#ifndef VPHP_V_BRIDGE_H
#define VPHP_V_BRIDGE_H

#include <php.h>
#include <stdbool.h>

#include "bridge/compat.h"

#if PHP_VERSION_ID >= 80100
#include <Zend/zend_enum.h>
#endif

struct vphp_class_handlers;

// 对象包装器
typedef struct {
  uint32_t magic;
  void *v_ptr;
  int owns_v_ptr;
  void (*cleanup_raw)(void *);
  void (*free_raw)(void *);
  void (*prop_handler)(void *, char *, int, zval *);
  void (*write_handler)(void *, char *, int, zval *);
  void (*sync_handler)(void *, zval *);
  const zend_object_handlers *original_handlers;
  HashTable *unset_bound_properties;
  bool may_have_bound_references;
  struct vphp_class_handlers *(*instance_handlers)(void);
  zval php_state;
  zend_object std;
} vphp_object_wrapper;

typedef struct vphp_class_handlers {
  void *v_ptr;
  void (*prop_handler)(void *, char *, int, zval *);
  void (*write_handler)(void *, char *, int, zval *);
  void (*sync_handler)(void *, zval *);
  void *(*new_raw)(void);
  void (*cleanup_raw)(void *);
  void (*free_raw)(void *);
  void (*init_php_state)(void *);
} vphp_class_handlers;

typedef struct {
  void *ex;
  void *ret;
} vphp_context_internal;

#define VPHP_BORROWS_VPTR 0
#define VPHP_OWNS_VPTR 1

typedef struct {
  void *ptr;
  char *label;
} vphp_res_t;

// 核心导出
void vphp_res_dtor(zend_resource *res);
void vphp_create_closure_FULL_AUTO_V2(zval *zv, void *v_thunk,
                                      void *bridge_ptr);
void vphp_create_closure_with_arity(zval *zv, void *v_thunk, void *bridge_ptr,
                                    int num_args, int required_args);
typedef void (*vphp_closure_bridge)(void *thunk, zend_execute_data *ex, zval *ret);
typedef void (*vphp_generator_resume)(void *state, zval *sent, zval *exception, zval *capture,
                                     int kind, zval *ret);
typedef void (*vphp_generator_close)(void *state, zval *capture);
typedef void (*vphp_generator_release)(void *state);
void vphp_init_generator_system(int module_number);
bool vphp_create_generator(zval *result, zval *capture, void *state, vphp_generator_resume resume,
                           vphp_generator_close close, vphp_generator_release release, bool by_reference,
                           bool release_capture_after_start);
void vphp_create_closure_with_arginfo(zval *zv, void *v_thunk, vphp_closure_bridge bridge,
                                     int num_args, int required_args,
                                     const zend_internal_arg_info *arginfo);
void vphp_create_closure_with_attributes(zval *zv, void *v_thunk, vphp_closure_bridge bridge,
                                         int num_args, int required_args,
                                         const zend_internal_arg_info *arginfo, HashTable *attributes);
void vphp_add_sensitive_closure_parameter(HashTable **attributes, uint32_t index);
typedef bool (*vphp_computed_default_matcher)(const zend_internal_function *func,
                                              zend_long callable, zend_long field);
void vphp_register_closure_default_class(const char *name,
                                         vphp_computed_default_matcher matches);
bool vphp_matches_computed_default_arginfo(const zend_internal_function *func,
                                           const zend_internal_arg_info *arginfo);
bool vphp_matches_computed_default_handler(const zend_internal_function *func,
                                           zif_handler handler);
void vphp_create_variadic_closure(zval *zv, void *v_thunk, vphp_closure_bridge bridge);
void vphp_inherit_class_before_properties(zend_class_entry *registered,
                                         zend_class_entry *parent);
zend_class_entry *vphp_register_class_with_abstract_statics(
    zend_class_entry *ce, zend_class_entry *parent);
vphp_object_wrapper *vphp_obj_from_obj(zend_object *obj);
zval *vphp_owned_object_php_state(void *v_ptr);
zval *vphp_weak_map_find(zval *map, zval *key, bool reference);
bool vphp_weak_map_bind_reference(zval *map, zval *key, zval *reference);
bool vphp_lazy_objects_supported(void);
bool vphp_clone_with_supported(void);
bool vphp_object_is_uninitialized_lazy(zval *value);
void vphp_register_object(void *v_ptr, zend_object *obj);
void vphp_return_obj(zval *return_value, void *v_ptr, zend_class_entry *ce);
void vphp_return_bound_object(zval *return_value, void *v_ptr,
                              zend_class_entry *ce, vphp_class_handlers *h,
                              int owns_v_ptr);
void vphp_return_owned_object(zval *return_value, void *v_ptr,
                              zend_class_entry *ce, vphp_class_handlers *h);
void vphp_return_borrowed_object(zval *return_value, void *v_ptr,
                                 zend_class_entry *ce,
                                 vphp_class_handlers *h);
void vphp_wrap_existing_object(zval *return_value, zend_object *obj);
void *vphp_allocate_contiguous_object(zend_class_entry *ce, size_t v_size);

// 对象与类管理
zend_object *vphp_create_object_handler(zend_class_entry *ce);
void vphp_init_cloneable_object_handlers(zend_object_handlers *handlers,
                                         zend_object_clone_obj_t clone_obj);
zend_object *vphp_clone_bound_object(zend_object *source,
                                      vphp_class_handlers *handlers,
                                      void (*clone_into)(void *, void *));
zend_object *vphp_create_inherited_object_handler(zend_class_entry *ce);
void vphp_init_resource_system(int module_number);
HashTable *vphp_get_properties(zend_object *object);
void vphp_bind_handlers(zend_object *obj, vphp_class_handlers *h);
void vphp_bind_handlers_with_ownership(zend_object *obj, vphp_class_handlers *h,
                                       int owns_v_ptr);
void vphp_bind_owned_handlers(zend_object *obj, vphp_class_handlers *h);
void vphp_bind_borrowed_handlers(zend_object *obj, vphp_class_handlers *h);
vphp_object_wrapper *vphp_ensure_instance_binding(zend_object *obj,
                                                  vphp_class_handlers *h,
                                                  int owns_v_ptr);
vphp_object_wrapper *vphp_ensure_owned_instance_binding(zend_object *obj,
                                                        vphp_class_handlers *h);
vphp_object_wrapper *vphp_ensure_borrowed_instance_binding(
    zend_object *obj, vphp_class_handlers *h);
void vphp_init_owned_instance(zend_object *obj, vphp_class_handlers *h);
zend_type vphp_arginfo_class_type(const char *name);
zend_type vphp_arginfo_type_list(const zend_type *members, uint32_t count,
                                 uint32_t flags);
bool vphp_validate_internal_call(zend_execute_data *execute_data);
bool vphp_check_closure_scalar_argument(zend_execute_data *execute_data,
                                        uint32_t index);
typedef void (*vphp_named_variadic_cb)(void *, uint32_t, const char *, int, zval *);
void vphp_create_named_variadic_closure(zval *zv, void *v_thunk, vphp_closure_bridge bridge,
                                       int num_args, int required_args,
                                       const zend_internal_arg_info *arginfo);
bool vphp_read_named_variadic_args(zend_execute_data *, void *, vphp_named_variadic_cb);
bool vphp_validate_internal_return(zend_execute_data *execute_data,
                                   zval *return_value);
void vphp_verify_parent_reference_methods(const zend_class_entry *ce,
                                          const zend_class_entry *parent);
void vphp_verify_mixed_property_redeclaration(const zend_class_entry *ce,
                                              const char *name, size_t name_len,
                                              bool mixed);
void vphp_verify_interface_reference_methods(const zend_class_entry *ce,
                                             const zend_class_entry *iface);
void vphp_mark_void_return(zval *return_value);
vphp_context_internal vphp_context_from_execute(zend_execute_data *execute_data,
                                                zval *return_value);
void *vphp_task_enter_fiber(void *raw);
void vphp_task_restore_fiber(void *previous);
bool vphp_task_can_suspend(void);
void *vphp_task_swap_group(void *group);
void *vphp_task_current_group(void);
bool vphp_task_stream_is_open(void *raw);
bool vphp_task_stream_same(void *first, void *second);
bool vphp_task_socket_open(const char *address, size_t length, bool listen,
                           zval *context_value, zval *result, zval *failure);
bool vphp_task_socket_connected(void *raw, zval *failure);
int vphp_task_socket_accept(void *raw, zval *result, zval *failure);
void *vphp_task_dependency_ptr(zval *value);
void vphp_task_close_dependency(zval *value);
int vphp_task_stream_descriptor(void *raw, uintptr_t *descriptor, bool *buffered);
int vphp_task_poll_wait(const uintptr_t *fds, const int *interests,
                        int *ready, int count, int milliseconds);

void vphp_call_optional_void_symbol(const char *symbol_name);

// 参数、值与返回 (由 V 侧代码引用)
uint32_t vphp_get_num_args(zend_execute_data *ex);
bool vphp_read_arg_default(zend_execute_data *ex, uint32_t index, zval *result);
zval *vphp_get_arg_ptr(zend_execute_data *ex, uint32_t index);
zval *vphp_new_zval(void);
zval *vphp_new_persistent_zval(void);
zval *vphp_new_strl(const char *s, int len);
bool vphp_new_stream_context(zval *options, zval *result);
bool vphp_open_stream(const char *path, size_t path_len, const char *mode,
                      size_t mode_len, zval *context_value, bool report_errors,
                      zval *result);
bool vphp_is_stream_resource(zval *value);
bool vphp_stream_read_checked(zval *value, int64_t length, zval *result);
bool vphp_stream_read_complete_line(zval *value, size_t max_bytes, zval *result);
bool vphp_stream_read_line_fragment(zval *value, size_t max_bytes, zval *result);
bool vphp_stream_wrapper_data(zval *value, zval *result);
void vphp_release_zval(zval *z);
void vphp_release_zval_ex(zval *z, int persistent);
void vphp_release_zval_persistent(zval *z);
void vphp_release_persistent_zval(zval *z);
void vphp_disown_zval(zval *z);
uintptr_t vphp_current_fiber_id(void);
void vphp_init_fiber_observers(void);
int vphp_autorelease_mark(void);
void vphp_autorelease_add(zval *z);
void vphp_autorelease_forget(zval *z);
void vphp_autorelease_drain(int mark);
void vphp_runtime_counters(int *autorelease_len, int *owned_len,
                           unsigned int *obj_registry_len,
                           unsigned int *rev_registry_len);
void vphp_request_startup(void);
void vphp_request_shutdown(void);

typedef struct {
  zend_class_entry **ce;
  const char *name;
  size_t name_len;
} vphp_static_request_property;

void *vphp_find_request_static_state(const char *key, size_t key_len);
void vphp_store_request_static_state(const char *key, size_t key_len,
                                     void *value, void (*release)(void *));
void *vphp_begin_static_sync(void *ce, void (*from_php)(void *),
                              void (*to_php)(void *));
void vphp_end_static_sync(void *scope);
void *vphp_current_static_sync_class(void (*from_php)(void *));
void *vphp_static_shadow_owner(zend_class_entry *ce, const char *base,
                               size_t base_len, const char *fields,
                               size_t fields_len);
void vphp_run_static_request(INTERNAL_FUNCTION_PARAMETERS,
                              const vphp_static_request_property *properties,
                              size_t count);
void vphp_autorelease_shutdown(void);
void vphp_install_runtime_binding_hooks(void);
void vphp_uninstall_runtime_binding_hooks(void);
void vphp_init_native_trait_cache_guard(int module_number);
void vphp_enable_native_trait_cache_guard(void);
void vphp_release_native_trait_cache_guard(void);
void vphp_array_add_next_zval(zval *main_array, zval *sub_item);
void vphp_throw(char *msg, int code);
void vphp_throw_class(char *class_name, char *msg, int code);
void vphp_throw_object(zval *exception);
void vphp_error(int level, char *msg);
void vphp_output_write(const char *msg, int len);
bool vphp_has_exception(void);
int vphp_exception_message(char *buffer, int buffer_len);
void vphp_clear_exception(void);
bool vphp_take_exception(zval *result);
void vphp_append_exception(zval *primary, zval *previous);
void vphp_init_registry(void);
void vphp_shutdown_registry(void);

// 值设置与操作
void vphp_set_null(zval *z);
bool vphp_is_null(zval *z);
void vphp_set_bool(zval *z, bool val);
void vphp_set_double(zval *z, double val);
int64_t vphp_get_lval(zval *z);
void vphp_set_lval(zval *z, int64_t val);
char *vphp_get_strval(zval *z);
int vphp_get_strlen(zval *z);
int vphp_get_type(zval *z);
zval *vphp_reference_value(zval *z);
void vphp_reference_set_zval(zval *z, zval *value);
void vphp_set_strval(zval *z, char *str, int len);
void vphp_convert_to_string(zval *z);
zval *vphp_new_str(const char *s);
void vphp_make_res(zval *return_value, void *ptr, const char *label);
void *vphp_fetch_res(zval *z);
void vphp_object_init(zval *z);
void vphp_update_property_string(zval *obj, const char *name, int name_len,
                                 const char *value);
void vphp_add_property_double(zval *obj, const char *name, double val);

// 数组助手
int vphp_array_count(zval *z);
int64_t vphp_array_next_index(zval *z);
void vphp_array_restore_next_index(zval *z, int64_t index);
void vphp_array_snapshot(zval *source, zval *target);
zval *vphp_array_get_index(zval *z, int64_t index);
zval *vphp_array_get_key(zval *array, const char *key, int key_len);
zval *vphp_array_find_string_key(zval *array, const char *key, size_t key_len);
zval *vphp_array_find_key(zval *array, zval *key);
bool vphp_array_remove_key(zval *array, const char *key, size_t key_len);
bool vphp_array_remove_index(zval *array, int64_t index);
void vphp_array_init(zval *z);
void vphp_iterable_collect(zval *input, zval *output, int shape);
void vphp_iterable_foreach_while(zval *input, void *ctx,
                                 bool (*callback)(void *, zval *, zval *));
int64_t vphp_iterable_count(zval *input);
void vphp_array_push_string(zval *z, const char *val);
void vphp_array_push_stringl(zval *z, const char *val, int len);
void vphp_array_push_double(zval *z, double val);
void vphp_array_push_long(zval *z, int64_t val);
void vphp_array_add_assoc_long(zval *z, const char *key, size_t key_len, int64_t val);
void vphp_array_add_assoc_bool(zval *z, const char *key, size_t key_len, int val);
void vphp_array_add_assoc_double(zval *z, const char *key, size_t key_len,
                                 double val);
void vphp_array_add_assoc_string(zval *z, const char *key, size_t key_len,
                                 const char *val, size_t val_len);
void vphp_array_add_assoc_zval(zval *z, const char *key, zval *val);
void vphp_array_add_assoc_zval_len(zval *z, const char *key, size_t len, zval *val);
void vphp_array_add_index_zval(zval *z, int64_t index, zval *val);
void vphp_superglobal_set_env_string(const char *key, const char *val);
zval *vphp_superglobal_get_env(void);
void vphp_superglobal_set_server_string(const char *key, const char *val);
zval *vphp_superglobal_get_server(void);
zval *vphp_superglobal_get_get(void);
zval *vphp_superglobal_get_post(void);
zval *vphp_superglobal_get_cookie(void);
zval *vphp_superglobal_get_files(void);
zval *vphp_superglobal_get_request(void);
void vphp_array_foreach(zval *z, void *ctx, void (*callback)(void *, zval *));

// 属性与兼容层
zval *vphp_read_property_compat(zend_object *obj, const char *name,
                                int name_len, zval *rv);
zval *vphp_read_inherited_property(zend_object *obj, const char *name,
                                    int name_len, zval *rv);
void vphp_write_property_compat(zend_object *obj, const char *name, int name_len,
                                zval *value);
void vphp_write_inherited_property(zend_object *obj, const char *name,
                                    int name_len, zval *value);
bool vphp_skip_bound_property_projection(zend_object *obj, const char *name, int name_len);
int vphp_has_property_compat(zend_object *obj, const char *name, int name_len);
int vphp_isset_property_compat(zend_object *obj, const char *name, int name_len);
void vphp_unset_property_compat(zend_object *obj, const char *name, int name_len);
void *vphp_new_plain_object_tracker(void);
void *vphp_capture_plain_object(void *tracker, zval *root);
void vphp_restore_plain_objects(void *handle);
void vphp_release_plain_object_state(void *handle);

// 状态获取
char *VPHP_Z_STRVAL(zval *z);
int VPHP_Z_STRLEN(zval *z);

// 静态属性与 CE
zval *vphp_read_static_property_value(zend_class_entry *ce, const char *name,
                                       size_t name_len);
void vphp_write_static_property_value(zend_class_entry *ce, const char *name,
                                        size_t name_len, zval *value);
void vphp_update_static_property_long(zend_class_entry *ce, char *name,
                                      int name_len, int64_t val);
void vphp_update_static_property_string(zend_class_entry *ce, char *name,
                                        int name_len, char *val, int val_len);
void vphp_update_static_property_bool(zend_class_entry *ce, char *name,
                                      int name_len, int val);
int64_t vphp_get_static_property_long(zend_class_entry *ce, char *name,
                                      int name_len);
char *vphp_get_static_property_string(zend_class_entry *ce, char *name,
                                      int name_len);
int vphp_get_static_property_bool(zend_class_entry *ce, char *name,
                                  int name_len);
void *vphp_get_active_ce(zend_execute_data *ex);
void *vphp_get_called_ce(zend_execute_data *ex);
const char *vphp_get_string_ptr(zval *z, int *len);
bool vphp_cast_string(zval *input, zval *output);
int64_t vphp_get_int(zval *z);
double vphp_get_double(zval *z);
zend_object *vphp_get_obj_from_zval(zval *zv);
void vphp_object_addref(zend_object *obj);
void vphp_object_release(zend_object *obj);
typedef struct vphp_task_native_pin vphp_task_native_pin;
vphp_task_native_pin *vphp_pin_native_receiver(zend_object *obj);
void vphp_unpin_native_receiver(zend_object *obj, vphp_task_native_pin *pin);
void *vphp_get_this_object(zend_execute_data *execute_data);
void *vphp_get_current_this_object(void);
zval *vphp_current_hook_backing_reference(void);
zval *vphp_current_hook_storage_reference(const char *name, size_t len);
typedef struct {
  const char *declared;
  const char *static_shadows;
  void (*init_inherited_fields)(zend_object *obj, zend_class_entry *owner);
} vphp_php_property_names;
void vphp_register_php_property_storage(zend_class_entry *ce,
                                        const vphp_php_property_names *names);
void vphp_release_php_property_storage(void);
void vphp_init_inherited_field(void *obj, void *owner, const char *name,
                               int name_len, void *value);
void vphp_copy_inherited_value(void *target, void *source);
bool vphp_inherited_value_unchanged(void *before, void *after);
zval *vphp_current_property_reference(const char *name, size_t len);
zval *vphp_current_static_property_reference(const char *name, size_t len);
void *vphp_get_v_ptr_from_zval(zval *zv);
void *vphp_bound_object_pointer(zend_object *object);

// 方法调用与 Callable
int vphp_object_method_required_params(const zval *value, const char *name,
                                       size_t name_len);
int vphp_call_method(zval *obj, const char *method, int method_len,
                     zval *retval, int param_count, zval **params_ptrs);
int vphp_is_callable(zval *callable);
int vphp_call_callable(zval *callable, zval *retval, int param_count,
                       zval **params_ptrs);
int vphp_call_callable_args(zval *callable, zval *retval, zval *args);
int vphp_new_instance_args(const char *class_name, int class_name_len,
                           zval *retval, zval *args);
int vphp_call_php_func(const char *name, int name_len, zval *retval,
                       int param_count, zval **params_ptrs);
int vphp_call_static_method(const char *class_name, int class_name_len,
                            const char *method, int method_len, zval *retval,
                            int param_count, zval **params_ptrs);
int vphp_new_instance(const char *class_name, int class_name_len, zval *retval,
                      int param_count, zval **params_ptrs);
int vphp_include_file(const char *filename, int filename_len, zval *retval,
                      int once);
const char *vphp_get_object_class_name(zval *zv, int *len);
const char *vphp_get_parent_class_name(zval *zv, int *len);
int vphp_class_is_internal(zval *zv);
int vphp_bind_class_interface(const char *class_name, int class_name_len,
                              const char *iface_name, int iface_name_len);
void vphp_register_auto_interface_binding(const char *class_name, int class_name_len,
                                          const char *iface_name, int iface_name_len);
void vphp_apply_auto_interface_bindings(int autoload);
#if PHP_VERSION_ID >= 80300
bool vphp_validate_method_override(const zend_function *method, bool startup);
#endif
#if PHP_VERSION_ID >= 80500
bool vphp_validate_property_overrides(zend_class_entry *ce, bool startup);
#endif
#if PHP_VERSION_ID >= 80400
typedef struct vphp_property_hooks {
  zend_function functions[ZEND_PROPERTY_HOOK_COUNT];
  zend_function *slots[ZEND_PROPERTY_HOOK_COUNT];
#if PHP_VERSION_ID >= 80600
  zend_arg_info arg_info[ZEND_PROPERTY_HOOK_COUNT][2];
#else
  zend_internal_arg_info arg_info[ZEND_PROPERTY_HOOK_COUNT][2];
#endif
  struct vphp_property_hooks *next;
} vphp_property_hooks;

uint32_t vphp_prepare_property_hooks(zend_class_entry *ce, zend_string *name,
                                     bool has_default);
void vphp_prepare_backed_property(zend_class_entry *ce,
                                  const char *name, size_t name_len);
zend_function *vphp_install_property_hook(vphp_property_hooks *hooks,
                                          zend_property_info *prop,
                                          zend_string *name,
                                          zend_property_hook_kind kind,
                                          zif_handler handler,
                                          const char *value_name);
void vphp_inherit_property_hooks(zend_property_info *prop, zend_string *name);
void vphp_verify_reference_property_hook(const zend_property_info *prop, const char *name);
void vphp_verify_interface_restricted_hooks(const zend_class_entry *ce,
                                            const zend_class_entry *iface);
void vphp_inherit_backed_property_contract(zend_class_entry *ce, const char *name,
                                           size_t name_len, zend_function **slots);
void vphp_verify_interface_property_contracts(zend_class_entry *ce, bool declared_abstract);
void vphp_release_property_hooks(void);
#endif
bool vphp_object_matches_external_interface(zval *object, const char *name, int len);
zend_class_entry *vphp_find_loaded_class_entry(const char *class_name,
                                               int class_name_len);
zend_class_entry *vphp_require_class_entry(const char *class_name,
                                           int class_name_len, int autoload);
zval *vphp_write_property(zend_object *object, zend_string *member, zval *value,
                          void **cache_slot);

zval *vphp_read_static_property_compat(const char *class_name, int class_name_len,
                                       const char *name, int name_len, zval *rv);
int vphp_write_static_property_compat(const char *class_name, int class_name_len,
                                      const char *name, int name_len, zval *value);
zval *vphp_read_class_constant_compat(const char *class_name, int class_name_len,
                                      const char *name, int name_len, zval *rv);

// 数组与通用
void vphp_return_array_start(zval *return_value);
void vphp_zval_foreach(zval *z, void *ctx,
                       void (*callback)(void *, zval *, zval *));

void *vphp_zend_enum_get_case(void *ce, const char *name, int name_len);
void vphp_init_enum_case_alias(zval *value, const char *enum_name, const char *case_name);
void vphp_zval_set_object_copy(void *z, void *zo);
bool vphp_object_ce_equals(void *obj, void *ce);
bool vphp_object_is_instance_of(void *obj, void *ce);

#endif
