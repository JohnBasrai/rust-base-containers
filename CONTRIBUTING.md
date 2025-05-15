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
