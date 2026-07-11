import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";

export default function Privacy() {
  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1 py-16">
        <div className="container max-w-3xl">
          <h1 className="mb-2 text-4xl font-bold">Privacy Policy</h1>
          <p className="mb-10 text-sm text-muted-foreground">Last updated: June 2026</p>

          <div className="prose prose-sm max-w-none text-muted-foreground space-y-8">

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">1. Information We Collect</h2>
              <p>We collect the following information when you use DeutschPrep:</p>
              <ul className="list-disc list-inside mt-2 space-y-1">
                <li><strong className="text-foreground">Account information:</strong> email address and display name provided at registration</li>
                <li><strong className="text-foreground">Test data:</strong> your answers, scores, and test attempt history</li>
                <li><strong className="text-foreground">Payment information:</strong> M-Pesa phone number and transaction reference (we do not store your M-Pesa PIN)</li>
                <li><strong className="text-foreground">Usage data:</strong> pages visited, actions taken on the Platform</li>
              </ul>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">2. How We Use Your Information</h2>
              <p>We use your information to:</p>
              <ul className="list-disc list-inside mt-2 space-y-1">
                <li>Provide access to purchased test modules</li>
                <li>Enable instructor review of your writing and speaking answers</li>
                <li>Process payments via M-Pesa</li>
                <li>Track your test history and progress</li>
                <li>Communicate with you about your account or results</li>
                <li>Improve the Platform and content quality</li>
              </ul>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">3. Data Storage</h2>
              <p>
                Your data is stored securely using Supabase, which uses industry-standard encryption at rest
                and in transit. Our infrastructure is hosted on servers in the European Union.
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">4. Instructor Access</h2>
              <p>
                Instructors on the Platform have access to your submitted writing and speaking answers for the
                purpose of grading. They do not have access to your payment details or personal account
                information beyond your display name.
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">5. Data Sharing</h2>
              <p>
                We do not sell your personal data. We share data only with:
              </p>
              <ul className="list-disc list-inside mt-2 space-y-1">
                <li><strong className="text-foreground">Supabase</strong> — database and authentication provider</li>
                <li><strong className="text-foreground">Safaricom (M-Pesa/Daraja API)</strong> — payment processing</li>
              </ul>
              <p className="mt-2">
                We may disclose information if required by law or to protect the safety of our users.
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">6. Your Rights</h2>
              <p>You have the right to:</p>
              <ul className="list-disc list-inside mt-2 space-y-1">
                <li>Access the personal data we hold about you</li>
                <li>Request correction of inaccurate data</li>
                <li>Request deletion of your account and associated data</li>
              </ul>
              <p className="mt-2">
                To exercise these rights, email us at{" "}
                <a href="mailto:support@deutschprep.co.ke" className="text-primary hover:underline">
                  support@deutschprep.co.ke
                </a>
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">7. Cookies</h2>
              <p>
                We use only essential cookies required to maintain your login session. We do not use
                third-party tracking or advertising cookies.
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">8. Children's Privacy</h2>
              <p>
                DeutschPrep is not intended for users under the age of 13. We do not knowingly collect
                personal data from children.
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">9. Changes to This Policy</h2>
              <p>
                We may update this Privacy Policy periodically. We will notify you of significant changes
                by email or via a notice on the Platform.
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">10. Contact</h2>
              <p>
                For privacy-related questions, please contact us at{" "}
                <a href="mailto:support@deutschprep.co.ke" className="text-primary hover:underline">
                  support@deutschprep.co.ke
                </a>
              </p>
            </section>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}
