import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { requireAuthenticatedUser } from "../_shared/auth.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

interface DemoCompleteRequest {
  purchaseId: string;
}

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    if (Deno.env.get("ENABLE_DEMO_PAYMENTS") !== "true") {
      return new Response(
        JSON.stringify({ success: false, error: "Demo payments are disabled" }),
        { headers: { ...corsHeaders, "Content-Type": "application/json" }, status: 403 }
      );
    }

    const authResult = await requireAuthenticatedUser(req);
    if (authResult instanceof Response) {
      return new Response(authResult.body, {
        status: authResult.status,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }
    const { user } = authResult;

    const { purchaseId }: DemoCompleteRequest = await req.json();

    const supabaseAdmin = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
    );

    const { data: purchase, error: fetchError } = await supabaseAdmin
      .from("purchases")
      .select("id, user_id, status, amount_kes")
      .eq("id", purchaseId)
      .single();

    if (fetchError || !purchase) {
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

    if (purchase.status !== "pending") {
      return new Response(JSON.stringify({ success: false, error: "Purchase is not pending" }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 400,
      });
    }

    const receipt = `DEMO-${Date.now()}`;

    const { error: updateError } = await supabaseAdmin
      .from("purchases")
      .update({
        status: "completed",
        mpesa_receipt_number: receipt,
        completed_at: new Date().toISOString(),
      })
      .eq("id", purchaseId);

    if (updateError) throw updateError;

    return new Response(
      JSON.stringify({ success: true, receipt }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" }, status: 200 }
    );
  } catch (error) {
    console.error("Demo payment error:", error);
    return new Response(
      JSON.stringify({ success: false, error: error.message }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" }, status: 400 }
    );
  }
});
