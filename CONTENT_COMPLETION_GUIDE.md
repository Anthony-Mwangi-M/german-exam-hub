# Content Completion Guide

## Current Status

### ✅ Completed
- **A1 Level**: 5 questions per skill (20 total) - Migration 009
- **A2 Level**: 10 questions per skill (40 total) - Migration 010

### 🚧 In Progress
- **B1 Level**: Partially complete in Migration 011
- **B2 Level**: Started in Migration 012

## Quick Setup Instructions

### Step 1: Run Existing Migrations

Run these migrations in your Supabase SQL Editor:

1. **Migration 009** - A1 questions (already created)
2. **Migration 010** - A2 questions (already created)

### Step 2: Complete Remaining Questions

You have two options:

#### Option A: Use AI to Generate (Recommended)
Use ChatGPT or Claude to generate questions following this template:

```sql
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 
  '[Your question here]', 
  'multiple_choice',
  ARRAY['Option 1', 'Option 2', 'Option 3', 'Option 4'],
  'Correct option',
  'Explanation',
  [number]
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = '[LEVEL]' AND s.code = '[SKILL]';
```

#### Option B: Manual Entry via Supabase Dashboard
1. Go to Table Editor → questions
2. Click "Insert row"
3. Fill in the fields manually

## Question Requirements by Level

### A1 (Beginner)
- **Topics**: Daily life, family, hobbies, food, basic greetings
- **Grammar**: Present tense, basic sentence structure, articles
- **Vocabulary**: 500-1000 words
- **Complexity**: Simple sentences, concrete topics

### A2 (Elementary)
- **Topics**: Work, travel, shopping, health, past experiences
- **Grammar**: Past tense, modal verbs, comparatives
- **Vocabulary**: 1000-2000 words
- **Complexity**: Connected sentences, personal experiences

### B1 (Intermediate)
- **Topics**: Education, environment, technology, opinions
- **Grammar**: Subjunctive, relative clauses, passive voice
- **Vocabulary**: 2000-3000 words
- **Complexity**: Arguments, descriptions, explanations

### B2 (Upper Intermediate)
- **Topics**: Abstract concepts, politics, culture, complex issues
- **Grammar**: Advanced structures, nuanced expressions
- **Vocabulary**: 3000-5000 words
- **Complexity**: Detailed arguments, analysis, formal writing

## Question Types by Skill

### Listening (Hören)
- Multiple choice based on audio scenarios
- Questions about main ideas, details, opinions
- **Note**: Currently text-based, audio files to be added later

### Reading (Lesen)
- Multiple choice comprehension questions
- Grammar and vocabulary in context
- Text analysis questions

### Writing (Schreiben)
- Text/essay type questions
- Prompts for emails, letters, opinions, descriptions
- Minimum word count specified in question

### Speaking (Sprechen)
- Text type (for written responses)
- Prompts for oral presentations
- **Note**: Will be evaluated manually or via audio upload later

## Recommended Question Distribution

For each test module (10 questions total):

### Listening & Reading
- 3 questions: Main idea/comprehension
- 3 questions: Details/specific information
- 2 questions: Vocabulary/grammar in context
- 2 questions: Inference/opinion

### Writing
- 2 questions: Formal writing (letters, emails)
- 3 questions: Opinion/argumentative
- 3 questions: Descriptive/narrative
- 2 questions: Practical (instructions, complaints)

### Speaking
- 2 questions: Personal introduction/description
- 3 questions: Opinion/discussion topics
- 3 questions: Situational responses
- 2 questions: Presentation/explanation

## Quick Generation Script

Use this Python script to generate bulk questions:

```python
levels = ['B1', 'B2']
skills = ['listening', 'reading', 'writing', 'speaking']

for level in levels:
    for skill in skills:
        for i in range(1, 11):  # 10 questions per module
            print(f"""
INSERT INTO questions (test_module_id, question_text, question_type, options, correct_answer, explanation, order_number)
SELECT tm.id, 
  '{level} {skill} question {i}', 
  '{'multiple_choice' if skill in ['listening', 'reading'] else 'text'}',
  {'ARRAY[\'Option 1\', \'Option 2\', \'Option 3\', \'Option 4\']' if skill in ['listening', 'reading'] else 'NULL'},
  '{'Option 1' if skill in ['listening', 'reading'] else 'Sample answer'}',
  'Explanation for question {i}',
  {i}
FROM test_modules tm 
JOIN levels l ON tm.level_id = l.id 
JOIN skills s ON tm.skill_id = s.id
WHERE l.code = '{level}' AND s.code = '{skill}';
""")
```

## Testing Your Questions

After adding questions, verify with:

```sql
-- Count questions per module
SELECT 
  l.code as level,
  s.code as skill,
  tm.title,
  COUNT(q.id) as question_count
FROM test_modules tm
JOIN levels l ON tm.level_id = l.id
JOIN skills s ON tm.skill_id = s.id
LEFT JOIN questions q ON q.test_module_id = tm.id
GROUP BY l.code, s.code, tm.title
ORDER BY l.code, s.code;

-- Should show 10 questions for each module
```

## Next Steps After Content Completion

1. **Test the user flow**
   - Purchase a test
   - Take the test
   - Review results

2. **Add audio files** (for listening tests)
   - Upload to Supabase Storage
   - Link to questions table

3. **Implement M-Pesa** (for real payments)
   - Set up Daraja API
   - Create Edge Function

4. **Build Admin Dashboard** (for content management)
   - CRUD for questions
   - Bulk import/export
   - Analytics

## Pro Tips

- Start with B1 and B2 listening/reading (easier to create)
- Use real German exam questions as inspiration (Goethe-Institut, TestDaF)
- Keep explanations clear and educational
- Test questions yourself before publishing
- Consider hiring a German teacher to review content quality
