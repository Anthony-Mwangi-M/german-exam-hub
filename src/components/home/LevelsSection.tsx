import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Headphones, BookOpen, PenTool, MessageCircle, ArrowRight } from "lucide-react";

const levels = [
  {
    id: "a1",
    title: "A1",
    subtitle: "Beginner",
    description: "Start your German journey with basic vocabulary and simple phrases.",
    price: "From KES 100",
    color: "bg-level-a1",
    borderColor: "border-level-a1/30",
    textColor: "text-level-a1",
  },
  {
    id: "a2",
    title: "A2",
    subtitle: "Elementary",
    description: "Build on basics with everyday expressions and routine tasks.",
    price: "From KES 150",
    color: "bg-level-a2",
    borderColor: "border-level-a2/30",
    textColor: "text-level-a2",
  },
  {
    id: "b1",
    title: "B1",
    subtitle: "Intermediate",
    description: "Handle most travel situations and describe experiences with ease.",
    price: "From KES 200",
    color: "bg-level-b1",
    borderColor: "border-level-b1/30",
    textColor: "text-level-b1",
  },
  {
    id: "b2",
    title: "B2",
    subtitle: "Upper-Intermediate",
    description: "Interact fluently with native speakers and understand complex texts.",
    price: "From KES 250",
    color: "bg-level-b2",
    borderColor: "border-level-b2/30",
    textColor: "text-level-b2",
  },
];

const skills = [
  { icon: Headphones, label: "Hören", english: "Listening" },
  { icon: BookOpen, label: "Lesen", english: "Reading" },
  { icon: PenTool, label: "Schreiben", english: "Writing" },
  { icon: MessageCircle, label: "Sprechen", english: "Speaking" },
];

export function LevelsSection() {
  return (
    <section className="bg-muted/30 py-20">
      <div className="container">
        {/* Section Header */}
        <div className="mx-auto mb-12 max-w-2xl text-center">
          <h2 className="mb-4 text-3xl font-bold text-foreground md:text-4xl">
            Choose Your Level
          </h2>
          <p className="text-lg text-muted-foreground">
            From complete beginner (A1) to upper-intermediate (B2), we've got exam preparation for every stage of your German learning journey.
          </p>
        </div>

        {/* Skills Legend */}
        <div className="mb-10 flex flex-wrap justify-center gap-4">
          {skills.map((skill) => (
            <div
              key={skill.label}
              className="flex items-center gap-2 rounded-full bg-background px-4 py-2 shadow-sm"
            >
              <skill.icon className="h-4 w-4 text-primary" />
              <span className="text-sm font-medium">{skill.label}</span>
              <span className="text-xs text-muted-foreground">({skill.english})</span>
            </div>
          ))}
        </div>

        {/* Level Cards */}
        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
          {levels.map((level) => (
            <div
              key={level.id}
              className={`group relative overflow-hidden rounded-2xl border-2 ${level.borderColor} bg-card p-6 shadow-card transition-all duration-300 hover:-translate-y-1 hover:shadow-card-hover`}
            >
              {/* Level Badge */}
              <div className={`mb-4 inline-flex h-14 w-14 items-center justify-center rounded-xl ${level.color}`}>
                <span className="text-xl font-bold text-background">{level.title}</span>
              </div>

              {/* Content */}
              <div className="space-y-3">
                <div>
                  <h3 className="text-xl font-bold text-foreground">{level.title} Level</h3>
                  <p className={`text-sm font-semibold ${level.textColor}`}>{level.subtitle}</p>
                </div>
                <p className="text-sm text-muted-foreground">{level.description}</p>

                {/* Skills Grid */}
                <div className="flex gap-2 py-2">
                  {skills.map((skill) => (
                    <div
                      key={skill.label}
                      className="flex h-8 w-8 items-center justify-center rounded-lg bg-muted"
                      title={`${skill.label} (${skill.english})`}
                    >
                      <skill.icon className="h-4 w-4 text-muted-foreground" />
                    </div>
                  ))}
                </div>

                {/* Price */}
                <p className="font-semibold text-foreground">{level.price}</p>

                {/* CTA */}
                <Button variant="outline" className="w-full group-hover:bg-foreground group-hover:text-background" asChild>
                  <Link to={`/level/${level.id}`}>
                    Explore {level.title}
                    <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" />
                  </Link>
                </Button>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
