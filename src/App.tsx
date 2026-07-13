import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { AuthProvider } from "@/contexts/AuthContext";
import { ProtectedRoute } from "@/components/auth/ProtectedRoute";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import Index from "./pages/Index";
import LevelDetail from "./pages/LevelDetail";
import About from "./pages/About";
import PlacementTest from "./pages/PlacementTest";
import PlacementTestResults from "./pages/PlacementTestResults";
import SignUp from "./pages/SignUp";
import SignIn from "./pages/SignIn";
import ForgotPassword from "./pages/ForgotPassword";
import ResetPassword from "./pages/ResetPassword";
import Purchase from "./pages/Purchase";
import TakeTest from "./pages/TakeTest";
import TestResults from "./pages/TestResults";
import Dashboard from "./pages/Dashboard";
import Terms from "./pages/Terms";
import Privacy from "./pages/Privacy";
import InstructorDashboard from "./pages/InstructorDashboard";
import InstructorGrading from "./pages/InstructorGrading";
import NotFound from "./pages/NotFound";

const queryClient = new QueryClient();

const App = () => (
  <ErrorBoundary>
    <QueryClientProvider client={queryClient}>
      <AuthProvider>
        <TooltipProvider>
          <Toaster />
          <Sonner />
          <BrowserRouter>
            <Routes>
              <Route path="/" element={<Index />} />
              <Route path="/level/:levelId" element={<LevelDetail />} />
              <Route path="/about" element={<About />} />
              <Route path="/terms" element={<Terms />} />
              <Route path="/privacy" element={<Privacy />} />
              <Route path="/signup" element={<SignUp />} />
              <Route path="/signin" element={<SignIn />} />
              <Route path="/forgot-password" element={<ForgotPassword />} />
              <Route path="/reset-password" element={<ResetPassword />} />
              <Route
                path="/dashboard"
                element={
                  <ProtectedRoute>
                    <Dashboard />
                  </ProtectedRoute>
                }
              />
              <Route
                path="/placement-test"
                element={
                  <ProtectedRoute>
                    <PlacementTest />
                  </ProtectedRoute>
                }
              />
              <Route
                path="/placement-test/results"
                element={
                  <ProtectedRoute>
                    <PlacementTestResults />
                  </ProtectedRoute>
                }
              />
              <Route
                path="/purchase/:moduleId"
                element={
                  <ProtectedRoute>
                    <Purchase />
                  </ProtectedRoute>
                }
              />
              <Route
                path="/test/:moduleId"
                element={
                  <ProtectedRoute>
                    <TakeTest />
                  </ProtectedRoute>
                }
              />
              <Route
                path="/test/:moduleId/results/:attemptId"
                element={
                  <ProtectedRoute>
                    <TestResults />
                  </ProtectedRoute>
                }
              />
              <Route
                path="/admin/grading"
                element={
                  <ProtectedRoute requireAdmin={true}>
                    <InstructorDashboard />
                  </ProtectedRoute>
                }
              />
              <Route
                path="/admin/grading/:attemptId"
                element={
                  <ProtectedRoute requireAdmin={true}>
                    <InstructorGrading />
                  </ProtectedRoute>
                }
              />
              {/* ADD ALL CUSTOM ROUTES ABOVE THE CATCH-ALL "*" ROUTE */}
              <Route path="*" element={<NotFound />} />
            </Routes>
          </BrowserRouter>
        </TooltipProvider>
      </AuthProvider>
    </QueryClientProvider>
  </ErrorBoundary>
);

export default App;
