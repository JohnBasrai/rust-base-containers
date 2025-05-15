# rust-base-containers

![Build and Push](https://github.com/JohnBasrai/rust-base-containers/actions/workflows/ci.yml/badge.svg)

🛠️ Reusable Rust development and runtime containers with support for formatting, linting, Diesel, PostgreSQL, Redis, Protobuf, and WASM. Designed to ensure CI parity and streamlined local development across all JohnBasrai GitHub Rust projects.

> ⚠️ These dependencies can extend build times by up 5 minutes or more if installed separately in each derived container. The `rust-dev` container saves this time by providing a pre-configured environment.

---

### 📌 Versioning Policy

Container tags follow semantic versioning aligned to Rust toolchain releases.

> ℹ️ For full details on tag format and branch naming conventions, see [CONTRIBUTING.md](CONTRIBUTING.md#branch-and-tagging-conventions).

---

## Features

- 🦀 Rust toolchain (with `clippy`, `rustfmt`)
- 🧪 `cargo test`, `cargo audit`, and `cargo fmt` integration
- 🗄️ Diesel CLI + PostgreSQL client libraries
- 🔌 Redis support
- 🧬 `protoc` and `prost-build` for gRPC / Protobuf workflows
- 🌐 WASM support via `wasm32-unknown-unknown` target
- ⚙️ Optimized for use in GitHub Actions, Docker Compose, and local dev with `start.sh`

---

## Container Variants

This project builds and publishes two containers under `ghcr.io/johnbasrai/cr8s/`:

### `rust-dev`
- Full-featured dev container for building, testing, and formatting
- Based on `rust:1.83-slim`
- Includes Diesel CLI, Redis tools, `cargo-audit`, `protobuf`, and `rustfmt`
- Tagged as:  
  - `ghcr.io/johnbasrai/cr8s/rust-dev:latest`  
  - `ghcr.io/johnbasrai/cr8s/rust-dev:v1.83`

### `rust-runtime`
- Minimal runtime container
- Based on a pinned digest of `debian:bullseye-slim`
- Installs only `ca-certificates`
- Used to run statically linked Rust apps
- Tagged as:  
  - `ghcr.io/johnbasrai/cr8s/rust-runtime:latest`  
  - `ghcr.io/johnbasrai/cr8s/rust-runtime:v0.3.0`

---

## 🔁 Example: Using `rust-runtime` in cr8s

```Dockerfile
# Dockerfile in cr8s/
FROM ghcr.io/johnbasrai/cr8s/rust-runtime:v0.3.0

# Copy your compiled binary
COPY target/release/cr8s /usr/local/bin/cr8s

CMD ["cr8s"]
