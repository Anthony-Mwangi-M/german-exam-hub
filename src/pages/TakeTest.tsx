import { useParams, useNavigate, Link } from "react-router-dom";
import { useEffect, useState } from "react";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { ArrowLeft, ArrowRight, Clock, Loader2, CheckCircle } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/contexts/AuthContext";
import { toast } from "@/hooks/use-toast";
import { VoiceRecorder } from "@/components/VoiceRecorder";
import { isListeningComingSoon, LISTENING_COMING_SOON_MESSAGE } from "@/lib/moduleAvailability";
import { SPEAKING_ANSWER_MARKER, uploadSpeakingRecording } from "@/lib/recordings";
import { formatWordLimit, getTeilInstruction } from "@/lib/examDisplay";

interface Question {
  id: string;
  question_text: string;
  question_type: 'multiple_choice' | 'fill_blank' | 'essay' | 'audio' | 'speaking';
  options?: any;
  correct_answer?: string;
  explanation?: string;
  points?: number;
  order: number;
  audio_url?: string;
  exam_part?: number | null;
  task_type?: string | null;
  word_limit_min?: number | null;
  word_limit_max?: number | null;
  leitpunkte?: string[] | null;
}

interface TestModule {
  id: string;
  title: string;
  duration_minutes: number;
  level: {
    code: string;
  };
  skill: {
    code: string;
    name_de: string;
  };
}

export default function TakeTest() {
  const { moduleId } = useParams<{ moduleId: string }>();
  const navigate = useNavigate();
  const { user } = useAuth();
  const [testModule, setTestModule] = useState<TestModule | null>(null);
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [answers, setAnswers] = useState<Record<string, string>>({});
  const [speakingBlobs, setSpeakingBlobs] = useState<Record<string, Blob>>({});
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [timeRemaining, setTimeRemaining] = useState(0);
  const [testAttemptId, setTestAttemptId] = useState<string | null>(null);
  const [hasAccess, setHasAccess] = useState(false);

  useEffect(() => {
    loadTestData();
  }, [moduleId]);

  useEffect(() => {
    if (timeRemaining <= 0) return;

    const timer = setInterval(() => {
      setTimeRemaining((prev) => {
        if (prev <= 1) {
          handleSubmit();
          return 0;
        }
        return prev - 1;
      });
    }, 1000);

    return () => clearInterval(timer);
  }, [timeRemaining]);

  const loadTestData = async () => {
    if (!user || !moduleId) return;

    setLoading(true);

    // Load test module first (check skill availability before access flow)
    const { data: moduleData } = await supabase
      .from('test_modules')
      .select(`
        *,
        level:levels(code),
        skill:skills(code, name_de)
      `)
      .eq('id', moduleId)
      .single();

    if (!moduleData) {
      setLoading(false);
      return;
    }

    if (isListeningComingSoon((moduleData as TestModule).skill?.code)) {
      toast({
        title: "Coming soon",
        description: LISTENING_COMING_SOON_MESSAGE,
      });
      navigate(`/level/${(moduleData as TestModule).level.code.toLowerCase()}`);
      setLoading(false);
      return;
    }

    // Check if user has purchased this test
    const { data: purchase } = await supabase
      .from('purchases')
      .select('id')
      .eq('user_id', user.id)
      .eq('test_module_id', moduleId)
      .eq('status', 'completed')
      .single();

    if (!purchase) {
      toast({
        title: "Access denied",
        description: "You need to purchase this test first.",
        variant: "destructive",
      });
      navigate(`/purchase/${moduleId}`);
      setLoading(false);
      return;
    }

    setHasAccess(true);

    setTestModule(moduleData as TestModule);
    setTimeRemaining(moduleData.duration_minutes * 60);

    // Load questions
    const { data: questionsData } = await supabase
      .from('questions')
      .select('*')
      .eq('test_module_id', moduleId)
      .order('order');

    if (questionsData) {
      setQuestions(questionsData);

      const maxScore = questionsData.reduce((sum, q) => sum + (q.points || 1), 0);

      const { data: attempt, error: attemptError } = await supabase
        .from('test_attempts')
        .insert({
          user_id: user.id,
          test_module_id: moduleId,
          max_score: maxScore,
        } as any)
        .select()
        .single();

      if (attemptError) throw attemptError;
      if (attempt) {
        setTestAttemptId((attempt as any).id);
      }
    }

    setLoading(false);
  };

  const handleAnswerChange = (questionId: string, answer: string) => {
    setAnswers((prev) => ({
      ...prev,
      [questionId]: answer,
    }));
  };

  const handleNext = () => {
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex((prev) => prev + 1);
    }
  };

  const handlePrevious = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex((prev) => prev - 1);
    }
  };

  const handleSubmit = async () => {
    if (!testAttemptId || !user) return;

    setSubmitting(true);

    try {
      const answerRecords = await Promise.all(
        questions.map(async (q) => {
          let userAnswer = answers[q.id] || '';

          if (q.question_type === 'speaking') {
            const blob = speakingBlobs[q.id];
            if (blob) {
              userAnswer = await uploadSpeakingRecording(blob, user.id, testAttemptId, q.id);
            } else {
              userAnswer = '';
            }
          }

          const isOpenEnded = q.question_type === 'essay' || q.question_type === 'speaking';
          const isCorrect = isOpenEnded
            ? null
            : (q.question_type === 'multiple_choice' ? userAnswer === q.correct_answer : null);

          return {
            test_attempt_id: testAttemptId,
            question_id: q.id,
            user_answer: userAnswer,
            is_correct: isCorrect,
            points_earned: isOpenEnded ? null : (isCorrect ? (q.points || 1) : 0),
          };
        })
      );

      const { data: savedAnswers, error: answersError } = await supabase
        .from('test_answers')
        .insert(answerRecords as any)
        .select();

      if (answersError) throw answersError;

      // Calculate score from auto-gradable questions only (MCQ)
      const mcqAnswers = savedAnswers.filter((a: any) => {
        const q = questions.find(q => q.id === a.question_id);
        return q?.question_type === 'multiple_choice';
      });
      const mcqMaxPoints = mcqAnswers.reduce((sum: number, a: any) => {
        const q = questions.find((q) => q.id === a.question_id);
        return sum + (q?.points || 1);
      }, 0);
      const earnedMcqPoints = mcqAnswers.reduce(
        (sum: number, a: any) => sum + (a.points_earned || 0),
        0
      );

      // Open-ended questions are pending; score reflects MCQ only.
      // While instructor review is pending, percentage stays null so the UI
      // shows a pending state instead of an interim number. Instructor
      // grading writes the final score and percentage when review completes.
      const openEndedCount = questions.filter(
        q => q.question_type === 'essay' || q.question_type === 'speaking'
      ).length;
      const hasOpenEnded = openEndedCount > 0;
      const percentage = hasOpenEnded
        ? null
        : mcqMaxPoints > 0
          ? Math.round((earnedMcqPoints / mcqMaxPoints) * 100)
          : 0;

      // Update test attempt
      const { error: updateError } = await (supabase
        .from('test_attempts') as any)
        .update({
          score: earnedMcqPoints,
          percentage: percentage,
          completed_at: new Date().toISOString(),
        })
        .eq('id', testAttemptId);

      if (updateError) throw updateError;

      toast({
        title: "Test submitted",
        description: hasOpenEnded
          ? "Your instructor will review your answers. Your score will appear on the results page once grading is complete."
          : "Your results are ready.",
      });

      // Navigate to results
      navigate(`/test/${moduleId}/results/${testAttemptId}`);
    } catch (error: any) {
      console.error('Submit error:', error);
      toast({
        title: "Submission failed",
        description: error.message || "Something went wrong. Please try again.",
        variant: "destructive",
      });
      setSubmitting(false);
    }
  };

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  if (loading) {
    return (
      <div className="flex min-h-screen flex-col">
        <Header />
        <main className="flex flex-1 items-center justify-center">
          <div className="text-center">
            <Loader2 className="h-8 w-8 animate-spin text-primary mx-auto mb-4" />
            <p className="text-muted-foreground">Loading test...</p>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  if (!testModule || !hasAccess || questions.length === 0) {
    return (
      <div className="flex min-h-screen flex-col">
        <Header />
        <main className="flex flex-1 items-center justify-center">
          <div className="text-center">
            <h1 className="mb-4 text-2xl font-bold">Test not available</h1>
            <Button asChild>
              <Link to="/">Go Home</Link>
            </Button>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  const isQuestionAnswered = (question: Question) => {
    if (question.question_type === 'speaking') {
      return !!speakingBlobs[question.id];
    }
    return !!answers[question.id];
  };

  const currentQuestion = questions[currentQuestionIndex];
  const previousQuestion = currentQuestionIndex > 0 ? questions[currentQuestionIndex - 1] : null;
  const showTeilHeader =
    currentQuestion.exam_part != null &&
    currentQuestion.exam_part !== previousQuestion?.exam_part;
  const teilInstruction = getTeilInstruction(
    testModule.skill.code,
    currentQuestion.exam_part
  );
  const wordLimitLabel = formatWordLimit(
    currentQuestion.word_limit_min,
    currentQuestion.word_limit_max
  );
  const leitpunkte = Array.isArray(currentQuestion.leitpunkte)
    ? currentQuestion.leitpunkte
    : null;
  const progress = ((currentQuestionIndex + 1) / questions.length) * 100;
  const answeredCount = questions.filter(isQuestionAnswered).length;

  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1 py-8">
        <div className="container max-w-4xl">
          {/* Test Header */}
          <div className="mb-6 flex items-center justify-between">
            <div>
              <h1 className="text-2xl font-bold">{testModule.title}</h1>
              <p className="text-sm text-muted-foreground">
                {testModule.level.code} • {testModule.skill.name_de}
              </p>
            </div>
            <div className="flex items-center gap-2 rounded-lg bg-orange-50 px-4 py-2">
              <Clock className="h-5 w-5 text-orange-600" />
              <span className="font-mono text-lg font-semibold text-orange-900">
                {formatTime(timeRemaining)}
              </span>
            </div>
          </div>

          {/* Progress */}
          <div className="mb-8">
            <div className="mb-2 flex justify-between text-sm">
              <span className="text-muted-foreground">
                Question {currentQuestionIndex + 1} of {questions.length}
              </span>
              <span className="text-muted-foreground">
                {answeredCount} answered
              </span>
            </div>
            <Progress value={progress} className="h-2" />
          </div>

          {/* Question Card */}
          <Card className="mb-6">
            <CardContent className="pt-6">
              <div className="mb-6">
                {showTeilHeader && (
                  <div className="mb-4 rounded-2xl border border-border/60 bg-secondary/50 px-4 py-3">
                    <span className="dp-pill">Teil {currentQuestion.exam_part}</span>
                    {teilInstruction && (
                      <p className="text-sm text-muted-foreground mt-2">{teilInstruction}</p>
                    )}
                  </div>
                )}

                {/* Audio player for listening questions */}
                {currentQuestion.audio_url && (
                  <div className="mb-4 rounded-lg border p-4 bg-muted/50">
                    <audio 
                      controls 
                      className="w-full"
                      src={currentQuestion.audio_url}
                    >
                      Your browser does not support audio.
                    </audio>
                    <p className="text-xs text-muted-foreground mt-2">
                      Sie können die Aufnahme mehrmals anhören.
                    </p>
                  </div>
                )}

                <h2 className="text-lg font-semibold mb-4 whitespace-pre-line">
                  {currentQuestion.question_text}
                </h2>

                {leitpunkte && leitpunkte.length > 0 && (
                  <div className="mb-4 rounded-lg bg-muted/50 px-4 py-3">
                    <p className="text-sm font-medium mb-2">Schreiben Sie zu diesen Punkten:</p>
                    <ul className="list-disc list-inside space-y-1 text-sm text-muted-foreground">
                      {leitpunkte.map((point, i) => (
                        <li key={i}>{point}</li>
                      ))}
                    </ul>
                  </div>
                )}

                {wordLimitLabel && (
                  <p className="text-sm text-muted-foreground mb-4">{wordLimitLabel}</p>
                )}

                {currentQuestion.question_type === 'multiple_choice' && currentQuestion.options && (
                  <RadioGroup
                    value={answers[currentQuestion.id] || ''}
                    onValueChange={(value) => handleAnswerChange(currentQuestion.id, value)}
                  >
                    <div className="space-y-3">
                      {(Array.isArray(currentQuestion.options) 
                        ? currentQuestion.options 
                        : JSON.parse(currentQuestion.options || '[]')
                      ).map((option: string, index: number) => (
                        <div
                          key={index}
                          className="flex items-center space-x-3 rounded-lg border border-border p-4 hover:bg-muted/50 transition-colors"
                        >
                          <RadioGroupItem value={option} id={`option-${index}`} />
                          <Label
                            htmlFor={`option-${index}`}
                            className="flex-1 cursor-pointer font-normal"
                          >
                            {option}
                          </Label>
                        </div>
                      ))}
                    </div>
                  </RadioGroup>
                )}

                {currentQuestion.question_type === 'essay' && (
                  <Textarea
                    value={answers[currentQuestion.id] || ''}
                    onChange={(e) => handleAnswerChange(currentQuestion.id, e.target.value)}
                    placeholder="Schreiben Sie Ihre Antwort hier..."
                    rows={6}
                    className="resize-none"
                  />
                )}

                {currentQuestion.question_type === 'speaking' && (
                  <VoiceRecorder
                    key={currentQuestion.id}
                    existingRecording={speakingBlobs[currentQuestion.id] ?? null}
                    onRecordingComplete={(audioBlob) => {
                      setSpeakingBlobs((prev) => ({ ...prev, [currentQuestion.id]: audioBlob }));
                      handleAnswerChange(currentQuestion.id, SPEAKING_ANSWER_MARKER);
                    }}
                    onRecordingClear={() => {
                      setSpeakingBlobs((prev) => {
                        const next = { ...prev };
                        delete next[currentQuestion.id];
                        return next;
                      });
                      handleAnswerChange(currentQuestion.id, '');
                    }}
                    disabled={submitting}
                  />
                )}
              </div>
            </CardContent>
          </Card>

          {/* Navigation */}
          <div className="flex items-center justify-between">
            <Button
              variant="outline"
              onClick={handlePrevious}
              disabled={currentQuestionIndex === 0}
            >
              <ArrowLeft className="mr-2 h-4 w-4" />
              Previous
            </Button>

            <div className="flex gap-2">
              {questions.map((_, index) => (
                <button
                  key={index}
                  onClick={() => setCurrentQuestionIndex(index)}
                  className={`h-8 w-8 rounded-full text-sm font-medium transition-colors ${
                    index === currentQuestionIndex
                      ? 'bg-primary text-primary-foreground'
                      : isQuestionAnswered(questions[index])
                      ? 'bg-green-100 text-green-900'
                      : 'bg-muted text-muted-foreground hover:bg-muted/80'
                  }`}
                >
                  {index + 1}
                </button>
              ))}
            </div>

            {currentQuestionIndex === questions.length - 1 ? (
              <Button
                onClick={handleSubmit}
                disabled={submitting}
              >
                {submitting ? (
                  <>
                    <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                    Submitting...
                  </>
                ) : (
                  <>
                    Submit Test
                    <CheckCircle className="ml-2 h-4 w-4" />
                  </>
                )}
              </Button>
            ) : (
              <Button onClick={handleNext}>
                Next
                <ArrowRight className="ml-2 h-4 w-4" />
              </Button>
            )}
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}
