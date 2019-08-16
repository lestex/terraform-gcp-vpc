SHELL := /usr/bin/env bash

# Docker build config variables
CREDENTIALS_PATH 	?= account.json
DOCKER_ORG 			:= leandevopsio
DOCKER_TAG			?= 0.1
DOCKER_REPO_BASE 	:= ${DOCKER_ORG}/buildenv:${DOCKER_TAG}

# All is the first target in the file so it will get picked up when you just run 'make' on its own
all: check_shell check_python check_terraform \
	 check_base_files check_trailing_whitespace generate_docs

# The .PHONY directive tells make that this isn't a real target and so
# the presence of a file named 'check_shell' won't cause this target to stop
# working
.PHONY: check_shell
check_shell:
	@source scripts/make.sh && check_shell

.PHONY: check_python
check_python:
	@source scripts/make.sh && check_python

.PHONY: check_terraform
check_terraform:
	@source scripts/make.sh && check_terraform

.PHONY: check_base_files
check_base_files:
	@source scripts/make.sh && basefiles

.PHONY: check_trailing_whitespace
check_trailing_whitespace:
	@source scripts/make.sh && check_trailing_whitespace

# Integration tests
.PHONY: test_integration
test_integration:
	./.circleci/ci_integration.sh

.PHONY: generate_docs
generate_docs:
	@source scripts/make.sh && generate_docs

.PHONY: docker_run
docker_run:
	docker run --rm -it \
		-e GOOGLE_APPLICATION_CREDENTIALS=${CREDENTIALS_PATH} \
		-e PROJECT_ID \
		-e RANDOM_STRING_FOR_TESTING \
		-v $(CURDIR):/app \
		${DOCKER_REPO_BASE} \
		/bin/bash -c "bundle install && .circleci/ci_integration.sh"		

.PHONY: docker_create
docker_create:
	docker run --rm -it \
		-e GOOGLE_APPLICATION_CREDENTIALS=${CREDENTIALS_PATH} \
		-e PROJECT_ID \
		-e RANDOM_STRING_FOR_TESTING \
		-v $(CURDIR):/app \
		${DOCKER_REPO_BASE} \
		/bin/bash -c "source test/ci_integration.sh && setup_environment && kitchen create"

.PHONY: docker_converge
docker_converge:
	docker run --rm -it \		
		-e GOOGLE_APPLICATION_CREDENTIALS=${CREDENTIALS_PATH} \
		-e PROJECT_ID \		
		-e RANDOM_STRING_FOR_TESTING \
		-v $(CURDIR):/app \
		${DOCKER_REPO_BASE} \
		/bin/bash -c "source test/ci_integration.sh && setup_environment && kitchen converge"

.PHONY: docker_verify
docker_verify:
	docker run --rm -it \		
		-e GOOGLE_APPLICATION_CREDENTIALS=${CREDENTIALS_PATH} \
		-e PROJECT_ID \		
		-e RANDOM_STRING_FOR_TESTING \
		-v $(CURDIR):/app \
		${DOCKER_REPO_BASE} \
		/bin/bash -c "source test/ci_integration.sh && setup_environment && kitchen verify"

.PHONY: docker_destroy
docker_destroy:
	docker run --rm -it \		
		-e GOOGLE_APPLICATION_CREDENTIALS=${CREDENTIALS_PATH} \
		-e PROJECT_ID \		
		-e RANDOM_STRING_FOR_TESTING \
		-v $(CURDIR):/app \
		${DOCKER_REPO_BASE} \
		/bin/bash -c "source test/ci_integration.sh && setup_environment && kitchen destroy"

.PHONY: test_integration_docker
test_integration_docker: docker_create docker_converge docker_verify docker_destroy
	@echo "Running test-kitchen tests in docker"
