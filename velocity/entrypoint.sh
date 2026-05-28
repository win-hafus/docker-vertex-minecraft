#!/bin/sh
set -e

# Generate forwarding.secret from environment variable if set
if [ -n "$VELOCITY_FORWARDING_SECRET" ]; then
    echo "$VELOCITY_FORWARDING_SECRET" > /srv/minecraft/velocity/forwarding.secret
    echo "Generated forwarding.secret from environment variable"
fi

if [ -f /srv/minecraft/velocity/plugins/velocity-discord-auth/config.properties.template ]; then
    envsubst < /srv/minecraft/velocity/plugins/velocity-discord-auth/config.properties.template > /srv/minecraft/velocity/plugins/velocity-discord-auth/config.properties
    echo "config.properties updated with environment variables"
fi

# Execute the original start command
exec ./server-start
