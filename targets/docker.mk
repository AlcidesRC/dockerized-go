###
# PRODUCTION
###

build-distroless: ## Docker: builds the service for production environment
	$(call showTitle,"DOCKER: BUILDING A DISTROLESS APPLICATION SERVICE",$(call rpad,21))
	@docker build --file Dockerfile --target distroless --tag app:latest .
	$(call taskDone)

###
# DEVELOPMENT
###

build: ## Docker: builds the service
	$(call showTitle,"DOCKER: BUILDING THE APPLICATION SERVICE",$(call rpad,29))
	$(call runDockerCompose,build,--build-arg UNAME=$(UNAME) --build-arg GNAME=$(GNAME) --build-arg UID=$(UID) --build-arg GID=$(GID))
	$(call taskDone)

down: ## Docker: stops the service
	$(call showTitle,"DOCKER: STOPPING THE APPLICATION SERVICE",$(call rpad,29))
	$(call runDockerCompose,down --remove-orphans)
	$(call taskDone)

up: ## Docker: starts the service
	$(call showTitle,"DOCKER: STARTING THE APPLICATION SERVICE",$(call rpad,29))
	$(call runDockerCompose,--file docker-compose.yml up --remove-orphans --detach)
	$(call taskDone)

logs: ## Docker: exposes the service logs
	$(call showTitle,"DOCKER: EXPOSING APPLICATION SERVICE LOGS",$(call rpad,29))
	$(call runDockerCompose,logs)
	$(call taskDone)

restart: ## Docker: restarts the service
	$(call showTitle,"DOCKER: RESTARTING THE APPLICATION SERVICE",$(call rpad,29))
	$(call runDockerCompose,restart $(SERVICE_NAME_APP))
	$(call taskDone)

bash: ## Docker: stablish a bash session into main container
	$(call showTitle,"DOCKER: STABLISHING BASH TERMINAL WITH APPLICATION SERVICE",$(call rpad,13))
	$(call runDockerComposeExec,bash)
	$(call taskDone)
