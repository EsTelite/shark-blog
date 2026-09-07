# Site Configuration Reference

This document describes how the Hugo site is organized and configured.

## Configuration file

The project uses `site.config.yaml` as its primary Hugo configuration file. Because this is a project-specific filename rather than Hugo's default `hugo.yaml`, commands must pass it explicitly:

```bash
hugo server --config site.config.yaml
hugo --config site.config.yaml --destination public
```

The initial configuration should remain focused on local static development:

```yaml
baseURL: "http://localhost:1313/"
locale: "en-us"
title: "Shark Blog"

author:
  name: "Your Name"

params:
  description: "A simple static blog"
  author: "Your Name"

permalinks:
  posts: "/posts/:slug/"

taxonomies:
  tag: "tags"
  category: "categories"

markup:
  goldmark:
    renderer:
      unsafe: false
```

Do not add production domains, deployment credentials, or hosting-specific configuration until a public deployment target has been chosen.

## Repository directories

| Directory | Purpose |
| --- | --- |
| `content/posts/` | Markdown blog posts and their YAML front matter. |
| `layouts/` | Hugo HTML templates and partials. |
| `static/images/` | Images copied directly to `/images/` in the generated site. |
| `static/css/` | CSS copied directly to `/css/` in the generated site. |
| `archetypes/` | Templates for creating new content files. |
| `docs/` | Project standards and references. |
| `public/` | Generated output; local-only and ignored by Git. |
| `resources/` | Hugo-generated resources; local-only and ignored by Git. |

## Layout responsibilities

The initial layout set should provide:

- `layouts/_default/baseof.html` — shared HTML document shell.
- `layouts/index.html` — home page and latest posts.
- `layouts/posts/list.html` — post listing page.
- `layouts/posts/single.html` — individual post page.
- `layouts/partials/header.html` — site header and navigation.
- `layouts/partials/footer.html` — site footer.

Templates should be small, semantic, and readable. Keep styling in `static/css/site.css` rather than embedding large style blocks in templates.

## URL and asset rules

- Posts use `/posts/:slug/` URLs.
- Site assets are referenced from the generated site root, for example `/images/diagram.png`.
- Files in `static/` are copied without template processing.
- Generated `public/` files must not be edited manually.
- Keep links and asset paths compatible with a future non-local `baseURL`.

## Configuration change checklist

When changing configuration:

- [ ] Confirm the YAML is valid.
- [ ] Run the local server with `--config site.config.yaml`.
- [ ] Check affected URLs and templates.
- [ ] Rebuild the `public/` output.
- [ ] Update this reference if the project convention changed.
