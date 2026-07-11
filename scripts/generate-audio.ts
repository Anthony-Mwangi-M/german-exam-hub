/**
 * Audio Generation Script for Listening Questions
 * 
 * This script generates audio files for all listening questions using Google Cloud TTS.
 * Run with: npx tsx scripts/generate-audio.ts
 * 
 * Prerequisites:
 * 1. Install dependencies: npm install @google-cloud/text-to-speech
 * 2. Set up Google Cloud credentials
 * 3. Set environment variables in .env
 */

import { TextToSpeechClient } from '@google-cloud/text-to-speech';
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';

const SUPABASE_URL = process.env.VITE_SUPABASE_URL!;
const SUPABASE_KEY = process.env.VITE_SUPABASE_ANON_KEY!;
const GOOGLE_CREDENTIALS_PATH = process.env.GOOGLE_APPLICATION_CREDENTIALS;

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);
const ttsClient = new TextToSpeechClient({
  keyFilename: GOOGLE_CREDENTIALS_PATH
});

// Create audio directory if it doesn't exist
const audioDir = path.join(process.cwd(), 'audio');
if (!fs.existsSync(audioDir)) {
  fs.mkdirSync(audioDir, { recursive: true });
}

async function generateAudio(text: string, filename: string): Promise<string> {
  console.log(`Generating audio for: ${filename}`);

  const request = {
    input: { text },
    voice: {
      languageCode: 'de-DE',
      name: 'de-DE-Wavenet-D', // Natural female voice
      ssmlGender: 'FEMALE' as const
    },
    audioConfig: {
      audioEncoding: 'MP3' as const,
      speakingRate: 0.9, // Slightly slower for learners
      pitch: 0
    }
  };

  const [response] = await ttsClient.synthesizeSpeech(request);
  
  if (!response.audioContent) {
    throw new Error('No audio content received');
  }

  // Save locally
  const localPath = path.join(audioDir, filename);
  fs.writeFileSync(localPath, response.audioContent as Buffer);
  console.log(`Saved locally: ${localPath}`);

  // Upload to Supabase Storage
  const fileBuffer = fs.readFileSync(localPath);
  const { data, error } = await supabase.storage
    .from('audio')
    .upload(filename, fileBuffer, {
      contentType: 'audio/mpeg',
      upsert: true
    });

  if (error) {
    console.error(`Upload error for ${filename}:`, error);
    throw error;
  }

  const publicUrl = `${SUPABASE_URL}/storage/v1/object/public/audio/${filename}`;
  console.log(`Uploaded to: ${publicUrl}`);
  
  return publicUrl;
}

async function main() {
  console.log('Starting audio generation...\n');

  // Get all listening questions (multiple_choice type)
  const { data: questions, error } = await supabase
    .from('questions')
    .select(`
      id,
      question_text,
      test_module:test_modules(
        id,
        title,
        skill:skills(code)
      )
    `)
    .eq('question_type', 'multiple_choice');

  if (error) {
    console.error('Error fetching questions:', error);
    return;
  }

  if (!questions || questions.length === 0) {
    console.log('No listening questions found');
    return;
  }

  console.log(`Found ${questions.length} listening questions\n`);

  let successCount = 0;
  let errorCount = 0;

  for (const question of questions) {
    try {
      const filename = `listening_${question.id}.mp3`;
      const audioUrl = await generateAudio(question.question_text, filename);

      // Update question with audio URL
      const { error: updateError } = await supabase
        .from('questions')
        .update({ audio_url: audioUrl })
        .eq('id', question.id);

      if (updateError) {
        console.error(`Failed to update question ${question.id}:`, updateError);
        errorCount++;
      } else {
        console.log(`✓ Successfully processed: ${filename}\n`);
        successCount++;
      }

      // Add delay to avoid rate limiting
      await new Promise(resolve => setTimeout(resolve, 1000));

    } catch (error) {
      console.error(`Error processing question ${question.id}:`, error);
      errorCount++;
    }
  }

  console.log('\n=== Summary ===');
  console.log(`Total questions: ${questions.length}`);
  console.log(`Successful: ${successCount}`);
  console.log(`Failed: ${errorCount}`);
}

main().catch(console.error);
