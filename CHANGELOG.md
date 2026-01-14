# Changelog

All notable changes to this Helm chart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.3] - 2026-01-14

### Fixed
- Fixed release workflow to skip existing releases
- Prevent duplicate release errors on re-runs

### Changed
- Add skip_existing flag to chart-releaser workflow
- Update artifacthub-repo.yaml with proper documentation header

## [1.0.2] - 2026-01-14

### Changed
- Translate CHANGELOG to English
- Update maintainer email to henriqzimer@outlook.com
- Update chart icon URL to current RomM logo
- Fix all repository URLs to use correct case (HenriqZimer)

### Removed
- Remove .all-contributorsrc from version control

## [1.0.1] - 2026-01-14

### Fixed
- Fixed lint workflow (removed --validate flag that requires K8s cluster)
- Fixed repository name in cr.yaml
- Cleaned up temporary files from repository

### Changed
- Lint workflow now runs on all pushes to main branch
- Added workflow_dispatch for manual release execution

## [1.0.0] - 2026-01-14

### Added
- Initial release of RomM Helm Chart
- Support for RomM application version 4.5.0
- Full deployment configuration with:
  - Kubernetes Deployment
  - Service (ClusterIP)
  - Ingress with TLS support
  - ConfigMap for non-sensitive configuration
  - Secret management for credentials
  - Persistent Volume Claims for data, ROMs, and config
- Built-in MariaDB deployment (optional)
- Horizontal Pod Autoscaling support
- Resource limits and requests configuration
- Health checks (liveness and readiness probes)
- Comprehensive values.yaml with sensible defaults
- Detailed README with installation instructions
- Production-ready templates following Helm best practices

### Supported Features
- Multi-replica deployment
- Persistent storage for:
  - ROM library
  - Application resources
  - Configuration files
  - MariaDB data
- Ingress configuration with:
  - Multiple host support
  - TLS/SSL termination
  - cert-manager integration
- External database support
- Customizable resource allocation
- Environment variable configuration via ConfigMap and Secrets
- Integration with IGDB and SteamGridDB for metadata

[Unreleased]: https://github.com/HenriqZimer/romm-helm-chart/compare/v1.0.3...HEAD
[1.0.3]: https://github.com/HenriqZimer/romm-helm-chart/releases/tag/v1.0.3
[1.0.2]: https://github.com/HenriqZimer/romm-helm-chart/releases/tag/v1.0.2
[1.0.1]: https://github.com/HenriqZimer/romm-helm-chart/releases/tag/v1.0.1
[1.0.0]: https://github.com/HenriqZimer/romm-helm-chart/releases/tag/v1.0.0
