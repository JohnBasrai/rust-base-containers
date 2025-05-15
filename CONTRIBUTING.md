## 🪢 Branch and Tagging Conventions

### Container Versioning

These containers are tagged using semantic versioning with Rust alignment:

- `vX.Y` matches the Rust compiler version (e.g. `1.83`)
- `vX.Y.Z` uses `Z` for internal patch revisions when container tooling or base layers change

For example:
- `v1.83.0` → Rust 1.83.0 with baseline tooling
- `v1.83.1` → Rust 1.83.0 with additional tools or updates
- `v1.84.0` → Rust 1.84.0 baseline on next compiler upgrade

✅ Always prefer specific `vX.Y.Z` tags over `:latest` for reproducible builds

---

### Branch Naming Conventions

- `versioning-policy` – structural policy or tagging updates
- `vX.Y.Z-prep` – preparing for a tagged container release
- `rust-X.Y-patch` – patch-level updates while keeping the same Rust version
- `tooling-update-*` – new tools or infra additions

These conventions help ensure traceability and clean semver alignment across container consumers.

## 🐳 Updating Dockerfiles and Releasing New Container Versions

If you change `Dockerfile.dev` or `Dockerfile.runtime`, follow these steps:

1. **Choose a new version** using semantic versioning aligned with Rust:
   - Use `vX.Y.Z` where `X.Y` tracks the Rust version (e.g. `1.83`)
   - Bump `Z` for patch-level updates (e.g. adding packages like `libssl3`, updating the base image)
   - For a full Rust version upgrade (e.g. `1.84`), start with `v1.84.0`
   - You can find the current version in `.github/workflows/ci.yml`

2. **Update the version tag** inside `.github/workflows/ci.yml`:
   ```yaml
   --tag ghcr.io/johnbasrai/cr8s/rust-runtime:v1.83.1
   ```

3. Commit your changes:

> ```
> git add Dockerfile.runtime
> git commit -m "runtime: add <change summary> (v1.83.1)"
> git tag v1.83.1
> git push origin main --tags
> ```

4. CI will automatically build and push:

- :v1.83.1 for reproducibility
- :latest as the rolling tag

✅ Keep commits clean and use changelogs if available.<br>
✅ Don't edit CI unless you're changing how containers are built or tagged.

