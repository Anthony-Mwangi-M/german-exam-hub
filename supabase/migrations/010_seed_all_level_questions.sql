-- Seed comprehensive questions for all levels (A2, B1, B2)
-- This adds 10 questions per test module for remaining levels
-- Total: 120 new questions (3 levels × 4 skills × 10 questions)

-- ============================================
-- A2 LEVEL QUESTIONS
-- ============================================

-- A2 Listening Questions (10 questions)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Was plant die Person für das Wochenende?', 'multiple_choice',
  jsonb_build_array('Ins Kino gehen', 'Zu Hause bleiben', 'Freunde besuchen', 'Einkaufen gehen'),
  'Freunde besuchen', 'Die Person erwähnt einen Besuch bei Freunden.', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Welches Verkehrsmittel nimmt die Person?', 'multiple_choice',
  jsonb_build_array('Bus', 'Zug', 'Auto', 'Fahrrad'),
  'Zug', 'Die Person fährt mit dem Zug zur Arbeit.', 2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Wie ist das Wetter heute?', 'multiple_choice',
  jsonb_build_array('Sonnig', 'Regnerisch', 'Bewölkt', 'Schnee'),
  'Regnerisch', 'Es regnet den ganzen Tag.', 3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Was bestellt die Person im Restaurant?', 'multiple_choice',
  jsonb_build_array('Pizza', 'Salat', 'Schnitzel', 'Suppe'),
  'Schnitzel', 'Die Person bestellt ein Schnitzel mit Pommes.', 4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Wann beginnt der Film?', 'multiple_choice',
  jsonb_build_array('18:00 Uhr', '19:30 Uhr', '20:00 Uhr', '21:00 Uhr'),
  '19:30 Uhr', 'Der Film beginnt um halb acht.', 5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Wo arbeitet die Person?', 'multiple_choice',
  jsonb_build_array('In einer Schule', 'In einem Krankenhaus', 'In einem Büro', 'In einem Geschäft'),
  'In einem Büro', 'Die Person arbeitet in einem Büro im Stadtzentrum.', 6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Was ist das Problem?', 'multiple_choice',
  jsonb_build_array('Der Zug hat Verspätung', 'Das Auto ist kaputt', 'Das Wetter ist schlecht', 'Die Straße ist gesperrt'),
  'Der Zug hat Verspätung', 'Der Zug kommt 20 Minuten später an.', 7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Welches Hobby hat die Person?', 'multiple_choice',
  jsonb_build_array('Schwimmen', 'Tanzen', 'Malen', 'Kochen'),
  'Kochen', 'Die Person kocht gerne am Wochenende.', 8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Wie viele Geschwister hat die Person?', 'multiple_choice',
  jsonb_build_array('Keine', 'Eins', 'Zwei', 'Drei'),
  'Zwei', 'Die Person hat einen Bruder und eine Schwester.', 9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Was möchte die Person kaufen?', 'multiple_choice',
  jsonb_build_array('Ein Buch', 'Eine Jacke', 'Schuhe', 'Eine Tasche'),
  'Eine Jacke', 'Die Person sucht eine warme Winterjacke.', 10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

-- A2 Reading Questions (10 questions)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Lies den Text: "Ich wohne seit drei Jahren in Berlin. Die Stadt gefällt mir sehr gut." Wie lange wohnt die Person in Berlin?', 'multiple_choice',
  jsonb_build_array('Ein Jahr', 'Zwei Jahre', 'Drei Jahre', 'Vier Jahre'),
  'Drei Jahre', 'Der Text sagt "seit drei Jahren".', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Was bedeutet "Ich habe keine Zeit"?', 'multiple_choice',
  jsonb_build_array('I have time', 'I have no time', 'I need time', 'I want time'),
  'I have no time', '"Keine Zeit" bedeutet "no time".', 2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Welches Wort passt? "Gestern _____ ich im Kino."', 'multiple_choice',
  jsonb_build_array('bin', 'war', 'habe', 'hatte'),
  'war', 'Präteritum von "sein" ist "war".', 3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Was ist richtig? "Ich möchte _____ Kaffee trinken."', 'multiple_choice',
  jsonb_build_array('ein', 'eine', 'einen', 'einem'),
  'einen', 'Akkusativ maskulin: "einen Kaffee".', 4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Welche Präposition ist richtig? "Ich fahre _____ Berlin."', 'multiple_choice',
  jsonb_build_array('in', 'nach', 'zu', 'bei'),
  'nach', 'Bei Städten ohne Artikel verwendet man "nach".', 5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Was bedeutet "aufstehen"?', 'multiple_choice',
  jsonb_build_array('to sit down', 'to get up', 'to lie down', 'to stand'),
  'to get up', '"Aufstehen" bedeutet "to get up" oder "to wake up".', 6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Welches Verb passt? "Ich _____ gerne Musik."', 'multiple_choice',
  jsonb_build_array('höre', 'sehe', 'lese', 'esse'),
  'höre', 'Man "hört" Musik.', 7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Was ist der Plural von "das Kind"?', 'multiple_choice',
  jsonb_build_array('die Kinder', 'die Kinds', 'die Kinden', 'die Kindern'),
  'die Kinder', 'Der Plural von "Kind" ist "Kinder".', 8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Welches Wort passt? "Das Buch ist _____ interessant."', 'multiple_choice',
  jsonb_build_array('sehr', 'viel', 'mehr', 'meist'),
  'sehr', '"Sehr" wird für Adjektive verwendet.', 9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 'Was bedeutet "umziehen"?', 'multiple_choice',
  jsonb_build_array('to move (house)', 'to change clothes', 'to travel', 'to visit'),
  'to move (house)', '"Umziehen" bedeutet "to move to a new place".', 10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

-- A2 Writing Questions (10 questions)
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 'Schreiben Sie eine E-Mail an einen Freund über Ihr letztes Wochenende (mindestens 5 Sätze).', 'essay',
  'Beispiel: Hallo Tom, wie geht es dir? Mein Wochenende war toll. Ich war im Park spazieren. Das Wetter war schön. Am Sonntag habe ich meine Familie besucht.', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 'Beschreiben Sie Ihren typischen Arbeitstag (6-8 Sätze).', 'essay',
  'Beispiel: Ich stehe um 6 Uhr auf. Dann dusche ich und frühstücke. Um 7:30 Uhr fahre ich zur Arbeit. Ich arbeite von 8 bis 17 Uhr. In der Mittagspause esse ich mit Kollegen. Nach der Arbeit gehe ich einkaufen. Abends koche ich und sehe fern.', 2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 'Schreiben Sie über Ihre Lieblingsstadt (5-7 Sätze).', 'essay',
  'Beispiel: Meine Lieblingsstadt ist Nairobi. Die Stadt ist sehr groß und modern. Es gibt viele Restaurants und Geschäfte. Die Menschen sind freundlich. Ich besuche gerne den Nationalpark. Die Stadt hat auch gute Verkehrsverbindungen.', 3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 'Schreiben Sie eine Einladung zu Ihrer Geburtstagsparty (mindestens 5 Sätze).', 'essay',
  'Beispiel: Liebe Freunde, ich lade euch zu meiner Geburtstagsparty ein. Die Party ist am Samstag, den 15. Mai. Sie beginnt um 18 Uhr. Wir feiern bei mir zu Hause. Bitte gebt mir bis Mittwoch Bescheid. Ich freue mich auf euch!', 4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 'Beschreiben Sie Ihr Lieblingsessen (4-6 Sätze).', 'essay',
  'Beispiel: Mein Lieblingsessen ist Ugali mit Sukuma Wiki. Es schmeckt sehr gut. Meine Mutter kocht es am besten. Wir essen es oft am Wochenende. Es ist ein traditionelles kenianisches Gericht.', 5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 'Schreiben Sie über Ihre Pläne für die Ferien (5-7 Sätze).', 'essay',
  'Beispiel: In den Ferien möchte ich nach Mombasa fahren. Ich will am Strand entspannen. Ich möchte auch schwimmen gehen. Vielleicht besuche ich das Fort Jesus. Ich freue mich auf die Ferien.', 6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 'Schreiben Sie eine Beschwerde über ein defektes Produkt (5-6 Sätze).', 'essay',
  'Beispiel: Sehr geehrte Damen und Herren, ich habe letzte Woche ein Handy gekauft. Leider funktioniert es nicht richtig. Der Bildschirm ist kaputt. Ich möchte das Handy umtauschen. Bitte antworten Sie mir bald. Mit freundlichen Grüßen.', 7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 'Beschreiben Sie Ihr Traumhaus (5-7 Sätze).', 'essay',
  'Beispiel: Mein Traumhaus ist groß und modern. Es hat vier Schlafzimmer und einen großen Garten. Die Küche ist hell und geräumig. Es gibt auch einen Swimmingpool. Das Haus liegt in einer ruhigen Gegend.', 8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 'Schreiben Sie über Ihren besten Freund/Ihre beste Freundin (5-6 Sätze).', 'essay',
  'Beispiel: Mein bester Freund heißt John. Wir kennen uns seit 10 Jahren. Er ist sehr lustig und hilfsbereit. Wir treffen uns oft am Wochenende. Wir spielen zusammen Fußball. Er ist ein toller Freund.', 9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 'Schreiben Sie über ein Problem in Ihrer Nachbarschaft (5-6 Sätze).', 'essay',
  'Beispiel: In meiner Nachbarschaft gibt es ein Problem. Die Straße ist sehr schmutzig. Es gibt zu viel Müll. Die Kinder können nicht draußen spielen. Wir brauchen mehr Mülleimer. Die Stadtverwaltung sollte helfen.', 10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';
