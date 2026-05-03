import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { CertificationModule } from './certification.model';

@Injectable({ providedIn: 'root' })
export class CertificationService {

  constructor(private http: HttpClient) {}

  loadModule(moduleId: string): Observable<CertificationModule> {
    return this.http.get<CertificationModule>(`certifications/${moduleId}.json`);
  }
}
