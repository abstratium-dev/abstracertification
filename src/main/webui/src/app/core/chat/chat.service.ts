import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError, map } from 'rxjs/operators';

export interface ChatMessage {
  role: 'user' | 'assistant';
  content: string;
  timestamp: Date;
}

export interface ChatRequest {
  message: string;
  certificationId: string;
  pageId: string;
  sessionId: string;
  history: ChatMessage[];
}

export interface ChatResponse {
  response: string;
}

@Injectable({
  providedIn: 'root'
})
export class ChatService {
  private readonly baseUrl = '/public';

  constructor(private http: HttpClient) {}

  sendMessage(request: ChatRequest): Observable<string> {
    return new Observable<string>(observer => {
      const url = `${this.baseUrl}/certifications/${request.certificationId}/chat`;
      
      // Send the request and handle SSE streaming
      fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'text/event-stream'
        },
        body: JSON.stringify(request)
      }).then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        // Read the SSE stream from langchain4j Multi<String>
        const reader = response.body?.getReader();
        const decoder = new TextDecoder();
        
        if (!reader) {
          throw new Error('Response body is not readable');
        }
        
        let buffer = '';
        
        function readStream(): Promise<void> {
          return reader!.read().then(({ done, value }) => {
            if (done) {
              observer.complete();
              return;
            }
            
            buffer += decoder.decode(value, { stream: true });
            
            // Process SSE data - langchain4j sends each token as a separate line
            const lines = buffer.split('\n');
            buffer = lines.pop() || ''; // Keep incomplete line in buffer
            
            for (const line of lines) {
              const trimmedLine = line.trim();
              if (trimmedLine.startsWith('data: ')) {
                const data = trimmedLine.slice(6); // Remove 'data: ' prefix
                if (data.startsWith('[ERROR]')) {
                  observer.error(new Error(data.slice(7))); // Remove '[ERROR] ' prefix
                  return;
                } else {
                  // JSON-decode the token to restore embedded newlines/special chars
                  try {
                    const token = JSON.parse(data);
                    observer.next(token);
                  } catch {
                    observer.next(data);
                  }
                }
              } else if (trimmedLine && !trimmedLine.startsWith(':')) {
                // langchain4j Multi<String> sends raw tokens, not wrapped in "data: "
                observer.next(line);
              }
            }
            
            return readStream();
          });
        }
        
        return readStream();
        
      }).catch(error => {
        observer.error(error);
      });
      
      // Cleanup function
      return () => {
        // No cleanup needed for fetch-based approach
      };
    });
  }

  private handleError(error: HttpErrorResponse): Observable<never> {
    let errorMessage = 'An error occurred while sending your message.';
    
    if (error.error instanceof ErrorEvent) {
      // Client-side error
      errorMessage = `Client error: ${error.error.message}`;
    } else {
      // Server-side error
      switch (error.status) {
        case 400:
          errorMessage = 'Invalid request. Please check your message and try again.';
          break;
        case 404:
          errorMessage = 'Certification not found. Please refresh the page and try again.';
          break;
        case 500:
          errorMessage = 'Server error. Please try again later.';
          break;
        default:
          errorMessage = `Server error: ${error.status} - ${error.message}`;
      }
    }
    
    console.error('Chat service error:', error);
    return throwError(() => errorMessage);
  }

  generateSessionId(): string {
    return 'session_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
  }
}
