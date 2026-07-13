import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { Button } from "@/components/ui/button";
import { Link } from "react-router-dom";
import { Target, Heart, Wallet, GraduationCap } from "lucide-react";

const values = [
  {
    icon: Target,
    title: "Exam Focused",
    description: "Everything we create is designed specifically to prepare you for real German exams. No fluff, just what you need to succeed.",
  },
  {
    icon: Wallet,
    title: "Affordable for All",
    description: "We believe quality exam preparation shouldn't break the bank. Our pricing starts from just KES 100.",
  },
  {
    icon: Heart,
    title: "Learner-Centered",
    description: "Simple, clear, and beginner-friendly. We know learning a new language can be daunting, so we keep things straightforward.",
  },
  {
    icon: GraduationCap,
    title: "CEFR Aligned",
    description: "All our content follows the Common European Framework of Reference for Languages, the global standard for language learning.",
  },
];

export default function About() {
  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1">
        {/* Hero */}
        <section className="border-b border-border bg-muted/30 py-16 md:py-24">
          <div className="container">
            <div className="mx-auto max-w-3xl text-center">
              <h1 className="mb-6 text-4xl font-bold text-foreground md:text-5xl">
                Helping You Succeed in <span className="text-gradient">German Exams</span>
              </h1>
              <p className="text-lg text-muted-foreground">
                DeutschPrep is your partner in German language exam preparation. We help learners across Africa prepare for migration, work, and study opportunities in Germany, Austria, and Switzerland.
              </p>
            </div>
          </div>
        </section>

        {/* Mission */}
        <section className="py-16">
          <div className="container">
            <div className="mx-auto max-w-3xl">
              <h2 className="mb-6 text-2xl font-bold text-foreground md:text-3xl">Our Mission</h2>
              <p className="mb-4 text-muted-foreground">
                We believe that language shouldn't be a barrier to opportunity. Whether you're preparing for the Goethe-Zertifikat, telc, or ÖSD exams, we provide affordable, focused revision materials that help you pass with confidence.
              </p>
              <p className="text-muted-foreground">
                Unlike full course platforms, we focus specifically on <strong>assessment and exam preparation</strong>. Our free placement tests help you know exactly where you stand, and our paid revision modules give you targeted practice in all four language skills: Listening, Reading, Writing, and Speaking.
              </p>
            </div>
          </div>
        </section>

        {/* Values */}
        <section className="bg-muted/30 py-16">
          <div className="container">
            <h2 className="mb-12 text-center text-2xl font-bold text-foreground md:text-3xl">
              What We Stand For
            </h2>
            <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-4">
              {values.map((value) => (
                <div key={value.title} className="rounded-2xl border border-border bg-card p-6 shadow-card">
                  <div className="mb-4 flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10">
                    <value.icon className="h-6 w-6 text-primary" />
                  </div>
                  <h3 className="mb-2 font-bold text-foreground">{value.title}</h3>
                  <p className="text-sm text-muted-foreground">{value.description}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* CTA */}
        <section className="py-16">
          <div className="container text-center">
            <h2 className="mb-4 text-2xl font-bold text-foreground">Ready to Get Started?</h2>
            <p className="mb-8 text-muted-foreground">
              Take our free placement test to find your level, then start practicing for the real exam.
            </p>
            <div className="flex flex-wrap justify-center gap-4">
              <Button variant="free" size="lg" asChild>
                <Link to="/placement-test">Take Free Placement Test</Link>
              </Button>
              <Button variant="outline" size="lg" asChild>
                <Link to="/#levels">Browse All Levels</Link>
              </Button>
            </div>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
}
