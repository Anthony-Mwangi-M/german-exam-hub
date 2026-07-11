import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { ArrowRight } from "lucide-react";
import { marketingImages } from "@/lib/marketingImages";

export function PlacementCTA() {
  return (
    <section className="px-6 py-20 md:py-28">
      <div className="container max-w-6xl">
        <div className="dp-surface overflow-hidden">
          <div className="grid lg:grid-cols-2">
            <div className="dp-photo min-h-[240px] rounded-none shadow-none lg:min-h-full">
              <img
                src={marketingImages.hero.tertiary}
                alt="Student discovering their German level"
              />
              <div className="dp-photo-overlay" />
            </div>

            <div className="flex flex-col justify-center p-8 md:p-12 lg:p-14">
              <span className="dp-pill w-fit">Free · ~15 minutes</span>

              <h2 className="dp-headline mt-6 text-3xl md:text-4xl">
                Not sure where to start?
                <br />
                Find your level first.
              </h2>

              <p className="mt-4 text-muted-foreground">
                A short diagnostic across grammar and comprehension. Get a CEFR recommendation before you purchase any module.
              </p>

              <Button size="lg" className="mt-8 h-12 w-fit rounded-full px-8 font-semibold" asChild>
                <Link to="/placement-test">
                  Take placement test
                  <ArrowRight className="ml-1 h-4 w-4" />
                </Link>
              </Button>

              <div className="mt-10 grid grid-cols-3 gap-4 border-t border-border pt-8">
                <div>
                  <p className="text-2xl font-semibold tracking-tight">~15m</p>
                  <p className="text-xs text-muted-foreground">Duration</p>
                </div>
                <div>
                  <p className="text-2xl font-semibold tracking-tight">A1–B2</p>
                  <p className="text-xs text-muted-foreground">All levels</p>
                </div>
                <div>
                  <p className="text-2xl font-semibold tracking-tight">Free</p>
                  <p className="text-xs text-muted-foreground">Always</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
