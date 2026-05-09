import { Component, OnInit, OnDestroy, inject } from '@angular/core';
import { CommonModule, Location } from '@angular/common';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import { CertificationModelService } from './certification.model';
import { CertificationController } from './certification.controller';
import { WizardDefinition, WizardStep, WizardChoicePoint, WizardEntry } from '../core/wizard/wizard.model';

/**
 * Displays a full structural overview of a certification.
 * Shows all page entries (direct steps and choice points) and their associated steps.
 * The certification is reloaded when the route is accessed directly.
 */
@Component({
  selector: 'certification-overview',
  imports: [CommonModule],
  templateUrl: './certification-overview.component.html',
  styleUrl: './certification-overview.component.scss',
})
export class CertificationOverviewComponent implements OnInit, OnDestroy {
  private modelService = inject(CertificationModelService);
  private controller = inject(CertificationController);
  private route = inject(ActivatedRoute);
  private location = inject(Location);

  definition = this.modelService.currentCertification$;
  loading = this.modelService.currentCertificationLoading$;
  error = this.modelService.currentCertificationError$;

  private certificationId = '';
  private routeSub: Subscription | null = null;

  ngOnInit(): void {
    this.routeSub = this.route.paramMap.subscribe((params: ParamMap) => {
      this.certificationId = params.get('certificationId') ?? '';
      if (this.certificationId) {
        this.controller.loadCertification(this.certificationId);
      }
    });
  }

  ngOnDestroy(): void {
    this.routeSub?.unsubscribe();
  }

  isChoicePoint(entry: WizardEntry): entry is WizardChoicePoint {
    return typeof entry === 'object' && 'variants' in entry;
  }

  getStepByRef(stepRef: string, definition: WizardDefinition): WizardStep | undefined {
    return definition.steps.find(s => `step-${s.id}` === stepRef);
  }

  getChoiceSteps(choicePoint: WizardChoicePoint, definition: WizardDefinition): Array<{ variant: { label: string; description: string; stepRef: string }; step: WizardStep | undefined }> {
    return choicePoint.variants.map(variant => ({
      variant,
      step: this.getStepByRef(variant.stepRef, definition)
    }));
  }

  goBack(): void {
    this.location.back();
  }

  navigateToCertifications(): void {
    this.location.go('/certifications');
  }
}
