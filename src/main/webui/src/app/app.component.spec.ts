import { TestBed } from '@angular/core/testing';
import { provideRouter } from '@angular/router';
import { signal } from '@angular/core';
import { AuthService, ANONYMOUS } from './core/auth.service';
import { ThemeService } from './core/theme.service';
import { ToastService } from './core/toast/toast.service';
import { ConfirmDialogService } from './core/confirm-dialog/confirm-dialog.service';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';
import { AppComponent } from './app.component';
import { WINDOW } from './core/window.token';

describe('AppComponent', () => {
  let mockAuthService: jasmine.SpyObj<AuthService>;
  let mockThemeService: Partial<ThemeService>;
  let mockToastService: Partial<ToastService>;
  let mockConfirmDialogService: Partial<ConfirmDialogService>;

  beforeEach(async () => {
    mockAuthService = jasmine.createSpyObj('AuthService', ['signout'], {
      token$: signal(ANONYMOUS)
    });
    mockThemeService = {
      theme$: signal('light'),
      toggleTheme: jasmine.createSpy('toggleTheme')
    };
    mockToastService = {
      toasts$: signal([]),
      show: jasmine.createSpy('show'),
      success: jasmine.createSpy('success'),
      error: jasmine.createSpy('error'),
      info: jasmine.createSpy('info'),
      remove: jasmine.createSpy('remove'),
      clear: jasmine.createSpy('clear')
    };
    mockConfirmDialogService = {
      state$: signal({ isOpen: false, config: null, resolve: null }),
      confirm: jasmine.createSpy('confirm'),
      handleConfirm: jasmine.createSpy('handleConfirm'),
      handleCancel: jasmine.createSpy('handleCancel')
    };

    await TestBed.configureTestingModule({
      imports: [AppComponent],
      providers: [
        provideRouter([]),
        { provide: AuthService, useValue: mockAuthService },
        { provide: ThemeService, useValue: mockThemeService },
        { provide: ToastService, useValue: mockToastService },
        { provide: ConfirmDialogService, useValue: mockConfirmDialogService },
        provideHttpClient(),
        provideHttpClientTesting(),
        { provide: WINDOW, useValue: window }
      ]
    }).compileComponents();
  });

  it('should create the app', () => {
    const fixture = TestBed.createComponent(AppComponent);
    const app = fixture.componentInstance;
    expect(app).toBeTruthy();
  });

  it(`should have the 'abstrafication' title`, () => {
    const fixture = TestBed.createComponent(AppComponent);
    const app = fixture.componentInstance;
    expect(app.title).toEqual('abstrafication');
  });

  it('should render router outlet', () => {
    const fixture = TestBed.createComponent(AppComponent);
    fixture.detectChanges();
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('router-outlet')).toBeTruthy();
  });
});
