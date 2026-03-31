PHP ?= php
ROOT ?= $(CURDIR)
EXT ?= ./vslim.so
HOST ?= 127.0.0.1
PORT ?= 8080
VHTTPD_ROOT ?= $(abspath $(ROOT)/../../../vhttpd)
VHTTPD_BIN ?= $(VHTTPD_ROOT)/vhttpd
VHTTPD_HOST ?= $(HOST)
VHTTPD_PORT ?= 19888
VHTTPD_ADMIN_PORT ?= 19988
VHTTPD_PID_FILE ?= /tmp/vslim_template_vhttpd.pid
VHTTPD_EVENT_LOG ?= /tmp/vslim_template_vhttpd.events.ndjson
VHTTPD_SOCKET ?= /tmp/vslim_template_worker.sock
WORKER_APP ?= $(ROOT)/public/worker.php
WORKER_CMD = $(PHP) -d extension=$(EXT) $(VHTTPD_ROOT)/php/package/bin/php-worker

.PHONY: help serve vhttpd cli cli-help health home module

help:
	@printf '%s\n' \
		'Template targets:' \
		'  make serve     Start the HTTP entry with PHP built-in server' \
		'  make vhttpd    Start the same app through vhttpd + php-worker' \
		'  make cli       Run the sample CLI command' \
		'  make cli-help  Show CLI command help' \
		'  make health    Run the health endpoint through the public entry' \
		'  make home      Render the home page through the public entry' \
		'  make module    Run the sample module endpoint through the public entry'

serve:
	$(PHP) -d extension=$(EXT) -S $(HOST):$(PORT) public/index.php

vhttpd:
	VHTTPD_APP=$(WORKER_APP) $(VHTTPD_BIN) \
		--host $(VHTTPD_HOST) \
		--port $(VHTTPD_PORT) \
		--pid-file $(VHTTPD_PID_FILE) \
		--event-log $(VHTTPD_EVENT_LOG) \
		--admin-host $(VHTTPD_HOST) \
		--admin-port $(VHTTPD_ADMIN_PORT) \
		--worker-socket $(VHTTPD_SOCKET) \
		--worker-autostart 1 \
		--worker-cmd '$(WORKER_CMD)'

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
