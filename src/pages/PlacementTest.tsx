import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { Header } from '@/components/layout/Header';
import { Footer } from '@/components/layout/Footer';
import { Button } from '@/components/ui/button';
import { supabase } from '@/lib/supabase';
import { useAuth } from '@/contexts/AuthContext';
import { Clock, CheckCircle, ArrowRight } from 'lucide-react';

interface Question {
  id: string;
  level_id: string;
  question_text: string;
  options: string[];
  correct_answer: string;
  points: number;
  order: number;
}

export default function PlacementTest() {
  const [started, setStarted] = useState(false);
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [answers, setAnswers] = useState<Record<string, string>>({});
  const [timeLeft, setTimeLeft] = useState(15 * 60); // 15 minutes
  const [loading, setLoading] = useState(false);
  const { user } = useAuth();
  const navigate = useNavigate();

  useEffect(() => {
    if (started && timeLeft > 0) {
      const timer = setInterval(() => {
        setTimeLeft((prev) => prev - 1);
      }, 1000);
      return () => clearInterval(timer);
    } else if (timeLeft === 0 && started) {
      handleSubmit();
    }
  }, [started, timeLeft]);

  const loadQuestions = async () => {
    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('placement_test_questions')
        .select('*')
        .order('order');

      if (error) {
        console.error('Error loading questions:', error);
        alert(`Error loading questions: ${error.message}`);
      } else if (!data || data.length === 0) {
        alert('No questions found. Please contact support.');
      } else {
        setQuestions(data || []);
        setStarted(true);
      }
    } catch (err) {
      console.error('Unexpected error:', err);
      alert('An unexpected error occurred. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleAnswer = (answer: string) => {
    setAnswers({ ...answers, [questions[currentIndex].id]: answer });
  };

  const handleNext = () => {
    if (currentIndex < questions.length - 1) {
      setCurrentIndex(currentIndex + 1);
    }
  };

  const handlePrevious = () => {
    if (currentIndex > 0) {
      setCurrentIndex(currentIndex - 1);
    }
  };

  const handleSubmit = async () => {
    if (!user) return;

    setLoading(true);

    // Calculate score
    let score = 0;
    let maxScore = 0;
    const levelScores: Record<string, { score: number; max: number }> = {};

    questions.forEach((q) => {
      maxScore += q.points;
      if (!levelScores[q.level_id]) {
        levelScores[q.level_id] = { score: 0, max: 0 };
      }
      levelScores[q.level_id].max += q.points;

      if (answers[q.id] === q.correct_answer) {
        score += q.points;
        levelScores[q.level_id].score += q.points;
      }
    });

    // Determine level based on performance
    let resultLevel = 'A1';
    const percentage = (score / maxScore) * 100;

    if (percentage >= 85) resultLevel = 'B2';
    else if (percentage >= 70) resultLevel = 'B1';
    else if (percentage >= 50) resultLevel = 'A2';
    else resultLevel = 'A1';

    // Save attempt to database
    const { error } = await supabase.from('test_attempts').insert({
      user_id: user.id,
      is_placement_test: true,
      score,
      max_score: maxScore,
      percentage: (score / maxScore) * 100,
      result_level: resultLevel,
      completed_at: new Date().toISOString(),
    });

    if (error) {
      console.error('Error saving test attempt:', error);
    }

    // Navigate to results
    navigate('/placement-test/results', {
      state: { score, maxScore, resultLevel, percentage },
    });
  };

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  if (!started) {
    return (
      <div className="flex min-h-screen flex-col">
        <Header />
        <main className="flex-1">
          <section className="border-b border-border py-16 md:py-24">
            <div className="container">
              <div className="mx-auto max-w-3xl text-center">
                <span className="mb-4 inline-block rounded-full bg-foreground px-4 py-1 text-sm font-semibold text-background">
                  100% FREE
                </span>
                <h1 className="mb-6 text-4xl font-bold text-foreground md:text-5xl">
                  Discover Your German Level
                </h1>
                <p className="mb-8 text-lg text-muted-foreground">
                  Take our placement test to find out your current level and get personalized recommendations.
                </p>

                <div className="mb-8 flex flex-wrap justify-center gap-6">
                  <div className="flex items-center gap-2">
                    <Clock className="h-5 w-5 text-primary" />
                    <span className="text-sm font-medium">15 minutes</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <CheckCircle className="h-5 w-5 text-primary" />
                    <span className="text-sm font-medium">20 questions</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <CheckCircle className="h-5 w-5 text-primary" />
                    <span className="text-sm font-medium">Instant results</span>
                  </div>
                </div>

                <Button size="lg" onClick={loadQuestions} disabled={loading}>
                  {loading ? 'Loading...' : 'Start Placement Test'}
                  <ArrowRight className="ml-2 h-5 w-5" />
                </Button>
              </div>
            </div>
          </section>
        </main>
        <Footer />
      </div>
    );
  }

  const currentQuestion = questions[currentIndex];
  const progress = ((currentIndex + 1) / questions.length) * 100;

  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1 bg-muted/30 py-8">
        <div className="container max-w-4xl">
          {/* Progress and Timer */}
          <div className="mb-6 flex items-center justify-between">
            <div className="flex-1">
              <div className="mb-2 flex items-center justify-between text-sm">
                <span className="font-medium">
                  Question {currentIndex + 1} of {questions.length}
                </span>
                <span className="text-muted-foreground">{Math.round(progress)}%</span>
              </div>
              <div className="h-2 overflow-hidden rounded-full bg-muted">
                <div
                  className="h-full bg-primary transition-all duration-300"
                  style={{ width: `${progress}%` }}
                />
              </div>
            </div>
            <div className="ml-6 flex items-center gap-2 rounded-lg bg-card px-4 py-2">
              <Clock className="h-4 w-4 text-primary" />
              <span className="font-mono text-sm font-medium">{formatTime(timeLeft)}</span>
            </div>
          </div>

          {/* Question Card */}
          <div className="rounded-2xl border border-border bg-card p-8 shadow-lg">
            <h2 className="mb-6 text-2xl font-medium text-foreground">
              {currentQuestion.question_text}
            </h2>

            <div className="space-y-3">
              {currentQuestion.options.map((option, idx) => (
                <button
                  key={idx}
                  onClick={() => handleAnswer(option)}
                  className={`w-full rounded-xl border-2 p-4 text-left transition-all ${
                    answers[currentQuestion.id] === option
                      ? 'border-primary bg-primary/5'
                      : 'border-border hover:border-primary/50 hover:bg-muted'
                  }`}
                >
                  <span className="font-medium">{option}</span>
                </button>
              ))}
            </div>

            {/* Navigation */}
            <div className="mt-8 flex items-center justify-between">
              <Button
                variant="outline"
                onClick={handlePrevious}
                disabled={currentIndex === 0}
              >
                Previous
              </Button>

              <div className="text-sm text-muted-foreground">
                {Object.keys(answers).length} of {questions.length} answered
              </div>

              {currentIndex === questions.length - 1 ? (
                <Button
                  onClick={handleSubmit}
                  disabled={Object.keys(answers).length !== questions.length}
                >
                  Submit Test
                </Button>
              ) : (
                <Button onClick={handleNext}>Next</Button>
              )}
            </div>
          </div>
        </div>
      </main>
    </div>
  );
}
