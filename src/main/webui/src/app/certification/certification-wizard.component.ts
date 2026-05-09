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

  /** Current step index derived from URL page parameter (0-based). */
  initialStepIndex = 0;

  private certificationId = '';
  private routeSub: Subscription | null = null;
  private hasValidatedPage = false;
  private isNavigatingFromStepChange = false;

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
   * Validates the requested page number and redirects if user tries to skip ahead.
   * Page numbers in URL are 1-based, internal step indices are 0-based.
   */
  private validateAndNavigateToPage(pageParam: string | null): void {
    const def = this.modelService.currentCertification$();
    console.log('[DEBUG] validateAndNavigateToPage called:', { pageParam, hasDef: !!def });
    if (!def) return;

    const requestedPage = pageParam ? parseInt(pageParam, 10) : 1;
    const totalEntries = def.entries.length;
    console.log('[DEBUG] validation state:', { requestedPage, totalEntries });

    // Validate page number is within bounds
    if (isNaN(requestedPage) || requestedPage < 1 || requestedPage > totalEntries) {
      console.log('[DEBUG] page out of bounds, redirecting to 1');
      this.router.navigate(['/certification', this.certificationId, 'page', 1], { replaceUrl: true });
      return;
    }

    const requestedEntryIndex = requestedPage - 1;
    const maxReachedEntryIndex = this.modelService.maxReachedEntryIndex$();

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
}
