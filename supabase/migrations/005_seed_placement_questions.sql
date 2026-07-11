-- Get level IDs
DO $$
DECLARE
    a1_id UUID;
    a2_id UUID;
    b1_id UUID;
    b2_id UUID;
BEGIN
    SELECT id INTO a1_id FROM levels WHERE code = 'A1';
    SELECT id INTO a2_id FROM levels WHERE code = 'A2';
    SELECT id INTO b1_id FROM levels WHERE code = 'B1';
    SELECT id INTO b2_id FROM levels WHERE code = 'B2';

    -- A1 Level Questions (Basic)
    INSERT INTO placement_test_questions (level_id, question_text, options, correct_answer, points, "order") VALUES
    (a1_id, 'Guten ___! Wie geht es Ihnen?', '["Tag", "Nacht", "Abend", "Morgen"]', 'Tag', 1, 1),
    (a1_id, 'Ich ___ Maria.', '["bin", "bist", "ist", "sind"]', 'bin', 1, 2),
    (a1_id, 'Das ist ___ Buch.', '["ein", "eine", "der", "die"]', 'ein', 1, 3),
    (a1_id, 'Woher ___ du?', '["komme", "kommst", "kommt", "kommen"]', 'kommst', 1, 4),
    (a1_id, 'Ich ___ Deutsch.', '["lerne", "lernst", "lernt", "lernen"]', 'lerne', 1, 5),

    -- A2 Level Questions (Elementary)
    (a2_id, 'Gestern ___ ich ins Kino gegangen.', '["habe", "bin", "war", "hatte"]', 'bin', 1, 6),
    (a2_id, 'Kannst du mir ___ helfen?', '["bitte", "danke", "gern", "sehr"]', 'bitte', 1, 7),
    (a2_id, 'Ich möchte ___ Kaffee trinken.', '["ein", "einen", "eine", "einem"]', 'einen', 1, 8),
    (a2_id, 'Wir haben ___ Wochenende viel Spaß gehabt.', '["am", "im", "um", "zu"]', 'am', 1, 9),
    (a2_id, 'Der Film war ___ als das Buch.', '["gut", "besser", "am besten", "beste"]', 'besser', 1, 10),

    -- B1 Level Questions (Intermediate)
    (b1_id, 'Wenn ich Zeit ___, würde ich dich besuchen.', '["habe", "hätte", "hatte", "haben"]', 'hätte', 2, 11),
    (b1_id, 'Das Auto, ___ vor dem Haus steht, gehört mir.', '["das", "der", "die", "dem"]', 'das', 2, 12),
    (b1_id, 'Ich freue mich ___ die Ferien.', '["auf", "über", "für", "zu"]', 'auf', 2, 13),
    (b1_id, 'Nachdem er ___ hatte, ging er schlafen.', '["gegessen", "essen", "isst", "aß"]', 'gegessen', 2, 14),
    (b1_id, 'Sie lässt ihr Auto ___.', '["reparieren", "repariert", "zu reparieren", "repariere"]', 'reparieren', 2, 15),

    -- B2 Level Questions (Upper-Intermediate)
    (b2_id, 'Der Vertrag muss bis morgen ___ werden.', '["unterschreiben", "unterschrieben", "zu unterschreiben", "unterschreibend"]', 'unterschrieben', 2, 16),
    (b2_id, 'Anstatt zu lernen, ___ er den ganzen Tag.', '["spielt", "spielte", "gespielt", "spielen"]', 'spielte', 2, 17),
    (b2_id, 'Die Entscheidung wurde ___ getroffen.', '["einstimmig", "einstimmige", "einstimmigen", "einstimmiges"]', 'einstimmig', 2, 18),
    (b2_id, 'Je mehr ich lerne, ___ besser verstehe ich es.', '["desto", "umso", "je", "als"]', 'desto', 2, 19),
    (b2_id, 'Das Projekt, ___ Durchführung kompliziert war, ist abgeschlossen.', '["dessen", "deren", "dem", "den"]', 'dessen', 2, 20);

END $$;
