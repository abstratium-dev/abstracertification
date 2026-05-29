import { CommonModule } from '@angular/common';
import { Component, effect, inject, OnInit, computed, Signal, signal } from '@angular/core';
import { Router, RouterLink, RouterLinkActive, ActivatedRoute, NavigationEnd } from '@angular/router';
import { filter, map } from 'rxjs';
import { AuthService, Token } from '../core/auth.service';
import { ThemeService } from '../core/theme.service';

@Component({
    selector: 'header',
    imports: [RouterLink, RouterLinkActive, CommonModule],
    templateUrl: './header.component.html',
    styleUrl: './header.component.scss',
})
export class HeaderComponent implements OnInit {
    private authService = inject(AuthService);
    themeService = inject(ThemeService);
    private router = inject(Router);
    private route = inject(ActivatedRoute);

    token!: Token;
    isSignedIn = false;

    /** Current certification ID when on a certification page */
    certificationId = signal<string | null>(null);

    /** True when on a certification page route (certification/:id or certification/:id/page/:page) */
    isOnCertificationPage: Signal<boolean> = computed(() => this.certificationId() !== null);

    readonly FONT_SIZE_KEY = 'wizard-font-size';
    fontSize: 'small' | 'medium' | 'large' = this.loadFontSize();

    constructor() {
        effect(() => {
            this.token = this.authService.token$();
            this.isSignedIn = this.token.isAuthenticated;
        });
    }

    ngOnInit(): void {
        console.log('[HEADER DEBUG] ngOnInit called');

        // Track route changes to detect certification page routes via route data
        this.router.events
            .pipe(
                filter(event => event instanceof NavigationEnd),
                map(() => this.route.root),
                map(rootRoute => {
                    console.log('[HEADER DEBUG] NavigationEnd event, checking route...');
                    return this.findCertificationRoute(rootRoute);
                })
            )
            .subscribe(routeInfo => {
                console.log('[HEADER DEBUG] Route info updated:', routeInfo);
                this.certificationId.set(routeInfo?.certId ?? null);
                console.log('[HEADER DEBUG] certificationId set to:', this.certificationId());
                console.log('[HEADER DEBUG] isOnCertificationPage:', this.isOnCertificationPage());
            });

        // Initial state check
        console.log('[HEADER DEBUG] Doing initial route check...');
        const initialRouteInfo = this.findCertificationRoute(this.route.root);
        console.log('[HEADER DEBUG] Initial route info:', initialRouteInfo);
        this.certificationId.set(initialRouteInfo?.certId ?? null);
        console.log('[HEADER DEBUG] Initial certificationId:', this.certificationId());
    }

    /**
     * Walks the route tree to find if we're on a certification page route
     * that has showCertificationControls: true in route data.
     */
    private findCertificationRoute(route: ActivatedRoute): { certId: string } | null {
        let current: ActivatedRoute | null = route;
        let depth = 0;

        console.log('[HEADER DEBUG] findCertificationRoute starting...');

        while (current) {
            const params = current.snapshot.params;
            const data = current.snapshot.data;
            const url = current.snapshot.url.map(s => s.path).join('/');

            console.log(`[HEADER DEBUG] Depth ${depth}: url='${url}', params=`, params, 'data=', data);

            // Check if this route has showCertificationControls: true
            if (data['showCertificationControls'] && params['certificationId']) {
                console.log('[HEADER DEBUG] Found matching route! certId:', params['certificationId']);
                return { certId: params['certificationId'] };
            }

            current = current.firstChild;
            depth++;
        }

        console.log('[HEADER DEBUG] No matching certification route found');
        return null;
    }

    toggleTheme(): void {
        this.themeService.toggleTheme();
    }

    signout() {
        this.authService.signout();
    }

    // --- Certification page controls ---

    navigateToOverview(): void {
        const certId = this.certificationId();
        if (certId) {
            this.router.navigate(['/certification', certId, 'overview']);
        }
    }

    setFontSize(size: 'small' | 'medium' | 'large'): void {
        this.fontSize = size;
        localStorage.setItem(this.FONT_SIZE_KEY, size);
        // Dispatch custom event to notify wizard component
        window.dispatchEvent(new CustomEvent('fontSizeChange', { detail: size }));
    }

    private loadFontSize(): 'small' | 'medium' | 'large' {
        const saved = localStorage.getItem(this.FONT_SIZE_KEY);
        if (saved === 'small' || saved === 'medium' || saved === 'large') {
            return saved;
        }
        return 'medium';
    }
}
