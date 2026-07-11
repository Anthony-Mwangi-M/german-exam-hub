-- A1 reference exam: Goethe-Zertifikat (Start Deutsch 1) structure for Lesen, Schreiben, Sprechen (v1, no Hören)

-- Module metadata (honest counts and durations)
UPDATE test_modules tm
SET
  title = 'A1 Lesen – Übungstest (Goethe)',
  description = '3 Teile: Richtig/Falsch, Informationen finden, Richtig/Falsch. 15 Aufgaben, 25 Minuten.',
  question_count = 15,
  duration_minutes = 25,
  exam_format = 'goethe'
FROM levels l, skills s
WHERE tm.level_id = l.id AND tm.skill_id = s.id
  AND l.code = 'A1' AND s.code = 'reading';

UPDATE test_modules tm
SET
  title = 'A1 Schreiben – Übungstest (Goethe)',
  description = '2 Teile: Formular ausfüllen, kurze Nachricht (circa 30 Wörter). 20 Minuten.',
  question_count = 2,
  duration_minutes = 20,
  exam_format = 'goethe'
FROM levels l, skills s
WHERE tm.level_id = l.id AND tm.skill_id = s.id
  AND l.code = 'A1' AND s.code = 'writing';

UPDATE test_modules tm
SET
  title = 'A1 Sprechen – Übungstest (Goethe)',
  description = '3 Teile: Sich vorstellen, Fragen & Antworten, Bitten formulieren. 15 Minuten.',
  question_count = 3,
  duration_minutes = 15,
  exam_format = 'goethe'
FROM levels l, skills s
WHERE tm.level_id = l.id AND tm.skill_id = s.id
  AND l.code = 'A1' AND s.code = 'speaking';

-- Replace A1 reading, writing, speaking questions
DELETE FROM questions WHERE test_module_id IN (
  SELECT tm.id FROM test_modules tm
  JOIN levels l ON tm.level_id = l.id
  JOIN skills s ON tm.skill_id = s.id
  WHERE l.code = 'A1' AND s.code IN ('reading', 'writing', 'speaking')
);

-- ─── LESEN (15 items, 3 Teile) ───────────────────────────────────────────────

-- Teil 1: Richtig/Falsch — zwei kurze Nachrichten
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Nachricht von Fatima:\n„Hallo! Mein Bus kommt heute später. Ich bin um 9 Uhr im Büro, nicht um 8 Uhr. Bitte sag das Herrn Müller. Bis gleich, Fatima."\n\nAussage: Fatima kommt heute um 8 Uhr.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Falsch',
  'Im Text steht: „um 9 Uhr", nicht 8 Uhr.',
  1, 1, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Nachricht von Fatima:\n„Hallo! Mein Bus kommt heute später. Ich bin um 9 Uhr im Büro, nicht um 8 Uhr. Bitte sag das Herrn Müller. Bis gleich, Fatima."\n\nAussage: Fatima möchte, dass Herr Müller Bescheid weiß.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Richtig',
  'Im Text: „Bitte sag das Herrn Müller."',
  2, 1, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Zettel in der Küche:\n„Liebe Kollegen, die Kaffeemaschine ist kaputt. Bitte keinen Kaffee mehr kochen. Ein Techniker kommt am Freitag. Danke, Herr Weber (Hausmeister)."\n\nAussage: Die Kaffeemaschine funktioniert nicht.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Richtig',
  'Im Text: „die Kaffeemaschine ist kaputt".',
  3, 1, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Zettel in der Küche:\n„Liebe Kollegen, die Kaffeemaschine ist kaputt. Bitte keinen Kaffee mehr kochen. Ein Techniker kommt am Freitag. Danke, Herr Weber (Hausmeister)."\n\nAussage: Der Techniker kommt heute.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Falsch',
  'Der Techniker kommt am Freitag, nicht heute.',
  4, 1, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Zettel in der Küche:\n„Liebe Kollegen, die Kaffeemaschine ist kaputt. Bitte keinen Kaffee mehr kochen. Ein Techniker kommt am Freitag. Danke, Herr Weber (Hausmeister)."\n\nAussage: Herr Weber ist der Hausmeister.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Richtig',
  'Im Text: „Herr Weber (Hausmeister)".',
  5, 1, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

-- Teil 2: Informationen finden (a oder b)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Sie möchten wissen, wann der Bus zum Krankenhaus fährt.\n\na) Busfahrplan an der Haltestelle\nb) Speisekarte im Restaurant\n\nWo finden Sie die Information?',
  'multiple_choice',
  jsonb_build_array('a', 'b'),
  'a',
  'Abfahrtszeiten stehen auf dem Busfahrplan, nicht auf der Speisekarte.',
  6, 2, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Sie möchten wissen, wie viel eine Fahrkarte für die U-Bahn kostet.\n\na) Preistafel am U-Bahn-Schalter\nb) Stundenplan der Deutschkurse\n\nWo finden Sie die Information?',
  'multiple_choice',
  jsonb_build_array('a', 'b'),
  'a',
  'Preise stehen auf der Preistafel am Schalter.',
  7, 2, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Sie möchten wissen, wann das Bürgeramt am Mittwoch offen hat.\n\na) Öffnungszeiten an der Tür des Bürgeramts\nb) Anzeige für eine Wohnung\n\nWo finden Sie die Information?',
  'multiple_choice',
  jsonb_build_array('a', 'b'),
  'a',
  'Öffnungszeiten stehen an der Tür des Amtes.',
  8, 2, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Sie suchen eine gebrauchte Waschmaschine, günstig.\n\na) Kleinanzeigen im Internet\nb) Speisekarte im Café\n\nWo finden Sie die Information?',
  'multiple_choice',
  jsonb_build_array('a', 'b'),
  'a',
  'Gebrauchte Geräte findet man in Kleinanzeigen.',
  9, 2, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Sie möchten wissen, wie das Wetter morgen wird.\n\na) Wetterbericht in der Zeitung\nb) Speisekarte im Restaurant\n\nWo finden Sie die Information?',
  'multiple_choice',
  jsonb_build_array('a', 'b'),
  'a',
  'Wetterinformationen stehen im Wetterbericht.',
  10, 2, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

-- Teil 3: Richtig/Falsch — öffentlicher Aushang
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Aushang am Sprachzentrum:\n„Der Deutschkurs A1 ist jetzt im Raum 204, nicht mehr im Raum 105. Der Kurs beginnt weiterhin um 18 Uhr. Bitte bringen Sie Ihr Kursbuch mit."\n\nAussage: Der Kurs ist jetzt in Raum 105.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Falsch',
  'Der Kurs ist jetzt in Raum 204.',
  11, 3, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Aushang am Sprachzentrum:\n„Der Deutschkurs A1 ist jetzt im Raum 204, nicht mehr im Raum 105. Der Kurs beginnt weiterhin um 18 Uhr. Bitte bringen Sie Ihr Kursbuch mit."\n\nAussage: Der Kurs beginnt um 18 Uhr.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Richtig',
  'Im Text: „beginnt weiterhin um 18 Uhr".',
  12, 3, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Aushang am Sprachzentrum:\n„Der Deutschkurs A1 ist jetzt im Raum 204, nicht mehr im Raum 105. Der Kurs beginnt weiterhin um 18 Uhr. Bitte bringen Sie Ihr Kursbuch mit."\n\nAussage: Man soll das Kursbuch mitbringen.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Richtig',
  'Im Text: „Bitte bringen Sie Ihr Kursbuch mit."',
  13, 3, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Aushang am Sprachzentrum:\n„Der Deutschkurs A1 ist jetzt im Raum 204, nicht mehr im Raum 105. Der Kurs beginnt weiterhin um 18 Uhr. Bitte bringen Sie Ihr Kursbuch mit."\n\nAussage: Der Kursraum hat sich geändert.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Richtig',
  'Der Raum ist jetzt 204 statt 105 — er hat sich geändert.',
  14, 3, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Aushang am Sprachzentrum:\n„Der Deutschkurs A1 ist jetzt im Raum 204, nicht mehr im Raum 105. Der Kurs beginnt weiterhin um 18 Uhr. Bitte bringen Sie Ihr Kursbuch mit."\n\nAussage: Die Uhrzeit des Kurses hat sich geändert.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Falsch',
  'Die Uhrzeit bleibt gleich (18 Uhr) — nur der Raum ändert sich.',
  15, 3, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'reading';

-- ─── SCHREIBEN (2 Teile) ─────────────────────────────────────────────────────

-- Teil 1: Formular ausfüllen
INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, leitpunkte, rubric, points
)
SELECT tm.id,
  E'Ihr Freund Samuel kommt aus Ghana und zieht in Ihre Stadt. Er sagt Ihnen: „Ich heiße Samuel Owusu. Ich komme aus Accra, Ghana. Meine neue Adresse ist Gartenstraße 12, 50667 Köln. Meine Telefonnummer ist 0176 4455 6677. Ich bin von Beruf Krankenpfleger."\n\nHelfen Sie Samuel und füllen Sie das Anmeldeformular beim Bürgeramt aus:\nName: _____\nHerkunftsland: _____\nAdresse: _____\nTelefonnummer: _____\nBeruf: _____',
  'fill_blank',
  'Name: Samuel Owusu | Herkunftsland: Ghana | Adresse: Gartenstraße 12, 50667 Köln | Telefonnummer: 0176 4455 6677 | Beruf: Krankenpfleger',
  1, 1, 'form_fill',
  '["Name korrekt übertragen","Adresse vollständig (Straße, PLZ, Ort)","Telefonnummer korrekt","Beruf korrekt"]'::jsonb,
  '{"task_achievement":"Alle fünf Felder korrekt und vollständig ausgefüllt?","coherence":"Nicht bewertet (Formular)","vocabulary":"Korrekte Übertragung der Wörter aus dem Text","grammar":"Korrekte Schreibweise von Namen und Zahlen"}'::jsonb,
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'writing';

-- Teil 2: Kurze Nachricht (circa 30 Wörter, 3 Leitpunkte)
INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, word_limit_min, word_limit_max, leitpunkte, rubric, points
)
SELECT tm.id,
  'Ihre Kollegin Anna hat morgen Geburtstag. Schreiben Sie Anna eine kurze Nachricht.',
  'essay',
  'Beispiel: Liebe Anna, herzlichen Glückwunsch zum Geburtstag! Ich wünsche dir alles Gute und viel Gesundheit. Am Samstag lade ich dich zum Kaffee ein. Hast du Zeit? Viele Grüße, …',
  2, 2, 'essay', 20, 35,
  '["Gratulieren Sie zum Geburtstag","Wünschen Sie etwas","Machen Sie einen Vorschlag (z.B. Treffen)"]'::jsonb,
  '{"task_achievement":"Alle drei Leitpunkte behandelt?","coherence":"Anrede und Gruß vorhanden","vocabulary":"Einfacher A1-Wortschatz","grammar":"Einfache Sätze, Verbposition"}'::jsonb,
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'writing';

-- ─── SPRECHEN (3 Teile) ──────────────────────────────────────────────────────

INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, rubric, points
)
SELECT tm.id,
  E'Teil 1 — Sich vorstellen\n\nStellen Sie sich mit den Stichwörtern vor:\n• Name\n• Land\n• Wohnort\n• Sprachen\n• Beruf',
  'speaking',
  'Erwartung: Kurze, einfache Sätze zu jedem Stichwort, ca. 1 Minute.',
  3, 1, 'speaking',
  '{"task_achievement":"Alle Stichwörter genannt?","coherence":"Einfache, verständliche Sätze","vocabulary":"Grundwortschatz zur eigenen Person","grammar":"Präsens, Ich-Form korrekt"}'::jsonb,
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'speaking';

INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, rubric, points
)
SELECT tm.id,
  E'Teil 2 — Fragen und Antworten\n\nThema: Ihre Arbeit\n\nStellen Sie eine Frage zum Thema und beantworten Sie auch die folgende Frage:\n„Wo arbeiten Sie?"',
  'speaking',
  'Erwartung: Eine eigene Frage zum Thema formulieren und die gestellte Frage in einem vollständigen Satz beantworten.',
  4, 2, 'speaking',
  '{"task_achievement":"Frage gestellt und Frage beantwortet?","coherence":"Vollständiger Satz","vocabulary":"Wortschatz Arbeit/Beruf","grammar":"W-Fragen, Präsens"}'::jsonb,
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'speaking';

INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, rubric, points
)
SELECT tm.id,
  E'Teil 3 — Bitten formulieren und reagieren\n\nBildkarte: Ein Fenster ist geschlossen.\n\nFormulieren Sie eine Bitte an einen Kollegen (z.B. „Bitte öffnen Sie das Fenster.") und reagieren Sie auf die Bitte eines Kollegen: „Können Sie mir bitte helfen?"',
  'speaking',
  'Erwartung: Höfliche Bitte/Aufforderung formulieren (Bitte + Imperativ oder „Können Sie...") und angemessen auf eine Bitte reagieren (zustimmen/ablehnen).',
  5, 3, 'speaking',
  '{"task_achievement":"Bitte formuliert und auf Bitte reagiert?","coherence":"Verständliche Aufforderung","vocabulary":"Alltägliche Höflichkeitsformeln","grammar":"Imperativ, Modalverb können"}'::jsonb,
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A1' AND s.code = 'speaking';
