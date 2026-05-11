import { ComponentFixture, TestBed } from '@angular/core/testing';
import { WelcomeComponent } from './welcome.component';
import { provideRouter } from '@angular/router';

// Mock RouterLink directive
import { Component, Input } from '@angular/core';

@Component({
  selector: '[routerLink]',
  template: '<ng-content></ng-content>',
  standalone: true
})
class MockRouterLink {
  @Input() routerLink: string | any[] = '';
}

describe('WelcomeComponent', () => {
  let component: WelcomeComponent;
  let fixture: ComponentFixture<WelcomeComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [WelcomeComponent],
      providers: [provideRouter([])]
    }).compileComponents();

    fixture = TestBed.createComponent(WelcomeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should render hero section with title', () => {
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('.hero-title')?.textContent).toContain('Master Skills');
  });

  it('should render features section', () => {
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('.features')).toBeTruthy();
    expect(compiled.querySelectorAll('.feature-card').length).toBe(4);
  });

  it('should render CTA button linking to certifications', () => {
    const compiled = fixture.nativeElement as HTMLElement;
    const ctaButton = compiled.querySelector('.cta-section a[routerLink="/certifications"]');
    expect(ctaButton).toBeTruthy();
  });
});
