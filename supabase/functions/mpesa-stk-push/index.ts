import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import {
  getMpesaConfig,
  getMpesaAccessToken,
  formatPhoneNumber,
  generatePassword,
  getTimestamp,
} from "../_shared/mpesa-config.ts";
import { requireAuthenticatedUser } from "../_shared/auth.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

interface STKPushRequest {
  phoneNumber: string;
  amount: number;
  purchaseId: string;
  testModuleId: string;
}

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const authResult = await requireAuthenticatedUser(req);
    if (authResult instanceof Response) {
      return new Response(authResult.body, {
        status: authResult.status,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }
    const { user } = authResult;

    const { phoneNumber, amount, purchaseId, testModuleId }: STKPushRequest = await req.json();

    const supabaseAdmin = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
    );

    const { data: purchase, error: purchaseError } = await supabaseAdmin
      .from("purchases")
      .select("id, user_id, test_module_id, status, amount_kes")
      .eq("id", purchaseId)
      .single();

    if (purchaseError || !purchase) {
      return new Response(JSON.stringify({ success: false, error: "Purchase not found" }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 404,
      });
    }

    if (purchase.user_id !== user.id) {
      return new Response(JSON.stringify({ success: false, error: "Forbidden" }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 403,
      });
    }

    if (purchase.test_module_id !== testModuleId) {
      return new Response(JSON.stringify({ success: false, error: "Invalid purchase" }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 403,
      });
    }

    if (purchase.status !== "pending") {
      return new Response(JSON.stringify({ success: false, error: "Purchase is not pending" }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 400,
      });
    }

    if (Math.round(amount) !== purchase.amount_kes) {
      return new Response(JSON.stringify({ success: false, error: "Amount mismatch" }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 400,
      });
    }

    const config = getMpesaConfig();
    const formattedPhone = formatPhoneNumber(phoneNumber);
    const accessToken = await getMpesaAccessToken();

    const timestamp = getTimestamp();
    const password = generatePassword(config.shortcode, config.passkey, timestamp);
    const callbackUrl =
      Deno.env.get("MPESA_CALLBACK_URL") ??
      `${Deno.env.get("SUPABASE_URL")}/functions/v1/mpesa-callback`;

    const stkPushPayload = {
      BusinessShortCode: config.shortcode,
      Password: password,
      Timestamp: timestamp,
      TransactionType: "CustomerPayBillOnline",
      Amount: Math.round(amount),
      PartyA: formattedPhone,
      PartyB: config.shortcode,
      PhoneNumber: formattedPhone,
      CallBackURL: callbackUrl,
      AccountReference: `TEST-${testModuleId.substring(0, 8)}`,
      TransactionDesc: "DeutschPrep Test Purchase",
    };

    const stkResponse = await fetch(`${config.baseUrl}/mpesa/stkpush/v1/processrequest`, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${accessToken}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(stkPushPayload),
    });

    const stkResult = await stkResponse.json();

    if (stkResult.ResponseCode === "0") {
      await supabaseAdmin
        .from("purchases")
        .update({
          mpesa_checkout_request_id: stkResult.CheckoutRequestID,
          mpesa_merchant_request_id: stkResult.MerchantRequestID,
        })
        .eq("id", purchaseId);

      return new Response(
        JSON.stringify({
          success: true,
          message: "STK push sent successfully",
          checkoutRequestId: stkResult.CheckoutRequestID,
        }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" }, status: 200 }
      );
    }

    throw new Error(stkResult.ResponseDescription || "STK push failed");
  } catch (error) {
    console.error("Error:", error);
    return new Response(
      JSON.stringify({ success: false, error: error.message }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" }, status: 400 }
    );
  }
});
