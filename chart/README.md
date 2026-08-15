# RomM Helm Chart

[![Version: 1.4.0](https://img.shields.io/badge/Version-1.4.0-informational?style=flat-square)](https://github.com/HenriqZimer/romm-helm-chart)
[![AppVersion: 5.1.0](https://img.shields.io/badge/AppVersion-5.1.0-informational?style=flat-square)](https://romm.app/)

A Helm chart for [RomM](https://romm.app/) - Beautiful, powerful, self-hosted ROM manager.

## TL;DR

```bash
# Add the Helm repository
helm repo add romm https://henriqzimer.github.io/romm-helm-chart
helm repo update

# Install RomM
helm install romm romm/romm
```

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- A running MariaDB/MySQL/PostgreSQL database (or use the included MariaDB deployment)
- A running Redis/Valkey instance (or use the included Valkey deployment) - RomM requires
  this for session storage, the background task queue, metadata caching, and socket.io
  pubsub; neither the `latest` nor `slim` RomM image bundles it
- A default `StorageClass` available in the cluster (persistence is enabled by default), or your own `storageClass`/`existingClaim` values
- Ingress controller (nginx-ingress recommended)
- cert-manager (optional, for automatic TLS certificates)

## Installing the Chart

### From Helm Repository

```bash
# Add the repository
helm repo add romm https://henriqzimer.github.io/romm-helm-chart
helm repo update

# Install RomM
helm install romm romm/romm
```

### From Source

```bash
# Clone the repository
git clone https://github.com/HenriqZimer/romm-helm-chart.git
cd romm-helm-chart

# Package the chart
helm package chart/

# Install from local package
helm install romm ./romm-1.4.0.tgz
```

## Configuration

### Required Configuration

Before deploying, you need to configure several required values:

1. **Database Configuration**: Set up MariaDB connection details
2. **Secrets**: Configure authentication secrets and API keys
3. **Storage**: Configure persistent volumes for ROMs and data
4. **Ingress**: Configure domain and TLS settings

### Example values-production.yaml

```yaml
# Database configuration
secrets:
  enabled: true
  data:
    DB_HOST: "romm-mariadb"
    DB_PORT: "3306"
    DB_USER: "romm"
    DB_PASSWD: "your_secure_password"
    DB_NAME: "romm"
    MYSQL_ROOT_PASSWORD: "your_root_password"
    MYSQL_DATABASE: "romm"
    MYSQL_USER: "romm"
    MYSQL_PASSWORD: "your_secure_password"
    ROMM_AUTH_SECRET_KEY: "your_32_char_secret_key"
    IGDB_CLIENT_ID: "your_igdb_client_id"
    IGDB_CLIENT_SECRET: "your_igdb_client_secret"
    STEAMGRIDDB_API_KEY: "your_steamgriddb_api_key"

# Ingress configuration
romm:
  ingress:
    enabled: true
    hosts:
      - host: romm.yourdomain.com
        paths:
          - path: /
            pathType: Prefix
    tls:
      - secretName: romm-tls
        hosts:
          - romm.yourdomain.com

  # Storage configuration
  persistence:
    config:
      enabled: true
      existingClaim: "romm-config-pvc"
    library:
      enabled: true
      existingClaim: "romm-library-pvc"
    resources:
      enabled: true
      existingClaim: "romm-resources-pvc"
    assets:
      enabled: true
      existingClaim: "romm-assets-pvc"
```

### Using External Secrets

For production deployments, it's recommended to use ExternalSecrets Operator:

```yaml
secrets:
  enabled: false

romm:
  envFrom:
    - secretRef:
        name: romm-external-secrets
```

### Database Options

#### Option 1: Internal MariaDB (Development/All-in-One)

Deploy MariaDB as part of the Helm chart. This is ideal for development or testing.

```yaml
mariadb:
  enabled: true
  persistence:
    enabled: true
    size: 10Gi
    storageClass: "your-storage-class"

secrets:
  enabled: true
  data:
    # Database credentials
    DB_USER: "romm"
    DB_PASSWD: "your_secure_password"
    DB_NAME: "romm"
    DB_PORT: "3306"
    # MariaDB root password
    MYSQL_ROOT_PASSWORD: "your_root_password"
    # Other RomM settings...
    ROMM_AUTH_SECRET_KEY: "your_32_char_secret_key"
```

#### Option 2: External MariaDB/MySQL (Production)

Use an existing external MariaDB or MySQL database. Perfect for production deployments where you want to manage your database separately.

```yaml
mariadb:
  enabled: false
  externalDatabase:
    host: "mysql.example.com"

secrets:
  enabled: true
  data:
    # Database credentials for external database
    DB_USER: "romm"
    DB_PASSWD: "your_secure_password"
    DB_NAME: "romm"
    DB_PORT: "3306"
    # Note: MYSQL_ROOT_PASSWORD is not needed for external databases
    # Other RomM settings...
    ROMM_AUTH_SECRET_KEY: "your_32_char_secret_key"
```

**Important Notes for External Database:**
- The database specified in `DB_NAME` must already exist on your external database server
- The user specified in `DB_USER` must have full permissions on that database
- Configure `DB_PORT` in your secrets (defaults to 3306)
- You don't need to configure `MYSQL_ROOT_PASSWORD` when using an external database
- Ensure network connectivity between your Kubernetes cluster and the external database server

### Redis / Valkey

RomM needs Redis or Valkey for session storage, the background task queue (RQ), metadata
caching, and socket.io pubsub — see [Redis or Valkey](https://docs.romm.app/latest/install/redis-or-valkey/).
This is not optional: without it, scheduled tasks (rescans, LaunchBox metadata sync, WebP
conversion, RetroAchievements sync) and the filesystem watcher silently stop working. Unlike
the database, neither RomM image variant bundles it, so this chart deploys an unauthenticated
internal Valkey instance by default (`redis.enabled: true`).

#### Option 1: Internal Valkey (Development/All-in-One)

```yaml
redis:
  enabled: true
  persistence:
    enabled: true
    size: 1Gi
    storageClass: "your-storage-class"

secrets:
  enabled: true
  data:
    # Optional - empty string (the default) means no auth.
    REDIS_PASSWORD: "your_redis_password"
    # Other RomM settings...
```

#### Option 2: External Redis/Valkey (Production)

```yaml
redis:
  enabled: false
  externalRedis:
    host: "redis.example.com"
    port: 6379

secrets:
  enabled: true
  data:
    REDIS_PASSWORD: "your_redis_password" # omit/empty if the external instance has no auth
    # Other RomM settings...
```

### Storage Configuration

RomM requires several persistent volumes. **Persistence is enabled by default** (since v1.1.0) for
`romm.persistence.{config,library,resources,assets}` and `mariadb.persistence`, using a PVC with your
cluster's default `StorageClass`. Set `storageClass` explicitly if you don't want the default one, or
set the relevant `*.enabled: false` to fall back to `emptyDir` (not recommended outside of quick local
testing, since all data — including the database — is lost on every pod restart).

```yaml
romm:
  persistence:
    # Configuration data (database connection, API keys, etc)
    config:
      enabled: true
      size: 1Gi
      storageClass: "your-storage-class"
      # OR use existing PVC
      existingClaim: "romm-config-pvc"

    # ROM library storage
    library:
      enabled: true
      size: 100Gi
      storageClass: "your-storage-class"
      existingClaim: "romm-library-pvc"

    # Resources (cover images, screenshots, etc)
    resources:
      enabled: true
      size: 10Gi
      storageClass: "your-storage-class"
      existingClaim: "romm-resources-pvc"

    # Assets (EmulatorJS files, etc)
    assets:
      enabled: true
      size: 5Gi
      storageClass: "your-storage-class"
      existingClaim: "romm-assets-pvc"
```

### TLS Configuration

#### Using cert-manager (Recommended)

```yaml
romm:
  ingress:
    annotations:
      cert-manager.io/cluster-issuer: "letsencrypt-prod"
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    tls:
      - secretName: romm-tls
        hosts:
          - romm.yourdomain.com
```

#### Using Existing Certificate

```yaml
romm:
  ingress:
    tls:
      - secretName: your-existing-tls-secret
        hosts:
          - romm.yourdomain.com
```

### Kubernetes-Specific Notes

RomM has no first-party Helm chart or Kubernetes guidance of its own (see
[docs.romm.app's Kubernetes page](https://docs.romm.app/latest/install/kubernetes/)) — the
project's own [Kubernetes troubleshooting doc](https://docs.romm.app/latest/troubleshooting/kubernetes/)
calls out several issues that are worth knowing before you deploy:

- **Ingress upload size**: ingress controllers typically cap request bodies well below what a
  ROM/ISO upload needs. This chart doesn't set an annotation for you (it varies by controller):
  ```yaml
  romm:
    ingress:
      annotations:
        nginx.ingress.kubernetes.io/proxy-body-size: "0" # nginx-ingress
        # traefik.ingress.kubernetes.io/router.middlewares: <ns>-romm-buffering@kubernetescrd
  ```
- **WebSocket timeouts**: long-lived scan progress/streaming sockets can get cut by an
  ingress controller's default proxy timeouts:
  ```yaml
  romm:
    ingress:
      annotations:
        nginx.ingress.kubernetes.io/proxy-read-timeout: "3600"
        nginx.ingress.kubernetes.io/proxy-send-timeout: "3600"
  ```
- **PVC permission issues**: if your storage class doesn't respect `fsGroup`, mounted volumes
  can come up owned by root and RomM (running as a non-root user) can't write to them. Try:
  ```yaml
  podSecurityContext:
    fsGroup: 1000
  ```
  or, if your storage class ignores `fsGroup` entirely, chown the volumes with a root
  `initContainers` entry before RomM starts.
- **`enableServiceLinks`**: Kubernetes injects every Service in the namespace as an env var by
  default, which can collide with RomM/nginx's own expected variable names. This chart already
  sets `enableServiceLinks: false` on the pod spec, so you don't need to do anything here.
- **Filesystem watcher on network volumes**: if `romm.persistence.library` is backed by NFS,
  SMB, or another network filesystem (common in Kubernetes), do **not** enable
  `ENABLE_RESCAN_ON_FILESYSTEM_CHANGE` — inotify-style events are unreliable over the network.
  Use `ENABLE_SCHEDULED_RESCAN`/`SCHEDULED_RESCAN_CRON` instead (set via `romm.env` or
  `romm.config.data`). See [Scanning & Watcher](https://docs.romm.app/latest/administration/scanning-and-watcher/).
- **Large scans OOMKilled**: hash calculation during a big first scan can push memory well past
  `romm.resources.limits.memory` (`2Gi` by default). Either raise the limit or disable hashing
  from the Scan page for very large libraries.
- **`romm.baseUrl`**: set this to your externally-reachable URL (e.g. `https://romm.example.com`)
  whenever `romm.ingress.enabled: true` — it's used for link/redirect generation and WebSocket
  origin checks. Leaving it empty is only fine for `kubectl port-forward`-only access.
- **Firmware/BIOS files**: these live inside the same library volume, under
  `library/bios/<platform>/` (e.g. `library/bios/ps/`) — no separate volume or config is needed,
  see [Firmware Management](https://docs.romm.app/latest/administration/firmware-management/).

## API Keys Configuration

RomM integrates with several external services. Get API keys from:

- **IGDB**: https://api.igdb.com/ (for game metadata)
- **SteamGridDB**: https://www.steamgriddb.com/profile/preferences/api (for game artwork)
- **MobyGames**: https://www.mobygames.com/info/api/ (for additional metadata)

## Parameters

### Global Parameters

| Name | Description | Value |
|------|-------------|-------|
| `replicaCount` | Number of RomM replicas | `1` |
| `revisionHistoryLimit` | Number of old ReplicaSets to retain | `3` |
| `imagePullSecrets` | Image pull secrets | `[]` |
| `nameOverride` | Override the default name | `""` |
| `fullnameOverride` | Override the default full name | `""` |

### RomM Application Parameters

| Name | Description | Value |
|------|-------------|-------|
| `romm.image.repository` | RomM image repository | `docker.io/rommapp/romm` |
| `romm.image.tag` | RomM image tag | `5.1.0` |
| `romm.image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `romm.service.type` | Service type | `ClusterIP` |
| `romm.service.port` | Service port | `8080` |
| `romm.ingress.enabled` | Enable ingress | `false` |
| `romm.ingress.className` | Ingress class name | `""` |
| `romm.livenessProbe` | Liveness probe (TCP check on port 8080 by default) | see `values.yaml` |
| `romm.readinessProbe` | Readiness probe (TCP check on port 8080 by default) | see `values.yaml` |
| `romm.startupProbe` | Startup probe | `{}` (disabled) |
| `serviceAccount.create` | Create a dedicated ServiceAccount | `false` |
| `serviceAccount.name` | ServiceAccount name (auto-generated when empty and `create: true`) | `""` |
| `securityContext` | Container securityContext | drops all capabilities, no privilege escalation |

### Database Parameters

| Name | Description | Value |
|------|-------------|-------|
| `mariadb.enabled` | Enable internal MariaDB deployment | `true` |
| `mariadb.externalDatabase.host` | External database hostname (when mariadb.enabled=false) | `""` |
| `mariadb.image.repository` | MariaDB image repository | `docker.io/mariadb` |
| `mariadb.image.tag` | MariaDB image tag | `11` |
| `mariadb.service.type` | MariaDB service type | `ClusterIP` |
| `mariadb.service.port` | MariaDB service port | `3306` |
| `mariadb.persistence.enabled` | Enable MariaDB persistence | `true` |
| `mariadb.persistence.size` | MariaDB PVC size | `10Gi` |

### Redis/Valkey Parameters

| Name | Description | Value |
|------|-------------|-------|
| `redis.enabled` | Enable internal Valkey deployment | `true` |
| `redis.externalRedis.host` / `redis.externalRedis.port` | External Redis/Valkey (when `redis.enabled=false`) | `""` / `6379` |
| `redis.image.repository` | Valkey image repository | `docker.io/valkey/valkey` |
| `redis.image.tag` | Valkey image tag | `8-alpine` |
| `redis.service.port` | Valkey service port | `6379` |
| `redis.persistence.enabled` | Enable Valkey persistence | `true` |
| `redis.persistence.size` | Valkey PVC size | `1Gi` |
| `secrets.data.REDIS_PASSWORD` | Redis/Valkey password (empty = no auth) | `""` |
| `romm.baseUrl` | Public URL RomM is reached at, sets `ROMM_BASE_URL` | `""` |

### Persistence Parameters

| Name | Description | Value |
|------|-------------|-------|
| `romm.persistence.config.enabled` | Enable config persistence | `true` |
| `romm.persistence.config.size` | Config PVC size | `1Gi` |
| `romm.persistence.library.enabled` | Enable library persistence | `true` |
| `romm.persistence.library.size` | Library PVC size | `100Gi` |
| `romm.persistence.resources.enabled` | Enable resources persistence | `true` |
| `romm.persistence.resources.size` | Resources PVC size | `10Gi` |
| `romm.persistence.assets.enabled` | Enable assets persistence | `true` |
| `romm.persistence.assets.size` | Assets PVC size | `5Gi` |

## Troubleshooting

### Common Issues

1. **Database Connection Issues**
   - Ensure MariaDB is running and accessible
   - Check DB_HOST, DB_PORT, DB_USER, DB_PASSWD values
   - Verify network policies allow communication

1a. **Missing scheduled tasks / stuck scans**
   - Ensure the Redis/Valkey pod (`redis.enabled: true`) or your external instance is reachable
   - Check `REDIS_HOST`/`REDIS_PORT`/`REDIS_PASSWORD` resolve correctly (`kubectl exec` into the
     pod and `redis-cli -h $REDIS_HOST -p $REDIS_PORT ping`)
   - Confirm no NetworkPolicy blocks the romm pod from reaching the redis Service

2. **Permission Issues**
   - Ensure PVCs have correct permissions (RomM runs as non-root)
   - Check storage class supports the required access modes

3. **Ingress Issues**
   - Verify ingress controller is installed and running
   - Check DNS resolution for your domain
   - Ensure TLS secret exists and is valid

4. **API Key Issues**
   - Verify API keys are correctly set in secrets
   - Check API service status and rate limits

### Logs

```bash
# View RomM pod logs
kubectl logs -f deployment/romm -n your-namespace

# View MariaDB logs (if using included MariaDB)
kubectl logs -f statefulset/romm-mariadb -n your-namespace
```

### Debugging

```bash
# Check pod status
kubectl get pods -n your-namespace

# Describe pod for detailed information
kubectl describe pod romm-xxxxx -n your-namespace

# Check ingress status
kubectl get ingress -n your-namespace
kubectl describe ingress romm -n your-namespace
```

## Upgrading

```bash
# Update the repository
helm repo update

# Upgrade RomM
helm upgrade romm henriqzimer/romm

# Or upgrade with new values
helm upgrade romm henriqzimer/romm -f your-values.yaml
```

## Uninstalling

```bash
# Uninstall RomM
helm uninstall romm

# Clean up PVCs (if desired)
kubectl delete pvc romm-config-pvc romm-library-pvc romm-resources-pvc romm-assets-pvc
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test your changes
5. Submit a pull request

## License

This chart is licensed under the MIT License.

## Links

- [RomM Official Website](https://romm.app/)
- [RomM GitHub](https://github.com/rommapp/romm)
- [RomM Documentation](https://docs.romm.app/)
- [Helm Documentation](https://helm.sh/docs/)
