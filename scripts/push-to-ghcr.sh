#!/usr/bin/env bash
set -euo pipefail

# CONFIG
IMAGE_NAME_DEV="ghcr.io/johnbasrai/rust-dev-tools:dev"
IMAGE_NAME_RUNTIME="ghcr.io/johnbasrai/rust-dev-tools:runtime"
USERNAME="johnbasrai"

# Ensure PAT is set
if [[ -z "${GHCR_PAT:-}" ]]; then
  echo "❌ Environment variable GHCR_PAT is not set."
  echo "Please export your GitHub Personal Access Token:"
  echo "    export GHCR_PAT=ghp_xxxYourTokenHere"
  exit 1
fi

echo "🔐 Logging in to ghcr.io..."
echo "$GHCR_PAT" | docker login ghcr.io -u "$USERNAME" --password-stdin

echo "📤 Pushing dev container..."
docker push "$IMAGE_NAME_DEV"

echo "📤 Pushing runtime container..."
docker push "$IMAGE_NAME_RUNTIME"

echo "✅ Done!"
