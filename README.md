# Basic Nginx Server Example

This repository provides a basic example of how to serve a static website using Nginx. It includes both insecure and secure configurations to demonstrate best practices for web server security.

## File Tree

```
.
├── .github/
│   └── workflows/
│       └── ci.yml
├── docs/
│   ├── EXERCISES.md
│   ├── PROJECT_GOALS.md
│   ├── TEST_PLAN.md
│   └── WORKSHEET.md
├── nginx/
│   ├── conf.d/
│   │   ├── insecure.conf
│   │   └── secure.conf
│   └── nginx.conf
├── scripts/
│   ├── check_site.sh
│   ├── generate-selfsigned.sh
│   └── start.sh
├── site/
│   ├── assets/
│   │   ├── app.js
│   │   └── style.css
│   ├── 404.html
│   ├── about.html
│   ├── contact.html
│   ├── index.html
│   ├── robots.txt
│   └── sitemap.xml
├── tests/
│   ├── bootstrap.sh
│   └── run_checks.sh
├── .gitignore
├── docker-compose.yml
├── Dockerfile
├── LICENSE
├── Makefile
└── README.md
```

## Quick Start

### Prerequisites

- Docker
- docker-compose
- `make`

### Instructions

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/Wm-Mason-Cyber/basic-nginx-server.git
    cd basic-nginx-server
    ```

2.  **Start the server (insecure configuration):**

    ```bash
    make up
    ```

    This will start the Nginx server in the background with the insecure configuration. You can access the site at `http://localhost:8080`.

3.  **Start the server (secure configuration):**

    ```bash
    make up-secure
    ```

    This will generate self-signed certificates and start the Nginx server with the secure configuration. You can access the site at `https://localhost:8443`.

4.  **Run the tests (insecure configuration):**

    ```bash
    make test
    ```

5.  **Run the tests (secure configuration):**

    ```bash
    make test-secure
    ```

6.  **Stop the server:**

    ```bash
    make down
    ```