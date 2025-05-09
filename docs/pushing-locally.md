# 🔧 Manually Pushing Docker Images to GHCR

This guide explains how to manually push your locally built Docker containers to [GitHub Container Registry (GHCR)](https://ghcr.io). This is useful when testing changes to the `rust-base-containers` container before the automated GitHub Actions workflow runs.

---

## 🧪 When Should You Do This?

You only need to push images manually if:

- You’ve modified a Dockerfile (e.g. `Dockerfile.dev`) and want to test it immediately
- You’re working offline or developing the container iteratively
- You want to push an intermediate version without waiting for CI

---

## 🐳 Step-by-Step

### 1. Export your GitHub Personal Access Token (PAT)

First, generate a PAT with these scopes:

- ✅ `write:packages`
- ✅ `read:packages`

> You can generate a token here: [https://github.com/settings/tokens](https://github.com/settings/tokens)

Then in your terminal:

```bash
export GHCR_PAT=ghp_yourActualTokenHere
```

---

### 2. Build the containers locally

```bash
./scripts/build-images.sh
```

This builds both:

- `ghcr.io/johnbasrai/rust-dev:latest`
- `ghcr.io/johnbasrai/rust-runtime:latest`

---

### 3. Push images to GHCR

```bash
./scripts/push-to-ghcr.sh
```

This will:

- Log in to GHCR using your PAT
- Push both `dev` and `runtime` containers

---

## 📂 File Overview

| File                     | Description                             |
|--------------------------|-----------------------------------------|
| `scripts/build-images.sh` | Builds both Docker images locally       |
| `scripts/push-to-ghcr.sh`| Pushes images to GHCR using `$GHCR_PAT` |

---

## ✅ Tips

- This is only for **manual pushes** — GitHub Actions handles pushes automatically on `main` branch changes or on a weekly schedule.
- Never commit your PAT to the repo or check it into `.env` files.
- You can safely revoke or regenerate your token anytime at [https://github.com/settings/tokens](https://github.com/settings/tokens)

---

## 📬 Need help?

If you're not sure whether to push manually or wait for CI, use `docker pull` in another repo to see if the image tag you want already exists:

```bash
docker pull ghcr.io/johnbasrai/rust-dev:latest
```
