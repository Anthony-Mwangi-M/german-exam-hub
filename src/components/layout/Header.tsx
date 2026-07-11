import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { Menu, X } from "lucide-react";
import { useAuth } from "@/contexts/AuthContext";
import { Button } from "@/components/ui/button";

interface HeaderProps {
  /** Overlay the page (transparent bg) so a dark hero's gradient runs behind the nav. */
  overlay?: boolean;
}

export function Header({ overlay = false }: HeaderProps) {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const { user, isAdmin, signOut } = useAuth();
  const navigate = useNavigate();

  const handleSignOut = async () => {
    await signOut();
    navigate("/");
  };

  const navChip =
    "rounded-lg px-3.5 py-2 text-sm font-semibold text-white/85 transition-colors hover:bg-white/10 hover:text-white";

  return (
    <header
      className={
        overlay
          ? "absolute inset-x-0 top-0 z-50 w-full bg-transparent"
          : "sticky top-0 z-50 w-full bg-ink"
      }
    >
      <div className="container flex h-16 items-center justify-between">
        <Link to="/" className="transition-opacity hover:opacity-80">
          <img src="/dp-logo.png" alt="DeutschPrep" className="h-8 w-auto" />
        </Link>

        <nav className="hidden items-center gap-1 md:flex">
          <Link to="/#levels" className={navChip}>
            Levels
          </Link>
          <Link to="/about" className={navChip}>
            About
          </Link>
          <Link to="/placement-test" className={navChip}>
            Placement Test
          </Link>
        </nav>

        <div className="hidden items-center gap-2 md:flex">
          {user ? (
            <>
              {isAdmin && (
                <Link
                  to="/admin/grading"
                  className="rounded-lg px-3.5 py-2 text-sm font-bold text-brand transition-colors hover:bg-white/10"
                >
                  Grade Tests
                </Link>
              )}
              <Link to="/dashboard" className={navChip}>
                Dashboard
              </Link>
              <Button
                size="sm"
                variant="ghost"
                className="text-white/85 hover:bg-white/10 hover:text-white"
                onClick={handleSignOut}
              >
                Sign Out
              </Button>
            </>
          ) : (
            <>
              <Link to="/signin" className={navChip}>
                Log in
              </Link>
              <Button size="sm" className="h-9 px-5" asChild>
                <Link to="/signup">Sign up</Link>
              </Button>
            </>
          )}
        </div>

        <button
          type="button"
          className="flex h-10 w-10 items-center justify-center rounded-lg bg-white/10 text-white md:hidden"
          onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
          aria-label="Toggle menu"
        >
          {mobileMenuOpen ? <X className="h-5 w-5" /> : <Menu className="h-5 w-5" />}
        </button>
      </div>

      {mobileMenuOpen && (
        <div className="border-t border-white/10 bg-ink p-6 md:hidden">
          <div className="flex flex-col gap-2">
            <Link to="/#levels" onClick={() => setMobileMenuOpen(false)} className={navChip}>
              Levels
            </Link>
            <Link to="/about" onClick={() => setMobileMenuOpen(false)} className={navChip}>
              About
            </Link>
            <Link
              to="/placement-test"
              onClick={() => setMobileMenuOpen(false)}
              className={navChip}
            >
              Placement Test
            </Link>
            {user ? (
              <>
                {isAdmin && (
                  <Link
                    to="/admin/grading"
                    onClick={() => setMobileMenuOpen(false)}
                    className="rounded-lg px-3.5 py-2 text-sm font-bold text-brand"
                  >
                    Grade Tests
                  </Link>
                )}
                <Link
                  to="/dashboard"
                  onClick={() => setMobileMenuOpen(false)}
                  className={navChip}
                >
                  Dashboard
                </Link>
                <Button
                  variant="secondary"
                  onClick={() => {
                    handleSignOut();
                    setMobileMenuOpen(false);
                  }}
                  className="mt-2 w-full"
                >
                  Sign Out
                </Button>
              </>
            ) : (
              <>
                <Link
                  to="/signin"
                  onClick={() => setMobileMenuOpen(false)}
                  className={navChip}
                >
                  Log in
                </Link>
                <Button asChild className="mt-2 w-full">
                  <Link to="/signup" onClick={() => setMobileMenuOpen(false)}>
                    Sign up
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
