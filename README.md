# Geometry of Embeddings --- seminar website

Public website for the seminar, served at <https://fabian-s.github.io/geometry-of-embed/>.

The pages are built from the `.qmd` files of the (private) seminar repo, where
this repo is the `website/` submodule:

* `build.sh` copies the announcement, schedule, primer and glossary from the
  parent repo, drops their PDF `format:` settings, and renders to `docs/`.
  Use it to preview locally (open `docs/index.html`).
* `deploy.sh` builds, commits `docs/` here, pushes to GitHub (Pages serves
  `docs/` on `main`), and then commits and pushes the updated submodule
  pointer in the parent repo (only `website/` is committed there).

## Deployment

1. Edit and commit the source `.qmd` files in the seminar repo as usual.
2. Run `website/deploy.sh` from the seminar repo.
3. Check the site after a minute or two.

`deploy.sh` stops if this checkout is behind `origin/main`
(e.g. after deploying from another machine): run `git -C website pull origin main`
first. Do not edit `docs/` or the copied `.qmd` files here by hand; they are
overwritten on every build.
