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

// php2v_call_zend_function 动态在全局函数表中查找 name 并利用 params 指针数组进行解包直调
static inline int php2v_call_zend_function(const char *name, size_t name_len, zval *retval, uint32_t param_count, zval **params) {
	zend_string *zstr_name = zend_string_init(name, name_len, 0);
	zval func_zval;
	ZVAL_STR(&func_zval, zstr_name);
	
	zval *z_args = NULL;
	if (param_count > 0) {
		z_args = (zval *)alloca(param_count * sizeof(zval));
		for (uint32_t i = 0; i < param_count; i++) {
			z_args[i] = *(params[i]);
		}
	}
	
	int res = call_user_function(EG(function_table), NULL, &func_zval, retval, param_count, z_args);
	
	zend_string_release(zstr_name);
	return res;
}

// php2v_eval_string 调用 zend_eval_string 执行动态代码
static inline int php2v_eval_string(const char *str, size_t len, zval *retval) {
	char *code = (char *)alloca(len + 1);
	memcpy(code, str, len);
	code[len] = '\0';
	return zend_eval_string(code, retval, "php2v_eval");
}

#endif
