#!/usr/bin/env bash
# Build the website, publish it to GitHub Pages, and record the new submodule
# commit in the parent (seminar) repo. Run from anywhere.
set -euo pipefail
cd "$(dirname "$0")"

# refuse to deploy on top of an outdated checkout
git fetch -q origin main
if ! git merge-base --is-ancestor origin/main HEAD; then
  echo "website/ is behind origin/main: pull first (git -C website pull origin main)" >&2
  exit 1
fi

./build.sh

git add docs
if git diff --cached --quiet; then
  echo "No changes to the rendered site."
else
  git commit -q -m "Update site"
fi
git push -q origin HEAD:main

# record the submodule pointer in the parent repo (commits only website/)
cd ..
if git diff --quiet -- website; then
  echo "Submodule pointer unchanged."
else
  git commit -q -m "Update website" -- website
  git push -q
fi
echo "Deployed: https://fabian-s.github.io/geometry-of-embed/ (Pages needs a minute to refresh)"
