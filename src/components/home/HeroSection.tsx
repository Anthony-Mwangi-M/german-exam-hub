import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { ArrowRight } from "lucide-react";
import { marketingImages } from "@/lib/marketingImages";

const stats = [
  { value: "A1–B2", label: "CEFR levels covered" },
  { value: "12+", label: "Exam modules live" },
  { value: "90+", label: "Goethe-style tasks" },
  { value: "3", label: "Skills per level" },
];

export function HeroSection() {
  const { main } = marketingImages.hero;

  return (
    <>
      {/* Dark hero with sunset gradient blob, Uppbeat-style */}
      <section className="relative overflow-hidden bg-ink px-6 pb-16 pt-28 md:pb-24 md:pt-36">
        <div className="dp-blob" aria-hidden="true" />

        <div className="container relative max-w-6xl">
          <div className="grid items-center gap-12 lg:grid-cols-2 lg:gap-8">
            <div>
              <h1 className="text-5xl font-extrabold leading-[1.02] tracking-[-0.03em] text-ink-foreground md:text-6xl lg:text-[4.25rem]">
                Pass your German exam with{" "}
                <span className="dp-mono text-brand">real practice</span>.
              </h1>

              <p className="mt-6 max-w-md text-lg font-medium leading-relaxed text-ink-muted">
                Goethe-style Lesen, Schreiben, and Sprechen for A1–B2. Practice the real
                format, get graded by instructors.
              </p>

              <Button size="lg" className="mt-9 h-14 px-8 text-base" asChild>
                <Link to="/placement-test">
                  Find your level
                  <ArrowRight className="ml-1 h-5 w-5" />
                </Link>
              </Button>
            </div>

            {/* Stacked photo cards with video-call inset */}
            <div className="relative mx-auto w-full max-w-[540px] lg:ml-auto">
              <div className="dp-stack">
                <div
                  className="dp-stack-echo translate-x-8 translate-y-8 md:translate-x-12 md:translate-y-12"
                  aria-hidden="true"
                >
                  <img src={main} alt="" />
                </div>
                <div
                  className="dp-stack-echo translate-x-4 translate-y-4 md:translate-x-6 md:translate-y-6"
                  aria-hidden="true"
                >
                  <img src={main} alt="" />
                </div>
                <div className="dp-stack-main aspect-[4/3]">
                  <img
                    src={main}
                    alt="Learner preparing for a German exam"
                    className="h-full w-full object-cover"
                  />
                </div>
              </div>
            </div>
          </div>

          {/* Stats band inside the dark hero */}
          <div className="mt-16 grid grid-cols-2 gap-x-6 gap-y-8 border-t border-white/10 pt-10 md:mt-20 md:grid-cols-4">
            {stats.map((stat) => (
              <div key={stat.label} className="text-center">
                <p className="text-3xl font-extrabold tracking-[-0.02em] text-ink-foreground md:text-4xl">
                  {stat.value}
                </p>
                <p className="mt-1 text-sm font-medium text-ink-muted">{stat.label}</p>
              </div>
            ))}
          </div>
        </div>
      </section>
    </>
  );
}
