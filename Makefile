
IMAGE ?= rpkatz/nginx-ajp-module
TAG ?= latest

# build with buildx
PLATFORMS?=linux/amd64,linux/arm,linux/arm64,linux/s390x
PROGRESS=plain

export DOCKER_CLI_EXPERIMENTAL=enabled

build: ensure-buildx
	docker buildx build \
	--platform=${PLATFORMS} $(OUTPUT) \
	--progress=$(PROGRESS) \
	--pull \
	--tag $(IMAGE):$(TAG) .

# push the cross built image
push: OUTPUT=--push
push: build

# enable buildx
ensure-buildx:
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker buildx rm ingress-nginx || true
	docker buildx create --use --name=ingress-nginx

.PHONY: build push ensure-buildx
