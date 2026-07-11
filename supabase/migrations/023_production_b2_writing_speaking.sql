-- Production B2 WRITING & SPEAKING Questions (20 questions)

DELETE FROM questions WHERE test_module_id IN (
  SELECT tm.id FROM test_modules tm
  JOIN levels l ON tm.level_id = l.id
  JOIN skills s ON tm.skill_id = s.id
  WHERE l.code = 'B2' AND s.code IN ('writing', 'speaking')
);

-- B2 WRITING QUESTIONS (10)

-- Q1: Argumentative essay
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Verfassen Sie einen argumentativen Essay zum Thema: "Künstliche Intelligenz in der Arbeitswelt - Chance oder Risiko?" Präsentieren Sie verschiedene Perspektiven und entwickeln Sie eine differenzierte Position. (200-250 Wörter)', 
  'essay',
  'Beispiel: Die Integration künstlicher Intelligenz in die Arbeitswelt ist ein kontroverses Thema, das sowohl Chancen als auch Risiken birgt. Befürworter argumentieren, dass KI repetitive Aufgaben übernehmen und somit menschliche Arbeitskraft für kreative und strategische Tätigkeiten freisetzen kann. Zudem ermöglicht sie Effizienzsteigerungen und kann gefährliche Arbeiten übernehmen. Kritiker hingegen befürchten massive Arbeitsplatzverluste, insbesondere in Bereichen mit routinierten Tätigkeiten. Die sozioökonomischen Folgen könnten gravierend sein, wenn keine adäquaten Umschulungsprogramme implementiert werden. Meiner Ansicht nach ist KI weder ausschließlich Chance noch Risiko, sondern eine transformative Kraft, die aktiv gestaltet werden muss. Entscheidend ist, dass Politik, Wirtschaft und Gesellschaft proaktiv handeln. Dies umfasst Investitionen in Bildung und lebenslanges Lernen, die Schaffung neuer Berufsfelder und soziale Absicherungssysteme für Übergangsphasen. Zudem müssen ethische Richtlinien für den KI-Einsatz entwickelt werden. Nur durch eine ganzheitliche Strategie, die technologischen Fortschritt mit sozialer Verantwortung verbindet, kann die Arbeitswelt der Zukunft human und produktiv gestaltet werden. Die Herausforderung besteht darin, Innovation zu fördern und gleichzeitig niemanden zurückzulassen.',
  1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

-- Q2: Formal report
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Verfassen Sie einen formellen Bericht über die Ergebnisse einer Mitarbeiterbefragung. Präsentieren Sie Daten, analysieren Sie Trends und geben Sie Empfehlungen. (180-220 Wörter)', 
  'essay',
  'Beispiel: Bericht: Mitarbeiterzufriedenheit 2024. Im März 2024 wurde eine umfassende Mitarbeiterbefragung durchgeführt (Teilnahmequote: 78%). Die Ergebnisse zeigen ein differenziertes Bild. Positiv bewertet wurden: Arbeitsatmosphäre (85% Zustimmung), Kollegialität (82%) und Aufgabenvielfalt (76%). Verbesserungsbedarf besteht bei: Work-Life-Balance (nur 54% zufrieden), Karriereentwicklung (48%) und Kommunikation zwischen Management und Mitarbeitern (52%). Im Vergleich zur Vorjahresbefragung ist die Gesamtzufriedenheit um 5 Prozentpunkte gesunken. Besonders auffällig ist die Unzufriedenheit jüngerer Mitarbeiter (unter 35 Jahre) bezüglich Entwicklungsmöglichkeiten. Empfehlungen: 1) Implementierung flexibler Arbeitsmodelle zur Verbesserung der Work-Life-Balance. 2) Etablierung strukturierter Karrierepfade und Mentoring-Programme. 3) Regelmäßige Town-Hall-Meetings zur Verbesserung der Kommunikation. 4) Gezielte Maßnahmen für jüngere Mitarbeiter, z.B. Weiterbildungsbudgets. Die Umsetzung dieser Maßnahmen sollte bis Ende Q3 erfolgen, mit einer Folgebefragung in 12 Monaten zur Erfolgskontrolle.',
  2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

-- Q3: Critical analysis
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Analysieren Sie kritisch die Aussage: "Soziale Medien fördern die Demokratie." Berücksichtigen Sie verschiedene Aspekte und entwickeln Sie eine nuancierte Position. (200-250 Wörter)', 
  'essay',
  'Beispiel: Die These, soziale Medien förderten die Demokratie, bedarf einer differenzierten Betrachtung. Einerseits haben soziale Medien zweifellos demokratisierende Potenziale. Sie ermöglichen direkte Kommunikation zwischen Bürgern und Politikern, senken Partizipationsbarrieren und geben marginalisierten Gruppen eine Stimme. Bewegungen wie der Arabische Frühling demonstrierten ihre mobilisierende Kraft. Andererseits zeigen sich problematische Entwicklungen. Algorithmische Filterblase verstärken Polarisierung, indem Nutzer primär Inhalte sehen, die ihre Ansichten bestätigen. Desinformation und Fake News verbreiten sich viral und untergraben faktenbasierte Diskurse. Zudem ermöglichen soziale Medien gezielte Manipulation durch Microtargeting und Bots. Die Konzentration der Macht bei wenigen Tech-Konzernen wirft Fragen demokratischer Kontrolle auf. Meiner Einschätzung nach sind soziale Medien ambivalent: Sie können Demokratie sowohl stärken als auch gefährden. Entscheidend ist die Regulierung. Transparenzpflichten für Algorithmen, Maßnahmen gegen Desinformation und Datenschutz sind essentiell. Gleichzeitig muss Medienkompetenz gefördert werden, damit Bürger kritisch mit Informationen umgehen können. Soziale Medien sind Werkzeuge - ihr demokratischer Wert hängt davon ab, wie wir sie gestalten und nutzen.',
  3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

-- Q4: Proposal writing
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie einen Projektvorschlag für eine Initiative zur Förderung nachhaltiger Mobilität in Ihrer Stadt. Beschreiben Sie Problem, Ziele, Maßnahmen und erwartete Ergebnisse. (180-220 Wörter)', 
  'essay',
  'Beispiel: Projektvorschlag: "Green Mobility Nairobi". Problemstellung: Nairobi leidet unter Verkehrschaos, Luftverschmutzung und ineffizienter Mobilität. Der motorisierte Individualverkehr dominiert, während nachhaltige Alternativen unterentwickelt sind. Projektziele: 1) Reduktion des CO2-Ausstoßes um 20% in drei Jahren. 2) Steigerung des Radverkehrsanteils von 2% auf 15%. 3) Verbesserung der Luftqualität. Geplante Maßnahmen: Phase 1 (Monate 1-6): Aufbau eines Fahrradverleihsystems mit 50 Stationen. Phase 2 (Monate 7-12): Schaffung von 100 km geschützten Radwegen. Phase 3 (Monate 13-24): Implementierung einer Bike-Sharing-App und Integration mit öffentlichem Nahverkehr. Phase 4 (Monate 25-36): Awareness-Kampagnen und Anreizprogramme. Budget: 5 Millionen USD (Finanzierung durch Stadthaushalt, internationale Klimafonds und private Sponsoren). Erwartete Ergebnisse: Reduzierung von Staus, verbesserte Gesundheit durch Bewegung und saubere Luft, Schaffung von 200 Arbeitsplätzen, Positionierung Nairobis als Vorreiter nachhaltiger Mobilität in Afrika. Erfolgsmessung durch regelmäßige Verkehrszählungen und Luftqualitätsmessungen.',
  4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

-- Q5: Comparative essay
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Vergleichen Sie das Bildungssystem in Ihrem Heimatland mit dem deutschen System. Analysieren Sie Stärken und Schwächen beider Systeme. (200-250 Wörter)', 
  'essay',
  'Beispiel: Das kenianische und deutsche Bildungssystem weisen signifikante Unterschiede auf. In Kenia folgt das System dem 8-4-4-Modell: acht Jahre Grundschule, vier Jahre Sekundarschule, vier Jahre Universität. Deutschland praktiziert ein gegliedertes System mit Gymnasium, Realschule und Hauptschule nach der Grundschule. Stärken des kenianischen Systems: Einheitlichkeit verhindert frühe Selektion, starker Fokus auf MINT-Fächer, wachsende Hochschullandschaft. Schwächen: Überfüllte Klassen (oft 50+ Schüler), Ressourcenmangel, starke Prüfungsorientierung, die kritisches Denken vernachlässigt. Das deutsche System punktet durch: gut ausgestattete Schulen, duales Ausbildungssystem, das Theorie und Praxis verbindet, starke Berufsbildung. Kritikpunkte: frühe Selektion mit 10 Jahren kann Chancenungleichheit verstärken, Bildungsföderalismus führt zu Disparitäten zwischen Bundesländern. Beide Systeme könnten voneinander lernen. Kenia würde von Deutschlands dualer Ausbildung und Ressourcenausstattung profitieren. Deutschland könnte Kenias inklusiveren Ansatz ohne frühe Selektion und die Betonung von MINT-Fächern übernehmen. Ideal wäre ein hybrides Modell: umfassende Grundbildung ohne frühe Trennung, kombiniert mit praxisnaher Berufsausbildung und ausreichenden Ressourcen für qualitativ hochwertigen Unterricht.',
  5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

-- Q6: Letter to the editor
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Schreiben Sie einen Leserbrief an eine Zeitung zu einem aktuellen gesellschaftlichen Thema. Nehmen Sie Stellung zu einem Artikel und präsentieren Sie Ihre Perspektive. (180-220 Wörter)', 
  'essay',
  'Beispiel: Betreff: Zu "Digitalisierung der Schulen - Fluch oder Segen?" (Ausgabe vom 15.03.2024). Sehr geehrte Redaktion, mit Interesse habe ich Ihren Artikel zur Schuldigitalisierung gelesen. Während ich die Chancen digitaler Bildung grundsätzlich anerkenne, vermisse ich eine kritische Auseinandersetzung mit den Risiken. Erstens: Die Annahme, digitale Medien verbesserten automatisch Lernerfolge, ist empirisch nicht belegt. Studien zeigen gemischte Ergebnisse. Entscheidend ist die pädagogische Einbettung, nicht die Technologie per se. Zweitens: Die Digitalisierung verschärft soziale Ungleichheit. Nicht alle Familien können sich Geräte und Internetanschlüsse leisten. Schulen in benachteiligten Vierteln haben oft schlechtere technische Ausstattung. Drittens: Datenschutzfragen werden vernachlässigt. Viele Lernplattformen sammeln umfangreiche Daten über Schüler. Wer kontrolliert diese Daten? Ich plädiere für einen ausgewogenen Ansatz: Digitale Werkzeuge dort einsetzen, wo sie pädagogischen Mehrwert bieten, aber traditionelle Methoden nicht komplett ersetzen. Zudem brauchen wir massive Investitionen in Infrastruktur und Lehrerfortbildung sowie strenge Datenschutzregeln. Technologie ist kein Selbstzweck, sondern Mittel zum Zweck besserer Bildung. Mit freundlichen Grüßen',
  6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

-- Q7: Problem-solution essay
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Analysieren Sie das Problem der Jugendarbeitslosigkeit und entwickeln Sie konkrete Lösungsvorschläge. Berücksichtigen Sie verschiedene Ursachen und Akteure. (200-250 Wörter)', 
  'essay',
  'Beispiel: Jugendarbeitslosigkeit ist ein komplexes Problem mit multiplen Ursachen. Strukturelle Faktoren umfassen den Wandel zur Wissensgesellschaft, der höhere Qualifikationen erfordert, sowie Automatisierung, die Einstiegspositionen eliminiert. Bildungssysteme hinken oft hinter Arbeitsmarktanforderungen her. Zudem fehlt es an Berufsorientierung und Praxiserfahrung. Lösungsansätze müssen mehrdimensional sein. Erstens: Bildungsreform. Curricula sollten zukunftsorientierte Kompetenzen wie digitale Literacy, kritisches Denken und Problemlösung betonen. Duale Ausbildungssysteme, die Theorie und Praxis verbinden, haben sich bewährt. Zweitens: Übergangsmanagement. Schulen sollten systematische Berufsorientierung anbieten. Praktika und Mentoring-Programme erleichtern den Einstieg. Drittens: Unternehmen müssen Verantwortung übernehmen. Ausbildungsplätze schaffen, Einstiegsprogramme für Berufsanfänger etablieren, On-the-Job-Training anbieten. Viertens: Staatliche Anreize. Subventionen für Unternehmen, die Jugendliche einstellen, Gründungsförderung für junge Entrepreneure, öffentliche Beschäftigungsprogramme als Überbrückung. Fünftens: Lebenslanges Lernen. Weiterbildungsmöglichkeiten müssen zugänglich und bezahlbar sein. Nur durch koordiniertes Handeln aller Akteure - Bildungsinstitutionen, Wirtschaft, Politik und Zivilgesellschaft - kann Jugendarbeitslosigkeit nachhaltig reduziert werden. Investitionen in junge Menschen sind Investitionen in die Zukunft der Gesellschaft.',
  7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

-- Q8: Review writing
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Verfassen Sie eine kritische Rezension eines Buches, Films oder einer Ausstellung. Analysieren Sie Stärken und Schwächen und geben Sie eine begründete Bewertung. (180-220 Wörter)', 
  'essay',
  'Beispiel: Rezension: "Factfulness" von Hans Rosling. Hans Roslings posthum veröffentlichtes Werk "Factfulness" ist ein bemerkenswerter Beitrag zur Aufklärung über globale Entwicklungen. Die Kernthese: Unsere Weltwahrnehmung ist systematisch verzerrt, wir überschätzen Probleme und unterschätzen Fortschritte. Rosling präsentiert überzeugende Daten, die zeigen, dass die Welt in vielen Bereichen - Armut, Gesundheit, Bildung - besser ist als angenommen. Seine "10 Instinkte", die unser Denken verzerren, sind erhellend: der Instinkt der Kluft (wir denken in "wir vs. die"), der Negativitätsinstinkt (schlechte Nachrichten dominieren), der Instinkt der geraden Linie (wir extrapolieren linear). Die Stärke des Buches liegt in der zugänglichen Darstellung komplexer Statistiken und der optimistischen, aber nicht naiven Perspektive. Schwächen: Manchmal wirkt Roslings Optimismus übertrieben. Klimawandel und Ungleichheit werden etwas zu kurz behandelt. Zudem richtet sich das Buch primär an westliche Leser. Dennoch: "Factfulness" ist ein wichtiges Korrektiv gegen Pessimismus und Panikmache. Es lehrt, Daten kritisch zu interpretieren und differenziert zu denken. Empfehlenswert für alle, die ihre Weltsicht hinterfragen möchten. Bewertung: 4/5 Sternen.',
  8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

-- Q9: Formal complaint
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Verfassen Sie eine formelle Beschwerde an eine Behörde über einen Missstand. Beschreiben Sie das Problem detailliert, belegen Sie es und fordern Sie konkrete Maßnahmen. (180-220 Wörter)', 
  'essay',
  'Beispiel: Betreff: Formelle Beschwerde bezüglich unzureichender Straßenbeleuchtung in der Musterstraße. Sehr geehrte Damen und Herren, hiermit möchte ich formell Beschwerde einreichen bezüglich der mangelhaften Straßenbeleuchtung in der Musterstraße (Abschnitt zwischen Hausnummer 10 und 50). Seit drei Monaten sind mindestens acht Straßenlaternen defekt, was zu erheblichen Sicherheitsproblemen führt. Konkrete Auswirkungen: 1) Erhöhtes Unfallrisiko für Fußgänger und Radfahrer, besonders bei Dunkelheit. 2) Zwei dokumentierte Stürze älterer Anwohner aufgrund schlechter Sicht. 3) Zunahme von Einbrüchen und Vandalismus in betroffenen Bereichen. 4) Subjektives Unsicherheitsgefühl, insbesondere bei Frauen und älteren Menschen. Trotz mehrfacher telefonischer Meldungen (Vorgangsnummern: 12345, 12678) erfolgte keine Reparatur. Dies ist inakzeptabel und stellt eine Verletzung der kommunalen Fürsorgepflicht dar. Ich fordere: 1) Umgehende Reparatur aller defekten Laternen innerhalb von 14 Tagen. 2) Schriftliche Bestätigung des Reparaturtermins. 3) Implementierung eines präventiven Wartungsplans. 4) Entschädigung für die Anwohner aufgrund der Vernachlässigung. Sollte keine zufriedenstellende Reaktion erfolgen, behalte ich mir rechtliche Schritte vor. Ich erwarte Ihre Stellungnahme bis zum 30. März 2024. Mit freundlichen Grüßen',
  9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

-- Q10: Reflective essay
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Reflektieren Sie über die Bedeutung interkultureller Kompetenz in einer globalisierten Welt. Beziehen Sie persönliche Erfahrungen ein und entwickeln Sie eine argumentative Position. (200-250 Wörter)', 
  'essay',
  'Beispiel: In einer zunehmend vernetzten Welt ist interkulturelle Kompetenz nicht mehr optional, sondern essentiell. Meine eigenen Erfahrungen als Kenianer, der in Deutschland studiert, haben mir dies eindrücklich vor Augen geführt. Interkulturelle Kompetenz umfasst mehrere Dimensionen. Kognitiv bedeutet sie, kulturelle Unterschiede zu verstehen - etwa dass Direktheit in Deutschland geschätzt wird, während in Kenia indirekte Kommunikation höflicher gilt. Affektiv erfordert sie Empathie und Offenheit gegenüber dem Fremden. Behavioral manifestiert sie sich in der Fähigkeit, das eigene Verhalten anzupassen. Die Relevanz ist vielfältig. Beruflich: Globale Teams sind Standard, interkulturelle Missverständnisse können Projekte gefährden. Gesellschaftlich: Migration und Diversität prägen moderne Gesellschaften; interkulturelle Kompetenz fördert Zusammenhalt. Persönlich: Sie erweitert Horizonte und bereichert das Leben. Allerdings ist interkulturelle Kompetenz kein Selbstläufer. Sie erfordert aktives Lernen, Reflexion eigener Vorurteile und die Bereitschaft, Unsicherheit auszuhalten. Bildungsinstitutionen sollten sie systematisch fördern - durch Austauschprogramme, interkulturelle Trainings und diverse Curricula. Unternehmen müssen Diversity Management ernst nehmen. Letztlich ist interkulturelle Kompetenz eine Schlüsselqualifikation des 21. Jahrhunderts. Sie befähigt uns, in Vielfalt nicht Bedrohung, sondern Bereicherung zu sehen und konstruktiv zusammenzuarbeiten. In einer Welt voller Herausforderungen, die globale Kooperation erfordern, ist sie unverzichtbar.',
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'writing';

-- B2 SPEAKING QUESTIONS (10)

-- Q1: Presenting complex arguments
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Präsentieren Sie eine differenzierte Analyse zum Thema: "Die Rolle von Technologie in der modernen Gesellschaft." Diskutieren Sie Chancen, Risiken und ethische Implikationen. Sprechen Sie 3-4 Minuten.', 
  'essay',
  'Bewertung: Komplexe Argumentation, nuancierte Perspektiven, kohärente Struktur, präzise Wortwahl, flüssiger Ausdruck, angemessenes akademisches Register, Verwendung von Konnektoren und Diskursmarkern.',
  1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

-- Q2: Defending a position
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Verteidigen Sie die Position: "Universitätsbildung sollte kostenlos sein." Antizipieren Sie Gegenargumente und entkräften Sie diese.', 
  'essay',
  'Beispiel: Ich vertrete die Position, dass Universitätsbildung kostenlos sein sollte. Erstens ist Bildung ein Menschenrecht und sollte nicht vom Einkommen abhängen. Zweitens profitiert die gesamte Gesellschaft von gut ausgebildeten Bürgern. Drittens verhindert kostenlose Bildung, dass talentierte Menschen aus finanziellen Gründen ausgeschlossen werden. Gegenargument: "Das ist zu teuer für den Staat." Meine Antwort: Langfristig zahlt es sich aus. Besser ausgebildete Menschen zahlen mehr Steuern und sind weniger auf Sozialleistungen angewiesen. Gegenargument: "Studenten schätzen kostenlose Bildung nicht." Meine Antwort: Studien zeigen, dass Motivation nicht vom Preis abhängt, sondern von Interesse und Karrierezielen. Gegenargument: "Nur Reiche profitieren von Universitäten." Meine Antwort: Genau deshalb brauchen wir kostenlose Bildung - um Chancengleichheit zu schaffen.',
  2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

-- Q3: Analyzing trends
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Analysieren Sie aktuelle Trends in der Arbeitswelt (Remote Work, Gig Economy, Automatisierung). Welche Auswirkungen haben diese auf Arbeitnehmer und Gesellschaft?', 
  'essay',
  'Beispiel: Die Arbeitswelt durchläuft fundamentale Transformationen. Remote Work hat sich von einer Ausnahme zur Norm entwickelt, beschleunigt durch die Pandemie. Dies bietet Flexibilität und Work-Life-Balance, birgt aber Risiken der Isolation und verschwimmender Grenzen zwischen Arbeit und Privatleben. Die Gig Economy wächst rasant. Plattformen wie Uber oder Upwork ermöglichen flexible Arbeit, aber oft ohne soziale Absicherung. Dies schafft eine prekäre Arbeitnehmerklasse. Automatisierung und KI ersetzen zunehmend Routineaufgaben. Während dies Effizienz steigert, droht Arbeitsplatzverlust in bestimmten Sektoren. Gesellschaftlich führen diese Trends zu Polarisierung: hochqualifizierte Wissensarbeiter profitieren, während gering qualifizierte Arbeiter unter Druck geraten. Wir brauchen neue Sozialmodelle, die Flexibilität ermöglichen, aber Sicherheit gewährleisten. Lebenslanges Lernen wird essentiell.',
  3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

-- Q4: Discussing abstract concepts
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Diskutieren Sie das Konzept "Nachhaltigkeit" in verschiedenen Kontexten (ökologisch, ökonomisch, sozial). Wie können diese Dimensionen in Einklang gebracht werden?', 
  'essay',
  'Beispiel: Nachhaltigkeit ist ein multidimensionales Konzept. Ökologisch bedeutet es, natürliche Ressourcen so zu nutzen, dass sie für zukünftige Generationen erhalten bleiben. Dies umfasst Klimaschutz, Biodiversität und Kreislaufwirtschaft. Ökonomisch bedeutet Nachhaltigkeit langfristige Wirtschaftsfähigkeit statt kurzfristiger Gewinnmaximierung. Unternehmen müssen soziale und ökologische Kosten internalisieren. Sozial bedeutet es Gerechtigkeit - innerhalb und zwischen Generationen. Niemand sollte auf Kosten anderer leben. Die Herausforderung ist, diese Dimensionen zu integrieren. Oft gibt es Zielkonflikte: Umweltschutz kann kurzfristig Arbeitsplätze kosten. Die Lösung liegt in systemischem Denken. Wir brauchen eine Transformation, die ökologische Grenzen respektiert, wirtschaftliche Prosperität ermöglicht und soziale Inklusion fördert. Dies erfordert Innovation, politischen Willen und gesellschaftlichen Konsens.',
  4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

-- Q5: Comparing cultural perspectives
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Vergleichen Sie unterschiedliche kulturelle Perspektiven auf Familie und Gemeinschaft. Wie beeinflussen diese Werte gesellschaftliche Strukturen?', 
  'essay',
  'Beispiel: Kulturelle Konzepte von Familie variieren erheblich. In kollektivistischen Gesellschaften wie Kenia ist die erweiterte Familie zentral. Mehrere Generationen leben oft zusammen, Entscheidungen werden gemeinsam getroffen, und es besteht eine starke Verpflichtung zur gegenseitigen Unterstützung. In individualistischen Gesellschaften wie Deutschland dominiert die Kernfamilie. Selbstständigkeit wird früh gefördert, und individuelle Autonomie wird höher bewertet als Gruppenkohäsion. Diese Unterschiede prägen Gesellschaften fundamental. Kollektivistische Kulturen haben oft stärkere soziale Netze, aber weniger individuelle Freiheit. Individualistische Kulturen fördern Innovation und Selbstverwirklichung, können aber zu Isolation führen. Beide Modelle haben Vor- und Nachteile. In einer globalisierten Welt ist es wichtig, diese Unterschiede zu verstehen und zu respektieren. Vielleicht liegt die Zukunft in hybriden Modellen, die Gemeinschaft und Individualität balancieren.',
  5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

-- Q6: Evaluating policies
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Bewerten Sie verschiedene Ansätze zur Bekämpfung von Armut (Sozialhilfe, Bildung, Wirtschaftswachstum). Welcher Ansatz ist am effektivsten?', 
  'essay',
  'Beispiel: Armutsbekämpfung erfordert multidimensionale Strategien. Sozialhilfe bietet kurzfristige Linderung. Sie verhindert extreme Not und stabilisiert Betroffene. Kritiker argumentieren, sie schaffe Abhängigkeit. Ich denke, sie ist notwendig, aber nicht ausreichend. Bildung ist langfristig am wirksamsten. Sie befähigt Menschen, sich selbst aus Armut zu befreien. Investitionen in Bildung zahlen sich generationenübergreifend aus. Allerdings dauert es Jahre, bis Effekte sichtbar werden. Wirtschaftswachstum schafft Arbeitsplätze und Wohlstand. Aber Wachstum allein garantiert nicht, dass Arme profitieren. Ohne Umverteilung kann Ungleichheit sogar zunehmen. Meiner Ansicht nach brauchen wir alle drei Ansätze kombiniert. Sozialhilfe als Sicherheitsnetz, Bildung als Befähigung, inklusives Wirtschaftswachstum als Motor. Zudem müssen strukturelle Ursachen wie Diskriminierung und ungleiche Machtverhältnisse adressiert werden. Armutsbekämpfung ist komplex und erfordert politischen Willen und langfristiges Engagement.',
  6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

-- Q7: Discussing ethical dilemmas
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Diskutieren Sie ethische Dilemmata der Gentechnologie. Wo sollten Grenzen gezogen werden und wer sollte diese Entscheidungen treffen?', 
  'essay',
  'Beispiel: Gentechnologie wirft fundamentale ethische Fragen auf. Einerseits bietet sie enorme Potenziale: Heilung genetischer Krankheiten, Verbesserung der Nahrungsmittelproduktion, Bekämpfung des Klimawandels. Andererseits gibt es Risiken: unvorhersehbare Langzeitfolgen, Missbrauchspotenzial, Fragen der Gerechtigkeit. Ein zentrales Dilemma ist "Designer-Babys". Sollten Eltern Gene ihrer Kinder optimieren dürfen? Befürworter argumentieren mit Elternrechten und Krankheitsprävention. Kritiker warnen vor Eugenik und wachsender Ungleichheit. Ich denke, therapeutische Eingriffe zur Verhinderung schwerer Krankheiten sind ethisch vertretbar. Enhancement zur Verbesserung normaler Eigenschaften ist problematisch. Wer sollte entscheiden? Nicht nur Wissenschaftler oder Politiker, sondern die Gesellschaft als Ganzes durch demokratische Prozesse. Wir brauchen internationale Ethikkommissionen, transparente Regulierung und öffentlichen Diskurs. Die Technologie entwickelt sich schneller als unsere ethischen Frameworks. Wir müssen proaktiv Grenzen setzen, bevor Fakten geschaffen werden.',
  7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

-- Q8: Analyzing historical developments
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Analysieren Sie, wie historische Ereignisse die heutige Weltordnung geprägt haben. Welche Lehren können wir daraus ziehen?', 
  'essay',
  'Beispiel: Die heutige Weltordnung ist Produkt historischer Prozesse. Der Kolonialismus prägt bis heute globale Ungleichheiten. Ehemalige Kolonien kämpfen mit Folgen wie künstlichen Grenzen, extraktiven Wirtschaftsstrukturen und kultureller Entfremdung. Die Weltkriege führten zur Gründung internationaler Institutionen wie der UN, die Frieden sichern sollten. Der Kalte Krieg teilte die Welt in Blöcke und hinterließ Konflikte, die bis heute schwelen. Die Dekolonisierung brachte Unabhängigkeit, aber oft instabile Staaten. Die Globalisierung seit den 1990ern vernetzte die Welt wirtschaftlich, schuf aber auch neue Abhängigkeiten. Lehren: Erstens, Geschichte hat lange Nachwirkungen. Wir können Gegenwart nicht verstehen ohne Vergangenheit. Zweitens, Machtstrukturen perpetuieren sich. Ohne aktive Umgestaltung bleiben Ungleichheiten bestehen. Drittens, internationale Kooperation ist essentiell. Globale Probleme erfordern globale Lösungen. Viertens, wir müssen aus Fehlern lernen. Nationalismus und Isolationismus führten zu Katastrophen. Heute brauchen wir Multilateralismus und Dialog.',
  8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

-- Q9: Presenting research findings
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Präsentieren Sie die Ergebnisse einer hypothetischen Studie zu einem Thema Ihrer Wahl. Erklären Sie Methodik, Ergebnisse und Implikationen.', 
  'essay',
  'Beispiel: Ich präsentiere Ergebnisse unserer Studie "Auswirkungen von Remote Work auf Produktivität und Wohlbefinden". Methodik: Wir befragten 500 Arbeitnehmer über 6 Monate, kombinierten Umfragen mit Produktivitätsdaten. Ergebnisse: Produktivität stieg im Durchschnitt um 13%. Überraschend war die Varianz: 40% berichteten höhere, 30% gleichbleibende, 30% niedrigere Produktivität. Faktoren: Wohnverhältnisse, Selbstdisziplin, Art der Tätigkeit. Wohlbefinden: 60% fühlten sich besser durch Flexibilität, 40% litten unter Isolation. Work-Life-Balance verbesserte sich bei 55%, verschlechterte sich bei 25% (verschwimmende Grenzen). Implikationen: Remote Work ist nicht universell besser oder schlechter. Unternehmen sollten hybride Modelle anbieten, die individuelle Präferenzen berücksichtigen. Wichtig sind: klare Kommunikationsstrukturen, virtuelle Teambuilding-Aktivitäten, Recht auf Abschalten. Limitationen: Studie fokussierte auf Büroarbeit, Langzeiteffekte unklar. Weitere Forschung zu verschiedenen Branchen und kulturellen Kontexten notwendig.',
  9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';

-- Q10: Negotiating and compromising
INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  'Simulieren Sie eine Verhandlungssituation: Sie und ein Kollege haben unterschiedliche Vorstellungen über ein Projekt. Finden Sie einen Kompromiss.', 
  'essay',
  'Beispiel: Ich verstehe Ihre Position, dass wir das Projekt schnell abschließen sollten. Zeitdruck ist real. Allerdings teile ich Ihre Einschätzung nicht vollständig. Qualität sollte nicht unter Geschwindigkeit leiden. Lassen Sie uns einen Mittelweg finden. Mein Vorschlag: Wir priorisieren Kernfunktionen und liefern diese termingerecht. Zusatzfeatures verschieben wir in eine zweite Phase. So erfüllen wir die Deadline und gewährleisten Qualität. Was halten Sie davon? Ich sehe Ihre Bedenken bezüglich Ressourcen. Wie wäre es, wenn wir temporär externe Unterstützung holen? Die Kosten sind überschaubar und würden sich durch pünktliche Lieferung amortisieren. Alternativ könnten wir das Team umstrukturieren: Sie fokussieren auf Entwicklung, ich übernehme Projektmanagement und Kommunikation. Das würde Effizienz steigern. Ich bin offen für Ihre Ideen. Wichtig ist, dass wir eine Lösung finden, mit der beide leben können. Unser gemeinsames Ziel ist Projekterfolg. Lassen Sie uns konstruktiv zusammenarbeiten statt gegeneinander. Was schlagen Sie vor?',
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'speaking';
