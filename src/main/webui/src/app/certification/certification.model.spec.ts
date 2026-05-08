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
        { id: 'cert-1', title: 'Cert 1', description: 'Description 1' },
        { id: 'cert-2', title: 'Cert 2', description: 'Description 2' }
      ];
      service.setCertifications(certs);
      expect(service.certifications$()).toEqual(certs);
    });

    it('should update certifications', () => {
      const certs1: CertificationSummary[] = [{ id: '1', title: 'A', description: '' }];
      const certs2: CertificationSummary[] = [{ id: '2', title: 'B', description: '' }];

      service.setCertifications(certs1);
      expect(service.certifications$()).toEqual(certs1);

      service.setCertifications(certs2);
      expect(service.certifications$()).toEqual(certs2);
    });

    it('should handle empty certifications list', () => {
      service.setCertifications([{ id: '1', title: 'A', description: '' }]);
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
      service.setCertifications([{ id: '1', title: 'A', description: '' }]);
      expect(service2.certifications$()).toEqual([{ id: '1', title: 'A', description: '' }]);
    });
  });
});
