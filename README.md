# Most Holy Name of Jesus Parish

Website for Most Holy Name of Jesus Parish — Holy Trinity, La Asunción, and Our Lady of Hungary churches in Perth Amboy, New Jersey.

**Live site:** [metuchen-churches.onrender.com](https://metuchen-churches.onrender.com)

## Tech Stack

- [Astro](https://astro.build) — static site generator
- [Tailwind CSS v4](https://tailwindcss.com) — styling
- Vanilla JS — interactions (no framework)
- Bilingual EN/ES with language toggle

## Getting Started

```bash
npm install
npm run dev        # Start dev server
npm run build      # Build for production (output: dist/)
npm run preview    # Preview production build
```

## Content Management

All content is managed via files and JSON — no CMS, no database. Drop files, run the script, push.

### Single Update Command

After adding or changing any content, run:

```bash
bash scripts/update-content.sh
```

This regenerates all JSON manifests (bulletins, photos, flyers). Then commit and push.

### Bulletins

Weekly parish bulletins (PDF files).

1. Name the file by date: `YYYYMMDD.pdf` (e.g., `20261025.pdf` for October 25, 2026)
2. Drop it into `public/content/sunday-uploads/`
3. Run `bash scripts/update-content.sh`
4. Commit and push

The site displays the latest bulletin prominently with a download button, and older ones in a month/year archive dropdown.

### Announcements

Parish announcements displayed in the slide-out drawer.

Edit `public/content/announcements.json`:

```json
[
  {
    "en": "Your announcement in English.",
    "es": "Tu anuncio en español."
  },
  {
    "en": "Another announcement.",
    "es": "Otro anuncio."
  }
]
```

No script needed — the site fetches this file at runtime.

### Photo Albums

Photos grouped by album.

1. Create a folder with the album name: `public/content/photos/Parish Feast Day 2026/`
2. Drop images (`.jpg`, `.jpeg`, `.png`, `.webp`) into the folder
3. Run `bash scripts/update-content.sh`
4. Commit and push

The folder name becomes the album name automatically.

### Flyers

Weekly flyers displayed on the Photos & Flyers page. Current week shown on top, older ones in the archive.

1. Drop the flyer image into `public/content/flyers/`
2. Name it with a date prefix for auto-sorting: `20261025-fall-festival.jpg`
   - If no date prefix, the file's modification date is used
   - The title is derived from the filename (dashes/underscores become spaces)
3. Run `bash scripts/update-content.sh`
4. Commit and push

Flyers older than 7 days automatically move to the "Flyer Archive" section.

### Mass Times

Mass schedules are in `src/data/churches.json`. Edit the `masses` object for each church. This requires a rebuild (`npm run build`) since it's compiled into the page.

## Deployment

### Render / Vercel

No special config needed. Set:
- **Build command:** `npm run build`
- **Output directory:** `dist`

### GitHub Pages

The included GitHub Action (`.github/workflows/deploy.yml`) auto-deploys on push to `main`. It sets the base path to `/metuchen-churches/` via environment variables.

## Project Structure

```
public/
  assets/              # Site images (hero, church photos, pastor)
  content/
    announcements.json # Parish announcements (edit directly)
    bulletins.json     # Generated — do not edit manually
    flyers.json        # Generated — do not edit manually
    photos.json        # Generated — do not edit manually
    sunday-uploads/    # Drop bulletin PDFs here
    flyers/            # Drop flyer images here
    photos/            # Create album folders with images here
  favicon.ico
scripts/
  update-content.sh    # Regenerates all JSON manifests
  update-bulletins.sh  # Bulletins only
  update-photos.sh     # Photos only
src/
  data/churches.json   # Church data (addresses, mass times, map links)
  pages/index.astro    # Main page
  pages/photos.astro   # Photos & Flyers page
  styles/global.css    # Global styles and CSS tokens
```
