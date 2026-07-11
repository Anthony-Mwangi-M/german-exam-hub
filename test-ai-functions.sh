#!/bin/bash

# DEFERRED for v1 — manual instructor grading only.
if [ "${AI_EVALUATION_ENABLED:-false}" != "true" ]; then
    echo "AI evaluation is disabled. Set AI_EVALUATION_ENABLED=true to run these tests."
    exit 0
fi


# Test AI Evaluation Functions
# This script tests both writing and speaking evaluation functions

set -e

echo "🧪 Testing AI Evaluation Functions"
echo "=================================="
echo ""

# Load environment variables
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi

# Check required variables
if [ -z "$VITE_SUPABASE_URL" ] || [ -z "$VITE_SUPABASE_ANON_KEY" ]; then
    echo "❌ Error: Missing Supabase credentials"
    echo "Please set VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY in .env"
    exit 1
fi

echo "✅ Supabase credentials found"
echo ""

# Test 1: Writing Evaluation (A1 Level)
echo "📝 Test 1: Writing Evaluation (A1 Level)"
echo "----------------------------------------"
echo "Request:"
echo '{
  "answerId": "test-a1-writing",
  "answerText": "Ich heiße Maria. Ich bin 25 Jahre alt. Ich komme aus Kenia. Ich lerne Deutsch.",
  "questionText": "Stellen Sie sich vor (Name, Alter, Herkunft)",
  "level": "A1"
}'
echo ""

RESPONSE=$(curl -s -X POST "$VITE_SUPABASE_URL/functions/v1/evaluate-writing" \
  -H "Authorization: Bearer $VITE_SUPABASE_ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "answerId": "test-a1-writing",
    "answerText": "Ich heiße Maria. Ich bin 25 Jahre alt. Ich komme aus Kenia. Ich lerne Deutsch.",
    "questionText": "Stellen Sie sich vor (Name, Alter, Herkunft)",
    "level": "A1"
  }')

echo "Response:"
echo "$RESPONSE" | jq '.' 2>/dev/null || echo "$RESPONSE"
echo ""

if echo "$RESPONSE" | jq -e '.overall_score' > /dev/null 2>&1; then
    echo "✅ Test 1 PASSED"
else
    echo "❌ Test 1 FAILED"
fi
echo ""

# Test 2: Writing Evaluation (B1 Level)
echo "📝 Test 2: Writing Evaluation (B1 Level)"
echo "----------------------------------------"
echo "Request:"
echo '{
  "answerId": "test-b1-writing",
  "answerText": "Meiner Meinung nach ist es sehr wichtig, dass wir die Umwelt schützen. Wir sollten weniger Plastik verwenden und mehr recyceln. Außerdem könnten wir öffentliche Verkehrsmittel benutzen statt Auto zu fahren.",
  "questionText": "Was können wir für die Umwelt tun?",
  "level": "B1"
}'
echo ""

RESPONSE=$(curl -s -X POST "$VITE_SUPABASE_URL/functions/v1/evaluate-writing" \
  -H "Authorization: Bearer $VITE_SUPABASE_ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "answerId": "test-b1-writing",
    "answerText": "Meiner Meinung nach ist es sehr wichtig, dass wir die Umwelt schützen. Wir sollten weniger Plastik verwenden und mehr recyceln. Außerdem könnten wir öffentliche Verkehrsmittel benutzen statt Auto zu fahren.",
    "questionText": "Was können wir für die Umwelt tun?",
    "level": "B1"
  }')

echo "Response:"
echo "$RESPONSE" | jq '.' 2>/dev/null || echo "$RESPONSE"
echo ""

if echo "$RESPONSE" | jq -e '.overall_score' > /dev/null 2>&1; then
    echo "✅ Test 2 PASSED"
else
    echo "❌ Test 2 FAILED"
fi
echo ""

# Test 3: Error Handling
echo "🔍 Test 3: Error Handling (Missing Fields)"
echo "-------------------------------------------"
echo "Request:"
echo '{
  "answerId": "test-error"
}'
echo ""

RESPONSE=$(curl -s -X POST "$VITE_SUPABASE_URL/functions/v1/evaluate-writing" \
  -H "Authorization: Bearer $VITE_SUPABASE_ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "answerId": "test-error"
  }')

echo "Response:"
echo "$RESPONSE" | jq '.' 2>/dev/null || echo "$RESPONSE"
echo ""

if echo "$RESPONSE" | jq -e '.error' > /dev/null 2>&1; then
    echo "✅ Test 3 PASSED (Error handled correctly)"
else
    echo "❌ Test 3 FAILED (Should return error)"
fi
echo ""

# Summary
echo "=================================="
echo "📊 Test Summary"
echo "=================================="
echo ""
echo "Functions tested:"
echo "  ✓ evaluate-writing (A1 level)"
echo "  ✓ evaluate-writing (B1 level)"
echo "  ✓ Error handling"
echo ""
echo "Note: Speaking evaluation requires audio file,"
echo "      test it through the frontend interface."
echo ""
echo "To view function logs:"
echo "  supabase functions logs evaluate-writing"
echo "  supabase functions logs evaluate-speaking"
echo ""
echo "To monitor costs:"
echo "  https://platform.openai.com/usage"
echo ""
