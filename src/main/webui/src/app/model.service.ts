import { Injectable, signal, Signal } from '@angular/core';

export interface Config {
  logLevel: string;
  provideAiHelp: boolean;
}

@Injectable({
  providedIn: 'root',
})
export class ModelService {

  private config = signal<Config | null>(null);

  config$: Signal<Config | null> = this.config.asReadonly();

  setConfig(config: Config) {
    this.config.set(config);
  }
}
