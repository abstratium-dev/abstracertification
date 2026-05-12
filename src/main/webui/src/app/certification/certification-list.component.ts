import { CommonModule } from '@angular/common';
import { Component, OnInit, inject } from '@angular/core';
import { Router } from '@angular/router';
import { CertificationModelService } from './certification.model';
import { CertificationController } from './certification.controller';
import { WizardProgressService } from '../core/wizard/wizard-progress.service';

/**
 * Displays a grid of available certifications loaded from the public API.
 * Each card shows the certification title and description with a "Start" action
 * that navigates to the certification wizard view.
 */
@Component({
  selector: 'certification-list',
  imports: [CommonModule],
  templateUrl: './certification-list.component.html',
  styleUrl: './certification-list.component.scss',
})
export class CertificationListComponent implements OnInit {
  private modelService = inject(CertificationModelService);
  private controller = inject(CertificationController);
  private router = inject(Router);
  private progressService = inject(WizardProgressService);

  certifications = this.modelService.certifications$;
  loading = this.modelService.certificationsLoading$;
  error = this.modelService.certificationsError$;

  ngOnInit(): void {
    this.controller.loadCertifications();
  }

  hasStarted(certificationId: string): boolean {
    return this.progressService.hasProgress(certificationId);
  }

  startCertification(certificationId: string): void {
    this.router.navigate(['/certification', certificationId, 'page', 1]);
  }

  viewOverview(certificationId: string): void {
    this.router.navigate(['/certification', certificationId, 'overview']);
  }
}
