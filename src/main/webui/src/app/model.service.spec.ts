import { TestBed } from '@angular/core/testing';
import { Config, ModelService } from './model.service';

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
      service.setConfig({ logLevel: 'INFO', provideAiHelp: false, warningMessage: '-', warningBgColor: '#fff3cd', brandLogoUrl: '', brandLogoAlt: '', brandName: '' });
      expect(service.config$()).toEqual({ logLevel: 'INFO', provideAiHelp: false, warningMessage: '-', warningBgColor: '#fff3cd', brandLogoUrl: '', brandLogoAlt: '', brandName: '' });
    });

    it('should update config', () => {
      service.setConfig({ logLevel: 'INFO', provideAiHelp: false, warningMessage: '-', warningBgColor: '#fff3cd', brandLogoUrl: '', brandLogoAlt: '', brandName: '' });
      expect(service.config$()).toEqual({ logLevel: 'INFO', provideAiHelp: false, warningMessage: '-', warningBgColor: '#fff3cd', brandLogoUrl: '', brandLogoAlt: '', brandName: '' });

      service.setConfig({ logLevel: 'DEBUG', provideAiHelp: true, warningMessage: 'Test warning', warningBgColor: '#fff3cd', brandLogoUrl: '', brandLogoAlt: '', brandName: '' });
      expect(service.config$()).toEqual({ logLevel: 'DEBUG', provideAiHelp: true, warningMessage: 'Test warning', warningBgColor: '#fff3cd', brandLogoUrl: '', brandLogoAlt: '', brandName: '' });
    });
  });

  describe('Signal Reactivity', () => {
    it('should emit signal updates for config', () => {
      service.setConfig({ logLevel: 'WARN', provideAiHelp: false, warningMessage: '-', warningBgColor: '#fff3cd', brandLogoUrl: '', brandLogoAlt: '', brandName: '' });
      expect(service.config$()).toEqual({ logLevel: 'WARN', provideAiHelp: false, warningMessage: '-', warningBgColor: '#fff3cd', brandLogoUrl: '', brandLogoAlt: '', brandName: '' });

      service.setConfig({ logLevel: 'ERROR', provideAiHelp: false, warningMessage: 'Error state', warningBgColor: '#fff3cd', brandLogoUrl: '', brandLogoAlt: '', brandName: '' });
      expect(service.config$()).toEqual({ logLevel: 'ERROR', provideAiHelp: false, warningMessage: 'Error state', warningBgColor: '#fff3cd', brandLogoUrl: '', brandLogoAlt: '', brandName: '' });
    });
  });

  describe('Service Singleton', () => {
    it('should be a singleton across injections', () => {
      const service2 = TestBed.inject(ModelService);
      service.setConfig({ logLevel: 'TRACE', provideAiHelp: false, warningMessage: '-', warningBgColor: '#fff3cd', brandLogoUrl: '', brandLogoAlt: '', brandName: '' });
      expect(service2.config$()).toEqual({ logLevel: 'TRACE', provideAiHelp: false, warningMessage: '-', warningBgColor: '#fff3cd', brandLogoUrl: '', brandLogoAlt: '', brandName: '' });
    });
  });

  describe('Config Management', () => {
    it('should set warningMessage from config', () => {
      const config: Config = { logLevel: 'INFO', provideAiHelp: false, warningMessage: 'Test warning', warningBgColor: '#fff3cd', brandLogoUrl: 'https://example.com/logo.png', brandLogoAlt: 'Logo', brandName: 'Example' };
      service.setConfig(config);
      expect(service.warningMessage$()).toBe('Test warning');
    });

    it('should clear warningMessage when config value is "-"', () => {
      const config: Config = { logLevel: 'INFO', provideAiHelp: false, warningMessage: '-', warningBgColor: '#fff3cd', brandLogoUrl: 'https://example.com/logo.png', brandLogoAlt: 'Logo', brandName: 'Example' };
      service.setConfig(config);
      expect(service.warningMessage$()).toBe('');
    });

    it('should default warningBgColor to #fff3cd initially', () => {
      expect(service.warningBgColor$()).toBe('#fff3cd');
    });

    it('should set warningBgColor from config', () => {
      const config: Config = { logLevel: 'INFO', provideAiHelp: false, warningMessage: 'alert', warningBgColor: '#ff0000', brandLogoUrl: 'https://example.com/logo.png', brandLogoAlt: 'Logo', brandName: 'Example' };
      service.setConfig(config);
      expect(service.warningBgColor$()).toBe('#ff0000');
    });

    it('should set warningBgColor to empty string when config value is empty', () => {
      const config: Config = { logLevel: 'INFO', provideAiHelp: false, warningMessage: 'alert', warningBgColor: '', brandLogoUrl: 'https://example.com/logo.png', brandLogoAlt: 'Logo', brandName: 'Example' };
      service.setConfig(config);
      expect(service.warningBgColor$()).toBe('');
    });

    it('should update warningBgColor when config changes', () => {
      service.setConfig({ logLevel: 'INFO', provideAiHelp: false, warningMessage: 'a', warningBgColor: '#aabbcc', brandLogoUrl: 'https://example.com/logo.png', brandLogoAlt: 'Logo', brandName: 'Example' });
      expect(service.warningBgColor$()).toBe('#aabbcc');
      service.setConfig({ logLevel: 'INFO', provideAiHelp: false, warningMessage: 'b', warningBgColor: '#112233', brandLogoUrl: 'https://example.com/logo.png', brandLogoAlt: 'Logo', brandName: 'Example' });
      expect(service.warningBgColor$()).toBe('#112233');
    });

    it('should have default brand values initially', () => {
      expect(service.brandLogoUrl$()).toBe('https://abstratium.dev/abstratium-logo-small.png');
      expect(service.brandLogoAlt$()).toBe('Abstratium Logo');
      expect(service.brandName$()).toBe('ABSTRATIUM');
    });

    it('should set brand values from config', () => {
      const config: Config = { logLevel: 'INFO', provideAiHelp: false, warningMessage: '', warningBgColor: '#fff3cd', brandLogoUrl: 'https://my.app/logo.svg', brandLogoAlt: 'My App', brandName: 'My App' };
      service.setConfig(config);
      expect(service.brandLogoUrl$()).toBe('https://my.app/logo.svg');
      expect(service.brandLogoAlt$()).toBe('My App');
      expect(service.brandName$()).toBe('My App');
    });

    it('should fall back to defaults when brand fields are empty strings', () => {
      const config: Config = { logLevel: 'INFO', provideAiHelp: false, warningMessage: '', warningBgColor: '#fff3cd', brandLogoUrl: '', brandLogoAlt: '', brandName: '' };
      service.setConfig(config);
      expect(service.brandLogoUrl$()).toBe('https://abstratium.dev/abstratium-logo-small.png');
      expect(service.brandLogoAlt$()).toBe('Abstratium Logo');
      expect(service.brandName$()).toBe('ABSTRATIUM');
    });
  });
});
