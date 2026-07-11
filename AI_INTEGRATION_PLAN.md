# AI Integration Plan - Fully Automated Platform

## Overview

Transform DeutschPrep into a fully AI-powered platform with:
1. **AI-generated audio** for listening tests
2. **AI grading** for writing tests
3. **AI evaluation** for speaking tests
4. **Automated feedback** for all question types

## Architecture

```
User Answer → Supabase Edge Function → OpenAI API → Evaluation → Database → User Feedback
```

## 1. AI Audio Generation (Text-to-Speech)

### Option A: OpenAI TTS (Recommended)
**Pros:** Natural voices, good German support, simple API  
**Cost:** $15 per 1M characters (~$0.60 for all 40 listening questions)

### Option B: Google Cloud TTS
**Pros:** Excellent German voices (Wavenet), cheaper  
**Cost:** $4 per 1M characters (~$0.16 for all questions)

### Option C: ElevenLabs
**Pros:** Most natural voices, emotion control  
**Cost:** $5-22/month subscription

### Implementation Strategy

**Approach 1: Pre-generate all audio (Recommended)**
- Generate 40 audio files once
- Upload to Supabase Storage
- No runtime costs
- Consistent quality

**Approach 2: Generate on-demand**
- Generate audio when question is accessed
- Cache in storage
- Flexible but slower first load

## 2. AI Writing Evaluation

### Using OpenAI GPT-4

**Capabilities:**
- Grammar checking
- Vocabulary assessment
- Structure analysis
- CEFR level evaluation
- Detailed feedback in German

**Cost:** ~$0.03 per essay evaluation

### Evaluation Criteria

```json
{
  "grammar": {
    "score": 0-100,
    "errors": ["list of errors"],
    "suggestions": ["corrections"]
  },
  "vocabulary": {
    "score": 0-100,
    "level": "A1-C2",
    "advanced_words": ["list"],
    "suggestions": ["better alternatives"]
  },
  "structure": {
    "score": 0-100,
    "coherence": "feedback",
    "organization": "feedback"
  },
  "content": {
    "score": 0-100,
    "relevance": "feedback",
    "completeness": "feedback"
  },
  "overall_score": 0-100,
  "cefr_level": "A1-C2",
  "feedback": "detailed feedback in German"
}
```

## 3. AI Speaking Evaluation

### Two-Step Process

**Step 1: Speech-to-Text**
- OpenAI Whisper API
- Converts voice to text
- Supports German
- Cost: $0.006 per minute

**Step 2: Text Evaluation**
- Same as writing evaluation
- Plus pronunciation feedback (if needed)
- Fluency assessment

### Additional: Pronunciation Analysis
- Use Azure Speech Services
- Provides pronunciation scores
- Cost: $1 per 1000 transactions

## 4. Implementation Plan

### Phase 1: Audio Generation (Week 1)

**Tasks:**
1. Choose TTS provider (recommend Google Cloud)
2. Create generation script
3. Generate all 40 audio files
4. Upload to Supabase Storage
5. Update database with audio URLs
6. Update frontend to play audio

**Deliverables:**
- 40 MP3 files
- Updated questions table
- Audio player in TakeTest component

### Phase 2: Writing Evaluation (Week 2)

**Tasks:**
1. Create Supabase Edge Function for evaluation
2. Integrate OpenAI API
3. Design evaluation rubric
4. Update TestResults page to show AI feedback
5. Store evaluations in database

**Deliverables:**
- `evaluate-writing` Edge Function
- AI feedback display
- Evaluation history

### Phase 3: Speaking Evaluation (Week 3)

**Tasks:**
1. Add voice recording to frontend
2. Create speech-to-text Edge Function
3. Integrate with writing evaluation
4. Add pronunciation scoring (optional)
5. Display comprehensive feedback

**Deliverables:**
- Voice recorder component
- `evaluate-speaking` Edge Function
- Speech-to-text conversion
- Pronunciation feedback

## 5. Cost Analysis

### Monthly Costs (Estimated)

**Assumptions:**
- 100 users/month
- Each user takes 2 tests
- 200 total test attempts/month

**Audio (One-time):**
- Pre-generate 40 files: $0.16-0.60 (one-time)
- Storage: Free (8MB total)

**Writing Evaluation:**
- 200 attempts × 10 writing questions = 2000 evaluations
- 2000 × $0.03 = $60/month

**Speaking Evaluation:**
- 200 attempts × 10 speaking questions = 2000 evaluations
- Speech-to-text: 2000 × 2 min × $0.006 = $24/month
- Text evaluation: 2000 × $0.03 = $60/month
- Total: $84/month

**Total Monthly AI Costs:**
- Writing: $60
- Speaking: $84
- **Total: $144/month for 100 users**
- **Per user: $1.44**

**With 500 users:** ~$720/month ($1.44/user)  
**With 1000 users:** ~$1,440/month ($1.44/user)

### Revenue vs Cost

If you charge KES 500 ($3.50) per test:
- Revenue per user (2 tests): $7
- AI cost per user: $1.44
- **Profit margin: 79%** (before other costs)

## 6. Technical Implementation

### Database Schema Updates

```sql
-- Add AI evaluation fields
ALTER TABLE test_answers 
ADD COLUMN ai_evaluation JSONB,
ADD COLUMN ai_score INTEGER,
ADD COLUMN ai_feedback TEXT,
ADD COLUMN evaluated_at TIMESTAMPTZ;

-- Add audio URLs
ALTER TABLE questions 
ADD COLUMN audio_url TEXT;

-- Create evaluations table for detailed tracking
CREATE TABLE ai_evaluations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  test_answer_id UUID REFERENCES test_answers(id),
  evaluation_type TEXT, -- 'writing' or 'speaking'
  raw_response JSONB,
  grammar_score INTEGER,
  vocabulary_score INTEGER,
  structure_score INTEGER,
  content_score INTEGER,
  overall_score INTEGER,
  cefr_level TEXT,
  feedback TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### Edge Function: Evaluate Writing

```typescript
// supabase/functions/evaluate-writing/index.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY');

serve(async (req) => {
  const { answerId, answerText, questionText, level } = await req.json();
  
  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  );

  // Call OpenAI API
  const response = await fetch('https://api.openai.com/v1/chat/completions', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${OPENAI_API_KEY}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      model: 'gpt-4',
      messages: [
        {
          role: 'system',
          content: `Du bist ein erfahrener Deutschlehrer, der Texte auf ${level}-Niveau bewertet. 
          Bewerte den folgenden Text nach Grammatik, Wortschatz, Struktur und Inhalt. 
          Gib detailliertes Feedback auf Deutsch und eine Punktzahl (0-100) für jede Kategorie.
          Antworte im JSON-Format.`
        },
        {
          role: 'user',
          content: `Aufgabe: ${questionText}\n\nAntwort des Schülers:\n${answerText}`
        }
      ],
      response_format: { type: "json_object" }
    }),
  });

  const evaluation = await response.json();
  const result = JSON.parse(evaluation.choices[0].message.content);

  // Store evaluation
  await supabase.from('ai_evaluations').insert({
    test_answer_id: answerId,
    evaluation_type: 'writing',
    raw_response: result,
    grammar_score: result.grammar.score,
    vocabulary_score: result.vocabulary.score,
    structure_score: result.structure.score,
    content_score: result.content.score,
    overall_score: result.overall_score,
    cefr_level: result.cefr_level,
    feedback: result.feedback
  });

  // Update test answer
  await supabase.from('test_answers').update({
    ai_evaluation: result,
    ai_score: result.overall_score,
    ai_feedback: result.feedback,
    evaluated_at: new Date().toISOString()
  }).eq('id', answerId);

  return new Response(JSON.stringify(result), {
    headers: { 'Content-Type': 'application/json' }
  });
});
```

### Edge Function: Evaluate Speaking

```typescript
// supabase/functions/evaluate-speaking/index.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

serve(async (req) => {
  const { answerId, audioBlob, questionText, level } = await req.json();
  
  // Step 1: Convert speech to text using Whisper
  const formData = new FormData();
  formData.append('file', audioBlob);
  formData.append('model', 'whisper-1');
  formData.append('language', 'de');

  const transcription = await fetch('https://api.openai.com/v1/audio/transcriptions', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${OPENAI_API_KEY}`,
    },
    body: formData
  });

  const { text } = await transcription.json();

  // Step 2: Evaluate the transcribed text (same as writing)
  // ... (similar to evaluate-writing)

  // Step 3: Add speaking-specific feedback
  const speakingEvaluation = {
    transcription: text,
    fluency_score: calculateFluency(text),
    // ... other metrics
  };

  return new Response(JSON.stringify(speakingEvaluation));
});
```

### Frontend: Voice Recording

```tsx
// src/components/VoiceRecorder.tsx
import { useState, useRef } from 'react';
import { Button } from '@/components/ui/button';
import { Mic, Square, Play } from 'lucide-react';

export function VoiceRecorder({ onRecordingComplete }) {
  const [isRecording, setIsRecording] = useState(false);
  const [audioURL, setAudioURL] = useState('');
  const mediaRecorder = useRef(null);
  const audioChunks = useRef([]);

  const startRecording = async () => {
    const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
    mediaRecorder.current = new MediaRecorder(stream);
    
    mediaRecorder.current.ondataavailable = (event) => {
      audioChunks.current.push(event.data);
    };

    mediaRecorder.current.onstop = () => {
      const audioBlob = new Blob(audioChunks.current, { type: 'audio/wav' });
      const url = URL.createObjectURL(audioBlob);
      setAudioURL(url);
      onRecordingComplete(audioBlob);
      audioChunks.current = [];
    };

    mediaRecorder.current.start();
    setIsRecording(true);
  };

  const stopRecording = () => {
    mediaRecorder.current.stop();
    setIsRecording(false);
  };

  return (
    <div className="space-y-4">
      <div className="flex gap-2">
        {!isRecording ? (
          <Button onClick={startRecording}>
            <Mic className="mr-2 h-4 w-4" />
            Aufnahme starten
          </Button>
        ) : (
          <Button onClick={stopRecording} variant="destructive">
            <Square className="mr-2 h-4 w-4" />
            Aufnahme stoppen
          </Button>
        )}
      </div>

      {audioURL && (
        <div>
          <audio controls src={audioURL} className="w-full" />
        </div>
      )}
    </div>
  );
}
```

### Frontend: AI Feedback Display

```tsx
// src/components/AIFeedback.tsx
export function AIFeedback({ evaluation }) {
  return (
    <div className="space-y-4">
      <div className="grid grid-cols-2 gap-4">
        <ScoreCard title="Grammatik" score={evaluation.grammar.score} />
        <ScoreCard title="Wortschatz" score={evaluation.vocabulary.score} />
        <ScoreCard title="Struktur" score={evaluation.structure.score} />
        <ScoreCard title="Inhalt" score={evaluation.content.score} />
      </div>

      <div className="rounded-lg bg-blue-50 p-4">
        <h3 className="font-semibold mb-2">Gesamtbewertung</h3>
        <div className="text-3xl font-bold text-primary">
          {evaluation.overall_score}/100
        </div>
        <div className="text-sm text-muted-foreground">
          CEFR-Niveau: {evaluation.cefr_level}
        </div>
      </div>

      <div className="rounded-lg border p-4">
        <h3 className="font-semibold mb-2">Detailliertes Feedback</h3>
        <p className="text-sm whitespace-pre-wrap">{evaluation.feedback}</p>
      </div>

      {evaluation.grammar.errors?.length > 0 && (
        <div className="rounded-lg border p-4">
          <h3 className="font-semibold mb-2">Grammatikfehler</h3>
          <ul className="list-disc list-inside space-y-1">
            {evaluation.grammar.errors.map((error, i) => (
              <li key={i} className="text-sm">{error}</li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}
```

## 7. Audio Generation Script

```typescript
// scripts/generate-audio.ts
import fs from 'fs';
import path from 'path';
import { createClient } from '@supabase/supabase-js';

const GOOGLE_TTS_API_KEY = process.env.GOOGLE_TTS_API_KEY;
const supabase = createClient(process.env.SUPABASE_URL!, process.env.SUPABASE_KEY!);

async function generateAudio(text: string, filename: string) {
  const response = await fetch(
    `https://texttospeech.googleapis.com/v1/text:synthesize?key=${GOOGLE_TTS_API_KEY}`,
    {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        input: { text },
        voice: {
          languageCode: 'de-DE',
          name: 'de-DE-Wavenet-D',
          ssmlGender: 'FEMALE'
        },
        audioConfig: {
          audioEncoding: 'MP3',
          speakingRate: 0.9, // Slightly slower for learners
          pitch: 0
        }
      })
    }
  );

  const { audioContent } = await response.json();
  const buffer = Buffer.from(audioContent, 'base64');
  
  // Save locally
  fs.writeFileSync(path.join('audio', filename), buffer);
  
  // Upload to Supabase Storage
  const { data, error } = await supabase.storage
    .from('audio')
    .upload(filename, buffer, {
      contentType: 'audio/mpeg',
      upsert: true
    });

  if (error) throw error;
  
  return `${process.env.SUPABASE_URL}/storage/v1/object/public/audio/${filename}`;
}

// Get all listening questions
const { data: questions } = await supabase
  .from('questions')
  .select('id, question_text')
  .eq('question_type', 'multiple_choice')
  .in('test_module_id', /* listening module IDs */);

// Generate audio for each
for (const question of questions) {
  const filename = `listening_${question.id}.mp3`;
  const audioUrl = await generateAudio(question.question_text, filename);
  
  // Update question with audio URL
  await supabase
    .from('questions')
    .update({ audio_url: audioUrl })
    .eq('id', question.id);
  
  console.log(`Generated: ${filename}`);
}
```

## 8. Environment Variables

Add to `.env`:

```env
# OpenAI
OPENAI_API_KEY=sk-...

# Google Cloud (for TTS)
GOOGLE_TTS_API_KEY=...

# Or ElevenLabs
ELEVENLABS_API_KEY=...
```

Add to Supabase secrets:

```bash
supabase secrets set OPENAI_API_KEY=sk-...
supabase secrets set GOOGLE_TTS_API_KEY=...
```

## 9. Implementation Timeline

**Week 1: Audio Generation**
- Day 1-2: Set up TTS API, generate audio
- Day 3-4: Upload to storage, update database
- Day 5: Update frontend, test

**Week 2: Writing Evaluation**
- Day 1-2: Create Edge Function
- Day 3-4: Design evaluation rubric, test
- Day 5: Update UI, integrate

**Week 3: Speaking Evaluation**
- Day 1-2: Add voice recording
- Day 3-4: Speech-to-text integration
- Day 5: Complete evaluation flow

**Week 4: Testing & Polish**
- Comprehensive testing
- Cost optimization
- Performance tuning
- User feedback collection

## 10. Cost Optimization Strategies

1. **Cache evaluations** - Don't re-evaluate same answer
2. **Use GPT-3.5** for simpler levels (A1/A2) - 10x cheaper
3. **Batch processing** - Evaluate multiple answers together
4. **Rate limiting** - Prevent abuse
5. **Pre-generate audio** - One-time cost
6. **Compress audio** - Reduce storage/bandwidth

## 11. Quality Assurance

- Spot-check AI evaluations against human grading
- Collect user feedback on AI accuracy
- Continuously refine prompts
- A/B test different evaluation approaches
- Monitor evaluation consistency

## Next Steps

1. **Choose TTS provider** (recommend Google Cloud)
2. **Set up OpenAI account** and get API key
3. **Generate audio files** (one-time task)
4. **Implement writing evaluation** (highest value)
5. **Add speaking evaluation** (complete automation)

Would you like me to implement any of these components now?
