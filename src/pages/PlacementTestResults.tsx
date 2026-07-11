import { useLocation, Link } from 'react-router-dom';
import { Header } from '@/components/layout/Header';
import { Footer } from '@/components/layout/Footer';
import { Button } from '@/components/ui/button';
import { Award, TrendingUp, BookOpen, ArrowRight } from 'lucide-react';

export default function PlacementTestResults() {
  const location = useLocation();
  const { score, maxScore, resultLevel, percentage } = location.state || {};

  if (!resultLevel) {
    return (
      <div className="flex min-h-screen flex-col">
        <Header />
        <main className="flex flex-1 items-center justify-center">
          <div className="text-center">
            <h1 className="mb-4 text-2xl font-bold">No results found</h1>
            <Button asChild>
              <Link to="/placement-test">Take Placement Test</Link>
            </Button>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  const levelInfo: Record<string, { name: string; description: string; color: string }> = {
    A1: {
      name: 'Beginner',
      description: 'You can understand and use familiar everyday expressions and basic phrases.',
      color: 'bg-green-50 text-green-900 border-green-200',
    },
    A2: {
      name: 'Elementary',
      description: 'You can communicate in simple routine tasks and describe your background.',
      color: 'bg-blue-50 text-blue-900 border-blue-200',
    },
    B1: {
      name: 'Intermediate',
      description: 'You can deal with most situations and describe experiences and events.',
      color: 'bg-orange-50 text-orange-900 border-orange-200',
    },
    B2: {
      name: 'Upper-Intermediate',
      description: 'You can interact fluently and understand complex texts on various subjects.',
      color: 'bg-purple-50 text-purple-900 border-purple-200',
    },
  };

  const info = levelInfo[resultLevel];

  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1 bg-muted/30 py-16">
        <div className="container max-w-4xl">
          {/* Results Card */}
          <div className="mb-8 rounded-2xl border border-border bg-card p-8 text-center shadow-lg">
            <div className="mb-6 inline-flex h-20 w-20 items-center justify-center rounded-full bg-primary/10">
              <Award className="h-10 w-10 text-primary" />
            </div>

            <h1 className="mb-2 text-3xl font-bold text-foreground">
              Your Level: {resultLevel}
            </h1>
            <p className="mb-6 text-xl text-muted-foreground">{info.name}</p>

            <div className="mb-8 flex justify-center gap-8">
              <div>
                <p className="text-4xl font-bold text-foreground">
                  {score}/{maxScore}
                </p>
                <p className="text-sm text-muted-foreground">Points</p>
              </div>
              <div>
                <p className="text-4xl font-bold text-foreground">{Math.round(percentage)}%</p>
                <p className="text-sm text-muted-foreground">Score</p>
              </div>
            </div>

            <div className={`rounded-xl border-2 p-6 ${info.color}`}>
              <p className="text-lg">{info.description}</p>
            </div>
          </div>

          {/* Recommendations */}
          <div className="space-y-6">
            <h2 className="text-2xl font-bold text-foreground">Recommended Next Steps</h2>

            <div className="grid gap-6 md:grid-cols-2">
              <div className="rounded-2xl border border-border bg-card p-6">
                <div className="mb-4 flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10">
                  <BookOpen className="h-6 w-6 text-primary" />
                </div>
                <h3 className="mb-2 text-lg font-bold text-foreground">
                  Practice {resultLevel} Tests
                </h3>
                <p className="mb-4 text-sm text-muted-foreground">
                  Start with {resultLevel} level practice tests to strengthen your skills.
                </p>
                <Button variant="outline" className="w-full" asChild>
                  <Link to={`/level/${resultLevel.toLowerCase()}`}>
                    View {resultLevel} Tests
                    <ArrowRight className="ml-2 h-4 w-4" />
                  </Link>
                </Button>
              </div>

              <div className="rounded-2xl border border-border bg-card p-6">
                <div className="mb-4 flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10">
                  <TrendingUp className="h-6 w-6 text-primary" />
                </div>
                <h3 className="mb-2 text-lg font-bold text-foreground">Browse All Levels</h3>
                <p className="mb-4 text-sm text-muted-foreground">
                  Explore tests for all levels from A1 to B2.
                </p>
                <Button variant="outline" className="w-full" asChild>
                  <Link to="/#levels">
                    View All Levels
                    <ArrowRight className="ml-2 h-4 w-4" />
                  </Link>
                </Button>
              </div>
            </div>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}
