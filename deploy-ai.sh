#!/bin/bash

# DeutschPrep AI Integration Deployment Script
# DEFERRED for v1 — manual instructor grading only.

set -e

if [ "${AI_EVALUATION_ENABLED:-false}" != "true" ]; then
    echo "AI evaluation is disabled for v1 (manual instructor grading)."
    echo "To deploy later: export AI_EVALUATION_ENABLED=true && ./deploy-ai.sh"
    exit 1
fi

echo "🚀 DeutschPrep AI Integration Deployment"
echo "========================================"
echo ""

# Check if OpenAI API key is set
if [ -z "$OPENAI_API_KEY" ]; then
    echo "❌ Error: OPENAI_API_KEY environment variable is not set"
    echo ""
    echo "Please set your OpenAI API key:"
    echo "  export OPENAI_API_KEY=sk-your-key-here"
    echo ""
    echo "Or add it to your .env file"
    exit 1
fi

echo "✅ OpenAI API key found"
echo ""

# Set Supabase secret
echo "📝 Setting Supabase secret..."
supabase secrets set OPENAI_API_KEY="$OPENAI_API_KEY"
echo "✅ Secret set successfully"
echo ""

# Run database migration
echo "🗄️  Running database migration..."
supabase db push
echo "✅ Database migration complete"
echo ""

# Deploy evaluate-writing function
echo "📤 Deploying evaluate-writing function..."
supabase functions deploy evaluate-writing
echo "✅ evaluate-writing deployed"
echo ""

# Deploy evaluate-speaking function
echo "📤 Deploying evaluate-speaking function..."
supabase functions deploy evaluate-speaking
echo "✅ evaluate-speaking deployed"
echo ""

# Test the functions
echo "🧪 Testing functions..."
echo ""

# Get Supabase URL and anon key from .env
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi

if [ -z "$VITE_SUPABASE_URL" ] || [ -z "$VITE_SUPABASE_ANON_KEY" ]; then
    echo "⚠️  Warning: Could not find Supabase credentials in .env"
    echo "Please test the functions manually"
else
    echo "Testing evaluate-writing..."
    curl -X POST "$VITE_SUPABASE_URL/functions/v1/evaluate-writing" \
      -H "Authorization: Bearer $VITE_SUPABASE_ANON_KEY" \
      -H "Content-Type: application/json" \
      -d '{
        "answerId": "test-id",
        "answerText": "Ich bin Student und lerne Deutsch seit zwei Jahren. Ich finde die Sprache sehr interessant.",
        "questionText": "Stellen Sie sich vor",
        "level": "A2"
      }' \
      --silent --show-error || echo "⚠️  Test failed - check function logs"
    
    echo ""
    echo "✅ Function test complete"
fi

echo ""
echo "========================================"
echo "🎉 AI Integration Deployment Complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "1. Update frontend components (see AI_IMPLEMENTATION_STEPS.md)"
echo "2. Test with real users"
echo "3. Monitor costs at https://platform.openai.com/usage"
echo ""
echo "Check function logs:"
echo "  supabase functions logs evaluate-writing"
echo "  supabase functions logs evaluate-speaking"
echo ""
echo "Cost per user: \$1.44 (79% profit margin at KES 500/test)"
echo ""
