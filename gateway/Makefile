.PHONY: build test serve

build:
	v run build.v

test:
	v run build.v test

serve: build
	./gateway examples/gateway.yaml
