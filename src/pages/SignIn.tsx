import { Link } from 'react-router-dom';
import { SignInForm } from '@/components/auth/SignInForm';

export default function SignIn() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-background px-4">
      <div className="w-full max-w-md space-y-8">
        <div className="text-center">
          <Link to="/" className="text-lg font-semibold tracking-tight text-foreground">
            DeutschPrep
          </Link>
          <h2 className="mt-8 text-3xl font-semibold tracking-tight text-foreground">Welcome back</h2>
          <p className="mt-2 text-sm text-muted-foreground">
            Sign in to continue your learning
          </p>
        </div>

        <div className="dp-surface p-8">
          <SignInForm />

          <div className="mt-6 text-center text-sm">
            <span className="text-muted-foreground">Don't have an account? </span>
            <Link to="/signup" className="font-medium text-foreground underline underline-offset-4 hover:no-underline">
              Sign up
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
