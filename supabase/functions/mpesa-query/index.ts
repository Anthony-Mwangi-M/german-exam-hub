import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import {
  getMpesaConfig,
  getMpesaAccessToken,
  generatePassword,
  getTimestamp,
} from "../_shared/mpesa-config.ts";
import { requireAuthenticatedUser } from "../_shared/auth.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

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

    const { checkoutRequestId } = await req.json();

    const config = getMpesaConfig();
    const accessToken = await getMpesaAccessToken();
    const timestamp = getTimestamp();
    const password = generatePassword(config.shortcode, config.passkey, timestamp);

    const queryPayload = {
      BusinessShortCode: config.shortcode,
      Password: password,
      Timestamp: timestamp,
      CheckoutRequestID: checkoutRequestId,
    };

    const queryResponse = await fetch(
      `${config.baseUrl}/mpesa/stkpushquery/v1/query`,
      {
        method: "POST",
        headers: {
          Authorization: `Bearer ${accessToken}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify(queryPayload),
      }
    );

    const queryResult = await queryResponse.json();

    return new Response(JSON.stringify(queryResult), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 200,
    });
  } catch (error) {
    console.error("Error:", error);
    return new Response(
      JSON.stringify({ success: false, error: error.message }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" }, status: 400 }
    );
  }
});
