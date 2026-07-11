import { Link } from "react-router-dom";

const levels = [
  { id: "a1", label: "A1 — Beginner" },
  { id: "a2", label: "A2 — Elementary" },
  { id: "b1", label: "B1 — Intermediate" },
  { id: "b2", label: "B2 — Upper-Intermediate" },
];

export function Footer() {
  return (
    <footer className="border-t border-border/50 bg-card">
      <div className="container px-6 py-16">
        <div className="grid gap-12 md:grid-cols-2 lg:grid-cols-4">
          <div className="space-y-4">
            <Link to="/" className="text-lg font-semibold tracking-tight text-foreground">
              DeutschPrep
            </Link>
            <p className="text-sm leading-relaxed text-muted-foreground">
              Goethe-style exam preparation for learners across Africa. A1 to B2.
            </p>
          </div>

          <div>
            <h4 className="mb-4 text-[11px] font-medium uppercase tracking-[0.12em] text-muted-foreground">
              Levels
            </h4>
            <ul className="space-y-3">
              {levels.map((level) => (
                <li key={level.id}>
                  <Link
                    to={`/level/${level.id}`}
                    className="text-sm text-muted-foreground transition-colors hover:text-foreground"
                  >
                    {level.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          <div>
            <h4 className="mb-4 text-[11px] font-medium uppercase tracking-[0.12em] text-muted-foreground">
              Resources
            </h4>
            <ul className="space-y-3">
              <li>
                <Link
                  to="/placement-test"
                  className="text-sm text-muted-foreground transition-colors hover:text-foreground"
                >
                  Placement Test
                </Link>
              </li>
              <li>
                <Link
                  to="/about"
                  className="text-sm text-muted-foreground transition-colors hover:text-foreground"
                >
                  About Us
                </Link>
              </li>
              <li>
                <a
                  href="mailto:support@deutschprep.co.ke"
                  className="text-sm text-muted-foreground transition-colors hover:text-foreground"
                >
                  Contact Support
                </a>
              </li>
            </ul>
          </div>

          <div>
            <h4 className="mb-4 text-[11px] font-medium uppercase tracking-[0.12em] text-muted-foreground">
              Skills
            </h4>
            <ul className="space-y-3 text-sm text-muted-foreground">
              <li>Lesen (Reading)</li>
              <li>Schreiben (Writing)</li>
              <li>Sprechen (Speaking)</li>
              <li>Hören (Listening) — soon</li>
            </ul>
          </div>
        </div>

        <div className="mt-14 flex flex-col items-center justify-between gap-4 border-t border-border/50 pt-8 sm:flex-row">
          <p className="text-sm text-muted-foreground">
            © {new Date().getFullYear()} DeutschPrep. All rights reserved.
          </p>
          <div className="flex items-center gap-6">
            <Link
              to="/terms"
              className="text-sm text-muted-foreground transition-colors hover:text-foreground"
            >
              Terms
            </Link>
            <Link
              to="/privacy"
              className="text-sm text-muted-foreground transition-colors hover:text-foreground"
            >
              Privacy
            </Link>
          </div>
        </div>
      </div>
    </footer>
  );
}
