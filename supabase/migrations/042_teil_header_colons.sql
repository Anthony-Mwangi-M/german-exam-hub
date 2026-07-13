-- Speaking/writing task headers read "Teil N, ..." after the dash cleanup
-- (040). A colon is the natural separator: "Teil 2: Ein Thema präsentieren".
-- Mirrors the same fix applied to migration files 033-036.

UPDATE questions
SET question_text = regexp_replace(question_text, '^Teil ([0-9]), ', 'Teil \1: ')
WHERE question_text ~ '^Teil [0-9], ';
