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

// php2v_call_zend_callable 动态调用任意 zval 可调用对象
static inline int php2v_call_zend_callable(zval *callable, zval *retval, uint32_t param_count, zval **params) {
	php2v_update_tsrm_cache();
	zval *z_args = NULL;
	if (param_count > 0) {
		z_args = (zval *)alloca(param_count * sizeof(zval));
		for (uint32_t i = 0; i < param_count; i++) {
			z_args[i] = *(params[i]);
		}
	}
	int res = call_user_function(EG(function_table), NULL, callable, retval, param_count, z_args);
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

	zend_try {
		zend_execute(op_array, retval);
	} zend_catch {
		// 捕获 bailout (exit/die/error)，安全刷新请求状态，避免 Zend 自杀

		php2v_refresh_request();
	} zend_end_try();
	destroy_op_array(op_array);
	efree(op_array);

	php2v_check_and_clear_exception();
	return 0;
}

static inline void php2v_register_persistent_constant(const char *name, const char *val) {
    php2v_update_tsrm_cache();
    
    zend_string *zname = zend_string_init(name, strlen(name), 0);
    zend_hash_del(EG(zend_constants), zname);
    zend_string_release(zname);
    
    zend_register_string_constant(name, strlen(name), val, CONST_CS | CONST_PERSISTENT, 0);
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
	
	if (zend_register_constant(&c) == NULL) {
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
	zend_is_auto_global(zstr);
	Z_TRY_ADDREF_P(val);
	zend_hash_update(&EG(symbol_table), zstr, val);
	zend_string_release(zstr);
	zend_rebuild_symbol_table();
}

static inline void php2v_inject_http_globals(zval *get, zval *post, zval *cookie, zval *server, zval *files) {
	php2v_update_tsrm_cache();
	
	zval_ptr_dtor(&PG(http_globals)[TRACK_VARS_GET]);
	zval_ptr_dtor(&PG(http_globals)[TRACK_VARS_POST]);
	zval_ptr_dtor(&PG(http_globals)[TRACK_VARS_COOKIE]);
	zval_ptr_dtor(&PG(http_globals)[TRACK_VARS_SERVER]);
	zval_ptr_dtor(&PG(http_globals)[TRACK_VARS_FILES]);
	
	ZVAL_COPY(&PG(http_globals)[TRACK_VARS_GET], get);
	ZVAL_COPY(&PG(http_globals)[TRACK_VARS_POST], post);
	ZVAL_COPY(&PG(http_globals)[TRACK_VARS_COOKIE], cookie);
	ZVAL_COPY(&PG(http_globals)[TRACK_VARS_SERVER], server);
	ZVAL_COPY(&PG(http_globals)[TRACK_VARS_FILES], files);
	
	zend_is_auto_global_str(ZEND_STRL("_GET"));
	zend_is_auto_global_str(ZEND_STRL("_POST"));
	zend_is_auto_global_str(ZEND_STRL("_COOKIE"));
	zend_is_auto_global_str(ZEND_STRL("_SERVER"));
	zend_is_auto_global_str(ZEND_STRL("_FILES"));
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

static void* g_php2v_registry = NULL;
static inline void* php2v_get_registry() {
    return g_php2v_registry;
}
static inline void php2v_set_registry(void* p) {
    g_php2v_registry = p;
}

#ifdef _MSC_VER
static __declspec(thread) void* php2v_current_ctx = NULL;
#else
static __thread void* php2v_current_ctx = NULL;
#endif

static inline void php2v_set_current_ctx(void* ctx) {
    php2v_current_ctx = ctx;
}

static inline void* php2v_get_current_ctx() {
    return php2v_current_ctx;
}

static inline const char* php2v_zstr_val(void* zstr) {
    if (!zstr) return "";
    return ((zend_string*)zstr)->val;
}

static inline size_t php2v_zstr_len(void* zstr) {
    if (!zstr) return 0;
    return ((zend_string*)zstr)->len;
}

// ---------------- 沙箱互操作桥接接口 ----------------
typedef void* (*php2v_v_callback_t)(const char* name, int name_len, void* z_args_array);
static php2v_v_callback_t g_php2v_v_callback = NULL;

static inline void php2v_set_v_callback(php2v_v_callback_t cb) {
    g_php2v_v_callback = cb;
}

static inline void* php2v_get_last_mysql_conn();

static void zif_vphp_call_v_native(zend_execute_data *execute_data, zval *return_value) {
    char *func_name = NULL;
    size_t func_name_len = 0;
    zval *args_array = NULL;

    ZEND_PARSE_PARAMETERS_START(2, 2)
        Z_PARAM_STRING(func_name, func_name_len)
        Z_PARAM_ARRAY(args_array)
    ZEND_PARSE_PARAMETERS_END();

    if (g_php2v_v_callback) {
        void* ret_zval = g_php2v_v_callback(func_name, (int)func_name_len, args_array);
        if (ret_zval) {
            ZVAL_COPY_VALUE(return_value, (zval*)ret_zval);
        } else {
            ZVAL_NULL(return_value);
        }
    } else {
        php_error_docref(NULL, E_WARNING, "V callback handler not registered");
        ZVAL_NULL(return_value);
    }
}

static inline int php2v_extract_array_elements(void* z_arr, void** out_elements) {
    if (!z_arr) return 0;
    HashTable *ht = Z_ARRVAL_P((zval*)z_arr);
    zval *val;
    int i = 0;
    ZEND_HASH_FOREACH_VAL(ht, val) {
        out_elements[i++] = val;
    } ZEND_HASH_FOREACH_END();
    return i;
}

static inline int php2v_get_array_num_elements(void* z_arr) {
    if (!z_arr) return 0;
    return zend_hash_num_elements(Z_ARRVAL_P((zval*)z_arr));
}

ZEND_BEGIN_ARG_INFO_EX(arginfo_vphp_call_v_native, 0, 0, 2)
    ZEND_ARG_INFO(0, func_name)
    ZEND_ARG_INFO(0, args)
ZEND_END_ARG_INFO()

static void zif_php2v_mysqli_init(zend_execute_data *execute_data, zval *return_value) {
    zend_string *class_name = zend_string_init("mysqli", sizeof("mysqli") - 1, 0);
    zend_class_entry *mysqli_ce = zend_lookup_class(class_name);
    zend_string_release(class_name);
    
    if (mysqli_ce) {
        object_init_ex(return_value, mysqli_ce);
    } else {
        object_init_ex(return_value, zend_standard_class_def);
    }
    
    zval zero;
    ZVAL_LONG(&zero, 0);
    zend_update_property(mysqli_ce ? mysqli_ce : zend_standard_class_def, Z_OBJ_P(return_value), "connect_errno", sizeof("connect_errno") - 1, &zero);
    
    zval version;
    ZVAL_STRING(&version, "8.0.32-VPHP");
    zend_update_property(mysqli_ce ? mysqli_ce : zend_standard_class_def, Z_OBJ_P(return_value), "server_info", sizeof("server_info") - 1, &version);
}

static void zif_php2v_mysqli_real_connect(zend_execute_data *execute_data, zval *return_value) {
    zval *dbh = NULL;
    zval *z_host = NULL;
    zval *z_user = NULL;
    zval *z_pass = NULL;
    zval *z_dbname = NULL;
    zval *z_port = NULL;
    zval *z_socket = NULL;
    zval *z_flags = NULL;
    
    ZEND_PARSE_PARAMETERS_START(1, 8)
        Z_PARAM_OBJECT(dbh)
        Z_PARAM_OPTIONAL
        Z_PARAM_ZVAL_OR_NULL(z_host)
        Z_PARAM_ZVAL_OR_NULL(z_user)
        Z_PARAM_ZVAL_OR_NULL(z_pass)
        Z_PARAM_ZVAL_OR_NULL(z_dbname)
        Z_PARAM_ZVAL_OR_NULL(z_port)
        Z_PARAM_ZVAL_OR_NULL(z_socket)
        Z_PARAM_ZVAL_OR_NULL(z_flags)
    ZEND_PARSE_PARAMETERS_END();
    
    if (g_php2v_v_callback) {
        zval args;
        array_init(&args);
        
        const char *host_str = (z_host && Z_TYPE_P(z_host) == IS_STRING) ? Z_STRVAL_P(z_host) : "127.0.0.1";
        zval z_h; ZVAL_STRING(&z_h, host_str);
        add_next_index_zval(&args, &z_h);
        
        const char *user_str = (z_user && Z_TYPE_P(z_user) == IS_STRING) ? Z_STRVAL_P(z_user) : "root";
        zval z_u; ZVAL_STRING(&z_u, user_str);
        add_next_index_zval(&args, &z_u);
        
        const char *pass_str = (z_pass && Z_TYPE_P(z_pass) == IS_STRING) ? Z_STRVAL_P(z_pass) : "";
        zval z_p; ZVAL_STRING(&z_p, pass_str);
        add_next_index_zval(&args, &z_p);
        
        const char *db_str = (z_dbname && Z_TYPE_P(z_dbname) == IS_STRING) ? Z_STRVAL_P(z_dbname) : "";
        zval z_d; ZVAL_STRING(&z_d, db_str);
        add_next_index_zval(&args, &z_d);
        
        long port_val = (z_port && Z_TYPE_P(z_port) == IS_LONG) ? Z_LVAL_P(z_port) : 3306;
        zval z_pt; ZVAL_LONG(&z_pt, port_val);
        add_next_index_zval(&args, &z_pt);
        
        g_php2v_v_callback("mysqli_real_connect", sizeof("mysqli_real_connect") - 1, &args);
        zval_ptr_dtor(&args);
    }
    
    if (dbh && Z_TYPE_P(dbh) == IS_OBJECT) {
        zval zero;
        ZVAL_LONG(&zero, 0);
        zend_update_property(Z_OBJCE_P(dbh), Z_OBJ_P(dbh), "connect_errno", sizeof("connect_errno") - 1, &zero);
        
        void* last_conn = php2v_get_last_mysql_conn();
        zval z_conn_val;
        ZVAL_LONG(&z_conn_val, (zend_long)last_conn);
        zend_update_property(Z_OBJCE_P(dbh), Z_OBJ_P(dbh), "handle", sizeof("handle") - 1, &z_conn_val);
    }
    
    ZVAL_TRUE(return_value);
}

static void zif_php2v_mysqli_query(zend_execute_data *execute_data, zval *return_value) {
    zval *dbh = NULL;
    char *query = NULL;
    size_t query_len = 0;
    ZEND_PARSE_PARAMETERS_START(2, 2)
        Z_PARAM_OBJECT(dbh)
        Z_PARAM_STRING(query, query_len)
    ZEND_PARSE_PARAMETERS_END();
    

    
    if (g_php2v_v_callback) {
        zval args;
        array_init(&args);
        
        zval z_dbh;
        ZVAL_COPY(&z_dbh, dbh);
        add_next_index_zval(&args, &z_dbh);
        
        zval z_query;
        ZVAL_STRINGL(&z_query, query, query_len);
        add_next_index_zval(&args, &z_query);
        
        void* ret = g_php2v_v_callback("mysqli_query", sizeof("mysqli_query") - 1, &args);
        zval_ptr_dtor(&args);
        
        if (ret) {
            *return_value = *(zval*)ret;
        } else {
            ZVAL_FALSE(return_value);
        }
    } else {
        ZVAL_FALSE(return_value);
    }
}

static void zif_php2v_mysqli_report(zend_execute_data *execute_data, zval *return_value) {
    ZVAL_TRUE(return_value);
}

static void zif_php2v_mysqli_connect_errno(zend_execute_data *execute_data, zval *return_value) {
    ZVAL_LONG(return_value, 0);
}

static void zif_php2v_mysqli_connect_error(zend_execute_data *execute_data, zval *return_value) {
    ZVAL_NULL(return_value);
}

static void zif_php2v_mysqli_error(zend_execute_data *execute_data, zval *return_value) {
    ZVAL_NULL(return_value);
}

static void zif_php2v_mysqli_errno(zend_execute_data *execute_data, zval *return_value) {
    ZVAL_LONG(return_value, 0);
}

static void zif_php2v_mysqli_select_db(zend_execute_data *execute_data, zval *return_value) {
    zval *z_dbh = NULL;
    char *dbname = NULL;
    size_t dbname_len = 0;
    
    ZEND_PARSE_PARAMETERS_START(2, 2)
        Z_PARAM_ZVAL_OR_NULL(z_dbh)
        Z_PARAM_STRING(dbname, dbname_len)
    ZEND_PARSE_PARAMETERS_END();
    
    if (g_php2v_v_callback && z_dbh && Z_TYPE_P(z_dbh) == IS_OBJECT) {
        zval *z_handle = zend_read_property(Z_OBJCE_P(z_dbh), Z_OBJ_P(z_dbh), "handle", sizeof("handle") - 1, 1, NULL);
        zend_long handle_val = zval_get_long(z_handle);
        
        zval args;
        array_init(&args);
        
        zval z_res;
        ZVAL_LONG(&z_res, handle_val);
        add_next_index_zval(&args, &z_res);
        
        zval z_dbname;
        ZVAL_STRINGL(&z_dbname, dbname, dbname_len);
        add_next_index_zval(&args, &z_dbname);
        
        void* ret = g_php2v_v_callback("mysqli_select_db", sizeof("mysqli_select_db") - 1, &args);
        zval_ptr_dtor(&args);
        
        if (ret && Z_TYPE_P((zval*)ret) == IS_TRUE) {
            ZVAL_TRUE(return_value);
        } else {
            ZVAL_FALSE(return_value);
        }
    } else {
        ZVAL_FALSE(return_value);
    }
}

static void zif_php2v_mysqli_set_charset(zend_execute_data *execute_data, zval *return_value) {
    ZVAL_TRUE(return_value);
}

static void zif_php2v_mysqli_real_escape_string(zend_execute_data *execute_data, zval *return_value) {
    zval *dbh = NULL;
    char *str = NULL;
    size_t str_len = 0;
    ZEND_PARSE_PARAMETERS_START(2, 2)
        Z_PARAM_OBJECT(dbh)
        Z_PARAM_STRING(str, str_len)
    ZEND_PARSE_PARAMETERS_END();
    
    if (!str || str_len == 0) {
        ZVAL_EMPTY_STRING(return_value);
        return;
    }
    
    char *escaped = malloc(str_len * 2 + 1);
    size_t escaped_len = 0;
    for (size_t i = 0; i < str_len; i++) {
        char c = str[i];
        if (c == '\'' || c == '"' || c == '\\' || c == '\0' || c == '\n' || c == '\r' || c == '\x1a') {
            escaped[escaped_len++] = '\\';
            if (c == '\0') {
                escaped[escaped_len++] = '0';
            } else if (c == '\n') {
                escaped[escaped_len++] = 'n';
            } else if (c == '\r') {
                escaped[escaped_len++] = 'r';
            } else if (c == '\x1a') {
                escaped[escaped_len++] = 'Z';
            } else {
                escaped[escaped_len++] = c;
            }
        } else {
            escaped[escaped_len++] = c;
        }
    }
    escaped[escaped_len] = '\0';
    
    ZVAL_STRINGL(return_value, escaped, escaped_len);
    free(escaped);
}

static void zif_php2v_mysqli_more_results(zend_execute_data *execute_data, zval *return_value) {
    ZVAL_FALSE(return_value);
}

static void zif_php2v_mysqli_next_result(zend_execute_data *execute_data, zval *return_value) {
    ZVAL_FALSE(return_value);
}

static void zif_php2v_gzinflate(zend_execute_data *execute_data, zval *return_value) {
    ZVAL_FALSE(return_value);
}

static void zif_php2v_headers_sent(zend_execute_data *execute_data, zval *return_value) {
    ZVAL_FALSE(return_value);
}

static void zif_php2v_mysqli_fetch_object(zend_execute_data *execute_data, zval *return_value) {
    zval *result = NULL;
    ZEND_PARSE_PARAMETERS_START(1, 4)
        Z_PARAM_OBJECT(result)
    ZEND_PARSE_PARAMETERS_END();
    
    if (g_php2v_v_callback && result && Z_TYPE_P(result) == IS_OBJECT) {
        zval *z_handle = zend_read_property(Z_OBJCE_P(result), Z_OBJ_P(result), "handle", sizeof("handle") - 1, 1, NULL);
        zend_long handle_val = zval_get_long(z_handle);

        
        zval args;
        array_init(&args);
        zval z_res;
        ZVAL_LONG(&z_res, handle_val);
        add_next_index_zval(&args, &z_res);
        
        void* ret = g_php2v_v_callback("mysqli_fetch_object", sizeof("mysqli_fetch_object") - 1, &args);
        zval_ptr_dtor(&args);
        
        if (ret) {
            *return_value = *(zval*)ret;
        } else {
            ZVAL_NULL(return_value);
        }
    } else {
        ZVAL_NULL(return_value);
    }
}

static inline void php2v_parse_and_build_array(const char* encoded_data, int mode, zval* return_value) {
    if (!encoded_data || strlen(encoded_data) == 0) {
        ZVAL_NULL(return_value);
        return;
    }
    
    array_init(return_value);
    char *str = strdup(encoded_data);
    char *saveptr1, *saveptr2;
    char *token = strtok_r(str, "\x01", &saveptr1);
    int idx = 0;
    
    while (token != NULL) {
        char *kv = strdup(token);
        char *k = strtok_r(kv, "\x02", &saveptr2);
        char *v = strtok_r(NULL, "\x02", &saveptr2);
        if (k) {

            if (v) {
                if (mode == 1 || mode == 3) {
                    add_assoc_string(return_value, k, v);
                }
                if (mode == 2 || mode == 3) {
                    add_index_string(return_value, idx, v);
                }
            } else {
                if (mode == 1 || mode == 3) {
                    add_assoc_null(return_value, k);
                }
                if (mode == 2 || mode == 3) {
                    add_index_null(return_value, idx);
                }
            }
        }
        free(kv);
        idx++;
        token = strtok_r(NULL, "\x01", &saveptr1);
    }
    free(str);
}

static void zif_php2v_mysqli_fetch_assoc(zend_execute_data *execute_data, zval *return_value) {
    zval *result = NULL;
    ZEND_PARSE_PARAMETERS_START(1, 1)
        Z_PARAM_OBJECT(result)
    ZEND_PARSE_PARAMETERS_END();
    
    if (g_php2v_v_callback && result && Z_TYPE_P(result) == IS_OBJECT) {
        zval *z_handle = zend_read_property(Z_OBJCE_P(result), Z_OBJ_P(result), "handle", sizeof("handle") - 1, 1, NULL);
        zend_long handle_val = zval_get_long(z_handle);
        
        zval args;
        array_init(&args);
        zval z_res;
        ZVAL_LONG(&z_res, handle_val);
        add_next_index_zval(&args, &z_res);
        
        void* ret = g_php2v_v_callback("mysqli_fetch_assoc", sizeof("mysqli_fetch_assoc") - 1, &args);
        zval_ptr_dtor(&args);
        
        if (ret && Z_TYPE_P((zval*)ret) == IS_STRING) {
            php2v_parse_and_build_array(Z_STRVAL_P((zval*)ret), 1, return_value);
        } else {
            ZVAL_NULL(return_value);
        }
    } else {
        ZVAL_NULL(return_value);
    }
}

static void zif_php2v_mysqli_fetch_row(zend_execute_data *execute_data, zval *return_value) {
    zval *result = NULL;
    ZEND_PARSE_PARAMETERS_START(1, 1)
        Z_PARAM_OBJECT(result)
    ZEND_PARSE_PARAMETERS_END();
    
    if (g_php2v_v_callback && result && Z_TYPE_P(result) == IS_OBJECT) {
        zval *z_handle = zend_read_property(Z_OBJCE_P(result), Z_OBJ_P(result), "handle", sizeof("handle") - 1, 1, NULL);
        zend_long handle_val = zval_get_long(z_handle);
        
        zval args;
        array_init(&args);
        zval z_res;
        ZVAL_LONG(&z_res, handle_val);
        add_next_index_zval(&args, &z_res);
        
        void* ret = g_php2v_v_callback("mysqli_fetch_row", sizeof("mysqli_fetch_row") - 1, &args);
        zval_ptr_dtor(&args);
        
        if (ret && Z_TYPE_P((zval*)ret) == IS_STRING) {
            php2v_parse_and_build_array(Z_STRVAL_P((zval*)ret), 2, return_value);
        } else {
            ZVAL_NULL(return_value);
        }
    } else {
        ZVAL_NULL(return_value);
    }
}

static void zif_php2v_mysqli_fetch_array(zend_execute_data *execute_data, zval *return_value) {
    zval *result = NULL;
    ZEND_PARSE_PARAMETERS_START(1, 2)
        Z_PARAM_OBJECT(result)
    ZEND_PARSE_PARAMETERS_END();
    
    if (g_php2v_v_callback && result && Z_TYPE_P(result) == IS_OBJECT) {
        zval *z_handle = zend_read_property(Z_OBJCE_P(result), Z_OBJ_P(result), "handle", sizeof("handle") - 1, 1, NULL);
        zend_long handle_val = zval_get_long(z_handle);
        
        zval args;
        array_init(&args);
        zval z_res;
        ZVAL_LONG(&z_res, handle_val);
        add_next_index_zval(&args, &z_res);
        
        void* ret = g_php2v_v_callback("mysqli_fetch_array", sizeof("mysqli_fetch_array") - 1, &args);
        zval_ptr_dtor(&args);
        
        if (ret && Z_TYPE_P((zval*)ret) == IS_STRING) {
            php2v_parse_and_build_array(Z_STRVAL_P((zval*)ret), 3, return_value);
        } else {
            ZVAL_NULL(return_value);
        }
    } else {
        ZVAL_NULL(return_value);
    }
}

static void zif_php2v_mysqli_num_rows(zend_execute_data *execute_data, zval *return_value) {
    zval *result = NULL;
    ZEND_PARSE_PARAMETERS_START(1, 1)
        Z_PARAM_OBJECT(result)
    ZEND_PARSE_PARAMETERS_END();
    
    if (g_php2v_v_callback && result && Z_TYPE_P(result) == IS_OBJECT) {
        zval *z_handle = zend_read_property(Z_OBJCE_P(result), Z_OBJ_P(result), "handle", sizeof("handle") - 1, 1, NULL);
        zend_long handle_val = zval_get_long(z_handle);
        
        zval args;
        array_init(&args);
        zval z_res;
        ZVAL_LONG(&z_res, handle_val);
        add_next_index_zval(&args, &z_res);
        
        void* ret = g_php2v_v_callback("mysqli_num_rows", sizeof("mysqli_num_rows") - 1, &args);
        zval_ptr_dtor(&args);
        
        if (ret) {
            *return_value = *(zval*)ret;
        } else {
            ZVAL_LONG(return_value, 0);
        }
    } else {
        ZVAL_LONG(return_value, 0);
    }
}


static void zif_php2v_mysqli_free_result(zend_execute_data *execute_data, zval *return_value) {
    ZVAL_TRUE(return_value);
}

static void zif_php2v_mysqli_close(zend_execute_data *execute_data, zval *return_value) {
    ZVAL_TRUE(return_value);
}

static void zif_php2v_mysqli_get_server_info(zend_execute_data *execute_data, zval *return_value) {
    ZVAL_STRING(return_value, "8.0.32-VPHP");
}

ZEND_BEGIN_ARG_INFO_EX(arginfo_mysqli_generic, 0, 0, 0)
ZEND_END_ARG_INFO()

static inline void php2v_register_sandbox_bridge() {
    static const zend_function_entry funcs[] = {
        {"vphp_call_v_native", zif_vphp_call_v_native, arginfo_vphp_call_v_native, 2, 0},
        {"mysqli_init", zif_php2v_mysqli_init, arginfo_mysqli_generic, 0, 0},
        {"mysqli_connect", zif_php2v_mysqli_init, arginfo_mysqli_generic, 0, 0},
        {"mysqli_real_connect", zif_php2v_mysqli_real_connect, arginfo_mysqli_generic, 0, 0},
        {"mysqli_query", zif_php2v_mysqli_query, arginfo_mysqli_generic, 0, 0},
        {"mysqli_report", zif_php2v_mysqli_report, arginfo_mysqli_generic, 0, 0},
        {"mysqli_connect_errno", zif_php2v_mysqli_connect_errno, arginfo_mysqli_generic, 0, 0},
        {"mysqli_connect_error", zif_php2v_mysqli_connect_error, arginfo_mysqli_generic, 0, 0},
        {"mysqli_error", zif_php2v_mysqli_error, arginfo_mysqli_generic, 0, 0},
        {"mysqli_errno", zif_php2v_mysqli_errno, arginfo_mysqli_generic, 0, 0},
        {"mysqli_select_db", zif_php2v_mysqli_select_db, arginfo_mysqli_generic, 0, 0},
        {"mysqli_set_charset", zif_php2v_mysqli_set_charset, arginfo_mysqli_generic, 0, 0},
        {"mysqli_real_escape_string", zif_php2v_mysqli_real_escape_string, arginfo_mysqli_generic, 0, 0},
        {"mysqli_fetch_assoc", zif_php2v_mysqli_fetch_assoc, arginfo_mysqli_generic, 0, 0},
        {"mysqli_fetch_row", zif_php2v_mysqli_fetch_row, arginfo_mysqli_generic, 0, 0},
        {"mysqli_fetch_array", zif_php2v_mysqli_fetch_array, arginfo_mysqli_generic, 0, 0},
        {"mysqli_fetch_object", zif_php2v_mysqli_fetch_object, arginfo_mysqli_generic, 0, 0},
        {"mysqli_num_rows", zif_php2v_mysqli_num_rows, arginfo_mysqli_generic, 0, 0},
        {"mysqli_free_result", zif_php2v_mysqli_free_result, arginfo_mysqli_generic, 0, 0},
        {"mysqli_close", zif_php2v_mysqli_close, arginfo_mysqli_generic, 0, 0},
        {"mysqli_get_server_info", zif_php2v_mysqli_get_server_info, arginfo_mysqli_generic, 0, 0},
        {"mysqli_more_results", zif_php2v_mysqli_more_results, arginfo_mysqli_generic, 0, 0},
        {"mysqli_next_result", zif_php2v_mysqli_next_result, arginfo_mysqli_generic, 0, 0},
        {"gzinflate", zif_php2v_gzinflate, arginfo_mysqli_generic, 0, 0},
        {NULL, NULL, NULL, 0, 0}
    };
    zend_register_functions(NULL, funcs, NULL, MODULE_PERSISTENT);

}
static inline int php2v_execute_file(const char* filepath) {
    php2v_register_persistent_constant("ABSPATH", "/Users/guweigang/wwwroot/wordpress/");
    php2v_register_persistent_constant("WP_USE_THEMES", "1");
    php2v_register_persistent_constant("MYSQLI_REPORT_OFF", "0");
    php2v_register_persistent_constant("MYSQLI_REPORT_ERROR", "1");
    php2v_register_persistent_constant("MYSQLI_REPORT_STRICT", "2");
    php2v_register_persistent_constant("MYSQLI_REPORT_ALL", "255");

    FILE *fp = fopen(filepath, "r");
    if (!fp) {
        printf("PHP2V ERROR - Cannot open file: %s\n", filepath);
        return -1;
    }

    zend_file_handle file_handle;
#if PHP_VERSION_ID >= 80100
    zend_stream_init_fp(&file_handle, fp, filepath);
#else
    memset(&file_handle, 0, sizeof(zend_file_handle));
    file_handle.type = ZEND_HANDLE_FP;
    file_handle.handle.fp = fp;
    file_handle.filename = filepath;
#endif

    zend_try {
        php_execute_script(&file_handle);
    } zend_catch {
        php2v_refresh_request();
    } zend_end_try();

    zend_destroy_file_handle(&file_handle);
    return 0;
}

static inline void php2v_exit() {
    zend_bailout();
}

static inline void php2v_run_entry(void *entry_fn) {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
	printf("[PHP2V_DEBUG] Before entry_fn\n");
	fflush(stdout);
	zend_try {
		((void (*)())entry_fn)();
		printf("[PHP2V_DEBUG] Normal end of entry_fn\n");
		fflush(stdout);
	} zend_catch {
		printf("[PHP2V_DEBUG] Caught zend_bailout!\n");
		fflush(stdout);
	} zend_end_try();
	printf("[PHP2V_DEBUG] After zend_try block\n");
	fflush(stdout);
}

static inline int php2v_get_response_status() {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
	return SG(sapi_headers).http_response_code;
}

static inline void php2v_get_response_headers(void (*callback)(const char *header_line, void *user_data), void *user_data) {
#ifdef ZTS
	ZEND_TSRMLS_CACHE_UPDATE();
#endif
	zend_llist_position pos;
	sapi_header_struct *h = (sapi_header_struct *)zend_llist_get_first_ex(&SG(sapi_headers).headers, &pos);
	while (h) {
		callback(h->header, user_data);
		h = (sapi_header_struct *)zend_llist_get_next_ex(&SG(sapi_headers).headers, &pos);
	}
}

static void* php2v_last_mysql_conn = NULL;
static inline void php2v_set_last_mysql_conn(void* conn) {
    php2v_last_mysql_conn = conn;
}
static inline void* php2v_get_last_mysql_conn() {
    return php2v_last_mysql_conn;
}

#endif
