#ifndef PHP2V_RT_ZTS_DEF_H
#define PHP2V_RT_ZTS_DEF_H

#include <sapi/embed/php_embed.h>

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

__attribute__((constructor)) static void php2v_auto_embed_init() {
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
