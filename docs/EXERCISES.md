# Exercises

Here are some exercises to help you practice what you've learned.

## Exercise 1: Identify Missing Headers

1.  Run the server with the `insecure.conf` configuration.
2.  Use `curl -I http://localhost:8080` to inspect the HTTP headers.
3.  Identify which security headers are missing compared to the `secure.conf` configuration.

**Instructor Notes:** Students should identify the absence of `Strict-Transport-Security`, `X-Frame-Options`, `X-Content-Type-Options`, `Referrer-Policy`, and `Content-Security-Policy`.

## Exercise 2: Add a Content Security Policy (CSP)

1.  Inspect the `secure.conf` file and locate the `Content-Security-Policy` header.
2.  Modify the CSP to allow loading scripts from an external domain (e.g., `https://ajax.googleapis.com`).
3.  Test your changes by adding a script tag to `index.html` that loads a script from the external domain.

**Instructor Notes:** Students should modify the `Content-Security-Policy` to include `script-src 'self' https://ajax.googleapis.com;`.

## Exercise 3: Tune Cache Policies

1.  Inspect the `secure.conf` file and locate the caching configuration for static assets.
2.  Change the `expires` directive to a shorter duration (e.g., `1d` for one day).
3.  Use `curl -I http://localhost:8080/assets/style.css` to verify that the `Cache-Control` header reflects the new duration.

**Instructor Notes:** Students should see `Cache-Control: public, max-age=86400` in the response headers.

## Exercise 4: Enable Gzip for Text Assets Only

1.  Inspect the `secure.conf` file and locate the `gzip_types` directive.
2.  Modify the directive to only compress text-based assets (e.g., `text/plain`, `text/css`, `application/javascript`).
3.  Verify your changes by checking the `Content-Encoding` header for different asset types.

**Instructor Notes:** Students should see `Content-Encoding: gzip` for text assets but not for images.
