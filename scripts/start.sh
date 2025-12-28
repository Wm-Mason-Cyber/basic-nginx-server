#!/bin/sh

set -e

# Use the NGINX_CONFIG environment variable to determine which config to use
# Default to insecure.conf if NGINX_CONFIG is not set
NGINX_CONFIG_FILE="${NGINX_CONFIG:-insecure.conf}"

echo "Using Nginx configuration: $NGINX_CONFIG_FILE"

# Remove any existing default config and link the chosen one
rm -f /etc/nginx/conf.d/default.conf
ln -sf /etc/nginx/conf.d/$NGINX_CONFIG_FILE /etc/nginx/conf.d/default.conf

# Execute the main Nginx command
exec nginx -g "daemon off;"
