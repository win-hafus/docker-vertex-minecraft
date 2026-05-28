# Vertex System

Docker Compose конфигурация для Minecraft-сервера Vertex System.

## Стек

| Сервис | Образ / Источник | Назначение |
|---|---|---|
| `minecraft-server` | Dockerfile (`./minecraft`) | Minecraft-сервер (Paper/Spigot) |
| `mariadb` | Dockerfile (`./mariadb`) | База данных для CoreProtect и DiscordSRV |
| `velocity` | Dockerfile (`./velocity`) | Прокси Velocity |
| `node-exporter` | `prom/node-exporter` | Метрики хоста для Prometheus |
| `json-exporter` | `prometheuscommunity/json-exporter` | Экспорт метрик в формате JSON |
| `blackbox-exporter` | `prom/blackbox-exporter` | Проверка доступности |

Все сервисы запускаются с `network_mode: host`.

## Требования

- Docker 24+
- Docker Compose v2

## Быстрый старт

```bash
git clone https://git-vertex-homelab.mooo.com/hafus/docker-minecraft.git
# или
git clone https://github.com/win-hafus/docker-vertex-minecraft.git
cd docker-minecraft
cp .env.example .env
# Заполните .env
docker compose pull
docker compose up -d
```

## Боже, храни РКН

Я написал комментарий к коду, но уверен, что его никто не прочитает. Из-за того, что сервер работает в собственной подсети zapret, может не обрабатывать его запросы к discord.com от чего вы не сможете подключиться, по крайней мере так у меня (I use Gentoo, btw). Вам нужно будет добавить пару правил к firewall запрета, если вы столкнулись с этой проблемой. Я использую `zapret-discord-youtube-linux`, поэтому конфиг лежит в `zapret-discord-youtube-linux/src/lib/firewall.sh`, если вы использует стандартный zapret, то он будет в `/opt/zapret/config`, но правила можно добавить и через `shell`:
```bash
doas nft add chain inet zapretunix forward { type filter hook forward priority filter \; policy accept \; }

doas nft add rule inet zapretunix forward \
  meta mark != 0x40000000 \
  tcp dport { 80, 443, 2053, 2083, 2087, 2096, 8443 } \
  counter queue flags bypass to 220 comment \"Added by zapret script\"

doas nft add rule inet zapretunix forward \
  meta mark != 0x40000000 \
  udp dport { 443, 19294-19344, 50000-50100 } \
  counter queue flags bypass to 220 comment \"Added by zapret script\"
```
Если по-заумному это происходит потому что:
> По умолчанию Zapret перехватывает только трафик самого хоста (`hook output`). Контейнеры Docker в bridge-сети маршрутизируют трафик через `hook forward`, поэтому без дополнительной настройки Discord и другие заблокированные ресурсы недоступны внутри контейнеров

> Порты могут отличаться, смотря какая у тебя стратегия и как ты ее придерживаешься

## Конфигурация (.env)

| Переменная | Описание |
|---|---|
| `DB_HOST` / `DB_PORT` | Хост и порт MariaDB |
| `MINECRAFT_MEMORY_LIMIT` | Лимит памяти для сервера (например, `5g`) |
| `MINECRAFT_CPU_LIMIT` | Лимит CPU (количество ядер) |
| `MYSQL_DATABASE_COREPROTECT` | Имя базы данных для CoreProtect |
| `MYSQL_DATABASE_DISCORDSRV` | Имя базы данных для DiscordSRV |
| `MYSQL_PASSWORD_*` | Пароли базы данных |
| `DISCORDSRV_BOT_TOKEN` | Токен Discord-бота |
| `VELOCITY_FORWARDING_SECRET` | Секрет переадресации Velocity |
| `JSON_EXPORTER_BIND_IP` / `_PORT` | Адрес привязки json-exporter |
| `BLACKBOX_EXPORTER_BIND_IP` / `_PORT` | Адрес привязки blackbox-exporter |
| `HEALTHCHECK_*` | Параметры проверки работоспособности |

## Структура репозитория

```
.
├── minecraft/          # Dockerfile и конфигурации Minecraft-сервера
├── velocity/           # Dockerfile и конфигурации прокси Velocity
├── mariadb/            # Dockerfile и скрипты инициализации MariaDB
├── json-exporter/      # Конфигурация json-exporter
├── blackbox/           # Конфигурация blackbox-exporter
├── docker-compose.yml
└── .env.example
```

## Особенности

### Аутентификация аккаунтов

Сервер использует собственный плагин, который генерирует уникальный UUID для каждого игрока на основе `никнейм + временная метка`. Этот UUID затем привязывается к Discord-аккаунту игрока через DiscordSRV, обеспечивая двухфакторную аутентификацию — что даёт пользователям пиратского (offline-mode) сервера надёжный уровень защиты аккаунта.

## Благодарности

- [PaperMC](https://papermc.io/) — программное обеспечение Minecraft-сервера
- [Velocity](https://velocitypowered.com/) — современный прокси для Minecraft
- [DiscordSRV](https://github.com/DiscordSRV/DiscordSRV) — мост между Minecraft и Discord
- [CoreProtect](https://github.com/PlayPro/CoreProtect) — логирование блоков и откат изменений
- [Prometheus](https://prometheus.io/) — метрики и мониторинг

## Контакты

- Discord: [Vertex System](https://discord.gg/gTuh9z29)
- Email: [konstantin.pirs@gmail.com](mailto:konstantin.pirs@gmail.com)

## Автор

- Gitea: [Hafus](https://git-vertex-homelab.mooo.com/hafus)
- GitHub: [Win-Hafus](https://github.com/win-hafus/)

## Лицензия

Проект распространяется под лицензией [GNU General Public License v3.0](LICENSE).
