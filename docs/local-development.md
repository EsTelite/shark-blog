# Local Development Reference

The first project milestone is a blog that can be previewed and built entirely on a local machine.

## Prerequisites

Install Hugo and verify the installation:

```bash
hugo version
```

The initial site does not require Node.js, a database, or a backend server.

## Start the development server

From the repository root:

```bash
hugo server --config site.config.yaml
```

Open the site at:

```text
http://localhost:1313
```

Hugo watches content, templates, configuration, and static assets and refreshes the preview when files change.

To include unpublished draft posts while writing:

```bash
hugo server --config site.config.yaml --buildDrafts
```

Drafts should remain `draft: true` until they are ready for publication.

## Create a new post

After the Hugo scaffold and post archetype exist, create a post with:

```bash
hugo new content/posts/YYYY-MM-slug.md --kind posts --format yaml
```

Review the generated front matter against [the content standard](content-standard.md), then write the Markdown body.

## Build static output

Generate the site into the local `public/` directory:

```bash
hugo --config site.config.yaml --destination public
```

The `public/` directory is generated output. Do not edit it manually or commit it to the repository.

To preview the generated files without Hugo's development server:

```bash
python3 -m http.server 8080 --directory public
```

Open:

```text
http://localhost:8080
```

## Local validation checklist

- [ ] Hugo starts without configuration errors.
- [ ] The home page loads at `http://localhost:1313`.
- [ ] Published posts appear in the listing.
- [ ] Draft posts are hidden by default.
- [ ] Draft posts appear with `--buildDrafts`.
- [ ] Individual post URLs work.
- [ ] Titles, dates, summaries, tags, and categories render correctly.
- [ ] Markdown headings, links, lists, and code blocks render correctly.
- [ ] Images under `static/images/` load through `/images/...`.
- [ ] The generated `public/` directory contains the expected HTML, CSS, and assets.
- [ ] The site remains usable at a narrow browser width.

## Troubleshooting

### Hugo cannot find the configuration

Use the explicit configuration flag:

```bash
hugo server --config site.config.yaml
```

### A post does not appear

Check that its front matter contains:

```yaml
draft: false
```

Also check that the post date is not unintentionally in the future.

### An image does not load

Place the file under `static/images/` and reference it from content as:

```markdown
![Descriptive alt text](/images/example.png)
```

### The preview looks stale

Stop and restart Hugo, or remove the generated `public/` directory and build again. Do not change generated files directly.

## Official Hugo references

- [Hugo Quick Start](https://gohugo.io/getting-started/quick-start/)
- [Hugo Front Matter](https://gohugo.io/content-management/front-matter/)
- [Hugo Templates](https://gohugo.io/templates/)
- [Hugo Server Command](https://gohugo.io/commands/hugo_server/)
- [Hugo Build Command](https://gohugo.io/commands/hugo/)
