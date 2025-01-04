install: ## Install the project.
	poetry install --no-root

.PHONY: up-postgres
up-postgres: ## Start postgres database container.
	docker compose up -d postgres --force-recreate

.PHONY: down
down: ## Stop all docker services from this project.
	docker compose down

.PHONY: rm-containers
rm-containers: ## Remove all docker containers.
	docker rm -f $(docker ps -aq)

.PHONY: start-docker
start-docker: ## Start the docker. WSL needs to manually start docker.
	sudo service docker start

.PHONY: revision
revision: ## Create a new revision of the database using alembic. Use MESSAGE="your message" to add a message.
	poetry run alembic revision --autogenerate

.PHONY: migrate
migrate: ## Apply the migrations to the database.
	poetry run alembic upgrade head

.PHONY: downgrade
downgrade: ## Undo the last migration.
	poetry run alembic downgrade -1

.PHONY: db-full-clean
db-full-clean: ## Drop and recreate the database.
	docker compose exec postgres postgres -u "$2" -p"$3" -e "DROP DATABASE IF EXISTS $4; CREATE DATABASE $4;"

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

