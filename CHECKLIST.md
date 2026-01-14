# Pre-Release Checklist

Use this checklist before publishing the repository to GitHub.

## Repository Structure
- [x] `.gitignore` configured
- [x] `.helmignore` configured in chart directory
- [x] `LICENSE` file present
- [x] `README.md` in English at root
- [x] `README.md` in chart directory with detailed documentation
- [x] `CHANGELOG.md` with version history
- [x] `CONTRIBUTING.md` with contribution guidelines
- [x] `SECURITY.md` with security policies
- [x] `.editorconfig` for code consistency

## Chart Quality
- [x] `Chart.yaml` properly configured with:
  - [x] Correct version
  - [x] App version
  - [x] Description
  - [x] Keywords
  - [x] Maintainers
  - [x] Home and sources URLs
- [x] `values.yaml` with comprehensive defaults
- [x] All templates follow Helm best practices
- [x] Chart passes `helm lint`
- [x] Chart can be templated without errors
- [x] Proper labels and annotations on all resources

## Documentation
- [x] Root README with:
  - [x] Project description
  - [x] Quick start guide
  - [x] Repository structure
  - [x] Links to documentation
  - [x] Prerequisites
  - [x] Features list
  - [x] Contributing section
  - [x] License information
- [x] Chart README with:
  - [x] Installation instructions
  - [x] Configuration options
  - [x] Examples
  - [x] Prerequisites
- [x] Example configurations in `examples/` directory
- [x] Changelog with version history

## GitHub Configuration
- [x] `.github/` directory structure
- [x] Issue templates:
  - [x] Bug report
  - [x] Feature request
  - [x] Config file for issue links
- [x] GitHub Actions workflows:
  - [x] Lint and test workflow
  - [x] Release workflow
- [x] `FUNDING.yml` (optional, uncomment if needed)

## Testing
- [x] Run `helm lint chart/`
- [x] Run `helm template test chart/`
- [x] Test with minimal values
- [x] Test with production values
- [ ] Test installation in a real cluster (optional but recommended)

## Before Publishing
- [ ] Update repository name in all documentation if different from "romm-helm-chart"
- [ ] Update GitHub username/organization in:
  - [ ] README.md
  - [ ] chart/README.md
  - [ ] CHANGELOG.md
  - [ ] cr.yaml
  - [ ] CONTRIBUTING.md
  - [ ] Issue templates
- [ ] Review and update all example values
- [ ] Ensure no sensitive data in repository
- [ ] Set up GitHub repository settings:
  - [ ] Enable issues
  - [ ] Enable discussions (recommended)
  - [ ] Enable GitHub Pages for Helm repository
  - [ ] Add repository description
  - [ ] Add repository topics/tags
  - [ ] Add repository website URL

## After Publishing
- [ ] Create initial release (v1.0.0)
- [ ] Verify GitHub Pages is publishing the chart
- [ ] Test installing from published repository
- [ ] Add badge to README with build status
- [ ] Share with community (optional)

## Security
- [ ] Review SECURITY.md
- [ ] Ensure default secrets are examples only
- [ ] Document security best practices
- [ ] Enable security advisories on GitHub

## Optional Enhancements
- [ ] Add helm-docs for automatic documentation generation
- [ ] Set up automated testing with kind
- [ ] Add more example configurations
- [ ] Create video or detailed tutorial
- [ ] Add badges for chart version, license, etc.
