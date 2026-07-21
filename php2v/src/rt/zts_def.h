#ifndef PHP2V_RT_ZTS_DEF_H
#define PHP2V_RT_ZTS_DEF_H

#include <php.h>
#include <sapi/embed/php_embed.h>
#include <Zend/zend_exceptions.h>
#include <Zend/zend_gc.h>

#ifdef __APPLE__
#include <crt_externs.h>
#endif

extern void php2v_register_sandbox_bridge();
extern void php2v_inject_http_globals(const char *get, const char *post, const char *cookie, const char *server, const char *files);

typedef struct {
	char *buf;
	size_t cap;
	size_t len;
	const char *get_str;
	const char *post_str;
	const char *cookie_str;
	const char *server_str;
	const char *files_str;
	const char *script_path;
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

#include <setjmp.h>
#include <pthread.h>
static __thread jmp_buf php2v_exit_jmp_buf;
static pthread_mutex_t php2v_exec_mutex = PTHREAD_MUTEX_INITIALIZER;
static inline int php2v_execute_file(const char* filepath);

static inline void php2v_run_in_thread_context(void (*entry_fn)(void)) {
	pthread_mutex_lock(&php2v_exec_mutex);
#ifdef ZTS
	ts_resource(0);
	ZEND_TSRMLS_CACHE_UPDATE();
	if (EG(vm_stack) == NULL) {
		zend_vm_stack_init();
	}
	php_request_startup();
	ZEND_TSRMLS_CACHE_UPDATE();
	gc_enable(0);
	gc_protect(1);
	php2v_register_sandbox_bridge();
	php2v_req_buf *b = (php2v_req_buf *)php2v_current_ctx;
	if (b) {
		php2v_inject_http_globals(b->get_str, b->post_str, b->cookie_str, b->server_str, b->files_str);
	}
	/* 开启大容量 4MB 输出缓冲，防止长页面（如 100KB+ 首页 HTML）在执行期间中途分段刷盘导致 OG(flags) TSRM 空指针 */
	php_output_start_user(NULL, 4194304, PHP_OUTPUT_HANDLER_STDFLAGS);
#endif
	if (setjmp(php2v_exit_jmp_buf) == 0) {
		zend_first_try {
			php2v_req_buf *b = (php2v_req_buf *)php2v_current_ctx;
			if (b && b->script_path && strlen(b->script_path) > 0) {
				php2v_execute_file(b->script_path);
			} else if (entry_fn) {
				entry_fn();
			}
		} zend_catch {
			// 捕获动态文件的 zend_bailout
		} zend_end_try();
	} else {
		// 安全捕获到了静态转译代码里 php2v_exit() 发出的自定义 longjmp ！！！
		printf("SUCCESSFULLY CAUGHT CUSTOM LONGJMP EXIT IN THREAD CONTEXT !!!\n");
	}
	php_call_shutdown_functions();
	php_output_flush_all();
	php_output_end_all();
#ifdef ZTS
	php_request_shutdown(NULL);
#endif
	pthread_mutex_unlock(&php2v_exec_mutex);
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

static inline void php2v_append_output(const char *str, size_t str_length) {
	php2v_ub_write(str, str_length);
}

static void php2v_register_server_variables(zval *track_vars_array) {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
	/* 当 Zend 引擎的 auto_global 惰性加载机制触发 $_SERVER 初始化时，
	   此回调被调用。我们从 TLS php2v_current_ctx 中读取序列化的 SERVER 数据，
	   解析后写入 track_vars_array，防止 embed SAPI 默认产生的空 $_SERVER 覆盖注入内容 */
	if (!php2v_current_ctx) return;
	php2v_req_buf *b = (php2v_req_buf *)php2v_current_ctx;
	if (!b->server_str || strlen(b->server_str) == 0) return;
	
	char *dup = strdup(b->server_str);
	char *p = dup;
	while (*p) {
		char *key = p;
		char *sep2 = strchr(p, '\x02');
		if (!sep2) break;
		*sep2 = '\0';
		char *val = sep2 + 1;
		
		char *sep1 = strchr(val, '\x01');
		if (sep1) {
			*sep1 = '\0';
			p = sep1 + 1;
		} else {
			p = val + strlen(val);
		}
		
		php_register_variable(key, val, track_vars_array);
	}
	free(dup);
}

__attribute__((constructor)) static void php2v_auto_embed_init() {
	setenv("PHPRC", "/nonexistent", 1);
	setenv("PHP_INI_SCAN_DIR", "", 1);
	php_embed_module.php_ini_ignore = 1;
	php_embed_module.php_ini_path_override = "/dev/null";
	php_embed_module.deactivate = NULL;
	php_embed_module.flush = NULL;
	php_embed_module.ub_write = php2v_ub_write;
	php_embed_module.register_server_variables = php2v_register_server_variables;
	
	char *embed_argv[] = { "wordpress_server", "-d", "opcache.enable=0", "-d", "opcache.enable_cli=0", "-d", "zend.enable_gc=0", "-d", "output_buffering=4194304", NULL };
	php_embed_init(9, embed_argv);
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

	zend_string *k3 = zend_string_init("zend.enable_gc", sizeof("zend.enable_gc") - 1, 0);
	zend_alter_ini_entry_chars(k3, "0", sizeof("0") - 1, PHP_INI_SYSTEM, PHP_INI_STAGE_RUNTIME);
	zend_string_release(k3);

	php2v_register_sandbox_bridge();
}

#endif
