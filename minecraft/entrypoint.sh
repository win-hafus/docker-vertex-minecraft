#!/bin/sh
set -e

# Substitute environment variables in CoreProtect config
if [ -f /srv/minecraft/vertex/plugins/CoreProtect/config.yml.template ]; then
    envsubst < /srv/minecraft/vertex/plugins/CoreProtect/config.yml.template > /srv/minecraft/vertex/plugins/CoreProtect/config.yml
    echo "CoreProtect config updated with environment variables"
fi

# Substitute environment variables in DiscordSRV config
if [ -f /srv/minecraft/vertex/plugins/DiscordSRV/config.yml.template ]; then
    envsubst < /srv/minecraft/vertex/plugins/DiscordSRV/config.yml.template > /srv/minecraft/vertex/plugins/DiscordSRV/config.yml
    echo "DiscordSRV config updated with environment variables"
fi

# Substitute environment variables in PictoMap config
if [ -f /srv/minecraft/vertex/plugins/PictoMap/config.yml.template ]; then
    envsubst < /srv/minecraft/vertex/plugins/PictoMap/config.yml.template > /srv/minecraft/vertex/plugins/PictoMap/config.yml
    echo "PictoMap config updated with environment variables"
fi

# Substitute environment variables in paper-global.yml
if [ -f /srv/minecraft/vertex/paper-global.yml.template ]; then
    envsubst < /srv/minecraft/vertex/paper-global.yml.template > /srv/minecraft/vertex/paper-global.yml
    echo "paper-global.yml updated with environment variables"
fi

# Execute the original command
exec "$@"
