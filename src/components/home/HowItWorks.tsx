import { marketingImages } from "@/lib/marketingImages";

/* Generated mockup: placement-result card stack, Preply tutor-list style */
function PlacementMockup() {
  const rows = [
    { code: "A2", label: "Recommended level", score: "78%", top: true },
    { code: "B1", label: "Within reach", score: "54%" },
    { code: "A1", label: "Completed", score: "96%" },
  ];
  return (
    <div className="relative space-y-2.5">
      {rows.map((row) => (
        <div
          key={row.code}
          className={`flex items-center gap-3 rounded-xl border bg-card p-3 ${
            row.top ? "border-foreground shadow-card" : "border-border"
          }`}
        >
          <span
            className={`flex h-10 w-10 shrink-0 items-center justify-center rounded-lg text-sm font-extrabold ${
              row.top ? "bg-brand text-foreground" : "bg-secondary text-muted-foreground"
            }`}
          >
            {row.code}
          </span>
          <div className="min-w-0 flex-1">
            <p className="truncate text-sm font-bold text-foreground">{row.label}</p>
            <p className="text-xs font-medium text-muted-foreground">Placement score</p>
          </div>
          <span className="text-sm font-extrabold text-foreground">{row.score}</span>
        </div>
      ))}
    </div>
  );
}

const steps = [
  {
    number: 1,
    chip: "bg-[#7FD6C2]",
    title: "Find your level.",
    description:
      "A free ~20 minute placement test recommends your CEFR level, from A1 to B2, before you spend anything.",
    media: <PlacementMockup />,
  },
  {
    number: 2,
    chip: "bg-[#FFD333]",
    title: "Practice the real format.",
    description:
      "Every module mirrors the official Goethe structure: the same Teile, task types, word counts, and timing.",
    media: (
      <div className="dp-photo aspect-[16/10]">
        <img src={marketingImages.levels.A2} alt="Goethe-style practice test" />
      </div>
    ),
  },
  {
    number: 3,
    chip: "bg-[#7DA7FF]",
    title: "Get graded feedback.",
    description:
      "Instructors grade your writing and speaking against the official four-dimension Goethe rubric.",
    media: (
      <div className="dp-photo aspect-[16/10]">
        <img src={marketingImages.levels.B1} alt="Instructor feedback on exam answers" />
      </div>
    ),
  },
];

export function HowItWorks() {
  return (
    <section className="px-6 py-16 md:py-24">
      <div className="container max-w-6xl">
        <h2 className="dp-headline mb-10">How DeutschPrep works:</h2>

        <div className="grid gap-4 md:grid-cols-3">
          {steps.map((step) => (
            <article key={step.number} className="dp-surface flex flex-col p-6 md:p-7">
              <span
                className={`flex h-9 w-9 items-center justify-center rounded-lg text-base font-extrabold text-foreground ${step.chip}`}
              >
                {step.number}
              </span>
              <h3 className="mt-5 text-2xl font-extrabold tracking-[-0.02em] text-foreground">
                {step.title}
              </h3>
              <p className="mt-3 flex-1 text-[15px] font-medium leading-relaxed text-muted-foreground">
                {step.description}
              </p>
              <div className="mt-6">{step.media}</div>
            </article>
          ))}
        </div>
      </div>
    </section>
  );
}
