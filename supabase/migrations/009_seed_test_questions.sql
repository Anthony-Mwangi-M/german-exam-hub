-- Seed sample questions for test modules
-- This creates 5 questions per skill for A1 level (20 questions total)

-- A1 Listening Questions
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT 
  tm.id,
  'Was hört die Person?',
  'multiple_choice',
  jsonb_build_array('Ein Telefon', 'Eine Tür', 'Ein Auto', 'Musik'),
  'Ein Telefon',
  'Die Person hört ein Telefon klingeln.',
  1
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT 
  tm.id,
  'Wo ist die Person?',
  'multiple_choice',
  jsonb_build_array('Im Supermarkt', 'Im Park', 'Zu Hause', 'Im Büro'),
  'Im Supermarkt',
  'Die Person kauft Lebensmittel ein.',
  2
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT 
  tm.id,
  'Wie viele Personen sprechen?',
  'multiple_choice',
  jsonb_build_array('Eine', 'Zwei', 'Drei', 'Vier'),
  'Zwei',
  'Es sind zwei Personen im Dialog.',
  3
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT 
  tm.id,
  'Wann treffen sie sich?',
  'multiple_choice',
  jsonb_build_array('Morgen', 'Heute', 'Nächste Woche', 'Am Wochenende'),
  'Morgen',
  'Sie vereinbaren ein Treffen für morgen.',
  4
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT 
  tm.id,
  'Was kostet das Produkt?',
  'multiple_choice',
  jsonb_build_array('5 Euro', '10 Euro', '15 Euro', '20 Euro'),
  '10 Euro',
  'Der Preis wird im Dialog genannt.',
  5
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'listening';

-- A1 Reading Questions
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT 
  tm.id,
  'Lies den Text: "Hallo, ich bin Maria. Ich komme aus Spanien." Woher kommt Maria?',
  'multiple_choice',
  jsonb_build_array('Deutschland', 'Spanien', 'Italien', 'Frankreich'),
  'Spanien',
  'Maria sagt "Ich komme aus Spanien".',
  1
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT 
  tm.id,
  'Was bedeutet "Guten Morgen"?',
  'multiple_choice',
  jsonb_build_array('Good morning', 'Good evening', 'Good night', 'Goodbye'),
  'Good morning',
  '"Guten Morgen" ist die deutsche Begrüßung am Morgen.',
  2
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT 
  tm.id,
  'Welches Wort passt? "Ich _____ Deutsch."',
  'multiple_choice',
  jsonb_build_array('lerne', 'lernen', 'lernst', 'lernt'),
  'lerne',
  'Mit "ich" verwendet man die Form "lerne".',
  3
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT 
  tm.id,
  'Was ist richtig? "Das ist _____ Buch."',
  'multiple_choice',
  jsonb_build_array('ein', 'eine', 'der', 'die'),
  'ein',
  '"Buch" ist neutral, daher "ein Buch".',
  4
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT 
  tm.id,
  'Welche Zahl ist richtig? "zwanzig"',
  'multiple_choice',
  jsonb_build_array('12', '20', '22', '30'),
  '20',
  '"Zwanzig" bedeutet 20.',
  5
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

-- A1 Writing Questions
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT 
  tm.id,
  'Schreiben Sie eine kurze Vorstellung (Name, Herkunft, Alter). Mindestens 3 Sätze.',
  'essay',
  'Beispiel: Ich heiße Anna. Ich komme aus Deutschland. Ich bin 25 Jahre alt.',
  1
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT 
  tm.id,
  'Schreiben Sie 5 Sätze über Ihre Familie.',
  'essay',
  'Beispiel: Ich habe eine Schwester. Meine Mutter heißt Maria. Mein Vater arbeitet als Lehrer.',
  2
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT 
  tm.id,
  'Beschreiben Sie Ihren Tagesablauf in 4-5 Sätzen.',
  'essay',
  'Beispiel: Ich stehe um 7 Uhr auf. Ich frühstücke um 8 Uhr. Ich arbeite von 9 bis 17 Uhr.',
  3
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT 
  tm.id,
  'Schreiben Sie eine E-Mail an einen Freund (Einladung zum Kaffee). Mindestens 4 Sätze.',
  'essay',
  'Beispiel: Hallo Peter, wie geht es dir? Hast du morgen Zeit? Wir können zusammen Kaffee trinken. Bis bald!',
  4
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT 
  tm.id,
  'Schreiben Sie 3 Sätze über Ihr Hobby.',
  'essay',
  'Beispiel: Mein Hobby ist Lesen. Ich lese gerne Romane. Ich lese jeden Tag.',
  5
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'writing';

-- A1 Speaking Questions
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT 
  tm.id,
  'Stellen Sie sich vor (Name, Alter, Herkunft, Beruf).',
  'essay',
  'Beispiel: Ich heiße Maria. Ich bin 30 Jahre alt. Ich komme aus Kenia. Ich bin Lehrerin.',
  1
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT 
  tm.id,
  'Beschreiben Sie Ihre Familie.',
  'essay',
  'Beispiel: Ich habe zwei Geschwister. Meine Eltern leben in Nairobi. Mein Bruder studiert.',
  2
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT 
  tm.id,
  'Was machen Sie gerne in Ihrer Freizeit?',
  'essay',
  'Beispiel: Ich spiele gerne Fußball. Ich treffe meine Freunde. Ich sehe gerne Filme.',
  3
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT 
  tm.id,
  'Beschreiben Sie Ihr Haus oder Ihre Wohnung.',
  'essay',
  'Beispiel: Ich wohne in einer Wohnung. Sie hat drei Zimmer. Die Küche ist groß.',
  4
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'speaking';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT 
  tm.id,
  'Was essen Sie gerne?',
  'essay',
  'Beispiel: Ich esse gerne Ugali. Ich mag auch Pizza. Zum Frühstück esse ich Brot.',
  5
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'speaking';

-- Note: For brevity, I'm adding just 5 questions per module for A1 level
-- In production, you would add all 10 questions per module for all levels (A1, A2, B1, B2)
-- and all skills (listening, reading, writing, speaking)

-- Add similar patterns for A2, B1, B2 levels with progressively more complex questions
