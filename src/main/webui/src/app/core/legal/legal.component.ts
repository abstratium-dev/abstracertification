import { Component } from '@angular/core';

@Component({
  selector: 'app-legal',
  standalone: true,
  imports: [],
  templateUrl: './legal.component.html',
  styleUrl: './legal.component.scss'
})
export class LegalComponent {
  readonly foundingYear = 2026;
  readonly currentYear = new Date().getFullYear();
  readonly copyrightYears = this.currentYear > this.foundingYear
    ? `${this.foundingYear}–${this.currentYear}`
    : `${this.foundingYear}`;
}
