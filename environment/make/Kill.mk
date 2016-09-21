kill:
	@if [ $(DEVELOPMENT) == NA -a $(PRODUCTION) == NA ]; then \
		if [ $(DEFAULT_ENVIRONMENT) == development ]; then \
			make kill-development; \
		else \
			make kill-production; \
		fi \
	else \
		if [ $(DEVELOPMENT) == true ]; then \
			make kill-development; \
		fi; \
		if [ $(PRODUCTION) == true ]; then \
			make kill-production; \
		fi \
	fi

kill-development:
	${INFO} "Killing development containers.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) kill

kill-production:
	@if [ $(PORT) == NA ]; then \
		bash -c '\
			printf $(RED); \
			echo "==> PORT environment variable not set."; \
			printf $(NC); \
		'; \
		exit 2; \
	fi
	${INFO} "Killing production containers.."
	${CMD} docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) kill