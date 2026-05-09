import { Routes } from '@angular/router';
import { NotFoundComponent } from './core/not-found/not-found.component';
import { SignedOutComponent } from './core/signed-out/signed-out.component';
import { CertificationListComponent } from './certification/certification-list.component';
import { authGuard } from './core/auth.guard';

export const routes: Routes = [
  { path: '',                               component: CertificationListComponent },
  { path: 'certifications',               component: CertificationListComponent },
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
