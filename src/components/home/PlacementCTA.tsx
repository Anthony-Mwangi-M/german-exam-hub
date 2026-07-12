import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { ArrowRight } from "lucide-react";
import { marketingImages } from "@/lib/marketingImages";

export function PlacementCTA() {
  return (
    <section className="px-6 py-16 md:py-24">
      <div className="container max-w-6xl">
        {/* Dark panel with sunset blob, Uppbeat-style */}
        <div className="relative overflow-hidden rounded-3xl bg-ink">
          <div className="dp-blob" aria-hidden="true" />

          <div className="relative grid items-center gap-10 p-8 md:p-12 lg:grid-cols-2 lg:p-16">
            <div>
              <h2 className="text-3xl font-extrabold leading-[1.05] tracking-[-0.02em] text-ink-foreground md:text-5xl">
                Progress starts at the{" "}
                <span className="dp-mono text-brand">right level</span>
              </h2>
              <p className="mt-5 max-w-md text-lg font-medium leading-relaxed text-ink-muted">
                Know your CEFR level in about 20 minutes — free, A1 to B2. Built from the
                same question bank as our Goethe-style exams.
              </p>

              <Button size="lg" className="mt-8 h-14 px-8 text-base" asChild>
                <Link to="/placement-test">
                  Take the placement test
                  <ArrowRight className="ml-1 h-5 w-5" />
                </Link>
              </Button>
            </div>

            {/* Stacked photo */}
            <div className="mx-auto w-full max-w-[380px]">
              <div className="dp-stack">
                <div
                  className="dp-stack-echo -translate-x-6 translate-y-3 md:-translate-x-10 md:translate-y-5"
                  aria-hidden="true"
                >
                  <img src={marketingImages.hero.tertiary} alt="" />
                </div>
                <div
                  className="dp-stack-echo -translate-x-3 translate-y-1.5 md:-translate-x-5 md:translate-y-2.5"
                  aria-hidden="true"
                >
                  <img src={marketingImages.hero.tertiary} alt="" />
                </div>
                <div className="dp-stack-main aspect-[4/5]">
                  <img
                    src={marketingImages.hero.tertiary}
                    alt="Learner discovering their German level"
                    className="h-full w-full object-cover"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
