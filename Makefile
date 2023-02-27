.PHONY: build clean
build:
	docker build -t trunk-builder .
clean:
	docker rmi trunk-builder
