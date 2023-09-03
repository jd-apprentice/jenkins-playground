IMAGE_NAME=jenkins
IMAGE_FILE=Jenkins
VERSION=4.414.1-1
IGNORE=2>/dev/null

exec: network build run

network:
	-docker network create $(IMAGE_NAME) 1> logs/network.log 2> logs/network-err.log

build:
	cd docker && docker build -t $(IMAGE_NAME):$(VERSION) -f $(IMAGE_FILE).Dockerfile .

enter:
	docker exec -it $(IMAGE_NAME) bash

run:
	docker run \
	--name $(IMAGE_NAME) \
	--restart=on-failure \
	--detach \
	--network $(IMAGE_NAME) \
	--env DOCKER_HOST=tcp://docker:2376 \
	--env DOCKER_CERT_PATH=/certs/client \
	--env DOCKER_TLS_VERIFY=1 \
	--publish 8080:8080 \
	--publish 50000:50000 \
	--volume /var/run/docker.sock:/var/run/docker.sock \
	--volume $(which docker):/usr/bin/docker \
	--volume jenkins-data:/var/jenkins_home \
	--volume jenkins-docker-certs:/certs/client:ro \
	$(IMAGE_NAME):$(VERSION)

clear:
	-docker network rm jenkins $(IGNORE)
	-docker rm -f $(IMAGE_NAME) $(IGNORE)
	-docker volume rm jenkins-data $(IGNORE)
	-docker volume rm jenkins-docker-certs $(IGNORE)
	-docker image rm $(IMAGE_NAME):$(VERSION) $(IGNORE)