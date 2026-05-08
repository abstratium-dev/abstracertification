import { TestBed } from '@angular/core/testing';
import { ModelService } from './model.service';

describe('ModelService', () => {
  let service: ModelService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ModelService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  describe('Initial State', () => {
    it('should have no config initially', () => {
      expect(service.config$()).toBeNull();
    });
  });

  describe('Config Management', () => {
    it('should set config', () => {
      service.setConfig({ logLevel: 'INFO' });
      expect(service.config$()).toEqual({ logLevel: 'INFO' });
    });

    it('should update config', () => {
      service.setConfig({ logLevel: 'INFO' });
      expect(service.config$()).toEqual({ logLevel: 'INFO' });

      service.setConfig({ logLevel: 'DEBUG' });
      expect(service.config$()).toEqual({ logLevel: 'DEBUG' });
    });
  });

  describe('Signal Reactivity', () => {
    it('should emit signal updates for config', () => {
      service.setConfig({ logLevel: 'WARN' });
      expect(service.config$()).toEqual({ logLevel: 'WARN' });

      service.setConfig({ logLevel: 'ERROR' });
      expect(service.config$()).toEqual({ logLevel: 'ERROR' });
    });
  });

  describe('Service Singleton', () => {
    it('should be a singleton across injections', () => {
      const service2 = TestBed.inject(ModelService);
      service.setConfig({ logLevel: 'TRACE' });
      expect(service2.config$()).toEqual({ logLevel: 'TRACE' });
    });
  });
});
