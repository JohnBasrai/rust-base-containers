#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Installing Diesel CLI with PostgreSQL support..."

# Ensure cargo is available
if ! command -v cargo >/dev/null 2>&1; then
  echo "❌ cargo not found. Please install Rust first."
  exit 1
fi

# Install Diesel CLI with Postgres only (not SQLite or MySQL)
cargo install diesel_cli --no-default-features --features postgres

echo "✅ Diesel CLI installed successfully."
