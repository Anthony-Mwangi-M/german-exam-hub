import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { Loader2, BookOpen, Trophy, Clock } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/contexts/AuthContext";
import { isListeningComingSoon } from "@/lib/moduleAvailability";

interface PurchasedTest {
  id: string;
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
  };
  created_at: string;
}

interface TestAttempt {
  id: string;
  score: number | null;
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
  is_placement_test: boolean;
}

export default function Dashboard() {
  const { user } = useAuth();
  const [purchases, setPurchases] = useState<PurchasedTest[]>([]);
  const [attempts, setAttempts] = useState<TestAttempt[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadDashboardData();
  }, []);

  const loadDashboardData = async () => {
    if (!user) return;

    setLoading(true);

    // Load purchased tests
    const { data: purchasesData } = await supabase
      .from('purchases')
      .select(`
        id,
        created_at,
        test_module:test_modules(
          id,
          title,
          level:levels(code),
          skill:skills(code, name_de)
        )
      `)
      .eq('user_id', user.id)
      .eq('status', 'completed')
      .order('created_at', { ascending: false });

    if (purchasesData) {
      setPurchases(purchasesData as any);
    }

    // Load test attempts
    const { data: attemptsData } = await supabase
      .from('test_attempts')
      .select(`
        id,
        score,
        percentage,
        completed_at,
        is_placement_test,
        test_module:test_modules(
          id,
          title,
          level:levels(code),
          skill:skills(code, name_de)
        )
      `)
      .eq('user_id', user.id)
      .not('completed_at', 'is', null)
      .order('completed_at', { ascending: false })
      .limit(10);

    if (attemptsData) {
      setAttempts(attemptsData as any);
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
            <p className="text-muted-foreground">Loading dashboard...</p>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1 py-12">
        <div className="container max-w-6xl">
          <div className="mb-8">
            <h1 className="text-3xl font-bold mb-2">My Dashboard</h1>
            <p className="text-muted-foreground">
              Track your progress and access your tests
            </p>
          </div>

          <Tabs defaultValue="purchased" className="space-y-6">
            <TabsList>
              <TabsTrigger value="purchased">
                <BookOpen className="h-4 w-4 mr-2" />
                My Tests
              </TabsTrigger>
              <TabsTrigger value="history">
                <Trophy className="h-4 w-4 mr-2" />
                Test History
              </TabsTrigger>
            </TabsList>

            <TabsContent value="purchased" className="space-y-4">
              {purchases.length === 0 ? (
                <Card>
                  <CardContent className="pt-6 text-center py-12">
                    <BookOpen className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
                    <h3 className="text-lg font-semibold mb-2">No tests purchased yet</h3>
                    <p className="text-muted-foreground mb-6">
                      Browse our test modules and start your German learning journey
                    </p>
                    <Button asChild>
                      <Link to="/">Browse Tests</Link>
                    </Button>
                  </CardContent>
                </Card>
              ) : (
                <div className="grid gap-4 md:grid-cols-2">
                  {purchases.map((purchase) => {
                    const listeningSoon = isListeningComingSoon(purchase.test_module.skill.code);
                    return (
                    <Card key={purchase.id}>
                      <CardHeader>
                        <div className="flex items-start justify-between">
                          <div>
                            <CardTitle className="text-lg">
                              {purchase.test_module.title}
                            </CardTitle>
                            <p className="text-sm text-muted-foreground mt-1">
                              {purchase.test_module.level.code} • {purchase.test_module.skill.name_de}
                            </p>
                          </div>
                          <Badge variant="secondary">
                            {listeningSoon ? 'Coming Soon' : 'Purchased'}
                          </Badge>
                        </div>
                      </CardHeader>
                      <CardContent>
                        <div className="flex items-center justify-between">
                          <p className="text-xs text-muted-foreground">
                            Purchased {new Date(purchase.created_at).toLocaleDateString()}
                          </p>
                          {listeningSoon ? (
                            <Button size="sm" disabled>
                              Coming Soon
                            </Button>
                          ) : (
                            <Button asChild size="sm">
                              <Link to={`/test/${purchase.test_module.id}`}>
                                Start Test
                              </Link>
                            </Button>
                          )}
                        </div>
                      </CardContent>
                    </Card>
                    );
                  })}
                </div>
              )}
            </TabsContent>

            <TabsContent value="history" className="space-y-4">
              {attempts.length === 0 ? (
                <Card>
                  <CardContent className="pt-6 text-center py-12">
                    <Trophy className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
                    <h3 className="text-lg font-semibold mb-2">No test history yet</h3>
                    <p className="text-muted-foreground">
                      Complete a test to see your results here
                    </p>
                  </CardContent>
                </Card>
              ) : (
                <div className="space-y-3">
                  {attempts.map((attempt) => (
                    <Card key={attempt.id}>
                      <CardContent className="pt-6">
                        <div className="flex items-center justify-between">
                          <div className="flex-1">
                            <h3 className="font-semibold mb-1">
                              {attempt.is_placement_test 
                                ? 'Placement Test' 
                                : attempt.test_module?.title || 'Test'}
                            </h3>
                            {!attempt.is_placement_test && attempt.test_module && (
                              <p className="text-sm text-muted-foreground">
                                {attempt.test_module.level.code} • {attempt.test_module.skill.name_de}
                              </p>
                            )}
                            <div className="flex items-center gap-2 mt-2 text-xs text-muted-foreground">
                              <Clock className="h-3 w-3" />
                              {new Date(attempt.completed_at).toLocaleDateString('en-US', {
                                year: 'numeric',
                                month: 'short',
                                day: 'numeric',
                                hour: '2-digit',
                                minute: '2-digit',
                              })}
                            </div>
                          </div>
                          <div className="flex items-center gap-4">
                            <div className="text-right">
                              <div className={`text-2xl font-bold ${
                                (attempt.percentage || 0) >= 85 ? 'text-green-600' :
                                (attempt.percentage || 0) >= 70 ? 'text-blue-600' :
                                (attempt.percentage || 0) >= 50 ? 'text-orange-600' :
                                'text-red-600'
                              }`}>
                                {attempt.percentage || 0}%
                              </div>
                              <p className="text-xs text-muted-foreground">Score</p>
                            </div>
                            {!attempt.is_placement_test && attempt.test_module && (
                              <Button asChild size="sm" variant="outline">
                                <Link to={`/test/${attempt.test_module.id}/results/${attempt.id}`}>
                                  View Details
                                </Link>
                              </Button>
                            )}
                            {attempt.is_placement_test && (
                              <Button asChild size="sm" variant="outline">
                                <Link to="/placement-test/results">
                                  View Results
                                </Link>
                              </Button>
                            )}
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </div>
              )}
            </TabsContent>
          </Tabs>
        </div>
      </main>
      <Footer />
    </div>
  );
}
