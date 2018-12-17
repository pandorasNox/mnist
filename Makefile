
include ./hack/help.mk

PWD=$(shell pwd)

.PHONY: up
up: ##dev start docker env
	docker run -d -t --rm --name pandorasnox_mnist -p 63832:8888 -v $(PWD):/workspace -w "/workspace" pandorasnox/deepo:pytorch-py36-jupyter-cpu 2> /dev/null || true

.PHONY: down
down: ##dev stop docker env
	docker stop pandorasnox_mnist

.PHONY: status
status: #dev return status of docker env
	docker ps --filter "name=pandorasnox_mnist"

.PHONY: cli
cli: ##@dev start dev cli
	$(MAKE) up 2> /dev/null || true
	docker exec -it pandorasnox_mnist bash

.PHONY: serve
serve: ##@dev start jupyter notebook server
	$(MAKE) up 2> /dev/null || true
	docker exec -it pandorasnox_mnist jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/workspace'

.PHONY: open
open: ##@dev open jupyter notebook UI in browser
	open http://localhost:63832
