import { useParams, Link } from "react-router-dom";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { Button } from "@/components/ui/button";
import { Headphones, BookOpen, PenTool, MessageCircle, CheckCircle, ArrowLeft } from "lucide-react";

const levelData: Record<string, {
  title: string;
  subtitle: string;
  description: string;
  color: string;
  bgColor: string;
  tests: { name: string; skill: string; price: string; questions: number }[];
}> = {
  a1: {
    title: "A1",
    subtitle: "Beginner",
    description: "Perfect for complete beginners. Learn basic vocabulary, simple phrases, and fundamental grammar structures needed for basic communication.",
    color: "text-level-a1",
    bgColor: "bg-level-a1",
    tests: [
      { name: "A1 Listening Practice Test", skill: "Hören", price: "KES 100", questions: 30 },
      { name: "A1 Reading Comprehension", skill: "Lesen", price: "KES 100", questions: 25 },
      { name: "A1 Writing Exercises", skill: "Schreiben", price: "KES 100", questions: 15 },
      { name: "A1 Speaking Prompts", skill: "Sprechen", price: "KES 100", questions: 20 },
    ],
  },
  a2: {
    title: "A2",
    subtitle: "Elementary",
    description: "Build upon A1 foundations. Handle everyday expressions, routine tasks, and simple direct exchanges of information on familiar topics.",
    color: "text-level-a2",
    bgColor: "bg-level-a2",
    tests: [
      { name: "A2 Listening Practice Test", skill: "Hören", price: "KES 150", questions: 35 },
      { name: "A2 Reading Comprehension", skill: "Lesen", price: "KES 150", questions: 30 },
      { name: "A2 Writing Exercises", skill: "Schreiben", price: "KES 150", questions: 18 },
      { name: "A2 Speaking Prompts", skill: "Sprechen", price: "KES 150", questions: 22 },
    ],
  },
  b1: {
    title: "B1",
    subtitle: "Intermediate",
    description: "Handle most travel situations and describe experiences, events, dreams, and ambitions. Express opinions and explain plans.",
    color: "text-level-b1",
    bgColor: "bg-level-b1",
    tests: [
      { name: "B1 Listening Practice Test", skill: "Hören", price: "KES 200", questions: 40 },
      { name: "B1 Reading Comprehension", skill: "Lesen", price: "KES 200", questions: 35 },
      { name: "B1 Writing Exercises", skill: "Schreiben", price: "KES 200", questions: 20 },
      { name: "B1 Speaking Prompts", skill: "Sprechen", price: "KES 200", questions: 25 },
    ],
  },
  b2: {
    title: "B2",
    subtitle: "Upper-Intermediate",
    description: "Interact fluently with native speakers. Understand complex texts and produce clear, detailed writing on a wide range of subjects.",
    color: "text-level-b2",
    bgColor: "bg-level-b2",
    tests: [
      { name: "B2 Listening Practice Test", skill: "Hören", price: "KES 250", questions: 45 },
      { name: "B2 Reading Comprehension", skill: "Lesen", price: "KES 250", questions: 40 },
      { name: "B2 Writing Exercises", skill: "Schreiben", price: "KES 250", questions: 22 },
      { name: "B2 Speaking Prompts", skill: "Sprechen", price: "KES 250", questions: 28 },
    ],
  },
};

const skillIcons: Record<string, typeof Headphones> = {
  Hören: Headphones,
  Lesen: BookOpen,
  Schreiben: PenTool,
  Sprechen: MessageCircle,
};

export default function LevelDetail() {
  const { levelId } = useParams<{ levelId: string }>();
  const level = levelData[levelId || "a1"];

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

  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1">
        {/* Hero */}
        <section className="border-b border-border bg-muted/30 py-12 md:py-16">
          <div className="container">
            <Link
              to="/"
              className="mb-6 inline-flex items-center gap-2 text-sm font-medium text-muted-foreground transition-colors hover:text-foreground"
            >
              <ArrowLeft className="h-4 w-4" />
              Back to all levels
            </Link>

            <div className="flex items-start gap-6">
              <div className={`flex h-20 w-20 items-center justify-center rounded-2xl ${level.bgColor}`}>
                <span className="text-3xl font-bold text-background">{level.title}</span>
              </div>
              <div>
                <h1 className="mb-2 text-3xl font-bold text-foreground md:text-4xl">
                  {level.title} Level – {level.subtitle}
                </h1>
                <p className="max-w-2xl text-lg text-muted-foreground">{level.description}</p>
              </div>
            </div>
          </div>
        </section>

        {/* Tests Grid */}
        <section className="py-12">
          <div className="container">
            <h2 className="mb-8 text-2xl font-bold text-foreground">
              Available Revision Tests
            </h2>

            <div className="grid gap-6 md:grid-cols-2">
              {level.tests.map((test) => {
                const SkillIcon = skillIcons[test.skill];
                return (
                  <div
                    key={test.name}
                    className="rounded-2xl border border-border bg-card p-6 shadow-card transition-all hover:shadow-card-hover"
                  >
                    <div className="mb-4 flex items-center gap-3">
                      <div className={`flex h-12 w-12 items-center justify-center rounded-xl ${level.bgColor}/10`}>
                        <SkillIcon className={`h-6 w-6 ${level.color}`} />
                      </div>
                      <div>
                        <span className={`text-sm font-semibold ${level.color}`}>{test.skill}</span>
                        <h3 className="font-bold text-foreground">{test.name}</h3>
                      </div>
                    </div>

                    <ul className="mb-6 space-y-2">
                      <li className="flex items-center gap-2 text-sm text-muted-foreground">
                        <CheckCircle className="h-4 w-4 text-accent" />
                        {test.questions} exam-style questions
                      </li>
                      <li className="flex items-center gap-2 text-sm text-muted-foreground">
                        <CheckCircle className="h-4 w-4 text-accent" />
                        Instant access after payment
                      </li>
                      <li className="flex items-center gap-2 text-sm text-muted-foreground">
                        <CheckCircle className="h-4 w-4 text-accent" />
                        Detailed explanations included
                      </li>
                    </ul>

                    <div className="flex items-center justify-between">
                      <span className="text-2xl font-bold text-foreground">{test.price}</span>
                      <Button>Pay & Access</Button>
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        </section>

        {/* Free Test CTA */}
        <section className="border-t border-border bg-muted/30 py-12">
          <div className="container text-center">
            <h3 className="mb-2 text-xl font-bold text-foreground">Not sure if {level.title} is right for you?</h3>
            <p className="mb-6 text-muted-foreground">Take our free placement test to find your exact level.</p>
            <Button variant="free" size="lg" asChild>
              <Link to="/placement-test">Take Free Placement Test</Link>
            </Button>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
}
