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
		zval rv;
		zval *msg = zend_read_property(ex->ce, ex, "message", sizeof("message") - 1, 0, &rv);
		if (msg && Z_TYPE_P(msg) == IS_STRING) {
			printf("PHP EXCEPTION MESSAGE: %s\n", Z_STRVAL_P(msg));
		}
		zend_clear_exception();
	}
}

static inline void php2v_refresh_request() {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
	php_request_shutdown(NULL);
	if (php_request_startup() == FAILURE) {
		printf("PHP2V ERROR - php_request_startup failed!\n");
	}
}

__attribute__((constructor)) static void php2v_auto_embed_init() {
	php_embed_module.php_ini_ignore = 1;
	php_embed_module.php_ini_path_override = "/dev/null";
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
}

#endif
