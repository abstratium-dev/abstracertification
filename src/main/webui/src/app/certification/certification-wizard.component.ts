import { Component, OnInit, OnDestroy, ViewChild, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { Subscription } from 'rxjs';
import { WizardComponent } from '../core/wizard/wizard.component';
import { CertificationModelService } from './certification.model';
import { CertificationController } from './certification.controller';

@Component({
  selector: 'certification-wizard',
  imports: [CommonModule, WizardComponent],
  templateUrl: './certification-wizard.component.html',
})
export class CertificationWizardComponent implements OnInit, OnDestroy {
  private modelService = inject(CertificationModelService);
  private controller = inject(CertificationController);
  private route = inject(ActivatedRoute);

  @ViewChild(WizardComponent) wizardComponent!: WizardComponent;

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
}
