import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

serve(async (req) => {
  try {
    const payload = await req.json();
    console.log('M-Pesa Callback received:', JSON.stringify(payload, null, 2));

    // Initialize Supabase client
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    );

    const { Body } = payload;
    const { stkCallback } = Body;

    const checkoutRequestId = stkCallback.CheckoutRequestID;
    const resultCode = stkCallback.ResultCode;
    const resultDesc = stkCallback.ResultDesc;

    // Find the purchase by checkout request ID
    const { data: purchase, error: fetchError } = await supabaseClient
      .from('purchases')
      .select('*')
      .eq('mpesa_checkout_request_id', checkoutRequestId)
      .single();

    if (fetchError || !purchase) {
      console.error('Purchase not found:', checkoutRequestId);
      return new Response(JSON.stringify({ success: false }), { status: 404 });
    }

    if (resultCode === 0) {
      // Payment successful
      const callbackMetadata = stkCallback.CallbackMetadata?.Item || [];
      const receiptNumber = callbackMetadata.find((item: any) => item.Name === 'MpesaReceiptNumber')?.Value;
      const transactionDate = callbackMetadata.find((item: any) => item.Name === 'TransactionDate')?.Value;
      const phoneNumber = callbackMetadata.find((item: any) => item.Name === 'PhoneNumber')?.Value;

      // Update purchase to completed
      const { error: updateError } = await supabaseClient
        .from('purchases')
        .update({
          status: 'completed',
          mpesa_receipt_number: receiptNumber,
          completed_at: new Date().toISOString(),
          mpesa_phone_number: phoneNumber?.toString(),
        })
        .eq('id', purchase.id);

      if (updateError) {
        console.error('Error updating purchase:', updateError);
      } else {
        console.log('Purchase completed successfully:', purchase.id);
      }
    } else {
      // Payment failed or cancelled
      const { error: updateError } = await supabaseClient
        .from('purchases')
        .update({
          status: 'failed',
          mpesa_error_message: resultDesc,
        })
        .eq('id', purchase.id);

      if (updateError) {
        console.error('Error updating purchase:', updateError);
      } else {
        console.log('Purchase failed:', purchase.id, resultDesc);
      }
    }

    return new Response(
      JSON.stringify({ ResultCode: 0, ResultDesc: 'Success' }),
      {
        headers: { 'Content-Type': 'application/json' },
        status: 200,
      }
    );
  } catch (error) {
    console.error('Callback error:', error);
    return new Response(
      JSON.stringify({ ResultCode: 1, ResultDesc: 'Error processing callback' }),
      {
        headers: { 'Content-Type': 'application/json' },
        status: 500,
      }
    );
  }
});
