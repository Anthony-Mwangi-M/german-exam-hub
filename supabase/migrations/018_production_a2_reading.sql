-- Production A2 READING Questions (10 questions)

DELETE FROM questions WHERE test_module_id IN (
  SELECT tm.id FROM test_modules tm
  JOIN levels l ON tm.level_id = l.id
  JOIN skills s ON tm.skill_id = s.id
  WHERE l.code = 'A2' AND s.code = 'reading'
);

-- Q1: Email about vacation
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'E-Mail: "Liebe Maria, ich war letzte Woche in München. Die Stadt ist wunderschön! Ich habe das Schloss Neuschwanstein besucht und viel bayerisches Essen probiert. Nächstes Jahr möchte ich wieder nach Deutschland fahren. Liebe Grüße, Tom" Was hat Tom gemacht?', 
  'multiple_choice',
  jsonb_build_array(
    'Eine Reise nach München',
    'Einen Deutschkurs besucht',
    'In München gearbeitet',
    'Bei Maria gewohnt'
  ),
  'Eine Reise nach München',
  'Tom schreibt über seinen Besuch in München: "ich war letzte Woche in München" und beschreibt seine Aktivitäten dort.',
  1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

-- Q2: Job advertisement
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Stellenanzeige: "Restaurant sucht Kellner/in. Arbeitszeit: Abends und am Wochenende. Gute Deutschkenntnisse erforderlich. Erfahrung nicht notwendig. Bewerbung an: info@restaurant.de" Was ist NICHT erforderlich?', 
  'multiple_choice',
  jsonb_build_array(
    'Berufserfahrung',
    'Deutschkenntnisse',
    'Arbeit am Wochenende',
    'Eine Bewerbung'
  ),
  'Berufserfahrung',
  'In der Anzeige steht: "Erfahrung nicht notwendig" - man braucht keine Berufserfahrung.',
  2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

-- Q3: Apartment description
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Wohnungsanzeige: "Schöne 3-Zimmer-Wohnung im 2. Stock, 75 m², mit Balkon. Küche und Bad renoviert. Miete: 950€ + Nebenkosten. Haustiere nicht erlaubt. Ruhige Lage, 5 Minuten zur U-Bahn." Was ist in der Wohnung NICHT erlaubt?', 
  'multiple_choice',
  jsonb_build_array(
    'Haustiere',
    'Kinder',
    'Rauchen',
    'Besucher'
  ),
  'Haustiere',
  'In der Anzeige steht explizit: "Haustiere nicht erlaubt".',
  3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

-- Q4: Course schedule
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Kursplan: "Integrationskurs B1: Mo-Fr, 9:00-12:30 Uhr. Dauer: 8 Wochen. Preis: 390€ (mit Berechtigung 195€). Anmeldung bis 1. März. Kursbeginn: 15. März." Wie lange dauert der Kurs?', 
  'multiple_choice',
  jsonb_build_array(
    '8 Wochen',
    '1 Monat',
    '12 Wochen',
    '3 Monate'
  ),
  '8 Wochen',
  'Im Kursplan steht: "Dauer: 8 Wochen".',
  4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

-- Q5: Restaurant review
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Bewertung: "Das Restaurant ist sehr gemütlich und das Personal ist freundlich. Das Essen schmeckt gut, aber es ist etwas teuer. Die Portionen sind klein. Ich komme trotzdem gerne wieder." Was findet der Autor negativ?', 
  'multiple_choice',
  jsonb_build_array(
    'Der Preis und die Portionsgröße',
    'Das Personal',
    'Die Atmosphäre',
    'Der Geschmack'
  ),
  'Der Preis und die Portionsgröße',
  'Der Autor kritisiert: "es ist etwas teuer" und "Die Portionen sind klein" - das sind die negativen Punkte.',
  5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

-- Q6: Museum information
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Museumsinfo: "Öffnungszeiten: Di-So 10-18 Uhr, montags geschlossen. Eintritt: Erwachsene 12€, Studenten 8€, Kinder unter 12 Jahren frei. Führungen um 11 und 15 Uhr." Wann ist das Museum geschlossen?', 
  'multiple_choice',
  jsonb_build_array(
    'Montags',
    'Sonntags',
    'Dienstags',
    'Jeden Tag um 18 Uhr'
  ),
  'Montags',
  'In der Information steht: "montags geschlossen".',
  6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

-- Q7: Weather report
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Wetterbericht: "Diese Woche bleibt es warm und trocken. Am Montag und Dienstag scheint die Sonne bei 28 Grad. Ab Mittwoch wird es bewölkt, aber es bleibt warm mit 25 Grad. Regen ist nicht zu erwarten." Wann wird es bewölkt?', 
  'multiple_choice',
  jsonb_build_array(
    'Ab Mittwoch',
    'Am Montag',
    'Am Dienstag',
    'Die ganze Woche'
  ),
  'Ab Mittwoch',
  'Der Bericht sagt: "Ab Mittwoch wird es bewölkt".',
  7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

-- Q8: Train ticket information
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Fahrkarte: "Berlin Hbf → München Hbf. Abfahrt: 10:15, Ankunft: 16:42. ICE 123, Wagen 5, Platz 42. Preis: 89€. Nicht erstattbar." Was bedeutet "nicht erstattbar"?', 
  'multiple_choice',
  jsonb_build_array(
    'Man bekommt kein Geld zurück',
    'Man kann nicht umsteigen',
    'Man kann nicht reservieren',
    'Man muss mehr bezahlen'
  ),
  'Man bekommt kein Geld zurück',
  '"Nicht erstattbar" bedeutet, dass man bei Stornierung das Geld nicht zurückbekommt.',
  8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

-- Q9: Invitation card
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Einladung: "Wir heiraten! Samstag, 20. Juni, 14 Uhr, Standesamt Mitte. Anschließend Feier im Restaurant Seeblick. Um Antwort bis 1. Juni wird gebeten. Lisa & Michael" Bis wann soll man antworten?', 
  'multiple_choice',
  jsonb_build_array(
    'Bis 1. Juni',
    'Bis 20. Juni',
    'Bis 14 Uhr',
    'Sofort'
  ),
  'Bis 1. Juni',
  'In der Einladung steht: "Um Antwort bis 1. Juni wird gebeten".',
  9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

-- Q10: Health insurance letter
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Brief: "Sehr geehrte Frau Müller, Ihre Krankenversicherung läuft am 31.12. aus. Bitte überweisen Sie den Beitrag von 180€ bis zum 15.12., damit die Versicherung weiterläuft. Mit freundlichen Grüßen" Was soll Frau Müller tun?', 
  'multiple_choice',
  jsonb_build_array(
    '180€ bis 15.12. überweisen',
    'Einen neuen Vertrag unterschreiben',
    'Zum Arzt gehen',
    'Die Versicherung kündigen'
  ),
  '180€ bis 15.12. überweisen',
  'Im Brief steht: "Bitte überweisen Sie den Beitrag von 180€ bis zum 15.12."',
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';
