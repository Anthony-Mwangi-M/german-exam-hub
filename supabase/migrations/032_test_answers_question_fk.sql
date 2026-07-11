-- PostgREST needs a FK to embed questions on test_answers (instructor dashboard + grading UI).

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'test_answers_question_id_fkey'
  ) THEN
    ALTER TABLE test_answers
      ADD CONSTRAINT test_answers_question_id_fkey
      FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE;
  END IF;
END $$;
