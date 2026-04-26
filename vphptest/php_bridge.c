/* ⚠️ VPHP Compiler Generated for vphptest */
#include "php_bridge.h"

#include "../vphp/v_bridge.h"


typedef struct { void* str; int len; int is_lit; } v_string;

extern void vphp_framework_init(int module_number);
extern void vphp_framework_shutdown(void);
extern void vphp_framework_request_startup(void);
extern void vphp_framework_request_shutdown(void);
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
ZEND_ARG_TYPE_INFO(0, class_name, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, iface_name, IS_STRING, 0)
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
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_unified_object_interop, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_unified_object_interop(vphp_context_internal ctx);
PHP_FUNCTION(v_unified_object_interop) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_unified_object_interop(ctx);
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
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_get_v_closure, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_v_closure(vphp_context_internal ctx);
PHP_FUNCTION(v_get_v_closure) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_v_closure(ctx);
}
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_get_v_closure_auto, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
extern void vphp_wrap_v_get_v_closure_auto(vphp_context_internal ctx);
PHP_FUNCTION(v_get_v_closure_auto) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    vphp_wrap_v_get_v_closure_auto(ctx);
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
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_get_closure_0, 0, 0, 0)
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
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_get_closure_1, 0, 0, 0)
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
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_get_closure_2, 0, 0, 0)
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
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_get_closure_3, 0, 0, 0)
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
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_get_closure_4, 0, 0, 0)
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
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_get_closure_3_void, 0, 0, 0)
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
ZEND_BEGIN_ARG_INFO_EX(arginfo_v_get_closure_4_void, 0, 0, 0)
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
    ZEND_RAW_FENTRY("save", NULL, arginfo_contentcontract_save, ZEND_ACC_PUBLIC | ZEND_ACC_ABSTRACT, NULL, NULL)
    ZEND_RAW_FENTRY("get_formatted_title", NULL, arginfo_contentcontract_get_formatted_title, ZEND_ACC_PUBLIC | ZEND_ACC_ABSTRACT, NULL, NULL)
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
    {   zend_class_entry ce;
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Demo\\Contracts\\NamedContract", demo__contracts__namedcontract_methods);
        demo__contracts__namedcontract_ce = zend_register_internal_interface(&ce);
    }
    return SUCCESS;
}
zend_class_entry *demo__contracts__aliascontract_ce = NULL;
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_demo__contracts__aliascontract_ping, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
static const zend_function_entry demo__contracts__aliascontract_methods[] = {
    ZEND_RAW_FENTRY("ping", NULL, arginfo_demo__contracts__aliascontract_ping, ZEND_ACC_PUBLIC | ZEND_ACC_ABSTRACT, NULL, NULL)
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Demo\\Contracts\\AliasContract", demo__contracts__aliascontract_methods);
        demo__contracts__aliascontract_ce = zend_register_internal_interface(&ce);
        zend_class_entry *iface_0_ce = vphp_require_class_entry("Demo\\Contracts\\NamedContract", sizeof("Demo\\Contracts\\NamedContract")-1, 0);
        if (!iface_0_ce) {
            vphp_throw("interface Demo\\\\Contracts\\\\NamedContract not found for Demo\\Contracts\\AliasContract", 0);
            return FAILURE;
        }
        zend_class_implements(demo__contracts__aliascontract_ce, 1, iface_0_ce);
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
    extern void vphp_wrap_AbstractReport_label(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* AbstractReport_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, AbstractReport_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_AbstractReport_label(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

PHP_METHOD(AbstractReport, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* AbstractReport_handlers();
    vphp_class_handlers *h = AbstractReport_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

static const zend_function_entry abstractreport_methods[] = {
    PHP_ME(AbstractReport, __construct, arginfo_abstractreport___construct, ZEND_ACC_PUBLIC)
    PHP_ME(AbstractReport, label, arginfo_abstractreport_label, ZEND_ACC_PUBLIC)
    ZEND_RAW_FENTRY("summarize", NULL, arginfo_abstractreport_summarize, ZEND_ACC_PUBLIC | ZEND_ACC_ABSTRACT, NULL, NULL)
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "AbstractReport", abstractreport_methods);
        abstractreport_ce = zend_register_internal_class(&ce);
        abstractreport_ce->ce_flags |= ZEND_ACC_EXPLICIT_ABSTRACT_CLASS;
        abstractreport_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(abstractreport_ce, "title", sizeof("title")-1, "", ZEND_ACC_PUBLIC);
    }
    return SUCCESS;
}
zend_class_entry *dailyreport_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_dailyreport_construct, 0, 0, 2)
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
    extern vphp_class_handlers* DailyReport_handlers();
    vphp_class_handlers *h = DailyReport_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_DailyReport_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_DailyReport_construct(v_ptr, ctx);
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
    extern void vphp_wrap_DailyReport_summarize(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* DailyReport_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, DailyReport_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_DailyReport_summarize(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry dailyreport_methods[] = {
    PHP_ME(DailyReport, __construct, arginfo_dailyreport_construct, ZEND_ACC_PUBLIC)
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "DailyReport", dailyreport_methods);
        zend_class_entry *parent_ce = vphp_require_class_entry("AbstractReport", sizeof("AbstractReport")-1, 0);
        if (!parent_ce) {
            vphp_throw("parent class AbstractReport not found for DailyReport", 0);
            return FAILURE;
        }
        dailyreport_ce = zend_register_internal_class_ex(&ce, parent_ce);
        dailyreport_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(dailyreport_ce, "summary", sizeof("summary")-1, "", ZEND_ACC_PUBLIC);
    }
    return SUCCESS;
}
zend_class_entry *author_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_author___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_OBJ_INFO_EX(arginfo_author_create, 0, 1, Author, 0)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_author_get_name, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(Author, create) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void* vphp_wrap_Author_create(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_Author_create(ctx);
    if (EG(exception)) {
        return;
    }
    extern vphp_class_handlers* Author_handlers();
    vphp_return_owned_object(return_value, v_instance, author_ce, Author_handlers());
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Author, get_name) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_Author_get_name(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Author_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Author_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_Author_get_name(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

PHP_METHOD(Author, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* Author_handlers();
    vphp_class_handlers *h = Author_handlers();
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Author", author_methods);
        author_ce = zend_register_internal_class(&ce);
        author_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(author_ce, "name", sizeof("name")-1, "", ZEND_ACC_PUBLIC);
    }
    return SUCCESS;
}
zend_class_entry *post_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_post___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_post_set_author, 0, 1, IS_VOID, 0)
ZEND_ARG_INFO(0, author)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_OBJ_INFO_EX(arginfo_post_get_author, 0, 0, Author, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(Post, set_author) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_Post_set_author(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Post_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Post_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_NULL();
    }
    vphp_wrap_Post_set_author(wrapper->v_ptr, ctx);
    if (!EG(exception)) {
        vphp_mark_void_return(return_value);
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

PHP_METHOD(Post, get_author) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void* vphp_wrap_Post_get_author(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Post_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Post_handlers());
    // printf("PHP_METHOD Post::get_author called, wrapper->v_ptr=%p\n", wrapper->v_ptr);
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_NULL();
    }
    void* v_instance = vphp_wrap_Post_get_author(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    extern vphp_class_handlers* Author_handlers();
    vphp_return_bound_object(return_value, v_instance, author_ce, Author_handlers(), VPHP_BORROWS_VPTR);
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}


PHP_METHOD(Post, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* Post_handlers();
    vphp_class_handlers *h = Post_handlers();
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Post", post_methods);
        post_ce = zend_register_internal_class(&ce);
        post_ce->create_object = vphp_create_object_handler;
        zend_declare_property_long(post_ce, "post_id", sizeof("post_id")-1, 0, ZEND_ACC_PUBLIC);
        zend_declare_property_null(post_ce, "author", sizeof("author")-1, ZEND_ACC_PUBLIC);
    }
    return SUCCESS;
}
zend_class_entry *article_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_article_construct, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, title, IS_STRING, 0)
ZEND_ARG_TYPE_INFO(0, id, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_article_internal_format, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_OBJ_INFO_EX(arginfo_article_create, 0, 1, Article, 0)
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
ZEND_ARG_TYPE_INFO(0, callback, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_OBJ_INFO_EX(arginfo_article_restore_author, 0, 1, Author, 0)
ZEND_ARG_TYPE_INFO(0, author_val, IS_MIXED, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(Article, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* Article_handlers();
    vphp_class_handlers *h = Article_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_Article_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_Article_construct(v_ptr, ctx);
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
    extern void vphp_wrap_Article_internal_format(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Article_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Article_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_Article_internal_format(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Article, create) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void* vphp_wrap_Article_create(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_Article_create(ctx);
    if (EG(exception)) {
        return;
    }
    extern vphp_class_handlers* Article_handlers();
    vphp_return_owned_object(return_value, v_instance, article_ce, Article_handlers());
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Article, get_formatted_title) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_Article_get_formatted_title(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Article_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Article_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_Article_get_formatted_title(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Article, save) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_Article_save(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Article_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Article_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_Article_save(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Article, dump_properties) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_Article_dump_properties(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Article_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Article_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_NULL();
    }
    vphp_wrap_Article_dump_properties(wrapper->v_ptr, ctx);
    if (!EG(exception)) {
        vphp_mark_void_return(return_value);
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Article, process_with_callback) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_Article_process_with_callback(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Article_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Article_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_Article_process_with_callback(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Article, restore_author) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void* vphp_wrap_Article_restore_author(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_Article_restore_author(ctx);
    if (EG(exception)) {
        return;
    }
    extern vphp_class_handlers* Author_handlers();
    vphp_return_bound_object(return_value, v_instance, author_ce, Author_handlers(), VPHP_OWNS_VPTR);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry article_methods[] = {
    PHP_ME(Article, __construct, arginfo_article_construct, ZEND_ACC_PUBLIC)
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Article", article_methods);
        zend_class_entry *parent_ce = vphp_require_class_entry("Post", sizeof("Post")-1, 0);
        if (!parent_ce) {
            vphp_throw("parent class Post not found for Article", 0);
            return FAILURE;
        }
        article_ce = zend_register_internal_class_ex(&ce, parent_ce);
        article_ce->create_object = vphp_create_object_handler;
        zend_class_entry *iface_0_ce = vphp_require_class_entry("ContentContract", sizeof("ContentContract")-1, 0);
        if (!iface_0_ce) {
            vphp_throw("interface ContentContract not found for Article", 0);
            return FAILURE;
        }
        zend_class_implements(article_ce, 1, iface_0_ce);
        zend_declare_class_constant_long(article_ce, "MAX_TITLE_LEN", sizeof("MAX_TITLE_LEN")-1, 1024);
        zend_declare_class_constant_string(article_ce, "NAME", sizeof("NAME")-1, "Samantha Black");
        zend_declare_class_constant_long(article_ce, "AGE", sizeof("AGE")-1, 24);
        zend_declare_property_long(article_ce, "created_at", sizeof("created_at")-1, 0, ZEND_ACC_PUBLIC | ZEND_ACC_READONLY);
        zend_declare_property_long(article_ce, "id", sizeof("id")-1, 0, ZEND_ACC_PUBLIC);
        zend_declare_property_string(article_ce, "title", sizeof("title")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_bool(article_ce, "is_top", sizeof("is_top")-1, 0, ZEND_ACC_PUBLIC);
        zend_declare_property_string(article_ce, "content", sizeof("content")-1, "", ZEND_ACC_PROTECTED);
        zend_declare_property_long(article_ce, "total_count", sizeof("total_count")-1, 0, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC);
    }
    return SUCCESS;
}
zend_class_entry *story_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_story___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_OBJ_INFO_EX(arginfo_story_create, 0, 2, Story, 0)
ZEND_ARG_INFO(0, author)
ZEND_ARG_TYPE_INFO(0, chapters, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_story_tell, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(Story, create) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void* vphp_wrap_Story_create(vphp_context_internal ctx);
    void* v_instance = vphp_wrap_Story_create(ctx);
    if (EG(exception)) {
        return;
    }
    extern vphp_class_handlers* Story_handlers();
    vphp_return_owned_object(return_value, v_instance, story_ce, Story_handlers());
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Story, tell) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_Story_tell(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Story_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Story_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_Story_tell(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

PHP_METHOD(Story, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* Story_handlers();
    vphp_class_handlers *h = Story_handlers();
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Story", story_methods);
        zend_class_entry *parent_ce = vphp_require_class_entry("Post", sizeof("Post")-1, 0);
        if (!parent_ce) {
            vphp_throw("parent class Post not found for Story", 0);
            return FAILURE;
        }
        story_ce = zend_register_internal_class_ex(&ce, parent_ce);
        story_ce->create_object = vphp_create_object_handler;
        zend_declare_property_long(story_ce, "chapter_count", sizeof("chapter_count")-1, 0, ZEND_ACC_PUBLIC);
    }
    return SUCCESS;
}
zend_class_entry *demo__contracts__aliasbase_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_aliasbase_construct, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, label, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(Demo__Contracts__AliasBase, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* AliasBase_handlers();
    vphp_class_handlers *h = AliasBase_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_AliasBase_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_AliasBase_construct(v_ptr, ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry demo__contracts__aliasbase_methods[] = {
    PHP_ME(Demo__Contracts__AliasBase, __construct, arginfo_aliasbase_construct, ZEND_ACC_PUBLIC)
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Demo\\Contracts\\AliasBase", demo__contracts__aliasbase_methods);
        demo__contracts__aliasbase_ce = zend_register_internal_class(&ce);
        demo__contracts__aliasbase_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(demo__contracts__aliasbase_ce, "label", sizeof("label")-1, "", ZEND_ACC_PUBLIC);
    }
    return SUCCESS;
}
zend_class_entry *aliasworker_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_aliasworker_construct, 0, 0, 2)
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
    extern vphp_class_handlers* AliasWorker_handlers();
    vphp_class_handlers *h = AliasWorker_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_AliasWorker_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_AliasWorker_construct(v_ptr, ctx);
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
    extern void vphp_wrap_AliasWorker_save(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* AliasWorker_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, AliasWorker_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_AliasWorker_save(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(AliasWorker, get_formatted_title) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_AliasWorker_get_formatted_title(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* AliasWorker_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, AliasWorker_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_AliasWorker_get_formatted_title(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(AliasWorker, ping) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_AliasWorker_ping(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* AliasWorker_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, AliasWorker_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_AliasWorker_ping(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry aliasworker_methods[] = {
    PHP_ME(AliasWorker, __construct, arginfo_aliasworker_construct, ZEND_ACC_PUBLIC)
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "AliasWorker", aliasworker_methods);
        zend_class_entry *parent_ce = vphp_require_class_entry("Demo\\Contracts\\AliasBase", sizeof("Demo\\Contracts\\AliasBase")-1, 0);
        if (!parent_ce) {
            vphp_throw("parent class Demo\\\\Contracts\\\\AliasBase not found for AliasWorker", 0);
            return FAILURE;
        }
        aliasworker_ce = zend_register_internal_class_ex(&ce, parent_ce);
        aliasworker_ce->create_object = vphp_create_object_handler;
        zend_class_entry *iface_0_ce = vphp_require_class_entry("ContentContract", sizeof("ContentContract")-1, 0);
        if (!iface_0_ce) {
            vphp_throw("interface ContentContract not found for AliasWorker", 0);
            return FAILURE;
        }
        zend_class_entry *iface_1_ce = vphp_require_class_entry("Demo\\Contracts\\AliasContract", sizeof("Demo\\Contracts\\AliasContract")-1, 0);
        if (!iface_1_ce) {
            vphp_throw("interface Demo\\\\Contracts\\\\AliasContract not found for AliasWorker", 0);
            return FAILURE;
        }
        zend_class_implements(aliasworker_ce, 2, iface_0_ce, iface_1_ce);
        zend_declare_property_string(aliasworker_ce, "title", sizeof("title")-1, "", ZEND_ACC_PUBLIC);
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "RuntimeDemo\\BaseException", runtimedemo__baseexception_methods);
        zend_class_entry *parent_ce = vphp_require_class_entry("Exception", sizeof("Exception")-1, 0);
        if (!parent_ce) {
            vphp_throw("parent class Exception not found for RuntimeDemo\\BaseException", 0);
            return FAILURE;
        }
        runtimedemo__baseexception_ce = zend_register_internal_class_ex(&ce, parent_ce);
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "RuntimeDemo\\ChildException", runtimedemo__childexception_methods);
        zend_class_entry *parent_ce = vphp_require_class_entry("RuntimeDemo\\BaseException", sizeof("RuntimeDemo\\BaseException")-1, 0);
        if (!parent_ce) {
            vphp_throw("parent class RuntimeDemo\\\\BaseException not found for RuntimeDemo\\ChildException", 0);
            return FAILURE;
        }
        runtimedemo__childexception_ce = zend_register_internal_class_ex(&ce, parent_ce);
    }
    return SUCCESS;
}
zend_class_entry *callableprocessor_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_callableprocessor_construct, 0, 0, 1)
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
PHP_METHOD(CallableProcessor, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* CallableProcessor_handlers();
    vphp_class_handlers *h = CallableProcessor_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_CallableProcessor_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_CallableProcessor_construct(v_ptr, ctx);
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
    extern void vphp_wrap_CallableProcessor_process(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* CallableProcessor_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, CallableProcessor_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_CallableProcessor_process(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(CallableProcessor, transform) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_CallableProcessor_transform(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* CallableProcessor_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, CallableProcessor_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_CallableProcessor_transform(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(CallableProcessor, apply) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_CallableProcessor_apply(vphp_context_internal ctx);
    vphp_wrap_CallableProcessor_apply(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry callableprocessor_methods[] = {
    PHP_ME(CallableProcessor, __construct, arginfo_callableprocessor_construct, ZEND_ACC_PUBLIC)
    PHP_ME(CallableProcessor, process, arginfo_callableprocessor_process, ZEND_ACC_PUBLIC)
    PHP_ME(CallableProcessor, transform, arginfo_callableprocessor_transform, ZEND_ACC_PUBLIC)
    PHP_ME(CallableProcessor, apply, arginfo_callableprocessor_apply, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "CallableProcessor", callableprocessor_methods);
        callableprocessor_ce = zend_register_internal_class(&ce);
        callableprocessor_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(callableprocessor_ce, "prefix", sizeof("prefix")-1, "", ZEND_ACC_PUBLIC);
    }
    return SUCCESS;
}
zend_class_entry *finder_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_finder_construct, 0, 0, 0)
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
    extern vphp_class_handlers* Finder_handlers();
    vphp_class_handlers *h = Finder_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_Finder_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_Finder_construct(v_ptr, ctx);
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
    extern void vphp_wrap_Finder_find(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Finder_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Finder_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_Finder_find(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Finder, index_of) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_Finder_index_of(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Finder_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Finder_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_Finder_index_of(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Finder, has_match) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_Finder_has_match(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Finder_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Finder_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_Finder_has_match(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Finder, try_parse_int) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_Finder_try_parse_int(vphp_context_internal ctx);
    vphp_wrap_Finder_try_parse_int(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry finder_methods[] = {
    PHP_ME(Finder, __construct, arginfo_finder_construct, ZEND_ACC_PUBLIC)
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Finder", finder_methods);
        finder_ce = zend_register_internal_class(&ce);
        finder_ce->create_object = vphp_create_object_handler;
        zend_declare_property_null(finder_ce, "items", sizeof("items")-1, ZEND_ACC_PUBLIC);
    }
    return SUCCESS;
}
zend_class_entry *readonlyrecord_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_readonlyrecord_construct, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, title, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_readonlyrecord_reveal, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(ReadonlyRecord, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* ReadonlyRecord_handlers();
    vphp_class_handlers *h = ReadonlyRecord_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_ReadonlyRecord_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_ReadonlyRecord_construct(v_ptr, ctx);
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
    extern void vphp_wrap_ReadonlyRecord_reveal(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* ReadonlyRecord_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, ReadonlyRecord_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_ReadonlyRecord_reveal(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry readonlyrecord_methods[] = {
    PHP_ME(ReadonlyRecord, __construct, arginfo_readonlyrecord_construct, ZEND_ACC_PUBLIC)
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "ReadonlyRecord", readonlyrecord_methods);
        readonlyrecord_ce = zend_register_internal_class(&ce);
        readonlyrecord_ce->create_object = vphp_create_object_handler;
        zend_declare_property_long(readonlyrecord_ce, "created_at", sizeof("created_at")-1, 0, ZEND_ACC_PUBLIC | ZEND_ACC_READONLY);
        zend_declare_property_string(readonlyrecord_ce, "title", sizeof("title")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_string(readonlyrecord_ce, "internal_note", sizeof("internal_note")-1, "", ZEND_ACC_PROTECTED);
    }
    return SUCCESS;
}
zend_class_entry *traitpost_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_traitpost_construct, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, title, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_traitpost_summary, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_traitpost_bump, 0, 0, IS_LONG, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_slugtrait_trait_only, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_slugtrait_internal_trait, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(TraitPost, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* TraitPost_handlers();
    vphp_class_handlers *h = TraitPost_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_TraitPost_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_TraitPost_construct(v_ptr, ctx);
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
    extern void vphp_wrap_TraitPost_summary(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* TraitPost_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, TraitPost_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_TraitPost_summary(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(TraitPost, bump) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_TraitPost_bump(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* TraitPost_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, TraitPost_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_TraitPost_bump(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(TraitPost, trait_only) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_TraitPost_trait_only(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* TraitPost_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, TraitPost_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_TraitPost_trait_only(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(TraitPost, internal_trait) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_TraitPost_internal_trait(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* TraitPost_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, TraitPost_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_TraitPost_internal_trait(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry traitpost_methods[] = {
    PHP_ME(TraitPost, __construct, arginfo_traitpost_construct, ZEND_ACC_PUBLIC)
    PHP_ME(TraitPost, summary, arginfo_traitpost_summary, ZEND_ACC_PUBLIC)
    PHP_ME(TraitPost, bump, arginfo_traitpost_bump, ZEND_ACC_PUBLIC)
    PHP_ME(TraitPost, trait_only, arginfo_slugtrait_trait_only, ZEND_ACC_PUBLIC)
    PHP_ME(TraitPost, internal_trait, arginfo_slugtrait_internal_trait, ZEND_ACC_PROTECTED)
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "TraitPost", traitpost_methods);
        traitpost_ce = zend_register_internal_class(&ce);
        traitpost_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(traitpost_ce, "title", sizeof("title")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_string(traitpost_ce, "slug", sizeof("slug")-1, "", ZEND_ACC_PUBLIC);
        zend_declare_property_long(traitpost_ce, "visits", sizeof("visits")-1, 0, ZEND_ACC_PUBLIC);
        zend_declare_property_string(traitpost_ce, "internal_note", sizeof("internal_note")-1, "", ZEND_ACC_PROTECTED);
    }
    return SUCCESS;
}
zend_class_entry *validator_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_validator_construct, 0, 0, 1)
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
    extern vphp_class_handlers* Validator_handlers();
    vphp_class_handlers *h = Validator_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_Validator_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_Validator_construct(v_ptr, ctx);
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
    extern void vphp_wrap_Validator_check(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Validator_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Validator_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_Validator_check(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Validator, sanitize) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_Validator_sanitize(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Validator_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Validator_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_Validator_sanitize(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Validator, assert_valid) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_Validator_assert_valid(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* Validator_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, Validator_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_Validator_assert_valid(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(Validator, parse_int) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_Validator_parse_int(vphp_context_internal ctx);
    vphp_wrap_Validator_parse_int(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry validator_methods[] = {
    PHP_ME(Validator, __construct, arginfo_validator_construct, ZEND_ACC_PUBLIC)
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "Validator", validator_methods);
        validator_ce = zend_register_internal_class(&ce);
        validator_ce->create_object = vphp_create_object_handler;
        zend_declare_property_bool(validator_ce, "strict", sizeof("strict")-1, 0, ZEND_ACC_PUBLIC);
    }
    return SUCCESS;
}
zend_class_entry *dispatchablesample_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_dispatchablesample_construct, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(DispatchableSample, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* DispatchableSample_handlers();
    vphp_class_handlers *h = DispatchableSample_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_DispatchableSample_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_DispatchableSample_construct(v_ptr, ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry dispatchablesample_methods[] = {
    PHP_ME(DispatchableSample, __construct, arginfo_dispatchablesample_construct, ZEND_ACC_PUBLIC)
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "DispatchableSample", dispatchablesample_methods);
        dispatchablesample_ce = zend_register_internal_class(&ce);
        dispatchablesample_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(dispatchablesample_ce, "name", sizeof("name")-1, "", ZEND_ACC_PUBLIC);
        zend_string *attribute_dispatchablesample_0_name = zend_string_init_interned("PhpDispatchable", sizeof("PhpDispatchable")-1, 1);
        zend_attribute *attribute_dispatchablesample_0 = zend_add_class_attribute(dispatchablesample_ce, attribute_dispatchablesample_0_name, 1);
        zend_string_release(attribute_dispatchablesample_0_name);
        ZVAL_STR(&attribute_dispatchablesample_0->args[0].value, zend_string_init_interned("worker", sizeof("worker")-1, 1));
    }
    return SUCCESS;
}
zend_class_entry *articlestatus_ce = NULL;

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
    articlestatus_ce = zend_register_internal_enum("ArticleStatus", IS_LONG, NULL);
    { zval _ev; ZVAL_LONG(&_ev, 0); zend_enum_add_case_cstr(articlestatus_ce, "draft", &_ev); }
    { zval _ev; ZVAL_LONG(&_ev, 1); zend_enum_add_case_cstr(articlestatus_ce, "review", &_ev); }
    { zval _ev; ZVAL_LONG(&_ev, 2); zend_enum_add_case_cstr(articlestatus_ce, "published", &_ev); }
    return SUCCESS;
}
zend_class_entry *vphp__task_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphp__task___construct, 0, 0, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphptask_spawn, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphptask_wait, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_INFO_EX(arginfo_vphptask_list, 0, 0, 0)
ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(VPhp__Task, spawn) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_VPhpTask_spawn(vphp_context_internal ctx);
    vphp_wrap_VPhpTask_spawn(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPhp__Task, wait) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_VPhpTask_wait(vphp_context_internal ctx);
    vphp_wrap_VPhpTask_wait(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
PHP_METHOD(VPhp__Task, list) {
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern void vphp_wrap_VPhpTask_list(vphp_context_internal ctx);
    vphp_wrap_VPhpTask_list(ctx);
    if (EG(exception)) {
        return;
    }
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

PHP_METHOD(VPhp__Task, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    extern vphp_class_handlers* VPhpTask_handlers();
    vphp_class_handlers *h = VPhpTask_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}

static const zend_function_entry vphp__task_methods[] = {
    PHP_ME(VPhp__Task, __construct, arginfo_vphp__task___construct, ZEND_ACC_PUBLIC)
    PHP_ME(VPhp__Task, spawn, arginfo_vphptask_spawn, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VPhp__Task, wait, arginfo_vphptask_wait, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
    PHP_ME(VPhp__Task, list, arginfo_vphptask_list, ZEND_ACC_PUBLIC | ZEND_ACC_STATIC)
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "VPhp\\Task", vphp__task_methods);
        vphp__task_ce = zend_register_internal_class(&ce);
        vphp__task_ce->create_object = vphp_create_object_handler;
    }
    return SUCCESS;
}
zend_class_entry *stringablebox_ce = NULL;
ZEND_BEGIN_ARG_INFO_EX(arginfo_stringablebox_construct, 0, 0, 1)
ZEND_ARG_TYPE_INFO(0, name, IS_STRING, 0)
ZEND_END_ARG_INFO()
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_stringablebox_str, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()
PHP_METHOD(StringableBox, __construct) {
    if (!vphp_validate_internal_call(execute_data)) {
        return;
    }
    vphp_context_internal ctx = vphp_context_from_execute(execute_data, return_value);
    extern vphp_class_handlers* StringableBox_handlers();
    vphp_class_handlers *h = StringableBox_handlers();
    vphp_init_owned_instance(Z_OBJ_P(getThis()), h);
    vphp_object_wrapper *wrapper = vphp_obj_from_obj(Z_OBJ_P(getThis()));
    extern void vphp_wrap_StringableBox_construct(void* v_ptr, vphp_context_internal ctx);
    void* v_ptr = wrapper->v_ptr;
    vphp_wrap_StringableBox_construct(v_ptr, ctx);
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
    extern void vphp_wrap_StringableBox_str(void* v_ptr, vphp_context_internal ctx);
    extern vphp_class_handlers* StringableBox_handlers();
    zend_object *vphp_this_obj = Z_OBJ_P(getThis());
    vphp_object_addref(vphp_this_obj);
    vphp_object_wrapper *wrapper = vphp_ensure_owned_instance_binding(vphp_this_obj, StringableBox_handlers());
    if (!wrapper->v_ptr) {
        vphp_object_release(vphp_this_obj);
        RETURN_FALSE;
    }
    vphp_wrap_StringableBox_str(wrapper->v_ptr, ctx);
    if (EG(exception)) {
        vphp_object_release(vphp_this_obj);
        return;
    }
    vphp_object_release(vphp_this_obj);
    if (!vphp_validate_internal_return(execute_data, return_value)) {
        return;
    }
}
static const zend_function_entry stringablebox_methods[] = {
    PHP_ME(StringableBox, __construct, arginfo_stringablebox_construct, ZEND_ACC_PUBLIC)
    PHP_ME(StringableBox, __toString, arginfo_stringablebox_str, ZEND_ACC_PUBLIC)
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
    {   zend_class_entry ce;
        INIT_CLASS_ENTRY(ce, "StringableBox", stringablebox_methods);
        stringablebox_ce = zend_register_internal_class(&ce);
        stringablebox_ce->create_object = vphp_create_object_handler;
        zend_declare_property_string(stringablebox_ce, "name", sizeof("name")-1, "", ZEND_ACC_PUBLIC);
    }
    return SUCCESS;
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
    PHP_FE(v_unified_object_interop, arginfo_v_unified_object_interop)
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
    PHP_FE(v_lifecycle_hook_state, arginfo_v_lifecycle_hook_state)
    PHP_FE(v_find_after, arginfo_v_find_after)
    PHP_FE(v_try_divide, arginfo_v_try_divide)
    PHP_FE(v_record_match, arginfo_v_record_match)
    PHP_FE(v_new_coach, arginfo_v_new_coach)
    PHP_FE(v_new_db, arginfo_v_new_db)
    PHP_FE(v_check_res, arginfo_v_check_res)
    PHP_FE(v_safe_divide, arginfo_v_safe_divide)
    PHP_FE(v_capitalize, arginfo_v_capitalize)
    PHP_FE(v_record_success, arginfo_v_record_success)
    PHP_FE(v_analyze_fitness_data, arginfo_v_analyze_fitness_data)
    PHP_FE(v_get_alerts, arginfo_v_get_alerts)
    PHP_FE_END
};
PHP_MINIT_FUNCTION(vphptest) {
    vphp_framework_init(module_number);
    vphp_call_optional_void_symbol("vphp_ext_auto_startup");
    vphp_call_optional_void_symbol("vphp_ext_startup");
    REGISTER_INI_ENTRIES();
        REGISTER_STRING_CONSTANT("APP_VERSION", "1.0.0", CONST_CS | CONST_PERSISTENT);
        REGISTER_LONG_CONSTANT("MAX_RETRY", 3, CONST_CS | CONST_PERSISTENT);
        REGISTER_DOUBLE_CONSTANT("PI_VALUE", 3.14159, CONST_CS | CONST_PERSISTENT);
        REGISTER_BOOL_CONSTANT("DEBUG_MODE", 0, CONST_CS | CONST_PERSISTENT);
    if (contentcontract_register_class() != SUCCESS) { return FAILURE; }
    if (demo__contracts__namedcontract_register_class() != SUCCESS) { return FAILURE; }
    if (demo__contracts__aliascontract_register_class() != SUCCESS) { return FAILURE; }
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
    return TSRMG(vphptest_globals_id, zend_vphptest_globals *, 0);
#else
    return &vphptest_globals;
#endif
}
zend_module_entry vphptest_module_entry = {
    STANDARD_MODULE_HEADER, "vphptest", vphptest_functions,
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
