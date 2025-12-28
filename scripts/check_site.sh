#!/bin/sh

set -e

# Wait for the server to be ready
echo "Waiting for server to be ready..."
while ! curl -s -o /dev/null http://localhost:8080; do
    sleep 1
done
echo "Server is ready."

# Check for HTTP 200 on /
echo "Checking for HTTP 200 on /"
curl -s -I http://localhost:8080/ | grep -q "HTTP/1.1 200 OK"
echo "OK"

# Check for 404 on unknown path
echo "Checking for 404 on unknown path"
curl -s -I http://localhost:8080/unknown | grep -q "HTTP/1.1 404 Not Found"
echo "OK"

# Check for security headers (secure config)
if [ "$NGINX_CONFIG" = "secure.conf" ]; then
    echo "Checking for security headers (secure config)"
    headers=$(curl -s -I http://localhost:8080/)
    echo "$headers" | grep -q "Strict-Transport-Security"
    echo "HSTS header found."
    echo "$headers" | grep -q "X-Frame-Options: DENY"
    echo "X-Frame-Options header found."
    echo "$headers" | grep -q "X-Content-Type-Options: nosniff"
    echo "X-Content-Type-Options header found."
    echo "$headers" | grep -q "Referrer-Policy: no-referrer-when-downgrade"
    echo "Referrer-Policy header found."
    echo "$headers" | grep -q "Content-Security-Policy"
    echo "CSP header found."
fi

# Check for absence of security headers (insecure config)
if [ "$NGINX_CONFIG" = "insecure.conf" ]; then
    echo "Checking for absence of security headers (insecure config)"
    headers=$(curl -s -I http://localhost:8080/)
    if echo "$headers" | grep -q "X-Frame-Options"; then
        echo "X-Frame-Options header found, which is unexpected in the insecure config."
        exit 1
    fi
    echo "X-Frame-Options header not found, as expected."
fi


# Check for gzip compression
echo "Checking for gzip compression"
curl -s -H "Accept-Encoding: gzip" -I http://localhost:8080/assets/style.css | grep -q "Content-Encoding: gzip"
echo "OK"

# Check for Cache-Control header for assets
echo "Checking for Cache-Control header for assets"
curl -s -I http://localhost:8080/assets/style.css | grep -q "Cache-Control: public, max-age=31536000"
echo "OK"

echo "All checks passed!"
exit 0
