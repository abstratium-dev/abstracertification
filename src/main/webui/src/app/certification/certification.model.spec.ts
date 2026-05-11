import { TestBed } from '@angular/core/testing';
import { CertificationModelService, CertificationSummary } from './certification.model';
import { WizardDefinition } from '../core/wizard/wizard.model';

describe('CertificationModelService', () => {
  let service: CertificationModelService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(CertificationModelService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  describe('Initial State', () => {
    it('should have empty certifications initially', () => {
      expect(service.certifications$()).toEqual([]);
    });

    it('should not be loading initially', () => {
      expect(service.certificationsLoading$()).toBe(false);
    });

    it('should have no error initially', () => {
      expect(service.certificationsError$()).toBeNull();
    });

    it('should have no current certification initially', () => {
      expect(service.currentCertification$()).toBeNull();
    });

    it('should not be loading current certification initially', () => {
      expect(service.currentCertificationLoading$()).toBe(false);
    });

    it('should have no current certification error initially', () => {
      expect(service.currentCertificationError$()).toBeNull();
    });
  });

  describe('Certifications List', () => {
    it('should set certifications', () => {
      const certs: CertificationSummary[] = [
        { id: 'cert-1', title: 'Cert 1', description: 'Description 1', comingSoon: false },
        { id: 'cert-2', title: 'Cert 2', description: 'Description 2', comingSoon: true }
      ];
      service.setCertifications(certs);
      expect(service.certifications$()).toEqual(certs);
    });

    it('should update certifications', () => {
      const certs1: CertificationSummary[] = [{ id: '1', title: 'A', description: '', comingSoon: false }];
      const certs2: CertificationSummary[] = [{ id: '2', title: 'B', description: '', comingSoon: false }];

      service.setCertifications(certs1);
      expect(service.certifications$()).toEqual(certs1);

      service.setCertifications(certs2);
      expect(service.certifications$()).toEqual(certs2);
    });

    it('should handle empty certifications list', () => {
      service.setCertifications([{ id: '1', title: 'A', description: '', comingSoon: false }]);
      service.setCertifications([]);
      expect(service.certifications$()).toEqual([]);
    });
  });

  describe('Loading State', () => {
    it('should set loading state', () => {
      service.setCertificationsLoading(true);
      expect(service.certificationsLoading$()).toBe(true);
    });

    it('should toggle loading state', () => {
      service.setCertificationsLoading(true);
      expect(service.certificationsLoading$()).toBe(true);

      service.setCertificationsLoading(false);
      expect(service.certificationsLoading$()).toBe(false);
    });
  });

  describe('Error State', () => {
    it('should set error', () => {
      service.setCertificationsError('Failed to load');
      expect(service.certificationsError$()).toBe('Failed to load');
    });

    it('should clear error', () => {
      service.setCertificationsError('Error');
      service.setCertificationsError(null);
      expect(service.certificationsError$()).toBeNull();
    });
  });

  describe('Current Certification', () => {
    it('should set current certification', () => {
      const definition: WizardDefinition = {
        id: 'test', title: 'Test', description: 'Desc',
        entries: [], steps: [], choiceSteps: new Map()
      };
      service.setCurrentCertification(definition);
      expect(service.currentCertification$()).toEqual(definition);
    });

    it('should clear current certification', () => {
      const definition: WizardDefinition = {
        id: 'test', title: 'Test', description: 'Desc',
        entries: [], steps: [], choiceSteps: new Map()
      };
      service.setCurrentCertification(definition);
      service.setCurrentCertification(null);
      expect(service.currentCertification$()).toBeNull();
    });

    it('should manage current certification loading state', () => {
      service.setCurrentCertificationLoading(true);
      expect(service.currentCertificationLoading$()).toBe(true);

      service.setCurrentCertificationLoading(false);
      expect(service.currentCertificationLoading$()).toBe(false);
    });

    it('should manage current certification error state', () => {
      service.setCurrentCertificationError('Failed');
      expect(service.currentCertificationError$()).toBe('Failed');

      service.setCurrentCertificationError(null);
      expect(service.currentCertificationError$()).toBeNull();
    });
  });

  describe('Service Singleton', () => {
    it('should be a singleton across injections', () => {
      const service2 = TestBed.inject(CertificationModelService);
      service.setCertifications([{ id: '1', title: 'A', description: '', comingSoon: false }]);
      expect(service2.certifications$()).toEqual([{ id: '1', title: 'A', description: '', comingSoon: false }]);
    });
  });

  describe('Progress Persistence', () => {
    beforeEach(() => {
      localStorage.clear();
    });

    afterEach(() => {
      localStorage.clear();
    });

    it('should have initial maxReachedEntryIndex of 0', () => {
      expect(service.maxReachedEntryIndex$()).toBe(0);
    });

    it('should have empty choiceSelections initially', () => {
      expect(service.choiceSelections$()).toEqual(new Map());
    });

    it('should update maxReachedEntryIndex', () => {
      service.setMaxReachedEntryIndex(5);
      expect(service.maxReachedEntryIndex$()).toBe(5);
    });

    it('should persist maxReachedEntryIndex to localStorage', () => {
      const definition: WizardDefinition = {
        id: 'test-cert', title: 'Test', description: 'Desc',
        entries: [], steps: [], choiceSteps: new Map()
      };

      service.setCurrentCertification(definition, 'test-cert');
      service.setMaxReachedEntryIndex(3);

      // Flush effects to ensure the localStorage write happens
      TestBed.flushEffects();

      const stored = localStorage.getItem('wizard-progress-test-cert');
      expect(stored).toBeTruthy();
      expect(JSON.parse(stored!).maxReachedEntryIndex).toBe(3);
    });

    it('should persist choiceSelections to localStorage', () => {
      const definition: WizardDefinition = {
        id: 'test-cert', title: 'Test', description: 'Desc',
        entries: [], steps: [], choiceSteps: new Map()
      };

      service.setCurrentCertification(definition, 'test-cert');
      service.setChoiceSelections('Choose setup', new Set([0, 2]));

      // Flush effects to ensure the localStorage write happens
      TestBed.flushEffects();

      const stored = localStorage.getItem('wizard-progress-test-cert');
      expect(stored).toBeTruthy();
      const parsed = JSON.parse(stored!);
      expect(parsed.choiceSelections).toEqual({ 'Choose setup': [0, 2] });
    });

    it('should load progress from localStorage when setting certification', () => {
      localStorage.setItem('wizard-progress-existing-cert', JSON.stringify({
        maxReachedEntryIndex: 7,
        choiceSelections: { 'Setup': [1] }
      }));

      const definition: WizardDefinition = {
        id: 'existing-cert', title: 'Test', description: 'Desc',
        entries: [], steps: [], choiceSteps: new Map()
      };

      service.setCurrentCertification(definition, 'existing-cert');

      expect(service.maxReachedEntryIndex$()).toBe(7);
      expect(service.choiceSelections$().get('Setup')).toEqual(new Set([1]));
    });

    it('should reset progress when resetMaxReachedEntryIndex is called', () => {
      localStorage.setItem('wizard-progress-reset-cert', JSON.stringify({
        maxReachedEntryIndex: 5,
        choiceSelections: { 'Choice': [0] }
      }));

      const definition: WizardDefinition = {
        id: 'reset-cert', title: 'Test', description: 'Desc',
        entries: [], steps: [], choiceSteps: new Map()
      };

      service.setCurrentCertification(definition, 'reset-cert');
      expect(service.maxReachedEntryIndex$()).toBe(5);

      service.resetMaxReachedEntryIndex();

      expect(service.maxReachedEntryIndex$()).toBe(0);
      expect(service.choiceSelections$()).toEqual(new Map());
      expect(localStorage.getItem('wizard-progress-reset-cert')).toBeNull();
    });

    it('should update choiceSelections with setChoiceSelections', () => {
      service.setChoiceSelections('Test Choice', new Set([0, 1]));

      expect(service.choiceSelections$().get('Test Choice')).toEqual(new Set([0, 1]));
    });

    it('should merge choice selections for different labels', () => {
      service.setChoiceSelections('Choice A', new Set([0]));
      service.setChoiceSelections('Choice B', new Set([1, 2]));

      const selections = service.choiceSelections$();
      expect(selections.get('Choice A')).toEqual(new Set([0]));
      expect(selections.get('Choice B')).toEqual(new Set([1, 2]));
    });

    it('should isolate progress per certification', () => {
      const def1: WizardDefinition = {
        id: 'cert-1', title: 'Cert 1', description: 'Desc',
        entries: [], steps: [], choiceSteps: new Map()
      };
      const def2: WizardDefinition = {
        id: 'cert-2', title: 'Cert 2', description: 'Desc',
        entries: [], steps: [], choiceSteps: new Map()
      };

      service.setCurrentCertification(def1, 'cert-1');
      service.setMaxReachedEntryIndex(3);
      TestBed.flushEffects();

      service.setCurrentCertification(def2, 'cert-2');
      service.setMaxReachedEntryIndex(7);
      TestBed.flushEffects();

      // Reload cert-1
      service.setCurrentCertification(def1, 'cert-1');
      expect(service.maxReachedEntryIndex$()).toBe(3);

      // Reload cert-2
      service.setCurrentCertification(def2, 'cert-2');
      expect(service.maxReachedEntryIndex$()).toBe(7);
    });
  });
});
