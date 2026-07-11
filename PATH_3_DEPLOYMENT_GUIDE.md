# Path 3: Full Production Deployment Guide

## Overview
This guide walks you through the complete production deployment including AI integration, audio generation, and production M-Pesa setup.

**Estimated Time**: 2 hours  
**Result**: Fully automated, production-ready platform

---

## ✅ Prerequisites

- [ ] Supabase project created
- [ ] Node.js and npm installed
- [ ] Git repository set up
- [ ] Domain name (optional but recommended)

---

## Phase 1: Backend Setup (30 minutes)

### Step 1: Get API Keys (10 min)

#### OpenAI API Key
1. Visit https://platform.openai.com/api-keys
2. Click "Create new secret key"
3. Name it "DeutschPrep Production"
4. Copy the key (starts with `sk-`)
5. Save it securely

#### Google Cloud TTS (for audio)
1. Go to https://console.cloud.google.com
2. Create new project "DeutschPrep"
3. Enable "Cloud Text-to-Speech API"
4. Create service account:
   - IAM & Admin → Service Accounts
   - Create Service Account
   - Name: "deutschprep-tts"
   - Role: "Cloud Text-to-Speech User"
5. Create key (JSON format)
6. Download and save as `google-credentials.json`

#### M-Pesa Production Credentials (if ready)
1. Visit https://developer.safaricom.co.ke
2. Go to "My Apps"
3. Get production credentials:
   - Consumer Key
   - Consumer Secret
   - Shortcode
   - Passkey
4. Save securely

### Step 2: Configure Environment (5 min)

Create `.env` file:
```bash
# Supabase
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_anon_key

# OpenAI
OPENAI_API_KEY=sk-your-openai-key

# Google Cloud TTS
GOOGLE_APPLICATION_CREDENTIALS=./google-credentials.json

# M-Pesa Production
MPESA_CONSUMER_KEY=your_production_key
MPESA_CONSUMER_SECRET=your_production_secret
MPESA_SHORTCODE=your_shortcode
MPESA_PASSKEY=your_production_passkey
MPESA_CALLBACK_URL=https://your-project.supabase.co/functions/v1/mpesa-callback
MPESA_ENVIRONMENT=production
```

### Step 3: Deploy Backend (15 min)

```bash
# 1. Set Supabase secrets
export OPENAI_API_KEY=sk-your-key
./deploy-ai.sh

# 2. Deploy M-Pesa functions (if using production)
./setup-mpesa.sh

# Or manually:
supabase secrets set MPESA_CONSUMER_KEY=your_key
supabase secrets set MPESA_CONSUMER_SECRET=your_secret
supabase secrets set MPESA_SHORTCODE=your_shortcode
supabase secrets set MPESA_PASSKEY=your_passkey

supabase functions deploy mpesa-stk-push
supabase functions deploy mpesa-callback
supabase functions deploy mpesa-query

# 3. Verify deployment
supabase functions list
```

**Expected Output**:
```
┌─────────────────────┬─────────┬────────────┐
│ NAME                │ VERSION │ STATUS     │
├─────────────────────┼─────────┼────────────┤
│ evaluate-writing    │ 1       │ ACTIVE     │
│ evaluate-speaking   │ 1       │ ACTIVE     │
│ mpesa-stk-push      │ 1       │ ACTIVE     │
│ mpesa-callback      │ 1       │ ACTIVE     │
│ mpesa-query         │ 1       │ ACTIVE     │
└─────────────────────┴─────────┴────────────┘
```

---

## Phase 2: Audio Generation (30 minutes)

### Step 1: Install Dependencies (2 min)
```bash
npm install
```

### Step 2: Create Storage Bucket (2 min)
```bash
# Create bucket
supabase storage create audio --public

# Or via Dashboard:
# 1. Go to Storage in Supabase Dashboard
# 2. Click "New bucket"
# 3. Name: "audio"
# 4. Check "Public bucket"
# 5. Click "Create bucket"
```

### Step 3: Generate Audio Files (20 min)
```bash
# Set Google credentials
export GOOGLE_APPLICATION_CREDENTIALS=./google-credentials.json

# Generate all audio files
npm run generate-audio
```

**Expected Output**:
```
🚀 Starting audio generation...

Found 40 listening questions

Generating audio for: listening_a1_1.mp3
Saved locally: /path/to/audio/listening_a1_1.mp3
Uploaded to: https://your-project.supabase.co/storage/v1/object/public/audio/listening_a1_1.mp3
✓ Successfully processed: listening_a1_1.mp3

... (continues for all 40 files)

=== Summary ===
Total questions: 40
Successful: 40
Failed: 0
```

### Step 4: Verify Audio (5 min)
1. Go to Supabase Dashboard → Storage → audio
2. Check that 40 MP3 files are uploaded
3. Click on a file and test playback
4. Verify URL is public

**Cost**: ~$0.16 one-time for all 40 files

---

## Phase 3: Frontend Integration (30 minutes)

### Step 1: Verify Components (5 min)

Check that these files exist:
- [x] `src/components/VoiceRecorder.tsx`
- [x] `src/components/AIFeedback.tsx`
- [x] `src/pages/TakeTest.tsx` (updated)
- [x] `src/pages/TestResults.tsx` (updated)

### Step 2: Install Frontend Dependencies (2 min)
```bash
npm install
```

### Step 3: Test Locally (10 min)
```bash
# Start development server
npm run dev

# Open browser to http://localhost:5173
```

**Test Checklist**:
- [ ] Sign up as new user
- [ ] Take placement test
- [ ] Purchase a test (demo mode)
- [ ] Take test with all question types:
  - [ ] Multiple choice works
  - [ ] Audio plays (if generated)
  - [ ] Essay textarea works
  - [ ] Voice recorder works
- [ ] Submit test
- [ ] View results
- [ ] AI feedback displays

### Step 4: Build for Production (5 min)
```bash
# Build
npm run build

# Test build
npm run preview
```

### Step 5: Deploy Frontend (8 min)

#### Option A: Vercel
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel

# Follow prompts:
# - Link to existing project or create new
# - Set environment variables
# - Deploy
```

#### Option B: Netlify
```bash
# Install Netlify CLI
npm i -g netlify-cli

# Deploy
netlify deploy --prod

# Follow prompts
```

#### Option C: Manual
1. Upload `dist` folder to your hosting
2. Configure environment variables
3. Set up redirects for SPA

---

## Phase 4: Testing & Verification (20 minutes)

### Test 1: AI Writing Evaluation (5 min)
```bash
./test-ai-functions.sh
```

**Expected**: All 3 tests pass

### Test 2: End-to-End User Flow (10 min)
1. **Sign Up**
   - [ ] Create new account
   - [ ] Verify email (if enabled)
   - [ ] Profile created

2. **Placement Test**
   - [ ] Take placement test
   - [ ] Submit answers
   - [ ] See results
   - [ ] Level recommendation

3. **Purchase Test**
   - [ ] Select a test
   - [ ] Enter phone number
   - [ ] Complete payment (demo or real)
   - [ ] Access granted

4. **Take Test**
   - [ ] Audio plays for listening
   - [ ] Multiple choice works
   - [ ] Essay textarea works
   - [ ] Voice recorder works
   - [ ] Timer counts down
   - [ ] Can navigate questions
   - [ ] Submit works

5. **View Results**
   - [ ] Score displays
   - [ ] AI feedback shows for essays
   - [ ] AI feedback shows for speaking
   - [ ] Transcription visible
   - [ ] Can review answers

### Test 3: M-Pesa Integration (5 min)

If using production M-Pesa:
1. Purchase a test with real phone number
2. Check phone for STK push
3. Enter PIN
4. Verify payment confirmation
5. Check access granted

Check logs:
```bash
supabase functions logs mpesa-stk-push
supabase functions logs mpesa-callback
```

---

## Phase 5: Monitoring & Optimization (10 minutes)

### Set Up Monitoring

#### OpenAI Usage
1. Visit https://platform.openai.com/usage
2. Set up billing alerts:
   - Go to Settings → Billing
   - Set monthly limit (e.g., $100)
   - Add email for alerts

#### Supabase Monitoring
1. Dashboard → Database → Usage
2. Monitor:
   - Database size
   - API requests
   - Storage usage
   - Function invocations

#### Set Up Alerts
```bash
# Create alert for high costs
# (Set up in OpenAI dashboard)

# Monitor function errors
supabase functions logs evaluate-writing --tail
supabase functions logs evaluate-speaking --tail
```

### Performance Optimization

1. **Enable Caching**
   - Audio files are already cached in storage
   - Consider CDN for static assets

2. **Database Optimization**
   - Indexes already created
   - Monitor slow queries

3. **Cost Optimization**
   - Using GPT-4o-mini (cost-effective)
   - Audio generated once (no recurring cost)
   - Monitor per-user costs

---

## Phase 6: Production Checklist (10 minutes)

### Security
- [ ] Environment variables secured
- [ ] API keys not in code
- [ ] RLS policies enabled
- [ ] HTTPS enabled
- [ ] CORS configured

### Performance
- [ ] Build optimized
- [ ] Images compressed
- [ ] Audio files compressed
- [ ] CDN configured (optional)

### Functionality
- [ ] All features tested
- [ ] AI evaluation working
- [ ] Audio playback working
- [ ] Voice recording working
- [ ] Payments working
- [ ] Email notifications (if enabled)

### Monitoring
- [ ] OpenAI usage tracking
- [ ] Supabase monitoring
- [ ] Error logging
- [ ] Cost alerts set

### Documentation
- [ ] User guide created
- [ ] Admin documentation
- [ ] API documentation
- [ ] Troubleshooting guide

---

## Cost Summary

### One-Time Costs
- Audio generation: $0.16
- Setup time: 2 hours

### Monthly Costs (100 users)
- AI evaluation: $144
- Supabase: $0 (free tier)
- Hosting: $0-20 (depends on platform)
- **Total: ~$144-164/month**

### Revenue (100 users)
- 100 users × 2 tests × KES 500 = KES 100,000
- ~$700 USD
- **Profit: $536-556 (79% margin)**

---

## Troubleshooting

### Audio Not Playing
```bash
# Check storage bucket
supabase storage list audio

# Verify URLs in database
supabase db query "SELECT id, audio_url FROM questions WHERE audio_url IS NOT NULL LIMIT 5"

# Test URL directly in browser
```

### AI Evaluation Not Working
```bash
# Check function logs
supabase functions logs evaluate-writing --tail

# Test manually
curl -X POST "https://your-project.supabase.co/functions/v1/evaluate-writing" \
  -H "Authorization: Bearer YOUR_ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{"answerId":"test","answerText":"Ich bin Student","questionText":"Stellen Sie sich vor","level":"A1"}'

# Verify OpenAI key
supabase secrets list
```

### M-Pesa Not Working
```bash
# Check logs
supabase functions logs mpesa-stk-push
supabase functions logs mpesa-callback

# Verify secrets
supabase secrets list

# Test with sandbox first
```

### Voice Recorder Not Working
- Check browser permissions
- Verify HTTPS (required for microphone)
- Test in different browsers
- Check console for errors

---

## Post-Deployment

### Week 1
- [ ] Monitor costs daily
- [ ] Check error logs
- [ ] Collect user feedback
- [ ] Fix any issues

### Week 2
- [ ] Analyze usage patterns
- [ ] Optimize costs if needed
- [ ] Add more content if needed
- [ ] Improve based on feedback

### Month 1
- [ ] Review financials
- [ ] Scale if needed
- [ ] Add new features
- [ ] Marketing push

---

## Support Resources

- **Documentation**: All guides in project root
- **Supabase Docs**: https://supabase.com/docs
- **OpenAI Docs**: https://platform.openai.com/docs
- **M-Pesa Docs**: https://developer.safaricom.co.ke

---

## Success Metrics

After deployment, track:
- User signups
- Test purchases
- AI evaluation accuracy
- User satisfaction
- Cost per user
- Profit margin

**Target Metrics**:
- 100 users in Month 1
- 79% profit margin
- <$1.50 cost per user
- >4.5 star rating

---

## 🎉 Congratulations!

You now have a fully automated, production-ready German language learning platform!

**What You've Built**:
- ✅ 140 CEFR-aligned questions
- ✅ AI-powered evaluation
- ✅ Audio for listening tests
- ✅ Voice recording for speaking
- ✅ M-Pesa payment integration
- ✅ Scalable architecture
- ✅ Cost-effective operation

**Next Steps**:
1. Launch marketing campaign
2. Collect user feedback
3. Iterate and improve
4. Scale to more users

Good luck! 🚀
