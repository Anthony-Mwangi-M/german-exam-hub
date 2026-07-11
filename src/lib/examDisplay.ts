const A2_TEIL_INSTRUCTIONS: Record<string, Record<number, string>> = {
  reading: {
    1: 'Teil 1 — Welche Anzeige passt? Lesen Sie die Situation und wählen Sie die passende Anzeige.',
    2: 'Teil 2 — Lesen Sie den Text. Wählen Sie die richtige Antwort.',
    3: 'Teil 3 — Lesen Sie den Text. Ist die Aussage richtig oder falsch?',
  },
  writing: {
    1: 'Teil 1 — Schreiben Sie eine kurze Nachricht (ca. 20–30 Wörter).',
    2: 'Teil 2 — Schreiben Sie eine halbformelle E-Mail (ca. 30–40 Wörter).',
  },
  speaking: {
    1: 'Teil 1 — Fragen stellen und beantworten (persönliche Informationen, ca. 2 Min.)',
    2: 'Teil 2 — Kurze Präsentation (ca. 2 Min.)',
    3: 'Teil 3 — Etwas gemeinsam planen (ca. 2 Min.)',
  },
};

export function getTeilInstruction(skillCode: string | undefined, examPart: number | null | undefined): string | null {
  if (!skillCode || !examPart) return null;
  return A2_TEIL_INSTRUCTIONS[skillCode]?.[examPart] ?? `Teil ${examPart}`;
}

export function formatWordLimit(min?: number | null, max?: number | null): string | null {
  if (min && max) return `${min}–${max} Wörter`;
  if (max) return `max. ${max} Wörter`;
  if (min) return `min. ${min} Wörter`;
  return null;
}
