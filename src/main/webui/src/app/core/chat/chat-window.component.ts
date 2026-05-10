import { Component, Input, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { MarkdownModule } from 'ngx-markdown';

export interface ChatMessage {
  role: 'user' | 'assistant';
  content: string;
  timestamp: Date;
}

@Component({
  selector: 'app-chat-window',
  standalone: true,
  imports: [CommonModule, FormsModule, MarkdownModule],
  template: `
    <div class="chat-window" [class.collapsed]="isCollapsed">
      <div class="chat-header" (click)="toggleCollapse()">
        <h4>💬 AI Assistant</h4>
        <button class="toggle-btn" type="button">
          <span [class.rotated]="!isCollapsed">▼</span>
        </button>
      </div>
      
      <div class="chat-content" *ngIf="!isCollapsed">
        <div class="chat-messages" #messagesContainer>
          <div 
            *ngFor="let message of messages" 
            class="message"
            [class.user-message]="message.role === 'user'"
            [class.assistant-message]="message.role === 'assistant'">
            <div class="message-content">
              <!-- Render markdown for assistant messages, plain text for user messages -->
              <div *ngIf="message.role === 'user'" class="user-text">{{ message.content }}</div>
              
              <!-- For assistant messages: render plain text during streaming, markdown when complete -->
              <div *ngIf="message.role === 'assistant'" 
                   class="assistant-content">
                <!-- Show plain text with pre-wrap during streaming or last message -->
                <div *ngIf="isStreamingMessage(message)" 
                     class="streaming-text">{{ message.content }}</div>
                <!-- Show proper markdown for completed messages -->
                <markdown *ngIf="!isStreamingMessage(message)" 
                          [data]="message.content" 
                          class="assistant-markdown"></markdown>
              </div>
            </div>
            <div class="message-time">{{ formatTime(message.timestamp) }}</div>
          </div>
          
          <div *ngIf="isLoading" class="message assistant-message">
            <div class="message-content">
              <span class="typing-indicator">Thinking...</span>
            </div>
          </div>
        </div>
        
        <div class="chat-input">
          <textarea
            [(ngModel)]="currentMessage"
            (keydown.enter)="handleEnterKey($event)"
            placeholder="Ask me anything about this step..."
            rows="3"
            [disabled]="isLoading">
          </textarea>
          <div class="chat-actions">
            <button
              class="btn-secondary btn-small"
              (click)="clearChat()"
              [disabled]="isLoading || messages.length === 0">
              Clear
            </button>
            <button
              class="btn-primary btn-small"
              (click)="sendMessage()"
              [disabled]="!currentMessage.trim() || isLoading">
              {{ isLoading ? 'Sending...' : 'Send' }}
            </button>
          </div>
        </div>
      </div>
    </div>
  `,
  styleUrls: ['./chat-window.component.scss']
})
export class ChatWindowComponent {
  @Input() certificationId: string = '';
  @Input() pageId: string = '';
  @Input() messages: ChatMessage[] = [];
  @Input() isLoading: boolean = false;
  
  // Track which messages are currently streaming
  streamingMessageIds: Set<string> = new Set();
  
  @Output() sendMessageEvent = new EventEmitter<{message: string, history: ChatMessage[]}>();
  @Output() clearChatEvent = new EventEmitter<void>();

  currentMessage: string = '';
  isCollapsed: boolean = false;

  toggleCollapse(): void {
    this.isCollapsed = !this.isCollapsed;
  }

  sendMessage(): void {
    if (this.currentMessage.trim() && !this.isLoading) {
      const messageHistory = [...this.messages];
      this.sendMessageEvent.emit({
        message: this.currentMessage.trim(),
        history: messageHistory
      });
      this.currentMessage = '';
    }
  }

  clearChat(): void {
    this.clearChatEvent.emit();
  }

  handleEnterKey(event: Event): void {
    const keyboardEvent = event as KeyboardEvent;
    if (keyboardEvent.key === 'Enter' && !keyboardEvent.shiftKey) {
      keyboardEvent.preventDefault();
      this.sendMessage();
    }
  }

  formatTime(date: Date): string {
    return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
  }

  isStreamingMessage(message: ChatMessage): boolean {
    // The last assistant message is considered streaming if loading is active
    if (message.role !== 'assistant') {
      return false;
    }
    
    // Check if this is the last assistant message and loading is active
    const lastAssistantMessage = [...this.messages]
      .reverse()
      .find(msg => msg.role === 'assistant');
    
    return lastAssistantMessage === message && this.isLoading;
  }

  scrollToBottom(): void {
    setTimeout(() => {
      const container = document.querySelector('.chat-messages');
      if (container) {
        container.scrollTop = container.scrollHeight;
      }
    }, 100);
  }
}
