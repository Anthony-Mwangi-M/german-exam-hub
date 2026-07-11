-- Production-Ready A1 Level Questions (CEFR-Aligned)
-- Total: 20 questions (5 per skill: Listening, Reading, Writing, Speaking)

-- Delete existing A1 questions
DELETE FROM questions WHERE test_module_id IN (
  SELECT tm.id FROM test_modules tm
  JOIN levels l ON tm.level_id = l.id
  WHERE l.code = 'A1'
);

-- A1 LISTENING QUESTIONS (Hören)

-- Question 1: Basic greeting comprehension
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Sie hören: "Guten Morgen! Wie geht es Ihnen?" Was ist die beste Antwort?', 
  'multiple_choice',
  jsonb_build_array(
    'Danke, gut. Und Ihnen?',
    'Ich heiße Maria.',
    'Ich komme aus Kenia.',
    'Auf Wiedersehen!'
  ),
  'Danke, gut. Und Ihnen?',
  'Bei der Frage "Wie geht es Ihnen?" antwortet man mit dem Befinden. "Danke, gut" ist die höfliche Standardantwort, und "Und Ihnen?" zeigt Interesse am Gesprächspartner.',
  1
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'listening';

-- Question 2: Time comprehension
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Sie hören: "Der Kurs beginnt um halb neun." Wann beginnt der Kurs?', 
  'multiple_choice',
  jsonb_build_array(
    '8:30 Uhr',
    '9:30 Uhr',
    '8:00 Uhr',
    '9:00 Uhr'
  ),
  '8:30 Uhr',
  '"Halb neun" bedeutet 8:30 Uhr. Im Deutschen bezieht sich "halb" auf die kommende Stunde, nicht die vergangene.',
  2
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'listening';

-- Question 3: Shopping dialogue
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Sie hören im Supermarkt: "Das macht 15 Euro 50." Was sagt der Verkäufer?', 
  'multiple_choice',
  jsonb_build_array(
    'Den Preis',
    'Die Adresse',
    'Die Telefonnummer',
    'Die Öffnungszeiten'
  ),
  'Den Preis',
  'Die Formulierung "Das macht..." wird beim Einkaufen verwendet, um den Gesamtpreis anzugeben.',
  3
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'listening';

-- Question 4: Family introduction
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Sie hören: "Das ist meine Schwester Anna. Sie ist 25 Jahre alt." Wer ist Anna?', 
  'multiple_choice',
  jsonb_build_array(
    'Die Schwester',
    'Die Mutter',
    'Die Tochter',
    'Die Freundin'
  ),
  'Die Schwester',
  'Im Text wird direkt gesagt: "Das ist meine Schwester Anna."',
  4
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'listening';

-- Question 5: Weather information
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Sie hören: "Heute ist es sonnig und warm, 25 Grad." Wie ist das Wetter?', 
  'multiple_choice',
  jsonb_build_array(
    'Sonnig und warm',
    'Kalt und regnerisch',
    'Bewölkt und kühl',
    'Windig und kalt'
  ),
  'Sonnig und warm',
  'Die Wetterinformation wird direkt genannt: "sonnig und warm, 25 Grad".',
  5
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'listening';

-- A1 READING QUESTIONS (Lesen)

-- Question 1: Simple email
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Lesen Sie die E-Mail: "Hallo Maria, ich komme morgen um 14 Uhr. Bis dann, Peter." Wann kommt Peter?', 
  'multiple_choice',
  jsonb_build_array(
    'Morgen um 14 Uhr',
    'Heute um 14 Uhr',
    'Morgen um 4 Uhr',
    'Übermorgen um 14 Uhr'
  ),
  'Morgen um 14 Uhr',
  'Im Text steht: "ich komme morgen um 14 Uhr". "Morgen" bedeutet der nächste Tag, "14 Uhr" ist 2 Uhr nachmittags.',
  1
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

-- Question 2: Restaurant menu
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Speisekarte: "Schnitzel mit Pommes - 12€, Salat - 6€, Pizza - 10€". Was kostet das Schnitzel?', 
  'multiple_choice',
  jsonb_build_array(
    '12 Euro',
    '6 Euro',
    '10 Euro',
    '18 Euro'
  ),
  '12 Euro',
  'Auf der Speisekarte steht: "Schnitzel mit Pommes - 12€".',
  2
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

-- Question 3: Apartment ad
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Anzeige: "2-Zimmer-Wohnung, 50 m², Miete 800€, zentral gelegen". Wie viele Zimmer hat die Wohnung?', 
  'multiple_choice',
  jsonb_build_array(
    '2 Zimmer',
    '50 Zimmer',
    '800 Zimmer',
    '1 Zimmer'
  ),
  '2 Zimmer',
  'In der Anzeige steht "2-Zimmer-Wohnung", das bedeutet die Wohnung hat 2 Zimmer.',
  3
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

-- Question 4: Train schedule
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Fahrplan: "Berlin - München, Abfahrt 10:30, Ankunft 16:45". Wann fährt der Zug ab?', 
  'multiple_choice',
  jsonb_build_array(
    '10:30 Uhr',
    '16:45 Uhr',
    '10:45 Uhr',
    '16:30 Uhr'
  ),
  '10:30 Uhr',
  '"Abfahrt" bedeutet, wann der Zug losfährt. Im Fahrplan steht: "Abfahrt 10:30".',
  4
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

-- Question 5: Personal information
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Text: "Ich heiße Tom. Ich bin 30 Jahre alt und wohne in Berlin. Ich arbeite als Lehrer." Was ist Toms Beruf?', 
  'multiple_choice',
  jsonb_build_array(
    'Lehrer',
    'Arzt',
    'Student',
    'Koch'
  ),
  'Lehrer',
  'Im Text steht: "Ich arbeite als Lehrer." Das ist Toms Beruf.',
  5
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

-- A1 WRITING QUESTIONS (Schreiben)

-- Question 1: Personal introduction
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie eine kurze Vorstellung (4-5 Sätze): Name, Alter, Herkunft, Beruf/Studium. Beispiel: "Ich heiße..., ich bin... Jahre alt..."', 
  'essay',
  'Beispielantwort: Ich heiße Sarah. Ich bin 25 Jahre alt. Ich komme aus Nairobi, Kenia. Ich studiere Medizin an der Universität. Ich lerne Deutsch, weil ich in Deutschland arbeiten möchte.',
  1
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'writing';

-- Question 2: Simple email
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie eine kurze E-Mail an einen Freund. Laden Sie ihn zum Kaffee ein. Nennen Sie: Tag, Uhrzeit, Ort. (3-4 Sätze)', 
  'essay',
  'Beispielantwort: Hallo Peter, wie geht es dir? Hast du am Samstag Zeit? Wir können um 15 Uhr Kaffee trinken. Treffen wir uns im Café Central? Bis bald, Maria',
  2
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'writing';

-- Question 3: Shopping list
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie eine Einkaufsliste für ein Frühstück (mindestens 5 Produkte). Beispiel: Brot, Butter...', 
  'essay',
  'Beispielantwort: Brot, Butter, Marmelade, Käse, Milch, Eier, Orangensaft, Kaffee',
  3
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'writing';

-- Question 4: Daily routine
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Beschreiben Sie Ihren Tagesablauf (4-5 Sätze). Wann stehen Sie auf? Was machen Sie? Beispiel: "Ich stehe um 7 Uhr auf..."', 
  'essay',
  'Beispielantwort: Ich stehe um 7 Uhr auf. Dann frühstücke ich. Um 8 Uhr fahre ich zur Arbeit. Ich arbeite von 9 bis 17 Uhr. Abends koche ich und sehe fern.',
  4
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'writing';

-- Question 5: Family description
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie über Ihre Familie (4-5 Sätze). Wie viele Personen? Namen? Was machen sie? Beispiel: "Meine Familie hat..."', 
  'essay',
  'Beispielantwort: Meine Familie hat vier Personen. Mein Vater heißt John und ist Lehrer. Meine Mutter heißt Grace und arbeitet als Krankenschwester. Ich habe einen Bruder. Er heißt David und ist Student.',
  5
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'writing';

-- A1 SPEAKING QUESTIONS (Sprechen)

-- Question 1: Self-introduction
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Stellen Sie sich vor: Name, Alter, Herkunft, Sprachen, Hobbys. Sprechen Sie 1-2 Minuten.', 
  'essay',
  'Bewertungskriterien: Vollständige Informationen (Name, Alter, Herkunft), verständliche Aussprache, einfache Sätze, Grundwortschatz korrekt verwendet.',
  1
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'speaking';

-- Question 2: Ordering food
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sie sind im Restaurant. Bestellen Sie etwas zu essen und zu trinken. Was sagen Sie zum Kellner?', 
  'essay',
  'Beispielantwort: "Guten Tag! Ich möchte bitte ein Schnitzel mit Pommes und einen Orangensaft. Danke!"',
  2
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'speaking';

-- Question 3: Asking for directions
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sie suchen den Bahnhof. Fragen Sie jemanden auf der Straße nach dem Weg.', 
  'essay',
  'Beispielantwort: "Entschuldigung, wo ist der Bahnhof? Können Sie mir helfen? Ist es weit von hier?"',
  3
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'speaking';

-- Question 4: Shopping dialogue
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sie kaufen im Supermarkt ein. Sie brauchen Brot, Milch und Äpfel. Was sagen Sie?', 
  'essay',
  'Beispielantwort: "Guten Tag! Ich brauche ein Brot, eine Flasche Milch und ein Kilo Äpfel. Was kostet das? Danke!"',
  4
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'speaking';

-- Question 5: Making an appointment
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sie möchten einen Termin beim Arzt machen. Rufen Sie an. Was sagen Sie?', 
  'essay',
  'Beispielantwort: "Guten Tag! Ich möchte einen Termin machen. Haben Sie am Montag Zeit? Um 10 Uhr? Ja, das passt. Vielen Dank!"',
  5
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'speaking';
