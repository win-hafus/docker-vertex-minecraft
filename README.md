# Vertex System

Docker Compose configuration for the Vertex System Minecraft server.

## Stack

| Service             | Image / Source                      | Purpose                                          |
| ------------------- | ----------------------------------- | ------------------------------------------------ |
| `minecraft-server`  | Dockerfile (`./minecraft`)          | Minecraft server (PaperMC)                       |
| `proxy-server`      | Dockerfile (`./velocity`)           | Velocity proxy (public entry point)              |
| `node-exporter`     | `prom/node-exporter`                | Host metrics for Prometheus                      |
| `json-exporter`     | `prometheuscommunity/json-exporter` | JSON metrics export                              |
| `blackbox-exporter` | `prom/blackbox-exporter`            | Availability probing                             |

> **Note:** MariaDB runs as an external (remote) service. The `./mariadb` directory contains
> initialization scripts that create the required databases for plugins and Grafana.
> MariaDB **must be running and accessible** before starting this stack.

## Requirements

- Docker 24+
- Docker Compose v2
- A running MariaDB instance reachable at `DB_HOST:DB_PORT`

## Getting Started

```bash
git clone https://github.com/win-hafus/docker-vertex-minecraft.git
cd docker-vertex-minecraft
cp .env.example .env
# Fill in all variables in .env (see Configuration section below)
docker compose pull
docker compose up -d
```

### Initializing the Database

Before the first launch, run the initialization scripts against your MariaDB instance:

```bash
mysql -h <DB_HOST> -P <DB_PORT> -u root -p < mariadb/init.sql
```

This creates the databases for CoreProtect, DiscordSRV, VDAuth, and Grafana.

## Configuration (.env)

Copy `.env.example` to `.env` and fill in all values. Do **not** leave placeholder values like `your_secure_password_here`.

| Variable                              | Description                                          |
| ------------------------------------- | ---------------------------------------------------- |
| `DB_HOST` / `DB_PORT`                 | MariaDB host and port                                |
| `MINECRAFT_MEMORY_LIMIT`              | Memory limit for the Minecraft server (e.g. `5g`)   |
| `MINECRAFT_CPU_LIMIT`                 | CPU limit (number of cores, e.g. `4`)                |
| `MYSQL_DATABASE_COREPROTECT`          | Database name for CoreProtect                        |
| `MYSQL_DATABASE_DISCORDSRV`           | Database name for DiscordSRV                         |
| `MYSQL_USERNAME_DISCORDSRV`           | MariaDB username for DiscordSRV                      |
| `MYSQL_PASSWORD_COREPROTECT`          | MariaDB password for CoreProtect                     |
| `MYSQL_PASSWORD_DISCORDSRV`           | MariaDB password for DiscordSRV                      |
| `MYSQL_PASSWORD_GRAFANA`              | MariaDB password for Grafana                         |
| `MYSQL_USERNAME_VDAUTH`               | MariaDB username for VDAuth                          |
| `MYSQL_PASSWORD_VDAUTH`               | MariaDB password for VDAuth                          |
| `DISCORDSRV_BOT_TOKEN`                | Discord bot token                                    |
| `VELOCITY_FORWARDING_SECRET`          | Velocity modern forwarding secret (base64)           |
| `JSON_EXPORTER_BIND_IP` / `_PORT`     | json-exporter bind address                           |
| `BLACKBOX_EXPORTER_BIND_IP` / `_PORT` | blackbox-exporter bind address                       |
| `HEALTHCHECK_INTERVAL`                | How often Docker checks container health (e.g. `30s`)|
| `HEALTHCHECK_TIMEOUT`                 | Health check timeout (e.g. `5s`)                     |
| `HEALTHCHECK_RETRIES`                 | Number of retries before marking unhealthy (e.g. `3`)|
| `HEALTHCHECK_START_PERIOD`            | Grace period on container start (e.g. `10s`)         |

## Repository Structure

```
.
├── minecraft/          # Minecraft server Dockerfile and configs
├── velocity/           # Velocity proxy Dockerfile and configs
├── mariadb/            # MariaDB init scripts (run against external DB)
├── json-exporter/      # json-exporter config
├── blackbox/           # blackbox-exporter config
├── docker-compose.yml
└── .env.example
```

## Features

### Account Authentication

The server uses [VDAuth](https://github.com/win-hafus/velocity-discord-auth) — a custom Velocity plugin that generates a unique UUID for each player based on `nickname + timestamp`. This UUID is bound to the player's Discord account via DiscordSRV, adding two-factor authentication and giving offline-mode (cracked) players a solid level of account security.

See the [VDAuth repository](https://github.com/win-hafus/velocity-discord-auth) for full documentation on setup and configuration.

### Monitoring

Host and service metrics are collected via Prometheus exporters:

- **node-exporter** — CPU, RAM, disk, and network stats for the host
- **json-exporter** — exports arbitrary JSON endpoints as Prometheus metrics
- **blackbox-exporter** — probes service availability (TCP/HTTP)

## Acknowledgements

- [PaperMC](https://papermc.io/) — Minecraft server software
- [Velocity](https://velocitypowered.com/) — Modern Minecraft proxy
- [VDAuth](https://github.com/win-hafus/velocity-discord-auth) — Custom Discord-based authentication plugin
- [DiscordSRV](https://github.com/DiscordSRV/DiscordSRV) — Minecraft ↔ Discord bridge
- [CoreProtect](https://github.com/PlayPro/CoreProtect) — Block logging and rollback
- [Prometheus](https://prometheus.io/) — Metrics and monitoring

## Contact

- Discord: [Vertex System](https://discord.gg/gTuh9z29)
- Email: konstantin.pirs@gmail.com

## Author

- Gitea: [Hafus](https://git-vertex-homelab.mooo.com/hafus)
- GitHub: [Win-Hafus](https://github.com/win-hafus/)

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE).
