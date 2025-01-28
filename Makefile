ifneq ("$(wildcard .env)","")
	include .env
	export
endif

install: ## Install the project.
	poetry lock
	poetry install --no-root
	poetry run pre-commit install

.PHONY: up
up: ## Start all podman services from this project.
	podman compose up -d --force-recreate

.PHONY: up-postgres
up-postgres: ## Start postgres database container.
	podman compose up -d postgres --force-recreate

.PHONY: up-mongo
up-mongo: ## Start mongodb database container.
	podman compose up -d mongo --force-recreate
	podman compose up -d mongo-express --force-recreate

.PHONY: down
down: ## Stop all podman services from this project.
	podman compose down

.PHONY: rm-containers
rm-containers: ## Remove all podman containers.
	podman rm -f $$(podman ps -aq)

.PHONY: start-podman
start-podman: ## Start the podman. WSL needs to manually start podman.
	sudo service podman start

.PHONY: revision
revision: ## Create a new revision of the database using alembic. Use MESSAGE="your message" to add a message.
	poetry run alembic revision --autogenerate

.PHONY: migrate
migrate: ## Apply the migrations to the database.
	poetry run alembic upgrade head

.PHONY: downgrade
downgrade: ## Undo the last migration.
	poetry run alembic downgrade -1

.PHONY: db-drop
db-drop: ## Drop the database.
	podman compose exec postgres psql -U $(DB_USERNAME) -d postgres -c "DROP DATABASE IF EXISTS $(DB_DATABASE);"

.PHONY: db-create
db-create: ## Create the database.
	podman compose exec postgres psql -U $(DB_USERNAME) -d postgres -c "CREATE DATABASE $(DB_DATABASE);"

.PHONY: db-full-clean
db-full-clean: db-drop db-create ## Drop and recreate the database.

.PHONY: db-reset
db-reset: db-full-clean migrate ## Drop, recreate and apply all migrations to the database.

.PHONY: clean
clean: ## Clean project's temporary files.
	find . -name '__pycache__' -exec rm -rf {} +
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.log' -exec rm -f {} +

.DEFAULT_GOAL := help
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' "Makefile" | sed 's/Makefile://g' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
