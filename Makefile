
include ./hack/help.mk

PWD=$(shell pwd)
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	OS="LINUX"
	OPEN=x-www-browser
endif
ifeq ($(UNAME_S),Darwin)
	OS="OSX"
	OPEN=open
endif

#IMAGE=pandorasnox/deepo:pytorch-py36-jupyter-cpu
IMAGE=flair
#CONTAINER_NAME=pandorasnox_mnist
CONTAINER_NAME=zalando_flair

.PHONY: up
up: ##dev start docker env
	docker run -d -t --rm --name $(CONTAINER_NAME) -p 63832:8888 -v $(PWD):/workspace -w "/workspace" $(IMAGE) 2> /dev/null || true

.PHONY: down
down: ##dev stop docker env
	docker stop $(CONTAINER_NAME)

.PHONY: status
status: #dev return status of docker env
	docker ps --filter "name=$(CONTAINER_NAME)"

.PHONY: cli
cli: ##@dev start dev cli
	$(MAKE) up 2> /dev/null || true
	docker exec -it $(CONTAINER_NAME) bash

.PHONY: serve
serve: ##@dev start jupyter notebook server
	$(MAKE) up 2> /dev/null || true
	docker exec -it $(CONTAINER_NAME) jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/workspace'

.PHONY: open
open: ##@dev open jupyter notebook UI in browser
	$(OPEN) http://localhost:63832

.PHONY: os
os:
	@echo $(OS)
