default:

_get-version *tag:
  sh ./scripts/get-version.sh {{tag}}

_get-version-tag *tag:
  echo "v$(just _get-version '{{tag}}')"

change-version tag:
  sh ./scripts/change-version.sh {{tag}}

_generate-title *tag:
  sh ./scripts/generate-title.sh {{tag}}

_generate-notes *tag:
  sh ./scripts/generate-notes.sh {{tag}}

create-release *tag: _add-tag
  git push --tags
  git push
  gh release create "$(just _get-version-tag '{{tag}}')" --title "$(just _generate-title '{{tag}}')" --notes "$(just _generate-notes '{{tag}}')"

_add-tag:
  git checkout master
  git tag "v$(grep '^version' typst.toml | cut -d ' ' -f 3 | tr -d '"')" HEAD

# The newly created directory (with content) is used for making a PR into the
# https://github.com/typst/packages repository.
make-PR-version:
  version=$(just _get-version); \
  mkdir "$version"; \
  find -maxdepth 1 -type f -name '[^.]*' -print0 | xargs -0 -I {} -- cp -rf '{}' "$version"/
