import { useState } from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { MailCheck } from 'lucide-react';

export default function ForgotPassword() {
  const [email, setEmail] = useState('');
  const [error, setError] = useState('');
  const [sent, setSent] = useState(false);
  const [loading, setLoading] = useState(false);
  const { resetPassword } = useAuth();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    const { error } = await resetPassword(email);

    if (error) {
      setError(error.message);
      setLoading(false);
    } else {
      setSent(true);
    }
  };

  return (
    <div className="flex min-h-screen items-center justify-center bg-background px-4">
      <div className="w-full max-w-md space-y-8">
        <div className="text-center">
          <Link to="/" className="inline-block">
            <img src="/dp-logo.png" alt="DeutschPrep" className="mx-auto h-8 w-auto" />
          </Link>
          <h2 className="mt-8 text-3xl font-semibold tracking-tight text-foreground">
            Reset your password
          </h2>
          <p className="mt-2 text-sm text-muted-foreground">
            Enter your email and we will send you a reset link
          </p>
        </div>

        <div className="dp-surface p-8">
          {sent ? (
            <div className="text-center">
              <div className="mx-auto mb-4 flex h-14 w-14 items-center justify-center rounded-full bg-green-50">
                <MailCheck className="h-7 w-7 text-green-600" />
              </div>
              <h3 className="font-semibold text-foreground">Check your email</h3>
              <p className="mt-2 text-sm text-muted-foreground">
                If an account exists for {email}, you will receive a password reset link
                shortly. The link expires after one hour.
              </p>
              <Button variant="outline" className="mt-6 w-full" asChild>
                <Link to="/signin">Back to sign in</Link>
              </Button>
            </div>
          ) : (
            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="email">Email</Label>
                <Input
                  id="email"
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  required
                  placeholder="you@example.com"
                />
              </div>

              {error && (
                <div className="rounded-lg bg-destructive/10 p-3 text-sm text-destructive">
                  {error}
                </div>
              )}

              <Button type="submit" className="w-full" disabled={loading}>
                {loading ? 'Sending...' : 'Send reset link'}
              </Button>

              <div className="text-center text-sm">
                <Link
                  to="/signin"
                  className="font-medium text-foreground underline underline-offset-4 hover:no-underline"
                >
                  Back to sign in
                </Link>
              </div>
            </form>
          )}
        </div>
      </div>
    </div>
  );
}
