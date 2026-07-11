# M-Pesa Quick Start Guide

Get M-Pesa payments working in 5 minutes.

## 1. Get Sandbox Credentials

Visit https://developer.safaricom.co.ke/ and create an app to get:
- Consumer Key
- Consumer Secret  
- Passkey
- Shortcode (use `174379` for sandbox)

## 2. Set Supabase Secrets

```bash
supabase secrets set MPESA_CONSUMER_KEY=your_key_here
supabase secrets set MPESA_CONSUMER_SECRET=your_secret_here
supabase secrets set MPESA_SHORTCODE=174379
supabase secrets set MPESA_PASSKEY=your_passkey_here
supabase secrets set MPESA_ENVIRONMENT=sandbox
```

## 3. Deploy Edge Functions

```bash
supabase functions deploy mpesa-stk-push
supabase functions deploy mpesa-callback
supabase functions deploy mpesa-query
```

## 4. Run Migration

In Supabase SQL Editor:
```sql
-- Copy and paste content from:
supabase/migrations/014_add_mpesa_fields.sql
```

## 5. Test Payment

Use sandbox test numbers:
- `254708374149` - Always succeeds
- `254708374150` - Always fails

## Production Checklist

When ready for production:

1. Get production credentials from Safaricom
2. Update secrets with production values
3. Change environment:
   ```bash
   supabase secrets set MPESA_ENVIRONMENT=production
   ```
4. Test with real phone numbers
5. Monitor payments in dashboard

## Troubleshooting

**"Invalid Access Token"**
- Check your Consumer Key/Secret are correct
- Verify secrets are set in Supabase

**"Callback not received"**
- Check Edge Function logs: `supabase functions logs mpesa-callback`
- Verify callback URL is accessible

**"Payment timeout"**
- User may have cancelled
- Check phone number format (254XXXXXXXXX)

## Support

Full documentation: `docs/MPESA_SETUP_GUIDE.md`
