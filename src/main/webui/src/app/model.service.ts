import { Injectable, signal, Signal } from '@angular/core';

export interface Config {
  logLevel: string;
  provideAiHelp: boolean;
  warningMessage: string;
}

@Injectable({
  providedIn: 'root',
})
export class ModelService {

  private config = signal<Config | null>(null);
  private warningMessage = signal<string>('');

  config$: Signal<Config | null> = this.config.asReadonly();
  warningMessage$: Signal<string> = this.warningMessage.asReadonly();

  setConfig(config: Config) {
    this.config.set(config);
    if (config.warningMessage === '-') {
      this.warningMessage.set('');
    } else {
      this.warningMessage.set(config.warningMessage || '');
    }
  }
}
