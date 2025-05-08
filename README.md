# rust-dev-tools

🛠️ Reusable Rust development container with support for formatting, linting, Diesel, PostgreSQL, Redis, Protobuf, and WASM. Designed for CI parity and local development across all JohnBasrai GitHub Rust projects.

## Features

- 🦀 Rust toolchain (with `clippy`, `rustfmt`)
- 🧪 `cargo test`, `cargo audit`, and `cargo fmt` integration
- 🗄️ Diesel CLI + PostgreSQL client libraries
- 🔌 Redis support
- 🧬 `protoc` and `prost-build` for gRPC / Protobuf workflows
- 🌐 WASM support via `wasm32-unknown-unknown` target
- ⚙️ Optimized for use in GitHub Actions, Docker Compose, or VS Code Dev Containers

## Usage

### Docker

```bash
# Clone this repo
git clone https://github.com/JohnBasrai/rust-dev-tools.git
cd rust-dev-tools

# Build the container
docker build -t rust-dev-tools -f Dockerfile.dev .

# Run with your local project mounted
docker run --rm -it -v $(pwd)/../your-project:/app -w /app rust-dev-tools bash
```

## Advanced Usage

For instructions on manually pushing containers to GHCR, see [docs/pushing-locally.md](docs/pushing-locally.md).

## License

[MIT](LICENSE)
