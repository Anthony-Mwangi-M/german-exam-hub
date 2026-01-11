import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { Button } from "@/components/ui/button";
import { Link } from "react-router-dom";
import { Clock, CheckCircle, ArrowRight, Target, BookOpen, Award } from "lucide-react";

const steps = [
  {
    number: "1",
    title: "Answer Questions",
    description: "Complete a mix of grammar, vocabulary, and comprehension questions.",
  },
  {
    number: "2",
    title: "Get Your Result",
    description: "Instantly see your estimated CEFR level (A1, A2, B1, or B2).",
  },
  {
    number: "3",
    title: "Start Revising",
    description: "Access recommended revision modules for your level.",
  },
];

export default function PlacementTest() {
  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1">
        {/* Hero */}
        <section className="border-b border-border py-16 md:py-24">
          <div className="container">
            <div className="mx-auto max-w-3xl text-center">
              <span className="mb-4 inline-block rounded-full bg-accent px-4 py-1 text-sm font-semibold text-accent-foreground">
                100% FREE
              </span>
              <h1 className="mb-6 text-4xl font-bold text-foreground md:text-5xl">
                Discover Your German Level
              </h1>
              <p className="mb-8 text-lg text-muted-foreground">
                Not sure whether you're A1, A2, B1, or B2? Take our free placement test to find out exactly where you stand and get personalized recommendations.
              </p>

              <div className="mb-8 flex flex-wrap justify-center gap-6">
                <div className="flex items-center gap-2">
                  <Clock className="h-5 w-5 text-primary" />
                  <span className="text-sm font-medium">~15 minutes</span>
                </div>
                <div className="flex items-center gap-2">
                  <CheckCircle className="h-5 w-5 text-accent" />
                  <span className="text-sm font-medium">No registration</span>
                </div>
                <div className="flex items-center gap-2">
                  <Award className="h-5 w-5 text-primary" />
                  <span className="text-sm font-medium">Instant results</span>
                </div>
              </div>

              <Button size="lg" className="gap-2">
                Start Placement Test
                <ArrowRight className="h-5 w-5" />
              </Button>
            </div>
          </div>
        </section>

        {/* How it works */}
        <section className="bg-muted/30 py-16">
          <div className="container">
            <h2 className="mb-12 text-center text-2xl font-bold text-foreground">
              How It Works
            </h2>
            <div className="grid gap-8 md:grid-cols-3">
              {steps.map((step) => (
                <div key={step.number} className="text-center">
                  <div className="mx-auto mb-4 flex h-14 w-14 items-center justify-center rounded-full bg-primary text-xl font-bold text-primary-foreground">
                    {step.number}
                  </div>
                  <h3 className="mb-2 font-bold text-foreground">{step.title}</h3>
                  <p className="text-sm text-muted-foreground">{step.description}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* What's covered */}
        <section className="py-16">
          <div className="container">
            <div className="mx-auto max-w-2xl text-center">
              <h2 className="mb-6 text-2xl font-bold text-foreground">What's Covered</h2>
              <div className="grid gap-4 sm:grid-cols-2">
                <div className="flex items-center gap-3 rounded-xl border border-border bg-card p-4">
                  <Target className="h-6 w-6 text-primary" />
                  <span className="font-medium">Grammar & Vocabulary</span>
                </div>
                <div className="flex items-center gap-3 rounded-xl border border-border bg-card p-4">
                  <BookOpen className="h-6 w-6 text-primary" />
                  <span className="font-medium">Reading Comprehension</span>
                </div>
              </div>
              <p className="mt-6 text-sm text-muted-foreground">
                The placement test covers core grammar and reading skills. For full skill assessment (including Listening, Writing, and Speaking), explore our paid revision modules.
              </p>
            </div>
          </div>
        </section>

        {/* Already know your level */}
        <section className="border-t border-border bg-muted/30 py-12">
          <div className="container text-center">
            <h3 className="mb-2 text-xl font-bold text-foreground">Already know your level?</h3>
            <p className="mb-6 text-muted-foreground">Jump straight to the revision modules for your level.</p>
            <div className="flex flex-wrap justify-center gap-3">
              <Button variant="outline" asChild>
                <Link to="/level/a1">A1 Beginner</Link>
              </Button>
              <Button variant="outline" asChild>
                <Link to="/level/a2">A2 Elementary</Link>
              </Button>
              <Button variant="outline" asChild>
                <Link to="/level/b1">B1 Intermediate</Link>
              </Button>
              <Button variant="outline" asChild>
                <Link to="/level/b2">B2 Upper-Intermediate</Link>
              </Button>
            </div>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
}
