-- Production B2 Level Questions (40 questions) - CEFR B2: Complex texts, detailed arguments
-- Delete existing B2 questions
DELETE FROM questions WHERE test_module_id IN (
  SELECT tm.id FROM test_modules tm
  JOIN levels l ON tm.level_id = l.id
  WHERE l.code = 'B2'
);

-- B2 LISTENING QUESTIONS (10)

-- Q1: Academic lecture
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Vorlesung: "Die Globalisierung hat ambivalente Auswirkungen. Einerseits ermöglicht sie wirtschaftliches Wachstum und kulturellen Austausch. Andererseits führt sie zu Ungleichheit und Umweltproblemen. Eine differenzierte Betrachtung ist notwendig." Was ist die Kernaussage?', 
  'multiple_choice',
  jsonb_build_array(
    'Globalisierung hat sowohl positive als auch negative Aspekte',
    'Globalisierung ist nur positiv',
    'Globalisierung ist nur negativ',
    'Globalisierung ist irrelevant'
  ),
  'Globalisierung hat sowohl positive als auch negative Aspekte',
  'Die Vorlesung betont die "ambivalenten Auswirkungen" und nennt sowohl Vorteile (Wachstum, Austausch) als auch Nachteile (Ungleichheit, Umwelt).',
  1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

-- Q2: Political debate
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Debatte: "Die Einführung eines bedingungslosen Grundeinkommens würde die Gesellschaft grundlegend verändern. Befürworter argumentieren mit mehr sozialer Gerechtigkeit, Kritiker befürchten Finanzierungsprobleme und sinkende Arbeitsmotivation." Welche Positionen werden genannt?', 
  'multiple_choice',
  jsonb_build_array(
    'Pro: soziale Gerechtigkeit; Contra: Finanzierung und Motivation',
    'Alle sind dafür',
    'Alle sind dagegen',
    'Nur finanzielle Aspekte'
  ),
  'Pro: soziale Gerechtigkeit; Contra: Finanzierung und Motivation',
  'Die Debatte präsentiert beide Seiten: Befürworter sehen soziale Gerechtigkeit, Kritiker sehen Finanzierungs- und Motivationsprobleme.',
  2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

-- Q3: Scientific presentation
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Vortrag: "Künstliche Intelligenz revolutioniert die Medizin. Algorithmen können Krankheiten präziser diagnostizieren als Menschen. Dennoch bleiben ethische Fragen: Wer trägt die Verantwortung bei Fehldiagnosen? Wie schützen wir Patientendaten?" Was wird problematisiert?', 
  'multiple_choice',
  jsonb_build_array(
    'Ethische und rechtliche Aspekte der KI-Medizin',
    'Die Ineffektivität von KI',
    'Die Kosten der Technologie',
    'Die Ausbildung von Ärzten'
  ),
  'Ethische und rechtliche Aspekte der KI-Medizin',
  'Trotz der Vorteile werden ethische Fragen (Verantwortung, Datenschutz) als problematisch hervorgehoben.',
  3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

-- Q4: Business negotiation
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Verhandlung: "Wir sind bereit, die Lieferfristen zu verkürzen, sofern Sie die Bestellmenge erhöhen. Alternativ könnten wir über einen Rabatt bei längerfristiger Vertragsbindung sprechen." Was wird angeboten?', 
  'multiple_choice',
  jsonb_build_array(
    'Zwei Optionen: schnellere Lieferung oder Rabatt',
    'Nur schnellere Lieferung',
    'Nur Rabatt',
    'Keine Zugeständnisse'
  ),
  'Zwei Optionen: schnellere Lieferung oder Rabatt',
  'Es werden zwei Alternativen präsentiert: kürzere Lieferfristen bei höherer Menge oder Rabatt bei längerer Bindung.',
  4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

-- Q5: Cultural analysis
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Analyse: "Die zunehmende Digitalisierung verändert unsere Kommunikationskultur fundamental. Während früher persönliche Treffen im Vordergrund standen, dominieren heute digitale Kanäle. Dies hat Auswirkungen auf die Qualität zwischenmenschlicher Beziehungen." Was ist die These?', 
  'multiple_choice',
  jsonb_build_array(
    'Digitalisierung verändert Kommunikation und Beziehungen',
    'Digitalisierung ist nur positiv',
    'Persönliche Treffen sind unwichtig',
    'Nichts hat sich geändert'
  ),
  'Digitalisierung verändert Kommunikation und Beziehungen',
  'Die These ist, dass Digitalisierung die Kommunikationskultur "fundamental" verändert und Beziehungen beeinflusst.',
  5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

-- Q6: Environmental policy discussion
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Diskussion: "Der Klimawandel erfordert drastische Maßnahmen. Einige Experten fordern ein Verbot von Verbrennungsmotoren ab 2030, andere halten dies für unrealistisch und plädieren für einen schrittweisen Übergang." Welche Strategien werden diskutiert?', 
  'multiple_choice',
  jsonb_build_array(
    'Radikaler Wandel versus gradueller Übergang',
    'Nur Verbote',
    'Keine Maßnahmen',
    'Nur technologische Lösungen'
  ),
  'Radikaler Wandel versus gradueller Übergang',
  'Es werden zwei Ansätze kontrastiert: drastische Verbote versus schrittweiser Übergang.',
  6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

-- Q7: Philosophical discourse
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Vortrag: "Die Frage nach dem Sinn des Lebens beschäftigt die Menschheit seit Jahrtausenden. Während religiöse Ansätze transzendente Antworten bieten, suchen säkulare Philosophien den Sinn in menschlichen Beziehungen und persönlicher Entwicklung." Was wird verglichen?', 
  'multiple_choice',
  jsonb_build_array(
    'Religiöse und säkulare Sinnkonzepte',
    'Nur religiöse Ansichten',
    'Nur säkulare Ansichten',
    'Wissenschaftliche Theorien'
  ),
  'Religiöse und säkulare Sinnkonzepte',
  'Der Vortrag kontrastiert religiöse (transzendente) und säkulare (menschliche) Ansätze zur Sinnfrage.',
  7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

-- Q8: Economic analysis
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Analyse: "Die Inflation hat komplexe Ursachen. Neben der expansiven Geldpolitik spielen Lieferkettenprobleme und geopolitische Spannungen eine Rolle. Eine monokausale Erklärung greift zu kurz." Was wird kritisiert?', 
  'multiple_choice',
  jsonb_build_array(
    'Vereinfachte Erklärungsansätze',
    'Die Geldpolitik',
    'Geopolitische Spannungen',
    'Wirtschaftswachstum'
  ),
  'Vereinfachte Erklärungsansätze',
  'Kritisiert wird die "monokausale Erklärung" - es gibt multiple Ursachen, nicht nur eine.',
  8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

-- Q9: Literary criticism
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Literaturkritik: "Der Roman zeichnet sich durch eine vielschichtige Erzählstruktur aus. Die Autorin verwebt geschickt verschiedene Zeitebenen und Perspektiven. Allerdings wirkt das Ende etwas konstruiert." Was wird gelobt?', 
  'multiple_choice',
  jsonb_build_array(
    'Die komplexe Erzählstruktur',
    'Das Ende',
    'Die Einfachheit',
    'Die Kürze'
  ),
  'Die komplexe Erzählstruktur',
  'Gelobt wird die "vielschichtige Erzählstruktur" mit verschiedenen Zeitebenen und Perspektiven.',
  9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

-- Q10: Technology ethics
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Diskussion: "Autonome Waffensysteme werfen fundamentale ethische Fragen auf. Kann eine Maschine über Leben und Tod entscheiden? Wer trägt die Verantwortung? Die internationale Gemeinschaft muss dringend Regelungen schaffen." Was wird gefordert?', 
  'multiple_choice',
  jsonb_build_array(
    'Internationale Regulierung autonomer Waffen',
    'Verbot aller Technologie',
    'Mehr Waffenproduktion',
    'Keine Regelungen'
  ),
  'Internationale Regulierung autonomer Waffen',
  'Gefordert wird, dass "die internationale Gemeinschaft dringend Regelungen schaffen" muss.',
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'listening';

-- B2 READING QUESTIONS (10)

-- Q1: Academic article
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Artikel: "Die Urbanisierung stellt Städte vor enorme Herausforderungen. Während die Bevölkerungsdichte zunimmt, müssen Infrastruktur, Wohnraum und öffentliche Dienstleistungen ausgebaut werden. Nachhaltige Stadtentwicklung erfordert innovative Konzepte, die ökologische, soziale und ökonomische Aspekte integrieren." Was wird als notwendig erachtet?', 
  'multiple_choice',
  jsonb_build_array(
    'Ganzheitliche, nachhaltige Stadtplanung',
    'Nur mehr Wohnungen',
    'Bevölkerungsreduktion',
    'Keine Veränderungen'
  ),
  'Ganzheitliche, nachhaltige Stadtplanung',
  'Der Artikel fordert "innovative Konzepte", die ökologische, soziale und ökonomische Aspekte integrieren - also ganzheitliche Planung.',
  1
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- Q2: Legal text
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Gesetzestext: "Gemäß §15 haben Arbeitnehmer Anspruch auf mindestens 20 Tage bezahlten Urlaub pro Jahr. Dieser Anspruch entsteht nach sechsmonatiger Betriebszugehörigkeit. Teilzeitbeschäftigte haben einen anteiligen Anspruch entsprechend ihrer Arbeitszeit." Wann entsteht der volle Urlaubsanspruch?', 
  'multiple_choice',
  jsonb_build_array(
    'Nach 6 Monaten Betriebszugehörigkeit',
    'Sofort',
    'Nach 1 Jahr',
    'Nach 2 Jahren'
  ),
  'Nach 6 Monaten Betriebszugehörigkeit',
  'Im Text steht: "Dieser Anspruch entsteht nach sechsmonatiger Betriebszugehörigkeit".',
  2
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- Q3: Scientific report
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Forschungsbericht: "Die Studie untersuchte den Zusammenhang zwischen Schlafqualität und kognitiver Leistung. Die Ergebnisse zeigen eine signifikante Korrelation: Probanden mit regelmäßigem, ausreichendem Schlaf schnitten in Gedächtnistests deutlich besser ab. Allerdings lässt die Studie keine Rückschlüsse auf Kausalität zu." Was ist eine Limitation der Studie?', 
  'multiple_choice',
  jsonb_build_array(
    'Keine Aussage über Ursache-Wirkungs-Beziehung',
    'Zu wenige Probanden',
    'Falsche Methodik',
    'Keine Korrelation gefunden'
  ),
  'Keine Aussage über Ursache-Wirkungs-Beziehung',
  'Die Studie zeigt Korrelation, aber "lässt keine Rückschlüsse auf Kausalität zu" - das ist die Limitation.',
  3
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- Q4: Opinion piece
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Kommentar: "Die Debatte um Gendergerechtigkeit in der Sprache polarisiert. Befürworter sehen darin einen wichtigen Schritt zur Gleichberechtigung, Kritiker befürchten eine Verkomplizierung der Sprache. Beide Positionen haben valide Argumente. Ein konstruktiver Dialog statt ideologischer Grabenkämpfe wäre wünschenswert." Was fordert der Autor?', 
  'multiple_choice',
  jsonb_build_array(
    'Sachliche Diskussion statt Polarisierung',
    'Abschaffung der Debatte',
    'Nur eine Position',
    'Keine Veränderungen'
  ),
  'Sachliche Diskussion statt Polarisierung',
  'Der Autor fordert "konstruktiven Dialog statt ideologischer Grabenkämpfe" - also sachliche Diskussion.',
  4
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- Q5: Historical analysis
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Historischer Text: "Die Industrialisierung des 19. Jahrhunderts transformierte die Gesellschaft fundamental. Während sie einerseits wirtschaftlichen Fortschritt und technologische Innovation brachte, führte sie andererseits zu sozialen Verwerfungen und Umweltproblemen. Die Ambivalenz dieser Entwicklung prägt Debatten bis heute." Was charakterisiert die Industrialisierung?', 
  'multiple_choice',
  jsonb_build_array(
    'Gleichzeitig Fortschritt und Probleme',
    'Nur positive Entwicklungen',
    'Nur negative Entwicklungen',
    'Keine bedeutenden Veränderungen'
  ),
  'Gleichzeitig Fortschritt und Probleme',
  'Der Text betont die "Ambivalenz": sowohl Fortschritt als auch soziale und ökologische Probleme.',
  5
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- Q6: Business strategy
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Strategiepapier: "Um im globalen Wettbewerb zu bestehen, muss das Unternehmen seine Innovationskraft stärken. Dies erfordert Investitionen in Forschung und Entwicklung, die Förderung einer Innovationskultur und strategische Partnerschaften. Kurzfristige Gewinnmaximierung darf nicht zu Lasten langfristiger Wettbewerbsfähigkeit gehen." Was wird priorisiert?', 
  'multiple_choice',
  jsonb_build_array(
    'Langfristige Innovation über kurzfristige Gewinne',
    'Nur kurzfristige Gewinne',
    'Keine Investitionen',
    'Nur Kostensenkung'
  ),
  'Langfristige Innovation über kurzfristige Gewinne',
  'Das Papier warnt, dass "kurzfristige Gewinnmaximierung nicht zu Lasten langfristiger Wettbewerbsfähigkeit" gehen darf.',
  6
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- Q7: Philosophical essay
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Essay: "Freiheit und Sicherheit stehen in einem Spannungsverhältnis. Absolute Freiheit ohne Regeln führt zu Chaos, absolute Sicherheit ohne Freiheiten zu Unterdrückung. Eine demokratische Gesellschaft muss kontinuierlich um die richtige Balance ringen." Was ist die Kernthese?', 
  'multiple_choice',
  jsonb_build_array(
    'Balance zwischen Freiheit und Sicherheit ist notwendig',
    'Nur Freiheit ist wichtig',
    'Nur Sicherheit ist wichtig',
    'Beides ist unwichtig'
  ),
  'Balance zwischen Freiheit und Sicherheit ist notwendig',
  'Die These ist, dass eine Gesellschaft "um die richtige Balance ringen" muss - weder Extrem ist gut.',
  7
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- Q8: Medical information
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Medizinischer Artikel: "Präventivmedizin gewinnt zunehmend an Bedeutung. Statt Krankheiten zu behandeln, zielt sie darauf ab, deren Entstehung zu verhindern. Dies umfasst Vorsorgeuntersuchungen, gesunde Lebensführung und Risikofaktorenmanagement. Langfristig könnte dies Gesundheitssysteme entlasten und Lebensqualität erhöhen." Was ist der Ansatz der Präventivmedizin?', 
  'multiple_choice',
  jsonb_build_array(
    'Krankheiten verhindern statt behandeln',
    'Nur Behandlung',
    'Keine Vorsorge',
    'Nur Medikamente'
  ),
  'Krankheiten verhindern statt behandeln',
  'Präventivmedizin "zielt darauf ab, deren Entstehung zu verhindern" - Prävention statt Behandlung.',
  8
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- Q9: Cultural critique
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Kulturkritik: "Die Konsumgesellschaft verspricht Glück durch materiellen Besitz. Doch empirische Studien zeigen: Ab einem gewissen Wohlstandsniveau korreliert mehr Konsum nicht mit höherer Lebenszufriedenheit. Immaterielle Werte wie Beziehungen und Sinnerfüllung sind entscheidender." Was wird infrage gestellt?', 
  'multiple_choice',
  jsonb_build_array(
    'Der Zusammenhang zwischen Konsum und Glück',
    'Die Bedeutung von Beziehungen',
    'Empirische Forschung',
    'Alle Werte'
  ),
  'Der Zusammenhang zwischen Konsum und Glück',
  'Die Kritik richtet sich gegen das Versprechen, dass "materieller Besitz" zu Glück führt - Studien widerlegen dies.',
  9
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';

-- Q10: Environmental policy
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  'Politikpapier: "Die Energiewende erfordert einen Paradigmenwechsel. Fossile Energieträger müssen durch erneuerbare ersetzt werden. Dies bedingt massive Investitionen in Infrastruktur, technologische Innovation und gesellschaftliche Akzeptanz. Der Transformationsprozess ist komplex, aber alternativlos." Was wird als unausweichlich dargestellt?', 
  'multiple_choice',
  jsonb_build_array(
    'Der Übergang zu erneuerbaren Energien',
    'Die Beibehaltung fossiler Energien',
    'Keine Veränderungen',
    'Nur technologische Lösungen'
  ),
  'Der Übergang zu erneuerbaren Energien',
  'Der Transformationsprozess wird als "alternativlos" bezeichnet - es gibt keine Alternative zum Übergang.',
  10
FROM test_modules tm JOIN levels l ON tm.level_id = l.id JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'B2' AND s.code = 'reading';
