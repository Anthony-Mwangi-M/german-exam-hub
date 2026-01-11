import { Link } from "react-router-dom";

const levels = [
  { id: "a1", label: "A1 - Beginner" },
  { id: "a2", label: "A2 - Elementary" },
  { id: "b1", label: "B1 - Intermediate" },
  { id: "b2", label: "B2 - Upper-Intermediate" },
];

const skills = ["Hören (Listening)", "Lesen (Reading)", "Schreiben (Writing)", "Sprechen (Speaking)"];

export function Footer() {
  return (
    <footer className="border-t border-border bg-muted/30">
      <div className="container py-12">
        <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-4">
          {/* Brand */}
          <div className="space-y-4">
            <Link to="/" className="flex items-center gap-2">
              <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-primary">
                <span className="text-lg font-bold text-primary-foreground">D</span>
              </div>
              <span className="text-xl font-bold text-foreground">DeutschPrep</span>
            </Link>
            <p className="text-sm text-muted-foreground">
              Prepare for German exams with confidence. Practice real exam-style questions from A1 to B2.
            </p>
          </div>

          {/* Levels */}
          <div>
            <h4 className="mb-4 font-semibold text-foreground">Exam Levels</h4>
            <ul className="space-y-2">
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

          {/* Skills */}
          <div>
            <h4 className="mb-4 font-semibold text-foreground">Exam Skills</h4>
            <ul className="space-y-2">
              {skills.map((skill) => (
                <li key={skill} className="text-sm text-muted-foreground">
                  {skill}
                </li>
              ))}
            </ul>
          </div>

          {/* Quick Links */}
          <div>
            <h4 className="mb-4 font-semibold text-foreground">Quick Links</h4>
            <ul className="space-y-2">
              <li>
                <Link
                  to="/"
                  className="text-sm text-muted-foreground transition-colors hover:text-foreground"
                >
                  Home
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
                <Link
                  to="/placement-test"
                  className="text-sm text-muted-foreground transition-colors hover:text-foreground"
                >
                  Free Placement Test
                </Link>
              </li>
            </ul>
          </div>
        </div>

        <div className="mt-12 border-t border-border pt-6">
          <p className="text-center text-sm text-muted-foreground">
            © {new Date().getFullYear()} DeutschPrep. All rights reserved. Prices shown in KES (Kenyan Shillings).
          </p>
        </div>
      </div>
    </footer>
  );
}
