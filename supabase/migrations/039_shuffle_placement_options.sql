-- Randomize the stored option order of placement test questions.
--
-- The client already shuffles options at render time, but the stored order
-- from migration 037 was authoring-biased (key at position B in 18 of 32
-- items). Randomizing storage removes the bias at the source so any future
-- surface that renders stored order inherits no signal.
--
-- Safe here because every placement option is a self-contained answer
-- string; grading compares values, not positions. Do NOT apply the same
-- blanket shuffle to the exam `questions` table — matching items there use
-- ordered letter labels (a–j) that reference pools in the question text.

UPDATE placement_test_questions
SET options = shuffled.new_options
FROM (
  SELECT id, (
    SELECT jsonb_agg(val ORDER BY random())
    FROM jsonb_array_elements(options) AS val
  ) AS new_options
  FROM placement_test_questions
) AS shuffled
WHERE placement_test_questions.id = shuffled.id;
