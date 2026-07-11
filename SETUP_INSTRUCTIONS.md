# M-Pesa Setup Instructions - Step by Step

Follow these exact steps to set up M-Pesa integration.

## Prerequisites

Before starting, you need:
1. Daraja API credentials (get from https://developer.safaricom.co.ke/)
2. Your Supabase project (already set up)

## Method 1: Automated Setup (Recommended)

### Step 1: Install Supabase CLI

Open your terminal and run:

```bash
npm install -g supabase
```

Wait for installation to complete.

### Step 2: Login to Supabase

```bash
supabase login
```

This will open your browser. Click "Authorize" to continue.

### Step 3: Link Your Project

```bash
supabase link --project-ref rpwlitvddtzupszplpmj
```

Enter your database password when prompted.

### Step 4: Run Setup Script

```bash
./setup-mpesa.sh
```

The script will ask for:
- Consumer Key (from Daraja)
- Consumer Secret (from Daraja)
- Passkey (from Daraja)
- Shortcode (press Enter for default: 174379)
- Environment (press Enter for default: sandbox)

That's it! The script will:
- Set all secrets
- Deploy all 3 Edge Functions
- Show you next steps

## Method 2: Manual Setup

If the script doesn't work, do it manually:

### Step 1: Install & Login

```bash
# Install CLI
npm install -g supabase

# Login
supabase login

# Link project
supabase link --project-ref rpwlitvddtzupszplpmj
```

### Step 2: Set Secrets

Replace `your_xxx` with your actual values:

```bash
supabase secrets set MPESA_CONSUMER_KEY=your_consumer_key
supabase secrets set MPESA_CONSUMER_SECRET=your_consumer_secret
supabase secrets set MPESA_SHORTCODE=174379
supabase secrets set MPESA_PASSKEY=your_passkey
supabase secrets set MPESA_ENVIRONMENT=sandbox
```

### Step 3: Deploy Functions

```bash
supabase functions deploy mpesa-stk-push
supabase functions deploy mpesa-callback
supabase functions deploy mpesa-query
```

## Method 3: Dashboard Only (Partial Setup)

If you can't use CLI, you can at least set secrets via dashboard:

### Set Secrets

1. Go to https://supabase.com/dashboard/project/rpwlitvddtzupszplpmj
2. Click **Project Settings** (gear icon)
3. Click **Edge Functions**
4. Scroll to **Secrets**
5. Add each secret:
   - `MPESA_CONSUMER_KEY`
   - `MPESA_CONSUMER_SECRET`
   - `MPESA_SHORTCODE` = `174379`
   - `MPESA_PASSKEY`
   - `MPESA_ENVIRONMENT` = `sandbox`

### Deploy Functions

Unfortunately, you MUST use CLI to deploy functions. There's no way around this.

But it's just 3 commands after installing CLI:
```bash
npm install -g supabase
supabase login
supabase link --project-ref rpwlitvddtzupszplpmj
supabase functions deploy mpesa-stk-push
supabase functions deploy mpesa-callback
supabase functions deploy mpesa-query
```

## After Setup

### 1. Run Database Migration

Go to Supabase SQL Editor:
https://supabase.com/dashboard/project/rpwlitvddtzupszplpmj/sql/new

Copy and paste content from:
`supabase/migrations/014_add_mpesa_fields.sql`

Click **Run**.

### 2. Test the Integration

1. Start your app: `npm run dev`
2. Sign in to your account
3. Go to any test purchase page
4. Enter test phone: `254708374149`
5. Click "Pay with M-Pesa"
6. Watch for success message

### 3. Check Logs

```bash
# View function logs
supabase functions logs mpesa-stk-push --tail
```

## Troubleshooting

### "Command not found: supabase"

The CLI isn't installed. Run:
```bash
npm install -g supabase
```

If that fails, try:
```bash
sudo npm install -g supabase
```

### "Not logged in"

Run:
```bash
supabase login
```

### "Project not linked"

Run:
```bash
supabase link --project-ref rpwlitvddtzupszplpmj
```

### "Failed to deploy function"

Check you're in the project directory:
```bash
pwd  # Should show your project path
ls   # Should show package.json and supabase folder
```

Then try again:
```bash
supabase functions deploy mpesa-stk-push
```

### "Invalid credentials"

Double-check your Daraja credentials:
- Consumer Key
- Consumer Secret
- Passkey

Make sure there are no extra spaces.

## Getting Daraja Credentials

If you don't have Daraja credentials yet:

1. Go to https://developer.safaricom.co.ke/
2. Sign up or log in
3. Click **My Apps** → **Create New App**
4. Enter app name: "DeutschPrep"
5. Select **Lipa Na M-Pesa Online**
6. Click **Create App**
7. Click on your app to see credentials:
   - Consumer Key
   - Consumer Secret
8. Go to **Test Credentials** tab for:
   - Passkey
   - Shortcode (usually 174379)

## Verify Setup

After everything is done, verify:

```bash
# Check secrets are set
supabase secrets list

# Check functions are deployed
supabase functions list

# View function logs
supabase functions logs mpesa-stk-push
```

You should see:
- ✅ 5 secrets listed
- ✅ 3 functions deployed
- ✅ No errors in logs

## Need Help?

If you're stuck:

1. Check the full guide: `docs/MPESA_SETUP_GUIDE.md`
2. Check function logs: `supabase functions logs mpesa-stk-push`
3. Verify secrets: `supabase secrets list`
4. Test with sandbox number: `254708374149`

## Quick Reference

```bash
# Install CLI
npm install -g supabase

# Login
supabase login

# Link project
supabase link --project-ref rpwlitvddtzupszplpmj

# Set secrets (replace with your values)
supabase secrets set MPESA_CONSUMER_KEY=your_key
supabase secrets set MPESA_CONSUMER_SECRET=your_secret
supabase secrets set MPESA_SHORTCODE=174379
supabase secrets set MPESA_PASSKEY=your_passkey
supabase secrets set MPESA_ENVIRONMENT=sandbox

# Deploy functions
supabase functions deploy mpesa-stk-push
supabase functions deploy mpesa-callback
supabase functions deploy mpesa-query

# Check status
supabase secrets list
supabase functions list
supabase functions logs mpesa-stk-push --tail
```

That's it! You're ready to accept M-Pesa payments. 🚀
