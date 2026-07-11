# DeutschPrep Database Schema

## Tables

### 1. profiles
Extends Supabase auth.users with additional user data
```sql
- id (uuid, FK to auth.users)
- email (text)
- full_name (text)
- role (enum: 'user', 'admin')
- created_at (timestamp)
- updated_at (timestamp)
```

### 2. levels
German proficiency levels
```sql
- id (uuid, PK)
- code (text) - 'A1', 'A2', 'B1', 'B2'
- name (text) - 'Beginner', 'Elementary', etc.
- description (text)
- order (int)
- created_at (timestamp)
```

### 3. skills
Language skills
```sql
- id (uuid, PK)
- code (text) - 'listening', 'reading', 'writing', 'speaking'
- name_de (text) - 'Hören', 'Lesen', 'Schreiben', 'Sprechen'
- name_en (text)
- created_at (timestamp)
```

### 4. test_modules
Purchasable test modules
```sql
- id (uuid, PK)
- level_id (uuid, FK to levels)
- skill_id (uuid, FK to skills)
- title (text)
- description (text)
- price_kes (int) - price in Kenyan Shillings
- question_count (int)
- duration_minutes (int)
- is_active (boolean)
- created_at (timestamp)
- updated_at (timestamp)
```

### 5. questions
Test questions
```sql
- id (uuid, PK)
- test_module_id (uuid, FK to test_modules)
- question_type (enum: 'multiple_choice', 'fill_blank', 'essay', 'audio', 'speaking')
- question_text (text)
- question_audio_url (text, nullable) - for listening questions
- question_image_url (text, nullable)
- options (jsonb) - for multiple choice: ["Option A", "Option B", ...]
- correct_answer (text)
- explanation (text, nullable)
- points (int)
- order (int)
- created_at (timestamp)
```

### 6. placement_test_questions
Questions for the free placement test
```sql
- id (uuid, PK)
- level_id (uuid, FK to levels)
- question_text (text)
- options (jsonb)
- correct_answer (text)
- points (int)
- order (int)
- created_at (timestamp)
```

### 7. purchases
User purchases
```sql
- id (uuid, PK)
- user_id (uuid, FK to profiles)
- test_module_id (uuid, FK to test_modules)
- amount_kes (int)
- mpesa_transaction_id (text)
- mpesa_phone_number (text)
- status (enum: 'pending', 'completed', 'failed', 'refunded')
- created_at (timestamp)
- completed_at (timestamp, nullable)
```

### 8. test_attempts
User test attempts
```sql
- id (uuid, PK)
- user_id (uuid, FK to profiles)
- test_module_id (uuid, FK to test_modules, nullable) - null for placement test
- is_placement_test (boolean)
- started_at (timestamp)
- completed_at (timestamp, nullable)
- score (int, nullable)
- max_score (int)
- percentage (decimal, nullable)
- result_level (text, nullable) - for placement test: 'A1', 'A2', etc.
```

### 9. test_answers
Individual answers in a test attempt
```sql
- id (uuid, PK)
- test_attempt_id (uuid, FK to test_attempts)
- question_id (uuid, FK to questions or placement_test_questions)
- user_answer (text)
- is_correct (boolean)
- points_earned (int)
- created_at (timestamp)
```

### 10. grammar_topics
Grammar assessment topics
```sql
- id (uuid, PK)
- title (text)
- description (text)
- price_kes (int)
- question_count (int)
- is_active (boolean)
- created_at (timestamp)
```

### 11. grammar_questions
Questions for grammar topics
```sql
- id (uuid, PK)
- grammar_topic_id (uuid, FK to grammar_topics)
- question_text (text)
- options (jsonb)
- correct_answer (text)
- explanation (text)
- points (int)
- order (int)
- created_at (timestamp)
```

## Row Level Security (RLS) Policies

### profiles
- Users can read their own profile
- Users can update their own profile
- Admins can read all profiles

### test_modules, questions, levels, skills
- Everyone can read active modules
- Only admins can create/update/delete

### purchases
- Users can read their own purchases
- Admins can read all purchases
- System can create purchases (via service role)

### test_attempts, test_answers
- Users can read/create their own attempts
- Admins can read all attempts

## Indexes
- purchases(user_id, status)
- test_attempts(user_id, completed_at)
- questions(test_module_id, order)
- test_answers(test_attempt_id)
