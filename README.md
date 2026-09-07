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

## Deploy to the development R2 site

The repository includes `scripts/deploy-r2.sh`. It uses AWS CLI against Cloudflare's S3-compatible endpoint to build Hugo and upload the generated files to the `shark-blog` R2 bucket. Uploaded objects use a five-minute cache lifetime by default, so purging is normally unnecessary:

```bash
./scripts/deploy-r2.sh
```

The script expects `CF_ACCOUNT_ID`, `R2_ACCESS_KEY_ID`, and `R2_SECRET_ACCESS_KEY` in `.env`. `CF_API_TOKEN` and `CF_ZONE_ID` are required only when `PURGE_CACHE=true`. Optional overrides include `SITE_URL`, `R2_BUCKET`, `R2_ENDPOINT`, `CACHE_CONTROL`, `PURGE_CACHE`, `CONFIG_FILE`, and `OUTPUT_DIR`:

```bash
SITE_URL=https://blog.ssdindo.com R2_BUCKET=shark-blog ./scripts/deploy-r2.sh
```

For an immediate update without waiting up to five minutes for cached responses, opt into a purge:

```bash
PURGE_CACHE=true ./scripts/deploy-r2.sh
```

Keep `.env` local and never commit it. Create the R2 credentials with Object Read & Write access to the `shark-blog` bucket. The Cloudflare API token is used only when `PURGE_CACHE=true`.
