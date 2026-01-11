import { Button } from "@/components/ui/button";
import { BookOpenCheck, Zap } from "lucide-react";

const topics = [
  { name: "Cases (Nominativ, Akkusativ, Dativ)", price: "KES 50" },
  { name: "Verb Conjugation", price: "KES 50" },
  { name: "Sentence Word Order", price: "KES 50" },
  { name: "Prepositions", price: "KES 50" },
  { name: "Modal Verbs", price: "KES 50" },
  { name: "Adjective Endings", price: "KES 50" },
];

export function GrammarSection() {
  return (
    <section className="bg-muted/30 py-20">
      <div className="container">
        <div className="grid items-center gap-12 lg:grid-cols-2">
          {/* Left Content */}
          <div className="space-y-6">
            <div className="inline-flex items-center gap-2 rounded-full bg-primary/10 px-4 py-2">
              <Zap className="h-4 w-4 text-primary" />
              <span className="text-sm font-semibold text-primary">Quick Assessments</span>
            </div>

            <h2 className="text-3xl font-bold text-foreground md:text-4xl">
              Grammar Topic Assessments
            </h2>

            <p className="text-lg text-muted-foreground">
              Short, focused tests on specific grammar topics. Perfect for quick revision before your exam. Affordable micro-products starting at just KES 50.
            </p>

            <div className="flex items-center gap-4">
              <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-accent/10">
                <BookOpenCheck className="h-6 w-6 text-accent" />
              </div>
              <div>
                <p className="font-semibold text-foreground">Instant Access</p>
                <p className="text-sm text-muted-foreground">Pay once, practice anytime</p>
              </div>
            </div>
          </div>

          {/* Right Grid */}
          <div className="grid gap-3 sm:grid-cols-2">
            {topics.map((topic) => (
              <div
                key={topic.name}
                className="flex items-center justify-between rounded-xl border border-border bg-card p-4 transition-all hover:shadow-card"
              >
                <span className="text-sm font-medium text-foreground">{topic.name}</span>
                <span className="ml-2 shrink-0 rounded-full bg-accent/10 px-3 py-1 text-xs font-semibold text-accent">
                  {topic.price}
                </span>
              </div>
            ))}
            <Button variant="default" className="col-span-full mt-2">
              View All Grammar Topics
            </Button>
          </div>
        </div>
      </div>
    </section>
  );
}
