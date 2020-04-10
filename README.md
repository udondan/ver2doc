# VerDoc

VerDoc is a helper to update version references in your documentation.

It expects your version to be stored in the file `VERSION` in the root of the repository.

```yaml
---
on:
  push:
    paths:
      - VERSION

jobs:
  set-version:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2
        with:
          fetch-depth: 1

      - name: Update Readme
        uses: udondan/verdoc@v0.7.0
        with:
          FILE: README.md
          PATTERN: (udondan/verdoc\@v)[0-9.]+
          REPLACE: \${1}${VERSION}

      - name: Update Action
        uses: udondan/verdoc@v0.7.0
        with:
          FILE: action.yml
          PATTERN: (udondan/verdoc:)[0-9.]+
          REPLACE: \${1}${VERSION}
```
