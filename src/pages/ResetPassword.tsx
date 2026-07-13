import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '@/contexts/AuthContext';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { toast } from '@/hooks/use-toast';

/**
 * Landing page for the password recovery email link. Supabase redirects here
 * with a recovery token; the client library exchanges it for a session
 * automatically, after which updateUser can set the new password.
 */
export default function ResetPassword() {
  const [password, setPassword] = useState('');
  const [confirm, setConfirm] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const { updatePassword, session, loading: authLoading } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    if (password.length < 8) {
      setError('Password must be at least 8 characters.');
      return;
    }
    if (password !== confirm) {
      setError('Passwords do not match.');
      return;
    }

    setLoading(true);
    const { error } = await updatePassword(password);

    if (error) {
      setError(error.message);
      setLoading(false);
    } else {
      toast({
        title: 'Password updated',
        description: 'You are signed in with your new password.',
      });
      navigate('/dashboard');
    }
  };

  const linkInvalid = !authLoading && !session;

  return (
    <div className="flex min-h-screen items-center justify-center bg-background px-4">
      <div className="w-full max-w-md space-y-8">
        <div className="text-center">
          <Link to="/" className="inline-block">
            <img src="/dp-logo.png" alt="DeutschPrep" className="mx-auto h-8 w-auto" />
          </Link>
          <h2 className="mt-8 text-3xl font-semibold tracking-tight text-foreground">
            Choose a new password
          </h2>
        </div>

        <div className="dp-surface p-8">
          {authLoading ? (
            <p className="text-center text-sm text-muted-foreground">Checking your reset link...</p>
          ) : linkInvalid ? (
            <div className="text-center">
              <h3 className="font-semibold text-foreground">This link is invalid or has expired</h3>
              <p className="mt-2 text-sm text-muted-foreground">
                Password reset links can only be used once and expire after one hour.
                Request a new one below.
              </p>
              <Button className="mt-6 w-full" asChild>
                <Link to="/forgot-password">Request a new link</Link>
              </Button>
            </div>
          ) : (
            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="password">New password</Label>
                <Input
                  id="password"
                  type="password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                  minLength={8}
                  placeholder="At least 8 characters"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="confirm">Confirm new password</Label>
                <Input
                  id="confirm"
                  type="password"
                  value={confirm}
                  onChange={(e) => setConfirm(e.target.value)}
                  required
                  minLength={8}
                  placeholder="Repeat your new password"
                />
              </div>

              {error && (
                <div className="rounded-lg bg-destructive/10 p-3 text-sm text-destructive">
                  {error}
                </div>
              )}

              <Button type="submit" className="w-full" disabled={loading}>
                {loading ? 'Updating...' : 'Update password'}
              </Button>
            </form>
          )}
        </div>
      </div>
    </div>
  );
}
