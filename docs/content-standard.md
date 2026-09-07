# Content and Front Matter Standard

This document defines the writing conventions for posts in `content/posts/`.

## File naming

Use a date prefix followed by a lowercase, hyphen-separated slug:

```text
YYYY-MM-slug.md
```

Examples:

```text
2026-03-first-post.md
2026-09-migrating-from-medium.md
```

The filename should be stable after publication. If a published URL must change, add an explicit `slug` or redirect/alias deliberately rather than renaming the file casually.

## YAML front matter

Every post must begin with YAML front matter using `---` delimiters. The `title`, `date`, and `draft` fields are required.

```markdown
---
title: "My First Post"
date: 2026-03-15T10:00:00+07:00
draft: false
description: "A short description used for the page metadata."
summary: "A short excerpt shown in post listings."
tags:
  - blogging
  - personal
categories:
  - general
image: "/images/my-first-post.png"
---
```

### Field rules

| Field | Required | Standard |
| --- | --- | --- |
| `title` | Yes | Use a clear, human-readable title and quote it. |
| `date` | Yes | Use an ISO 8601 date and timezone offset. |
| `draft` | Yes | Use the boolean values `true` or `false`, never quoted strings. |
| `description` | No | Keep it concise and suitable for search and social metadata. |
| `summary` | No | Use a readable excerpt for the post listing. |
| `tags` | No | Use lowercase, specific terms. |
| `categories` | No | Use a small number of broad categories. |
| `image` | No | Use a site-relative path beginning with `/images/`. |
| `slug` | No | Add only when the URL should differ from the filename. |

Use block-style YAML arrays for lists. Keep metadata values simple and avoid putting Markdown inside front matter.

## Draft and publication rules

- New posts should start with `draft: true`.
- Set `draft: false` only after the post has been reviewed locally.
- Do not use future publication dates unless the scheduled publishing behavior has been intentionally configured and tested.
- Keep the `date` value explicit; do not rely only on the filename date.

## Markdown writing rules

- Do not repeat the post title as a Markdown `#` heading; the Hugo template renders the title.
- Use `##` for major sections and `###` for subsections.
- Keep paragraphs short and focused on one idea.
- Use fenced code blocks with a language identifier:

  ````markdown
  ```bash
  hugo server --config site.config.yaml
  ```
  ````

- Use descriptive link text instead of bare URLs when possible.
- Add meaningful alt text to images.
- Prefer relative, stable site paths for internal links.
- Store post images in `static/images/`; reference them as `/images/filename.ext`.
- Avoid inline HTML unless the Markdown renderer cannot express the required result.

## Review checklist

Before publishing a post:

- [ ] The filename follows `YYYY-MM-slug.md`.
- [ ] YAML front matter is valid and uses the required fields.
- [ ] The title and date are correct.
- [ ] `draft` is set to `false` only when ready.
- [ ] Links work in the local preview.
- [ ] Images load and have useful alt text.
- [ ] Code blocks specify their language.
- [ ] Headings follow the hierarchy without skipping levels.
- [ ] The post is readable on a narrow screen.
