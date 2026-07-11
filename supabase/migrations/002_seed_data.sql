-- Seed levels
INSERT INTO levels (code, name, description, "order") VALUES
('A1', 'Beginner', 'Basic vocabulary and simple phrases for everyday situations', 1),
('A2', 'Elementary', 'Everyday expressions and routine tasks in familiar contexts', 2),
('B1', 'Intermediate', 'Handle travel situations and describe experiences confidently', 3),
('B2', 'Upper-Intermediate', 'Interact fluently and understand complex texts with ease', 4);

-- Seed skills
INSERT INTO skills (code, name_de, name_en) VALUES
('listening', 'Hören', 'Listening'),
('reading', 'Lesen', 'Reading'),
('writing', 'Schreiben', 'Writing'),
('speaking', 'Sprechen', 'Speaking');
