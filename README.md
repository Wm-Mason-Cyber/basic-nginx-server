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
│   └── generate-selfsigned.sh
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

2.  **Start the server:**

    ```bash
    make up
    ```

    This will start the Nginx server in the background with the secure configuration by default. You can access the site at `https://localhost:8443`.

3.  **Run the tests:**

    ```bash
    make test
    ```

4.  **Switch to the insecure configuration for exercises:**

    To switch to the insecure configuration for the exercises, you can mount the `insecure.conf` file over the default configuration in the `docker-compose.yml` file.

    First, stop the running container:
    ```bash
    make down
    ```

    Then, modify the `docker-compose.yml` file to mount the `insecure.conf` file:
    ```yaml
    services:
      web:
        build: .
        ports:
          - "8080:80"
          - "8443:443"
        volumes:
          - ./nginx/conf.d/insecure.conf:/etc/nginx/conf.d/default.conf
    ```

    Finally, start the server again:
    ```bash
    make up
    ```
    You can now access the site at `http://localhost:8080`.

5.  **Stop the server:**

    ```bash
    make down
    ```