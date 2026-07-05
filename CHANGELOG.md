# Changelog

All notable changes to this Helm chart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.1.0] - 2026-07-05

### Added
- Liveness, readiness and startup probes for the RomM container (TCP check on port 8080 by default, since RomM has no dedicated `/health` endpoint)
- `NOTES.txt` shown after install/upgrade with access instructions, warnings for non-persistent storage, and a reminder to change default credentials
- Configurable `serviceAccount` (create/name/annotations)
- `checksum/secret` and `checksum/configmap` pod annotations so `helm upgrade` rolls pods when secrets or the config ConfigMap change

### Changed
- **Breaking (defaults only):** persistence is now enabled by default for `romm.persistence.{config,library,resources,assets}` and `mariadb.persistence` — previously these defaulted to `emptyDir`, which silently lost all data (including the database) on every pod restart. Existing installs that already set these values explicitly are unaffected; fresh installs now require a default `StorageClass` to be available, or `storageClass`/`existingClaim` to be set explicitly.
- Container `securityContext` now defaults to `allowPrivilegeEscalation: false` and drops all Linux capabilities
- Default secret placeholder values (`DB_PASSWD`, `MYSQL_ROOT_PASSWORD`, `ROMM_AUTH_SECRET_KEY`) renamed to make it obvious they are unsafe defaults that must be overridden before any non-local deployment

### Fixed
- CI lint workflow (`lint-test.yml`) no longer swallows `chart-testing` failures via `continue-on-error`

## [1.0.5] - 2026-01-23

### Changed
- Optimize secrets configuration by auto-generating MariaDB credentials from DB_* values
- Removed duplicate MYSQL_USER, MYSQL_PASSWORD, and MYSQL_DATABASE from values.yaml
- Chart now automatically creates MYSQL_* environment variables from DB_USER, DB_PASSWD, and DB_NAME
- Reduced required secrets configuration from 7 to 4 variables

### Improved
- Simplified secrets management with automatic credential mapping
- Eliminated risk of inconsistencies between DB_* and MYSQL_* values

## [1.0.4] - 2026-01-14

### Changed
- Add complete maintainer information with personal website (https://henriqzimer.com.br)
- Add Helm repository link to Artifact Hub (https://henriqzimer.github.io/romm-helm-chart/)
- Add maintainer GitHub profile and website to Artifact Hub links
- Add complete changelog history for all versions (1.0.0 - 1.0.3) to Artifact Hub

### Fixed
- Update maintainer email to henrique.zimermann@outlook.com

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
