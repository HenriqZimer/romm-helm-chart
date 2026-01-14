# RomM Helm Chart Repository

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Helm Version](https://img.shields.io/badge/Helm-v3-blue)](https://helm.sh)

This repository contains a production-ready Helm chart for deploying [RomM](https://romm.app/) on Kubernetes.

## About RomM

RomM (Rom Manager) is a beautiful, powerful, self-hosted ROM manager for your retro gaming collection. It provides a modern web interface to organize, manage, and browse your ROM library with features like:

- 🎮 Multi-platform ROM management
- 🖼️ Automatic artwork and metadata scraping
- 📱 Responsive web interface
- 🔍 Advanced search and filtering
- 👥 Multi-user support
- 🎯 Game matching with IGDB and SteamGridDB

## Quick Start

### Add Helm Repository

```bash
helm repo add henriqzimer https://henriqzimer.github.io/helm-applications
helm repo update
```

### Install Chart

```bash
helm install romm henriqzimer/romm
```

For detailed installation instructions and configuration options, see the [chart README](chart/README.md).

## Repository Structure

```
.
├── chart/              # Helm chart for RomM
│   ├── Chart.yaml      # Chart metadata
│   ├── values.yaml     # Default configuration values
│   ├── README.md       # Detailed chart documentation
│   └── templates/      # Kubernetes manifest templates
├── LICENSE             # Repository license
└── README.md           # This file
```

## Documentation

- **[Chart Documentation](chart/README.md)** - Complete installation and configuration guide
- **[RomM Official Docs](https://romm.app/)** - RomM application documentation
- **[Values Reference](chart/values.yaml)** - All available configuration options

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- MariaDB/MySQL database
- Persistent storage (NFS, local-path, or cloud storage)
- (Optional) Ingress controller
- (Optional) cert-manager for automatic TLS

## Features

This Helm chart provides:

- ✅ Production-ready Kubernetes deployment
- ✅ Built-in MariaDB support (optional)
- ✅ Persistent volume management
- ✅ Ingress configuration with TLS support
- ✅ Horizontal Pod Autoscaling (HPA)
- ✅ Resource limits and requests
- ✅ Health checks and probes
- ✅ ConfigMap and Secret management
- ✅ Service configuration

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This Helm chart is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

The RomM application itself is licensed under its own terms. See the [RomM repository](https://github.com/rommapp/romm) for more information.

## Support

- 🐛 [Report Issues](https://github.com/henriqzimer/romm-helm-chart/issues)
- 💬 [Discussions](https://github.com/henriqzimer/romm-helm-chart/discussions)
- 📖 [Documentation](chart/README.md)

## Maintainer

- **henriqzimer**

---

Made with ❤️ for the retro gaming community