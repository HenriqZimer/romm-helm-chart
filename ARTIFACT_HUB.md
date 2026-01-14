# Publishing to Artifact Hub

This repository is configured for Artifact Hub publication.

## Quick Setup

### 1. Sign in to Artifact Hub
- Go to https://artifacthub.io
- Click "Sign in with GitHub"
- Authorize the application

### 2. Add Repository
In Artifact Hub Control Panel:
- Go to **Repositories** → **Add**
- Fill in:
  - **Name**: `romm-helm-chart`
  - **Display name**: `RomM Helm Chart`
  - **URL**: `https://henriqzimer.github.io/romm-helm-chart/`
  - **Kind**: `Helm charts`
- Click **Add**

### 3. Verify Publication
After 1-2 minutes, your chart will appear at:
```
https://artifacthub.io/packages/helm/romm-helm-chart/romm
```

## Configuration Files

### artifacthub-repo.yaml
Located in repository root. Contains repository metadata:
```yaml
repositoryID: 3cfd0254-40b6-4cc5-88ff-ca52da2fc46e
owners:
  - name: HenriqZimer
    email: henrique.zimermann@outlook.com
```

### Chart.yaml Annotations
Includes Artifact Hub metadata:
- License information
- Links to source and documentation
- Changelog for current version

## Verified Publisher

To become a verified publisher:
1. Add your repository on Artifact Hub
2. The repositoryID will be generated
3. Add `artifacthub-repo.yaml` with the ID (already done!)
4. Commit and push
5. Artifact Hub will verify ownership

See: https://artifacthub.io/docs/topics/repositories/\#verified-publisher

## Automatic Updates

Artifact Hub checks for updates hourly and will:
- Index new chart versions
- Update package information
- Show latest releases

## Badge

The README already includes the Artifact Hub badge:
```markdown
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/romm-helm-chart)](https://artifacthub.io/packages/search?repo=romm-helm-chart)
```

---

**Status**: ✅ Ready for publication
