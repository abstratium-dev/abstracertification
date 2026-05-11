import { Component, inject, signal } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { Location } from '@angular/common';
import { ContactService } from './contact.service';

@Component({
  selector: 'app-contact',
  standalone: true,
  imports: [ReactiveFormsModule],
  templateUrl: './contact.component.html',
  styleUrl: './contact.component.scss'
})
export class ContactComponent {
  private fb = inject(FormBuilder);
  private contactService = inject(ContactService);
  private route = inject(ActivatedRoute);
  private location = inject(Location);

  readonly context: string | null = this.route.snapshot.queryParamMap.get('context');

  form: FormGroup = this.fb.group({
    name:    ['', [Validators.required, Validators.maxLength(255)]],
    country: ['', [Validators.required, Validators.maxLength(100)]],
    email:   ['', [Validators.required, Validators.email, Validators.maxLength(255)]],
    query:   ['', [Validators.required, Validators.maxLength(5000)]]
  });

  submitting = signal(false);
  submitted = signal(false);
  error = signal<string | null>(null);

  submit(): void {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    this.submitting.set(true);
    this.error.set(null);

    const payload = { ...this.form.value, ...(this.context ? { context: this.context } : {}) };
    this.contactService.submit(payload).subscribe({
      next: () => {
        this.submitted.set(true);
        this.submitting.set(false);
      },
      error: () => {
        this.error.set('Something went wrong. Please try again later.');
        this.submitting.set(false);
      }
    });
  }

  isInvalid(field: string): boolean {
    const control = this.form.get(field);
    return !!(control && control.invalid && control.touched);
  }

  goBack(): void {
    this.location.back();
  }
}
