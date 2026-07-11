import { Link } from "react-router-dom";
import { ChevronRight } from "lucide-react";

/* Line icons in Preply's landmark style, hand-drawn for each level */
function GateIcon() {
  return (
    <svg viewBox="0 0 48 48" fill="none" stroke="currentColor" strokeWidth="2" className="h-11 w-11">
      <path d="M6 40h36M8 40V18M14 40V18M20 40V18M28 40V18M34 40V18M40 40V18M6 18h36M8 18l-2-6h36l-2 6M18 12V8h12v4M22 8V5h4v3" />
    </svg>
  );
}

function BubblesIcon() {
  return (
    <svg viewBox="0 0 48 48" fill="none" stroke="currentColor" strokeWidth="2" className="h-11 w-11">
      <path d="M8 10h22a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H16l-6 5v-5H8a2 2 0 0 1-2-2V12a2 2 0 0 1 2-2Z" />
      <path d="M36 20h4a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2h-2v4l-5-4h-9" />
      <path d="M12 16h14M12 21h9" />
    </svg>
  );
}

function TrainIcon() {
  return (
    <svg viewBox="0 0 48 48" fill="none" stroke="currentColor" strokeWidth="2" className="h-11 w-11">
      <rect x="10" y="8" width="28" height="26" rx="4" />
      <path d="M10 22h28M17 8v14M31 8v14M16 28h.01M32 28h.01M14 34l-4 6M34 34l4 6M18 40h12" />
    </svg>
  );
}

function PodiumIcon() {
  return (
    <svg viewBox="0 0 48 48" fill="none" stroke="currentColor" strokeWidth="2" className="h-11 w-11">
      <path d="M14 20h20l-2 20H16l-2-20ZM12 14h24v6H12zM24 14v-4M20 6h8v4h-8ZM20 28h8" />
    </svg>
  );
}

const levels = [
  {
    id: "a1",
    code: "A1",
    title: "A1 German",
    category: "Beginner",
    detail: "Everyday basics · from KES 100",
    icon: GateIcon,
  },
  {
    id: "a2",
    code: "A2",
    title: "A2 German",
    category: "Elementary",
    detail: "Reference Goethe exam · from KES 150",
    icon: BubblesIcon,
    featured: true,
  },
  {
    id: "b1",
    code: "B1",
    title: "B1 German",
    category: "Intermediate",
    detail: "Work & travel scenarios · from KES 200",
    icon: TrainIcon,
  },
  {
    id: "b2",
    code: "B2",
    title: "B2 German",
    category: "Upper-Intermediate",
    detail: "Professional fluency · from KES 250",
    icon: PodiumIcon,
  },
];

export function LevelsSection() {
  return (
    <section className="px-6 py-16 md:py-24" id="levels">
      <div className="container max-w-6xl">
        <div className="mb-10 max-w-2xl">
          <h2 className="dp-headline">Choose your level.</h2>
          <p className="dp-subhead mt-4 font-medium">
            Lesen, Schreiben, and Sprechen at every level. Hören coming soon.
          </p>
        </div>

        <div className="grid gap-4 sm:grid-cols-2">
          {levels.map((level) => {
            const Icon = level.icon;
            return (
              <Link key={level.id} to={`/level/${level.id}`} className="group block">
                <article className="dp-surface-hover flex items-center gap-5 p-6 md:p-7">
                  <div className="shrink-0 text-foreground transition-colors group-hover:text-brand">
                    <Icon />
                  </div>
                  <div className="min-w-0 flex-1">
                    <div className="flex items-center gap-2">
                      <h3 className="text-xl font-extrabold tracking-[-0.02em] text-foreground md:text-2xl">
                        {level.title}
                      </h3>
                      {level.featured && (
                        <span className="dp-pill-accent shrink-0">Reference exam</span>
                      )}
                    </div>
                    <p className="mt-1 truncate text-sm font-medium text-muted-foreground">
                      {level.category} · {level.detail}
                    </p>
                  </div>
                  <ChevronRight className="h-5 w-5 shrink-0 text-foreground transition-transform group-hover:translate-x-1" />
                </article>
              </Link>
            );
          })}
        </div>

        <p className="mt-12 text-center font-medium text-muted-foreground">
          Not sure which level?{" "}
          <Link
            to="/placement-test"
            className="font-extrabold text-foreground underline underline-offset-4 hover:text-brand"
          >
            Take the free placement test
          </Link>
        </p>
      </div>
    </section>
  );
}
