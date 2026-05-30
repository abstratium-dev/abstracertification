import { ComponentFixture, TestBed } from '@angular/core/testing';
import { signal } from '@angular/core';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting, HttpTestingController } from '@angular/common/http/testing';
import { provideRouter } from '@angular/router';

import { HeaderComponent } from './header.component';
import { AuthService, ANONYMOUS } from '../core/auth.service';
import { ThemeService } from '../core/theme.service';

describe('HeaderComponent', () => {
  let component: HeaderComponent;
  let fixture: ComponentFixture<HeaderComponent>;
  let mockAuthService: jasmine.SpyObj<AuthService>;
  let mockThemeService: Partial<ThemeService>;

  beforeEach(async () => {
    mockAuthService = jasmine.createSpyObj('AuthService', ['signOut'], {
      token$: signal(ANONYMOUS),
      sessionFraction$: signal(0),
      sessionMinutesRemaining$: signal(0)
    });
    mockThemeService = {
      theme$: signal('light'),
      toggleTheme: jasmine.createSpy('toggleTheme')
    };

    await TestBed.configureTestingModule({
      imports: [HeaderComponent],
      providers: [
        provideRouter([]),
        { provide: AuthService, useValue: mockAuthService },
        { provide: ThemeService, useValue: mockThemeService },
        provideHttpClient(),
        provideHttpClientTesting(),
        provideRouter([])
      ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(HeaderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should call signout when signout button is clicked', () => {
    component.signOut();
    expect(mockAuthService.signOut).toHaveBeenCalled();
  });

  it('should call toggleTheme when theme button is clicked', () => {
    component.toggleTheme();
    expect(mockThemeService.toggleTheme).toHaveBeenCalled();
  });
});
