import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { ModelService } from './model.service';

@Injectable({
  providedIn: 'root',
})
export class Controller {

  private modelService = inject(ModelService);
  private http = inject(HttpClient);

  async loadConfig(): Promise<{logLevel: string}> {
    try {
      const config = await firstValueFrom(
        this.http.get<{logLevel: string}>('/public/config')
      );
      this.modelService.setConfig(config);
      return config;
    } catch (error) {
      console.error('Error loading config:', error);
      throw error;
    }
  }
}
