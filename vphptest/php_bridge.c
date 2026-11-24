/* ⚠️ VPHP Compiler Generated for vphptest */
#include "php_bridge.h"

#include "../vphp/v_bridge.h"


typedef struct { void* str; int64_t len; int64_t is_lit; } v_string;

extern void _vinit_caller(void);
extern void _vcleanup_caller(void);
extern void vphp_framework_init(int module_number);
extern void vphp_framework_shutdown(void);
extern void vphp_framework_request_startup(void);
extern void vphp_framework_request_shutdown(void);
static const zend_internal_arg_info struct_closure_arginfo_callableprocessor_struct_closure_storage[] = {
{ (const char *)(uintptr_t)(2), ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0), NULL },
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, count, IS_LONG, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_callableprocessor_struct_closure = (void *)struct_closure_arginfo_callableprocessor_struct_closure_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_v_closure_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_MIXED, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_v_closure = (void *)struct_closure_arginfo_v_get_v_closure_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_v_closure_auto_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_MIXED, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_v_closure_auto = (void *)struct_closure_arginfo_v_get_v_closure_auto_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_closure_0_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_MIXED, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_closure_0 = (void *)struct_closure_arginfo_v_get_closure_0_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_closure_1_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_MIXED, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_closure_1 = (void *)struct_closure_arginfo_v_get_closure_1_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_closure_2_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_MIXED, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_closure_2 = (void *)struct_closure_arginfo_v_get_closure_2_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_closure_3_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_MIXED, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_closure_3 = (void *)struct_closure_arginfo_v_get_closure_3_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_closure_4_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_MIXED, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_closure_4 = (void *)struct_closure_arginfo_v_get_closure_4_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_closure_3_void_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_VOID, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_closure_3_void = (void *)struct_closure_arginfo_v_get_closure_3_void_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_closure_4_void_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_VOID, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_closure_4_void = (void *)struct_closure_arginfo_v_get_closure_4_void_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_struct_param_closure_storage[] = {
{ (const char *)(uintptr_t)(2), ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0), NULL },
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, count, IS_LONG, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_struct_param_closure = (void *)struct_closure_arginfo_v_get_struct_param_closure_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_struct_default_closure_storage[] = {
{ (const char *)(uintptr_t)(1), ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0), NULL },
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, count, IS_LONG, 0, "7")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, flag, _IS_BOOL, 0, "true")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, label, IS_STRING, 1, "null")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, computed, IS_LONG, 0, "new \\VPHP\\Internal\\vphptest_ClosureDefault(0, 4)")
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_struct_default_closure = (void *)struct_closure_arginfo_v_get_struct_default_closure_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_struct_default_closure_void_storage[] = {
{ (const char *)(uintptr_t)(1), ZEND_TYPE_INIT_CODE(IS_VOID, 0, 0), NULL },
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, count, IS_LONG, 0, "7")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, flag, _IS_BOOL, 0, "true")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, label, IS_STRING, 1, "null")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, computed, IS_LONG, 0, "new \\VPHP\\Internal\\vphptest_ClosureDefault(1, 4)")
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_struct_default_closure_void = (void *)struct_closure_arginfo_v_get_struct_default_closure_void_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_struct_computed_defaults_closure_storage[] = {
{ (const char *)(uintptr_t)(1), ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0), NULL },
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, first, IS_LONG, 0, "new \\VPHP\\Internal\\vphptest_ClosureDefault(2, 1)")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, second, IS_LONG, 1, "new \\VPHP\\Internal\\vphptest_ClosureDefault(2, 2)")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, flag, _IS_BOOL, 0, "true")
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_struct_computed_defaults_closure = (void *)struct_closure_arginfo_v_get_struct_computed_defaults_closure_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_struct_native_defaults_closure_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0), NULL },
{ "payload", ZEND_TYPE_INIT_CLASS_CONST("NativeClosurePayload", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), "new \\VPHP\\Internal\\vphptest_ClosureDefault(3, 0)" },
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, label, IS_STRING, 0, "'trailing'")
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_struct_native_defaults_closure = (void *)struct_closure_arginfo_v_get_struct_native_defaults_closure_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_struct_failing_defaults_closure_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0), NULL },
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, first, IS_LONG, 0, "new \\VPHP\\Internal\\vphptest_ClosureDefault(4, 0)")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, second, IS_LONG, 0, "new \\VPHP\\Internal\\vphptest_ClosureDefault(4, 1)")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, tail, _IS_BOOL, 0, "true")
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_struct_failing_defaults_closure = (void *)struct_closure_arginfo_v_get_struct_failing_defaults_closure_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_variadic_value_closure_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_variadic_value_closure = (void *)struct_closure_arginfo_v_get_variadic_value_closure_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_variadic_zval_closure_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_MIXED, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_variadic_zval_closure = (void *)struct_closure_arginfo_v_get_variadic_zval_closure_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_variadic_zval_void_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_VOID, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_variadic_zval_void = (void *)struct_closure_arginfo_v_get_variadic_zval_void_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_variadic_borrowed_closure_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_MIXED, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_variadic_borrowed_closure = (void *)struct_closure_arginfo_v_get_variadic_borrowed_closure_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_variadic_scalar_string_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_variadic_scalar_string = (void *)struct_closure_arginfo_v_get_variadic_scalar_string_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_variadic_scalar_i64_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_variadic_scalar_i64 = (void *)struct_closure_arginfo_v_get_variadic_scalar_i64_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_variadic_scalar_value_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_NONE(0), NULL },
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_variadic_scalar_value = (void *)struct_closure_arginfo_v_get_variadic_scalar_value_storage;
static const zend_internal_arg_info struct_closure_arginfo_v_get_struct_literal_defaults_closure_storage[] = {
{ (const char *)(uintptr_t)(0), ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0), NULL },
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, message, IS_STRING, 0, "\"a\\n\\t\\x00\\xe2\\x98\\xba\\$'\\\\\\\"\"")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, raw, IS_STRING, 0, "\"\\\\n\\${literal}\"")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, octal, IS_LONG, 0, "-15")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, binary, IS_LONG, 0, "161")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, floating, IS_DOUBLE, 0, "2.0")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, single, IS_DOUBLE, 0, "0.10000000149011612")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, option, IS_STRING, 1, "'present'")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, nullable, IS_LONG, 1, "null")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, items, IS_ARRAY, 0, "[1, 16]")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, empty, IS_ARRAY, 0, "[]")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, lookup, IS_ARRAY, 0, "['count' => 16]")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, tail, _IS_BOOL, 0, "true")
ZEND_END_ARG_INFO()
void *struct_closure_arginfo_v_get_struct_literal_defaults_closure = (void *)struct_closure_arginfo_v_get_struct_literal_defaults_closure_storage;
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_add, 0, 2, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, a, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, b, IS_LONG, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_add(vphp_context_internal ctx);
PHP_FUNCTION(v_add) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_add(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_greet, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_greet(vphp_context_internal ctx);
PHP_FUNCTION(v_greet) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_greet(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_float_const, 0, 0, IS_DOUBLE, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_float_const(vphp_context_internal ctx);
PHP_FUNCTION(v_float_const) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_float_const(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_float_id, 0, 1, IS_DOUBLE, 0)
ZEND_ARG_TYPE_INFO(0, x, IS_DOUBLE, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_float_id(vphp_context_internal ctx);
PHP_FUNCTION(v_float_id) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_float_id(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_pure_map_test, 0, 2, IS_ARRAY, 0)
ZEND_ARG_TYPE_INFO(0, k, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, v, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_pure_map_test(vphp_context_internal ctx);
PHP_FUNCTION(v_pure_map_test) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_pure_map_test(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_process_list, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_process_list(vphp_context_internal ctx);
PHP_FUNCTION(v_process_list) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_process_list(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_test_map, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_test_map(vphp_context_internal ctx);
PHP_FUNCTION(v_test_map) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_test_map(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_get_config, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_config(vphp_context_internal ctx);
PHP_FUNCTION(v_get_config) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_config(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_get_user, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_user(vphp_context_internal ctx);
PHP_FUNCTION(v_get_user) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_user(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_call_back, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_call_back(vphp_context_internal ctx);
PHP_FUNCTION(v_call_back) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_call_back(ctx);
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_bind_class_interface, 0, 2, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, className, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, ifaceName, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_bind_class_interface(vphp_context_internal ctx);
PHP_FUNCTION(v_bind_class_interface) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_bind_class_interface(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_complex_test, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_complex_test(vphp_context_internal ctx);
PHP_FUNCTION(v_complex_test) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_complex_test(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_persistent_nested_roundtrip, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_persistent_nested_roundtrip(vphp_context_internal ctx);
PHP_FUNCTION(v_persistent_nested_roundtrip) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_persistent_nested_roundtrip(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_persistent_multi_nested_stress, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_persistent_multi_nested_stress(vphp_context_internal ctx);
PHP_FUNCTION(v_persistent_multi_nested_stress) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_persistent_multi_nested_stress(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_analyze_user_object, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_analyze_user_object(vphp_context_internal ctx);
PHP_FUNCTION(v_analyze_user_object) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_analyze_user_object(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_mutate_user_object, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_mutate_user_object(vphp_context_internal ctx);
PHP_FUNCTION(v_mutate_user_object) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_mutate_user_object(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_check_user_object_props, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_check_user_object_props(vphp_context_internal ctx);
PHP_FUNCTION(v_check_user_object_props) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_check_user_object_props(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_construct_php_object, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_construct_php_object(vphp_context_internal ctx);
PHP_FUNCTION(v_construct_php_object) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_construct_php_object(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_call_php_static_method, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_call_php_static_method(vphp_context_internal ctx);
PHP_FUNCTION(v_call_php_static_method) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_call_php_static_method(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_mutate_php_static_prop, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_mutate_php_static_prop(vphp_context_internal ctx);
PHP_FUNCTION(v_mutate_php_static_prop) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_mutate_php_static_prop(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_read_php_class_constant, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_read_php_class_constant(vphp_context_internal ctx);
PHP_FUNCTION(v_read_php_class_constant) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_read_php_class_constant(ctx);
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_typed_php_interop, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, obj, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_typed_php_interop(vphp_context_internal ctx);
PHP_FUNCTION(v_typed_php_interop) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_typed_php_interop(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_typed_object_restore, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_typed_object_restore(vphp_context_internal ctx);
PHP_FUNCTION(v_typed_object_restore) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_typed_object_restore(ctx);
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_zval_conversion_api, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_zval_conversion_api(vphp_context_internal ctx);
PHP_FUNCTION(v_zval_conversion_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_zval_conversion_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_persistent_fallback_counter_probe, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_persistent_fallback_counter_probe(vphp_context_internal ctx);
PHP_FUNCTION(v_persistent_fallback_counter_probe) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_persistent_fallback_counter_probe(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_request_scope_counter_probe, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, rounds, IS_LONG, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_request_scope_counter_probe(vphp_context_internal ctx);
PHP_FUNCTION(v_request_scope_counter_probe) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_request_scope_counter_probe(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_value_zbox_lifecycle_probe, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_value_zbox_lifecycle_probe(vphp_context_internal ctx);
PHP_FUNCTION(v_php_value_zbox_lifecycle_probe) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_value_zbox_lifecycle_probe(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_unified_object_interop, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_unified_object_interop(vphp_context_internal ctx);
PHP_FUNCTION(v_unified_object_interop) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_unified_object_interop(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_php_class_named_api, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_class_named_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_class_named_api) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_class_named_api(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_php_function_named_api, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_function_named_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_function_named_api) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_function_named_api(ctx);
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_closure_api, 0, 1, IS_STRING, 0)
ZEND_ARG_CALLABLE_INFO(0, callback, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_closure_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_closure_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_closure_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_closure_persistent_api, 0, 1, IS_STRING, 0)
ZEND_ARG_CALLABLE_INFO(0, callback, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_closure_persistent_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_closure_persistent_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_closure_persistent_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_php_class_meta_api, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_class_meta_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_class_meta_api) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_class_meta_api(ctx);
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_object_api, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_object_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_object_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_object_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_array_api, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_array_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_array_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_array_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_callable_api, 0, 1, IS_STRING, 0)
ZEND_ARG_CALLABLE_INFO(0, callback, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_callable_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_callable_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_callable_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_value_api, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_value_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_value_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_value_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_scalar_api, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_scalar_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_scalar_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_scalar_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_scalar_strict_api, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_scalar_strict_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_scalar_strict_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_scalar_strict_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_semantic_empty_api, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_semantic_empty_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_semantic_empty_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_semantic_empty_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_params_struct_api, 0, 0, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, status, IS_LONG, 0, "200")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, reasonPhrase, IS_STRING, 0, "''")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, secure, _IS_BOOL, 0, "false")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, ratio, IS_DOUBLE, 0, "1.5")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_params_struct_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_params_struct_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_params_struct_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_computed_params, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, prefix, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, sequence, IS_LONG, 0, "new \\VPHP\\Internal\\vphptest_ClosureDefault(6, 1)")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, label, IS_STRING, 1, "new \\VPHP\\Internal\\vphptest_ClosureDefault(6, 2)")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, enabled, _IS_BOOL, 0, "true")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_computed_params(vphp_context_internal ctx);
PHP_FUNCTION(v_php_computed_params) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_computed_params(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_arg_binding_optional_scalar_api, 0, 0, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, count, IS_LONG, 0, "7")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, label, IS_STRING, 0, "\"fallback\"")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_arg_binding_optional_scalar_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_arg_binding_optional_scalar_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_arg_binding_optional_scalar_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_direct_arg_camel_api, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, firstName, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, defaultValue, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_direct_arg_camel_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_direct_arg_camel_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_direct_arg_camel_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_call_style_arg_attrs_api, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, valueAlias, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, optionalCount, IS_LONG, 0, "7")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_call_style_arg_attrs_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_call_style_arg_attrs_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_call_style_arg_attrs_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_semantic_params_struct_api, 0, 0, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, label, IS_STRING, 0, "''")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, flag, _IS_BOOL, 0, "false")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, items, IS_ARRAY, 0, "[]")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_semantic_params_struct_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_semantic_params_struct_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_semantic_params_struct_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_php_args_api, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_args_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_args_api) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_args_api(ctx);
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_resource_api, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_resource_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_resource_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_resource_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_wrapper_param_api, 0, 5, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, obj, IS_OBJECT, 0)
ZEND_ARG_TYPE_INFO(0, arr, IS_ARRAY, 0)
ZEND_ARG_CALLABLE_INFO(0, callable, 0)
ZEND_ARG_TYPE_INFO(0, nullValue, IS_NULL, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, maybeObj, IS_OBJECT, 1, "null")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_wrapper_param_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_wrapper_param_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_wrapper_param_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_optional_value_api, 0, 0, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, value, IS_MIXED, 1, "null")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_optional_value_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_optional_value_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_optional_value_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_optional_object_api, 0, 0, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, obj, IS_OBJECT, 1, "null")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_optional_object_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_optional_object_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_optional_object_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_return_value_api, 0, 1, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_return_value_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_return_value_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_return_value_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_return_array_api, 0, 1, IS_ARRAY, 0)
ZEND_ARG_TYPE_INFO(0, arr, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_return_array_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_return_array_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_return_array_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_return_object_api, 0, 1, IS_OBJECT, 0)
ZEND_ARG_TYPE_INFO(0, obj, IS_OBJECT, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_return_object_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_return_object_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_return_object_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_php_return_callable_api, 0, 0, 1)
ZEND_ARG_CALLABLE_INFO(0, callable, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_return_callable_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_return_callable_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_return_callable_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_return_string_wrapper_api, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_return_string_wrapper_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_return_string_wrapper_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_return_string_wrapper_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_return_persistent_array_api, 0, 1, IS_ARRAY, 0)
ZEND_ARG_TYPE_INFO(0, arr, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_return_persistent_array_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_return_persistent_array_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_return_persistent_array_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_dyn_value_runtime_refs, 0, 3, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, rawObj, IS_MIXED, 0)
ZEND_ARG_CALLABLE_INFO(0, callback, 0)
ZEND_ARG_TYPE_INFO(0, rawRes, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_dyn_value_runtime_refs(vphp_context_internal ctx);
PHP_FUNCTION(v_dyn_value_runtime_refs) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_dyn_value_runtime_refs(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_reference_api, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_reference_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_reference_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_reference_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_step_reference, 0, 2, IS_VOID, 0)
ZEND_ARG_TYPE_INFO(0, step, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(1, cursor, IS_LONG, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_step_reference(vphp_context_internal ctx);
PHP_FUNCTION(v_step_reference) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_step_reference(ctx);
    if (!EG(exception)) {
        vphp_mark_void_return(return_value);
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_optional_reference, 0, 0, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(1, cursor, IS_MIXED, 0, "null")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, label, IS_STRING, 1, "null")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_optional_reference(vphp_context_internal ctx);
PHP_FUNCTION(v_optional_reference) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_optional_reference(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_step_references, 0, 1, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, step, IS_LONG, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(1, cursors, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_step_references(vphp_context_internal ctx);
PHP_FUNCTION(v_step_references) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_step_references(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_replace_reference, 0, 2, IS_VOID, 0)
ZEND_ARG_TYPE_INFO(1, target, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, replacement, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_replace_reference(vphp_context_internal ctx);
PHP_FUNCTION(v_replace_reference) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_replace_reference(ctx);
    if (!EG(exception)) {
        vphp_mark_void_return(return_value);
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_iterable_api, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_iterable_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_iterable_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_iterable_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_superglobals_api, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_superglobals_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_superglobals_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_superglobals_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_throwable_api, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_throwable_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_throwable_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_throwable_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_enum_api, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_enum_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_enum_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_enum_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_unified_ownership_interop, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_unified_ownership_interop(vphp_context_internal ctx);
PHP_FUNCTION(v_unified_ownership_interop) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_unified_ownership_interop(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_read_php_global_const, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_read_php_global_const(vphp_context_internal ctx);
PHP_FUNCTION(v_read_php_global_const) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_read_php_global_const(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_php_symbol_exists, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_symbol_exists(vphp_context_internal ctx);
PHP_FUNCTION(v_php_symbol_exists) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_symbol_exists(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_include_php_file, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_include_php_file(vphp_context_internal ctx);
PHP_FUNCTION(v_include_php_file) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_include_php_file(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_include_php_file_once, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_include_php_file_once(vphp_context_internal ctx);
PHP_FUNCTION(v_include_php_file_once) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_include_php_file_once(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_include_php_module_demo, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_include_php_module_demo(vphp_context_internal ctx);
PHP_FUNCTION(v_include_php_module_demo) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_include_php_module_demo(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_php_object_meta, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_object_meta(vphp_context_internal ctx);
PHP_FUNCTION(v_php_object_meta) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_object_meta(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_php_object_introspection, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_object_introspection(vphp_context_internal ctx);
PHP_FUNCTION(v_php_object_introspection) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_object_introspection(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_php_array_introspection, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_array_introspection(vphp_context_internal ctx);
PHP_FUNCTION(v_php_array_introspection) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_array_introspection(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_php_object_probe, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_object_probe(vphp_context_internal ctx);
PHP_FUNCTION(v_php_object_probe) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_object_probe(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_trigger_user_action, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_trigger_user_action(vphp_context_internal ctx);
PHP_FUNCTION(v_trigger_user_action) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_trigger_user_action(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_call_php_closure, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_call_php_closure(vphp_context_internal ctx);
PHP_FUNCTION(v_call_php_closure) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_call_php_closure(ctx);
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_call_php_closure_helper, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, raw, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_call_php_closure_helper(vphp_context_internal ctx);
PHP_FUNCTION(v_call_php_closure_helper) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_call_php_closure_helper(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_test_globals, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_test_globals(vphp_context_internal ctx);
PHP_FUNCTION(v_test_globals) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_test_globals(ctx);
}
static const zend_internal_arg_info arginfo_v_get_v_closure[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_v_closure(vphp_context_internal ctx);
PHP_FUNCTION(v_get_v_closure) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_v_closure(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_v_closure_auto[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_v_closure_auto(vphp_context_internal ctx);
PHP_FUNCTION(v_get_v_closure_auto) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_v_closure_auto(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_iter_helpers_demo, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_iter_helpers_demo(vphp_context_internal ctx);
PHP_FUNCTION(v_iter_helpers_demo) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_iter_helpers_demo(ctx);
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_iterable_object_demo, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, input, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_iterable_object_demo(vphp_context_internal ctx);
PHP_FUNCTION(v_iterable_object_demo) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_iterable_object_demo(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_reverse_string, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_reverse_string(vphp_context_internal ctx);
PHP_FUNCTION(v_reverse_string) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_reverse_string(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_logic_main, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_logic_main(vphp_context_internal ctx);
PHP_FUNCTION(v_logic_main) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_logic_main(ctx);
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_invoke_callable, 0, 1, IS_STRING, 0)
ZEND_ARG_CALLABLE_INFO(0, callback, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_invoke_callable(vphp_context_internal ctx);
PHP_FUNCTION(v_invoke_callable) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_invoke_callable(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_invoke_with_arg, 0, 2, IS_STRING, 0)
ZEND_ARG_CALLABLE_INFO(0, callback, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_invoke_with_arg(vphp_context_internal ctx);
PHP_FUNCTION(v_invoke_with_arg) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_invoke_with_arg(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_closure_0[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_closure_0(vphp_context_internal ctx);
PHP_FUNCTION(v_get_closure_0) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_closure_0(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_closure_1[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_closure_1(vphp_context_internal ctx);
PHP_FUNCTION(v_get_closure_1) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_closure_1(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_closure_2[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_closure_2(vphp_context_internal ctx);
PHP_FUNCTION(v_get_closure_2) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_closure_2(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_closure_3[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_closure_3(vphp_context_internal ctx);
PHP_FUNCTION(v_get_closure_3) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_closure_3(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_closure_4[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_closure_4(vphp_context_internal ctx);
PHP_FUNCTION(v_get_closure_4) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_closure_4(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_closure_3_void[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_closure_3_void(vphp_context_internal ctx);
PHP_FUNCTION(v_get_closure_3_void) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_closure_3_void(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_closure_4_void[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_closure_4_void(vphp_context_internal ctx);
PHP_FUNCTION(v_get_closure_4_void) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_closure_4_void(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_struct_param_closure[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_struct_param_closure(vphp_context_internal ctx);
PHP_FUNCTION(v_get_struct_param_closure) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_struct_param_closure(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_struct_default_closure[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_struct_default_closure(vphp_context_internal ctx);
PHP_FUNCTION(v_get_struct_default_closure) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_struct_default_closure(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_struct_default_closure_void[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_struct_default_closure_void(vphp_context_internal ctx);
PHP_FUNCTION(v_get_struct_default_closure_void) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_struct_default_closure_void(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_struct_computed_defaults_closure[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_struct_computed_defaults_closure(vphp_context_internal ctx);
PHP_FUNCTION(v_get_struct_computed_defaults_closure) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_struct_computed_defaults_closure(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_struct_native_defaults_closure[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_struct_native_defaults_closure(vphp_context_internal ctx);
PHP_FUNCTION(v_get_struct_native_defaults_closure) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_struct_native_defaults_closure(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_struct_failing_defaults_closure[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_struct_failing_defaults_closure(vphp_context_internal ctx);
PHP_FUNCTION(v_get_struct_failing_defaults_closure) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_struct_failing_defaults_closure(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_invoke_legacy_struct_closure, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_invoke_legacy_struct_closure(vphp_context_internal ctx);
PHP_FUNCTION(v_invoke_legacy_struct_closure) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_invoke_legacy_struct_closure(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_invoke_legacy_struct_closure_void, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_invoke_legacy_struct_closure_void(vphp_context_internal ctx);
PHP_FUNCTION(v_invoke_legacy_struct_closure_void) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_invoke_legacy_struct_closure_void(ctx);
}
static const zend_internal_arg_info arginfo_v_get_variadic_value_closure[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_variadic_value_closure(vphp_context_internal ctx);
PHP_FUNCTION(v_get_variadic_value_closure) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_variadic_value_closure(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_variadic_zval_closure[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_variadic_zval_closure(vphp_context_internal ctx);
PHP_FUNCTION(v_get_variadic_zval_closure) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_variadic_zval_closure(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_variadic_zval_void[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_variadic_zval_void(vphp_context_internal ctx);
PHP_FUNCTION(v_get_variadic_zval_void) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_variadic_zval_void(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_variadic_borrowed_closure[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_variadic_borrowed_closure(vphp_context_internal ctx);
PHP_FUNCTION(v_get_variadic_borrowed_closure) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_variadic_borrowed_closure(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_variadic_scalar_string[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_variadic_scalar_string(vphp_context_internal ctx);
PHP_FUNCTION(v_get_variadic_scalar_string) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_variadic_scalar_string(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_variadic_scalar_i64[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_variadic_scalar_i64(vphp_context_internal ctx);
PHP_FUNCTION(v_get_variadic_scalar_i64) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_variadic_scalar_i64(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_variadic_scalar_value[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_variadic_scalar_value(vphp_context_internal ctx);
PHP_FUNCTION(v_get_variadic_scalar_value) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_variadic_scalar_value(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_invoke_legacy_variadic_scalar, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_invoke_legacy_variadic_scalar(vphp_context_internal ctx);
PHP_FUNCTION(v_invoke_legacy_variadic_scalar) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_invoke_legacy_variadic_scalar(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_invoke_legacy_variadic_scalar_alias, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_invoke_legacy_variadic_scalar_alias(vphp_context_internal ctx);
PHP_FUNCTION(v_invoke_legacy_variadic_scalar_alias) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_invoke_legacy_variadic_scalar_alias(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_invoke_legacy_variadic_void, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_invoke_legacy_variadic_void(vphp_context_internal ctx);
PHP_FUNCTION(v_invoke_legacy_variadic_void) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_invoke_legacy_variadic_void(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_invoke_legacy_variadic_void_alias, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_invoke_legacy_variadic_void_alias(vphp_context_internal ctx);
PHP_FUNCTION(v_invoke_legacy_variadic_void_alias) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_invoke_legacy_variadic_void_alias(ctx);
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_literal_params, 0, 0, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, message, IS_STRING, 0, "\"a\\n\\t\\x00\\xe2\\x98\\xba\\$'\\\\\\\"\"")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, raw, IS_STRING, 0, "\"\\\\n\\${literal}\"")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, octal, IS_LONG, 0, "-15")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, binary, IS_LONG, 0, "161")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, floating, IS_DOUBLE, 0, "2.0")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, single, IS_DOUBLE, 0, "0.10000000149011612")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, option, IS_STRING, 1, "'present'")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, nullable, IS_LONG, 1, "null")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, items, IS_ARRAY, 0, "[1, 16]")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, empty, IS_ARRAY, 0, "[]")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, lookup, IS_ARRAY, 0, "['count' => 16]")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, tail, _IS_BOOL, 0, "true")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_literal_params(vphp_context_internal ctx);
PHP_FUNCTION(v_php_literal_params) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_literal_params(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_get_struct_literal_defaults_closure[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_struct_literal_defaults_closure(vphp_context_internal ctx);
PHP_FUNCTION(v_get_struct_literal_defaults_closure) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_struct_literal_defaults_closure(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_overridden_params, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, prefix, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, option, IS_STRING, 1, "\"php\\tvalue\"")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, spacer, IS_STRING, 0, "'native spacer'")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, count, IS_LONG, 0, "VPHP_PARAMS_OVERRIDE_COUNT")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, nullable, IS_STRING, 1, "null")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, items, IS_ARRAY, 0, "[1, 2]")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, tail, _IS_BOOL, 0, "true")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_overridden_params(vphp_context_internal ctx);
PHP_FUNCTION(v_php_overridden_params) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_overridden_params(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_direct_defaults, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, prefix, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, count, IS_LONG, 0, "VPHP_ORDINARY_ARG_COUNT")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, values, IS_ARRAY, 1, "[1, VPHP_ORDINARY_ARG_COUNT]")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, label, IS_STRING, 1, "\"fallback\"")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, enabled, _IS_BOOL, 0, "true")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_direct_defaults(vphp_context_internal ctx);
PHP_FUNCTION(v_php_direct_defaults) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_direct_defaults(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_legacy_optional_tail, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, before, IS_LONG, 0, "5")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, blocked, IS_LONG, 0, "9")
ZEND_ARG_TYPE_INFO(0, tail, IS_LONG, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_legacy_optional_tail(vphp_context_internal ctx);
PHP_FUNCTION(v_php_legacy_optional_tail) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_legacy_optional_tail(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_lifecycle_hook_state, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_lifecycle_hook_state(vphp_context_internal ctx);
PHP_FUNCTION(v_lifecycle_hook_state) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_lifecycle_hook_state(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_test_concurrent_object_roots, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_test_concurrent_object_roots(vphp_context_internal ctx);
PHP_FUNCTION(v_test_concurrent_object_roots) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_test_concurrent_object_roots(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_find_after, 0, 2, IS_STRING, 1)
ZEND_ARG_TYPE_INFO(0, haystack, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, needle, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_find_after(vphp_context_internal ctx);
PHP_FUNCTION(v_find_after) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_find_after(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_try_divide, 0, 2, IS_LONG, 1)
ZEND_ARG_TYPE_INFO(0, a, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, b, IS_LONG, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_try_divide(vphp_context_internal ctx);
PHP_FUNCTION(v_try_divide) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_try_divide(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_record_match, 0, 0, 3)
ZEND_ARG_TYPE_INFO(0, path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, haystack, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, needle, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_record_match(vphp_context_internal ctx);
PHP_FUNCTION(v_record_match) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_record_match(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_typed_raw_string_param, 0, 0, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, text, IS_STRING, 0, "\"C:\\\\tmp\\\\\\$HOME\"")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_typed_raw_string_param(vphp_context_internal ctx);
PHP_FUNCTION(v_typed_raw_string_param) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_typed_raw_string_param(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_typed_alias_bool_param, 0, 0, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, enabled, _IS_BOOL, 0, "true")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_typed_alias_bool_param(vphp_context_internal ctx);
PHP_FUNCTION(v_typed_alias_bool_param) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_typed_alias_bool_param(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_typed_bool_params, 0, 0, IS_LONG, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, firstFlag, _IS_BOOL, 0, "true")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, secondFlag, _IS_BOOL, 0, "false")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_typed_bool_params(vphp_context_internal ctx);
PHP_FUNCTION(v_typed_bool_params) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_typed_bool_params(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_compiler_probe, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_compiler_probe(vphp_context_internal ctx);
PHP_FUNCTION(v_compiler_probe) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_compiler_probe(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_compiler_probe_named_sum[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST_MASK("VPHP\\Compiler\\ModuleProbeKind|VPHP\\Compiler\\ModuleProbeReadOnlyBox|VPHP\\Compiler\\OtherProbeKind", MAY_BE_LONG | MAY_BE_NULL | _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
{ "value", ZEND_TYPE_INIT_CLASS_CONST_MASK("VPHP\\Compiler\\ModuleProbeKind|VPHP\\Compiler\\ModuleProbeReadOnlyBox|VPHP\\Compiler\\OtherProbeKind", MAY_BE_LONG | MAY_BE_NULL | _ZEND_ARG_INFO_FLAGS(0, 0, 0)), "null" },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_compiler_probe_named_sum(vphp_context_internal ctx);
PHP_FUNCTION(v_compiler_probe_named_sum) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_compiler_probe_named_sum(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_internal_arg_info arginfo_v_compiler_probe_explicit_union[] = {
    { (const char*)(uintptr_t)(1), ZEND_TYPE_INIT_CLASS_CONST_MASK("VPHP\\Compiler\\ModuleProbeKind|VPHP\\Compiler\\OtherProbeKind", _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
{ "value", ZEND_TYPE_INIT_CLASS_CONST_MASK("VPHP\\Compiler\\ModuleProbeKind|VPHP\\Compiler\\OtherProbeKind", _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_compiler_probe_explicit_union(vphp_context_internal ctx);
PHP_FUNCTION(v_compiler_probe_explicit_union) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_compiler_probe_explicit_union(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static zend_internal_arg_info arginfo_v_compiler_probe_intersection[] = {
    { (const char*)(uintptr_t)(1), ZEND_TYPE_INIT_MASK(MAY_BE_ANY | _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
{ "value", ZEND_TYPE_INIT_MASK(MAY_BE_ANY | _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_compiler_probe_intersection(vphp_context_internal ctx);
PHP_FUNCTION(v_compiler_probe_intersection) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_compiler_probe_intersection(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static zend_internal_arg_info arginfo_v_compiler_probe_wrong_dnf_return[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_MASK(MAY_BE_ANY | _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_compiler_probe_wrong_dnf_return(vphp_context_internal ctx);
PHP_FUNCTION(v_compiler_probe_wrong_dnf_return) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_compiler_probe_wrong_dnf_return(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_compiler_probe_variadic, 0, 0, IS_LONG, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_LONG, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_compiler_probe_variadic(vphp_context_internal ctx);
PHP_FUNCTION(v_compiler_probe_variadic) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_compiler_probe_variadic(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_compiler_probe_options, 0, 0, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, prefix, IS_STRING, 0, "'default'")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, count, IS_LONG, 0, "3")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_compiler_probe_options(vphp_context_internal ctx);
PHP_FUNCTION(v_compiler_probe_options) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_compiler_probe_options(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_typed_string_param, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, prefix, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, defaultValue, IS_STRING, 0, "\"line\\n\\\"\\\\\\${token}\\xe9\\x9b\\xaa\\x00\"")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, suffix, IS_STRING, 0, "\"\"")
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_typed_string_param(vphp_context_internal ctx);
PHP_FUNCTION(v_typed_string_param) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_typed_string_param(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_typed_required_string_param, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, text, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_typed_required_string_param(vphp_context_internal ctx);
PHP_FUNCTION(v_typed_required_string_param) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_typed_required_string_param(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_new_coach, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_new_coach(vphp_context_internal ctx);
PHP_FUNCTION(v_new_coach) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_new_coach(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_new_db, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_new_db(vphp_context_internal ctx);
PHP_FUNCTION(v_new_db) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_new_db(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_check_res, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_check_res(vphp_context_internal ctx);
PHP_FUNCTION(v_check_res) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_check_res(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_safe_divide, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, a, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, b, IS_LONG, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_safe_divide(vphp_context_internal ctx);
PHP_FUNCTION(v_safe_divide) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_safe_divide(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_capitalize, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, input, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_capitalize(vphp_context_internal ctx);
PHP_FUNCTION(v_capitalize) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_capitalize(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_record_success, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, path, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, label, IS_STRING, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_record_success(vphp_context_internal ctx);
PHP_FUNCTION(v_record_success) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_record_success(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_v_php_param_attr_api, 0, 2, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, query, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, page, IS_LONG, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_param_attr_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_param_attr_api) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_param_attr_api(ctx);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_php_arg_attr_runtime_api, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_php_arg_attr_runtime_api(vphp_context_internal ctx);
PHP_FUNCTION(v_php_arg_attr_runtime_api) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_php_arg_attr_runtime_api(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_analyze_fitness_data, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_analyze_fitness_data(vphp_context_internal ctx);
PHP_FUNCTION(v_analyze_fitness_data) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_analyze_fitness_data(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_get_alerts, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_alerts(vphp_context_internal ctx);
PHP_FUNCTION(v_get_alerts) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_alerts(ctx);
}
zend_class_entry *contentcontract_ce = NULL;
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_contentcontract_save, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_contentcontract_get_formatted_title, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
static const zend_function_entry contentcontract_methods[] = {
    VPHP_ZEND_RAW_FENTRY("save", NULL, arginfo_contentcontract_save, ZEND_ACC_PUBLIC | ZEND_ACC_ABSTRACT)
    VPHP_ZEND_RAW_FENTRY("get_formatted_title", NULL, arginfo_contentcontract_get_formatted_title, ZEND_ACC_PUBLIC | ZEND_ACC_ABSTRACT)
    PHP_FE_END
};

static int contentcontract_register_class(void) {
    if (contentcontract_ce != NULL) {
        return SUCCESS;
    }
    contentcontract_ce = vphp_find_loaded_class_entry("ContentContract", sizeof("ContentContract")-1);
    if (contentcontract_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "ContentContract", contentcontract_methods);
        contentcontract_ce = zend_register_internal_interface(&ce);
    }
    return SUCCESS;
}
zend_class_entry *demo__contracts__namedcontract_ce = NULL;

static const zend_function_entry demo__contracts__namedcontract_methods[] = {
    PHP_FE_END
};

static int demo__contracts__namedcontract_register_class(void) {
    if (demo__contracts__namedcontract_ce != NULL) {
        return SUCCESS;
    }
    demo__contracts__namedcontract_ce = vphp_find_loaded_class_entry("Demo\\Contracts\\NamedContract", sizeof("Demo\\Contracts\\NamedContract")-1);
    if (demo__contracts__namedcontract_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Demo\\Contracts\\NamedContract", demo__contracts__namedcontract_methods);
        demo__contracts__namedcontract_ce = zend_register_internal_interface(&ce);
    }
    return SUCCESS;
}
zend_class_entry *demo__contracts__aliascontract_ce = NULL;
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_demo__contracts__aliascontract_ping, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
static const zend_function_entry demo__contracts__aliascontract_methods[] = {
    VPHP_ZEND_RAW_FENTRY("ping", NULL, arginfo_demo__contracts__aliascontract_ping, ZEND_ACC_PUBLIC | ZEND_ACC_ABSTRACT)
    PHP_FE_END
};

static int demo__contracts__aliascontract_register_class(void) {
    if (demo__contracts__aliascontract_ce != NULL) {
        return SUCCESS;
    }
    demo__contracts__aliascontract_ce = vphp_find_loaded_class_entry("Demo\\Contracts\\AliasContract", sizeof("Demo\\Contracts\\AliasContract")-1);
    if (demo__contracts__aliascontract_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Demo\\Contracts\\AliasContract", demo__contracts__aliascontract_methods);
        demo__contracts__aliascontract_ce = zend_register_internal_interface(&ce);
        zend_class_entry *iface_0_ce = vphp_require_class_entry("Demo\\Contracts\\NamedContract", sizeof("Demo\\Contracts\\NamedContract")-1, 0);
        if (!iface_0_ce) {
            zend_error(E_CORE_WARNING, "Cannot register %s: interface %s was not found", "Demo\\Contracts\\AliasContract", "Demo\\Contracts\\NamedContract");
            return FAILURE;
        }
        vphp_verify_interface_reference_methods(demo__contracts__aliascontract_ce, iface_0_ce);
#if PHP_VERSION_ID >= 80400
        vphp_verify_interface_restricted_hooks(demo__contracts__aliascontract_ce, iface_0_ce);
#endif
        zend_class_implements(demo__contracts__aliascontract_ce, 1, iface_0_ce);
        vphp_prepare_class_constant_cache(demo__contracts__aliascontract_ce);
    }
    return SUCCESS;
}
zend_class_entry *vphp__compiler__moduleprobecontract_ce = NULL;
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp__compiler__moduleprobecontract_label, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
static const zend_function_entry vphp__compiler__moduleprobecontract_methods[] = {
    VPHP_ZEND_RAW_FENTRY("label", NULL, arginfo_vphp__compiler__moduleprobecontract_label, ZEND_ACC_PUBLIC | ZEND_ACC_ABSTRACT)
    PHP_FE_END
};

static int vphp__compiler__moduleprobecontract_register_class(void) {
    if (vphp__compiler__moduleprobecontract_ce != NULL) {
        return SUCCESS;
    }
    vphp__compiler__moduleprobecontract_ce = vphp_find_loaded_class_entry("VPHP\\Compiler\\ModuleProbeContract", sizeof("VPHP\\Compiler\\ModuleProbeContract")-1);
    if (vphp__compiler__moduleprobecontract_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VPHP\\Compiler\\ModuleProbeContract", vphp__compiler__moduleprobecontract_methods);
        vphp__compiler__moduleprobecontract_ce = zend_register_internal_interface(&ce);
    }
    return SUCCESS;
}
zend_class_entry *abstractreport_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_abstractreport___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_abstractreport_label, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_abstractreport_summarize, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(AbstractReport, label) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_abstract_report_label(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* abstract_report_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, abstract_report_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_abstract_report_label(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

ZEND_NAMED_FUNCTION(ZEND_MN(AbstractReport___construct)) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* abstract_report_handlers();
    vphp_class_handlers *h = abstract_report_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

static const zend_function_entry abstractreport_methods[] = {
    PHP_ME(AbstractReport, __construct, arginfo_abstractreport___construct, ZEND_ACC_PUBLIC)
    PHP_ME(AbstractReport, label, arginfo_abstractreport_label, ZEND_ACC_PUBLIC)
    VPHP_ZEND_RAW_FENTRY("summarize", NULL, arginfo_abstractreport_summarize, ZEND_ACC_PUBLIC | ZEND_ACC_ABSTRACT)
    PHP_FE_END
};

static int abstractreport_register_class(void) {
    if (abstractreport_ce != NULL) {
        return SUCCESS;
    }
    abstractreport_ce = vphp_find_loaded_class_entry("AbstractReport", sizeof("AbstractReport")-1);
    if (abstractreport_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "AbstractReport", abstractreport_methods);
        abstractreport_ce = zend_register_internal_class(&ce);
        abstractreport_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE | ZEND_ACC_EXPLICIT_ABSTRACT_CLASS;
        abstractreport_ce->create_object = vphp_create_object_handler;
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("title", sizeof("title")-1, 1);
            zend_declare_typed_property(abstractreport_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
    }
    return SUCCESS;
}
zend_class_entry *dailyreport_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_dailyreport___construct, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, title, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, summary, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_dailyreport_summarize, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(DailyReport, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* daily_report_handlers();
    vphp_class_handlers *h = daily_report_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_daily_report_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_daily_report_construct(v_ptr, ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(DailyReport, summarize) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_daily_report_summarize(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* daily_report_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, daily_report_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_daily_report_summarize(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry dailyreport_methods[] = {
    PHP_ME(DailyReport, __construct, arginfo_dailyreport___construct, ZEND_ACC_PUBLIC)
    PHP_ME(DailyReport, summarize, arginfo_dailyreport_summarize, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int dailyreport_register_class(void) {
    if (dailyreport_ce != NULL) {
        return SUCCESS;
    }
    dailyreport_ce = vphp_find_loaded_class_entry("DailyReport", sizeof("DailyReport")-1);
    if (dailyreport_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "DailyReport", dailyreport_methods);
        zend_class_entry *parent_ce = vphp_require_class_entry("AbstractReport", sizeof("AbstractReport")-1, 0);
        if (!parent_ce) {
            zend_error(E_CORE_WARNING, "Cannot register %s: parent class %s was not found", "DailyReport", "AbstractReport");
            return FAILURE;
        }
        vphp_verify_parent_reference_methods(&ce, parent_ce);
        dailyreport_ce = zend_register_internal_class_ex(&ce, parent_ce);
        dailyreport_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        dailyreport_ce->create_object = vphp_create_object_handler;
#if PHP_VERSION_ID >= 80400
        vphp_prepare_backed_property(dailyreport_ce, "summary", sizeof("summary")-1);
#endif
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("summary", sizeof("summary")-1, 1);
            zend_declare_typed_property(dailyreport_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
#if PHP_VERSION_ID >= 80400
        {
            static zend_function *inherited_hooks[ZEND_PROPERTY_HOOK_COUNT];
            vphp_inherit_backed_property_contract(dailyreport_ce, "summary", sizeof("summary")-1, inherited_hooks);
        }
#endif
        }
        vphp_prepare_class_constant_cache(dailyreport_ce);
#if PHP_VERSION_ID >= 80400
        vphp_verify_interface_property_contracts(dailyreport_ce, false);
#endif
    }
    return SUCCESS;
}
zend_class_entry *author_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_author___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
static const zend_internal_arg_info arginfo_author_create[] = {
    { (const char*)(uintptr_t)(1), ZEND_TYPE_INIT_CLASS_CONST("Author", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_author_get_name, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(Author, create) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void* vphp_wrap_author_create(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_author_create(ctx);
    if (EG(exception)) {
        return;
    }
    extern vphp_class_handlers* author_handlers();
    vphp_return_owned_object(return_value, v_instance, author_ce, author_handlers());
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Author, get_name) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_author_get_name(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* author_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, author_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_author_get_name(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

ZEND_NAMED_FUNCTION(ZEND_MN(Author___construct)) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* author_handlers();
    vphp_class_handlers *h = author_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

static const zend_function_entry author_methods[] = {
    PHP_ME(Author, __construct, arginfo_author___construct, ZEND_ACC_PUBLIC)
    PHP_ME(Author, create, arginfo_author_create, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(Author, get_name, arginfo_author_get_name, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int author_register_class(void) {
    if (author_ce != NULL) {
        return SUCCESS;
    }
    author_ce = vphp_find_loaded_class_entry("Author", sizeof("Author")-1);
    if (author_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Author", author_methods);
        author_ce = zend_register_internal_class(&ce);
        author_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        author_ce->create_object = vphp_create_object_handler;
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("name", sizeof("name")-1, 1);
            zend_declare_typed_property(author_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
    }
    return SUCCESS;
}
zend_class_entry *post_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_post___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
static const zend_internal_arg_info arginfo_post_set_author[] = {
    { (const char*)(uintptr_t)(1), ZEND_TYPE_INIT_CODE(IS_VOID, 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
{ "author", ZEND_TYPE_INIT_CLASS_CONST("Author", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
static const zend_internal_arg_info arginfo_post_get_author[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Author", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
PHP_METHOD(Post, set_author) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_post_set_author(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* post_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, post_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_NULL();
    }
    vphp_wrap_post_set_author(wrapper->v_ptr, ctx);
    if (!EG(exception)) {
        vphp_mark_void_return(return_value);
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

PHP_METHOD(Post, get_author) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void* vphp_wrap_post_get_author(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* post_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, post_handlers());
    // printf("PHP_METHOD Post::get_author called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_NULL();
    }
    void* v_instance = vphp_wrap_post_get_author(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    extern vphp_class_handlers* author_handlers();
    vphp_return_bound_object(return_value, v_instance, author_ce, author_handlers(), VPHP_BORROWS_VPTR);
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}


ZEND_NAMED_FUNCTION(ZEND_MN(Post___construct)) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* post_handlers();
    vphp_class_handlers *h = post_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

static const zend_function_entry post_methods[] = {
    PHP_ME(Post, __construct, arginfo_post___construct, ZEND_ACC_PUBLIC)
    PHP_ME(Post, set_author, arginfo_post_set_author, ZEND_ACC_PUBLIC)
    PHP_ME(Post, get_author, arginfo_post_get_author, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int post_register_class(void) {
    if (post_ce != NULL) {
        return SUCCESS;
    }
    post_ce = vphp_find_loaded_class_entry("Post", sizeof("Post")-1);
    if (post_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Post", post_methods);
        post_ce = zend_register_internal_class(&ce);
        post_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        post_ce->create_object = vphp_create_object_handler;
        {
            zval default_val;
            ZVAL_LONG(&default_val, 0);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_string *property_name = zend_string_init_interned("post_id", sizeof("post_id")-1, 1);
            zend_declare_typed_property(post_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
        zend_declare_property_null(post_ce, "author", sizeof("author")-1, ZEND_ACC_PUBLIC);
    }
    return SUCCESS;
}
zend_class_entry *article_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_article___construct, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, title, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, id, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_article_internal_format, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
static const zend_internal_arg_info arginfo_article_create[] = {
    { (const char*)(uintptr_t)(1), ZEND_TYPE_INIT_CLASS_CONST("Article", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_ARG_TYPE_INFO(0, title, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_article_get_formatted_title, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_article_save, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_article_dump_properties, 0, 1, IS_VOID, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_article_process_with_callback, 0, 1, _IS_BOOL, 0)
ZEND_ARG_CALLABLE_INFO(0, callback, 0)
ZEND_END_ARG_INFO()
static const zend_internal_arg_info arginfo_article_restore_author[] = {
    { (const char*)(uintptr_t)(1), ZEND_TYPE_INIT_CLASS_CONST("Author", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_ARG_TYPE_INFO(0, authorVal, IS_MIXED, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(Article, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* article_handlers();
    vphp_class_handlers *h = article_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_article_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_article_construct(v_ptr, ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Article, internal_format) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_article_internal_format(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* article_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, article_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_article_internal_format(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Article, create) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void* vphp_wrap_article_create(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_article_create(ctx);
    if (EG(exception)) {
        return;
    }
    extern vphp_class_handlers* article_handlers();
    vphp_return_owned_object(return_value, v_instance, article_ce, article_handlers());
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Article, get_formatted_title) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_article_get_formatted_title(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* article_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, article_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_article_get_formatted_title(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Article, save) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_article_save(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* article_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, article_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_article_save(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Article, dump_properties) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_article_dump_properties(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* article_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, article_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_NULL();
    }
    vphp_wrap_article_dump_properties(wrapper->v_ptr, ctx);
    if (!EG(exception)) {
        vphp_mark_void_return(return_value);
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Article, process_with_callback) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_article_process_with_callback(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* article_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, article_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_article_process_with_callback(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Article, restore_author) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void* vphp_wrap_article_restore_author(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_article_restore_author(ctx);
    if (EG(exception)) {
        return;
    }
    extern vphp_class_handlers* author_handlers();
    vphp_return_bound_object(return_value, v_instance, author_ce, author_handlers(), VPHP_OWNS_VPTR);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry article_methods[] = {
    PHP_ME(Article, __construct, arginfo_article___construct, ZEND_ACC_PUBLIC)
    PHP_ME(Article, internal_format, arginfo_article_internal_format, ZEND_ACC_PROTECTED)
    PHP_ME(Article, create, arginfo_article_create, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(Article, get_formatted_title, arginfo_article_get_formatted_title, ZEND_ACC_PUBLIC)
    PHP_ME(Article, save, arginfo_article_save, ZEND_ACC_PUBLIC)
    PHP_ME(Article, dump_properties, arginfo_article_dump_properties, ZEND_ACC_PUBLIC)
    PHP_ME(Article, process_with_callback, arginfo_article_process_with_callback, ZEND_ACC_PUBLIC)
    PHP_ME(Article, restore_author, arginfo_article_restore_author, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_FE_END
};

static int article_register_class(void) {
    if (article_ce != NULL) {
        return SUCCESS;
    }
    article_ce = vphp_find_loaded_class_entry("Article", sizeof("Article")-1);
    if (article_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Article", article_methods);
        zend_class_entry *parent_ce = vphp_require_class_entry("Post", sizeof("Post")-1, 0);
        if (!parent_ce) {
            zend_error(E_CORE_WARNING, "Cannot register %s: parent class %s was not found", "Article", "Post");
            return FAILURE;
        }
        vphp_verify_parent_reference_methods(&ce, parent_ce);
        article_ce = zend_register_internal_class(&ce);
        {
            zval val;
            ZVAL_LONG(&val, 1024);
            zend_string *const_name = zend_string_init("MAX_TITLE_LEN", 13, 1);
#if PHP_VERSION_ID >= 80300
            zend_type constant_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_declare_typed_class_constant(article_ce, const_name, &val, ZEND_ACC_PUBLIC, NULL, constant_type);
#else
            zend_declare_class_constant_ex(article_ce, const_name, &val, ZEND_ACC_PUBLIC, NULL);
#endif
            zend_string_release(const_name);
        }
        {
            zval val;
            ZVAL_STR(&val, zend_string_init("Samantha Black", 14, 1));
            zend_string *const_name = zend_string_init("NAME", 4, 1);
#if PHP_VERSION_ID >= 80300
            zend_type constant_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_declare_typed_class_constant(article_ce, const_name, &val, ZEND_ACC_PUBLIC, NULL, constant_type);
#else
            zend_declare_class_constant_ex(article_ce, const_name, &val, ZEND_ACC_PUBLIC, NULL);
#endif
            zend_string_release(const_name);
        }
        {
            zval val;
            ZVAL_LONG(&val, 24);
            zend_string *const_name = zend_string_init("AGE", 3, 1);
#if PHP_VERSION_ID >= 80300
            zend_type constant_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_declare_typed_class_constant(article_ce, const_name, &val, ZEND_ACC_PUBLIC, NULL, constant_type);
#else
            zend_declare_class_constant_ex(article_ce, const_name, &val, ZEND_ACC_PUBLIC, NULL);
#endif
            zend_string_release(const_name);
        }
        vphp_inherit_class_before_properties(article_ce, parent_ce);
        article_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        article_ce->create_object = vphp_create_object_handler;
#if PHP_VERSION_ID >= 80400
        vphp_prepare_backed_property(article_ce, "created_at", sizeof("created_at")-1);
#endif
        {
            zval default_val;
            ZVAL_LONG(&default_val, 0);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_string *property_name = zend_string_init_interned("created_at", sizeof("created_at")-1, 1);
            zend_declare_typed_property(article_ce, property_name, &default_val, ZEND_ACC_PUBLIC | ZEND_ACC_READONLY, NULL, property_type);
#if PHP_VERSION_ID >= 80400
        {
            static zend_function *inherited_hooks[ZEND_PROPERTY_HOOK_COUNT];
            vphp_inherit_backed_property_contract(article_ce, "created_at", sizeof("created_at")-1, inherited_hooks);
        }
#endif
        }
#if PHP_VERSION_ID >= 80400
        vphp_prepare_backed_property(article_ce, "id", sizeof("id")-1);
#endif
        {
            zval default_val;
            ZVAL_LONG(&default_val, 0);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_string *property_name = zend_string_init_interned("id", sizeof("id")-1, 1);
            zend_declare_typed_property(article_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
#if PHP_VERSION_ID >= 80400
        {
            static zend_function *inherited_hooks[ZEND_PROPERTY_HOOK_COUNT];
            vphp_inherit_backed_property_contract(article_ce, "id", sizeof("id")-1, inherited_hooks);
        }
#endif
        }
#if PHP_VERSION_ID >= 80400
        vphp_prepare_backed_property(article_ce, "title", sizeof("title")-1);
#endif
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("title", sizeof("title")-1, 1);
            zend_declare_typed_property(article_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
#if PHP_VERSION_ID >= 80400
        {
            static zend_function *inherited_hooks[ZEND_PROPERTY_HOOK_COUNT];
            vphp_inherit_backed_property_contract(article_ce, "title", sizeof("title")-1, inherited_hooks);
        }
#endif
        }
#if PHP_VERSION_ID >= 80400
        vphp_prepare_backed_property(article_ce, "is_top", sizeof("is_top")-1);
#endif
        {
            zval default_val;
            ZVAL_FALSE(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(_IS_BOOL, 0, 0);
            zend_string *property_name = zend_string_init_interned("is_top", sizeof("is_top")-1, 1);
            zend_declare_typed_property(article_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
#if PHP_VERSION_ID >= 80400
        {
            static zend_function *inherited_hooks[ZEND_PROPERTY_HOOK_COUNT];
            vphp_inherit_backed_property_contract(article_ce, "is_top", sizeof("is_top")-1, inherited_hooks);
        }
#endif
        }
#if PHP_VERSION_ID >= 80400
        vphp_prepare_backed_property(article_ce, "content", sizeof("content")-1);
#endif
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("content", sizeof("content")-1, 1);
            zend_declare_typed_property(article_ce, property_name, &default_val, ZEND_ACC_PROTECTED, NULL, property_type);
#if PHP_VERSION_ID >= 80400
        {
            static zend_function *inherited_hooks[ZEND_PROPERTY_HOOK_COUNT];
            vphp_inherit_backed_property_contract(article_ce, "content", sizeof("content")-1, inherited_hooks);
        }
#endif
        }
#if PHP_VERSION_ID >= 80400
        vphp_prepare_backed_property(article_ce, "total_count", sizeof("total_count")-1);
#endif
        {
            zval default_val;
            ZVAL_LONG(&default_val, 0);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_string *property_name = zend_string_init_interned("total_count", sizeof("total_count")-1, 1);
            zend_declare_typed_property(article_ce, property_name, &default_val, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC, NULL, property_type);
#if PHP_VERSION_ID >= 80400
        {
            static zend_function *inherited_hooks[ZEND_PROPERTY_HOOK_COUNT];
            vphp_inherit_backed_property_contract(article_ce, "total_count", sizeof("total_count")-1, inherited_hooks);
        }
#endif
        }
        static const vphp_php_property_names property_names = {
            "\000", "total_count\000", NULL
        };
        vphp_register_php_property_storage(article_ce, &property_names);
        zend_class_entry *iface_0_ce = vphp_require_class_entry("ContentContract", sizeof("ContentContract")-1, 0);
        if (!iface_0_ce) {
            zend_error(E_CORE_WARNING, "Cannot register %s: interface %s was not found", "Article", "ContentContract");
            return FAILURE;
        }
        vphp_verify_interface_reference_methods(article_ce, iface_0_ce);
#if PHP_VERSION_ID >= 80400
        vphp_verify_interface_restricted_hooks(article_ce, iface_0_ce);
#endif
        zend_class_implements(article_ce, 1, iface_0_ce);
        vphp_prepare_class_constant_cache(article_ce);
#if PHP_VERSION_ID >= 80400
        vphp_verify_interface_property_contracts(article_ce, false);
#endif
    }
    return SUCCESS;
}
zend_class_entry *story_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_story___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
static const zend_internal_arg_info arginfo_story_create[] = {
    { (const char*)(uintptr_t)(2), ZEND_TYPE_INIT_CLASS_CONST("Story", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
{ "author", ZEND_TYPE_INIT_CLASS_CONST("Author", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_ARG_TYPE_INFO(0, chapters, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_story_tell, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(Story, create) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void* vphp_wrap_story_create(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_story_create(ctx);
    if (EG(exception)) {
        return;
    }
    extern vphp_class_handlers* story_handlers();
    vphp_return_owned_object(return_value, v_instance, story_ce, story_handlers());
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Story, tell) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_story_tell(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* story_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, story_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_story_tell(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

ZEND_NAMED_FUNCTION(ZEND_MN(Story___construct)) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* story_handlers();
    vphp_class_handlers *h = story_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

static const zend_function_entry story_methods[] = {
    PHP_ME(Story, __construct, arginfo_story___construct, ZEND_ACC_PUBLIC)
    PHP_ME(Story, create, arginfo_story_create, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(Story, tell, arginfo_story_tell, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int story_register_class(void) {
    if (story_ce != NULL) {
        return SUCCESS;
    }
    story_ce = vphp_find_loaded_class_entry("Story", sizeof("Story")-1);
    if (story_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Story", story_methods);
        zend_class_entry *parent_ce = vphp_require_class_entry("Post", sizeof("Post")-1, 0);
        if (!parent_ce) {
            zend_error(E_CORE_WARNING, "Cannot register %s: parent class %s was not found", "Story", "Post");
            return FAILURE;
        }
        vphp_verify_parent_reference_methods(&ce, parent_ce);
        story_ce = zend_register_internal_class_ex(&ce, parent_ce);
        story_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        story_ce->create_object = vphp_create_object_handler;
#if PHP_VERSION_ID >= 80400
        vphp_prepare_backed_property(story_ce, "chapter_count", sizeof("chapter_count")-1);
#endif
        {
            zval default_val;
            ZVAL_LONG(&default_val, 0);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_string *property_name = zend_string_init_interned("chapter_count", sizeof("chapter_count")-1, 1);
            zend_declare_typed_property(story_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
#if PHP_VERSION_ID >= 80400
        {
            static zend_function *inherited_hooks[ZEND_PROPERTY_HOOK_COUNT];
            vphp_inherit_backed_property_contract(story_ce, "chapter_count", sizeof("chapter_count")-1, inherited_hooks);
        }
#endif
        }
        vphp_prepare_class_constant_cache(story_ce);
#if PHP_VERSION_ID >= 80400
        vphp_verify_interface_property_contracts(story_ce, false);
#endif
    }
    return SUCCESS;
}
zend_class_entry *demo__contracts__aliasbase_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_demo__contracts__aliasbase___construct, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, label, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(Demo__Contracts__AliasBase, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* alias_base_handlers();
    vphp_class_handlers *h = alias_base_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_alias_base_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_alias_base_construct(v_ptr, ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry demo__contracts__aliasbase_methods[] = {
    PHP_ME(Demo__Contracts__AliasBase, __construct, arginfo_demo__contracts__aliasbase___construct, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int demo__contracts__aliasbase_register_class(void) {
    if (demo__contracts__aliasbase_ce != NULL) {
        return SUCCESS;
    }
    demo__contracts__aliasbase_ce = vphp_find_loaded_class_entry("Demo\\Contracts\\AliasBase", sizeof("Demo\\Contracts\\AliasBase")-1);
    if (demo__contracts__aliasbase_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Demo\\Contracts\\AliasBase", demo__contracts__aliasbase_methods);
        demo__contracts__aliasbase_ce = zend_register_internal_class(&ce);
        demo__contracts__aliasbase_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        demo__contracts__aliasbase_ce->create_object = vphp_create_object_handler;
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("label", sizeof("label")-1, 1);
            zend_declare_typed_property(demo__contracts__aliasbase_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
    }
    return SUCCESS;
}
zend_class_entry *aliasworker_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_aliasworker___construct, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, label, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, title, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_aliasworker_save, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_aliasworker_get_formatted_title, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_aliasworker_ping, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(AliasWorker, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* alias_worker_handlers();
    vphp_class_handlers *h = alias_worker_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_alias_worker_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_alias_worker_construct(v_ptr, ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(AliasWorker, save) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_alias_worker_save(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* alias_worker_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, alias_worker_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_alias_worker_save(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(AliasWorker, get_formatted_title) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_alias_worker_get_formatted_title(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* alias_worker_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, alias_worker_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_alias_worker_get_formatted_title(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(AliasWorker, ping) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_alias_worker_ping(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* alias_worker_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, alias_worker_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_alias_worker_ping(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry aliasworker_methods[] = {
    PHP_ME(AliasWorker, __construct, arginfo_aliasworker___construct, ZEND_ACC_PUBLIC)
    PHP_ME(AliasWorker, save, arginfo_aliasworker_save, ZEND_ACC_PUBLIC)
    PHP_ME(AliasWorker, get_formatted_title, arginfo_aliasworker_get_formatted_title, ZEND_ACC_PUBLIC)
    PHP_ME(AliasWorker, ping, arginfo_aliasworker_ping, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int aliasworker_register_class(void) {
    if (aliasworker_ce != NULL) {
        return SUCCESS;
    }
    aliasworker_ce = vphp_find_loaded_class_entry("AliasWorker", sizeof("AliasWorker")-1);
    if (aliasworker_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "AliasWorker", aliasworker_methods);
        zend_class_entry *parent_ce = vphp_require_class_entry("Demo\\Contracts\\AliasBase", sizeof("Demo\\Contracts\\AliasBase")-1, 0);
        if (!parent_ce) {
            zend_error(E_CORE_WARNING, "Cannot register %s: parent class %s was not found", "AliasWorker", "Demo\\Contracts\\AliasBase");
            return FAILURE;
        }
        vphp_verify_parent_reference_methods(&ce, parent_ce);
        aliasworker_ce = zend_register_internal_class_ex(&ce, parent_ce);
        aliasworker_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        aliasworker_ce->create_object = vphp_create_object_handler;
#if PHP_VERSION_ID >= 80400
        vphp_prepare_backed_property(aliasworker_ce, "title", sizeof("title")-1);
#endif
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("title", sizeof("title")-1, 1);
            zend_declare_typed_property(aliasworker_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
#if PHP_VERSION_ID >= 80400
        {
            static zend_function *inherited_hooks[ZEND_PROPERTY_HOOK_COUNT];
            vphp_inherit_backed_property_contract(aliasworker_ce, "title", sizeof("title")-1, inherited_hooks);
        }
#endif
        }
        zend_class_entry *iface_0_ce = vphp_require_class_entry("ContentContract", sizeof("ContentContract")-1, 0);
        if (!iface_0_ce) {
            zend_error(E_CORE_WARNING, "Cannot register %s: interface %s was not found", "AliasWorker", "ContentContract");
            return FAILURE;
        }
        vphp_verify_interface_reference_methods(aliasworker_ce, iface_0_ce);
#if PHP_VERSION_ID >= 80400
        vphp_verify_interface_restricted_hooks(aliasworker_ce, iface_0_ce);
#endif
        zend_class_implements(aliasworker_ce, 1, iface_0_ce);
        zend_class_entry *iface_1_ce = vphp_require_class_entry("Demo\\Contracts\\AliasContract", sizeof("Demo\\Contracts\\AliasContract")-1, 0);
        if (!iface_1_ce) {
            zend_error(E_CORE_WARNING, "Cannot register %s: interface %s was not found", "AliasWorker", "Demo\\Contracts\\AliasContract");
            return FAILURE;
        }
        vphp_verify_interface_reference_methods(aliasworker_ce, iface_1_ce);
#if PHP_VERSION_ID >= 80400
        vphp_verify_interface_restricted_hooks(aliasworker_ce, iface_1_ce);
#endif
        zend_class_implements(aliasworker_ce, 1, iface_1_ce);
        vphp_prepare_class_constant_cache(aliasworker_ce);
#if PHP_VERSION_ID >= 80400
        vphp_verify_interface_property_contracts(aliasworker_ce, false);
#endif
    }
    return SUCCESS;
}
zend_class_entry *runtimedemo__baseexception_ce = NULL;

static const zend_function_entry runtimedemo__baseexception_methods[] = {
    PHP_FE_END
};

static int runtimedemo__baseexception_register_class(void) {
    if (runtimedemo__baseexception_ce != NULL) {
        return SUCCESS;
    }
    runtimedemo__baseexception_ce = vphp_find_loaded_class_entry("RuntimeDemo\\BaseException", sizeof("RuntimeDemo\\BaseException")-1);
    if (runtimedemo__baseexception_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "RuntimeDemo\\BaseException", runtimedemo__baseexception_methods);
        zend_class_entry *parent_ce = vphp_require_class_entry("Exception", sizeof("Exception")-1, 0);
        if (!parent_ce) {
            zend_error(E_CORE_WARNING, "Cannot register %s: parent class %s was not found", "RuntimeDemo\\BaseException", "Exception");
            return FAILURE;
        }
        vphp_verify_parent_reference_methods(&ce, parent_ce);
        runtimedemo__baseexception_ce = zend_register_internal_class_ex(&ce, parent_ce);
        vphp_prepare_class_constant_cache(runtimedemo__baseexception_ce);
#if PHP_VERSION_ID >= 80400
        vphp_verify_interface_property_contracts(runtimedemo__baseexception_ce, false);
#endif
    }
    return SUCCESS;
}
zend_class_entry *runtimedemo__childexception_ce = NULL;

static const zend_function_entry runtimedemo__childexception_methods[] = {
    PHP_FE_END
};

static int runtimedemo__childexception_register_class(void) {
    if (runtimedemo__childexception_ce != NULL) {
        return SUCCESS;
    }
    runtimedemo__childexception_ce = vphp_find_loaded_class_entry("RuntimeDemo\\ChildException", sizeof("RuntimeDemo\\ChildException")-1);
    if (runtimedemo__childexception_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "RuntimeDemo\\ChildException", runtimedemo__childexception_methods);
        zend_class_entry *parent_ce = vphp_require_class_entry("RuntimeDemo\\BaseException", sizeof("RuntimeDemo\\BaseException")-1, 0);
        if (!parent_ce) {
            zend_error(E_CORE_WARNING, "Cannot register %s: parent class %s was not found", "RuntimeDemo\\ChildException", "RuntimeDemo\\BaseException");
            return FAILURE;
        }
        vphp_verify_parent_reference_methods(&ce, parent_ce);
        runtimedemo__childexception_ce = zend_register_internal_class_ex(&ce, parent_ce);
        vphp_prepare_class_constant_cache(runtimedemo__childexception_ce);
#if PHP_VERSION_ID >= 80400
        vphp_verify_interface_property_contracts(runtimedemo__childexception_ce, false);
#endif
    }
    return SUCCESS;
}
zend_class_entry *callableprocessor_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_callableprocessor___construct, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, prefix, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_callableprocessor_process, 0, 1, IS_STRING, 0)
ZEND_ARG_CALLABLE_INFO(0, callback, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_callableprocessor_transform, 0, 2, IS_STRING, 0)
ZEND_ARG_CALLABLE_INFO(0, callback, 0)
ZEND_ARG_TYPE_INFO(0, input, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_callableprocessor_apply, 0, 2, IS_STRING, 0)
ZEND_ARG_CALLABLE_INFO(0, callback, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_STRING, 0)
ZEND_END_ARG_INFO()
static const zend_internal_arg_info arginfo_callableprocessor_structclosure[] = {
    { (const char*)(uintptr_t)(0), ZEND_TYPE_INIT_CLASS_CONST("Closure", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_callableprocessor_computedparams, 0, 0, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, sequence, IS_LONG, 0, "new \\VPHP\\Internal\\vphptest_ClosureDefault(5, 0)")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, label, IS_STRING, 1, "new \\VPHP\\Internal\\vphptest_ClosureDefault(5, 1)")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, enabled, _IS_BOOL, 0, "true")
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_callableprocessor_literalparams, 0, 0, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, message, IS_STRING, 0, "\"a\\n\\t\\x00\\xe2\\x98\\xba\\$'\\\\\\\"\"")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, raw, IS_STRING, 0, "\"\\\\n\\${literal}\"")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, octal, IS_LONG, 0, "-15")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, binary, IS_LONG, 0, "161")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, floating, IS_DOUBLE, 0, "2.0")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, single, IS_DOUBLE, 0, "0.10000000149011612")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, option, IS_STRING, 1, "'present'")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, nullable, IS_LONG, 1, "null")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, items, IS_ARRAY, 0, "[1, 16]")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, empty, IS_ARRAY, 0, "[]")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, lookup, IS_ARRAY, 0, "['count' => 16]")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, tail, _IS_BOOL, 0, "true")
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_callableprocessor_overriddenparams, 0, 0, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, option, IS_STRING, 1, "\"php\\tvalue\"")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, spacer, IS_STRING, 0, "'native spacer'")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, count, IS_LONG, 0, "VPHP_PARAMS_OVERRIDE_COUNT")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, nullable, IS_STRING, 1, "null")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, items, IS_ARRAY, 0, "[1, 2]")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, tail, _IS_BOOL, 0, "true")
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_callableprocessor_directdefaults, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, prefix, IS_STRING, 0)
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, count, IS_LONG, 0, "VPHP_ORDINARY_ARG_COUNT")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, values, IS_ARRAY, 1, "[1, VPHP_ORDINARY_ARG_COUNT]")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, label, IS_STRING, 1, "\"fallback\"")
ZEND_ARG_TYPE_INFO_WITH_DEFAULT_VALUE(0, enabled, _IS_BOOL, 0, "true")
ZEND_END_ARG_INFO()
PHP_METHOD(CallableProcessor, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* callable_processor_handlers();
    vphp_class_handlers *h = callable_processor_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_callable_processor_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_callable_processor_construct(v_ptr, ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(CallableProcessor, process) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_callable_processor_process(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* callable_processor_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, callable_processor_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_callable_processor_process(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(CallableProcessor, transform) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_callable_processor_transform(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* callable_processor_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, callable_processor_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_callable_processor_transform(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(CallableProcessor, apply) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_callable_processor_apply(vphp_context_internal ctx);
    vphp_wrap_callable_processor_apply(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(CallableProcessor, structClosure) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_callable_processor_struct_closure(vphp_context_internal ctx);
    vphp_wrap_callable_processor_struct_closure(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(CallableProcessor, computedParams) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_callable_processor_computed_params(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* callable_processor_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, callable_processor_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_callable_processor_computed_params(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(CallableProcessor, literalParams) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_callable_processor_literal_params(vphp_context_internal ctx);
    vphp_wrap_callable_processor_literal_params(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(CallableProcessor, overriddenParams) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_callable_processor_overridden_params(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* callable_processor_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, callable_processor_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_callable_processor_overridden_params(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(CallableProcessor, directDefaults) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_callable_processor_direct_defaults(vphp_context_internal ctx);
    vphp_wrap_callable_processor_direct_defaults(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry callableprocessor_methods[] = {
    PHP_ME(CallableProcessor, __construct, arginfo_callableprocessor___construct, ZEND_ACC_PUBLIC)
    PHP_ME(CallableProcessor, process, arginfo_callableprocessor_process, ZEND_ACC_PUBLIC)
    PHP_ME(CallableProcessor, transform, arginfo_callableprocessor_transform, ZEND_ACC_PUBLIC)
    PHP_ME(CallableProcessor, apply, arginfo_callableprocessor_apply, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(CallableProcessor, structClosure, arginfo_callableprocessor_structclosure, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(CallableProcessor, computedParams, arginfo_callableprocessor_computedparams, ZEND_ACC_PUBLIC)
    PHP_ME(CallableProcessor, literalParams, arginfo_callableprocessor_literalparams, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(CallableProcessor, overriddenParams, arginfo_callableprocessor_overriddenparams, ZEND_ACC_PUBLIC)
    PHP_ME(CallableProcessor, directDefaults, arginfo_callableprocessor_directdefaults, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_FE_END
};

static int callableprocessor_register_class(void) {
    if (callableprocessor_ce != NULL) {
        return SUCCESS;
    }
    callableprocessor_ce = vphp_find_loaded_class_entry("CallableProcessor", sizeof("CallableProcessor")-1);
    if (callableprocessor_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "CallableProcessor", callableprocessor_methods);
        callableprocessor_ce = zend_register_internal_class(&ce);
        callableprocessor_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        callableprocessor_ce->create_object = vphp_create_object_handler;
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("prefix", sizeof("prefix")-1, 1);
            zend_declare_typed_property(callableprocessor_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
    }
    return SUCCESS;
}
zend_class_entry *finder_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_finder___construct, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_finder_find, 0, 1, IS_STRING, 1)
ZEND_ARG_TYPE_INFO(0, keyword, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_finder_index_of, 0, 1, IS_LONG, 1)
ZEND_ARG_TYPE_INFO(0, keyword, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_finder_has_match, 0, 1, _IS_BOOL, 1)
ZEND_ARG_TYPE_INFO(0, keyword, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_finder_try_parse_int, 0, 1, IS_LONG, 1)
ZEND_ARG_TYPE_INFO(0, s, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(Finder, __construct) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* finder_handlers();
    vphp_class_handlers *h = finder_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_finder_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_finder_construct(v_ptr, ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Finder, find) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_finder_find(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* finder_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, finder_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_finder_find(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Finder, index_of) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_finder_index_of(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* finder_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, finder_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_finder_index_of(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Finder, has_match) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_finder_has_match(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* finder_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, finder_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_finder_has_match(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Finder, try_parse_int) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_finder_try_parse_int(vphp_context_internal ctx);
    vphp_wrap_finder_try_parse_int(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry finder_methods[] = {
    PHP_ME(Finder, __construct, arginfo_finder___construct, ZEND_ACC_PUBLIC)
    PHP_ME(Finder, find, arginfo_finder_find, ZEND_ACC_PUBLIC)
    PHP_ME(Finder, index_of, arginfo_finder_index_of, ZEND_ACC_PUBLIC)
    PHP_ME(Finder, has_match, arginfo_finder_has_match, ZEND_ACC_PUBLIC)
    PHP_ME(Finder, try_parse_int, arginfo_finder_try_parse_int, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_FE_END
};

static int finder_register_class(void) {
    if (finder_ce != NULL) {
        return SUCCESS;
    }
    finder_ce = vphp_find_loaded_class_entry("Finder", sizeof("Finder")-1);
    if (finder_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Finder", finder_methods);
        finder_ce = zend_register_internal_class(&ce);
        finder_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        finder_ce->create_object = vphp_create_object_handler;
        {
            zval default_val;
            ZVAL_NULL(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_ARRAY, 0, 0);
            zend_string *property_name = zend_string_init_interned("items", sizeof("items")-1, 1);
            zend_declare_typed_property(finder_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
    }
    return SUCCESS;
}
zend_class_entry *readonlyrecord_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_readonlyrecord___construct, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, title, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_readonlyrecord_reveal, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(ReadonlyRecord, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* readonly_record_handlers();
    vphp_class_handlers *h = readonly_record_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_readonly_record_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_readonly_record_construct(v_ptr, ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(ReadonlyRecord, reveal) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_readonly_record_reveal(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* readonly_record_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, readonly_record_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_readonly_record_reveal(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry readonlyrecord_methods[] = {
    PHP_ME(ReadonlyRecord, __construct, arginfo_readonlyrecord___construct, ZEND_ACC_PUBLIC)
    PHP_ME(ReadonlyRecord, reveal, arginfo_readonlyrecord_reveal, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int readonlyrecord_register_class(void) {
    if (readonlyrecord_ce != NULL) {
        return SUCCESS;
    }
    readonlyrecord_ce = vphp_find_loaded_class_entry("ReadonlyRecord", sizeof("ReadonlyRecord")-1);
    if (readonlyrecord_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "ReadonlyRecord", readonlyrecord_methods);
        readonlyrecord_ce = zend_register_internal_class(&ce);
        readonlyrecord_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        readonlyrecord_ce->create_object = vphp_create_object_handler;
        {
            zval default_val;
            ZVAL_LONG(&default_val, 0);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_string *property_name = zend_string_init_interned("created_at", sizeof("created_at")-1, 1);
            zend_declare_typed_property(readonlyrecord_ce, property_name, &default_val, ZEND_ACC_PUBLIC | ZEND_ACC_READONLY, NULL, property_type);
        }
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("title", sizeof("title")-1, 1);
            zend_declare_typed_property(readonlyrecord_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("internal_note", sizeof("internal_note")-1, 1);
            zend_declare_typed_property(readonlyrecord_ce, property_name, &default_val, ZEND_ACC_PROTECTED, NULL, property_type);
        }
    }
    return SUCCESS;
}
zend_class_entry *vphp__compiler__moduleprobekind_ce = NULL;

extern void vphp_enum_backing_values_vphp__compiler__moduleprobekind(int64_t *);
static const zend_function_entry vphp__compiler__moduleprobekind_methods[] = {
    PHP_FE_END
};

static int vphp__compiler__moduleprobekind_register_class(void) {
    if (vphp__compiler__moduleprobekind_ce != NULL) {
        return SUCCESS;
    }
    vphp__compiler__moduleprobekind_ce = vphp_find_loaded_class_entry("VPHP\\Compiler\\ModuleProbeKind", sizeof("VPHP\\Compiler\\ModuleProbeKind")-1);
    if (vphp__compiler__moduleprobekind_ce != NULL) {
        return SUCCESS;
    }
    {
        vphp__compiler__moduleprobekind_ce = zend_register_internal_enum("VPHP\\Compiler\\ModuleProbeKind", IS_LONG, NULL);
        int64_t backing_values[2];
        vphp_enum_backing_values_vphp__compiler__moduleprobekind(backing_values);
        {
            int64_t value = backing_values[0];
            if (value < ZEND_LONG_MIN || value > ZEND_LONG_MAX) {
                zend_error(E_WARNING, "PHP enum VPHP\\Compiler\\ModuleProbeKind::alpha has a backing value outside the PHP integer range");
                return FAILURE;
            }
            if (zend_hash_index_exists(vphp__compiler__moduleprobekind_ce->backed_enum_table, (zend_ulong)value)) {
                zend_error(E_WARNING, "PHP enum VPHP\\Compiler\\ModuleProbeKind::alpha duplicates an integer backing value");
                return FAILURE;
            }
            zval backing_value;
            ZVAL_LONG(&backing_value, (zend_long)value);
            zend_enum_add_case_cstr(vphp__compiler__moduleprobekind_ce, "alpha", &backing_value);
        }
        {
            int64_t value = backing_values[1];
            if (value < ZEND_LONG_MIN || value > ZEND_LONG_MAX) {
                zend_error(E_WARNING, "PHP enum VPHP\\Compiler\\ModuleProbeKind::beta has a backing value outside the PHP integer range");
                return FAILURE;
            }
            if (zend_hash_index_exists(vphp__compiler__moduleprobekind_ce->backed_enum_table, (zend_ulong)value)) {
                zend_error(E_WARNING, "PHP enum VPHP\\Compiler\\ModuleProbeKind::beta duplicates an integer backing value");
                return FAILURE;
            }
            zval backing_value;
            ZVAL_LONG(&backing_value, (zend_long)value);
            zend_enum_add_case_cstr(vphp__compiler__moduleprobekind_ce, "beta", &backing_value);
        }
    }
    return SUCCESS;
}
zend_class_entry *vphp__compiler__otherprobekind_ce = NULL;

extern void vphp_enum_backing_values_vphp__compiler__otherprobekind(int64_t *);
static const zend_function_entry vphp__compiler__otherprobekind_methods[] = {
    PHP_FE_END
};

static int vphp__compiler__otherprobekind_register_class(void) {
    if (vphp__compiler__otherprobekind_ce != NULL) {
        return SUCCESS;
    }
    vphp__compiler__otherprobekind_ce = vphp_find_loaded_class_entry("VPHP\\Compiler\\OtherProbeKind", sizeof("VPHP\\Compiler\\OtherProbeKind")-1);
    if (vphp__compiler__otherprobekind_ce != NULL) {
        return SUCCESS;
    }
    {
        vphp__compiler__otherprobekind_ce = zend_register_internal_enum("VPHP\\Compiler\\OtherProbeKind", IS_LONG, NULL);
        int64_t backing_values[1];
        vphp_enum_backing_values_vphp__compiler__otherprobekind(backing_values);
        {
            int64_t value = backing_values[0];
            if (value < ZEND_LONG_MIN || value > ZEND_LONG_MAX) {
                zend_error(E_WARNING, "PHP enum VPHP\\Compiler\\OtherProbeKind::other has a backing value outside the PHP integer range");
                return FAILURE;
            }
            if (zend_hash_index_exists(vphp__compiler__otherprobekind_ce->backed_enum_table, (zend_ulong)value)) {
                zend_error(E_WARNING, "PHP enum VPHP\\Compiler\\OtherProbeKind::other duplicates an integer backing value");
                return FAILURE;
            }
            zval backing_value;
            ZVAL_LONG(&backing_value, (zend_long)value);
            zend_enum_add_case_cstr(vphp__compiler__otherprobekind_ce, "other", &backing_value);
        }
    }
    return SUCCESS;
}
zend_class_entry *vphp__compiler__moduleprobereadonlybox_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphp__compiler__moduleprobereadonlybox___construct, 0, 0, 0)
ZEND_END_ARG_INFO()

ZEND_NAMED_FUNCTION(ZEND_MN(VPHP__Compiler__ModuleProbeReadOnlyBox___construct)) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* vphp_module_probe_read_only_box_handlers();
    vphp_class_handlers *h = vphp_module_probe_read_only_box_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

static const zend_function_entry vphp__compiler__moduleprobereadonlybox_methods[] = {
    PHP_ME(VPHP__Compiler__ModuleProbeReadOnlyBox, __construct, arginfo_vphp__compiler__moduleprobereadonlybox___construct, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int vphp__compiler__moduleprobereadonlybox_register_class(void) {
    if (vphp__compiler__moduleprobereadonlybox_ce != NULL) {
        return SUCCESS;
    }
    vphp__compiler__moduleprobereadonlybox_ce = vphp_find_loaded_class_entry("VPHP\\Compiler\\ModuleProbeReadOnlyBox", sizeof("VPHP\\Compiler\\ModuleProbeReadOnlyBox")-1);
    if (vphp__compiler__moduleprobereadonlybox_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VPHP\\Compiler\\ModuleProbeReadOnlyBox", vphp__compiler__moduleprobereadonlybox_methods);
        vphp__compiler__moduleprobereadonlybox_ce = zend_register_internal_class(&ce);
        vphp__compiler__moduleprobereadonlybox_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE | ZEND_ACC_READONLY_CLASS;
        vphp__compiler__moduleprobereadonlybox_ce->create_object = vphp_create_object_handler;
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("title", sizeof("title")-1, 1);
            zend_declare_typed_property(vphp__compiler__moduleprobereadonlybox_ce, property_name, &default_val, ZEND_ACC_PUBLIC | ZEND_ACC_READONLY, NULL, property_type);
        }
        {
            zval default_val;
            ZVAL_LONG(&default_val, 0);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_string *property_name = zend_string_init_interned("value", sizeof("value")-1, 1);
            zend_declare_typed_property(vphp__compiler__moduleprobereadonlybox_ce, property_name, &default_val, ZEND_ACC_PUBLIC | ZEND_ACC_READONLY, NULL, property_type);
        }
    }
    return SUCCESS;
}
zend_class_entry *vphp__compiler__moduleprobebox_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphp__compiler__moduleprobebox___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
static const zend_internal_arg_info arginfo_vphp__compiler__moduleprobebox_test_sumtype[] = {
    { (const char*)(uintptr_t)(1), ZEND_TYPE_INIT_MASK(MAY_BE_LONG|MAY_BE_STRING | _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_ARG_TYPE_MASK(0, val, MAY_BE_LONG|MAY_BE_STRING, NULL)
ZEND_END_ARG_INFO()
static const zend_internal_arg_info arginfo_vphp__compiler__moduleprobebox_test_enum_echo[] = {
    { (const char*)(uintptr_t)(1), ZEND_TYPE_INIT_CLASS_CONST("VPHP\\Compiler\\ModuleProbeKind", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
{ "kind", ZEND_TYPE_INIT_CLASS_CONST("VPHP\\Compiler\\ModuleProbeKind", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
static const zend_internal_arg_info arginfo_vphp__compiler__moduleprobebox_test_sumtype_echo[] = {
    { (const char*)(uintptr_t)(1), ZEND_TYPE_INIT_CLASS_CONST_MASK("VPHP\\Compiler\\ModuleProbeKind|VPHP\\Compiler\\ModuleProbeReadOnlyBox|VPHP\\Compiler\\OtherProbeKind", MAY_BE_LONG | _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
{ "val", ZEND_TYPE_INIT_CLASS_CONST_MASK("VPHP\\Compiler\\ModuleProbeKind|VPHP\\Compiler\\ModuleProbeReadOnlyBox|VPHP\\Compiler\\OtherProbeKind", MAY_BE_LONG | _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp__compiler__moduleprobebox_test_variadic, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, sep, IS_STRING, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_STRING, 0)
ZEND_END_ARG_INFO()
static const zend_internal_arg_info arginfo_vphp__compiler__moduleprobebox_test_struct_param[] = {
    { (const char*)(uintptr_t)(1), ZEND_TYPE_INIT_CODE(IS_STRING, 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
{ "box", ZEND_TYPE_INIT_CLASS_CONST("VPHP\\Compiler\\ModuleProbeReadOnlyBox", 0, _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp__compiler__moduleprobebox_label, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
static zend_internal_arg_info arginfo_vphp__compiler__moduleprobebox_compoundidentity[] = {
    { (const char*)(uintptr_t)(1), ZEND_TYPE_INIT_MASK(MAY_BE_ANY | _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
{ "value", ZEND_TYPE_INIT_MASK(MAY_BE_ANY | _ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL },
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp__compiler__moduleprobebox_stepreference, 0, 1, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(1, cursor, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp__compiler__moduleprobebox_staticlabel, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VPHP__Compiler__ModuleProbeBox, test_sumtype) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_module_probe_box_test_sumtype(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_module_probe_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_module_probe_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_vphp_module_probe_box_test_sumtype(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPHP__Compiler__ModuleProbeBox, test_enum_echo) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_module_probe_box_test_enum_echo(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_module_probe_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_module_probe_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_vphp_module_probe_box_test_enum_echo(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPHP__Compiler__ModuleProbeBox, test_sumtype_echo) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_module_probe_box_test_sumtype_echo(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_module_probe_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_module_probe_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_vphp_module_probe_box_test_sumtype_echo(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPHP__Compiler__ModuleProbeBox, test_variadic) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_module_probe_box_test_variadic(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_module_probe_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_module_probe_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_vphp_module_probe_box_test_variadic(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPHP__Compiler__ModuleProbeBox, test_struct_param) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_module_probe_box_test_struct_param(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_module_probe_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_module_probe_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_vphp_module_probe_box_test_struct_param(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPHP__Compiler__ModuleProbeBox, label) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_module_probe_box_label(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_module_probe_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_module_probe_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_vphp_module_probe_box_label(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPHP__Compiler__ModuleProbeBox, compoundIdentity) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_module_probe_box_compound_identity(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_module_probe_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_module_probe_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_vphp_module_probe_box_compound_identity(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPHP__Compiler__ModuleProbeBox, stepReference) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_module_probe_box_step_reference(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_module_probe_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_module_probe_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_vphp_module_probe_box_step_reference(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPHP__Compiler__ModuleProbeBox, staticLabel) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_module_probe_box_static_label(vphp_context_internal ctx);
    vphp_wrap_vphp_module_probe_box_static_label(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

ZEND_NAMED_FUNCTION(ZEND_MN(VPHP__Compiler__ModuleProbeBox___construct)) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* vphp_module_probe_box_handlers();
    vphp_class_handlers *h = vphp_module_probe_box_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

static const zend_function_entry vphp__compiler__moduleprobebox_methods[] = {
    PHP_ME(VPHP__Compiler__ModuleProbeBox, __construct, arginfo_vphp__compiler__moduleprobebox___construct, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__ModuleProbeBox, test_sumtype, arginfo_vphp__compiler__moduleprobebox_test_sumtype, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__ModuleProbeBox, test_enum_echo, arginfo_vphp__compiler__moduleprobebox_test_enum_echo, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__ModuleProbeBox, test_sumtype_echo, arginfo_vphp__compiler__moduleprobebox_test_sumtype_echo, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__ModuleProbeBox, test_variadic, arginfo_vphp__compiler__moduleprobebox_test_variadic, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__ModuleProbeBox, test_struct_param, arginfo_vphp__compiler__moduleprobebox_test_struct_param, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__ModuleProbeBox, label, arginfo_vphp__compiler__moduleprobebox_label, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__ModuleProbeBox, compoundIdentity, arginfo_vphp__compiler__moduleprobebox_compoundidentity, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__ModuleProbeBox, stepReference, arginfo_vphp__compiler__moduleprobebox_stepreference, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__ModuleProbeBox, staticLabel, arginfo_vphp__compiler__moduleprobebox_staticlabel, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_FE_END
};

static int vphp__compiler__moduleprobebox_register_class(void) {
    if (vphp__compiler__moduleprobebox_ce != NULL) {
        return SUCCESS;
    }
    vphp__compiler__moduleprobebox_ce = vphp_find_loaded_class_entry("VPHP\\Compiler\\ModuleProbeBox", sizeof("VPHP\\Compiler\\ModuleProbeBox")-1);
    if (vphp__compiler__moduleprobebox_ce != NULL) {
        return SUCCESS;
    }
    {
#if PHP_VERSION_ID >= 80300
        arginfo_vphp__compiler__moduleprobebox_compoundidentity[0].type = vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("ArrayObject"), vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("Iterator"), vphp_arginfo_class_type("Countable")}, 2, _ZEND_TYPE_INTERSECTION_BIT)}, 2, _ZEND_TYPE_UNION_BIT | MAY_BE_LONG | MAY_BE_NULL | _ZEND_ARG_INFO_FLAGS(0, 0, 0));
        arginfo_vphp__compiler__moduleprobebox_compoundidentity[1].type = vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("ArrayObject"), vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("Iterator"), vphp_arginfo_class_type("Countable")}, 2, _ZEND_TYPE_INTERSECTION_BIT)}, 2, _ZEND_TYPE_UNION_BIT | MAY_BE_LONG | MAY_BE_NULL | _ZEND_ARG_INFO_FLAGS(0, 0, 0));
#endif
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VPHP\\Compiler\\ModuleProbeBox", vphp__compiler__moduleprobebox_methods);
        vphp__compiler__moduleprobebox_ce = zend_register_internal_class(&ce);
#if PHP_VERSION_ID < 80300
        {
            zend_function *registered = zend_hash_str_find_ptr_lc(&vphp__compiler__moduleprobebox_ce->function_table, "compoundIdentity", sizeof("compoundIdentity")-1);
            if (!registered || !registered->common.arg_info) { return FAILURE; }
            (registered->common.arg_info - 1)[0].type = vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("ArrayObject"), vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("Iterator"), vphp_arginfo_class_type("Countable")}, 2, _ZEND_TYPE_INTERSECTION_BIT)}, 2, _ZEND_TYPE_UNION_BIT | MAY_BE_LONG | MAY_BE_NULL | _ZEND_ARG_INFO_FLAGS(0, 0, 0));
            (registered->common.arg_info - 1)[1].type = vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("ArrayObject"), vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("Iterator"), vphp_arginfo_class_type("Countable")}, 2, _ZEND_TYPE_INTERSECTION_BIT)}, 2, _ZEND_TYPE_UNION_BIT | MAY_BE_LONG | MAY_BE_NULL | _ZEND_ARG_INFO_FLAGS(0, 0, 0));
        }
#endif
        vphp__compiler__moduleprobebox_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        vphp__compiler__moduleprobebox_ce->create_object = vphp_create_object_handler;
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("name", sizeof("name")-1, 1);
            zend_declare_typed_property(vphp__compiler__moduleprobebox_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
        {
            zval default_val;
            ZVAL_LONG(&default_val, 0);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_string *property_name = zend_string_init_interned("count", sizeof("count")-1, 1);
            zend_declare_typed_property(vphp__compiler__moduleprobebox_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
        zend_class_entry *iface_0_ce = vphp_require_class_entry("VPHP\\Compiler\\ModuleProbeContract", sizeof("VPHP\\Compiler\\ModuleProbeContract")-1, 0);
        if (!iface_0_ce) {
            zend_error(E_CORE_WARNING, "Cannot register %s: interface %s was not found", "VPHP\\Compiler\\ModuleProbeBox", "VPHP\\Compiler\\ModuleProbeContract");
            return FAILURE;
        }
        vphp_verify_interface_reference_methods(vphp__compiler__moduleprobebox_ce, iface_0_ce);
#if PHP_VERSION_ID >= 80400
        vphp_verify_interface_restricted_hooks(vphp__compiler__moduleprobebox_ce, iface_0_ce);
#endif
        zend_class_implements(vphp__compiler__moduleprobebox_ce, 1, iface_0_ce);
        vphp_prepare_class_constant_cache(vphp__compiler__moduleprobebox_ce);
#if PHP_VERSION_ID >= 80400
        vphp_verify_interface_property_contracts(vphp__compiler__moduleprobebox_ce, false);
#endif
    }
    return SUCCESS;
}
zend_class_entry *vphp__compiler__copyablebox_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphp__compiler__copyablebox___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp__compiler__copyablebox_hold, 0, 1, IS_VOID, 0)
ZEND_ARG_TYPE_INFO(0, value, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp__compiler__copyablebox_cloneinitialized, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp__compiler__copyablebox_bump, 0, 1, IS_VOID, 0)
ZEND_ARG_TYPE_INFO(0, delta, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp__compiler__copyablebox_state, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp__compiler__copyablebox___serialize, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp__compiler__copyablebox___unserialize, 0, 1, IS_VOID, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
extern vphp_class_handlers *vphp_copyable_box_handlers(void);
static zend_object_handlers vphp__compiler__copyablebox_object_handlers;
static zend_object *vphp__compiler__copyablebox_create_object(zend_class_entry *ce) {
    zend_object *obj = vphp_create_object_handler(ce);
    obj->handlers = &vphp__compiler__copyablebox_object_handlers;
    return obj;
}
extern void vphp_copyable_box_clone_into_raw(void *, void *);
static zend_object *vphp__compiler__copyablebox_clone_object(zend_object *obj) {
    return vphp_clone_bound_object(obj, vphp_copyable_box_handlers(), vphp_copyable_box_clone_into_raw);
}
PHP_METHOD(VPHP__Compiler__CopyableBox, hold) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_copyable_box_hold(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_copyable_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_copyable_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_NULL();
    }
    vphp_wrap_vphp_copyable_box_hold(wrapper->v_ptr, ctx);
    if (!EG(exception)) {
        vphp_mark_void_return(return_value);
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPHP__Compiler__CopyableBox, cloneInitialized) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_copyable_box_clone_initialized(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_copyable_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_copyable_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_vphp_copyable_box_clone_initialized(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPHP__Compiler__CopyableBox, bump) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_copyable_box_bump(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_copyable_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_copyable_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_NULL();
    }
    vphp_wrap_vphp_copyable_box_bump(wrapper->v_ptr, ctx);
    if (!EG(exception)) {
        vphp_mark_void_return(return_value);
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPHP__Compiler__CopyableBox, state) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_copyable_box_state(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_copyable_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_copyable_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_vphp_copyable_box_state(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPHP__Compiler__CopyableBox, __serialize) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_copyable_box_serialize_state(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_copyable_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_copyable_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_vphp_copyable_box_serialize_state(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPHP__Compiler__CopyableBox, __unserialize) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_copyable_box_unserialize_state(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_copyable_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_copyable_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_NULL();
    }
    vphp_wrap_vphp_copyable_box_unserialize_state(wrapper->v_ptr, ctx);
    if (!EG(exception)) {
        vphp_mark_void_return(return_value);
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

ZEND_NAMED_FUNCTION(ZEND_MN(VPHP__Compiler__CopyableBox___construct)) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* vphp_copyable_box_handlers();
    vphp_class_handlers *h = vphp_copyable_box_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

static const zend_function_entry vphp__compiler__copyablebox_methods[] = {
    PHP_ME(VPHP__Compiler__CopyableBox, __construct, arginfo_vphp__compiler__copyablebox___construct, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__CopyableBox, hold, arginfo_vphp__compiler__copyablebox_hold, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__CopyableBox, cloneInitialized, arginfo_vphp__compiler__copyablebox_cloneinitialized, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__CopyableBox, bump, arginfo_vphp__compiler__copyablebox_bump, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__CopyableBox, state, arginfo_vphp__compiler__copyablebox_state, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__CopyableBox, __serialize, arginfo_vphp__compiler__copyablebox___serialize, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__CopyableBox, __unserialize, arginfo_vphp__compiler__copyablebox___unserialize, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int vphp__compiler__copyablebox_register_class(void) {
    if (vphp__compiler__copyablebox_ce != NULL) {
        return SUCCESS;
    }
    vphp__compiler__copyablebox_ce = vphp_find_loaded_class_entry("VPHP\\Compiler\\CopyableBox", sizeof("VPHP\\Compiler\\CopyableBox")-1);
    if (vphp__compiler__copyablebox_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VPHP\\Compiler\\CopyableBox", vphp__compiler__copyablebox_methods);
        vphp__compiler__copyablebox_ce = zend_register_internal_class(&ce);
        vphp_init_cloneable_object_handlers(&vphp__compiler__copyablebox_object_handlers, vphp__compiler__copyablebox_clone_object);
        vphp__compiler__copyablebox_ce->create_object = vphp__compiler__copyablebox_create_object;
        {
            zval default_val;
            ZVAL_LONG(&default_val, 0);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_string *property_name = zend_string_init_interned("count", sizeof("count")-1, 1);
            zend_declare_typed_property(vphp__compiler__copyablebox_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
    }
    return SUCCESS;
}
zend_class_entry *vphp__compiler__taggedbox_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphp__compiler__taggedbox___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp__compiler__taggedbox___serialize, 0, 0, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp__compiler__taggedbox___unserialize, 0, 1, IS_VOID, 0)
ZEND_ARG_TYPE_INFO(0, data, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
extern vphp_class_handlers *vphp_tagged_box_handlers(void);
static zend_object_handlers vphp__compiler__taggedbox_object_handlers;
static zend_object *vphp__compiler__taggedbox_create_object(zend_class_entry *ce) {
    zend_object *obj = vphp_create_object_handler(ce);
    obj->handlers = &vphp__compiler__taggedbox_object_handlers;
    vphp_obj_from_obj(obj)->instance_handlers = vphp_tagged_box_handlers;
    return obj;
}
extern void vphp_tagged_box_clone_into_raw(void *, void *);
static zend_object *vphp__compiler__taggedbox_clone_object(zend_object *obj) {
    return vphp_clone_bound_object(obj, vphp_tagged_box_handlers(), vphp_tagged_box_clone_into_raw);
}
PHP_METHOD(VPHP__Compiler__TaggedBox, __serialize) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_tagged_box_serialize_tagged_state(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_tagged_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_tagged_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_vphp_tagged_box_serialize_tagged_state(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPHP__Compiler__TaggedBox, __unserialize) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_tagged_box_unserialize_tagged_state(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_tagged_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_tagged_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_NULL();
    }
    vphp_wrap_vphp_tagged_box_unserialize_tagged_state(wrapper->v_ptr, ctx);
    if (!EG(exception)) {
        vphp_mark_void_return(return_value);
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

ZEND_NAMED_FUNCTION(ZEND_MN(VPHP__Compiler__TaggedBox___construct)) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* vphp_tagged_box_handlers();
    vphp_class_handlers *h = vphp_tagged_box_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

static const zend_function_entry vphp__compiler__taggedbox_methods[] = {
    PHP_ME(VPHP__Compiler__TaggedBox, __construct, arginfo_vphp__compiler__taggedbox___construct, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__TaggedBox, __serialize, arginfo_vphp__compiler__taggedbox___serialize, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__TaggedBox, __unserialize, arginfo_vphp__compiler__taggedbox___unserialize, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int vphp__compiler__taggedbox_register_class(void) {
    if (vphp__compiler__taggedbox_ce != NULL) {
        return SUCCESS;
    }
    vphp__compiler__taggedbox_ce = vphp_find_loaded_class_entry("VPHP\\Compiler\\TaggedBox", sizeof("VPHP\\Compiler\\TaggedBox")-1);
    if (vphp__compiler__taggedbox_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VPHP\\Compiler\\TaggedBox", vphp__compiler__taggedbox_methods);
        zend_class_entry *parent_ce = vphp_require_class_entry("VPHP\\Compiler\\CopyableBox", sizeof("VPHP\\Compiler\\CopyableBox")-1, 0);
        if (!parent_ce) {
            zend_error(E_CORE_WARNING, "Cannot register %s: parent class %s was not found", "VPHP\\Compiler\\TaggedBox", "VPHP\\Compiler\\CopyableBox");
            return FAILURE;
        }
        vphp_verify_parent_reference_methods(&ce, parent_ce);
        vphp__compiler__taggedbox_ce = zend_register_internal_class_ex(&ce, parent_ce);
        vphp_init_cloneable_object_handlers(&vphp__compiler__taggedbox_object_handlers, vphp__compiler__taggedbox_clone_object);
        vphp__compiler__taggedbox_ce->create_object = vphp__compiler__taggedbox_create_object;
#if PHP_VERSION_ID >= 80400
        vphp_prepare_backed_property(vphp__compiler__taggedbox_ce, "tag", sizeof("tag")-1);
#endif
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("tag", sizeof("tag")-1, 1);
            zend_declare_typed_property(vphp__compiler__taggedbox_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
#if PHP_VERSION_ID >= 80400
        {
            static zend_function *inherited_hooks[ZEND_PROPERTY_HOOK_COUNT];
            vphp_inherit_backed_property_contract(vphp__compiler__taggedbox_ce, "tag", sizeof("tag")-1, inherited_hooks);
        }
#endif
        }
        vphp_prepare_class_constant_cache(vphp__compiler__taggedbox_ce);
#if PHP_VERSION_ID >= 80400
        vphp_verify_interface_property_contracts(vphp__compiler__taggedbox_ce, false);
#endif
    }
    return SUCCESS;
}
zend_class_entry *vphp__compiler__numberedbox_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphp__compiler__numberedbox___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
extern vphp_class_handlers *vphp_numbered_box_handlers(void);
static zend_object_handlers vphp__compiler__numberedbox_object_handlers;
static zend_object *vphp__compiler__numberedbox_create_object(zend_class_entry *ce) {
    zend_object *obj = vphp_create_object_handler(ce);
    obj->handlers = &vphp__compiler__numberedbox_object_handlers;
    vphp_obj_from_obj(obj)->instance_handlers = vphp_numbered_box_handlers;
    return obj;
}
extern void vphp_numbered_box_clone_into_raw(void *, void *);
static zend_object *vphp__compiler__numberedbox_clone_object(zend_object *obj) {
    return vphp_clone_bound_object(obj, vphp_numbered_box_handlers(), vphp_numbered_box_clone_into_raw);
}

ZEND_NAMED_FUNCTION(ZEND_MN(VPHP__Compiler__NumberedBox___construct)) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* vphp_numbered_box_handlers();
    vphp_class_handlers *h = vphp_numbered_box_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

static const zend_function_entry vphp__compiler__numberedbox_methods[] = {
    PHP_ME(VPHP__Compiler__NumberedBox, __construct, arginfo_vphp__compiler__numberedbox___construct, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int vphp__compiler__numberedbox_register_class(void) {
    if (vphp__compiler__numberedbox_ce != NULL) {
        return SUCCESS;
    }
    vphp__compiler__numberedbox_ce = vphp_find_loaded_class_entry("VPHP\\Compiler\\NumberedBox", sizeof("VPHP\\Compiler\\NumberedBox")-1);
    if (vphp__compiler__numberedbox_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VPHP\\Compiler\\NumberedBox", vphp__compiler__numberedbox_methods);
        zend_class_entry *parent_ce = vphp_require_class_entry("VPHP\\Compiler\\TaggedBox", sizeof("VPHP\\Compiler\\TaggedBox")-1, 0);
        if (!parent_ce) {
            zend_error(E_CORE_WARNING, "Cannot register %s: parent class %s was not found", "VPHP\\Compiler\\NumberedBox", "VPHP\\Compiler\\TaggedBox");
            return FAILURE;
        }
        vphp_verify_parent_reference_methods(&ce, parent_ce);
        vphp__compiler__numberedbox_ce = zend_register_internal_class_ex(&ce, parent_ce);
        vphp__compiler__numberedbox_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        vphp_init_cloneable_object_handlers(&vphp__compiler__numberedbox_object_handlers, vphp__compiler__numberedbox_clone_object);
        vphp__compiler__numberedbox_ce->create_object = vphp__compiler__numberedbox_create_object;
#if PHP_VERSION_ID >= 80400
        vphp_prepare_backed_property(vphp__compiler__numberedbox_ce, "number", sizeof("number")-1);
#endif
        {
            zval default_val;
            ZVAL_LONG(&default_val, 0);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_string *property_name = zend_string_init_interned("number", sizeof("number")-1, 1);
            zend_declare_typed_property(vphp__compiler__numberedbox_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
#if PHP_VERSION_ID >= 80400
        {
            static zend_function *inherited_hooks[ZEND_PROPERTY_HOOK_COUNT];
            vphp_inherit_backed_property_contract(vphp__compiler__numberedbox_ce, "number", sizeof("number")-1, inherited_hooks);
        }
#endif
        }
        vphp_prepare_class_constant_cache(vphp__compiler__numberedbox_ce);
#if PHP_VERSION_ID >= 80400
        vphp_verify_interface_property_contracts(vphp__compiler__numberedbox_ce, false);
#endif
    }
    return SUCCESS;
}
zend_class_entry *vphp__compiler__moduleprobetypedconsts_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphp__compiler__moduleprobetypedconsts___construct, 0, 0, 0)
ZEND_END_ARG_INFO()

ZEND_NAMED_FUNCTION(ZEND_MN(VPHP__Compiler__ModuleProbeTypedConsts___construct)) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* vphp_module_probe_typed_consts_handlers();
    vphp_class_handlers *h = vphp_module_probe_typed_consts_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

static const zend_function_entry vphp__compiler__moduleprobetypedconsts_methods[] = {
    PHP_ME(VPHP__Compiler__ModuleProbeTypedConsts, __construct, arginfo_vphp__compiler__moduleprobetypedconsts___construct, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int vphp__compiler__moduleprobetypedconsts_register_class(void) {
    if (vphp__compiler__moduleprobetypedconsts_ce != NULL) {
        return SUCCESS;
    }
    vphp__compiler__moduleprobetypedconsts_ce = vphp_find_loaded_class_entry("VPHP\\Compiler\\ModuleProbeTypedConsts", sizeof("VPHP\\Compiler\\ModuleProbeTypedConsts")-1);
    if (vphp__compiler__moduleprobetypedconsts_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VPHP\\Compiler\\ModuleProbeTypedConsts", vphp__compiler__moduleprobetypedconsts_methods);
        vphp__compiler__moduleprobetypedconsts_ce = zend_register_internal_class(&ce);
        {
            zval val;
            ZVAL_LONG(&val, 100);
            zend_string *const_name = zend_string_init("MAX_LIMIT", 9, 1);
#if PHP_VERSION_ID >= 80300
            zend_type constant_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_declare_typed_class_constant(vphp__compiler__moduleprobetypedconsts_ce, const_name, &val, ZEND_ACC_PUBLIC, NULL, constant_type);
#else
            zend_declare_class_constant_ex(vphp__compiler__moduleprobetypedconsts_ce, const_name, &val, ZEND_ACC_PUBLIC, NULL);
#endif
            zend_string_release(const_name);
        }
        {
            zval val;
            ZVAL_STR(&val, zend_string_init("1.0.0", 5, 1));
            zend_string *const_name = zend_string_init("CONST_VERSION", 13, 1);
#if PHP_VERSION_ID >= 80300
            zend_type constant_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_declare_typed_class_constant(vphp__compiler__moduleprobetypedconsts_ce, const_name, &val, ZEND_ACC_PUBLIC, NULL, constant_type);
#else
            zend_declare_class_constant_ex(vphp__compiler__moduleprobetypedconsts_ce, const_name, &val, ZEND_ACC_PUBLIC, NULL);
#endif
            zend_string_release(const_name);
        }
        {
            zval val;
            ZVAL_BOOL(&val, 1);
            zend_string *const_name = zend_string_init("IS_ACTIVE", 9, 1);
#if PHP_VERSION_ID >= 80300
            zend_type constant_type = ZEND_TYPE_INIT_CODE(_IS_BOOL, 0, 0);
            zend_declare_typed_class_constant(vphp__compiler__moduleprobetypedconsts_ce, const_name, &val, ZEND_ACC_PUBLIC, NULL, constant_type);
#else
            zend_declare_class_constant_ex(vphp__compiler__moduleprobetypedconsts_ce, const_name, &val, ZEND_ACC_PUBLIC, NULL);
#endif
            zend_string_release(const_name);
        }
        vphp__compiler__moduleprobetypedconsts_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        vphp__compiler__moduleprobetypedconsts_ce->create_object = vphp_create_object_handler;
    }
    return SUCCESS;
}
zend_class_entry *vphp__compiler__moduleprobewrapperbox_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphp__compiler__moduleprobewrapperbox___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp__compiler__moduleprobewrapperbox_change_props, 0, 6, IS_VOID, 0)
ZEND_ARG_TYPE_INFO(0, newVal, IS_MIXED, 0)
ZEND_ARG_TYPE_INFO(0, newObj, IS_OBJECT, 0)
ZEND_ARG_TYPE_INFO(0, newStr, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, newNum, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, newB, _IS_BOOL, 0)
ZEND_ARG_TYPE_INFO(0, newArr, IS_ARRAY, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VPHP__Compiler__ModuleProbeWrapperBox, change_props) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_vphp_module_probe_wrapper_box_change_props(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* vphp_module_probe_wrapper_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, vphp_module_probe_wrapper_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_NULL();
    }
    vphp_wrap_vphp_module_probe_wrapper_box_change_props(wrapper->v_ptr, ctx);
    if (!EG(exception)) {
        vphp_mark_void_return(return_value);
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

ZEND_NAMED_FUNCTION(ZEND_MN(VPHP__Compiler__ModuleProbeWrapperBox___construct)) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* vphp_module_probe_wrapper_box_handlers();
    vphp_class_handlers *h = vphp_module_probe_wrapper_box_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

static const zend_function_entry vphp__compiler__moduleprobewrapperbox_methods[] = {
    PHP_ME(VPHP__Compiler__ModuleProbeWrapperBox, __construct, arginfo_vphp__compiler__moduleprobewrapperbox___construct, ZEND_ACC_PUBLIC)
    PHP_ME(VPHP__Compiler__ModuleProbeWrapperBox, change_props, arginfo_vphp__compiler__moduleprobewrapperbox_change_props, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int vphp__compiler__moduleprobewrapperbox_register_class(void) {
    if (vphp__compiler__moduleprobewrapperbox_ce != NULL) {
        return SUCCESS;
    }
    vphp__compiler__moduleprobewrapperbox_ce = vphp_find_loaded_class_entry("VPHP\\Compiler\\ModuleProbeWrapperBox", sizeof("VPHP\\Compiler\\ModuleProbeWrapperBox")-1);
    if (vphp__compiler__moduleprobewrapperbox_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VPHP\\Compiler\\ModuleProbeWrapperBox", vphp__compiler__moduleprobewrapperbox_methods);
        vphp__compiler__moduleprobewrapperbox_ce = zend_register_internal_class(&ce);
        vphp__compiler__moduleprobewrapperbox_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        vphp__compiler__moduleprobewrapperbox_ce->create_object = vphp_create_object_handler;
        zend_declare_property_null(vphp__compiler__moduleprobewrapperbox_ce, "val", sizeof("val")-1, ZEND_ACC_PUBLIC);
        {
            zval default_val;
            ZVAL_NULL(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_OBJECT, 0, 0);
            zend_string *property_name = zend_string_init_interned("obj", sizeof("obj")-1, 1);
            zend_declare_typed_property(vphp__compiler__moduleprobewrapperbox_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("str", sizeof("str")-1, 1);
            zend_declare_typed_property(vphp__compiler__moduleprobewrapperbox_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
        {
            zval default_val;
            ZVAL_LONG(&default_val, 0);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_string *property_name = zend_string_init_interned("num", sizeof("num")-1, 1);
            zend_declare_typed_property(vphp__compiler__moduleprobewrapperbox_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
        {
            zval default_val;
            ZVAL_FALSE(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(_IS_BOOL, 0, 0);
            zend_string *property_name = zend_string_init_interned("b", sizeof("b")-1, 1);
            zend_declare_typed_property(vphp__compiler__moduleprobewrapperbox_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
        {
            zval default_val;
            ZVAL_NULL(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_ARRAY, 0, 0);
            zend_string *property_name = zend_string_init_interned("arr", sizeof("arr")-1, 1);
            zend_declare_typed_property(vphp__compiler__moduleprobewrapperbox_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
    }
    return SUCCESS;
}
zend_class_entry *traitpost_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_traitpost___construct, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, title, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_traitpost_summary, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_traitpost_bump, 0, 0, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_traitpost_trait_only, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_traitpost_internal_trait, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(TraitPost, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* trait_post_handlers();
    vphp_class_handlers *h = trait_post_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_trait_post_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_trait_post_construct(v_ptr, ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(TraitPost, summary) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_trait_post_summary(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* trait_post_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, trait_post_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_trait_post_summary(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(TraitPost, bump) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_trait_post_bump(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* trait_post_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, trait_post_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_trait_post_bump(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(TraitPost, trait_only) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_trait_post_trait_only(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* trait_post_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, trait_post_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_trait_post_trait_only(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(TraitPost, internal_trait) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_trait_post_internal_trait(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* trait_post_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, trait_post_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_trait_post_internal_trait(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry traitpost_methods[] = {
    PHP_ME(TraitPost, __construct, arginfo_traitpost___construct, ZEND_ACC_PUBLIC)
    PHP_ME(TraitPost, summary, arginfo_traitpost_summary, ZEND_ACC_PUBLIC)
    PHP_ME(TraitPost, bump, arginfo_traitpost_bump, ZEND_ACC_PUBLIC)
    PHP_ME(TraitPost, trait_only, arginfo_traitpost_trait_only, ZEND_ACC_PUBLIC)
    PHP_ME(TraitPost, internal_trait, arginfo_traitpost_internal_trait, ZEND_ACC_PROTECTED)
    PHP_FE_END
};

static int traitpost_register_class(void) {
    if (traitpost_ce != NULL) {
        return SUCCESS;
    }
    traitpost_ce = vphp_find_loaded_class_entry("TraitPost", sizeof("TraitPost")-1);
    if (traitpost_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "TraitPost", traitpost_methods);
        traitpost_ce = zend_register_internal_class(&ce);
        traitpost_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        traitpost_ce->create_object = vphp_create_object_handler;
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("title", sizeof("title")-1, 1);
            zend_declare_typed_property(traitpost_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("slug", sizeof("slug")-1, 1);
            zend_declare_typed_property(traitpost_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
        {
            zval default_val;
            ZVAL_LONG(&default_val, 0);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_LONG, 0, 0);
            zend_string *property_name = zend_string_init_interned("visits", sizeof("visits")-1, 1);
            zend_declare_typed_property(traitpost_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("internal_note", sizeof("internal_note")-1, 1);
            zend_declare_typed_property(traitpost_ce, property_name, &default_val, ZEND_ACC_PROTECTED, NULL, property_type);
        }
    }
    return SUCCESS;
}
zend_class_entry *validator_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_validator___construct, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, strict, _IS_BOOL, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_validator_check, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, input, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_validator_sanitize, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, input, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_validator_assert_valid, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, input, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_validator_parse_int, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, s, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(Validator, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* validator_handlers();
    vphp_class_handlers *h = validator_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_validator_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_validator_construct(v_ptr, ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Validator, check) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_validator_check(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* validator_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, validator_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_validator_check(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Validator, sanitize) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_validator_sanitize(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* validator_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, validator_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_validator_sanitize(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Validator, assert_valid) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_validator_assert_valid(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* validator_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, validator_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_validator_assert_valid(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Validator, parse_int) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_validator_parse_int(vphp_context_internal ctx);
    vphp_wrap_validator_parse_int(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry validator_methods[] = {
    PHP_ME(Validator, __construct, arginfo_validator___construct, ZEND_ACC_PUBLIC)
    PHP_ME(Validator, check, arginfo_validator_check, ZEND_ACC_PUBLIC)
    PHP_ME(Validator, sanitize, arginfo_validator_sanitize, ZEND_ACC_PUBLIC)
    PHP_ME(Validator, assert_valid, arginfo_validator_assert_valid, ZEND_ACC_PUBLIC)
    PHP_ME(Validator, parse_int, arginfo_validator_parse_int, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_FE_END
};

static int validator_register_class(void) {
    if (validator_ce != NULL) {
        return SUCCESS;
    }
    validator_ce = vphp_find_loaded_class_entry("Validator", sizeof("Validator")-1);
    if (validator_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Validator", validator_methods);
        validator_ce = zend_register_internal_class(&ce);
        validator_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        validator_ce->create_object = vphp_create_object_handler;
        {
            zval default_val;
            ZVAL_FALSE(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(_IS_BOOL, 0, 0);
            zend_string *property_name = zend_string_init_interned("strict", sizeof("strict")-1, 1);
            zend_declare_typed_property(validator_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
    }
    return SUCCESS;
}
zend_class_entry *dispatchablesample_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_dispatchablesample___construct, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_dispatchablesample_tagged, 0, 1, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(DispatchableSample, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* dispatchable_sample_handlers();
    vphp_class_handlers *h = dispatchable_sample_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_dispatchable_sample_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_dispatchable_sample_construct(v_ptr, ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(DispatchableSample, tagged) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_dispatchable_sample_tagged(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* dispatchable_sample_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, dispatchable_sample_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_dispatchable_sample_tagged(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry dispatchablesample_methods[] = {
    PHP_ME(DispatchableSample, __construct, arginfo_dispatchablesample___construct, ZEND_ACC_PUBLIC)
    PHP_ME(DispatchableSample, tagged, arginfo_dispatchablesample_tagged, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int dispatchablesample_register_class(void) {
    if (dispatchablesample_ce != NULL) {
        return SUCCESS;
    }
    dispatchablesample_ce = vphp_find_loaded_class_entry("DispatchableSample", sizeof("DispatchableSample")-1);
    if (dispatchablesample_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "DispatchableSample", dispatchablesample_methods);
        dispatchablesample_ce = zend_register_internal_class(&ce);
        dispatchablesample_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        dispatchablesample_ce->create_object = vphp_create_object_handler;
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("name", sizeof("name")-1, 1);
            zend_declare_typed_property(dispatchablesample_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
        zend_string *attribute_dispatchablesample_0_name = zend_string_init_interned("PhpDispatchable", sizeof("PhpDispatchable")-1, 1);
        zend_attribute *attribute_dispatchablesample_0 = vphp_zend_add_class_attribute(dispatchablesample_ce, attribute_dispatchablesample_0_name, 1);
        zend_string_release(attribute_dispatchablesample_0_name);
        ZVAL_STR(&attribute_dispatchablesample_0->args[0].value, zend_string_init_interned("worker", 6, 1));
        zend_function *method_dispatchablesample_1 = zend_hash_str_find_ptr_lc(&dispatchablesample_ce->function_table, "tagged", sizeof("tagged")-1);
        if (method_dispatchablesample_1 != NULL) {
        zend_string *attribute_dispatchablesample_1_0_0_name = zend_string_init_interned("FromQuery", sizeof("FromQuery")-1, 1);
        zend_attribute *attribute_dispatchablesample_1_0_0 = vphp_zend_add_parameter_attribute(method_dispatchablesample_1, 0, attribute_dispatchablesample_1_0_0_name, 1);
        zend_string_release(attribute_dispatchablesample_1_0_0_name);
        ZVAL_STR(&attribute_dispatchablesample_1_0_0->args[0].value, zend_string_init_interned("name", 4, 1));
        zend_string *attribute_dispatchablesample_1_0_1_name = zend_string_init_interned("MustBeString", sizeof("MustBeString")-1, 1);
        zend_attribute *attribute_dispatchablesample_1_0_1 = vphp_zend_add_parameter_attribute(method_dispatchablesample_1, 0, attribute_dispatchablesample_1_0_1_name, 0);
        zend_string_release(attribute_dispatchablesample_1_0_1_name);
        }
    }
    return SUCCESS;
}
zend_class_entry *articlestatus_ce = NULL;

extern void vphp_enum_backing_values_articlestatus(int64_t *);
static const zend_function_entry articlestatus_methods[] = {
    PHP_FE_END
};

static int articlestatus_register_class(void) {
    if (articlestatus_ce != NULL) {
        return SUCCESS;
    }
    articlestatus_ce = vphp_find_loaded_class_entry("ArticleStatus", sizeof("ArticleStatus")-1);
    if (articlestatus_ce != NULL) {
        return SUCCESS;
    }
    {
        articlestatus_ce = zend_register_internal_enum("ArticleStatus", IS_LONG, NULL);
        int64_t backing_values[3];
        vphp_enum_backing_values_articlestatus(backing_values);
        {
            int64_t value = backing_values[0];
            if (value < ZEND_LONG_MIN || value > ZEND_LONG_MAX) {
                zend_error(E_WARNING, "PHP enum ArticleStatus::draft has a backing value outside the PHP integer range");
                return FAILURE;
            }
            if (zend_hash_index_exists(articlestatus_ce->backed_enum_table, (zend_ulong)value)) {
                zend_error(E_WARNING, "PHP enum ArticleStatus::draft duplicates an integer backing value");
                return FAILURE;
            }
            zval backing_value;
            ZVAL_LONG(&backing_value, (zend_long)value);
            zend_enum_add_case_cstr(articlestatus_ce, "draft", &backing_value);
        }
        {
            int64_t value = backing_values[1];
            if (value < ZEND_LONG_MIN || value > ZEND_LONG_MAX) {
                zend_error(E_WARNING, "PHP enum ArticleStatus::review has a backing value outside the PHP integer range");
                return FAILURE;
            }
            if (zend_hash_index_exists(articlestatus_ce->backed_enum_table, (zend_ulong)value)) {
                zend_error(E_WARNING, "PHP enum ArticleStatus::review duplicates an integer backing value");
                return FAILURE;
            }
            zval backing_value;
            ZVAL_LONG(&backing_value, (zend_long)value);
            zend_enum_add_case_cstr(articlestatus_ce, "review", &backing_value);
        }
        {
            int64_t value = backing_values[2];
            if (value < ZEND_LONG_MIN || value > ZEND_LONG_MAX) {
                zend_error(E_WARNING, "PHP enum ArticleStatus::published has a backing value outside the PHP integer range");
                return FAILURE;
            }
            if (zend_hash_index_exists(articlestatus_ce->backed_enum_table, (zend_ulong)value)) {
                zend_error(E_WARNING, "PHP enum ArticleStatus::published duplicates an integer backing value");
                return FAILURE;
            }
            zval backing_value;
            ZVAL_LONG(&backing_value, (zend_long)value);
            zend_enum_add_case_cstr(articlestatus_ce, "published", &backing_value);
        }
    }
    return SUCCESS;
}
zend_class_entry *vphp__task_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphp__task___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphp__task_spawn, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphp__task_wait, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphp__task_list, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VPhp__Task, spawn) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_v_php_task_spawn(vphp_context_internal ctx);
    vphp_wrap_v_php_task_spawn(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPhp__Task, wait) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_v_php_task_wait(vphp_context_internal ctx);
    vphp_wrap_v_php_task_wait(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPhp__Task, list) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_v_php_task_list(vphp_context_internal ctx);
    vphp_wrap_v_php_task_list(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

ZEND_NAMED_FUNCTION(ZEND_MN(VPhp__Task___construct)) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* v_php_task_handlers();
    vphp_class_handlers *h = v_php_task_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

static const zend_function_entry vphp__task_methods[] = {
    PHP_ME(VPhp__Task, __construct, arginfo_vphp__task___construct, ZEND_ACC_PUBLIC)
    PHP_ME(VPhp__Task, spawn, arginfo_vphp__task_spawn, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VPhp__Task, wait, arginfo_vphp__task_wait, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VPhp__Task, list, arginfo_vphp__task_list, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_FE_END
};

static int vphp__task_register_class(void) {
    if (vphp__task_ce != NULL) {
        return SUCCESS;
    }
    vphp__task_ce = vphp_find_loaded_class_entry("VPhp\\Task", sizeof("VPhp\\Task")-1);
    if (vphp__task_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VPhp\\Task", vphp__task_methods);
        vphp__task_ce = zend_register_internal_class(&ce);
        vphp__task_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        vphp__task_ce->create_object = vphp_create_object_handler;
    }
    return SUCCESS;
}
zend_class_entry *stringablebox_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_stringablebox___construct, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_stringablebox___tostring, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(StringableBox, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* stringable_box_handlers();
    vphp_class_handlers *h = stringable_box_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_stringable_box_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_stringable_box_construct(v_ptr, ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(StringableBox, __toString) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_stringable_box_str(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* stringable_box_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_task_native_pin *vphp_this_pin = vphp_pin_native_receiver(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, stringable_box_handlers());
    if (!wrapper->v_ptr) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        RETURN_FALSE;
    }
    vphp_wrap_stringable_box_str(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
        return;
    }
    vphp_unpin_native_receiver(vphp_this_obj, vphp_this_pin);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry stringablebox_methods[] = {
    PHP_ME(StringableBox, __construct, arginfo_stringablebox___construct, ZEND_ACC_PUBLIC)
    PHP_ME(StringableBox, __toString, arginfo_stringablebox___tostring, ZEND_ACC_PUBLIC)
    PHP_FE_END
};

static int stringablebox_register_class(void) {
    if (stringablebox_ce != NULL) {
        return SUCCESS;
    }
    stringablebox_ce = vphp_find_loaded_class_entry("StringableBox", sizeof("StringableBox")-1);
    if (stringablebox_ce != NULL) {
        return SUCCESS;
    }
    {
        zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "StringableBox", stringablebox_methods);
        stringablebox_ce = zend_register_internal_class(&ce);
        stringablebox_ce->ce_flags |= ZEND_ACC_NOT_SERIALIZABLE;
        stringablebox_ce->create_object = vphp_create_object_handler;
        {
            zval default_val;
            ZVAL_EMPTY_STRING(&default_val);
            zend_type property_type = ZEND_TYPE_INIT_CODE(IS_STRING, 0, 0);
            zend_string *property_name = zend_string_init_interned("name", sizeof("name")-1, 1);
            zend_declare_typed_property(stringablebox_ce, property_name, &default_val, ZEND_ACC_PUBLIC, NULL, property_type);
        }
    }
    return SUCCESS;
}
static const vphp_static_request_property vphp_vphptest_with_static_request_properties[] = {
    {&article_ce, "total_count", sizeof("total_count") - 1},
};
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_vphp_vphptest_with_static_request, 0, 1, IS_MIXED, 0)
    ZEND_ARG_CALLABLE_INFO(0, callback, 0)
ZEND_END_ARG_INFO()
PHP_FUNCTION(vphp_vphptest_with_static_request) {
    vphp_run_static_request(INTERNAL_FUNCTION_PARAM_PASSTHRU, vphp_vphptest_with_static_request_properties,
        sizeof(vphp_vphptest_with_static_request_properties) / sizeof(vphp_vphptest_with_static_request_properties[0]));
}
static bool vphp_dispatch_computed_default(const zend_internal_function *func, zend_long callable, zend_long field) {
    switch (callable) {
        case 0:
            return (field == 4) && vphp_matches_computed_default_arginfo(func, struct_closure_arginfo_v_get_struct_default_closure_storage);
        case 1:
            return (field == 4) && vphp_matches_computed_default_arginfo(func, struct_closure_arginfo_v_get_struct_default_closure_void_storage);
        case 2:
            return (field == 1 || field == 2) && vphp_matches_computed_default_arginfo(func, struct_closure_arginfo_v_get_struct_computed_defaults_closure_storage);
        case 3:
            return (field == 0) && vphp_matches_computed_default_arginfo(func, struct_closure_arginfo_v_get_struct_native_defaults_closure_storage);
        case 4:
            return (field == 0 || field == 1) && vphp_matches_computed_default_arginfo(func, struct_closure_arginfo_v_get_struct_failing_defaults_closure_storage);
        case 5:
            return (field == 0 || field == 1) && vphp_matches_computed_default_handler(func, ZEND_MN(CallableProcessor_computedParams));
        case 6:
            return (field == 1 || field == 2) && vphp_matches_computed_default_handler(func, ZEND_FN(v_php_computed_params));
        default: break;
    }
    return false;
}
ZEND_BEGIN_MODULE_GLOBALS(vphptest)
    zend_long request_count;
    v_string last_user;
ZEND_END_MODULE_GLOBALS(vphptest)

ZEND_DECLARE_MODULE_GLOBALS(vphptest)
#define VPHP_G(v) ZEND_MODULE_GLOBALS_ACCESSOR(vphptest, v)
static void php_vphptest_init_globals(zend_vphptest_globals *globals) {
    globals->request_count = 0;
    globals->last_user.str = NULL;
    globals->last_user.len = 0;
    globals->last_user.is_lit = 0;
}
PHP_INI_BEGIN()
    PHP_INI_ENTRY("vphptest.enable_cache", "1", PHP_INI_ALL, NULL)
    PHP_INI_ENTRY("vphptest.max_threads", "4", PHP_INI_ALL, NULL)
PHP_INI_END()
static const zend_function_entry vphptest_functions[] = {
    PHP_FE(v_add, arginfo_v_add)
    PHP_FE(v_greet, arginfo_v_greet)
    PHP_FE(v_float_const, arginfo_v_float_const)
    PHP_FE(v_float_id, arginfo_v_float_id)
    PHP_FE(v_pure_map_test, arginfo_v_pure_map_test)
    PHP_FE(v_process_list, arginfo_v_process_list)
    PHP_FE(v_test_map, arginfo_v_test_map)
    PHP_FE(v_get_config, arginfo_v_get_config)
    PHP_FE(v_get_user, arginfo_v_get_user)
    PHP_FE(v_call_back, arginfo_v_call_back)
    PHP_FE(v_bind_class_interface, arginfo_v_bind_class_interface)
    PHP_FE(v_complex_test, arginfo_v_complex_test)
    PHP_FE(v_persistent_nested_roundtrip, arginfo_v_persistent_nested_roundtrip)
    PHP_FE(v_persistent_multi_nested_stress, arginfo_v_persistent_multi_nested_stress)
    PHP_FE(v_analyze_user_object, arginfo_v_analyze_user_object)
    PHP_FE(v_mutate_user_object, arginfo_v_mutate_user_object)
    PHP_FE(v_check_user_object_props, arginfo_v_check_user_object_props)
    PHP_FE(v_construct_php_object, arginfo_v_construct_php_object)
    PHP_FE(v_call_php_static_method, arginfo_v_call_php_static_method)
    PHP_FE(v_mutate_php_static_prop, arginfo_v_mutate_php_static_prop)
    PHP_FE(v_read_php_class_constant, arginfo_v_read_php_class_constant)
    PHP_FE(v_typed_php_interop, arginfo_v_typed_php_interop)
    PHP_FE(v_typed_object_restore, arginfo_v_typed_object_restore)
    PHP_FE(v_zval_conversion_api, arginfo_v_zval_conversion_api)
    PHP_FE(v_persistent_fallback_counter_probe, arginfo_v_persistent_fallback_counter_probe)
    PHP_FE(v_request_scope_counter_probe, arginfo_v_request_scope_counter_probe)
    PHP_FE(v_php_value_zbox_lifecycle_probe, arginfo_v_php_value_zbox_lifecycle_probe)
    PHP_FE(v_unified_object_interop, arginfo_v_unified_object_interop)
    PHP_FE(v_php_class_named_api, arginfo_v_php_class_named_api)
    PHP_FE(v_php_function_named_api, arginfo_v_php_function_named_api)
    PHP_FE(v_php_closure_api, arginfo_v_php_closure_api)
    PHP_FE(v_php_closure_persistent_api, arginfo_v_php_closure_persistent_api)
    PHP_FE(v_php_class_meta_api, arginfo_v_php_class_meta_api)
    PHP_FE(v_php_object_api, arginfo_v_php_object_api)
    PHP_FE(v_php_array_api, arginfo_v_php_array_api)
    PHP_FE(v_php_callable_api, arginfo_v_php_callable_api)
    PHP_FE(v_php_value_api, arginfo_v_php_value_api)
    PHP_FE(v_php_scalar_api, arginfo_v_php_scalar_api)
    PHP_FE(v_php_scalar_strict_api, arginfo_v_php_scalar_strict_api)
    PHP_FE(v_php_semantic_empty_api, arginfo_v_php_semantic_empty_api)
    PHP_FE(v_php_params_struct_api, arginfo_v_php_params_struct_api)
    PHP_FE(v_php_computed_params, arginfo_v_php_computed_params)
    PHP_FE(v_php_arg_binding_optional_scalar_api, arginfo_v_php_arg_binding_optional_scalar_api)
    PHP_FE(v_php_direct_arg_camel_api, arginfo_v_php_direct_arg_camel_api)
    PHP_FE(v_php_call_style_arg_attrs_api, arginfo_v_php_call_style_arg_attrs_api)
    PHP_FE(v_php_semantic_params_struct_api, arginfo_v_php_semantic_params_struct_api)
    PHP_FE(v_php_args_api, arginfo_v_php_args_api)
    PHP_FE(v_php_resource_api, arginfo_v_php_resource_api)
    PHP_FE(v_php_wrapper_param_api, arginfo_v_php_wrapper_param_api)
    PHP_FE(v_php_optional_value_api, arginfo_v_php_optional_value_api)
    PHP_FE(v_php_optional_object_api, arginfo_v_php_optional_object_api)
    PHP_FE(v_php_return_value_api, arginfo_v_php_return_value_api)
    PHP_FE(v_php_return_array_api, arginfo_v_php_return_array_api)
    PHP_FE(v_php_return_object_api, arginfo_v_php_return_object_api)
    PHP_FE(v_php_return_callable_api, arginfo_v_php_return_callable_api)
    PHP_FE(v_php_return_string_wrapper_api, arginfo_v_php_return_string_wrapper_api)
    PHP_FE(v_php_return_persistent_array_api, arginfo_v_php_return_persistent_array_api)
    PHP_FE(v_dyn_value_runtime_refs, arginfo_v_dyn_value_runtime_refs)
    PHP_FE(v_php_reference_api, arginfo_v_php_reference_api)
    PHP_FE(v_step_reference, arginfo_v_step_reference)
    PHP_FE(v_optional_reference, arginfo_v_optional_reference)
    PHP_FE(v_step_references, arginfo_v_step_references)
    PHP_FE(v_replace_reference, arginfo_v_replace_reference)
    PHP_FE(v_php_iterable_api, arginfo_v_php_iterable_api)
    PHP_FE(v_php_superglobals_api, arginfo_v_php_superglobals_api)
    PHP_FE(v_php_throwable_api, arginfo_v_php_throwable_api)
    PHP_FE(v_php_enum_api, arginfo_v_php_enum_api)
    PHP_FE(v_unified_ownership_interop, arginfo_v_unified_ownership_interop)
    PHP_FE(v_read_php_global_const, arginfo_v_read_php_global_const)
    PHP_FE(v_php_symbol_exists, arginfo_v_php_symbol_exists)
    PHP_FE(v_include_php_file, arginfo_v_include_php_file)
    PHP_FE(v_include_php_file_once, arginfo_v_include_php_file_once)
    PHP_FE(v_include_php_module_demo, arginfo_v_include_php_module_demo)
    PHP_FE(v_php_object_meta, arginfo_v_php_object_meta)
    PHP_FE(v_php_object_introspection, arginfo_v_php_object_introspection)
    PHP_FE(v_php_array_introspection, arginfo_v_php_array_introspection)
    PHP_FE(v_php_object_probe, arginfo_v_php_object_probe)
    PHP_FE(v_trigger_user_action, arginfo_v_trigger_user_action)
    PHP_FE(v_call_php_closure, arginfo_v_call_php_closure)
    PHP_FE(v_call_php_closure_helper, arginfo_v_call_php_closure_helper)
    PHP_FE(v_test_globals, arginfo_v_test_globals)
    PHP_FE(v_get_v_closure, arginfo_v_get_v_closure)
    PHP_FE(v_get_v_closure_auto, arginfo_v_get_v_closure_auto)
    PHP_FE(v_iter_helpers_demo, arginfo_v_iter_helpers_demo)
    PHP_FE(v_iterable_object_demo, arginfo_v_iterable_object_demo)
    PHP_FE(v_reverse_string, arginfo_v_reverse_string)
    PHP_FE(v_logic_main, arginfo_v_logic_main)
    PHP_FE(v_invoke_callable, arginfo_v_invoke_callable)
    PHP_FE(v_invoke_with_arg, arginfo_v_invoke_with_arg)
    PHP_FE(v_get_closure_0, arginfo_v_get_closure_0)
    PHP_FE(v_get_closure_1, arginfo_v_get_closure_1)
    PHP_FE(v_get_closure_2, arginfo_v_get_closure_2)
    PHP_FE(v_get_closure_3, arginfo_v_get_closure_3)
    PHP_FE(v_get_closure_4, arginfo_v_get_closure_4)
    PHP_FE(v_get_closure_3_void, arginfo_v_get_closure_3_void)
    PHP_FE(v_get_closure_4_void, arginfo_v_get_closure_4_void)
    PHP_FE(v_get_struct_param_closure, arginfo_v_get_struct_param_closure)
    PHP_FE(v_get_struct_default_closure, arginfo_v_get_struct_default_closure)
    PHP_FE(v_get_struct_default_closure_void, arginfo_v_get_struct_default_closure_void)
    PHP_FE(v_get_struct_computed_defaults_closure, arginfo_v_get_struct_computed_defaults_closure)
    PHP_FE(v_get_struct_native_defaults_closure, arginfo_v_get_struct_native_defaults_closure)
    PHP_FE(v_get_struct_failing_defaults_closure, arginfo_v_get_struct_failing_defaults_closure)
    PHP_FE(v_invoke_legacy_struct_closure, arginfo_v_invoke_legacy_struct_closure)
    PHP_FE(v_invoke_legacy_struct_closure_void, arginfo_v_invoke_legacy_struct_closure_void)
    PHP_FE(v_get_variadic_value_closure, arginfo_v_get_variadic_value_closure)
    PHP_FE(v_get_variadic_zval_closure, arginfo_v_get_variadic_zval_closure)
    PHP_FE(v_get_variadic_zval_void, arginfo_v_get_variadic_zval_void)
    PHP_FE(v_get_variadic_borrowed_closure, arginfo_v_get_variadic_borrowed_closure)
    PHP_FE(v_get_variadic_scalar_string, arginfo_v_get_variadic_scalar_string)
    PHP_FE(v_get_variadic_scalar_i64, arginfo_v_get_variadic_scalar_i64)
    PHP_FE(v_get_variadic_scalar_value, arginfo_v_get_variadic_scalar_value)
    PHP_FE(v_invoke_legacy_variadic_scalar, arginfo_v_invoke_legacy_variadic_scalar)
    PHP_FE(v_invoke_legacy_variadic_scalar_alias, arginfo_v_invoke_legacy_variadic_scalar_alias)
    PHP_FE(v_invoke_legacy_variadic_void, arginfo_v_invoke_legacy_variadic_void)
    PHP_FE(v_invoke_legacy_variadic_void_alias, arginfo_v_invoke_legacy_variadic_void_alias)
    PHP_FE(v_php_literal_params, arginfo_v_php_literal_params)
    PHP_FE(v_get_struct_literal_defaults_closure, arginfo_v_get_struct_literal_defaults_closure)
    PHP_FE(v_php_overridden_params, arginfo_v_php_overridden_params)
    PHP_FE(v_php_direct_defaults, arginfo_v_php_direct_defaults)
    PHP_FE(v_php_legacy_optional_tail, arginfo_v_php_legacy_optional_tail)
    PHP_FE(v_lifecycle_hook_state, arginfo_v_lifecycle_hook_state)
    PHP_FE(v_test_concurrent_object_roots, arginfo_v_test_concurrent_object_roots)
    PHP_FE(v_find_after, arginfo_v_find_after)
    PHP_FE(v_try_divide, arginfo_v_try_divide)
    PHP_FE(v_record_match, arginfo_v_record_match)
    PHP_FE(v_typed_raw_string_param, arginfo_v_typed_raw_string_param)
    PHP_FE(v_typed_alias_bool_param, arginfo_v_typed_alias_bool_param)
    PHP_FE(v_typed_bool_params, arginfo_v_typed_bool_params)
    PHP_FE(v_compiler_probe, arginfo_v_compiler_probe)
    PHP_FE(v_compiler_probe_named_sum, arginfo_v_compiler_probe_named_sum)
    PHP_FE(v_compiler_probe_explicit_union, arginfo_v_compiler_probe_explicit_union)
    PHP_FE(v_compiler_probe_intersection, arginfo_v_compiler_probe_intersection)
    PHP_FE(v_compiler_probe_wrong_dnf_return, arginfo_v_compiler_probe_wrong_dnf_return)
    PHP_FE(v_compiler_probe_variadic, arginfo_v_compiler_probe_variadic)
    PHP_FE(v_compiler_probe_options, arginfo_v_compiler_probe_options)
    PHP_FE(v_typed_string_param, arginfo_v_typed_string_param)
    PHP_FE(v_typed_required_string_param, arginfo_v_typed_required_string_param)
    PHP_FE(v_new_coach, arginfo_v_new_coach)
    PHP_FE(v_new_db, arginfo_v_new_db)
    PHP_FE(v_check_res, arginfo_v_check_res)
    PHP_FE(v_safe_divide, arginfo_v_safe_divide)
    PHP_FE(v_capitalize, arginfo_v_capitalize)
    PHP_FE(v_record_success, arginfo_v_record_success)
    PHP_FE(v_php_param_attr_api, arginfo_v_php_param_attr_api)
    PHP_FE(v_php_arg_attr_runtime_api, arginfo_v_php_arg_attr_runtime_api)
    PHP_FE(v_analyze_fitness_data, arginfo_v_analyze_fitness_data)
    PHP_FE(v_get_alerts, arginfo_v_get_alerts)
    PHP_FE(vphp_vphptest_with_static_request, arginfo_vphp_vphptest_with_static_request)
    PHP_FE_END
};
PHP_MINIT_FUNCTION(vphptest) {
#if PHP_VERSION_ID >= 80300
    arginfo_v_compiler_probe_intersection[0].type = vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("Iterator"), vphp_arginfo_class_type("Countable")}, 2, _ZEND_TYPE_INTERSECTION_BIT | _ZEND_ARG_INFO_FLAGS(0, 0, 0));
    arginfo_v_compiler_probe_intersection[1].type = vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("Iterator"), vphp_arginfo_class_type("Countable")}, 2, _ZEND_TYPE_INTERSECTION_BIT | _ZEND_ARG_INFO_FLAGS(0, 0, 0));
    arginfo_v_compiler_probe_wrong_dnf_return[0].type = vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("ArrayObject"), vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("Iterator"), vphp_arginfo_class_type("Countable")}, 2, _ZEND_TYPE_INTERSECTION_BIT)}, 2, _ZEND_TYPE_UNION_BIT | _ZEND_ARG_INFO_FLAGS(0, 0, 0));
#endif
    if (zend_register_functions(NULL, vphptest_functions, NULL, type) != SUCCESS) {
        return FAILURE;
    }
    EG(current_module)->functions = vphptest_functions;
#if PHP_VERSION_ID < 80300
    {
        zend_function *registered = zend_hash_str_find_ptr_lc(CG(function_table), "v_compiler_probe_intersection", sizeof("v_compiler_probe_intersection")-1);
        if (!registered || !registered->common.arg_info) { return FAILURE; }
        (registered->common.arg_info - 1)[0].type = vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("Iterator"), vphp_arginfo_class_type("Countable")}, 2, _ZEND_TYPE_INTERSECTION_BIT | _ZEND_ARG_INFO_FLAGS(0, 0, 0));
        (registered->common.arg_info - 1)[1].type = vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("Iterator"), vphp_arginfo_class_type("Countable")}, 2, _ZEND_TYPE_INTERSECTION_BIT | _ZEND_ARG_INFO_FLAGS(0, 0, 0));
    }
    {
        zend_function *registered = zend_hash_str_find_ptr_lc(CG(function_table), "v_compiler_probe_wrong_dnf_return", sizeof("v_compiler_probe_wrong_dnf_return")-1);
        if (!registered || !registered->common.arg_info) { return FAILURE; }
        (registered->common.arg_info - 1)[0].type = vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("ArrayObject"), vphp_arginfo_type_list((zend_type[]){vphp_arginfo_class_type("Iterator"), vphp_arginfo_class_type("Countable")}, 2, _ZEND_TYPE_INTERSECTION_BIT)}, 2, _ZEND_TYPE_UNION_BIT | _ZEND_ARG_INFO_FLAGS(0, 0, 0));
    }
#endif
    _vinit_caller();
    vphp_framework_init(module_number);
    vphp_call_optional_void_symbol("vphp_ext_auto_startup");
    vphp_call_optional_void_symbol("vphp_ext_startup");
    REGISTER_INI_ENTRIES();
    vphp_register_closure_default_class("VPHP\\Internal\\vphptest_ClosureDefault", vphp_dispatch_computed_default);
        REGISTER_STRINGL_CONSTANT("APP_VERSION", "1.0.0", 5, CONST_CS | CONST_PERSISTENT);
        REGISTER_LONG_CONSTANT("MAX_RETRY", 3, CONST_CS | CONST_PERSISTENT);
        REGISTER_DOUBLE_CONSTANT("PI_VALUE", 3.14159, CONST_CS | CONST_PERSISTENT);
        REGISTER_BOOL_CONSTANT("DEBUG_MODE", 0, CONST_CS | CONST_PERSISTENT);
        REGISTER_STRINGL_CONSTANT("COMPILER_PROBE_CONSTANT", "module-constant-ok", 18, CONST_CS | CONST_PERSISTENT);
    {
        zend_function *func_v_php_param_attr_api = zend_hash_str_find_ptr_lc(CG(function_table), "v_php_param_attr_api", sizeof("v_php_param_attr_api")-1);
        if (func_v_php_param_attr_api != NULL) {
            zend_string *attribute_v_php_param_attr_api_0_0_name = zend_string_init_interned("FromQuery", sizeof("FromQuery")-1, 1);
            zend_attribute *attribute_v_php_param_attr_api_0_0 = vphp_zend_add_parameter_attribute(func_v_php_param_attr_api, 0, attribute_v_php_param_attr_api_0_0_name, 1);
            zend_string_release(attribute_v_php_param_attr_api_0_0_name);
            ZVAL_STR(&attribute_v_php_param_attr_api_0_0->args[0].value, zend_string_init_interned("q", 1, 1));
            zend_string *attribute_v_php_param_attr_api_0_1_name = zend_string_init_interned("MustBeString", sizeof("MustBeString")-1, 1);
            zend_attribute *attribute_v_php_param_attr_api_0_1 = vphp_zend_add_parameter_attribute(func_v_php_param_attr_api, 0, attribute_v_php_param_attr_api_0_1_name, 0);
            zend_string_release(attribute_v_php_param_attr_api_0_1_name);
            zend_string *attribute_v_php_param_attr_api_1_0_name = zend_string_init_interned("FromQuery", sizeof("FromQuery")-1, 1);
            zend_attribute *attribute_v_php_param_attr_api_1_0 = vphp_zend_add_parameter_attribute(func_v_php_param_attr_api, 1, attribute_v_php_param_attr_api_1_0_name, 1);
            zend_string_release(attribute_v_php_param_attr_api_1_0_name);
            ZVAL_STR(&attribute_v_php_param_attr_api_1_0->args[0].value, zend_string_init_interned("page", 4, 1));
            zend_string *attribute_v_php_param_attr_api_1_1_name = zend_string_init_interned("MustBeInt", sizeof("MustBeInt")-1, 1);
            zend_attribute *attribute_v_php_param_attr_api_1_1 = vphp_zend_add_parameter_attribute(func_v_php_param_attr_api, 1, attribute_v_php_param_attr_api_1_1_name, 0);
            zend_string_release(attribute_v_php_param_attr_api_1_1_name);
        }
    }
    if (contentcontract_register_class() != SUCCESS) { return FAILURE; }
    if (demo__contracts__namedcontract_register_class() != SUCCESS) { return FAILURE; }
    if (demo__contracts__aliascontract_register_class() != SUCCESS) { return FAILURE; }
    if (vphp__compiler__moduleprobecontract_register_class() != SUCCESS) { return FAILURE; }
    if (abstractreport_register_class() != SUCCESS) { return FAILURE; }
    if (dailyreport_register_class() != SUCCESS) { return FAILURE; }
    if (author_register_class() != SUCCESS) { return FAILURE; }
    if (post_register_class() != SUCCESS) { return FAILURE; }
    if (article_register_class() != SUCCESS) { return FAILURE; }
    if (story_register_class() != SUCCESS) { return FAILURE; }
    if (demo__contracts__aliasbase_register_class() != SUCCESS) { return FAILURE; }
    if (aliasworker_register_class() != SUCCESS) { return FAILURE; }
    if (runtimedemo__baseexception_register_class() != SUCCESS) { return FAILURE; }
    if (runtimedemo__childexception_register_class() != SUCCESS) { return FAILURE; }
    if (callableprocessor_register_class() != SUCCESS) { return FAILURE; }
    if (finder_register_class() != SUCCESS) { return FAILURE; }
    if (readonlyrecord_register_class() != SUCCESS) { return FAILURE; }
    if (vphp__compiler__moduleprobekind_register_class() != SUCCESS) { return FAILURE; }
    if (vphp__compiler__otherprobekind_register_class() != SUCCESS) { return FAILURE; }
    if (vphp__compiler__moduleprobereadonlybox_register_class() != SUCCESS) { return FAILURE; }
    if (vphp__compiler__moduleprobebox_register_class() != SUCCESS) { return FAILURE; }
    if (vphp__compiler__copyablebox_register_class() != SUCCESS) { return FAILURE; }
    if (vphp__compiler__taggedbox_register_class() != SUCCESS) { return FAILURE; }
    if (vphp__compiler__numberedbox_register_class() != SUCCESS) { return FAILURE; }
    if (vphp__compiler__moduleprobetypedconsts_register_class() != SUCCESS) { return FAILURE; }
    if (vphp__compiler__moduleprobewrapperbox_register_class() != SUCCESS) { return FAILURE; }
    if (traitpost_register_class() != SUCCESS) { return FAILURE; }
    if (validator_register_class() != SUCCESS) { return FAILURE; }
    if (dispatchablesample_register_class() != SUCCESS) { return FAILURE; }
    if (articlestatus_register_class() != SUCCESS) { return FAILURE; }
    if (vphp__task_register_class() != SUCCESS) { return FAILURE; }
    if (stringablebox_register_class() != SUCCESS) { return FAILURE; }
    vphp_apply_auto_interface_bindings(0);
    return SUCCESS;
}
PHP_MSHUTDOWN_FUNCTION(vphptest) {
    UNREGISTER_INI_ENTRIES();
    vphp_call_optional_void_symbol("vphp_ext_shutdown");
    vphp_call_optional_void_symbol("vphp_ext_auto_shutdown");
    vphp_framework_shutdown();
    vphp_release_attribute_arrays();
    vphp_release_php_property_storage();
#if PHP_VERSION_ID >= 80400
    vphp_release_property_hooks();
#endif
    _vcleanup_caller();
    if (type != MODULE_TEMPORARY) { vphp_release_enum_case_aliases(); }
    return SUCCESS;
}
PHP_RINIT_FUNCTION(vphptest) {
    vphp_framework_request_startup();
    vphp_call_optional_void_symbol("vphp_ext_request_auto_startup");
    vphp_call_optional_void_symbol("vphp_ext_request_startup");
    return SUCCESS;
}
PHP_RSHUTDOWN_FUNCTION(vphptest) {
    vphp_call_optional_void_symbol("vphp_ext_request_shutdown");
    vphp_call_optional_void_symbol("vphp_ext_request_auto_shutdown");
    vphp_framework_request_shutdown();
    if (type == MODULE_TEMPORARY) { vphp_release_enum_case_aliases(); }
    return SUCCESS;
}
PHP_MINFO_FUNCTION(vphptest) {
    php_info_print_table_start();
    php_info_print_table_header(2, "vphptest support", "enabled");
    php_info_print_table_row(2, "Version", "0.1.0");
    php_info_print_table_row(2, "Description", "PHP Bindings for V");
    php_info_print_table_end();
    DISPLAY_INI_ENTRIES();
}

void* vphp_get_active_globals() {
#ifdef ZTS
    return ZEND_MODULE_GLOBALS_BULK(vphptest);
#else
    return &vphptest_globals;
#endif
}
zend_module_entry vphptest_module_entry = {
    STANDARD_MODULE_HEADER, "vphptest",
    NULL,
    PHP_MINIT(vphptest), PHP_MSHUTDOWN(vphptest), PHP_RINIT(vphptest), PHP_RSHUTDOWN(vphptest), PHP_MINFO(vphptest), "0.1.0",
    PHP_MODULE_GLOBALS(vphptest),
    (void (*)(void*)) php_vphptest_init_globals,
    NULL,
    NULL,
    STANDARD_MODULE_PROPERTIES_EX
};

#ifdef COMPILE_DL_VPHPTEST
ZEND_GET_MODULE(vphptest)
#endif
