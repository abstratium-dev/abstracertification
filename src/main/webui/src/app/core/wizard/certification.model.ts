export interface CertificationModule {
  id: string;
  title: string;
  description: string;
  pages: CertificationPage[];
}

export interface CertificationPage {
  id: string;
  title: string;
  why: string;
  instructions: InstructionStep[];
  questions: Question[];
}

export interface InstructionStep {
  text: string;
  command?: string;
  note?: string;
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
