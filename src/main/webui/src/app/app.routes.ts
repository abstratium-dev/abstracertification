import { Routes } from '@angular/router';
import { authGuard } from './core/auth.guard';
import { NotFoundComponent } from './core/not-found/not-found.component';
import { DemoComponent } from './demo/demo.component';
import { SignedOutComponent } from './core/signed-out/signed-out.component';
import { WizardComponent } from './core/wizard/wizard.component';

export const routes: Routes = [
  { path: '',           component: DemoComponent, canActivate: [authGuard] },
  { path: 'demo',       component: DemoComponent, canActivate: [authGuard] },
  { path: 'certification/:moduleId', component: WizardComponent, canActivate: [authGuard] },
  { path: 'signed-out', component: SignedOutComponent },
  { path: '**',         component: NotFoundComponent }
];
