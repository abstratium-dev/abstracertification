import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterLink } from '@angular/router';
import { CertificationService } from './certification.service';
import { CertificationModuleIndex } from './certification.model';

interface ModuleInfo {
  id: string;
  title: string;
  description: string;
  pageCount: number;
}

@Component({
  selector: 'module-list',
  imports: [CommonModule, RouterLink],
  templateUrl: './module-list.component.html',
  styleUrl: './module-list.component.scss',
})
export class ModuleListComponent implements OnInit {
  modules: ModuleInfo[] = [];
  loading = true;
  error: string | null = null;

  constructor(
    private certificationService: CertificationService,
    private router: Router,
  ) {}

  ngOnInit(): void {
    this.loadModules();
  }

  private loadModules(): void {
    this.loading = true;
    this.error = null;

    // For now, we have one hardcoded module
    // In the future, this could be fetched from a modules index file
    const moduleIds = ['linux-home-server'];
    const loadedModules: ModuleInfo[] = [];
    let completed = 0;

    if (moduleIds.length === 0) {
      this.loading = false;
      return;
    }

    for (const moduleId of moduleIds) {
      this.certificationService.loadModuleIndex(moduleId).subscribe({
        next: (index: CertificationModuleIndex) => {
          loadedModules.push({
            id: index.id,
            title: index.title,
            description: index.description,
            pageCount: index.pageEntries.length,
          });
          completed++;
          if (completed === moduleIds.length) {
            this.modules = loadedModules;
            this.loading = false;
          }
        },
        error: (err: Error) => {
          this.error = `Failed to load module: ${err.message}`;
          completed++;
          if (completed === moduleIds.length) {
            this.loading = false;
          }
        }
      });
    }
  }

  startModule(moduleId: string): void {
    this.router.navigate(['/certification', moduleId]);
  }
}
