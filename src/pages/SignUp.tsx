import { Link } from 'react-router-dom';
import { SignUpForm } from '@/components/auth/SignUpForm';

export default function SignUp() {
  return (
    <div className="flex min-h-screen items-center justify-center bg-background px-4">
      <div className="w-full max-w-md space-y-8">
        <div className="text-center">
          <Link to="/" className="text-lg font-semibold tracking-tight text-foreground">
            DeutschPrep
          </Link>
          <h2 className="mt-8 text-3xl font-semibold tracking-tight text-foreground">Create your account</h2>
          <p className="mt-2 text-sm text-muted-foreground">
            Create your account and start practicing
          </p>
        </div>

        <div className="dp-surface p-8">
          <SignUpForm />

          <div className="mt-6 text-center text-sm">
            <span className="text-muted-foreground">Already have an account? </span>
            <Link to="/signin" className="font-medium text-foreground underline underline-offset-4 hover:no-underline">
              Sign in
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
