# Supabase Edge Functions

This directory contains Supabase Edge Functions for DeutschPrep.

## Functions

### mpesa-stk-push
Initiates M-Pesa STK Push payment request.

**Endpoint:** `POST /functions/v1/mpesa-stk-push`

**Request:**
```json
{
  "phoneNumber": "0712345678",
  "amount": 500,
  "purchaseId": "uuid",
  "testModuleId": "uuid"
}
```

**Response:**
```json
{
  "success": true,
  "message": "STK push sent successfully",
  "checkoutRequestId": "ws_CO_123456789"
}
```

### mpesa-callback
Webhook endpoint for M-Pesa payment confirmation.

**Endpoint:** `POST /functions/v1/mpesa-callback`

This is called automatically by Safaricom when payment is completed or fails.

### mpesa-query
Query the status of an M-Pesa transaction.

**Endpoint:** `POST /functions/v1/mpesa-query`

**Request:**
```json
{
  "checkoutRequestId": "ws_CO_123456789"
}
```

### evaluate-writing / evaluate-speaking (deferred)

**Not used in v1.** Writing and speaking are graded manually via the instructor dashboard.

- `verify_jwt = true` in `config.toml` — unauthenticated calls are rejected at the gateway
- Functions return `403` unless Supabase secret `AI_EVALUATION_ENABLED=true` is set
- Do **not** deploy these for launch. Deploy only: `mpesa-stk-push`, `mpesa-callback`, `mpesa-query`, `demo-complete-purchase`

```bash
# Deploy launch functions only
supabase functions deploy mpesa-stk-push mpesa-callback mpesa-query demo-complete-purchase
```

## Development

### Local Testing

```bash
# Start Supabase locally
supabase start

# Serve functions locally
supabase functions serve

# Test function
curl -i --location --request POST 'http://localhost:54321/functions/v1/mpesa-stk-push' \
  --header 'Authorization: Bearer YOUR_ANON_KEY' \
  --header 'Content-Type: application/json' \
  --data '{"phoneNumber":"254708374149","amount":500,"purchaseId":"test","testModuleId":"test"}'
```

### Deploy

```bash
# Deploy single function
supabase functions deploy mpesa-stk-push

# Deploy all functions
supabase functions deploy
```

### View Logs

```bash
# Tail logs
supabase functions logs mpesa-stk-push --tail

# View recent logs
supabase functions logs mpesa-callback
```

## Environment Variables

Required secrets (set via `supabase secrets set`):

- `MPESA_CONSUMER_KEY` - Daraja API consumer key
- `MPESA_CONSUMER_SECRET` - Daraja API consumer secret
- `MPESA_SHORTCODE` - Business shortcode (174379 for sandbox)
- `MPESA_PASSKEY` - Lipa Na M-Pesa passkey
- `MPESA_ENVIRONMENT` - `sandbox` or `production`
- `SUPABASE_URL` - Auto-set by Supabase
- `SUPABASE_SERVICE_ROLE_KEY` - Auto-set by Supabase

## Shared Code

The `_shared` directory contains reusable utilities:

- `mpesa-config.ts` - M-Pesa configuration and helpers

## Security

- All M-Pesa credentials are stored as Supabase secrets
- Never expose credentials in frontend code
- All API calls go through Edge Functions
- Use Row Level Security (RLS) for database access

## Testing

### Sandbox Test Numbers

- `254708374149` - Always succeeds
- `254708374150` - Always fails

### Test Flow

1. Create a purchase in the app
2. Enter test phone number
3. Check function logs for STK push
4. Wait for callback (simulated in sandbox)
5. Verify purchase status updated

## Troubleshooting

### Function not deploying
```bash
# Check function syntax
deno check supabase/functions/mpesa-stk-push/index.ts

# View deployment logs
supabase functions deploy mpesa-stk-push --debug
```

### Callback not working
```bash
# Check callback logs
supabase functions logs mpesa-callback --tail

# Test callback manually
curl -X POST 'https://your-project.supabase.co/functions/v1/mpesa-callback' \
  -H 'Content-Type: application/json' \
  -d '{"Body":{"stkCallback":{"ResultCode":0}}}'
```

## Documentation

- [M-Pesa Setup Guide](../../docs/MPESA_SETUP_GUIDE.md)
- [M-Pesa Quick Start](../../docs/MPESA_QUICK_START.md)
- [Daraja API Docs](https://developer.safaricom.co.ke/docs)
