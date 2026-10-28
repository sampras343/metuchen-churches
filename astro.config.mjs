import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  site: process.env.SITE_URL || '/',
  base: process.env.SITE_BASE || '/',
  vite: {
    plugins: [tailwindcss()],
    server: {
      fs: { allow: ['.'] },
    },
  },
  publicDir: 'public',
});
