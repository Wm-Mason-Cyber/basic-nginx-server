#!/bin/sh

set -e

CERT_DIR="certs"
CERT_KEY="$CERT_DIR/server.key"
CERT_CRT="$CERT_DIR/server.crt"

if [ -f "$CERT_KEY" ] && [ -f "$CERT_CRT" ]; then
    echo "Certificates already exist. Skipping generation."
    exit 0
fi

mkdir -p "$CERT_DIR"

openssl req -x509 -newkey rsa:4096 -keyout "$CERT_KEY" -out "$CERT_CRT" -sha256 -days 365 -nodes -subj "/C=US/ST=Virginia/L=Williamsburg/O=William & Mary/OU=Cyber/CN=localhost"

echo "Self-signed certificates generated successfully."
