#!/bin/bash
# Scans public/content/photos/ for album folders and generates photos.json
# Each subfolder = one album. Images inside = album photos.
DIR="public/content/photos"
OUT="public/content/photos.json"

python3 -c "
import os, json

base = '$DIR'
albums = []
if os.path.isdir(base):
    for folder in sorted(os.listdir(base), reverse=True):
        path = os.path.join(base, folder)
        if not os.path.isdir(path):
            continue
        photos = sorted([f for f in os.listdir(path) if f.lower().endswith(('.jpg','.jpeg','.png','.webp'))])
        if photos:
            albums.append({'album': folder, 'folder': folder, 'photos': photos})

with open('$OUT', 'w') as fp:
    json.dump(albums, fp, indent=2)
print(f'Updated $OUT with {len(albums)} albums, {sum(len(a[\"photos\"]) for a in albums)} photos')
"
