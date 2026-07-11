-- Demo purchase completion without Edge Functions (for testing before M-Pesa).
-- Set demo_payments_enabled to 'false' in app_config before production launch.

CREATE TABLE IF NOT EXISTS app_config (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);

ALTER TABLE app_config ENABLE ROW LEVEL SECURITY;

INSERT INTO app_config (key, value)
VALUES ('demo_payments_enabled', 'true')
ON CONFLICT (key) DO NOTHING;

CREATE OR REPLACE FUNCTION complete_demo_purchase(purchase_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_purchase purchases%ROWTYPE;
  v_receipt TEXT;
  v_demo_enabled TEXT;
BEGIN
  SELECT value INTO v_demo_enabled
  FROM app_config
  WHERE key = 'demo_payments_enabled';

  IF v_demo_enabled IS DISTINCT FROM 'true' THEN
    RAISE EXCEPTION 'Demo payments are disabled';
  END IF;

  IF auth.uid() IS NULL THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;

  SELECT * INTO v_purchase FROM purchases WHERE id = purchase_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Purchase not found';
  END IF;

  IF v_purchase.user_id != auth.uid() THEN
    RAISE EXCEPTION 'Forbidden';
  END IF;

  IF v_purchase.status != 'pending' THEN
    RAISE EXCEPTION 'Purchase is not pending';
  END IF;

  v_receipt := 'DEMO-' || floor(extract(epoch FROM now()))::bigint;

  UPDATE purchases
  SET
    status = 'completed',
    mpesa_receipt_number = v_receipt,
    completed_at = NOW()
  WHERE id = purchase_id;

  RETURN jsonb_build_object('success', true, 'receipt', v_receipt);
END;
$$;

REVOKE ALL ON FUNCTION complete_demo_purchase(UUID) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION complete_demo_purchase(UUID) TO authenticated;
