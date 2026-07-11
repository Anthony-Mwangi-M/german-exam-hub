# M-Pesa Integration - Deployment Checklist

Use this checklist to deploy M-Pesa integration step by step.

## Prerequisites

- [ ] Supabase project is set up and running
- [ ] Supabase CLI installed (`npm install -g supabase`)
- [ ] Daraja API account created at https://developer.safaricom.co.ke/

## Step 1: Get Daraja Credentials

### Sandbox (Testing)
- [ ] Log in to Daraja Portal
- [ ] Create a new app
- [ ] Select "Lipa Na M-Pesa Online" API
- [ ] Copy Consumer Key
- [ ] Copy Consumer Secret
- [ ] Get Passkey from test credentials page
- [ ] Note Shortcode (usually `174379` for sandbox)

### Production (Later)
- [ ] Apply for production access
- [ ] Get Paybill/Till number approved
- [ ] Receive production credentials

## Step 2: Configure Supabase

### Set Environment Secrets
```bash
# Login to Supabase
supabase login

# Link your project
supabase link --project-ref YOUR_PROJECT_REF

# Set M-Pesa secrets
supabase secrets set MPESA_CONSUMER_KEY=your_consumer_key_here
supabase secrets set MPESA_CONSUMER_SECRET=your_consumer_secret_here
supabase secrets set MPESA_SHORTCODE=174379
supabase secrets set MPESA_PASSKEY=your_passkey_here
supabase secrets set MPESA_ENVIRONMENT=sandbox
```

- [ ] Consumer Key set
- [ ] Consumer Secret set
- [ ] Shortcode set
- [ ] Passkey set
- [ ] Environment set to `sandbox`

### Verify Secrets
```bash
supabase secrets list
```
- [ ] All secrets are listed

## Step 3: Deploy Edge Functions

```bash
# Deploy STK Push function
supabase functions deploy mpesa-stk-push

# Deploy Callback function
supabase functions deploy mpesa-callback

# Deploy Query function
supabase functions deploy mpesa-query
```

- [ ] mpesa-stk-push deployed
- [ ] mpesa-callback deployed
- [ ] mpesa-query deployed

### Verify Deployment
```bash
# Check function status
supabase functions list
```
- [ ] All functions show as deployed

## Step 4: Run Database Migration

### Option A: Via Supabase Dashboard
1. Go to SQL Editor in Supabase Dashboard
2. Open `supabase/migrations/014_add_mpesa_fields.sql`
3. Copy all content
4. Paste into SQL Editor
5. Click "Run"

### Option B: Via CLI
```bash
supabase db push
```

- [ ] Migration 014 executed successfully
- [ ] No errors in migration

### Verify Migration
```sql
-- Run in SQL Editor
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'purchases' 
AND column_name LIKE 'mpesa%';
```
- [ ] `mpesa_checkout_request_id` column exists
- [ ] `mpesa_merchant_request_id` column exists
- [ ] `mpesa_error_message` column exists

## Step 5: Test the Integration

### Test with Sandbox Numbers

1. Start your app: `npm run dev`
2. Sign in to your account
3. Navigate to a test purchase page
4. Enter test phone number: `254708374149`
5. Click "Pay with M-Pesa"

- [ ] STK Push initiated successfully
- [ ] No errors in browser console
- [ ] Payment status updates correctly

### Check Logs
```bash
# View STK Push logs
supabase functions logs mpesa-stk-push --tail

# View Callback logs
supabase functions logs mpesa-callback --tail
```

- [ ] STK Push logs show successful request
- [ ] Callback logs show payment confirmation
- [ ] No errors in logs

### Verify Database
```sql
-- Check recent purchases
SELECT 
  id,
  status,
  amount_kes,
  phone_number,
  mpesa_receipt_number,
  created_at
FROM purchases
ORDER BY created_at DESC
LIMIT 5;
```

- [ ] Purchase record created with status `pending`
- [ ] Status updated to `completed` after payment
- [ ] M-Pesa receipt number stored

## Step 6: Test Failure Scenarios

### Test Failed Payment
1. Use test number: `254708374150`
2. Attempt payment
3. Verify failure handling

- [ ] Payment fails as expected
- [ ] Status updated to `failed`
- [ ] Error message displayed to user
- [ ] Error logged in database

### Test Timeout
1. Use valid number but don't complete payment
2. Wait 30 seconds

- [ ] Timeout message displayed
- [ ] Purchase remains in `pending` state
- [ ] User can retry payment

## Step 7: Production Preparation

### Before Going Live

- [ ] Get production Daraja credentials
- [ ] Test with real phone numbers in sandbox
- [ ] Review all error messages
- [ ] Set up monitoring alerts
- [ ] Prepare customer support documentation
- [ ] Test refund process (if applicable)

### Switch to Production

```bash
# Update secrets with production values
supabase secrets set MPESA_CONSUMER_KEY=production_key
supabase secrets set MPESA_CONSUMER_SECRET=production_secret
supabase secrets set MPESA_SHORTCODE=your_production_shortcode
supabase secrets set MPESA_PASSKEY=production_passkey
supabase secrets set MPESA_ENVIRONMENT=production

# Redeploy functions (to pick up new environment)
supabase functions deploy mpesa-stk-push
supabase functions deploy mpesa-callback
supabase functions deploy mpesa-query
```

- [ ] Production credentials set
- [ ] Environment changed to `production`
- [ ] Functions redeployed
- [ ] Test with real phone number
- [ ] Monitor first few transactions closely

## Step 8: Monitoring Setup

### Database Queries

Save these queries for monitoring:

```sql
-- Payment success rate (last 24 hours)
SELECT 
  status,
  COUNT(*) as count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) as percentage
FROM purchases
WHERE created_at > NOW() - INTERVAL '24 hours'
GROUP BY status;

-- Revenue today
SELECT 
  COUNT(*) as transactions,
  SUM(amount_kes) as total_revenue
FROM purchases
WHERE status = 'completed'
AND DATE(created_at) = CURRENT_DATE;

-- Failed payments (last 7 days)
SELECT 
  DATE(created_at) as date,
  COUNT(*) as failed_count,
  STRING_AGG(DISTINCT mpesa_error_message, ', ') as error_messages
FROM purchases
WHERE status = 'failed'
AND created_at > NOW() - INTERVAL '7 days'
GROUP BY DATE(created_at)
ORDER BY date DESC;
```

- [ ] Monitoring queries saved
- [ ] Dashboard created (optional)
- [ ] Alerts configured (optional)

## Step 9: Documentation

- [ ] Team trained on M-Pesa integration
- [ ] Customer support has troubleshooting guide
- [ ] Refund process documented
- [ ] Escalation process defined

## Step 10: Go Live!

### Final Checks

- [ ] All tests passing
- [ ] Production credentials verified
- [ ] Monitoring in place
- [ ] Support team ready
- [ ] Backup plan prepared

### Launch

- [ ] Enable M-Pesa payments in production
- [ ] Monitor first transactions closely
- [ ] Be ready to rollback if needed
- [ ] Celebrate! 🎉

## Rollback Plan

If something goes wrong:

1. **Disable payments temporarily**
   ```bash
   # Set environment to maintenance mode
   # Or comment out payment button in UI
   ```

2. **Check logs**
   ```bash
   supabase functions logs mpesa-stk-push
   supabase functions logs mpesa-callback
   ```

3. **Revert to demo mode**
   - Update Purchase.tsx to use demo payment
   - Deploy frontend changes

4. **Fix issues**
   - Debug based on logs
   - Test in sandbox
   - Redeploy when fixed

## Support Contacts

- **Daraja Support**: mpesabusiness@safaricom.co.ke
- **Supabase Support**: https://supabase.com/support
- **Internal Team**: [Your team contact]

## Success Criteria

Integration is successful when:

- [ ] 95%+ payment success rate
- [ ] Average payment time < 30 seconds
- [ ] No critical errors in logs
- [ ] Users can complete purchases smoothly
- [ ] Revenue is being tracked correctly

## Notes

Use this space for deployment-specific notes:

```
Date: _______________
Deployed by: _______________
Production URL: _______________
Issues encountered: _______________
Resolution: _______________
```

---

**Remember**: Start with sandbox, test thoroughly, then move to production. Monitor closely for the first few days!
