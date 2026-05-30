# Mermaid Lazy Loading — Attempted Approach

## Problem

`mermaid.min.js` (3.16 MB raw / 659 kB transfer) was bundled into the initial `scripts` chunk via `angular.json`, loading on every page even when no mermaid diagrams are shown.

## Attempted Fix

1. Removed `node_modules/mermaid/dist/mermaid.min.js` from `scripts` in `angular.json`.
2. Copied `mermaid.min.js` into `public/` so it is served as a static asset at `/mermaid.min.js`.
3. Added a `prebuild` npm script to automate the copy: `cp node_modules/mermaid/dist/mermaid.min.js public/mermaid.min.js`.
4. Added `public/mermaid.min.js` to `.gitignore`.
5. In `WizardComponent.ngOnInit()`, injected `DOCUMENT` and dynamically appended a `<script src="mermaid.min.js">` tag, guarded by a `typeof window.mermaid !== 'undefined'` check to prevent double-loading.

## Why It Didn't Work

`ngx-markdown` v21 checks `typeof mermaid === 'undefined'` synchronously when a `[mermaid]` directive is used. The dynamically injected script tag loads **asynchronously**, so `window.mermaid` is not yet defined at the point `ngx-markdown` checks it, causing the error:

> `[ngx-markdown] When using the mermaid attribute you have to include Mermaid files to angular.json or use imports.`

## Options to Investigate

- **Load the script eagerly but from `public/`** — keeps it out of the JS bundle but still blocks on page load. Not a bundle win for the wizard route, but removes it from the Angular-bundled `scripts` chunk and allows CDN caching separately.
- **Await script load before rendering `<markdown mermaid>`** — use a `BehaviorSubject` or signal `mermaidReady$` that resolves on the script's `load` event, then conditionally render the markdown component with `*ngIf="mermaidReady$ | async"`.
- **Replace `ngx-markdown` mermaid integration** — call `mermaid.initialize()` and `mermaid.run()` directly after dynamic load, bypassing `ngx-markdown`'s check entirely.
- **CDN** — load from `https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js` with a `<link rel="preload">` hint on the wizard route only.
