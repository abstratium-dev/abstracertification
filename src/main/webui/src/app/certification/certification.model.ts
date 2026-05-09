import { Injectable, signal, Signal } from '@angular/core';
import { WizardDefinition } from '../core/wizard/wizard.model';

/** Lightweight summary of a certification, used in list views. */
export interface CertificationSummary {
  id: string;
  title: string;
  description: string;
}

/**
 * Signal-based model service for certification state.
 * Holds the list of available certifications and the currently loaded
 * certification (mapped to a WizardDefinition), along with loading and error
 * states for each. Updated exclusively by the CertificationController.
 */
@Injectable({
  providedIn: 'root',
})
export class CertificationModelService {

  private certifications = signal<CertificationSummary[]>([]);
  private certificationsLoading = signal<boolean>(false);
  private certificationsError = signal<string | null>(null);

  private currentCertification = signal<WizardDefinition | null>(null);
  private currentCertificationLoading = signal<boolean>(false);
  private currentCertificationError = signal<string | null>(null);

  /**
   * Tracks the furthest entry index the user has reached (0-based).
   * This tracks position in the original entries array, not resolved steps.
   * Used to prevent URL-based page skipping.
   */
  private maxReachedEntryIndex = signal<number>(0);

  certifications$: Signal<CertificationSummary[]> = this.certifications.asReadonly();
  certificationsLoading$: Signal<boolean> = this.certificationsLoading.asReadonly();
  certificationsError$: Signal<string | null> = this.certificationsError.asReadonly();

  currentCertification$: Signal<WizardDefinition | null> = this.currentCertification.asReadonly();
  currentCertificationLoading$: Signal<boolean> = this.currentCertificationLoading.asReadonly();
  currentCertificationError$: Signal<string | null> = this.currentCertificationError.asReadonly();

  maxReachedEntryIndex$: Signal<number> = this.maxReachedEntryIndex.asReadonly();

  setCertifications(certifications: CertificationSummary[]) {
    this.certifications.set(certifications);
  }

  setCertificationsLoading(loading: boolean) {
    this.certificationsLoading.set(loading);
  }

  setCertificationsError(error: string | null) {
    this.certificationsError.set(error);
  }

  setCurrentCertification(certification: WizardDefinition | null) {
    this.currentCertification.set(certification);
  }

  setCurrentCertificationLoading(loading: boolean) {
    this.currentCertificationLoading.set(loading);
  }

  setCurrentCertificationError(error: string | null) {
    this.currentCertificationError.set(error);
  }

  setMaxReachedEntryIndex(index: number) {
    this.maxReachedEntryIndex.set(index);
  }

  resetMaxReachedEntryIndex() {
    this.maxReachedEntryIndex.set(0);
  }
}
