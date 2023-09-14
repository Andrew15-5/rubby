#!/bin/sh
cd "$(dirname "$0")" || exit 1
version=$(sh ./get-version.sh "$@")
tag="v$version"

tag_date=$(
  git log --date=format:%Y-%B-%m --pretty=format:%ad "$tag" | head -n 1
)
year=$(echo "$tag_date" | cut -d - -f 1)
month=$(echo "$tag_date" | cut -d - -f 2)
day=$(echo "$tag_date" | cut -d - -f 3 | sed 's/^0//')
title="Version $version ($month $day, $year)"

echo "$title"
