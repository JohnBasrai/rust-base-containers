# Changelog

All notable changes to this project will be documented in this file.

---

## [v0.1.0] – 2025-05-08

### Added
- `Dockerfile.dev`: Full Rust development environment (rustfmt, clippy, audit, Diesel CLI, Redis, Protobuf, WASM)
- `Dockerfile.runtime`: Minimal runtime container with libpq5 for production use
- `quickstart.sh`: Unified script to build, run, and test containers
- `scripts/build-images.sh`: Build both dev and runtime containers at once
- `scripts/push-to-ghcr.sh`: Manual GHCR publishing with `$GHCR_PAT`
- `.editorconfig` and `.gitattributes` for cross-editor and cross-platform consistency
- `docs/pushing-locally.md`: Guide for manual container pushes

### Changed
- Updated to `rust:1.83-slim` to support latest versions of `diesel_cli` and `cargo-outdated`
- Cleaned and clarified `README.md` for usage with downstream repos
