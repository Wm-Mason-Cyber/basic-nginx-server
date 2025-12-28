# Makefile for the Basic Nginx Server Example

.PHONY: all up down test lint-html reset

all: up

up:
	@echo "Starting up the services..."
	@docker-compose up --build -d

down:
	@echo "Stopping the services..."
	@docker-compose down

test:
	@echo "Running tests..."
	@./tests/run_checks.sh

lint-html:
	@echo "Linting HTML files..."
	@if command -v tidy >/dev/null 2>&1; then \
		tidy -q -e site/*.html; \
	else \
		echo "Tidy not found, skipping HTML linting."; \
	fi

reset: down
	@echo "Resetting the environment..."
	@docker-compose down -v --remove-orphans
	@rm -rf certs
