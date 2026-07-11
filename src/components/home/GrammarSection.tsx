export function GrammarSection() {
  return (
    <section className="px-6 pb-20 md:pb-28">
      <div className="container max-w-6xl">
        <div className="dp-panel">
          <div className="grid gap-10 lg:grid-cols-2 lg:items-center">
            <div>
              <span className="dp-pill">Coming soon</span>
              <h2 className="mt-4 text-3xl font-semibold leading-tight tracking-[-0.02em] text-foreground md:text-4xl">
                Grammar drills.
                <br />
                One topic at a time.
              </h2>
              <p className="mt-4 text-muted-foreground">
                Focused mini-assessments on cases, verb conjugation, word order, and more — built for quick revision before your exam.
              </p>
            </div>
            <div className="space-y-2">
              {[
                "Cases (Nominativ, Akkusativ, Dativ)",
                "Verb Conjugation",
                "Sentence Word Order",
                "Prepositions",
                "Modal Verbs",
                "Adjective Endings",
              ].map((topic) => (
                <div
                  key={topic}
                  className="flex items-center justify-between rounded-2xl border border-border/60 bg-secondary/50 px-4 py-3 text-sm text-muted-foreground"
                >
                  <span>{topic}</span>
                  <span className="rounded-full bg-muted px-2.5 py-0.5 text-[10px] font-semibold uppercase tracking-wide">
                    Soon
                  </span>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
