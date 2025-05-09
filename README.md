<!-- -*- mode: markdown -*- -->

# rust-base-containers

![Build and Push](https://github.com/JohnBasrai/rust-base-containers/actions/workflows/ci.yml/badge.svg)

🛠️ Reusable Rust development container with support for formatting, linting, Diesel, PostgreSQL, Redis, Protobuf, and WASM. Designed for CI parity and local development across all JohnBasrai GitHub Rust projects.

---

## Features

- 🦀 Rust toolchain (with `clippy`, `rustfmt`)
- 🧪 `cargo test`, `cargo audit`, and `cargo fmt` integration
- 🗄️ Diesel CLI + PostgreSQL client libraries
- 🔌 Redis support
- 🧬 `protoc` and `prost-build` for gRPC / Protobuf workflows
- 🌐 WASM support via `wasm32-unknown-unknown` target
- ⚙️ Optimized for use in GitHub Actions, Docker Compose, or VS Code Dev Containers

---

## Container Variants

This project builds and publishes two containers:

- **`dev`**: Full-featured development environment with Rust, clippy, rustfmt, cargo-audit, Diesel CLI, Protobuf, and more. Use this for CI, development, and testing.
- **`runtime`**: Minimal runtime container with only the `libpq5` dependency and a pre-built binary. Use this for production or Docker Compose targets.

Both containers are published to:
`ghcr.io/johnbasrai/rust-base-containers`

---

### 🧩 Using the Runtime Container in Your App Repos (e.g. `cr8s`)

If you're using `rust-runtime` as a base image in another Rust project like `cr8s`, you can extend it in your app's `Dockerfile` like so:

```Dockerfile
# Dockerfile in cr8s/
FROM ghcr.io/johnbasrai/rust-runtime:latest

# Copy in your compiled binary
COPY target/release/cr8s /usr/local/bin/app

# Set the default command (optional if already set)
CMD ["app"]
```

This lets you:

* Avoid duplicating runtime dependencies like `libpq5`
* Keep build and runtime containers cleanly separated
* Build in CI with `ghcr.io/johnbasrai/rust-dev:latest`, and run with `ghcr.io/johnbasrai/rust-runtime:latest`


> 📌 Make sure the binary is built (e.g., via `cargo build --release`) before building the image.

---

## 🏃‍♂️ rust-runtime

Minimal runtime container for Rust apps, used as a base image by downstream projects (e.g., `cr8s`). Includes only `ca-certificates` on top of `debian:bookworm-slim`.

```Dockerfile
FROM ghcr.io/johnbasrai/rust-runtime:latest
COPY ./target/release/myapp /usr/local/bin/myapp
CMD ["myapp"]
```
---

## License

[MIT](LICENSE)
