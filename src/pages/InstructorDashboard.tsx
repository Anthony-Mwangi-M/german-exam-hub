import { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Loader2, BookOpen, Trophy, Clock, Search, GraduationCap, ArrowRight, User } from "lucide-react";
import { toast } from "sonner";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/contexts/AuthContext";

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

export default function InstructorDashboard() {
  const { isAdmin } = useAuth();
  const navigate = useNavigate();
  const [attempts, setAttempts] = useState<TestAttempt[]>([]);
  const [pendingAttemptIds, setPendingAttemptIds] = useState<Set<string>>(new Set());
  const [searchQuery, setSearchQuery] = useState("");
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState<string | null>(null);

  useEffect(() => {
    if (!isAdmin && !loading) {
      navigate("/");
    }
  }, [isAdmin, loading]);

  useEffect(() => {
    loadDashboardData();
  }, []);

  const loadDashboardData = async () => {
    setLoading(true);
    setLoadError(null);

    try {
      const { data: attemptsData, error: attemptsError } = await supabase
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
        .eq('is_placement_test', false)
        .not('completed_at', 'is', null)
        .order('completed_at', { ascending: false });

      if (attemptsError) throw attemptsError;

      const { data: answersData, error: answersError } = await supabase
        .from('test_answers')
        .select('test_attempt_id')
        .is('is_correct', null);

      if (answersError) throw answersError;

      const pendingIds = new Set<string>(
        answersData?.map((a) => a.test_attempt_id) || []
      );

      setAttempts((attemptsData as any) || []);
      setPendingAttemptIds(pendingIds);
    } catch (err) {
      console.error("Error loading dashboard data:", err);
      const message =
        err instanceof Error
          ? err.message
          : "Could not load grading queue. Ensure migration 026 (admin grading policies) is applied and your account has role = admin.";
      setLoadError(message);
      toast.error("Failed to load instructor dashboard", { description: message });
    } finally {
      setLoading(false);
    }
  };

  const filteredAttempts = attempts.filter((attempt) => {
    const studentName = attempt.profile?.full_name?.toLowerCase() || "";
    const studentEmail = attempt.profile?.email?.toLowerCase() || "";
    const moduleTitle = attempt.test_module?.title?.toLowerCase() || "";
    const levelCode = attempt.test_module?.level?.code?.toLowerCase() || "";
    const query = searchQuery.toLowerCase();

    return (
      studentName.includes(query) ||
      studentEmail.includes(query) ||
      moduleTitle.includes(query) ||
      levelCode.includes(query)
    );
  });

  const pendingAttempts = filteredAttempts.filter((a) => pendingAttemptIds.has(a.id));
  const gradedAttempts = filteredAttempts.filter((a) => !pendingAttemptIds.has(a.id));

  if (loading) {
    return (
      <div className="flex min-h-screen flex-col">
        <Header />
        <main className="flex flex-1 items-center justify-center">
          <div className="text-center">
            <Loader2 className="h-8 w-8 animate-spin text-primary mx-auto mb-4" />
            <p className="text-muted-foreground">Loading instructor panel...</p>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1 py-12 bg-slate-50/50">
        <div className="container max-w-6xl">
          <div className="flex flex-col md:flex-row md:items-center justify-between mb-8 gap-4">
            <div>
              <div className="flex items-center gap-2 text-primary font-semibold mb-1">
                <GraduationCap className="h-5 w-5" />
                Instructor Portal
              </div>
              <h1 className="text-3xl font-bold tracking-tight">Grading Dashboard</h1>
              <p className="text-muted-foreground mt-1">
                Review and grade student writing and speaking test submissions.
              </p>
            </div>
            <div className="relative w-full md:w-80">
              <Search className="absolute left-3 top-2.5 h-4.5 w-4.5 text-muted-foreground" />
              <Input
                placeholder="Search student, test, or level..."
                className="pl-10 bg-white"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
              />
            </div>
          </div>

          {loadError && (
            <Card className="mb-6 border-destructive/50 bg-destructive/5">
              <CardContent className="pt-6">
                <p className="text-sm text-destructive font-medium">Could not load the grading queue</p>
                <p className="text-sm text-muted-foreground mt-1">{loadError}</p>
                <p className="text-xs text-muted-foreground mt-2">
                  Run migrations 026 and 032 in Supabase, then set your instructor profile:{" "}
                  <code className="text-xs">UPDATE profiles SET role = &apos;admin&apos; WHERE email = &apos;your@email.com&apos;;</code>
                </p>
                <Button variant="outline" size="sm" className="mt-3" onClick={loadDashboardData}>
                  Retry
                </Button>
              </CardContent>
            </Card>
          )}

          <Tabs defaultValue="pending" className="space-y-6">
            <TabsList className="bg-white border">
              <TabsTrigger value="pending" className="gap-2">
                <Clock className="h-4 w-4" />
                Awaiting Review
                {pendingAttempts.length > 0 && (
                  <Badge variant="destructive" className="ml-1 px-1.5 py-0.5 text-xs font-semibold">
                    {pendingAttempts.length}
                  </Badge>
                )}
              </TabsTrigger>
              <TabsTrigger value="graded" className="gap-2">
                <Trophy className="h-4 w-4" />
                Completed Reviews
                <Badge variant="secondary" className="ml-1">
                  {gradedAttempts.length}
                </Badge>
              </TabsTrigger>
            </TabsList>

            <TabsContent value="pending" className="space-y-4">
              {pendingAttempts.length === 0 ? (
                <Card className="border-dashed bg-white">
                  <CardContent className="pt-12 text-center py-16">
                    <BookOpen className="h-12 w-12 text-muted-foreground/60 mx-auto mb-4" />
                    <h3 className="text-lg font-semibold mb-2">No pending reviews</h3>
                    <p className="text-muted-foreground max-w-sm mx-auto">
                      All submitted writing and speaking tests are graded. Check back later when students submit new answers.
                    </p>
                  </CardContent>
                </Card>
              ) : (
                <div className="grid gap-4">
                  {pendingAttempts.map((attempt) => (
                    <Card key={attempt.id} className="bg-white hover:border-slate-300 transition-all shadow-sm">
                      <CardContent className="p-6">
                        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                          <div className="space-y-1 flex-1">
                            <div className="flex items-center gap-2">
                              <Badge className="bg-amber-100 text-amber-800 hover:bg-amber-100 border-none font-medium">
                                Awaiting Grade
                              </Badge>
                              <span className="text-sm font-semibold text-primary">
                                {attempt.test_module?.level.code} • {attempt.test_module?.skill.name_de}
                              </span>
                            </div>
                            <h3 className="text-lg font-bold text-slate-900 mt-1">
                              {attempt.test_module?.title || "German Practice Test"}
                            </h3>
                            <div className="flex flex-wrap gap-x-4 gap-y-1 text-sm text-muted-foreground mt-2">
                              <span className="flex items-center gap-1">
                                <User className="h-3.5 w-3.5" />
                                {attempt.profile?.full_name || "Anonymous User"} ({attempt.profile?.email})
                              </span>
                              <span className="flex items-center gap-1">
                                <Clock className="h-3.5 w-3.5" />
                                Submitted {new Date(attempt.completed_at).toLocaleString('en-US', {
                                  month: 'short',
                                  day: 'numeric',
                                  hour: '2-digit',
                                  minute: '2-digit'
                                })}
                              </span>
                            </div>
                          </div>
                          <div>
                            <Button asChild className="w-full md:w-auto shadow-sm gap-2">
                              <Link to={`/admin/grading/${attempt.id}`}>
                                Start Grading
                                <ArrowRight className="h-4 w-4" />
                              </Link>
                            </Button>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </div>
              )}
            </TabsContent>

            <TabsContent value="graded" className="space-y-4">
              {gradedAttempts.length === 0 ? (
                <Card className="border-dashed bg-white">
                  <CardContent className="pt-12 text-center py-16">
                    <Trophy className="h-12 w-12 text-muted-foreground/60 mx-auto mb-4" />
                    <h3 className="text-lg font-semibold mb-2">No completed reviews yet</h3>
                    <p className="text-muted-foreground max-w-sm mx-auto">
                      Once you grade student submissions, they will appear here as completed reviews.
                    </p>
                  </CardContent>
                </Card>
              ) : (
                <div className="grid gap-4">
                  {gradedAttempts.map((attempt) => (
                    <Card key={attempt.id} className="bg-white hover:border-slate-300 transition-all shadow-sm">
                      <CardContent className="p-6">
                        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                          <div className="space-y-1 flex-1">
                            <div className="flex items-center gap-2">
                              <Badge className="bg-emerald-100 text-emerald-800 hover:bg-emerald-100 border-none font-medium">
                                Graded
                              </Badge>
                              <span className="text-sm font-semibold text-primary">
                                {attempt.test_module?.level.code} • {attempt.test_module?.skill.name_de}
                              </span>
                            </div>
                            <h3 className="text-lg font-bold text-slate-900 mt-1">
                              {attempt.test_module?.title || "German Practice Test"}
                            </h3>
                            <div className="flex flex-wrap gap-x-4 gap-y-1 text-sm text-muted-foreground mt-2">
                              <span className="flex items-center gap-1">
                                <User className="h-3.5 w-3.5" />
                                {attempt.profile?.full_name || "Anonymous User"} ({attempt.profile?.email})
                              </span>
                              <span className="flex items-center gap-1">
                                <Clock className="h-3.5 w-3.5" />
                                Graded/Completed {new Date(attempt.completed_at).toLocaleDateString()}
                              </span>
                            </div>
                          </div>
                          <div className="flex items-center gap-4 justify-between md:justify-end">
                            <div className="text-right">
                              <div className="text-2xl font-bold text-slate-900">{attempt.percentage}%</div>
                              <p className="text-xs text-muted-foreground">Score ({attempt.score}/{attempt.max_score} pts)</p>
                            </div>
                            <Button asChild variant="outline" size="sm" className="gap-2">
                              <Link to={`/admin/grading/${attempt.id}`}>
                                View Details
                              </Link>
                            </Button>
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
