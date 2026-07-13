-- A2 reference exam: Goethe-Zertifikat structure for Lesen, Schreiben, Sprechen (v1, no Hören)

-- Module metadata (honest counts and durations)
UPDATE test_modules tm
SET
  title = 'A2 Lesen Übungstest (Goethe)',
  description = '4 Teile: Anzeigen zuordnen, Texte verstehen, Richtig/Falsch, Situationen zuordnen. 20 Aufgaben, 30 Minuten.',
  question_count = 20,
  duration_minutes = 30,
  exam_format = 'goethe'
FROM levels l, skills s
WHERE tm.level_id = l.id AND tm.skill_id = s.id
  AND l.code = 'A2' AND s.code = 'reading';

UPDATE test_modules tm
SET
  title = 'A2 Schreiben Übungstest (Goethe)',
  description = '2 Teile: kurze Nachricht und halbformelle E-Mail mit Leitpunkten. 30 Minuten.',
  question_count = 2,
  duration_minutes = 30,
  exam_format = 'goethe'
FROM levels l, skills s
WHERE tm.level_id = l.id AND tm.skill_id = s.id
  AND l.code = 'A2' AND s.code = 'writing';

UPDATE test_modules tm
SET
  title = 'A2 Sprechen Übungstest (Goethe)',
  description = '3 Teile: Fragen & Antworten, Präsentation, gemeinsam planen. 15 Minuten.',
  question_count = 3,
  duration_minutes = 15,
  exam_format = 'goethe'
FROM levels l, skills s
WHERE tm.level_id = l.id AND tm.skill_id = s.id
  AND l.code = 'A2' AND s.code = 'speaking';

-- Replace A2 reading, writing, speaking questions
DELETE FROM questions WHERE test_module_id IN (
  SELECT tm.id FROM test_modules tm
  JOIN levels l ON tm.level_id = l.id
  JOIN skills s ON tm.skill_id = s.id
  WHERE l.code = 'A2' AND s.code IN ('reading', 'writing', 'speaking')
);

-- ─── LESEN (15 items, 3 Teile) ───────────────────────────────────────────────

-- Teil 1: Matching (Anzeigen)
INSERT INTO questions (
  test_module_id, question_text, question_type, options, correct_answer, explanation,
  "order", exam_part, task_type, points
)
SELECT tm.id,
  E'Situation: Sie möchten am Samstag mit Ihren Kindern schwimmen.\n\nAnzeigen:\na) Schwimmbad „Aqua Fun", Sa–So 10–18 Uhr, Kinder unter 6 gratis\nb) Fitnessstudio PowerGym, nur Erwachsene, Monatskarte 49 €\nc) Deutschkurs A2, Mo–Mi 18–20 Uhr, Anmeldung online\nd) 2-Zimmer-Wohnung, 75 m², Haustiere nicht erlaubt\n\nWelche Anzeige passt?',
  'multiple_choice',
  jsonb_build_array('a) Schwimmbad „Aqua Fun"', 'b) Fitnessstudio PowerGym', 'c) Deutschkurs A2', 'd) 2-Zimmer-Wohnung'),
  'a) Schwimmbad „Aqua Fun"',
  'Nur das Schwimmbad passt zur Situation mit Kindern am Wochenende.',
  1, 1, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Situation: Sie suchen einen Nebenjob am Abend in einem Geschäft.\n\nAnzeigen:\na) Restaurant „Zur Sonne", sucht Servicekraft, nur abends und am Wochenende\nb) Büro sucht Sekretär/in, Mo–Fr 9–17 Uhr\nc) Kindergarten sucht Erzieher/in, Vollzeit\nd) Autowerkstatt, sucht Mechaniker/in mit Erfahrung\n\nWelche Anzeige passt?',
  'multiple_choice',
  jsonb_build_array('a) Restaurant „Zur Sonne"', 'b) Büro sucht Sekretär/in', 'c) Kindergarten sucht Erzieher/in', 'd) Autowerkstatt'),
  'a) Restaurant „Zur Sonne"',
  'Das Restaurant sucht Abend- und Wochenendarbeit, passend für einen Nebenjob am Abend.',
  2, 1, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Situation: Ihr Deutsch ist A2 und Sie möchten abends einen Kurs besuchen.\n\nAnzeigen:\na) Integrationskurs B1, täglich 9–12 Uhr\nb) Abendkurs Deutsch A2, Di+Do 18:30–20:30 Uhr\nc) Nachhilfe Mathematik, für Schüler\nd) Yoga für Anfänger, Sa 10 Uhr\n\nWelche Anzeige passt?',
  'multiple_choice',
  jsonb_build_array('a) Integrationskurs B1', 'b) Abendkurs Deutsch A2', 'c) Nachhilfe Mathematik', 'd) Yoga für Anfänger'),
  'b) Abendkurs Deutsch A2',
  'Der Abendkurs A2 passt zu Niveau und gewünschter Uhrzeit.',
  3, 1, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Situation: Sie haben eine kleine Katze und suchen eine Wohnung.\n\nAnzeigen:\na) WG-Zimmer, 420 € warm, Haustiere erlaubt\nb) 1-Zimmer-Wohnung, 650 €, keine Haustiere\nc) Studentenwohnheim, nur für Studierende\nd) Ferienwohnung, nur kurzfristig\n\nWelche Anzeige passt?',
  'multiple_choice',
  jsonb_build_array('a) WG-Zimmer', 'b) 1-Zimmer-Wohnung', 'c) Studentenwohnheim', 'd) Ferienwohnung'),
  'a) WG-Zimmer',
  'Nur die WG erlaubt Haustiere.',
  4, 1, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Situation: Sie möchten am Sonntag ein Museum besuchen.\n\nAnzeigen:\na) Stadtmuseum, Di–So 10–18 Uhr, Mo geschlossen\nb) Disco „Nightlife", Fr+Sa ab 22 Uhr\nc) Sprachcafé, jeden Mittwoch 19 Uhr\nd) Wochenmarkt, nur samstags 7–14 Uhr\n\nWelche Anzeige passt?',
  'multiple_choice',
  jsonb_build_array('a) Stadtmuseum', 'b) Disco „Nightlife"', 'c) Sprachcafé', 'd) Wochenmarkt'),
  'a) Stadtmuseum',
  'Das Museum ist sonntags geöffnet (Di–So).',
  5, 1, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

-- Teil 2: Multiple choice comprehension
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Arbeitsplatz-E-Mail:\n\n„Liebe Kolleginnen und Kollegen, ab nächster Woche gilt die neue Schichtplanung. Die Frühschicht beginnt um 6:00 Uhr, die Spätschicht endet um 22:00 Uhr. Bitte melden Sie Urlaub mindestens zwei Wochen vorher an. Bei Krankheit rufen Sie bitte vor 8:00 Uhr an."\n\nWann muss man Urlaub anmelden?',
  'multiple_choice',
  jsonb_build_array('Mindestens zwei Wochen vorher', 'Am selben Tag', 'Einen Monat vorher', 'Nur schriftlich per Post'),
  'Mindestens zwei Wochen vorher',
  'Im Text: „mindestens zwei Wochen vorher".',
  6, 2, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Wohnungsanzeige:\n\n„Helle 2-Zimmer-Wohnung, 58 m², Balkon, Einbauküche. Warmmiete 780 €. Kaution 1.560 €. Haustiere nach Absprache. Besichtigung jeden Donnerstag 17–19 Uhr. Schlüssel nur mit Personalausweis."\n\nWas ist über die Kaution richtig?',
  'multiple_choice',
  jsonb_build_array('Sie beträgt 1.560 €', 'Sie ist nicht nötig', 'Sie kostet 780 €', 'Man zahlt sie monatlich'),
  'Sie beträgt 1.560 €',
  'Im Text steht: „Kaution 1.560 €".',
  7, 2, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Krankenkassen-Brief:\n\n„Ihre Versicherungskarte läuft am 31. März ab. Bitte beantragen Sie online eine neue Karte. Die neue Karte ist in etwa 10 Tagen bei Ihnen. Ohne gültige Karte müssen Sie beim Arztbesuch selbst zahlen."\n\nWas passiert ohne gültige Karte?',
  'multiple_choice',
  jsonb_build_array('Man muss beim Arzt selbst zahlen', 'Man bekommt keine Medikamente', 'Die Versicherung endet sofort', 'Man muss ins Krankenhaus'),
  'Man muss beim Arzt selbst zahlen',
  'Im Text: „müssen Sie beim Arztbesuch selbst zahlen".',
  8, 2, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Fahrplan:\n\n„ICE 512: Hamburg Hbf 09:12 → Berlin Hbf 11:45, Gleis 7. Verspätung ca. 15 Minuten wegen Bauarbeiten. Reisende nach Leipzig bitte in Hannover umsteigen."\n\nWarum hat der Zug Verspätung?',
  'multiple_choice',
  jsonb_build_array('Wegen Bauarbeiten', 'Wegen schlechten Wetters', 'Wegen eines Streiks', 'Wegen eines Unfalls'),
  'Wegen Bauarbeiten',
  'Im Text: „wegen Bauarbeiten".',
  9, 2, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Einladung:\n\n„Wir feiern am 12. Juli um 15 Uhr unsere Haus-Einweihung. Adresse: Musterstraße 8. Bitte bringen Sie keine Geschenke mit, Ihre Anwesenheit ist uns Geschenk genug. Um Rückmeldung bis 5. Juli bitten wir."\n\nWas sollen die Gäste mitbringen?',
  'multiple_choice',
  jsonb_build_array('Nichts, keine Geschenke', 'Blumen und Wein', 'Essen für alle', 'Eine Karte und Geld'),
  'Nichts, keine Geschenke',
  'Im Text: „bringt Sie keine Geschenke mit".',
  10, 2, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

-- Teil 3: Richtig / Falsch (shared workplace context)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Text:\n\n„Neue Kollegin: Am Montag beginnt Frau Adebayo in unserer Pflegestation. Sie kommt aus Kenia und hat in Nairobi als Krankenpflegerin gearbeitet. Ihre Schicht ist zunächst Mo–Fr von 7:00 bis 15:00 Uhr. Am ersten Tag treffen wir uns um 8:30 Uhr in der Teeküche."\n\nAussage: Frau Adebayo hat schon in Deutschland gearbeitet.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Falsch',
  'Sie hat in Nairobi gearbeitet, nicht in Deutschland.',
  11, 3, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Text:\n\n„Neue Kollegin: Am Montag beginnt Frau Adebayo in unserer Pflegestation. Sie kommt aus Kenia und hat in Nairobi als Krankenpflegerin gearbeitet. Ihre Schicht ist zunächst Mo–Fr von 7:00 bis 15:00 Uhr. Am ersten Tag treffen wir uns um 8:30 Uhr in der Teeküche."\n\nAussage: Am ersten Tag ist ein Treffen um 8:30 Uhr geplant.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Richtig',
  'Im Text: „treffen wir uns um 8:30 Uhr".',
  12, 3, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Text:\n\n„Neue Kollegin: Am Montag beginnt Frau Adebayo in unserer Pflegestation. Sie kommt aus Kenia und hat in Nairobi als Krankenpflegerin gearbeitet. Ihre Schicht ist zunächst Mo–Fr von 7:00 bis 15:00 Uhr. Am ersten Tag treffen wir uns um 8:30 Uhr in der Teeküche."\n\nAussage: Frau Adebayo arbeitet zunächst nur am Wochenende.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Falsch',
  'Die Schicht ist Mo–Fr, nicht am Wochenende.',
  13, 3, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Text:\n\n„Neue Kollegin: Am Montag beginnt Frau Adebayo in unserer Pflegestation. Sie kommt aus Kenia und hat in Nairobi als Krankenpflegerin gearbeitet. Ihre Schicht ist zunächst Mo–Fr von 7:00 bis 15:00 Uhr. Am ersten Tag treffen wir uns um 8:30 Uhr in der Teeküche."\n\nAussage: Frau Adebayo kommt aus Kenia.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Richtig',
  'Im Text: „Sie kommt aus Kenia".',
  14, 3, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Text:\n\n„Neue Kollegin: Am Montag beginnt Frau Adebayo in unserer Pflegestation. Sie kommt aus Kenia und hat in Nairobi als Krankenpflegerin gearbeitet. Ihre Schicht ist zunächst Mo–Fr von 7:00 bis 15:00 Uhr. Am ersten Tag treffen wir uns um 8:30 Uhr in der Teeküche."\n\nAussage: Die Frühschicht endet um 15:00 Uhr.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Richtig',
  'Im Text: Schicht „von 7:00 bis 15:00 Uhr".',
  15, 3, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

-- Teil 4: Situationen den Anzeigen zuordnen (gemeinsamer Anzeigenpool a–f)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Anzeigen:\na) Nachhilfe Deutsch, Einzelunterricht, auch abends, 15 €/Stunde\nb) Second-Hand-Laden „Nochmal gut", günstige Kleidung, Mo–Sa\nc) Fahrradwerkstatt Krause, Reparatur innerhalb von 24 Stunden\nd) Volkshochschule, Computerkurs für Anfänger, Anmeldung nötig\ne) Zahnarztpraxis Dr. Berg, neue Patienten willkommen, auch ohne Termin\nf) Möbelbörse online, gebrauchte Möbel günstig kaufen und verkaufen\n\nSituation: Ihr Fahrrad hat einen Platten und Sie brauchen es morgen wieder.\nWelche Anzeige passt?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c', 'd', 'e', 'f'),
  'c',
  'Nur die Fahrradwerkstatt repariert innerhalb von 24 Stunden.',
  16, 4, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Anzeigen:\na) Nachhilfe Deutsch, Einzelunterricht, auch abends, 15 €/Stunde\nb) Second-Hand-Laden „Nochmal gut", günstige Kleidung, Mo–Sa\nc) Fahrradwerkstatt Krause, Reparatur innerhalb von 24 Stunden\nd) Volkshochschule, Computerkurs für Anfänger, Anmeldung nötig\ne) Zahnarztpraxis Dr. Berg, neue Patienten willkommen, auch ohne Termin\nf) Möbelbörse online, gebrauchte Möbel günstig kaufen und verkaufen\n\nSituation: Sie möchten am Computer besser arbeiten lernen, haben aber noch nie einen Kurs gemacht.\nWelche Anzeige passt?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c', 'd', 'e', 'f'),
  'd',
  'Der Computerkurs für Anfänger an der Volkshochschule passt genau.',
  17, 4, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Anzeigen:\na) Nachhilfe Deutsch, Einzelunterricht, auch abends, 15 €/Stunde\nb) Second-Hand-Laden „Nochmal gut", günstige Kleidung, Mo–Sa\nc) Fahrradwerkstatt Krause, Reparatur innerhalb von 24 Stunden\nd) Volkshochschule, Computerkurs für Anfänger, Anmeldung nötig\ne) Zahnarztpraxis Dr. Berg, neue Patienten willkommen, auch ohne Termin\nf) Möbelbörse online, gebrauchte Möbel günstig kaufen und verkaufen\n\nSituation: Sie haben starke Zahnschmerzen und noch keinen Arzt in der Stadt.\nWelche Anzeige passt?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c', 'd', 'e', 'f'),
  'e',
  'Die Zahnarztpraxis nimmt neue Patienten auch ohne Termin an.',
  18, 4, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Anzeigen:\na) Nachhilfe Deutsch, Einzelunterricht, auch abends, 15 €/Stunde\nb) Second-Hand-Laden „Nochmal gut", günstige Kleidung, Mo–Sa\nc) Fahrradwerkstatt Krause, Reparatur innerhalb von 24 Stunden\nd) Volkshochschule, Computerkurs für Anfänger, Anmeldung nötig\ne) Zahnarztpraxis Dr. Berg, neue Patienten willkommen, auch ohne Termin\nf) Möbelbörse online, gebrauchte Möbel günstig kaufen und verkaufen\n\nSituation: Sie ziehen bald in eine neue Wohnung und brauchen günstig einen Tisch und einen Schrank.\nWelche Anzeige passt?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c', 'd', 'e', 'f'),
  'f',
  'Die Möbelbörse bietet gebrauchte Möbel günstig an.',
  19, 4, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Anzeigen:\na) Nachhilfe Deutsch, Einzelunterricht, auch abends, 15 €/Stunde\nb) Second-Hand-Laden „Nochmal gut", günstige Kleidung, Mo–Sa\nc) Fahrradwerkstatt Krause, Reparatur innerhalb von 24 Stunden\nd) Volkshochschule, Computerkurs für Anfänger, Anmeldung nötig\ne) Zahnarztpraxis Dr. Berg, neue Patienten willkommen, auch ohne Termin\nf) Möbelbörse online, gebrauchte Möbel günstig kaufen und verkaufen\n\nSituation: Ihr Deutsch ist noch nicht gut genug und Sie möchten abends einzeln üben.\nWelche Anzeige passt?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c', 'd', 'e', 'f'),
  'a',
  'Die Nachhilfe bietet abends Einzelunterricht in Deutsch an.',
  20, 4, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'reading';

-- ─── SCHREIBEN (2 Teile) ─────────────────────────────────────────────────────

INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, word_limit_min, word_limit_max, leitpunkte, rubric, points
)
SELECT tm.id,
  'Ihre Kollegin Fatima hat Ihnen geschrieben: „Hast du am Donnerstag Zeit für eine kurze Besprechung?" Schreiben Sie Fatima eine kurze Nachricht.',
  'essay',
  'Beispiel: Hallo Fatima, ja, am Donnerstag habe ich Zeit. Vormittags bin ich im Büro, ab 14 Uhr auch. Wann passt es dir am besten? Treffen wir uns in der Kantine oder online? Schreib mir bitte die Uhrzeit. Viele Grüße, …',
  1, 1, 'essay', 20, 30,
  '["Sagen Sie, ob Sie Zeit haben","Schlagen Sie eine Uhrzeit vor","Sagen Sie, wo Sie sich treffen möchten"]'::jsonb,
  '{"task_achievement":"Alle drei Leitpunkte behandelt?","coherence":"Kurze, zusammenhängende Nachricht","vocabulary":"Informeller A2-Wortschatz","grammar":"Verbposition, Zeitangaben"}'::jsonb,
  25
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, word_limit_min, word_limit_max, leitpunkte, rubric, points
)
SELECT tm.id,
  'Sie können am Montag nicht zur Arbeit kommen, weil Sie zum Arzt müssen. Schreiben Sie eine E-Mail an Ihre Vorgesetzte, Frau Schneider.',
  'essay',
  'Beispiel: Sehr geehrte Frau Schneider, leider kann ich am Montag nicht zur Arbeit kommen, weil ich einen wichtigen Arzttermin habe. Ich werde meine Aufgaben am Dienstag erledigen. Ab Dienstag bin ich wieder im Büro. Bei Fragen erreichen Sie mich per E-Mail. Mit freundlichen Grüßen, …',
  2, 2, 'essay', 30, 40,
  '["Sagen Sie, warum Sie nicht kommen können","Sagen Sie, wann Sie wieder arbeiten können","Bieten Sie an, Aufgaben später zu erledigen"]'::jsonb,
  '{"task_achievement":"Alle drei Leitpunkte behandelt?","coherence":"Halbformelle E-Mail-Struktur (Anrede, Gruß)","vocabulary":"Berufs- und Gesundheitswortschatz A2","grammar":"Modalverben, Nebensätze mit weil"}'::jsonb,
  25
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

-- ─── SPRECHEN (3 Teile) ──────────────────────────────────────────────────────

INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, rubric, points
)
SELECT tm.id,
  E'Teil 1, Fragen und Antworten\n\nStellen Sie sich vor und beantworten Sie:\n• Wie heißen Sie und woher kommen Sie?\n• Wo wohnen Sie jetzt?\n• Was machen Sie beruflich?\n• Welche Sprachen sprechen Sie?',
  'speaking',
  'Erwartung: Name, Herkunft, Wohnort, Beruf/Studium, Sprachen, in zusammenhängenden Sätzen, ca. 2 Minuten.',
  1, 1, 'speaking',
  '{"task_achievement":"Alle Fragen beantwortet?","coherence":"Flüssige Sätze, nicht nur Stichworte","vocabulary":"A2 Alltagswortschatz","grammar":"Präsens, einfache Nebensätze"}'::jsonb,
  20
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'speaking';

INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, rubric, points
)
SELECT tm.id,
  E'Teil 2, Kurze Präsentation\n\nSprechen Sie 2 Minuten über Ihr Lieblingshobby.\n• Was ist das Hobby?\n• Wie oft machen Sie das?\n• Warum gefällt es Ihnen?',
  'speaking',
  'Erwartung: Klare Struktur (Einleitung, Details, Meinung), Zeitformen passend, ca. 2 Minuten.',
  2, 2, 'speaking',
  '{"task_achievement":"Alle Punkte behandelt?","coherence":"Logischer Aufbau der Präsentation","vocabulary":"Freizeit- und Hobbywortschatz","grammar":"Häufigkeit (oft, manchmal), weil-Sätze"}'::jsonb,
  20
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'speaking';

INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, rubric, points
)
SELECT tm.id,
  E'Teil 3, Gemeinsam planen\n\nIhr Kollege möchte am Wochenende einen Ausflug machen. Planen Sie gemeinsam:\n• Wohin möchten Sie fahren?\n• Wann treffen Sie sich?\n• Was nehmen Sie mit?\n• Wie kommen Sie hin?',
  'speaking',
  'Erwartung: Vorschläge machen, zustimmen/ablehnen, Zeit und Ort vereinbaren, Partnerdialog simuliert.',
  3, 3, 'speaking',
  '{"task_achievement":"Alle Planungspunkte besprochen?","coherence":"Fragen und Vorschläge im Dialog","vocabulary":"Reisen, Transport, Zeit","grammar":"Modalverben (können, möchten), W-Fragen"}'::jsonb,
  20
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'speaking';
