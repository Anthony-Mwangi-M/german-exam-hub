# Running the Latest Migration

## Migration 009: Seed Test Questions

This migration adds sample questions for the test modules. Currently, it includes 5 questions per skill for A1 level.

### Option 1: Using Supabase Dashboard (Recommended)

1. Go to your Supabase project dashboard: https://supabase.com/dashboard/project/rpwlitvddtzupszplpmj
2. Click on "SQL Editor" in the left sidebar
3. Click "New Query"
4. Open the file `supabase/migrations/009_seed_test_questions.sql`
5. Copy all the content
6. Paste it into the SQL Editor
7. Click "Run" button
8. You should see a success message

### Option 2: Using Supabase CLI

If you have Supabase CLI installed:

```bash
# Make sure you're in the project root
cd /path/to/deutschprep

# Run the migration
supabase db push
```

### Verify the Migration

After running the migration, verify it worked:

1. Go to SQL Editor in Supabase Dashboard
2. Run this query:

```sql
-- Check how many questions were created
SELECT 
  l.code as level,
  s.code as skill,
  COUNT(q.id) as question_count
FROM questions q
JOIN test_modules tm ON q.test_module_id = tm.id
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
GROUP BY l.code, s.code
ORDER BY l.code, s.code;
```

You should see 5 questions for each A1 skill (listening, reading, writing, speaking).

### What This Migration Does

- Adds 5 listening questions for A1 level (multiple choice)
- Adds 5 reading questions for A1 level (multiple choice)
- Adds 5 writing questions for A1 level (text/essay type)
- Adds 5 speaking questions for A1 level (text/oral response type)

Total: 20 questions for A1 level

### Next Steps

After running this migration, you can:

1. Test the purchase flow by buying an A1 test
2. Take the test and see the questions
3. Complete the test and view results
4. Add more questions for A2, B1, B2 levels (follow the same pattern in the migration file)

### Adding More Questions

To add questions for other levels (A2, B1, B2), you can:

1. Copy the pattern from migration 009
2. Change the level code in the WHERE clause
3. Update the questions to be appropriate for that level
4. Run the new SQL in the SQL Editor

Example for A2:
```sql
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT 
  tm.id,
  'Your A2 question here',
  'multiple_choice',
  ARRAY['Option 1', 'Option 2', 'Option 3', 'Option 4'],
  'Option 1',
  'Explanation here',
  1
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = 'A2' AND s.code = 'listening';
```

## Troubleshooting

### Error: "relation does not exist"
- Make sure you've run all previous migrations (001-008)
- Check that the test_modules table has data

### Error: "duplicate key value"
- The migration might have already been run
- Check existing questions: `SELECT COUNT(*) FROM questions;`

### No questions showing in the app
- Verify questions were created: `SELECT * FROM questions LIMIT 5;`
- Check that test_module_id matches existing modules
- Verify RLS policies allow reading questions
