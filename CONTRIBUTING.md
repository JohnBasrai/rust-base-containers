# Contributing to `rust-base-containers`

This repository builds and maintains two container images:

- `rust-dev`: a full-featured development container with Rust, tooling, and system dependencies
- `rust-runtime`: a minimal runtime container for statically linked Rust binaries

These containers are consumed by downstream projects like [`cr8s`](https://github.com/JohnBasrai/cr8s) and `cr8s-fe`. This document defines the tagging strategy, versioning policy, and CI best practices for contributing to this repository.

---

## 📦 Versioning and Tagging Strategy

This repository publishes two container images:

| Target        | Tag Format                | Purpose                                           |
|---------------|---------------------------|---------------------------------------------------|
| `rust-dev`    | `1.83.0-revN`             | Tracks Rust toolchain version + dev tooling state |
| `rust-runtime`| `YYYY.MM.DD[.rN]`         | Tracks this repo's runtime container revisions     |

### `rust-dev` Tag Format

- Mirrors the current Rust toolchain version (`1.83.0`, `1.74.1`, etc.)
- Uses a `-revN` suffix to track internal updates:
  - New tooling (`cargo-audit`, `trunk`) or updated to them
  - Base image changes
  - CI enhancements
- Examples:
  - `1.83.0-rev1`
  - `1.83.0-rev2`

### `rust-runtime` Tag Format

- Follows a **monotonically increasing**, **date-based format**:
  - `YYYY.MM.DD` for the first release on a given day
  - `YYYY.MM.DD.r2`, `YYYY.MM.DD.r3`, etc. for subsequent releases on same day
- This format is:
  - **Easy to understand**
  - **Encodes recency**
  - **Independent from downstream app versioning**
- Examples:
  - `2025.05.19`
  - `2025.05.19.r2`

> ⚠️ `rust-runtime` versions are fully decoupled from downstream `cr8s` or `cr8s-fe` crate versions.
> This avoids confusion and lets container updates proceed independently.

### Git Repository Tags

- This repo uses the same `YYYY.MM.DD[.rN]` format for Git tags to reflect project-wide releases
- These Git tags are used to:
  - Track CI changes
  - Anchor `CHANGELOG.md` updates
  - Group container image releases under a single semantic checkpoint

---

### 📌 Optional Addition to `CONTRIBUTING.md`

You can add a one-liner under your changelog guidance:

> 🔖 Each changelog section is titled with the Git tag:
> `## [YYYY.MM.DD]` — the date **is the tag**, no additional date suffix is needed.

---

## 🧱 Buildx: Per-Repo Builders

To avoid Docker layer cache collisions, each repository uses a **dedicated Buildx builder**:

```yaml
- name: 🧱 Create and Use Named Buildx Builder
  run: |
    BUILDER_NAME="${BUILDER_NAME:-${GITHUB_REPOSITORY#*/}-builder}"
    echo "BUILDER_NAME=$BUILDER_NAME" >> $GITHUB_ENV
    docker buildx inspect "$BUILDER_NAME" > /dev/null 2>&1 || \
      docker buildx create --name "$BUILDER_NAME" --driver docker-container --use
    docker buildx use "$BUILDER_NAME"
```

Later steps (e.g. image builds) reference the builder using the exported variable:
Later steps (e.g. image builds) reference the builder using the exported variable:

```yaml
--builder ${{ env.BUILDER_NAME }}
```

This ensures that each repository's CI jobs use isolated builder names, reducing cache contamination and improving reproducibility.

---
