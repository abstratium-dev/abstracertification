import { Component, OnInit, OnDestroy, AfterViewChecked, inject, afterNextRender, Injector } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import mermaid from 'mermaid';
import { CertificationService } from './certification.service';
import { ThemeService } from '../theme.service';
import {
  CertificationModule, CertificationPage, PageState, Question,
  PageChoice, PageEntry
} from './certification.model';

export interface WizardStep {
  type: 'page' | 'choice';
  page?: CertificationPage;
  choice?: PageChoice;
}

@Component({
  selector: 'wizard',
  imports: [CommonModule],
  templateUrl: './wizard.component.html',
  styleUrl: './wizard.component.scss',
})
export class WizardComponent implements OnInit, OnDestroy, AfterViewChecked {
  private mermaidInitialized = false;
  private mermaidRendering = false;
  private lastRenderedStepIndex = -1;
  private pendingRender = false;
  module: CertificationModule | null = null;
  steps: WizardStep[] = [];
  currentStepIndex = 0;
  pageStates: Map<string, PageState> = new Map();
  selectedAnswers: Map<string, number | null> = new Map();
  answeredQuestions: Set<string> = new Set();
  pageSubmitted = false;
  loading = true;
  error: string | null = null;

  choiceSelections: Map<string, Set<number>> = new Map();
  shuffledQuestions: Map<string, Question[]> = new Map();

  fontSize: 'small' | 'medium' | 'large' = 'medium';

  private routeSub: Subscription | null = null;

  private themeService = inject(ThemeService);
  private injector = inject(Injector);

  constructor(
    private certificationService: CertificationService,
    private route: ActivatedRoute,
  ) {}

  ngOnInit(): void {
    this.routeSub = this.route.paramMap.subscribe((params: ParamMap) => {
      const moduleId = params.get('moduleId') ?? 'linux-home-server';
      this.loadModule(moduleId);
    });
  }

  ngOnDestroy(): void {
    this.routeSub?.unsubscribe();
  }

  ngAfterViewChecked(): void {
    // Only render if we're on a new step and not already rendering
    if (this.currentStepIndex !== this.lastRenderedStepIndex && !this.mermaidRendering && !this.pendingRender) {
      this.pendingRender = true;
      // Use afterNextRender to ensure DOM is fully updated
      afterNextRender(() => {
        this.renderMermaidDiagrams();
        this.pendingRender = false;
      }, { injector: this.injector });
    }
  }

  private async renderMermaidDiagrams(): Promise<void> {
    if (this.mermaidRendering) return;

    // Find unrendered mermaid elements
    const elements = document.querySelectorAll('.mermaid:not([data-processed="true"])');
    console.debug('[Mermaid] Found', elements.length, 'unrendered elements');
    if (elements.length === 0) {
      this.lastRenderedStepIndex = this.currentStepIndex;
      return;
    }

    this.mermaidRendering = true;

    if (!this.mermaidInitialized) {
      const currentTheme = this.themeService.theme$();
      const mermaidTheme = currentTheme === 'dark' ? 'dark' : 'default';
      mermaid.initialize({ startOnLoad: false, theme: mermaidTheme, securityLevel: 'loose' });
      this.mermaidInitialized = true;
      console.debug('[Mermaid] Initialized with theme:', mermaidTheme);
    }

    // Small delay for DOM to stabilize
    await new Promise(resolve => setTimeout(resolve, 50));

    try {
      for (let i = 0; i < elements.length; i++) {
        const element = elements[i] as HTMLElement;
        const graphDefinition = element.getAttribute('data-diagram') || '';
        console.debug('[Mermaid] Rendering diagram', i, 'length:', graphDefinition.length);
        if (!graphDefinition.trim()) {
          console.warn('[Mermaid] Empty diagram definition');
          continue;
        }

        const id = `mermaid-${this.currentStepIndex}-${i}`;
        console.debug('[Mermaid] Calling render with id:', id);
        const { svg } = await mermaid.render(id, graphDefinition);
        console.debug('[Mermaid] Rendered SVG length:', svg.length);
        element.innerHTML = svg;
        element.setAttribute('data-processed', 'true');
        console.debug('[Mermaid] SVG inserted into DOM');
      }
      this.lastRenderedStepIndex = this.currentStepIndex;
    } catch (e) {
      console.error('[Mermaid] Render error:', e);
      // Show error message in the diagram container
      for (let i = 0; i < elements.length; i++) {
        const element = elements[i] as HTMLElement;
        if (!element.hasAttribute('data-processed')) {
          element.innerHTML = '<div style="color: var(--color-error); padding: 1rem;">Failed to render diagram</div>';
          element.setAttribute('data-processed', 'true');
        }
      }
    } finally {
      this.mermaidRendering = false;
    }
  }

  private loadModule(moduleId: string): void {
    this.loading = true;
    this.error = null;
    this.certificationService.loadModule(moduleId).subscribe({
      next: (mod: CertificationModule) => {
        this.module = mod;
        this.loading = false;
        this.buildSteps();
      },
      error: (err: Error) => {
        this.error = `Failed to load certification module: ${err.message}`;
        this.loading = false;
      }
    });
  }

  private buildSteps(): void {
    if (!this.module) return;
    this.steps = [];
    this.choiceSelections.clear();
    this.pageStates.clear();
    this.selectedAnswers.clear();
    this.answeredQuestions.clear();
    this.currentStepIndex = 0;
    this.pageSubmitted = false;

    let pageIndex = 0;
    for (const entry of this.module.pageEntries) {
      if (typeof entry === 'string') {
        const page = this.module.pages[pageIndex++];
        this.steps.push({ type: 'page', page });
        this.initPageState(page);
      } else {
        const choice = entry as PageChoice;
        this.steps.push({ type: 'choice', choice });
        this.choiceSelections.set(choice.label, new Set());
      }
    }
  }

  private initPageState(page: CertificationPage): void {
    this.pageStates.set(page.id, { answers: new Map(), completed: false });
    for (const q of page.questions) {
      this.selectedAnswers.set(q.id, null);
    }
    this.shuffledQuestions.set(page.id, this.shuffleArray([...page.questions]));
  }

  private shuffleArray<T>(array: T[]): T[] {
    const result = [...array];
    for (let i = result.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [result[i], result[j]] = [result[j], result[i]];
    }
    return result;
  }

  isChoiceStep(step: WizardStep): boolean {
    return step.type === 'choice';
  }

  get currentStep(): WizardStep | null {
    return this.steps[this.currentStepIndex] ?? null;
  }

  get currentPage(): CertificationPage | null {
    const step = this.currentStep;
    if (!step || step.type !== 'page') return null;
    return step.page ?? null;
  }

  get currentQuestions(): Question[] {
    const page = this.currentPage;
    if (!page) return [];
    return this.shuffledQuestions.get(page.id) ?? page.questions;
  }

  get currentChoice(): PageChoice | null {
    const step = this.currentStep;
    if (!step || step.type !== 'choice') return null;
    return step.choice ?? null;
  }

  get totalSteps(): number {
    return this.steps.length;
  }

  get progressPercent(): number {
    if (this.totalSteps === 0) return 0;
    return Math.round(((this.currentStepIndex + 1) / this.totalSteps) * 100);
  }

  get currentStepCompleted(): boolean {
    const step = this.currentStep;
    if (!step) return false;
    if (step.type === 'choice') {
      return this.isChoiceSelectionMade(step.choice!);
    }
    const page = step.page!;
    return page.questions.every(q => this.answeredQuestions.has(q.id) && this.isCorrect(q));
  }

  get canGoNext(): boolean {
    return this.currentStepCompleted && this.currentStepIndex < this.totalSteps - 1;
  }

  isChoiceSelectionMade(choice: PageChoice): boolean {
    const selected = this.choiceSelections.get(choice.label);
    if (!selected) return false;
    return selected.size >= choice.minRequired;
  }

  get canGoPrev(): boolean {
    return this.currentStepIndex > 0;
  }

  // --- Choice handling ---

  isChoiceCompleted(choice: PageChoice): boolean {
    const selected = this.choiceSelections.get(choice.label);
    if (!selected) return false;
    if (selected.size < choice.minRequired) return false;
    // All selected variant pages must be completed
    for (const variantIdx of selected) {
      const variantPages = this.module!.choicePages.get(choice.label);
      if (!variantPages) return false;
      const page = variantPages[variantIdx];
      if (!page.questions.every(q => this.answeredQuestions.has(q.id) && this.isCorrect(q))) {
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
        // Single select — clear previous and remove its steps
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

  private getChoiceByLabel(label: string): PageChoice | null {
    if (!this.module) return null;
    for (const entry of this.module.pageEntries) {
      if (typeof entry !== 'string' && (entry as PageChoice).label === label) {
        return entry as PageChoice;
      }
    }
    return null;
  }

  private getChoiceStepIndex(choiceLabel: string): number {
    return this.steps.findIndex(s => s.type === 'choice' && s.choice?.label === choiceLabel);
  }

  private insertVariantStep(choiceLabel: string, variantIndex: number): void {
    const choiceStepIdx = this.getChoiceStepIndex(choiceLabel);
    if (choiceStepIdx < 0) return;
    const variantPages = this.module!.choicePages.get(choiceLabel);
    if (!variantPages) return;
    const page = variantPages[variantIndex];

    // Insert right after the choice step (or after other already-inserted variants)
    let insertAt = choiceStepIdx + 1;
    while (insertAt < this.steps.length && this.steps[insertAt].type === 'page' &&
           this.isVariantPage(this.steps[insertAt], choiceLabel)) {
      insertAt++;
    }
    this.steps.splice(insertAt, 0, { type: 'page', page });
    this.initPageState(page);
  }

  private removeVariantSteps(choiceLabel: string, variantIndex: number): void {
    const variantPages = this.module!.choicePages.get(choiceLabel);
    if (!variantPages) return;
    const page = variantPages[variantIndex];

    const idx = this.steps.findIndex(s => s.type === 'page' && s.page?.id === page.id);
    if (idx >= 0) {
      this.steps.splice(idx, 1);
      // Clean up state for removed page
      for (const q of page.questions) {
        this.selectedAnswers.delete(q.id);
        this.answeredQuestions.delete(q.id);
      }
      this.pageStates.delete(page.id);
      // Adjust current index if needed
      if (this.currentStepIndex >= this.steps.length) {
        this.currentStepIndex = this.steps.length - 1;
      }
    }
  }

  private isVariantPage(step: WizardStep, choiceLabel: string): boolean {
    if (step.type !== 'page' || !step.page) return false;
    const variantPages = this.module!.choicePages.get(choiceLabel);
    if (!variantPages) return false;
    return variantPages.some(p => p.id === step.page!.id);
  }

  // --- Question handling ---

  selectAnswer(question: Question, optionIndex: number): void {
    if (this.pageSubmitted) return;
    this.selectedAnswers.set(question.id, optionIndex);
  }

  get allQuestionsSelected(): boolean {
    const questions = this.currentQuestions;
    if (questions.length === 0) return true;
    return questions.every(q => this.selectedAnswers.get(q.id) != null);
  }

  submitPage(): void {
    if (this.pageSubmitted) return;
    this.pageSubmitted = true;
    for (const q of this.currentQuestions) {
      this.answeredQuestions.add(q.id);
    }
  }

  getSelectedAnswer(questionId: string): number | null {
    return this.selectedAnswers.get(questionId) ?? null;
  }

  isAnswered(questionId: string): boolean {
    return this.answeredQuestions.has(questionId);
  }

  isCorrect(question: Question): boolean {
    return this.selectedAnswers.get(question.id) === question.correctIndex;
  }

  isOptionCorrect(question: Question, optionIndex: number): boolean {
    return optionIndex === question.correctIndex;
  }

  // --- Navigation ---

  goNext(): void {
    if (this.canGoNext) {
      this.currentStepIndex++;
      this.pageSubmitted = false;
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }
  }

  goPrev(): void {
    if (this.canGoPrev) {
      this.currentStepIndex--;
      const step = this.currentStep;
      if (step?.type === 'page') {
        this.pageSubmitted = this.isStepCompleted(this.currentStepIndex) || this.currentPageHasWrongAnswer;
      } else {
        this.pageSubmitted = false;
      }
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }
  }

  goToStep(index: number): void {
    if (index >= 0 && index < this.totalSteps) {
      this.currentStepIndex = index;
      const step = this.steps[index];
      if (step.type === 'page') {
        this.pageSubmitted = this.isStepCompleted(index);
      } else {
        this.pageSubmitted = false;
      }
    }
  }

  isStepAccessible(index: number): boolean {
    if (index === 0) return true;
    for (let i = 0; i < index; i++) {
      if (!this.isStepCompleted(i)) return false;
    }
    return true;
  }

  isStepCompleted(index: number): boolean {
    const step = this.steps[index];
    if (!step) return false;
    if (step.type === 'choice') {
      return this.isChoiceCompleted(step.choice!);
    }
    const page = step.page!;
    return page.questions.every(q => this.answeredQuestions.has(q.id) && this.isCorrect(q));
  }

  getStepLabel(index: number): string {
    const step = this.steps[index];
    if (!step) return '';
    if (step.type === 'choice') return step.choice!.label;
    return step.page!.title;
  }

  get currentPageHasWrongAnswer(): boolean {
    if (!this.pageSubmitted) return false;
    return this.currentQuestions.some(q => !this.isCorrect(q));
  }

  resetCurrentPage(): void {
    const page = this.currentPage;
    if (!page) return;
    this.pageSubmitted = false;
    for (const q of page.questions) {
      this.selectedAnswers.set(q.id, null);
      this.answeredQuestions.delete(q.id);
    }
    this.pageStates.set(page.id, { answers: new Map(), completed: false });
    // Reshuffle questions for the next attempt
    this.shuffledQuestions.set(page.id, this.shuffleArray([...page.questions]));
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
}
