generate:
	test -n "$(VERSION)" # $$VERSION is not defined
	echo Updating Dockerfile with haproxy version $${VERSION}
	sed 's/HAPROXY_VERSION/$(VERSION)/' Dockerfile.tpl > Dockerfile
build:
	test -n "$(VERSION)" # $$VERSION is not defined
	echo Building to version $${VERSION}
	docker build -t $${REGISTRY_PATH}:$${VERSION} .

push:
	test -n "$(REGISTRY_PATH)" # $$REGISTRY_PATH is not defined
	docker push $${REGISTRY_PATH}

all: generate build push
