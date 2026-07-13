/* Generated illustration: tilted quiz card + checkpoint card, Preply "Learn with confidence" style */
function GrammarIllustration() {
  return (
    <div className="relative mx-auto h-[340px] w-full max-w-[440px]" aria-hidden="true">
      {/* Quiz card */}
      <div className="absolute left-0 top-10 w-[240px] -rotate-6 rounded-2xl border border-border bg-card p-5 shadow-card">
        <p className="text-center text-sm font-extrabold leading-snug text-foreground">
          Welcher Artikel passt?
          <br />
          „___ Haus ist groß."
        </p>
        <div className="mt-4 grid grid-cols-2 gap-2">
          <span className="rounded-lg border-2 border-[#3BB273] bg-[#3BB273]/10 px-3 py-2 text-center text-sm font-bold text-foreground">
            Das ✓
          </span>
          <span className="rounded-lg border border-border px-3 py-2 text-center text-sm font-medium text-muted-foreground">
            Der
          </span>
          <span className="rounded-lg border border-border px-3 py-2 text-center text-sm font-medium text-muted-foreground">
            Die
          </span>
          <span className="rounded-lg border border-border px-3 py-2 text-center text-sm font-medium text-muted-foreground">
            Den
          </span>
        </div>
      </div>

      {/* Checkpoint card */}
      <div className="absolute right-0 top-0 w-[220px] rotate-3 rounded-2xl border border-border bg-card p-5 text-center shadow-card">
        {/* Star coin */}
        <svg viewBox="0 0 64 64" className="mx-auto h-16 w-16">
          <circle cx="32" cy="32" r="28" fill="#FFD333" />
          <circle cx="32" cy="32" r="21" fill="#FFC300" />
          <path
            d="M32 18l4.1 8.3 9.2 1.3-6.6 6.5 1.5 9.1L32 39l-8.2 4.3 1.5-9.1-6.6-6.5 9.2-1.3L32 18z"
            fill="#FFF3C4"
          />
        </svg>
        <p className="mt-3 text-base font-extrabold text-foreground">Checkpoint geschafft!</p>
        <div className="mt-3 flex items-center justify-between rounded-lg bg-secondary px-3 py-2">
          <span className="text-xs font-bold text-muted-foreground">Punkte</span>
          <span className="text-sm font-extrabold text-foreground">+20 ★</span>
        </div>
        <div className="mt-2 flex items-center justify-between rounded-lg bg-secondary px-3 py-2">
          <span className="text-xs font-bold text-muted-foreground">Ergebnis</span>
          <span className="text-sm font-extrabold text-[#3BB273]">100%</span>
        </div>
      </div>
    </div>
  );
}

export function GrammarSection() {
  return (
    <section className="px-6 py-16 md:py-24">
      <div className="container max-w-6xl">
        <div className="grid items-center gap-12 lg:grid-cols-2">
          <div>
            <p className="text-[11px] font-extrabold uppercase tracking-[0.16em] text-muted-foreground">
              Built on the official format
            </p>
            <h2 className="mt-4 text-3xl font-extrabold leading-tight tracking-[-0.02em] text-foreground md:text-4xl">
              Learn with confidence
            </h2>
            <p className="mt-4 max-w-md font-medium leading-relaxed text-muted-foreground">
              Grammar drills on cases, verb conjugation, word order, and more are on the
              way: quick checkpoints for revision before your exam, matched to your CEFR
              level.
            </p>
            <span className="dp-pill-accent mt-6 inline-flex">Coming soon</span>
          </div>

          <GrammarIllustration />
        </div>
      </div>
    </section>
  );
}
