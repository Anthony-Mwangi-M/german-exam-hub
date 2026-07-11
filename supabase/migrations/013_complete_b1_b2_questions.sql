-- Generated SQL for B1 and B2 Questions
-- Copy this output to a new migration file


-- ============================================
-- B1 LEVEL QUESTIONS
-- ============================================


-- B1 Listening Questions (10 questions)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was ist das Hauptthema des Gesprächs?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 listening question 1',
  1
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welche Meinung vertritt der Sprecher?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 listening question 2',
  2
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Warum kann die Person nicht kommen?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 listening question 3',
  3
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was wird empfohlen?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 listening question 4',
  4
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welches Problem wird beschrieben?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 listening question 5',
  5
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was plant die Organisation?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 listening question 6',
  6
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welcher Vorschlag wird gemacht?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 listening question 7',
  7
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was ist der Grund für die Änderung?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 listening question 8',
  8
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welche Erfahrung wird beschrieben?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 listening question 9',
  9
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was wird als nächstes passieren?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 listening question 10',
  10
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

-- B1 Reading Questions (10 questions)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was ist die Hauptaussage des Textes?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 reading question 1',
  1
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welches Wort passt? ''_____ des schlechten Wetters gingen wir spazieren.''', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 reading question 2',
  2
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was bedeutet ''sich beschweren''?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 reading question 3',
  3
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welche Konjunktion ist richtig? ''Ich lerne Deutsch, _____ ich in Deutschland arbeiten möchte.''', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 reading question 4',
  4
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was ist richtig? ''Der Film, _____ ich gestern gesehen habe, war toll.''', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 reading question 5',
  5
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welches Verb passt? ''Die Regierung hat beschlossen, die Steuern zu _____.''', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 reading question 6',
  6
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was bedeutet ''nachhaltig''?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 reading question 7',
  7
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welche Präposition ist richtig? ''Ich interessiere mich _____ Politik.''', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 reading question 8',
  8
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was ist richtig? ''Wenn ich Zeit _____, würde ich mehr reisen.''', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 reading question 9',
  9
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welches Wort passt? ''Die Firma hat ihre Produktion _____.''', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B1 reading question 10',
  10
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- B1 Writing Questions (10 questions)
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie einen formellen Brief an Ihren Vermieter über ein Problem (8-10 Sätze).', 
  'essay',
  'Sample answer for B1 writing question 1',
  1
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie Ihre Meinung zum Thema ''Sollten Schuluniformen Pflicht sein?'' (10-12 Sätze).', 
  'essay',
  'Sample answer for B1 writing question 2',
  2
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Beschreiben Sie ein wichtiges Ereignis in Ihrem Leben (8-10 Sätze).', 
  'essay',
  'Sample answer for B1 writing question 3',
  3
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie eine Bewerbung für einen Job (10-12 Sätze).', 
  'essay',
  'Sample answer for B1 writing question 4',
  4
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Verfassen Sie einen Blogbeitrag über Ihr Hobby (8-10 Sätze).', 
  'essay',
  'Sample answer for B1 writing question 5',
  5
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie einen Beschwerdebrief an ein Geschäft (8-10 Sätze).', 
  'essay',
  'Sample answer for B1 writing question 6',
  6
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Beschreiben Sie Vor- und Nachteile des Lebens in der Stadt (10-12 Sätze).', 
  'essay',
  'Sample answer for B1 writing question 7',
  7
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie über Ihre Zukunftspläne (8-10 Sätze).', 
  'essay',
  'Sample answer for B1 writing question 8',
  8
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Verfassen Sie eine Einladung zu einer Veranstaltung (6-8 Sätze).', 
  'essay',
  'Sample answer for B1 writing question 9',
  9
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie über ein soziales Problem in Ihrem Land (10-12 Sätze).', 
  'essay',
  'Sample answer for B1 writing question 10',
  10
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

-- B1 Speaking Questions (10 questions)
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Stellen Sie sich und Ihren beruflichen Werdegang vor.', 
  'essay',
  'Sample answer for B1 speaking question 1',
  1
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Beschreiben Sie Ihre Heimatstadt und was sie besonders macht.', 
  'essay',
  'Sample answer for B1 speaking question 2',
  2
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sprechen Sie über Ihre Meinung zu sozialen Medien.', 
  'essay',
  'Sample answer for B1 speaking question 3',
  3
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Erklären Sie, wie man ein traditionelles Gericht aus Ihrem Land kocht.', 
  'essay',
  'Sample answer for B1 speaking question 4',
  4
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Diskutieren Sie die Vor- und Nachteile von Fernarbeit.', 
  'essay',
  'Sample answer for B1 speaking question 5',
  5
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Beschreiben Sie eine Person, die Sie bewundern.', 
  'essay',
  'Sample answer for B1 speaking question 6',
  6
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sprechen Sie über Umweltprobleme in Ihrer Region.', 
  'essay',
  'Sample answer for B1 speaking question 7',
  7
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Erklären Sie, warum Sie Deutsch lernen.', 
  'essay',
  'Sample answer for B1 speaking question 8',
  8
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Beschreiben Sie Ihren idealen Urlaub.', 
  'essay',
  'Sample answer for B1 speaking question 9',
  9
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Diskutieren Sie die Rolle der Technologie in der Bildung.', 
  'essay',
  'Sample answer for B1 speaking question 10',
  10
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

-- ============================================
-- B2 LEVEL QUESTIONS
-- ============================================


-- B2 Listening Questions (10 questions)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welche Position vertritt der Experte zur Klimapolitik?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 listening question 1',
  1
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was wird als Hauptursache des Problems genannt?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 listening question 2',
  2
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welche Entwicklung wird für die Zukunft prognostiziert?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 listening question 3',
  3
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welches Argument wird zur Unterstützung der These angeführt?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 listening question 4',
  4
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was ist die Schlussfolgerung des Vortrags?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 listening question 5',
  5
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welche Gegenargumente werden erwähnt?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 listening question 6',
  6
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was wird als Lösung vorgeschlagen?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 listening question 7',
  7
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welche Rolle spielt die Regierung laut Sprecher?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 listening question 8',
  8
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was sind die langfristigen Konsequenzen?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 listening question 9',
  9
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welche Perspektive wird kritisiert?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 listening question 10',
  10
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

-- B2 Reading Questions (10 questions)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was ist die zentrale These des Artikels?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 reading question 1',
  1
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welches Wort passt? ''Die Maßnahmen haben sich als _____ erwiesen.''', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 reading question 2',
  2
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was bedeutet ''nachvollziehbar'' in diesem Kontext?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 reading question 3',
  3
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welche Konjunktion ist richtig? ''_____ die Kosten hoch sind, lohnt sich die Investition.''', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 reading question 4',
  4
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was ist richtig? ''Das Projekt, _____ Erfolg überraschend war, wird fortgesetzt.''', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 reading question 5',
  5
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welches Verb passt? ''Die Studie _____ wichtige Erkenntnisse.''', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 reading question 6',
  6
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was bedeutet ''ambivalent''?', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 reading question 7',
  7
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welche Präposition ist richtig? ''Die Entscheidung basiert _____ wissenschaftlichen Daten.''', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 reading question 8',
  8
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Was ist richtig? ''Hätte ich das gewusst, _____ ich anders gehandelt.''', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 reading question 9',
  9
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Welches Wort passt? ''Die Entwicklung _____ sich beschleunigt.''', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for B2 reading question 10',
  10
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- B2 Writing Questions (10 questions)
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Verfassen Sie einen argumentativen Essay zum Thema ''Künstliche Intelligenz in der Arbeitswelt'' (200-250 Wörter).', 
  'essay',
  'Sample answer for B2 writing question 1',
  1
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie einen formellen Brief an eine Behörde bezüglich eines Anliegens (180-220 Wörter).', 
  'essay',
  'Sample answer for B2 writing question 2',
  2
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Analysieren Sie die Vor- und Nachteile der Globalisierung (200-250 Wörter).', 
  'essay',
  'Sample answer for B2 writing question 3',
  3
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie einen Artikel über nachhaltige Entwicklung (180-220 Wörter).', 
  'essay',
  'Sample answer for B2 writing question 4',
  4
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Verfassen Sie eine Stellungnahme zur Digitalisierung im Bildungswesen (200-250 Wörter).', 
  'essay',
  'Sample answer for B2 writing question 5',
  5
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie über kulturelle Unterschiede und deren Bedeutung (180-220 Wörter).', 
  'essay',
  'Sample answer for B2 writing question 6',
  6
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Analysieren Sie ein aktuelles gesellschaftliches Problem (200-250 Wörter).', 
  'essay',
  'Sample answer for B2 writing question 7',
  7
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Verfassen Sie einen Kommentar zu Umweltschutzmaßnahmen (180-220 Wörter).', 
  'essay',
  'Sample answer for B2 writing question 8',
  8
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie über die Zukunft der Mobilität (200-250 Wörter).', 
  'essay',
  'Sample answer for B2 writing question 9',
  9
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Diskutieren Sie ethische Fragen der modernen Medizin (200-250 Wörter).', 
  'essay',
  'Sample answer for B2 writing question 10',
  10
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

-- B2 Speaking Questions (10 questions)
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Präsentieren Sie Ihre Ansichten zur Rolle der Medien in der Demokratie.', 
  'essay',
  'Sample answer for B2 speaking question 1',
  1
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Diskutieren Sie die Auswirkungen der Globalisierung auf lokale Kulturen.', 
  'essay',
  'Sample answer for B2 speaking question 2',
  2
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Erklären Sie komplexe wirtschaftliche Zusammenhänge in Ihrem Land.', 
  'essay',
  'Sample answer for B2 speaking question 3',
  3
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Analysieren Sie die Herausforderungen des Klimawandels.', 
  'essay',
  'Sample answer for B2 speaking question 4',
  4
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sprechen Sie über die Bedeutung von Bildung für gesellschaftlichen Fortschritt.', 
  'essay',
  'Sample answer for B2 speaking question 5',
  5
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Diskutieren Sie ethische Dilemmata in der modernen Technologie.', 
  'essay',
  'Sample answer for B2 speaking question 6',
  6
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Präsentieren Sie Lösungsansätze für soziale Ungleichheit.', 
  'essay',
  'Sample answer for B2 speaking question 7',
  7
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Erörtern Sie die Zukunft der Arbeit im digitalen Zeitalter.', 
  'essay',
  'Sample answer for B2 speaking question 8',
  8
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sprechen Sie über kulturelle Identität in einer globalisierten Welt.', 
  'essay',
  'Sample answer for B2 speaking question 9',
  9
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Diskutieren Sie die Balance zwischen Sicherheit und Freiheit.', 
  'essay',
  'Sample answer for B2 speaking question 10',
  10
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';
