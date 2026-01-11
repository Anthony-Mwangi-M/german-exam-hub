import { useState } from "react";
import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Menu, X } from "lucide-react";

const levels = [
  { id: "a1", label: "A1", color: "bg-level-a1" },
  { id: "a2", label: "A2", color: "bg-level-a2" },
  { id: "b1", label: "B1", color: "bg-level-b1" },
  { id: "b2", label: "B2", color: "bg-level-b2" },
];

export function Header() {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  return (
    <header className="sticky top-0 z-50 w-full border-b border-border/50 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/80">
      <div className="container flex h-16 items-center justify-between">
        {/* Logo */}
        <Link to="/" className="flex items-center gap-2">
          <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-primary">
            <span className="text-lg font-bold text-primary-foreground">D</span>
          </div>
          <span className="text-xl font-bold text-foreground">DeutschPrep</span>
        </Link>

        {/* Desktop Navigation */}
        <nav className="hidden items-center gap-1 md:flex">
          {/* Level Pills */}
          <div className="mr-4 flex items-center gap-1 rounded-full border border-border bg-muted/50 p-1">
            {levels.map((level) => (
              <Link
                key={level.id}
                to={`/level/${level.id}`}
                className="flex h-8 w-10 items-center justify-center rounded-full text-sm font-semibold transition-all hover:bg-background hover:shadow-sm"
              >
                {level.label}
              </Link>
            ))}
          </div>

          <Link
            to="/about"
            className="px-4 py-2 text-sm font-medium text-muted-foreground transition-colors hover:text-foreground"
          >
            About
          </Link>
        </nav>

        {/* CTA Buttons */}
        <div className="hidden items-center gap-3 md:flex">
          <Button variant="free" size="sm">
            Free Placement Test
          </Button>
          <Button variant="outline" size="sm">
            Sign In
          </Button>
        </div>

        {/* Mobile Menu Button */}
        <button
          className="flex h-10 w-10 items-center justify-center rounded-lg md:hidden"
          onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
        >
          {mobileMenuOpen ? <X className="h-5 w-5" /> : <Menu className="h-5 w-5" />}
        </button>
      </div>

      {/* Mobile Menu */}
      {mobileMenuOpen && (
        <div className="border-t border-border bg-background p-4 md:hidden">
          <div className="mb-4 flex justify-center gap-2">
            {levels.map((level) => (
              <Link
                key={level.id}
                to={`/level/${level.id}`}
                onClick={() => setMobileMenuOpen(false)}
                className="flex h-10 w-12 items-center justify-center rounded-lg bg-muted text-sm font-semibold transition-all hover:bg-muted/80"
              >
                {level.label}
              </Link>
            ))}
          </div>
          <div className="flex flex-col gap-2">
            <Link
              to="/about"
              onClick={() => setMobileMenuOpen(false)}
              className="rounded-lg px-4 py-2 text-center text-sm font-medium hover:bg-muted"
            >
              About
            </Link>
            <Button variant="free" className="w-full">
              Free Placement Test
            </Button>
            <Button variant="outline" className="w-full">
              Sign In
            </Button>
          </div>
        </div>
      )}
    </header>
  );
}
