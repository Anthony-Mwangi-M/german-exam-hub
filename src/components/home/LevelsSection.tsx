import { Link } from "react-router-dom";
import { ArrowRight } from "lucide-react";
import { marketingImages } from "@/lib/marketingImages";

const levels = [
  {
    id: "a1",
    code: "A1" as const,
    category: "Beginner",
    title: "Start with everyday German",
    description: "Basic vocabulary and simple phrases for familiar situations.",
    price: "KES 100",
  },
  {
    id: "a2",
    code: "A2" as const,
    category: "Elementary",
    title: "Goethe-style Übungstest",
    description: "Reference exam live — Lesen, Schreiben, Sprechen in official structure.",
    price: "KES 150",
    featured: true,
  },
  {
    id: "b1",
    code: "B1" as const,
    category: "Intermediate",
    title: "Travel and work scenarios",
    description: "Handle routine tasks and describe experiences with confidence.",
    price: "KES 200",
  },
  {
    id: "b2",
    code: "B2" as const,
    category: "Upper-Intermediate",
    title: "Complex texts and opinions",
    description: "Interact fluently and understand detailed professional content.",
    price: "KES 250",
  },
];

export function LevelsSection() {
  return (
    <section className="px-6 py-20 md:py-28" id="levels">
      <div className="container max-w-6xl">
        <div className="mb-12 max-w-2xl">
          <span className="dp-pill">CEFR levels</span>
          <h2 className="dp-headline mt-5">
            Choose your level.
            <br />
            Start practicing.
          </h2>
          <p className="dp-subhead mt-4">
            Lesen, Schreiben, and Sprechen at every level. Hören coming soon.
          </p>
        </div>

        <div className="grid gap-5 sm:grid-cols-2">
          {levels.map((level) => (
            <Link key={level.id} to={`/level/${level.id}`} className="group block">
              <article className="dp-surface-hover overflow-hidden">
                <div className="dp-card-photo">
                  <img
                    src={marketingImages.levels[level.code]}
                    alt={`${level.code} German exam preparation`}
                  />
                  <div className="dp-photo-overlay" />
                  {level.featured && (
                    <span className="absolute left-4 top-4 z-10 dp-pill-accent">
                      Reference exam
                    </span>
                  )}
                </div>

                <div className="p-6 md:p-7">
                  <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-muted-foreground">
                    {level.category}
                  </p>
                  <h3 className="mt-2 text-xl font-semibold tracking-[-0.02em] text-foreground md:text-2xl">
                    {level.code} · {level.title}
                  </h3>
                  <p className="mt-2 text-sm leading-relaxed text-muted-foreground">
                    {level.description}
                  </p>

                  <div className="mt-6 flex items-center justify-between border-t border-border pt-5">
                    <div>
                      <p className="text-[11px] font-medium uppercase tracking-wide text-muted-foreground">
                        From
                      </p>
                      <p className="text-2xl font-semibold tracking-tight text-foreground">
                        {level.price}
                      </p>
                    </div>
                    <span className="inline-flex items-center gap-1.5 text-sm font-medium text-foreground transition-colors group-hover:text-primary">
                      View modules
                      <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-0.5" />
                    </span>
                  </div>
                </div>
              </article>
            </Link>
          ))}
        </div>

        <p className="mt-14 text-center text-muted-foreground">
          Not sure which level?{" "}
          <Link
            to="/placement-test"
            className="font-semibold text-foreground underline underline-offset-4 hover:text-primary"
          >
            Take the free placement test
          </Link>
        </p>
      </div>
    </section>
  );
}
