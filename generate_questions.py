#!/usr/bin/env python3
"""
Quick script to generate SQL for remaining test questions.
Run this and copy the output to a new migration file.
"""

# Question templates for each level and skill
templates = {
    'B1': {
        'listening': [
            "Was ist das Hauptthema des Gesprächs?",
            "Welche Meinung vertritt der Sprecher?",
            "Warum kann die Person nicht kommen?",
            "Was wird empfohlen?",
            "Welches Problem wird beschrieben?",
            "Was plant die Organisation?",
            "Welcher Vorschlag wird gemacht?",
            "Was ist der Grund für die Änderung?",
            "Welche Erfahrung wird beschrieben?",
            "Was wird als nächstes passieren?"
        ],
        'reading': [
            "Was ist die Hauptaussage des Textes?",
            "Welches Wort passt? '_____ des schlechten Wetters gingen wir spazieren.'",
            "Was bedeutet 'sich beschweren'?",
            "Welche Konjunktion ist richtig? 'Ich lerne Deutsch, _____ ich in Deutschland arbeiten möchte.'",
            "Was ist richtig? 'Der Film, _____ ich gestern gesehen habe, war toll.'",
            "Welches Verb passt? 'Die Regierung hat beschlossen, die Steuern zu _____.'",
            "Was bedeutet 'nachhaltig'?",
            "Welche Präposition ist richtig? 'Ich interessiere mich _____ Politik.'",
            "Was ist richtig? 'Wenn ich Zeit _____, würde ich mehr reisen.'",
            "Welches Wort passt? 'Die Firma hat ihre Produktion _____.'"
        ],
        'writing': [
            "Schreiben Sie einen formellen Brief an Ihren Vermieter über ein Problem (8-10 Sätze).",
            "Schreiben Sie Ihre Meinung zum Thema 'Sollten Schuluniformen Pflicht sein?' (10-12 Sätze).",
            "Beschreiben Sie ein wichtiges Ereignis in Ihrem Leben (8-10 Sätze).",
            "Schreiben Sie eine Bewerbung für einen Job (10-12 Sätze).",
            "Verfassen Sie einen Blogbeitrag über Ihr Hobby (8-10 Sätze).",
            "Schreiben Sie einen Beschwerdebrief an ein Geschäft (8-10 Sätze).",
            "Beschreiben Sie Vor- und Nachteile des Lebens in der Stadt (10-12 Sätze).",
            "Schreiben Sie über Ihre Zukunftspläne (8-10 Sätze).",
            "Verfassen Sie eine Einladung zu einer Veranstaltung (6-8 Sätze).",
            "Schreiben Sie über ein soziales Problem in Ihrem Land (10-12 Sätze)."
        ],
        'speaking': [
            "Stellen Sie sich und Ihren beruflichen Werdegang vor.",
            "Beschreiben Sie Ihre Heimatstadt und was sie besonders macht.",
            "Sprechen Sie über Ihre Meinung zu sozialen Medien.",
            "Erklären Sie, wie man ein traditionelles Gericht aus Ihrem Land kocht.",
            "Diskutieren Sie die Vor- und Nachteile von Fernarbeit.",
            "Beschreiben Sie eine Person, die Sie bewundern.",
            "Sprechen Sie über Umweltprobleme in Ihrer Region.",
            "Erklären Sie, warum Sie Deutsch lernen.",
            "Beschreiben Sie Ihren idealen Urlaub.",
            "Diskutieren Sie die Rolle der Technologie in der Bildung."
        ]
    },
    'B2': {
        'listening': [
            "Welche Position vertritt der Experte zur Klimapolitik?",
            "Was wird als Hauptursache des Problems genannt?",
            "Welche Entwicklung wird für die Zukunft prognostiziert?",
            "Welches Argument wird zur Unterstützung der These angeführt?",
            "Was ist die Schlussfolgerung des Vortrags?",
            "Welche Gegenargumente werden erwähnt?",
            "Was wird als Lösung vorgeschlagen?",
            "Welche Rolle spielt die Regierung laut Sprecher?",
            "Was sind die langfristigen Konsequenzen?",
            "Welche Perspektive wird kritisiert?"
        ],
        'reading': [
            "Was ist die zentrale These des Artikels?",
            "Welches Wort passt? 'Die Maßnahmen haben sich als _____ erwiesen.'",
            "Was bedeutet 'nachvollziehbar' in diesem Kontext?",
            "Welche Konjunktion ist richtig? '_____ die Kosten hoch sind, lohnt sich die Investition.'",
            "Was ist richtig? 'Das Projekt, _____ Erfolg überraschend war, wird fortgesetzt.'",
            "Welches Verb passt? 'Die Studie _____ wichtige Erkenntnisse.'",
            "Was bedeutet 'ambivalent'?",
            "Welche Präposition ist richtig? 'Die Entscheidung basiert _____ wissenschaftlichen Daten.'",
            "Was ist richtig? 'Hätte ich das gewusst, _____ ich anders gehandelt.'",
            "Welches Wort passt? 'Die Entwicklung _____ sich beschleunigt.'"
        ],
        'writing': [
            "Verfassen Sie einen argumentativen Essay zum Thema 'Künstliche Intelligenz in der Arbeitswelt' (200-250 Wörter).",
            "Schreiben Sie einen formellen Brief an eine Behörde bezüglich eines Anliegens (180-220 Wörter).",
            "Analysieren Sie die Vor- und Nachteile der Globalisierung (200-250 Wörter).",
            "Schreiben Sie einen Artikel über nachhaltige Entwicklung (180-220 Wörter).",
            "Verfassen Sie eine Stellungnahme zur Digitalisierung im Bildungswesen (200-250 Wörter).",
            "Schreiben Sie über kulturelle Unterschiede und deren Bedeutung (180-220 Wörter).",
            "Analysieren Sie ein aktuelles gesellschaftliches Problem (200-250 Wörter).",
            "Verfassen Sie einen Kommentar zu Umweltschutzmaßnahmen (180-220 Wörter).",
            "Schreiben Sie über die Zukunft der Mobilität (200-250 Wörter).",
            "Diskutieren Sie ethische Fragen der modernen Medizin (200-250 Wörter)."
        ],
        'speaking': [
            "Präsentieren Sie Ihre Ansichten zur Rolle der Medien in der Demokratie.",
            "Diskutieren Sie die Auswirkungen der Globalisierung auf lokale Kulturen.",
            "Erklären Sie komplexe wirtschaftliche Zusammenhänge in Ihrem Land.",
            "Analysieren Sie die Herausforderungen des Klimawandels.",
            "Sprechen Sie über die Bedeutung von Bildung für gesellschaftlichen Fortschritt.",
            "Diskutieren Sie ethische Dilemmata in der modernen Technologie.",
            "Präsentieren Sie Lösungsansätze für soziale Ungleichheit.",
            "Erörtern Sie die Zukunft der Arbeit im digitalen Zeitalter.",
            "Sprechen Sie über kulturelle Identität in einer globalisierten Welt.",
            "Diskutieren Sie die Balance zwischen Sicherheit und Freiheit."
        ]
    }
}

def generate_sql(level, skill, questions):
    """Generate SQL INSERT statements for questions."""
    sql_parts = []
    
    for i, question_text in enumerate(questions, 1):
        if skill in ['listening', 'reading']:
            # Multiple choice
            sql = f"""INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, "order")
SELECT tm.id, 
  '{question_text}', 
  'multiple_choice',
  jsonb_build_array('Option A', 'Option B', 'Option C', 'Option D'),
  'Option A',
  'Explanation for {level} {skill} question {i}',
  {i}
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = '{level}' AND s.code = '{skill}';"""
        elif skill == 'writing':
            # Essay type
            sql = f"""INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  '{question_text}', 
  'essay',
  'Sample answer for {level} {skill} question {i}',
  {i}
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = '{level}' AND s.code = '{skill}';"""
        else:  # speaking
            # Speaking type (can also use essay for now)
            sql = f"""INSERT INTO questions (test_module_id, question_text, question_type, correct_answer, "order")
SELECT tm.id, 
  '{question_text}', 
  'essay',
  'Sample answer for {level} {skill} question {i}',
  {i}
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = '{level}' AND s.code = '{skill}';"""
        
        sql_parts.append(sql)
    
    return '\n\n'.join(sql_parts)

def main():
    print("-- Generated SQL for B1 and B2 Questions")
    print("-- Copy this output to a new migration file\n")
    
    for level in ['B1', 'B2']:
        print(f"\n-- ============================================")
        print(f"-- {level} LEVEL QUESTIONS")
        print(f"-- ============================================\n")
        
        for skill in ['listening', 'reading', 'writing', 'speaking']:
            print(f"\n-- {level} {skill.capitalize()} Questions (10 questions)")
            questions = templates[level][skill]
            sql = generate_sql(level, skill, questions)
            print(sql)

if __name__ == '__main__':
    main()
