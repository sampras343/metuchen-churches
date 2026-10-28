#!/bin/bash
# Scans public/content/sunday-uploads/ for PDFs and generates bulletins.json
DIR="public/content/sunday-uploads"
OUT="public/content/bulletins.json"

python3 -c "
import os, json, re
files = sorted([f for f in os.listdir('$DIR') if f.endswith('.pdf')], reverse=True)
bulletins = []
for f in files:
    m = re.match(r'(\d{4})(\d{2})(\d{2})\.pdf', f)
    if m:
        bulletins.append({'file': f, 'year': int(m.group(1)), 'month': int(m.group(2)), 'day': int(m.group(3))})
with open('$OUT', 'w') as fp:
    json.dump(bulletins, fp, indent=2)
print(f'Updated $OUT with {len(bulletins)} bulletins')
"
