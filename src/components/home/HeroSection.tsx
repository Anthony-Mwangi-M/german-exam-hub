import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { ArrowRight } from "lucide-react";
import { marketingImages } from "@/lib/marketingImages";

const skills = [
  { name: "Lesen", sub: "Reading", desc: "Goethe-style texts, matching & comprehension", live: true },
  { name: "Schreiben", sub: "Writing", desc: "Structured prompts with Leitpunkte", live: true },
  { name: "Sprechen", sub: "Speaking", desc: "Record answers, instructor-reviewed", live: true },
  { name: "Hören", sub: "Listening", desc: "Native audio — launching soon", live: false },
];

export function HeroSection() {
  const { main, secondary, tertiary } = marketingImages.hero;

  return (
    <section className="relative px-6 pt-24 pb-12 md:pt-32 md:pb-20">
      <div className="container max-w-6xl">
        <div className="max-w-3xl">
          <span className="dp-pill">Goethe · ÖSD · A1–B2</span>

          <h1 className="dp-headline mt-8">
            German exam prep
            <br />
            that feels like the real test.
          </h1>

          <p className="dp-subhead mt-6 max-w-xl">
            Practice Lesen, Schreiben, and Sprechen with Goethe-style exams. Know your level. Move forward with confidence.
          </p>

          <div className="mt-10 flex flex-wrap gap-3">
            <Button size="lg" className="h-12 rounded-full px-8 text-[15px] font-semibold" asChild>
              <Link to="/placement-test">
                Take placement test
                <ArrowRight className="ml-1 h-4 w-4" />
              </Link>
            </Button>
            <Button
              size="lg"
              variant="outline"
              className="h-12 rounded-full border-foreground/15 bg-card px-8 text-[15px] font-medium"
              asChild
            >
              <Link to="/#levels">Browse levels</Link>
            </Button>
          </div>
        </div>

        {/* exactly.ai-style photo mosaic */}
        <div className="mt-14 grid grid-cols-12 gap-3 md:mt-20 md:gap-4">
          <div className="dp-photo col-span-12 aspect-[16/10] sm:col-span-7 sm:row-span-2 sm:aspect-auto sm:min-h-[340px] md:min-h-[420px]">
            <img src={main} alt="Students collaborating on German exam preparation" />
            <div className="dp-photo-overlay" />
          </div>
          <div className="col-span-6 flex flex-col gap-3 sm:col-span-5 md:gap-4">
            <div className="dp-photo aspect-[4/3] flex-1 sm:aspect-auto sm:min-h-[160px] md:min-h-[200px]">
              <img src={secondary} alt="Focused study session for German language exam" />
              <div className="dp-photo-overlay" />
            </div>
            <div className="dp-photo aspect-[4/3] flex-1 sm:aspect-auto sm:min-h-[160px] md:min-h-[200px]">
              <img src={tertiary} alt="Professional preparing for relocation to Germany" />
              <div className="dp-photo-overlay" />
            </div>
          </div>
        </div>

        {/* Feature card — case-study layout */}
        <div className="dp-panel mt-10 md:mt-14">
          <div className="grid gap-10 lg:grid-cols-2 lg:gap-16">
            <div>
              <p className="text-[11px] font-semibold uppercase tracking-[0.14em] text-muted-foreground">
                Exam simulator
              </p>
              <h2 className="mt-3 text-2xl font-semibold leading-tight tracking-[-0.02em] text-foreground md:text-3xl">
                Three skills live today.
                <br />
                One path to Germany.
              </h2>
              <p className="mt-4 text-muted-foreground">
                A2 is our reference Goethe-style exam. A1, B1, and B2 follow the same structure.
              </p>
            </div>

            <ul className="space-y-0 divide-y divide-border">
              {skills.map((skill) => (
                <li
                  key={skill.name}
                  className="flex items-start justify-between gap-4 py-4 first:pt-0 last:pb-0"
                >
                  <div>
                    <p className="font-medium text-foreground">
                      {skill.name}{" "}
                      <span className="font-normal text-muted-foreground">· {skill.sub}</span>
                    </p>
                    <p className="mt-0.5 text-sm text-muted-foreground">{skill.desc}</p>
                  </div>
                  {!skill.live && (
                    <span className="shrink-0 rounded-full bg-secondary px-2.5 py-1 text-[10px] font-semibold uppercase tracking-wide text-muted-foreground">
                      Soon
                    </span>
                  )}
                </li>
              ))}
            </ul>
          </div>
        </div>
      </div>
    </section>
  );
}
