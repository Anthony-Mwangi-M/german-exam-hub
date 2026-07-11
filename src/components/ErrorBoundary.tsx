import { Component, ReactNode } from "react";
import { Button } from "@/components/ui/button";

interface Props {
  children: ReactNode;
}

interface State {
  hasError: boolean;
  error: Error | null;
}

export class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false, error: null };
  }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, info: { componentStack: string }) {
    console.error("[DeutschPrep] Uncaught error:", error, info.componentStack);
  }

  render() {
    if (this.state.hasError) {
      return (
        <div className="flex min-h-screen flex-col items-center justify-center bg-background px-6 text-center">
          <div className="mb-6 flex h-20 w-20 items-center justify-center rounded-full bg-destructive/10">
            <span className="text-4xl">⚠️</span>
          </div>
          <h1 className="mb-3 text-2xl font-bold text-foreground">Something went wrong</h1>
          <p className="mb-2 max-w-md text-muted-foreground">
            An unexpected error occurred. Please try refreshing the page.
          </p>
          {this.state.error && (
            <p className="mb-6 max-w-md rounded-lg bg-muted px-4 py-2 font-mono text-xs text-muted-foreground">
              {this.state.error.message}
            </p>
          )}
          <div className="flex gap-3">
            <Button onClick={() => window.location.reload()}>
              Refresh Page
            </Button>
            <Button variant="outline" onClick={() => window.location.href = '/'}>
              Go Home
            </Button>
          </div>
        </div>
      );
    }

    return this.props.children;
  }
}
