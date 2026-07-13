-- Remove em dashes and spaced en dashes (Gedankenstriche) from all
-- user-facing content, mirroring the same mechanical rules applied to the
-- content migration files:
--   * module titles: ' – ' becomes a plain space
--   * everywhere else: ' — ' and ' – ' become ', ', bare '—' becomes ','
--   * unspaced en dashes stay (ranges like B1–B2, 9–14 Uhr, Hamburg–Berlin)
-- correct_answer and options are transformed with the same function so
-- value-based grading equality is preserved.

CREATE OR REPLACE FUNCTION pg_temp.dedash(t TEXT) RETURNS TEXT AS $$
  SELECT replace(replace(replace(t, ' — ', ', '), '—', ','), ' – ', ', ');
$$ LANGUAGE sql IMMUTABLE;

-- Module titles: dash is a separator, drop it without adding a comma
UPDATE test_modules
SET title = replace(title, ' – ', ' ')
WHERE title LIKE '% – %';

UPDATE test_modules
SET description = pg_temp.dedash(description)
WHERE description ~ '—| – ';

UPDATE questions
SET
  question_text  = pg_temp.dedash(question_text),
  explanation    = pg_temp.dedash(explanation),
  correct_answer = pg_temp.dedash(correct_answer),
  audio_script   = pg_temp.dedash(audio_script)
WHERE question_text ~ '—| – '
   OR explanation ~ '—| – '
   OR correct_answer ~ '—| – '
   OR audio_script ~ '—| – ';

UPDATE questions
SET options = (
  SELECT jsonb_agg(pg_temp.dedash(val) ORDER BY ord)
  FROM jsonb_array_elements_text(options) WITH ORDINALITY t(val, ord)
)
WHERE options IS NOT NULL AND options::text ~ '—| – ';

UPDATE questions
SET leitpunkte = (
  SELECT jsonb_agg(pg_temp.dedash(val) ORDER BY ord)
  FROM jsonb_array_elements_text(leitpunkte) WITH ORDINALITY t(val, ord)
)
WHERE leitpunkte IS NOT NULL AND leitpunkte::text ~ '—| – ';

UPDATE questions
SET rubric = (
  SELECT jsonb_object_agg(key, pg_temp.dedash(value))
  FROM jsonb_each_text(rubric)
)
WHERE rubric IS NOT NULL AND rubric::text ~ '—| – ';

UPDATE placement_test_questions
SET
  question_text  = pg_temp.dedash(question_text),
  correct_answer = pg_temp.dedash(correct_answer)
WHERE question_text ~ '—| – ' OR correct_answer ~ '—| – ';

UPDATE placement_test_questions
SET options = (
  SELECT jsonb_agg(pg_temp.dedash(val) ORDER BY ord)
  FROM jsonb_array_elements_text(options) WITH ORDINALITY t(val, ord)
)
WHERE options IS NOT NULL AND options::text ~ '—| – ';
