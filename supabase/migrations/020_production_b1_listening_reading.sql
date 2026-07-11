-- Production B1 LISTENING & READING Questions (20 questions total)
-- CEFR B1: Understanding main points, handling most situations

-- Delete existing B1 listening and reading questions
DELETE FROM questions WHERE test_module_id IN (
  SELECT tm.id FROM test_modules tm
  JOIN levels l ON tm.level_id = l.id
  JOIN skills s ON tm.skill_id = s.id
  WHERE l.code = 'B1' AND s.code IN ('listening', 'reading')
);

-- B1 LISTENING QUESTIONS (10)

-- Q1: Radio news
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Radionachrichten: "Die Regierung plant, die Mehrwertsteuer ab nächstem Jahr um 2 Prozent zu erhöhen. Experten kritisieren diese Entscheidung, weil dadurch die Lebenshaltungskosten steigen werden." Was wird kritisiert?', 
  'multiple_choice',
  jsonb_build_array(
    'Die Steuererhöhung',
    'Die Experten',
    'Die Regierung allgemein',
    'Die Lebenshaltungskosten'
  ),
  'Die Steuererhöhung',
  'Experten kritisieren die Entscheidung, die Mehrwertsteuer zu erhöhen, weil dies die Lebenshaltungskosten erhöht.',
  1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

-- Q2: Job interview dialogue
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Vorstellungsgespräch: "Warum möchten Sie bei uns arbeiten?" - "Ihr Unternehmen hat einen ausgezeichneten Ruf und bietet interessante Entwicklungsmöglichkeiten. Außerdem passen meine Qualifikationen perfekt zur Stellenbeschreibung." Was ist der Hauptgrund?', 
  'multiple_choice',
  jsonb_build_array(
    'Entwicklungsmöglichkeiten und passende Qualifikationen',
    'Nur der gute Ruf',
    'Nur die Qualifikationen',
    'Das Gehalt'
  ),
  'Entwicklungsmöglichkeiten und passende Qualifikationen',
  'Der Bewerber nennt mehrere Gründe: den Ruf des Unternehmens, Entwicklungsmöglichkeiten und die Passung seiner Qualifikationen.',
  2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

-- Q3: Environmental discussion
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Diskussion: "Wir müssen dringend etwas gegen den Klimawandel tun. Jeder Einzelne kann durch weniger Autofahren und bewussteren Konsum einen Beitrag leisten." Was wird empfohlen?', 
  'multiple_choice',
  jsonb_build_array(
    'Individuelle Verhaltensänderungen',
    'Nur politische Maßnahmen',
    'Nichts zu tun',
    'Mehr zu konsumieren'
  ),
  'Individuelle Verhaltensänderungen',
  'Der Sprecher betont, dass "jeder Einzelne" durch Verhaltensänderungen (weniger Auto, bewusster Konsum) beitragen kann.',
  3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

-- Q4: University lecture excerpt
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Vorlesung: "Die Digitalisierung verändert unsere Arbeitswelt grundlegend. Während einige Berufe verschwinden, entstehen neue. Lebenslanges Lernen wird immer wichtiger." Was ist die Hauptaussage?', 
  'multiple_choice',
  jsonb_build_array(
    'Arbeitswelt wandelt sich, Weiterbildung ist wichtig',
    'Alle Berufe verschwinden',
    'Digitalisierung ist schlecht',
    'Nichts ändert sich'
  ),
  'Arbeitswelt wandelt sich, Weiterbildung ist wichtig',
  'Die Kernaussage ist der Wandel der Arbeitswelt durch Digitalisierung und die Notwendigkeit lebenslangen Lernens.',
  4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

-- Q5: Customer service call
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Telefonat: "Ich habe vor drei Wochen ein Paket bestellt, aber es ist immer noch nicht angekommen. Können Sie nachsehen, wo es ist?" - "Einen Moment bitte. Das Paket wurde leider an die falsche Adresse geliefert. Wir senden Ihnen ein neues." Was ist das Problem?', 
  'multiple_choice',
  jsonb_build_array(
    'Falsche Lieferadresse',
    'Paket ist verloren',
    'Bestellung wurde storniert',
    'Paket ist beschädigt'
  ),
  'Falsche Lieferadresse',
  'Der Kundenservice erklärt, dass das Paket "an die falsche Adresse geliefert" wurde.',
  5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

-- Q6: Travel report
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Reisebericht: "Obwohl das Hotel etwas außerhalb lag, war die Lage ideal zum Entspannen. Die Zimmer waren sauber, allerdings war das WLAN sehr langsam. Das Personal war ausgesprochen hilfsbereit." Was wird positiv bewertet?', 
  'multiple_choice',
  jsonb_build_array(
    'Lage, Sauberkeit und Personal',
    'Nur die Lage',
    'Nur das WLAN',
    'Alles war perfekt'
  ),
  'Lage, Sauberkeit und Personal',
  'Positiv: Lage (ideal zum Entspannen), Sauberkeit, hilfsbereites Personal. Negativ: langsames WLAN.',
  6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

-- Q7: Health advice
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Gesundheitstipp: "Regelmäßige Bewegung ist wichtiger als intensives Training. Schon 30 Minuten Spazierengehen täglich können das Risiko für Herzkrankheiten deutlich senken." Was wird empfohlen?', 
  'multiple_choice',
  jsonb_build_array(
    'Regelmäßige moderate Bewegung',
    'Intensives Training',
    'Nur am Wochenende Sport',
    'Gar keine Bewegung'
  ),
  'Regelmäßige moderate Bewegung',
  'Die Empfehlung betont "regelmäßige Bewegung" (täglich 30 Minuten) statt intensivem Training.',
  7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

-- Q8: Work meeting
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Besprechung: "Das Projekt läuft gut, aber wir liegen etwas hinter dem Zeitplan. Wir sollten zusätzliche Ressourcen einsetzen, um die Deadline einzuhalten." Was wird vorgeschlagen?', 
  'multiple_choice',
  jsonb_build_array(
    'Mehr Ressourcen einsetzen',
    'Die Deadline verschieben',
    'Das Projekt abbrechen',
    'Nichts ändern'
  ),
  'Mehr Ressourcen einsetzen',
  'Der Vorschlag ist, "zusätzliche Ressourcen einzusetzen", um trotz Verzögerung die Deadline zu halten.',
  8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

-- Q9: Cultural event announcement
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Ankündigung: "Das Stadtfest findet dieses Jahr vom 15. bis 17. Juli statt. Es gibt Live-Musik, internationale Küche und ein Kinderprogramm. Der Eintritt ist frei, aber für Konzerte braucht man Tickets." Was kostet Eintritt?', 
  'multiple_choice',
  jsonb_build_array(
    'Nur für Konzerte',
    'Für alles',
    'Für nichts',
    'Nur für Essen'
  ),
  'Nur für Konzerte',
  'Der Eintritt zum Fest ist frei, aber "für Konzerte braucht man Tickets" - nur diese kosten Geld.',
  9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

-- Q10: Technology discussion
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Gespräch: "Smartphones haben unser Leben erleichtert, aber wir verbringen zu viel Zeit damit. Es ist wichtig, auch mal offline zu sein und direkte soziale Kontakte zu pflegen." Was ist die Meinung?', 
  'multiple_choice',
  jsonb_build_array(
    'Smartphones sind nützlich, aber man sollte sie bewusst nutzen',
    'Smartphones sind nur schlecht',
    'Man sollte immer online sein',
    'Soziale Kontakte sind unwichtig'
  ),
  'Smartphones sind nützlich, aber man sollte sie bewusst nutzen',
  'Die Aussage ist differenziert: Smartphones haben Vorteile ("erleichtert"), aber bewusste Nutzung und Offline-Zeit sind wichtig.',
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'listening';

-- B1 READING QUESTIONS (10)

-- Q1: Newspaper article
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Artikel: "Die Stadt plant, die Innenstadt autofrei zu machen. Während Umweltschützer die Maßnahme begrüßen, befürchten Geschäftsinhaber Umsatzeinbußen. Ein Kompromiss könnte eine teilweise Sperrung sein." Welche Positionen gibt es?', 
  'multiple_choice',
  jsonb_build_array(
    'Umweltschützer dafür, Geschäftsinhaber dagegen',
    'Alle sind dafür',
    'Alle sind dagegen',
    'Niemand hat eine Meinung'
  ),
  'Umweltschützer dafür, Geschäftsinhaber dagegen',
  'Der Artikel zeigt zwei Positionen: Umweltschützer "begrüßen" die Maßnahme, Geschäftsinhaber "befürchten" Nachteile.',
  1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- Q2: Formal letter
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Brief: "Sehr geehrte Damen und Herren, hiermit kündige ich meine Wohnung zum 31. März. Ich bitte um Bestätigung und um einen Termin für die Wohnungsübergabe. Mit freundlichen Grüßen" Was möchte der Absender?', 
  'multiple_choice',
  jsonb_build_array(
    'Die Wohnung kündigen',
    'Die Miete erhöhen',
    'Reparaturen melden',
    'Einen Nachmieter suchen'
  ),
  'Die Wohnung kündigen',
  'Der Brief ist eine Kündigung: "hiermit kündige ich meine Wohnung zum 31. März".',
  2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- Q3: Product review
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Bewertung: "Der Laptop ist leistungsstark und hat ein gutes Display. Leider ist die Akkulaufzeit mit nur 4 Stunden enttäuschend. Für den Preis hätte ich mehr erwartet. Trotzdem empfehlenswert für Nutzer, die hauptsächlich am Schreibtisch arbeiten." Für wen ist der Laptop geeignet?', 
  'multiple_choice',
  jsonb_build_array(
    'Für Nutzer am Schreibtisch',
    'Für Reisende',
    'Für niemanden',
    'Für alle'
  ),
  'Für Nutzer am Schreibtisch',
  'Trotz kurzer Akkulaufzeit wird der Laptop "für Nutzer, die hauptsächlich am Schreibtisch arbeiten" empfohlen.',
  3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- Q4: Job description
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Stellenanzeige: "Wir suchen einen Marketing-Manager (m/w/d) mit mindestens 3 Jahren Berufserfahrung. Voraussetzungen: Hochschulabschluss, fließendes Englisch, Teamfähigkeit. Wir bieten: flexible Arbeitszeiten, Homeoffice-Möglichkeit, Weiterbildungen." Was wird NICHT angeboten?', 
  'multiple_choice',
  jsonb_build_array(
    'Firmenwagen',
    'Flexible Arbeitszeiten',
    'Homeoffice',
    'Weiterbildungen'
  ),
  'Firmenwagen',
  'Angeboten werden: flexible Arbeitszeiten, Homeoffice, Weiterbildungen. Ein Firmenwagen wird nicht erwähnt.',
  4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- Q5: Blog post
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Blog: "Minimalismus bedeutet nicht, auf alles zu verzichten. Es geht darum, bewusst zu entscheiden, was wirklich wichtig ist. Weniger Besitz kann zu mehr Freiheit und Zufriedenheit führen." Was ist die Kernaussage?', 
  'multiple_choice',
  jsonb_build_array(
    'Bewusster Konsum führt zu mehr Lebensqualität',
    'Man sollte nichts besitzen',
    'Besitz macht glücklich',
    'Minimalismus ist unmöglich'
  ),
  'Bewusster Konsum führt zu mehr Lebensqualität',
  'Die Aussage betont bewusste Entscheidungen und dass "weniger Besitz" zu "mehr Freiheit und Zufriedenheit" führen kann.',
  5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- Q6: Insurance information
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Versicherungsinfo: "Die Haftpflichtversicherung deckt Schäden ab, die Sie anderen zufügen. Ausgenommen sind vorsätzliche Schäden und Schäden am eigenen Eigentum. Die Deckungssumme beträgt 5 Millionen Euro." Was ist NICHT versichert?', 
  'multiple_choice',
  jsonb_build_array(
    'Eigene Schäden und vorsätzliche Schäden',
    'Schäden an anderen',
    'Unfallschäden',
    'Alle Schäden'
  ),
  'Eigene Schäden und vorsätzliche Schäden',
  'Ausgeschlossen sind "vorsätzliche Schäden" und "Schäden am eigenen Eigentum".',
  6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- Q7: Study abroad information
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Studieninfo: "Das Erasmus-Programm ermöglicht Studierenden, ein oder zwei Semester im Ausland zu studieren. Die Studienleistungen werden anerkannt. Studierende erhalten ein monatliches Stipendium von 300-500 Euro." Was ist ein Vorteil?', 
  'multiple_choice',
  jsonb_build_array(
    'Anerkennung der Studienleistungen',
    'Kostenlose Unterkunft',
    'Garantierter Arbeitsplatz',
    'Keine Prüfungen'
  ),
  'Anerkennung der Studienleistungen',
  'Ein wichtiger Vorteil: "Die Studienleistungen werden anerkannt" - man verliert keine Studienzeit.',
  7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- Q8: Rental agreement excerpt
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Mietvertrag: "Der Mieter verpflichtet sich, Schönheitsreparaturen selbst durchzuführen. Dazu gehören Tapezieren und Streichen. Größere Reparaturen trägt der Vermieter. Die Kündigungsfrist beträgt drei Monate." Wer zahlt größere Reparaturen?', 
  'multiple_choice',
  jsonb_build_array(
    'Der Vermieter',
    'Der Mieter',
    'Beide zusammen',
    'Niemand'
  ),
  'Der Vermieter',
  'Im Vertrag steht: "Größere Reparaturen trägt der Vermieter".',
  8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- Q9: Health article
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Gesundheitsartikel: "Stress ist nicht grundsätzlich schlecht. Kurzfristiger Stress kann die Leistung steigern. Problematisch wird es erst bei chronischem Stress, der zu gesundheitlichen Problemen führen kann." Was ist die Aussage über Stress?', 
  'multiple_choice',
  jsonb_build_array(
    'Kurzfristiger Stress ist okay, chronischer ist problematisch',
    'Jeder Stress ist schädlich',
    'Stress ist immer gut',
    'Stress existiert nicht'
  ),
  'Kurzfristiger Stress ist okay, chronischer ist problematisch',
  'Der Artikel differenziert: Kurzfristiger Stress kann positiv sein, chronischer Stress ist problematisch.',
  9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';

-- Q10: Consumer rights
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Verbraucherinfo: "Bei Online-Käufen haben Sie ein 14-tägiges Widerrufsrecht. Sie können die Ware ohne Angabe von Gründen zurückschicken. Ausgenommen sind verderbliche Waren und individuell angefertigte Produkte." Was kann man NICHT zurückgeben?', 
  'multiple_choice',
  jsonb_build_array(
    'Verderbliche und individuell angefertigte Waren',
    'Alle Waren',
    'Nur Kleidung',
    'Nur Elektronik'
  ),
  'Verderbliche und individuell angefertigte Waren',
  'Ausnahmen vom Widerrufsrecht: "verderbliche Waren und individuell angefertigte Produkte".',
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B1' AND s.code = 'reading';
