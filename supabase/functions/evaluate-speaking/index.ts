import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { aiEvaluationDisabledResponse, handleAiEvaluationCors } from "../_shared/ai-evaluation.ts";

const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY');
const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;

interface SpeakingEvaluationRequest {
  answerId: string;
  audioBase64: string;
  questionText: string;
  level: string;
}

serve(async (req) => {
  const corsResponse = handleAiEvaluationCors(req);
  if (corsResponse) return corsResponse;

  const disabledResponse = aiEvaluationDisabledResponse();
  if (disabledResponse) return disabledResponse;

  try {
    const { answerId, audioBase64, questionText, level }: SpeakingEvaluationRequest = await req.json();

    console.log('Received speaking evaluation request:', { answerId, questionText, level, audioLength: audioBase64?.length });

    if (!answerId || !audioBase64 || !questionText || !level) {
      console.error('Missing required fields');
      return new Response(
        JSON.stringify({ error: 'Missing required fields' }),
        { status: 400, headers: { 'Content-Type': 'application/json' } }
      );
    }

    if (!OPENAI_API_KEY) {
      console.error('OpenAI API key not configured');
      return new Response(
        JSON.stringify({ error: 'OpenAI API key not configured' }),
        { status: 500, headers: { 'Content-Type': 'application/json' } }
      );
    }

    console.log('Converting audio...');
    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

    // Step 1: Convert speech to text using Whisper
    const audioBuffer = Uint8Array.from(atob(audioBase64), c => c.charCodeAt(0));
    const audioBlob = new Blob([audioBuffer], { type: 'audio/webm' });
    
    const formData = new FormData();
    formData.append('file', audioBlob, 'audio.webm');
    formData.append('model', 'whisper-1');
    formData.append('language', 'de');

    const transcriptionResponse = await fetch('https://api.openai.com/v1/audio/transcriptions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OPENAI_API_KEY}`,
      },
      body: formData
    });

    if (!transcriptionResponse.ok) {
      const error = await transcriptionResponse.text();
      console.error('Whisper API error:', error);
      console.error('Response status:', transcriptionResponse.status);
      return new Response(
        JSON.stringify({ error: 'Failed to transcribe audio', details: error }),
        { status: 500, headers: { 'Content-Type': 'application/json' } }
      );
    }

    console.log('Transcription successful');
    const { text: transcription } = await transcriptionResponse.json();
    console.log('Transcribed text:', transcription);

    // Step 2: Evaluate the transcribed text
    console.log('Calling OpenAI for evaluation...');
    const evaluationResponse = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OPENAI_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini',
        messages: [
          {
            role: 'system',
            content: `Du bist ein erfahrener Deutschlehrer, der mündliche Antworten auf ${level}-Niveau nach CEFR-Standards bewertet.

Bewerte die folgende transkribierte Antwort nach diesen Kriterien:
1. Grammatik (0-100): Korrektheit der Grammatik
2. Wortschatz (0-100): Angemessenheit und Vielfalt für ${level}
3. Struktur (0-100): Kohärenz und logischer Aufbau
4. Inhalt (0-100): Relevanz und Vollständigkeit
5. Flüssigkeit (0-100): Basierend auf Satzlänge und Komplexität

Antworte im folgenden JSON-Format:
{
  "grammar": {
    "score": 0-100,
    "errors": ["Fehler 1", "Fehler 2"],
    "suggestions": ["Korrektur 1", "Korrektur 2"]
  },
  "vocabulary": {
    "score": 0-100,
    "level": "A1-C2",
    "advanced_words": ["Wort 1", "Wort 2"],
    "suggestions": ["Bessere Alternative 1"]
  },
  "structure": {
    "score": 0-100,
    "coherence": "Feedback zur Kohärenz",
    "organization": "Feedback zur Organisation"
  },
  "content": {
    "score": 0-100,
    "relevance": "Feedback zur Relevanz",
    "completeness": "Feedback zur Vollständigkeit"
  },
  "fluency": {
    "score": 0-100,
    "feedback": "Feedback zur Flüssigkeit"
  },
  "overall_score": 0-100,
  "cefr_level": "A1-C2",
  "feedback": "Detailliertes Feedback auf Deutsch (3-5 Sätze)"
}`
          },
          {
            role: 'user',
            content: `Aufgabe: ${questionText}\n\nTranskribierte Antwort:\n${transcription}`
          }
        ],
        response_format: { type: "json_object" },
        temperature: 0.3,
      }),
    });

    if (!evaluationResponse.ok) {
      const error = await evaluationResponse.text();
      console.error('OpenAI evaluation error:', error);
      console.error('Response status:', evaluationResponse.status);
      return new Response(
        JSON.stringify({ error: 'Failed to evaluate speech', details: error }),
        { status: 500, headers: { 'Content-Type': 'application/json' } }
      );
    }

    const evaluation = await evaluationResponse.json();
    const result = JSON.parse(evaluation.choices[0].message.content);

    // Store evaluation in ai_evaluations table
    const { error: evalError } = await supabase.from('ai_evaluations').insert({
      test_answer_id: answerId,
      evaluation_type: 'speaking',
      raw_response: result,
      grammar_score: result.grammar.score,
      vocabulary_score: result.vocabulary.score,
      structure_score: result.structure.score,
      content_score: result.content.score,
      overall_score: result.overall_score,
      cefr_level: result.cefr_level,
      feedback: result.feedback,
      transcription: transcription
    });

    if (evalError) {
      console.error('Database error:', evalError);
      return new Response(
        JSON.stringify({ error: 'Failed to store evaluation' }),
        { status: 500, headers: { 'Content-Type': 'application/json' } }
      );
    }

    // Update test_answers table
    const { error: updateError } = await supabase.from('test_answers').update({
      ai_evaluation: result,
      ai_score: result.overall_score,
      ai_feedback: result.feedback,
      user_answer: transcription, // Store transcription as the answer
      evaluated_at: new Date().toISOString()
    }).eq('id', answerId);

    if (updateError) {
      console.error('Update error:', updateError);
    }

    return new Response(JSON.stringify({
      ...result,
      transcription
    }), {
      headers: { 
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    });

  } catch (error) {
    console.error('Error:', error);
    return new Response(
      JSON.stringify({ error: error.message || 'Internal server error' }),
      { status: 500, headers: { 'Content-Type': 'application/json' } }
    );
  }
});
