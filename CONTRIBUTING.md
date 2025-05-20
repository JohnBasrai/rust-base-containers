# Contributing to rust-base-containers

This repository builds and maintains the `rust-dev` and `rust-runtime` containers used by downstream projects like [`cr8s`](https://github.com/JohnBasrai/cr8s) and `cr8s-fe`. To maintain consistency across the ecosystem, we follow a structured versioning and tagging policy.

---

## 📦 1 Image Versioning

We publish two container images:

| Image         | Purpose                          | Versioning Source                      |
|---------------|----------------------------------|----------------------------------------|
| `rust-dev`    | Dev container with Rust + tools  | Rust toolchain version + repo revision |
| `rust-runtime`| Minimal runtime container        | Matches downstream crate version       |

---

> ### 1.1 `rust-dev` Version Format

- Format: `X.Y.0-revN` (e.g., `1.83.0-rev3`)
- `X.Y.0`: Matches the Rust toolchain version (e.g. `1.83.0`)
- `revN`: Tracks repo-level revisions, e.g.:
  - Adding new tooling (e.g., `cargo-deny`, `wasm-bindgen`)
  - Base OS or dependency updates

> Example: `rust-dev:1.83.0-rev3`

---

> ### 1.2 `rust-runtime` Version Format

- Format: matches the crate version of the downstream app (e.g., `cr8s`, `cr8s-fe`)
- No `v` prefix
- Derived from `Cargo.toml`

> Example: `rust-runtime:0.1.3` for `cr8s-fe@0.1.3`

### 📍 Where Docker Tags Are Defined

The `rust-dev` and `rust-runtime` image tags are **set explicitly** in the `ci.yml` workflow file:

```yaml
env:
  RUST_DEV_VERSION:     1.83.0-rev3
  RUST_RUNTIME_VERSION: 0.1.3
```

### 🧱 Named Buildx Builder per Repo

To avoid cache collisions between repositories using Docker Buildx, CI workflows should use a **repo-specific builder name**. This is especially important when enabling layer caching with `--cache-from` and `--cache-to`.

Recommended pattern in `ci.yml`:

```yaml
- name: 🧱 Create and Use Named Buildx Builder
  run: |
    BUILDER_NAME="${BUILDER_NAME:-${GITHUB_REPOSITORY#*/}-builder}"
    echo "BUILDER_NAME=$BUILDER_NAME" >> $GITHUB_ENV
    docker buildx inspect "$BUILDER_NAME" > /dev/null 2>&1 || \
      docker buildx create --name "$BUILDER_NAME" --driver docker-container --use
    docker buildx use "$BUILDER_NAME"
```

Later steps reference the builder like this:

```yaml
--builder ${{ env.BUILDER_NAME }}
```

This ensures that each repository's CI jobs use isolated builder names, reducing cache contamination and improving reproducibility.

---

### 🔐 Dev User and Cargo Permissions

The `rust-dev` container runs as a non-root user named `dev` (`UID=1000`) for compatibility with host bind mounts and to support container-safe linting and formatting.

To ensure tools like `cargo clippy`, `cargo audit`, and `cargo fmt` work correctly inside the container:

```dockerfile
# Dockerfile.dev
RUN chown -R dev:dev /usr/local/cargo
```

This grants the `dev` user full access to the Rust toolchain, registry, and cache directories, which are typically owned by the user in standard setups (`$HOME/.cargo`).

> ⚠️ Omitting this step may result in `Permission denied` errors when running cargo tools inside the container.

---

## 2 🏷️ Tag Naming Rules

- ❌ **No `v` prefix** in Docker image tags
- ✅ Use `-revN` suffix for internal revisions (only applies to `rust-dev`)
- ✅ Git tags for this repo may still use `v` (e.g., `v0.1.4` release)

---

## 3 🌿 Branching and Releases

- Branch names should reflect scope:  
  `fix/image-tag-policy-alignment`, `ci/version-tagging`, etc.
- Releases should correspond to meaningful changes (e.g., base image realignment, CI updates)
- GitHub Releases should document new image tags and any relevant policy updates
- **Do not push images to GHCR manually.** All images must be published via the automated GitHub Actions workflow to ensure version integrity and policy compliance.

---

## 4 ✅ Examples

| Git Tag     | Image                           | Tag                     |
|-------------|----------------------------------|--------------------------|
| `v0.1.4`    | `rust-runtime` (for cr8s-fe)     | `rust-runtime:0.1.3`     |
| `v0.1.4`    | `rust-dev` with Rust 1.83.0      | `rust-dev:1.83.0-rev3`   |

---

Thanks for helping maintain a consistent and clean container workflow! If you're contributing new image logic, please follow these policies or open a PR to propose changes.
