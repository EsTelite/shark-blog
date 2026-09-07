# Project Documentation

This folder contains the standards and references for the static Hugo blog.

## Documentation map

- [Content and front matter standard](content-standard.md) — how to name, write, and publish posts.
- [Site configuration reference](site-configuration.md) — the Hugo configuration file, layouts, and static assets.
- [Local development reference](local-development.md) — commands for previewing, building, and validating the site locally.

## Project decisions

- Hugo is the static site generator.
- Posts are Markdown files stored in `content/posts/`.
- Post metadata uses YAML front matter delimited by `---`.
- The primary configuration file is `site.config.yaml`.
- The first delivery target is local development and local static output.
- Public deployment is intentionally deferred.

## Documentation rules

1. Treat these documents as the source of truth for project conventions.
2. Update the relevant document when a project decision changes.
3. Keep examples copyable and consistent with the current repository structure.
4. Do not document deployment-specific settings until public deployment is selected.
