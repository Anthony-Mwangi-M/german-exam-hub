import { useParams, Link, useNavigate } from "react-router-dom";
import { useEffect, useState } from "react";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { CheckCircle, XCircle, Loader2, Trophy, ArrowLeft, Clock, PenLine, Mic } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/contexts/AuthContext";
import { getRecordingPlaybackUrl } from "@/lib/recordings";

interface TestAttempt {
  id: string;
  score: number;
  completed_at: string;
  test_module: {
    id: string;
    title: string;
    level: {
      code: string;
    };
    skill: {
      name_de: string;
    };
  };
}

interface QuestionResult {
  question_text: string;
  user_answer: string;
  correct_answer: string;
  is_correct: boolean | null;
  explanation?: string;
  question_type: string;
  task_type?: string;
  instructor_feedback?: string | null;
  playback_url?: string;
}

export default function TestResults() {
  const { moduleId, attemptId } = useParams<{ moduleId: string; attemptId: string }>();
  const navigate = useNavigate();
  const { user } = useAuth();
  const [attempt, setAttempt] = useState<TestAttempt | null>(null);
  const [results, setResults] = useState<QuestionResult[]>([]);
  const [loading, setLoading] = useState(true);
  const [showAnswers, setShowAnswers] = useState(false);

  useEffect(() => {
    loadResults();
  }, [attemptId]);

  const loadResults = async () => {
    if (!user || !attemptId) return;

    setLoading(true);

    // Load test attempt
    const { data: attemptData } = await supabase
      .from('test_attempts')
      .select(`
        *,
        test_module:test_modules(
          id,
          title,
          level:levels(code),
          skill:skills(name_de)
        )
      `)
      .eq('id', attemptId)
      .eq('user_id', user.id)
      .single();

    if (attemptData) {
      setAttempt(attemptData);

      // Load answers with questions
      const { data: answersData } = await supabase
        .from('test_answers')
        .select(`
          user_answer,
          is_correct,
          instructor_feedback,
          question:questions!test_answers_question_id_fkey(
            question_text,
            correct_answer,
            explanation,
            question_type
          )
        `)
        .eq('test_attempt_id', attemptId);

      if (answersData) {
        const formattedResults = await Promise.all(
          answersData.map(async (answer: any) => {
            const questionType = answer.question.question_type;
            let playback_url: string | undefined;

            if (questionType === 'speaking' && answer.user_answer) {
              try {
                playback_url = await getRecordingPlaybackUrl(answer.user_answer);
              } catch {
                playback_url = undefined;
              }
            }

            return {
              question_text: answer.question.question_text,
              user_answer: answer.user_answer,
              correct_answer: answer.question.correct_answer,
              is_correct: answer.is_correct,
              explanation: answer.question.explanation,
              question_type: questionType,
              instructor_feedback: answer.instructor_feedback,
              playback_url,
            };
          })
        );
        setResults(formattedResults);
      }
    }

    setLoading(false);
  };

  if (loading) {
    return (
      <div className="flex min-h-screen flex-col">
        <Header />
        <main className="flex flex-1 items-center justify-center">
          <div className="text-center">
            <Loader2 className="h-8 w-8 animate-spin text-primary mx-auto mb-4" />
            <p className="text-muted-foreground">Loading results...</p>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  if (!attempt) {
    return (
      <div className="flex min-h-screen flex-col">
        <Header />
        <main className="flex flex-1 items-center justify-center">
          <div className="text-center">
            <h1 className="mb-4 text-2xl font-bold">Results not found</h1>
            <Button asChild>
              <Link to="/">Go Home</Link>
            </Button>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  const mcqResults = results.filter((r) => r.question_type === 'multiple_choice');
  const openEndedResults = results.filter((r) => r.question_type === 'essay' || r.question_type === 'speaking');
  const correctCount = mcqResults.filter((r) => r.is_correct === true).length;
  const totalMcq = mcqResults.length;
  const totalQuestions = results.length;
  const percentage = attempt.score;
  const hasPending = openEndedResults.length > 0;

  const getScoreColor = (score: number) => {
    if (score >= 85) return 'text-green-600';
    if (score >= 70) return 'text-blue-600';
    if (score >= 50) return 'text-orange-600';
    return 'text-red-600';
  };

  const getScoreMessage = (score: number) => {
    if (score >= 85) return 'Excellent work!';
    if (score >= 70) return 'Great job!';
    if (score >= 50) return 'Good effort!';
    return 'Keep practicing!';
  };

  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1 py-12">
        <div className="container max-w-4xl">
          <Link
            to={`/level/${attempt.test_module.level.code.toLowerCase()}`}
            className="mb-6 inline-flex items-center gap-2 text-sm font-medium text-muted-foreground transition-colors hover:text-foreground"
          >
            <ArrowLeft className="h-4 w-4" />
            Back to {attempt.test_module.level.code} tests
          </Link>

          {/* Score Card */}
          <Card className="mb-8">
            <CardHeader className="text-center pb-4">
              <div className="mx-auto mb-4 flex h-24 w-24 items-center justify-center rounded-full bg-primary/10">
                <Trophy className="h-12 w-12 text-primary" />
              </div>
              <CardTitle className="text-3xl">{getScoreMessage(percentage)}</CardTitle>
            </CardHeader>
            <CardContent className="text-center">
              <div className="mb-6">
                <div className={`text-6xl font-bold ${getScoreColor(percentage)}`}>
                  {percentage}%
                </div>
                <p className="mt-2 text-muted-foreground">
                  {totalMcq > 0
                    ? `${correctCount} of ${totalMcq} multiple choice correct`
                    : 'Submitted for review'}
                </p>
                {hasPending && (
                  <p className="mt-1 text-sm text-amber-600">
                    + {openEndedResults.length} open-ended answer{openEndedResults.length > 1 ? 's' : ''} pending instructor review
                  </p>
                )}
              </div>

              <div className="mb-6 rounded-lg bg-muted p-4">
                <h3 className="font-semibold mb-2">{attempt.test_module.title}</h3>
                <p className="text-sm text-muted-foreground">
                  {attempt.test_module.level.code} • {attempt.test_module.skill.name_de}
                </p>
                <p className="text-xs text-muted-foreground mt-2">
                  Completed on {new Date(attempt.completed_at).toLocaleDateString('en-US', {
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric',
                    hour: '2-digit',
                    minute: '2-digit',
                  })}
                </p>
              </div>


              <div className="flex gap-4 justify-center">
                <Button
                  variant="outline"
                  onClick={() => setShowAnswers(!showAnswers)}
                >
                  {showAnswers ? 'Hide' : 'Review'} Answers
                </Button>
                <Button asChild>
                  <Link to={`/test/${moduleId}`}>Retake Test</Link>
                </Button>
              </div>

              {/* Instructor review notice if any open-ended questions */}
              {results.some(r => r.question_type === 'essay' || r.question_type === 'speaking') && (
                <div className="mt-6 rounded-lg border border-amber-200 bg-amber-50 p-4 text-left">
                  <div className="flex items-start gap-3">
                    <Clock className="h-5 w-5 text-amber-600 flex-shrink-0 mt-0.5" />
                    <div>
                      <p className="font-medium text-amber-900">Instructor Review Pending</p>
                      <p className="text-sm text-amber-700 mt-1">
                        Your writing and speaking answers have been submitted and are awaiting instructor review.
                        Check back on this results page for your full grade.
                      </p>
                    </div>
                  </div>
                </div>
              )}
            </CardContent>
          </Card>

          {/* Answer Review */}
          {showAnswers && (
            <div className="space-y-4">
              <h2 className="text-2xl font-bold mb-4">Answer Review</h2>
              {results.map((result, index) => (
                <Card key={index}>
                  <CardContent className="pt-6">
                    <div className="flex items-start gap-3 mb-4">
                      {result.is_correct === true ? (
                        <CheckCircle className="h-6 w-6 text-green-600 flex-shrink-0 mt-1" />
                      ) : result.is_correct === false ? (
                        <XCircle className="h-6 w-6 text-red-600 flex-shrink-0 mt-1" />
                      ) : (
                        <Clock className="h-6 w-6 text-amber-600 flex-shrink-0 mt-1" />
                      )}
                      <div className="flex-1">
                        <h3 className="font-semibold mb-2">
                          Question {index + 1}
                        </h3>
                        <p className="text-muted-foreground mb-4">{result.question_text}</p>

                        {/* Instructor-graded: essay and speaking */}
                        {(result.question_type === 'essay' || result.question_type === 'speaking') && (
                          <div className="space-y-3">
                            <div className="rounded-lg bg-muted p-3">
                              <div className="flex items-center gap-2 mb-2">
                                {result.question_type === 'speaking'
                                  ? <Mic className="h-4 w-4 text-muted-foreground" />
                                  : <PenLine className="h-4 w-4 text-muted-foreground" />
                                }
                                <p className="text-sm font-medium">
                                  {result.question_type === 'speaking' ? 'Your recording' : 'Your answer'}:
                                </p>
                              </div>
                              {result.question_type === 'speaking' ? (
                                result.playback_url ? (
                                  <audio controls className="w-full" src={result.playback_url} />
                                ) : (
                                  <p className="text-sm text-muted-foreground italic">
                                    Audio recording submitted
                                  </p>
                                )
                              ) : (
                                <p className="text-sm whitespace-pre-wrap">
                                  {result.user_answer || '(No answer provided)'}
                                </p>
                              )}
                            </div>
                            {result.is_correct === null ? (
                              <Badge variant="outline" className="gap-1.5 text-amber-700 border-amber-300 bg-amber-50">
                                <Clock className="h-3 w-3" />
                                Pending instructor review
                              </Badge>
                            ) : (
                              <div className="space-y-2">
                                <div className={`rounded-lg p-3 ${result.is_correct ? 'bg-green-50 text-green-900 border border-green-200' : 'bg-red-50 text-red-900 border border-red-200'}`}>
                                  <p className="text-sm font-medium">
                                    Instructor Grade: {result.is_correct ? 'Correct / Pass' : 'Incorrect / Needs Improvement'}
                                  </p>
                                  {result.instructor_feedback && (
                                    <p className="text-sm mt-2 whitespace-pre-wrap">{result.instructor_feedback}</p>
                                  )}
                                </div>
                                <div className="rounded-lg bg-blue-50 p-3 text-blue-900 border border-blue-200">
                                  <p className="text-sm font-medium mb-1">Model Answer / Criteria:</p>
                                  <p className="text-sm whitespace-pre-wrap text-blue-700">{result.correct_answer}</p>
                                </div>
                              </div>
                            )}
                          </div>
                        )}

                        {/* Auto-graded: multiple choice */}
                        {result.question_type === 'multiple_choice' && (
                          <div className="space-y-2">
                            <div className="rounded-lg bg-muted p-3">
                              <p className="text-sm font-medium mb-1">Your answer:</p>
                              <p className={result.is_correct ? 'text-green-700' : 'text-red-700'}>
                                {result.user_answer || '(No answer provided)'}
                              </p>
                            </div>

                            {!result.is_correct && (
                              <div className="rounded-lg bg-green-50 p-3">
                                <p className="text-sm font-medium mb-1 text-green-900">Correct answer:</p>
                                <p className="text-green-700">{result.correct_answer}</p>
                              </div>
                            )}

                            {result.explanation && (
                              <div className="rounded-lg bg-blue-50 p-3">
                                <p className="text-sm font-medium mb-1 text-blue-900">Explanation:</p>
                                <p className="text-sm text-blue-700">{result.explanation}</p>
                              </div>
                            )}
                          </div>
                        )}
                      </div>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </div>
      </main>
      <Footer />
    </div>
  );
}
