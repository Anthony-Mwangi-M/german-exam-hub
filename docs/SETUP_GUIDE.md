# DeutschPrep Setup Guide

## Prerequisites
- Node.js 18+ installed
- Supabase account
- M-Pesa Daraja API credentials (for payments)

## Step 1: Create Supabase Project

1. Go to [supabase.com](https://supabase.com)
2. Click "New Project"
3. Fill in project details:
   - Name: deutschprep
   - Database Password: (save this securely)
   - Region: Choose closest to Kenya (e.g., Singapore or Frankfurt)
4. Wait for project to be created (~2 minutes)

## Step 2: Run Database Migrations

1. In your Supabase project dashboard, go to **SQL Editor**
2. Click "New Query"
3. Copy the entire contents of `supabase/migrations/001_initial_schema.sql`
4. Paste and click "Run"
5. Verify all tables were created in the **Table Editor**

## Step 3: Seed Initial Data

Run this SQL in the SQL Editor to add levels and skills:

```sql
-- Insert levels
INSERT INTO levels (code, name, description, "order") VALUES
('A1', 'Beginner', 'Basic vocabulary and simple phrases for everyday situations', 1),
('A2', 'Elementary', 'Everyday expressions and routine tasks in familiar contexts', 2),
('B1', 'Intermediate', 'Handle travel situations and describe experiences confidently', 3),
('B2', 'Upper-Intermediate', 'Interact fluently and understand complex texts with ease', 4);

-- Insert skills
INSERT INTO skills (code, name_de, name_en) VALUES
('listening', 'Hören', 'Listening'),
('reading', 'Lesen', 'Reading'),
('writing', 'Schreiben', 'Writing'),
('speaking', 'Sprechen', 'Speaking');
```

## Step 4: Get Supabase Credentials

1. In Supabase dashboard, go to **Settings** → **API**
2. Copy:
   - Project URL
   - anon/public key

## Step 5: Configure Environment Variables

1. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```

2. Fill in your Supabase credentials:
   ```env
   VITE_SUPABASE_URL=https://your-project.supabase.co
   VITE_SUPABASE_ANON_KEY=your-anon-key
   ```

## Step 6: Install Dependencies

```bash
npm install
```

## Step 7: Run Development Server

```bash
npm run dev
```

## Step 8: Create Admin User

1. Sign up through the app
2. In Supabase dashboard, go to **Table Editor** → **profiles**
3. Find your user and change `role` from `user` to `admin`

## Step 9: M-Pesa Setup (Later)

### Get Daraja API Credentials

1. Go to [Daraja Portal](https://developer.safaricom.co.ke/)
2. Create an account
3. Create a new app
4. Get credentials:
   - Consumer Key
   - Consumer Secret
   - Shortcode
   - Passkey

### Test in Sandbox First

Use sandbox credentials for testing before going live.

## Next Steps

1. ✅ Database is set up
2. ✅ Authentication works
3. 🔄 Build placement test
4. 🔄 Add test modules
5. 🔄 Integrate M-Pesa
6. 🔄 Build admin dashboard

## Troubleshooting

### "Missing Supabase environment variables"
- Make sure `.env` file exists
- Check that variables start with `VITE_`
- Restart dev server after changing `.env`

### RLS Policies Not Working
- Make sure you're logged in
- Check user role in profiles table
- Verify policies in Supabase dashboard

### Can't Create Admin User
- Sign up first through the app
- Then manually update role in Supabase dashboard
