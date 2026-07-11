import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { aiEvaluationDisabledResponse, handleAiEvaluationCors } from "../_shared/ai-evaluation.ts";

const OPENAI_API_KEY = Deno.env.get('OPENAI_API_KEY');
const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;

interface EvaluationRequest {
  answerId: string;
  answerText: string;
  questionText: string;
  level: string;
}

serve(async (req) => {
  const corsResponse = handleAiEvaluationCors(req);
  if (corsResponse) return corsResponse;

  const disabledResponse = aiEvaluationDisabledResponse();
  if (disabledResponse) return disabledResponse;

  try {
    const { answerId, answerText, questionText, level }: EvaluationRequest = await req.json();

    console.log('Received request:', { answerId, answerText: answerText?.substring(0, 50), questionText, level });

    if (!answerId || !answerText || !questionText || !level) {
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

    console.log('Calling OpenAI API...');

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

    // Call OpenAI API
    const response = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OPENAI_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: 'gpt-4o-mini', // More cost-effective
        messages: [
          {
            role: 'system',
            content: `Du bist ein erfahrener Deutschlehrer, der Texte auf ${level}-Niveau nach CEFR-Standards bewertet.

Bewerte den folgenden Text nach diesen Kriterien:
1. Grammatik (0-100): Korrektheit der Grammatik, Satzbau
2. Wortschatz (0-100): Angemessenheit und Vielfalt des Wortschatzes für ${level}
3. Struktur (0-100): Kohärenz, Organisation, logischer Aufbau
4. Inhalt (0-100): Relevanz, Vollständigkeit, Tiefe der Antwort

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
  "overall_score": 0-100,
  "cefr_level": "A1-C2",
  "feedback": "Detailliertes Feedback auf Deutsch (3-5 Sätze)"
}`
          },
          {
            role: 'user',
            content: `Aufgabe: ${questionText}\n\nAntwort des Schülers:\n${answerText}`
          }
        ],
        response_format: { type: "json_object" },
        temperature: 0.3, // More consistent evaluations
      }),
    });

    if (!response.ok) {
      const error = await response.text();
      console.error('OpenAI API error:', error);
      console.error('Response status:', response.status);
      return new Response(
        JSON.stringify({ error: 'Failed to evaluate text', details: error }),
        { status: 500, headers: { 'Content-Type': 'application/json' } }
      );
    }

    console.log('OpenAI API call successful');
    const evaluation = await response.json();
    console.log('Evaluation received:', evaluation);
    const result = JSON.parse(evaluation.choices[0].message.content);

    // Store evaluation in ai_evaluations table
    const { error: evalError } = await supabase.from('ai_evaluations').insert({
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
      evaluated_at: new Date().toISOString()
    }).eq('id', answerId);

    if (updateError) {
      console.error('Update error:', updateError);
    }

    return new Response(JSON.stringify(result), {
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
