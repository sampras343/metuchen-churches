import strings from '../data/i18n.json';

const languages: string[] = (strings as any).languages;

export function t(key: string): string {
  const entry = (strings as any)[key];
  if (!entry) return key;
  return languages.map(lang => `<span data-lang="${lang}">${entry[lang] || entry.en || key}</span>`).join('');
}

export function tRaw(key: string): Record<string, string> {
  return (strings as any)[key] || { en: key };
}

export function getLangs(): string[] {
  return languages;
}
