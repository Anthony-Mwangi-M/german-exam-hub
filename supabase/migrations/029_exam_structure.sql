-- Exam structure metadata for Goethe/ÖSD-style simulator (v1: Lesen, Schreiben, Sprechen)

-- Audio asset registry (for post-v1 Hören; schema ready now)
CREATE TABLE audio_assets (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  storage_path TEXT NOT NULL,
  source_url TEXT,
  license TEXT NOT NULL,
  attribution_text TEXT,
  cefr_level TEXT,
  duration_sec INT,
  transcript TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  CONSTRAINT audio_assets_license_check CHECK (
    license IN ('CC0', 'CC-BY', 'CC-BY-SA', 'OWNED')
  )
);

CREATE INDEX idx_audio_assets_cefr ON audio_assets(cefr_level);

ALTER TABLE audio_assets ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view audio assets"
ON audio_assets FOR SELECT USING (true);

CREATE POLICY "Admins can manage audio assets"
ON audio_assets FOR ALL USING (is_admin());

-- Module-level exam format
ALTER TABLE test_modules
  ADD COLUMN IF NOT EXISTS exam_format TEXT NOT NULL DEFAULT 'goethe';

ALTER TABLE test_modules
  ADD CONSTRAINT test_modules_exam_format_check
  CHECK (exam_format IN ('goethe', 'osd'));

-- Question-level exam structure
ALTER TABLE questions
  ADD COLUMN IF NOT EXISTS exam_part SMALLINT,
  ADD COLUMN IF NOT EXISTS audio_script TEXT,
  ADD COLUMN IF NOT EXISTS audio_plays_max SMALLINT,
  ADD COLUMN IF NOT EXISTS task_type TEXT,
  ADD COLUMN IF NOT EXISTS word_limit_min INT,
  ADD COLUMN IF NOT EXISTS word_limit_max INT,
  ADD COLUMN IF NOT EXISTS leitpunkte JSONB,
  ADD COLUMN IF NOT EXISTS rubric JSONB,
  ADD COLUMN IF NOT EXISTS audio_source_id UUID REFERENCES audio_assets(id);

ALTER TABLE questions
  ADD CONSTRAINT questions_task_type_check CHECK (
    task_type IS NULL OR task_type IN (
      'mcq', 'true_false', 'matching', 'gap_fill', 'form_fill', 'essay', 'speaking'
    )
  );

ALTER TABLE questions
  ADD CONSTRAINT questions_audio_plays_max_check CHECK (
    audio_plays_max IS NULL OR audio_plays_max BETWEEN 1 AND 2
  );

-- Map existing question_type values to task_type
UPDATE questions
SET task_type = CASE question_type::text
  WHEN 'multiple_choice' THEN 'mcq'
  WHEN 'fill_blank' THEN 'gap_fill'
  WHEN 'essay' THEN 'essay'
  WHEN 'speaking' THEN 'speaking'
  WHEN 'audio' THEN 'mcq'
  ELSE 'mcq'
END
WHERE task_type IS NULL;

COMMENT ON COLUMN questions.exam_part IS 'Goethe exam Teil number (1, 2, 3...)';
COMMENT ON COLUMN questions.audio_script IS 'Spoken passage only (Hören); separate from question_text';
COMMENT ON COLUMN questions.audio_plays_max IS 'Max replays per item: 1 or 2 per Goethe rules';
COMMENT ON COLUMN questions.task_type IS 'UI task variant: mcq, true_false, matching, gap_fill, form_fill, essay, speaking';
COMMENT ON COLUMN questions.leitpunkte IS 'Writing prompt bullet points (Schreiben)';
COMMENT ON COLUMN questions.rubric IS 'Instructor grading rubric JSON (4 dimensions)';
