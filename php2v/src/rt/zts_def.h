#ifndef PHP2V_RT_ZTS_DEF_H
#define PHP2V_RT_ZTS_DEF_H

#include <sapi/embed/php_embed.h>
#include <Zend/zend_exceptions.h>

#ifdef __APPLE__
#include <crt_externs.h>
#endif

static inline void php2v_register_custom_functions();

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
}

static inline void php2v_run_in_thread_context(void (*entry_fn)(void)) {
#ifdef ZTS
	ts_resource(0);
	ZEND_TSRMLS_CACHE_UPDATE();
	if (EG(vm_stack) == NULL) {
		zend_vm_stack_init();
	}
	php_request_startup();
	ZEND_TSRMLS_CACHE_UPDATE();
	php2v_register_custom_functions();
#endif
	zend_try {
		if (entry_fn) {
			entry_fn();
		}
	} zend_catch {
		// 被 zend_bailout 捕获，安全处理 exit/wp_die 等
	} zend_end_try();
	php_output_end_all();
	php_output_flush_all();
}

static inline void php2v_shutdown_request() {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
	php_request_shutdown(NULL);
#endif
}

static inline void php2v_register_sandbox_bridge();

typedef struct {
	char *buf;
	size_t cap;
	size_t len;
} php2v_req_buf;

#ifdef _MSC_VER
static __declspec(thread) void* php2v_current_ctx = NULL;
#else
static __thread void* php2v_current_ctx = NULL;
#endif

static inline size_t php2v_ub_write(const char *str, size_t str_length) {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
	if (php2v_current_ctx && str && str_length > 0) {
		php2v_req_buf *b = (php2v_req_buf *)php2v_current_ctx;
		if (b->len + str_length >= b->cap) {
			size_t new_cap = (b->cap == 0) ? 4096 : (b->cap * 2 + str_length);
			char *new_buf = (char *)realloc(b->buf, new_cap);
			if (new_buf) {
				b->buf = new_buf;
				b->cap = new_cap;
			}
		}
		if (b->buf) {
			memcpy(b->buf + b->len, str, str_length);
			b->len += str_length;
			b->buf[b->len] = '\0';
		}
	}
	return str_length;
}

__attribute__((constructor)) static void php2v_auto_embed_init() {
	setenv("USE_ZEND_ALLOC", "0", 1);
	php_embed_module.php_ini_ignore = 1;
	php_embed_module.php_ini_path_override = "/dev/null";
	php_embed_module.deactivate = NULL;
	php_embed_module.flush = NULL;
	php_embed_module.ub_write = php2v_ub_write;
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
	zend_string *k1 = zend_string_init("opcache.enable", sizeof("opcache.enable") - 1, 0);
	zend_alter_ini_entry_chars(k1, "0", sizeof("0") - 1, PHP_INI_SYSTEM, PHP_INI_STAGE_RUNTIME);
	zend_string_release(k1);

	zend_string *k2 = zend_string_init("opcache.enable_cli", sizeof("opcache.enable_cli") - 1, 0);
	zend_alter_ini_entry_chars(k2, "0", sizeof("0") - 1, PHP_INI_SYSTEM, PHP_INI_STAGE_RUNTIME);
	zend_string_release(k2);

	php2v_register_sandbox_bridge();
}

#endif
