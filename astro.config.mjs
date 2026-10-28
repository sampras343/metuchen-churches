import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

const config = {
  vite: {
    plugins: [tailwindcss()],
    server: {
      fs: { allow: ['.'] },
    },
  },
  publicDir: 'public',
};

if (process.env.SITE_URL) config.site = process.env.SITE_URL;
if (process.env.SITE_BASE) config.base = process.env.SITE_BASE;

export default defineConfig(config);
