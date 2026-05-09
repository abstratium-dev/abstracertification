import { Injectable } from '@angular/core';

/**
 * Storage key for wizard progress, keyed by certification ID.
 * Format: `wizard-progress-{certificationId}`
 */
const STORAGE_KEY_PREFIX = 'wizard-progress';

/**
 * Serialized representation of wizard progress for local storage.
 */
export interface StoredWizardProgress {
  /** The furthest entry index the user has reached (0-based). */
  maxReachedEntryIndex: number;
  /** Choice selections: choiceLabel -> array of selected variant indices. */
  choiceSelections: Record<string, number[]>;
}

/**
 * Service for persisting and restoring wizard progress to/from localStorage.
 * Uses the certification ID as a prefix to isolate progress per certification.
 */
@Injectable({
  providedIn: 'root',
})
export class WizardProgressService {
  /**
   * Saves wizard progress to localStorage.
   * @param certificationId The unique ID of the certification
   * @param progress The progress data to store
   */
  saveProgress(certificationId: string, progress: StoredWizardProgress): void {
    if (!certificationId) return;
    try {
      const key = this.getStorageKey(certificationId);
      const data = JSON.stringify(progress);
      localStorage.setItem(key, data);
    } catch (e) {
      console.error('[WizardProgressService] Failed to save progress:', e);
    }
  }

  /**
   * Loads wizard progress from localStorage.
   * @param certificationId The unique ID of the certification
   * @returns The stored progress, or null if not found
   */
  loadProgress(certificationId: string): StoredWizardProgress | null {
    if (!certificationId) return null;
    try {
      const key = this.getStorageKey(certificationId);
      const data = localStorage.getItem(key);
      if (!data) return null;
      return JSON.parse(data) as StoredWizardProgress;
    } catch (e) {
      console.error('[WizardProgressService] Failed to load progress:', e);
      return null;
    }
  }

  /**
   * Clears wizard progress from localStorage.
   * @param certificationId The unique ID of the certification
   */
  clearProgress(certificationId: string): void {
    if (!certificationId) return;
    try {
      const key = this.getStorageKey(certificationId);
      localStorage.removeItem(key);
    } catch (e) {
      console.error('[WizardProgressService] Failed to clear progress:', e);
    }
  }

  /**
   * Checks if progress exists for a certification.
   * @param certificationId The unique ID of the certification
   * @returns true if progress exists in localStorage
   */
  hasProgress(certificationId: string): boolean {
    if (!certificationId) return false;
    try {
      const key = this.getStorageKey(certificationId);
      return localStorage.getItem(key) !== null;
    } catch (e) {
      return false;
    }
  }

  private getStorageKey(certificationId: string): string {
    return `${STORAGE_KEY_PREFIX}-${certificationId}`;
  }
}
