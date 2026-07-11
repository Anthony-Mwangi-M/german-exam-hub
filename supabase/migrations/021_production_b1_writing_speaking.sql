-- Production B1 WRITING & SPEAKING Questions (20 questions)

DELETE FROM questions WHERE test_module_id IN (
  SELECT tm.id FROM test_modules tm
  JOIN levels l ON tm.level_id = l.id
  JOIN skills s ON tm.skill_id = s.id
  WHERE l.code = 'B1' AND s.code IN ('writing', 'speaking')
);

-- B1 WRITING QUESTIONS (10)

-- Q1: Opinion essay
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie Ihre Meinung zum Thema: "Sollte Homeoffice zur Pflicht werden?" Nennen Sie Vor- und Nachteile und begründen Sie Ihre Position. (120-150 Wörter)', 
  'essay',
  'Beispiel: Homeoffice hat sowohl Vorteile als auch Nachteile. Einerseits spart man Zeit und Geld für den Arbeitsweg. Man kann flexibler arbeiten und Familie und Beruf besser vereinbaren. Andererseits fehlt der direkte Kontakt zu Kollegen, was die Zusammenarbeit erschweren kann. Außerdem fällt es manchen Menschen schwer, zu Hause konzentriert zu arbeiten. Meiner Meinung nach sollte Homeoffice nicht zur Pflicht werden, aber als Option angeboten werden. Jeder Mitarbeiter sollte selbst entscheiden können, ob er lieber im Büro oder zu Hause arbeitet. Ein Hybrid-Modell, bei dem man einige Tage im Büro und einige Tage zu Hause arbeitet, wäre ideal. So kombiniert man die Vorteile beider Arbeitsformen.',
  1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

-- Q2: Formal complaint
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sie haben ein defektes Produkt erhalten. Schreiben Sie eine formelle Beschwerde an den Hersteller. Beschreiben Sie das Problem, erklären Sie, was Sie bereits unternommen haben, und sagen Sie, was Sie erwarten. (120-150 Wörter)', 
  'essay',
  'Beispiel: Sehr geehrte Damen und Herren, am 15. Februar habe ich bei Ihnen einen Staubsauger (Modell XY-2000, Bestellnummer 123456) bestellt. Leider funktioniert das Gerät nicht ordnungsgemäß. Der Motor macht laute Geräusche und schaltet sich nach wenigen Minuten automatisch ab. Ich habe bereits versucht, das Problem durch Reinigung des Filters zu beheben, aber ohne Erfolg. Auch die Bedienungsanleitung konnte mir nicht weiterhelfen. Da das Produkt offensichtlich einen Defekt hat, erwarte ich eine kostenlose Reparatur oder einen Ersatz. Sollte dies nicht möglich sein, möchte ich vom Kaufvertrag zurücktreten und eine vollständige Rückerstattung erhalten. Ich bitte um eine schnelle Bearbeitung meiner Beschwerde und um Mitteilung, wie wir weiter vorgehen. Mit freundlichen Grüßen',
  2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

-- Q3: Recommendation letter
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Ein Freund möchte in Ihrer Stadt studieren. Schreiben Sie ihm einen Brief mit Informationen und Tipps: Wohnungssuche, Lebenshaltungskosten, Freizeitangebote, Verkehr. (120-150 Wörter)', 
  'essay',
  'Beispiel: Lieber Tom, ich freue mich, dass du in Berlin studieren möchtest! Hier ein paar Tipps: Die Wohnungssuche ist nicht einfach. Am besten suchst du online auf WG-gesucht.de oder Immobilienscout24. Ein WG-Zimmer kostet etwa 400-600 Euro. Die Lebenshaltungskosten sind moderat. Für Essen und Transport solltest du etwa 300 Euro pro Monat einplanen. Als Student bekommst du ein Semesterticket für öffentliche Verkehrsmittel. Berlin hat ein ausgezeichnetes U-Bahn- und Bus-Netz. In deiner Freizeit gibt es viel zu tun: Museen, Theater, Parks und Clubs. Viele Museen bieten Studentenrabatte. Ich empfehle dir, früh mit der Wohnungssuche zu beginnen, am besten 2-3 Monate vor Studienbeginn. Wenn du Fragen hast, melde dich gerne! Viele Grüße',
  3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

-- Q4: Job application letter
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie ein Bewerbungsschreiben für eine Stelle als Verkäufer/in. Stellen Sie sich vor, beschreiben Sie Ihre Qualifikationen und Erfahrungen, erklären Sie Ihre Motivation. (130-160 Wörter)', 
  'essay',
  'Beispiel: Sehr geehrte Damen und Herren, mit großem Interesse habe ich Ihre Stellenanzeige für eine/n Verkäufer/in gelesen. Ich möchte mich hiermit um diese Position bewerben. Ich bin 26 Jahre alt und habe eine Ausbildung als Einzelhandelskaufmann abgeschlossen. In den letzten drei Jahren habe ich in einem Modegeschäft gearbeitet, wo ich für Kundenberatung und Kassenabrechnung zuständig war. Dabei habe ich gelernt, freundlich und professionell mit Kunden umzugehen. Ich bin teamfähig, zuverlässig und arbeite gerne im Verkauf. Der Kontakt mit Menschen macht mir Spaß, und ich kann gut auf Kundenwünsche eingehen. Ihre Stelle interessiert mich besonders, weil Ihr Unternehmen einen ausgezeichneten Ruf hat und gute Entwicklungsmöglichkeiten bietet. Über eine Einladung zu einem persönlichen Gespräch würde ich mich sehr freuen. Mit freundlichen Grüßen',
  4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

-- Q5: Event report
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie einen Bericht über eine Veranstaltung, die Sie besucht haben (Konzert, Ausstellung, Sportveranstaltung). Beschreiben Sie: Was? Wann? Wo? Wie war es? (120-150 Wörter)', 
  'essay',
  'Beispiel: Letzten Samstag habe ich das Stadtfest in der Innenstadt besucht. Die Veranstaltung fand von 14 bis 22 Uhr auf dem Marktplatz statt. Es gab verschiedene Stände mit internationalem Essen, Live-Musik auf zwei Bühnen und ein Kinderprogramm. Besonders gut hat mir die Band "Die Stadtmusikanten" gefallen, die deutsche Rockmusik gespielt hat. Die Atmosphäre war sehr angenehm und familiär. Viele Menschen waren gekommen, aber es war nicht zu voll. Das Essen war lecker und die Preise waren fair. Ein Highlight war die Feuershow am Abend, die alle Besucher begeistert hat. Einziger Nachteil: Es gab zu wenige Sitzgelegenheiten. Insgesamt war es ein gelungenes Fest, und ich werde nächstes Jahr wieder hingehen. Ich kann die Veranstaltung allen empfehlen, die einen schönen Tag mit Familie oder Freunden verbringen möchten.',
  5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

-- Q6: Problem-solution essay
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Thema: "Plastikmüll ist ein großes Problem." Beschreiben Sie das Problem und schlagen Sie Lösungen vor. Was kann jeder Einzelne tun? Was sollte die Politik tun? (130-160 Wörter)', 
  'essay',
  'Beispiel: Plastikmüll ist eines der größten Umweltprobleme unserer Zeit. Jedes Jahr landen Millionen Tonnen Plastik in den Ozeanen und schaden der Tierwelt. Plastik braucht Hunderte von Jahren, um sich zu zersetzen. Es gibt verschiedene Lösungsansätze. Jeder Einzelne kann seinen Beitrag leisten, indem er weniger Plastik verwendet. Man sollte Stofftaschen statt Plastiktüten benutzen, Mehrwegflaschen kaufen und auf unnötige Verpackungen verzichten. Auch die Politik muss handeln. Einwegplastik sollte verboten oder stark besteuert werden. Supermärkte sollten verpflichtet werden, unverpackte Produkte anzubieten. Außerdem brauchen wir bessere Recyclingsysteme. Wichtig ist auch, dass Unternehmen umweltfreundliche Alternativen entwickeln. Nur wenn alle zusammenarbeiten - Verbraucher, Politik und Industrie - können wir das Plastikproblem lösen. Wir müssen jetzt handeln, um unsere Umwelt für zukünftige Generationen zu schützen.',
  6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

-- Q7: Formal request
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie einen formellen Brief an Ihre Hausverwaltung. Bitten Sie um Erlaubnis, ein Haustier zu halten. Beschreiben Sie das Tier und erklären Sie, warum es keine Probleme geben wird. (120-150 Wörter)', 
  'essay',
  'Beispiel: Sehr geehrte Damen und Herren, ich wohne seit zwei Jahren in Ihrer Wohnanlage (Musterstraße 10, Wohnung 23) und bin sehr zufrieden. Ich möchte Sie hiermit um Erlaubnis bitten, eine Katze zu halten. Es handelt sich um eine ruhige, erwachsene Hauskatze, die ausschließlich in der Wohnung leben wird. Die Katze wird nicht nach draußen gehen und daher keine Probleme im Treppenhaus oder Garten verursachen. Ich bin bereit, eine zusätzliche Kaution zu hinterlegen und die Wohnung bei Auszug professionell reinigen zu lassen. Als verantwortungsvoller Tierhalter werde ich dafür sorgen, dass keine Lärmbelästigung oder Geruchsbelästigung entsteht. Ich habe bereits mit meinen direkten Nachbarn gesprochen, und sie haben keine Einwände. Ich würde mich sehr freuen, wenn Sie meinem Antrag zustimmen könnten. Für Rückfragen stehe ich gerne zur Verfügung. Mit freundlichen Grüßen',
  7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

-- Q8: Comparison essay
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Vergleichen Sie das Lernen in der Schule mit dem Selbststudium. Was sind die Vor- und Nachteile? Was ist effektiver? (120-150 Wörter)', 
  'essay',
  'Beispiel: Schulunterricht und Selbststudium haben beide Vor- und Nachteile. In der Schule hat man einen strukturierten Lehrplan und professionelle Lehrer, die Fragen beantworten können. Man lernt in einer Gruppe, was motivierend sein kann. Außerdem gibt es regelmäßige Tests, die den Lernfortschritt überprüfen. Nachteile sind, dass man sich an feste Zeiten halten muss und das Tempo nicht selbst bestimmen kann. Beim Selbststudium ist man völlig flexibel. Man kann lernen, wann und wo man möchte, und sich auf die Themen konzentrieren, die einen interessieren. Allerdings braucht man viel Selbstdisziplin, und es gibt niemanden, der Fragen beantwortet. Meiner Meinung nach ist eine Kombination am effektivsten. Man sollte einen Kurs besuchen, um die Grundlagen zu lernen, und dann durch Selbststudium vertiefen. So profitiert man von beiden Methoden.',
  8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

-- Q9: Invitation and information
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sie organisieren eine Abschiedsparty für einen Kollegen. Schreiben Sie eine E-Mail an alle Kollegen: Wann? Wo? Was ist geplant? Was soll jeder mitbringen? (120-150 Wörter)', 
  'essay',
  'Beispiel: Liebe Kolleginnen und Kollegen, wie ihr wisst, verlässt uns Thomas Ende des Monats. Deshalb möchte ich eine Abschiedsparty für ihn organisieren. Die Party findet am Freitag, den 28. März, ab 18 Uhr in unserem Büro statt. Wir werden den Konferenzraum dekorieren und dort feiern. Ich habe schon Getränke und Snacks bestellt, aber es wäre toll, wenn jeder noch etwas mitbringen könnte - zum Beispiel einen Salat, einen Kuchen oder andere Leckereien. Wir sammeln auch Geld für ein Abschiedsgeschenk. Jeder kann freiwillig 10-15 Euro geben. Ich denke, wir kaufen ihm einen Gutschein für seine Lieblingsb buchhandlung. Bitte gebt mir bis Mittwoch Bescheid, ob ihr kommen könnt, damit ich besser planen kann. Ich freue mich auf einen schönen Abend mit euch allen! Viele Grüße',
  9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

-- Q10: Personal experience narrative
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Erzählen Sie von einer Situation, in der Sie ein Problem lösen mussten. Was war das Problem? Wie haben Sie es gelöst? Was haben Sie gelernt? (130-160 Wörter)', 
  'essay',
  'Beispiel: Vor einem Jahr hatte ich ein großes Problem bei der Arbeit. Ich sollte eine wichtige Präsentation halten, aber am Abend vorher ist mein Computer abgestürzt. Alle meine Dateien waren weg, und ich hatte kein Backup. Zuerst war ich in Panik, aber dann habe ich ruhig überlegt, was ich tun kann. Ich habe einen Freund angerufen, der sich mit Computern auskennt. Er konnte die meisten Dateien wiederherstellen. Die fehlenden Informationen habe ich aus E-Mails und Notizen rekonstruiert. Ich habe die ganze Nacht durchgearbeitet und die Präsentation neu erstellt. Am nächsten Tag war ich müde, aber die Präsentation war fertig und lief gut. Aus dieser Erfahrung habe ich gelernt, wie wichtig regelmäßige Backups sind. Jetzt sichere ich alle wichtigen Dateien automatisch in der Cloud. Außerdem habe ich gelernt, in Stresssituationen ruhig zu bleiben und systematisch nach Lösungen zu suchen.',
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'writing';

-- B1 SPEAKING QUESTIONS (10)

-- Q1: Presenting an opinion
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Präsentieren Sie Ihre Meinung: "Sollten Schuluniformen Pflicht sein?" Nennen Sie Argumente dafür und dagegen, und begründen Sie Ihre Position. Sprechen Sie 2-3 Minuten.', 
  'essay',
  'Bewertung: Klare Struktur (Einleitung, Argumente, Schluss), differenzierte Argumentation, Verwendung von Konnektoren (einerseits/andererseits, deshalb, trotzdem), flüssige Sprache, angemessenes Tempo.',
  1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

-- Q2: Describing a process
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Erklären Sie, wie man in Ihrem Land einen Führerschein macht. Welche Schritte sind notwendig? Wie lange dauert es? Was kostet es?', 
  'essay',
  'Beispiel: In Kenia muss man zuerst eine Fahrschule besuchen. Man braucht mindestens 30 Fahrstunden. Dann macht man eine theoretische Prüfung über Verkehrsregeln. Wenn man diese besteht, darf man zur praktischen Prüfung. Die praktische Prüfung dauert etwa 30 Minuten. Man muss zeigen, dass man sicher fahren kann. Der ganze Prozess dauert normalerweise 2-3 Monate. Die Kosten liegen bei etwa 30.000-40.000 Schilling. Das ist ziemlich teuer für viele Menschen.',
  2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

-- Q3: Discussing advantages and disadvantages
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Diskutieren Sie Vor- und Nachteile von sozialen Medien. Wie nutzen Sie soziale Medien? Was finden Sie gut, was problematisch?', 
  'essay',
  'Beispiel: Soziale Medien haben viele Vorteile. Man kann leicht mit Freunden und Familie in Kontakt bleiben, auch wenn sie weit weg wohnen. Man bekommt schnell Nachrichten und Informationen. Für Unternehmen sind sie wichtig für Marketing. Aber es gibt auch Nachteile. Viele Menschen verbringen zu viel Zeit online. Es gibt Probleme mit Datenschutz und Fake News. Cybermobbing ist ein ernstes Problem. Ich nutze soziale Medien hauptsächlich, um mit Freunden zu kommunizieren und Fotos zu teilen. Ich versuche aber, nicht zu viel Zeit damit zu verbringen.',
  3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

-- Q4: Giving advice
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Ein Freund möchte nach Deutschland ziehen, um dort zu arbeiten. Geben Sie ihm Ratschläge: Was sollte er vorbereiten? Worauf sollte er achten? Was sind Herausforderungen?', 
  'essay',
  'Beispiel: Zuerst solltest du deine Deutschkenntnisse verbessern. Mindestens B1-Niveau ist wichtig. Du solltest dich über Visa-Anforderungen informieren und alle Dokumente vorbereiten. Suche schon von Kenia aus nach Wohnungen und Jobs online. Die Lebenshaltungskosten in Deutschland sind höher als in Kenia, besonders in großen Städten. Du brauchst eine Krankenversicherung - das ist Pflicht. Das Wetter ist sehr unterschiedlich, im Winter ist es kalt. Kulturell gibt es Unterschiede: Deutsche sind sehr pünktlich und direkt. Sei offen für neue Erfahrungen und hab Geduld. Die ersten Monate sind schwierig, aber es wird besser.',
  4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

-- Q5: Describing a memorable experience
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Erzählen Sie von einem Erlebnis, das Sie nie vergessen werden. Was ist passiert? Warum war es so besonders? Wie haben Sie sich gefühlt?', 
  'essay',
  'Beispiel: Ich werde nie vergessen, als ich meinen Universitätsabschluss gemacht habe. Es war ein sehr emotionaler Tag. Ich war die erste Person in meiner Familie, die studiert hat. Meine Eltern waren so stolz. Die Zeremonie war wunderschön. Als ich mein Diplom bekommen habe, musste ich weinen. Ich habe an all die schwierigen Jahre gedacht, die harte Arbeit, die Prüfungen. Manchmal wollte ich aufgeben, aber ich habe durchgehalten. Nach der Zeremonie haben wir mit der ganzen Familie gefeiert. Es war einer der glücklichsten Tage meines Lebens. Dieses Erlebnis hat mir gezeigt, dass man alles erreichen kann, wenn man hart arbeitet und nicht aufgibt.',
  5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

-- Q6: Hypothetical situation
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Was würden Sie tun, wenn Sie im Lotto gewinnen würden? Wie würden Sie das Geld verwenden? Würde sich Ihr Leben ändern?', 
  'essay',
  'Beispiel: Wenn ich im Lotto gewinnen würde, würde ich zuerst meiner Familie helfen. Ich würde meinen Eltern ein schönes Haus kaufen. Dann würde ich einen Teil des Geldes sparen und investieren. Ich würde auch etwas für wohltätige Zwecke spenden, vielleicht für Bildungsprojekte in Kenia. Ich würde gerne reisen und die Welt sehen. Aber ich würde trotzdem weiter arbeiten, weil mir mein Beruf Spaß macht. Ich denke, zu viel Geld kann auch Probleme bringen. Deshalb würde ich versuchen, vernünftig damit umzugehen und nicht alles auf einmal auszugeben.',
  6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

-- Q7: Explaining cultural differences
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Beschreiben Sie wichtige kulturelle Unterschiede zwischen Ihrem Land und Deutschland. Was sollten Deutsche wissen, wenn sie Ihr Land besuchen?', 
  'essay',
  'Beispiel: Es gibt viele kulturelle Unterschiede zwischen Kenia und Deutschland. In Kenia sind wir sehr gastfreundlich und herzlich. Wir begrüßen uns oft mit Umarmungen, auch wenn wir jemanden nicht gut kennen. Familie ist sehr wichtig, und wir treffen oft die erweiterte Familie. In Deutschland sind die Menschen eher reserviert und brauchen mehr persönlichen Raum. Pünktlichkeit ist in Deutschland sehr wichtig, in Kenia sind wir flexibler mit der Zeit. Wenn Deutsche Kenia besuchen, sollten sie wissen, dass wir sehr freundlich sind und gerne mit Besuchern sprechen. Sie sollten respektvoll mit älteren Menschen umgehen. Und sie sollten bereit sein, verschiedene Speisen zu probieren!',
  7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

-- Q8: Problem-solving discussion
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Ihr Nachbar macht jeden Abend bis spät in die Nacht laute Musik. Was würden Sie tun? Wie würden Sie das Problem lösen?', 
  'essay',
  'Beispiel: Zuerst würde ich freundlich mit meinem Nachbarn sprechen. Ich würde erklären, dass die laute Musik mich stört und ich nicht schlafen kann. Vielleicht weiß er nicht, dass es so laut ist. Ich würde vorschlagen, dass er die Musik nach 22 Uhr leiser macht. Wenn das nicht hilft, würde ich mit dem Vermieter sprechen. Als letzten Schritt könnte man die Polizei rufen, aber das würde ich nur machen, wenn nichts anderes funktioniert. Ich denke, die meisten Probleme kann man durch ruhige Gespräche lösen. Man sollte immer erst versuchen, eine friedliche Lösung zu finden.',
  8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

-- Q9: Future plans
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Sprechen Sie über Ihre Zukunftspläne. Was möchten Sie in den nächsten 5 Jahren erreichen? Beruflich und privat?', 
  'essay',
  'Beispiel: In den nächsten fünf Jahren möchte ich beruflich weiterkommen. Ich arbeite jetzt als Krankenpfleger, aber ich möchte mich spezialisieren, vielleicht in der Kinderkrankenpflege. Dafür muss ich noch eine Weiterbildung machen. Ich möchte auch mein Deutsch verbessern und vielleicht in Deutschland arbeiten. Das ist mein großer Traum. Privat möchte ich eine Familie gründen. Ich bin jetzt mit meiner Freundin zusammen, und wir planen zu heiraten. Wir möchten auch ein Haus kaufen. Außerdem möchte ich mehr reisen und neue Länder kennenlernen. Ich weiß, dass nicht alles so klappt, wie man plant, aber ich bin optimistisch.',
  9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';

-- Q10: Expressing regret and lessons learned
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Gibt es etwas, das Sie in Ihrem Leben bereuen? Was würden Sie anders machen, wenn Sie die Zeit zurückdrehen könnten? Was haben Sie daraus gelernt?', 
  'essay',
  'Beispiel: Ja, ich bereue, dass ich in der Schule nicht fleißiger gelernt habe. Ich habe viel Zeit mit Freunden verbracht und nicht genug für die Schule getan. Deshalb waren meine Noten nicht so gut. Wenn ich die Zeit zurückdrehen könnte, würde ich mehr lernen und mich besser auf Prüfungen vorbereiten. Aber ich habe daraus gelernt, dass Bildung sehr wichtig ist. Deshalb nehme ich jetzt mein Studium sehr ernst. Ich habe auch gelernt, dass man Chancen nutzen sollte, wenn man sie hat. Man bekommt nicht immer eine zweite Chance. Diese Erfahrung hat mich zu einem verantwortungsvolleren Menschen gemacht.',
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'speaking';
