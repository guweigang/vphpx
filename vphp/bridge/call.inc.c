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
  zval *params = NULL;

  ZVAL_STRINGL(&func_name, name, name_len);
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
  int result = call_user_function(EG(function_table), NULL, &func_name, retval,
                                  param_count, params);
  zval_ptr_dtor(&func_name);
  if (params) {
    for (int i = 0; i < param_count; i++) {
      zval_ptr_dtor(&params[i]);
    }
    efree(params);
  }
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

int vphp_new_instance(const char *class_name, int class_name_len, zval *retval,
                      int param_count, zval **params_ptrs) {
  zend_class_entry *ce = vphp_lookup_class_by_name(class_name, class_name_len);
  zval *params = NULL;
  zval ctor_name;
  zval ctor_retval;

  if (!ce) {
    return -1;
  }

  object_init_ex(retval, ce);
  if (!ce->constructor) {
    return param_count == 0 ? SUCCESS : -1;
  }

  ZVAL_STRINGL(&ctor_name, "__construct", sizeof("__construct") - 1);
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
  ZVAL_UNDEF(&ctor_retval);
  int result = call_user_function(EG(function_table), retval, &ctor_name,
                                  &ctor_retval, param_count, params);
  zval_ptr_dtor(&ctor_name);
  zval_ptr_dtor(&ctor_retval);
  if (params) {
    for (int i = 0; i < param_count; i++) {
      zval_ptr_dtor(&params[i]);
    }
    efree(params);
  }
  return result;
}

int vphp_include_file(const char *filename, int filename_len, zval *retval,
                      int once) {
  zend_file_handle file_handle;
  ZVAL_UNDEF(retval);
  if (EG(exception)) {
    return FAILURE;
  }
  zend_string *filename_str = zend_string_init(filename, filename_len, 0);
  zend_string *resolved_path = zend_resolve_path(filename_str);
  zend_string_release(filename_str);
  if (once && resolved_path &&
      zend_hash_exists(&EG(included_files), resolved_path)) {
    ZVAL_TRUE(retval);
    zend_string_release(resolved_path);
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
  return EG(exception) ? FAILURE : SUCCESS;
}

int vphp_call_method(zval *obj, const char *method, int method_len,
                     zval *retval, int param_count, zval **params_ptrs) {
  zval *params = NULL;

  if (!obj || Z_TYPE_P(obj) != IS_OBJECT) {
    return -1;
  }
  ZVAL_UNDEF(retval);
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
  int result = SUCCESS;
  zval method_name;
  ZVAL_STRINGL(&method_name, method, method_len);
  result = call_user_function(EG(function_table), obj, &method_name, retval,
                              param_count, params);
  zval_ptr_dtor(&method_name);
  if (params) {
    for (int i = 0; i < param_count; i++) {
      zval_ptr_dtor(&params[i]);
    }
    efree(params);
  }
  if (EG(exception) != NULL) {
    return SUCCESS;
  }
  return result;
}

int vphp_is_callable(zval *callable) {
  return callable ? (vphp_zend_is_callable(callable) ? 1 : 0) : 0;
}

int vphp_call_callable(zval *callable, zval *retval, int param_count,
                       zval **params_ptrs) {
  zval *params = NULL;
  zend_fcall_info fci;
  zend_fcall_info_cache fcc;
  char *error = NULL;
  char debug_buf[256];

  if (!callable) {
    vphp_bridge_debug_log("vphp-bridge-debug","vphp_call_callable callable=NULL");
    return -1;
  }
  snprintf(debug_buf, sizeof(debug_buf),
           "vphp_call_callable enter callable=%p retval=%p param_count=%d type=%d",
           (void *)callable, (void *)retval, param_count, Z_TYPE_P(callable));
  vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  vphp_bridge_debug_log_zval("vphp-bridge-debug","vphp_call_callable callable_state", callable);
  ZVAL_UNDEF(retval);
  if (vphp_zend_fcall_info_init(callable, &fci, &fcc, &error) != SUCCESS) {
    snprintf(debug_buf, sizeof(debug_buf),
             "vphp_call_callable init_fail callable=%p error=%s", (void *)callable,
             error != NULL ? error : "(null)");
    vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    if (error != NULL) {
      efree(error);
    }
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
  snprintf(debug_buf, sizeof(debug_buf),
           "vphp_call_callable before_zend_call callable=%p retval=%p", (void *)callable,
           (void *)retval);
  vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  int result = vphp_zend_call_function(&fci, &fcc);
  snprintf(debug_buf, sizeof(debug_buf),
           "vphp_call_callable after_zend_call callable=%p result=%d retval_type=%d exception=%p",
           (void *)callable, result, retval != NULL ? Z_TYPE_P(retval) : -1,
           (void *)EG(exception));
  vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  if (params) {
    for (int i = 0; i < param_count; i++) {
      zval_ptr_dtor(&params[i]);
    }
    efree(params);
  }
  vphp_bridge_debug_log("vphp-bridge-debug","vphp_call_callable exit");
  return result;
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

static void ZEND_FASTCALL vphp_closure_handler(zend_execute_data *execute_data,
                                               zval *return_value) {
  zend_internal_function *zf = (zend_internal_function *)execute_data->func;
  void *v_thunk = zf->reserved[0];
  void *bridge_ptr = zf->reserved[1];

  if (bridge_ptr) {
    vphp_mark_omitted_computed_defaults(execute_data);
    void (*bridge)(void *, zend_execute_data *, zval *) =
        (void (*)(void *, zend_execute_data *, zval *))bridge_ptr;
    bridge(v_thunk, execute_data, return_value);
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
  vphp_create_closure_with_arginfo(zv, v_thunk, bridge_ptr, num_args,
                                  required_args, NULL);
}

void vphp_create_closure_with_arginfo(zval *zv, void *v_thunk, void *bridge_ptr,
                                     int num_args, int required_args,
                                     const zend_internal_arg_info *arginfo) {
  zend_internal_function *zf =
      (zend_internal_function *)pecalloc(1, sizeof(zend_internal_function), 1);
  zf->type = ZEND_INTERNAL_FUNCTION;
  zf->handler = vphp_closure_handler;
  zf->fn_flags = ZEND_ACC_CLOSURE | ZEND_ACC_PUBLIC;
  zf->function_name = zend_string_init("VPHPClosure", 11, 1);
  zf->num_args = num_args;
  zf->required_num_args = required_args;
  zf->arg_info = arginfo ? (zend_internal_arg_info *)arginfo + 1 : NULL;
  zf->reserved[0] = v_thunk;
  zf->reserved[1] = bridge_ptr;

  vphp_zend_create_closure(zv, (zend_function *)zf);
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
  zend_object std;
} vphp_closure_default;

static zend_object_handlers vphp_closure_default_handlers;

static vphp_closure_default *vphp_closure_default_from_object(zend_object *obj) {
  return (vphp_closure_default *)((char *)obj - XtOffsetOf(vphp_closure_default, std));
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
  if (caller && caller->func && caller->func->type == ZEND_INTERNAL_FUNCTION &&
      caller->opline == NULL && (ZEND_CALL_INFO(execute_data) & ast_call) == ast_call &&
      !(scope && zend_string_equals_literal_ci(scope->name, "ReflectionParameter"))) {
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
  vphp_closure_default_handlers.offset = XtOffsetOf(vphp_closure_default, std);
  vphp_closure_default_handlers.clone_obj = NULL;
  ce->constructor->internal_function.reserved[0] = (void *)matches;
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

void vphp_create_variadic_closure(zval *zv, void *v_thunk, void *bridge_ptr) {
  zend_internal_function *zf =
      (zend_internal_function *)pecalloc(1, sizeof(zend_internal_function), 1);
  zf->type = ZEND_INTERNAL_FUNCTION;
  zf->handler = vphp_closure_handler;
  zf->fn_flags = ZEND_ACC_CLOSURE | ZEND_ACC_PUBLIC;
  zf->function_name = zend_string_init("VPHPClosure", 11, 1);
  zf->num_args = 1;
  zf->required_num_args = 0;
  zf->arg_info = (zend_internal_arg_info *)vphp_variadic_closure_arginfo + 1;
  zf->reserved[0] = v_thunk;
  zf->reserved[1] = bridge_ptr;

  vphp_zend_create_closure(zv, (zend_function *)zf);
}
