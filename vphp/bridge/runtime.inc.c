static zend_class_entry *vphp_type_scope_ce(zend_execute_data *execute_data,
                                            const char *name) {
  zend_class_entry *scope = execute_data && execute_data->func
                                ? execute_data->func->common.scope
                                : NULL;
  zend_class_entry *called_scope =
      execute_data ? vphp_zend_get_called_scope(execute_data) : NULL;

  if (scope == NULL || name == NULL) {
    return NULL;
  }
  if (strcmp(name, "self") == 0) {
    return scope;
  }
  if (strcmp(name, "parent") == 0) {
    return scope->parent;
  }
  if (strcmp(name, "static") == 0) {
    return called_scope ? called_scope : scope;
  }
  return NULL;
}

static zend_string *vphp_normalize_literal_type_name(const char *literal_name) {
  size_t len = 0;
  size_t i = 0;
  size_t out_len = 0;
  char *buffer = NULL;
  zend_string *normalized = NULL;

  if (literal_name == NULL) {
    return NULL;
  }

  len = strlen(literal_name);
  buffer = emalloc(len + 1);
  for (i = 0; i < len; i++) {
    if (literal_name[i] == '\\' && i + 1 < len && literal_name[i + 1] == '\\') {
      buffer[out_len++] = '\\';
      i++;
      continue;
    }
    buffer[out_len++] = literal_name[i];
  }
  buffer[out_len] = '\0';
  normalized = zend_string_init(buffer, out_len, 0);
  efree(buffer);
  return normalized;
}

static zend_class_entry *vphp_lookup_type_ce(zend_execute_data *execute_data,
                                             zend_type type) {
  const char *literal_name = NULL;
  zend_string *name = NULL;
  zend_class_entry *ce = NULL;

  if (ZEND_TYPE_HAS_NAME(type)) {
    name = ZEND_TYPE_NAME(type);
    return vphp_zend_lookup_class(name);
  }
  if (!ZEND_TYPE_HAS_LITERAL_NAME(type)) {
    return NULL;
  }

  literal_name = ZEND_TYPE_LITERAL_NAME(type);
  name = vphp_normalize_literal_type_name(literal_name);
  ce = vphp_type_scope_ce(execute_data, ZSTR_VAL(name));
  if (ce != NULL) {
    zend_string_release(name);
    return ce;
  }
  if (execute_data && execute_data->func && execute_data->func->common.scope &&
      strcmp(ZSTR_VAL(execute_data->func->common.scope->name), ZSTR_VAL(name)) ==
          0) {
    zend_string_release(name);
    return execute_data->func->common.scope;
  }
  ce = vphp_zend_lookup_class(name);
  zend_string_release(name);
  return ce;
}

static bool vphp_value_matches_named_type(zend_execute_data *execute_data,
                                          zend_type type, zval *value,
                                          bool is_return_type) {
  zval *check = value;
  zend_class_entry *ce = NULL;
  zend_string *expected_name = NULL;
  bool release_expected_name = false;

  if (check == NULL) {
    return false;
  }
  ZVAL_DEREF(check);
  if (Z_TYPE_P(check) != IS_OBJECT) {
    return false;
  }
  vphp_preload_auto_interfaces_for_class(Z_OBJCE_P(check));
  vphp_apply_auto_interface_bindings_for_class(Z_OBJCE_P(check));

  if (ZEND_TYPE_HAS_NAME(type)) {
    expected_name = ZEND_TYPE_NAME(type);
  } else if (ZEND_TYPE_HAS_LITERAL_NAME(type)) {
    expected_name = vphp_normalize_literal_type_name(ZEND_TYPE_LITERAL_NAME(type));
    release_expected_name = true;
  }
  if (expected_name != NULL &&
      zend_string_equals_ci(Z_OBJCE_P(check)->name, expected_name)) {
    if (release_expected_name) {
      zend_string_release(expected_name);
    }
    return true;
  }

  ce = vphp_lookup_type_ce(execute_data, type);
  if (ce == NULL) {
    bool unresolved_match = vphp_class_has_auto_interface_binding(
        Z_OBJCE_P(check), expected_name);
    if (release_expected_name) {
      zend_string_release(expected_name);
    }
    return unresolved_match;
  }
  vphp_preload_auto_interfaces_for_class(Z_OBJCE_P(check));
  vphp_apply_auto_interface_bindings_for_class(Z_OBJCE_P(check));
  if ((ce->ce_flags & ZEND_ACC_INTERFACE) &&
      vphp_zend_class_implements_interface(Z_OBJCE_P(check), ce)) {
    if (release_expected_name) {
      zend_string_release(expected_name);
    }
    return true;
  }
  if (instanceof_function(Z_OBJCE_P(check), ce) != 0) {
    if (release_expected_name) {
      zend_string_release(expected_name);
    }
    return true;
  }
  if (expected_name != NULL) {
    zval retval;
    zval expected_zv;
    zval *params[2] = {check, &expected_zv};
    int result = 0;

    ZVAL_UNDEF(&retval);
    ZVAL_STR_COPY(&expected_zv, expected_name);
    result = vphp_call_php_func("is_a", 4, &retval, 2, params);
    zval_ptr_dtor(&expected_zv);
    if (result == SUCCESS) {
      bool matched = vphp_zend_is_true(&retval);
      zval_ptr_dtor(&retval);
      if (matched) {
        if (release_expected_name) {
          zend_string_release(expected_name);
        }
        return true;
      }
    }
  }
  if (release_expected_name) {
    zend_string_release(expected_name);
  }
  return false;
}

static bool vphp_value_matches_mask(uint32_t mask, zval *value, bool strict,
                                    bool is_return_type, bool can_coerce) {
  zval *check = value;
  uint32_t scalar_mask = 0;

  if (check == NULL) {
    return false;
  }
  ZVAL_DEREF(check);

  if ((mask & MAY_BE_ANY) == MAY_BE_ANY) {
    return true;
  }
  if ((mask & MAY_BE_TRUE) && Z_TYPE_P(check) == IS_TRUE) {
    return true;
  }
  if ((mask & MAY_BE_FALSE) && Z_TYPE_P(check) == IS_FALSE) {
    return true;
  }
  if ((mask & MAY_BE_STRING) && Z_TYPE_P(check) == IS_STRING) {
    return true;
  }
  if ((mask & MAY_BE_LONG) && Z_TYPE_P(check) == IS_LONG) {
    return true;
  }
  if ((mask & MAY_BE_DOUBLE) && Z_TYPE_P(check) == IS_DOUBLE) {
    return true;
  }
  if ((mask & MAY_BE_BOOL) == MAY_BE_BOOL &&
      (Z_TYPE_P(check) == IS_TRUE || Z_TYPE_P(check) == IS_FALSE)) {
    return true;
  }
  if ((mask & MAY_BE_ARRAY) && Z_TYPE_P(check) == IS_ARRAY) {
    return true;
  }
  if ((mask & MAY_BE_OBJECT) && Z_TYPE_P(check) == IS_OBJECT) {
    return true;
  }
  if ((mask & MAY_BE_RESOURCE) && Z_TYPE_P(check) == IS_RESOURCE) {
    return true;
  }
  if ((mask & MAY_BE_CALLABLE) && vphp_zend_is_callable(check)) {
    return true;
  }
  if ((mask & MAY_BE_VOID) && is_return_type && Z_TYPE_P(check) == IS_NULL) {
    return true;
  }

  if ((mask & MAY_BE_BOOL) == MAY_BE_BOOL) {
    scalar_mask |= MAY_BE_BOOL;
  }
  scalar_mask |= mask & (MAY_BE_LONG | MAY_BE_DOUBLE | MAY_BE_STRING);
  if (can_coerce && scalar_mask != 0 &&
      vphp_zend_verify_scalar_type_hint(scalar_mask, check, strict)) {
    return true;
  }

  return false;
}

static bool vphp_value_matches_type(zend_execute_data *execute_data,
                                    zend_type type, zval *value,
                                    bool is_return_type) {
  zval *check = value;
  uint32_t mask = ZEND_TYPE_PURE_MASK(type);
  bool strict = execute_data && execute_data->prev_execute_data
                    ? ZEND_CALL_USES_STRICT_TYPES(execute_data->prev_execute_data)
                    : false;

  if (!ZEND_TYPE_IS_SET(type)) {
    return true;
  }
  if (check == NULL) {
    return false;
  }
  zend_reference *typed_ref =
      Z_ISREF_P(check) && ZEND_REF_HAS_TYPE_SOURCES(Z_REF_P(check))
          ? Z_REF_P(check) : NULL;
  ZVAL_DEREF(check);

  if (Z_TYPE_P(check) == IS_NULL) {
    return ZEND_TYPE_ALLOW_NULL(type) || (mask & MAY_BE_NULL) != 0;
  }

  if (ZEND_TYPE_HAS_LIST(type)) {
    const zend_type *subtype = NULL;

    if (ZEND_TYPE_IS_INTERSECTION(type)) {
      ZEND_TYPE_LIST_FOREACH(ZEND_TYPE_LIST(type), subtype) {
        if (!vphp_value_matches_type(execute_data, *subtype, value,
                                     is_return_type)) {
          return false;
        }
      }
      ZEND_TYPE_LIST_FOREACH_END();
      return true;
    }

    ZEND_TYPE_LIST_FOREACH(ZEND_TYPE_LIST(type), subtype) {
      if (vphp_value_matches_type(execute_data, *subtype, value,
                                  is_return_type)) {
        return true;
      }
    }
    ZEND_TYPE_LIST_FOREACH_END();
    // Zend stores the scalar members of a union in the outer mask.
  }

  if (ZEND_TYPE_IS_ITERABLE_FALLBACK(type) && vphp_zend_is_iterable(check)) {
    return true;
  }
  if (ZEND_TYPE_HAS_NAME(type) || ZEND_TYPE_HAS_LITERAL_NAME(type)) {
    if (vphp_value_matches_named_type(execute_data, type, check, is_return_type)) {
      return true;
    }
  }
  if (vphp_value_matches_mask(mask, check, strict, is_return_type,
                               !is_return_type && typed_ref == NULL)) {
    return true;
  }
  if (is_return_type) {
    // Zend's user-function fallback can coerce scalar returns. An internal
    // function has to return a value that already satisfies its arginfo.
    if ((mask & MAY_BE_STATIC) && Z_TYPE_P(check) == IS_OBJECT) {
      zend_class_entry *called_scope = vphp_type_scope_ce(execute_data, "static");
      return called_scope && instanceof_function(Z_OBJCE_P(check), called_scope);
    }
    return false;
  }
  // Named types and lists were checked above. The Zend user-function
  // fallback requires a VM cache slot for class types on PHP 8.2–8.4.
  return !ZEND_TYPE_IS_COMPLEX(type) &&
      vphp_zend_check_user_type_slow(&type, check, typed_ref, false);
}

zend_type vphp_arginfo_class_type(const char *name) {
  zend_string *class_name = zend_string_init_interned(name, strlen(name), 1);
  zend_alloc_ce_cache(class_name);
  return (zend_type) ZEND_TYPE_INIT_CLASS(class_name, 0, 0);
}

zend_type vphp_arginfo_type_list(const zend_type *members, uint32_t count,
                                 uint32_t flags) {
  // Zend owns the persistent list once it registers the type.
  zend_type_list *list = pemalloc(ZEND_TYPE_LIST_SIZE(count), 1);
  list->num_types = count;
  memcpy(list->types, members, count * sizeof(zend_type));
  return (zend_type) ZEND_TYPE_INIT_PTR_MASK(list, _ZEND_TYPE_LIST_BIT | flags);
}

#if PHP_VERSION_ID < 80300
static bool vphp_has_sensitive_variadic_args(const zend_function *func) {
  return (func->common.fn_flags & ZEND_ACC_VARIADIC) &&
      zend_get_parameter_attribute_str(func->common.attributes,
          ZEND_STRL("sensitiveparameter"), func->common.num_args) != NULL;
}

// PHP 8.2 copies extra named arguments into traces without checking the
// variadic parameter attribute. Put the native redaction objects in this frame.
static void vphp_redact_sensitive_named_args(zend_execute_data *execute_data) {
  HashTable *args = execute_data->extra_named_params;
  if (GC_REFCOUNT(args) > 1) {
    execute_data->extra_named_params = zend_array_dup(args);
    zend_array_release(args);
    args = execute_data->extra_named_params;
  }

  zval *value;
  ZEND_HASH_FOREACH_VAL(args, value) {
    zval original, redacted;
    ZVAL_COPY_DEREF(&original, value);
    object_init_ex(&redacted, zend_ce_sensitive_parameter_value);
    zend_call_known_instance_method_with_1_params(
        zend_ce_sensitive_parameter_value->constructor, Z_OBJ(redacted), NULL,
        &original);
    zval_ptr_dtor(&original);
    zval_ptr_dtor(value);
    ZVAL_COPY_VALUE(value, &redacted);
  } ZEND_HASH_FOREACH_END();
}
#endif

bool vphp_validate_internal_call(zend_execute_data *execute_data) {
  const zend_function *func = execute_data ? execute_data->func : NULL;
  uint32_t arg_count = 0;
  uint32_t min_args = 0;
  uint32_t max_args = 0;
  bool variadic = false;
  uint32_t i = 0;

  if (func == NULL) {
    return true;
  }

#if PHP_VERSION_ID < 80300
  if ((ZEND_CALL_INFO(execute_data) & ZEND_CALL_HAS_EXTRA_NAMED_PARAMS) &&
      vphp_has_sensitive_variadic_args(func)) {
    vphp_redact_sensitive_named_args(execute_data);
  }
#endif

#if PHP_VERSION_ID >= 80300
  if (func->common.scope && !func->common.prototype && func->common.attributes &&
#if PHP_VERSION_ID >= 80400
      !func->common.prop_info &&
#endif
      zend_get_attribute_str(func->common.attributes, ZEND_STRL("override")) &&
      !vphp_validate_method_override(func, false)) {
    return false;
  }
#endif

  arg_count = ZEND_CALL_NUM_ARGS(execute_data);
  min_args = func->common.required_num_args;
  max_args = func->common.num_args;
  variadic = (func->common.fn_flags & ZEND_ACC_VARIADIC) != 0;

  if (variadic && (ZEND_CALL_INFO(execute_data) & ZEND_CALL_HAS_EXTRA_NAMED_PARAMS) &&
      ARG_MUST_BE_SENT_BY_REF(func, max_args + 1)) {
    zend_unexpected_extra_named_error();
    return false;
  }

  if (arg_count < min_args || (!variadic && arg_count > max_args)) {
    vphp_zend_wrong_parameters_count_error(min_args,
                                           variadic ? (uint32_t)-1 : max_args);
    return false;
  }

  // Convert named gaps identified by our metadata back to omitted V fields.
  if (func->type == ZEND_INTERNAL_FUNCTION) {
    vphp_mark_omitted_computed_defaults(execute_data);
  }

  for (i = 0; i < arg_count; i++) {
    zend_arg_info *arg_info = NULL;
    zval *arg = NULL;

    if (func->common.arg_info == NULL) {
      break;
    }

    if (i >= max_args && !variadic) {
      break;
    }
    // Zend keeps the variadic entry immediately after the fixed parameters.
    arg_info = &func->common.arg_info[i < max_args ? i : max_args];

    if (!ZEND_TYPE_IS_SET(arg_info->type)) {
      continue;
    }
    arg = ZEND_CALL_ARG(execute_data, i + 1);
    if (Z_ISUNDEF_P(arg) || vphp_value_matches_type(execute_data, arg_info->type, arg, false)) {
      continue;
    }

    vphp_zend_verify_arg_error(func, arg_info, i + 1, arg);
    return false;
  }

  return true;
}

bool vphp_check_closure_scalar_argument(zend_execute_data *execute_data,
                                        uint32_t index) {
  const zend_function *func = execute_data ? execute_data->func : NULL;
  if (!func || !func->common.arg_info || index >= ZEND_CALL_NUM_ARGS(execute_data)) {
    return true;
  }
  uint32_t fixed = func->common.num_args;
  if (index >= fixed && !(func->common.fn_flags & ZEND_ACC_VARIADIC)) {
    return true;
  }
  zend_type type = func->common.arg_info[index < fixed ? index : fixed].type;
  const uint32_t scalars = MAY_BE_BOOL | MAY_BE_LONG | MAY_BE_DOUBLE | MAY_BE_STRING;
  uint32_t mask = ZEND_TYPE_PURE_MASK(type);
  if (ZEND_TYPE_IS_COMPLEX(type) || (mask & scalars) == 0 ||
      (mask & ~(scalars | MAY_BE_NULL)) != 0) {
    return true;
  }
  zval *arg = ZEND_CALL_ARG(execute_data, index + 1);
  return vphp_value_matches_type(execute_data, type, arg, false);
}

bool vphp_read_named_variadic_args(zend_execute_data *execute_data, void *ctx,
                                  vphp_named_variadic_cb append) {
  if (!(ZEND_CALL_INFO(execute_data) & ZEND_CALL_HAS_EXTRA_NAMED_PARAMS)) {
    return true;
  }
  if (!append) {
    zend_unexpected_extra_named_error();
    return false;
  }

  const zend_function *func = execute_data->func;
  uint32_t fixed = func->common.num_args;
  uint32_t count = ZEND_CALL_NUM_ARGS(execute_data);
  uint32_t index = count > fixed ? count : fixed;
  const zend_arg_info *info = &func->common.arg_info[fixed];
#if PHP_VERSION_ID < 80300
  const bool sensitive = vphp_has_sensitive_variadic_args(func);
#endif
  zend_string *key;
  zval *value;
  ZEND_HASH_FOREACH_STR_KEY_VAL(execute_data->extra_named_params, key, value) {
    zval *argument = value;
#if PHP_VERSION_ID < 80300
    zval rv;
    if (sensitive) {
      argument = vphp_zend_read_property(zend_ce_sensitive_parameter_value,
          Z_OBJ_P(value), ZEND_STRL("value"), true, &rv);
    }
#endif
    if (ZEND_TYPE_IS_SET(info->type) &&
        !vphp_value_matches_type(execute_data, info->type, argument, false)) {
      vphp_zend_verify_arg_error(func, info, index + 1, argument);
      return false;
    }
    append(ctx, index++, ZSTR_VAL(key), (int)ZSTR_LEN(key), argument);
  } ZEND_HASH_FOREACH_END();
  return !EG(exception);
}

bool vphp_validate_internal_return(zend_execute_data *execute_data,
                                   zval *return_value) {
  const zend_function *func = execute_data ? execute_data->func : NULL;
  zend_arg_info *ret_info = NULL;
  zval *check = return_value;

  if (func == NULL || func->common.arg_info == NULL) {
    return true;
  }

  if (!EG(exception) && (func->common.fn_flags & ZEND_ACC_RETURN_REFERENCE) &&
      (!return_value || !Z_ISREF_P(return_value))) {
    if (func->common.scope) {
      const char *kind = "";
#if PHP_VERSION_ID >= 80400
      if (func->common.prop_info) {
        kind = "Property hook ";
      }
#endif
      zend_throw_error(NULL, "%s%s::%s() must return a reference", kind,
                       ZSTR_VAL(func->common.scope->name), ZSTR_VAL(func->common.function_name));
    } else {
      zend_throw_error(NULL, "%s() must return a reference", ZSTR_VAL(func->common.function_name));
    }
    return false;
  }
#if PHP_VERSION_ID >= 80600
  if (!EG(exception) && (func->common.fn_flags & ZEND_ACC_RETURN_REFERENCE)) {
    zend_return_unwrap_ref(execute_data, return_value);
  }
#endif
  ret_info = func->common.arg_info - 1;
  if (!ZEND_TYPE_IS_SET(ret_info->type)) {
    return true;
  }
  if (EG(exception)) {
    return false;
  }
  if (check != NULL) {
    ZVAL_DEREF(check);
  }
  if (ZEND_TYPE_CONTAINS_CODE(ret_info->type, IS_VOID)) {
    if (check != NULL && Z_TYPE_P(check) == IS_UNDEF) {
      // Keep UNDEF for validation, then return a value Zend can invoke indirectly.
      ZVAL_NULL(return_value);
      return true;
    }
    vphp_zend_verify_return_error(func, return_value);
    return false;
  }
  if (ZEND_TYPE_CONTAINS_CODE(ret_info->type, IS_NEVER)) {
    vphp_zend_verify_never_error(func);
    return false;
  }
  if (vphp_value_matches_type(execute_data, ret_info->type, return_value,
                              true)) {
    return true;
  }

  vphp_zend_verify_return_error(func, return_value);
  return false;
}

static void vphp_require_method_reference(const zend_function *contract,
                                           zend_string *class_name) {
  zend_error_noreturn(E_CORE_ERROR, "%s::%s() must return by reference like %s::%s()",
      ZSTR_VAL(class_name), ZSTR_VAL(contract->common.function_name),
      ZSTR_VAL(contract->common.scope->name), ZSTR_VAL(contract->common.function_name));
}

void vphp_verify_parent_reference_methods(const zend_class_entry *ce,
                                          const zend_class_entry *parent) {
  for (const zend_function_entry *entry = ce->info.internal.builtin_functions;
       entry && entry->fname; entry++) {
    if ((entry->flags & ZEND_ACC_RETURN_REFERENCE) ||
        (entry->arg_info && ZEND_ARG_SEND_MODE(entry->arg_info))) {
      continue;
    }
    const zend_function *inherited =
        zend_hash_str_find_ptr_lc(&parent->function_table, entry->fname, strlen(entry->fname));
    if (inherited &&
        (inherited->common.fn_flags & ZEND_ACC_RETURN_REFERENCE) &&
        ((inherited->common.fn_flags & ZEND_ACC_ABSTRACT) ||
         !(inherited->common.fn_flags & (ZEND_ACC_PRIVATE | ZEND_ACC_CTOR)))) {
      vphp_require_method_reference(inherited, ce->name);
    }
  }
}

void vphp_verify_interface_reference_methods(const zend_class_entry *ce,
                                             const zend_class_entry *iface) {
  zend_string *name;
  const zend_function *required;
  ZEND_HASH_MAP_FOREACH_STR_KEY_PTR(&iface->function_table, name, required) {
    if (!(required->common.fn_flags & ZEND_ACC_RETURN_REFERENCE)) {
      continue;
    }
    const zend_function *own = zend_hash_find_ptr(&ce->function_table, name);
    if (own && !(own->common.fn_flags & ZEND_ACC_RETURN_REFERENCE)) {
      vphp_require_method_reference(required, ce->name);
    }
  } ZEND_HASH_FOREACH_END();
}

void vphp_mark_void_return(zval *return_value) {
  if (return_value == NULL) {
    return;
  }
  ZVAL_UNDEF(return_value);
}

uint32_t vphp_get_num_args(zend_execute_data *ex) {
  return ZEND_CALL_NUM_ARGS(ex);
}

zval *vphp_get_arg_ptr(zend_execute_data *ex, uint32_t index) {
  return ZEND_CALL_ARG(ex, index);
}

bool vphp_read_arg_default(zend_execute_data *ex, uint32_t index,
                           zval *result) {
  const zend_function *func = ex->func;
  zval value;
  ZVAL_UNDEF(&value);

  // Use the same arginfo and constant-expression evaluation as named gaps.
  if (func->type != ZEND_INTERNAL_FUNCTION ||
      (func->common.fn_flags & ZEND_ACC_USER_ARG_INFO) ||
      index >= func->common.num_args || !func->internal_function.arg_info ||
      zend_get_default_from_internal_arg_info(
          &value, &func->internal_function.arg_info[index]) == FAILURE) {
    if (!EG(exception)) {
      zend_argument_error(zend_ce_argument_count_error, index + 1,
                          "must be passed explicitly, because the default value is not known");
    }
    zval_ptr_dtor(&value);
    return false;
  }
  if (Z_TYPE(value) == IS_CONSTANT_AST &&
      zval_update_constant_ex(&value, func->common.scope) == FAILURE) {
    zval_ptr_dtor(&value);
    return false;
  }
  const zend_arg_info *arg_info = &func->common.arg_info[index];
  if (ZEND_TYPE_IS_SET(arg_info->type) &&
      !vphp_value_matches_type(ex, arg_info->type, &value, false)) {
    vphp_zend_verify_arg_error(func, arg_info, index + 1, &value);
    zval_ptr_dtor(&value);
    return false;
  }
  zval_ptr_dtor(result);
  ZVAL_COPY_VALUE(result, &value);
  return true;
}

void vphp_throw(char *msg, int code) {
  vphp_zend_throw_exception(NULL, msg, (zend_long)code);
}

void vphp_throw_class(char *class_name, char *msg, int code) {
  zend_class_entry *ce = NULL;
  zend_string *cls = NULL;
  if (class_name != NULL) {
    cls = zend_string_init(class_name, strlen(class_name), 0);
    ce = vphp_autoload_class(cls);
    if (ce != NULL) {
      vphp_preload_auto_interfaces_for_class(ce);
    }
    zend_string_release(cls);
  }
  vphp_zend_throw_exception(ce, msg, (zend_long)code);
}

void vphp_throw_object(zval *exception) {
  zval copy;
  if (exception == NULL || Z_TYPE_P(exception) != IS_OBJECT) {
    vphp_zend_throw_exception(NULL, "exception object must be a valid object", 0);
    return;
  }
  ZVAL_COPY(&copy, exception);
  vphp_zend_throw_exception_object(&copy);
}

void vphp_error(int level, char *msg) { php_error(level, "%s", msg); }

void vphp_output_write(const char *msg, int len) {
  if (msg == NULL || len <= 0) {
    return;
  }
  PHPWRITE(msg, len);
}

bool vphp_has_exception() { return EG(exception) != NULL; }

int vphp_exception_message(char *buffer, int buffer_len) {
  if (buffer == NULL || buffer_len <= 0) {
    return 0;
  }
  buffer[0] = '\0';
  if (EG(exception) == NULL) {
    return 0;
  }

  zval rv;
  zval *message = vphp_zend_read_property(EG(exception)->ce, EG(exception),
                                          "message", sizeof("message") - 1,
                                          true, &rv);
  if (message == NULL || Z_TYPE_P(message) == IS_UNDEF || Z_TYPE_P(message) == IS_NULL) {
    return 0;
  }

  zval copy;
  ZVAL_COPY(&copy, message);
  convert_to_string(&copy);
  int written = snprintf(buffer, (size_t)buffer_len, "%s", Z_STRVAL(copy));
  zval_ptr_dtor(&copy);
  if (written < 0) {
    buffer[0] = '\0';
    return 0;
  }
  return written >= buffer_len ? buffer_len - 1 : written;
}

void vphp_clear_exception() {
  if (EG(exception) != NULL) {
    vphp_zend_clear_exception();
  }
}

bool vphp_take_exception(zval *result) {
  zend_object *exception = EG(exception);
  if (!exception || !instanceof_function(exception->ce, zend_ce_throwable)) {
    return false;
  }
  ZVAL_OBJ_COPY(result, exception);
  vphp_zend_clear_exception();
  return true;
}

static zend_object *vphp_previous_exception(zend_object *exception) {
  zval rv;
  zval *previous = vphp_zend_read_property(zend_get_exception_base(exception),
      exception, "previous", sizeof("previous") - 1, true, &rv);
  return previous && Z_TYPE_P(previous) == IS_OBJECT ? Z_OBJ_P(previous) : NULL;
}

static bool vphp_add_exception_chain(HashTable *visited, zend_object *exception) {
  for (; exception; exception = vphp_previous_exception(exception)) {
    if (!zend_hash_index_add_empty_element(visited, exception->handle)) {
      return false;
    }
  }
  return true;
}

void vphp_append_exception(zval *primary, zval *previous) {
  zend_object *head = Z_OBJ_P(primary);
  zend_object *tail = Z_OBJ_P(previous);
  HashTable visited;
  zend_hash_init(&visited, 4, NULL, NULL, 0);
  bool disjoint = vphp_add_exception_chain(&visited, head)
      && vphp_add_exception_chain(&visited, tail);
  zend_hash_destroy(&visited);
  if (!disjoint) {
    return;
  }
  GC_ADDREF(tail);
  zend_exception_set_previous(head, tail);
}

uintptr_t vphp_current_fiber_id(void) {
  zend_fiber_context *fiber = EG(current_fiber_context);
  return fiber == EG(main_fiber_context) ? 0 : (uintptr_t)fiber;
}

static vphp_autorelease_pool_t *vphp_current_autorelease_pool(bool create) {
  zend_fiber_context *fiber = (zend_fiber_context *)vphp_current_fiber_id();
  if (fiber == NULL) {
    return &vphp_autorelease_pool;
  }
  for (vphp_fiber_autorelease_pool *item = vphp_fiber_autorelease_pools;
       item != NULL; item = item->next) {
    if (item->fiber == fiber) {
      return &item->pool;
    }
  }
  if (!create) {
    return NULL;
  }
  vphp_fiber_autorelease_pool *item = pecalloc(1, sizeof(*item), 1);
  item->fiber = fiber;
  item->next = vphp_fiber_autorelease_pools;
  vphp_fiber_autorelease_pools = item;
  return &item->pool;
}

int vphp_autorelease_mark(void) {
  vphp_autorelease_pool_t *pool = vphp_current_autorelease_pool(false);
  return pool == NULL ? 0 : pool->len;
}

static void vphp_runtime_debug_log_pools(const char *phase) {
  char debug_buf[256];
  snprintf(debug_buf, sizeof(debug_buf),
           "request_shutdown %s owned_len=%d autorelease_len=%d registry=%u reverse=%u sidecar=%u",
           phase, vphp_owned_pool.len, vphp_autorelease_mark(),
           vphp_registry_initialized
               ? zend_hash_num_elements(&vphp_object_registry)
               : 0,
           vphp_registry_initialized
               ? zend_hash_num_elements(&vphp_reverse_registry)
               : 0,
           vphp_sidecar_registry_initialized
               ? zend_hash_num_elements(&vphp_sidecar_registry)
               : 0);
  vphp_bridge_debug_log("vphp-runtime-debug", debug_buf);
}

static void vphp_runtime_debug_dump_owned_pool(const char *phase, int limit) {
  char debug_buf[512];
  int emitted = 0;
  for (int i = vphp_owned_pool.len - 1; i >= 0; i--) {
    zval *z = vphp_owned_pool.items[i];
    const char *origin = "(unknown)";
    uint32_t refcount = 0;
    if (z == NULL) {
      continue;
    }
    if (vphp_owned_pool.origins != NULL && vphp_owned_pool.origins[i] != NULL) {
      origin = vphp_owned_pool.origins[i];
    }
    if (Z_REFCOUNTED_P(z)) {
      refcount = GC_REFCOUNT(Z_COUNTED_P(z));
    }
    if (Z_TYPE_P(z) == IS_STRING) {
      size_t src_len = Z_STRLEN_P(z);
      size_t copy_len = src_len < 96 ? src_len : 96;
      char snippet[97];
      memset(snippet, 0, sizeof(snippet));
      if (copy_len > 0) {
        memcpy(snippet, Z_STRVAL_P(z), copy_len);
      }
      snprintf(debug_buf, sizeof(debug_buf),
               "owned_pool %s idx=%d z=%p type=%d class=%s refcount=%u origin=%s strlen=%zu str=\"%s%s\"",
               phase, i, (void *)z, Z_TYPE_P(z),
               vphp_debug_zval_class_name(z), refcount, origin, src_len,
               snippet, src_len > copy_len ? "..." : "");
    } else if (Z_TYPE_P(z) == IS_ARRAY) {
      zend_array *arr = Z_ARRVAL_P(z);
      zend_ulong idx_key = 0;
      zend_string *str_key = NULL;
      zval *item = NULL;
      char keys[160];
      size_t used = 0;
      int key_count = 0;
      memset(keys, 0, sizeof(keys));
      ZEND_HASH_FOREACH_KEY_VAL(arr, idx_key, str_key, item) {
        char piece[48];
        (void)item;
        if (key_count >= 4 || used >= sizeof(keys) - 1) {
          break;
        }
        if (str_key != NULL) {
          snprintf(piece, sizeof(piece), "%s%.*s", key_count == 0 ? "" : ",",
                   24, ZSTR_VAL(str_key));
        } else {
          snprintf(piece, sizeof(piece), "%s%lu", key_count == 0 ? "" : ",",
                   (unsigned long)idx_key);
        }
        size_t piece_len = strlen(piece);
        if (piece_len == 0 || used + piece_len >= sizeof(keys) - 1) {
          break;
        }
        memcpy(keys + used, piece, piece_len);
        used += piece_len;
        keys[used] = '\0';
        key_count++;
      }
      ZEND_HASH_FOREACH_END();
      snprintf(debug_buf, sizeof(debug_buf),
               "owned_pool %s idx=%d z=%p type=%d class=%s refcount=%u origin=%s array_count=%u keys=%s",
               phase, i, (void *)z, Z_TYPE_P(z),
               vphp_debug_zval_class_name(z), refcount, origin,
               (unsigned)zend_hash_num_elements(arr),
               used > 0 ? keys : "(none)");
    } else if (Z_TYPE_P(z) == IS_LONG) {
      snprintf(debug_buf, sizeof(debug_buf),
               "owned_pool %s idx=%d z=%p type=%d class=%s refcount=%u origin=%s long=%lld",
               phase, i, (void *)z, Z_TYPE_P(z),
               vphp_debug_zval_class_name(z), refcount, origin,
               (long long)Z_LVAL_P(z));
    } else {
      snprintf(debug_buf, sizeof(debug_buf),
               "owned_pool %s idx=%d z=%p type=%d class=%s refcount=%u origin=%s",
               phase, i, (void *)z, Z_TYPE_P(z),
               vphp_debug_zval_class_name(z), refcount, origin);
    }
    vphp_bridge_debug_log("vphp-runtime-debug",debug_buf);
    emitted++;
    if (limit > 0 && emitted >= limit) {
      break;
    }
  }
}

static void vphp_runtime_debug_dump_autorelease_range(
    const vphp_autorelease_pool_t *pool, const char *phase, int mark, int limit) {
  char debug_buf[512];
  int emitted = 0;
  if (mark < 0) {
    mark = 0;
  }
  for (int i = pool->len - 1; i >= mark; i--) {
    zval *z = pool->items[i];
    uint32_t refcount = 0;
    if (z == NULL) {
      continue;
    }
    if (Z_REFCOUNTED_P(z)) {
      refcount = GC_REFCOUNT(Z_COUNTED_P(z));
    }
    snprintf(debug_buf, sizeof(debug_buf),
             "autorelease_pool %s idx=%d z=%p type=%d class=%s refcount=%u",
             phase, i, (void *)z, Z_TYPE_P(z),
             vphp_debug_zval_class_name(z), refcount);
    vphp_bridge_debug_log("vphp-runtime-debug",debug_buf);
    emitted++;
    if (limit > 0 && emitted >= limit) {
      break;
    }
  }
}

static bool vphp_owned_contains(zval *z) {
  if (z == NULL) {
    return false;
  }
  for (int i = vphp_owned_pool.len - 1; i >= 0; i--) {
    if (vphp_owned_pool.items[i] == z) {
      return true;
    }
  }
  return false;
}

static void vphp_owned_add(zval *z, char *origin) {
  if (z == NULL || vphp_owned_contains(z)) {
    if (origin != NULL) {
      efree(origin);
    }
    return;
  }
  if (vphp_owned_pool.len >= vphp_owned_pool.cap) {
    int new_cap = vphp_owned_pool.cap == 0 ? 64 : vphp_owned_pool.cap * 2;
    size_t bytes = (size_t)new_cap * sizeof(zval *);
    size_t origin_bytes = (size_t)new_cap * sizeof(char *);
    int old_cap = vphp_owned_pool.cap;
    if (vphp_owned_pool.items == NULL) {
      vphp_owned_pool.items = (zval **)pemalloc(bytes, 1);
    } else {
      vphp_owned_pool.items =
          (zval **)perealloc(vphp_owned_pool.items, bytes, 1);
    }
    if (vphp_owned_pool.origins == NULL) {
      vphp_owned_pool.origins = (char **)pemalloc(origin_bytes, 1);
      if (vphp_owned_pool.origins != NULL) {
        memset(vphp_owned_pool.origins, 0, origin_bytes);
      }
    } else {
      vphp_owned_pool.origins =
          (char **)perealloc(vphp_owned_pool.origins, origin_bytes, 1);
      if (vphp_owned_pool.origins != NULL && new_cap > old_cap) {
        memset(vphp_owned_pool.origins + old_cap, 0,
               (size_t)(new_cap - old_cap) * sizeof(char *));
      }
    }
    if (vphp_owned_pool.items == NULL) {
      vphp_owned_pool.cap = 0;
      vphp_owned_pool.len = 0;
      if (origin != NULL) {
        efree(origin);
      }
      return;
    }
    vphp_owned_pool.cap = new_cap;
  }
  vphp_owned_pool.items[vphp_owned_pool.len] = z;
  if (vphp_owned_pool.origins != NULL) {
    vphp_owned_pool.origins[vphp_owned_pool.len] = origin;
  } else if (origin != NULL) {
    efree(origin);
  }
  vphp_owned_pool.len++;
}

static bool vphp_owned_remove_ex(zval *z, int persistent) {
  if (z == NULL || vphp_owned_pool.len == 0) {
    return false;
  }
  for (int i = vphp_owned_pool.len - 1; i >= 0; i--) {
    if (vphp_owned_pool.items[i] == z) {
      if (vphp_owned_pool.origins != NULL && vphp_owned_pool.origins[i] != NULL) {
        if (persistent) {
          pefree(vphp_owned_pool.origins[i], 1);
        } else {
          efree(vphp_owned_pool.origins[i]);
        }
      }
      vphp_owned_pool.items[i] = vphp_owned_pool.items[vphp_owned_pool.len - 1];
      if (vphp_owned_pool.origins != NULL) {
        vphp_owned_pool.origins[i] =
            vphp_owned_pool.origins[vphp_owned_pool.len - 1];
        vphp_owned_pool.origins[vphp_owned_pool.len - 1] = NULL;
      }
      vphp_owned_pool.items[vphp_owned_pool.len - 1] = NULL;
      vphp_owned_pool.len--;
      return true;
    }
  }
  return false;
}

static bool vphp_owned_remove(zval *z) {
  return vphp_owned_remove_ex(z, 0);
}

static zval **vphp_find_autorelease_slot(vphp_autorelease_pool_t *pool, zval *z) {
  for (int i = pool->len - 1; i >= 0; i--) {
    if (pool->items[i] == z) {
      return &pool->items[i];
    }
  }
  return NULL;
}

static zval **vphp_autorelease_slot(zval *z) {
  zval **slot = vphp_find_autorelease_slot(&vphp_autorelease_pool, z);
  if (slot != NULL) {
    return slot;
  }
  for (vphp_fiber_autorelease_pool *item = vphp_fiber_autorelease_pools;
       item != NULL; item = item->next) {
    slot = vphp_find_autorelease_slot(&item->pool, z);
    if (slot != NULL) {
      return slot;
    }
  }
  return NULL;
}

void vphp_autorelease_add(zval *z) {
  if (z == NULL || !vphp_owned_contains(z) || vphp_autorelease_slot(z) != NULL) {
    return;
  }
  vphp_autorelease_pool_t *pool = vphp_current_autorelease_pool(true);
  if (pool->len >= pool->cap) {
    int cap = pool->cap == 0 ? 32 : pool->cap * 2;
    size_t bytes = (size_t)cap * sizeof(zval *);
    pool->items = pool->items == NULL ? pemalloc(bytes, 1)
                                     : perealloc(pool->items, bytes, 1);
    pool->cap = cap;
  }
  pool->items[pool->len++] = z;
}

void vphp_autorelease_forget(zval *z) {
  if (z != NULL) {
    zval **slot = vphp_autorelease_slot(z);
    if (slot != NULL) {
      *slot = NULL;
    }
  }
}

static void vphp_dtor_zval(zval *z) {
  zend_execute_data *frame = EG(current_execute_data);
  if (UNEXPECTED(EG(exception) && frame && frame->func &&
                 frame->func->type == ZEND_INTERNAL_FUNCTION)) {
    // An internal frame has no opcode. Generator cleanup may still inspect
    // this slot when it runs finally during an exception or Fiber unwind.
    frame->opline = NULL;
  }
  zval_ptr_dtor(z);
}

static void vphp_drain_autorelease_pool(vphp_autorelease_pool_t *pool, int mark) {
  if (pool == NULL || mark > pool->len) {
    return;
  }
  if (mark < 0) {
    mark = 0;
  }
  pool->drain_depth++;
  vphp_runtime_debug_log_pools("drain_enter");
  if (pool->drain_depth > 1) {
    char depth_msg[128];
    snprintf(depth_msg, sizeof(depth_msg),
             "vphp_autorelease_drain recursive_depth=%d mark=%d len=%d",
             pool->drain_depth, mark, pool->len);
    vphp_bridge_debug_log("vphp-runtime-debug", depth_msg);
  }
  if (vphp_bridge_debug_enabled() != 0 && pool->len > mark) {
    vphp_runtime_debug_dump_autorelease_range(pool, "before_drain", mark, 32);
  }
  while (pool->len > mark) {
    int index = --pool->len;
    zval *z = pool->items[index];
    pool->items[index] = NULL;
    // Pop before release: destructors may reenter PHP and open another scope.
    if (vphp_owned_remove(z)) {
      vphp_dtor_zval(z);
      efree(z);
    }
  }
  pool->drain_depth--;
  vphp_runtime_debug_log_pools("drain_exit");
}

void vphp_autorelease_drain(int mark) {
  vphp_drain_autorelease_pool(vphp_current_autorelease_pool(false), mark);
}

static void vphp_destroy_fiber_autorelease_pool(zend_fiber_context *fiber) {
  vphp_fiber_autorelease_pool **link = &vphp_fiber_autorelease_pools;
  while (*link != NULL && (*link)->fiber != fiber) {
    link = &(*link)->next;
  }
  if (*link == NULL) {
    return;
  }
  vphp_fiber_autorelease_pool *item = *link;
  vphp_drain_autorelease_pool(&item->pool, 0);
  // Destructors can switch fibers and change the list while the pool drains.
  link = &vphp_fiber_autorelease_pools;
  while (*link != item) {
    link = &(*link)->next;
  }
  *link = item->next;
  if (item->pool.items != NULL) {
    pefree(item->pool.items, 1);
  }
  pefree(item, 1);
}

static void vphp_fiber_stack_destroyed(zend_fiber_context *fiber) {
  vphp_release_task_fiber_pins(fiber);
  vphp_destroy_fiber_autorelease_pool(fiber);
  vphp_fiber_gc_destroy(fiber);
}

static void vphp_fiber_stack_switched(zend_fiber_context *from, zend_fiber_context *to) {
  vphp_fiber_gc_switch();
  vphp_switch_static_request(from, to);
}

void vphp_init_fiber_observers(void) {
  zend_observer_fiber_init_register(vphp_fiber_gc_init);
  zend_observer_fiber_destroy_register(vphp_fiber_stack_destroyed);
  zend_observer_fiber_switch_register(vphp_fiber_stack_switched);
}

void vphp_runtime_counters(int *autorelease_len, int *owned_len,
                           unsigned int *obj_registry_len,
                           unsigned int *rev_registry_len) {
  if (autorelease_len != NULL) {
    *autorelease_len = vphp_autorelease_mark();
  }
  if (owned_len != NULL) {
    *owned_len = vphp_owned_pool.len;
  }
  if (obj_registry_len != NULL) {
    *obj_registry_len = vphp_registry_initialized
                            ? zend_hash_num_elements(&vphp_object_registry)
                            : 0;
  }
  if (rev_registry_len != NULL) {
    *rev_registry_len = vphp_registry_initialized
                            ? zend_hash_num_elements(&vphp_reverse_registry)
                            : 0;
  }
}

void vphp_request_startup(void) {
  vphp_task_native_pins = NULL;
  vphp_fiber_gc_request_startup();
  vphp_clear_static_request();
  vphp_apply_registered_auto_interface_bindings(0);
  vphp_flush_pending_auto_interface_bindings();
  vphp_last_class_table_count = zend_hash_num_elements(CG(class_table));
}

void vphp_request_shutdown(void) {
  vphp_task_restore_fiber(NULL);
  vphp_task_swap_group(NULL);
  vphp_fiber_gc_request_shutdown();
  char debug_buf[256];
  vphp_runtime_debug_log_pools("enter");
  if (vphp_owned_pool.len > 0) {
    vphp_runtime_debug_dump_owned_pool("enter", 24);
  }
  vphp_autorelease_drain(0);
  while (vphp_fiber_autorelease_pools != NULL) {
    vphp_destroy_fiber_autorelease_pool(vphp_fiber_autorelease_pools->fiber);
  }
  vphp_runtime_debug_log_pools("after_autorelease_drain");
  if (vphp_owned_pool.len > 0) {
    vphp_runtime_debug_dump_owned_pool("after_autorelease_drain", 24);
  }
  vphp_last_class_table_count = 0;
  vphp_runtime_binding_applying = 0;
  vphp_runtime_internal_call_depth = 0;
  vphp_runtime_autoloading = 0;
  if (vphp_pending_auto_iface_bindings != NULL) {
    efree(vphp_pending_auto_iface_bindings);
    vphp_pending_auto_iface_bindings = NULL;
  }
  vphp_pending_auto_iface_bindings_len = 0;
  vphp_pending_auto_iface_bindings_cap = 0;
  vphp_runtime_debug_log_pools("before_sidecar_cleanup");
  if (vphp_sidecar_registry_initialized) {
    vphp_object_wrapper *binding = NULL;
    zend_ulong obj_key = 0;
    ZEND_HASH_FOREACH_NUM_KEY_PTR(&vphp_sidecar_registry, obj_key, binding) {
      if (binding == NULL) {
        snprintf(debug_buf, sizeof(debug_buf),
                 "request_shutdown sidecar skip_null obj=%p", (void *)obj_key);
        vphp_bridge_debug_log("vphp-runtime-debug",debug_buf);
        continue;
      }
      snprintf(debug_buf, sizeof(debug_buf),
               "request_shutdown sidecar binding obj=%p binding=%p v_ptr=%p owns=%d original_handlers=%p",
               (void *)obj_key, (void *)binding, binding->v_ptr,
               binding->owns_v_ptr, (void *)binding->original_handlers);
      vphp_bridge_debug_log("vphp-runtime-debug",debug_buf);
      if (vphp_registry_initialized) {
        zend_hash_index_del(&vphp_reverse_registry, obj_key);
        snprintf(debug_buf, sizeof(debug_buf),
                 "request_shutdown sidecar reverse_del obj=%p", (void *)obj_key);
        vphp_bridge_debug_log("vphp-runtime-debug",debug_buf);
      }
      if (binding->v_ptr != NULL && vphp_registry_initialized) {
        zend_hash_index_del(&vphp_object_registry, (zend_ulong)binding->v_ptr);
        snprintf(debug_buf, sizeof(debug_buf),
                 "request_shutdown sidecar object_del v_ptr=%p", binding->v_ptr);
        vphp_bridge_debug_log("vphp-runtime-debug",debug_buf);
      }
    }
    ZEND_HASH_FOREACH_END();
    vphp_bridge_debug_log("vphp-runtime-debug","request_shutdown sidecar clean begin");
    zend_hash_clean(&vphp_sidecar_registry);
    vphp_bridge_debug_log("vphp-runtime-debug","request_shutdown sidecar clean done");
  }
  if (vphp_registry_initialized) {
    vphp_bridge_debug_log("vphp-runtime-debug","request_shutdown object_registry clean begin");
    zend_hash_clean(&vphp_object_registry);
    vphp_bridge_debug_log("vphp-runtime-debug","request_shutdown object_registry clean done");
    vphp_bridge_debug_log("vphp-runtime-debug","request_shutdown reverse_registry clean begin");
    zend_hash_clean(&vphp_reverse_registry);
    vphp_bridge_debug_log("vphp-runtime-debug","request_shutdown reverse_registry clean done");
  }
  vphp_runtime_debug_log_pools("exit");
  if (vphp_owned_pool.len > 0) {
    vphp_runtime_debug_dump_owned_pool("exit", 24);
  }
  if (vphp_autorelease_pool.items != NULL) {
    pefree(vphp_autorelease_pool.items, 1);
    vphp_autorelease_pool.items = NULL;
  }
  vphp_autorelease_pool.cap = 0;
  vphp_autorelease_pool.len = 0;
  if (vphp_owned_pool.origins != NULL) {
    for (int i = 0; i < vphp_owned_pool.len; i++) {
      if (vphp_owned_pool.origins[i] != NULL) {
        efree(vphp_owned_pool.origins[i]);
      }
    }
    pefree(vphp_owned_pool.origins, 1);
    vphp_owned_pool.origins = NULL;
  }
  if (vphp_owned_pool.items != NULL) {
    pefree(vphp_owned_pool.items, 1);
    vphp_owned_pool.items = NULL;
  }
  vphp_owned_pool.cap = 0;
  vphp_owned_pool.len = 0;
  vphp_clear_static_request();
}

void vphp_autorelease_shutdown(void) {
  char debug_buf[256];
  vphp_bridge_debug_log("vphp-runtime-debug","autorelease_shutdown enter");
  if (vphp_autorelease_pool.items != NULL) {
    snprintf(debug_buf, sizeof(debug_buf),
             "autorelease_shutdown free autorelease_pool.items=%p cap=%d len=%d",
             (void *)vphp_autorelease_pool.items, vphp_autorelease_pool.cap,
             vphp_autorelease_pool.len);
    vphp_bridge_debug_log("vphp-runtime-debug",debug_buf);
    pefree(vphp_autorelease_pool.items, 1);
    vphp_autorelease_pool.items = NULL;
  }
  vphp_autorelease_pool.cap = 0;
  vphp_autorelease_pool.len = 0;
  if (vphp_owned_pool.items != NULL) {
    snprintf(debug_buf, sizeof(debug_buf),
             "autorelease_shutdown free owned_pool.items=%p cap=%d len=%d",
             (void *)vphp_owned_pool.items, vphp_owned_pool.cap,
             vphp_owned_pool.len);
    vphp_bridge_debug_log("vphp-runtime-debug",debug_buf);
    pefree(vphp_owned_pool.items, 1);
    vphp_owned_pool.items = NULL;
  }
  if (vphp_owned_pool.origins != NULL) {
    snprintf(debug_buf, sizeof(debug_buf),
             "autorelease_shutdown free owned_pool.origins=%p cap=%d len=%d",
             (void *)vphp_owned_pool.origins, vphp_owned_pool.cap,
             vphp_owned_pool.len);
    vphp_bridge_debug_log("vphp-runtime-debug",debug_buf);
    for (int i = 0; i < vphp_owned_pool.len; i++) {
      if (vphp_owned_pool.origins[i] != NULL) {
        efree(vphp_owned_pool.origins[i]);
      }
    }
    pefree(vphp_owned_pool.origins, 1);
    vphp_owned_pool.origins = NULL;
  }
  vphp_owned_pool.cap = 0;
  vphp_owned_pool.len = 0;
  vphp_bridge_debug_log("vphp-runtime-debug","autorelease_shutdown exit");
}

static zend_class_entry *vphp_lookup_class_by_name(const char *class_name,
                                                   int class_name_len) {
  zend_string *zs = zend_string_init(class_name, class_name_len, 0);
  zend_class_entry *ce = vphp_zend_lookup_class(zs);
  zend_string_release(zs);
  return ce;
}

static zend_class_entry *
vphp_find_loaded_class_no_autoload(const char *class_name, int class_name_len) {
  zend_string *name = zend_string_init(class_name, class_name_len, 0);
  zend_string *lower = zend_string_tolower(name);
  zend_class_entry *ce = zend_hash_find_ptr(CG(class_table), lower);
  zend_string_release(lower);
  zend_string_release(name);
  return ce;
}

zend_class_entry *vphp_find_loaded_class_entry(const char *class_name,
                                               int class_name_len) {
  return vphp_find_loaded_class_no_autoload(class_name, class_name_len);
}

bool vphp_object_matches_external_interface(zval *object, const char *name,
                                            int len) {
  if (!object || !name || len <= 0) {
    return false;
  }
  ZVAL_DEREF(object);
  if (Z_TYPE_P(object) != IS_OBJECT) {
    return false;
  }
  zend_class_entry *class_ce = Z_OBJCE_P(object);
  zend_class_entry *iface_ce = vphp_find_loaded_class_no_autoload(name, len);
  if (iface_ce) {
    if (!(iface_ce->ce_flags & ZEND_ACC_INTERFACE)) {
      return false;
    }
    vphp_apply_auto_interface_bindings_for_class(class_ce);
    return vphp_zend_class_implements_interface(class_ce, iface_ce);
  }

  zend_string *expected = zend_string_init(name, len, 0);
  bool matches = vphp_class_has_auto_interface_binding(class_ce, expected);
  zend_string_release(expected);
  return matches;
}

zend_class_entry *vphp_require_class_entry(const char *class_name,
                                           int class_name_len, int autoload) {
  zend_class_entry *ce = NULL;

  if (!class_name || class_name_len <= 0) {
    return NULL;
  }
  ce = vphp_find_loaded_class_no_autoload(class_name, class_name_len);
  if (ce != NULL) {
    return ce;
  }
  if (!autoload) {
    return NULL;
  }
  return vphp_lookup_class_by_name(class_name, class_name_len);
}

static int vphp_class_is_descendant_of(zend_class_entry *ce,
                                       zend_class_entry *parent_ce) {
  zend_class_entry *cursor = NULL;

  if (!ce || !parent_ce) {
    return 0;
  }
  cursor = ce->parent;
  while (cursor != NULL) {
    if (cursor == parent_ce) {
      return 1;
    }
    cursor = cursor->parent;
  }
  return 0;
}

#if PHP_VERSION_ID >= 80400
static bool vphp_property_has_operation(const zend_property_info *prop, int kind) {
  return (!(prop->flags & ZEND_ACC_VIRTUAL) &&
          (kind == ZEND_PROPERTY_HOOK_GET || !(prop->flags & ZEND_ACC_READONLY))) ||
         (prop->hooks && prop->hooks[kind]);
}
#endif

#if PHP_VERSION_ID >= 80300
enum { VPHP_OVERRIDE_METHOD = -2, VPHP_OVERRIDE_PROPERTY = -1 };

static bool vphp_interface_has_override(const zend_class_entry *iface,
                                         zend_string *name, int operation) {
  if (operation == VPHP_OVERRIDE_METHOD) {
    return zend_hash_find_ptr_lc(&iface->function_table, name) != NULL;
  }
  const zend_property_info *prop = zend_hash_find_ptr(&iface->properties_info, name);
#if PHP_VERSION_ID >= 80500
  return prop && (operation == VPHP_OVERRIDE_PROPERTY ||
                  vphp_property_has_operation(prop, operation));
#else
  return prop != NULL;
#endif
}

static bool vphp_find_interface_override(zend_class_entry *ce, zend_string *name,
                                          int operation, bool autoload,
                                          bool *unresolved) {
  for (uint32_t i = 0; i < ce->num_interfaces; i++) {
    if (vphp_interface_has_override(ce->interfaces[i], name, operation)) {
      return true;
    }
  }

  for (uint32_t i = 0; i < vphp_auto_iface_bindings_len; i++) {
    vphp_auto_iface_binding_t *entry = &vphp_auto_iface_bindings[i];
    zend_class_entry *owner = vphp_find_loaded_class_no_autoload(
        entry->class_name, entry->class_name_len);
    if (!owner || (owner != ce && !vphp_class_is_descendant_of(ce, owner))) {
      continue;
    }
    zend_class_entry *iface = vphp_require_class_entry(entry->iface_name,
                                                        entry->iface_name_len,
                                                        autoload);
    if (!iface) {
      if (autoload && EG(exception)) {
        return false;
      }
      *unresolved = true;
    } else if ((iface->ce_flags & ZEND_ACC_INTERFACE) &&
               vphp_interface_has_override(iface, name, operation)) {
      return true;
    }
  }
  return false;
}

bool vphp_validate_method_override(const zend_function *method, bool startup) {
  zend_class_entry *ce = method->common.scope;
  zend_string *name = method->common.function_name;
  // Zend's ZEND_ACC_OVERRIDE failure path reads the userland op_array.
  // Zend links visible parent methods to their prototypes. Interface
  // declarations that extend other interfaces do not get a prototype.
  bool unresolved = false;
  if (method->common.prototype ||
      vphp_find_interface_override(ce, name, VPHP_OVERRIDE_METHOD, !startup, &unresolved)) {
    return true;
  }
  if (!startup && EG(exception)) {
    return false;
  }

  const char *message =
      "%s::%s() has #[\\Override] attribute, but no matching parent method exists";
  if (startup) {
    // PHP-side interfaces can be autoloaded only after module startup.
    if (unresolved && !(method->common.fn_flags & ZEND_ACC_ABSTRACT)) {
      return true;
    }
    zend_error(E_CORE_ERROR, message, ZSTR_VAL(ce->name), ZSTR_VAL(name));
  } else {
    zend_throw_error(NULL, message, ZSTR_VAL(ce->name), ZSTR_VAL(name));
  }
  return false;
}
#endif

static zval *vphp_bind_property_reference(zval *slot, zend_property_info *source,
                                          zend_string *key) {
  if (Z_ISUNDEF_P(slot)) {
    if (source && !ZEND_TYPE_ALLOW_NULL(source->type)) {
      zend_throw_error(NULL, "Cannot access uninitialized non-nullable property %s::$%s by reference",
                       ZSTR_VAL(source->ce->name), ZSTR_VAL(key));
      return NULL;
    }
    ZVAL_NULL(slot);
    Z_PROP_FLAG_P(slot) = 0;
  }
  if (!Z_ISREF_P(slot)) {
    ZVAL_MAKE_REF(slot);
    if (source) {
      ZEND_REF_ADD_TYPE_SOURCE(Z_REF_P(slot), source);
    }
  }
  return slot;
}

static zval *vphp_zend_property_reference(zend_object *object, zend_string *key) {
  zval *slot = zend_std_get_property_ptr_ptr(object, key, BP_VAR_W, NULL);
  if (!slot || slot == &EG(error_zval) || EG(exception)) {
    return NULL;
  }
  return vphp_bind_property_reference(slot, zend_get_typed_property_info_for_slot(object, slot), key);
}

static HashTable vphp_php_property_storage;
static bool vphp_php_property_storage_initialized;

void vphp_register_php_property_storage(zend_class_entry *ce,
                                        const vphp_php_property_names *names) {
  if (!vphp_php_property_storage_initialized) {
    zend_hash_init(&vphp_php_property_storage, 8, NULL, NULL, 1);
    vphp_php_property_storage_initialized = true;
  }
  // Generated code supplies a static, double-NUL-terminated list.
  zend_hash_index_update_ptr(&vphp_php_property_storage, (zend_ulong)(uintptr_t)ce, (void *)names);
}

void vphp_release_php_property_storage(void) {
  if (vphp_php_property_storage_initialized) {
    zend_hash_destroy(&vphp_php_property_storage);
    vphp_php_property_storage_initialized = false;
  }
}

static const vphp_php_property_names *vphp_php_storage_names(const zend_class_entry *ce) {
  if (!vphp_php_property_storage_initialized) {
    return NULL;
  }
  return zend_hash_index_find_ptr(&vphp_php_property_storage, (zend_ulong)(uintptr_t)ce);
}

static void vphp_init_inherited_fields(zend_object *obj, zend_class_entry *ce) {
  if (ce == NULL) {
    return;
  }
  vphp_init_inherited_fields(obj, ce->parent);
  const vphp_php_property_names *storage = vphp_php_storage_names(ce);
  if (storage != NULL && storage->init_inherited_fields != NULL) {
    storage->init_inherited_fields(obj, ce);
  }
}

void vphp_init_inherited_field(void *obj_ptr, void *owner_ptr, const char *name,
                               int name_len, void *value) {
  zend_object *obj = obj_ptr;
  zend_class_entry *owner = owner_ptr;
  zend_string *member = zend_string_init(name, name_len, 0);
  zend_class_entry *previous_scope = EG(fake_scope);
  EG(fake_scope) = owner;
  zend_property_info *info = zend_get_property_info(obj->ce, member, true);
  if (info != NULL && info != ZEND_WRONG_PROPERTY_INFO && info->ce == owner) {
    zend_std_write_property(obj, member, value, NULL);
  }
  EG(fake_scope) = previous_scope;
  zend_string_release(member);
}

static bool vphp_property_name_in_list(const char *names, zend_string *name) {
  for (const char *entry = names; *entry;) {
    size_t len = strlen(entry);
    if (len == ZSTR_LEN(name) && memcmp(entry, ZSTR_VAL(name), len) == 0) {
      return true;
    }
    entry += len + 1;
  }
  return false;
}

static bool vphp_has_php_property_storage(const zend_property_info *property,
                                          zend_string *name) {
  if (property->ce->type == ZEND_USER_CLASS) {
    return true;
  }
  const vphp_php_property_names *names = vphp_php_storage_names(property->ce);
  return names && vphp_property_name_in_list(names->declared, name);
}

static bool vphp_has_static_shadow(const zend_class_entry *ce, zend_string *key) {
  for (; ce; ce = ce->parent) {
    const vphp_php_property_names *names = vphp_php_storage_names(ce);
    if (names && vphp_property_name_in_list(names->static_shadows, key)) {
      return true;
    }
  }
  return false;
}

static bool vphp_property_reference_can_write(const zend_property_info *property,
                                               zend_string *key) {
#if PHP_VERSION_ID >= 80400
  if ((property->flags & ZEND_ACC_PPP_SET_MASK) &&
      !zend_asymmetric_property_has_set_access(property)) {
    zend_throw_error(NULL, "Cannot indirectly modify %s(set) property %s::$%s",
                     (property->flags & ZEND_ACC_PRIVATE_SET) ? "private" : "protected",
                     ZSTR_VAL(property->ce->name), ZSTR_VAL(key));
    return false;
  }
#endif
  return true;
}

zval *vphp_current_property_reference(const char *name, size_t len) {
  if (EG(exception)) {
    return NULL;
  }
  zend_execute_data *ex = EG(current_execute_data);
  if (!ex || !ex->func || !ex->func->common.scope || Z_TYPE(ex->This) != IS_OBJECT) {
    zend_throw_error(NULL, "A property reference requires an active instance method");
    return NULL;
  }
  zend_object *object = Z_OBJ(ex->This);
  zend_string *key = zend_string_init(name, len, 0);
  zend_class_entry *previous_scope = EG(fake_scope);
  // Use the active method's Zend scope, including when called on a subclass.
  EG(fake_scope) = NULL;
  const zend_property_info *property = zend_get_property_info(object->ce, key, true);
  zval *slot = NULL;
  if (property && property != ZEND_WRONG_PROPERTY_INFO &&
      !(property->flags & (ZEND_ACC_STATIC | ZEND_ACC_READONLY)) &&
#if PHP_VERSION_ID >= 80400
      !property->hooks && !(property->flags & ZEND_ACC_VIRTUAL) &&
#endif
      vphp_uses_standard_property_storage(object) &&
      vphp_has_php_property_storage(property, key) &&
      vphp_property_reference_can_write(property, key)) {
    slot = vphp_zend_property_reference(object, key);
  }
  EG(fake_scope) = previous_scope;
  if (!slot && !EG(exception)) {
    zend_throw_error(NULL, "Cannot bind reference to %s::$%s: expected a writable PHP storage property without hooks",
                     ZSTR_VAL(object->ce->name), ZSTR_VAL(key));
  }
  zend_string_release(key);
  return slot;
}

zval *vphp_current_static_property_reference(const char *name, size_t len) {
  if (EG(exception)) {
    return NULL;
  }
  zend_execute_data *ex = EG(current_execute_data);
  zend_class_entry *ce = ex && ex->func && ex->func->common.scope
      ? vphp_zend_get_called_scope(ex) : NULL;
  if (!ce) {
    zend_throw_error(NULL, "A static property reference requires an active class method");
    return NULL;
  }
  zend_string *key = zend_string_init(name, len, 0);
  zend_class_entry *previous_scope = EG(fake_scope);
  EG(fake_scope) = NULL;
  zend_property_info *property = zend_hash_find_ptr(&ce->properties_info, key);
  zval *reference = NULL;
  if (property && (property->flags & ZEND_ACC_STATIC) &&
      vphp_has_php_property_storage(property, key) && !vphp_has_static_shadow(ce, key)) {
    zval *slot = zend_std_get_static_property_with_info(ce, key, BP_VAR_W, &property);
    if (slot && !EG(exception) && vphp_property_reference_can_write(property, key)) {
      reference = vphp_bind_property_reference(slot,
          ZEND_TYPE_IS_SET(property->type) ? property : NULL, key);
    }
  }
  EG(fake_scope) = previous_scope;
  if (!reference && !EG(exception)) {
    zend_throw_error(NULL, "Cannot bind reference to %s::$%s: expected a writable PHP static storage property",
                     ZSTR_VAL(ce->name), ZSTR_VAL(key));
  }
  zend_string_release(key);
  return reference;
}

#if PHP_VERSION_ID >= 80400
static zval *vphp_hook_property_reference(zend_object *object, zend_string *key,
                                          const zend_property_info *backing) {
  const zend_property_info *actual = zend_get_property_info(object->ce, key, true);
  if (!actual || actual == ZEND_WRONG_PROPERTY_INFO ||
      (actual->flags & (ZEND_ACC_VIRTUAL | ZEND_ACC_STATIC | ZEND_ACC_READONLY)) ||
      (backing ? actual->prototype != backing->prototype : actual->hooks != NULL)) {
    return NULL;
  }
  return vphp_zend_property_reference(object, key);
}
#endif

zval *vphp_current_hook_backing_reference(void) {
#if PHP_VERSION_ID >= 80400
  zend_execute_data *execute_data = EG(current_execute_data);
  const zend_function *hook = execute_data ? execute_data->func : NULL;
  if (hook && hook->common.prop_info && (hook->common.fn_flags & ZEND_ACC_RETURN_REFERENCE) &&
      Z_TYPE(execute_data->This) == IS_OBJECT) {
    zend_object *object = Z_OBJ(execute_data->This);
    const zend_property_info *declared = hook->common.prop_info;
    const char *name = zend_get_unmangled_property_name(declared->name);
    zend_string *key = zend_string_init(name, strlen(name), 0);
    zval *slot = vphp_hook_property_reference(object, key, declared);
    zend_string_release(key);
    if (slot) {
      return slot;
    }
  }
#endif
  if (!EG(exception)) {
    zend_throw_error(NULL, "A backing reference requires an active backed property &get hook");
  }
  return NULL;
}

zval *vphp_current_hook_storage_reference(const char *name, size_t len) {
#if PHP_VERSION_ID >= 80400
  zend_execute_data *execute_data = EG(current_execute_data);
  const zend_function *hook = execute_data ? execute_data->func : NULL;
  if (hook && hook->common.prop_info && Z_TYPE(execute_data->This) == IS_OBJECT) {
    zend_object *object = Z_OBJ(execute_data->This);
    zend_string *key = zend_string_init(name, len, 0);
    zval *slot = vphp_hook_property_reference(object, key, NULL);
    zend_string_release(key);
    if (slot) {
      return slot;
    }
  }
#endif
  if (!EG(exception)) {
    zend_throw_error(NULL, "A hook storage reference requires an accessible writable property without hooks");
  }
  return NULL;
}

void vphp_verify_mixed_property_redeclaration(const zend_class_entry *ce,
                                              const char *name, size_t name_len,
                                              bool mixed) {
  const zend_property_info *parent = ce->parent
      ? zend_hash_str_find_ptr(&ce->parent->properties_info, name, name_len)
      : NULL;
  if (!parent || (parent->flags & ZEND_ACC_PRIVATE)) {
    return;
  }
#if PHP_VERSION_ID >= 80400
  if (parent->hooks || (parent->flags & ZEND_ACC_VIRTUAL)) {
    return;
  }
#endif
  // Exported properties are declared after the internal class inherits.
  if (mixed && !ZEND_TYPE_IS_SET(parent->type)) {
    zend_error_noreturn(E_CORE_ERROR,
        "Type of %s::$%s must be omitted to match the parent definition in class %s",
        ZSTR_VAL(ce->name), name, ZSTR_VAL(parent->ce->name));
  }
  if (!mixed && ZEND_TYPE_PURE_MASK(parent->type) == MAY_BE_ANY) {
    zend_error_noreturn(E_CORE_ERROR, "Type of %s::$%s must be mixed (as in class %s)",
        ZSTR_VAL(ce->name), name, ZSTR_VAL(parent->ce->name));
  }
}

#if PHP_VERSION_ID >= 80400
static vphp_property_hooks *vphp_registered_property_hooks;

void vphp_prepare_backed_property(zend_class_entry *ce,
                                  const char *name, size_t name_len) {
  zend_property_info *inherited = zend_hash_str_find_ptr(&ce->properties_info, name, name_len);
  if (!inherited || inherited->ce == ce) {
    return;
  }
  if (inherited->flags & ZEND_ACC_FINAL) {
    zend_error_noreturn(E_CORE_ERROR, "Cannot override final property %s::$%s",
                        ZSTR_VAL(inherited->ce->name), name);
  }
  if (inherited->flags & ZEND_ACC_VIRTUAL) {
    // An inherited contract has no backing slot for zend_declare_typed_property to reuse.
    zend_hash_str_del(&ce->properties_info, name, name_len);
    if (inherited->hooks && ce->num_hooked_props) {
      ce->num_hooked_props--;
    }
  }
}

uint32_t vphp_prepare_property_hooks(zend_class_entry *ce, zend_string *name,
                                     bool has_default) {
  zend_property_info *parent = ce->parent
      ? zend_hash_find_ptr(&ce->parent->properties_info, name) : NULL;
  uint32_t flags = 0;
  if (parent) {
    if (parent->flags & ZEND_ACC_FINAL) {
      zend_error_noreturn(E_CORE_ERROR, "Cannot override final property %s::$%s",
                          ZSTR_VAL(parent->ce->name), ZSTR_VAL(name));
    }
    if (parent->flags & (ZEND_ACC_PRIVATE | ZEND_ACC_VIRTUAL)) {
      // The inherited entry has no backing slot the new declaration can reuse.
      zend_hash_del(&ce->properties_info, name);
    }
    if (parent->hooks && ce->num_hooked_props) {
      ce->num_hooked_props--;
    }
    if (parent->flags & ZEND_ACC_PRIVATE) {
      flags |= ZEND_ACC_CHANGED;
    } else if (parent->flags & (ZEND_ACC_STATIC | ZEND_ACC_READONLY)) {
      zend_error_noreturn(E_CORE_ERROR, "Cannot redeclare %s::$%s with property hooks",
                          ZSTR_VAL(parent->ce->name), ZSTR_VAL(name));
    } else if (!(parent->flags & ZEND_ACC_VIRTUAL)) {
      has_default = true;
    }
  }
  return flags | (has_default ? 0 : ZEND_ACC_VIRTUAL);
}

zend_function *vphp_install_property_hook(vphp_property_hooks *hooks,
                                          zend_property_info *prop,
                                          zend_string *name,
                                          zend_property_hook_kind kind,
                                          zif_handler handler,
                                          const char *value_name) {
  if (!prop->hooks) {
    prop->hooks = hooks->slots;
    prop->ce->num_hooked_props++;
    hooks->next = vphp_registered_property_hooks;
    vphp_registered_property_hooks = hooks;
  }
  bool setter = kind == ZEND_PROPERTY_HOOK_SET;
  zend_internal_function *fn = &hooks->functions[kind].internal_function;
  zend_string *hook_name = zend_strpprintf(0, "$%s::%s", ZSTR_VAL(name), setter ? "set" : "get");
  fn->type = ZEND_INTERNAL_FUNCTION;
  fn->fn_flags = (prop->flags & ZEND_ACC_PRIVATE) ? ZEND_ACC_PRIVATE : ZEND_ACC_PUBLIC;
  if (!handler) {
    fn->fn_flags |= ZEND_ACC_ABSTRACT;
  }
  fn->function_name = zend_string_init_interned(ZSTR_VAL(hook_name), ZSTR_LEN(hook_name), 1);
  zend_string_release(hook_name);
  fn->scope = prop->ce;
  fn->prop_info = prop;
  fn->handler = handler;
  fn->module = prop->ce->info.internal.module;
  fn->num_args = setter ? 1 : 0;
  fn->required_num_args = fn->num_args;
  fn->arg_info = &hooks->arg_info[kind][1];
  fn->arg_info[-1].type = setter ? (zend_type)ZEND_TYPE_INIT_CODE(IS_VOID, 0, 0) : prop->type;
  if (ZEND_TYPE_IS_SET(fn->arg_info[-1].type)) {
    fn->fn_flags |= ZEND_ACC_HAS_RETURN_TYPE;
  }
  if (setter) {
#if PHP_VERSION_ID >= 80600
    fn->arg_info[0].name = zend_string_init_interned(value_name, strlen(value_name), 1);
#else
    fn->arg_info[0].name = value_name;
#endif
    fn->arg_info[0].type = prop->type;
    if (ZEND_TYPE_IS_SET(prop->type)) {
      fn->fn_flags |= ZEND_ACC_HAS_TYPE_HINTS;
    }
  }
#ifdef ZTS
  ZEND_MAP_PTR_NEW_STATIC(fn->run_time_cache);
#endif
  zend_set_function_arg_flags(&hooks->functions[kind]);
  return hooks->slots[kind] = &hooks->functions[kind];
}

#if PHP_VERSION_ID >= 80600
static zend_type vphp_property_type_in_scope(zend_type type, zend_class_entry *scope) {
  if (ZEND_TYPE_HAS_LIST(type)) {
    zend_type_list *original = ZEND_TYPE_LIST(type);
    zend_type_list *list = emalloc(ZEND_TYPE_LIST_SIZE(original->num_types));
    list->num_types = original->num_types;
    for (uint32_t i = 0; i < original->num_types; i++) {
      list->types[i] = vphp_property_type_in_scope(original->types[i], scope);
    }
    ZEND_TYPE_SET_LIST(type, list);
  } else {
    const char *name = ZEND_TYPE_HAS_NAME(type) ? ZSTR_VAL(ZEND_TYPE_NAME(type))
        : ZEND_TYPE_HAS_LITERAL_NAME(type) ? ZEND_TYPE_LITERAL_NAME(type) : NULL;
    if (name != NULL && zend_binary_strcasecmp(name, strlen(name), "self", 4) == 0) {
      ZEND_TYPE_SET_PTR_AND_KIND(type, scope->name, _ZEND_TYPE_NAME_BIT);
    } else if (name != NULL && scope->parent &&
               zend_binary_strcasecmp(name, strlen(name), "parent", 6) == 0) {
      ZEND_TYPE_SET_PTR_AND_KIND(type, scope->parent->name, _ZEND_TYPE_NAME_BIT);
    }
  }
  return type;
}

static void vphp_release_property_type_lists(zend_type type) {
  if (ZEND_TYPE_HAS_LIST(type)) {
    zend_type_list *list = ZEND_TYPE_LIST(type);
    for (uint32_t i = 0; i < list->num_types; i++) {
      vphp_release_property_type_lists(list->types[i]);
    }
    efree(list);
  }
}
#else
ZEND_API zend_inheritance_status zend_perform_covariant_type_check(
    zend_class_entry *fe_scope, const zend_type fe_type,
    zend_class_entry *proto_scope, const zend_type proto_type);
#endif

static bool vphp_contract_type_is_subtype(const zend_property_info *source,
                                           const zend_property_info *target) {
  if (!ZEND_TYPE_IS_SET(source->type) || !ZEND_TYPE_IS_SET(target->type)) {
    return ZEND_TYPE_IS_SET(source->type) == ZEND_TYPE_IS_SET(target->type);
  }
#if PHP_VERSION_ID >= 80600
  // Zend's public setter check uses a single scope. Resolve the target's
  // relative names in its declaring scope before passing it to that check.
  zend_arg_info value = {0};
  value.type = vphp_property_type_in_scope(target->type, target->ce);
  zend_function setter = {0};
  setter.common.arg_info = &value;
  zend_function *hooks[ZEND_PROPERTY_HOOK_COUNT] = {0};
  hooks[ZEND_PROPERTY_HOOK_SET] = &setter;
  zend_property_info property = *source;
  property.hooks = hooks;
  zend_inheritance_status status = zend_verify_property_hook_variance(&property, &setter);
  vphp_release_property_type_lists(value.type);
  return status == INHERITANCE_SUCCESS;
#else
  return zend_perform_covariant_type_check(source->ce, source->type,
      target->ce, target->type) == INHERITANCE_SUCCESS;
#endif
}

static bool vphp_has_property_hook_flag(const zend_property_info *prop, uint32_t flags) {
  for (uint32_t i = 0; prop->hooks && i < ZEND_PROPERTY_HOOK_COUNT; i++) {
    if (prop->hooks[i] && (prop->hooks[i]->common.fn_flags & flags)) {
      return true;
    }
  }
  return false;
}

static void vphp_check_property_contract_set_access(const zend_property_info *prop,
                                                    const zend_property_info *contract) {
  const zend_function *setter = contract->hooks ? contract->hooks[ZEND_PROPERTY_HOOK_SET] : NULL;
  if (setter && (setter->common.fn_flags & ZEND_ACC_ABSTRACT) &&
      !(contract->flags & ZEND_ACC_PPP_SET_MASK) &&
      (prop->flags & (ZEND_ACC_READONLY | ZEND_ACC_PPP_SET_MASK))) {
    zend_error_noreturn(E_CORE_ERROR, "Set access level of %s::$%s must be omitted (as in class %s)",
        ZSTR_VAL(prop->ce->name), ZSTR_VAL(prop->name), ZSTR_VAL(contract->ce->name));
  }
}

static void vphp_check_property_hook_contract(const zend_property_info *prop,
                                               const zend_property_info *parent,
                                               const char *name) {
  const char *kind = vphp_has_property_hook_flag(parent, ZEND_ACC_ABSTRACT) ? "abstract" : "hooked";
  if ((prop->flags & ZEND_ACC_STATIC) ||
      (prop->flags & ZEND_ACC_PPP_MASK) > (parent->flags & ZEND_ACC_PPP_MASK)) {
    zend_error_noreturn(E_CORE_ERROR, "Invalid declaration of %s::$%s for %s property in %s",
        ZSTR_VAL(prop->ce->name), name, kind, ZSTR_VAL(parent->ce->name));
  }
  vphp_check_property_contract_set_access(prop, parent);
  bool get = vphp_property_has_operation(parent, ZEND_PROPERTY_HOOK_GET);
  bool set = vphp_property_has_operation(parent, ZEND_PROPERTY_HOOK_SET);
  if ((get && !vphp_contract_type_is_subtype(prop, parent)) ||
      (set && !vphp_contract_type_is_subtype(parent, prop))) {
    zend_error_noreturn(E_CORE_ERROR, "Type of %s::$%s is incompatible with %s property in %s",
        ZSTR_VAL(prop->ce->name), name, kind, ZSTR_VAL(parent->ce->name));
  }
}

static void vphp_require_property_hook_reference(const zend_function *own,
                                                 const zend_function *contract) {
  if ((contract->common.fn_flags & ZEND_ACC_RETURN_REFERENCE) &&
      !(own->common.fn_flags & ZEND_ACC_RETURN_REFERENCE)) {
    zend_error_noreturn(E_CORE_ERROR, "Property hook %s::%s() must return by reference like %s::%s()",
        ZSTR_VAL(own->common.scope->name), ZSTR_VAL(own->common.function_name),
        ZSTR_VAL(contract->common.scope->name), ZSTR_VAL(contract->common.function_name));
  }
}

void vphp_verify_interface_restricted_hooks(const zend_class_entry *ce,
                                           const zend_class_entry *iface) {
  zend_string *name;
  const zend_property_info *contract;
  ZEND_HASH_MAP_FOREACH_STR_KEY_PTR(&iface->properties_info, name, contract) {
    if (!contract->hooks) {
      continue;
    }
    const zend_property_info *prop = zend_hash_find_ptr(&ce->properties_info, name);
    if (!prop || (prop->flags & ZEND_ACC_PRIVATE)) {
      continue;
    }
    // A MINIT contract failure must stop extension loading.
    vphp_check_property_contract_set_access(prop, contract);
    const zend_function *required = contract->hooks[ZEND_PROPERTY_HOOK_GET];
    const zend_function *own = prop->hooks ? prop->hooks[ZEND_PROPERTY_HOOK_GET] : NULL;
    if (own && required) {
      vphp_require_property_hook_reference(own, required);
    }
  } ZEND_HASH_FOREACH_END();
}

static void vphp_merge_property_hooks(zend_property_info *prop,
                                      const zend_property_info *parent,
                                      const char *name,
                                      zend_function **backed_slots) {
  if (vphp_has_property_hook_flag(parent, ZEND_ACC_ABSTRACT | ZEND_ACC_FINAL | ZEND_ACC_RETURN_REFERENCE)) {
    vphp_check_property_hook_contract(prop, parent, name);
  }
  if (!(parent->ce->ce_flags & ZEND_ACC_INTERFACE)) {
    prop->prototype = parent->prototype;
  }
  for (uint32_t i = 0; parent->hooks && i < ZEND_PROPERTY_HOOK_COUNT; i++) {
    zend_function *inherited = parent->hooks[i];
    if (!inherited) {
      continue;
    }
    zend_function *own = prop->hooks ? prop->hooks[i] : NULL;
    bool abstract = (inherited->common.fn_flags & ZEND_ACC_ABSTRACT) != 0;
    if (own) {
      if (inherited->common.fn_flags & ZEND_ACC_FINAL) {
        zend_error_noreturn(E_CORE_ERROR, "Cannot override final property hook %s::%s()",
            ZSTR_VAL(inherited->common.scope->name), ZSTR_VAL(inherited->common.function_name));
      }
      vphp_require_property_hook_reference(own, inherited);
      if (!abstract && (own->common.fn_flags & ZEND_ACC_ABSTRACT)) {
        zend_error_noreturn(E_CORE_ERROR, "Cannot make non-abstract property hook %s::%s() abstract in class %s",
            ZSTR_VAL(inherited->common.scope->name), ZSTR_VAL(inherited->common.function_name),
            ZSTR_VAL(prop->ce->name));
      }
      own->common.prototype = inherited->common.prototype
          ? inherited->common.prototype : inherited;
      continue;
    }
    if (abstract && vphp_property_has_operation(prop, i)) {
      continue;
    }
    if (prop->flags & ZEND_ACC_READONLY) {
      zend_error_noreturn(E_CORE_ERROR, "Hooked property %s::$%s cannot be readonly",
          ZSTR_VAL(prop->ce->name), name);
    }
    if (!prop->hooks) {
      prop->hooks = backed_slots;
      prop->ce->num_hooked_props++;
    }
    prop->hooks[i] = inherited;
  }
}

void vphp_inherit_property_hooks(zend_property_info *prop, zend_string *name) {
  const zend_property_info *parent = prop->ce->parent
      ? zend_hash_find_ptr(&prop->ce->parent->properties_info, name) : NULL;
  if (parent && !(parent->flags & ZEND_ACC_PRIVATE)) {
    vphp_merge_property_hooks(prop, parent, ZSTR_VAL(name), NULL);
  }
}

void vphp_verify_reference_property_hook(const zend_property_info *prop, const char *name) {
  if (!(prop->flags & ZEND_ACC_VIRTUAL) && prop->hooks &&
      prop->hooks[ZEND_PROPERTY_HOOK_SET] && prop->hooks[ZEND_PROPERTY_HOOK_GET] &&
      (prop->hooks[ZEND_PROPERTY_HOOK_GET]->common.fn_flags & ZEND_ACC_RETURN_REFERENCE)) {
    zend_error_noreturn(E_CORE_ERROR, "Get hook of backed property %s::$%s with set hook may not return by reference",
        ZSTR_VAL(prop->ce->name), name);
  }
}

void vphp_inherit_backed_property_contract(zend_class_entry *ce, const char *name,
                                           size_t name_len, zend_function **slots) {
  if (!ce->parent || !ce->parent->num_hooked_props) {
    return;
  }
  zend_property_info *parent = zend_hash_str_find_ptr(&ce->parent->properties_info, name, name_len);
  // Interface requirements are independently verified after the class is linked.
  if (!parent || (parent->ce->ce_flags & ZEND_ACC_INTERFACE) ||
      (parent->flags & ZEND_ACC_PRIVATE) ||
      !vphp_has_property_hook_flag(parent, ZEND_ACC_ABSTRACT | ZEND_ACC_FINAL | ZEND_ACC_RETURN_REFERENCE)) {
    return;
  }
  zend_property_info *prop = zend_hash_str_find_ptr(&ce->properties_info, name, name_len);
  if (prop && prop->ce == ce) {
    vphp_merge_property_hooks(prop, parent, name, slots);
    vphp_verify_reference_property_hook(prop, name);
  }
}

void vphp_verify_interface_property_contracts(zend_class_entry *ce, bool declared_abstract) {
  if (declared_abstract || (ce->ce_flags & ZEND_ACC_INTERFACE)) {
    return;
  }
  const zend_property_info *prop;
  ZEND_HASH_MAP_FOREACH_PTR(&ce->properties_info, prop) {
    for (uint32_t i = 0; prop->hooks && i < ZEND_PROPERTY_HOOK_COUNT; i++) {
      const zend_function *hook = prop->hooks[i];
      if (hook && (hook->common.fn_flags & ZEND_ACC_ABSTRACT)) {
        zend_error_noreturn(E_CORE_ERROR,
            "Class %s must implement property hook %s::%s()",
            ZSTR_VAL(ce->name), ZSTR_VAL(hook->common.scope->name),
            ZSTR_VAL(hook->common.function_name));
      }
    }
  } ZEND_HASH_FOREACH_END();

  // The generated registration declares properties after class inheritance.
  // Recheck the interface contracts of a parent if a child replaced a property.
  if (!ce->parent) {
    return;
  }
  for (uint32_t i = 0; i < ce->parent->num_interfaces; i++) {
    zend_class_entry *iface = ce->parent->interfaces[i];
    zend_string *name;
    const zend_property_info *contract;
    ZEND_HASH_MAP_FOREACH_STR_KEY_PTR(&iface->properties_info, name, contract) {
      const zend_property_info *own = zend_hash_find_ptr(&ce->properties_info, name);
      if (!own || own->ce != ce || !contract->hooks) {
        continue;
      }
      for (uint32_t kind = 0; kind < ZEND_PROPERTY_HOOK_COUNT; kind++) {
        const zend_function *hook = contract->hooks[kind];
        if (!hook) {
          continue;
        }
        if (!(own->flags & ZEND_ACC_PUBLIC) || (own->flags & ZEND_ACC_STATIC) ||
            (kind == ZEND_PROPERTY_HOOK_SET && (own->flags & ZEND_ACC_PPP_SET_MASK)) ||
            !vphp_property_has_operation(own, kind)) {
          zend_error_noreturn(E_CORE_ERROR, "Class %s must implement property hook %s::%s()",
              ZSTR_VAL(ce->name), ZSTR_VAL(iface->name), ZSTR_VAL(hook->common.function_name));
        }
        bool compatible = kind == ZEND_PROPERTY_HOOK_GET
            ? vphp_contract_type_is_subtype(own, contract)
            : vphp_contract_type_is_subtype(contract, own);
        if (!compatible) {
          zend_error_noreturn(E_CORE_ERROR, "Type of %s::$%s is incompatible with %s::%s()",
              ZSTR_VAL(ce->name), ZSTR_VAL(name), ZSTR_VAL(iface->name),
              ZSTR_VAL(hook->common.function_name));
        }
      }
    } ZEND_HASH_FOREACH_END();
  }
  if ((ce->ce_flags & ZEND_ACC_IMPLICIT_ABSTRACT_CLASS) && ce->parent->num_hooked_props) {
    // Declaring a backing property can satisfy the inherited abstract hook.
    const zend_function *method;
    ZEND_HASH_MAP_FOREACH_PTR(&ce->function_table, method) {
      if (method->common.fn_flags & ZEND_ACC_ABSTRACT) {
        return;
      }
    } ZEND_HASH_FOREACH_END();
    ce->ce_flags &= ~(ZEND_ACC_IMPLICIT_ABSTRACT_CLASS | ZEND_ACC_EXPLICIT_ABSTRACT_CLASS);
  }
}

void vphp_release_property_hooks(void) {
  while (vphp_registered_property_hooks) {
    vphp_property_hooks *hooks = vphp_registered_property_hooks;
    vphp_registered_property_hooks = hooks->next;
    for (uint32_t i = 0; i < ZEND_PROPERTY_HOOK_COUNT; i++) {
      zend_function *fn = &hooks->functions[i];
      if (fn->common.attributes) {
        zend_hash_release(fn->common.attributes);
        fn->common.attributes = NULL;
      }
    }
  }
}
#endif

#if PHP_VERSION_ID >= 80500
static bool vphp_validate_property_override(const zend_property_info *prop,
                                      zend_string *name, bool startup) {
  zend_class_entry *ce = prop->ce;
  zend_property_info *inherited = ce->parent
      ? zend_hash_find_ptr(&ce->parent->properties_info, name) : NULL;
  bool unresolved = false;

  // The parent table already includes inherited properties. A private
  // property does not satisfy Override, even when the name is identical.
  if (inherited && !(inherited->flags & ZEND_ACC_PRIVATE)) {
    return true;
  }
  // Interface property contracts always describe instance properties.
  if (!(prop->flags & ZEND_ACC_STATIC) &&
      (vphp_find_interface_override(ce, name, VPHP_OVERRIDE_PROPERTY, false, &unresolved) ||
       (startup && unresolved))) {
    return true;
  }

  const char *message =
      "%s::$%s has #[\\Override] attribute, but no matching parent property exists";
  if (startup) {
    zend_error(E_CORE_ERROR, message, ZSTR_VAL(ce->name), ZSTR_VAL(name));
  } else {
    zend_throw_error(NULL, message, ZSTR_VAL(ce->name), ZSTR_VAL(name));
  }
  return false;
}

static bool vphp_validate_property_hook_override(const zend_property_info *prop,
                                           zend_string *name,
                                           zend_property_hook_kind kind,
                                           bool startup) {
  zend_class_entry *ce = prop->ce;
  const zend_property_info *parent = ce->parent
      ? zend_hash_find_ptr(&ce->parent->properties_info, name) : NULL;
  bool unresolved = false;
  if ((parent && !(parent->flags & ZEND_ACC_PRIVATE) &&
       vphp_property_has_operation(parent, kind)) ||
      vphp_find_interface_override(ce, name, kind, false, &unresolved) ||
      (startup && unresolved)) {
    return true;
  }
  const char *msg =
      "%s::$%s::%s() has #[\\Override] attribute, but no matching parent method exists";
  const char *kind_name = kind == ZEND_PROPERTY_HOOK_GET ? "get" : "set";
  if (startup) {
    zend_error(E_CORE_ERROR, msg, ZSTR_VAL(ce->name), ZSTR_VAL(name), kind_name);
  } else {
    zend_throw_error(NULL, msg, ZSTR_VAL(ce->name), ZSTR_VAL(name), kind_name);
  }
  return false;
}

bool vphp_validate_property_overrides(zend_class_entry *ce, bool startup) {
  for (; ce; ce = startup ? NULL : ce->parent) {
    if (ce->type != ZEND_INTERNAL_CLASS) {
      continue;
    }
    zend_string *name;
    zend_property_info *prop;
    ZEND_HASH_MAP_FOREACH_STR_KEY_PTR(&ce->properties_info, name, prop) {
      if (prop->ce != ce) {
        continue;
      }
      if (prop->attributes &&
          zend_get_attribute_str(prop->attributes, ZEND_STRL("override")) &&
          !vphp_validate_property_override(prop, name, startup)) {
        return false;
      }
      for (uint32_t i = 0; prop->hooks && i < ZEND_PROPERTY_HOOK_COUNT; i++) {
        const zend_function *hook = prop->hooks[i];
        if (hook && hook->common.prop_info == prop && hook->common.attributes &&
            zend_get_attribute_str(hook->common.attributes, ZEND_STRL("override")) &&
            !vphp_validate_property_hook_override(prop, name, i, startup)) {
          return false;
        }
      }
    } ZEND_HASH_FOREACH_END();
  }
  return true;
}
#endif

static int vphp_class_is_throwable(zend_class_entry *ce) {
  if (!ce) {
    return 0;
  }
  return vphp_zend_class_implements_interface(ce, zend_ce_throwable) ? 1 : 0;
}

static zend_class_entry *vphp_autoload_class(zend_string *name) {
  if (!name) {
    return NULL;
  }
  return vphp_zend_lookup_class_ex(name);
}

static void vphp_preload_auto_interfaces_for_class(zend_class_entry *class_ce) {
  vphp_prepare_auto_interfaces_for_class(class_ce, 1);
}

static void vphp_prepare_auto_interfaces_for_class(zend_class_entry *class_ce,
                                                   int autoload) {
  int matched_any = 0;

  if (!class_ce || vphp_auto_iface_bindings_len == 0 ||
      vphp_runtime_autoloading || vphp_runtime_binding_applying) {
    return;
  }

  vphp_runtime_autoloading = 1;
  vphp_runtime_binding_applying = 1;
  for (uint32_t i = 0; i < vphp_auto_iface_bindings_len; i++) {
    vphp_auto_iface_binding_t *entry = &vphp_auto_iface_bindings[i];
    zend_class_entry *bound_class_ce = vphp_find_loaded_class_no_autoload(
        entry->class_name, entry->class_name_len);
    zend_string *iface_name = NULL;

    if (!bound_class_ce) {
      continue;
    }
    if (class_ce != bound_class_ce &&
        !vphp_class_is_descendant_of(class_ce, bound_class_ce)) {
      continue;
    }

    matched_any = 1;
    iface_name = zend_string_init(entry->iface_name, entry->iface_name_len, 0);
    if (!autoload) {
      zend_class_entry *loaded_iface_ce = vphp_find_loaded_class_no_autoload(
          entry->iface_name, entry->iface_name_len);
      if (loaded_iface_ce != NULL) {
        matched_any = 1;
      }
    } else if (vphp_autoload_class(iface_name) != NULL) {
      matched_any = 1;
    }
    zend_string_release(iface_name);
  }

  vphp_runtime_autoloading = 0;
  vphp_runtime_binding_applying = 0;
  if (matched_any) {
    /*
     * Do not mutate class/interface relationships while Zend is still inside
     * an autoload stack. Composer-style PSR interfaces are loaded one file at
     * a time, and applying zend_do_implement_interface() mid-autoload can
     * corrupt subsequent interface queries/instantiation.
     */
    vphp_apply_registered_auto_interface_bindings(0);
    vphp_flush_pending_auto_interface_bindings();
    vphp_last_class_table_count = zend_hash_num_elements(CG(class_table));
#if PHP_VERSION_ID >= 80500
    if (autoload && !EG(exception)) {
      vphp_validate_property_overrides(class_ce, false);
    }
#endif
  }
}

static zend_class_entry *vphp_runtime_query_class_from_arg(zval *arg,
                                                           int autoload) {
  if (!arg) {
    return NULL;
  }
  if (Z_TYPE_P(arg) == IS_OBJECT) {
    return Z_OBJCE_P(arg);
  }
  if (Z_TYPE_P(arg) == IS_STRING) {
    if (autoload) {
      return vphp_lookup_class_by_name(Z_STRVAL_P(arg), Z_STRLEN_P(arg));
    }
    return vphp_find_loaded_class_no_autoload(Z_STRVAL_P(arg), Z_STRLEN_P(arg));
  }
  return NULL;
}

static int vphp_runtime_bool_arg(zend_execute_data *execute_data, uint32_t index,
                                 int default_value) {
  zval *arg = NULL;

  if (!execute_data || ZEND_CALL_NUM_ARGS(execute_data) < index) {
    return default_value;
  }
  arg = ZEND_CALL_ARG(execute_data, index);
  if (!arg) {
    return default_value;
  }
  return vphp_zend_is_true(arg) ? 1 : 0;
}

static void
vphp_runtime_prepare_internal_query_bindings(zend_execute_data *execute_data) {
  zend_function *func = NULL;
  zend_string *function_name = NULL;
  zend_class_entry *query_ce = NULL;
  zval *query_arg = NULL;

  if (!execute_data || vphp_auto_iface_bindings_len == 0) {
    return;
  }
  func = execute_data->func;
  if (!func || func->type != ZEND_INTERNAL_FUNCTION || func->common.scope != NULL ||
      func->common.function_name == NULL || ZEND_CALL_NUM_ARGS(execute_data) == 0) {
    return;
  }

  function_name = func->common.function_name;
  query_arg = ZEND_CALL_ARG(execute_data, 1);
  if (!query_arg) {
    return;
  }

  if (zend_string_equals_literal(function_name, "class_implements")) {
    int autoload = vphp_runtime_bool_arg(execute_data, 2, 1);

    query_ce = vphp_runtime_query_class_from_arg(query_arg, autoload);
    if (query_ce != NULL) {
      vphp_prepare_auto_interfaces_for_class(query_ce, autoload);
    }
    return;
  }

  if (zend_string_equals_literal(function_name, "is_a") ||
      zend_string_equals_literal(function_name, "is_subclass_of")) {
    int allow_string = zend_string_equals_literal(function_name, "is_subclass_of")
                           ? vphp_runtime_bool_arg(execute_data, 3, 1)
                           : vphp_runtime_bool_arg(execute_data, 3, 0);

    if (Z_TYPE_P(query_arg) == IS_STRING && !allow_string) {
      return;
    }
    query_ce = vphp_runtime_query_class_from_arg(query_arg, 1);
    if (query_ce != NULL) {
      vphp_prepare_auto_interfaces_for_class(query_ce, 1);
    }
  }
}

static int vphp_auto_binding_requires_deferral(zend_class_entry *class_ce,
                                               zend_class_entry *iface_ce) {
  if (!class_ce || !iface_ce) {
    return 0;
  }
  if (vphp_runtime_internal_call_depth == 0) {
    return 0;
  }
  if (!vphp_class_is_throwable(class_ce)) {
    return 0;
  }
  if (!(iface_ce->ce_flags & ZEND_ACC_INTERFACE)) {
    return 0;
  }
  if (iface_ce->num_interfaces == 0) {
    return 0;
  }
  return 1;
}

static void vphp_queue_pending_auto_interface_binding(uint32_t binding_index) {
  if (binding_index >= vphp_auto_iface_bindings_len) {
    return;
  }
  for (uint32_t i = 0; i < vphp_pending_auto_iface_bindings_len; i++) {
    if (vphp_pending_auto_iface_bindings[i].binding_index == binding_index) {
      return;
    }
  }
  if (vphp_pending_auto_iface_bindings_len >=
      vphp_pending_auto_iface_bindings_cap) {
    uint32_t new_cap = vphp_pending_auto_iface_bindings_cap == 0
                           ? 4
                           : vphp_pending_auto_iface_bindings_cap * 2;
    size_t bytes = sizeof(vphp_pending_auto_iface_binding_t) * new_cap;
    if (vphp_pending_auto_iface_bindings == NULL) {
      vphp_pending_auto_iface_bindings = emalloc(bytes);
    } else {
      vphp_pending_auto_iface_bindings =
          erealloc(vphp_pending_auto_iface_bindings, bytes);
    }
    if (vphp_pending_auto_iface_bindings == NULL) {
      vphp_pending_auto_iface_bindings_cap = 0;
      vphp_pending_auto_iface_bindings_len = 0;
      return;
    }
    vphp_pending_auto_iface_bindings_cap = new_cap;
  }
  vphp_pending_auto_iface_bindings[vphp_pending_auto_iface_bindings_len++]
      .binding_index = binding_index;
}

static int vphp_try_apply_auto_interface_binding(vphp_auto_iface_binding_t *entry,
                                                 uint32_t binding_index,
                                                 int autoload, int allow_defer) {
  zend_class_entry *class_ce = NULL;
  zend_class_entry *iface_ce = NULL;

  if (!entry) {
    return 0;
  }

  if (autoload) {
    class_ce =
        vphp_lookup_class_by_name(entry->class_name, entry->class_name_len);
    iface_ce = vphp_lookup_class_by_name(entry->iface_name, entry->iface_name_len);
  } else {
    class_ce = vphp_find_loaded_class_no_autoload(entry->class_name,
                                                  entry->class_name_len);
    iface_ce = vphp_find_loaded_class_no_autoload(entry->iface_name,
                                                  entry->iface_name_len);
  }

  if (!class_ce || !iface_ce) {
    return 0;
  }
  if (vphp_zend_class_implements_interface(class_ce, iface_ce)) {
    return 1;
  }
  if (allow_defer && vphp_auto_binding_requires_deferral(class_ce, iface_ce)) {
    vphp_queue_pending_auto_interface_binding(binding_index);
    return -1;
  }
  return vphp_implement_interface_for_class(class_ce, iface_ce);
}

static void vphp_flush_pending_auto_interface_bindings(void) {
  if (vphp_pending_auto_iface_bindings_len == 0 ||
      vphp_runtime_internal_call_depth > 0) {
    return;
  }

  for (uint32_t i = 0; i < vphp_pending_auto_iface_bindings_len; i++) {
    uint32_t binding_index = vphp_pending_auto_iface_bindings[i].binding_index;
    if (binding_index >= vphp_auto_iface_bindings_len) {
      continue;
    }
    (void)vphp_try_apply_auto_interface_binding(
        &vphp_auto_iface_bindings[binding_index], binding_index, 0, 0);
  }
  vphp_pending_auto_iface_bindings_len = 0;
}

static int vphp_implement_interface_for_class(zend_class_entry *class_ce,
                                              zend_class_entry *iface_ce) {
  int result = 0;

  if (!class_ce || !iface_ce) {
    return 0;
  }

  if (!vphp_zend_class_implements_interface(class_ce, iface_ce)) {
    vphp_zend_do_implement_interface(class_ce, iface_ce);
  }
  result = vphp_zend_class_implements_interface(class_ce, iface_ce) ? 1 : 0;

  return result;
}

int vphp_bind_class_interface(const char *class_name, int class_name_len,
                              const char *iface_name, int iface_name_len) {
  zend_string *class_name_str = zend_string_init(class_name, class_name_len, 0);
  zend_string *iface_name_str = zend_string_init(iface_name, iface_name_len, 0);
  zend_class_entry *class_ce = vphp_zend_lookup_class(class_name_str);
  zend_class_entry *iface_ce = vphp_zend_lookup_class(iface_name_str);
  int result = 0;

  zend_string_release(class_name_str);
  zend_string_release(iface_name_str);

  if (!class_ce || !iface_ce) {
    return 0;
  }

  if (vphp_zend_class_implements_interface(class_ce, iface_ce)) {
    return 1;
  }

  result = vphp_implement_interface_for_class(class_ce, iface_ce);
  return result;
}

void vphp_register_auto_interface_binding(const char *class_name,
                                          int class_name_len,
                                          const char *iface_name,
                                          int iface_name_len) {
  if (!class_name || class_name_len <= 0 || !iface_name || iface_name_len <= 0) {
    return;
  }
  for (uint32_t i = 0; i < vphp_auto_iface_bindings_len; i++) {
    vphp_auto_iface_binding_t *entry = &vphp_auto_iface_bindings[i];
    if (entry->class_name_len == class_name_len &&
        entry->iface_name_len == iface_name_len &&
        strncasecmp(entry->class_name, class_name, class_name_len) == 0 &&
        strncmp(entry->iface_name, iface_name, iface_name_len) == 0) {
      return;
    }
  }
  if (vphp_auto_iface_bindings_len >= vphp_auto_iface_bindings_cap) {
    uint32_t new_cap =
        vphp_auto_iface_bindings_cap == 0 ? 8 : vphp_auto_iface_bindings_cap * 2;
    size_t bytes = sizeof(vphp_auto_iface_binding_t) * new_cap;
    if (vphp_auto_iface_bindings == NULL) {
      vphp_auto_iface_bindings = pemalloc(bytes, 1);
    } else {
      vphp_auto_iface_bindings = perealloc(vphp_auto_iface_bindings, bytes, 1);
    }
    if (vphp_auto_iface_bindings == NULL) {
      vphp_auto_iface_bindings_cap = 0;
      vphp_auto_iface_bindings_len = 0;
      return;
    }
    vphp_auto_iface_bindings_cap = new_cap;
  }
  vphp_auto_iface_binding_t *entry =
      &vphp_auto_iface_bindings[vphp_auto_iface_bindings_len++];
  entry->class_name = pemalloc((size_t)class_name_len + 1, 1);
  memcpy(entry->class_name, class_name, class_name_len);
  entry->class_name[class_name_len] = '\0';
  entry->class_name_len = class_name_len;
  entry->iface_name = pemalloc((size_t)iface_name_len + 1, 1);
  memcpy(entry->iface_name, iface_name, iface_name_len);
  entry->iface_name[iface_name_len] = '\0';
  entry->iface_name_len = iface_name_len;
}

static bool vphp_class_has_auto_interface_binding(zend_class_entry *class_ce,
                                                   zend_string *expected_name) {
  if (class_ce == NULL || expected_name == NULL) {
    return false;
  }
  for (uint32_t i = 0; i < vphp_auto_iface_bindings_len; i++) {
    vphp_auto_iface_binding_t *entry = &vphp_auto_iface_bindings[i];
    if ((int)ZSTR_LEN(class_ce->name) != entry->class_name_len ||
        (int)ZSTR_LEN(expected_name) != entry->iface_name_len) {
      continue;
    }
    if (strncasecmp(ZSTR_VAL(class_ce->name), entry->class_name,
                    (size_t)entry->class_name_len) != 0) {
      continue;
    }
    if (strncasecmp(ZSTR_VAL(expected_name), entry->iface_name,
                (size_t)entry->iface_name_len) != 0) {
      continue;
    }
    return true;
  }
  return false;
}

static void vphp_apply_auto_interface_bindings_for_class(zend_class_entry *ce) {
  if (!ce || vphp_auto_iface_bindings_len == 0) {
    return;
  }
  for (uint32_t i = 0; i < vphp_auto_iface_bindings_len; i++) {
    vphp_auto_iface_binding_t *entry = &vphp_auto_iface_bindings[i];
    if ((int)ZSTR_LEN(ce->name) != entry->class_name_len) {
      continue;
    }
    if (strncasecmp(ZSTR_VAL(ce->name), entry->class_name,
                    (size_t)entry->class_name_len) != 0) {
      continue;
    }
    (void)vphp_try_apply_auto_interface_binding(entry, i, 0, 0);
  }
}

static void vphp_apply_registered_auto_interface_bindings(int autoload) {
  if (vphp_auto_iface_bindings_len == 0) {
    return;
  }
  for (uint32_t i = 0; i < vphp_auto_iface_bindings_len; i++) {
    vphp_auto_iface_binding_t *entry = &vphp_auto_iface_bindings[i];
    (void)vphp_try_apply_auto_interface_binding(entry, i, autoload,
                                                autoload ? 0 : 1);
  }
}

void vphp_apply_auto_interface_bindings(int autoload) {
  vphp_apply_registered_auto_interface_bindings(autoload);
  if (!autoload) {
    vphp_flush_pending_auto_interface_bindings();
  }
}

static void vphp_runtime_maybe_apply_bindings(uint32_t class_count_before,
                                              int should_check) {
  uint32_t class_count_after = 0;

  if (should_check && !vphp_runtime_binding_applying) {
    class_count_after = zend_hash_num_elements(CG(class_table));
    if (!(class_count_after == class_count_before &&
          class_count_after == vphp_last_class_table_count)) {
      vphp_last_class_table_count = class_count_after;
      vphp_runtime_binding_applying = 1;
      vphp_apply_registered_auto_interface_bindings(0);
      vphp_runtime_binding_applying = 0;
    }
  }

  vphp_flush_pending_auto_interface_bindings();
}

static zend_class_entry *(*vphp_previous_inheritance_cache_add)(
    zend_class_entry *, zend_class_entry *, zend_class_entry *,
    zend_class_entry **, HashTable *);
static int vphp_native_trait_module;
#ifdef ZTS
static MUTEX_T vphp_native_trait_cache_lock;
#endif

static inline bool vphp_is_own_native_trait(const zend_class_entry *trait) {
  return trait && trait->type == ZEND_INTERNAL_CLASS &&
      (trait->ce_flags & ZEND_ACC_TRAIT) && trait->info.internal.module &&
      trait->info.internal.module->module_number == vphp_native_trait_module;
}

static zend_class_entry *vphp_cache_inheritance_without_native_traits(
    zend_class_entry *ce, zend_class_entry *proto, zend_class_entry *parent,
    zend_class_entry **traits_and_interfaces, HashTable *dependencies) {
  for (uint32_t i = 0; traits_and_interfaces && i < proto->num_traits; i++) {
    zend_class_entry *trait = traits_and_interfaces[i];
    if (vphp_is_own_native_trait(trait)) {
      /* Trait binding copies metadata that still belongs to the extension.
       * OPcache assumes it can move that metadata out of request memory. */
      return NULL;
    }
  }
  return vphp_previous_inheritance_cache_add(
      ce, proto, parent, traits_and_interfaces, dependencies);
}

static void vphp_check_native_trait_preload(void) {
  if (!vphp_native_trait_module || !(CG(compiler_options) & ZEND_COMPILE_PRELOAD)) {
    return;
  }

  /* Preload can link classes after the startup script returns, including
   * declarations compiled by opcache_compile_file() without execution. */
  zend_class_entry *ce;
  ZEND_HASH_MAP_FOREACH_PTR(CG(class_table), ce) {
    for (uint32_t i = 0; i < ce->num_traits; i++) {
      zend_string *trait_name = ce->trait_names[i].lc_name;
      zend_class_entry *trait = zend_hash_find_ptr(CG(class_table), trait_name);
      if (vphp_is_own_native_trait(trait)) {
        zend_error_noreturn(E_COMPILE_ERROR,
            "Cannot preload %s because it uses VPHP trait %s; load the declaration at request time",
            ZSTR_VAL(ce->name), ZSTR_VAL(trait->name));
      }
    }
  } ZEND_HASH_FOREACH_END();
}

void vphp_init_native_trait_cache_guard(int module_number) {
  vphp_native_trait_module = module_number;
#ifdef ZTS
  vphp_native_trait_cache_lock = tsrm_mutex_alloc();
#endif
}

void vphp_enable_native_trait_cache_guard(void) {
#ifdef ZTS
  tsrm_mutex_lock(vphp_native_trait_cache_lock);
#endif
  if (zend_inheritance_cache_add && !vphp_previous_inheritance_cache_add) {
    vphp_previous_inheritance_cache_add = zend_inheritance_cache_add;
    zend_inheritance_cache_add = vphp_cache_inheritance_without_native_traits;
  }
#ifdef ZTS
  tsrm_mutex_unlock(vphp_native_trait_cache_lock);
#endif
}

void vphp_release_native_trait_cache_guard(void) {
  if (zend_inheritance_cache_add == vphp_cache_inheritance_without_native_traits) {
    zend_inheritance_cache_add = vphp_previous_inheritance_cache_add;
  }
  vphp_previous_inheritance_cache_add = NULL;
  vphp_native_trait_module = 0;
#ifdef ZTS
  tsrm_mutex_free(vphp_native_trait_cache_lock);
#endif
}

static void vphp_runtime_binding_execute_ex(zend_execute_data *execute_data) {
  uint32_t class_count_before = 0;
  int should_check = 0;

  if (vphp_auto_iface_bindings_len > 0 && !vphp_runtime_binding_applying) {
    class_count_before = zend_hash_num_elements(CG(class_table));
    should_check = 1;
  }

  if (vphp_prev_execute_ex != NULL) {
    vphp_prev_execute_ex(execute_data);
  } else {
    execute_ex(execute_data);
  }

  vphp_check_native_trait_preload();
  vphp_runtime_maybe_apply_bindings(class_count_before, should_check);
}

static void vphp_runtime_binding_execute_internal(zend_execute_data *execute_data,
                                                  zval *return_value) {
  uint32_t class_count_before = 0;
  int should_check = 0;
  int suspend_binding_during_call = 0;
  int prev_binding_applying = 0;
  zend_function *func = NULL;
  zend_string *function_name = NULL;

  if (vphp_auto_iface_bindings_len > 0 && !vphp_runtime_binding_applying) {
    class_count_before = zend_hash_num_elements(CG(class_table));
    should_check = 1;
  }

  func = execute_data != NULL ? execute_data->func : NULL;
  if (func != NULL && func->type == ZEND_INTERNAL_FUNCTION &&
      func->common.scope == NULL && func->common.function_name != NULL) {
    function_name = func->common.function_name;
    if (zend_string_equals_literal(function_name, "interface_exists") ||
        zend_string_equals_literal(function_name, "class_exists") ||
        zend_string_equals_literal(function_name, "trait_exists")) {
      should_check = 0;
      suspend_binding_during_call = 1;
    }
  }

  vphp_runtime_prepare_internal_query_bindings(execute_data);
  vphp_runtime_internal_call_depth++;
  vphp_track_instance_receiver(execute_data);
  if (suspend_binding_during_call) {
    prev_binding_applying = vphp_runtime_binding_applying;
    vphp_runtime_binding_applying = 1;
  }
  if (vphp_prev_execute_internal != NULL) {
    vphp_prev_execute_internal(execute_data, return_value);
  } else {
    execute_internal(execute_data, return_value);
  }
  vphp_finish_reference_scope(execute_data);
  if (suspend_binding_during_call) {
    vphp_runtime_binding_applying = prev_binding_applying;
  }
  if (vphp_runtime_internal_call_depth > 0) {
    vphp_runtime_internal_call_depth--;
  }

  vphp_fiber_gc_after_internal_call(func);
  vphp_runtime_maybe_apply_bindings(class_count_before, should_check);
}

void vphp_install_runtime_binding_hooks(void) {
  if (vphp_runtime_binding_hook_refs++ > 0) {
    return;
  }
  vphp_prev_execute_ex = zend_execute_ex;
  vphp_prev_execute_internal = zend_execute_internal;
  zend_execute_ex = vphp_runtime_binding_execute_ex;
  zend_execute_internal = vphp_runtime_binding_execute_internal;
}

void vphp_uninstall_runtime_binding_hooks(void) {
  if (vphp_runtime_binding_hook_refs == 0) {
    return;
  }
  vphp_runtime_binding_hook_refs--;
  if (vphp_runtime_binding_hook_refs > 0) {
    return;
  }
  if (zend_execute_ex == vphp_runtime_binding_execute_ex) {
    zend_execute_ex = vphp_prev_execute_ex;
  }
  if (zend_execute_internal == vphp_runtime_binding_execute_internal) {
    zend_execute_internal = vphp_prev_execute_internal;
  }
  vphp_prev_execute_ex = NULL;
  vphp_prev_execute_internal = NULL;
}

void *vphp_zend_enum_get_case(void *ce, const char *name, int name_len) {
#if PHP_VERSION_ID >= 80100
  zend_class_entry *entry = ce;
  if (!entry || !(entry->ce_flags & ZEND_ACC_ENUM)) {
    return NULL;
  }
#ifdef CE_CONSTANTS_TABLE
  HashTable *constants = CE_CONSTANTS_TABLE(entry);
#else
  HashTable *constants = &entry->constants_table;
#endif
  zend_class_constant *constant = zend_hash_str_find_ptr(constants, name, name_len);
  if (!constant || !(ZEND_CLASS_CONST_FLAGS(constant) & ZEND_CLASS_CONST_IS_CASE)) {
    return NULL;
  }
  zend_string *zs = zend_string_init(name, name_len, 0);
  zend_object *zo = zend_enum_get_case(entry, zs);
  zend_string_release(zs);
  return (void *)zo;
#else
  return NULL;
#endif
}

void vphp_init_enum_case_alias(zval *value, const char *enum_name,
                              const char *case_name) {
  /* A persistent lookup AST lets Zend resolve the registered case per request. */
  size_t size = sizeof(zend_ast_ref) + zend_ast_size(2) + 2 * sizeof(zend_ast_zval);
  zend_ast_ref *reference = pemalloc(size, 1);
  GC_SET_REFCOUNT(reference, 1);
  GC_TYPE_INFO(reference) = GC_CONSTANT_AST | GC_PERSISTENT | GC_IMMUTABLE;

  zend_ast *lookup = GC_AST(reference);
  lookup->kind = ZEND_AST_CLASS_CONST;
  lookup->attr = ZEND_FETCH_CLASS_EXCEPTION;
  lookup->lineno = 0;
  zend_ast_zval *names = (zend_ast_zval *)((char *)lookup + zend_ast_size(2));
  const char *spellings[] = {enum_name, case_name};
  for (size_t i = 0; i < 2; i++) {
    lookup->child[i] = (zend_ast *)&names[i];
    names[i].kind = ZEND_AST_ZVAL;
    names[i].attr = 0;
    ZVAL_STR(&names[i].val, zend_string_init_interned(spellings[i], strlen(spellings[i]), 1));
    Z_LINENO(names[i].val) = 0;
  }
  Z_TYPE_INFO_P(value) = IS_CONSTANT_AST;
  Z_AST_P(value) = reference;
}

void vphp_zval_set_object_copy(void *z, void *zo) {
  if (z && zo) {
    ZVAL_OBJ_COPY((zval *)z, (zend_object *)zo);
  }
}

bool vphp_object_ce_equals(void *obj, void *ce) {
  if (!obj || !ce) return false;
  return ((zend_object *)obj)->ce == (zend_class_entry *)ce;
}

bool vphp_object_is_instance_of(void *obj, void *ce) {
  if (!obj || !ce) return false;
  return instanceof_function(((zend_object *)obj)->ce, (zend_class_entry *)ce) != 0;
}


