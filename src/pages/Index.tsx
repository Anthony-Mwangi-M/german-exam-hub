import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { HeroSection } from "@/components/home/HeroSection";
import { LevelsSection } from "@/components/home/LevelsSection";
import { PlacementCTA } from "@/components/home/PlacementCTA";
import { GrammarSection } from "@/components/home/GrammarSection";

const Index = () => {
  return (
    <div className="flex min-h-screen flex-col">
      <Header />
      <main className="flex-1">
        <HeroSection />
        <LevelsSection />
        <PlacementCTA />
        <GrammarSection />
      </main>
      <Footer />
    </div>
  );
};

export default Index;
