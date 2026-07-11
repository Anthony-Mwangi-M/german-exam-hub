# Quick Start - Path 3 (Full Production)

## 🚀 Deploy in 2 Hours

### Prerequisites
- Supabase project
- Node.js installed
- Terminal access

---

## Step 1: Get API Keys (10 min)

### OpenAI
```
1. Visit: https://platform.openai.com/api-keys
2. Create new key
3. Copy: sk-...
```

### Google Cloud TTS
```
1. Visit: https://console.cloud.google.com
2. Create project
3. Enable Text-to-Speech API
4. Create service account
5. Download JSON credentials
```

### M-Pesa (Optional)
```
1. Visit: https://developer.safaricom.co.ke
2. Get production credentials
3. Save for later
```

---

## Step 2: Configure (5 min)

Create `.env`:
```bash
VITE_SUPABASE_URL=your_url
VITE_SUPABASE_ANON_KEY=your_key
OPENAI_API_KEY=sk-your-key
GOOGLE_APPLICATION_CREDENTIALS=./google-credentials.json
```

---

## Step 3: Deploy Backend (15 min)

```bash
# Deploy AI functions
export OPENAI_API_KEY=sk-your-key
./deploy-ai.sh

# Deploy M-Pesa (if ready)
./setup-mpesa.sh
```

---

## Step 4: Generate Audio (30 min)

```bash
# Create storage
supabase storage create audio --public

# Generate audio
export GOOGLE_APPLICATION_CREDENTIALS=./google-credentials.json
npm run generate-audio
```

---

## Step 5: Test (15 min)

```bash
# Install & run
npm install
npm run dev

# Test at http://localhost:5173
# - Sign up
# - Take test
# - Check AI feedback
# - Test voice recorder
```

---

## Step 6: Deploy (10 min)

```bash
# Build
npm run build

# Deploy (choose one)
vercel                    # Vercel
netlify deploy --prod     # Netlify
# or upload dist/ folder
```

---

## Step 7: Verify (20 min)

```bash
# Test AI
./test-ai-functions.sh

# Check logs
supabase functions logs evaluate-writing
supabase functions logs evaluate-speaking

# Test live site
# - Complete user flow
# - Verify AI feedback
# - Test payments
```

---

## ✅ Done!

Your platform is live with:
- ✅ 140 CEFR questions
- ✅ AI evaluation
- ✅ Audio playback
- ✅ Voice recording
- ✅ M-Pesa payments

---

## 📊 Costs

- Audio: $0.16 (one-time)
- Per user: $1.44
- Profit: 79% margin

---

## 🆘 Issues?

```bash
# Check logs
supabase functions logs <function-name>

# Test functions
./test-ai-functions.sh

# Verify secrets
supabase secrets list
```

---

## 📚 Full Guide

See **PATH_3_DEPLOYMENT_GUIDE.md** for detailed instructions.

---

## 🎉 Launch Checklist

- [ ] API keys obtained
- [ ] Backend deployed
- [ ] Audio generated
- [ ] Frontend deployed
- [ ] Tests passing
- [ ] Monitoring set up

---

**Time**: ~2 hours  
**Result**: Production-ready platform  
**Profit**: 79% margin

Let's go! 🚀
