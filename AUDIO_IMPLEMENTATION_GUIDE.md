# Audio Implementation Guide (Optional)

## Overview

Adding audio to listening questions enhances realism but is not required for launch.

## Option 1: Text-to-Speech (Quick & Cheap)

### Using Google Cloud TTS

```javascript
// Node.js script to generate audio
const textToSpeech = require('@google-cloud/text-to-speech');
const fs = require('fs');

async function generateAudio(text, filename) {
  const client = new textToSpeech.TextToSpeechClient();
  
  const request = {
    input: { text },
    voice: { 
      languageCode: 'de-DE',
      name: 'de-DE-Wavenet-D' // Natural-sounding voice
    },
    audioConfig: { audioEncoding: 'MP3' },
  };

  const [response] = await client.synthesizeSpeech(request);
  fs.writeFileSync(filename, response.audioContent, 'binary');
}

// Generate for all listening questions
const questions = [
  { id: 1, text: "Guten Morgen! Wie geht es Ihnen?" },
  // ... all 40 listening questions
];

questions.forEach(q => {
  generateAudio(q.text, `audio/listening_${q.id}.mp3`);
});
```

**Cost:** ~$4 per 1 million characters (very cheap)

### Using Amazon Polly

```javascript
const AWS = require('aws-sdk');
const polly = new AWS.Polly();

async function generateAudio(text, filename) {
  const params = {
    Text: text,
    OutputFormat: 'mp3',
    VoiceId: 'Vicki', // German female voice
    Engine: 'neural' // More natural
  };

  const data = await polly.synthesizeSpeech(params).promise();
  fs.writeFileSync(filename, data.AudioStream);
}
```

**Cost:** ~$4 per 1 million characters

## Option 2: Professional Recording (Best Quality)

### Finding Voice Talent

**Platforms:**
- Fiverr: $50-150 for 40 short recordings
- Upwork: $100-300 for professional
- Voices.com: $200-500 for high quality

**Requirements:**
- Native German speaker
- Clear pronunciation
- Standard German (Hochdeutsch)
- Good recording equipment

### Recording Specifications

- **Format:** MP3
- **Bitrate:** 128 kbps (good quality, small size)
- **Sample Rate:** 44.1 kHz
- **Mono:** (not stereo, saves space)
- **Length:** 5-30 seconds per question

## Implementation Steps

### Step 1: Generate/Record Audio Files

Create 40 audio files for listening questions:
- A1: 5 files
- A2: 10 files
- B1: 10 files
- B2: 10 files

### Step 2: Upload to Supabase Storage

```bash
# Create storage bucket
supabase storage create audio

# Set public access
supabase storage update audio --public true

# Upload files
supabase storage upload audio listening_a1_1.mp3
# ... repeat for all files
```

Or via Dashboard:
1. Go to Storage in Supabase
2. Create bucket "audio"
3. Make it public
4. Upload files

### Step 3: Update Database Schema

```sql
-- Add audio_url column to questions table
ALTER TABLE questions 
ADD COLUMN audio_url TEXT;

-- Update listening questions with audio URLs
UPDATE questions 
SET audio_url = 'https://your-project.supabase.co/storage/v1/object/public/audio/listening_a1_1.mp3'
WHERE id = 'question-id-here';
```

### Step 4: Update Frontend

**TakeTest.tsx:**

```tsx
// Add audio player for listening questions
{question.question_type === 'multiple_choice' && 
 question.audio_url && (
  <div className="mb-4">
    <audio 
      controls 
      className="w-full"
      src={question.audio_url}
    >
      Your browser does not support audio.
    </audio>
    <p className="text-sm text-muted-foreground mt-2">
      Sie können die Aufnahme mehrmals anhören.
    </p>
  </div>
)}

<p className="text-lg mb-4">{question.question_text}</p>
```

### Step 5: Test

1. Upload one test audio file
2. Update one question with audio_url
3. Take that test
4. Verify audio plays correctly
5. Roll out to all listening questions

## Cost Estimate

### Text-to-Speech
- Google/Amazon TTS: ~$5 total
- Time: 1-2 hours to generate all files
- Quality: Good (7/10)

### Professional Recording
- Fiverr: $50-150
- Time: 1-2 days turnaround
- Quality: Excellent (9/10)

### Hybrid Approach
- Use TTS for A1/A2 (simpler content): $2
- Professional for B1/B2 (complex content): $100
- Total: ~$100
- Quality: Mixed (8/10 average)

## Recommendation

**For MVP Launch:**
- Skip audio initially
- Launch with text-based listening
- Add audio in Phase 2 based on user feedback

**If Adding Audio:**
- Use TTS for quick implementation
- Upgrade to professional later if needed
- Start with A1 level only, expand gradually

## Alternative: Hybrid Approach

Keep text-based questions but add audio as optional:

```tsx
<div className="mb-4">
  <p className="text-lg mb-2">
    {question.question_text}
  </p>
  {question.audio_url && (
    <details className="mt-2">
      <summary className="cursor-pointer text-sm text-primary">
        🎧 Audio anhören (optional)
      </summary>
      <audio controls className="w-full mt-2" src={question.audio_url} />
    </details>
  )}
</div>
```

This way:
- Platform works without audio
- Audio enhances experience when available
- You can add audio gradually

## Storage Considerations

**File Sizes:**
- 5-10 seconds: ~100 KB
- 10-20 seconds: ~200 KB
- 20-30 seconds: ~300 KB

**Total Storage:**
- 40 files × 200 KB average = 8 MB
- Negligible cost on Supabase (1 GB free)

## Conclusion

Audio is a nice enhancement but NOT required for launch. The platform is fully functional with text-based listening questions, which is industry-standard for practice tests.

**Launch Priority:**
1. ✅ Launch with current content (text-based)
2. Get users and feedback
3. Add audio if users request it
4. Start with TTS, upgrade to professional if needed

You can always add audio later as a "platform update" to re-engage users!
