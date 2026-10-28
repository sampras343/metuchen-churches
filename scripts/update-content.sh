#!/bin/bash
# Single script to regenerate all content manifests
# Run from project root: bash scripts/update-content.sh

echo "Updating content manifests..."
bash scripts/update-bulletins.sh
bash scripts/update-photos.sh

# Flyers: scan public/content/flyers/ and generate flyers.json
DIR="public/content/flyers"
OUT="public/content/flyers.json"

python3 -c "
import os, json, re
from datetime import datetime

base = '$DIR'
flyers = []
if os.path.isdir(base):
    for f in sorted(os.listdir(base), reverse=True):
        if not f.lower().endswith(('.jpg','.jpeg','.png','.webp','.pdf')):
            continue
        name = os.path.splitext(f)[0]
        # Try to extract date from filename (YYYYMMDD or YYYY-MM-DD prefix)
        date = None
        m = re.match(r'(\d{4})[-_]?(\d{2})[-_]?(\d{2})', name)
        if m:
            date = f'{m.group(1)}-{m.group(2)}-{m.group(3)}'
            title = re.sub(r'^\d{4}[-_]?\d{2}[-_]?\d{2}[-_ ]*', '', name).replace('-', ' ').replace('_', ' ').strip()
            if not title:
                title = datetime.strptime(date, '%Y-%m-%d').strftime('%B %d, %Y')
        else:
            date = datetime.fromtimestamp(os.path.getmtime(os.path.join(base, f))).strftime('%Y-%m-%d')
            title = name.replace('-', ' ').replace('_', ' ')

        flyers.append({'title': title, 'file': f, 'date': date})

flyers.sort(key=lambda x: x['date'], reverse=True)
with open('$OUT', 'w') as fp:
    json.dump(flyers, fp, indent=2)
print(f'Updated $OUT with {len(flyers)} flyers')
"

echo "Done."
