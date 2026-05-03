import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import { CertificationService } from './certification.service';
import { CertificationModule, CertificationPage, PageState, Question } from './certification.model';

@Component({
  selector: 'wizard',
  imports: [CommonModule],
  templateUrl: './wizard.component.html',
  styleUrl: './wizard.component.scss',
})
export class WizardComponent implements OnInit, OnDestroy {
  module: CertificationModule | null = null;
  currentPageIndex = 0;
  pageStates: Map<string, PageState> = new Map();
  selectedAnswers: Map<string, number | null> = new Map();
  answeredQuestions: Set<string> = new Set();
  loading = true;
  error: string | null = null;

  private routeSub: Subscription | null = null;

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

  private loadModule(moduleId: string): void {
    this.loading = true;
    this.error = null;
    this.certificationService.loadModule(moduleId).subscribe({
      next: (mod: CertificationModule) => {
        this.module = mod;
        this.loading = false;
        this.initPageStates();
      },
      error: (err: Error) => {
        this.error = `Failed to load certification module: ${err.message}`;
        this.loading = false;
      }
    });
  }

  private initPageStates(): void {
    if (!this.module) return;
    this.pageStates.clear();
    this.selectedAnswers.clear();
    this.answeredQuestions.clear();
    for (const page of this.module.pages) {
      this.pageStates.set(page.id, { answers: new Map(), completed: false });
      for (const q of page.questions) {
        this.selectedAnswers.set(q.id, null);
      }
    }
  }

  get currentPage(): CertificationPage | null {
    if (!this.module) return null;
    return this.module.pages[this.currentPageIndex] ?? null;
  }

  get totalPages(): number {
    return this.module?.pages.length ?? 0;
  }

  get progressPercent(): number {
    if (this.totalPages === 0) return 0;
    return Math.round(((this.currentPageIndex + 1) / this.totalPages) * 100);
  }

  get currentPageCompleted(): boolean {
    const page = this.currentPage;
    if (!page) return false;
    return page.questions.every(q => this.answeredQuestions.has(q.id) && this.isCorrect(q));
  }

  get canGoNext(): boolean {
    return this.currentPageCompleted && this.currentPageIndex < this.totalPages - 1;
  }

  get canGoPrev(): boolean {
    return this.currentPageIndex > 0;
  }

  selectAnswer(question: Question, optionIndex: number): void {
    if (this.answeredQuestions.has(question.id)) return;
    this.selectedAnswers.set(question.id, optionIndex);
  }

  submitAnswer(question: Question): void {
    if (this.answeredQuestions.has(question.id)) return;
    if (this.selectedAnswers.get(question.id) == null) return;
    this.answeredQuestions.add(question.id);
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

  goNext(): void {
    if (this.canGoNext) {
      this.currentPageIndex++;
    }
  }

  goPrev(): void {
    if (this.canGoPrev) {
      this.currentPageIndex--;
    }
  }

  goToPage(index: number): void {
    if (index >= 0 && index < this.totalPages) {
      this.currentPageIndex = index;
    }
  }

  isPageAccessible(index: number): boolean {
    if (index === 0) return true;
    // All previous pages must be completed
    for (let i = 0; i < index; i++) {
      const page = this.module!.pages[i];
      if (!page.questions.every(q => this.answeredQuestions.has(q.id) && this.isCorrect(q))) {
        return false;
      }
    }
    return true;
  }

  isPageCompleted(index: number): boolean {
    if (!this.module) return false;
    const page = this.module.pages[index];
    return page.questions.every(q => this.answeredQuestions.has(q.id) && this.isCorrect(q));
  }
}
