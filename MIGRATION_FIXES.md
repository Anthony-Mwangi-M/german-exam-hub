# Migration Fixes Applied

## Issues Found and Fixed

### 1. Column Name Mismatch
**Problem**: Migration files used `order_number` but database has `"order"`
**Fix**: Replaced all occurrences of `order_number` with `"order"` in migrations

### 2. Options Data Type Mismatch
**Problem**: Migration files used `ARRAY[...]` but database expects JSONB
**Fix**: Replaced `ARRAY[...]` with `jsonb_build_array(...)` in all migrations

### 3. Question Type Enum Mismatch
**Problem**: Used `'text'` but enum only has: `'multiple_choice', 'fill_blank', 'essay', 'audio', 'speaking'`
**Fix**: Changed `'text'` to `'essay'` for writing and speaking questions

### 4. TypeScript Type Definitions
**Problem**: Type definitions didn't match actual database schema
**Fixes**:
- Updated `questions` table types (order_number → order, options type, question_type enum)
- Updated `test_answers` table types (added points_earned field)
- Updated `test_attempts` table types (removed status, added max_score and percentage)

### 5. Code Updates
**Files Updated**:
- `src/pages/TakeTest.tsx` - Updated to use correct field names, enum values, and parse JSONB options
- `src/pages/Dashboard.tsx` - Updated to use percentage instead of score for display
- `src/types/database.ts` - Updated all type definitions to match schema
- `generate_questions.py` - Updated to generate correct SQL with proper enum values

## Files Fixed

### Migration Files:
- ✅ `supabase/migrations/009_seed_test_questions.sql`
- ✅ `supabase/migrations/010_seed_all_level_questions.sql`
- ✅ `supabase/migrations/013_complete_b1_b2_questions.sql`

### Code Files:
- ✅ `src/types/database.ts`
- ✅ `src/pages/TakeTest.tsx`
- ✅ `src/pages/Dashboard.tsx`

## How to Apply Migrations Now

The migrations are now fixed and ready to run. Follow these steps:

### Step 1: Run Migration 009 (A1 Questions)
```sql
-- Copy content from supabase/migrations/009_seed_test_questions.sql
-- Paste into Supabase SQL Editor
-- Click Run
```

### Step 2: Run Migration 010 (A2 Questions)
```sql
-- Copy content from supabase/migrations/010_seed_all_level_questions.sql
-- Paste into Supabase SQL Editor
-- Click Run
```

### Step 3: Run Migration 013 (B1 & B2 Questions)
```sql
-- Copy content from supabase/migrations/013_complete_b1_b2_questions.sql
-- Paste into Supabase SQL Editor
-- Click Run
```

### Step 4: Verify Questions
```sql
SELECT 
  l.code as level,
  s.code as skill,
  COUNT(q.id) as question_count
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
LEFT JOIN questions q ON q.test_module_id = tm.id
GROUP BY l.code, s.code
ORDER BY l.code, s.code;
```

Expected results:
- A1: 5 questions per skill (20 total)
- A2: 10 questions per skill (40 total)
- B1: 10 questions per skill (40 total)
- B2: 10 questions per skill (40 total)

## Database Schema Reference

### questions table
```sql
CREATE TABLE questions (
    id UUID PRIMARY KEY,
    test_module_id UUID NOT NULL,
    question_type question_type NOT NULL,
    question_text TEXT NOT NULL,
    question_audio_url TEXT,
    question_image_url TEXT,
    options JSONB,                    -- JSONB, not ARRAY
    correct_answer TEXT NOT NULL,
    explanation TEXT,
    points INT DEFAULT 1 NOT NULL,
    "order" INT NOT NULL,             -- "order" not order_number
    created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### test_attempts table
```sql
CREATE TABLE test_attempts (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    test_module_id UUID,
    is_placement_test BOOLEAN DEFAULT false,
    started_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ,
    score INT,                        -- Raw score (number correct)
    max_score INT NOT NULL,           -- Total questions
    percentage DECIMAL(5,2),          -- Calculated percentage
    result_level TEXT
);
```

### test_answers table
```sql
CREATE TABLE test_answers (
    id UUID PRIMARY KEY,
    test_attempt_id UUID NOT NULL,
    question_id UUID NOT NULL,
    user_answer TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL,
    points_earned INT NOT NULL,       -- Points for this answer
    created_at TIMESTAMPTZ DEFAULT NOW()
);
```

## Testing After Migration

1. **Check questions exist**:
   ```sql
   SELECT COUNT(*) FROM questions;
   -- Should return 140
   ```

2. **Test purchase flow**:
   - Go to any level page
   - Click "Purchase" on a test
   - Complete simulated payment

3. **Test taking a test**:
   - Start a purchased test
   - Answer questions
   - Submit test

4. **Check results**:
   - View score and percentage
   - Review answers
   - Check dashboard

## Common Issues

### Issue: "column does not exist"
- Make sure you're using the exact column names from the schema
- Remember to quote "order" since it's a reserved word

### Issue: "invalid input syntax for type json"
- Make sure options are in JSONB format using `jsonb_build_array()`
- Not PostgreSQL ARRAY format

### Issue: "null value in column violates not-null constraint"
- Check that all required fields are provided
- For test_attempts, max_score is required
- For test_answers, points_earned is required

## Next Steps

After successfully running all migrations:
1. Test the complete user flow
2. Improve question quality (better options, explanations)
3. Move to M-Pesa integration or Admin dashboard
