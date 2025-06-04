# rust-base-containers

![Build and Push](https://github.com/JohnBasrai/rust-base-containers/actions/workflows/ci.yml/badge.svg)

🛠️ Reusable Rust development and runtime containers with support for formatting, linting, Diesel, PostgreSQL, Redis, Protobuf, and WASM. Designed to ensure CI parity and streamlined local development across all JohnBasrai GitHub Rust projects.

> ⚠️ Using the `rust-dev` container with dependencies preinstalled can reduce build times by up to 5 minutes or more vs using offical `rust:1.83-slim` base image.

---

## 📌 Versioning Policy

Container tags follow a two-track policy:

- `rust-dev` uses `X.Y.0-revN` format, where `X.Y` matches the Rust toolchain version (e.g., `1.83.0-rev5`)
- `rust-runtime` uses `A.B.C` format aligned with downstream consumer crate versions (e.g., `0.1.3` from `cr8s-fe`)

> ❗ Tags do **not** use a `v` prefix.  
> For full details, see [CONTRIBUTING.md](CONTRIBUTING.md).

---

## Features

- 🦀 Rust toolchain (with `clippy`, `rustfmt`)
- 🧪 `cargo test`, `cargo audit`, cargo outdated, and `cargo fmt` integration
- 🗄️ PostgreSQL cli + client libraries
- 🔌 Redis support
- 🧬 `protoc` and `prost-build` for gRPC / Protobuf workflows
- 🌐 WASM support via `wasm32-unknown-unknown` target
- ⚙️ Optimized for use in GitHub Actions, Docker Compose, and local dev

---

## Container Variants

This project builds and publishes two containers under `ghcr.io/johnbasrai/cr8s/`:

### `rust-dev`
- Full-featured dev container for building, testing, and formatting
- Based on `rust:1.83-slim`
- Includes Redis tools, `cargo-audit`, `protobuf`, and `rustfmt`
- Tagged as:  
  - `ghcr.io/johnbasrai/cr8s/rust-dev:1.83.0-rev5`

### `rust-runtime`
- Minimal runtime container
- Based on a pinned digest of `debian:bookworm-slim`
- Installs only `ca-certificates`
- Used to run statically linked Rust apps
- Tagged as:  
  - `ghcr.io/johnbasrai/cr8s/rust-runtime:0.1.3`

---

## 🔁 Example: Using `rust-runtime` in cr8s

```Dockerfile
# Dockerfile in cr8s/
FROM ghcr.io/johnbasrai/cr8s/rust-runtime:0.1.3

# Copy your compiled binary
COPY target/release/cr8s /usr/local/bin/cr8s

CMD ["cr8s"]
