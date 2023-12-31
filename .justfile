_default:

_get-version:
  sh ./scripts/get-version.sh

_get-version-tag:
  echo "v$(just _get-version)"

change-version tag:
  sh ./scripts/change-version.sh {{tag}}

_generate-title:
  sh ./scripts/generate-title.sh

_generate-notes:
  sh ./scripts/generate-notes.sh

create-release: _add-tag
  git push --tags
  git push
  gh release create "$(just _get-version-tag)" \
    --title "$(just _generate-title)" \
    --notes "$(just _generate-notes)"

_add-tag:
  git checkout master
  git tag "v$(grep '^version' typst.toml | cut -d ' ' -f 3 | tr -d '"')" HEAD

# The newly created directory (with content) is used for making a PR into the
# https://github.com/typst/packages repository.
make-PR-version:
  version=$(just _get-version); \
  mkdir "$version"; \
  find -maxdepth 1 -type f -name '[^.]*' -print0 | xargs -0 -I {} -- cp -rf '{}' "$version"/
