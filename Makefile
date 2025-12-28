# Makefile for the Basic Nginx Server Example

.PHONY: all up up-secure down test test-secure lint-html reset

all: up

up:
	@echo "Starting up the services (insecure)..."
	@docker compose up --build -d

up-secure: scripts/generate-selfsigned.sh
	@echo "Starting up the services (secure)..."
	@NGINX_CONFIG=secure.conf docker compose up --build -d

down:
	@echo "Stopping the services..."
	@docker compose down

test:
	@echo "Running tests (insecure)..."
	@NGINX_CONFIG=insecure.conf ./tests/run_checks.sh

test-secure: scripts/generate-selfsigned.sh
	@echo "Running tests (secure)..."
	@NGINX_CONFIG=secure.conf ./tests/run_checks.sh

lint-html:
	@echo "Linting HTML files..."
	@if command -v tidy >/dev/null 2>&1; then \
		tidy -q -e site/*.html; \
	else \
		echo "Tidy not found, skipping HTML linting."; \
	fi

reset: down
	@echo "Resetting the environment..."
	@docker compose down -v --remove-orphans
	@rm -rf certs
