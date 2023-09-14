default:

get-version *tag:
  sh ./scripts/get-version.sh {{tag}}

get-version-tag *tag:
  echo "v$(just get-version '{{tag}}')"

change-version tag:
  sh ./scripts/change-version.sh {{tag}}

generate-title *tag:
  sh ./scripts/generate-title.sh {{tag}}

generate-notes *tag:
  sh ./scripts/generate-notes.sh {{tag}}

create-release *tag:
  gh release create "$(just get-version-tag '{{tag}}')" --title "$(just generate-title '{{tag}}')" --notes "$(just generate-notes '{{tag}}')"

add-tag:
  git checkout master
  git tag "v$(grep '^version' typst.toml | cut -d ' ' -f 3 | tr -d '"')" HEAD
