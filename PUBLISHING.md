# Publishing Guide

This guide will help you publish the RomM Helm Chart repository to GitHub and make it available via GitHub Pages.

## Prerequisites

- GitHub account
- Git installed locally
- Helm 3.x installed
- Repository ready (see CHECKLIST.md)

## Step 1: Create GitHub Repository

1. Go to [GitHub](https://github.com) and log in
2. Click the "+" icon in the top right and select "New repository"
3. Configure your repository:
   - **Repository name**: `romm-helm-chart` (or your preferred name)
   - **Description**: "Production-ready Helm chart for RomM - Beautiful, powerful, self-hosted ROM manager"
   - **Visibility**: Public
   - **DO NOT** initialize with README, .gitignore, or license (we already have them)
4. Click "Create repository"

## Step 2: Update Repository URLs

Before pushing, update all references to the repository URL:

```bash
# Files to update:
# - README.md
# - chart/README.md
# - CHANGELOG.md
# - cr.yaml
# - CONTRIBUTING.md
# - .github/ISSUE_TEMPLATE/*.yml

# Replace "henriqzimer/romm-helm-chart" with your "username/repo-name"
```

## Step 3: Push to GitHub

```bash
# Navigate to your repository
cd /home/henriqzimer/k8s/romm

# Verify git is initialized
git status

# If not initialized, run:
# git init
# git add .
# git commit -m "Initial commit: RomM Helm Chart v1.0.0"

# Add your GitHub repository as remote
git remote add origin https://github.com/YOUR-USERNAME/romm-helm-chart.git

# Or if already exists, update it:
git remote set-url origin https://github.com/YOUR-USERNAME/romm-helm-chart.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Step 4: Configure GitHub Pages

1. Go to your repository on GitHub
2. Click on "Settings" tab
3. Scroll down to "Pages" in the left sidebar
4. Under "Source", select:
   - **Source**: Deploy from a branch
   - **Branch**: `gh-pages` / `(root)`
5. Click "Save"

**Note**: The `gh-pages` branch will be created automatically by the release workflow when you create your first release.

## Step 5: Create First Release

The release workflow will automatically create the Helm repository when you push to main with chart changes.

To manually trigger a release:

1. Make sure all changes are committed
2. Tag the release:
   ```bash
   git tag -a v1.0.0 -m "Release v1.0.0"
   git push origin v1.0.0
   ```

Or create a release through GitHub:

1. Go to your repository on GitHub
2. Click "Releases" → "Create a new release"
3. Click "Choose a tag" → type `v1.0.0` → "Create new tag"
4. Release title: `v1.0.0`
5. Description: Copy from CHANGELOG.md
6. Click "Publish release"

## Step 6: Verify Chart Repository

After the release workflow completes (check Actions tab):

1. Your chart should be available at:
   ```
   https://YOUR-USERNAME.github.io/romm-helm-chart
   ```

2. Test adding the repository:
   ```bash
   helm repo add romm https://YOUR-USERNAME.github.io/romm-helm-chart
   helm repo update
   helm search repo romm
   ```

3. Test installation:
   ```bash
   helm install romm-test romm/romm --dry-run --debug
   ```

## Step 7: Configure Repository Settings

### General Settings
1. Go to Settings → General
2. Add description: "Production-ready Helm chart for RomM"
3. Add website: `https://romm.app`
4. Add topics: `helm`, `helm-chart`, `kubernetes`, `romm`, `retrogaming`, `emulation`

### Features
1. Enable:
   - ✅ Issues
   - ✅ Discussions (recommended)
   - ✅ Projects (optional)
   - ✅ Wiki (optional)

### Security
1. Go to Settings → Security
2. Enable:
   - ✅ Private vulnerability reporting
   - ✅ Dependency graph
   - ✅ Dependabot alerts

## Step 8: Test Everything

```bash
# Add your published repository
helm repo add romm https://YOUR-USERNAME.github.io/romm-helm-chart
helm repo update

# Search for the chart
helm search repo romm

# Install with default values
helm install romm-test romm/romm --dry-run

# Install with custom values
helm install romm-test romm/romm -f examples/minimal-values.yaml --dry-run
```

## Step 9: Promote Your Chart

1. **Add badges to README** (update after first release):
   ```markdown
   [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/romm)](https://artifacthub.io/packages/search?repo=romm)
   [![Release](https://img.shields.io/github/v/release/YOUR-USERNAME/romm-helm-chart)](https://github.com/YOUR-USERNAME/romm-helm-chart/releases)
   ```

2. **Submit to Artifact Hub**:
   - Go to [Artifact Hub](https://artifacthub.io)
   - Sign in with GitHub
   - Add your repository
   - Follow the verification steps

3. **Share**:
   - Reddit: r/selfhosted, r/kubernetes
   - Discord: Kubernetes communities
   - Twitter/X: Tag #Kubernetes #Helm #SelfHosted

## Maintenance

### Releasing New Versions

1. Make changes to the chart
2. Update version in `chart/Chart.yaml`
3. Update `CHANGELOG.md`
4. Commit and push:
   ```bash
   git add .
   git commit -m "Release v1.1.0: Add new feature"
   git push
   ```
5. The release workflow will automatically package and publish

### Updating Documentation

- Always keep README.md up to date
- Update CHANGELOG.md for every release
- Review and update examples regularly

## Troubleshooting

### Chart Not Appearing in Repository

1. Check Actions tab for workflow errors
2. Verify gh-pages branch exists
3. Check GitHub Pages settings
4. Wait a few minutes for GitHub Pages to deploy

### Release Workflow Fails

1. Check workflow logs in Actions tab
2. Verify `cr.yaml` configuration
3. Ensure Chart.yaml version is updated
4. Check GITHUB_TOKEN permissions

### Cannot Push to Repository

1. Verify remote URL: `git remote -v`
2. Check authentication (use SSH or Personal Access Token)
3. Ensure you have write permissions

## Need Help?

- [Helm Documentation](https://helm.sh/docs/)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Chart Releaser Action](https://github.com/helm/chart-releaser-action)
- [Artifact Hub](https://artifacthub.io)

---

Good luck with your chart! 🚀
