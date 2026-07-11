import { useParams, Link } from "react-router-dom";
import { useEffect, useState } from "react";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { Button } from "@/components/ui/button";
import { Headphones, BookOpen, PenTool, MessageCircle, CheckCircle, ArrowLeft, Clock, FileText } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/contexts/AuthContext";
import { isListeningComingSoon, LISTENING_COMING_SOON_MESSAGE } from "@/lib/moduleAvailability";
import { marketingImages } from "@/lib/marketingImages";

interface TestModule {
  id: string;
  title: string;
  description: string;
  price_kes: number;
  question_count: number;
  duration_minutes: number;
  skill: {
    code: string;
    name_de: string;
    name_en: string;
  };
  isPurchased?: boolean;
}

interface Level {
  id: string;
  code: string;
  name: string;
  description: string;
}

const skillIcons: Record<string, typeof Headphones> = {
  listening: Headphones,
  reading: BookOpen,
  writing: PenTool,
  speaking: MessageCircle,
};

export default function LevelDetail() {
  const { levelId } = useParams<{ levelId: string }>();
  const [level, setLevel] = useState<Level | null>(null);
  const [testModules, setTestModules] = useState<TestModule[]>([]);
  const [loading, setLoading] = useState(true);
  const { user } = useAuth();

  useEffect(() => {
    loadLevelData();
  }, [levelId]);

  const loadLevelData = async () => {
    setLoading(true);
    
    // Load level info
    const { data: levelData } = await supabase
      .from('levels')
      .select('*')
      .eq('code', levelId?.toUpperCase())
      .single();

    if (levelData) {
      setLevel(levelData);

      // Load test modules for this level
      const { data: modulesData } = await supabase
        .from('test_modules')
        .select(`
          *,
          skill:skills(code, name_de, name_en)
        `)
        .eq('level_id', levelData.id)
        .eq('is_active', true);

      if (modulesData && user) {
        // Check which modules are purchased
        const { data: purchases } = await supabase
          .from('purchases')
          .select('test_module_id')
          .eq('user_id', user.id)
          .eq('status', 'completed');

        const purchasedIds = new Set(purchases?.map(p => p.test_module_id) || []);
        
        const modulesWithPurchaseStatus = modulesData.map(module => ({
          ...module,
          isPurchased: purchasedIds.has(module.id),
        }));

        setTestModules(modulesWithPurchaseStatus);
      } else if (modulesData) {
        setTestModules(modulesData);
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
            <div className="h-8 w-8 animate-spin rounded-full border-4 border-primary border-t-transparent mx-auto mb-4" />
            <p className="text-muted-foreground">Loading...</p>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  if (!level) {
    return (
      <div className="flex min-h-screen flex-col">
        <Header />
        <main className="flex flex-1 items-center justify-center">
          <div className="text-center">
            <h1 className="mb-4 text-2xl font-bold">Level not found</h1>
            <Button asChild>
              <Link to="/">Go Home</Link>
            </Button>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  const levelImage =
    marketingImages.levels[level.code as keyof typeof marketingImages.levels] ??
    marketingImages.levels.A2;

  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1">
        <section className="border-b border-border/50 py-12 md:py-16">
          <div className="container max-w-6xl">
            <Link
              to="/"
              className="mb-8 inline-flex items-center gap-2 text-sm text-muted-foreground transition-colors hover:text-foreground"
            >
              <ArrowLeft className="h-4 w-4" />
              Back to all levels
            </Link>

            <div className="dp-surface overflow-hidden">
              <div className="dp-card-photo max-h-[320px] md:max-h-[380px]">
                <img src={levelImage} alt={`${level.code} German exam preparation`} />
                <div className="dp-photo-overlay" />
              </div>
              <div className="p-8 md:p-10">
                <span className="dp-pill">{level.name}</span>
                <h1 className="mt-4 text-4xl font-semibold tracking-tight text-foreground md:text-5xl">
                  {level.code} practice exams
                </h1>
                <p className="mt-3 max-w-2xl text-lg text-muted-foreground">{level.description}</p>
              </div>
            </div>
          </div>
        </section>

        <section className="py-12 md:py-16">
          <div className="container max-w-6xl">
            <h2 className="mb-8 text-2xl font-semibold tracking-tight text-foreground md:text-3xl">
              Available modules
            </h2>

            {testModules.length === 0 ? (
              <div className="dp-panel text-center">
                <p className="text-muted-foreground">No tests available for this level yet.</p>
              </div>
            ) : (
              <div className="grid gap-5 md:grid-cols-2">
                {testModules.map((test) => {
                  const SkillIcon = skillIcons[test.skill.code];
                  const comingSoon = isListeningComingSoon(test.skill.code);
                  return (
                    <article
                      key={test.id}
                      className={`dp-surface-hover overflow-hidden p-6 md:p-7 ${comingSoon ? "opacity-90" : ""}`}
                    >
                      <div className="mb-5 flex items-start gap-4">
                        <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-secondary">
                          <SkillIcon className="h-5 w-5 text-foreground" />
                        </div>
                        <div className="flex-1">
                          <div className="flex flex-wrap items-center gap-2">
                            <span className="text-xs font-medium uppercase tracking-wide text-muted-foreground">
                              {test.skill.name_de}
                            </span>
                            {comingSoon && <Badge variant="secondary">Coming Soon</Badge>}
                          </div>
                          <h3 className="mt-1 text-xl font-semibold tracking-tight text-foreground">
                            {test.title}
                          </h3>
                        </div>
                      </div>

                      <p className="mb-5 text-sm leading-relaxed text-muted-foreground">
                        {comingSoon ? LISTENING_COMING_SOON_MESSAGE : test.description}
                      </p>

                      {!comingSoon && (
                        <ul className="mb-6 space-y-2 border-t border-border/50 pt-5">
                          <li className="flex items-center gap-2 text-sm text-muted-foreground">
                            <FileText className="h-4 w-4 shrink-0" />
                            {test.question_count} exam-style questions
                          </li>
                          <li className="flex items-center gap-2 text-sm text-muted-foreground">
                            <Clock className="h-4 w-4 shrink-0" />
                            {test.duration_minutes} minutes
                          </li>
                          <li className="flex items-center gap-2 text-sm text-muted-foreground">
                            <CheckCircle className="h-4 w-4 shrink-0" />
                            {test.isPurchased ? "Purchased" : "Instant access after payment"}
                          </li>
                        </ul>
                      )}

                      <div className="flex items-center justify-between gap-4">
                        {comingSoon ? (
                          <Button disabled className="w-full">
                            Coming Soon
                          </Button>
                        ) : (
                          <>
                            <div>
                              <p className="text-xs text-muted-foreground">Price</p>
                              <p className="text-2xl font-semibold tracking-tight text-foreground">
                                KES {test.price_kes}
                              </p>
                            </div>
                            {test.isPurchased ? (
                              <Button asChild>
                                <Link to={`/test/${test.id}`}>Start Test</Link>
                              </Button>
                            ) : (
                              <Button asChild>
                                <Link to={`/purchase/${test.id}`}>Purchase</Link>
                              </Button>
                            )}
                          </>
                        )}
                      </div>
                    </article>
                  );
                })}
              </div>
            )}
          </div>
        </section>

        <section className="border-t border-border/50 py-12 md:py-16">
          <div className="container max-w-6xl text-center">
            <div className="dp-panel mx-auto max-w-xl">
              <h3 className="text-2xl font-semibold tracking-tight text-foreground">
                Not sure if {level.code} is right?
              </h3>
              <p className="mt-2 text-muted-foreground">
                Take the free placement test to find your exact level.
              </p>
              <Button size="lg" className="mt-6" asChild>
                <Link to="/placement-test">Take Placement Test</Link>
              </Button>
            </div>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
}
