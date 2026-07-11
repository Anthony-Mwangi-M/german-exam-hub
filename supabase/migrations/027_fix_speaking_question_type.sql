-- Sprechen modules were seeded with question_type = 'essay'.
-- Use 'speaking' so TakeTest shows VoiceRecorder and instructor queue works.

UPDATE questions q
SET question_type = 'speaking'
FROM test_modules tm
JOIN skills s ON tm.skill_id = s.id
WHERE q.test_module_id = tm.id
  AND s.code = 'speaking'
  AND q.question_type = 'essay';
