#!/usr/bin/env bash
set -e

# 1. Update layout.css with proper aspect-ratio and clean container styling
cat << 'FILE_EOF' >> src/styles/layout.css

/* Fix brand logo sizing and aspect ratio */
.brand-logo-badge {
  width: 40px !important;
  height: 40px !important;
  padding: 0 !important;
  overflow: hidden !important;
  border-radius: 10px !important;
  background: #000000 !important;
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
}

.brand-logo-img {
  width: 100% !important;
  height: 100% !important;
  object-fit: cover !important;
  transform: scale(1.15) !important; /* Zooms in to crop margins cleanly */
  display: block !important;
}
FILE_EOF

# 2. Stage, commit, push, and deploy
git add .
git commit -m "fix(ui): adjust logo badge dimensions and object-fit scale" || true
git push origin main
npm run deploy

echo "✅ Logo display fixed and deployed!"
