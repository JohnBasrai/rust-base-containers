#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="rust-dev-tools"

case "${1:-shell}" in
  build)
    echo "🔨 Building Docker image..."
    docker build -t $IMAGE_NAME .
    ;;
  shell)
    echo "🚀 Launching dev shell..."
    docker run --rm -it -v "$PWD":/app -w /app $IMAGE_NAME bash
    ;;
  check)
    echo "🧪 Running checks (fmt, clippy, test)..."
    docker run --rm -v "$PWD":/app -w /app $IMAGE_NAME bash -c \
      "cargo fmt -- --check && cargo clippy --all-targets --all-features -- -D warnings && cargo test"
    ;;
  *)
    echo "Usage: $0 [build|shell|check]"
    exit 1
    ;;
esac
