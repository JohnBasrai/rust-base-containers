# Changelog

All notable changes to this project will be documented in this file.

## [2025.05.20]

### Changed
- 🐳 Switched Docker Buildx caching from `type=local` to `type=gha`
- 🧱 Updated Buildx setup to use `docker-container` driver for full BuildKit support
- 🐞 Enabled `--progress=plain` and `--debug` for better cache visibility
- 🚀 CI now supports persistent layer caching across GitHub-hosted runners

## [2025.05.19]

### Fixed
- 🛠️ `chown /usr/local/cargo` so `dev` user can run cargo tools (`clippy`, `audit`, etc.)

### Added
- 🐳 Enable Docker `buildx` cache via `actions/cache@v4` in CI
- 🧱 Use named builder `cr8s-builder` for reproducible CI builds

### Docs
- 🧾 Documented how Docker tags are defined and how to trace which commit built an image
- 🔐 Added guidance on the `dev` user and permission requirements for `cargo` tooling

## [2025-05.15]

### Added
- Added `libssl3` and `libpq5` to runtime container for Rocket + Diesel support
- Upgraded base image from `debian:bullseye-slim` to `debian:bookworm-slim`
- Added `appuser` non-root user for secure runtime execution

## [2025-05-08]

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
  - `ghcr.io/johnbasrai/cr8s/rust-dev:latest`
  - `ghcr.io/johnbasrai/cr8s/rust-runtime:latest`
- `runtime` container not currently in use by downstream apps, but prepared for future multi-stage builds.
