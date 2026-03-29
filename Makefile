.PHONY: help setup dev test test-e2e build lint clean docker-up docker-down db-migrate db-seed

## help - Display all available commands
help:
	@echo "ERP Ecosystem - Available Commands"
	@echo "===================================="
	@echo ""
	@grep -E '^## ' Makefile | sed 's/^## //' | awk -F' - ' '{printf "  %-20s %s\n", $$1, $$2}'
	@echo ""

## setup - Initialize development environment
setup:
	bash scripts/setup.sh

## dev - Start development server
dev:
	npx turbo dev --concurrency=25

## test - Run unit tests
test:
	npx turbo test

## test-e2e - Run end-to-end tests
test-e2e:
	npx turbo test:e2e

## build - Build all packages and applications
build:
	npx turbo build

## lint - Lint all code and check types
lint:
	npx turbo lint && npx turbo typecheck

## clean - Remove build artifacts and node_modules
clean:
	rm -rf node_modules apps/*/node_modules apps/*/.next apps/*/dist

## docker-up - Start Docker services
docker-up:
	docker compose up -d

## docker-down - Stop Docker services
docker-down:
	docker compose down

## db-migrate - Generate and push database schema
db-migrate:
	npx turbo db:generate && npx turbo db:push

## db-seed - Seed database with initial data
db-seed:
	npx turbo db:seed
