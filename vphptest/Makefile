.PHONY: all build ext test clean

BREW_PATH ?= /opt/homebrew
VPHP_V_GC ?= auto
VPHP_V_GC_STRIPPED := $(strip $(VPHP_V_GC))
RESOLVED_VPHP_V_GC := $(shell if [ -n "$(VPHP_V_GC_STRIPPED)" ] && [ "$(VPHP_V_GC_STRIPPED)" != "auto" ]; then printf "%s" "$(VPHP_V_GC_STRIPPED)"; elif pkg-config --exists bdw-gc 2>/dev/null; then printf boehm; else printf none; fi)
DISABLED_WARNINGS := -Wno-pointer-to-int-cast -Wno-incompatible-pointer-types -Wno-initializer-overrides
PHP_INC := $(shell php-config --includes)
PHP_LDFLAGS := $(shell php-config --ldflags)
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

# 默认目标：构建扩展
all: build

# 完整构建：先跑 vphp compiler，再链接扩展
build:
	VPHP_V_GC="$(VPHP_V_GC)" v -path ".:..:@vlib" run build.v

# 仅使用仓库中已有的生成物链接扩展
ext:
	@if [ -z "$(EXT_C)" ]; then \
		echo "Error: no transpiled extension C file found (expected *_generated.c)."; \
		exit 1; \
	fi
	C_INCLUDE_PATH="$(BREW_PATH)/include/cjson" \
	gcc -shared -fPIC $(DISABLED_WARNINGS) -DCOMPILE_DL_VPHPTEST=1 \
		$(GC_CFLAGS) $(V_ROOT_CFLAGS) -I$(BREW_PATH)/include -L$(BREW_PATH)/lib -lcjson \
		-DcJSON_GetErrorPos=cJSON_GetErrorPtr \
		$(PHP_INC) $(EXT_C) php_bridge.c ../vphp/v_bridge.c -o vphptest.so \
		-I../vphp $(PHP_LDFLAGS) $(PHP_LIBS) $(GC_LIBS) $(PLATFORM_LDFLAGS) -fvisibility=default

# 运行测试
test: build
	@./run_tests.sh

# 清理所有生成产物
clean:
	rm -f vphptest.so
	rm -f *_generated.c
