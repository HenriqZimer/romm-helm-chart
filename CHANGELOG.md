# Changelog

All notable changes to this Helm chart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.1] - 2026-01-14

### Fixed
- Corrigido workflow de lint (removido --validate que requer cluster K8s)
- Corrigido nome do repositório no cr.yaml
- Limpeza de arquivos temporários do repositório

### Changed
- Workflow de lint agora roda em todos os pushes
- Adicionado workflow_dispatch para execução manual do release

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

[Unreleased]: https://github.com/henriqzimer/romm-helm-chart/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/henriqzimer/romm-helm-chart/releases/tag/v1.0.0
