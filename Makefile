SHELL := /usr/bin/env bash

# All is the first target in the file so it will get picked up when you just run 'make' on its own
all: check_shell check_python check_golang check_terraform \
	 check_docker check_base_files test_check_headers check_headers \
	 check_trailing_whitespace generate_docs

# The .PHONY directive tells make that this isn't a real target and so
# the presence of a file named 'check_shell' won't cause this target to stop
# working
.PHONY: check_shell
check_shell:
	@source scripts/make.sh && check_shell

.PHONY: check_python
check_python:
	@source scripts/make.sh && check_python

.PHONY: check_golang
check_golang:
	@source scripts/make.sh && golang

.PHONY: check_terraform
check_terraform:
	@source scripts/make.sh && check_terraform

.PHONY: check_docker
check_docker:
	@source scripts/make.sh && docker

.PHONY: check_base_files
check_base_files:
	@source scripts/make.sh && basefiles

.PHONY: check_trailing_whitespace
check_trailing_whitespace:
	@source scripts/make.sh && check_trailing_whitespace

.PHONY: test_check_headers
test_check_headers:
	@echo "Testing the validity of the header check"
	@python scripts/test_verify_boilerplate.py

.PHONY: check_headers
check_headers:
	@source scripts/make.sh && check_headers

# Integration tests
.PHONY: test_integration
test_integration:
	./.circleci/ci_integration.sh

.PHONY: generate_docs
generate_docs:
	@source scripts/make.sh && generate_docs

