<!-- -*- mode: markdown -*- -->

# rust-dev-tools

![Build and Push](https://github.com/JohnBasrai/rust-dev-tools/actions/workflows/ci.yml/badge.svg)

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
`ghcr.io/johnbasrai/rust-dev-tools`

---

### 🧩 Using the Runtime Container in Your App Repos (e.g. `cr8s`)

If you're using `rust-dev-tools:runtime` as a base image in another Rust project like `cr8s`, you can extend it in your app's `Dockerfile` like so:

```Dockerfile
# Dockerfile in cr8s/
FROM ghcr.io/johnbasrai/rust-dev-tools:runtime

# Copy in your compiled binary
COPY target/release/cr8s /usr/local/bin/app

# Set the default command (optional if already set)
CMD ["app"]
```

This lets you:

* Avoid duplicating runtime dependencies like `libpq5`
* Keep build and runtime containers cleanly separated
* Build in CI with `rust-dev-tools:dev`, and run with `runtime`

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

## Usage

### Docker

```bash
# Clone this repo
git clone https://github.com/JohnBasrai/rust-dev-tools.git
cd rust-dev-tools

# Build and run the dev container using scripts
./quickstart.sh build dev        # Build dev container only
./quickstart.sh shell            # Launch interactive shell
./quickstart.sh check            # Run fmt, clippy, and tests
```

---

## Advanced Usage

For instructions on manually pushing containers to GHCR, see [docs/pushing-locally.md](docs/pushing-locally.md).

```bash
# Build both dev and runtime containers at once
./scripts/build-images.sh
```

---

## License

[MIT](LICENSE)
