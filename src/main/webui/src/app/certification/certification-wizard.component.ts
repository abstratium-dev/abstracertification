import { Component, OnInit, OnDestroy, ViewChild, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, ParamMap, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { WizardComponent } from '../core/wizard/wizard.component';
import { CertificationModelService } from './certification.model';
import { CertificationController } from './certification.controller';

@Component({
  selector: 'certification-wizard',
  imports: [CommonModule, WizardComponent],
  templateUrl: './certification-wizard.component.html',
  styleUrl: './certification-wizard.component.scss',
})
export class CertificationWizardComponent implements OnInit, OnDestroy {
  private modelService = inject(CertificationModelService);
  private controller = inject(CertificationController);
  private route = inject(ActivatedRoute);
  private router = inject(Router);

  @ViewChild(WizardComponent) wizardComponent!: WizardComponent;

  definition = this.modelService.currentCertification$;
  loading = this.modelService.currentCertificationLoading$;
  error = this.modelService.currentCertificationError$;
  maxReachedEntryIndex = this.modelService.maxReachedEntryIndex$;
  choiceSelections = this.modelService.choiceSelections$;

  /** Current step index derived from URL page parameter (0-based). */
  initialStepIndex = 0;

  private certificationId = '';
  private routeSub: Subscription | null = null;
  private hasValidatedPage = false;
  private isNavigatingFromStepChange = false;

  /** Public getter for certification ID to make it accessible in template */
  get certificationIdPublic(): string {
    return this.certificationId;
  }

  ngOnInit(): void {
    this.routeSub = this.route.paramMap.subscribe((params: ParamMap) => {
      const newCertificationId = params.get('certificationId') ?? '';
      const pageParam = params.get('page');
      // Update initialStepIndex from URL (page numbers are 1-based, step indices are 0-based)
      this.initialStepIndex = pageParam ? parseInt(pageParam, 10) - 1 : 0;
      console.log('[DEBUG] route changed:', { newCertificationId, pageParam, currentId: this.certificationId, isNavigatingFromStepChange: this.isNavigatingFromStepChange, initialStepIndex: this.initialStepIndex });

      // Reset max reached step if certification changed
      if (newCertificationId !== this.certificationId) {
        console.log('[DEBUG] certification changed, resetting maxReached');
        this.certificationId = newCertificationId;
        this.modelService.resetMaxReachedEntryIndex();
        this.hasValidatedPage = false;
      }

      if (this.certificationId) {
        this.controller.loadCertification(this.certificationId);
        // Validate page once definition is loaded (only if not from our own stepChange)
        if (!this.isNavigatingFromStepChange) {
          setTimeout(() => this.validateAndNavigateToPage(pageParam), 0);
        }
      }
    });
  }

  ngOnDestroy(): void {
    this.routeSub?.unsubscribe();
  }

  /**
   * Validates the requested page number and redirects if:
   * 1. User tries to skip ahead of their progress
   * 2. User is behind their saved progress (on page refresh, navigate to latest)
   *
   * Page numbers in URL are 1-based, internal step indices are 0-based.
   */
  private validateAndNavigateToPage(pageParam: string | null): void {
    const def = this.modelService.currentCertification$();
    console.log('[DEBUG] validateAndNavigateToPage called:', { pageParam, hasDef: !!def });
    if (!def) return;

    const requestedPage = pageParam ? parseInt(pageParam, 10) : 1;
    const totalEntries = def.entries.length;
    const maxReachedEntryIndex = this.modelService.maxReachedEntryIndex$();

    // The "latest page" is the furthest page the user can access
    // (maxReached + 1, or maxReached if at the end)
    const latestPage = Math.min(maxReachedEntryIndex + 1, totalEntries);

    console.log('[DEBUG] validation state:', { pageParam, requestedPage, totalEntries, maxReachedEntryIndex, latestPage });

    // When entering certification without a page parameter, redirect to latest saved page
    if (!pageParam && maxReachedEntryIndex > 0) {
      console.log('[DEBUG] entering cert without page, redirecting to latest:', latestPage);
      this.router.navigate(['/certification', this.certificationId, 'page', latestPage], { replaceUrl: true });
      return;
    }

    // Validate page number is within bounds
    if (isNaN(requestedPage) || requestedPage < 1 || requestedPage > totalEntries) {
      console.log('[DEBUG] page out of bounds, redirecting to latest:', latestPage);
      this.router.navigate(['/certification', this.certificationId, 'page', latestPage], { replaceUrl: true });
      return;
    }

    const requestedEntryIndex = requestedPage - 1;

    // User can access entries they've been to (maxReached)
    // AND the next entry they need to work on (maxReached + 1)
    const maxAllowedEntry = maxReachedEntryIndex + 1;

    if (requestedEntryIndex > maxAllowedEntry) {
      // Redirect to the furthest allowed page
      const allowedPage = Math.min(maxAllowedEntry + 1, totalEntries);
      console.log('[DEBUG] entry not allowed, redirecting to:', allowedPage);
      this.router.navigate(['/certification', this.certificationId, 'page', allowedPage], { replaceUrl: true });
      return;
    }

    // On refresh (initial load), if user is behind their saved progress,
    // redirect them to the latest page they can access
    if (requestedPage < latestPage && maxReachedEntryIndex > 0) {
      console.log('[DEBUG] page behind saved progress, redirecting to latest:', latestPage);
      this.router.navigate(['/certification', this.certificationId, 'page', latestPage], { replaceUrl: true });
      return;
    }

    // Valid page - wizard uses entry index to initialize via initialStepIndex input
    // The wizard component handles mapping entry index to resolved step internally
    console.log('[DEBUG] valid entry index:', requestedEntryIndex);
  }

  onSubmitAnswers(answers: Map<string, string>): void {
    this.controller.checkAnswers(this.certificationId, answers).subscribe({
      next: (results) => {
        this.wizardComponent.applyAnswerResults(results);
      },
      error: (err) => {
        console.error('Error checking answers:', err);
        this.wizardComponent.submitting = false;
      }
    });
  }

  navigateToOverview(): void {
    this.router.navigate(['/certification', this.certificationId, 'overview']);
  }

  /**
   * Handles step navigation from the wizard component.
   * Updates the URL and tracks the furthest reached step.
   */
  onStepChange(entryIndex: number): void {
    const currentPage = entryIndex + 1;
    const maxReached = this.modelService.maxReachedEntryIndex$();
    console.log('[DEBUG] onStepChange:', { entryIndex, currentPage, maxReached });

    // Update max reached if user is now further than before
    if (entryIndex > maxReached) {
      console.log('[DEBUG] updating maxReachedEntry to:', entryIndex);
      this.modelService.setMaxReachedEntryIndex(entryIndex);
    }

    // Mark that we're navigating from stepChange to prevent validation loop
    this.isNavigatingFromStepChange = true;

    // Update URL to reflect current entry (use replaceUrl to avoid polluting history)
    console.log('[DEBUG] navigating to URL page:', currentPage);
    this.router.navigate(['/certification', this.certificationId, 'page', currentPage], { replaceUrl: true });
  }

  /**
   * Handles choice selection changes from the wizard.
   * Updates the model to persist selections to localStorage.
   */
  onChoiceSelectionsChange(selections: Map<string, Set<number>>): void {
    console.log('[DEBUG] choiceSelectionsChange:', selections);
    for (const [label, selectedIndices] of selections.entries()) {
      this.modelService.setChoiceSelections(label, selectedIndices);
    }
  }

  /**
   * Handles feedback submission from the wizard.
   * Submits feedback to the backend via the controller.
   */
  onSubmitFeedback(event: { feedbackType: 'INSTRUCTION' | 'PAGE'; targetId: string; feedbackText: string }): void {
    console.log('[DEBUG] submitFeedback:', event);
    this.controller.submitFeedback(this.certificationId, event.feedbackType, event.targetId, event.feedbackText)
      .subscribe({
        next: (response) => {
          console.log('[DEBUG] feedback submitted:', response);
          // Notify wizard of successful submission
          this.wizardComponent.markFeedbackSubmitted(event.targetId, event.feedbackType);
        },
        error: (err) => {
          console.error('Error submitting feedback:', err);
          // Notify wizard of failed submission
          this.wizardComponent.markFeedbackError(
            event.targetId,
            event.feedbackType,
            'Failed to submit feedback. Please try again.'
          );
        }
      });
  }
}
