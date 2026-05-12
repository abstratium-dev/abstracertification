import { Routes } from '@angular/router';
import { NotFoundComponent } from './core/not-found/not-found.component';
import { SignedOutComponent } from './core/signed-out/signed-out.component';
import { WelcomeComponent } from './core/welcome/welcome.component';
import { authGuard } from './core/auth.guard';

export const routes: Routes = [
  { path: '',                             component: WelcomeComponent },
  {
    path: 'pricing',
    loadComponent: () => import('./core/pricing/pricing.component').then(m => m.PricingComponent)
  },
  {
    path: 'contact',
    loadComponent: () => import('./core/contact/contact.component').then(m => m.ContactComponent)
  },
  {
    path: 'legal',
    loadComponent: () => import('./core/legal/legal.component').then(m => m.LegalComponent)
  },
  {
    path: 'certifications',
    loadComponent: () => import('./certification/certification-list.component').then(m => m.CertificationListComponent)
  },
  {
    path: 'certification/:certificationId',
    loadComponent: () => import('./certification/certification-wizard.component').then(m => m.CertificationWizardComponent)
  },
  {
    path: 'certification/:certificationId/page/:page',
    loadComponent: () => import('./certification/certification-wizard.component').then(m => m.CertificationWizardComponent)
  },
  {
    path: 'certification/:certificationId/overview',
    loadComponent: () => import('./certification/certification-overview.component').then(m => m.CertificationOverviewComponent)
  },
  { path: 'signed-out',                   component: SignedOutComponent },
  { path: '**',                           component: NotFoundComponent }
];
