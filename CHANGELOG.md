# Changelog

All notable changes to this project will be documented in this file.

## [v0.1.0] – 2025-05-08

### Added
- Initial release of `rust-dev` and `rust-runtime` containers.
- `Dockerfile.dev` includes full Rust toolchain with:
  - `clippy`, `rustfmt`, `cargo-audit`, `cargo-outdated`, Diesel CLI (PostgreSQL), Redis, and Protobuf tooling.
- `Dockerfile.runtime` added for minimal deployment use with:
  - `debian:bookworm-slim`
  - `ca-certificates` only, intended for use by downstream Rust apps (e.g., `cr8s`).
- `.dockerignore` now excludes dev artifacts and editor temp files.
- Updated `README.md` with instructions and usage for both containers.
- GitHub Actions CI badge and `ci.yml` workflow integrated.

### Changed
- `WORKDIR` for `dev` container now set to `/app` with non-root `dev` user, enabling volume mounts for local Rust projects.

### Notes
- These images are published to [ghcr.io](https://ghcr.io/johnbasrai):
  - `ghcr.io/johnbasrai/rust-dev:latest`
  - `ghcr.io/johnbasrai/rust-runtime:latest`
- `runtime` container not currently in use by downstream apps, but prepared for future multi-stage builds.
