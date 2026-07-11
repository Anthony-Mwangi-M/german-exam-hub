import { supabase } from '@/lib/supabase';

export const RECORDINGS_BUCKET = 'recordings';
const SPEAKING_RECORDED = '__recorded__';

/** Marker stored in answers state when a blob is ready (upload happens on submit). */
export const SPEAKING_ANSWER_MARKER = SPEAKING_RECORDED;

export function buildRecordingStoragePath(
  userId: string,
  attemptId: string,
  questionId: string,
  extension = 'webm'
): string {
  return `${userId}/${attemptId}/${questionId}.${extension}`;
}

/** True when user_answer is a Supabase Storage path or public URL (not inline base64). */
export function isStorageRecordingPath(value: string): boolean {
  if (!value || value === SPEAKING_RECORDED) return false;
  if (value.startsWith('data:audio')) return false;
  if (value.startsWith('http://') || value.startsWith('https://')) return true;
  return value.includes('/');
}

function toStoragePath(userAnswer: string): string {
  if (userAnswer.startsWith(`${RECORDINGS_BUCKET}/`)) {
    return userAnswer.slice(`${RECORDINGS_BUCKET}/`.length);
  }
  return userAnswer;
}

function extensionFromBlob(blob: Blob): string {
  if (blob.type.includes('mp4')) return 'mp4';
  if (blob.type.includes('mpeg')) return 'mp3';
  if (blob.type.includes('ogg')) return 'ogg';
  return 'webm';
}

export async function uploadSpeakingRecording(
  blob: Blob,
  userId: string,
  attemptId: string,
  questionId: string
): Promise<string> {
  const ext = extensionFromBlob(blob);
  const path = buildRecordingStoragePath(userId, attemptId, questionId, ext);

  const { error } = await supabase.storage.from(RECORDINGS_BUCKET).upload(path, blob, {
    upsert: true,
    contentType: blob.type || 'audio/webm',
  });

  if (error) throw error;
  return path;
}

/** Resolve a speaking answer to a URL the browser audio element can play. */
export async function getRecordingPlaybackUrl(userAnswer: string): Promise<string> {
  if (!userAnswer || userAnswer === SPEAKING_RECORDED) return '';

  if (
    userAnswer.startsWith('data:audio') ||
    userAnswer.startsWith('http://') ||
    userAnswer.startsWith('https://')
  ) {
    return userAnswer;
  }

  if (isStorageRecordingPath(userAnswer)) {
    const storagePath = toStoragePath(userAnswer);

    const { data: signed, error } = await supabase.storage
      .from(RECORDINGS_BUCKET)
      .createSignedUrl(storagePath, 3600);

    if (!error && signed?.signedUrl) {
      return signed.signedUrl;
    }

    const { data: publicData } = supabase.storage
      .from(RECORDINGS_BUCKET)
      .getPublicUrl(storagePath);

    return publicData.publicUrl;
  }

  return `data:audio/webm;base64,${userAnswer}`;
}
