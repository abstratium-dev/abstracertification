/** A glossary-style key concept displayed in the "Key Concepts" section of a step. */
export interface WizardInfoItem {
  term: string;
  description: string;
}

/** A single actionable instruction within a wizard step's "What to do" section. */
export interface WizardInstruction {
  text: string;
  /** Optional shell command for the user to execute. */
  command?: string;
  /** Optional additional context or tip. */
  note?: string;
  /** Optional Mermaid diagram source rendered inline. */
  mermaid?: string;
}

/** A selectable answer option displayed for a wizard question. */
export interface WizardAnswerOption {
  id: string;
  text: string;
}

/** A comprehension-check question presented at the end of a wizard step. */
export interface WizardQuestion {
  id: string;
  text: string;
  /** Available answer options (correctness is NOT known to the frontend). */
  options: WizardAnswerOption[];
}

/** Result of a backend answer check: maps questionId to whether the answer was correct. */
export type WizardAnswerResults = Map<string, boolean>;

/**
 * A single content step in the wizard. Contains the "why" explanation,
 * key concepts, instructions, and comprehension questions.
 */
export interface WizardStep {
  id: string;
  title: string;
  /** Explanation of why this step matters. */
  why: string;
  infoItems: WizardInfoItem[];
  /** Whether the info/key-concepts section starts expanded. */
  infoExpanded: boolean;
  instructions: WizardInstruction[];
  questions: WizardQuestion[];
}

/** One selectable variant within a {@link WizardChoicePoint}. */
export interface WizardChoiceVariant {
  label: string;
  description: string;
  /** Reference ID used to look up the associated step in choiceSteps. */
  stepRef: string;
}

/**
 * A choice point in the wizard where the user selects one or more variants.
 * Each selected variant inserts its associated step into the wizard flow.
 */
export interface WizardChoicePoint {
  label: string;
  description: string;
  /** Minimum number of variants the user must select. */
  minRequired: number;
  /** Maximum number of variants the user may select. */
  maxRequired: number;
  variants: WizardChoiceVariant[];
}

/**
 * A wizard entry is either a step reference (string ID) for direct steps,
 * or a {@link WizardChoicePoint} for user-selectable branching.
 */
export type WizardEntry = string | WizardChoicePoint;

/**
 * Complete definition of a wizard instance. Provided via @Input() to the
 * generic WizardComponent. Contains all steps, choice definitions,
 * and the ordered list of entries that determine the wizard flow.
 */
export interface WizardDefinition {
  id: string;
  title: string;
  description: string;
  /** Ordered sequence of entries (step refs or choice points) defining the flow. */
  entries: WizardEntry[];
  /** Steps referenced by DIRECT entries, in the same order as their entries. */
  steps: WizardStep[];
  /** Steps associated with choice variants, keyed by the choice label. */
  choiceSteps: Map<string, WizardStep[]>;
}

/** Tracks per-step UI state: which answers were selected and whether the step is complete. */
export interface WizardPageState {
  answers: Map<string, number>;
  completed: boolean;
}
