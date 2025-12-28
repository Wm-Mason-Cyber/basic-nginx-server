#!/bin/sh

set -e

# Determine the URL based on the NGINX_CONFIG
if [ "$NGINX_CONFIG" = "secure.conf" ]; then
    URL="https://localhost:8443"
    CURL_OPTS="-k" # Allow insecure server connections when using SSL
else
    URL="http://localhost:8080"
    CURL_OPTS=""
fi

# Wait for the server to be ready
echo "Waiting for server to be ready..."
while ! curl -s -o /dev/null $CURL_OPTS $URL; do
    sleep 1
done
echo "Server is ready."

# Check for HTTP 200 on /
echo "Checking for HTTP 200 on /"
curl -s -I $CURL_OPTS $URL/ | grep -q "200"
echo "OK"

# Check for 404 on unknown path
echo "Checking for 404 on unknown path"
curl -s -I $CURL_OPTS $URL/unknown | grep -q "404"
echo "OK"

# Check for security headers (secure config)
if [ "$NGINX_CONFIG" = "secure.conf" ]; then
    echo "Checking for security headers (secure config)"
    headers=$(curl -s -I $CURL_OPTS $URL/)
    
    echo -n "Checking for Strict-Transport-Security header... "
    if echo "$headers" | grep -qi "Strict-Transport-Security"; then
        echo "Found."
    else
        echo "NOT FOUND."
        echo "Headers received: $headers"
        exit 1
    fi

    echo -n "Checking for X-Frame-Options: DENY header... "
    if echo "$headers" | grep -qi "X-Frame-Options: DENY"; then
        echo "Found."
    else
        echo "NOT FOUND."
        echo "Headers received: $headers"
        exit 1
    fi

    echo -n "Checking for X-Content-Type-Options: nosniff header... "
    if echo "$headers" | grep -qi "X-Content-Type-Options: nosniff"; then
        echo "Found."
    else
        echo "NOT FOUND."
        echo "Headers received: $headers"
        exit 1
    fi

    echo -n "Checking for Referrer-Policy: no-referrer-when-downgrade header... "
    if echo "$headers" | grep -qi "Referrer-Policy: no-referrer-when-downgrade"; then
        echo "Found."
    else
        echo "NOT FOUND."
        echo "Headers received: $headers"
        exit 1
    fi

    echo -n "Checking for Content-Security-Policy header... "
    if echo "$headers" | grep -qi "Content-Security-Policy"; then
        echo "Found."
    else
        echo "NOT FOUND."
        echo "Headers received: $headers"
        exit 1
    fi
fi

# Check for absence of security headers (insecure config)
if [ "$NGINX_CONFIG" = "insecure.conf" ]; then
    echo "Checking for absence of security headers (insecure config)"
    headers=$(curl -s -I $CURL_OPTS $URL/)
    if echo "$headers" | grep -qi "X-Frame-Options"; then
        echo "X-Frame-Options header found, which is unexpected in the insecure config."
        exit 1
    fi
    echo "X-Frame-Options header not found, as expected."
fi

# Check for gzip compression
echo "Checking for gzip compression"
curl -s -H "Accept-Encoding: gzip" -I $CURL_OPTS $URL/assets/style.css | grep -qi "Content-Encoding: gzip"
echo "OK"

# Check for Cache-Control header for assets
echo "Checking for Cache-Control header for assets"
curl -s -I $CURL_OPTS $URL/assets/style.css | grep -qi "Cache-Control: public, max-age=31536000"
echo "OK"

echo "All checks passed!"
exit 0
