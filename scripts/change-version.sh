#!/bin/sh
cd "$(dirname "$0")" || exit 1
if [ -z "$1" ]; then
  >&2 echo "Provide a new version"
  exit 1
fi

old_version=$(sh ./get-version.sh)
regex_old_version=$(echo "$old_version" | sed 's/\./\\&/g')

version=$1
regex_new_version=$(echo "$version" | sed 's/\./\\&/g')

sed_command="s/$regex_old_version/$regex_new_version/"
sed -i "$sed_command" ../README.md ../typst.toml ../example.typ
