-- Add AI evaluation fields to test_answers table
ALTER TABLE test_answers 
ADD COLUMN ai_evaluation JSONB,
ADD COLUMN ai_score INTEGER,
ADD COLUMN ai_feedback TEXT,
ADD COLUMN evaluated_at TIMESTAMPTZ;

-- Add audio URL to questions table
ALTER TABLE questions 
ADD COLUMN audio_url TEXT;

-- Create ai_evaluations table for detailed tracking
CREATE TABLE ai_evaluations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  test_answer_id UUID REFERENCES test_answers(id) ON DELETE CASCADE NOT NULL,
  evaluation_type TEXT NOT NULL, -- 'writing' or 'speaking'
  raw_response JSONB NOT NULL,
  grammar_score INTEGER,
  vocabulary_score INTEGER,
  structure_score INTEGER,
  content_score INTEGER,
  overall_score INTEGER NOT NULL,
  cefr_level TEXT,
  feedback TEXT NOT NULL,
  transcription TEXT, -- For speaking tests
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Create index for efficient lookups
CREATE INDEX idx_ai_evaluations_answer ON ai_evaluations(test_answer_id);

-- Enable RLS
ALTER TABLE ai_evaluations ENABLE ROW LEVEL SECURITY;

-- RLS Policies for ai_evaluations
CREATE POLICY "Users can view own evaluations" ON ai_evaluations FOR SELECT USING (
    EXISTS (
        SELECT 1 FROM test_answers 
        JOIN test_attempts ON test_answers.test_attempt_id = test_attempts.id
        WHERE test_answers.id = ai_evaluations.test_answer_id 
        AND test_attempts.user_id = auth.uid()
    )
);

CREATE POLICY "Service role can insert evaluations" ON ai_evaluations FOR INSERT WITH CHECK (true);
