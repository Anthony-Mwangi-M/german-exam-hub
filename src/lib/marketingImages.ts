import heroMain from "@/assets/marketing/hero-main.jpg";
import heroSecondary from "@/assets/marketing/hero-secondary.jpg";
import heroTertiary from "@/assets/marketing/hero-tertiary.jpg";
import levelA1 from "@/assets/marketing/level-a1.jpg";
import levelA2 from "@/assets/marketing/level-a2.jpg";
import levelB1 from "@/assets/marketing/level-b1.jpg";
import levelB2 from "@/assets/marketing/level-b2.jpg";

export const marketingImages = {
  hero: {
    main: heroMain,
    secondary: heroSecondary,
    tertiary: heroTertiary,
  },
  levels: {
    A1: levelA1,
    A2: levelA2,
    B1: levelB1,
    B2: levelB2,
  } as const,
};
