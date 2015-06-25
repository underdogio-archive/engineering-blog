#!/usr/bin/env bash
# Exit on the first error and echo commands
set -e
set -x

# Build our files
npm run build

# Update all `article` URLs to include an `index.html`
# DEV: Without this change, links between articles wouldn't work on htmlpreview.github.com
#   `href="/articles/roll-call-todd/"` -> `href="/articles/roll-call-todd/index.html"`
# DEV: This must come before we prepend `/underdogio` to URLs
shopt -s globstar
sed -E "s/( href=\"\/articles\/[^\"]+)\/\"/\1\/index.html\"/" build/**/*.html --in-place
shopt -u globstar

# Update the absolute paths (but not absolute URLs) to be prefixed with repo
# DEV: This is necessary for raw.githubcontent.com
#   `/css/main.css` -> `/underdogio/underdogio.github.io/my-preview-branch/css/main.css`
branch="$(git symbolic-ref HEAD --short)"
preview_branch="$branch.preview"
escaped_preview_branch="$(echo $preview_branch | sed -E "s/\\//\\\\\//g")"
shopt -s globstar
sed -E "s/( href=)\"\/([^\"]+)/\1\"\/underdogio\/underdogio.github.io\/$escaped_preview_branch\/\2/" build/**/*.html --in-place
sed -E "s/( src=)\"\/([^\"]+)/\1\"\/underdogio\/underdogio.github.io\/$escaped_preview_branch\/\2/" build/**/*.html --in-place
shopt -u globstar

# Publish our folder
./node_modules/.bin/gh-pages --dist build/ --branch "$preview_branch"

# Silence extra noise
set +x

# Notify ourselves of the successful build
echo "A preview of underdogio.github.io has been built and pushed to the \`$preview_branch\` branch"
echo "Please view it at http://htmlpreview.github.io/?https://github.com/underdogio/underdogio.github.io/blob/$preview_branch/index.html"
exit 0
