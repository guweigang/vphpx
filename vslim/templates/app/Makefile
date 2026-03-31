PHP ?= php
EXT ?= ./vslim.so
HOST ?= 127.0.0.1
PORT ?= 8080

.PHONY: help serve cli cli-help health home module

help:
	@printf '%s\n' \
		'Template targets:' \
		'  make serve     Start the HTTP entry with PHP built-in server' \
		'  make cli       Run the sample CLI command' \
		'  make cli-help  Show CLI command help' \
		'  make health    Run the health endpoint through the public entry' \
		'  make home      Render the home page through the public entry' \
		'  make module    Run the sample module endpoint through the public entry'

serve:
	$(PHP) -d extension=$(EXT) -S $(HOST):$(PORT) public/index.php

cli:
	$(PHP) -d extension=$(EXT) bin/vslim about services cache

cli-help:
	$(PHP) -d extension=$(EXT) bin/vslim about --help

health:
	REQUEST_METHOD=GET REQUEST_URI=/health HTTP_HOST=$(HOST):$(PORT) \
		$(PHP) -d extension=$(EXT) public/index.php

home:
	REQUEST_METHOD=GET REQUEST_URI=/ HTTP_HOST=$(HOST):$(PORT) HTTP_X_TRACE_ID=make-home \
		$(PHP) -d extension=$(EXT) public/index.php

module:
	REQUEST_METHOD=GET REQUEST_URI=/module/ping HTTP_HOST=$(HOST):$(PORT) \
		$(PHP) -d extension=$(EXT) public/index.php
