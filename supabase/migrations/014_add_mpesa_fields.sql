-- Add M-Pesa related fields to purchases table
ALTER TABLE purchases 
ADD COLUMN IF NOT EXISTS mpesa_checkout_request_id TEXT,
ADD COLUMN IF NOT EXISTS mpesa_merchant_request_id TEXT,
ADD COLUMN IF NOT EXISTS mpesa_receipt_number TEXT,
ADD COLUMN IF NOT EXISTS mpesa_error_message TEXT;

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_purchases_checkout_request 
ON purchases(mpesa_checkout_request_id);

CREATE INDEX IF NOT EXISTS idx_purchases_receipt_number
ON purchases(mpesa_receipt_number);

-- Add comments
COMMENT ON COLUMN purchases.mpesa_checkout_request_id IS 'M-Pesa STK Push checkout request ID';
COMMENT ON COLUMN purchases.mpesa_merchant_request_id IS 'M-Pesa merchant request ID';
COMMENT ON COLUMN purchases.mpesa_receipt_number IS 'M-Pesa transaction receipt number';
COMMENT ON COLUMN purchases.mpesa_error_message IS 'Error message if payment failed';
