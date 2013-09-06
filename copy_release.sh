#!/usr/bin/env bash

set -e

# assign the release version to copy
release=$1

if [ -z $release ]; then
  echo "You must enter a release version." >&2
  exit 1
fi

# working paths
copy_from="../Sugar/release"
copy_to="app/assets/javascripts"

# move the full scripts
cp $copy_from/sugar-full.development.js $copy_to/sugar-development.js
cp $copy_from/sugar-full.min.js $copy_to/sugar-full.js
cp $copy_from/sugar.min.js $copy_to/sugar.js

# update the version identifier
sed -i "" "s/SUGARJS_VERSION = \"[0-9\.]*\"/SUGARJS_VERSION = \"$release\"/" lib/sugar/rails/version.rb

echo "Successfully copied Sugar $release to the sugar-rails"
