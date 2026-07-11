-- Add UPDATE policy for purchases table
-- This allows users to update their own purchases (needed for payment status updates)

CREATE POLICY "Users can update own purchases" ON purchases 
FOR UPDATE 
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());

-- Also add policy for service role to update purchases (for M-Pesa callbacks)
CREATE POLICY "Service role can update purchases" ON purchases 
FOR UPDATE 
USING (true)
WITH CHECK (true);
