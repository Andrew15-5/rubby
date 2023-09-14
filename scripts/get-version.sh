#!/bin/sh
cd "$(dirname "$0")" || exit 1
version_tags=$(git tag --list | grep '^v')
latest_version_tag=$(echo "$version_tags" | sort -Vr | head -n 1)

if [ -z "$1" ]; then
  tag=$latest_version_tag
else
  tags=$(echo "$version_tags" | grep -F "$1")
  lines=$(echo "$tags" | wc --lines)
  if [ -z "$tags" ]; then
    >&2 echo "There is not tag matching $1"
    exit 1
  fi
  if [ "$lines" -ne 1 ]; then
    >&2 echo "$1 matches more than one tag"
    exit 1
  fi
  tag=$tags
fi

version=$(echo "$tag" | sed 's/v//')

echo "$version"
