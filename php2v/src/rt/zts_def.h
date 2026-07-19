#ifndef PHP2V_RT_ZTS_DEF_H
#define PHP2V_RT_ZTS_DEF_H

#include <sapi/embed/php_embed.h>
#include <Zend/zend_exceptions.h>

#ifdef __APPLE__
#include <crt_externs.h>
#endif

#ifdef ZTS
__attribute__((visibility("default"))) extern __thread void *TSRMLS_CACHE;
#endif

static inline void php2v_update_tsrm_cache() {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
}

static inline void php2v_check_and_clear_exception() {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
	if (EG(exception)) {
		zend_object *ex = EG(exception);
		printf("PHP EXCEPTION TRIGGERED: %s\n", ex->ce->name->val);
		zval rv, rv_file, rv_line;
		zval *msg = zend_read_property(ex->ce, ex, "message", sizeof("message") - 1, 1, &rv);
		if (msg && Z_TYPE_P(msg) == IS_STRING) {
			printf("PHP EXCEPTION MESSAGE: %s\n", Z_STRVAL_P(msg));
		}
		if (EG(current_execute_data) && EG(current_execute_data)->func) {
			zend_op_array *op_array = &EG(current_execute_data)->func->op_array;
			if (op_array->filename) {
				const zend_op *opline = EG(current_execute_data)->opline;
				uint32_t lineno = opline ? opline->lineno : 0;
				printf("PHP EXCEPTION LOCATION FROM VM EXECUTE: %s on line %u\n", ZSTR_VAL(op_array->filename), lineno);
			}
		}
		zend_clear_exception();
	}
}

static inline void php2v_refresh_request() {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
	if (EG(exception)) {
		zend_clear_exception();
	}
	// 完整的 PHP 请求生命周期重置：清空 class 表、函数表、全局变量等
	// 使常驻模式下每次请求都有干净的引擎状态
	php_request_shutdown(NULL);
	php_request_startup();
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
}

static inline void php2v_register_thread() {
#ifdef ZTS
	ts_resource(0);
	ZEND_TSRMLS_CACHE_UPDATE();
	static __thread int request_started = 0;
	if (!request_started) {
		if (EG(vm_stack) == NULL) {
			zend_vm_stack_init();
		}
		php_request_startup();
		request_started = 1;
		ZEND_TSRMLS_CACHE_UPDATE();
	}
#endif
}

static inline void php2v_register_sandbox_bridge();

__attribute__((constructor)) static void php2v_auto_embed_init() {
	setenv("USE_ZEND_ALLOC", "0", 1);
	php_embed_module.php_ini_ignore = 1;
	php_embed_module.php_ini_path_override = "/dev/null";
	php_embed_module.deactivate = NULL;
	php_embed_module.flush = NULL;
#ifdef __APPLE__
	int argc = *_NSGetArgc();
	char **argv = *_NSGetArgv();
	php_embed_init(argc, argv);
#else
	char *argv[] = { "php2v", NULL };
	php_embed_init(1, argv);
#endif
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
	php2v_register_sandbox_bridge();
}

#endif
