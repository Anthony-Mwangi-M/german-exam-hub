import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { CheckCircle, Sparkles } from "lucide-react";
import heroImage from "@/assets/hero-student.jpg";

const features = [
  "Free placement tests",
  "Exam-style questions",
  "All 4 language skills",
];

export function HeroSection() {
  return (
    <section className="relative overflow-hidden bg-background py-16 md:py-24">
      <div className="container">
        <div className="grid items-center gap-12 lg:grid-cols-2">
          {/* Left Content */}
          <div className="space-y-8">
            {/* Badge */}
            <div className="inline-flex items-center gap-2 rounded-full border border-border bg-muted/50 px-4 py-2 text-sm">
              <Sparkles className="h-4 w-4 text-primary" />
              <span className="font-medium">German Exam Preparation • A1 to B2</span>
            </div>

            {/* Headline */}
            <div className="space-y-4">
              <h1 className="text-4xl font-extrabold leading-tight tracking-tight text-foreground md:text-5xl lg:text-6xl">
                Prepare for{" "}
                <span className="text-gradient">German Exams</span>
                <br />
                with Confidence
              </h1>
              <p className="max-w-lg text-lg text-muted-foreground">
                Know your level. Practice real exam-style questions. Move forward to Germany, Austria, or Switzerland with the skills you need.
              </p>
            </div>

            {/* Features */}
            <ul className="flex flex-wrap gap-4">
              {features.map((feature) => (
                <li key={feature} className="flex items-center gap-2 text-sm font-medium text-foreground">
                  <CheckCircle className="h-5 w-5 text-accent" />
                  {feature}
                </li>
              ))}
            </ul>

            {/* CTAs */}
            <div className="flex flex-wrap gap-4">
              <Button variant="free" size="lg" asChild>
                <Link to="/placement-test">Take Free Placement Test</Link>
              </Button>
              <Button variant="hero-outline" size="lg" asChild>
                <Link to="/levels">Browse Levels A1–B2</Link>
              </Button>
            </div>

            {/* Stats */}
            <div className="flex items-center gap-6 pt-4">
              <div>
                <p className="text-2xl font-bold text-foreground">5,000+</p>
                <p className="text-sm text-muted-foreground">Practice Questions</p>
              </div>
              <div className="h-10 w-px bg-border" />
              <div>
                <p className="text-2xl font-bold text-foreground">4 Skills</p>
                <p className="text-sm text-muted-foreground">Complete Coverage</p>
              </div>
              <div className="h-10 w-px bg-border" />
              <div>
                <p className="text-2xl font-bold text-foreground">From 100</p>
                <p className="text-sm text-muted-foreground">KES per module</p>
              </div>
            </div>
          </div>

          {/* Right Image */}
          <div className="relative">
            <div className="relative overflow-hidden rounded-3xl shadow-card">
              <img
                src={heroImage}
                alt="Student preparing for German exam"
                className="aspect-[4/3] w-full object-cover"
              />
              {/* Floating Badge */}
              <div className="absolute right-4 top-4 rounded-full bg-background/95 px-4 py-2 shadow-lg backdrop-blur">
                <span className="text-sm font-semibold text-foreground">CEFR-aligned tests</span>
              </div>
              {/* Bottom Badge */}
              <div className="absolute bottom-4 left-4 flex items-center gap-2 rounded-full bg-background/95 px-4 py-2 shadow-lg backdrop-blur">
                <div className="flex h-6 w-6 items-center justify-center rounded-full bg-accent">
                  <CheckCircle className="h-4 w-4 text-accent-foreground" />
                </div>
                <span className="text-sm font-medium text-foreground">Learn anytime, anywhere</span>
              </div>
            </div>

            {/* Decorative elements */}
            <div className="absolute -right-4 -top-4 -z-10 h-72 w-72 rounded-full bg-primary/10 blur-3xl" />
            <div className="absolute -bottom-8 -left-8 -z-10 h-64 w-64 rounded-full bg-accent/10 blur-3xl" />
          </div>
        </div>
      </div>
    </section>
  );
}
