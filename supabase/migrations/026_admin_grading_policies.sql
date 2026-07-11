-- Admin RLS for manual instructor grading + grading metadata on test_answers

-- Grading metadata (instructor manual review)
ALTER TABLE test_answers
  ADD COLUMN IF NOT EXISTS graded_by UUID REFERENCES profiles(id),
  ADD COLUMN IF NOT EXISTS graded_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS instructor_feedback TEXT;

-- Admins can view all student profiles (for instructor dashboard joins)
CREATE POLICY "Admins can view all profiles"
ON profiles
FOR SELECT
USING (is_admin());

-- Admins can load student answers for grading
CREATE POLICY "Admins can view all answers"
ON test_answers
FOR SELECT
USING (is_admin());

-- Admins can save grades on student answers
CREATE POLICY "Admins can update all answers"
ON test_answers
FOR UPDATE
USING (is_admin());

-- Admins can recalculate attempt scores after grading
CREATE POLICY "Admins can update all attempts"
ON test_attempts
FOR UPDATE
USING (is_admin());
