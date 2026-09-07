#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
cd "$ROOT_DIR"

ENV_FILE=${ENV_FILE:-.env}
CONFIG_FILE=${CONFIG_FILE:-site.config.yaml}
OUTPUT_DIR=${OUTPUT_DIR:-public}
SITE_URL=${SITE_URL:-https://blog.ssdindo.com}
R2_BUCKET=${R2_BUCKET:-shark-blog}
CACHE_CONTROL=${CACHE_CONTROL:-max-age=300}
PURGE_CACHE=${PURGE_CACHE:-false}

if [[ -f "$ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi

: "${CF_ACCOUNT_ID:?CF_ACCOUNT_ID must be set in $ENV_FILE or the environment}"
: "${R2_ACCESS_KEY_ID:?R2_ACCESS_KEY_ID must be set in $ENV_FILE or the environment}"
: "${R2_SECRET_ACCESS_KEY:?R2_SECRET_ACCESS_KEY must be set in $ENV_FILE or the environment}"

if [[ "${PURGE_CACHE,,}" == "true" ]]; then
  : "${CF_API_TOKEN:?CF_API_TOKEN must be set when PURGE_CACHE=true}"
  : "${CF_ZONE_ID:?CF_ZONE_ID must be set when PURGE_CACHE=true}"
fi

R2_ENDPOINT=${R2_ENDPOINT:-"https://${CF_ACCOUNT_ID}.r2.cloudflarestorage.com"}
API_BASE="https://api.cloudflare.com/client/v4"

require_command() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "error: required command not found: $1" >&2
    exit 1
  }
}

for command in hugo aws curl python3; do
  require_command "$command"
done

export AWS_ACCESS_KEY_ID="$R2_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$R2_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="auto"

echo "Building Hugo site for $SITE_URL"
rm -rf "$OUTPUT_DIR"
hugo --config "$CONFIG_FILE" --baseURL "${SITE_URL%/}/" --destination "$OUTPUT_DIR"

echo "Uploading $OUTPUT_DIR to R2 bucket $R2_BUCKET"
aws s3 sync "$OUTPUT_DIR/" "s3://$R2_BUCKET/" \
  --endpoint-url "$R2_ENDPOINT" \
  --region auto \
  --delete \
  --cache-control "$CACHE_CONTROL" \
  --only-show-errors

# AWS CLI MIME detection can vary by environment; explicitly correct CSS metadata.
if [[ -f "$OUTPUT_DIR/css/site.css" ]]; then
  aws s3 cp "$OUTPUT_DIR/css/site.css" "s3://$R2_BUCKET/css/site.css" \
    --endpoint-url "$R2_ENDPOINT" \
    --region auto \
    --cache-control "$CACHE_CONTROL" \
    --content-type "text/css" \
    --only-show-errors
fi

if [[ "${PURGE_CACHE,,}" == "true" ]]; then
  echo "Purging Cloudflare cache for $SITE_URL"
  purge_payload=$(python3 -c 'import json, sys; print(json.dumps({"files": [sys.argv[1] + "/", sys.argv[1] + "/index.html", sys.argv[1] + "/css/site.css"]}))' "$SITE_URL")
  curl --fail-with-body --silent --show-error \
    -X POST \
    -H "Authorization: Bearer $CF_API_TOKEN" \
    -H "Content-Type: application/json" \
    --data "$purge_payload" \
    "$API_BASE/zones/$CF_ZONE_ID/purge_cache" \
    | python3 -c 'import json, sys; data=json.load(sys.stdin); raise SystemExit(0 if data.get("success") else json.dumps(data.get("errors", [])))'
else
  echo "Skipping cache purge; objects use Cache-Control: $CACHE_CONTROL"
fi

echo "Deployment complete: $SITE_URL"
