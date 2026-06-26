#ifndef PHP2V_RT_HELPER_H
#define PHP2V_RT_HELPER_H

#include <php.h>
#include "zts_def.h"

static zval php2v_active_exception;
static int php2v_has_active_exception = 0;

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

// php2v_call_method 动态在对象中查找并调用方法
static inline int php2v_call_method(zval *obj, const char *method_name, size_t method_len, zval *retval, uint32_t param_count, zval **params) {
	php2v_update_tsrm_cache();
	zval method_zval;
	ZVAL_STRINGL(&method_zval, method_name, method_len);
	
	zval *z_args = NULL;
	if (param_count > 0) {
		z_args = (zval *)alloca(param_count * sizeof(zval));
		for (uint32_t i = 0; i < param_count; i++) {
			z_args[i] = *(params[i]);
		}
	}
	
	int res = call_user_function(EG(function_table), obj, &method_zval, retval, param_count, z_args);
	
	zval_ptr_dtor(&method_zval);
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

// php2v_register_constant 在运行时将常量注册到 Zend 常量表
static inline int php2v_register_constant(const char *name, size_t name_len, zval *val) {
	php2v_update_tsrm_cache();
	zend_constant c;
	c.filename = NULL;
	c.attributes = NULL;
	
	ZVAL_COPY(&c.value, val);
	c.name = zend_string_init(name, name_len, 0);
	
	#ifndef PHP_USER_CONSTANT
	#define PHP_USER_CONSTANT 0x7f
	#endif
	
	ZEND_CONSTANT_SET_FLAGS(&c, CONST_CS, PHP_USER_CONSTANT);
	
	if (zend_register_constant(&c) == FAILURE) {
		zend_error(E_WARNING, "Constant %s already defined", name);
		zend_string_release(c.name);
		zval_ptr_dtor(&c.value);
		return 0;
	}
	return 1;
}

// php2v_get_constant 获取 Zend 常量表中的常量值
static inline int php2v_get_constant(const char *name, size_t name_len, zval *retval) {
	php2v_update_tsrm_cache();
	zend_string *zstr = zend_string_init(name, name_len, 0);
	zend_constant *c = zend_get_constant(zstr);
	zend_string_release(zstr);
	if (c) {
		ZVAL_COPY(retval, &c->value);
		return 1;
	}
	zend_throw_error(NULL, "Undefined constant \"%s\"", name);
	ZVAL_NULL(retval);
	return 0;
}

static inline int php2v_has_exception() {
	php2v_update_tsrm_cache();
	return php2v_has_active_exception || (EG(exception) != NULL);
}

static inline void php2v_get_and_clear_exception(zval *retval) {
	php2v_update_tsrm_cache();
	if (php2v_has_active_exception) {
		ZVAL_COPY(retval, &php2v_active_exception);
		zval_ptr_dtor(&php2v_active_exception);
		ZVAL_UNDEF(&php2v_active_exception);
		php2v_has_active_exception = 0;
	} else if (EG(exception)) {
		ZVAL_OBJ(retval, EG(exception));
		EG(exception) = NULL;
	} else {
		ZVAL_NULL(retval);
	}
}

static inline void php2v_throw_exception_object(zval *ex) {
	php2v_update_tsrm_cache();
	if (ex) {
		ZVAL_COPY(&php2v_active_exception, ex);
		php2v_has_active_exception = 1;
	}
}

static inline int php2v_get_superglobal(const char *name, size_t name_len, zval *retval) {
	php2v_update_tsrm_cache();
	zend_string *zstr = zend_string_init(name, name_len, 0);
	zval *val = zend_hash_find(&EG(symbol_table), zstr);
	zend_string_release(zstr);
	if (val) {
		ZVAL_COPY(retval, val);
		return 1;
	}
	ZVAL_NULL(retval);
	return 0;
}

static inline void php2v_register_global(const char *name, size_t name_len, zval *val) {
	php2v_update_tsrm_cache();
	zend_string *zstr = zend_string_init(name, name_len, 0);
	zend_hash_update(&EG(symbol_table), zstr, val);
	zend_string_release(zstr);
}

static inline int php2v_instance_of(zval *obj, const char *class_name, size_t name_len) {
	php2v_update_tsrm_cache();
	if (!obj || Z_TYPE_P(obj) != IS_OBJECT) return 0;
	zend_string *zstr = zend_string_init(class_name, name_len, 0);
	zend_class_entry *ce = zend_lookup_class(zstr);
	zend_string_release(zstr);
	if (!ce) return 0;
	return instanceof_function(Z_OBJCE_P(obj), ce);
}

static zval php2v_null_val;
static zval php2v_true_val;
static zval php2v_false_val;
static int php2v_constants_inited = 0;

static inline void php2v_init_constants() {
	if (php2v_constants_inited) return;
	ZVAL_NULL(&php2v_null_val);
	ZVAL_TRUE(&php2v_true_val);
	ZVAL_FALSE(&php2v_false_val);
	php2v_constants_inited = 1;
}

static inline zval* php2v_get_null() {
	php2v_init_constants();
	return &php2v_null_val;
}

static inline zval* php2v_get_true() {
	php2v_init_constants();
	return &php2v_true_val;
}

static inline zval* php2v_get_false() {
	php2v_init_constants();
	return &php2v_false_val;
}

#endif
