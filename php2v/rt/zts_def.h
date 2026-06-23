#ifndef PHP2V_RT_ZTS_DEF_H
#define PHP2V_RT_ZTS_DEF_H

#include <php.h>

#ifdef ZTS
ZEND_TSRMLS_CACHE_DEFINE()
#endif

#endif
