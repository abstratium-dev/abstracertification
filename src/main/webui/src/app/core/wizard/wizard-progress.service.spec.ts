import { TestBed } from '@angular/core/testing';
import { WizardProgressService, StoredWizardProgress } from './wizard-progress.service';

describe('WizardProgressService', () => {
  let service: WizardProgressService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(WizardProgressService);
    // Clear localStorage before each test
    localStorage.clear();
  });

  afterEach(() => {
    localStorage.clear();
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  describe('saveProgress', () => {
    it('should save progress to localStorage', () => {
      const certId = 'test-cert-123';
      const progress: StoredWizardProgress = {
        maxReachedEntryIndex: 3,
        choiceSelections: {
          'Choose your setup': [0, 2],
          'Select storage': [1]
        }
      };

      service.saveProgress(certId, progress);

      const stored = localStorage.getItem('wizard-progress-test-cert-123');
      expect(stored).toBeTruthy();
      expect(JSON.parse(stored!)).toEqual(progress);
    });

    it('should not throw when localStorage is unavailable', () => {
      const originalSetItem = localStorage.setItem;
      localStorage.setItem = () => { throw new Error('Storage full'); };

      const certId = 'test-cert';
      const progress: StoredWizardProgress = {
        maxReachedEntryIndex: 1,
        choiceSelections: {}
      };

      expect(() => service.saveProgress(certId, progress)).not.toThrow();

      localStorage.setItem = originalSetItem;
    });

    it('should not save when certificationId is empty', () => {
      const progress: StoredWizardProgress = {
        maxReachedEntryIndex: 1,
        choiceSelections: {}
      };

      service.saveProgress('', progress);

      expect(localStorage.length).toBe(0);
    });
  });

  describe('loadProgress', () => {
    it('should load progress from localStorage', () => {
      const certId = 'my-cert';
      const progress: StoredWizardProgress = {
        maxReachedEntryIndex: 5,
        choiceSelections: {
          'Choose variant': [0]
        }
      };
      localStorage.setItem('wizard-progress-my-cert', JSON.stringify(progress));

      const loaded = service.loadProgress(certId);

      expect(loaded).toEqual(progress);
    });

    it('should return null when no progress exists', () => {
      const loaded = service.loadProgress('nonexistent-cert');

      expect(loaded).toBeNull();
    });

    it('should return null when localStorage is unavailable', () => {
      const originalGetItem = localStorage.getItem;
      localStorage.getItem = () => { throw new Error('Storage error'); };

      const loaded = service.loadProgress('test-cert');

      expect(loaded).toBeNull();

      localStorage.getItem = originalGetItem;
    });

    it('should return null for empty certificationId', () => {
      const loaded = service.loadProgress('');

      expect(loaded).toBeNull();
    });
  });

  describe('clearProgress', () => {
    it('should remove progress from localStorage', () => {
      const certId = 'cert-to-clear';
      localStorage.setItem('wizard-progress-cert-to-clear', JSON.stringify({
        maxReachedEntryIndex: 2,
        choiceSelections: {}
      }));

      service.clearProgress(certId);

      expect(localStorage.getItem('wizard-progress-cert-to-clear')).toBeNull();
    });

    it('should not throw when clearing non-existent progress', () => {
      expect(() => service.clearProgress('nonexistent')).not.toThrow();
    });

    it('should not attempt to clear when certificationId is empty', () => {
      expect(() => service.clearProgress('')).not.toThrow();
    });
  });

  describe('hasProgress', () => {
    it('should return true when progress exists', () => {
      const certId = 'existing-cert';
      localStorage.setItem('wizard-progress-existing-cert', JSON.stringify({
        maxReachedEntryIndex: 1,
        choiceSelections: {}
      }));

      expect(service.hasProgress(certId)).toBe(true);
    });

    it('should return false when no progress exists', () => {
      expect(service.hasProgress('no-progress-cert')).toBe(false);
    });

    it('should return false for empty certificationId', () => {
      expect(service.hasProgress('')).toBe(false);
    });

    it('should return false when localStorage is unavailable', () => {
      const originalGetItem = localStorage.getItem;
      localStorage.getItem = () => { throw new Error('Storage error'); };

      expect(service.hasProgress('test-cert')).toBe(false);

      localStorage.getItem = originalGetItem;
    });
  });

  describe('certification isolation', () => {
    it('should isolate progress by certification ID', () => {
      const progress1: StoredWizardProgress = {
        maxReachedEntryIndex: 3,
        choiceSelections: { 'Setup': [0] }
      };
      const progress2: StoredWizardProgress = {
        maxReachedEntryIndex: 7,
        choiceSelections: { 'Config': [1, 2] }
      };

      service.saveProgress('cert-1', progress1);
      service.saveProgress('cert-2', progress2);

      expect(service.loadProgress('cert-1')).toEqual(progress1);
      expect(service.loadProgress('cert-2')).toEqual(progress2);
    });

    it('should use certification ID as prefix in storage key', () => {
      const certId = 'my-awesome-cert';
      const progress: StoredWizardProgress = {
        maxReachedEntryIndex: 1,
        choiceSelections: {}
      };

      service.saveProgress(certId, progress);

      const keys = Object.keys(localStorage);
      expect(keys).toContain('wizard-progress-my-awesome-cert');
    });
  });
});
