import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { Config, ModelService } from './model.service';

@Injectable({
  providedIn: 'root',
})
export class Controller {

  private modelService = inject(ModelService);
  private http = inject(HttpClient);

  async triggerError(): Promise<void> {
    try {
      await firstValueFrom(
        this.http.get<void>('/api/demo/error')
      );
    } catch (error) {
      console.error('Error response:', error);
      throw error;
    }
  }

  async loadConfig(): Promise<Config> {
    try {
      const config = await firstValueFrom(
        this.http.get<Config>('/public/config')
      );
      this.modelService.setConfig(config);
      return config;
    } catch (error) {
      console.error('Error loading config:', error);
      throw error;
    }
  }
}
