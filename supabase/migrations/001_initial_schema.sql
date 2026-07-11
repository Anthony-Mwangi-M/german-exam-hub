-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create enum types
CREATE TYPE user_role AS ENUM ('user', 'admin');
CREATE TYPE purchase_status AS ENUM ('pending', 'completed', 'failed', 'refunded');
CREATE TYPE question_type AS ENUM ('multiple_choice', 'fill_blank', 'essay', 'audio', 'speaking');

-- Profiles table (extends auth.users)
CREATE TABLE profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL,
    full_name TEXT,
    role user_role DEFAULT 'user' NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Levels table
CREATE TABLE levels (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    "order" INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Skills table
CREATE TABLE skills (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code TEXT UNIQUE NOT NULL,
    name_de TEXT NOT NULL,
    name_en TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Test modules table
CREATE TABLE test_modules (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    level_id UUID REFERENCES levels(id) ON DELETE CASCADE NOT NULL,
    skill_id UUID REFERENCES skills(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    price_kes INT NOT NULL,
    question_count INT NOT NULL,
    duration_minutes INT NOT NULL,
    is_active BOOLEAN DEFAULT true NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Questions table
CREATE TABLE questions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    test_module_id UUID REFERENCES test_modules(id) ON DELETE CASCADE NOT NULL,
    question_type question_type NOT NULL,
    question_text TEXT NOT NULL,
    question_audio_url TEXT,
    question_image_url TEXT,
    options JSONB,
    correct_answer TEXT NOT NULL,
    explanation TEXT,
    points INT DEFAULT 1 NOT NULL,
    "order" INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Placement test questions table
CREATE TABLE placement_test_questions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    level_id UUID REFERENCES levels(id) ON DELETE CASCADE NOT NULL,
    question_text TEXT NOT NULL,
    options JSONB NOT NULL,
    correct_answer TEXT NOT NULL,
    points INT DEFAULT 1 NOT NULL,
    "order" INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Purchases table
CREATE TABLE purchases (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
    test_module_id UUID REFERENCES test_modules(id) ON DELETE CASCADE NOT NULL,
    amount_kes INT NOT NULL,
    mpesa_transaction_id TEXT,
    mpesa_phone_number TEXT NOT NULL,
    status purchase_status DEFAULT 'pending' NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    completed_at TIMESTAMPTZ
);

-- Test attempts table
CREATE TABLE test_attempts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
    test_module_id UUID REFERENCES test_modules(id) ON DELETE CASCADE,
    is_placement_test BOOLEAN DEFAULT false NOT NULL,
    started_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    completed_at TIMESTAMPTZ,
    score INT,
    max_score INT NOT NULL,
    percentage DECIMAL(5,2),
    result_level TEXT
);

-- Test answers table
CREATE TABLE test_answers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    test_attempt_id UUID REFERENCES test_attempts(id) ON DELETE CASCADE NOT NULL,
    question_id UUID NOT NULL,
    user_answer TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL,
    points_earned INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Grammar topics table
CREATE TABLE grammar_topics (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    description TEXT,
    price_kes INT NOT NULL,
    question_count INT NOT NULL,
    is_active BOOLEAN DEFAULT true NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Grammar questions table
CREATE TABLE grammar_questions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    grammar_topic_id UUID REFERENCES grammar_topics(id) ON DELETE CASCADE NOT NULL,
    question_text TEXT NOT NULL,
    options JSONB NOT NULL,
    correct_answer TEXT NOT NULL,
    explanation TEXT,
    points INT DEFAULT 1 NOT NULL,
    "order" INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Create indexes
CREATE INDEX idx_purchases_user_status ON purchases(user_id, status);
CREATE INDEX idx_test_attempts_user ON test_attempts(user_id, completed_at);
CREATE INDEX idx_questions_module ON questions(test_module_id, "order");
CREATE INDEX idx_test_answers_attempt ON test_answers(test_attempt_id);
CREATE INDEX idx_placement_questions_level ON placement_test_questions(level_id, "order");

-- Enable Row Level Security
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE test_modules ENABLE ROW LEVEL SECURITY;
ALTER TABLE questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE placement_test_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE purchases ENABLE ROW LEVEL SECURITY;
ALTER TABLE test_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE test_answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE grammar_topics ENABLE ROW LEVEL SECURITY;
ALTER TABLE grammar_questions ENABLE ROW LEVEL SECURITY;

-- RLS Policies for profiles
CREATE POLICY "Users can view own profile" ON profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Admins can view all profiles" ON profiles FOR SELECT USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
);

-- RLS Policies for test_modules (public read, admin write)
CREATE POLICY "Anyone can view active test modules" ON test_modules FOR SELECT USING (is_active = true);
CREATE POLICY "Admins can manage test modules" ON test_modules FOR ALL USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
);

-- RLS Policies for questions (public read for purchased, admin write)
CREATE POLICY "Users can view questions for purchased tests" ON questions FOR SELECT USING (
    EXISTS (
        SELECT 1 FROM purchases 
        WHERE purchases.user_id = auth.uid() 
        AND purchases.test_module_id = questions.test_module_id 
        AND purchases.status = 'completed'
    )
    OR EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
);
CREATE POLICY "Admins can manage questions" ON questions FOR ALL USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
);

-- RLS Policies for placement_test_questions (public read)
CREATE POLICY "Anyone can view placement test questions" ON placement_test_questions FOR SELECT USING (true);
CREATE POLICY "Admins can manage placement questions" ON placement_test_questions FOR ALL USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
);

-- RLS Policies for purchases
CREATE POLICY "Users can view own purchases" ON purchases FOR SELECT USING (user_id = auth.uid());
CREATE POLICY "Users can create purchases" ON purchases FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "Admins can view all purchases" ON purchases FOR SELECT USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
);

-- RLS Policies for test_attempts
CREATE POLICY "Users can view own attempts" ON test_attempts FOR SELECT USING (user_id = auth.uid());
CREATE POLICY "Users can create attempts" ON test_attempts FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY "Users can update own attempts" ON test_attempts FOR UPDATE USING (user_id = auth.uid());
CREATE POLICY "Admins can view all attempts" ON test_attempts FOR SELECT USING (
    EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin')
);

-- RLS Policies for test_answers
CREATE POLICY "Users can view own answers" ON test_answers FOR SELECT USING (
    EXISTS (SELECT 1 FROM test_attempts WHERE test_attempts.id = test_answers.test_attempt_id AND test_attempts.user_id = auth.uid())
);
CREATE POLICY "Users can create answers" ON test_answers FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM test_attempts WHERE test_attempts.id = test_answers.test_attempt_id AND test_attempts.user_id = auth.uid())
);

-- Function to handle new user creation
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO profiles (id, email, full_name)
    VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data->>'full_name');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger for new user creation
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers for updated_at
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_test_modules_updated_at BEFORE UPDATE ON test_modules
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
