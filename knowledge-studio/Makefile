PHP ?= php
ROOT ?= $(CURDIR)
EXT ?= ../vslim/vslim.so
HOST ?= 127.0.0.1
PORT ?= 8094

.PHONY: help serve cli cli-help health login console

help:
	@printf '%s\n' \
		'Knowledge Studio targets:' \
		'  make serve     Start the HTTP entry with PHP built-in server' \
		'  make cli       Run the sample CLI command' \
		'  make cli-help  Show CLI help' \
		'  make health    Probe the health endpoint' \
		'  make login     Render the login page through the public entry' \
		'  make console   Render the console page through the public entry'

serve:
	$(PHP) -d extension=$(EXT) -S $(HOST):$(PORT) public/index.php

cli:
	$(PHP) -d extension=$(EXT) bin/vslim studio:about

cli-help:
	$(PHP) -d extension=$(EXT) bin/vslim studio:about --help

health:
	REQUEST_METHOD=GET REQUEST_URI=/health HTTP_HOST=$(HOST):$(PORT) \
		$(PHP) -d extension=$(EXT) public/index.php

login:
	REQUEST_METHOD=GET REQUEST_URI=/login HTTP_HOST=$(HOST):$(PORT) \
		$(PHP) -d extension=$(EXT) public/index.php

console:
	REQUEST_METHOD=GET REQUEST_URI=/console HTTP_HOST=$(HOST):$(PORT) \
		$(PHP) -d extension=$(EXT) public/index.php
