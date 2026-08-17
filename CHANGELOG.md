# Changelog

All notable changes to this Helm chart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.5.2] - 2026-08-16

### Added
- `chart/values.schema.json` validating `values.yaml` - powers the "Values schema" feature on ArtifactHub, previously absent since no chart in this project ever had one.

## [1.5.1] - 2026-08-15

### Fixed
- `icon` URL (`https://romm.app/_ipx/q_80/images/blocks/logos/romm.svg`) 404'd on ArtifactHub — romm.app's site moved/removed that asset path. Switched to `.github/resources/isotipo.png` in RomM's own GitHub repo, a stable path served straight from `raw.githubusercontent.com`.

## [1.5.0] - 2026-08-15

### Added
- `romm.dbDriver`, setting `ROMM_DB_DRIVER` (`mariadb`/`mysql`/`postgresql`) — previously never set by the chart at all, silently relying on RomM's own default and giving no way to switch dialects when pointing `mariadb.externalDatabase` at a MySQL or PostgreSQL instance
- `redis.externalRedis.username`/`.db`/`.ssl`, wiring `REDIS_USERNAME`/`REDIS_DB`/`REDIS_SSL` for external Redis/Valkey instances that need ACL auth, a non-default logical DB, or TLS
- `chart/files/config.example.yml` — a fully-annotated example `config.yml` covering every documented section (`exclude`, `system`, `filesystem`, `scan`, `emulatorjs`, `streaming`), ships with the chart as a copy-from-here reference for `romm.config.data`
- README: full "Environment Variables Reference" table covering every variable from [docs.romm.app/reference/environment-variables/](https://docs.romm.app/latest/reference/environment-variables/), organized by category, noting which already have `values.yaml` wiring vs which need `romm.env`/`romm.envFrom`
- README: "Configuration File (config.yml)" section walking through `romm.config.enabled`/`romm.config.data` with a working example, pointing at the new `files/config.example.yml`

## [1.4.0] - 2026-08-15

### Added
- Deploy Redis/Valkey (`redis.*`, `docker.io/valkey/valkey:8-alpine`) — this was entirely missing from the chart despite RomM requiring it for session storage, the background task queue (RQ), metadata/heartbeat caching, and socket.io pubsub. Neither the `latest` nor `slim` RomM image bundles it, so scheduled tasks and the filesystem watcher would silently stop working without a Redis/Valkey instance the chart never provisioned. Supports both an internal deployment (`redis.enabled: true`, default) and an external instance (`redis.enabled: false` + `redis.externalRedis.host/port`), mirroring the existing `mariadb` pattern (own Deployment/Service/PVC, optional auth via `secrets.data.REDIS_PASSWORD`)
- `REDIS_HOST`/`REDIS_PORT`/`REDIS_PASSWORD` env wiring into the RomM container, generated dynamically between the internal Service and `externalRedis`, the same way `DB_HOST` already worked
- `romm.baseUrl`, setting `ROMM_BASE_URL` — required for correct link/redirect generation and WebSocket origin checks once the chart sits behind an Ingress (previously had no way to set this without `romm.env`)
- README: a "Kubernetes-Specific Notes" section covering ingress upload-size/WebSocket-timeout annotations, `fsGroup`/PVC permission guidance, the filesystem watcher's unreliability on network-backed library volumes (NFS/SMB), OOM risk from hash calculation on large scans, and firmware/BIOS folder placement — all called out in upstream `docs.romm.app`'s Kubernetes and troubleshooting pages, none of which this chart's README previously reflected
- README: a "Redis / Valkey" configuration section (internal vs external), matching the existing "Database Options" section's structure

## [1.3.0] - 2026-08-12

### Changed
- Bump default RomM version to `5.1.0` (`romm.image.tag` and `appVersion`), from the long-stale `4.5.0` default

## [1.2.1] - 2026-08-12

### Fixed
- `config.yml` ConfigMap rendered a stray literal `|` as the first line of the file, corrupting it. `romm.config.data` (already a literal multi-line string) was being piped through `toYaml` on top of the existing `config.yml: |` block scalar, double-encoding it. Template now uses `nindent` directly on the string.

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
