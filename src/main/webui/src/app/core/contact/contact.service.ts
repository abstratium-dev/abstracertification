import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface ContactRequest {
  name: string;
  country: string;
  email: string;
  query: string;
  context?: string;
}

export interface ContactResponse {
  id: string;
}

@Injectable({
  providedIn: 'root'
})
export class ContactService {
  private http = inject(HttpClient);

  submit(request: ContactRequest): Observable<ContactResponse> {
    return this.http.post<ContactResponse>('/public/contact', request);
  }
}
