static zend_class_entry *vphp_get_ce_from_zval(zval *zv) {
  if (!zv) {
    return NULL;
  }
  if (Z_TYPE_P(zv) == IS_OBJECT) {
    return Z_OBJCE_P(zv);
  }
  if (Z_TYPE_P(zv) == IS_STRING) {
    return vphp_lookup_class_by_name(Z_STRVAL_P(zv), Z_STRLEN_P(zv));
  }
  return NULL;
}

int vphp_call_php_func(const char *name, int name_len, zval *retval,
                       int param_count, zval **params_ptrs) {
  zval func_name;
  ZVAL_STRINGL(&func_name, name, name_len);
  int result = vphp_call_callable(&func_name, retval, param_count, params_ptrs);
  zval_ptr_dtor(&func_name);
  return result;
}

int vphp_call_static_method(const char *class_name, int class_name_len,
                            const char *method, int method_len, zval *retval,
                            int param_count, zval **params_ptrs) {
  zend_string *callable =
      zend_strpprintf(0, "%.*s::%.*s", class_name_len, class_name, method_len,
                      method);
  zval callable_zv;
  ZVAL_STR(&callable_zv, callable);
  int result =
      vphp_call_callable(&callable_zv, retval, param_count, params_ptrs);
  zval_ptr_dtor(&callable_zv);
  return result;
}

static int vphp_new_instance_impl(const char *class_name, int class_name_len,
                                  zval *retval, int count, zval *params,
                                  HashTable *named_args) {
  zend_class_entry *ce = vphp_lookup_class_by_name(class_name, class_name_len);
  if (!ce) {
    if (!EG(exception)) {
      zend_throw_error(NULL, "Class \"%.*s\" not found", class_name_len, class_name);
    }
    return FAILURE;
  }
  return vphp_zend_init_with_constructor(retval, ce, count, params, named_args);
}

int vphp_new_instance(const char *class_name, int class_name_len, zval *retval,
                      int param_count, zval **params_ptrs) {
  ZVAL_UNDEF(retval);
  if (EG(exception)) {
    return FAILURE;
  }
  zval *params = NULL;
  if (param_count > 0) {
    params = (zval *)safe_emalloc(param_count, sizeof(zval), 0);
    for (int i = 0; i < param_count; i++) {
      if (params_ptrs[i]) {
        ZVAL_COPY(&params[i], params_ptrs[i]);
      } else {
        ZVAL_NULL(&params[i]);
      }
    }
  }
  vphp_static_sync *sync = vphp_suspend_static_sync();
  int result = vphp_new_instance_impl(class_name, class_name_len, retval,
                                     param_count, params, NULL);
  if (params) {
    for (int i = 0; i < param_count; i++) {
      vphp_dtor_zval(&params[i]);
    }
    efree(params);
  }
  vphp_resume_static_sync(sync);
  return EG(exception) ? FAILURE : result;
}

int vphp_include_file(const char *filename, int filename_len, zval *retval,
                      int once) {
  zend_file_handle file_handle;
  ZVAL_UNDEF(retval);
  if (EG(exception)) {
    return FAILURE;
  }
  vphp_static_sync *sync = vphp_suspend_static_sync();
  zend_string *filename_str = zend_string_init(filename, filename_len, 0);
  zend_string *resolved_path = zend_resolve_path(filename_str);
  zend_string_release(filename_str);
  if (once && resolved_path &&
      zend_hash_exists(&EG(included_files), resolved_path)) {
    ZVAL_TRUE(retval);
    zend_string_release(resolved_path);
    vphp_resume_static_sync(sync);
    return SUCCESS;
  }
  zend_stream_init_filename(&file_handle, filename);
  file_handle.primary_script = 0;
  if (resolved_path) {
    file_handle.opened_path = resolved_path;
  }
  int type = once ? ZEND_INCLUDE_ONCE : ZEND_INCLUDE;
  if (!EG(current_execute_data)) {
    zend_result result = vphp_zend_execute_scripts(type, retval, 1, &file_handle);
    zend_destroy_file_handle(&file_handle);
    vphp_resume_static_sync(sync);
    return result;
  }

  // Let the calling PHP frame catch exceptions from the included file.
  zend_op_array *script = zend_compile_file(&file_handle, type);
  if (file_handle.opened_path) {
    zend_hash_add_empty_element(&EG(included_files), file_handle.opened_path);
  }
  zend_destroy_file_handle(&file_handle);
  if (script) {
    if (!EG(exception)) {
      zend_execute(script, retval);
#ifdef ZEND_HAS_OOM
      if (ZEND_HAS_OOM()) {
        zend_handle_delayed_oom();
      }
#endif
    }
    zend_destroy_static_vars(script);
    destroy_op_array(script);
    efree_size(script, sizeof(zend_op_array));
  }
  vphp_resume_static_sync(sync);
  return EG(exception) ? FAILURE : SUCCESS;
}

int vphp_is_callable(zval *callable) {
  return callable ? (vphp_zend_is_callable(callable) ? 1 : 0) : 0;
}

static int vphp_call_callable_impl(zval *callable, zend_object *receiver,
                                   zval *retval, int param_count,
                                   zval **params_ptrs, HashTable *named_params) {
  zval *params = NULL;
  zend_fcall_info fci;
  zend_fcall_info_cache fcc;
  char *error = NULL;
  char debug_buf[256];

  ZVAL_UNDEF(retval);
  if (EG(exception)) {
    return FAILURE;
  }
  if (!callable) {
    vphp_bridge_debug_log("vphp-bridge-debug","vphp_call_callable callable=NULL");
    return -1;
  }
  snprintf(debug_buf, sizeof(debug_buf),
           "vphp_call_callable enter callable=%p retval=%p param_count=%d type=%d",
           (void *)callable, (void *)retval, param_count, Z_TYPE_P(callable));
  vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  vphp_bridge_debug_log_zval("vphp-bridge-debug","vphp_call_callable callable_state", callable);
  vphp_static_sync *sync = vphp_suspend_static_sync();
  if (vphp_zend_fcall_info_init(callable, receiver, &fci, &fcc, &error) != SUCCESS) {
    snprintf(debug_buf, sizeof(debug_buf),
             "vphp_call_callable init_fail callable=%p error=%s", (void *)callable,
             error != NULL ? error : "(null)");
    vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    if (!EG(exception)) {
      zend_type_error("Invalid PHP callable: %s", error ? error : "target is not callable");
    }
    if (error != NULL) {
      efree(error);
    }
    vphp_resume_static_sync(sync);
    return -1;
  }
  snprintf(debug_buf, sizeof(debug_buf),
           "vphp_call_callable init_ok callable=%p object=%p function_handler=%p",
           (void *)callable, (void *)fci.object, (void *)fcc.function_handler);
  vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  if (fcc.object != NULL) {
    zval callable_obj;
    ZVAL_OBJ(&callable_obj, fcc.object);
    vphp_bridge_debug_log_zval("vphp-bridge-debug","vphp_call_callable fcc_object_state",
                                    &callable_obj);
  }
  if (param_count > 0) {
    params = (zval *)safe_emalloc(param_count, sizeof(zval), 0);
    for (int i = 0; i < param_count; i++) {
      if (params_ptrs[i]) {
        ZVAL_COPY(&params[i], params_ptrs[i]);
        snprintf(debug_buf, sizeof(debug_buf),
                 "vphp_call_callable param[%d] src=%p dst=%p", i,
                 (void *)params_ptrs[i], (void *)&params[i]);
        vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
        vphp_bridge_debug_log_zval("vphp-bridge-debug","vphp_call_callable param_state",
                                        &params[i]);
      } else {
        ZVAL_NULL(&params[i]);
      }
    }
  }
  snprintf(debug_buf, sizeof(debug_buf),
           "vphp_call_callable params_ready callable=%p params=%p count=%d",
           (void *)callable, (void *)params, param_count);
  vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  fci.retval = retval;
  fci.param_count = param_count;
  fci.params = params;
  fci.named_params = named_params;
  snprintf(debug_buf, sizeof(debug_buf),
           "vphp_call_callable before_zend_call callable=%p retval=%p", (void *)callable,
           (void *)retval);
  vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  // Zend owns the callee's arguments; this buffer owns our separate copies.
  vphp_task_native_pin *param_roots = vphp_task_trace_values(params, param_count);
  int result = vphp_zend_call_function(&fci, &fcc);
  vphp_task_untrace_values(param_roots);
  snprintf(debug_buf, sizeof(debug_buf),
           "vphp_call_callable after_zend_call callable=%p result=%d retval_type=%d exception=%p",
           (void *)callable, result, retval != NULL ? Z_TYPE_P(retval) : -1,
           (void *)EG(exception));
  vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  if (params) {
    for (int i = 0; i < param_count; i++) {
      vphp_dtor_zval(&params[i]);
    }
    efree(params);
  }
  vphp_resume_static_sync(sync);
  vphp_bridge_debug_log("vphp-bridge-debug","vphp_call_callable exit");
  return EG(exception) ? FAILURE : result;
}

int vphp_call_method(zval *obj, const char *method, int method_len,
                     zval *retval, int param_count, zval **params_ptrs) {
  if (!obj || Z_TYPE_P(obj) != IS_OBJECT) {
    ZVAL_UNDEF(retval);
    return FAILURE;
  }
  zval method_name;
  ZVAL_STRINGL(&method_name, method, method_len);
  int result = vphp_call_callable_impl(&method_name, Z_OBJ_P(obj), retval,
                                       param_count, params_ptrs, NULL);
  zval_ptr_dtor(&method_name);
  return result;
}

int vphp_call_callable(zval *callable, zval *retval, int param_count,
                       zval **params_ptrs) {
  return vphp_call_callable_impl(callable, NULL, retval, param_count, params_ptrs, NULL);
}

int vphp_call_callable_args(zval *callable, zval *retval, zval *args) {
  if (!args || Z_TYPE_P(args) != IS_ARRAY) {
    ZVAL_UNDEF(retval);
    return FAILURE;
  }
  zval arguments;
  ZVAL_COPY(&arguments, args);
  int result = vphp_call_callable_impl(callable, NULL, retval, 0, NULL, Z_ARRVAL(arguments));
  vphp_dtor_zval(&arguments);
  return EG(exception) ? FAILURE : result;
}

int vphp_new_instance_args(const char *class_name, int class_name_len,
                           zval *retval, zval *args) {
  ZVAL_UNDEF(retval);
  if (EG(exception) || !args || Z_TYPE_P(args) != IS_ARRAY) {
    return FAILURE;
  }

  zval arguments;
  ZVAL_COPY(&arguments, args);
  vphp_static_sync *sync = vphp_suspend_static_sync();
  int result = vphp_new_instance_impl(class_name, class_name_len, retval,
                                     0, NULL, Z_ARRVAL(arguments));
  vphp_dtor_zval(&arguments);
  vphp_resume_static_sync(sync);
  return EG(exception) ? FAILURE : result;
}

const char *vphp_get_object_class_name(zval *zv, int *len) {
  zend_class_entry *ce = vphp_get_ce_from_zval(zv);
  if (!ce) {
    *len = 0;
    return "";
  }
  *len = ZSTR_LEN(ce->name);
  return ZSTR_VAL(ce->name);
}

const char *vphp_get_parent_class_name(zval *zv, int *len) {
  zend_class_entry *ce = vphp_get_ce_from_zval(zv);
  if (!ce || !ce->parent) {
    *len = 0;
    return "";
  }
  *len = ZSTR_LEN(ce->parent->name);
  return ZSTR_VAL(ce->parent->name);
}

int vphp_class_is_internal(zval *zv) {
  zend_class_entry *ce = vphp_get_ce_from_zval(zv);
  if (!ce) {
    return 0;
  }
  return (ce->type == ZEND_INTERNAL_CLASS) ? 1 : 0;
}

void *vphp_get_this_object(zend_execute_data *execute_data) {
  zval *this_obj = getThis();
  return this_obj ? (void *)Z_OBJ_P(this_obj) : NULL;
}

void *vphp_get_current_this_object(void) {
  zend_execute_data *execute_data = EG(current_execute_data);
  if (execute_data == NULL) {
    return NULL;
  }
  zval *this_obj = getThis();
  return this_obj ? (void *)Z_OBJ_P(this_obj) : NULL;
}

void *vphp_get_active_ce(zend_execute_data *ex) {
  if (ex && ex->func && ex->func->common.scope) {
    return (void *)ex->func->common.scope;
  }
  return NULL;
}

void *vphp_get_called_ce(zend_execute_data *ex) {
  zend_class_entry *ce = ex ? vphp_zend_get_called_scope(ex) : NULL;
  return ce ? (void *)ce : vphp_get_active_ce(ex);
}

static void ZEND_FASTCALL vphp_closure_handler(zend_execute_data *execute_data,
                                               zval *return_value) {
  zend_internal_function *zf = (zend_internal_function *)execute_data->func;
  void *v_thunk = zf->reserved[0];
  vphp_closure_bridge bridge = (vphp_closure_bridge)zf->reserved[1];

  if (bridge) {
    if ((zf->fn_flags & ZEND_ACC_VARIADIC) &&
        (ZEND_CALL_INFO(execute_data) & ZEND_CALL_HAS_EXTRA_NAMED_PARAMS)) {
      if (!zf->reserved[2] &&
          (zf->num_args > 0 || ZEND_TYPE_HAS_NAME(zf->arg_info[zf->num_args].type) ||
          ((zf->fn_flags & ZEND_ACC_HAS_RETURN_TYPE) &&
           !(zf->fn_flags & ZEND_ACC_RETURN_REFERENCE)))) {
        /* V variadic arrays have no slot for a PHP argument name. */
        zend_unexpected_extra_named_error();
        return;
      }
      if (!vphp_validate_internal_call(execute_data)) {
        return;
      }
    }
    vphp_mark_omitted_computed_defaults(execute_data);
    bridge(v_thunk, execute_data, return_value);
    if (zf->fn_flags & (ZEND_ACC_RETURN_REFERENCE | ZEND_ACC_HAS_RETURN_TYPE)) {
      if (!EG(exception) && Z_TYPE_P(return_value) == IS_NULL &&
          ZEND_TYPE_CONTAINS_CODE(zf->arg_info[-1].type, IS_VOID)) {
        vphp_mark_void_return(return_value);
      }
      vphp_validate_internal_return(execute_data, return_value);
    }
  }
}

void vphp_create_closure_FULL_AUTO_V2(zval *zv, void *v_thunk,
                                      void *bridge_ptr) {
  zend_internal_function *zf =
      (zend_internal_function *)pecalloc(1, sizeof(zend_internal_function), 1);
  zf->type = ZEND_INTERNAL_FUNCTION;
  zf->handler = vphp_closure_handler;
  zf->fn_flags = ZEND_ACC_CLOSURE | ZEND_ACC_PUBLIC;
  zf->function_name = zend_string_init("VPHPClosure", 11, 1);
  zf->num_args = 0;
  zf->required_num_args = 0;
  zf->arg_info = NULL;
  zf->reserved[0] = v_thunk;
  zf->reserved[1] = bridge_ptr;

  vphp_zend_create_closure(zv, (zend_function *)zf);
}

void vphp_create_closure_with_arity(zval *zv, void *v_thunk, void *bridge_ptr,
                                    int num_args, int required_args) {
  vphp_create_closure_with_arginfo(zv, v_thunk, (vphp_closure_bridge)bridge_ptr, num_args,
                                  required_args, NULL);
}

static void vphp_create_closure_from_arginfo(zval *zv, void *v_thunk,
                                            vphp_closure_bridge bridge, int num_args,
                                            int required_args, const zend_internal_arg_info *arginfo,
                                            bool named_variadic, HashTable *attributes) {
  zend_internal_function *zf =
      (zend_internal_function *)pecalloc(1, sizeof(zend_internal_function), 1);
  zf->type = ZEND_INTERNAL_FUNCTION;
  zf->handler = vphp_closure_handler;
  zf->fn_flags = ZEND_ACC_CLOSURE | ZEND_ACC_PUBLIC;
  zf->function_name = zend_string_init("VPHPClosure", 11, 1);
  zf->num_args = num_args;
  zf->required_num_args = required_args;
  zf->attributes = attributes;
  if (arginfo) {
#if PHP_VERSION_ID >= 80600
    // Runtime arginfo uses zend_string names from PHP 8.6 onward.
    zend_arg_info *converted = ecalloc(num_args + 1, sizeof(*converted));
    for (int i = 0; i <= num_args; i++) {
      zend_convert_internal_arg_info(&converted[i], &arginfo[i], i == 0, false);
    }
    zf->arg_info = converted + 1;
    zf->reserved[3] = (void *)arginfo;
#else
    zf->arg_info = (zend_internal_arg_info *)arginfo + 1;
#endif
    if (ZEND_ARG_SEND_MODE(arginfo)) {
      zf->fn_flags |= ZEND_ACC_RETURN_REFERENCE;
    }
    if (ZEND_TYPE_IS_SET(arginfo[0].type)) {
      zf->fn_flags |= ZEND_ACC_HAS_RETURN_TYPE;
    }
    if (num_args > 0 && ZEND_ARG_IS_VARIADIC(&arginfo[num_args]) &&
        (named_variadic || num_args > 1 || ZEND_TYPE_HAS_NAME(arginfo[num_args].type) ||
         ZEND_TYPE_PURE_MASK(arginfo[num_args].type) != MAY_BE_ANY ||
         (zf->fn_flags & (ZEND_ACC_RETURN_REFERENCE | ZEND_ACC_HAS_RETURN_TYPE)) ||
         ZEND_ARG_SEND_MODE(&arginfo[num_args]))) {
      zf->fn_flags |= ZEND_ACC_VARIADIC;
      zf->num_args--;
      zf->reserved[2] = named_variadic ? zf : NULL;
    }
    zend_set_function_arg_flags((zend_function *)zf);
  }
  zf->reserved[0] = v_thunk;
  zf->reserved[1] = (void *)bridge;

  vphp_zend_create_closure(zv, (zend_function *)zf);
}

void vphp_create_closure_with_arginfo(zval *zv, void *v_thunk, vphp_closure_bridge bridge,
                                     int num_args, int required_args,
                                     const zend_internal_arg_info *arginfo) {
  vphp_create_closure_from_arginfo(zv, v_thunk, bridge, num_args, required_args, arginfo, false, NULL);
}

void vphp_create_closure_with_attributes(zval *zv, void *v_thunk, vphp_closure_bridge bridge,
                                         int num_args, int required_args,
                                         const zend_internal_arg_info *arginfo, HashTable *attributes) {
  vphp_create_closure_from_arginfo(zv, v_thunk, bridge, num_args, required_args, arginfo, false, attributes);
}

void vphp_add_sensitive_closure_parameter(HashTable **attributes, uint32_t index) {
  zend_add_attribute(attributes, zend_ce_sensitive_parameter->name, 0,
                     ZEND_ATTRIBUTE_PERSISTENT, index + 1, 0);
}

void vphp_create_named_variadic_closure(zval *zv, void *v_thunk, vphp_closure_bridge bridge,
                                       int num_args, int required_args,
                                       const zend_internal_arg_info *arginfo) {
  vphp_create_closure_from_arginfo(zv, v_thunk, bridge, num_args, required_args, arginfo, true, NULL);
}

ZEND_BEGIN_ARG_INFO_EX(vphp_closure_default_constructor_args, 0, 0, 2)
ZEND_ARG_TYPE_INFO(0, closure, IS_LONG, 0)
ZEND_ARG_TYPE_INFO(0, field, IS_LONG, 0)
ZEND_END_ARG_INFO()

ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(vphp_closure_default_is_dynamic_args, 0, 0, _IS_BOOL, 0)
ZEND_END_ARG_INFO()

typedef struct {
  vphp_computed_default_matcher matches;
  zend_long closure;
  zend_long field;
  bool initialized;
#if PHP_VERSION_ID >= 80600
  const zend_execute_data *partial_origin;
#endif
  zend_object std;
} vphp_closure_default;

static zend_object_handlers vphp_closure_default_handlers;

static vphp_closure_default *vphp_closure_default_from_object(zend_object *obj) {
  return (vphp_closure_default *)((char *)obj - offsetof(vphp_closure_default, std));
}

static zend_object *vphp_create_closure_default(zend_class_entry *ce) {
  vphp_closure_default *marker = zend_object_alloc(sizeof(*marker), ce);
  zend_object_std_init(&marker->std, ce);
  marker->std.handlers = &vphp_closure_default_handlers;
  return &marker->std;
}

static PHP_METHOD(VphpClosureDefault, __construct) {
  zend_long closure, field;
  ZEND_PARSE_PARAMETERS_START(2, 2)
    Z_PARAM_LONG(closure)
    Z_PARAM_LONG(field)
  ZEND_PARSE_PARAMETERS_END();

  vphp_closure_default *marker = vphp_closure_default_from_object(Z_OBJ_P(ZEND_THIS));
  if (marker->initialized) {
    return;
  }
  marker->initialized = true;
  marker->closure = closure;
  marker->field = field;
  marker->matches = NULL;
  zend_execute_data *caller = execute_data->prev_execute_data;
  zend_class_entry *scope = caller && caller->func ? caller->func->common.scope : NULL;
  // Zend creates an internal call frame when filling a missing internal argument.
  // Reflection and userland defaults only create inert descriptors.
  const uint32_t ast_call = ZEND_CALL_TOP | ZEND_CALL_DYNAMIC;
  bool omitted_internal_argument = caller && caller->func && caller->func->type == ZEND_INTERNAL_FUNCTION &&
      caller->opline == NULL && (ZEND_CALL_INFO(execute_data) & ast_call) == ast_call &&
      !(scope && zend_string_equals_literal_ci(scope->name, "ReflectionParameter"));
#if PHP_VERSION_ID >= 80600
  // Zend emits defaults for gaps before a named placeholder into the body of
  // its synthetic partial closure. The receiver still verifies the marker's
  // callable and argument index before replacing it with an omitted slot.
  if (caller && caller->func && caller->func->type == ZEND_USER_FUNCTION &&
      (caller->func->common.fn_flags & ZEND_ACC_CLOSURE) &&
      caller->func->common.function_name &&
      zend_string_starts_with_literal(caller->func->common.function_name, "{closure:pfa:")) {
    marker->partial_origin = caller;
    omitted_internal_argument = true;
  }
#endif
  if (omitted_internal_argument) {
    marker->matches = (vphp_computed_default_matcher)execute_data->func->internal_function.reserved[0];
  }
}

static PHP_METHOD(VphpClosureDefault, isDynamic) {
  ZEND_PARSE_PARAMETERS_NONE();
  RETURN_TRUE;
}

static const zend_function_entry vphp_closure_default_methods[] = {
    PHP_ME(VphpClosureDefault, __construct, vphp_closure_default_constructor_args,
           ZEND_ACC_PUBLIC)
    PHP_ME(VphpClosureDefault, isDynamic, vphp_closure_default_is_dynamic_args,
           ZEND_ACC_PUBLIC)
    PHP_FE_END
};

void vphp_register_closure_default_class(const char *name,
                                         vphp_computed_default_matcher matches) {
  zend_class_entry definition;
  INIT_CLASS_ENTRY_EX(definition, name, strlen(name), vphp_closure_default_methods);
  zend_class_entry *ce = zend_register_internal_class(&definition);
  ce->ce_flags |= ZEND_ACC_FINAL;
  ce->create_object = vphp_create_closure_default;
  memcpy(&vphp_closure_default_handlers, zend_get_std_object_handlers(),
         sizeof(vphp_closure_default_handlers));
  vphp_closure_default_handlers.offset = offsetof(vphp_closure_default, std);
  vphp_closure_default_handlers.clone_obj = NULL;
  ce->constructor->internal_function.reserved[0] = (void *)matches;
}

bool vphp_matches_computed_default_arginfo(const zend_internal_function *func,
                                           const zend_internal_arg_info *arginfo) {
#if PHP_VERSION_ID >= 80600
  return func->reserved[3] == arginfo;
#else
  return func->arg_info == arginfo + 1;
#endif
}

bool vphp_matches_computed_default_handler(const zend_internal_function *func,
                                           zif_handler handler) {
  if (func->handler == handler) {
    return true;
  }
  if (!(func->fn_flags & ZEND_ACC_FAKE_CLOSURE) || !func->function_name) {
    return false;
  }
  // First-class callables preserve the registered arginfo and wrap the handler.
  HashTable *table = func->scope ? &func->scope->function_table : EG(function_table);
  zend_string *name = zend_string_tolower(func->function_name);
  const zend_function *registered = zend_hash_find_ptr(table, name);
  zend_string_release(name);
  return registered && registered->type == ZEND_INTERNAL_FUNCTION
      && registered->internal_function.handler == handler
      && registered->internal_function.arg_info == func->arg_info;
}

static void vphp_mark_omitted_computed_defaults(zend_execute_data *execute_data) {
  const zend_internal_function *func = &execute_data->func->internal_function;
  // Closure::__invoke can forward already-filled slots in a fresh Zend frame.
  if (!func->arg_info) {
    return;
  }
  uint32_t count = MIN(ZEND_CALL_NUM_ARGS(execute_data), func->num_args);
  for (uint32_t i = 0; i < count; ++i) {
    zval *arg = ZEND_CALL_ARG(execute_data, i + 1);
    if (Z_TYPE_P(arg) != IS_OBJECT || Z_OBJ_HT_P(arg) != &vphp_closure_default_handlers) {
      continue;
    }
    vphp_closure_default *marker = vphp_closure_default_from_object(Z_OBJ_P(arg));
#if PHP_VERSION_ID >= 80600
    if (marker->partial_origin && marker->partial_origin != execute_data->prev_execute_data) {
      continue;
    }
#endif
    if (marker->matches && marker->field == i &&
        marker->matches(func, marker->closure, marker->field)) {
      zval_ptr_dtor(arg);
      ZVAL_UNDEF(arg);
    }
  }
}

static const zend_internal_arg_info vphp_variadic_closure_arginfo[] = {
    {(const char *)(uintptr_t)(0),
     ZEND_TYPE_INIT_NONE(_ZEND_ARG_INFO_FLAGS(0, 0, 0)), NULL},
    ZEND_ARG_VARIADIC_TYPE_INFO(0, args, IS_MIXED, 0)};

void vphp_create_variadic_closure(zval *zv, void *v_thunk, vphp_closure_bridge bridge) {
  vphp_create_closure_with_arginfo(zv, v_thunk, bridge, 1, 0, vphp_variadic_closure_arginfo);
}
