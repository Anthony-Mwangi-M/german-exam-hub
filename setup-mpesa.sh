#!/bin/bash

# M-Pesa Setup Script for DeutschPrep
# This script helps you configure and deploy M-Pesa integration

echo "🚀 DeutschPrep M-Pesa Setup"
echo "============================"
echo ""

# Check if Supabase CLI is installed
if ! command -v supabase &> /dev/null; then
    echo "❌ Supabase CLI is not installed."
    echo ""
    echo "Install it with:"
    echo "  npm install -g supabase"
    echo "  or"
    echo "  brew install supabase/tap/supabase"
    echo ""
    exit 1
fi

echo "✅ Supabase CLI is installed"
echo ""

# Check if logged in
echo "Checking Supabase login status..."
if ! supabase projects list &> /dev/null; then
    echo "❌ Not logged in to Supabase"
    echo ""
    echo "Please run: supabase login"
    echo ""
    exit 1
fi

echo "✅ Logged in to Supabase"
echo ""

# Prompt for M-Pesa credentials
echo "📝 Enter your M-Pesa Daraja API credentials:"
echo "(Get these from https://developer.safaricom.co.ke/)"
echo ""

read -p "Consumer Key: " CONSUMER_KEY
read -p "Consumer Secret: " CONSUMER_SECRET
read -p "Passkey: " PASSKEY
read -p "Shortcode (default: 174379 for sandbox): " SHORTCODE
SHORTCODE=${SHORTCODE:-174379}

read -p "Environment (sandbox/production, default: sandbox): " ENVIRONMENT
ENVIRONMENT=${ENVIRONMENT:-sandbox}

echo ""
echo "🔐 Setting Supabase secrets..."

# Set secrets
supabase secrets set MPESA_CONSUMER_KEY="$CONSUMER_KEY"
supabase secrets set MPESA_CONSUMER_SECRET="$CONSUMER_SECRET"
supabase secrets set MPESA_PASSKEY="$PASSKEY"
supabase secrets set MPESA_SHORTCODE="$SHORTCODE"
supabase secrets set MPESA_ENVIRONMENT="$ENVIRONMENT"

if [ $? -eq 0 ]; then
    echo "✅ Secrets configured successfully"
else
    echo "❌ Failed to set secrets"
    exit 1
fi

echo ""
echo "📦 Deploying Edge Functions..."

# Deploy functions
supabase functions deploy mpesa-stk-push
if [ $? -ne 0 ]; then
    echo "❌ Failed to deploy mpesa-stk-push"
    exit 1
fi

supabase functions deploy mpesa-callback
if [ $? -ne 0 ]; then
    echo "❌ Failed to deploy mpesa-callback"
    exit 1
fi

supabase functions deploy mpesa-query
if [ $? -ne 0 ]; then
    echo "❌ Failed to deploy mpesa-query"
    exit 1
fi

echo ""
echo "✅ All functions deployed successfully!"
echo ""
echo "🎉 M-Pesa integration is ready!"
echo ""
echo "Next steps:"
echo "1. Run migration 014 in Supabase SQL Editor"
echo "2. Test with sandbox number: 254708374149"
echo "3. Check logs: supabase functions logs mpesa-stk-push --tail"
echo ""
echo "📚 Documentation:"
echo "  - Quick Start: docs/MPESA_QUICK_START.md"
echo "  - Full Guide: docs/MPESA_SETUP_GUIDE.md"
echo ""
