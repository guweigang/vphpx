#ifndef PHP2V_RT_HELPER_H
#define PHP2V_RT_HELPER_H

#include <php.h>
#include "zts_def.h"

static inline int php2v_hash_get_entry(void *ht, uint32_t index, zval **val, zend_string **key, zend_ulong *num_key) {
	php2v_update_tsrm_cache();
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
	php2v_update_tsrm_cache();
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

// php2v_eval_string 调用 zend_compile_string 和 zend_execute 执行动态代码
static inline int php2v_eval_string(const char *str, size_t len, zval *retval) {
	php2v_update_tsrm_cache();
	php2v_check_and_clear_exception();

	// 使用 zend_compile_string 编译代码，这样就不会像 zend_eval_string 那样遇到 retval 就不加区别地 prepend "return "。
	// 为了使编译器将其作为 PHP 脚本编译，必须加上 "<?php " 前缀。
	size_t new_len = len + 6;
	char *buf = (char *)alloca(new_len + 1);
	memcpy(buf, "<?php ", 6);
	memcpy(buf + 6, str, len);
	buf[new_len] = '\0';

	zend_string *zstr = zend_string_init(buf, new_len, 0);
	zend_op_array *op_array = zend_compile_string(zstr, "php2v_eval", 0);
	zend_string_release(zstr);

	if (!op_array) {
		return -1;
	}

	if (retval) {
		ZVAL_UNDEF(retval);
	}

	zend_execute(op_array, retval);
	destroy_op_array(op_array);
	efree(op_array);

	php2v_check_and_clear_exception();
	return 0;
}

#endif
