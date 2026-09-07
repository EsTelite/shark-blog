# Shark Blog

A simple static blog built with Hugo, Markdown, YAML front matter, and plain HTML/CSS templates.

## Local development

Hugo must be installed first:

```bash
hugo version
```

Start the development server:

```bash
hugo server --config site.config.yaml
```

Open [http://localhost:1313](http://localhost:1313).

To include draft posts:

```bash
hugo server --config site.config.yaml --buildDrafts
```

## Build static output

```bash
hugo --config site.config.yaml --destination public
```

The generated site is written to `public/`, which is ignored by Git.

To preview the generated output directly:

```bash
python3 -m http.server 8080 --directory public
```

## Project documentation

See [`docs/`](docs/) for writing standards, YAML front matter conventions, Hugo configuration, and the local development reference.
