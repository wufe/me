# Application name
APP_NAME ?= app

# Quiet log
QUIET ?= false

APP_FOLDER := src
APP_BACKEND_FOLDER ?= $(APP_FOLDER)/backend
APP_FRONTEND_FOLDER ?= $(APP_FOLDER)/frontend

BIN_FOLDER := bin

# Git repositories
ANSIBLE_IMAGE_PATH := environment/docker/images/ansible
ANSIBLE_IMAGE_REPO := https://github.com/Wufe/docker-ansible
PHP_IMAGE_PATH := environment/docker/images/php70
PHP_IMAGE_REPO := https://github.com/Wufe/docker-php70

# Docker compose files
DEV_COMMON_COMPOSE_FILE := environment/docker/compose/development/common.yml
DEV_APP_COMPOSE_FILE := environment/docker/compose/development/app.yml

REL_COMMON_COMPOSE_FILE := environment/docker/compose/release/common.yml
REL_APP_COMPOSE_FILE := environment/docker/compose/release/app.yml

COMPOSE_DEV_FILES := -f $(DEV_COMMON_COMPOSE_FILE) -f $(DEV_APP_COMPOSE_FILE)
COMPOSE_REL_FILES := -f $(REL_COMMON_COMPOSE_FILE) -f $(REL_APP_COMPOSE_FILE)

.PHONY: install development test build release deploy wipe watch run

install:
	${INFO} "Downloading docker images.."
	@if ! [ -d "$(ANSIBLE_IMAGE_PATH)" ]; then \
		git clone $(ANSIBLE_IMAGE_REPO) $(ANSIBLE_IMAGE_PATH); \
	fi
	@if ! [ -d "$(PHP_IMAGE_PATH)" ]; then \
		git clone $(PHP_IMAGE_REPO) $(PHP_IMAGE_PATH); \
	fi
	${INFO} "Downloading NPM dependencies.."
	${CMD} docker run -it --rm -w /app -v `pwd`:/app node:wheezy npm install -s
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app node:wheezy npm install -s
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_FRONTEND_FOLDER):/app node:wheezy npm install -s
	${INFO} "Downloading composer dependencies.."
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app composer/composer install
	${INFO} "Executing post-install scripts.."
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app composer/composer run-script post-root-package-install
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app composer/composer run-script post-create-project-cmd
	${INFO} "Changing permissions.."
	${CMD} chmod +x $(BIN_FOLDER)/*
	${INFO} "Building docker images from compose.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) build
	${INFO} "Building javascript using webpack.."
	${CMD} docker run -it --rm -w /app -v `pwd`:/app node:wheezy npm run pack -s
	${SUCCESS} "Done."

development:
	${INFO} "Starting database.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) up probe
	${INFO} "Starting web server.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) up -d nginx
	${INFO} "Migrating database.."
	${CMD} docker exec -it $$(docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) ps -q php) php /app/artisan migrate
	${SUCCESS} "Development environment ready."

test:
	# Requires development environment up and running
	@make development
	${INFO} "Testing.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) up test
	${SUCCESS} "Done."

build:
	# To be implemented
release:
	# To be implemented
deploy:
	# To be implemented

wipe:
	${INFO} "Wiping docker dangling images and volumes.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) kill
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) rm -f -v
	@docker images -q -f dangling=true | xargs -I ARGS docker rmi -f ARGS
	@docker volume ls -q -f dangling=true | xargs -I ARGS docker volume rm ARGS
	${INFO} "Wiping folders and environment.."
	${CMD} rm -rf environment/docker/images/*
	${CMD} rm -rf mysql_data
	${CMD} rm -rf node_modules
	${CMD} rm -rf src/backend/.env
	${CMD} rm -rf src/backend/node_modules
	${CMD} rm -rf src/backend/vendor
	${CMD} rm -rf src/backend/public/assets/javascript/*.bundle.js*
	${CMD} rm -rf src/backend/public/assets/javascript/*chunk.js*
	${CMD} rm -rf src/frontend/node_modules
	${SUCCESS} "Done."

watch:
	${INFO} "Starting now webpack routine.."
	${CMD} docker run -it --rm -w /app -v `pwd`:/app node:wheezy npm run pack:watch -s

run:
	${INFO} "Running all suite of development commands.."
	@make wipe
	@make install
	@make development
	@make test



GREEN := "\e[0;32m"
DARKGREY := "\e[1;30m"
YELLOW := "\e[1;33m"
NC := "\e[0m"

INFO := @bash -c '\
	printf $(YELLOW); \
	echo "=> $$1"; \
	printf $(NC)' VALUE

SUCCESS := @bash -c '\
	printf $(GREEN); \
	echo "=> $$1"; \
	printf $(NC)' VALUE

ifeq ($(QUIET),true)
	CMD := @bash -c '\
	$$* >/dev/null; \
	' VALUE
endif

ifeq ($(QUIET),false)
	CMD := @bash -c '\
	printf $(DARKGREY); \
	echo "=> $$*"; \
	$$*; \
	printf $(NC)' VALUE
endif