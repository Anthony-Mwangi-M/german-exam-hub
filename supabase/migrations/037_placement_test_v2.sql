-- Placement test v2: fixes defective items and expands to 8 items per band
--
-- Fixes from review:
--   * "Guten ___!" had three valid answers (Tag/Morgen/Abend) — removed
--   * "Je mehr ..., ___ besser" listed both desto and umso — umso removed
--   * "Anstatt zu lernen, ___ er den ganzen Tag" had no past anchor — anchored
--   * Politeness item (bitte) replaced with a grammar discriminator
-- Additions:
--   * 2 reading-comprehension items per band (matches "grammar and
--     comprehension" marketing copy)
--   * 8 items per band = 32 items, A1/A2 worth 1 point, B1/B2 worth 2

DELETE FROM placement_test_questions;

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

    INSERT INTO placement_test_questions (level_id, question_text, options, correct_answer, points, "order") VALUES

    -- ─── A1 (8 items, 1 point) ───────────────────────────────────────────
    (a1_id, 'Das ___ meine Schwester.',
     '["bin", "ist", "sind", "bist"]', 'ist', 1, 1),
    (a1_id, 'Ich habe ___ Bruder.',
     '["ein", "einen", "eine", "einem"]', 'einen', 1, 2),
    (a1_id, 'Ich habe ___ Auto.',
     '["nicht", "kein", "keine", "nichts"]', 'kein', 1, 3),
    (a1_id, '___ wohnst du? — In Nairobi.',
     '["Woher", "Wer", "Wo", "Wohin"]', 'Wo', 1, 4),
    (a1_id, 'Anna und Tom ___ aus Kenia.',
     '["kommt", "kommen", "kommst", "komme"]', 'kommen', 1, 5),
    (a1_id, 'Das ist ___ Handy. Es gehört mir.',
     '["meine", "meinem", "mein", "meiner"]', 'mein', 1, 6),
    (a1_id, E'Schild am Geschäft:\n„Öffnungszeiten: Mo–Fr 8–18 Uhr, Sa 9–14 Uhr, So geschlossen."\n\nWann ist das Geschäft geschlossen?',
     '["Am Samstag", "Am Montag", "Am Sonntag", "Am Freitag"]', 'Am Sonntag', 1, 7),
    (a1_id, E'Notiz:\n„Hallo Ben, ich komme heute 20 Minuten später. Warte bitte vor dem Kino! Lisa"\n\nWas soll Ben machen?',
     '["Später kommen", "Vor dem Kino warten", "Ins Kino gehen", "Lisa anrufen"]', 'Vor dem Kino warten', 1, 8),

    -- ─── A2 (8 items, 1 point) ───────────────────────────────────────────
    (a2_id, 'Wir ___ am Sonntag einen Ausflug gemacht.',
     '["sind", "haben", "waren", "hatten"]', 'haben', 1, 9),
    (a2_id, 'Ich fahre mit ___ Bus zur Arbeit.',
     '["den", "der", "das", "dem"]', 'dem', 1, 10),
    (a2_id, 'Im Sommer ist es ___ als im Winter.',
     '["warm", "wärmer", "am wärmsten", "wärmste"]', 'wärmer', 1, 11),
    (a2_id, '___ du mir bitte helfen?',
     '["Kann", "Könnt", "Kannst", "Können"]', 'Kannst', 1, 12),
    (a2_id, 'Ich bleibe heute zu Hause, weil ich krank ___.',
     '["bin", "ist", "sein", "habe"]', 'bin', 1, 13),
    (a2_id, 'Wann stehst du morgens ___?',
     '["an", "auf", "aus", "ab"]', 'auf', 1, 14),
    (a2_id, E'E-Mail:\n„Liebe Frau Otieno, Ihr Termin am Dienstag fällt leider aus. Können Sie am Donnerstag um 10 Uhr kommen? Bitte antworten Sie bis morgen. Praxis Dr. Weber"\n\nWas soll Frau Otieno tun?',
     '["Am Dienstag kommen", "Bis morgen antworten", "Dr. Weber anrufen", "Den Termin absagen"]', 'Bis morgen antworten', 1, 15),
    (a2_id, E'Anzeige:\n„Suche Nachhilfe in Mathematik für meinen Sohn (12 Jahre). Zweimal pro Woche, gern abends."\n\nWas sucht die Person?',
     '["Eine neue Arbeit", "Einen Mathekurs für sich", "Nachhilfe für ihr Kind", "Eine Schule"]', 'Nachhilfe für ihr Kind', 1, 16),

    -- ─── B1 (8 items, 2 points) ──────────────────────────────────────────
    (b1_id, 'Wenn ich mehr Zeit ___, würde ich einen Deutschkurs machen.',
     '["habe", "hätte", "hatte", "haben"]', 'hätte', 2, 17),
    (b1_id, 'Die Kollegin, ___ ich gestern geholfen habe, ist sehr nett.',
     '["die", "der", "den", "dem"]', 'der', 2, 18),
    (b1_id, 'Wir warten ___ den Bus.',
     '["an", "für", "auf", "über"]', 'auf', 2, 19),
    (b1_id, 'Nachdem sie die Prüfung bestanden ___, feierte sie mit Freunden.',
     '["hat", "hatte", "ist", "war"]', 'hatte', 2, 20),
    (b1_id, 'In Deutschland ___ viel Brot gegessen.',
     '["ist", "hat", "werden", "wird"]', 'wird', 2, 21),
    (b1_id, 'Ich lasse meine Haare ___.',
     '["geschnitten", "schneiden", "zu schneiden", "schneidet"]', 'schneiden', 2, 22),
    (b1_id, E'Aushang:\n„Sehr geehrte Mieterinnen und Mieter, wegen Wartungsarbeiten fällt der Aufzug am Mittwoch von 9 bis 15 Uhr aus. Wir bitten um Verständnis. Die Hausverwaltung"\n\nWas passiert am Mittwoch?',
     '["Das Haus wird renoviert", "Der Aufzug funktioniert nicht", "Die Verwaltung ist geschlossen", "Die Mieter müssen ausziehen"]', 'Der Aufzug funktioniert nicht', 2, 23),
    (b1_id, E'Forumsbeitrag:\n„Ich finde Online-Kurse praktisch, weil man flexibel lernen kann. Trotzdem fehlt mir der direkte Kontakt zu anderen Lernenden."\n\nWie findet die Person Online-Kurse?',
     '["Nur schlecht", "Nur gut", "Langweilig", "Praktisch, aber nicht perfekt"]', 'Praktisch, aber nicht perfekt', 2, 24),

    -- ─── B2 (8 items, 2 points) ──────────────────────────────────────────
    (b2_id, 'Der Antrag muss bis Freitag ___ werden.',
     '["einreichen", "eingereicht", "einzureichen", "eingereichte"]', 'eingereicht', 2, 25),
    (b2_id, 'Die Firma, ___ Produkte weltweit bekannt sind, expandiert nach Ostafrika.',
     '["dessen", "denen", "deren", "die"]', 'deren', 2, 26),
    (b2_id, 'Je länger man übt, ___ sicherer wird man.',
     '["als", "desto", "wie", "dann"]', 'desto', 2, 27),
    (b2_id, 'Anstatt sich vorzubereiten, ___ er gestern den ganzen Abend fern.',
     '["sieht", "sehen", "sah", "gesehen"]', 'sah', 2, 28),
    (b2_id, 'Die ___ Teilnehmer erhalten ein Zertifikat.',
     '["erfolgreiche", "erfolgreichen", "erfolgreicher", "erfolgreiches"]', 'erfolgreichen', 2, 29),
    (b2_id, 'Der Minister sagte, die Lage ___ stabil.',
     '["sei", "sein", "seid", "bin"]', 'sei', 2, 30),
    (b2_id, E'Zeitungsausschnitt:\n„Immer mehr Unternehmen setzen auf die Vier-Tage-Woche. Erste Studien zeigen eine höhere Produktivität, allerdings warnen Kritiker vor Personalengpässen in sozialen Berufen."\n\nWas zeigen erste Studien?',
     '["Personalengpässe", "Höhere Produktivität", "Weniger Motivation", "Mehr Krankheitstage"]', 'Höhere Produktivität', 2, 31),
    (b2_id, E'Kommentar:\n„Zwar bietet das Homeoffice viele Freiheiten, doch verschwimmen dabei häufig die Grenzen zwischen Arbeit und Privatleben."\n\nWelche Kritik äußert der Text am Homeoffice?',
     '["Es gibt zu viele Freiheiten", "Es ist zu teuer", "Man arbeitet zu wenig", "Arbeit und Privatleben vermischen sich"]', 'Arbeit und Privatleben vermischen sich', 2, 32);

END $$;
