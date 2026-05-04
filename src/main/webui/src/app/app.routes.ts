import { Routes } from '@angular/router';
import { authGuard } from './core/auth.guard';
import { NotFoundComponent } from './core/not-found/not-found.component';
import { SignedOutComponent } from './core/signed-out/signed-out.component';
import { WizardComponent } from './core/wizard/wizard.component';
import { ModuleListComponent } from './core/wizard/module-list.component';

export const routes: Routes = [
  { path: '',                   component: ModuleListComponent, canActivate: [authGuard] },
  { path: 'certifications',     component: ModuleListComponent, canActivate: [authGuard] },
  { path: 'certification/:moduleId', component: WizardComponent, canActivate: [authGuard] },
  { path: 'signed-out',         component: SignedOutComponent },
  { path: '**',                 component: NotFoundComponent }
];
