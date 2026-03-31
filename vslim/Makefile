.PHONY: all build emit-only prod build-prod ext dist dist-source vhttpd serve test psr-matrix framework-matrix demo-self-test demo-verify mvp-check runtime-check clean

BREW_PATH ?= /opt/homebrew
VPHP_V_GC ?= auto
VPHP_V_GC_STRIPPED := $(strip $(VPHP_V_GC))
RESOLVED_VPHP_V_GC := $(shell if [ -n "$(VPHP_V_GC_STRIPPED)" ] && [ "$(VPHP_V_GC_STRIPPED)" != "auto" ]; then printf "%s" "$(VPHP_V_GC_STRIPPED)"; elif pkg-config --exists bdw-gc 2>/dev/null; then printf boehm; else printf none; fi)
DISABLED_WARNINGS := -Wno-pointer-to-int-cast -Wno-incompatible-pointer-types -Wno-initializer-overrides -Wno-unused-value
PHP_INC := $(shell php-config --includes)
PHP_LDFLAGS := $(shell php-config --ldflags | awk '{for (i = 1; i <= NF; i++) { t = $$i; if (substr(t,1,2) == "-L") { p = substr(t,3); cmd = "test -d \"" p "\""; if (system(cmd) != 0) continue; } printf "%s ", t; }}')
PHP_LIBS := $(shell php-config --libs | sed 's/-lzip//g')
V_EXE := $(shell command -v v 2>/dev/null)
V_ROOT := $(if $(V_EXE),$(shell dirname "$(shell realpath "$(V_EXE)")"))
V_ZIP_INCLUDE := $(if $(V_ROOT),$(V_ROOT)/thirdparty/zip)
V_ROOT_CFLAGS := $(if $(wildcard $(V_ZIP_INCLUDE)),-I$(V_ZIP_INCLUDE),)
EXT_C := $(firstword $(wildcard *_generated.c))
GC_CFLAGS :=
GC_LIBS :=
ifeq ($(RESOLVED_VPHP_V_GC),boehm)
GC_CFLAGS := $(shell pkg-config --cflags bdw-gc)
GC_LIBS := $(shell pkg-config --libs bdw-gc)
endif
UNAME_S := $(shell uname -s)
PLATFORM_LDFLAGS :=
ifeq ($(UNAME_S),Darwin)
PLATFORM_LDFLAGS += -undefined dynamic_lookup
endif
ROOT := $(CURDIR)
ARTIFACT_VERSION ?= $(shell git -C $(ROOT)/.. describe --tags --always --dirty)
ARTIFACT_PLATFORM ?= $(shell php -r '$$os = strtolower(PHP_OS_FAMILY); if ($$os === "darwin") $$os = "macos"; $$arch = strtolower(php_uname("m")); if (in_array($$arch, ["amd64", "x64", "x86_64"], true)) $$arch = "x86_64"; if (in_array($$arch, ["aarch64", "arm64"], true)) $$arch = "arm64"; echo $$os . "-" . $$arch;')
PACKAGE_FORMAT ?= zip
VHTTPD_ROOT ?= $(abspath $(ROOT)/../../vhttpd)
SRC_DIR := $(VHTTPD_ROOT)/src
VHTTPD_BIN := $(VHTTPD_ROOT)/vhttpd
VHTTPD_PORT ?= 19881
VHTTPD_HOST ?= 127.0.0.1
VHTTPD_PID_FILE ?= /tmp/vslim_vhttpd.pid
VHTTPD_EVENT_LOG ?= /tmp/vslim_vhttpd.events.ndjson
VSLIM_DEMO_BASE_URL ?= http://127.0.0.1:19888
VSLIM_WORKER_SOCKET ?= /tmp/vslim_worker.sock
VSLIM_WORKER_CMD := php -d extension=$(ROOT)/vslim.so $(VHTTPD_ROOT)/php/package/bin/php-worker --socket $(VSLIM_WORKER_SOCKET)
MVP_TESTS := \
	tests/test_vslim_request_trace_ids.phpt \
	tests/test_vslim_dispatch_envelope_map_headers.phpt \
	tests/test_vslim_worker_envelope_map.phpt \
	tests/test_vslim_mvc_view_controller.phpt \
	tests/test_vslim_resource_routes.phpt \
	tests/test_vslim_resource_opts.phpt \
	tests/test_vslim_error_response_json.phpt \
	tests/test_vslim_mcp_namespace_components.phpt

RUNTIME_EXTRA_TESTS := \
	tests/*worker*.phpt \
	tests/test_php_worker_stream_dispatch_helpers.phpt \
	tests/test_php_worker_stream_dispatch_json_maps.phpt \
	tests/test_php_worker_mcp_dispatch.phpt

RUNTIME_VHTTPD_TESTS := \
	tests/test_vslim_app_template_vhttpd_smoke.phpt \
	tests/test_httpd_toml_worker_env.phpt \
	tests/test_httpd_worker_streaming.phpt \
	tests/test_httpd_worker_timeout.phpt

all: build

build:
	VPHP_V_GC="$(VPHP_V_GC)" v -path ".:..:@vlib" run build.v

emit-only:
	VPHP_V_GC="$(VPHP_V_GC)" v -path ".:..:@vlib" run build.v -emit-only

prod:
	VPHP_V_GC="$(VPHP_V_GC)" v -path ".:..:@vlib" run build.v -prod

build-prod: prod

dist: build
	php $(ROOT)/scripts/package_release.php \
		--version="$(ARTIFACT_VERSION)" \
		--platform="$(ARTIFACT_PLATFORM)" \
		--package-type=binary \
		--format="$(PACKAGE_FORMAT)" \
		--ext-path="$(ROOT)/vslim.so"

dist-source:
	php $(ROOT)/scripts/package_release.php \
		--version="$(ARTIFACT_VERSION)" \
		--platform="$(ARTIFACT_PLATFORM)" \
		--package-type=source \
		--format="$(PACKAGE_FORMAT)"

ext:
	@if [ -z "$(EXT_C)" ]; then \
		echo "Error: no transpiled extension C file found (expected *_generated.c)."; \
		exit 1; \
	fi
	C_INCLUDE_PATH="$(BREW_PATH)/include/cjson" \
	gcc -shared -fPIC $(DISABLED_WARNINGS) -DCOMPILE_DL_VSLIM=1 \
		$(GC_CFLAGS) $(V_ROOT_CFLAGS) -I$(BREW_PATH)/include -L$(BREW_PATH)/lib -lcjson \
		-DcJSON_GetErrorPos=cJSON_GetErrorPtr \
		$(PHP_INC) $(EXT_C) php_bridge.c ../vphp/v_bridge.c -o vslim.so \
		-I../vphp $(PHP_LDFLAGS) $(PHP_LIBS) $(GC_LIBS) $(PLATFORM_LDFLAGS) -fvisibility=default

vhttpd:
	@$(MAKE) -C $(VHTTPD_ROOT) build VHTTPD_BIN="$(VHTTPD_BIN)" VPHP_V_GC="$(VPHP_V_GC)"

serve: build vhttpd
	$(VHTTPD_BIN) \
		--host $(VHTTPD_HOST) \
		--port $(VHTTPD_PORT) \
		--pid-file $(VHTTPD_PID_FILE) \
		--event-log $(VHTTPD_EVENT_LOG) \
		--worker-socket $(VSLIM_WORKER_SOCKET) \
		--worker-autostart 1 \
		--worker-cmd '$(VSLIM_WORKER_CMD)'

# Default test target stays fast on purpose. Heavy httpd/vhttpd/worker
# integration PHPTs are split out into `make runtime-check`.
test: build
	@./run_tests.sh

psr-matrix:
	@./tests/run_psr_matrix.sh

framework-matrix:
	@./tests/run_framework_matrix.sh

demo-self-test: build
	php -d extension=$(ROOT)/vslim.so $(ROOT)/examples/demo_app.php --self-test

demo-verify:
	BASE_URL=$(VSLIM_DEMO_BASE_URL) $(ROOT)/examples/verify_demo.sh

mvp-check: build
	@echo "[mvp-check] demo self-test"
	@php -d extension=$(ROOT)/vslim.so $(ROOT)/examples/demo_app.php --self-test
	@echo "[mvp-check] phpt core set"
	@TEST_PHP_EXECUTABLE="$$(which php)" php ../vphptest/run-tests.php -q --show-all -d extension=./vslim.so $(MVP_TESTS)

runtime-check: build vhttpd
	@echo "[runtime-check] phpt runtime regression set"
	@./run_tests.sh $(RUNTIME_VHTTPD_TESTS) $(RUNTIME_EXTRA_TESTS)

clean:
	rm -f vslim.so $(VHTTPD_BIN)
	rm -f *_generated.c
	rm -rf dist
