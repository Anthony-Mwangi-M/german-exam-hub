-- Production A2 WRITING & SPEAKING Questions (20 questions total)

-- Delete existing A2 writing questions
DELETE FROM questions WHERE test_module_id IN (
  SELECT tm.id FROM test_modules tm
  JOIN levels l ON tm.level_id = l.id
  JOIN skills s ON tm.skill_id = s.id
  WHERE l.code = 'A2' AND s.code = 'writing'
);

-- Delete existing A2 speaking questions
DELETE FROM questions WHERE test_module_id IN (
  SELECT tm.id FROM test_modules tm
  JOIN levels l ON tm.level_id = l.id
  JOIN skills s ON tm.skill_id = s.id
  WHERE l.code = 'A2' AND s.code = 'speaking'
);

-- A2 WRITING QUESTIONS (10)

-- Q1: Formal email - appointment
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie eine E-Mail an Ihren Arzt. Sie möchten einen Termin absagen und einen neuen Termin vereinbaren. Schreiben Sie: Warum können Sie nicht kommen? Wann haben Sie Zeit? (60-80 Wörter)', 
  'essay',
  'Beispiel: Sehr geehrter Dr. Schmidt, leider kann ich meinen Termin am Montag, den 15. März um 10 Uhr nicht wahrnehmen. Ich bin beruflich unterwegs und kann nicht rechtzeitig zurück sein. Könnten wir einen neuen Termin vereinbaren? Ich hätte Zeit am Mittwoch, den 17. März nachmittags oder am Donnerstag, den 18. März vormittags. Bitte geben Sie mir Bescheid, welcher Termin möglich ist. Mit freundlichen Grüßen, Maria Kamau',
  1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

-- Q2: Informal message - invitation
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie eine Nachricht an einen Freund. Laden Sie ihn zu Ihrem Geburtstag ein. Schreiben Sie: Wann und wo? Was gibt es? Was soll er mitbringen? (50-70 Wörter)', 
  'essay',
  'Beispiel: Hallo Peter! Ich habe am Samstag, den 20. Mai Geburtstag und mache eine Party bei mir zu Hause. Die Party beginnt um 19 Uhr. Es gibt Essen und Musik. Kannst du etwas zu trinken mitbringen? Ich freue mich, wenn du kommst! Sag mir bitte bis Mittwoch Bescheid, ob du Zeit hast. Liebe Grüße, Sarah',
  2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

-- Q3: Complaint letter
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sie haben online einen Pullover bestellt, aber er ist zu klein. Schreiben Sie eine E-Mail an den Shop. Beschreiben Sie das Problem und sagen Sie, was Sie möchten. (60-80 Wörter)', 
  'essay',
  'Beispiel: Sehr geehrte Damen und Herren, ich habe letzte Woche einen Pullover in Größe M bestellt (Bestellnummer: 12345). Leider ist der Pullover zu klein. Ich möchte ihn gerne umtauschen und Größe L bekommen. Ist das möglich? Wie funktioniert der Umtausch? Muss ich den Pullover zurückschicken? Bitte senden Sie mir Informationen. Mit freundlichen Grüßen, John Ochieng',
  3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

-- Q4: Job application
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie eine kurze Bewerbung für einen Ferienjob im Supermarkt. Schreiben Sie: Wer sind Sie? Warum möchten Sie den Job? Wann haben Sie Zeit? (70-90 Wörter)', 
  'essay',
  'Beispiel: Sehr geehrte Damen und Herren, ich heiße David Mwangi und bin 22 Jahre alt. Ich studiere Betriebswirtschaft an der Universität Nairobi. Ich suche einen Ferienjob für die Sommermonate Juli und August. Ich habe schon Erfahrung im Verkauf und arbeite gerne im Team. Ich bin zuverlässig und lerne schnell. Ich kann von Montag bis Samstag arbeiten. Über eine Einladung zu einem Gespräch würde ich mich sehr freuen. Mit freundlichen Grüßen, David Mwangi',
  4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

-- Q5: Travel report
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie über eine Reise, die Sie gemacht haben. Wohin sind Sie gefahren? Was haben Sie gemacht? Wie war es? (70-90 Wörter)', 
  'essay',
  'Beispiel: Letzten Monat war ich in Mombasa am Meer. Ich bin mit dem Bus gefahren. Die Fahrt hat 8 Stunden gedauert. Das Hotel war sehr schön und direkt am Strand. Jeden Tag bin ich schwimmen gegangen und habe in der Sonne gelegen. Das Essen war ausgezeichnet, besonders der frische Fisch. Ich habe auch eine Bootstour gemacht und Delfine gesehen. Das war fantastisch! Die Reise war wunderbar und ich möchte nächstes Jahr wieder nach Mombasa fahren.',
  5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

-- Q6: Apartment search
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sie suchen eine Wohnung. Schreiben Sie eine E-Mail an einen Vermieter. Stellen Sie sich vor und stellen Sie Fragen zur Wohnung. (60-80 Wörter)', 
  'essay',
  'Beispiel: Sehr geehrte Frau Müller, ich habe Ihre Anzeige für die 2-Zimmer-Wohnung gelesen. Ich interessiere mich sehr für die Wohnung. Ich bin 28 Jahre alt und arbeite als Krankenpfleger im Krankenhaus. Ich suche eine ruhige Wohnung in guter Lage. Ist die Wohnung noch frei? Wann kann ich die Wohnung besichtigen? Sind Haustiere erlaubt? Ich habe eine kleine Katze. Ich freue mich auf Ihre Antwort. Mit freundlichen Grüßen, James Kimani',
  6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

-- Q7: Restaurant recommendation
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Ein Freund besucht Sie. Empfehlen Sie ihm ein Restaurant. Beschreiben Sie: Welches Restaurant? Was gibt es dort? Warum ist es gut? (60-80 Wörter)', 
  'essay',
  'Beispiel: Hallo Tom! Ich empfehle dir das Restaurant "Zum Löwen" in der Stadtmitte. Dort gibt es traditionelle deutsche Küche. Das Schnitzel ist besonders lecker! Die Preise sind nicht zu teuer, ein Hauptgericht kostet etwa 12-15 Euro. Das Restaurant ist sehr gemütlich und das Personal ist freundlich. Am Wochenende ist es oft voll, deshalb solltest du vorher reservieren. Die Telefonnummer ist 030-12345678. Ich hoffe, es gefällt dir! Viele Grüße, Anna',
  7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

-- Q8: Course feedback
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sie haben einen Deutschkurs besucht. Schreiben Sie eine Bewertung. Was war gut? Was war nicht so gut? Würden Sie den Kurs empfehlen? (70-90 Wörter)', 
  'essay',
  'Beispiel: Ich habe drei Monate lang den B1-Deutschkurs bei der Sprachschule Berlin besucht. Der Lehrer war sehr kompetent und hat alles gut erklärt. Der Unterricht war interessant und abwechslungsreich. Wir haben viel gesprochen und das hat mir geholfen. Leider war die Gruppe mit 15 Personen etwas zu groß. Manchmal hatte man nicht genug Zeit zum Sprechen. Die Räume waren modern und gut ausgestattet. Insgesamt war der Kurs sehr gut und ich würde ihn weiterempfehlen.',
  8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

-- Q9: Daily routine description
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Beschreiben Sie einen typischen Arbeitstag. Wann stehen Sie auf? Was machen Sie? Wann gehen Sie schlafen? (70-90 Wörter)', 
  'essay',
  'Beispiel: Ich stehe jeden Morgen um 6 Uhr auf. Zuerst dusche ich und frühstücke. Um 7:30 Uhr fahre ich mit dem Bus zur Arbeit. Die Fahrt dauert 30 Minuten. Ich arbeite in einem Büro von 8 bis 17 Uhr mit einer Stunde Mittagspause. Nach der Arbeit gehe ich manchmal einkaufen oder treffe Freunde. Abends koche ich und esse zu Hause. Dann sehe ich fern oder lese ein Buch. Um 23 Uhr gehe ich ins Bett. Am Wochenende schlafe ich länger.',
  9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

-- Q10: Event invitation response
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sie haben eine Einladung zu einer Hochzeit bekommen, aber Sie können nicht kommen. Schreiben Sie eine Antwort. Bedanken Sie sich, erklären Sie warum Sie nicht können, wünschen Sie alles Gute. (60-80 Wörter)', 
  'essay',
  'Beispiel: Liebe Lisa, lieber Michael, vielen Dank für die Einladung zu eurer Hochzeit! Ich freue mich sehr für euch. Leider kann ich am 20. Juni nicht kommen, weil ich an diesem Tag auf einer Konferenz in Nairobi bin. Das tut mir sehr leid! Ich wünsche euch einen wunderschönen Tag und alles Gute für eure gemeinsame Zukunft. Ich hoffe, wir sehen uns bald und ihr erzählt mir von der Feier. Herzliche Grüße, Grace',
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'writing';

-- A2 SPEAKING QUESTIONS (10)

-- Q1: Introducing yourself in detail
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Stellen Sie sich ausführlich vor: Name, Alter, Herkunft, Familie, Beruf/Studium, Hobbys, Wohnort. Sprechen Sie 2-3 Minuten.', 
  'essay',
  'Bewertung: Vollständige Informationen, zusammenhängende Sätze, Vergangenheit und Gegenwart, klare Aussprache, angemessenes Tempo.',
  1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'speaking';

-- Q2: Describing a past event
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Erzählen Sie von Ihrem letzten Urlaub oder Wochenende. Wohin sind Sie gefahren? Was haben Sie gemacht? Wie war das Wetter? Mit wem waren Sie?', 
  'essay',
  'Beispiel: Letztes Wochenende war ich mit meiner Familie am Naivasha-See. Wir sind am Samstag früh losgefahren. Das Wetter war sehr schön und sonnig. Wir haben ein Boot gemietet und sind auf dem See gefahren. Wir haben viele Vögel gesehen. Mittags haben wir am Ufer gegrillt. Das Essen war lecker. Am Abend sind wir zurückgefahren. Es war ein toller Tag!',
  2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'speaking';

-- Q3: Making a complaint
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sie haben im Restaurant kaltes Essen bekommen. Beschweren Sie sich höflich beim Kellner. Was sagen Sie?', 
  'essay',
  'Beispiel: Entschuldigung, ich habe ein Problem. Mein Essen ist leider kalt. Könnten Sie es bitte noch einmal warm machen? Oder können Sie mir ein neues Gericht bringen? Das wäre sehr nett. Vielen Dank!',
  3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'speaking';

-- Q4: Asking for help
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sie verstehen einen Brief von Ihrer Krankenkasse nicht. Rufen Sie dort an und bitten Sie um Hilfe. Was sagen Sie?', 
  'essay',
  'Beispiel: Guten Tag! Mein Name ist Maria Kamau. Ich habe einen Brief von Ihnen bekommen, aber ich verstehe ihn nicht ganz. Können Sie mir bitte helfen? Was bedeutet dieser Satz hier? Muss ich etwas bezahlen? Bis wann muss ich das machen? Könnten Sie das bitte noch einmal erklären? Vielen Dank für Ihre Hilfe!',
  4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'speaking';

-- Q5: Comparing two things
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Vergleichen Sie das Leben in der Stadt und auf dem Land. Was ist besser? Was ist schlechter? Was gefällt Ihnen besser?', 
  'essay',
  'Beispiel: In der Stadt gibt es mehr Geschäfte und Restaurants. Man kann viel unternehmen. Aber es ist laut und stressig. Auf dem Land ist es ruhiger und die Luft ist besser. Aber es gibt weniger Arbeit und man braucht ein Auto. Ich persönlich mag die Stadt lieber, weil ich gerne ausgehe und Freunde treffe. Aber am Wochenende fahre ich gerne aufs Land, um mich zu erholen.',
  5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'speaking';

-- Q6: Giving advice
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Ein Freund möchte Deutsch lernen. Geben Sie ihm Tipps. Was soll er machen? Welche Methoden sind gut?', 
  'essay',
  'Beispiel: Ich empfehle dir, einen Kurs zu besuchen. Das ist am besten. Du solltest auch jeden Tag ein bisschen lernen, nicht nur einmal pro Woche. Schau deutsche Filme mit Untertiteln. Das hilft sehr! Lies einfache Texte und Kinderbücher. Sprich mit deutschen Freunden, wenn möglich. Und hab keine Angst, Fehler zu machen! Das ist normal beim Lernen.',
  6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'speaking';

-- Q7: Describing your home
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Beschreiben Sie Ihre Wohnung oder Ihr Haus. Wie viele Zimmer gibt es? Wie ist es eingerichtet? Was gefällt Ihnen? Was möchten Sie ändern?', 
  'essay',
  'Beispiel: Ich wohne in einer 3-Zimmer-Wohnung im zweiten Stock. Es gibt ein Wohnzimmer, ein Schlafzimmer, eine Küche und ein Bad. Das Wohnzimmer ist groß und hell. Dort steht ein Sofa, ein Fernseher und ein Esstisch. Die Küche ist klein, aber modern. Ich habe einen kleinen Balkon mit Blumen. Mir gefällt die Wohnung sehr gut. Nur das Bad ist etwas alt. Das möchte ich gerne renovieren.',
  7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'speaking';

-- Q8: Planning an activity
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sie möchten mit einem Freund ins Kino gehen. Schlagen Sie einen Film vor, vereinbaren Sie Zeit und Treffpunkt. Was sagen Sie?', 
  'essay',
  'Beispiel: Hallo Peter! Hast du Lust, am Samstag ins Kino zu gehen? Es läuft ein neuer Action-Film. Der soll sehr gut sein. Wann hast du Zeit? Um 18 Uhr oder um 20 Uhr? Wir können uns vor dem Kino treffen, zum Beispiel um 17:45 Uhr. Danach können wir noch etwas essen gehen. Was meinst du? Hast du Lust?',
  8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'speaking';

-- Q9: Talking about health
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sie sind beim Arzt. Beschreiben Sie Ihre Symptome. Was tut Ihnen weh? Seit wann haben Sie die Beschwerden?', 
  'essay',
  'Beispiel: Guten Tag, Herr Doktor. Mir geht es nicht gut. Ich habe seit drei Tagen starke Kopfschmerzen und Fieber. Mein Hals tut auch weh und ich huste viel. Ich bin sehr müde und habe keinen Appetit. Nachts kann ich nicht gut schlafen, weil ich die ganze Zeit husten muss. Was kann ich tun? Brauche ich Medikamente?',
  9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'speaking';

-- Q10: Expressing preferences
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sprechen Sie über Ihre Hobbys und Freizeitaktivitäten. Was machen Sie gerne? Was machen Sie nicht gerne? Wie oft machen Sie das?', 
  'essay',
  'Beispiel: In meiner Freizeit mache ich gerne Sport. Ich spiele zweimal pro Woche Fußball mit Freunden. Das macht viel Spaß! Ich lese auch gerne Bücher, besonders Krimis. Am Wochenende gehe ich manchmal ins Kino oder treffe Freunde. Ich koche nicht so gerne, deshalb esse ich oft im Restaurant. Fernsehen finde ich langweilig. Ich höre lieber Musik oder gehe spazieren.',
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'speaking';
