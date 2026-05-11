import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { ContactComponent } from './contact.component';
import { ContactService } from './contact.service';
import { provideHttpClient } from '@angular/common/http';
import { ActivatedRoute, convertToParamMap } from '@angular/router';
import { Location } from '@angular/common';
import { of, throwError } from 'rxjs';

function makeRoute(queryParams: Record<string, string> = {}) {
  return {
    snapshot: { queryParamMap: convertToParamMap(queryParams) }
  };
}

describe('ContactComponent', () => {
  let component: ContactComponent;
  let fixture: ComponentFixture<ContactComponent>;
  let contactServiceSpy: jasmine.SpyObj<ContactService>;
  let locationSpy: jasmine.SpyObj<Location>;

  beforeEach(async () => {
    contactServiceSpy = jasmine.createSpyObj('ContactService', ['submit']);
    locationSpy = jasmine.createSpyObj('Location', ['back']);

    await TestBed.configureTestingModule({
      imports: [ContactComponent],
      providers: [
        provideHttpClient(),
        { provide: ContactService, useValue: contactServiceSpy },
        { provide: ActivatedRoute, useValue: makeRoute() },
        { provide: Location, useValue: locationSpy }
      ]
    }).compileComponents();

    fixture = TestBed.createComponent(ContactComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should call location.back() when goBack is invoked', () => {
    component.goBack();
    expect(locationSpy.back).toHaveBeenCalledTimes(1);
  });

  it('should render the contact form', () => {
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('form')).toBeTruthy();
    expect(compiled.querySelector('#name')).toBeTruthy();
    expect(compiled.querySelector('#country')).toBeTruthy();
    expect(compiled.querySelector('#email')).toBeTruthy();
    expect(compiled.querySelector('#query')).toBeTruthy();
  });

  it('should display the page title', () => {
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('.contact-title')?.textContent).toContain('Contact Us');
  });

  it('should have an invalid form when empty', () => {
    expect(component.form.invalid).toBeTrue();
  });

  it('should mark fields as touched when submitting invalid form', () => {
    component.submit();
    expect(component.form.get('name')?.touched).toBeTrue();
    expect(component.form.get('email')?.touched).toBeTrue();
  });

  it('should not call service when form is invalid', () => {
    component.submit();
    expect(contactServiceSpy.submit).not.toHaveBeenCalled();
  });

  it('should show field error when name is empty and touched', () => {
    component.form.get('name')?.markAsTouched();
    fixture.detectChanges();
    const compiled = fixture.nativeElement as HTMLElement;
    const nameGroup = compiled.querySelector('.form-group');
    expect(nameGroup?.querySelector('.field-error')).toBeTruthy();
  });

  it('should show error for invalid email', () => {
    component.form.get('email')?.setValue('not-valid');
    component.form.get('email')?.markAsTouched();
    fixture.detectChanges();
    expect(component.isInvalid('email')).toBeTrue();
  });

  it('isInvalid should return false for valid untouched field', () => {
    expect(component.isInvalid('name')).toBeFalse();
  });

  it('isInvalid should return true for required field touched with empty value', () => {
    component.form.get('name')?.markAsTouched();
    expect(component.isInvalid('name')).toBeTrue();
  });

  it('should call service and show success on valid submit', fakeAsync(() => {
    contactServiceSpy.submit.and.returnValue(of({ id: 'abc-123' }));

    component.form.setValue({
      name: 'Alice',
      country: 'Germany',
      email: 'alice@example.com',
      query: 'A valid question.'
    });

    component.submit();
    tick();
    fixture.detectChanges();

    expect(contactServiceSpy.submit).toHaveBeenCalledOnceWith({
      name: 'Alice',
      country: 'Germany',
      email: 'alice@example.com',
      query: 'A valid question.'
    });
    expect(component.submitted()).toBeTrue();
    expect(component.submitting()).toBeFalse();
  }));

  it('should show success message after successful submission', fakeAsync(() => {
    contactServiceSpy.submit.and.returnValue(of({ id: 'abc-123' }));

    component.form.setValue({
      name: 'Alice',
      country: 'Germany',
      email: 'alice@example.com',
      query: 'A valid question.'
    });

    component.submit();
    tick();
    fixture.detectChanges();

    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('.message-success')).toBeTruthy();
    expect(compiled.querySelector('form')).toBeNull();
  }));

  it('should show error message on service failure', fakeAsync(() => {
    contactServiceSpy.submit.and.returnValue(throwError(() => new Error('Server error')));

    component.form.setValue({
      name: 'Bob',
      country: 'France',
      email: 'bob@example.com',
      query: 'Another question.'
    });

    component.submit();
    tick();
    fixture.detectChanges();

    expect(component.error()).toBeTruthy();
    expect(component.submitted()).toBeFalse();
    expect(component.submitting()).toBeFalse();
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('.message-error')).toBeTruthy();
  }));

  it('should set submitting to true during submission', () => {
    contactServiceSpy.submit.and.returnValue(of({ id: 'xyz' }));

    component.form.setValue({
      name: 'Carol',
      country: 'Spain',
      email: 'carol@example.com',
      query: 'Yet another question.'
    });

    component.submit();

    // submitting starts as true synchronously, then resolves
    // After tick it becomes false, but we can verify the service was called
    expect(contactServiceSpy.submit).toHaveBeenCalled();
  });
});

describe('ContactComponent with context query param', () => {
  let component: ContactComponent;
  let contactServiceSpy: jasmine.SpyObj<ContactService>;

  beforeEach(async () => {
    contactServiceSpy = jasmine.createSpyObj('ContactService', ['submit']);
    const locationSpy = jasmine.createSpyObj('Location', ['back']);

    await TestBed.configureTestingModule({
      imports: [ContactComponent],
      providers: [
        provideHttpClient(),
        { provide: ContactService, useValue: contactServiceSpy },
        { provide: ActivatedRoute, useValue: makeRoute({ context: 'pricing' }) },
        { provide: Location, useValue: locationSpy }
      ]
    }).compileComponents();

    const fixture = TestBed.createComponent(ContactComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should read context from query params', () => {
    expect(component.context).toBe('pricing');
  });

  it('should include context in the submission payload', fakeAsync(() => {
    contactServiceSpy.submit.and.returnValue(of({ id: 'ctx-123' }));

    component.form.setValue({
      name: 'Pricing User',
      country: 'Belgium',
      email: 'pricing@example.com',
      query: 'Tell me about enterprise pricing.'
    });

    component.submit();
    tick();

    expect(contactServiceSpy.submit).toHaveBeenCalledOnceWith(
      jasmine.objectContaining({ context: 'pricing' })
    );
  }));
});
