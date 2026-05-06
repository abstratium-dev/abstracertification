import { Routes } from '@angular/router';
import { NotFoundComponent } from './core/not-found/not-found.component';
import { SignedOutComponent } from './core/signed-out/signed-out.component';
import { WizardComponent } from './core/wizard/wizard.component';
import { ModuleListComponent } from './core/wizard/module-list.component';

export const routes: Routes = [
  { path: '',                   component: ModuleListComponent },
  { path: 'certifications',     component: ModuleListComponent },
  { path: 'certification/:moduleId', component: WizardComponent },
  { path: 'signed-out',         component: SignedOutComponent },
  { path: '**',                 component: NotFoundComponent }
];
