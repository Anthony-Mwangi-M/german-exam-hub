export const LISTENING_SKILL_CODE = 'listening';

/** Hören is excluded from v1; native-speaker audio comes post-launch. */
export function isListeningComingSoon(skillCode: string | undefined): boolean {
  return skillCode === LISTENING_SKILL_CODE;
}

export const LISTENING_COMING_SOON_MESSAGE =
  'Hörverstehen (listening) is coming soon. We are adding native-speaker audio for a full exam experience.';
