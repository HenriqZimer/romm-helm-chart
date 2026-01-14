# Security Policy

## Supported Versions

We release patches for security vulnerabilities for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability within this Helm chart, please send an email to the maintainer. All security vulnerabilities will be promptly addressed.

**Please do not report security vulnerabilities through public GitHub issues.**

When reporting a vulnerability, please include:

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

We will acknowledge your email within 48 hours and send a more detailed response within 5 days indicating the next steps in handling your report.

## Security Best Practices

When deploying RomM using this Helm chart:

1. **Secrets Management**
   - Never commit sensitive data to version control
   - Use Kubernetes Secrets or external secret management (e.g., Vault, External Secrets Operator)
   - Rotate secrets regularly

2. **Network Security**
   - Use TLS/SSL for ingress (enable cert-manager integration)
   - Configure network policies to restrict pod communication
   - Use strong authentication secrets

3. **Resource Limits**
   - Set appropriate resource limits and requests
   - Enable pod security policies/standards
   - Use read-only root filesystems where possible

4. **Updates**
   - Keep the chart updated to the latest version
   - Monitor security advisories for RomM application
   - Regularly update Kubernetes and Helm

5. **Database Security**
   - Use strong database passwords
   - Restrict database access to necessary pods only
   - Enable encryption at rest if supported by your storage provider
   - Regular backups

## Security Features

This chart includes:

- Secret management for sensitive data
- Resource limits and requests
- Health checks and liveness probes
- Support for Pod Security Standards
- Network policy examples (optional)
