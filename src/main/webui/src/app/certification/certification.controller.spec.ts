import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';
import { CertificationController } from './certification.controller';
import { CertificationModelService } from './certification.model';

describe('CertificationController', () => {
  let controller: CertificationController;
  let modelService: CertificationModelService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting()
      ]
    });
    controller = TestBed.inject(CertificationController);
    modelService = TestBed.inject(CertificationModelService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpMock.verify();
  });

  it('should be created', () => {
    expect(controller).toBeTruthy();
  });

  describe('loadCertifications', () => {
    it('should load certifications and update model service', () => {
      const mockCerts = [
        { id: 'cert-1', title: 'Cert 1', description: 'Desc 1', comingSoon: false },
        { id: 'cert-2', title: 'Cert 2', description: 'Desc 2', comingSoon: true }
      ];

      controller.loadCertifications();

      const req = httpMock.expectOne('/public/certifications');
      expect(req.request.method).toBe('GET');
      req.flush(mockCerts);

      expect(modelService.certifications$()).toEqual(mockCerts);
      expect(modelService.certificationsLoading$()).toBe(false);
      expect(modelService.certificationsError$()).toBeNull();
    });

    it('should set loading state before request', () => {
      controller.loadCertifications();

      expect(modelService.certificationsLoading$()).toBe(true);
      expect(modelService.certificationsError$()).toBeNull();

      const req = httpMock.expectOne('/public/certifications');
      req.flush([]);
    });

    it('should handle empty certifications list', () => {
      controller.loadCertifications();

      const req = httpMock.expectOne('/public/certifications');
      req.flush([]);

      expect(modelService.certifications$()).toEqual([]);
      expect(modelService.certificationsLoading$()).toBe(false);
    });

    it('should handle error response', () => {
      controller.loadCertifications();

      const req = httpMock.expectOne('/public/certifications');
      req.error(new ProgressEvent('error'), { status: 500, statusText: 'Server Error' });

      expect(modelService.certifications$()).toEqual([]);
      expect(modelService.certificationsLoading$()).toBe(false);
      expect(modelService.certificationsError$()).toBe('Failed to load certifications');
    });

    it('should log errors to console', () => {
      spyOn(console, 'error');

      controller.loadCertifications();

      const req = httpMock.expectOne('/public/certifications');
      req.error(new ProgressEvent('error'));

      expect(console.error).toHaveBeenCalledWith('Error loading certifications:', jasmine.any(Object));
    });
  });

  describe('loadCertification', () => {
    it('should load a certification and map to WizardDefinition', () => {
      const mockCert = {
        id: 'test-cert',
        title: 'Test Certification',
        description: 'A test certification',
        steps: [{
          id: 'step-1',
          stepKey: 'intro',
          title: 'Introduction',
          why: 'Learn the basics',
          infoExpanded: true,
          infoItems: [{ id: 'info-1', term: 'Term', description: 'Desc', sequenceOrder: 1 }],
          instructions: [{ id: 'instr-1', text: 'Do this', command: 'echo hello', sequenceOrder: 1 }],
          questions: [{
            id: 'q-1',
            questionKey: 'q1',
            text: 'What is this?',
            sequenceOrder: 1,
            answerOptions: [
              { id: 'a-1', text: 'Answer A', sequenceOrder: 1 },
              { id: 'a-2', text: 'Answer B', sequenceOrder: 2 }
            ]
          }]
        }],
        pageEntries: [{
          id: 'pe-1',
          entryType: 'DIRECT',
          sequenceOrder: 1,
          directStepId: 'step-1'
        }]
      };

      controller.loadCertification('test-cert');

      const req = httpMock.expectOne('/public/certifications/test-cert');
      expect(req.request.method).toBe('GET');
      req.flush(mockCert);

      const definition = modelService.currentCertification$();
      expect(definition).toBeTruthy();
      expect(definition!.id).toBe('test-cert');
      expect(definition!.title).toBe('Test Certification');
      expect(definition!.steps.length).toBe(1);
      expect(definition!.steps[0].title).toBe('Introduction');
      expect(definition!.steps[0].infoItems.length).toBe(1);
      expect(definition!.steps[0].instructions.length).toBe(1);
      expect(definition!.steps[0].questions.length).toBe(1);
      expect(definition!.steps[0].questions[0].options).toEqual([
        { id: 'a-1', text: 'Answer A' },
        { id: 'a-2', text: 'Answer B' }
      ]);
      expect(modelService.currentCertificationLoading$()).toBe(false);
      expect(modelService.currentCertificationError$()).toBeNull();
    });

    it('should set loading state before request', () => {
      controller.loadCertification('test-cert');

      expect(modelService.currentCertificationLoading$()).toBe(true);
      expect(modelService.currentCertificationError$()).toBeNull();

      const req = httpMock.expectOne('/public/certifications/test-cert');
      req.flush({
        id: 'test-cert', title: 'Test', description: '',
        steps: [], pageEntries: []
      });
    });

    it('should handle error response', () => {
      controller.loadCertification('non-existent');

      const req = httpMock.expectOne('/public/certifications/non-existent');
      req.error(new ProgressEvent('error'), { status: 404, statusText: 'Not Found' });

      expect(modelService.currentCertification$()).toBeNull();
      expect(modelService.currentCertificationLoading$()).toBe(false);
      expect(modelService.currentCertificationError$()).toContain('Failed to load certification');
    });

    it('should log errors to console', () => {
      spyOn(console, 'error');

      controller.loadCertification('fail');

      const req = httpMock.expectOne('/public/certifications/fail');
      req.error(new ProgressEvent('error'));

      expect(console.error).toHaveBeenCalledWith('Error loading certification:', jasmine.any(Object));
    });

    it('should handle choice entries in certification', () => {
      const mockCert = {
        id: 'choice-cert',
        title: 'Choice Cert',
        description: 'With choices',
        steps: [
          {
            id: 'step-linux', stepKey: 'linux', title: 'Linux Setup',
            why: 'Linux', infoExpanded: false,
            infoItems: [], instructions: [], questions: []
          },
          {
            id: 'step-windows', stepKey: 'windows', title: 'Windows Setup',
            why: 'Windows', infoExpanded: false,
            infoItems: [], instructions: [], questions: []
          }
        ],
        pageEntries: [{
          id: 'pe-1',
          entryType: 'CHOICE',
          sequenceOrder: 1,
          choiceLabel: 'OS Choice',
          choiceDescription: 'Choose your OS',
          minRequired: 1,
          maxRequired: 1,
          variants: [
            { id: 'v-1', label: 'Linux', description: 'Use Linux', sequenceOrder: 1, stepId: 'step-linux' },
            { id: 'v-2', label: 'Windows', description: 'Use Windows', sequenceOrder: 2, stepId: 'step-windows' }
          ]
        }]
      };

      controller.loadCertification('choice-cert');

      const req = httpMock.expectOne('/public/certifications/choice-cert');
      req.flush(mockCert);

      const definition = modelService.currentCertification$();
      expect(definition).toBeTruthy();
      expect(definition!.entries.length).toBe(1);

      const choiceEntry = definition!.entries[0];
      expect(typeof choiceEntry).not.toBe('string');
      if (typeof choiceEntry !== 'string') {
        expect(choiceEntry.label).toBe('OS Choice');
        expect(choiceEntry.variants.length).toBe(2);
        expect(choiceEntry.variants[0].label).toBe('Linux');
        expect(choiceEntry.variants[1].label).toBe('Windows');
      }

      const choiceSteps = definition!.choiceSteps.get('OS Choice');
      expect(choiceSteps).toBeTruthy();
      expect(choiceSteps!.length).toBe(2);
      expect(choiceSteps![0].title).toBe('Linux Setup');
      expect(choiceSteps![1].title).toBe('Windows Setup');
    });
  });
});
