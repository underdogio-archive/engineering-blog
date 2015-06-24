#!/usr/bin/env bash
# Exit on the first error
set -e

# Build our files and verify it was successful
# DEV: We could use `test -f` but `ls` bundles an error message nicely
npm run build
ls -la build/index.html
