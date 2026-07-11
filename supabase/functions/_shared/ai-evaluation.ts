const CORS_HEADERS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

export function handleAiEvaluationCors(req: Request): Response | null {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: CORS_HEADERS });
  }
  return null;
}

/** V1 uses manual instructor grading only. Set AI_EVALUATION_ENABLED=true to opt in later. */
export function aiEvaluationDisabledResponse(): Response | null {
  if (Deno.env.get("AI_EVALUATION_ENABLED") === "true") {
    return null;
  }

  return new Response(
    JSON.stringify({
      error: "AI evaluation is disabled. Writing and speaking are graded manually by instructors.",
    }),
    { status: 403, headers: { ...CORS_HEADERS, "Content-Type": "application/json" } }
  );
}
