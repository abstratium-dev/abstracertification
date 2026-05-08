import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, map } from 'rxjs';
import { CertificationModelService, CertificationSummary } from './certification.model';
import {
  WizardDefinition, WizardStep, WizardChoicePoint, WizardEntry,
  WizardAnswerResults
} from '../core/wizard/wizard.model';

// Backend response interfaces matching DATABASE.md entity names
// Note: directStep on PageEntry and step on ChoiceVariant are @JsonIgnored,
// so the JSON contains steps as a separate array on Certification.
// DIRECT page entries consume steps in sequence order.
// CHOICE variants reference steps that are NOT in the DIRECT sequence.
interface BackendCertification {
  id: string;
  title: string;
  description: string;
  pageEntries: BackendPageEntry[];
  steps: BackendCertificationStep[];
}

interface BackendPageEntry {
  id: string;
  entryType: 'DIRECT' | 'CHOICE';
  sequenceOrder: number;
  directStepId?: string;
  choiceLabel?: string;
  choiceDescription?: string;
  minRequired?: number;
  maxRequired?: number;
  variants?: BackendChoiceVariant[];
}

interface BackendChoiceVariant {
  id: string;
  label: string;
  description: string;
  sequenceOrder: number;
  stepId?: string;
}

interface BackendCertificationStep {
  id: string;
  stepKey: string;
  title: string;
  why: string;
  infoExpanded: boolean;
  infoItems: BackendInfoItem[];
  instructions: BackendInstruction[];
  questions: BackendQuestion[];
}

interface BackendInfoItem {
  id: string;
  term: string;
  description: string;
  sequenceOrder: number;
}

interface BackendInstruction {
  id: string;
  text: string;
  command?: string;
  note?: string;
  mermaidDiagram?: string;
  sequenceOrder: number;
}

interface BackendQuestion {
  id: string;
  questionKey: string;
  text: string;
  sequenceOrder: number;
  answerOptions: BackendAnswerOption[];
}

interface BackendAnswerOption {
  id: string;
  text: string;
  sequenceOrder: number;
}

interface CheckAnswersRequest {
  answers: { [questionId: string]: string };
}

interface CheckAnswersResponse {
  results: { [questionId: string]: boolean };
}

@Injectable({
  providedIn: 'root',
})
export class CertificationController {

  private modelService = inject(CertificationModelService);
  private http = inject(HttpClient);

  private readonly publicApiUrl = '/public/certifications';

  loadCertifications() {
    this.modelService.setCertificationsLoading(true);
    this.modelService.setCertificationsError(null);

    this.http.get<CertificationSummary[]>(this.publicApiUrl).subscribe({
      next: (certifications) => {
        this.modelService.setCertifications(certifications);
        this.modelService.setCertificationsLoading(false);
      },
      error: (err) => {
        console.error('Error loading certifications:', err);
        this.modelService.setCertifications([]);
        this.modelService.setCertificationsError('Failed to load certifications');
        this.modelService.setCertificationsLoading(false);
      }
    });
  }

  loadCertification(certificationId: string) {
    this.modelService.setCurrentCertificationLoading(true);
    this.modelService.setCurrentCertificationError(null);

    this.http.get<BackendCertification>(`${this.publicApiUrl}/${certificationId}`).subscribe({
      next: (cert) => {
        const definition = this.mapToWizardDefinition(cert);
        this.modelService.setCurrentCertification(definition);
        this.modelService.setCurrentCertificationLoading(false);
      },
      error: (err) => {
        console.error('Error loading certification:', err);
        this.modelService.setCurrentCertification(null);
        this.modelService.setCurrentCertificationError(`Failed to load certification: ${err.message}`);
        this.modelService.setCurrentCertificationLoading(false);
      }
    });
  }

  private mapToWizardDefinition(cert: BackendCertification): WizardDefinition {
    const entries: WizardEntry[] = [];
    const steps: WizardStep[] = [];
    const choiceSteps = new Map<string, WizardStep[]>();

    // Build a map of step ID -> BackendCertificationStep for lookup
    const stepsById = new Map<string, BackendCertificationStep>();
    for (const step of cert.steps) {
      stepsById.set(step.id, step);
    }

    // Sort page entries by sequenceOrder
    const sortedPageEntries = [...cert.pageEntries].sort((a, b) => a.sequenceOrder - b.sequenceOrder);

    for (const entry of sortedPageEntries) {
      if (entry.entryType === 'DIRECT') {
        const backendStep = entry.directStepId ? stepsById.get(entry.directStepId) : undefined;
        if (backendStep) {
          entries.push(`step-${backendStep.id}`);
          steps.push(this.mapToWizardStep(backendStep));
        }
      } else if (entry.entryType === 'CHOICE') {
        const sortedVariants = (entry.variants || []).sort((a, b) => a.sequenceOrder - b.sequenceOrder);

        const variantWizardSteps: WizardStep[] = [];
        const variantRefs: { label: string; description: string; stepRef: string }[] = [];

        for (const variant of sortedVariants) {
          const backendStep = variant.stepId ? stepsById.get(variant.stepId) : undefined;
          if (backendStep) {
            variantWizardSteps.push(this.mapToWizardStep(backendStep));
            variantRefs.push({
              label: variant.label,
              description: variant.description,
              stepRef: `step-${backendStep.id}`
            });
          }
        }

        const choicePoint: WizardChoicePoint = {
          label: entry.choiceLabel || 'Choice',
          description: entry.choiceDescription || '',
          minRequired: entry.minRequired || 0,
          maxRequired: entry.maxRequired || 1,
          variants: variantRefs
        };
        entries.push(choicePoint);
        choiceSteps.set(choicePoint.label, variantWizardSteps);
      }
    }

    return {
      id: cert.id,
      title: cert.title,
      description: cert.description,
      entries,
      steps,
      choiceSteps
    };
  }

  /**
   * Submits selected answers to the backend for validation.
   * @param certificationId ID of the certification
   * @param answers Map of questionId -> selected answer option ID
   * @returns Observable of WizardAnswerResults (questionId -> correct boolean)
   */
  checkAnswers(certificationId: string, answers: Map<string, string>): Observable<WizardAnswerResults> {
    const payload: CheckAnswersRequest = {
      answers: Object.fromEntries(answers)
    };
    return this.http.post<CheckAnswersResponse>(
      `${this.publicApiUrl}/${certificationId}/check-answers`, payload
    ).pipe(
      map(response => new Map(Object.entries(response.results)))
    );
  }

  private mapToWizardStep(backendStep: BackendCertificationStep): WizardStep {
    const sortedInfoItems = [...backendStep.infoItems].sort((a, b) => a.sequenceOrder - b.sequenceOrder);
    const sortedInstructions = [...backendStep.instructions].sort((a, b) => a.sequenceOrder - b.sequenceOrder);
    const sortedQuestions = [...backendStep.questions].sort((a, b) => a.sequenceOrder - b.sequenceOrder);

    return {
      id: backendStep.id,
      title: backendStep.title,
      why: backendStep.why,
      infoItems: sortedInfoItems.map(item => ({
        term: item.term,
        description: item.description
      })),
      infoExpanded: backendStep.infoExpanded,
      instructions: sortedInstructions.map(instr => ({
        text: instr.text,
        command: instr.command,
        note: instr.note,
        mermaid: instr.mermaidDiagram
      })),
      questions: sortedQuestions.map(q => {
        const sortedOptions = [...q.answerOptions].sort((a, b) => a.sequenceOrder - b.sequenceOrder);
        return {
          id: q.id,
          text: q.text,
          options: sortedOptions.map(opt => ({ id: opt.id, text: opt.text }))
        };
      })
    };
  }
}
