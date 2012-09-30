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
copy_to="vendor/assets/javascripts"

# move the 'precompiled' directory
cp -R $copy_from/$release/precompiled $copy_to

# move the full scripts
cp $copy_from/$release/sugar-$release-full.development.js $copy_to/sugar-development.js
cp $copy_from/$release/sugar-$release-full.min.js $copy_to/sugar-full.js
cp $copy_from/$release/sugar-$release.min.js $copy_to/sugar.js

# update the version identifier
sed -i "" "s/SUGARJS_VERSION = \"[0-9\.]*\"/SUGARJS_VERSION = \"$release\"/" lib/sugar/rails/version.rb

echo "Successfully copied Sugar $release to the sugar-rails"
