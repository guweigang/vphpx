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

.PHONY: help serve vhttpd smoke-vhttpd cli cli-help health home module

help:
	@printf '%s\n' \
		'Template targets:' \
		'  make serve     Start the HTTP entry with PHP built-in server' \
		'  make vhttpd    Start the same app through vhttpd + php-worker' \
		'  make smoke-vhttpd  Boot vhttpd, probe the template app, then stop it' \
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

smoke-vhttpd:
	@set -eu; \
	if [ ! -x "$(VHTTPD_BIN)" ]; then \
		echo "vhttpd binary not found: $(VHTTPD_BIN)"; \
		exit 1; \
	fi; \
	tmp_dir="$$(mktemp -d /tmp/vslim-template-smoke.XXXXXX)"; \
	pid_file="$$tmp_dir/vhttpd.pid"; \
	event_log="$$tmp_dir/events.ndjson"; \
	stdout_log="$$tmp_dir/stdout.log"; \
	socket="$$tmp_dir/worker.sock"; \
	cleanup() { \
		if [ -f "$$pid_file" ]; then \
			pid="$$(cat "$$pid_file" 2>/dev/null || true)"; \
			if [ -n "$$pid" ]; then \
				kill "$$pid" >/dev/null 2>&1 || true; \
				sleep 1; \
			fi; \
		fi; \
		rm -rf "$$tmp_dir"; \
	}; \
	trap cleanup EXIT INT TERM; \
	echo "[smoke-vhttpd] booting template app via vhttpd on $(VHTTPD_HOST):$(VHTTPD_PORT)"; \
	VHTTPD_APP="$(WORKER_APP)" "$(VHTTPD_BIN)" \
		--host "$(VHTTPD_HOST)" \
		--port "$(VHTTPD_PORT)" \
		--pid-file "$$pid_file" \
		--event-log "$$event_log" \
		--admin-host "$(VHTTPD_HOST)" \
		--admin-port "$(VHTTPD_ADMIN_PORT)" \
		--worker-socket "$$socket" \
		--worker-autostart 1 \
		--worker-cmd '$(WORKER_CMD)' \
		>> "$$stdout_log" 2>&1 & \
	for attempt in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do \
		if curl --noproxy '*' -fsS "http://$(VHTTPD_HOST):$(VHTTPD_PORT)/health" >/dev/null 2>&1; then \
			break; \
		fi; \
		sleep 0.2; \
	done; \
	health_body="$$(curl --noproxy '*' -fsS "http://$(VHTTPD_HOST):$(VHTTPD_PORT)/health")"; \
	module_body="$$(curl --noproxy '*' -fsS "http://$(VHTTPD_HOST):$(VHTTPD_PORT)/module/ping")"; \
	missing_status="$$(curl --noproxy '*' -s -o "$$tmp_dir/missing.out" -w '%{http_code}' "http://$(VHTTPD_HOST):$(VHTTPD_PORT)/missing")"; \
	missing_body="$$(cat "$$tmp_dir/missing.out")"; \
	printf '%s\n' "[smoke-vhttpd] /health => $$health_body"; \
	printf '%s\n' "[smoke-vhttpd] /module/ping => $$module_body"; \
	printf '%s\n' "[smoke-vhttpd] /missing => $$missing_status $$missing_body"; \
	test "$$health_body" = 'ok|vslim-template|provider-ready' || exit 1; \
	test "$$module_body" = 'module|module-ready|yes' || exit 1; \
	test "$$missing_status" = '404' || exit 1; \
	test "$$missing_body" = '{"ok":false,"error":"template-not-found","path":"\/missing"}' || exit 1

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
