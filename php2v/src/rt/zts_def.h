#ifndef PHP2V_RT_ZTS_DEF_H
#define PHP2V_RT_ZTS_DEF_H

#include <php.h>
#include <sapi/embed/php_embed.h>
#include <Zend/zend_exceptions.h>

#ifdef __APPLE__
#include <crt_externs.h>
#endif

extern void php2v_register_sandbox_bridge();
extern void php2v_inject_http_globals(zval *get, zval *post, zval *cookie, zval *server, zval *files);

typedef struct {
	char *buf;
	size_t cap;
	size_t len;
	zval *get;
	zval *post;
	zval *cookie;
	zval *server;
	zval *files;
} php2v_req_buf;

#ifdef _MSC_VER
static __declspec(thread) void* php2v_current_ctx = NULL;
#else
static __thread void* php2v_current_ctx = NULL;
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
	php2v_register_sandbox_bridge();
	php2v_req_buf *b = (php2v_req_buf *)php2v_current_ctx;
	if (b && b->server) {
		php2v_inject_http_globals(b->get, b->post, b->cookie, b->server, b->files);
	}
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

static int (*orig_sapi_startup)(sapi_module_struct *sapi_module) = NULL;

static int php2v_sapi_startup(sapi_module_struct *sapi_module) {
	if (orig_sapi_startup && orig_sapi_startup(sapi_module) == FAILURE) {
		return FAILURE;
	}
	extern void php2v_register_mysqli_classes();
	php2v_register_mysqli_classes();
	return SUCCESS;
}

#include <sys/mman.h>
#include <unistd.h>

__attribute__((constructor)) static void php2v_auto_embed_init() {
	setenv("USE_ZEND_ALLOC", "0", 1);
	setenv("PHPRC", "/nonexistent", 1);
	setenv("PHP_INI_SCAN_DIR", "", 1);

	long page_size = sysconf(_SC_PAGESIZE);
	void *addr = (void *)((uintptr_t)&php_embed_module & ~(page_size - 1));
	mprotect(addr, page_size, PROT_READ | PROT_WRITE);

	php_embed_module.php_ini_ignore = 0;
	php_embed_module.php_ini_path_override = "/dev/null";
	php_embed_module.deactivate = NULL;
	php_embed_module.flush = NULL;
	php_embed_module.ub_write = php2v_ub_write;
	
	orig_sapi_startup = php_embed_module.startup;
	php_embed_module.startup = php2v_sapi_startup;

	mprotect(addr, page_size, PROT_READ);

	char *embed_argv[] = { "wordpress_server", "-d", "opcache.enable=0", "-d", "opcache.enable_cli=0", NULL };
	php_embed_init(5, embed_argv);
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
	extern zend_op_array *compile_file(zend_file_handle *file_handle, int type);
	zend_compile_file = compile_file;
	zend_string *k1 = zend_string_init("opcache.enable", sizeof("opcache.enable") - 1, 0);
	zend_alter_ini_entry_chars(k1, "0", sizeof("0") - 1, PHP_INI_SYSTEM, PHP_INI_STAGE_RUNTIME);
	zend_string_release(k1);

	zend_string *k2 = zend_string_init("opcache.enable_cli", sizeof("opcache.enable_cli") - 1, 0);
	zend_alter_ini_entry_chars(k2, "0", sizeof("0") - 1, PHP_INI_SYSTEM, PHP_INI_STAGE_RUNTIME);
	zend_string_release(k2);

	php2v_register_sandbox_bridge();
}

#endif
