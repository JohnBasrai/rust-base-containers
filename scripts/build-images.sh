#!/usr/bin/env bash
set -euo pipefail

# Build dev image
echo "🔨 Building dev container..."
docker build -f Dockerfile.dev -t ghcr.io/johnbasrai/rust-dev-tools:dev .

# Build runtime image (optional app copy if staging used)
echo "🔨 Building runtime container..."
docker build -f Dockerfile.runtime -t ghcr.io/johnbasrai/rust-dev-tools:runtime .
