import { useState, useRef } from 'react';
import { Button } from '@/components/ui/button';
import { Mic, Square, Play, Trash2 } from 'lucide-react';
import { Alert, AlertDescription } from '@/components/ui/alert';

interface VoiceRecorderProps {
  onRecordingComplete: (audioBlob: Blob) => void;
  onRecordingClear?: () => void;
  disabled?: boolean;
  maxDurationSeconds?: number;
}

function getRecordingMimeType(): string {
  const types = ['audio/webm;codecs=opus', 'audio/webm', 'audio/mp4', 'audio/ogg'];
  return types.find((t) => MediaRecorder.isTypeSupported(t)) ?? 'audio/webm';
}

export function VoiceRecorder({
  onRecordingComplete,
  onRecordingClear,
  disabled,
  maxDurationSeconds = 240,
}: VoiceRecorderProps) {
  const [isRecording, setIsRecording] = useState(false);
  const [audioURL, setAudioURL] = useState<string>('');
  const [error, setError] = useState<string>('');
  const mediaRecorder = useRef<MediaRecorder | null>(null);
  const audioChunks = useRef<Blob[]>([]);
  const maxDurationTimer = useRef<ReturnType<typeof setTimeout> | null>(null);

  const startRecording = async () => {
    try {
      setError('');
      const mimeType = getRecordingMimeType();
      const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
      
      mediaRecorder.current = new MediaRecorder(stream, { mimeType });
      
      mediaRecorder.current.ondataavailable = (event) => {
        if (event.data.size > 0) {
          audioChunks.current.push(event.data);
        }
      };

      mediaRecorder.current.onstop = () => {
        if (maxDurationTimer.current) {
          clearTimeout(maxDurationTimer.current);
          maxDurationTimer.current = null;
        }
        const audioBlob = new Blob(audioChunks.current, { type: mimeType });
        const url = URL.createObjectURL(audioBlob);
        setAudioURL(url);
        onRecordingComplete(audioBlob);
        
        // Stop all tracks
        stream.getTracks().forEach(track => track.stop());
      };

      audioChunks.current = [];
      mediaRecorder.current.start();
      setIsRecording(true);

      if (maxDurationSeconds > 0) {
        maxDurationTimer.current = setTimeout(() => {
          if (mediaRecorder.current?.state === 'recording') {
            mediaRecorder.current.stop();
            setIsRecording(false);
          }
        }, maxDurationSeconds * 1000);
      }
    } catch (err) {
      console.error('Error accessing microphone:', err);
      setError('Mikrofon-Zugriff verweigert. Bitte erlauben Sie den Zugriff auf Ihr Mikrofon.');
    }
  };

  const stopRecording = () => {
    if (mediaRecorder.current && isRecording) {
      mediaRecorder.current.stop();
      setIsRecording(false);
    }
  };

  const clearRecording = () => {
    setAudioURL('');
    audioChunks.current = [];
    onRecordingClear?.();
  };

  return (
    <div className="space-y-4">
      {error && (
        <Alert variant="destructive">
          <AlertDescription>{error}</AlertDescription>
        </Alert>
      )}

      <div className="flex gap-2">
        {!isRecording && !audioURL ? (
          <Button 
            onClick={startRecording} 
            disabled={disabled}
            className="flex-1"
          >
            <Mic className="mr-2 h-4 w-4" />
            Aufnahme starten
          </Button>
        ) : isRecording ? (
          <Button 
            onClick={stopRecording} 
            variant="destructive"
            className="flex-1"
          >
            <Square className="mr-2 h-4 w-4" />
            Aufnahme stoppen
          </Button>
        ) : (
          <>
            <Button 
              onClick={startRecording} 
              disabled={disabled}
              variant="outline"
            >
              <Mic className="mr-2 h-4 w-4" />
              Neu aufnehmen
            </Button>
            <Button 
              onClick={clearRecording} 
              variant="outline"
              size="icon"
            >
              <Trash2 className="h-4 w-4" />
            </Button>
          </>
        )}
      </div>

      {isRecording && (
        <div className="flex items-center gap-2 text-sm text-red-600">
          <div className="h-3 w-3 rounded-full bg-red-600 animate-pulse" />
          Aufnahme läuft...
        </div>
      )}

      {audioURL && (
        <div className="rounded-lg border p-4 bg-muted/50">
          <p className="text-sm font-medium mb-2">Ihre Aufnahme:</p>
          <audio controls src={audioURL} className="w-full" />
        </div>
      )}

      <p className="text-xs text-muted-foreground">
        Tipp: Sprechen Sie klar und deutlich. Sie können die Aufnahme beliebig oft wiederholen.
      </p>
    </div>
  );
}
