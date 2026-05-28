# Vertex System

Docker Compose configuration for the Vertex System Minecraft server.

## Stack

| Service | Image / Source | Purpose |
|---|---|---|
| `minecraft-server` | Dockerfile (`./minecraft`) | Minecraft server (Paper/Spigot) |
| `mariadb` | Dockerfile (`./mariadb`) | Database for CoreProtect and DiscordSRV |
| `velocity` | Dockerfile (`./velocity`) | Velocity proxy |
| `node-exporter` | `prom/node-exporter` | Host metrics for Prometheus |
| `json-exporter` | `prometheuscommunity/json-exporter` | JSON metrics export |
| `blackbox-exporter` | `prom/blackbox-exporter` | Availability probing |

All services run with `network_mode: host`.

## Requirements

- Docker 24+
- Docker Compose v2

## Getting Started

```bash
git clone https://git-vertex-homelab.mooo.com/hafus/docker-minecraft.git
# or
git clone https://github.com/win-hafus/docker-vertex-minecraft.git
cd docker-minecraft
cp .env.example .env
# Fill in .env
docker compose pull
docker compose up -d
```

## Configuration (.env)

| Variable | Description |
|---|---|
| `DB_HOST` / `DB_PORT` | MariaDB host and port |
| `MINECRAFT_MEMORY_LIMIT` | Memory limit for the server (e.g. `5g`) |
| `MINECRAFT_CPU_LIMIT` | CPU limit (number of cores) |
| `MYSQL_DATABASE_COREPROTECT` | Database name for CoreProtect |
| `MYSQL_DATABASE_DISCORDSRV` | Database name for DiscordSRV |
| `MYSQL_PASSWORD_*` | Database passwords |
| `DISCORDSRV_BOT_TOKEN` | Discord bot token |
| `VELOCITY_FORWARDING_SECRET` | Velocity forwarding secret |
| `JSON_EXPORTER_BIND_IP` / `_PORT` | json-exporter bind address |
| `BLACKBOX_EXPORTER_BIND_IP` / `_PORT` | blackbox-exporter bind address |
| `HEALTHCHECK_*` | Healthcheck parameters |

## Repository Structure

```
.
├── minecraft/          # Minecraft server Dockerfile and configs
├── velocity/           # Velocity proxy Dockerfile and configs
├── mariadb/            # MariaDB Dockerfile and init scripts
├── json-exporter/      # json-exporter config
├── blackbox/           # blackbox-exporter config
├── docker-compose.yml
└── .env.example
```

## Features
 
### Account Authentication
 
The server uses a custom-built plugin that generates a unique UUID for each player based on `nickname + timestamp`. This UUID is then bound to the player's Discord account via DiscordSRV, adding two-factor authentication — giving cracked (offline-mode) server users a solid level of account security.

## Acknowledgements

- [PaperMC](https://papermc.io/) — Minecraft server software
- [Velocity](https://velocitypowered.com/) — Modern Minecraft proxy
- [DiscordSRV](https://github.com/DiscordSRV/DiscordSRV) — Minecraft ↔ Discord bridge
- [CoreProtect](https://github.com/PlayPro/CoreProtect) — Block logging and rollback
- [Prometheus](https://prometheus.io/) — Metrics and monitoring

## Contact

- Discord: [Vertex System](https://discord.gg/gTuh9z29)
- Email: [konstantin.pirs@gmail.com](mailto:konstantin.pirs@gmail.com)

## Author

- Gitea: [Hafus](https://git-vertex-homelab.mooo.com/hafus)
- GitHub: [Win-Hafus](https://github.com/win-hafus/)

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE).
