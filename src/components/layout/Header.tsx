import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { Menu, X } from "lucide-react";
import { useAuth } from "@/contexts/AuthContext";
import { Button } from "@/components/ui/button";

export function Header() {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const { user, isAdmin, signOut } = useAuth();
  const navigate = useNavigate();

  const handleSignOut = async () => {
    await signOut();
    navigate("/");
  };

  const navLink =
    "text-sm text-muted-foreground transition-colors hover:text-foreground";

  return (
    <header className="sticky top-0 z-50 w-full border-b border-border/50 bg-background/90 backdrop-blur-md">
      <div className="container flex h-16 items-center justify-between">
        <Link
          to="/"
          className="text-lg font-semibold tracking-tight text-foreground transition-opacity hover:opacity-70"
        >
          DeutschPrep
        </Link>

        <nav className="hidden items-center gap-8 md:flex">
          <Link to="/#levels" className={navLink}>
            Levels
          </Link>
          <Link to="/about" className={navLink}>
            About
          </Link>
          <Link to="/placement-test" className={navLink}>
            Placement Test
          </Link>
        </nav>

        <div className="hidden items-center gap-3 md:flex">
          {user ? (
            <>
              {isAdmin && (
                <Link to="/admin/grading" className="text-sm font-medium text-accent hover:text-accent/80">
                  Grade Tests
                </Link>
              )}
              <Link to="/dashboard" className={navLink}>
                Dashboard
              </Link>
              <Button variant="ghost" size="sm" onClick={handleSignOut}>
                Sign Out
              </Button>
            </>
          ) : (
            <>
              <Link to="/signin" className={navLink}>
                Sign In
              </Link>
              <Button size="sm" className="h-9 px-5" asChild>
                <Link to="/signup">Get started</Link>
              </Button>
            </>
          )}
        </div>

        <button
          type="button"
          className="flex h-10 w-10 items-center justify-center rounded-full border border-border/60 bg-card md:hidden"
          onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
          aria-label="Toggle menu"
        >
          {mobileMenuOpen ? <X className="h-5 w-5" /> : <Menu className="h-5 w-5" />}
        </button>
      </div>

      {mobileMenuOpen && (
        <div className="border-t border-border/50 bg-card p-6 md:hidden">
          <div className="flex flex-col gap-4">
            <Link to="/#levels" onClick={() => setMobileMenuOpen(false)} className={navLink}>
              Levels
            </Link>
            <Link to="/about" onClick={() => setMobileMenuOpen(false)} className={navLink}>
              About
            </Link>
            <Link to="/placement-test" onClick={() => setMobileMenuOpen(false)} className={navLink}>
              Placement Test
            </Link>
            {user ? (
              <>
                {isAdmin && (
                  <Link
                    to="/admin/grading"
                    onClick={() => setMobileMenuOpen(false)}
                    className="text-sm font-medium text-accent"
                  >
                    Grade Tests
                  </Link>
                )}
                <Link to="/dashboard" onClick={() => setMobileMenuOpen(false)} className={navLink}>
                  Dashboard
                </Link>
                <Button
                  variant="outline"
                  onClick={() => {
                    handleSignOut();
                    setMobileMenuOpen(false);
                  }}
                  className="w-full"
                >
                  Sign Out
                </Button>
              </>
            ) : (
              <>
                <Link to="/signin" onClick={() => setMobileMenuOpen(false)} className={navLink}>
                  Sign In
                </Link>
                <Button asChild className="w-full">
                  <Link to="/signup" onClick={() => setMobileMenuOpen(false)}>
                    Get started
                  </Link>
                </Button>
              </>
            )}
          </div>
        </div>
      )}
    </header>
  );
}
