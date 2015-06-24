#!/usr/bin/env bash
# Exit on the first error and echo commands
set -e
set -x

# Build our files
npm run build

# Generate a timestamp for our release
version="$(date --utc +%Y%m%d.%H%M%S.%N)"

# Version it via `npm` (bumps package.json, adds git commit, and git tag)
npm version "$version"

# Push our changes
git push origin release
git push origin --tags

# Publish the compiled version to `gh-pages`
npm run _deploy

# Notify ourselves of the successful build
echo "underdogio.github.io has been built and deployed successfully as \"$version\""
echo "Please verify changes at http://underdogio.github.io/"
exit 0
