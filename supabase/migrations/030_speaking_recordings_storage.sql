-- Supabase Storage bucket for student speaking recordings
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'recordings',
  'recordings',
  false,
  10485760,
  ARRAY['audio/webm', 'audio/mp4', 'audio/mpeg', 'audio/ogg']
)
ON CONFLICT (id) DO NOTHING;

-- Students upload to: {user_id}/{attempt_id}/{question_id}.webm
CREATE POLICY "Users can upload own speaking recordings"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'recordings'
  AND auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Users can update own speaking recordings"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'recordings'
  AND auth.uid()::text = (storage.foldername(name))[1]
)
WITH CHECK (
  bucket_id = 'recordings'
  AND auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Users can read own speaking recordings"
ON storage.objects FOR SELECT
TO authenticated
USING (
  bucket_id = 'recordings'
  AND auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Admins can read all speaking recordings"
ON storage.objects FOR SELECT
TO authenticated
USING (
  bucket_id = 'recordings'
  AND is_admin()
);
