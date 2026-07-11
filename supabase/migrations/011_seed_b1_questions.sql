-- Seed B1 Level Questions (40 questions total: 4 skills × 10 questions)

-- B1 Listening Questions (10 questions)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Was ist das Hauptthema des Gesprächs?', 'multiple_choice',
  ARRAY['Umweltschutz', 'Gesundheit', 'Bildung', 'Technologie'],
  'Umweltschutz', 'Die Sprecher diskutieren über Klimawandel und Recycling.', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Welche Meinung vertritt der Sprecher?', 'multiple_choice',
  ARRAY['Er ist dafür', 'Er ist dagegen', 'Er ist neutral', 'Er ist unsicher'],
  'Er ist dafür', 'Der Sprecher unterstützt die vorgeschlagene Lösung.', 2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Warum kann die Person nicht kommen?', 'multiple_choice',
  ARRAY['Sie ist krank', 'Sie muss arbeiten', 'Sie hat einen anderen Termin', 'Sie ist im Urlaub'],
  'Sie muss arbeiten', 'Die Person hat eine wichtige Besprechung.', 3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Was wird empfohlen?', 'multiple_choice',
  ARRAY['Mehr Sport treiben', 'Gesünder essen', 'Mehr schlafen', 'Weniger arbeiten'],
  'Gesünder essen', 'Der Arzt empfiehlt eine ausgewogene Ernährung.', 4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Welches Problem wird beschrieben?', 'multiple_choice',
  ARRAY['Verkehrsstau', 'Lärmbelästigung', 'Luftverschmutzung', 'Wassermangel'],
  'Verkehrsstau', 'Die Stadt hat Probleme mit dem Verkehr in der Rushhour.', 5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Was plant die Firma?', 'multiple_choice',
  ARRAY['Expansion ins Ausland', 'Neue Mitarbeiter einstellen', 'Büro umziehen', 'Produkte ändern'],
  'Expansion ins Ausland', 'Die Firma möchte in drei neue Länder expandieren.', 6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Welcher Vorschlag wird gemacht?', 'multiple_choice',
  ARRAY['Früher anfangen', 'Später aufhören', 'Pause machen', 'Termin verschieben'],
  'Termin verschieben', 'Man schlägt vor, das Meeting auf nächste Woche zu verschieben.', 7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Was ist der Grund für die Änderung?', 'multiple_choice',
  ARRAY['Kosteneinsparung', 'Zeitersparnis', 'Bessere Qualität', 'Kundenwunsch'],
  'Kosteneinsparung', 'Die Änderung soll Kosten um 20% reduzieren.', 8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Welche Erfahrung wird beschrieben?', 'multiple_choice',
  ARRAY['Positive', 'Negative', 'Gemischte', 'Neutrale'],
  'Gemischte', 'Es gab sowohl gute als auch schlechte Aspekte.', 9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Was wird als nächstes passieren?', 'multiple_choice',
  ARRAY['Eine Entscheidung treffen', 'Mehr Informationen sammeln', 'Experten konsultieren', 'Abstimmen'],
  'Mehr Informationen sammeln', 'Man will erst weitere Daten analysieren.', 10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

-- B1 Reading Questions (10 questions)
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Was ist die Hauptaussage des Textes?', 'multiple_choice',
  ARRAY['Digitalisierung verändert die Arbeitswelt', 'Technologie ist gefährlich', 'Menschen verlieren Jobs', 'Bildung ist wichtig'],
  'Digitalisierung verändert die Arbeitswelt', 'Der Text beschreibt den digitalen Wandel in Unternehmen.', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Welches Wort passt? "_____ des schlechten Wetters gingen wir spazieren."', 'multiple_choice',
  ARRAY['Wegen', 'Trotz', 'Während', 'Statt'],
  'Trotz', '"Trotz" drückt einen Gegensatz aus.', 2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Was bedeutet "sich beschweren"?', 'multiple_choice',
  ARRAY['to complain', 'to explain', 'to describe', 'to discuss'],
  'to complain', '"Sich beschweren" bedeutet "to complain".', 3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Welche Konjunktion ist richtig? "Ich lerne Deutsch, _____ ich in Deutschland arbeiten möchte."', 'multiple_choice',
  ARRAY['weil', 'obwohl', 'wenn', 'als'],
  'weil', '"Weil" leitet einen Grund ein.', 4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Was ist richtig? "Der Film, _____ ich gestern gesehen habe, war toll."', 'multiple_choice',
  ARRAY['der', 'den', 'dem', 'dessen'],
  'den', 'Relativpronomen im Akkusativ: "den".', 5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Welches Verb passt? "Die Regierung hat beschlossen, die Steuern zu _____."', 'multiple_choice',
  ARRAY['erhöhen', 'steigen', 'wachsen', 'zunehmen'],
  'erhöhen', '"Erhöhen" ist transitiv und passt hier.', 6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Was bedeutet "nachhaltig"?', 'multiple_choice',
  ARRAY['sustainable', 'temporary', 'expensive', 'modern'],
  'sustainable', '"Nachhaltig" bedeutet "sustainable".', 7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Welche Präposition ist richtig? "Ich interessiere mich _____ Politik."', 'multiple_choice',
  ARRAY['für', 'an', 'über', 'von'],
  'für', '"Sich interessieren für" ist die richtige Kombination.', 8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Was ist richtig? "Wenn ich Zeit _____, würde ich mehr reisen."', 'multiple_choice',
  ARRAY['habe', 'hätte', 'hatte', 'haben würde'],
  'hätte', 'Konjunktiv II: "hätte".', 9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 'Welches Wort passt? "Die Firma hat ihre Produktion _____."', 'multiple_choice',
  ARRAY['verdoppelt', 'doppelt', 'zweifach', 'zwei'],
  'verdoppelt', '"Verdoppelt" bedeutet "doubled".', 10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- B1 Writing Questions (10 questions)
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, order_number)
SELECT tm.id, 'Schreiben Sie einen formellen Brief an Ihren Vermieter über ein Problem in Ihrer Wohnung (8-10 Sätze).', 'text',
  'Beispiel: Sehr geehrter Herr Müller, ich schreibe Ihnen, weil es ein Problem in meiner Wohnung gibt. Die Heizung funktioniert seit drei Tagen nicht mehr. Es ist sehr kalt in der Wohnung. Ich habe versucht, das Problem selbst zu lösen, aber es hat nicht geklappt. Könnten Sie bitte einen Handwerker schicken? Das Problem sollte schnell gelöst werden. Ich bin diese Woche jeden Tag zu Hause. Sie können mich jederzeit anrufen. Vielen Dank für Ihre Hilfe. Mit freundlichen Grüßen.', 1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, order_number)
SELECT tm.id, 'Schreiben Sie Ihre Meinung zum Thema "Sollten Schuluniformen Pflicht sein?" (10-12 Sätze).', 'text',
  'Beispiel: Meiner Meinung nach sollten Schuluniformen nicht Pflicht sein. Erstens schränken sie die persönliche Freiheit ein. Jeder sollte selbst entscheiden können, was er trägt. Zweitens sind Uniformen oft teuer. Nicht alle Familien können sich das leisten. Andererseits verstehe ich, dass Uniformen Vorteile haben. Sie können soziale Unterschiede verringern. Niemand wird wegen seiner Kleidung gemobbt. Außerdem fördern sie das Gemeinschaftsgefühl. Trotzdem finde ich, dass die Nachteile überwiegen. Individualität ist wichtig für die Entwicklung junger Menschen. Schulen sollten andere Wege finden, um Zusammenhalt zu fördern.', 2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, order_number)
SELECT tm.id, 'Beschreiben Sie ein wichtiges Ereignis in Ihrem Leben (8-10 Sätze).', 'text',
  'Beispiel: Ein wichtiges Ereignis in meinem Leben war mein Universitätsabschluss. Ich habe vier Jahre lang hart gearbeitet. Es gab viele schwierige Momente. Manchmal wollte ich aufgeben. Aber meine Familie hat mich immer unterstützt. Am Tag der Abschlussfeier war ich sehr stolz. Meine Eltern waren auch da. Sie haben geweint vor Freude. Dieser Tag hat mein Leben verändert. Jetzt habe ich bessere Berufschancen. Ich bin dankbar für diese Erfahrung.', 3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';
