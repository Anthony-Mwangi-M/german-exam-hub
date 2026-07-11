import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";

export default function Terms() {
  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1 py-16">
        <div className="container max-w-3xl">
          <h1 className="mb-2 text-4xl font-bold">Terms of Service</h1>
          <p className="mb-10 text-sm text-muted-foreground">Last updated: June 2026</p>

          <div className="prose prose-sm max-w-none text-muted-foreground space-y-8">

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">1. Acceptance of Terms</h2>
              <p>
                By accessing or using DeutschPrep ("the Platform"), you agree to be bound by these Terms of
                Service. If you do not agree, please do not use the Platform.
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">2. Description of Service</h2>
              <p>
                DeutschPrep provides German-language exam preparation content including placement tests,
                practice modules, and instructor-reviewed assessments for CEFR levels A1 through B2. The
                Platform is intended for individual learners preparing for language exams.
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">3. User Accounts</h2>
              <p>
                You must create an account to access paid content. You are responsible for maintaining the
                confidentiality of your login credentials and for all activity under your account. You must
                provide accurate and complete information when registering.
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">4. Payments & Refunds</h2>
              <p>
                Test modules are purchased individually via M-Pesa. All prices are listed in Kenyan Shillings
                (KES). Payments are final. Refunds may be considered on a case-by-case basis if technical
                issues prevented access to purchased content. Contact us within 7 days of purchase to request
                a review.
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">5. Content & Intellectual Property</h2>
              <p>
                All content on the Platform — including test questions, explanations, and feedback — is the
                property of DeutschPrep. You may not copy, reproduce, distribute, or commercially exploit
                any content without written permission. Purchased access is for personal, non-commercial use
                only.
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">6. Instructor Review</h2>
              <p>
                Writing and speaking test answers are reviewed by qualified instructors. We aim to return
                results within 2–3 business days. Turnaround times may vary during peak periods. Instructor
                feedback is provided in good faith and is not a guarantee of exam outcome.
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">7. Prohibited Use</h2>
              <p>You agree not to:</p>
              <ul className="list-disc list-inside mt-2 space-y-1">
                <li>Share your account credentials with others</li>
                <li>Reproduce or distribute test questions</li>
                <li>Use the Platform for any unlawful purpose</li>
                <li>Attempt to reverse-engineer or interfere with the Platform</li>
              </ul>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">8. Disclaimer</h2>
              <p>
                DeutschPrep is an exam preparation tool and does not guarantee exam success. The Platform is
                provided "as is" without warranties of any kind.
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">9. Changes to Terms</h2>
              <p>
                We reserve the right to modify these terms at any time. Continued use of the Platform after
                changes constitutes acceptance of the new terms.
              </p>
            </section>

            <section>
              <h2 className="text-xl font-semibold text-foreground mb-3">10. Contact</h2>
              <p>
                For questions about these Terms, please contact us at{" "}
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
