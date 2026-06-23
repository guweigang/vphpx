#ifndef PHP2V_RT_ZTS_INST_H
#define PHP2V_RT_ZTS_INST_H

#include <sapi/embed/php_embed.h>

#ifdef ZTS
#if defined(__GNUC__) || defined(__clang__)
__attribute__((visibility("default"))) __thread void *TSRMLS_CACHE = NULL;
#else
_Thread_local void *TSRMLS_CACHE = NULL;
#endif
#endif

#endif
