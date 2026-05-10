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
      service.setConfig({ logLevel: 'INFO', provideAiHelp: false });
      expect(service.config$()).toEqual({ logLevel: 'INFO', provideAiHelp: false });
    });

    it('should update config', () => {
      service.setConfig({ logLevel: 'INFO', provideAiHelp: false });
      expect(service.config$()).toEqual({ logLevel: 'INFO', provideAiHelp: false });

      service.setConfig({ logLevel: 'DEBUG', provideAiHelp: true });
      expect(service.config$()).toEqual({ logLevel: 'DEBUG', provideAiHelp: true });
    });
  });

  describe('Signal Reactivity', () => {
    it('should emit signal updates for config', () => {
      service.setConfig({ logLevel: 'WARN', provideAiHelp: false });
      expect(service.config$()).toEqual({ logLevel: 'WARN', provideAiHelp: false });

      service.setConfig({ logLevel: 'ERROR', provideAiHelp: false });
      expect(service.config$()).toEqual({ logLevel: 'ERROR', provideAiHelp: false });
    });
  });

  describe('Service Singleton', () => {
    it('should be a singleton across injections', () => {
      const service2 = TestBed.inject(ModelService);
      service.setConfig({ logLevel: 'TRACE', provideAiHelp: false });
      expect(service2.config$()).toEqual({ logLevel: 'TRACE', provideAiHelp: false });
    });
  });
});
