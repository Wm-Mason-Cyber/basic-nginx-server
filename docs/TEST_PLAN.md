# Test Plan

This document describes the automated tests for this project and how to extend them.

## Automated Checks

The automated tests are located in the `scripts/check_site.sh` script. This script performs the following checks:

- **HTTP 200 on /**: Checks that the root of the site returns a `200 OK` status code.
- **404 on unknown path**: Checks that a request to an unknown path returns a `404 Not Found` status code.
- **Security Headers**:
    - **Secure config**: Checks for the presence of the following security headers:
        - `Strict-Transport-Security`
        - `X-Frame-Options`
        - `X-Content-Type-Options`
        - `Referrer-Policy`
        - `Content-Security-Policy`
    - **Insecure config**: Checks for the absence of the `X-Frame-Options` header.
- **Gzip Compression**: Checks that static assets are compressed with gzip.
- **Cache-Control Header**: Checks that static assets have a `Cache-Control` header with a long `max-age`.

## Extending the Tests

To add more tests, you can add more `curl` commands to the `scripts/check_site.sh` script. For example, you could add checks for:

- The content of the `sitemap.xml` or `robots.txt` files.
- The presence of specific HTML elements on a page.
- The response time of the server.
