import { Routes } from '@angular/router';
import { NotFoundComponent } from './core/not-found/not-found.component';
import { SignedOutComponent } from './core/signed-out/signed-out.component';
import { CertificationListComponent } from './certification/certification-list.component';
import { CertificationWizardComponent } from './certification/certification-wizard.component';

export const routes: Routes = [
  { path: '',                              component: CertificationListComponent },
  { path: 'certifications',                component: CertificationListComponent },
  { path: 'certification/:certificationId', component: CertificationWizardComponent },
  { path: 'signed-out',                    component: SignedOutComponent },
  { path: '**',                            component: NotFoundComponent }
];
