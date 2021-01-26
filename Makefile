IMAGE_NAME   := $(shell basename $(CURDIR))
DOCKER_REPO  := atrakic
TAG   	     := 0.0.1

.PHONY: docker/local
docker/local:
	DOCKER_BUILDKIT=1 docker build --no-cache \
		--build-arg IMAGE_TITLE=$(IMAGE_NAME) \
		--build-arg IMAGE_CREATE_DATE=$$(date +%Y%m%d%H%M%S) \
		--build-arg IMAGE_AUTHOR="Admir Trakic" \
		--build-arg=$$(git rev-parse --abbrev-ref HEAD) \
		-t $(IMAGE_NAME):latest \
		.

.PHONY: docker-tag
docker-tag: ## Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
	docker tag $(IMAGE_NAME):latest $(DOCKER_REPO)/$(IMAGE_NAME):$(TAG)

.PHONY: docker-publish
docker-publish: docker-tag ## Publish the image and tags to a repository.
	docker push $(DOCKER_REPO)/$(IMAGE_NAME):$(TAG)

kind:
	kind create cluster #--config kind-example-config.yaml
