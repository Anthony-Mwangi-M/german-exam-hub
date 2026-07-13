-- Pending-review attempts must not carry an interim percentage.
--
-- Convention (matches TakeTest/Dashboard/TestResults): while an attempt has
-- ungraded answers (is_correct IS NULL), percentage stays NULL and the UI
-- shows a pending state. Instructor grading writes the final score and
-- percentage. This clears interim values written by the old submit code.

UPDATE test_attempts ta
SET percentage = NULL
WHERE ta.is_placement_test = false
  AND ta.percentage IS NOT NULL
  AND EXISTS (
    SELECT 1 FROM test_answers a
    WHERE a.test_attempt_id = ta.id AND a.is_correct IS NULL
  );
