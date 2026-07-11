import { useParams, useNavigate, Link } from "react-router-dom";
import { useEffect, useState } from "react";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { ArrowLeft, CheckCircle, Loader2, AlertCircle } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/contexts/AuthContext";
import { toast } from "@/hooks/use-toast";
import { isListeningComingSoon, LISTENING_COMING_SOON_MESSAGE } from "@/lib/moduleAvailability";

interface TestModule {
  id: string;
  title: string;
  description: string;
  price_kes: number;
  question_count: number;
  duration_minutes: number;
  level: {
    code: string;
    name: string;
  };
  skill: {
    code: string;
    name_de: string;
    name_en: string;
  };
}

const DEMO_PHONE = "0700000000";

export default function Purchase() {
  const { moduleId } = useParams<{ moduleId: string }>();
  const navigate = useNavigate();
  const { user } = useAuth();
  const mpesaEnabled = import.meta.env.VITE_USE_REAL_MPESA === "true";
  const demoPaymentsEnabled = import.meta.env.VITE_USE_DEMO_PAYMENTS === "true";
  const paymentsEnabled = mpesaEnabled || demoPaymentsEnabled;
  const [testModule, setTestModule] = useState<TestModule | null>(null);
  const [loading, setLoading] = useState(true);
  const [phoneNumber, setPhoneNumber] = useState("");
  const [processing, setProcessing] = useState(false);
  const [alreadyPurchased, setAlreadyPurchased] = useState(false);

  useEffect(() => {
    loadModuleData();
  }, [moduleId]);

  const loadModuleData = async () => {
    if (!user || !moduleId) return;

    setLoading(true);

    const { data: moduleData } = await supabase
      .from("test_modules")
      .select(`
        *,
        level:levels(code, name),
        skill:skills(code, name_de, name_en)
      `)
      .eq("id", moduleId)
      .single();

    if (moduleData) {
      setTestModule(moduleData);

      const { data: purchase } = await supabase
        .from("purchases")
        .select("id")
        .eq("user_id", user.id)
        .eq("test_module_id", moduleId)
        .eq("status", "completed")
        .single();

      if (purchase) {
        setAlreadyPurchased(true);
      }
    }

    setLoading(false);
  };

  const pollUntilCompleted = (purchaseId: string, onSuccess: (receipt: string) => void) => {
    let attempts = 0;
    const maxAttempts = 60;

    const pollPaymentStatus = setInterval(async () => {
      attempts++;

      const { data: updatedPurchase } = await supabase
        .from("purchases")
        .select("status, mpesa_receipt_number")
        .eq("id", purchaseId)
        .single();

      if (updatedPurchase?.status === "completed") {
        clearInterval(pollPaymentStatus);
        setProcessing(false);
        onSuccess(updatedPurchase.mpesa_receipt_number || "");
      } else if (updatedPurchase?.status === "failed" || attempts >= maxAttempts) {
        clearInterval(pollPaymentStatus);
        setProcessing(false);

        toast({
          title: "Payment failed",
          description:
            attempts >= maxAttempts
              ? "Payment timeout. Please try again."
              : "Payment was cancelled or failed.",
          variant: "destructive",
        });
      }
    }, 1000);
  };

  const handlePurchase = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!user || !testModule) return;

    const phone = phoneNumber.trim() || (demoPaymentsEnabled && !mpesaEnabled ? DEMO_PHONE : "");

    if (mpesaEnabled) {
      const phoneRegex = /^(254|0)[17]\d{8}$/;
      if (!phoneRegex.test(phone.replace(/\s/g, ""))) {
        toast({
          title: "Invalid phone number",
          description: "Please enter a valid Kenyan phone number (e.g., 0712345678 or 254712345678)",
          variant: "destructive",
        });
        return;
      }
    }

    if (!paymentsEnabled) {
      toast({
        title: "Payments unavailable",
        description: "Enable demo payments or configure M-Pesa to purchase tests.",
        variant: "destructive",
      });
      return;
    }

    setProcessing(true);

    try {
      const { data: purchase, error } = await supabase
        .from("purchases")
        .insert({
          user_id: user.id,
          test_module_id: testModule.id,
          amount_kes: testModule.price_kes,
          mpesa_phone_number: phone,
          status: "pending" as const,
        } as any)
        .select()
        .single();

      if (error) throw error;
      if (!purchase) throw new Error("Failed to create purchase");

      const purchaseId = (purchase as any).id;

      if (mpesaEnabled) {
        const { data: stkData, error: stkError } = await supabase.functions.invoke("mpesa-stk-push", {
          body: {
            phoneNumber: phone,
            amount: testModule.price_kes,
            purchaseId,
            testModuleId: testModule.id,
          },
        });

        if (stkError) throw new Error(`Payment service error: ${stkError.message || "Unknown error"}`);
        if (!stkData?.success) throw new Error(stkData?.error || "Failed to initiate payment");

        toast({
          title: "Check your phone",
          description: "Enter your M-Pesa PIN to complete the payment.",
        });

        pollUntilCompleted(purchaseId, (receipt) => {
          toast({
            title: "Payment successful! 🎉",
            description: `Receipt: ${receipt}`,
          });
          setTimeout(() => navigate(`/test/${testModule.id}`), 1500);
        });
      } else {
        toast({
          title: "Demo payment",
          description: "Completing your test purchase (no real charge)...",
        });

        const { data: demoData, error: demoError } = await supabase.rpc("complete_demo_purchase", {
          purchase_id: purchaseId,
        });

        if (demoError) {
          const hint = demoError.message?.includes("Could not find the function")
            ? " Run migration 031_demo_purchase_rpc.sql in the Supabase SQL editor."
            : "";
          throw new Error((demoError.message || "Demo payment failed") + hint);
        }
        const demoResult = demoData as { success?: boolean; receipt?: string; error?: string } | null;
        if (!demoResult?.success) {
          throw new Error(demoResult?.error || "Demo payment failed");
        }

        setProcessing(false);
        toast({
          title: "Demo purchase complete",
          description: `Receipt: ${demoResult.receipt}`,
        });
        setTimeout(() => navigate(`/test/${testModule.id}`), 1000);
      }
    } catch (error: any) {
      console.error("Purchase error:", error);
      toast({
        title: "Purchase failed",
        description: error.message || "Something went wrong. Please try again.",
        variant: "destructive",
      });
      setProcessing(false);
    }
  };

  if (loading) {
    return (
      <div className="flex min-h-screen flex-col">
        <Header />
        <main className="flex flex-1 items-center justify-center">
          <div className="text-center">
            <Loader2 className="h-8 w-8 animate-spin text-primary mx-auto mb-4" />
            <p className="text-muted-foreground">Loading...</p>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  if (!testModule) {
    return (
      <div className="flex min-h-screen flex-col">
        <Header />
        <main className="flex flex-1 items-center justify-center">
          <div className="text-center">
            <h1 className="mb-4 text-2xl font-bold">Test not found</h1>
            <Button asChild>
              <Link to="/">Go Home</Link>
            </Button>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  if (isListeningComingSoon(testModule.skill.code)) {
    return (
      <div className="flex min-h-screen flex-col">
        <Header />
        <main className="flex flex-1 items-center justify-center">
          <div className="text-center max-w-md px-4">
            <AlertCircle className="h-16 w-16 text-muted-foreground mx-auto mb-4" />
            <h1 className="mb-2 text-2xl font-bold">Coming Soon</h1>
            <p className="mb-6 text-muted-foreground">{LISTENING_COMING_SOON_MESSAGE}</p>
            <Button asChild>
              <Link to={`/level/${testModule.level.code.toLowerCase()}`}>
                Back to {testModule.level.code} tests
              </Link>
            </Button>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  if (alreadyPurchased) {
    return (
      <div className="flex min-h-screen flex-col">
        <Header />
        <main className="flex flex-1 items-center justify-center">
          <div className="text-center max-w-md">
            <CheckCircle className="h-16 w-16 text-green-500 mx-auto mb-4" />
            <h1 className="mb-2 text-2xl font-bold">Already Purchased</h1>
            <p className="mb-6 text-muted-foreground">You already have access to this test.</p>
            <Button asChild>
              <Link to={`/test/${testModule.id}`}>Start Test</Link>
            </Button>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1 py-12">
        <div className="container max-w-4xl">
          <Link
            to={`/level/${testModule.level.code.toLowerCase()}`}
            className="mb-6 inline-flex items-center gap-2 text-sm font-medium text-muted-foreground transition-colors hover:text-foreground"
          >
            <ArrowLeft className="h-4 w-4" />
            Back to {testModule.level.code} tests
          </Link>

          <div className="grid gap-8 md:grid-cols-2">
            <Card>
              <CardHeader>
                <CardTitle>Test Details</CardTitle>
                <CardDescription>What you&apos;re purchasing</CardDescription>
              </CardHeader>
              <CardContent className="space-y-4">
                <div>
                  <h3 className="font-semibold text-lg">{testModule.title}</h3>
                  <p className="text-sm text-muted-foreground mt-1">
                    {testModule.level.code} • {testModule.skill.name_de}
                  </p>
                </div>

                <p className="text-sm text-muted-foreground">{testModule.description}</p>

                <div className="space-y-2 pt-4 border-t">
                  <div className="flex justify-between text-sm">
                    <span className="text-muted-foreground">Questions</span>
                    <span className="font-medium">{testModule.question_count}</span>
                  </div>
                  <div className="flex justify-between text-sm">
                    <span className="text-muted-foreground">Duration</span>
                    <span className="font-medium">{testModule.duration_minutes} minutes</span>
                  </div>
                  <div className="flex justify-between text-sm">
                    <span className="text-muted-foreground">Access</span>
                    <span className="font-medium">Unlimited</span>
                  </div>
                </div>

                <div className="pt-4 border-t">
                  <div className="flex justify-between items-center">
                    <span className="text-lg font-semibold">Total</span>
                    <span className="text-2xl font-bold text-primary">KES {testModule.price_kes}</span>
                  </div>
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle>{mpesaEnabled ? "Payment via M-Pesa" : "Demo checkout"}</CardTitle>
                <CardDescription>
                  {mpesaEnabled
                    ? "Enter your M-Pesa phone number"
                    : "No real charge — for testing before M-Pesa goes live"}
                </CardDescription>
              </CardHeader>
              <CardContent>
                <form onSubmit={handlePurchase} className="space-y-6">
                  {mpesaEnabled && (
                    <div className="space-y-2">
                      <Label htmlFor="phone">M-Pesa Phone Number</Label>
                      <Input
                        id="phone"
                        type="tel"
                        placeholder="0712345678 or 254712345678"
                        value={phoneNumber}
                        onChange={(e) => setPhoneNumber(e.target.value)}
                        required
                        disabled={processing}
                      />
                      <p className="text-xs text-muted-foreground">
                        You&apos;ll receive an STK push notification on your phone
                      </p>
                    </div>
                  )}

                  {demoPaymentsEnabled && !mpesaEnabled && (
                    <div className="rounded-lg bg-amber-50 p-4 text-sm text-amber-900">
                      <div className="flex gap-2">
                        <AlertCircle className="h-5 w-5 flex-shrink-0" />
                        <p>
                          <strong>Demo mode.</strong> Purchases complete instantly with no M-Pesa charge.
                          Set <code className="text-xs">VITE_USE_REAL_MPESA=true</code> when you go live.
                        </p>
                      </div>
                    </div>
                  )}

                  {!paymentsEnabled && (
                    <div className="rounded-lg bg-amber-50 p-4 text-sm text-amber-900">
                      <div className="flex gap-2">
                        <AlertCircle className="h-5 w-5 flex-shrink-0" />
                        <p>
                          Payments are disabled. Set <code className="text-xs">VITE_USE_DEMO_PAYMENTS=true</code> for
                          testing, or configure M-Pesa for production.
                        </p>
                      </div>
                    </div>
                  )}

                  {mpesaEnabled && (
                    <div className="rounded-lg bg-blue-50 p-4 text-sm text-blue-900">
                      <div className="flex gap-2">
                        <AlertCircle className="h-5 w-5 flex-shrink-0" />
                        <div>
                          <p className="font-medium mb-1">How it works:</p>
                          <ol className="list-decimal list-inside space-y-1 text-xs">
                            <li>Enter your M-Pesa phone number</li>
                            <li>Click &quot;Pay with M-Pesa&quot;</li>
                            <li>Check your phone for STK push</li>
                            <li>Enter your M-Pesa PIN</li>
                            <li>Get instant access to the test</li>
                          </ol>
                        </div>
                      </div>
                    </div>
                  )}

                  <Button
                    type="submit"
                    className="w-full"
                    size="lg"
                    disabled={processing || !paymentsEnabled}
                  >
                    {processing ? (
                      <>
                        <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                        Processing...
                      </>
                    ) : mpesaEnabled ? (
                      `Pay KES ${testModule.price_kes} with M-Pesa`
                    ) : (
                      `Complete demo purchase (KES ${testModule.price_kes})`
                    )}
                  </Button>

                  <p className="text-xs text-center text-muted-foreground">
                    {mpesaEnabled ? "Secure payment powered by M-Pesa" : "Demo checkout — no payment provider required"}
                  </p>
                </form>
              </CardContent>
            </Card>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}
