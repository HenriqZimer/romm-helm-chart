# RomM Helm Chart Repository

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Helm Version](https://img.shields.io/badge/Helm-v3-blue)](https://helm.sh)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/romm-helm-chart)](https://artifacthub.io/packages/search?repo=romm-helm-chart)

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
helm repo add henriqzimer https://henriqzimer.github.io/romm-helm-chart/
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

- 🐛 [Report Issues](https://github.com/HenriqZimer/romm-helm-chart/issues)
- 💬 [Discussions](https://github.com/HenriqZimer/romm-helm-chart/discussions)
- 📖 [Documentation](chart/README.md)

## Contributors

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/HenriqZimer"><img src="https://avatars.githubusercontent.com/u/12345678?v=4?s=100" width="100px;" alt="HenriqZimer"/><br /><sub><b>HenriqZimer</b></sub></a><br /><a href="https://github.com/HenriqZimer/romm-helm-chart/commits?author=HenriqZimer" title="Code">💻</a> <a href="https://github.com/HenriqZimer/romm-helm-chart/commits?author=HenriqZimer" title="Documentation">📖</a> <a href="#maintenance-HenriqZimer" title="Maintenance">🚧</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

---

Made with ❤️ for the retro gaming community
