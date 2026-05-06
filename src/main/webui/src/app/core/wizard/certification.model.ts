export interface PageVariant {
  label: string;
  description: string;
  url: string;
}

export interface PageChoice {
  type: 'choice';
  label: string;
  description: string;
  minRequired: number;
  maxRequired: number;
  variants: PageVariant[];
}

export type PageEntry = string | PageChoice;

export interface CertificationModuleIndex {
  id: string;
  title: string;
  description: string;
  pageEntries: PageEntry[];
}

export interface ResolvedPageEntry {
  page: CertificationPage;
  choiceGroupId?: string;
}

export interface CertificationModule {
  id: string;
  title: string;
  description: string;
  pageEntries: PageEntry[];
  pages: CertificationPage[];
  choicePages: Map<string, CertificationPage[]>;
}

export interface InfoItem {
  term: string;
  description: string;
}

export interface CertificationPage {
  id: string;
  title: string;
  why: string;
  info?: InfoItem[];
  infoExpanded?: boolean;
  instructions: InstructionStep[];
  questions: Question[];
}

export interface InstructionStep {
  text: string;
  command?: string;
  note?: string;
  mermaid?: string;
}

export interface Question {
  id: string;
  text: string;
  options: string[];
  correctIndex: number;
}

export interface PageState {
  answers: Map<string, number>;
  completed: boolean;
}
