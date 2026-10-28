import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

const base = process.env.SITE_BASE || '/metuchen-churches/';

export default defineConfig({
  site: process.env.SITE_URL || 'https://sampras343.github.io',
  base,
  vite: {
    plugins: [tailwindcss()],
    server: {
      fs: { allow: ['.'] },
    },
  },
  publicDir: 'public',
});
