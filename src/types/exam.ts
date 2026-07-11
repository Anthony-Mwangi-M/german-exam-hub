export type ExamFormat = 'goethe' | 'osd';

export type ExamTaskType =
  | 'mcq'
  | 'true_false'
  | 'matching'
  | 'gap_fill'
  | 'form_fill'
  | 'essay'
  | 'speaking';

export type AudioLicense = 'CC0' | 'CC-BY' | 'CC-BY-SA' | 'OWNED';

/** Four-dimension Goethe rubric stored on questions.rubric */
export interface InstructorRubric {
  task_achievement?: string;
  coherence?: string;
  vocabulary?: string;
  grammar?: string;
}
