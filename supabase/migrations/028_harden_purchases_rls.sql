-- Remove client-side purchase status updates.
-- Only edge functions (service role) may update purchases after M-Pesa callback.

DROP POLICY IF EXISTS "Users can update own purchases" ON purchases;
DROP POLICY IF EXISTS "Service role can update purchases" ON purchases;
