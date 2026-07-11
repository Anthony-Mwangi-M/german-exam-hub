# Frontend AI Integration Checklist

This checklist guides you through integrating the AI evaluation components into your frontend.

## Prerequisites
- [x] Database migration run (`supabase db push`)
- [x] Edge Functions deployed (`./deploy-ai.sh`)
- [x] OpenAI API key configured
- [ ] Frontend components created (VoiceRecorder, AIFeedback)

## Step 1: Update TakeTest.tsx (20 min)

### 1.1 Add Imports
```tsx
import { VoiceRecorder } from '@/components/VoiceRecorder';
import { Play } from 'lucide-react';
```

### 1.2 Add Audio Player for Listening Questions
Find the question rendering section and add before the question text:

```tsx
{/* Audio player for listening questions */}
{currentQuestion.audio_url && (
  <div className="mb-4 rounded-lg border p-4 bg-muted/50">
    <audio 
      controls 
      className="w-full"
      src={currentQuestion.audio_url}
    >
      Your browser does not support audio.
    </audio>
    <p className="text-xs text-muted-foreground mt-2">
      Sie können die Aufnahme mehrmals anhören.
    </p>
  </div>
)}
```

### 1.3 Add Voice Recorder for Speaking Questions
Replace the textarea for speaking questions:

```tsx
{currentQuestion.question_type === 'speaking' && (
  <VoiceRecorder
    onRecordingComplete={(audioBlob) => {
      // Convert to base64
      const reader = new FileReader();
      reader.readAsDataURL(audioBlob);
      reader.onloadend = () => {
        const base64 = reader.result?.toString().split(',')[1];
        handleAnswerChange(currentQuestion.id, base64 || '');
      };
    }}
    disabled={submitting}
  />
)}
```

### 1.4 Update handleSubmit Function
Replace the existing handleSubmit with AI evaluation logic:

```tsx
const handleSubmit = async () => {
  if (!testAttemptId || !user) return;
  setSubmitting(true);

  try {
    // Save all answers first
    const answerRecords = questions.map((q) => {
      const userAnswer = answers[q.id] || '';
      const isCorrect = q.question_type === 'multiple_choice' 
        ? userAnswer === q.correct_answer
        : null; // Will be evaluated by AI

      return {
        test_attempt_id: testAttemptId,
        question_id: q.id,
        user_answer: userAnswer,
        is_correct: isCorrect,
        points_earned: isCorrect ? (q.points || 1) : 0,
      };
    });

    const { data: savedAnswers, error: answersError } = await supabase
      .from('test_answers')
      .insert(answerRecords as any)
      .select();

    if (answersError) throw answersError;

    // Trigger AI evaluation for essay and speaking questions
    const evaluationPromises = savedAnswers
      .filter((answer: any) => {
        const question = questions.find(q => q.id === answer.question_id);
        return question?.question_type === 'essay' || question?.question_type === 'speaking';
      })
      .map(async (answer: any) => {
        const question = questions.find(q => q.id === answer.question_id);
        if (!question) return;

        const endpoint = question.question_type === 'speaking' 
          ? 'evaluate-speaking' 
          : 'evaluate-writing';

        const body = question.question_type === 'speaking'
          ? {
              answerId: answer.id,
              audioBase64: answer.user_answer,
              questionText: question.question_text,
              level: testModule?.level.code || 'A1'
            }
          : {
              answerId: answer.id,
              answerText: answer.user_answer,
              questionText: question.question_text,
              level: testModule?.level.code || 'A1'
            };

        try {
          const response = await supabase.functions.invoke(endpoint, {
            body
          });

          if (response.error) {
            console.error(`AI evaluation error for ${answer.id}:`, response.error);
          }
        } catch (error) {
          console.error(`Failed to evaluate ${answer.id}:`, error);
        }
      });

    // Wait for all evaluations (but don't block submission)
    Promise.all(evaluationPromises).catch(console.error);

    // Calculate score (only for multiple choice)
    const correctCount = savedAnswers.filter((a: any) => a.is_correct).length;
    const score = Math.round((correctCount / questions.length) * 100);

    // Update test attempt
    await supabase
      .from('test_attempts')
      .update({
        score: correctCount,
        percentage: score,
        completed_at: new Date().toISOString(),
      })
      .eq('id', testAttemptId);

    toast({
      title: "Test submitted!",
      description: "AI is evaluating your answers...",
    });

    navigate(`/test/${moduleId}/results/${testAttemptId}`);
  } catch (error: any) {
    console.error('Submit error:', error);
    toast({
      title: "Submission failed",
      description: error.message,
      variant: "destructive",
    });
    setSubmitting(false);
  }
};
```

**Status**: [ ] Complete

---

## Step 2: Update TestResults.tsx (10 min)

### 2.1 Add Import
```tsx
import { AIFeedback } from '@/components/AIFeedback';
```

### 2.2 Update QuestionResult Interface
```tsx
interface QuestionResult {
  question_text: string;
  user_answer: string;
  correct_answer: string;
  is_correct: boolean;
  explanation?: string;
  question_type: string;
  ai_evaluation?: any; // Add this
}
```

### 2.3 Update loadResults Function
Modify the query to include ai_evaluation:

```tsx
const { data: answersData } = await supabase
  .from('test_answers')
  .select(`
    user_answer,
    is_correct,
    ai_evaluation,
    question:questions(
      question_text,
      correct_answer,
      explanation,
      question_type
    )
  `)
  .eq('test_attempt_id', attemptId);

if (answersData) {
  const formattedResults = answersData.map((answer: any) => ({
    question_text: answer.question.question_text,
    user_answer: answer.user_answer,
    correct_answer: answer.question.correct_answer,
    is_correct: answer.is_correct,
    explanation: answer.question.explanation,
    question_type: answer.question.question_type,
    ai_evaluation: answer.ai_evaluation, // Add this
  }));
  setResults(formattedResults);
}
```

### 2.4 Add AI Feedback Display
In the answer review section, add after the question text:

```tsx
{/* AI Feedback for essay and speaking questions */}
{result.ai_evaluation && (
  <div className="mt-4">
    <AIFeedback 
      evaluation={result.ai_evaluation}
      type={result.question_type === 'speaking' ? 'speaking' : 'writing'}
    />
  </div>
)}

{/* Traditional feedback for multiple choice */}
{!result.ai_evaluation && (
  <div className="space-y-2">
    <div className="rounded-lg bg-muted p-3">
      <p className="text-sm font-medium mb-1">Your answer:</p>
      <p className={result.is_correct ? 'text-green-700' : 'text-red-700'}>
        {result.user_answer || '(No answer provided)'}
      </p>
    </div>

    {!result.is_correct && result.question_type === 'multiple_choice' && (
      <div className="rounded-lg bg-green-50 p-3">
        <p className="text-sm font-medium mb-1 text-green-900">Correct answer:</p>
        <p className="text-green-700">{result.correct_answer}</p>
      </div>
    )}

    {result.explanation && (
      <div className="rounded-lg bg-blue-50 p-3">
        <p className="text-sm font-medium mb-1 text-blue-900">Explanation:</p>
        <p className="text-sm text-blue-700">{result.explanation}</p>
      </div>
    )}
  </div>
)}
```

**Status**: [ ] Complete

---

## Step 3: Test Everything (15 min)

### 3.1 Test Writing Evaluation
- [ ] Take a test with essay questions
- [ ] Submit a written answer
- [ ] Check results page
- [ ] Verify AI feedback appears
- [ ] Check scores are displayed correctly

### 3.2 Test Speaking Evaluation
- [ ] Take a test with speaking questions
- [ ] Record your voice
- [ ] Submit the test
- [ ] Check results page
- [ ] Verify transcription appears
- [ ] Verify AI feedback appears

### 3.3 Test Audio Playback (if audio generated)
- [ ] Take a listening test
- [ ] Verify audio player appears
- [ ] Test play/pause controls
- [ ] Verify audio plays correctly

### 3.4 Test Multiple Choice (should still work)
- [ ] Take a test with multiple choice
- [ ] Submit answers
- [ ] Verify immediate scoring works
- [ ] Verify correct/incorrect display

---

## Step 4: Build & Deploy (5 min)

### 4.1 Install Dependencies
```bash
npm install
```

### 4.2 Build
```bash
npm run build
```

### 4.3 Test Build Locally
```bash
npm run preview
```

### 4.4 Deploy
Deploy to your hosting platform (Vercel, Netlify, etc.)

**Status**: [ ] Complete

---

## Verification Checklist

After deployment, verify:

- [ ] Users can sign up and log in
- [ ] Placement test works
- [ ] Users can purchase tests (demo mode)
- [ ] Audio plays for listening questions (if implemented)
- [ ] Voice recorder works for speaking questions
- [ ] Writing questions accept text input
- [ ] Test submission works
- [ ] AI evaluation runs in background
- [ ] Results page shows AI feedback
- [ ] Scores are calculated correctly
- [ ] All question types display properly

---

## Troubleshooting

### AI Feedback Not Appearing
1. Check browser console for errors
2. Verify Edge Functions are deployed
3. Check function logs: `supabase functions logs evaluate-writing`
4. Verify OpenAI API key is set

### Voice Recorder Not Working
1. Check browser permissions for microphone
2. Test in different browsers
3. Check console for errors
4. Verify HTTPS (required for microphone access)

### Audio Not Playing
1. Verify audio_url exists in database
2. Check storage bucket is public
3. Test audio URL directly in browser
4. Check browser console for errors

---

## Performance Tips

1. **Lazy Load Components**: Import VoiceRecorder and AIFeedback dynamically
2. **Optimize Audio**: Use compressed MP3 files
3. **Cache Evaluations**: Don't re-evaluate same answer
4. **Background Processing**: AI evaluation runs async, doesn't block UI

---

## Cost Monitoring

After integration, monitor:
- OpenAI usage: https://platform.openai.com/usage
- Supabase function invocations
- Storage usage (if using audio)

Expected costs:
- $1.44 per user (2 tests)
- 79% profit margin at KES 500/test

---

## Next Steps After Integration

1. [ ] Test with real users
2. [ ] Collect feedback on AI evaluations
3. [ ] Monitor costs and adjust if needed
4. [ ] Add more questions if needed
5. [ ] Implement M-Pesa production mode
6. [ ] Add email notifications
7. [ ] Create admin dashboard enhancements

---

## Support

If you get stuck:
1. Check the relevant documentation
2. Review function logs
3. Test with curl commands
4. Check browser console

You've got this! 🚀
