#ifndef PHP2V_RT_HELPER_H
#define PHP2V_RT_HELPER_H

#include <php.h>

static inline int php2v_hash_get_entry(void *ht, uint32_t index, zval **val, zend_string **key, zend_ulong *num_key) {
	HashTable *arr = (HashTable *)ht;
	if (!arr) return 0;
	while (index < arr->nNumUsed) {
		Bucket *b = &arr->arData[index];
		if (Z_TYPE(b->val) != IS_UNDEF) {
			*val = &b->val;
			*key = b->key;
			*num_key = b->h;
			return 1;
		}
		index++;
	}
	return 0;
}

#endif
