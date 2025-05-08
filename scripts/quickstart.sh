#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME_DEV="rust-dev-tools"
IMAGE_NAME_RUNTIME="rust-runtime"

usage() {
  echo "Usage: $0 [build [dev|runtime|all]|shell|check]"
  exit 1
}

case "${1:-shell}" in
  build)
    case "${2:-dev}" in
      dev)
        echo "🔨 Building dev container..."
        docker build -f Dockerfile.dev -t $IMAGE_NAME_DEV .
        ;;
      runtime)
        echo "🔨 Building runtime container..."
        docker build -f Dockerfile.runtime -t $IMAGE_NAME_RUNTIME .
        ;;
      all)
        echo "🔨 Building both dev and runtime containers..."
        docker build -f Dockerfile.dev -t $IMAGE_NAME_DEV .
        docker build -f Dockerfile.runtime -t $IMAGE_NAME_RUNTIME .
        ;;
      *)
        usage
        ;;
    esac
    ;;
  shell)
    echo "🚀 Launching dev shell..."
    docker run --rm -it -v "$PWD":/app -w /app $IMAGE_NAME_DEV bash
    ;;
  check)
    echo "🧪 Running checks (fmt, clippy, test)..."
    docker run --rm -v "$PWD":/app -w /app $IMAGE_NAME_DEV bash -c \
      "cargo fmt -- --check && cargo clippy --all-targets --all-features -- -D warnings && cargo test"
    ;;
  *)
    usage
    ;;
esac
