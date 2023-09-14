#!/bin/sh
cd "$(dirname "$0")" || exit 1
version=$(sh ./get-version.sh "$@")

changelog_file='../CHANGELOG.md'
regex_tag=$(echo "$version" | sed 's/\./\\&/g')

specific_version_begin_patter='/## \['"$regex_tag"']/'
version_begin_patter='/## \[[0-9]+\.[0-9]+\.[0-9]+\]/'

sed_command1="${specific_version_begin_patter}="

version_begin_line_number=$(sed -n -E "$sed_command1" "$changelog_file")
plus_one_line=$((version_begin_line_number + 1))

sed_command2="1,${plus_one_line}d"
sed_command3="${version_begin_patter}="

version_begin_line_number=$(
  sed -n -E "$sed_command2;$sed_command3" "$changelog_file"
)
minus_one_line=$((version_begin_line_number - 1))

sed_command4="${minus_one_line},\$d"

notes=$(sed -E "$sed_command2;$sed_command4" "$changelog_file")

echo "$notes"
