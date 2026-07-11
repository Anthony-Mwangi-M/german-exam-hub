-- Production A2 LISTENING Questions (10 questions)
-- CEFR A2: Understanding routine information, simple announcements

DELETE FROM questions WHERE test_module_id IN (
  SELECT tm.id FROM test_modules tm
  JOIN levels l ON tm.level_id = l.id
  JOIN skills s ON tm.skill_id = s.id
  WHERE l.code = 'A2' AND s.code = 'listening'
);

-- Q1: Train announcement
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Durchsage am Bahnhof: "Der ICE nach Hamburg fährt heute von Gleis 7 statt Gleis 5 ab. Wir bitten um Entschuldigung." Was hat sich geändert?', 
  'multiple_choice',
  jsonb_build_array(
    'Das Gleis',
    'Die Uhrzeit',
    'Das Ziel',
    'Der Zugtyp'
  ),
  'Das Gleis',
  'Der Zug fährt jetzt von Gleis 7 statt Gleis 5 ab. "Statt" bedeutet "anstelle von" - das Gleis hat sich geändert.',
  1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

-- Q2: Phone message
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Mailbox: "Hallo, hier ist Anna. Ich kann heute leider nicht kommen, weil ich krank bin. Können wir uns morgen treffen?" Warum kommt Anna nicht?', 
  'multiple_choice',
  jsonb_build_array(
    'Sie ist krank',
    'Sie hat keine Zeit',
    'Sie ist im Urlaub',
    'Sie hat den Termin vergessen'
  ),
  'Sie ist krank',
  'Anna sagt direkt: "weil ich krank bin". Das ist der Grund, warum sie nicht kommen kann.',
  2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

-- Q3: Weather forecast
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Wetterbericht: "Am Wochenende wird es regnerisch und kühl. Die Temperaturen liegen zwischen 12 und 15 Grad. Nehmen Sie einen Regenschirm mit!" Was braucht man am Wochenende?', 
  'multiple_choice',
  jsonb_build_array(
    'Einen Regenschirm',
    'Eine Sonnenbrille',
    'Badekleidung',
    'Winterkleidung'
  ),
  'Einen Regenschirm',
  'Der Wetterbericht sagt "regnerisch" und empfiehlt: "Nehmen Sie einen Regenschirm mit!"',
  3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

-- Q4: Job interview
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Gespräch: "Haben Sie schon Berufserfahrung?" - "Ja, ich habe zwei Jahre in einem Hotel gearbeitet." Wo hat die Person gearbeitet?', 
  'multiple_choice',
  jsonb_build_array(
    'In einem Hotel',
    'In einem Restaurant',
    'In einem Büro',
    'In einer Schule'
  ),
  'In einem Hotel',
  'Die Person antwortet: "ich habe zwei Jahre in einem Hotel gearbeitet."',
  4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

-- Q5: Doctor appointment
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Arztpraxis: "Nehmen Sie diese Tabletten dreimal täglich nach dem Essen. Kommen Sie in einer Woche wieder." Wann soll man die Tabletten nehmen?', 
  'multiple_choice',
  jsonb_build_array(
    'Nach dem Essen',
    'Vor dem Essen',
    'Während dem Essen',
    'Ohne Essen'
  ),
  'Nach dem Essen',
  'Der Arzt sagt: "nach dem Essen". Das bedeutet, man isst zuerst und nimmt dann die Tabletten.',
  5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

-- Q6: Store hours
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Ansage: "Unser Geschäft ist montags bis freitags von 9 bis 18 Uhr geöffnet. Samstags schließen wir um 14 Uhr." Bis wann ist das Geschäft samstags geöffnet?', 
  'multiple_choice',
  jsonb_build_array(
    'Bis 14 Uhr',
    'Bis 18 Uhr',
    'Bis 9 Uhr',
    'Es ist geschlossen'
  ),
  'Bis 14 Uhr',
  'Die Ansage sagt: "Samstags schließen wir um 14 Uhr." Das bedeutet, das Geschäft ist bis 14 Uhr geöffnet.',
  6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

-- Q7: Party invitation
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Einladung: "Ich mache am Samstag eine Party. Sie beginnt um 19 Uhr. Bitte bring etwas zu trinken mit!" Was soll man mitbringen?', 
  'multiple_choice',
  jsonb_build_array(
    'Etwas zu trinken',
    'Etwas zu essen',
    'Ein Geschenk',
    'Musik'
  ),
  'Etwas zu trinken',
  'In der Einladung steht: "Bitte bring etwas zu trinken mit!" - Getränke sollen mitgebracht werden.',
  7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

-- Q8: Hotel reservation
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Telefonat: "Ich möchte ein Zimmer für zwei Personen vom 15. bis 20. Juni buchen. Mit Frühstück, bitte." Wie lange bleibt der Gast?', 
  'multiple_choice',
  jsonb_build_array(
    '5 Nächte',
    '2 Nächte',
    '15 Nächte',
    '20 Nächte'
  ),
  '5 Nächte',
  'Vom 15. bis 20. Juni sind 5 Nächte (15., 16., 17., 18., 19. Juni).',
  8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

-- Q9: Course information
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Kursinfo: "Der Deutschkurs findet dienstags und donnerstags von 18 bis 20 Uhr statt. Der Kurs kostet 200 Euro pro Monat." Wie oft ist der Kurs pro Woche?', 
  'multiple_choice',
  jsonb_build_array(
    'Zweimal',
    'Einmal',
    'Dreimal',
    'Jeden Tag'
  ),
  'Zweimal',
  'Der Kurs ist "dienstags und donnerstags" - das sind zwei Tage pro Woche.',
  9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';

-- Q10: Travel experience
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Erzählung: "Letztes Jahr war ich in Berlin. Das Wetter war schön und ich habe viele Museen besucht. Am besten hat mir das Pergamonmuseum gefallen." Was hat der Person am besten gefallen?', 
  'multiple_choice',
  jsonb_build_array(
    'Das Pergamonmuseum',
    'Das Wetter',
    'Die Stadt Berlin',
    'Alle Museen'
  ),
  'Das Pergamonmuseum',
  'Die Person sagt: "Am besten hat mir das Pergamonmuseum gefallen." Das war das Highlight.',
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';
