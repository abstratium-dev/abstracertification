import { TestBed } from '@angular/core/testing';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { provideHttpClient } from '@angular/common/http';
import { Controller } from './controller';
import { ModelService } from './model.service';

describe('Controller', () => {
  let controller: Controller;
  let modelService: ModelService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting()
      ]
    });
    controller = TestBed.inject(Controller);
    modelService = TestBed.inject(ModelService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpMock.verify();
  });

  it('should be created', () => {
    expect(controller).toBeTruthy();
  });

  describe('loadConfig', () => {
    it('should load config and update model service', async () => {
      const mockConfig = { logLevel: 'INFO', provideAiHelp: false };

      const configPromise = controller.loadConfig();

      const req = httpMock.expectOne('/public/config');
      expect(req.request.method).toBe('GET');
      req.flush(mockConfig);

      const result = await configPromise;
      expect(result).toEqual(mockConfig);
      expect(modelService.config$()).toEqual(mockConfig);
    });

    it('should throw error on failed config load', async () => {
      const configPromise = controller.loadConfig();

      const req = httpMock.expectOne('/public/config');
      req.error(new ProgressEvent('error'), { status: 500, statusText: 'Server Error' });

      await expectAsync(configPromise).toBeRejected();
    });

    it('should log errors to console', async () => {
      spyOn(console, 'error');

      const configPromise = controller.loadConfig();

      const req = httpMock.expectOne('/public/config');
      req.error(new ProgressEvent('error'));

      try {
        await configPromise;
      } catch (e) {
        // Expected
      }

      expect(console.error).toHaveBeenCalledWith('Error loading config:', jasmine.any(Object));
    });
  });
});
