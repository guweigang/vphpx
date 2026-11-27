int64_t vphp_get_lval(zval *z) { return Z_LVAL_P(z); }

void vphp_set_lval(zval *z, int64_t val) { ZVAL_LONG(z, (zend_long)val); }

char *vphp_get_strval(zval *z) { return z ? Z_STRVAL_P(z) : ""; }

int vphp_get_strlen(zval *z) { return z ? Z_STRLEN_P(z) : 0; }

int vphp_get_type(zval *z) { return z ? Z_TYPE_P(z) : IS_UNDEF; }

bool vphp_new_stream_context(zval *options, zval *result) {
  ZVAL_UNDEF(result);
  if (EG(exception) || !options || Z_TYPE_P(options) != IS_ARRAY) {
    return false;
  }

  php_stream_context *context = php_stream_context_alloc();
  zend_string *wrapper;
  zval *wrapper_options;
  ZEND_HASH_FOREACH_STR_KEY_VAL(Z_ARRVAL_P(options), wrapper, wrapper_options) {
    ZVAL_DEREF(wrapper_options);
    if (!wrapper || memchr(ZSTR_VAL(wrapper), '\0', ZSTR_LEN(wrapper)) ||
        Z_TYPE_P(wrapper_options) != IS_ARRAY) {
      goto invalid_options;
    }

    zend_string *name;
    zval *value;
    ZEND_HASH_FOREACH_STR_KEY_VAL(Z_ARRVAL_P(wrapper_options), name, value) {
      if (!name || memchr(ZSTR_VAL(name), '\0', ZSTR_LEN(name))) {
        goto invalid_options;
      }
      php_stream_context_set_option(context, ZSTR_VAL(wrapper), ZSTR_VAL(name), value);
    } ZEND_HASH_FOREACH_END();
  } ZEND_HASH_FOREACH_END();

  ZVAL_RES(result, context->res);
  return true;

invalid_options:
  zend_list_delete(context->res);
  zend_value_error("Stream context options must map wrapper names to arrays with string keys and no null bytes");
  return false;
}

bool vphp_open_stream(const char *path, size_t path_len, const char *mode,
                      size_t mode_len, zval *context_value, bool report_errors,
                      zval *result) {
  ZVAL_UNDEF(result);
  if (EG(exception)) {
    return false;
  }
  if (memchr(path, '\0', path_len) || memchr(mode, '\0', mode_len)) {
    zend_value_error("Stream path and mode must not contain null bytes");
    return false;
  }
  zend_string *filename = zend_string_init(path, path_len, 0);
  zend_string *open_mode = zend_string_init(mode, mode_len, 0);
  vphp_static_sync *sync = vphp_suspend_static_sync();
  php_stream_context *context = php_stream_context_from_zval(context_value, 0);
  php_stream *stream = NULL;
  if (!EG(exception) && (!context_value || context)) {
    stream = php_stream_open_wrapper_ex(ZSTR_VAL(filename), ZSTR_VAL(open_mode),
        report_errors ? REPORT_ERRORS : 0, NULL, context);
  }
  if (stream) {
    php_stream_to_zval(stream, result);
  }
  vphp_resume_static_sync(sync);
  zend_string_release(open_mode);
  zend_string_release(filename);
  return stream && !EG(exception);
}

static php_stream *vphp_stream_from_resource(zval *value) {
  if (!value || Z_TYPE_P(value) != IS_RESOURCE) {
    return NULL;
  }
  return zend_fetch_resource2_ex(value, NULL, php_file_le_stream(), php_file_le_pstream());
}

bool vphp_is_stream_resource(zval *value) {
  return vphp_stream_from_resource(value) != NULL;
}

bool vphp_stream_read_checked(zval *value, int64_t length, zval *result) {
  ZVAL_UNDEF(result);
  if (EG(exception) || length < -1 || !vphp_stream_from_resource(value)) {
    return false;
  }

  smart_str contents = {0};
  char chunk[8192];
  vphp_static_sync *sync = vphp_suspend_static_sync();
  while (length != 0 && !EG(exception)) {
    php_stream *stream = vphp_stream_from_resource(value);
    if (!stream) {
      break;
    }
    size_t limit = length > 0 && length < (int64_t)sizeof(chunk)
        ? (size_t)length : sizeof(chunk);
    ssize_t count = php_stream_read(stream, chunk, limit);
    if (count <= 0) {
      if (length == -1 && count == 0 && !EG(exception) &&
          vphp_stream_from_resource(value) == stream && php_stream_eof(stream)) {
        length = 0;
      }
      break;
    }
    smart_str_appendl(&contents, chunk, (size_t)count);
    if (length > 0) {
      length -= count;
    }
  }
  vphp_resume_static_sync(sync);
  if (length != 0 || EG(exception)) {
    smart_str_free(&contents);
    return false;
  }
  ZVAL_STR(result, smart_str_extract(&contents));
  return true;
}

bool vphp_stream_read_line_fragment(zval *value, size_t max_bytes, zval *result) {
  ZVAL_UNDEF(result);
  if (EG(exception) || max_bytes == 0 || max_bytes == SIZE_MAX ||
      !vphp_stream_from_resource(value)) {
    return false;
  }
  zend_string *line = zend_string_alloc(max_bytes, false);
  size_t length = 0;
  vphp_static_sync *sync = vphp_suspend_static_sync();
  php_stream *stream = EG(exception) ? NULL : vphp_stream_from_resource(value);
  char *read = stream ? php_stream_get_line(stream, ZSTR_VAL(line), max_bytes + 1, &length) : NULL;
  vphp_resume_static_sync(sync);
  if (EG(exception) || !vphp_stream_from_resource(value)) {
    zend_string_release(line);
    return false;
  }
  if (!read || !length) {
    zend_string_release(line);
    ZVAL_EMPTY_STRING(result);
    return true;
  }
  ZSTR_LEN(line) = length;
  ZVAL_STR(result, line);
  return true;
}

bool vphp_stream_read_complete_line(zval *value, size_t max_bytes, zval *result) {
  if (!vphp_stream_read_line_fragment(value, max_bytes, result)) return false;
  if (Z_STRLEN_P(result) && Z_STRVAL_P(result)[Z_STRLEN_P(result) - 1] == '\n') return true;
  zval_ptr_dtor(result);
  ZVAL_UNDEF(result);
  return false;
}

bool vphp_stream_wrapper_data(zval *value, zval *result) {
  ZVAL_UNDEF(result);
  if (EG(exception)) {
    return false;
  }
  php_stream *stream = vphp_stream_from_resource(value);
  if (!stream || Z_ISUNDEF(stream->wrapperdata)) {
    return false;
  }
  ZVAL_COPY(result, &stream->wrapperdata);
  return true;
}

zval *vphp_reference_value(zval *z) {
  if (z == NULL || Z_TYPE_P(z) != IS_REFERENCE) {
    return NULL;
  }
  if (EG(exception) || !vphp_active_static_request()->sync) {
    return Z_REFVAL_P(z);
  }
  zval reference;
  ZVAL_COPY(&reference, z);
  vphp_static_sync *sync = vphp_suspend_static_sync();
  vphp_resume_static_sync(sync);
  // A writeback can invoke a destructor that detaches the original alias.
  // Only return a borrowed referent while another owner still holds the cell.
  zval *result = !EG(exception) && GC_REFCOUNT(Z_REF(reference)) > 1
      ? Z_REFVAL(reference) : NULL;
  zval_ptr_dtor(&reference);
  return result;
}

void vphp_reference_set_zval(zval *z, zval *value) {
  if (z == NULL || value == NULL || Z_TYPE_P(z) != IS_REFERENCE || EG(exception)) {
    return;
  }
  zval reference;
  zval source;
  ZVAL_COPY(&reference, z);
  ZVAL_COPY(&source, value);
  vphp_static_sync *sync = vphp_suspend_static_sync();
  if (!EG(exception)) {
    zval *input = &source;
    ZVAL_DEREF(input);
    if (input != Z_REFVAL(reference)) {
      zval previous;
      zval copy;
      ZVAL_COPY(&previous, Z_REFVAL(reference));
      ZVAL_COPY(&copy, input);
      ZEND_TRY_ASSIGN_REF_VALUE(&reference, &copy);
      zval_ptr_dtor(&previous);
    }
  }
  zval_ptr_dtor(&source);
  zval_ptr_dtor(&reference);
  vphp_resume_static_sync(sync);
}

const char *vphp_get_string_ptr(zval *z, int *len) {
  if (z && Z_TYPE_P(z) == IS_STRING) {
    *len = Z_STRLEN_P(z);
    return Z_STRVAL_P(z);
  }
  *len = 0;
  return "";
}

bool vphp_cast_string(zval *input, zval *output) {
  if (!input || EG(exception)) {
    return false;
  }
  zval value;
  ZVAL_COPY_DEREF(&value, input);
  bool may_call_php = Z_TYPE(value) == IS_OBJECT || Z_TYPE(value) == IS_ARRAY;
  vphp_static_sync *sync = may_call_php ? vphp_suspend_static_sync() : NULL;
  zend_string *text = zval_try_get_string(&value);
  zval_ptr_dtor(&value);
  if (may_call_php) {
    vphp_resume_static_sync(sync);
  }
  if (!text) {
    return false;
  }
  if (EG(exception)) {
    zend_string_release(text);
    return false;
  }
  ZVAL_STR(output, text);
  return true;
}

void vphp_set_strval(zval *z, char *str, int len) { ZVAL_STRINGL(z, str, len); }

void vphp_set_bool(zval *z, bool val) {
  if (val) {
    ZVAL_TRUE(z);
  } else {
    ZVAL_FALSE(z);
  }
}

void vphp_set_double(zval *z, double val) { ZVAL_DOUBLE(z, val); }

void vphp_set_null(zval *z) { ZVAL_NULL(z); }

bool vphp_is_null(zval *z) {
  return z == NULL || Z_TYPE_P(z) == IS_NULL || Z_TYPE_P(z) == IS_UNDEF;
}

int64_t vphp_get_int(zval *z) {
  if (!z) {
    return 0;
  }
  if (Z_TYPE_P(z) == IS_LONG) {
    return Z_LVAL_P(z);
  }
  return 0;
}

double vphp_get_double(zval *z) {
  if (!z) {
    return 0.0;
  }
  if (Z_TYPE_P(z) == IS_DOUBLE) {
    return Z_DVAL_P(z);
  }
  if (Z_TYPE_P(z) == IS_LONG) {
    return (double)Z_LVAL_P(z);
  }
  return 0.0;
}

static void vphp_debug_log_release_zval(const char *phase, zval *z,
                                        int removed) {
  char debug_buf[256];
  int type = -1;
  uint32_t refcount = 0;
  if (vphp_bridge_debug_enabled() == 0) {
    return;
  }
  type = z != NULL ? Z_TYPE_P(z) : -1;
  if (z != NULL && Z_REFCOUNTED_P(z)) {
    refcount = GC_REFCOUNT(Z_COUNTED_P(z));
  }
  snprintf(debug_buf, sizeof(debug_buf),
           "vphp_release_zval %s z=%p type=%d class=%s refcount=%u removed=%d",
           phase, (void *)z, type, vphp_debug_zval_class_name(z), refcount,
           removed);
  vphp_bridge_debug_log("vphp-value-debug",debug_buf);
}

void vphp_convert_to_string(zval *z) {
  if (z && Z_TYPE_P(z) != IS_STRING) {
    convert_to_string(z);
  }
}

static char *vphp_capture_new_zval_origin_ex(int persistent) {
  const char *file = zend_get_executed_filename();
  uint32_t line = zend_get_executed_lineno();
  char buf[256];
  char *out;
  int written;
  const char *func_name = get_active_function_name();

  if (func_name == NULL) {
    written = snprintf(buf, sizeof(buf), "%s:%u",
                       file != NULL ? file : "(unknown)", (unsigned)line);
  } else {
    written = snprintf(buf, sizeof(buf), "%s %s:%u", func_name,
                       file != NULL ? file : "(unknown)", (unsigned)line);
  }
  if (written < 0) {
    return NULL;
  }
  if ((size_t)written >= sizeof(buf)) {
    written = (int)sizeof(buf) - 1;
  }
  out = (char *)pemalloc((size_t)written + 1, persistent);
  if (out == NULL) {
    return NULL;
  }
  memcpy(out, buf, (size_t)written);
  out[written] = '\0';
  return out;
}

static char *vphp_capture_new_zval_origin(void) {
  return vphp_capture_new_zval_origin_ex(0);
}

zval *vphp_new_zval() {
  zval *z = (zval *)emalloc(sizeof(zval));
  if (z == NULL) {
    return NULL;
  }
  ZVAL_UNDEF(z);
  vphp_owned_add(z, vphp_capture_new_zval_origin());
  return z;
}

zval *vphp_new_str(const char *s) {
  zval *z = vphp_new_zval();
  ZVAL_STRING(z, s);
  return z;
}

zval *vphp_new_strl(const char *s, int len) {
  zval *z = vphp_new_zval();
  ZVAL_STRINGL(z, s, len);
  return z;
}

zval *vphp_new_persistent_zval() {
  zval *z = (zval *)pemalloc(sizeof(zval), 1);
  if (z == NULL) {
    return NULL;
  }
  ZVAL_UNDEF(z);
  return z;
}

void vphp_release_persistent_zval(zval *z) {
  if (z == NULL) {
    return;
  }
  zval_ptr_dtor(z);
  pefree(z, 1);
}

void vphp_release_zval_ex(zval *z, int persistent) {
  bool removed = false;
  if (!z) {
    return;
  }
  removed = vphp_owned_remove_ex(z, persistent);
  if (!removed) {
    vphp_debug_log_release_zval("skip_not_owned", z, 0);
    return;
  }
  vphp_debug_log_release_zval("enter_owned", z, removed);
  vphp_autorelease_forget(z);
  vphp_debug_log_release_zval("before_dtor", z, removed);
  vphp_dtor_zval(z);
  vphp_bridge_debug_log("vphp-value-debug","vphp_release_zval after_dtor");
  if (persistent) {
    pefree(z, 1);
  } else {
    efree(z);
  }
  vphp_bridge_debug_log("vphp-value-debug","vphp_release_zval after_free");
}

void vphp_release_zval(zval *z) { vphp_release_zval_ex(z, 0); }

void vphp_release_zval_persistent(zval *z) { vphp_release_zval_ex(z, 1); }

void vphp_disown_zval(zval *z) {
  if (z == NULL) {
    return;
  }
  vphp_autorelease_forget(z);
  (void)vphp_owned_remove(z);
}

void vphp_object_init(zval *z) { object_init(z); }

void vphp_update_property_string(zval *obj, const char *name, int name_len,
                                 const char *value) {
  add_property_stringl(obj, name, value, strlen(value));
}

void vphp_add_property_double(zval *obj, const char *name, double val) {
  add_property_double(obj, name, val);
}

int vphp_array_count(zval *z) {
  return (z && Z_TYPE_P(z) == IS_ARRAY) ? zend_hash_num_elements(Z_ARRVAL_P(z))
                                        : 0;
}

int64_t vphp_array_next_index(zval *z) {
  return Z_ARRVAL_P(z)->nNextFreeElement;
}

void vphp_array_restore_next_index(zval *z, int64_t index) {
  SEPARATE_ARRAY(z);
  Z_ARRVAL_P(z)->nNextFreeElement = (zend_long)index;
}

typedef struct {
  zval source;
  zval target;
} vphp_array_snapshot_node;

static void vphp_snapshot_array_value(zval *target, zval *source,
                                      HashTable *seen, zend_stack *pending) {
  if (Z_TYPE_P(source) != IS_ARRAY && Z_TYPE_P(source) != IS_REFERENCE) {
    ZVAL_COPY(target, source);
    return;
  }

  bool array = Z_TYPE_P(source) == IS_ARRAY;
  zend_ulong key = (zend_ulong)(uintptr_t)(array ? (void *)Z_ARRVAL_P(source)
                                                : (void *)Z_REF_P(source));
  zend_refcounted *existing = zend_hash_index_find_ptr(seen, key);
  if (existing) {
    if (array) {
      ZVAL_ARR(target, (zend_array *)existing);
    } else {
      ZVAL_REF(target, (zend_reference *)existing);
    }
    GC_ADDREF(existing);
    return;
  }

  if (array) {
    array_init_size(target, zend_hash_num_elements(Z_ARRVAL_P(source)));
  } else {
    ZVAL_NEW_EMPTY_REF(target);
    ZVAL_UNDEF(Z_REFVAL_P(target));
  }
  zend_hash_index_add_ptr(seen, key, Z_COUNTED_P(target));
  vphp_array_snapshot_node node;
  ZVAL_COPY_VALUE(&node.source, source);
  ZVAL_COPY_VALUE(&node.target, target);
  zend_stack_push(pending, &node);
}

void vphp_array_snapshot(zval *source, zval *target) {
  HashTable seen;
  zend_stack pending;
  zend_hash_init(&seen, 8, NULL, NULL, 0);
  zend_stack_init(&pending, sizeof(vphp_array_snapshot_node));
  vphp_snapshot_array_value(target, source, &seen, &pending);
  while (!zend_stack_is_empty(&pending)) {
    vphp_array_snapshot_node node = *(vphp_array_snapshot_node *)zend_stack_top(&pending);
    zend_stack_del_top(&pending);
    if (Z_TYPE(node.source) == IS_REFERENCE) {
      vphp_snapshot_array_value(Z_REFVAL(node.target), Z_REFVAL(node.source),
                                &seen, &pending);
      continue;
    }
    HashTable *source_array = Z_ARRVAL(node.source);
    HashTable *target_array = Z_ARRVAL(node.target);
    zend_ulong index;
    zend_string *key;
    zval *source_value;
    ZEND_HASH_FOREACH_KEY_VAL_IND(source_array, index, key, source_value) {
      zval value;
      vphp_snapshot_array_value(&value, source_value, &seen, &pending);
      if (key) {
        zend_hash_add_new(target_array, key, &value);
      } else {
        zend_hash_index_add_new(target_array, index, &value);
      }
    }
    ZEND_HASH_FOREACH_END();
    target_array->nNextFreeElement = source_array->nNextFreeElement;
  }
  zend_stack_destroy(&pending);
  zend_hash_destroy(&seen);
}

zval *vphp_array_get_index(zval *z, int64_t index) {
  return (z && Z_TYPE_P(z) == IS_ARRAY)
             ? zend_hash_index_find(Z_ARRVAL_P(z), (zend_ulong)(zend_long)index)
             : NULL;
}

zval *vphp_array_get_key(zval *array, const char *key, int key_len) {
  return (array && Z_TYPE_P(array) == IS_ARRAY)
             ? zend_hash_str_find(Z_ARRVAL_P(array), key, key_len)
             : NULL;
}

zval *vphp_array_find_string_key(zval *array, const char *key, size_t key_len) {
  return (array && Z_TYPE_P(array) == IS_ARRAY)
             ? zend_symtable_str_find(Z_ARRVAL_P(array), key, key_len)
             : NULL;
}

zval *vphp_array_find_key(zval *array, zval *key) {
  if (!array || Z_TYPE_P(array) != IS_ARRAY || !key) {
    return NULL;
  }
  ZVAL_DEREF(key);
  if (Z_TYPE_P(key) == IS_LONG) {
    return zend_hash_index_find(Z_ARRVAL_P(array), (zend_ulong)Z_LVAL_P(key));
  }
  if (Z_TYPE_P(key) == IS_STRING) {
    return zend_symtable_find(Z_ARRVAL_P(array), Z_STR_P(key));
  }
  return NULL;
}

bool vphp_array_remove_key(zval *array, const char *key, size_t key_len) {
  if (!array || Z_TYPE_P(array) != IS_ARRAY ||
      !zend_symtable_str_exists(Z_ARRVAL_P(array), key, key_len)) {
    return false;
  }
  SEPARATE_ARRAY(array);
  return zend_symtable_str_del(Z_ARRVAL_P(array), key, key_len) == SUCCESS;
}

bool vphp_array_remove_index(zval *array, int64_t index) {
  if (index < ZEND_LONG_MIN || index > ZEND_LONG_MAX) {
    return false;
  }
  zend_ulong key = (zend_ulong)(zend_long)index;
  if (!array || Z_TYPE_P(array) != IS_ARRAY ||
      !zend_hash_index_exists(Z_ARRVAL_P(array), key)) {
    return false;
  }
  SEPARATE_ARRAY(array);
  return zend_hash_index_del(Z_ARRVAL_P(array), key) == SUCCESS;
}

void vphp_array_init(zval *z) { array_init(z); }

// Takes ownership of the value on both success and failure.
static void vphp_array_append(zval *array, zval *value) {
  SEPARATE_ARRAY(array);
  if (add_next_index_zval(array, value) == FAILURE) {
    zval_ptr_dtor(value);
    if (!EG(exception)) {
      zend_throw_error(NULL,
          "Cannot add element to the array as the next element is already occupied");
    }
  }
}

void vphp_array_push_string(zval *z, const char *val) {
  zval value;
  ZVAL_STRING(&value, val);
  vphp_array_append(z, &value);
}

void vphp_array_push_stringl(zval *z, const char *val, int len) {
  zval value;
  ZVAL_STRINGL(&value, val, len);
  vphp_array_append(z, &value);
}

void vphp_array_push_double(zval *z, double val) {
  zval value;
  ZVAL_DOUBLE(&value, val);
  vphp_array_append(z, &value);
}

void vphp_array_push_long(zval *z, int64_t val) {
  zval value;
  ZVAL_LONG(&value, (zend_long)val);
  vphp_array_append(z, &value);
}

void vphp_array_add_assoc_long(zval *z, const char *key, size_t key_len,
                               int64_t val) {
  SEPARATE_ARRAY(z);
  add_assoc_long_ex(z, key, key_len, (zend_long)val);
}

void vphp_array_add_assoc_bool(zval *z, const char *key, size_t key_len, int val) {
  SEPARATE_ARRAY(z);
  add_assoc_bool_ex(z, key, key_len, val != 0);
}

void vphp_array_add_assoc_double(zval *z, const char *key, size_t key_len,
                                 double val) {
  SEPARATE_ARRAY(z);
  add_assoc_double_ex(z, key, key_len, val);
}

void vphp_array_add_assoc_string(zval *z, const char *key, size_t key_len,
                                 const char *val, size_t val_len) {
  SEPARATE_ARRAY(z);
  add_assoc_stringl_ex(z, key, key_len, val, val_len);
}

void vphp_array_add_assoc_zval_len(zval *z, const char *key, size_t len, zval *val) {
  if (z == NULL || key == NULL || val == NULL) {
    return;
  }
  zval copy;
  ZVAL_COPY(&copy, val);
  SEPARATE_ARRAY(z);
  add_assoc_zval_ex(z, key, len, &copy);
}

void vphp_array_add_assoc_zval(zval *z, const char *key, zval *val) {
  if (key) {
    vphp_array_add_assoc_zval_len(z, key, strlen(key), val);
  }
}

void vphp_array_add_index_zval(zval *z, int64_t index, zval *val) {
  if (z == NULL || val == NULL) {
    return;
  }
  zval copy;
  ZVAL_COPY(&copy, val);
  SEPARATE_ARRAY(z);
  add_index_zval(z, (zend_ulong)(zend_long)index, &copy);
}

static zval *vphp_ensure_superglobal_array(const char *name, size_t len,
                                           uint32_t track_vars_index) {
  zval *global = NULL;
  zval *symbol = NULL;
  if (name == NULL || len == 0) {
    return NULL;
  }
  zend_is_auto_global_str((char *)name, len);
  symbol = zend_hash_str_find(&EG(symbol_table), name, len);
  if (symbol != NULL) {
    if (Z_TYPE_P(symbol) != IS_ARRAY) {
      zval_ptr_dtor_nogc(symbol);
      array_init(symbol);
    }
    return symbol;
  }
  global = &PG(http_globals)[track_vars_index];
  if (Z_TYPE_P(global) != IS_ARRAY) {
    zval_ptr_dtor_nogc(global);
    array_init(global);
  }
  return global;
}

void vphp_superglobal_set_env_string(const char *key, const char *val) {
  zval *global = NULL;
  zval zv;
  if (key == NULL || val == NULL) {
    return;
  }
  global = vphp_ensure_superglobal_array("_ENV", sizeof("_ENV") - 1,
                                         TRACK_VARS_ENV);
  if (global == NULL) {
    return;
  }
  ZVAL_STRING(&zv, val);
  zend_hash_str_update(Z_ARRVAL_P(global), key, strlen(key), &zv);
}

zval *vphp_superglobal_get_env(void) {
  return vphp_ensure_superglobal_array("_ENV", sizeof("_ENV") - 1,
                                       TRACK_VARS_ENV);
}

void vphp_superglobal_set_server_string(const char *key, const char *val) {
  zval *global = NULL;
  zval zv;
  if (key == NULL || val == NULL) {
    return;
  }
  global = vphp_ensure_superglobal_array("_SERVER", sizeof("_SERVER") - 1,
                                         TRACK_VARS_SERVER);
  if (global == NULL) {
    return;
  }
  ZVAL_STRING(&zv, val);
  zend_hash_str_update(Z_ARRVAL_P(global), key, strlen(key), &zv);
}

zval *vphp_superglobal_get_server(void) {
  return vphp_ensure_superglobal_array("_SERVER", sizeof("_SERVER") - 1,
                                       TRACK_VARS_SERVER);
}

zval *vphp_superglobal_get_get(void) {
  return vphp_ensure_superglobal_array("_GET", sizeof("_GET") - 1,
                                       TRACK_VARS_GET);
}

zval *vphp_superglobal_get_post(void) {
  return vphp_ensure_superglobal_array("_POST", sizeof("_POST") - 1,
                                       TRACK_VARS_POST);
}

zval *vphp_superglobal_get_cookie(void) {
  return vphp_ensure_superglobal_array("_COOKIE", sizeof("_COOKIE") - 1,
                                       TRACK_VARS_COOKIE);
}

zval *vphp_superglobal_get_files(void) {
  return vphp_ensure_superglobal_array("_FILES", sizeof("_FILES") - 1,
                                       TRACK_VARS_FILES);
}

zval *vphp_superglobal_get_request(void) {
  return vphp_ensure_superglobal_array("_REQUEST", sizeof("_REQUEST") - 1,
                                       TRACK_VARS_REQUEST);
}

void vphp_array_add_next_zval(zval *main_array, zval *sub_item) {
  if (main_array == NULL || sub_item == NULL) {
    return;
  }
  zval copy;
  ZVAL_COPY(&copy, sub_item);
  vphp_array_append(main_array, &copy);
}

void vphp_return_array_start(zval *return_value) { array_init(return_value); }

static void vphp_foreach_value(zval *z, void *ctx,
                               bool (*callback)(void *, zval *, zval *),
                               bool read_key) {
  if (!z) {
    return;
  }

  if (Z_TYPE_P(z) == IS_ARRAY) {
    HashTable *ht = Z_ARRVAL_P(z);
    if (!read_key) {
      zval *value;
      ZEND_HASH_FOREACH_VAL(ht, value) {
        if (EG(exception) || !callback(ctx, NULL, value)) {
          break;
        }
      }
      ZEND_HASH_FOREACH_END();
      return;
    }
    zend_string *key;
    zend_ulong index;
    zval *val;
    ZEND_HASH_FOREACH_KEY_VAL(ht, index, key, val) {
      zval key_zv;
      if (key) {
        ZVAL_STR_COPY(&key_zv, key);
      } else {
        ZVAL_LONG(&key_zv, index);
      }
      bool keep_going = !EG(exception) && callback(ctx, &key_zv, val);
      zval_ptr_dtor(&key_zv);
      if (!keep_going) {
        break;
      }
    }
    ZEND_HASH_FOREACH_END();
    return;
  }

  if (Z_TYPE_P(z) == IS_OBJECT) {
    zend_class_entry *ce = Z_OBJCE_P(z);

    if (ce && ce->get_iterator) {
      if (EG(exception)) {
        return;
      }
      zend_object_iterator *iter = ce->get_iterator(ce, z, 0);
      if (!iter) {
        return;
      }
      iter->index = 0;
      if (!EG(exception) && iter->funcs->rewind) {
        iter->funcs->rewind(iter);
      }
      while (!EG(exception) && iter->funcs->valid(iter) == SUCCESS && !EG(exception)) {
        zval *val = iter->funcs->get_current_data(iter);
        if (!val || EG(exception)) {
          break;
        }
        zval key_zv;
        ZVAL_UNDEF(&key_zv);
        if (read_key && iter->funcs->get_current_key) {
          iter->funcs->get_current_key(iter, &key_zv);
        } else {
          ZVAL_LONG(&key_zv, iter->index);
        }
        bool keep_going = !EG(exception) && callback(ctx, &key_zv, val);
        zval_ptr_dtor(&key_zv);
        if (!keep_going) {
          break;
        }
        if (!EG(exception)) {
          iter->index++;
          iter->funcs->move_forward(iter);
        }
      }
      zend_iterator_dtor(iter);
      return;
    }

    HashTable *ht = Z_OBJPROP_P(z);
    zend_string *key;
    zend_ulong index;
    zval *val;
    ZEND_HASH_FOREACH_KEY_VAL(ht, index, key, val) {
      zval key_zv;
      if (key) {
        ZVAL_STR_COPY(&key_zv, key);
      } else {
        ZVAL_LONG(&key_zv, index);
      }
      bool keep_going = !EG(exception) && callback(ctx, &key_zv, val);
      zval_ptr_dtor(&key_zv);
      if (!keep_going) {
        break;
      }
    }
    ZEND_HASH_FOREACH_END();
  }
}

typedef struct {
  void *ctx;
  void (*callback)(void *, zval *, zval *);
} vphp_foreach_context;

static bool vphp_foreach_all(void *ctx, zval *key, zval *value) {
  vphp_foreach_context *state = ctx;
  state->callback(state->ctx, key, value);
  return true;
}

void vphp_zval_foreach(zval *z, void *ctx,
                       void (*callback)(void *, zval *, zval *)) {
  vphp_foreach_context state = {ctx, callback};
  vphp_foreach_value(z, &state, vphp_foreach_all, true);
}

void vphp_iterable_foreach_while(zval *input, void *ctx,
                                 bool (*callback)(void *, zval *, zval *)) {
  if (!input) {
    return;
  }
  // Keep the traversed value alive if a callback replaces the original.
  zval snapshot;
  ZVAL_COPY_DEREF(&snapshot, input);
  bool traversable = Z_TYPE(snapshot) == IS_OBJECT;
  vphp_static_sync *sync = traversable ? vphp_suspend_static_sync() : NULL;
  vphp_foreach_value(&snapshot, ctx, callback, false);
  zval_ptr_dtor(&snapshot);
  if (traversable) {
    vphp_resume_static_sync(sync);
  }
}

static bool vphp_collect_iterable_entry(void *ctx, zval *key, zval *value) {
  zval entry, key_copy, value_copy;
  array_init_size(&entry, 2);
  ZVAL_COPY_DEREF(&key_copy, key);
  ZVAL_COPY_DEREF(&value_copy, value);
  add_next_index_zval(&entry, &key_copy);
  add_next_index_zval(&entry, &value_copy);
  add_next_index_zval(ctx, &entry);
  return true;
}

static bool vphp_collect_iterable_value(void *ctx, zval *key, zval *value) {
  (void)key;
  zval copy;
  ZVAL_COPY(&copy, value);
  add_next_index_zval(ctx, &copy);
  return true;
}

static bool vphp_collect_iterable_keyed(void *ctx, zval *key, zval *value) {
  zval *output = ctx;
  array_set_zval_key(Z_ARRVAL_P(output), key, value);
  return true;
}

// Keep the values aligned with IterableCollection in vphp/zval/array.v.
enum {
  VPHP_ITERABLE_VALUES,
  VPHP_ITERABLE_ENTRIES,
  VPHP_ITERABLE_KEYED
};

void vphp_iterable_collect(zval *input, zval *output, int shape) {
  bool traversable = Z_TYPE_P(input) == IS_OBJECT;
  vphp_static_sync *sync = traversable ? vphp_suspend_static_sync() : NULL;
  switch (shape) {
    case VPHP_ITERABLE_VALUES:
      vphp_foreach_value(input, output, vphp_collect_iterable_value, false);
      break;
    case VPHP_ITERABLE_ENTRIES:
      vphp_foreach_value(input, output, vphp_collect_iterable_entry, true);
      break;
    case VPHP_ITERABLE_KEYED:
      vphp_foreach_value(input, output, vphp_collect_iterable_keyed, true);
      break;
  }
  if (traversable) {
    vphp_resume_static_sync(sync);
  }
}

static int vphp_count_iterable_item(zend_object_iterator *iter, void *ctx) {
  (void)iter;
  zend_long *count = ctx;
  if (*count == ZEND_LONG_MAX) {
    return ZEND_HASH_APPLY_STOP;
  }
  ++*count;
  return ZEND_HASH_APPLY_KEEP;
}

int64_t vphp_iterable_count(zval *input) {
  if (!input || EG(exception)) {
    return 0;
  }
  if (Z_TYPE_P(input) == IS_ARRAY) {
    return zend_hash_num_elements(Z_ARRVAL_P(input));
  }
  if (Z_TYPE_P(input) != IS_OBJECT || !Z_OBJCE_P(input)->get_iterator) {
    return 0;
  }
  zend_long count = 0;
  vphp_static_sync *sync = vphp_suspend_static_sync();
  spl_iterator_apply(input, vphp_count_iterable_item, &count);
  vphp_resume_static_sync(sync);
  return EG(exception) ? 0 : count;
}

void vphp_array_foreach(zval *z, void *ctx, void (*callback)(void *, zval *)) {
  if (z && Z_TYPE_P(z) == IS_ARRAY) {
    zval *val;
    ZEND_HASH_FOREACH_VAL(Z_ARRVAL_P(z), val) { callback(ctx, val); }
    ZEND_HASH_FOREACH_END();
  }
}

int le_vphp_res;

extern void vphp_release_native_task_resource(void *ptr);
extern void vphp_release_task_dependencies(void *ptr);

void vphp_res_dtor(zend_resource *res) {
  if (res == NULL) {
    return;
  }
  vphp_res_t *wrapper = (vphp_res_t *)res->ptr;
  if (wrapper != NULL) {
    if (wrapper->label != NULL && strcmp(wrapper->label, "v_task") == 0 &&
        wrapper->ptr != NULL) {
      vphp_release_native_task_resource(wrapper->ptr);
      wrapper->ptr = NULL;
    }
    if (wrapper->label && strcmp(wrapper->label, "vphp_task_dependency") == 0 && wrapper->ptr) {
      vphp_release_task_dependencies(wrapper->ptr);
    }
    if (wrapper->label != NULL) {
      efree(wrapper->label);
      wrapper->label = NULL;
    }
    efree(wrapper);
    res->ptr = NULL;
  }
}

void *vphp_task_dependency_ptr(zval *value) {
  if (!value || Z_TYPE_P(value) != IS_RESOURCE || Z_RES_P(value)->type != le_vphp_res) return NULL;
  vphp_res_t *wrapper = Z_RES_P(value)->ptr;
  if (wrapper && wrapper->label && strcmp(wrapper->label, "vphp_task_dependency") == 0) {
    return wrapper->ptr;
  }
  return NULL;
}

void vphp_task_close_dependency(zval *value) {
  if (vphp_task_dependency_ptr(value)) zend_list_close(Z_RES_P(value));
}

void vphp_init_resource_system(int module_number) {
  le_vphp_res = vphp_zend_register_list_destructors_ex(
      vphp_res_dtor, NULL, "VPHP Generic Resource", module_number);
}

void vphp_make_res(zval *return_value, void *ptr, const char *label) {
  if (!ptr) {
    RETVAL_NULL();
    return;
  }
  vphp_res_t *wrapper = emalloc(sizeof(vphp_res_t));
  wrapper->ptr = ptr;
  wrapper->label = estrdup(label != NULL ? label : "");
  RETVAL_RES(vphp_zend_register_resource(wrapper, le_vphp_res));
}

void *vphp_fetch_res(zval *z) {
  vphp_res_t *wrapper = (vphp_res_t *)vphp_zend_fetch_resource(
      Z_RES_P(z), "VPHP Generic Resource", le_vphp_res);
  return wrapper ? wrapper->ptr : NULL;
}

zval *vphp_read_static_property_compat(const char *class_name,
                                       int class_name_len, const char *name,
                                       int name_len, zval *rv) {
  zend_class_entry *ce = vphp_lookup_class_by_name(class_name, class_name_len);
  if (!ce) {
    ZVAL_NULL(rv);
    return rv;
  }
  zval *prop = vphp_zend_read_static_property(ce, name, (size_t)name_len);
  if (!prop) {
    ZVAL_NULL(rv);
    return rv;
  }
  ZVAL_COPY(rv, prop);
  return rv;
}

int vphp_write_static_property_compat(const char *class_name,
                                      int class_name_len, const char *name,
                                      int name_len, zval *value) {
  zend_class_entry *ce = vphp_lookup_class_by_name(class_name, class_name_len);
  if (!ce) {
    return -1;
  }
  vphp_zend_update_static_property(ce, name, (size_t)name_len, value);
  return 0;
}

zval *vphp_read_class_constant_compat(const char *class_name,
                                      int class_name_len, const char *name,
                                      int name_len, zval *rv) {
  zend_string *class_name_str = zend_string_init(class_name, class_name_len, 0);
  zend_string *const_name_str = zend_string_init(name, name_len, 0);
  zval *constant = vphp_zend_get_class_constant(class_name_str, const_name_str);
  zend_string_release(class_name_str);
  zend_string_release(const_name_str);
  if (!constant) {
    ZVAL_NULL(rv);
    return rv;
  }
  ZVAL_COPY(rv, constant);
  return rv;
}

zval *vphp_read_static_property_value(zend_class_entry *ce, const char *name,
                                       size_t name_len) {
  zval *value = vphp_zend_read_static_property(ce, name, name_len);
  if (value) {
    ZVAL_DEREF(value);
  }
  return value;
}

void vphp_write_static_property_value(zend_class_entry *ce, const char *name,
                                        size_t name_len, zval *value) {
  vphp_zend_update_static_property(ce, name, name_len, value);
}

void vphp_update_static_property_long(zend_class_entry *ce, char *name,
                                      int name_len, int64_t val) {
  vphp_zend_update_static_property_long(ce, name, (size_t)name_len,
                                        (zend_long)val);
}

void vphp_update_static_property_string(zend_class_entry *ce, char *name,
                                        int name_len, char *val, int val_len) {
  vphp_zend_update_static_property_string(ce, name, (size_t)name_len, val,
                                          (size_t)val_len);
}

void vphp_update_static_property_bool(zend_class_entry *ce, char *name,
                                      int name_len, int val) {
  vphp_zend_update_static_property_bool(ce, name, (size_t)name_len, val != 0);
}

int64_t vphp_get_static_property_long(zend_class_entry *ce, char *name,
                                      int name_len) {
  zval *rv = vphp_zend_read_static_property(ce, name, (size_t)name_len);
  return rv ? zval_get_long(rv) : 0;
}

char *vphp_get_static_property_string(zend_class_entry *ce, char *name,
                                      int name_len) {
  zval *rv = vphp_zend_read_static_property(ce, name, (size_t)name_len);
  if (rv) {
    zend_string *s = zval_get_string(rv);
    return ZSTR_VAL(s);
  }
  return "";
}

int vphp_get_static_property_bool(zend_class_entry *ce, char *name,
                                  int name_len) {
  zval *rv = vphp_zend_read_static_property(ce, name, (size_t)name_len);
  return rv != NULL && vphp_zend_is_true(rv);
}

char *VPHP_Z_STRVAL(zval *z) { return Z_STRVAL_P(z); }

int VPHP_Z_STRLEN(zval *z) { return Z_STRLEN_P(z); }
void vphp_copy_inherited_value(void *target, void *source) {
  zval *out = target;
  zval *in = source;
  if (in != NULL) {
    ZVAL_DEREF(in);
    if (Z_TYPE_P(in) != IS_UNDEF) {
      ZVAL_COPY(out, in);
    }
  }
}

bool vphp_inherited_value_unchanged(void *before, void *after) {
  zval *old = before;
  zval *current = after;
  if (old == NULL || current == NULL) {
    return old == current;
  }
  ZVAL_DEREF(old);
  ZVAL_DEREF(current);
  if (Z_TYPE_P(old) != Z_TYPE_P(current)) {
    return false;
  }
  switch (Z_TYPE_P(old)) {
    case IS_NULL:
    case IS_FALSE:
    case IS_TRUE:
      return true;
    case IS_LONG:
      return Z_LVAL_P(old) == Z_LVAL_P(current);
    case IS_DOUBLE:
      return memcmp(&Z_DVAL_P(old), &Z_DVAL_P(current), sizeof(double)) == 0;
    case IS_STRING:
      return zend_string_equals(Z_STR_P(old), Z_STR_P(current));
    case IS_ARRAY:
      // The two snapshots share storage until a writer separates the array.
      return Z_ARR_P(old) == Z_ARR_P(current);
    case IS_OBJECT:
      return Z_OBJ_P(old) == Z_OBJ_P(current);
    case IS_RESOURCE:
      return Z_RES_P(old) == Z_RES_P(current);
    default:
      return false;
  }
}
