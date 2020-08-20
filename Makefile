VERSION = $(IMAGE_VERSION)-haproxy-$(HAPROXY_VERSION)
IMAGE = $(NAMESPACE)/haproxy-docker-logging

all: generate build export

.PHONY: generate build export clean

generate:
	test -n "$(HAPROXY_VERSION)" # $$HAPROXY_VERSION is not defined
	
	echo Updating Dockerfile with haproxy version $${HAPROXY_VERSION}
	sed 's/HAPROXY_VERSION/$(HAPROXY_VERSION)/' Dockerfile.tpl > Dockerfile

build:
	test -n "$(IMAGE_VERSION)" # $$IMAGE_VERSION is not defined
	test -n "$(REGISTRY)" # $$REGISTRY is not defined
	test -n "$(NAMESPACE)" # $$NAMESPACE is not defined

	docker build -t $(IMAGE) -f Dockerfile .
	docker tag $(IMAGE) $(IMAGE):$(VERSION)
	docker tag $(IMAGE) $(REGISTRY)/$(IMAGE):$(VERSION)

export:
	docker push $(REGISTRY)/$(IMAGE):$(VERSION)

clean:
	docker rmi $(IMAGE)
	docker rmi $(IMAGE)-$(VERSION)
	docker rmi $(REGISTRY)/$(IMAGE):$(VERSION)

