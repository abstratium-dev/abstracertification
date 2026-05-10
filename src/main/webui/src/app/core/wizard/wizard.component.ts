import { Component, Input, Output, EventEmitter, OnChanges, SimpleChanges, inject, computed } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MarkdownComponent, type MermaidAPI } from 'ngx-markdown';
import { ThemeService } from '../theme.service';
import { ChatWindowComponent, ChatMessage } from '../chat/chat-window.component';
import { ChatService, ChatRequest } from '../chat/chat.service';
import {
  WizardDefinition, WizardStep, WizardChoicePoint, WizardEntry,
  WizardPageState, WizardQuestion, WizardAnswerResults
} from './wizard.model';

/**
 * Internal representation of a resolved entry in the wizard flow.
 * Either a content step or a choice point, determined by {@link type}.
 */
export interface ResolvedWizardStep {
  type: 'step' | 'choice';
  step?: WizardStep;
  choice?: WizardChoicePoint;
}

/**
 * Generic, reusable wizard UI component.
 * Accepts a {@link WizardDefinition} via @Input() and manages all UI state:
 * step navigation, progress tracking, choice selection, question answering,
 * and font size preferences. Contains no HTTP calls or domain-specific logic.
 */
@Component({
  selector: 'wizard',
  imports: [CommonModule, MarkdownComponent, ChatWindowComponent],
  templateUrl: './wizard.component.html',
  styleUrl: './wizard.component.scss',
})
export class WizardComponent implements OnChanges {
  @Input() definition: WizardDefinition | null = null;

  /** Initial step index to start on (0-based). Used when restoring from URL. */
  @Input() initialStepIndex = 0;

  /** Highest entry index the user has previously reached. Used to render past entries as completed. */
  @Input() maxReachedEntryIndex = 0;

  /** Emits when the user clicks "Submit Answers" — payload is questionId -> selected option ID. */
  @Output() submitAnswers = new EventEmitter<Map<string, string>>();

  /** Emits when the user clicks the "Overview" button to view certification structure. */
  @Output() viewOverview = new EventEmitter<void>();

  /** Emits when the user navigates to a different step (payload is 0-based step index). */
  @Output() stepChange = new EventEmitter<number>();

  /** Emits when the user submits feedback — payload is { feedbackType, targetId, feedbackText }. */
  @Output() submitFeedback = new EventEmitter<{ feedbackType: 'INSTRUCTION' | 'PAGE'; targetId: string; feedbackText: string }>();

  /** Initial choice selections to restore after page refresh: choiceLabel -> Set of variant indices. */
  @Input() initialChoiceSelections: Map<string, Set<number>> = new Map();

  /** Emits when choice selections change (payload is choiceLabel -> Set of variant indices). */
  @Output() choiceSelectionsChange = new EventEmitter<Map<string, Set<number>>>();

  resolvedSteps: ResolvedWizardStep[] = [];
  currentStepIndex = 0;
  pageStates: Map<string, WizardPageState> = new Map();
  /** Tracks selected option ID per question. */
  selectedAnswers: Map<string, string | null> = new Map();
  answeredQuestions: Set<string> = new Set();

  /** Feedback form state per instruction: instructionId -> { isOpen, text, submitting, submitted } */
  instructionFeedback: Map<string, { isOpen: boolean; text: string; submitting: boolean; submitted: boolean; error: string | null }> = new Map();
  /** Page-level feedback form state: stepId -> { isOpen, text, submitting, submitted } */
  pageFeedback: Map<string, { isOpen: boolean; text: string; submitting: boolean; submitted: boolean; error: string | null }> = new Map();
  pageSubmitted = false;
  submitting = false;

  /** Backend answer check results per step: stepId -> (questionId -> correct). */
  answerResultsByStep: Map<string, WizardAnswerResults> = new Map();

  choiceSelections: Map<string, Set<number>> = new Map();
  shuffledQuestions: Map<string, WizardQuestion[]> = new Map();
  infoExpandedState: Map<string, boolean> = new Map();

  // Chat functionality
  @Input() certificationId: string = '';
  chatMessages: ChatMessage[] = [];
  isChatLoading: boolean = false;
  private chatService = inject(ChatService);
  private chatSessionId: string = '';

  readonly FONT_SIZE_KEY = 'wizard-font-size';
  fontSize: 'small' | 'medium' | 'large' = this.loadFontSize();

  private themeService = inject(ThemeService);

  readonly mermaidOptions = computed((): MermaidAPI.MermaidConfig =>
    ({ theme: this.themeService.theme$() === 'dark' ? 'dark' : 'default' })
  );

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['definition'] && this.definition) {
      this.buildSteps();
    }
  }

  private buildSteps(): void {
    if (!this.definition) return;
    this.resolvedSteps = [];
    this.choiceSelections.clear();
    this.pageStates.clear();
    this.selectedAnswers.clear();
    this.answeredQuestions.clear();
    this.pageSubmitted = false;
    this.submitting = false;
    this.answerResultsByStep.clear();

    let stepIndex = 0;
    for (const entry of this.definition.entries) {
      if (typeof entry === 'string') {
        const step = this.definition.steps[stepIndex++];
        this.resolvedSteps.push({ type: 'step', step });
        this.initStepState(step);
      } else {
        const choice = entry as WizardChoicePoint;
        this.resolvedSteps.push({ type: 'choice', choice });
        // Restore choice selections from localStorage if available
        const restoredSelections = this.initialChoiceSelections.get(choice.label);
        this.choiceSelections.set(choice.label, restoredSelections ? new Set(restoredSelections) : new Set());
      }
    }

    // Restore variant steps from choice selections after all base steps are built
    this.restoreVariantSteps();

    // Calculate the correct resolved step index from initialStepIndex (entry index)
    // This must be done AFTER variants are restored so the mapping is correct
    const targetEntryIndex = Math.max(0, Math.min(this.initialStepIndex, this.definition.entries.length - 1));
    const targetResolvedIndex = this.getResolvedIndexForEntry(targetEntryIndex);
    // Ensure the resolved index is within bounds (it should be, but be safe)
    this.currentStepIndex = Math.min(targetResolvedIndex, this.resolvedSteps.length - 1);
    console.log('[WIZARD] buildSteps, initialStepIndex (entry):', this.initialStepIndex, '-> resolvedStepIndex:', this.currentStepIndex);
  }

  /**
   * Restores variant steps based on the restored choice selections.
   * This must be called after buildSteps has built the base steps.
   */
  private restoreVariantSteps(): void {
    if (!this.definition) return;

    for (const entry of this.definition.entries) {
      if (typeof entry !== 'string') {
        const choice = entry as WizardChoicePoint;
        const selected = this.choiceSelections.get(choice.label);
        if (selected && selected.size > 0) {
          // Insert variant steps in order
          const sortedVariants = Array.from(selected).sort((a, b) => a - b);
          for (const variantIndex of sortedVariants) {
            this.insertVariantStep(choice.label, variantIndex);
          }
        }
      }
    }
  }

  private initStepState(step: WizardStep): void {
    this.pageStates.set(step.id, { answers: new Map(), completed: false });
    for (const q of step.questions) {
      this.selectedAnswers.set(q.id, null);
    }
    this.shuffledQuestions.set(step.id, this.shuffleWithOptions([...step.questions]));
    this.infoExpandedState.set(step.id, step.infoExpanded ?? true);
    // Initialize feedback state for each instruction
    for (const instr of step.instructions) {
      if (!this.instructionFeedback.has(instr.id)) {
        this.instructionFeedback.set(instr.id, { isOpen: false, text: '', submitting: false, submitted: false, error: null });
      }
    }
    // Initialize page-level feedback state
    if (!this.pageFeedback.has(step.id)) {
      this.pageFeedback.set(step.id, { isOpen: false, text: '', submitting: false, submitted: false, error: null });
    }
  }

  /** Shuffles questions AND randomizes option order within each question. */
  private shuffleWithOptions(questions: WizardQuestion[]): WizardQuestion[] {
    return this.shuffleArray(questions).map(q => ({
      ...q,
      options: this.shuffleArray([...q.options])
    }));
  }

  private shuffleArray<T>(array: T[]): T[] {
    const result = [...array];
    for (let i = result.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [result[i], result[j]] = [result[j], result[i]];
    }
    return result;
  }

  isChoiceStep(resolved: ResolvedWizardStep): boolean {
    return resolved.type === 'choice';
  }

  get currentResolvedStep(): ResolvedWizardStep | null {
    return this.resolvedSteps[this.currentStepIndex] ?? null;
  }

  get currentStep(): WizardStep | null {
    const resolved = this.currentResolvedStep;
    if (!resolved || resolved.type !== 'step') return null;
    return resolved.step ?? null;
  }

  get currentQuestions(): WizardQuestion[] {
    const step = this.currentStep;
    if (!step) return [];
    return this.shuffledQuestions.get(step.id) ?? step.questions;
  }

  get currentChoice(): WizardChoicePoint | null {
    const resolved = this.currentResolvedStep;
    if (!resolved || resolved.type !== 'choice') return null;
    return resolved.choice ?? null;
  }

  get totalSteps(): number {
    return this.resolvedSteps.length;
  }

  /** Returns the number of original entries (for progress display). Does not change when choices add variant steps. */
  get totalEntries(): number {
    return this.definition?.entries.length ?? 0;
  }

  /** Returns the entry index for progress display (1-based). */
  get currentEntryNumber(): number {
    return this.getCurrentEntryIndex() + 1;
  }

  get progressPercent(): number {
    const total = this.totalEntries;
    if (total === 0) return 0;
    // Use entry index for progress, not resolved step index
    return Math.round((this.currentEntryNumber / total) * 100);
  }

  get currentStepCompleted(): boolean {
    const resolved = this.currentResolvedStep;
    if (!resolved) return false;
    if (resolved.type === 'choice') {
      return this.isChoiceSelectionMade(resolved.choice!);
    }
    const step = resolved.step!;
    return step.questions.every(q => this.answeredQuestions.has(q.id) && this.isCorrect(q));
  }

  get canGoNext(): boolean {
    return this.currentStepCompleted && this.currentStepIndex < this.totalSteps - 1;
  }

  isChoiceSelectionMade(choice: WizardChoicePoint): boolean {
    const selected = this.choiceSelections.get(choice.label);
    if (!selected) return false;
    return selected.size >= choice.minRequired;
  }

  get canGoPrev(): boolean {
    return this.currentStepIndex > 0;
  }

  // --- Choice handling ---

  isChoiceCompleted(choice: WizardChoicePoint): boolean {
    const selected = this.choiceSelections.get(choice.label);
    if (!selected) return false;
    if (selected.size < choice.minRequired) return false;
    for (const variantIdx of selected) {
      const variantSteps = this.definition!.choiceSteps.get(choice.label);
      if (!variantSteps) return false;
      const step = variantSteps[variantIdx];
      if (!step.questions.every(q => this.answeredQuestions.has(q.id) && this.isCorrect(q))) {
        return false;
      }
    }
    return true;
  }

  toggleVariantSelection(choiceLabel: string, variantIndex: number): void {
    const selected = this.choiceSelections.get(choiceLabel);
    if (!selected) return;
    const choice = this.getChoiceByLabel(choiceLabel);
    if (!choice) return;

    if (selected.has(variantIndex)) {
      selected.delete(variantIndex);
      this.removeVariantSteps(choiceLabel, variantIndex);
    } else {
      if (choice.maxRequired === 1) {
        for (const prevIdx of selected) {
          this.removeVariantSteps(choiceLabel, prevIdx);
        }
        selected.clear();
      } else if (selected.size >= choice.maxRequired) {
        return;
      }
      selected.add(variantIndex);
      this.insertVariantStep(choiceLabel, variantIndex);
    }
    // Emit updated selections for persistence
    this.choiceSelectionsChange.emit(new Map(this.choiceSelections));
  }

  isVariantSelected(choiceLabel: string, variantIndex: number): boolean {
    return this.choiceSelections.get(choiceLabel)?.has(variantIndex) ?? false;
  }

  getSelectedVariantCount(choiceLabel: string): number {
    return this.choiceSelections.get(choiceLabel)?.size ?? 0;
  }

  private getChoiceByLabel(label: string): WizardChoicePoint | null {
    if (!this.definition) return null;
    for (const entry of this.definition.entries) {
      if (typeof entry !== 'string' && (entry as WizardChoicePoint).label === label) {
        return entry as WizardChoicePoint;
      }
    }
    return null;
  }

  private getChoiceStepIndex(choiceLabel: string): number {
    return this.resolvedSteps.findIndex(s => s.type === 'choice' && s.choice?.label === choiceLabel);
  }

  private insertVariantStep(choiceLabel: string, variantIndex: number): void {
    const choiceStepIdx = this.getChoiceStepIndex(choiceLabel);
    if (choiceStepIdx < 0) return;
    const variantSteps = this.definition!.choiceSteps.get(choiceLabel);
    if (!variantSteps) return;
    const step = variantSteps[variantIndex];

    let insertAt = choiceStepIdx + 1;
    while (insertAt < this.resolvedSteps.length && this.resolvedSteps[insertAt].type === 'step' &&
           this.isVariantStep(this.resolvedSteps[insertAt], choiceLabel)) {
      insertAt++;
    }
    this.resolvedSteps.splice(insertAt, 0, { type: 'step', step });
    this.initStepState(step);
  }

  private removeVariantSteps(choiceLabel: string, variantIndex: number): void {
    const variantSteps = this.definition!.choiceSteps.get(choiceLabel);
    if (!variantSteps) return;
    const step = variantSteps[variantIndex];

    const idx = this.resolvedSteps.findIndex(s => s.type === 'step' && s.step?.id === step.id);
    if (idx >= 0) {
      this.resolvedSteps.splice(idx, 1);
      for (const q of step.questions) {
        this.selectedAnswers.delete(q.id);
        this.answeredQuestions.delete(q.id);
      }
      this.pageStates.delete(step.id);
      if (this.currentStepIndex >= this.resolvedSteps.length) {
        this.currentStepIndex = this.resolvedSteps.length - 1;
      }
    }
  }

  private isVariantStep(resolved: ResolvedWizardStep, choiceLabel: string): boolean {
    if (resolved.type !== 'step' || !resolved.step) return false;
    const variantSteps = this.definition!.choiceSteps.get(choiceLabel);
    if (!variantSteps) return false;
    return variantSteps.some(s => s.id === resolved.step!.id);
  }

  // --- Question handling ---

  selectAnswer(question: WizardQuestion, optionId: string): void {
    if (this.pageSubmitted) return;
    this.selectedAnswers.set(question.id, optionId);
  }

  get allQuestionsSelected(): boolean {
    const questions = this.currentQuestions;
    if (questions.length === 0) return true;
    return questions.every(q => this.selectedAnswers.get(q.id) != null);
  }

  submitPage(): void {
    if (this.pageSubmitted || this.submitting) return;
    this.submitting = true;

    // Build the answers map (questionId -> selected option ID) for current step
    const answers = new Map<string, string>();
    for (const q of this.currentQuestions) {
      const selected = this.selectedAnswers.get(q.id);
      if (selected) {
        answers.set(q.id, selected);
      }
    }

    // Emit to parent for backend validation
    this.submitAnswers.emit(answers);
  }

  /**
   * Called by the parent component after receiving backend results.
   * Applies the results and marks the page as submitted.
   */
  applyAnswerResults(results: WizardAnswerResults): void {
    const step = this.currentStep;
    if (step) {
      this.answerResultsByStep.set(step.id, results);
    }
    this.pageSubmitted = true;
    this.submitting = false;
    for (const q of this.currentQuestions) {
      this.answeredQuestions.add(q.id);
    }
  }

  getSelectedAnswer(questionId: string): string | null {
    return this.selectedAnswers.get(questionId) ?? null;
  }

  isAnswered(questionId: string): boolean {
    return this.answeredQuestions.has(questionId);
  }

  /** Returns true if the backend reported this question as correctly answered. */
  isCorrect(question: WizardQuestion): boolean {
    for (const [, results] of this.answerResultsByStep) {
      if (results.has(question.id)) {
        return results.get(question.id) === true;
      }
    }
    return false;
  }

  /** Returns true if the selected option for this question is the one that was marked wrong. */
  isSelectedOptionWrong(questionId: string, optionId: string): boolean {
    for (const [, results] of this.answerResultsByStep) {
      if (results.has(questionId)) {
        const isWrong = results.get(questionId) === false;
        return isWrong && this.selectedAnswers.get(questionId) === optionId;
      }
    }
    return false;
  }

  // --- Navigation ---

  goNext(): void {
    console.log('[WIZARD] goNext called, currentStep:', this.currentStepIndex, 'canGoNext:', this.canGoNext);
    if (this.canGoNext) {
      this.currentStepIndex++;
      this.pageSubmitted = false;
      // Emit the entry index, not the resolved step index
      this.stepChange.emit(this.getCurrentEntryIndex());
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }
  }

  goPrev(): void {
    console.log('[WIZARD] goPrev called, currentStep:', this.currentStepIndex, 'canGoPrev:', this.canGoPrev);
    if (this.canGoPrev) {
      this.currentStepIndex--;
      const resolved = this.currentResolvedStep;
      if (resolved?.type === 'step') {
        this.pageSubmitted = this.isResolvedStepCompleted(this.currentStepIndex) || this.currentPageHasWrongAnswer;
      } else {
        this.pageSubmitted = false;
      }
      // Emit the entry index, not the resolved step index
      this.stepChange.emit(this.getCurrentEntryIndex());
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }
  }

  goToStep(index: number): void {
    console.log('[WIZARD] goToStep called:', index, 'currentStep:', this.currentStepIndex);
    if (index >= 0 && index < this.totalSteps && index !== this.currentStepIndex) {
      this.currentStepIndex = index;
      const resolved = this.resolvedSteps[index];
      if (resolved.type === 'step') {
        this.pageSubmitted = this.isResolvedStepCompleted(index);
      } else {
        this.pageSubmitted = false;
      }
      // Emit the entry index, not the resolved step index
      this.stepChange.emit(this.getCurrentEntryIndex());
    }
  }

  /**
   * Maps current resolved step index back to the entry index in the original definition.
   * This handles the case where variant steps have been inserted after choices.
   */
  private getCurrentEntryIndex(): number {
    if (!this.definition) return 0;
    
    let entryIndex = 0;
    let resolvedIndex = 0;
    
    while (entryIndex < this.definition.entries.length && resolvedIndex <= this.currentStepIndex) {
      const entry = this.definition.entries[entryIndex];
      
      if (typeof entry === 'string') {
        // Direct step - consumes one resolved step
        if (resolvedIndex === this.currentStepIndex) {
          return entryIndex;
        }
        resolvedIndex++;
      } else {
        // Choice point
        const choice = entry as WizardChoicePoint;
        
        // Check if we're at the choice step itself
        if (resolvedIndex === this.currentStepIndex && this.resolvedSteps[resolvedIndex]?.type === 'choice') {
          return entryIndex;
        }
        resolvedIndex++;
        
        // Check if we're on a variant step inserted after this choice
        const variantSteps = this.definition.choiceSteps.get(choice.label) || [];
        const selectedVariants = this.choiceSelections.get(choice.label) || new Set();
        
        for (let i = 0; i < variantSteps.length; i++) {
          if (selectedVariants.has(i) && resolvedIndex <= this.currentStepIndex) {
            if (resolvedIndex === this.currentStepIndex) {
              // We're on a variant step - return the choice's entry index
              return entryIndex;
            }
            resolvedIndex++;
          }
        }
      }
      entryIndex++;
    }
    
    return Math.min(entryIndex, this.definition.entries.length - 1);
  }

  /**
   * Maps an entry index to the corresponding resolved step index.
   * Choice entries map to their choice resolved step; variant steps are skipped.
   */
  getResolvedIndexForEntry(entryIndex: number): number {
    if (!this.definition) return entryIndex;
    let resolvedIndex = 0;
    for (let i = 0; i < entryIndex; i++) {
      const entry = this.definition.entries[i];
      resolvedIndex++;
      if (typeof entry !== 'string') {
        const choice = entry as WizardChoicePoint;
        const selectedVariants = this.choiceSelections.get(choice.label) || new Set();
        resolvedIndex += selectedVariants.size;
      }
    }
    return resolvedIndex;
  }

  isEntryAccessible(entryIndex: number): boolean {
    // Any entry at or before the furthest reached is always accessible
    if (entryIndex <= this.maxReachedEntryIndex) return true;
    const resolvedIndex = this.getResolvedIndexForEntry(entryIndex);
    return this.isStepAccessible(resolvedIndex);
  }

  isEntryCompleted(entryIndex: number): boolean {
    if (!this.definition) return false;
    // If the user has navigated past this entry in a prior session, show it as green
    if (entryIndex < this.maxReachedEntryIndex) return true;
    const entry = this.definition.entries[entryIndex];
    const resolvedIndex = this.getResolvedIndexForEntry(entryIndex);
    const resolved = this.resolvedSteps[resolvedIndex];
    if (!resolved) return false;
    if (typeof entry !== 'string') {
      return this.isChoiceCompleted(resolved.choice!);
    }
    return this.isResolvedStepCompleted(resolvedIndex);
  }

  isEntryActive(entryIndex: number): boolean {
    const resolvedIndex = this.getResolvedIndexForEntry(entryIndex);
    if (!this.definition) return false;
    const entry = this.definition.entries[entryIndex];
    if (typeof entry !== 'string') {
      // Active if we are on the choice step or any of its variant steps
      const choice = entry as WizardChoicePoint;
      const selectedVariants = this.choiceSelections.get(choice.label) || new Set();
      const lastVariantResolved = resolvedIndex + selectedVariants.size;
      return this.currentStepIndex >= resolvedIndex && this.currentStepIndex <= lastVariantResolved;
    }
    return this.currentStepIndex === resolvedIndex;
  }

  goToEntry(entryIndex: number): void {
    const resolvedIndex = this.getResolvedIndexForEntry(entryIndex);
    this.goToStep(resolvedIndex);
  }

  getEntryLabel(entryIndex: number): string {
    if (!this.definition) return '';
    const entry = this.definition.entries[entryIndex];
    if (typeof entry !== 'string') return (entry as WizardChoicePoint).label;
    const resolvedIndex = this.getResolvedIndexForEntry(entryIndex);
    return this.getStepLabel(resolvedIndex);
  }

  isStepAccessible(index: number): boolean {
    if (index === 0) return true;
    for (let i = 0; i < index; i++) {
      if (!this.isResolvedStepCompleted(i)) return false;
    }
    return true;
  }

  isResolvedStepCompleted(index: number): boolean {
    const resolved = this.resolvedSteps[index];
    if (!resolved) return false;
    if (resolved.type === 'choice') {
      return this.isChoiceCompleted(resolved.choice!);
    }
    const step = resolved.step!;
    return step.questions.every(q => this.answeredQuestions.has(q.id) && this.isCorrect(q));
  }

  getStepLabel(index: number): string {
    const resolved = this.resolvedSteps[index];
    if (!resolved) return '';
    if (resolved.type === 'choice') return resolved.choice!.label;
    return resolved.step!.title;
  }

  get currentPageHasWrongAnswer(): boolean {
    if (!this.pageSubmitted) return false;
    return this.currentQuestions.some(q => !this.isCorrect(q));
  }

  resetCurrentPage(): void {
    const step = this.currentStep;
    if (!step) return;
    this.pageSubmitted = false;
    this.submitting = false;
    this.answerResultsByStep.delete(step.id);
    for (const q of step.questions) {
      this.selectedAnswers.set(q.id, null);
      this.answeredQuestions.delete(q.id);
    }
    this.pageStates.set(step.id, { answers: new Map(), completed: false });
    this.shuffledQuestions.set(step.id, this.shuffleWithOptions([...step.questions]));
  }

  // --- Font size control ---

  setFontSize(size: 'small' | 'medium' | 'large'): void {
    this.fontSize = size;
    localStorage.setItem(this.FONT_SIZE_KEY, size);
  }

  private loadFontSize(): 'small' | 'medium' | 'large' {
    const saved = localStorage.getItem(this.FONT_SIZE_KEY);
    if (saved === 'small' || saved === 'medium' || saved === 'large') {
      return saved;
    }
    return 'medium';
  }

  increaseFontSize(): void {
    if (this.fontSize === 'small') this.setFontSize('medium');
    else if (this.fontSize === 'medium') this.setFontSize('large');
  }

  decreaseFontSize(): void {
    if (this.fontSize === 'large') this.setFontSize('medium');
    else if (this.fontSize === 'medium') this.setFontSize('small');
  }

  // --- Info section handling ---

  isInfoExpanded(stepId: string): boolean {
    return this.infoExpandedState.get(stepId) ?? true;
  }

  toggleInfoExpanded(stepId: string): void {
    const current = this.infoExpandedState.get(stepId) ?? true;
    this.infoExpandedState.set(stepId, !current);
  }

  // --- Feedback handling ---

  toggleInstructionFeedback(instructionId: string): void {
    const state = this.instructionFeedback.get(instructionId);
    if (state) {
      state.isOpen = !state.isOpen;
      if (!state.isOpen) {
        state.text = '';
        state.error = null;
      }
    }
  }

  togglePageFeedback(stepId: string): void {
    const state = this.pageFeedback.get(stepId);
    if (state) {
      state.isOpen = !state.isOpen;
      if (!state.isOpen) {
        state.text = '';
        state.error = null;
      }
    }
  }

  updateInstructionFeedbackText(instructionId: string, text: string): void {
    const state = this.instructionFeedback.get(instructionId);
    if (state) {
      state.text = text;
      state.error = null;
    }
  }

  updatePageFeedbackText(stepId: string, text: string): void {
    const state = this.pageFeedback.get(stepId);
    if (state) {
      state.text = text;
      state.error = null;
    }
  }

  submitInstructionFeedback(instructionId: string): void {
    const state = this.instructionFeedback.get(instructionId);
    if (!state || !state.text.trim()) {
      return;
    }

    state.submitting = true;
    state.error = null;

    this.submitFeedback.emit({
      feedbackType: 'INSTRUCTION',
      targetId: instructionId,
      feedbackText: state.text.trim()
    });
  }

  submitPageFeedback(stepId: string): void {
    const state = this.pageFeedback.get(stepId);
    if (!state || !state.text.trim()) {
      return;
    }

    state.submitting = true;
    state.error = null;

    this.submitFeedback.emit({
      feedbackType: 'PAGE',
      targetId: stepId,
      feedbackText: state.text.trim()
    });
  }

  /**
   * Called by parent component after feedback is successfully submitted.
   * Marks the feedback form as submitted.
   */
  markFeedbackSubmitted(targetId: string, feedbackType: 'INSTRUCTION' | 'PAGE'): void {
    if (feedbackType === 'INSTRUCTION') {
      const state = this.instructionFeedback.get(targetId);
      if (state) {
        state.submitting = false;
        state.submitted = true;
        state.text = '';
      }
    } else {
      const state = this.pageFeedback.get(targetId);
      if (state) {
        state.submitting = false;
        state.submitted = true;
        state.text = '';
      }
    }
  }

  /**
   * Called by parent component if feedback submission failed.
   */
  markFeedbackError(targetId: string, feedbackType: 'INSTRUCTION' | 'PAGE', error: string): void {
    if (feedbackType === 'INSTRUCTION') {
      const state = this.instructionFeedback.get(targetId);
      if (state) {
        state.submitting = false;
        state.error = error;
      }
    } else {
      const state = this.pageFeedback.get(targetId);
      if (state) {
        state.submitting = false;
        state.error = error;
      }
    }
  }

  // Chat functionality methods
  onChatSendMessage(event: { message: string; history: ChatMessage[] }): void {
    if (!this.currentStep || !this.certificationId) {
      return;
    }

    // Initialize session ID if not set
    if (!this.chatSessionId) {
      this.chatSessionId = this.chatService.generateSessionId();
    }

    // Add user message to chat
    const userMessage: ChatMessage = {
      role: 'user',
      content: event.message,
      timestamp: new Date()
    };
    this.chatMessages = [...event.history, userMessage];
    this.isChatLoading = true;

    // Prepare chat request
    const chatRequest: ChatRequest = {
      message: event.message,
      certificationId: this.certificationId,
      pageId: this.currentStep.id,
      sessionId: this.chatSessionId,
      history: event.history
    };

    // Send message to chat service
    let assistantMessage: ChatMessage = {
      role: 'assistant',
      content: '',
      timestamp: new Date()
    };
    this.chatMessages = [...this.chatMessages, assistantMessage];
    
    this.chatService.sendMessage(chatRequest).subscribe({
      next: (chunk) => {
        // Accumulate streaming chunks
        assistantMessage.content += chunk;
        // Update the messages array to trigger UI updates
        this.chatMessages = [...this.chatMessages];
      },
      error: (error) => {
        console.error('Chat error:', error);
        // Replace partial message with error message
        assistantMessage.content = 'Sorry, I encountered an error. Please try again later.';
        this.chatMessages = [...this.chatMessages];
        this.isChatLoading = false;
      },
      complete: () => {
        // Streaming completed
        this.isChatLoading = false;
      }
    });
  }

  onChatClearChat(): void {
    this.chatMessages = [];
    // Generate new session ID for fresh conversation
    this.chatSessionId = this.chatService.generateSessionId();
  }
}
