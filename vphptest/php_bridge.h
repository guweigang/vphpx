/* ⚠️ VPHP Compiler Generated，请勿手动修改 */
#ifndef VPHP_EXT_VPHPTEST_BRIDGE_H
#define VPHP_EXT_VPHPTEST_BRIDGE_H

#include <php.h>
#include <Zend/zend_attributes.h>
#include <Zend/zend_enum.h>
#include <ext/standard/info.h>

extern zend_module_entry vphptest_module_entry;
#define phpext_vphptest_ptr &vphptest_module_entry

extern void* vphp_get_active_globals();

PHP_FUNCTION(v_add);
PHP_FUNCTION(v_greet);
PHP_FUNCTION(v_float_const);
PHP_FUNCTION(v_float_id);
PHP_FUNCTION(v_pure_map_test);
PHP_FUNCTION(v_process_list);
PHP_FUNCTION(v_test_map);
PHP_FUNCTION(v_get_config);
PHP_FUNCTION(v_get_user);
PHP_FUNCTION(v_call_back);
PHP_FUNCTION(v_bind_class_interface);
PHP_FUNCTION(v_complex_test);
PHP_FUNCTION(v_persistent_nested_roundtrip);
PHP_FUNCTION(v_persistent_multi_nested_stress);
PHP_FUNCTION(v_analyze_user_object);
PHP_FUNCTION(v_mutate_user_object);
PHP_FUNCTION(v_check_user_object_props);
PHP_FUNCTION(v_construct_php_object);
PHP_FUNCTION(v_call_php_static_method);
PHP_FUNCTION(v_mutate_php_static_prop);
PHP_FUNCTION(v_read_php_class_constant);
PHP_FUNCTION(v_typed_php_interop);
PHP_FUNCTION(v_typed_object_restore);
PHP_FUNCTION(v_zval_conversion_api);
PHP_FUNCTION(v_persistent_fallback_counter_probe);
PHP_FUNCTION(v_request_scope_counter_probe);
PHP_FUNCTION(v_unified_object_interop);
PHP_FUNCTION(v_unified_ownership_interop);
PHP_FUNCTION(v_read_php_global_const);
PHP_FUNCTION(v_php_symbol_exists);
PHP_FUNCTION(v_include_php_file);
PHP_FUNCTION(v_include_php_file_once);
PHP_FUNCTION(v_include_php_module_demo);
PHP_FUNCTION(v_php_object_meta);
PHP_FUNCTION(v_php_object_introspection);
PHP_FUNCTION(v_php_array_introspection);
PHP_FUNCTION(v_php_object_probe);
PHP_FUNCTION(v_trigger_user_action);
PHP_FUNCTION(v_call_php_closure);
PHP_FUNCTION(v_call_php_closure_helper);
PHP_FUNCTION(v_test_globals);
PHP_FUNCTION(v_get_v_closure);
PHP_FUNCTION(v_get_v_closure_auto);
PHP_FUNCTION(v_iter_helpers_demo);
PHP_FUNCTION(v_iterable_object_demo);
PHP_FUNCTION(v_reverse_string);
PHP_FUNCTION(v_logic_main);
PHP_FUNCTION(v_invoke_callable);
PHP_FUNCTION(v_invoke_with_arg);
PHP_FUNCTION(v_get_closure_0);
PHP_FUNCTION(v_get_closure_1);
PHP_FUNCTION(v_get_closure_2);
PHP_FUNCTION(v_get_closure_3);
PHP_FUNCTION(v_get_closure_4);
PHP_FUNCTION(v_get_closure_3_void);
PHP_FUNCTION(v_get_closure_4_void);
PHP_FUNCTION(v_lifecycle_hook_state);
PHP_FUNCTION(v_find_after);
PHP_FUNCTION(v_try_divide);
PHP_FUNCTION(v_record_match);
PHP_FUNCTION(v_new_coach);
PHP_FUNCTION(v_new_db);
PHP_FUNCTION(v_check_res);
PHP_FUNCTION(v_safe_divide);
PHP_FUNCTION(v_capitalize);
PHP_FUNCTION(v_record_success);
PHP_FUNCTION(v_analyze_fitness_data);
PHP_FUNCTION(v_get_alerts);
extern zend_class_entry *contentcontract_ce;
extern zend_class_entry *demo__contracts__namedcontract_ce;
extern zend_class_entry *demo__contracts__aliascontract_ce;
extern zend_class_entry *abstractreport_ce;
extern zend_class_entry *dailyreport_ce;
extern zend_class_entry *author_ce;
extern zend_class_entry *post_ce;
extern zend_class_entry *article_ce;
extern zend_class_entry *story_ce;
extern zend_class_entry *demo__contracts__aliasbase_ce;
extern zend_class_entry *aliasworker_ce;
extern zend_class_entry *runtimedemo__baseexception_ce;
extern zend_class_entry *runtimedemo__childexception_ce;
extern zend_class_entry *callableprocessor_ce;
extern zend_class_entry *finder_ce;
extern zend_class_entry *readonlyrecord_ce;
extern zend_class_entry *traitpost_ce;
extern zend_class_entry *validator_ce;
extern zend_class_entry *dispatchablesample_ce;
extern zend_class_entry *articlestatus_ce;
extern zend_class_entry *vphp__task_ce;
extern zend_class_entry *stringablebox_ce;
#endif
