-- Seed B2 Level Questions (40 questions total: 4 skills × 10 questions)
-- B2 level requires more complex language and abstract topics

-- B2 Listening Questions
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Welche Position vertritt der Experte zur Klimapolitik?', 'multiple_choice',
  ARRAY['Radikale Maßnahmen sind notwendig', 'Schrittweise Änderungen sind besser', 'Die Wirtschaft hat Priorität', 'Individuelle Verantwortung reicht aus'],
  'Radikale Maßnahmen sind notwendig', 'Der Experte betont die Dringlichkeit umfassender Reformen.', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Was wird als Hauptursache des Problems genannt?', 'multiple_choice',
  ARRAY['Mangelnde Bildung', 'Politisches Versagen', 'Wirtschaftliche Interessen', 'Gesellschaftlicher Wandel'],
  'Wirtschaftliche Interessen', 'Profitorientierung wird als Haupthindernis identifiziert.', 2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Welche Entwicklung wird für die Zukunft prognostiziert?', 'multiple_choice',
  ARRAY['Kontinuierliches Wachstum', 'Stagnation', 'Rückgang', 'Unvorhersehbare Schwankungen'],
  'Kontinuierliches Wachstum', 'Experten erwarten eine positive Entwicklung in den nächsten Jahren.', 3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Welches Argument wird zur Unterstützung der These angeführt?', 'multiple_choice',
  ARRAY['Historische Beispiele', 'Wissenschaftliche Studien', 'Persönliche Erfahrungen', 'Internationale Vergleiche'],
  'Wissenschaftliche Studien', 'Der Sprecher bezieht sich auf aktuelle Forschungsergebnisse.', 4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Was ist die Schlussfolgerung des Vortrags?', 'multiple_choice',
  ARRAY['Sofortiges Handeln ist erforderlich', 'Weitere Forschung ist nötig', 'Das Problem löst sich von selbst', 'Verschiedene Ansätze sind möglich'],
  'Sofortiges Handeln ist erforderlich', 'Der Redner appelliert an unmittelbare Maßnahmen.', 5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';
