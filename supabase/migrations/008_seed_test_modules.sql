-- Seed test modules for each level and skill
DO $$
DECLARE
    a1_id UUID;
    a2_id UUID;
    b1_id UUID;
    b2_id UUID;
    listening_id UUID;
    reading_id UUID;
    writing_id UUID;
    speaking_id UUID;
BEGIN
    -- Get level IDs
    SELECT id INTO a1_id FROM levels WHERE code = 'A1';
    SELECT id INTO a2_id FROM levels WHERE code = 'A2';
    SELECT id INTO b1_id FROM levels WHERE code = 'B1';
    SELECT id INTO b2_id FROM levels WHERE code = 'B2';
    
    -- Get skill IDs
    SELECT id INTO listening_id FROM skills WHERE code = 'listening';
    SELECT id INTO reading_id FROM skills WHERE code = 'reading';
    SELECT id INTO writing_id FROM skills WHERE code = 'writing';
    SELECT id INTO speaking_id FROM skills WHERE code = 'speaking';

    -- A1 Test Modules
    INSERT INTO test_modules (level_id, skill_id, title, description, price_kes, question_count, duration_minutes, is_active) VALUES
    (a1_id, listening_id, 'A1 Listening Practice Test', 'Practice listening comprehension with basic everyday conversations and simple announcements.', 100, 30, 30, true),
    (a1_id, reading_id, 'A1 Reading Comprehension', 'Read and understand simple texts, signs, and short messages.', 100, 25, 45, true),
    (a1_id, writing_id, 'A1 Writing Exercises', 'Practice writing simple sentences and filling out forms.', 100, 15, 40, true),
    (a1_id, speaking_id, 'A1 Speaking Prompts', 'Prepare for speaking tasks with guided prompts and sample answers.', 100, 20, 30, true),

    -- A2 Test Modules
    (a2_id, listening_id, 'A2 Listening Practice Test', 'Understand conversations about familiar topics and simple announcements.', 150, 35, 35, true),
    (a2_id, reading_id, 'A2 Reading Comprehension', 'Read short texts, personal letters, and simple advertisements.', 150, 30, 50, true),
    (a2_id, writing_id, 'A2 Writing Exercises', 'Write short personal letters and simple connected texts.', 150, 18, 45, true),
    (a2_id, speaking_id, 'A2 Speaking Prompts', 'Practice describing experiences and giving opinions on familiar topics.', 150, 22, 35, true),

    -- B1 Test Modules
    (b1_id, listening_id, 'B1 Listening Practice Test', 'Understand main points of clear speech on familiar matters and radio/TV programs.', 200, 40, 40, true),
    (b1_id, reading_id, 'B1 Reading Comprehension', 'Read texts about current affairs and understand descriptions of events and feelings.', 200, 35, 60, true),
    (b1_id, writing_id, 'B1 Writing Exercises', 'Write detailed texts on familiar subjects and personal letters describing experiences.', 200, 20, 50, true),
    (b1_id, speaking_id, 'B1 Speaking Prompts', 'Describe experiences, dreams, and ambitions, and give reasons for opinions.', 200, 25, 40, true),

    -- B2 Test Modules
    (b2_id, listening_id, 'B2 Listening Practice Test', 'Understand extended speech and lectures, and follow complex arguments.', 250, 45, 45, true),
    (b2_id, reading_id, 'B2 Reading Comprehension', 'Read articles, reports, and contemporary literary prose with ease.', 250, 40, 70, true),
    (b2_id, writing_id, 'B2 Writing Exercises', 'Write clear, detailed texts on various subjects and essays with arguments.', 250, 22, 60, true),
    (b2_id, speaking_id, 'B2 Speaking Prompts', 'Present detailed descriptions, explain viewpoints, and interact fluently.', 250, 28, 45, true);

END $$;
