.PHONY: help ps build build-prod start fresh fresh-prod stop restart destroy \
	cache cache-clear migrate migrate migrate-fresh tests tests-html

CONTAINER_PHP=api
CONTAINER_REDIS=redis
CONTAINER_DATABASE=database

help: ## Print help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

ps: ## Show containers.
	@docker compose ps

build: ## Build all containers for PROD
	@docker build --no-cache . -f ./Dockerfile
start: ## Start all containers
	@docker compose -f docker-compose.local.yml up --force-recreate -d
stop: ## Stop all containers
	@docker compose -f docker-compose.local.yml stop
restart: stop start ## Restart all containers
destroy: stop ## Destroy all containers

build-prod: ## Build all containers for DEV
	@docker build --no-cache .
start-prod: ## Start all containers
	@docker compose up --force-recreate -d
stop-prod: ## Stop all containers
	@docker compose stop
restart-prod: stop-prod start-prod ## Restart all containers
destroy-prod: stop-prod ## Destroy all containers

fresh:  ## Destroy & recreate all uing dev containers.
	make stop
	make destroy
	make build
	make start

fresh-prod: ## Destroy & recreate all using prod containers.
	make stop-prod
	make destroy-prod
	make build-prod
	make start-prod

ssh: ## SSH into PHP container
	docker exec -it ${CONTAINER_PHP} sh

install: ## Run composer install
	docker exec ${CONTAINER_PHP} composer install

migrate: ## Run migration files
	docker exec ${CONTAINER_PHP} php artisan migrate

migrate-fresh: ## Clear database and run all migrations
	docker exec ${CONTAINER_PHP} php artisan migrate:fresh

tests: ## Run all tests
	docker exec ${CONTAINER_PHP} ./vendor/bin/phpunit

tests-html: ## Run tests and generate coverage. Report found in reports/index.html
	docker exec ${CONTAINER_PHP} php -d zend_extension=xdebug.so -d xdebug.mode=coverage ./vendor/bin/phpunit --coverage-html reports

lint: ## Run phpcs
	./vendor/bin/phpcs --standard=ruleset.xml app/

lint-fix: ## Run phpcbf
	./vendor/bin/phpcbf --standard=ruleset.xml app/
