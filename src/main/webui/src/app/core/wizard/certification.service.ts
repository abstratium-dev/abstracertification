import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, forkJoin, switchMap, map, of } from 'rxjs';
import { CertificationModule, CertificationModuleIndex, CertificationPage, PageChoice, PageEntry } from './certification.model';

@Injectable({ providedIn: 'root' })
export class CertificationService {

  constructor(private http: HttpClient) {}

  loadModuleIndex(moduleId: string): Observable<CertificationModuleIndex> {
    return this.http.get<CertificationModuleIndex>(`certifications/${moduleId}.json`);
  }

  loadModule(moduleId: string): Observable<CertificationModule> {
    return this.loadModuleIndex(moduleId).pipe(
      switchMap((index: CertificationModuleIndex) => {
        const allUrls = this.collectAllUrls(index.pageEntries);
        if (allUrls.length === 0) {
          return of({
            id: index.id,
            title: index.title,
            description: index.description,
            pageEntries: index.pageEntries,
            pages: [] as CertificationPage[],
            choicePages: new Map<string, CertificationPage[]>()
          });
        }
        const pageRequests: Observable<CertificationPage>[] = allUrls.map(
          (url: string) => this.http.get<CertificationPage>(url)
        );
        return forkJoin(pageRequests).pipe(
          map((loadedPages: CertificationPage[]) => {
            const urlToPage = new Map<string, CertificationPage>();
            allUrls.forEach((url: string, i: number) => urlToPage.set(url, loadedPages[i]));

            const pages: CertificationPage[] = [];
            const choicePages = new Map<string, CertificationPage[]>();

            for (const entry of index.pageEntries) {
              if (typeof entry === 'string') {
                pages.push(urlToPage.get(entry)!);
              } else {
                const choice = entry as PageChoice;
                const variantPages = choice.variants.map(v => urlToPage.get(v.url)!);
                choicePages.set(choice.label, variantPages);
              }
            }

            return {
              id: index.id,
              title: index.title,
              description: index.description,
              pageEntries: index.pageEntries,
              pages,
              choicePages
            };
          })
        );
      })
    );
  }

  loadPage(pageUrl: string): Observable<CertificationPage> {
    return this.http.get<CertificationPage>(pageUrl);
  }

  private collectAllUrls(entries: PageEntry[]): string[] {
    const urls: string[] = [];
    for (const entry of entries) {
      if (typeof entry === 'string') {
        urls.push(entry);
      } else {
        const choice = entry as PageChoice;
        for (const variant of choice.variants) {
          urls.push(variant.url);
        }
      }
    }
    return urls;
  }
}
