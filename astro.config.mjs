import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  site: 'https://sampras343.github.io',
  base: '/metuchen-churches/',
  vite: {
    plugins: [tailwindcss()],
    server: {
      fs: { allow: ['.'] },
    },
  },
  publicDir: 'public',
});
