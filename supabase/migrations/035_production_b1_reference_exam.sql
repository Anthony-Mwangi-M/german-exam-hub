-- B1 reference exam: Goethe-Zertifikat B1 structure for Lesen, Schreiben, Sprechen (v1, no Hören)

-- Module metadata (honest counts and durations)
UPDATE test_modules tm
SET
  title = 'B1 Lesen – Übungstest (Goethe)',
  description = '5 Teile: Richtig/Falsch, Multiple Choice, Anzeigen zuordnen, Meinungen zuordnen, Multiple Choice. 18 Aufgaben, 65 Minuten.',
  question_count = 18,
  duration_minutes = 65,
  exam_format = 'goethe'
FROM levels l, skills s
WHERE tm.level_id = l.id AND tm.skill_id = s.id
  AND l.code = 'B1' AND s.code = 'reading';

UPDATE test_modules tm
SET
  title = 'B1 Schreiben – Übungstest (Goethe)',
  description = '3 Aufgaben: informelle E-Mail, Meinung im Forum, formeller Brief. 60 Minuten.',
  question_count = 3,
  duration_minutes = 60,
  exam_format = 'goethe'
FROM levels l, skills s
WHERE tm.level_id = l.id AND tm.skill_id = s.id
  AND l.code = 'B1' AND s.code = 'writing';

UPDATE test_modules tm
SET
  title = 'B1 Sprechen – Übungstest (Goethe)',
  description = '3 Teile: gemeinsam planen, Präsentation halten, Feedback geben. 15 Minuten.',
  question_count = 3,
  duration_minutes = 15,
  exam_format = 'goethe'
FROM levels l, skills s
WHERE tm.level_id = l.id AND tm.skill_id = s.id
  AND l.code = 'B1' AND s.code = 'speaking';

-- Replace B1 reading, writing, speaking questions
DELETE FROM questions WHERE test_module_id IN (
  SELECT tm.id FROM test_modules tm
  JOIN levels l ON tm.level_id = l.id
  JOIN skills s ON tm.skill_id = s.id
  WHERE l.code = 'B1' AND s.code IN ('reading', 'writing', 'speaking')
);

-- ─── LESEN (18 items, 5 Teile) ───────────────────────────────────────────────

-- Teil 1: Richtig/Falsch — Blogeintrag
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Blogeintrag:\n\n„Mein erster Arbeitstag in der Klinik. Ich war so nervös! Meine Stationsleitung, Frau Keller, hat mir alles genau gezeigt: die Zimmer, die Medikamentenschränke, die Übergabe am Morgen. Zuerst habe ich viele Namen vergessen, aber die Kollegen waren geduldig. Am Nachmittag durfte ich schon bei einer Patientin die Blutdruckmessung übernehmen — unter Aufsicht natürlich. Ich bin froh, dass ich mich für diese Ausbildung entschieden habe, auch wenn am Anfang vieles neu und anstrengend war."\n\nAussage: Die Autorin/der Autor war am ersten Tag ruhig und entspannt.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Falsch',
  'Im Text: „Ich war so nervös!" — das Gegenteil von entspannt.',
  1, 1, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Blogeintrag:\n\n„Mein erster Arbeitstag in der Klinik. Ich war so nervös! Meine Stationsleitung, Frau Keller, hat mir alles genau gezeigt: die Zimmer, die Medikamentenschränke, die Übergabe am Morgen. Zuerst habe ich viele Namen vergessen, aber die Kollegen waren geduldig. Am Nachmittag durfte ich schon bei einer Patientin die Blutdruckmessung übernehmen — unter Aufsicht natürlich. Ich bin froh, dass ich mich für diese Ausbildung entschieden habe, auch wenn am Anfang vieles neu und anstrengend war."\n\nAussage: Die Kollegen waren ungeduldig, weil Namen vergessen wurden.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Falsch',
  'Im Text: „die Kollegen waren geduldig".',
  2, 1, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Blogeintrag:\n\n„Mein erster Arbeitstag in der Klinik. Ich war so nervös! Meine Stationsleitung, Frau Keller, hat mir alles genau gezeigt: die Zimmer, die Medikamentenschränke, die Übergabe am Morgen. Zuerst habe ich viele Namen vergessen, aber die Kollegen waren geduldig. Am Nachmittag durfte ich schon bei einer Patientin die Blutdruckmessung übernehmen — unter Aufsicht natürlich. Ich bin froh, dass ich mich für diese Ausbildung entschieden habe, auch wenn am Anfang vieles neu und anstrengend war."\n\nAussage: Am Nachmittag durfte die Autorin/der Autor allein und ohne Aufsicht arbeiten.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Falsch',
  'Im Text steht ausdrücklich „unter Aufsicht natürlich".',
  3, 1, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Blogeintrag:\n\n„Mein erster Arbeitstag in der Klinik. Ich war so nervös! Meine Stationsleitung, Frau Keller, hat mir alles genau gezeigt: die Zimmer, die Medikamentenschränke, die Übergabe am Morgen. Zuerst habe ich viele Namen vergessen, aber die Kollegen waren geduldig. Am Nachmittag durfte ich schon bei einer Patientin die Blutdruckmessung übernehmen — unter Aufsicht natürlich. Ich bin froh, dass ich mich für diese Ausbildung entschieden habe, auch wenn am Anfang vieles neu und anstrengend war."\n\nAussage: Die Autorin/der Autor bereut die Entscheidung für die Ausbildung.',
  'multiple_choice',
  jsonb_build_array('Richtig', 'Falsch'),
  'Falsch',
  'Im Text: „Ich bin froh, dass ich mich für diese Ausbildung entschieden habe".',
  4, 1, 'true_false', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- Teil 2: Multiple Choice (a/b/c) — Zeitungsartikel
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Zeitungsartikel:\n\n„Fachkräftemangel in der Pflege: Immer mehr deutsche Kliniken stellen internationale Pflegekräfte ein. Laut einer aktuellen Studie fehlen bis 2030 rund 500.000 Pflegekräfte in Deutschland. Viele Krankenhäuser bieten deshalb spezielle Programme an: Sprachkurse, Anerkennungshilfe für ausländische Abschlüsse und Unterstützung bei der Wohnungssuche. Kritiker bemängeln jedoch, dass die Integration am Arbeitsplatz oft zu wenig begleitet wird und viele neue Kolleginnen und Kollegen sich am Anfang allein gelassen fühlen."\n\nWas ist laut Text ein Problem bei der Integration?',
  'multiple_choice',
  jsonb_build_array('Die Begleitung am Arbeitsplatz ist oft unzureichend.', 'Es gibt zu viele Sprachkurse.', 'Die Wohnungssuche ist nicht nötig.', 'Es gibt keine internationalen Pflegekräfte.'),
  'Die Begleitung am Arbeitsplatz ist oft unzureichend.',
  'Im Text: „die Integration am Arbeitsplatz oft zu wenig begleitet wird".',
  5, 2, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Zeitungsartikel:\n\n„Fachkräftemangel in der Pflege: Immer mehr deutsche Kliniken stellen internationale Pflegekräfte ein. Laut einer aktuellen Studie fehlen bis 2030 rund 500.000 Pflegekräfte in Deutschland. Viele Krankenhäuser bieten deshalb spezielle Programme an: Sprachkurse, Anerkennungshilfe für ausländische Abschlüsse und Unterstützung bei der Wohnungssuche. Kritiker bemängeln jedoch, dass die Integration am Arbeitsplatz oft zu wenig begleitet wird und viele neue Kolleginnen und Kollegen sich am Anfang allein gelassen fühlen."\n\nWie viele Pflegekräfte fehlen laut Studie bis 2030?',
  'multiple_choice',
  jsonb_build_array('Etwa 500.000', 'Etwa 50.000', 'Etwa 5.000', 'Die Zahl steht nicht im Text.'),
  'Etwa 500.000',
  'Im Text: „rund 500.000 Pflegekräfte".',
  6, 2, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Zeitungsartikel:\n\n„Fachkräftemangel in der Pflege: Immer mehr deutsche Kliniken stellen internationale Pflegekräfte ein. Laut einer aktuellen Studie fehlen bis 2030 rund 500.000 Pflegekräfte in Deutschland. Viele Krankenhäuser bieten deshalb spezielle Programme an: Sprachkurse, Anerkennungshilfe für ausländische Abschlüsse und Unterstützung bei der Wohnungssuche. Kritiker bemängeln jedoch, dass die Integration am Arbeitsplatz oft zu wenig begleitet wird und viele neue Kolleginnen und Kollegen sich am Anfang allein gelassen fühlen."\n\nWas bieten viele Krankenhäuser NICHT an?',
  'multiple_choice',
  jsonb_build_array('Ein garantiertes Auto', 'Sprachkurse', 'Anerkennungshilfe für Abschlüsse', 'Unterstützung bei der Wohnungssuche'),
  'Ein garantiertes Auto',
  'Autos werden im Text nicht erwähnt; die anderen drei Angebote schon.',
  7, 2, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- Teil 3: Anzeigen zuordnen (gemeinsamer Anzeigenpool a–f)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Anzeigen:\na) Krankenkasse „GesundPlus" — Sonderkonditionen für Berufseinsteiger, Beratung auf Englisch möglich\nb) Abendkurs „Deutsch für den Beruf" B1–B2, Mo+Mi 19–21 Uhr\nc) WG-Zimmer nahe Klinikum — 380 € warm, ruhige Lage\nd) Fitnessstudio „PowerFit" — 24/7 geöffnet, Probetraining kostenlos\ne) Umzugsservice „Schnell & Sicher" — auch am Wochenende\nf) Steuerberatung für internationale Fachkräfte — erste Beratung kostenlos\n\nSituation: Sie ziehen nächste Woche um und brauchen samstags Hilfe.\nWelche Anzeige passt?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c', 'd', 'e', 'f'),
  'e',
  'Nur der Umzugsservice bietet ausdrücklich Hilfe am Wochenende.',
  8, 3, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Anzeigen:\na) Krankenkasse „GesundPlus" — Sonderkonditionen für Berufseinsteiger, Beratung auf Englisch möglich\nb) Abendkurs „Deutsch für den Beruf" B1–B2, Mo+Mi 19–21 Uhr\nc) WG-Zimmer nahe Klinikum — 380 € warm, ruhige Lage\nd) Fitnessstudio „PowerFit" — 24/7 geöffnet, Probetraining kostenlos\ne) Umzugsservice „Schnell & Sicher" — auch am Wochenende\nf) Steuerberatung für internationale Fachkräfte — erste Beratung kostenlos\n\nSituation: Sie möchten Ihr berufliches Deutsch verbessern und arbeiten tagsüber.\nWelche Anzeige passt?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c', 'd', 'e', 'f'),
  'b',
  'Der Abendkurs findet nach der Arbeitszeit statt (19–21 Uhr).',
  9, 3, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Anzeigen:\na) Krankenkasse „GesundPlus" — Sonderkonditionen für Berufseinsteiger, Beratung auf Englisch möglich\nb) Abendkurs „Deutsch für den Beruf" B1–B2, Mo+Mi 19–21 Uhr\nc) WG-Zimmer nahe Klinikum — 380 € warm, ruhige Lage\nd) Fitnessstudio „PowerFit" — 24/7 geöffnet, Probetraining kostenlos\ne) Umzugsservice „Schnell & Sicher" — auch am Wochenende\nf) Steuerberatung für internationale Fachkräfte — erste Beratung kostenlos\n\nSituation: Sie fangen bald im Klinikum an und suchen ein günstiges Zimmer in der Nähe.\nWelche Anzeige passt?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c', 'd', 'e', 'f'),
  'c',
  'Das WG-Zimmer liegt in der Nähe des Klinikums und ist günstig.',
  10, 3, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Anzeigen:\na) Krankenkasse „GesundPlus" — Sonderkonditionen für Berufseinsteiger, Beratung auf Englisch möglich\nb) Abendkurs „Deutsch für den Beruf" B1–B2, Mo+Mi 19–21 Uhr\nc) WG-Zimmer nahe Klinikum — 380 € warm, ruhige Lage\nd) Fitnessstudio „PowerFit" — 24/7 geöffnet, Probetraining kostenlos\ne) Umzugsservice „Schnell & Sicher" — auch am Wochenende\nf) Steuerberatung für internationale Fachkräfte — erste Beratung kostenlos\n\nSituation: Sie sind neu in Deutschland und müssen sich zum ersten Mal krankenversichern.\nWelche Anzeige passt?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c', 'd', 'e', 'f'),
  'a',
  'Die Krankenkasse richtet sich ausdrücklich an Berufseinsteiger, mit Beratung auf Englisch.',
  11, 3, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- Teil 4: Meinungen zuordnen (4 Personen, dafür/dagegen)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Thema: Sollten Großraumbüros abgeschafft werden?\n\nPerson Timo: „Ich finde Großraumbüros schrecklich. Es ist immer laut, ich kann mich nicht konzentrieren und werde ständig unterbrochen. Ich arbeite viel lieber allein in einem ruhigen Raum."\n\nIst Timo für oder gegen Großraumbüros?',
  'multiple_choice',
  jsonb_build_array('Dafür', 'Dagegen'),
  'Dagegen',
  'Timo nennt nur negative Punkte (laut, keine Konzentration) — er ist dagegen.',
  12, 4, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Thema: Sollten Großraumbüros abgeschafft werden?\n\nPerson Larissa: „Ich finde Großraumbüros gut, weil man schnell mit Kollegen sprechen kann. Der Austausch ist einfacher, und man fühlt sich weniger isoliert als in einem Einzelbüro."\n\nIst Larissa für oder gegen Großraumbüros?',
  'multiple_choice',
  jsonb_build_array('Dafür', 'Dagegen'),
  'Dafür',
  'Larissa nennt Vorteile (schneller Austausch, weniger Isolation) — sie ist dafür.',
  13, 4, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Thema: Sollten Großraumbüros abgeschafft werden?\n\nPerson Bruno: „Es kommt darauf an. Für manche Aufgaben ist ein Großraumbüro praktisch, für konzentrierte Arbeit brauche ich aber Ruhe. Am besten wäre eine Mischung aus beidem."\n\nIst Bruno eindeutig dafür oder dagegen?',
  'multiple_choice',
  jsonb_build_array('Dafür', 'Dagegen', 'Weder eindeutig dafür noch dagegen'),
  'Weder eindeutig dafür noch dagegen',
  'Bruno sieht Vor- und Nachteile und wünscht sich eine Mischung — keine eindeutige Position.',
  14, 4, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Thema: Sollten Großraumbüros abgeschafft werden?\n\nPerson Aylin: „Absolut abschaffen! Studien zeigen, dass die Produktivität in Großraumbüros sinkt. Ich unterschreibe sofort jede Petition dagegen."\n\nIst Aylin für oder gegen Großraumbüros?',
  'multiple_choice',
  jsonb_build_array('Dafür', 'Dagegen'),
  'Dagegen',
  'Aylin fordert die Abschaffung ausdrücklich — klar dagegen.',
  15, 4, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- Teil 5: Multiple Choice — betriebliche Anweisung
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Betriebsordnung (Auszug):\n\n„§4 Arbeitszeiten: Die vereinbarten Schichten sind verbindlich. Tauschwünsche müssen mindestens 48 Stunden vorher mit der Schichtleitung abgesprochen werden. §7 Krankmeldung: Bei Krankheit ist die Vorgesetzte spätestens 30 Minuten vor Schichtbeginn telefonisch zu informieren. Eine Krankschreibung ist ab dem dritten Krankheitstag vorzulegen."\n\nWann muss spätestens eine Krankschreibung vorgelegt werden?',
  'multiple_choice',
  jsonb_build_array('Ab dem dritten Krankheitstag', 'Ab dem ersten Krankheitstag', 'Erst nach einer Woche', 'Gar nicht nötig'),
  'Ab dem dritten Krankheitstag',
  'Im Text: „ab dem dritten Krankheitstag".',
  16, 5, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Betriebsordnung (Auszug):\n\n„§4 Arbeitszeiten: Die vereinbarten Schichten sind verbindlich. Tauschwünsche müssen mindestens 48 Stunden vorher mit der Schichtleitung abgesprochen werden. §7 Krankmeldung: Bei Krankheit ist die Vorgesetzte spätestens 30 Minuten vor Schichtbeginn telefonisch zu informieren. Eine Krankschreibung ist ab dem dritten Krankheitstag vorzulegen."\n\nWie lange vorher muss ein Schichttausch abgesprochen werden?',
  'multiple_choice',
  jsonb_build_array('Mindestens 48 Stunden vorher', 'Mindestens eine Woche vorher', 'Am selben Tag', 'Es gibt keine Frist'),
  'Mindestens 48 Stunden vorher',
  'Im Text: „mindestens 48 Stunden vorher".',
  17, 5, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Betriebsordnung (Auszug):\n\n„§4 Arbeitszeiten: Die vereinbarten Schichten sind verbindlich. Tauschwünsche müssen mindestens 48 Stunden vorher mit der Schichtleitung abgesprochen werden. §7 Krankmeldung: Bei Krankheit ist die Vorgesetzte spätestens 30 Minuten vor Schichtbeginn telefonisch zu informieren. Eine Krankschreibung ist ab dem dritten Krankheitstag vorzulegen."\n\nWie soll eine Krankmeldung erfolgen?',
  'multiple_choice',
  jsonb_build_array('Telefonisch, spätestens 30 Minuten vor Schichtbeginn', 'Per E-Mail, am Vortag', 'Gar nicht nötig', 'Nur schriftlich per Post'),
  'Telefonisch, spätestens 30 Minuten vor Schichtbeginn',
  'Im Text: „telefonisch zu informieren", „spätestens 30 Minuten vor Schichtbeginn".',
  18, 5, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- ─── SCHREIBEN (3 Aufgaben) ──────────────────────────────────────────────────

-- Aufgabe 1: Informelle E-Mail (circa 80 Wörter)
INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, word_limit_min, word_limit_max, leitpunkte, rubric, points
)
SELECT tm.id,
  'Erzählen Sie einer Freundin oder einem Freund von Ihrem ersten Arbeitstag in Deutschland. Schreiben Sie eine informelle E-Mail (circa 80 Wörter).',
  'essay',
  'Beispiel: Liebe Amara, du fragst, wie mein erster Arbeitstag war — total aufregend! Ich war morgens sehr nervös, aber meine Kollegen waren total nett und haben mir alles gezeigt. Am schwierigsten war es, mir so viele neue Namen zu merken. Mittags haben wir zusammen in der Kantine gegessen, das war schön. Am Nachmittag durfte ich schon erste Aufgaben übernehmen. Ich glaube, das wird ein guter Job für mich. Ich erzähle dir mehr, wenn wir telefonieren! Viele Grüße, …',
  1, 1, 'essay', 70, 90,
  '["Beschreiben Sie Ihre Gefühle am ersten Tag","Berichten Sie von einem konkreten Ereignis","Sagen Sie, wie es weitergeht"]'::jsonb,
  '{"task_achievement":"Alle drei Leitpunkte behandelt?","coherence":"Zusammenhängender Text mit Konnektoren (weil, aber, deshalb)","vocabulary":"Wortschatz Arbeitswelt B1","grammar":"Perfekt/Präteritum, Nebensätze"}'::jsonb,
  25
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

-- Aufgabe 2: Meinung im Forum (circa 80 Wörter)
INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, word_limit_min, word_limit_max, leitpunkte, rubric, points
)
SELECT tm.id,
  'In einem Online-Forum wird diskutiert: „Sollten Unternehmen mehr Homeoffice anbieten?" Schreiben Sie Ihre Meinung dazu (circa 80 Wörter).',
  'essay',
  'Beispiel: Meiner Meinung nach sollten Unternehmen mehr Homeoffice anbieten. Erstens sparen Mitarbeiter Zeit, weil sie nicht pendeln müssen. Zweitens können viele Menschen zu Hause konzentrierter arbeiten. Natürlich gibt es auch Nachteile: Der direkte Kontakt zu Kollegen fehlt manchmal. Trotzdem finde ich, dass ein Mix aus Büro und Homeoffice die beste Lösung ist. So bekommt man Flexibilität und bleibt trotzdem im Team verbunden. Deshalb bin ich klar dafür, dass Firmen diese Möglichkeit anbieten.',
  2, 2, 'essay', 70, 90,
  '["Nennen Sie Ihre Meinung klar","Nennen Sie mindestens ein Argument","Begründen Sie Ihre Position"]'::jsonb,
  '{"task_achievement":"Meinung klar und begründet dargestellt?","coherence":"Argumentativer Aufbau mit Konnektoren (erstens, trotzdem, deshalb)","vocabulary":"Meinungsäußerung, Argumentation B1","grammar":"Nebensätze mit weil/obwohl, Komparativ"}'::jsonb,
  25
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

-- Aufgabe 3: Formeller Brief (circa 40 Wörter)
INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, word_limit_min, word_limit_max, leitpunkte, rubric, points
)
SELECT tm.id,
  'Sie müssen wegen einer wichtigen Prüfung (z.B. Sprachprüfung) an einem Arbeitstag freinehmen. Schreiben Sie eine formelle E-Mail an Ihre Vorgesetzte, Frau Hartmann (circa 40 Wörter).',
  'essay',
  'Beispiel: Sehr geehrte Frau Hartmann, am 14. März habe ich eine wichtige Sprachprüfung und bitte deshalb um einen freien Tag. Meine Aufgaben übernimmt an diesem Tag mein Kollege Herr Diallo. Ich bedanke mich im Voraus für Ihr Verständnis. Mit freundlichen Grüßen, …',
  3, 3, 'essay', 30, 50,
  '["Sagen Sie, worum Sie bitten","Nennen Sie den Grund","Bieten Sie eine Lösung an (z.B. Vertretung)"]'::jsonb,
  '{"task_achievement":"Alle drei Leitpunkte behandelt?","coherence":"Formelle Brief-/E-Mail-Struktur (Anrede, Gruß)","vocabulary":"Formeller Wortschatz, Höflichkeitsformen","grammar":"Modalverben, formeller Satzbau"}'::jsonb,
  25
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

-- ─── SPRECHEN (3 Teile) ──────────────────────────────────────────────────────

INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, rubric, points
)
SELECT tm.id,
  E'Teil 1 — Gemeinsam etwas planen\n\nEin Kollege verlässt das Team. Planen Sie gemeinsam mit einem Partner eine Abschiedsfeier:\n• Wann und wo soll die Feier stattfinden?\n• Wer bringt was mit (Essen, Getränke, Geschenk)?\n• Wer sagt dem Kollegen Bescheid?',
  'speaking',
  'Erwartung: Vorschläge machen, auf Vorschläge des Partners reagieren, gemeinsam zu einer Entscheidung kommen (circa 3 Minuten).',
  4, 1, 'speaking',
  '{"task_achievement":"Alle Planungspunkte besprochen und Entscheidung getroffen?","coherence":"Dialogischer Aufbau, Vorschlag–Reaktion","vocabulary":"Planen, vorschlagen, organisieren","grammar":"Konjunktiv II (könnten, würden), Modalverben"}'::jsonb,
  20
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, rubric, points
)
SELECT tm.id,
  E'Teil 2 — Ein Thema präsentieren\n\nHalten Sie eine strukturierte Präsentation (circa 3 Minuten) zum Thema: „Sollte man im Homeoffice arbeiten dürfen?"\n\nGehen Sie auf folgende Punkte ein:\n• Einleitung: Worum geht es?\n• Vorteile und Nachteile\n• Ihre persönliche Situation/Meinung\n• Schluss',
  'speaking',
  'Erwartung: Klare Gliederung (Einleitung – Pro/Contra – persönliche Situation – Schluss), zusammenhängender Vortrag ohne Dialogpartner.',
  5, 2, 'speaking',
  '{"task_achievement":"Alle vier Teile der Präsentation enthalten?","coherence":"Klare Struktur mit Übergängen (erstens, außerdem, zusammenfassend)","vocabulary":"Präsentationswortschatz, Vor-/Nachteile","grammar":"Komplexe Sätze, Nebensätze"}'::jsonb,
  20
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, rubric, points
)
SELECT tm.id,
  E'Teil 3 — Feedback geben\n\nIhr Partner hat gerade seine Präsentation gehalten. Geben Sie kurzes, höfliches Feedback und stellen Sie eine inhaltliche Frage zur Präsentation.',
  'speaking',
  'Erwartung: Höfliches, konkretes Feedback (z.B. „Mir hat gefallen, dass...") und eine sinnvolle Anschlussfrage zum Thema.',
  6, 3, 'speaking',
  '{"task_achievement":"Feedback gegeben und Frage gestellt?","coherence":"Höfliche, verständliche Formulierungen","vocabulary":"Feedback-Wortschatz (mir hat gefallen, ich frage mich...)","grammar":"Fragesätze, Perfekt"}'::jsonb,
  20
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';
