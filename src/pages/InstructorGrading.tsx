import { useEffect, useState } from "react";
import { useParams, Link, useNavigate } from "react-router-dom";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { toast } from "sonner";
import { Loader2, ArrowLeft, Check, X, GraduationCap, Mic, PenLine, Save, HelpCircle } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/contexts/AuthContext";
import { getRecordingPlaybackUrl, isStorageRecordingPath } from "@/lib/recordings";
import { Textarea } from "@/components/ui/textarea";

interface TestAttempt {
  id: string;
  user_id: string;
  score: number | null;
  max_score: number;
  percentage: number | null;
  completed_at: string;
  test_module: {
    id: string;
    title: string;
    level: {
      code: string;
    };
    skill: {
      code: string;
      name_de: string;
    };
  } | null;
  profile: {
    full_name: string | null;
    email: string;
  } | null;
}

interface Answer {
  id: string;
  user_answer: string;
  is_correct: boolean | null;
  points_earned: number | null;
  question: {
    id: string;
    question_text: string;
    question_type: 'multiple_choice' | 'fill_blank' | 'essay' | 'audio' | 'speaking';
    correct_answer: string;
    explanation: string | null;
    points: number;
    order: number;
    rubric?: Record<string, string> | null;
  };
}

export default function InstructorGrading() {
  const { attemptId } = useParams<{ attemptId: string }>();
  const { isAdmin, user } = useAuth();
  const navigate = useNavigate();
  const [attempt, setAttempt] = useState<TestAttempt | null>(null);
  const [answers, setAnswers] = useState<Answer[]>([]);
  const [grades, setGrades] = useState<Record<string, { is_correct: boolean | null; points_earned: number; instructor_feedback?: string }>>({});
  const [audioUrls, setAudioUrls] = useState<Record<string, string>>({});
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (!isAdmin && !loading) {
      navigate("/");
    }
  }, [isAdmin, loading]);

  useEffect(() => {
    loadAttemptData();
  }, [attemptId]);

  const loadAttemptData = async () => {
    if (!attemptId) return;
    setLoading(true);

    try {
      // 1. Fetch test attempt details
      const { data: attemptData, error: attemptError } = await supabase
        .from('test_attempts')
        .select(`
          *,
          profile:profiles!test_attempts_user_id_fkey(full_name, email),
          test_module:test_modules(
            id,
            title,
            level:levels(code),
            skill:skills(code, name_de)
          )
        `)
        .eq('id', attemptId)
        .single();

      if (attemptError) throw attemptError;
      setAttempt(attemptData as any);

      // 2. Fetch answers with questions details
      const { data: answersData, error: answersError } = await supabase
        .from('test_answers')
        .select(`
          id,
          user_answer,
          is_correct,
          points_earned,
          question:questions!test_answers_question_id_fkey(
            id,
            question_text,
            question_type,
            correct_answer,
            explanation,
            points,
            order,
            rubric
          )
        `)
        .eq('test_attempt_id', attemptId)
        .order('question(order)', { ascending: true });

      if (answersError) throw answersError;

      const formattedAnswers = (answersData as any) || [];
      setAnswers(formattedAnswers);

      // Initialize grading state for open-ended questions
      const initialGrades: Record<string, { is_correct: boolean | null; points_earned: number }> = {};
      formattedAnswers.forEach((ans: Answer) => {
        if (ans.question.question_type === 'essay' || ans.question.question_type === 'speaking') {
          initialGrades[ans.id] = {
            is_correct: ans.is_correct,
            points_earned: ans.points_earned !== null ? ans.points_earned : 0,
            instructor_feedback: '',
          };
        }
      });
      setGrades(initialGrades);

      const speakingUrls: Record<string, string> = {};
      for (const ans of formattedAnswers) {
        if (ans.question.question_type === 'speaking' && ans.user_answer) {
          try {
            speakingUrls[ans.id] = await getRecordingPlaybackUrl(ans.user_answer);
          } catch {
            speakingUrls[ans.id] = getAudioUrl(ans.user_answer);
          }
        }
      }
      setAudioUrls(speakingUrls);
    } catch (err) {
      console.error("Error loading grading data:", err);
      toast.error("Failed to load submission data");
    } finally {
      setLoading(false);
    }
  };

  const handleGradeChange = (answerId: string, isCorrect: boolean, maxPoints: number) => {
    const current = grades[answerId] || { is_correct: null, points_earned: 0 };
    setGrades({
      ...grades,
      [answerId]: {
        is_correct: isCorrect,
        points_earned: isCorrect ? maxPoints : 0,
      },
    });
  };

  const handlePointsChange = (answerId: string, points: number, maxPoints: number) => {
    const validatedPoints = Math.min(Math.max(0, points), maxPoints);
    const isCorrect = validatedPoints > 0;
    
    setGrades({
      ...grades,
      [answerId]: {
        is_correct: isCorrect,
        points_earned: validatedPoints,
      },
    });
  };

  const handleSubmitGrades = async () => {
    if (!attempt || !attemptId) return;
    setSubmitting(true);

    try {
      // 1. Update test_answers
      const updatePromises = Object.entries(grades).map(([answerId, grade]) => {
        return supabase
          .from('test_answers')
          .update({
            is_correct: grade.is_correct,
            points_earned: grade.points_earned,
            instructor_feedback: grade.instructor_feedback || null,
            graded_by: user?.id ?? null,
            graded_at: new Date().toISOString(),
          })
          .eq('id', answerId);
      });

      const results = await Promise.all(updatePromises);
      const error = results.find(r => r.error);
      if (error) throw error.error;

      // 2. Fetch all answers for this attempt to recalculate total
      const { data: updatedAnswers, error: fetchError } = await supabase
        .from('test_answers')
        .select('points_earned')
        .eq('test_attempt_id', attemptId);

      if (fetchError) throw fetchError;

      const totalScore = updatedAnswers.reduce((sum, ans) => sum + (ans.points_earned || 0), 0);
      const percentage = attempt.max_score > 0 ? Math.round((totalScore / attempt.max_score) * 100) : 0;

      // 3. Update test attempt total score & percentage
      const { error: attemptUpdateError } = await supabase
        .from('test_attempts')
        .update({
          score: totalScore,
          percentage: percentage
        })
        .eq('id', attemptId);

      if (attemptUpdateError) throw attemptUpdateError;

      toast.success("Submission successfully graded!");
      navigate("/admin/grading");
    } catch (err) {
      console.error("Error saving grades:", err);
      toast.error("Failed to submit grades");
    } finally {
      setSubmitting(false);
    }
  };

  const getAudioUrl = (answer: string) => {
    if (!answer) return "";
    if (answer.startsWith('data:audio')) return answer;
    if (isStorageRecordingPath(answer)) return "";
    return `data:audio/webm;base64,${answer}`;
  };

  if (loading) {
    return (
      <div className="flex min-h-screen flex-col">
        <Header />
        <main className="flex flex-1 items-center justify-center">
          <div className="text-center">
            <Loader2 className="h-8 w-8 animate-spin text-primary mx-auto mb-4" />
            <p className="text-muted-foreground">Loading test submission...</p>
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
            <h2 className="text-xl font-bold mb-4">Submission not found</h2>
            <Button asChild>
              <Link to="/admin/grading">Back to Dashboard</Link>
            </Button>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  const mcqAnswers = answers.filter(a => a.question.question_type === 'multiple_choice');
  const openEndedAnswers = answers.filter(a => a.question.question_type === 'essay' || a.question.question_type === 'speaking');

  // Compute live scores
  const gradedMcqPoints = mcqAnswers.reduce((sum, a) => sum + (a.points_earned || 0), 0);
  const liveOpenEndedPoints = Object.values(grades).reduce((sum, g) => sum + (g.points_earned || 0), 0);
  const currentTotal = gradedMcqPoints + liveOpenEndedPoints;
  const currentPercentage = attempt.max_score > 0 ? Math.round((currentTotal / attempt.max_score) * 100) : 0;

  const allGraded = openEndedAnswers.every(a => grades[a.id]?.is_correct !== null);

  return (
    <div className="flex min-h-screen flex-col bg-slate-50/50">
      <Header />
      <main className="flex-1 py-12">
        <div className="container max-w-6xl">
          <div className="mb-6">
            <Link
              to="/admin/grading"
              className="inline-flex items-center gap-2 text-sm font-medium text-muted-foreground hover:text-foreground transition-colors"
            >
              <ArrowLeft className="h-4 w-4" />
              Back to Grading Dashboard
            </Link>
          </div>

          <div className="grid gap-6 lg:grid-cols-3">
            {/* Main Grading Column */}
            <div className="lg:col-span-2 space-y-6">
              <div>
                <div className="flex items-center gap-2 text-primary font-semibold mb-1">
                  <GraduationCap className="h-5 w-5" />
                  Evaluate Submission
                </div>
                <h1 className="text-3xl font-bold tracking-tight">
                  {attempt.test_module?.title || "German Assessment"}
                </h1>
                <p className="text-muted-foreground mt-1">
                  Level: <span className="font-semibold text-slate-800">{attempt.test_module?.level.code}</span> •
                  Skill: <span className="font-semibold text-slate-800">{attempt.test_module?.skill.name_de}</span>
                </p>
              </div>

              {/* Open-Ended Questions (Actionable) */}
              <div className="space-y-6">
                <h2 className="text-xl font-bold text-slate-800">Open-Ended Questions</h2>
                {openEndedAnswers.map((ans, index) => {
                  const currentGrade = grades[ans.id] || { is_correct: null, points_earned: 0 };
                  const maxPoints = ans.question.points || 5;

                  return (
                    <Card key={ans.id} className="bg-white border shadow-sm">
                      <CardHeader className="pb-3 border-b border-slate-100">
                        <div className="flex items-center justify-between">
                          <div className="flex items-center gap-2">
                            <span className="font-bold text-slate-900 text-lg">Question {index + 1}</span>
                            <Badge variant="secondary" className="gap-1 px-2 py-0.5 font-medium">
                              {ans.question.question_type === 'speaking' ? <Mic className="h-3 w-3" /> : <PenLine className="h-3 w-3" />}
                              {ans.question.question_type === 'speaking' ? 'Speaking / Sprechen' : 'Writing / Schreiben'}
                            </Badge>
                          </div>
                          <span className="text-sm font-semibold text-slate-500">Max Points: {maxPoints}</span>
                        </div>
                      </CardHeader>
                      <CardContent className="pt-5 space-y-4">
                        {/* Prompt */}
                        <div>
                          <p className="text-sm font-bold text-slate-800 flex items-center gap-1.5 mb-1.5">
                            <HelpCircle className="h-4.5 w-4.5 text-primary" />
                            Question Prompt:
                          </p>
                          <p className="text-slate-700 bg-slate-50 border border-slate-100 rounded-md p-3.5 text-sm leading-relaxed whitespace-pre-line">
                            {ans.question.question_text}
                          </p>
                        </div>

                        {/* Student Answer */}
                        <div>
                          <p className="text-sm font-bold text-slate-800 mb-1.5">Student Submission:</p>
                          <div className="bg-white border rounded-md p-4 shadow-inner text-slate-900 min-h-[100px] leading-relaxed">
                            {ans.question.question_type === 'speaking' ? (
                              <div className="space-y-3">
                                {ans.user_answer ? (
                                  <>
                                    <p className="text-sm text-slate-500 italic mb-2">Student audio recording:</p>
                                    <audio 
                                      controls 
                                      className="w-full"
                                      src={audioUrls[ans.id] || getAudioUrl(ans.user_answer)}
                                    />
                                  </>
                                ) : (
                                  <p className="text-sm text-red-500 italic">No audio recording submitted.</p>
                                )}
                              </div>
                            ) : (
                              <p className="whitespace-pre-wrap text-sm">
                                {ans.user_answer || <span className="text-red-500 italic">No answer submitted.</span>}
                              </p>
                            )}
                          </div>
                        </div>

                        {/* Model Answer */}
                        <div>
                          <p className="text-sm font-bold text-slate-800 mb-1.5">Model Answer / Grading Rubric:</p>
                          <p className="text-slate-600 bg-blue-50/50 border border-blue-100/50 rounded-md p-3.5 text-sm leading-relaxed whitespace-pre-line">
                            {ans.question.correct_answer || "N/A"}
                          </p>
                        </div>

                        {ans.question.rubric && (
                          <div>
                            <p className="text-sm font-bold text-slate-800 mb-2">Goethe rubric (4 dimensions):</p>
                            <div className="grid gap-2 sm:grid-cols-2">
                              {Object.entries(ans.question.rubric).map(([key, hint]) => (
                                <div key={key} className="rounded-md border bg-slate-50 px-3 py-2 text-sm">
                                  <span className="font-medium capitalize">{key.replace(/_/g, ' ')}: </span>
                                  <span className="text-muted-foreground">{hint}</span>
                                </div>
                              ))}
                            </div>
                          </div>
                        )}

                        <div>
                          <p className="text-sm font-bold text-slate-800 mb-1.5">Instructor Feedback (optional):</p>
                          <Textarea
                            value={currentGrade.instructor_feedback ?? ''}
                            onChange={(e) =>
                              setGrades({
                                ...grades,
                                [ans.id]: { ...currentGrade, instructor_feedback: e.target.value },
                              })
                            }
                            placeholder="Feedback for the student..."
                            rows={3}
                          />
                        </div>

                        {/* Grading Controls */}
                        <div className="pt-4 border-t border-slate-100 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                          <div className="flex items-center gap-2">
                            <Button
                              type="button"
                              variant={currentGrade.is_correct === true ? "default" : "outline"}
                              className={currentGrade.is_correct === true ? "bg-emerald-600 hover:bg-emerald-700 text-white border-emerald-600" : "hover:bg-slate-50"}
                              onClick={() => handleGradeChange(ans.id, true, maxPoints)}
                            >
                              <Check className="mr-1.5 h-4 w-4" />
                              Pass / Correct
                            </Button>
                            <Button
                              type="button"
                              variant={currentGrade.is_correct === false ? "destructive" : "outline"}
                              onClick={() => handleGradeChange(ans.id, false, maxPoints)}
                            >
                              <X className="mr-1.5 h-4 w-4" />
                              Fail / Incorrect
                            </Button>
                          </div>

                          <div className="flex items-center gap-3">
                            <label className="text-sm font-semibold text-slate-700 whitespace-nowrap">
                              Points Awarded:
                            </label>
                            <div className="flex items-center gap-1.5">
                              <Input
                                type="number"
                                min={0}
                                max={maxPoints}
                                value={currentGrade.points_earned}
                                onChange={(e) => handlePointsChange(ans.id, parseInt(e.target.value) || 0, maxPoints)}
                                className="w-20 text-center"
                              />
                              <span className="text-sm text-slate-500">/ {maxPoints}</span>
                            </div>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  );
                })}
              </div>
            </div>

            {/* Sidebar Summary & Info */}
            <div className="space-y-6">
              {/* Student Card */}
              <Card className="bg-white border shadow-sm">
                <CardHeader>
                  <CardTitle className="text-lg">Student Profile</CardTitle>
                </CardHeader>
                <CardContent className="space-y-3.5">
                  <div>
                    <p className="text-xs text-muted-foreground font-medium uppercase tracking-wider">Full Name</p>
                    <p className="font-semibold text-slate-900 mt-0.5">
                      {attempt.profile?.full_name || "Anonymous User"}
                    </p>
                  </div>
                  <div>
                    <p className="text-xs text-muted-foreground font-medium uppercase tracking-wider">Email Address</p>
                    <p className="font-semibold text-slate-900 mt-0.5">
                      {attempt.profile?.email}
                    </p>
                  </div>
                  <div>
                    <p className="text-xs text-muted-foreground font-medium uppercase tracking-wider">Submitted At</p>
                    <p className="font-semibold text-slate-900 mt-0.5">
                      {new Date(attempt.completed_at).toLocaleString('en-US', {
                        year: 'numeric',
                        month: 'long',
                        day: 'numeric',
                        hour: '2-digit',
                        minute: '2-digit'
                      })}
                    </p>
                  </div>
                </CardContent>
              </Card>

              {/* Grading Summary */}
              <Card className="bg-white border shadow-sm sticky top-6">
                <CardHeader>
                  <CardTitle className="text-lg">Grading Status</CardTitle>
                  <CardDescription>Overall score calculates live.</CardDescription>
                </CardHeader>
                <CardContent className="space-y-6">
                  {/* Score Meter */}
                  <div className="text-center py-4 bg-slate-50 rounded-lg border border-slate-100">
                    <div className="text-4xl font-extrabold text-primary">
                      {currentPercentage}%
                    </div>
                    <p className="text-sm text-muted-foreground mt-1.5">
                      Live Grade: <span className="font-bold text-slate-800">{currentTotal}</span> / {attempt.max_score} points
                    </p>
                  </div>

                  <div className="space-y-3.5 text-sm">
                    <div className="flex justify-between border-b border-slate-100 pb-2">
                      <span className="text-muted-foreground">Auto-graded (MCQ):</span>
                      <span className="font-bold text-slate-800">{gradedMcqPoints} pts</span>
                    </div>
                    <div className="flex justify-between border-b border-slate-100 pb-2">
                      <span className="text-muted-foreground">Manual Open-Ended:</span>
                      <span className="font-bold text-slate-800">{liveOpenEndedPoints} pts</span>
                    </div>
                    <div className="flex justify-between font-bold pt-1.5 text-slate-900 text-base">
                      <span>Total Score:</span>
                      <span>{currentTotal} / {attempt.max_score} pts</span>
                    </div>
                  </div>

                  <div className="pt-2">
                    <Button
                      onClick={handleSubmitGrades}
                      disabled={submitting || !allGraded}
                      className="w-full gap-2 shadow-sm font-semibold"
                    >
                      {submitting ? (
                        <Loader2 className="h-4 w-4 animate-spin" />
                      ) : (
                        <Save className="h-4 w-4" />
                      )}
                      Submit Grading
                    </Button>
                    {!allGraded && (
                      <p className="text-xs text-amber-600 text-center mt-2.5 leading-normal">
                        Please evaluate all open-ended questions before submitting.
                      </p>
                    )}
                  </div>
                </CardContent>
              </Card>
            </div>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}
