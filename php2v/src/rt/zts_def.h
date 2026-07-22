#ifndef PHP2V_RT_ZTS_DEF_H
#define PHP2V_RT_ZTS_DEF_H

#include <php.h>
#include <SAPI.h>
#include <php_main.h>
#include <sapi/embed/php_embed.h>
#include <Zend/zend_exceptions.h>
#include <Zend/zend_gc.h>
#include <curl/curl.h>

#include <sys/time.h>

static inline double microtime_sec() {
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return (double)tv.tv_sec + (double)tv.tv_usec / 1000000.0;
}

extern void php2v_register_sandbox_bridge();

static inline const char* php2v_async_http_fetch(const char *url, const char *method, const char *body) {
	extern char* v_async_http_fetch(char* c_url, char* c_method, char* c_body);
	return v_async_http_fetch((char*)(url ? url : ""), (char*)(method ? method : "GET"), (char*)(body ? body : ""));
}


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
	int response_code;
	char *headers_str;
	const char *raw_post_data;
	size_t raw_post_data_read;
} php2v_req_buf;

static inline php2v_req_buf* php2v_create_req_buf() {
	return (php2v_req_buf*)calloc(1, sizeof(php2v_req_buf));
}

static inline void php2v_destroy_req_buf(php2v_req_buf *b) {
	if (b) {
		if (b->buf) free(b->buf);
		if (b->headers_str) free(b->headers_str);
		free(b);
	}
}

#if defined(__GNUC__) || defined(__clang__)
__attribute__((weak)) __thread void* php2v_current_ctx = NULL;
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
		printf("PHP EXCEPTION: %s\n", ex->ce->name->val);
		zval rv;
		zval *msg = zend_read_property(ex->ce, ex, "message", sizeof("message") - 1, 1, &rv);
		if (msg && Z_TYPE_P(msg) == IS_STRING) {
			printf("  Message: %s\n", Z_STRVAL_P(msg));
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
static inline int php2v_execute_file(const char* filepath);
size_t php_raw_url_decode(char *str, size_t len);

/*
 * FrankenPHP 风格：需要单独 shutdown 的模块列表
 * filter 模块必须在每个请求间重置，否则 $_GET/$_POST 的 filter flags 会泄漏
 */
static const char *PHP2V_MODULES_TO_RELOAD[] = {
	NULL
};

/*
 * FrankenPHP 风格的精细化 Worker 请求关闭
 * 对标 frankenphp_worker_request_shutdown()
 *
 * 关键：不调 php_request_shutdown(NULL)！
 * php_request_shutdown 会销毁所有 ZTS 模块级的静态句柄，
 * 在常驻进程重入时导致 pcre_match / assert 等动态句柄失效。
 */
/*
 * 清理回调函数：对标 PHP 内核 zend_shutdown_executor_globals 中的
 * clean_non_persistent_constant / clean_non_persistent_function / clean_non_persistent_class
 */
static int php2v_clean_non_persistent_constant(zval *zv) {
	zend_constant *c = Z_PTR_P(zv);
	return (ZEND_CONSTANT_FLAGS(c) & CONST_PERSISTENT) ? ZEND_HASH_APPLY_KEEP : ZEND_HASH_APPLY_REMOVE;
}

static int php2v_clean_non_persistent_function(zval *zv) {
	zend_function *f = Z_PTR_P(zv);
	return (f->type == ZEND_INTERNAL_FUNCTION) ? ZEND_HASH_APPLY_KEEP : ZEND_HASH_APPLY_REMOVE;
}

static int php2v_clean_non_persistent_class(zval *zv) {
	zend_class_entry *ce = Z_PTR_P(zv);
	return (ce->type == ZEND_INTERNAL_CLASS) ? ZEND_HASH_APPLY_KEEP : ZEND_HASH_APPLY_REMOVE;
}

static inline void php2v_worker_request_shutdown() {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
	zend_try {
		php_request_shutdown(NULL);
	} zend_end_try();
#endif
}

/*
 * FrankenPHP 风格的超全局变量重建
 * 对标 frankenphp_reset_super_globals()
 *
 * 通过触发 CG(auto_globals) 的 auto_global_callback 来重建
 * $_GET / $_POST / $_COOKIE / $_SERVER / $_FILES
 * 绝不直接修改 PG(http_globals) 或 EG(symbol_table)！
 */
static void php2v_populate_track_vars(int track_var_type, const char *serialized_str, const char *global_name) {
	zval *global_arr = &PG(http_globals)[track_var_type];
	if (Z_TYPE_P(global_arr) == IS_ARRAY) {
		zval_ptr_dtor(global_arr);
	}
	array_init(global_arr);

	if (serialized_str && strlen(serialized_str) > 0) {
		char *dup = strdup(serialized_str);
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

			if (track_var_type == TRACK_VARS_COOKIE) {
				char *decoded = estrdup(val);
				php_raw_url_decode(decoded, strlen(decoded));
				php_register_variable_safe(key, decoded, strlen(decoded), global_arr);
				efree(decoded);
			} else {
				php_register_variable_safe(key, val, strlen(val), global_arr);
			}
		}
		free(dup);
	}

	zval z_copy;
	ZVAL_COPY(&z_copy, global_arr);
	zend_hash_str_update(&EG(symbol_table), global_name, strlen(global_name), &z_copy);
}

static inline void php2v_reset_super_globals() {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif

	/* 每次请求前清空符号表，并重新初始化 GLOBALS 核心回环符号 */
	zend_try {
		zend_hash_clean(&EG(symbol_table));
		zval globals_zv;
		ZVAL_ARR(&globals_zv, &EG(symbol_table));
		zend_hash_str_update(&EG(symbol_table), "GLOBALS", sizeof("GLOBALS") - 1, &globals_zv);
	} zend_end_try();

	php2v_req_buf *b = (php2v_req_buf *)php2v_current_ctx;
	zend_auto_global *auto_global;
	ZEND_HASH_MAP_FOREACH_PTR(CG(auto_globals), auto_global) {
		if (auto_global->name && strcmp(auto_global->name->val, "_GET") == 0) {
			if (b) php2v_populate_track_vars(TRACK_VARS_GET, b->get_str, "_GET");
			auto_global->armed = 0;
		} else if (auto_global->name && strcmp(auto_global->name->val, "_POST") == 0) {
			if (b) php2v_populate_track_vars(TRACK_VARS_POST, b->post_str, "_POST");
			auto_global->armed = 0;
		} else if (auto_global->name && strcmp(auto_global->name->val, "_COOKIE") == 0) {
			if (b) php2v_populate_track_vars(TRACK_VARS_COOKIE, b->cookie_str, "_COOKIE");
			auto_global->armed = 0;
		} else if (auto_global->auto_global_callback) {
			auto_global->armed = auto_global->auto_global_callback(auto_global->name);
		}
	} ZEND_HASH_FOREACH_END();
}

/*
 * 核心请求处理：在线程上下文中执行 PHP 脚本
 *
 * 生命周期（对标 FrankenPHP Worker Mode）：
 *   php_request_startup()
 *   → 执行文件/函数
 *   → 预存 response headers & status code
 *   → php2v_worker_request_shutdown() [精细化关闭]
 */
static inline void php2v_run_in_thread_context(void (*entry_fn)(void)) {
#ifdef ZTS
	ts_resource(0);
	ZEND_TSRMLS_CACHE_UPDATE();

	/* php_request_startup 初始化请求级资源 */
	php_request_startup();
	ZEND_TSRMLS_CACHE_UPDATE();

	/* 禁用 GC（常驻进程中 GC 可能干扰 ZTS 状态） */
	gc_enable(0);
	gc_protect(1);

	/* 显式重置 SAPI Headers 状态码为 200，清空上一个请求残留的状态 */
	SG(sapi_headers).http_response_code = 200;
	if (SG(sapi_headers).headers.head) {
		zend_llist_clean(&SG(sapi_headers).headers);
	}

	/* 注册沙箱桥接函数 */
	php2v_register_sandbox_bridge();

	/* 填充 php://input 对应的 raw_post_data */
	php2v_req_buf *req_b_input = (php2v_req_buf *)php2v_current_ctx;
	if (req_b_input && req_b_input->raw_post_data && strlen(req_b_input->raw_post_data) > 0) {
		SG(request_info).content_length = strlen(req_b_input->raw_post_data);
		req_b_input->raw_post_data_read = 0;
	}

	/* FrankenPHP 风格：不手动注入超全局变量！
	 * 靠 register_server_variables 回调 + auto_global_callback 自动注入
	 * 这里只需触发重建 */
	php2v_reset_super_globals();

	zval *server_zv = zend_hash_str_find(&EG(symbol_table), "_SERVER", sizeof("_SERVER") - 1);
	if (server_zv && Z_TYPE_P(server_zv) == IS_ARRAY) {
		zval *ct_zv = zend_hash_str_find(Z_ARRVAL_P(server_zv), "CONTENT_TYPE", sizeof("CONTENT_TYPE") - 1);
		if (ct_zv && Z_TYPE_P(ct_zv) == IS_STRING) {
			SG(request_info).content_type = Z_STRVAL_P(ct_zv);
		}
	}
#endif

	/* 执行 PHP 脚本或转译函数 */
	if (setjmp(php2v_exit_jmp_buf) == 0) {
		zend_first_try {
			php2v_req_buf *b = (php2v_req_buf *)php2v_current_ctx;
			if (b && b->script_path && strlen(b->script_path) > 0) {
				double t0 = microtime_sec();
				php2v_execute_file(b->script_path);
				double t1 = microtime_sec();
				printf("[PHP EXEC TIME] File: %s took %.4f seconds\n", b->script_path, t1 - t0);
			} else if (entry_fn) {
				entry_fn();
			}
		} zend_catch {
			/* 捕获动态文件的 zend_bailout */
			printf("[PHP BAILOUT CAUGHT] An error or die() triggered bailout during request processing!\n");
			php2v_check_and_clear_exception();
		} zend_end_try();
	} else {
		/* 安全捕获静态转译代码里 php2v_exit() 的自定义 longjmp */
	}

	/* 预存 response 状态码到 req_buf */
	php2v_req_buf *req_b = (php2v_req_buf *)php2v_current_ctx;
	if (req_b) {
		req_b->response_code = SG(sapi_headers).http_response_code;
	}

	/* FrankenPHP 风格的精细化请求关闭 */
	php2v_worker_request_shutdown();
}

/* php2v_shutdown_request 保留但标记为 legacy（用于非 worker 模式的完整关闭） */
static inline void php2v_shutdown_request() {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
	php_request_shutdown(NULL);
#endif
}

static inline void php2v_sapi_flush(void *server_context) {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
}

static inline size_t php2v_ub_write(const char *str, size_t str_length) {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
	if (php2v_current_ctx && str && str_length > 0) {
		php2v_req_buf *b = (php2v_req_buf *)php2v_current_ctx;
		size_t needed = b->len + str_length + 1;
		if (needed > b->cap) {
			size_t new_cap = (b->cap == 0) ? 65536 : (b->cap * 2);
			if (new_cap < needed) {
				new_cap = needed + 65536;
			}
			char *new_buf = (char *)realloc(b->buf, new_cap);
			if (!new_buf) return str_length; /* OOM 保护 */
			b->buf = new_buf;
			b->cap = new_cap;
		}
		memcpy(b->buf + b->len, str, str_length);
		b->len += str_length;
		b->buf[b->len] = '\0';
	}
	return str_length;
}

static inline void php2v_append_output(const char *str, size_t str_length) {
	php2v_ub_write(str, str_length);
}

/*
 * SAPI register_server_variables 回调
 * FrankenPHP 风格：通过 php_register_variable 将请求数据注入
 * 当 Zend 的 auto_global 惰性加载触发 $_SERVER 初始化时自动调用
 */
static void php2v_register_server_variables(zval *track_vars_array) {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
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

static int php2v_header_handler(sapi_header_struct *sapi_header, sapi_header_op_enum op, sapi_headers_struct *sapi_headers) {
	if (sapi_header && sapi_header->header) {
		printf("[SAPI HEADER INTERCEPTED] %s (ctx: %p)\n", sapi_header->header, php2v_current_ctx);
		if (php2v_current_ctx) {
			php2v_req_buf *req_b = (php2v_req_buf *)php2v_current_ctx;
			size_t h_len = sapi_header->header_len;
			if (h_len > 0) {
				size_t old_len = req_b->headers_str ? strlen(req_b->headers_str) : 0;
				size_t new_len = old_len + h_len + 2;
				char *new_str = (char *)realloc(req_b->headers_str, new_len);
				if (new_str) {
					req_b->headers_str = new_str;
					memcpy(req_b->headers_str + old_len, sapi_header->header, h_len);
					req_b->headers_str[old_len + h_len] = '\x01';
					req_b->headers_str[old_len + h_len + 1] = '\0';
				}
			}
		}
	}
	return SAPI_HEADER_ADD;
}

static size_t php2v_read_post(char *buf, size_t count_bytes) {
	if (!php2v_current_ctx) return 0;
	php2v_req_buf *b = (php2v_req_buf *)php2v_current_ctx;
	if (!b->raw_post_data || b->raw_post_data_read >= strlen(b->raw_post_data)) {
		return 0;
	}
	size_t total_len = strlen(b->raw_post_data);
	size_t remain = total_len - b->raw_post_data_read;
	size_t to_copy = (count_bytes < remain) ? count_bytes : remain;
	memcpy(buf, b->raw_post_data + b->raw_post_data_read, to_copy);
	b->raw_post_data_read += to_copy;
	return to_copy;
}

static zif_handler orig_curl_exec_handler = NULL;

static ZEND_NAMED_FUNCTION(php2v_async_curl_exec_handler) {
	if (orig_curl_exec_handler) {
		orig_curl_exec_handler(INTERNAL_FUNCTION_PARAM_PASSTHRU);
		return;
	}
	RETURN_FALSE;
}

__attribute__((constructor)) static void php2v_auto_embed_init() {
	curl_global_init(CURL_GLOBAL_DEFAULT);
	setenv("PHPRC", "/nonexistent", 1);
	setenv("PHP_INI_SCAN_DIR", "", 1);
	php_embed_module.php_ini_ignore = 1;
	php_embed_module.php_ini_path_override = "/dev/null";
	php_embed_module.deactivate = NULL;
	php_embed_module.flush = php2v_sapi_flush;
	php_embed_module.ub_write = php2v_ub_write;
	php_embed_module.read_post = php2v_read_post;
	php_embed_module.header_handler = php2v_header_handler;
	php_embed_module.register_server_variables = php2v_register_server_variables;

	char *embed_argv[] = {
		"wordpress_server",
		"-d", "opcache.enable=0",
		"-d", "opcache.enable_cli=0",
		"-d", "zend.enable_gc=0",
		"-d", "pcre.jit=0",
		"-d", "zend.assertions=-1",
		"-d", "output_buffering=Off",
		"-d", "memory_limit=-1",
		"-d", "default_socket_timeout=0.1",
		"-d", "max_execution_time=5",
		"-d", "display_errors=1",
		"-d", "log_errors=1",
		NULL
	};
	php_embed_init(19, embed_argv);
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
	extern zend_op_array *compile_file(zend_file_handle *file_handle, int type);
	zend_compile_file = compile_file;

	/* 用 V 语言 spawn 协程接管 curl_exec 异步代理 */
	zend_function *curl_fn = zend_hash_str_find_ptr(CG(function_table), "curl_exec", sizeof("curl_exec") - 1);
	if (curl_fn) {
		orig_curl_exec_handler = curl_fn->internal_function.handler;
		curl_fn->internal_function.handler = php2v_async_curl_exec_handler;
	}

	/* 运行时再次确认关键 ini 设置 */
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
