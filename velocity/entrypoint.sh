#!/bin/sh
set -e

# Generate forwarding.secret from environment variable if set
if [ -n "$VELOCITY_FORWARDING_SECRET" ]; then
    echo "$VELOCITY_FORWARDING_SECRET" > /srv/minecraft/velocity/forwarding.secret
    echo "Generated forwarding.secret from environment variable"
fi

# Execute the original start command
exec ./server-start
