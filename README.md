# Ver2Doc

Ver2Doc is a helper to update version references in your documentation.

It expects your version to be stored in the file `VERSION` in the root of the repository.

The action needs to be called for every single file and requires to provide a reges patter to match against.

```yaml
- name: Step 1
  uses: udondan/ver2doc@v1.0.0
  with:
    FILE: some.file
    PATTERN: [0-9.]+
```

You can use back references, which then of course requires you to also provide a replacement string.

```yaml
- name: Step 2
  uses: udondan/ver2doc@v1.0.0
  with:
    FILE: some.file
          FILE: README.md
          PATTERN: (udondan/ver2doc\@v)[0-9.]+
          REPLACE: \${1}${VERSION}
```

Complete example usage in conjunction with [actions/checkout](https://github.com/marketplace/actions/checkout) and [ad-m/github-push-action](https://github.com/marketplace/actions/github-push)

```yaml
---
on:
  push:
    paths:
      - VERSION
    tags-ignore:
      - "*"

jobs:
  set-version:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2
        with:
          fetch-depth: 1

      - name: Update Readme
        uses: udondan/ver2doc@v1.0.0
        with:
          FILE: README.md
          PATTERN: (udondan/ver2doc\@v)[0-9.]+
          REPLACE: \${1}${VERSION}

      - name: Update Action
        uses: udondan/ver2doc@v1.0.0
        with:
          FILE: action.yml
          PATTERN: (udondan/ver2doc:)[0-9.]+
          REPLACE: \${1}${VERSION}

      - name: Commit changes
        run: |
          git config --local user.email "action@github.com"
          git config --local user.name "GitHub Action"
          git diff --exit-code || git commit -m "Updates version references" -a

      - name: Push changes
        uses: ad-m/github-push-action@v0.5.0
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          branch: ${{ github.ref }}
```
