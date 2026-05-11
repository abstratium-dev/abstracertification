import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';
import { ContactService, ContactRequest, ContactResponse } from './contact.service';

describe('ContactService', () => {
  let service: ContactService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
        ContactService
      ]
    });
    service = TestBed.inject(ContactService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpMock.verify();
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should POST to /public/contact and return id', () => {
    const request: ContactRequest = {
      name: 'Test User',
      country: 'Portugal',
      email: 'test@example.com',
      query: 'How do I get started?'
    };
    const mockResponse: ContactResponse = { id: 'some-uuid-123' };

    let result: ContactResponse | undefined;
    service.submit(request).subscribe(res => result = res);

    const req = httpMock.expectOne('/public/contact');
    expect(req.request.method).toBe('POST');
    expect(req.request.body).toEqual(request);
    req.flush(mockResponse);

    expect(result).toEqual(mockResponse);
  });

  it('should propagate HTTP errors', () => {
    const request: ContactRequest = {
      name: 'Error User',
      country: 'Italy',
      email: 'err@example.com',
      query: 'This will fail.'
    };

    let errorOccurred = false;
    service.submit(request).subscribe({
      error: () => errorOccurred = true
    });

    const req = httpMock.expectOne('/public/contact');
    req.flush('Server Error', { status: 500, statusText: 'Internal Server Error' });

    expect(errorOccurred).toBeTrue();
  });
});
