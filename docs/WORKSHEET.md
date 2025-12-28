# Worksheet

## Student Tasks

1.  Clone the repository and run `make up` to start the server.
2.  Use `curl` to explore the site and its headers.
3.  Complete the exercises in `docs/EXERCISES.md`.
4.  Answer the following questions:

    - What is the purpose of the `X-Frame-Options` header?
    - What is the difference between `Cache-Control: no-cache` and `Cache-Control: no-store`?
    - What is the purpose of the `Content-Security-Policy` header?

## Teacher Key

- **What is the purpose of the `X-Frame-Options` header?**
  - To prevent clickjacking attacks by controlling whether a browser can render a page in a `<frame>`, `<iframe>`, `<embed>`, or `<object>`.

- **What is the difference between `Cache-Control: no-cache` and `Cache-Control: no-store`?**
  - `no-cache` indicates that a client must revalidate with the server before using a cached response.
  - `no-store` is more restrictive and tells the client not to cache the response at all.

- **What is the purpose of the `Content-Security-Policy` header?**
  - To control which resources (e.g., scripts, styles, images) a browser is allowed to load for a given page. This helps prevent Cross-Site Scripting (XSS) attacks.
