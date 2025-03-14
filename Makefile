SHELL = /bin/sh
.DEFAULT_GOAL := help
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

.PHONY: check
check: ## run stow in dry run mode to validate actions
	stow -vvn */

.PHONY: clean
clean: ## delete symlinks using stow
	stow -vvD */

.PHONY: create
create: ## create symlinks using stow
	stow -vv */

.PHONY: update
update: ## delete and create symlinks using stow
	stow -vvR */

.PHONY: help
help: ## display this message
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} { \
		if (/^[a-zA-Z_-]+:.*?##.*$$/) {printf "    ${YELLOW}%-20s${GREEN}%s${RESET}\n", $$1, $$2} \
		else if (/^## .*$$/) {printf "  ${CYAN}%s${RESET}\n", substr($$1,4)} \
		}' $(MAKEFILE_LIST)
