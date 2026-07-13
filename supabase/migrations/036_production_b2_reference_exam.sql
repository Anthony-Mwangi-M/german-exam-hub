-- B2 reference exam: Goethe-Zertifikat B2 structure for Lesen, Schreiben, Sprechen (v1, no Hören)

-- Module metadata (honest counts and durations)
UPDATE test_modules tm
SET
  title = 'B2 Lesen Übungstest (Goethe)',
  description = '5 Teile: Personen zuordnen, Detailverstehen, Multiple Choice, Sätze einfügen, Überschriften zuordnen. 18 Aufgaben, 65 Minuten.',
  question_count = 18,
  duration_minutes = 65,
  exam_format = 'goethe'
FROM levels l, skills s
WHERE tm.level_id = l.id AND tm.skill_id = s.id
  AND l.code = 'B2' AND s.code = 'reading';

UPDATE test_modules tm
SET
  title = 'B2 Schreiben Übungstest (Goethe)',
  description = '2 Teile: Meinung im Forum, formelle geschäftliche Nachricht. 75 Minuten.',
  question_count = 2,
  duration_minutes = 75,
  exam_format = 'goethe'
FROM levels l, skills s
WHERE tm.level_id = l.id AND tm.skill_id = s.id
  AND l.code = 'B2' AND s.code = 'writing';

UPDATE test_modules tm
SET
  title = 'B2 Sprechen Übungstest (Goethe)',
  description = '2 Teile: Vortrag halten, Diskussion führen. 15 Minuten.',
  question_count = 2,
  duration_minutes = 15,
  exam_format = 'goethe'
FROM levels l, skills s
WHERE tm.level_id = l.id AND tm.skill_id = s.id
  AND l.code = 'B2' AND s.code = 'speaking';

-- Replace B2 reading, writing, speaking questions
DELETE FROM questions WHERE test_module_id IN (
  SELECT tm.id FROM test_modules tm
  JOIN levels l ON tm.level_id = l.id
  JOIN skills s ON tm.skill_id = s.id
  WHERE l.code = 'B2' AND s.code IN ('reading', 'writing', 'speaking')
);

-- ─── LESEN (18 items, 5 Teile) ───────────────────────────────────────────────

-- Teil 1: Vier Personen einer Aussage zuordnen (Personen können mehrmals gewählt werden)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Thema: Weiterbildung neben dem Beruf\n\nPerson A (Chidi): „Ich habe berufsbegleitend einen Meisterkurs gemacht, abends und am Wochenende. Es war anstrengend, aber mein Gehalt ist danach deutlich gestiegen."\nPerson B (Marta): „Für mich kam eine Weiterbildung neben der Arbeit nicht infrage, mit zwei kleinen Kindern hätte ich keine Zeit dafür gehabt. Ich habe stattdessen intern Erfahrung gesammelt."\nPerson C (Ravi): „Mein Arbeitgeber hat die Fortbildung komplett bezahlt und mir sogar Arbeitszeit dafür freigegeben. Ohne diese Unterstützung hätte ich es nicht geschafft."\nPerson D (Nasrin): „Ich habe online studiert, in meinem eigenen Tempo. Das war finanziell die einzige Option, die ich mir leisten konnte."\n\nDiese Person konnte die Weiterbildung nur dank finanzieller Unterstützung des Arbeitgebers machen.\n\nWelche Person?',
  'multiple_choice',
  jsonb_build_array('Person A', 'Person B', 'Person C', 'Person D'),
  'Person C',
  'Ravi sagt: „Mein Arbeitgeber hat die Fortbildung komplett bezahlt... Ohne diese Unterstützung hätte ich es nicht geschafft."',
  1, 1, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Thema: Weiterbildung neben dem Beruf\n\nPerson A (Chidi): „Ich habe berufsbegleitend einen Meisterkurs gemacht, abends und am Wochenende. Es war anstrengend, aber mein Gehalt ist danach deutlich gestiegen."\nPerson B (Marta): „Für mich kam eine Weiterbildung neben der Arbeit nicht infrage, mit zwei kleinen Kindern hätte ich keine Zeit dafür gehabt. Ich habe stattdessen intern Erfahrung gesammelt."\nPerson C (Ravi): „Mein Arbeitgeber hat die Fortbildung komplett bezahlt und mir sogar Arbeitszeit dafür freigegeben. Ohne diese Unterstützung hätte ich es nicht geschafft."\nPerson D (Nasrin): „Ich habe online studiert, in meinem eigenen Tempo. Das war finanziell die einzige Option, die ich mir leisten konnte."\n\nDiese Person hat wegen fehlender Zeit keine externe Weiterbildung gemacht.\n\nWelche Person?',
  'multiple_choice',
  jsonb_build_array('Person A', 'Person B', 'Person C', 'Person D'),
  'Person B',
  'Marta sagt, mit zwei kleinen Kindern hätte sie keine Zeit dafür gehabt.',
  2, 1, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Thema: Weiterbildung neben dem Beruf\n\nPerson A (Chidi): „Ich habe berufsbegleitend einen Meisterkurs gemacht, abends und am Wochenende. Es war anstrengend, aber mein Gehalt ist danach deutlich gestiegen."\nPerson B (Marta): „Für mich kam eine Weiterbildung neben der Arbeit nicht infrage, mit zwei kleinen Kindern hätte ich keine Zeit dafür gehabt. Ich habe stattdessen intern Erfahrung gesammelt."\nPerson C (Ravi): „Mein Arbeitgeber hat die Fortbildung komplett bezahlt und mir sogar Arbeitszeit dafür freigegeben. Ohne diese Unterstützung hätte ich es nicht geschafft."\nPerson D (Nasrin): „Ich habe online studiert, in meinem eigenen Tempo. Das war finanziell die einzige Option, die ich mir leisten konnte."\n\nDiese Person hat finanziell von der Weiterbildung profitiert.\n\nWelche Person?',
  'multiple_choice',
  jsonb_build_array('Person A', 'Person B', 'Person C', 'Person D'),
  'Person A',
  'Chidi sagt, sein Gehalt sei danach deutlich gestiegen.',
  3, 1, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Thema: Weiterbildung neben dem Beruf\n\nPerson A (Chidi): „Ich habe berufsbegleitend einen Meisterkurs gemacht, abends und am Wochenende. Es war anstrengend, aber mein Gehalt ist danach deutlich gestiegen."\nPerson B (Marta): „Für mich kam eine Weiterbildung neben der Arbeit nicht infrage, mit zwei kleinen Kindern hätte ich keine Zeit dafür gehabt. Ich habe stattdessen intern Erfahrung gesammelt."\nPerson C (Ravi): „Mein Arbeitgeber hat die Fortbildung komplett bezahlt und mir sogar Arbeitszeit dafür freigegeben. Ohne diese Unterstützung hätte ich es nicht geschafft."\nPerson D (Nasrin): „Ich habe online studiert, in meinem eigenen Tempo. Das war finanziell die einzige Option, die ich mir leisten konnte."\n\nDiese Person konnte sich nur eine flexible, selbstfinanzierte Option leisten.\n\nWelche Person?',
  'multiple_choice',
  jsonb_build_array('Person A', 'Person B', 'Person C', 'Person D'),
  'Person D',
  'Nasrin sagt, das Online-Studium sei „finanziell die einzige Option" gewesen, die sie sich leisten konnte.',
  4, 1, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Thema: Weiterbildung neben dem Beruf\n\nPerson A (Chidi): „Ich habe berufsbegleitend einen Meisterkurs gemacht, abends und am Wochenende. Es war anstrengend, aber mein Gehalt ist danach deutlich gestiegen."\nPerson B (Marta): „Für mich kam eine Weiterbildung neben der Arbeit nicht infrage, mit zwei kleinen Kindern hätte ich keine Zeit dafür gehabt. Ich habe stattdessen intern Erfahrung gesammelt."\nPerson C (Ravi): „Mein Arbeitgeber hat die Fortbildung komplett bezahlt und mir sogar Arbeitszeit dafür freigegeben. Ohne diese Unterstützung hätte ich es nicht geschafft."\nPerson D (Nasrin): „Ich habe online studiert, in meinem eigenen Tempo. Das war finanziell die einzige Option, die ich mir leisten konnte."\n\nDiese Person hat trotz einer belastenden Doppelbelastung (Arbeit und Kurs) durchgehalten.\n\nWelche Person?',
  'multiple_choice',
  jsonb_build_array('Person A', 'Person B', 'Person C', 'Person D'),
  'Person A',
  'Chidi beschreibt Abend- und Wochenendunterricht neben dem Beruf als „anstrengend", hat aber durchgehalten.',
  5, 1, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- Teil 2: Detailverstehen, Kolumne
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Kolumne:\n\n„Seit Jahren wird über den Fachkräftemangel geklagt, doch gleichzeitig scheitern viele qualifizierte Bewerberinnen und Bewerber aus dem Ausland an bürokratischen Hürden. Die Anerkennung ausländischer Abschlüsse dauert oft Monate, manchmal Jahre. Dabei zeigen Pilotprojekte in einzelnen Bundesländern, dass ein beschleunigtes Verfahren möglich wäre, wenn der politische Wille vorhanden ist. Stattdessen verlieren wir wertvolle Zeit, während andere Länder mit einfacheren Verfahren um dieselben Fachkräfte werben."\n\nWas ist die Hauptaussage der Kolumne?',
  'multiple_choice',
  jsonb_build_array('Bürokratie verhindert, dass Deutschland dringend benötigte Fachkräfte schnell gewinnt.', 'Es gibt in Deutschland keinen Fachkräftemangel.', 'Andere Länder haben komplizierte Anerkennungsverfahren.', 'Pilotprojekte sind grundsätzlich gescheitert.'),
  'Bürokratie verhindert, dass Deutschland dringend benötigte Fachkräfte schnell gewinnt.',
  'Die Kolumne kritisiert lange Anerkennungsverfahren als Hindernis, obwohl Fachkräfte gebraucht werden.',
  6, 2, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Kolumne:\n\n„Seit Jahren wird über den Fachkräftemangel geklagt, doch gleichzeitig scheitern viele qualifizierte Bewerberinnen und Bewerber aus dem Ausland an bürokratischen Hürden. Die Anerkennung ausländischer Abschlüsse dauert oft Monate, manchmal Jahre. Dabei zeigen Pilotprojekte in einzelnen Bundesländern, dass ein beschleunigtes Verfahren möglich wäre, wenn der politische Wille vorhanden ist. Stattdessen verlieren wir wertvolle Zeit, während andere Länder mit einfacheren Verfahren um dieselben Fachkräfte werben."\n\nWas belegt laut Autor/in, dass schnellere Verfahren möglich wären?',
  'multiple_choice',
  jsonb_build_array('Pilotprojekte in einzelnen Bundesländern', 'Eine internationale Studie', 'Aussagen von Bewerbern', 'Statistiken aus anderen Ländern'),
  'Pilotprojekte in einzelnen Bundesländern',
  'Im Text: „Pilotprojekte in einzelnen Bundesländern" zeigen, dass ein schnelleres Verfahren möglich wäre.',
  7, 2, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Kolumne:\n\n„Seit Jahren wird über den Fachkräftemangel geklagt, doch gleichzeitig scheitern viele qualifizierte Bewerberinnen und Bewerber aus dem Ausland an bürokratischen Hürden. Die Anerkennung ausländischer Abschlüsse dauert oft Monate, manchmal Jahre. Dabei zeigen Pilotprojekte in einzelnen Bundesländern, dass ein beschleunigtes Verfahren möglich wäre, wenn der politische Wille vorhanden ist. Stattdessen verlieren wir wertvolle Zeit, während andere Länder mit einfacheren Verfahren um dieselben Fachkräfte werben."\n\nWelche Haltung nimmt der Autor/die Autorin gegenüber der aktuellen Situation ein?',
  'multiple_choice',
  jsonb_build_array('Kritisch, er/sie fordert schnellere Verfahren.', 'Zustimmend, die Verfahren sind angemessen.', 'Neutral, er/sie äußert keine Meinung.', 'Gleichgültig, das Thema sei unwichtig.'),
  'Kritisch, er/sie fordert schnellere Verfahren.',
  'Der Ton ist kritisch gegenüber der Bürokratie und fordert implizit eine Beschleunigung.',
  8, 2, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- Teil 3: Multiple Choice, Debattentext
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Debattenbeitrag:\n\n„Befürworter der Vier-Tage-Woche argumentieren, sie steigere die Produktivität und reduziere Krankheitstage. Kritiker halten dagegen, dass in Branchen mit Personalmangel, etwa der Pflege oder Logistik, eine Verkürzung der Arbeitszeit schlicht unrealistisch sei, solange nicht genügend Fachkräfte vorhanden sind. Beide Seiten sind sich jedoch einig, dass Pilotprojekte notwendig sind, um verlässliche Daten zu sammeln, bevor branchenübergreifende Entscheidungen getroffen werden."\n\nWas ist laut Text ein Haupteinwand der Kritiker?',
  'multiple_choice',
  jsonb_build_array('In Branchen mit Personalmangel sei eine Arbeitszeitverkürzung unrealistisch.', 'Die Vier-Tage-Woche erhöhe die Krankheitstage.', 'Pilotprojekte seien überflüssig.', 'Alle Branchen seien gleich betroffen.'),
  'In Branchen mit Personalmangel sei eine Arbeitszeitverkürzung unrealistisch.',
  'Im Text: „in Branchen mit Personalmangel... eine Verkürzung der Arbeitszeit schlicht unrealistisch sei".',
  9, 3, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Debattenbeitrag:\n\n„Befürworter der Vier-Tage-Woche argumentieren, sie steigere die Produktivität und reduziere Krankheitstage. Kritiker halten dagegen, dass in Branchen mit Personalmangel, etwa der Pflege oder Logistik, eine Verkürzung der Arbeitszeit schlicht unrealistisch sei, solange nicht genügend Fachkräfte vorhanden sind. Beide Seiten sind sich jedoch einig, dass Pilotprojekte notwendig sind, um verlässliche Daten zu sammeln, bevor branchenübergreifende Entscheidungen getroffen werden."\n\nWorin sind sich Befürworter und Kritiker laut Text einig?',
  'multiple_choice',
  jsonb_build_array('Dass Pilotprojekte notwendig sind, um Daten zu sammeln.', 'Dass die Vier-Tage-Woche sofort eingeführt werden sollte.', 'Dass es in der Pflege keinen Personalmangel gibt.', 'Dass die Produktivität keine Rolle spielt.'),
  'Dass Pilotprojekte notwendig sind, um Daten zu sammeln.',
  'Im Text: „Beide Seiten sind sich... einig, dass Pilotprojekte notwendig sind".',
  10, 3, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Debattenbeitrag:\n\n„Befürworter der Vier-Tage-Woche argumentieren, sie steigere die Produktivität und reduziere Krankheitstage. Kritiker halten dagegen, dass in Branchen mit Personalmangel, etwa der Pflege oder Logistik, eine Verkürzung der Arbeitszeit schlicht unrealistisch sei, solange nicht genügend Fachkräfte vorhanden sind. Beide Seiten sind sich jedoch einig, dass Pilotprojekte notwendig sind, um verlässliche Daten zu sammeln, bevor branchenübergreifende Entscheidungen getroffen werden."\n\nWelche zwei Branchen werden als Beispiele für Personalmangel genannt?',
  'multiple_choice',
  jsonb_build_array('Pflege und Logistik', 'IT und Finanzen', 'Bildung und Tourismus', 'Landwirtschaft und Handel'),
  'Pflege und Logistik',
  'Im Text: „etwa der Pflege oder Logistik".',
  11, 3, 'mcq', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- Teil 4: Sätze in Lücken einfügen (strukturelles Verstehen)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Text mit Lücken:\n\n„Die Digitalisierung verändert auch die Ausbildung im Gesundheitswesen. [__1__] Simulationstrainings mit virtueller Realität ermöglichen es Auszubildenden, komplexe Situationen gefahrlos zu üben. [__2__] Kritiker warnen jedoch, dass digitale Werkzeuge den direkten menschlichen Kontakt nicht vollständig ersetzen können. [__3__] Die meisten Expertinnen und Experten sind sich daher einig: Technologie sollte ergänzen, nicht ersetzen. [__4__]"\n\nSätze zum Einfügen:\na) Genau dieser Kontakt sei aber ein zentraler Teil der pflegerischen Tätigkeit.\nb) Immer mehr Kliniken setzen daher auf digitale Lernmethoden.\nc) Deshalb bleibt die praktische Ausbildung am Patienten weiterhin unverzichtbar.\nd) Das Wetter spielte dabei traditionell keine Rolle.\ne) Vor allem in der Pflegeausbildung zeigt sich das deutlich.\n\nWelcher Satz passt in Lücke 1?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c', 'd', 'e'),
  'e',
  'Satz e) leitet direkt zum folgenden Beispiel der Pflegeausbildung über.',
  12, 4, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Text mit Lücken:\n\n„Die Digitalisierung verändert auch die Ausbildung im Gesundheitswesen. [__1__] Simulationstrainings mit virtueller Realität ermöglichen es Auszubildenden, komplexe Situationen gefahrlos zu üben. [__2__] Kritiker warnen jedoch, dass digitale Werkzeuge den direkten menschlichen Kontakt nicht vollständig ersetzen können. [__3__] Die meisten Expertinnen und Experten sind sich daher einig: Technologie sollte ergänzen, nicht ersetzen. [__4__]"\n\nSätze zum Einfügen:\na) Genau dieser Kontakt sei aber ein zentraler Teil der pflegerischen Tätigkeit.\nb) Immer mehr Kliniken setzen daher auf digitale Lernmethoden.\nc) Deshalb bleibt die praktische Ausbildung am Patienten weiterhin unverzichtbar.\nd) Das Wetter spielte dabei traditionell keine Rolle.\ne) Vor allem in der Pflegeausbildung zeigt sich das deutlich.\n\nWelcher Satz passt in Lücke 2?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c', 'd', 'e'),
  'b',
  'Satz b) führt logisch vom Simulationstraining zur allgemeinen Aussage über digitale Lernmethoden in Kliniken.',
  13, 4, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Text mit Lücken:\n\n„Die Digitalisierung verändert auch die Ausbildung im Gesundheitswesen. [__1__] Simulationstrainings mit virtueller Realität ermöglichen es Auszubildenden, komplexe Situationen gefahrlos zu üben. [__2__] Kritiker warnen jedoch, dass digitale Werkzeuge den direkten menschlichen Kontakt nicht vollständig ersetzen können. [__3__] Die meisten Expertinnen und Experten sind sich daher einig: Technologie sollte ergänzen, nicht ersetzen. [__4__]"\n\nSätze zum Einfügen:\na) Genau dieser Kontakt sei aber ein zentraler Teil der pflegerischen Tätigkeit.\nb) Immer mehr Kliniken setzen daher auf digitale Lernmethoden.\nc) Deshalb bleibt die praktische Ausbildung am Patienten weiterhin unverzichtbar.\nd) Das Wetter spielte dabei traditionell keine Rolle.\ne) Vor allem in der Pflegeausbildung zeigt sich das deutlich.\n\nWelcher Satz passt in Lücke 3?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c', 'd', 'e'),
  'a',
  'Satz a) begründet direkt, warum der menschliche Kontakt laut Kritikern so wichtig ist.',
  14, 4, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Text mit Lücken:\n\n„Die Digitalisierung verändert auch die Ausbildung im Gesundheitswesen. [__1__] Simulationstrainings mit virtueller Realität ermöglichen es Auszubildenden, komplexe Situationen gefahrlos zu üben. [__2__] Kritiker warnen jedoch, dass digitale Werkzeuge den direkten menschlichen Kontakt nicht vollständig ersetzen können. [__3__] Die meisten Expertinnen und Experten sind sich daher einig: Technologie sollte ergänzen, nicht ersetzen. [__4__]"\n\nSätze zum Einfügen:\na) Genau dieser Kontakt sei aber ein zentraler Teil der pflegerischen Tätigkeit.\nb) Immer mehr Kliniken setzen daher auf digitale Lernmethoden.\nc) Deshalb bleibt die praktische Ausbildung am Patienten weiterhin unverzichtbar.\nd) Das Wetter spielte dabei traditionell keine Rolle.\ne) Vor allem in der Pflegeausbildung zeigt sich das deutlich.\n\nWelcher Satz passt in Lücke 4?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c', 'd', 'e'),
  'c',
  'Satz c) zieht die logische Schlussfolgerung aus der vorherigen Aussage „ergänzen, nicht ersetzen".',
  15, 4, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- Teil 5: Überschriften zuordnen
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Überschriften:\na) Weniger Bürokratie gefordert\nb) Neue Studie zur Mitarbeiterzufriedenheit\nc) Sprachförderung am Arbeitsplatz wird ausgebaut\n\nAbsatz: „Ab dem kommenden Quartal bieten immer mehr Unternehmen berufsbegleitende Deutschkurse direkt im Betrieb an. Ziel ist es, internationale Fachkräfte schneller in Teams zu integrieren und Missverständnisse in der täglichen Kommunikation zu reduzieren."\n\nWelche Überschrift passt?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c'),
  'c',
  'Der Absatz beschreibt betriebliche Deutschkurse, passend zu „Sprachförderung am Arbeitsplatz wird ausgebaut".',
  16, 5, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Überschriften:\na) Weniger Bürokratie gefordert\nb) Neue Studie zur Mitarbeiterzufriedenheit\nc) Sprachförderung am Arbeitsplatz wird ausgebaut\n\nAbsatz: „Verbände fordern seit Langem, die Anerkennung ausländischer Berufsabschlüsse zu vereinfachen. Aktuell dauert das Verfahren in manchen Bundesländern über ein Jahr, ein Zeitraum, den sich weder Betriebe noch Bewerberinnen und Bewerber leisten können."\n\nWelche Überschrift passt?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c'),
  'a',
  'Der Absatz kritisiert lange Verfahren und fordert Vereinfachung, passend zu „Weniger Bürokratie gefordert".',
  17, 5, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order", exam_part, task_type, points)
SELECT tm.id,
  E'Überschriften:\na) Weniger Bürokratie gefordert\nb) Neue Studie zur Mitarbeiterzufriedenheit\nc) Sprachförderung am Arbeitsplatz wird ausgebaut\n\nAbsatz: „Laut einer aktuellen Umfrage unter 2.000 Beschäftigten ist die Zufriedenheit mit flexiblen Arbeitszeitmodellen deutlich gestiegen, während die Zufriedenheit mit Aufstiegschancen weiterhin niedrig bleibt."\n\nWelche Überschrift passt?',
  'multiple_choice',
  jsonb_build_array('a', 'b', 'c'),
  'b',
  'Der Absatz referiert Umfrageergebnisse zur Zufriedenheit, passend zu „Neue Studie zur Mitarbeiterzufriedenheit".',
  18, 5, 'matching', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- ─── SCHREIBEN (2 Teile) ─────────────────────────────────────────────────────

-- Teil 1: Meinung im Forum (circa 150 Wörter)
INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, word_limit_min, word_limit_max, leitpunkte, rubric, points
)
SELECT tm.id,
  'In einem Firmenforum wird diskutiert: „Sollten Unternehmen verpflichtend Deutschkurse für internationale Mitarbeitende anbieten?" Verfassen Sie einen Beitrag, in dem Sie verschiedene Perspektiven berücksichtigen und eine begründete Position entwickeln (circa 150 Wörter).',
  'essay',
  'Beispiel: Die Frage, ob Unternehmen verpflichtend Deutschkurse anbieten sollten, wird kontrovers diskutiert. Befürworter argumentieren, dass gute Sprachkenntnisse die Sicherheit am Arbeitsplatz erhöhen und Missverständnisse reduzieren. Zudem fühlen sich Mitarbeitende oft schneller integriert, wenn sie aktiv unterstützt werden. Gegner wenden ein, dass verpflichtende Kurse zusätzlichen Zeitdruck erzeugen und nicht jeder das gleiche Lerntempo hat. Meiner Meinung nach überwiegen die Vorteile: Sprachförderung sollte jedoch freiwillig, aber attraktiv gestaltet sein, etwa durch bezahlte Arbeitszeit und flexible Kurszeiten. So profitieren sowohl Unternehmen als auch Mitarbeitende, ohne dass zusätzlicher Druck entsteht. Entscheidend ist, dass die Angebote praxisnah sind und tatsächlich zur beruflichen Kommunikation beitragen. Nur so lässt sich langfristig echte Integration erreichen, statt reiner Pflichterfüllung.',
  1, 1, 'essay', 130, 170,
  '["Nennen Sie Argumente für und gegen verpflichtende Kurse","Entwickeln Sie eine eigene, begründete Position","Beziehen Sie sich auf praktische Konsequenzen"]'::jsonb,
  '{"task_achievement":"Verschiedene Perspektiven berücksichtigt und eigene Position begründet?","coherence":"Klar strukturierter Argumentationsaufbau mit Konnektoren","vocabulary":"Breiter, präziser Wortschatz ohne Wiederholungen","grammar":"Komplexe Satzstrukturen, korrekte Konjunktive"}'::jsonb,
  30
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

-- Teil 2: Formelle geschäftliche Nachricht (circa 100 Wörter)
INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, word_limit_min, word_limit_max, leitpunkte, rubric, points
)
SELECT tm.id,
  'Sie haben in einem Projekt eine Terminverzögerung festgestellt. Schreiben Sie eine formelle Nachricht an die Projektleitung, in der Sie die Verzögerung erklären, Konsequenzen benennen und einen Lösungsvorschlag machen (circa 100 Wörter).',
  'essay',
  'Beispiel: Sehr geehrte Frau Brandt, ich möchte Sie über eine Verzögerung im aktuellen Projekt informieren. Aufgrund eines Lieferengpasses bei einem externen Partner verschiebt sich die Fertigstellung voraussichtlich um eine Woche. Dies betrifft insbesondere die für den 20. dieses Monats geplante Präsentation. Um den Zeitverlust auszugleichen, schlage ich vor, zwei Teilschritte parallel statt nacheinander durchzuführen. Ich bin gerne bereit, dies in einem kurzen Gespräch näher zu erläutern. Für Rückfragen stehe ich jederzeit zur Verfügung. Mit freundlichen Grüßen, …',
  2, 2, 'essay', 80, 120,
  '["Erklären Sie den Grund der Verzögerung","Benennen Sie die Konsequenzen","Machen Sie einen konkreten Lösungsvorschlag"]'::jsonb,
  '{"task_achievement":"Grund, Konsequenz und Lösungsvorschlag klar dargestellt?","coherence":"Formelle, logisch aufgebaute Geschäftskorrespondenz","vocabulary":"Geschäftlicher/administrativer Wortschatz B2","grammar":"Passiv, Nominalisierungen, formeller Satzbau"}'::jsonb,
  30
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

-- ─── SPRECHEN (2 Teile) ──────────────────────────────────────────────────────

INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, rubric, points
)
SELECT tm.id,
  E'Teil 1, Vortrag halten\n\nHalten Sie einen kurzen Vortrag (circa 4 Minuten) zum Thema: „Sollten Berufsabschlüsse aus dem Ausland automatisch anerkannt werden?"\n\nGehen Sie ein auf:\n• Ihre Position und Begründung\n• Mögliche Alternativen zur automatischen Anerkennung\n• Beantworten Sie am Ende eine Nachfrage des Prüfers/der Prüferin',
  'speaking',
  'Erwartung: Strukturierter Monolog mit klarer Position, Begründung, Alternativen und angemessener Reaktion auf eine Rückfrage.',
  3, 1, 'speaking',
  '{"task_achievement":"Position, Begründung, Alternativen und Antwort auf Nachfrage enthalten?","coherence":"Klare Redegliederung mit Übergängen","vocabulary":"Differenzierter Wortschatz zu Bildung/Anerkennung","grammar":"Konjunktiv, komplexe Nebensätze, Passiv"}'::jsonb,
  25
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

INSERT INTO questions (
  test_module_id, question_text, question_type, correct_answer,
  "order", exam_part, task_type, rubric, points
)
SELECT tm.id,
  E'Teil 2, Diskussion führen\n\nDiskutieren Sie mit einem Partner/einer Partnerin (circa 5 Minuten): „Sollten Unternehmen internationale Fachkräfte bei der Wohnungssuche aktiv unterstützen?"\n\nVertreten Sie Ihren Standpunkt, gehen Sie auf die Argumente Ihres Partners ein und versuchen Sie, am Ende einen Kompromiss zu finden.',
  'speaking',
  'Erwartung: Aktive Diskussion mit Standpunktvertretung, Eingehen auf Gegenargumente und gemeinsamer Kompromissfindung.',
  4, 2, 'speaking',
  '{"task_achievement":"Standpunkt vertreten, auf Partner eingegangen, Kompromiss gefunden?","coherence":"Dialogisch, mit Widerspruch und Zustimmung","vocabulary":"Diskussionswortschatz (ich stimme zu/widerspreche, andererseits)","grammar":"Konzessivsätze (obwohl, trotzdem), Konjunktiv II"}'::jsonb,
  25
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';
