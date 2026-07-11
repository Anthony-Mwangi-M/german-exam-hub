# M-Pesa Integration Setup Guide

This guide will help you set up M-Pesa payment integration for DeutschPrep.

## Overview

The M-Pesa integration uses:
- **Daraja API** (Safaricom's M-Pesa API)
- **STK Push** (Lipa Na M-Pesa Online)
- **Supabase Edge Functions** for secure API calls
- **Webhook callbacks** for payment confirmation

## Prerequisites

1. Safaricom Daraja API account
2. Supabase project with Edge Functions enabled
3. M-Pesa Paybill or Till Number

## Step 1: Get Daraja API Credentials

### For Testing (Sandbox)

1. Go to https://developer.safaricom.co.ke/
2. Sign up or log in
3. Create a new app
4. Select "Lipa Na M-Pesa Online" API
5. Note down:
   - Consumer Key
   - Consumer Secret
   - Passkey (from test credentials page)
   - Business Short Code (usually 174379 for sandbox)

### For Production

1. Apply for production credentials through Safaricom
2. Get your Paybill/Till number approved
3. Receive production credentials via email

## Step 2: Configure Supabase Environment Variables

### In Supabase Dashboard

1. Go to Project Settings → Edge Functions
2. Add the following secrets:

```bash
# M-Pesa Credentials
MPESA_CONSUMER_KEY=your_consumer_key_here
MPESA_CONSUMER_SECRET=your_consumer_secret_here
MPESA_SHORTCODE=174379  # Use your actual shortcode
MPESA_PASSKEY=your_passkey_here

# Supabase (already set by default)
SUPABASE_URL=your_project_url
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
```

### Using Supabase CLI

```bash
# Set secrets
supabase secrets set MPESA_CONSUMER_KEY=your_key
supabase secrets set MPESA_CONSUMER_SECRET=your_secret
supabase secrets set MPESA_SHORTCODE=174379
supabase secrets set MPESA_PASSKEY=your_passkey
```

## Step 3: Deploy Edge Functions

### Install Supabase CLI

```bash
npm install -g supabase
```

### Login to Supabase

```bash
supabase login
```

### Link Your Project

```bash
supabase link --project-ref your-project-ref
```

### Deploy Functions

```bash
# Deploy all functions
supabase functions deploy mpesa-stk-push
supabase functions deploy mpesa-callback
supabase functions deploy mpesa-query
```

## Step 4: Run Database Migration

Run the migration to add M-Pesa fields:

```bash
# In Supabase SQL Editor, run:
supabase/migrations/014_add_mpesa_fields.sql
```

Or via CLI:

```bash
supabase db push
```

## Step 5: Configure Callback URL in Daraja

### For Sandbox Testing

The callback URL is automatically set in the STK Push request:
```
https://your-project-ref.supabase.co/functions/v1/mpesa-callback
```

### For Production

1. Log in to Daraja Portal
2. Go to your app settings
3. Set the callback URL to:
   ```
   https://your-project-ref.supabase.co/functions/v1/mpesa-callback
   ```

## Step 6: Test the Integration

### Using Sandbox

1. Use test phone numbers provided by Safaricom:
   - `254708374149` (always succeeds)
   - `254708374150` (always fails)

2. Test the flow:
   ```bash
   # Start your app
   npm run dev
   
   # Navigate to a test purchase page
   # Enter test phone number
   # Click "Pay with M-Pesa"
   ```

3. Check logs:
   ```bash
   # View Edge Function logs
   supabase functions logs mpesa-stk-push
   supabase functions logs mpesa-callback
   ```

### Test Payment Flow

```typescript
// Example test in browser console
const response = await fetch('https://your-project.supabase.co/functions/v1/mpesa-stk-push', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer YOUR_ANON_KEY'
  },
  body: JSON.stringify({
    phoneNumber: '254708374149',
    amount: 500,
    purchaseId: 'test-purchase-id',
    testModuleId: 'test-module-id'
  })
});

const data = await response.json();
console.log(data);
```

## Step 7: Monitor Payments

### Check Purchase Status

```sql
-- View recent purchases
SELECT 
  p.id,
  p.status,
  p.amount_kes,
  p.phone_number,
  p.mpesa_receipt_number,
  p.created_at,
  p.completed_at,
  u.email as user_email,
  tm.title as test_name
FROM purchases p
JOIN profiles u ON p.user_id = u.id
JOIN test_modules tm ON p.test_module_id = tm.id
ORDER BY p.created_at DESC
LIMIT 20;
```

### Check Failed Payments

```sql
SELECT 
  id,
  phone_number,
  amount_kes,
  mpesa_error_message,
  created_at
FROM purchases
WHERE status = 'failed'
ORDER BY created_at DESC;
```

## Troubleshooting

### Common Issues

#### 1. "Invalid Access Token"
- Check your Consumer Key and Secret
- Ensure they're correctly set in Supabase secrets
- Verify you're using the right environment (sandbox vs production)

#### 2. "Invalid Shortcode"
- Verify your Business Short Code
- For sandbox, use `174379`
- For production, use your actual Paybill/Till number

#### 3. "Callback Not Received"
- Check Edge Function logs: `supabase functions logs mpesa-callback`
- Verify callback URL is accessible
- Ensure webhook is not blocked by firewall

#### 4. "Payment Timeout"
- User may have cancelled the STK push
- Check if phone number is correct
- Verify phone has M-Pesa enabled

#### 5. "Insufficient Funds"
- User's M-Pesa balance is too low
- Ask user to top up and try again

### Debug Mode

Enable detailed logging:

```typescript
// In Edge Function
console.log('Request payload:', JSON.stringify(payload, null, 2));
console.log('M-Pesa response:', JSON.stringify(response, null, 2));
```

View logs:
```bash
supabase functions logs mpesa-stk-push --tail
```

## Production Checklist

Before going live:

- [ ] Get production Daraja API credentials
- [ ] Update environment variables with production keys
- [ ] Change API URLs from sandbox to production:
  - Sandbox: `https://sandbox.safaricom.co.ke`
  - Production: `https://api.safaricom.co.ke`
- [ ] Test with real phone numbers
- [ ] Set up monitoring and alerts
- [ ] Configure proper error handling
- [ ] Add email notifications for successful payments
- [ ] Set up reconciliation process
- [ ] Test callback URL is accessible
- [ ] Add rate limiting to prevent abuse
- [ ] Set up backup payment method

## API Endpoints

### STK Push
```
POST https://your-project.supabase.co/functions/v1/mpesa-stk-push
```

### Callback (Webhook)
```
POST https://your-project.supabase.co/functions/v1/mpesa-callback
```

### Query Transaction Status
```
POST https://your-project.supabase.co/functions/v1/mpesa-query
```

## Security Best Practices

1. **Never expose credentials in frontend code**
   - All M-Pesa calls go through Edge Functions
   - Use Supabase RLS for database security

2. **Validate all inputs**
   - Phone numbers
   - Amounts
   - User authentication

3. **Use HTTPS only**
   - Supabase Edge Functions use HTTPS by default

4. **Monitor for fraud**
   - Track failed payment attempts
   - Set up alerts for suspicious activity

5. **Keep secrets secure**
   - Use Supabase secrets management
   - Rotate credentials regularly

## Support

- **Daraja API Docs**: https://developer.safaricom.co.ke/docs
- **Supabase Edge Functions**: https://supabase.com/docs/guides/functions
- **M-Pesa Support**: mpesabusiness@safaricom.co.ke

## Next Steps

After M-Pesa is working:

1. Add email notifications for successful payments
2. Implement payment reconciliation
3. Add admin dashboard for payment monitoring
4. Set up automated refunds
5. Add payment analytics
