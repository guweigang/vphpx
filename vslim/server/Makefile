.PHONY: build test serve app

build:
	v run build.v

test:
	v run build.v test

serve: build
	./vslim-server examples/vslim.yaml

app:
	v run build.v app
