-- Allow null values for is_correct in test_answers
-- This is needed for essay and speaking questions that are AI-evaluated
ALTER TABLE test_answers 
ALTER COLUMN is_correct DROP NOT NULL;

-- Also allow null for points_earned initially (will be set after AI evaluation)
ALTER TABLE test_answers 
ALTER COLUMN points_earned DROP NOT NULL;
