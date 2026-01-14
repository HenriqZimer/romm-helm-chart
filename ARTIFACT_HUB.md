# Publishing to Artifact Hub

Quick guide to publish this Helm chart on Artifact Hub.

## Steps

### 1. Sign in to Artifact Hub
- Go to https://artifacthub.io
- Click "Sign in" and choose "Sign in with GitHub"

### 2. Add Repository
- Go to Control Panel → Repositories → Add
- Fill in:
  - **Name**: `romm-helm-chart`
  - **URL**: `https://henriqzimer.github.io/romm-helm-chart/`
  - **Kind**: Helm charts

### 3. Verify
- Wait 1-2 minutes for sync
- Chart will appear at: https://artifacthub.io/packages/helm/romm-helm-chart/romm

## Configuration Files

✅ `artifacthub-repo.yaml` - Repository metadata (already configured)
✅ `Chart.yaml` - Includes Artifact Hub annotations

## Badge

Already in README.md:
```markdown
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/romm-helm-chart)](https://artifacthub.io/packages/search?repo=romm-helm-chart)
```

---

**Status**: Ready for publication!
