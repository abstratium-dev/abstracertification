import { Injectable, signal, Signal, effect, inject } from '@angular/core';
import { WizardDefinition } from '../core/wizard/wizard.model';
import { WizardProgressService, StoredWizardProgress } from '../core/wizard/wizard-progress.service';

/** Lightweight summary of a certification, used in list views. */
export interface CertificationSummary {
  id: string;
  title: string;
  description: string;
  comingSoon: boolean;
}

/**
 * Signal-based model service for certification state.
 * Holds the list of available certifications and the currently loaded
 * certification (mapped to a WizardDefinition), along with loading and error
 * states for each. Updated exclusively by the CertificationController.
 *
 * This service also persists wizard progress (max reached entry and choice
 * selections) to localStorage, using the certification ID as a prefix.
 */
@Injectable({
  providedIn: 'root',
})
export class CertificationModelService {
  private progressService = inject(WizardProgressService);

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

  /**
   * Tracks choice selections: choiceLabel -> Set of selected variant indices.
   * This is needed to restore variant steps after a page refresh.
   */
  private choiceSelections = signal<Map<string, Set<number>>>(new Map());

  /**
   * The current certification ID, used for localStorage persistence.
   */
  private currentCertificationId = signal<string>('');

  certifications$: Signal<CertificationSummary[]> = this.certifications.asReadonly();
  certificationsLoading$: Signal<boolean> = this.certificationsLoading.asReadonly();
  certificationsError$: Signal<string | null> = this.certificationsError.asReadonly();

  currentCertification$: Signal<WizardDefinition | null> = this.currentCertification.asReadonly();
  currentCertificationLoading$: Signal<boolean> = this.currentCertificationLoading.asReadonly();
  currentCertificationError$: Signal<string | null> = this.currentCertificationError.asReadonly();

  maxReachedEntryIndex$: Signal<number> = this.maxReachedEntryIndex.asReadonly();

  choiceSelections$: Signal<Map<string, Set<number>>> = this.choiceSelections.asReadonly();

  constructor() {
    // Auto-save progress whenever it changes
    effect(() => {
      const certId = this.currentCertificationId();
      const maxIndex = this.maxReachedEntryIndex();
      const selections = this.choiceSelections();

      if (certId) {
        const progress: StoredWizardProgress = {
          maxReachedEntryIndex: maxIndex,
          choiceSelections: this.serializeChoiceSelections(selections),
        };
        this.progressService.saveProgress(certId, progress);
      }
    });
  }

  setCertifications(certifications: CertificationSummary[]) {
    this.certifications.set(certifications);
  }

  setCertificationsLoading(loading: boolean) {
    this.certificationsLoading.set(loading);
  }

  setCertificationsError(error: string | null) {
    this.certificationsError.set(error);
  }

  setCurrentCertification(certification: WizardDefinition | null, certificationId?: string) {
    this.currentCertification.set(certification);
    if (certificationId) {
      this.currentCertificationId.set(certificationId);
      this.loadProgress(certificationId);
    }
  }

  /**
   * Loads saved progress from localStorage for the given certification.
   */
  private loadProgress(certificationId: string): void {
    const progress = this.progressService.loadProgress(certificationId);
    if (progress) {
      this.maxReachedEntryIndex.set(progress.maxReachedEntryIndex);
      this.choiceSelections.set(this.deserializeChoiceSelections(progress.choiceSelections));
    } else {
      this.maxReachedEntryIndex.set(0);
      this.choiceSelections.set(new Map());
    }
  }

  /**
   * Converts choice selections Map to a serializable object.
   */
  private serializeChoiceSelections(selections: Map<string, Set<number>>): Record<string, number[]> {
    const result: Record<string, number[]> = {};
    for (const [label, indices] of selections.entries()) {
      result[label] = Array.from(indices);
    }
    return result;
  }

  /**
   * Converts serialized choice selections back to a Map.
   */
  private deserializeChoiceSelections(data: Record<string, number[]>): Map<string, Set<number>> {
    const result = new Map<string, Set<number>>();
    for (const [label, indices] of Object.entries(data)) {
      result.set(label, new Set(indices));
    }
    return result;
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
    this.choiceSelections.set(new Map());
    if (this.currentCertificationId()) {
      this.progressService.clearProgress(this.currentCertificationId());
    }
  }

  /**
   * Sets the choice selections for a specific choice point.
   * Called by the wizard component when user makes selections.
   */
  setChoiceSelections(choiceLabel: string, selections: Set<number>): void {
    const current = new Map(this.choiceSelections());
    current.set(choiceLabel, selections);
    this.choiceSelections.set(current);
  }
}
