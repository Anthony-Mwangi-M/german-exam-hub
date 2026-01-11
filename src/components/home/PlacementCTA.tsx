import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Target, Clock, Award } from "lucide-react";

const benefits = [
  {
    icon: Target,
    title: "Know Your Level",
    description: "Discover if you're A1, A2, B1, or B2 in minutes",
  },
  {
    icon: Clock,
    title: "Quick & Easy",
    description: "Complete the test in under 15 minutes",
  },
  {
    icon: Award,
    title: "100% Free",
    description: "No payment or registration required",
  },
];

export function PlacementCTA() {
  return (
    <section className="py-20">
      <div className="container">
        <div className="relative overflow-hidden rounded-3xl bg-foreground p-8 md:p-12 lg:p-16">
          {/* Content */}
          <div className="relative z-10 mx-auto max-w-3xl text-center">
            <span className="mb-4 inline-block rounded-full bg-accent px-4 py-1 text-sm font-semibold text-accent-foreground">
              FREE
            </span>
            <h2 className="mb-4 text-3xl font-bold text-background md:text-4xl lg:text-5xl">
              Not Sure Where to Start?
            </h2>
            <p className="mb-8 text-lg text-background/80">
              Take our free placement test to discover your current German level. Get personalized recommendations for which revision modules to start with.
            </p>

            {/* Benefits */}
            <div className="mb-10 grid gap-6 md:grid-cols-3">
              {benefits.map((benefit) => (
                <div key={benefit.title} className="rounded-xl bg-background/10 p-4">
                  <benefit.icon className="mx-auto mb-3 h-8 w-8 text-accent" />
                  <h3 className="mb-1 font-semibold text-background">{benefit.title}</h3>
                  <p className="text-sm text-background/70">{benefit.description}</p>
                </div>
              ))}
            </div>

            {/* CTA */}
            <Button
              size="lg"
              className="bg-accent text-accent-foreground hover:bg-accent/90"
              asChild
            >
              <Link to="/placement-test">Take Free Placement Test Now</Link>
            </Button>
          </div>

          {/* Decorative elements */}
          <div className="absolute -left-20 -top-20 h-64 w-64 rounded-full bg-primary/20 blur-3xl" />
          <div className="absolute -bottom-20 -right-20 h-64 w-64 rounded-full bg-accent/20 blur-3xl" />
        </div>
      </div>
    </section>
  );
}
