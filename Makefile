IMAGE_NAME=jenkins
IMAGE_FILE=Jenkins
VERSION=4.414.1-1

build:
	cd docker && docker build -t $(IMAGE_NAME):$(VERSION) -f $(IMAGE_FILE).Dockerfile .

run:
	docker run \   
	--name jenkins \
	--restart=on-failure \
	--detach \
	--network jenkins \
	--env DOCKER_HOST=tcp://docker:2376 \
	--env DOCKER_CERT_PATH=/certs/client \
	--env DOCKER_TLS_VERIFY=1 \
	--publish 8080:8080 \
	--publish 50000:50000 \
	--volume jenkins-data:/var/jenkins_home \
	--volume jenkins-docker-certs:/certs/client:ro \
	jenkins:4.414.1-1