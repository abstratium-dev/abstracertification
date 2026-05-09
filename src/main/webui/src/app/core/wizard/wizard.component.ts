import { Component, Input, Output, EventEmitter, OnChanges, SimpleChanges, inject, computed } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MarkdownComponent, type MermaidAPI } from 'ngx-markdown';
import { ThemeService } from '../theme.service';
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
  imports: [CommonModule, MarkdownComponent],
  templateUrl: './wizard.component.html',
  styleUrl: './wizard.component.scss',
})
export class WizardComponent implements OnChanges {
  @Input() definition: WizardDefinition | null = null;

  /** Initial step index to start on (0-based). Used when restoring from URL. */
  @Input() initialStepIndex = 0;

  /** Emits when the user clicks "Submit Answers" — payload is questionId -> selected option ID. */
  @Output() submitAnswers = new EventEmitter<Map<string, string>>();

  /** Emits when the user clicks the "Overview" button to view certification structure. */
  @Output() viewOverview = new EventEmitter<void>();

  /** Emits when the user navigates to a different step (payload is 0-based step index). */
  @Output() stepChange = new EventEmitter<number>();

  resolvedSteps: ResolvedWizardStep[] = [];
  currentStepIndex = 0;
  pageStates: Map<string, WizardPageState> = new Map();
  /** Tracks selected option ID per question. */
  selectedAnswers: Map<string, string | null> = new Map();
  answeredQuestions: Set<string> = new Set();
  pageSubmitted = false;
  submitting = false;

  /** Backend answer check results per step: stepId -> (questionId -> correct). */
  answerResultsByStep: Map<string, WizardAnswerResults> = new Map();

  choiceSelections: Map<string, Set<number>> = new Map();
  shuffledQuestions: Map<string, WizardQuestion[]> = new Map();
  infoExpandedState: Map<string, boolean> = new Map();

  fontSize: 'small' | 'medium' | 'large' = 'medium';

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
    // Use initialStepIndex if valid, otherwise start at 0
    const targetStep = Math.max(0, Math.min(this.initialStepIndex, this.definition.entries.length - 1));
    console.log('[WIZARD] buildSteps, initialStepIndex:', this.initialStepIndex, 'setting currentStepIndex to:', targetStep);
    this.currentStepIndex = targetStep;
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
        this.choiceSelections.set(choice.label, new Set());
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
  }

  increaseFontSize(): void {
    if (this.fontSize === 'small') this.fontSize = 'medium';
    else if (this.fontSize === 'medium') this.fontSize = 'large';
  }

  decreaseFontSize(): void {
    if (this.fontSize === 'large') this.fontSize = 'medium';
    else if (this.fontSize === 'medium') this.fontSize = 'small';
  }

  // --- Info section handling ---

  isInfoExpanded(stepId: string): boolean {
    return this.infoExpandedState.get(stepId) ?? true;
  }

  toggleInfoExpanded(stepId: string): void {
    const current = this.infoExpandedState.get(stepId) ?? true;
    this.infoExpandedState.set(stepId, !current);
  }
}
