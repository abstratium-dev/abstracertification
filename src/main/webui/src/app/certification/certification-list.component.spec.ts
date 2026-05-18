import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter } from '@angular/router';
import { provideHttpClient } from '@angular/common/http';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { CertificationListComponent } from './certification-list.component';
import { CertificationModelService } from './certification.model';
import { CertificationController } from './certification.controller';
import { WizardProgressService } from '../core/wizard/wizard-progress.service';

describe('CertificationListComponent', () => {
  let component: CertificationListComponent;
  let fixture: ComponentFixture<CertificationListComponent>;
  let progressService: WizardProgressService;
  let modelService: CertificationModelService;
  let controller: CertificationController;
  let httpMock: HttpTestingController;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CertificationListComponent],
      providers: [
        provideRouter([]),
        provideHttpClient(),
        provideHttpClientTesting(),
      ],
    }).compileComponents();

    fixture = TestBed.createComponent(CertificationListComponent);
    component = fixture.componentInstance;
    progressService = TestBed.inject(WizardProgressService);
    modelService = TestBed.inject(CertificationModelService);
    controller = TestBed.inject(CertificationController);
    httpMock = TestBed.inject(HttpTestingController);
    localStorage.clear();
  });

  afterEach(() => {
    httpMock.verify();
    localStorage.clear();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  describe('hasStarted', () => {
    it('should return false when no progress exists for the certification', () => {
      expect(component.hasStarted('cert-abc')).toBe(false);
    });

    it('should return true when progress exists in localStorage for the certification', () => {
      progressService.saveProgress('cert-abc', { maxReachedEntryIndex: 2, choiceSelections: {} });
      expect(component.hasStarted('cert-abc')).toBe(true);
    });

    it('should return false for a different certification ID', () => {
      progressService.saveProgress('cert-abc', { maxReachedEntryIndex: 2, choiceSelections: {} });
      expect(component.hasStarted('cert-xyz')).toBe(false);
    });

    it('should return false after progress is cleared', () => {
      progressService.saveProgress('cert-abc', { maxReachedEntryIndex: 2, choiceSelections: {} });
      progressService.clearProgress('cert-abc');
      expect(component.hasStarted('cert-abc')).toBe(false);
    });
  });

  describe('template rendering', () => {
    const mockCerts = [
      { id: 'cert-1', title: 'Cert One', description: 'Desc one', comingSoon: false, aiEnabled: false },
      { id: 'cert-2', title: 'Cert Two', description: 'Desc two', comingSoon: false, aiEnabled: false },
      { id: 'cert-3', title: 'Cert Three', description: 'Desc three', comingSoon: true, aiEnabled: false },
    ];

    beforeEach(() => {
      progressService.saveProgress('cert-1', { maxReachedEntryIndex: 1, choiceSelections: {} });
      fixture.detectChanges();
      const req = httpMock.expectOne('/public/certifications');
      req.flush(mockCerts);
      fixture.detectChanges();
    });

    it('should show "In Progress" badge for a started certification', () => {
      const badges = fixture.nativeElement.querySelectorAll('.in-progress-badge');
      expect(badges.length).toBe(1);
      expect(badges[0].textContent.trim()).toBe('In Progress');
    });

    it('should show "Coming Soon" badge for coming-soon certifications', () => {
      const badges = fixture.nativeElement.querySelectorAll('.coming-soon-badge');
      expect(badges.length).toBe(1);
      expect(badges[0].textContent.trim()).toBe('Coming Soon');
    });

    it('should apply in-progress class only to the started certification card', () => {
      const inProgressCards = fixture.nativeElement.querySelectorAll('.certification-card.in-progress');
      expect(inProgressCards.length).toBe(1);
      expect(inProgressCards[0].querySelector('h2').textContent.trim()).toBe('Cert One');
    });

    it('should show "Continue" button for a started certification', () => {
      const allCards = fixture.nativeElement.querySelectorAll('.certification-card');
      const startedCard = Array.from(allCards).find((c: any) =>
        c.querySelector('h2')?.textContent.trim() === 'Cert One'
      ) as HTMLElement;
      expect(startedCard.querySelector('.btn-start')!.textContent!.trim()).toBe('Continue');
    });

    it('should show "Start" button for a not-started certification', () => {
      const allCards = fixture.nativeElement.querySelectorAll('.certification-card');
      const notStartedCard = Array.from(allCards).find((c: any) =>
        c.querySelector('h2')?.textContent.trim() === 'Cert Two'
      ) as HTMLElement;
      expect(notStartedCard.querySelector('.btn-start')!.textContent!.trim()).toBe('Start');
    });

    it('should not show a start button for coming-soon certifications', () => {
      const allCards = fixture.nativeElement.querySelectorAll('.certification-card');
      const comingSoonCard = Array.from(allCards).find((c: any) =>
        c.classList.contains('coming-soon')
      ) as HTMLElement;
      expect(comingSoonCard.querySelector('.btn-start')).toBeNull();
    });
  });
});
