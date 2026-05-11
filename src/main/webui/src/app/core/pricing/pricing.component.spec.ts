import { ComponentFixture, TestBed } from '@angular/core/testing';
import { PricingComponent } from './pricing.component';
import { provideRouter } from '@angular/router';

describe('PricingComponent', () => {
  let component: PricingComponent;
  let fixture: ComponentFixture<PricingComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PricingComponent],
      providers: [provideRouter([])]
    }).compileComponents();

    fixture = TestBed.createComponent(PricingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should render four pricing tiers', () => {
    const compiled = fixture.nativeElement as HTMLElement;
    const tiers = compiled.querySelectorAll('.tier-card');
    expect(tiers.length).toBe(4);
  });

  it('should display Free tier with €0 price', () => {
    const compiled = fixture.nativeElement as HTMLElement;
    const freeTier = compiled.querySelectorAll('.tier-card')[0];
    expect(freeTier.querySelector('.tier-name')?.textContent).toContain('Free');
    expect(freeTier.querySelector('.price-amount')?.textContent).toContain('€0');
  });

  it('should display Per Certificate tier with €10 price', () => {
    const compiled = fixture.nativeElement as HTMLElement;
    const perCertTier = compiled.querySelectorAll('.tier-card')[1];
    expect(perCertTier.querySelector('.tier-name')?.textContent).toContain('Per Certificate');
    expect(perCertTier.querySelector('.price-amount')?.textContent).toContain('€10');
  });

  it('should display Unlimited tier with €100 price', () => {
    const compiled = fixture.nativeElement as HTMLElement;
    const unlimitedTier = compiled.querySelectorAll('.tier-card')[2];
    expect(unlimitedTier.querySelector('.tier-name')?.textContent).toContain('Unlimited');
    expect(unlimitedTier.querySelector('.price-amount')?.textContent).toContain('€100');
  });

  it('should display Enterprise tier with Custom pricing', () => {
    const compiled = fixture.nativeElement as HTMLElement;
    const enterpriseTier = compiled.querySelectorAll('.tier-card')[3];
    expect(enterpriseTier.querySelector('.tier-name')?.textContent).toContain('Enterprise');
    expect(enterpriseTier.querySelector('.price-amount')?.textContent).toContain('Custom');
  });

  it('should mark Per Certificate as most popular', () => {
    const compiled = fixture.nativeElement as HTMLElement;
    const popularBadge = compiled.querySelector('.popular-badge');
    expect(popularBadge).toBeTruthy();
    expect(popularBadge?.textContent).toContain('Most Popular');
  });

  it('should render FAQ section', () => {
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('.pricing-faq')).toBeTruthy();
    expect(compiled.querySelectorAll('.faq-item').length).toBeGreaterThan(0);
  });
});
