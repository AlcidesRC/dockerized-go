.DEFAULT_GOAL := help

###
# CONSTANTS
###

SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

ifneq (,$(findstring xterm,$(TERM)))
	BLACK   := $(shell tput -Txterm setaf 0)
	RED     := $(shell tput -Txterm setaf 1)
	GREEN   := $(shell tput -Txterm setaf 2)
	YELLOW  := $(shell tput -Txterm setaf 3)
	BLUE    := $(shell tput -Txterm setaf 4)
	MAGENTA := $(shell tput -Txterm setaf 5)
	CYAN    := $(shell tput -Txterm setaf 6)
	WHITE   := $(shell tput -Txterm setaf 7)
	RESET   := $(shell tput -Txterm sgr0)
else
	BLACK   := ""
	RED     := ""
	GREEN   := ""
	YELLOW  := ""
	BLUE    := ""
	MAGENTA := ""
	CYAN    := ""
	WHITE   := ""
	RESET   := ""
endif

UID   := $(shell id --user)
GID   := $(shell id --group)
UNAME := $(shell id --user --name)
GNAME := $(shell id --group --name)

MODULE_NAME = app
SERVICE_NAME_APP = app

DOCKER_COMPOSE              = @docker-compose
DOCKER_COMPOSE_EXEC         = $(DOCKER_COMPOSE) exec $(SERVICE_NAME_APP)
DOCKER_COMPOSE_EXEC_AS_USER = $(DOCKER_COMPOSE) exec --user=$(UNAME) $(SERVICE_NAME_APP)

###
# DOCKER RELATED FUNCTIONS
###

# $(1)=CMD $(2)=OPTIONS
define runDockerCompose
	$(DOCKER_COMPOSE) $(1) $(2)
endef

# $(1)=CMD $(2)=OPTIONS
define runDockerComposeExec
	$(DOCKER_COMPOSE_EXEC) $(1) $(2)
endef

# $(1)=CMD $(2)=OPTIONS
define runDockerComposeExecAsUser
	$(DOCKER_COMPOSE_EXEC_AS_USER) $(1) $(2)
endef

###
# STRINGS RELATED FUNCTIONS
###

# $(1)=NUMBER OF CHARS
define lpad
	$(shell printf "%$(1)s" "")
endef

# $(1)=NUMBER OF CHARS
define rpad
	$(shell printf "%-$(1)s" "")
endef

# $(1)=TITLE $(2)=PADDING
define showTitle
	@echo "┌─────────────────────────────────────────────────────────────────────────────┐"
	@echo "│ ${YELLOW}$(1)${RESET} $(2) │"
	@echo "└─────────────────────────────────────────────────────────────────────────────┘"
	@echo ""
endef

# $(1)=TEXT $(2)=EXTRA
define success
	@echo ""
	@echo " ${GREEN}✓${RESET}  $(1) $(2)"
	@echo ""
endef

# $(1)=TEXT $(2)=EXTRA
define info
	@echo " ${YELLOW}ℹ${RESET}  $(1) $(2)"
endef

# $(1)=TEXT $(2)=EXTRA
define warning
	@echo " ${RED}‼${RESET}  $(1) $(2)"
endef

define taskDone
	$(call success,Task done!)
endef

###
# MAKEFILE TARGETS
###

-include $(SELF_DIR)/targets/*.mk
