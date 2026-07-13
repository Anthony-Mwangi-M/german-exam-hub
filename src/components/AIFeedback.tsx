/** Deferred: v1 uses manual instructor grading only. Not imported by the app. */
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Progress } from '@/components/ui/progress';
import { CheckCircle, AlertCircle } from 'lucide-react';

interface AIEvaluation {
  grammar: {
    score: number;
    errors?: string[];
    suggestions?: string[];
  };
  vocabulary: {
    score: number;
    level?: string;
    advanced_words?: string[];
    suggestions?: string[];
  };
  structure: {
    score: number;
    coherence?: string;
    organization?: string;
  };
  content: {
    score: number;
    relevance?: string;
    completeness?: string;
  };
  fluency?: {
    score: number;
    feedback?: string;
  };
  overall_score: number;
  cefr_level: string;
  feedback: string;
  transcription?: string;
}

interface AIFeedbackProps {
  evaluation: AIEvaluation;
  type: 'writing' | 'speaking';
}

function ScoreCard({ title, score }: { title: string; score: number }) {
  const getColor = (score: number) => {
    if (score >= 85) return 'text-green-600';
    if (score >= 70) return 'text-blue-600';
    if (score >= 50) return 'text-orange-600';
    return 'text-red-600';
  };

  return (
    <div className="rounded-lg border p-4">
      <p className="text-sm font-medium text-muted-foreground mb-2">{title}</p>
      <div className="flex items-end gap-2">
        <span className={`text-3xl font-bold ${getColor(score)}`}>{score}</span>
        <span className="text-muted-foreground mb-1">/100</span>
      </div>
      <Progress value={score} className="mt-2 h-2" />
    </div>
  );
}

export function AIFeedback({ evaluation, type }: AIFeedbackProps) {
  return (
    <div className="space-y-6">
      {/* Transcription for speaking tests */}
      {type === 'speaking' && evaluation.transcription && (
        <Card>
          <CardHeader>
            <CardTitle className="text-lg">Transkription</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-sm italic text-muted-foreground">
              "{evaluation.transcription}"
            </p>
          </CardContent>
        </Card>
      )}

      {/* Score Grid */}
      <div className="grid grid-cols-2 gap-4">
        <ScoreCard title="Grammatik" score={evaluation.grammar.score} />
        <ScoreCard title="Wortschatz" score={evaluation.vocabulary.score} />
        <ScoreCard title="Struktur" score={evaluation.structure.score} />
        <ScoreCard title="Inhalt" score={evaluation.content.score} />
        {type === 'speaking' && evaluation.fluency && (
          <ScoreCard title="Flüssigkeit" score={evaluation.fluency.score} />
        )}
      </div>

      {/* Overall Score */}
      <Card className="bg-gradient-to-br from-primary/10 to-primary/5">
        <CardContent className="pt-6">
          <div className="text-center">
            <p className="text-sm font-medium text-muted-foreground mb-2">
              Gesamtbewertung
            </p>
            <div className="text-5xl font-bold text-primary mb-2">
              {evaluation.overall_score}
              <span className="text-2xl text-muted-foreground">/100</span>
            </div>
            <div className="inline-flex items-center gap-2 rounded-full bg-primary/20 px-4 py-1">
              <span className="text-sm font-semibold text-primary">
                CEFR-Niveau: {evaluation.cefr_level}
              </span>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Detailed Feedback */}
      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Detailliertes Feedback</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm leading-relaxed whitespace-pre-wrap">
            {evaluation.feedback}
          </p>
        </CardContent>
      </Card>

      {/* Grammar Errors */}
      {evaluation.grammar.errors && evaluation.grammar.errors.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-lg flex items-center gap-2">
              <AlertCircle className="h-5 w-5 text-orange-600" />
              Grammatikfehler
            </CardTitle>
          </CardHeader>
          <CardContent>
            <ul className="space-y-2">
              {evaluation.grammar.errors.map((error, i) => (
                <li key={i} className="flex items-start gap-2 text-sm">
                  <span className="text-orange-600 mt-0.5">•</span>
                  <span>{error}</span>
                </li>
              ))}
            </ul>
            {evaluation.grammar.suggestions && evaluation.grammar.suggestions.length > 0 && (
              <div className="mt-4 pt-4 border-t">
                <p className="text-sm font-medium mb-2">Korrekturen:</p>
                <ul className="space-y-2">
                  {evaluation.grammar.suggestions.map((suggestion, i) => (
                    <li key={i} className="flex items-start gap-2 text-sm text-green-700">
                      <CheckCircle className="h-4 w-4 mt-0.5 flex-shrink-0" />
                      <span>{suggestion}</span>
                    </li>
                  ))}
                </ul>
              </div>
            )}
          </CardContent>
        </Card>
      )}

      {/* Vocabulary Suggestions */}
      {evaluation.vocabulary.suggestions && evaluation.vocabulary.suggestions.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-lg">Wortschatz-Verbesserungen</CardTitle>
          </CardHeader>
          <CardContent>
            <ul className="space-y-2">
              {evaluation.vocabulary.suggestions.map((suggestion, i) => (
                <li key={i} className="flex items-start gap-2 text-sm">
                  <CheckCircle className="h-4 w-4 text-blue-600 mt-0.5 flex-shrink-0" />
                  <span>{suggestion}</span>
                </li>
              ))}
            </ul>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
