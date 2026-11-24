static ZEND_NAMED_FUNCTION(vphp_abstract_static_placeholder) {
  zend_throw_error(NULL, "Cannot call abstract method %s::%s()",
                   ZSTR_VAL(EX(func)->common.scope->name),
                   ZSTR_VAL(EX(func)->common.function_name));
}

void vphp_inherit_class_before_properties(zend_class_entry *registered,
                                         zend_class_entry *parent) {
  zend_do_inheritance(registered, parent);
  // The generated registration declares the child's properties after inheritance.
  if (parent->default_properties_count > 0) {
    size_t size = parent->default_properties_count * sizeof(*parent->properties_info_table);
    registered->properties_info_table = pemalloc(size, 1);
    memcpy(registered->properties_info_table, parent->properties_info_table, size);
  }
}

zend_class_entry *vphp_register_class_with_abstract_statics(
    zend_class_entry *ce, zend_class_entry *parent) {
  const zend_function_entry *methods = ce->info.internal.builtin_functions;
  const uint32_t abstract_static = ZEND_ACC_ABSTRACT | ZEND_ACC_STATIC;
  size_t count = 0;
  bool has_abstract_static = false;
  while (methods[count].fname) {
    has_abstract_static |= (methods[count].flags & abstract_static) == abstract_static;
    count++;
  }
  if (!has_abstract_static) {
    return parent ? zend_register_internal_class_ex(ce, parent)
                  : zend_register_internal_class(ce);
  }
  zend_function_entry *entries = safe_emalloc(count + 1, sizeof(*entries), 0);
  memcpy(entries, methods, (count + 1) * sizeof(*entries));

  // Zend warns about abstract static methods in internal class entry tables.
  // Keep static and the original signature for Zend's registration checks.
  for (size_t i = 0; i < count; ++i) {
    if ((entries[i].flags & abstract_static) == abstract_static) {
      entries[i].flags &= ~ZEND_ACC_ABSTRACT;
      entries[i].handler = vphp_abstract_static_placeholder;
    }
  }
  ce->info.internal.builtin_functions = entries;
  zend_class_entry *registered = zend_register_internal_class(ce);
  ce->info.internal.builtin_functions = methods;
  registered->info.internal.builtin_functions = methods;
  efree(entries);

  // Restore the abstract contract before Zend checks inheritance.
  for (size_t i = 0; i < count; ++i) {
    if ((methods[i].flags & abstract_static) == abstract_static) {
      zend_function *method = zend_hash_str_find_ptr_lc(
          &registered->function_table, methods[i].fname, strlen(methods[i].fname));
      ZEND_ASSERT(method != NULL);
      if (method) {
        method->internal_function.handler = NULL;
        method->common.fn_flags |= ZEND_ACC_ABSTRACT;
      }
    }
  }
  registered->ce_flags |= ZEND_ACC_IMPLICIT_ABSTRACT_CLASS | ZEND_ACC_EXPLICIT_ABSTRACT_CLASS;

  if (parent) {
    vphp_inherit_class_before_properties(registered, parent);
  }
  return registered;
}

void vphp_init_registry() {
  if (!vphp_registry_initialized) {
    zend_hash_init(&vphp_object_registry, 16, NULL, NULL, 1);
    zend_hash_init(&vphp_reverse_registry, 16, NULL, NULL, 1);
    vphp_registry_initialized = true;
  }
}

int vphp_object_method_required_params(const zval *value, const char *name,
                                       size_t name_len) {
  if (value == NULL || Z_TYPE_P(value) != IS_OBJECT) {
    return -1;
  }
  const zend_function *method = zend_hash_str_find_ptr_lc(
      &Z_OBJCE_P(value)->function_table, name, name_len);
  return method ? (int)method->common.required_num_args : -1;
}

static void vphp_init_sidecar_registry(void) {
  if (vphp_sidecar_registry_initialized) {
    return;
  }
  memset(&vphp_null_wrapper, 0, sizeof(vphp_null_wrapper));
  zend_hash_init(&vphp_sidecar_registry, 16, NULL, NULL, 1);
  vphp_sidecar_registry_initialized = true;
}

static int vphp_object_uses_inline_wrapper(zend_object *obj) {
  return obj != NULL && obj->handlers->free_obj == vphp_free_object_handler &&
         obj->handlers->offset == offsetof(vphp_object_wrapper, std);
}

static void vphp_init_inherited_handler_registry(void) {
  if (vphp_inherited_handler_registry_initialized) {
    return;
  }
  zend_hash_init(&vphp_inherited_handler_registry, 8, NULL, NULL, 1);
  vphp_inherited_handler_registry_initialized = true;
}

static vphp_object_wrapper *vphp_lookup_sidecar(zend_object *obj) {
  if (!vphp_sidecar_registry_initialized || obj == NULL) {
    return NULL;
  }
  return zend_hash_index_find_ptr(&vphp_sidecar_registry, (zend_ulong)obj);
}

static vphp_object_wrapper *vphp_binding_for_obj(zend_object *obj, int create) {
  vphp_object_wrapper *sidecar = NULL;
  if (obj == NULL) {
    return &vphp_null_wrapper;
  }
  if (vphp_object_uses_inline_wrapper(obj)) {
    return (vphp_object_wrapper *)((char *)(obj)-offsetof(vphp_object_wrapper, std));
  }
  sidecar = vphp_lookup_sidecar(obj);
  if (sidecar != NULL || !create) {
    return sidecar != NULL ? sidecar : &vphp_null_wrapper;
  }
  vphp_init_sidecar_registry();
  sidecar = ecalloc(1, sizeof(vphp_object_wrapper));
  sidecar->magic = VPHP_MAGIC;
  zend_hash_index_update_ptr(&vphp_sidecar_registry, (zend_ulong)obj, sidecar);
  return sidecar;
}

static int vphp_binding_uses_registry(zend_object *obj) {
  return vphp_object_uses_inline_wrapper(obj);
}

void vphp_shutdown_registry() {
  vphp_bridge_debug_log("vphp-bridge-debug","shutdown_registry enter");
  if (vphp_registry_initialized) {
    vphp_bridge_debug_log("vphp-bridge-debug","shutdown_registry object_registry destroy begin");
    zend_hash_destroy(&vphp_object_registry);
    vphp_bridge_debug_log("vphp-bridge-debug","shutdown_registry object_registry destroy done");
    vphp_bridge_debug_log("vphp-bridge-debug","shutdown_registry reverse_registry destroy begin");
    zend_hash_destroy(&vphp_reverse_registry);
    vphp_bridge_debug_log("vphp-bridge-debug","shutdown_registry reverse_registry destroy done");
    vphp_registry_initialized = false;
  }
  if (vphp_sidecar_registry_initialized) {
    vphp_bridge_debug_log("vphp-bridge-debug","shutdown_registry sidecar_registry destroy begin");
    zend_hash_destroy(&vphp_sidecar_registry);
    vphp_bridge_debug_log("vphp-bridge-debug","shutdown_registry sidecar_registry destroy done");
    vphp_sidecar_registry_initialized = false;
  }
  if (vphp_inherited_handler_registry_initialized) {
    zend_object_handlers *handlers = NULL;
    vphp_bridge_debug_log("vphp-bridge-debug","shutdown_registry inherited_handler_registry free begin");
    ZEND_HASH_FOREACH_PTR(&vphp_inherited_handler_registry, handlers) {
      if (handlers != NULL) {
        pefree(handlers, 1);
      }
    }
    ZEND_HASH_FOREACH_END();
    zend_hash_destroy(&vphp_inherited_handler_registry);
    vphp_bridge_debug_log("vphp-bridge-debug","shutdown_registry inherited_handler_registry free done");
    vphp_inherited_handler_registry_initialized = false;
  }
  if (vphp_auto_iface_bindings != NULL) {
    vphp_bridge_debug_log("vphp-bridge-debug","shutdown_registry auto_iface_bindings free begin");
    for (uint32_t i = 0; i < vphp_auto_iface_bindings_len; i++) {
      pefree(vphp_auto_iface_bindings[i].class_name, 1);
      pefree(vphp_auto_iface_bindings[i].iface_name, 1);
    }
    pefree(vphp_auto_iface_bindings, 1);
    vphp_auto_iface_bindings = NULL;
    vphp_bridge_debug_log("vphp-bridge-debug","shutdown_registry auto_iface_bindings free done");
  }
  vphp_auto_iface_bindings_len = 0;
  vphp_auto_iface_bindings_cap = 0;
  vphp_bridge_debug_log("vphp-bridge-debug","shutdown_registry exit");
}

void vphp_register_object(void *v_ptr, zend_object *obj) {
  vphp_init_registry();
  if (v_ptr == NULL || obj == NULL) {
    return;
  }
  zend_hash_index_update_ptr(&vphp_object_registry, (zend_ulong)v_ptr, obj);
  zend_hash_index_update_ptr(&vphp_reverse_registry, (zend_ulong)obj, v_ptr);
}

/* The PHP object is the sole owner of this slot. Borrowed wrappers may
 * disappear or be recreated while their V owner remains alive. */
zval *vphp_owned_object_php_state(void *v_ptr) {
  if (v_ptr == NULL || !vphp_registry_initialized) {
    return NULL;
  }
  zend_object *obj = zend_hash_index_find_ptr(&vphp_object_registry, (zend_ulong)v_ptr);
  if (!vphp_object_uses_inline_wrapper(obj)) {
    return NULL;
  }
  vphp_object_wrapper *wrapper = vphp_binding_for_obj(obj, 0);
  if (!wrapper->owns_v_ptr || wrapper->v_ptr != v_ptr) {
    return NULL;
  }
  if (Z_ISUNDEF(wrapper->php_state)) {
    array_init(&wrapper->php_state);
  }
  return &wrapper->php_state;
}

static bool vphp_weak_map_accepts_key(zval *map, zval *key) {
  return !EG(exception) && map && key && Z_TYPE_P(map) == IS_OBJECT &&
      Z_TYPE_P(key) == IS_OBJECT &&
      zend_string_equals_literal(Z_OBJCE_P(map)->name, "WeakMap");
}

zval *vphp_weak_map_find(zval *map, zval *key, bool reference) {
  if (!vphp_weak_map_accepts_key(map, key)) {
    return NULL;
  }
  // BP_VAR_IS keeps an absent key silent while preserving a stored null.
  zval scratch;
  ZVAL_UNDEF(&scratch);
  zend_object *object = Z_OBJ_P(map);
  zval *value = object->handlers->read_dimension(object, key, BP_VAR_IS, &scratch);
  zval *copy = NULL;
  if (value && !Z_ISUNDEF_P(value) && !EG(exception) &&
      (!reference || Z_ISREF_P(value))) {
    copy = vphp_new_zval();
    if (reference) {
      ZVAL_COPY(copy, value);
    } else {
      ZVAL_COPY_DEREF(copy, value);
    }
  }
  zval_ptr_dtor(&scratch);
  return copy;
}

bool vphp_weak_map_bind_reference(zval *map, zval *key, zval *reference) {
  if (!vphp_weak_map_accepts_key(map, key) || !reference || !Z_ISREF_P(reference)) {
    return false;
  }
  // Publishing static state and replacing a value can both run PHP destructors.
  zval map_copy, key_copy, ref_copy;
  ZVAL_COPY(&map_copy, map);
  ZVAL_COPY(&key_copy, key);
  ZVAL_COPY(&ref_copy, reference);
  vphp_static_sync *sync = vphp_suspend_static_sync();
  zend_object *object = Z_OBJ(map_copy);
  bool bound = !EG(exception);
#if PHP_VERSION_ID < 80600
  // A reference assignment requires an existing key before PHP 8.6.
  if (bound) {
    zval scratch;
    ZVAL_UNDEF(&scratch);
    zval *value = object->handlers->read_dimension(object, &key_copy, BP_VAR_IS, &scratch);
    bound = value && !Z_ISUNDEF_P(value) && !EG(exception);
    zval_ptr_dtor(&scratch);
  }
#endif
  if (bound) {
    object->handlers->write_dimension(object, &key_copy, &ref_copy);
  }
  zval_ptr_dtor(&ref_copy);
  zval_ptr_dtor(&key_copy);
  zval_ptr_dtor(&map_copy);
  vphp_resume_static_sync(sync);
  return bound && !EG(exception);
}

bool vphp_lazy_objects_supported(void) {
#if PHP_VERSION_ID >= 80400
  return true;
#else
  return false;
#endif
}

bool vphp_clone_with_supported(void) {
#if PHP_VERSION_ID >= 80500
  return true;
#else
  return false;
#endif
}

bool vphp_object_is_uninitialized_lazy(zval *value) {
#if PHP_VERSION_ID >= 80400
  return value && Z_TYPE_P(value) == IS_OBJECT &&
      !zend_lazy_object_initialized(Z_OBJ_P(value));
#else
  (void)value;
  return false;
#endif
}

void vphp_return_obj(zval *return_value, void *v_ptr, zend_class_entry *ce) {
  char debug_buf[256];
  int debug_on = vphp_bridge_debug_enabled();
  if (!v_ptr) {
    ZVAL_NULL(return_value);
    return;
  }
  vphp_init_registry();
  zend_object *existing_obj =
      zend_hash_index_find_ptr(&vphp_object_registry, (zend_ulong)v_ptr);
  if (existing_obj) {
    if (GC_FLAGS(existing_obj) & IS_OBJ_DESTRUCTOR_CALLED) {
      if (debug_on) {
        snprintf(debug_buf, sizeof(debug_buf),
                 "vphp_return_obj skip stale existing_obj=%p v_ptr=%p class=%s flags=%u",
                 (void *)existing_obj, v_ptr,
                 existing_obj->ce && existing_obj->ce->name
                     ? ZSTR_VAL(existing_obj->ce->name)
                     : "(null)",
                 (unsigned)GC_FLAGS(existing_obj));
        vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
      }
      zend_hash_index_del(&vphp_object_registry, (zend_ulong)v_ptr);
      existing_obj = NULL;
    }
  }
  if (existing_obj) {
    if (!ce || existing_obj->ce == ce ||
        instanceof_function(existing_obj->ce, ce)) {
      if (debug_on) {
        snprintf(debug_buf, sizeof(debug_buf),
                 "vphp_return_obj reuse existing_obj=%p v_ptr=%p class=%s ce=%s flags=%u refcount=%u",
                 (void *)existing_obj, v_ptr,
                 existing_obj->ce && existing_obj->ce->name
                     ? ZSTR_VAL(existing_obj->ce->name)
                     : "(null)",
                 ce && ce->name ? ZSTR_VAL(ce->name) : "(null)",
                 (unsigned)GC_FLAGS(existing_obj),
                 (unsigned)GC_REFCOUNT(existing_obj));
        vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
      }
      GC_ADDREF(existing_obj);
      ZVAL_OBJ(return_value, existing_obj);
      return;
    }
    zend_hash_index_del(&vphp_object_registry, (zend_ulong)v_ptr);
  }
  if (debug_on) {
    snprintf(debug_buf, sizeof(debug_buf),
             "vphp_return_obj object_init_ex begin return_value=%p v_ptr=%p ce=%p ce_name=%s create_object=%p",
             (void *)return_value, v_ptr, (void *)ce,
             ce && ce->name ? ZSTR_VAL(ce->name) : "(null)",
             ce != NULL ? (void *)ce->create_object : NULL);
    vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  }
  object_init_ex(return_value, ce);
  if (debug_on) {
    snprintf(debug_buf, sizeof(debug_buf),
             "vphp_return_obj object_init_ex done return_value=%p type=%d obj=%p ce_name=%s",
             (void *)return_value, return_value != NULL ? Z_TYPE_P(return_value) : -1,
             return_value != NULL && Z_TYPE_P(return_value) == IS_OBJECT
                 ? (void *)Z_OBJ_P(return_value)
                 : NULL,
             ce && ce->name ? ZSTR_VAL(ce->name) : "(null)");
    vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  }
  zend_object *new_obj = Z_OBJ_P(return_value);
  vphp_object_wrapper *wrapper = vphp_binding_for_obj(new_obj, 1);
  if (wrapper != &vphp_null_wrapper) {
    wrapper->v_ptr = v_ptr;
  }
  if (debug_on) {
    snprintf(debug_buf, sizeof(debug_buf),
             "vphp_return_obj new_obj=%p v_ptr=%p class=%s ce=%s",
             (void *)new_obj, v_ptr,
             new_obj && new_obj->ce && new_obj->ce->name
                 ? ZSTR_VAL(new_obj->ce->name)
                 : "(null)",
             ce && ce->name ? ZSTR_VAL(ce->name) : "(null)");
    vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  }
  vphp_register_object(v_ptr, new_obj);
}

void vphp_return_bound_object(zval *return_value, void *v_ptr,
                              zend_class_entry *ce, vphp_class_handlers *h,
                              int owns_v_ptr) {
  extern void vphp_ensure_vptr_root(void *ptr);
  char debug_buf[256];
  int debug_on = vphp_bridge_debug_enabled();
  if (debug_on) {
    snprintf(debug_buf, sizeof(debug_buf),
             "vphp_return_bound_object enter return_value=%p v_ptr=%p ce=%p ce_name=%s handlers=%p owns=%d",
             (void *)return_value, v_ptr, (void *)ce,
             ce && ce->name ? ZSTR_VAL(ce->name) : "(null)", (void *)h,
             owns_v_ptr);
    vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  }
  if (owns_v_ptr == VPHP_OWNS_VPTR && v_ptr != NULL) {
    vphp_ensure_vptr_root(v_ptr);
  }
  vphp_return_obj(return_value, v_ptr, ce);
  if (Z_TYPE_P(return_value) == IS_OBJECT && h != NULL) {
    zend_object *object = Z_OBJ_P(return_value);
    vphp_object_wrapper *wrapper = vphp_binding_for_obj(object, 0);
    bool initialize = v_ptr && owns_v_ptr == VPHP_OWNS_VPTR &&
        h->init_php_state && vphp_object_uses_inline_wrapper(object) &&
        !wrapper->owns_v_ptr;
    vphp_bind_handlers_with_ownership(object, h, owns_v_ptr);
    if (initialize && !EG(exception)) {
      h->init_php_state(v_ptr);
    }
  }
  if (debug_on) {
    snprintf(debug_buf, sizeof(debug_buf),
             "vphp_return_bound_object exit return_value=%p type=%d obj=%p",
             (void *)return_value, return_value != NULL ? Z_TYPE_P(return_value) : -1,
             return_value != NULL && Z_TYPE_P(return_value) == IS_OBJECT
                 ? (void *)Z_OBJ_P(return_value)
                 : NULL);
    vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  }
}

void vphp_return_owned_object(zval *return_value, void *v_ptr,
                              zend_class_entry *ce, vphp_class_handlers *h) {
  vphp_return_bound_object(return_value, v_ptr, ce, h, VPHP_OWNS_VPTR);
}

void vphp_return_borrowed_object(zval *return_value, void *v_ptr,
                                 zend_class_entry *ce,
                                 vphp_class_handlers *h) {
  vphp_return_bound_object(return_value, v_ptr, ce, h, VPHP_BORROWS_VPTR);
}

void vphp_wrap_existing_object(zval *return_value, zend_object *obj) {
  if (return_value == NULL) {
    return;
  }
  if (obj == NULL) {
    ZVAL_NULL(return_value);
    return;
  }
  GC_ADDREF(obj);
  ZVAL_OBJ(return_value, obj);
}

void *vphp_allocate_contiguous_object(zend_class_entry *ce, size_t v_size) {
  (void)ce;
  if (v_size == 0) {
    return NULL;
  }
  /* Matches generic_free_raw's C.builtin___v_free release path. */
  return calloc(1, v_size);
}

void vphp_object_addref(zend_object *obj) {
  if (obj == NULL) {
    return;
  }
  GC_ADDREF(obj);
}

void vphp_object_release(zend_object *obj) {
  if (obj == NULL) {
    return;
  }
  OBJ_RELEASE(obj);
}

vphp_object_wrapper *vphp_obj_from_obj(zend_object *obj) {
  vphp_object_wrapper *wrapper = vphp_binding_for_obj(obj, 0);
  if (wrapper == &vphp_null_wrapper) {
    return wrapper;
  }
  if (vphp_registry_initialized && obj != NULL) {
    void *rev_ptr =
        zend_hash_index_find_ptr(&vphp_reverse_registry, (zend_ulong)obj);
    if (rev_ptr != NULL) {
      if (wrapper->v_ptr != rev_ptr) {
        wrapper->v_ptr = rev_ptr;
      }
    } else if (wrapper->v_ptr != NULL) {
      zend_object *mapped = zend_hash_index_find_ptr(&vphp_object_registry,
                                                     (zend_ulong)wrapper->v_ptr);
      if (mapped == obj) {
        zend_hash_index_update_ptr(&vphp_reverse_registry, (zend_ulong)obj,
                                   wrapper->v_ptr);
      }
    }
  }
  return wrapper;
}

zend_object *vphp_get_obj_from_zval(zval *zv) { return Z_OBJ_P(zv); }

void *vphp_get_v_ptr_from_zval(zval *zv) {
  if (!zv || Z_TYPE_P(zv) != IS_OBJECT) {
    return NULL;
  }
  return vphp_bound_object_pointer(Z_OBJ_P(zv));
}

static const zend_object_handlers *vphp_original_handlers_for(zend_object *obj) {
  vphp_object_wrapper *wrapper = NULL;
  if (obj == NULL) {
    return zend_get_std_object_handlers();
  }
  wrapper = vphp_obj_from_obj(obj);
  if (wrapper != NULL && wrapper != &vphp_null_wrapper &&
      wrapper->original_handlers != NULL) {
    return wrapper->original_handlers;
  }
  return zend_get_std_object_handlers();
}

static int vphp_has_property(zend_object *object, zend_string *member, int mode,
                             void **cache_slot);
static void vphp_unset_property(zend_object *object, zend_string *member,
                                void **cache_slot);
static zval *vphp_get_property_ptr_ptr(zend_object *object, zend_string *member,
                                       int type, void **cache_slot);

static zend_object_handlers *vphp_clone_inherited_handlers(
    const zend_object_handlers *original_handlers) {
  zend_object_handlers *cloned = NULL;
  if (original_handlers == NULL) {
    return NULL;
  }
  vphp_init_inherited_handler_registry();
  cloned = zend_hash_index_find_ptr(&vphp_inherited_handler_registry,
                                    (zend_ulong)original_handlers);
  if (cloned != NULL) {
    return cloned;
  }
  cloned = pemalloc(sizeof(zend_object_handlers), 1);
  memcpy(cloned, original_handlers, sizeof(zend_object_handlers));
  cloned->read_property = vphp_read_property;
  cloned->write_property = vphp_write_property;
  cloned->has_property = vphp_has_property;
  cloned->unset_property = vphp_unset_property;
  cloned->get_property_ptr_ptr = vphp_get_property_ptr_ptr;
  cloned->get_properties = vphp_get_properties;
  zend_hash_index_update_ptr(&vphp_inherited_handler_registry,
                             (zend_ulong)original_handlers, cloned);
  return cloned;
}

static const zend_object_handlers *vphp_unwrap_inherited_handlers(
    const zend_object_handlers *handlers) {
  const zend_object_handlers *current = handlers;
  if (current == NULL || !vphp_inherited_handler_registry_initialized) {
    return current;
  }
  for (;;) {
    zend_object_handlers *cloned = NULL;
    zend_ulong original_key = 0;
    int unwrapped = 0;
    ZEND_HASH_FOREACH_NUM_KEY_PTR(&vphp_inherited_handler_registry, original_key,
                                  cloned) {
      if ((const zend_object_handlers *)cloned == current) {
        current = (const zend_object_handlers *)original_key;
        unwrapped = 1;
        break;
      }
    }
    ZEND_HASH_FOREACH_END();
    if (!unwrapped) {
      return current;
    }
  }
}

static const zend_object_handlers *vphp_fallback_handlers(
    const zend_object_handlers *handlers) {
  return handlers != NULL ? handlers : zend_get_std_object_handlers();
}

static zend_object *vphp_resolve_inherited_parent_object(
    zend_class_entry *ce,
    zend_object *(*self_create_object)(zend_class_entry *)) {
  zend_class_entry *cursor = ce != NULL ? ce->parent : NULL;
  while (cursor != NULL) {
    if (cursor->create_object != NULL &&
        cursor->create_object != self_create_object) {
      return cursor->create_object(ce);
    }
    cursor = cursor->parent;
  }
  return NULL;
}

static const char *vphp_debug_object_class_name(zend_object *obj) {
  if (obj == NULL || obj->ce == NULL || obj->ce->name == NULL) {
    return "(null)";
  }
  return ZSTR_VAL(obj->ce->name);
}



void vphp_free_object_handler(zend_object *obj) {
  vphp_object_wrapper *wrapper = vphp_obj_from_obj(obj);
  const zend_object_handlers *original_handlers = vphp_original_handlers_for(obj);
  void *owned_v_ptr = NULL;
  void (*cleanup_raw)(void *) = NULL;
  void (*free_raw)(void *) = NULL;
  int owns_v_ptr = 0;
  int uses_inline_wrapper = vphp_object_uses_inline_wrapper(obj);
  int has_sidecar_wrapper =
      !uses_inline_wrapper && wrapper != NULL && wrapper != &vphp_null_wrapper;
  char debug_buf[256];
  int debug_on = vphp_bridge_debug_enabled();
  if (wrapper) {
    owned_v_ptr = wrapper->v_ptr;
    cleanup_raw = wrapper->cleanup_raw;
    free_raw = wrapper->free_raw;
    owns_v_ptr = wrapper->owns_v_ptr;
    if (wrapper->unset_bound_properties != NULL) {
      zend_array_release(wrapper->unset_bound_properties);
      wrapper->unset_bound_properties = NULL;
    }
  }
  if (debug_on) {
    snprintf(debug_buf, sizeof(debug_buf),
             "vphp_free_object_handler enter obj=%p class=%s wrapper=%p v_ptr=%p owns=%d inline=%d sidecar=%d original_free=%p",
             (void *)obj, vphp_debug_object_class_name(obj), (void *)wrapper,
             owned_v_ptr, owns_v_ptr, uses_inline_wrapper, has_sidecar_wrapper,
             original_handlers != NULL ? (void *)original_handlers->free_obj : NULL);
    vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  }
  if (vphp_registry_initialized && obj) {
    void *mapped_v_ptr =
        zend_hash_index_find_ptr(&vphp_reverse_registry, (zend_ulong)obj);
    if (debug_on) {
      snprintf(debug_buf, sizeof(debug_buf),
               "vphp_free_object_handler reverse_registry obj=%p class=%s mapped_v_ptr=%p",
               (void *)obj, vphp_debug_object_class_name(obj), mapped_v_ptr);
      vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    }
    if (mapped_v_ptr) {
      zend_object *mapped = zend_hash_index_find_ptr(&vphp_object_registry,
                                                     (zend_ulong)mapped_v_ptr);
      if (debug_on) {
        snprintf(debug_buf, sizeof(debug_buf),
                 "vphp_free_object_handler reverse_registry mapped obj=%p class=%s mapped_v_ptr=%p mapped_obj=%p",
                 (void *)obj, vphp_debug_object_class_name(obj), mapped_v_ptr,
                 (void *)mapped);
        vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
      }
      if (mapped == obj) {
        zend_hash_index_del(&vphp_object_registry, (zend_ulong)mapped_v_ptr);
        if (debug_on) {
          snprintf(debug_buf, sizeof(debug_buf),
                   "vphp_free_object_handler object_registry deleted by reverse obj=%p class=%s mapped_v_ptr=%p",
                   (void *)obj, vphp_debug_object_class_name(obj), mapped_v_ptr);
          vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
        }
      }
      zend_hash_index_del(&vphp_reverse_registry, (zend_ulong)obj);
      if (debug_on) {
        snprintf(debug_buf, sizeof(debug_buf),
                 "vphp_free_object_handler reverse_registry deleted obj=%p class=%s",
                 (void *)obj, vphp_debug_object_class_name(obj));
        vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
      }
    }
  }
  if (vphp_registry_initialized && wrapper && wrapper->v_ptr) {
    zend_object *mapped = zend_hash_index_find_ptr(&vphp_object_registry,
                                                   (zend_ulong)wrapper->v_ptr);
    if (debug_on) {
      snprintf(debug_buf, sizeof(debug_buf),
               "vphp_free_object_handler wrapper_registry obj=%p class=%s wrapper_v_ptr=%p mapped_obj=%p",
               (void *)obj, vphp_debug_object_class_name(obj), wrapper->v_ptr,
               (void *)mapped);
      vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    }
    if (mapped == obj) {
      zend_hash_index_del(&vphp_object_registry, (zend_ulong)wrapper->v_ptr);
      if (debug_on) {
        snprintf(debug_buf, sizeof(debug_buf),
                 "vphp_free_object_handler object_registry deleted by wrapper obj=%p class=%s wrapper_v_ptr=%p",
                 (void *)obj, vphp_debug_object_class_name(obj), wrapper->v_ptr);
        vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
      }
    }
  }
  if (uses_inline_wrapper && wrapper) {
    if (debug_on) {
      snprintf(debug_buf, sizeof(debug_buf),
               "vphp_free_object_handler clear_inline_wrapper begin obj=%p class=%s wrapper=%p",
               (void *)obj, vphp_debug_object_class_name(obj), (void *)wrapper);
      vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    }
    wrapper->v_ptr = NULL;
    wrapper->owns_v_ptr = 0;
    wrapper->cleanup_raw = NULL;
    wrapper->free_raw = NULL;
    wrapper->prop_handler = NULL;
    wrapper->write_handler = NULL;
    wrapper->sync_handler = NULL;
    wrapper->original_handlers = NULL;
    zval php_state;
    ZVAL_COPY_VALUE(&php_state, &wrapper->php_state);
    ZVAL_UNDEF(&wrapper->php_state);
    zval_ptr_dtor(&php_state);
    if (debug_on) {
      snprintf(debug_buf, sizeof(debug_buf),
               "vphp_free_object_handler clear_inline_wrapper done obj=%p class=%s wrapper=%p",
               (void *)obj, vphp_debug_object_class_name(obj), (void *)wrapper);
      vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    }
  }
  if (original_handlers != NULL && original_handlers->free_obj != NULL &&
      original_handlers->free_obj != vphp_free_object_handler) {
    if (debug_on) {
      snprintf(debug_buf, sizeof(debug_buf),
               "vphp_free_object_handler original_free begin obj=%p class=%s free_obj=%p",
               (void *)obj, vphp_debug_object_class_name(obj),
               (void *)original_handlers->free_obj);
      vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    }
    original_handlers->free_obj(obj);
    if (debug_on) {
      snprintf(debug_buf, sizeof(debug_buf),
               "vphp_free_object_handler original_free done obj=%p class=%s free_obj=%p",
               (void *)obj, vphp_debug_object_class_name(obj),
               (void *)original_handlers->free_obj);
      vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    }
  } else {
    if (debug_on) {
      snprintf(debug_buf, sizeof(debug_buf),
               "vphp_free_object_handler std_dtor begin obj=%p class=%s",
               (void *)obj, vphp_debug_object_class_name(obj));
      vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    }
    zend_object_std_dtor(obj);
    if (debug_on) {
      snprintf(debug_buf, sizeof(debug_buf),
               "vphp_free_object_handler std_dtor done obj=%p class=%s",
               (void *)obj, vphp_debug_object_class_name(obj));
      vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    }
  }
  if (debug_on) {
    snprintf(debug_buf, sizeof(debug_buf),
             "vphp_free_object_handler post_std_dtor obj=%p class=%s sidecar=%d",
             (void *)obj, vphp_debug_object_class_name(obj), has_sidecar_wrapper);
    vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  }
  if (owns_v_ptr && owned_v_ptr) {
    if (debug_on) {
      snprintf(debug_buf, sizeof(debug_buf),
               "vphp_free_object_handler owned cleanup obj=%p v_ptr=%p cleanup=%p free=%p",
               (void *)obj, owned_v_ptr, (void *)cleanup_raw, (void *)free_raw);
      vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    }
    if (cleanup_raw) {
      cleanup_raw(owned_v_ptr);
    }
    if (free_raw) {
      free_raw(owned_v_ptr);
    }
    if (debug_on) {
      snprintf(debug_buf, sizeof(debug_buf),
               "vphp_free_object_handler owned cleanup done obj=%p v_ptr=%p",
               (void *)obj, owned_v_ptr);
      vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    }
  }
  if (has_sidecar_wrapper && vphp_sidecar_registry_initialized && obj != NULL) {
    if (debug_on) {
      snprintf(debug_buf, sizeof(debug_buf),
               "vphp_free_object_handler sidecar_cleanup begin obj=%p class=%s wrapper=%p",
               (void *)obj, vphp_debug_object_class_name(obj), (void *)wrapper);
      vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    }
    zend_hash_index_del(&vphp_sidecar_registry, (zend_ulong)obj);
    wrapper->v_ptr = NULL;
    wrapper->owns_v_ptr = 0;
    wrapper->cleanup_raw = NULL;
    wrapper->free_raw = NULL;
    wrapper->prop_handler = NULL;
    wrapper->write_handler = NULL;
    wrapper->sync_handler = NULL;
    wrapper->original_handlers = NULL;
    efree(wrapper);
    if (debug_on) {
      snprintf(debug_buf, sizeof(debug_buf),
               "vphp_free_object_handler sidecar_cleanup done obj=%p class=%s",
               (void *)obj, vphp_debug_object_class_name(obj));
      vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    }
  }
  if (debug_on) {
    snprintf(debug_buf, sizeof(debug_buf),
             "vphp_free_object_handler exit obj=%p class=%s", (void *)obj,
             vphp_debug_object_class_name(obj));
    vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  }
}

#if PHP_VERSION_ID >= 80400
static bool vphp_has_zend_property_operation(zend_object *object,
                                            zend_string *member,
                                            zend_property_hook_kind kind) {
  if (!object->ce->num_hooked_props) {
    return false;
  }
  const zend_property_info *prop =
      zend_hash_find_ptr(&object->ce->properties_info, member);
  return prop && prop->hooks &&
      ((prop->flags & ZEND_ACC_VIRTUAL) || prop->hooks[kind]);
}
#endif

static bool vphp_property_was_unset(const vphp_object_wrapper *wrapper,
                                    zend_string *member) {
  return wrapper->unset_bound_properties != NULL &&
      zend_hash_exists(wrapper->unset_bound_properties, member);
}

static bool vphp_read_v_field(vphp_object_wrapper *wrapper,
                             zend_string *member, zval *rv) {
  if (!wrapper->v_ptr || !wrapper->prop_handler) {
    return false;
  }
  ZVAL_UNDEF(rv);
  wrapper->prop_handler(wrapper->v_ptr, ZSTR_VAL(member),
                        (int)ZSTR_LEN(member), rv);
  return !Z_ISUNDEF_P(rv);
}

static bool vphp_read_bound_property(vphp_object_wrapper *wrapper,
                                     zend_string *member, zval *rv) {
  return !vphp_property_was_unset(wrapper, member) &&
      vphp_read_v_field(wrapper, member, rv);
}

static zend_property_info *vphp_reference_property_info(zend_object *object,
                                                        zend_string *member) {
  zend_property_info *info = zend_hash_find_ptr(&object->ce->properties_info, member);
  if (info == NULL || !(info->flags & ZEND_ACC_PUBLIC) ||
      (info->flags & (ZEND_ACC_STATIC | ZEND_ACC_READONLY))) {
    return NULL;
  }
#if PHP_VERSION_ID >= 80400
  if (info->hooks || (info->flags & ZEND_ACC_VIRTUAL)) {
    return NULL;
  }
#endif
  return info;
}

static bool vphp_is_reference_slot(zend_object *object,
                                   const vphp_object_wrapper *wrapper,
                                   zend_string *member) {
  zend_property_info *info = wrapper->may_have_bound_references
      ? vphp_reference_property_info(object, member) : NULL;
  return info && Z_ISREF_P(OBJ_PROP(object, info->offset));
}

bool vphp_skip_bound_property_projection(zend_object *obj, const char *name,
                                         int name_len) {
  const vphp_object_wrapper *wrapper = vphp_obj_from_obj(obj);
  if (wrapper->unset_bound_properties != NULL &&
      zend_hash_str_exists(wrapper->unset_bound_properties, name, name_len)) {
    return true;
  }
  if (!wrapper->may_have_bound_references) {
    return false;
  }
  zend_string *member = zend_string_init(name, name_len, 0);
  bool referenced = vphp_is_reference_slot(obj, wrapper, member);
  zend_string_release(member);
  return referenced;
}

static zval *vphp_read_referenced_v_field(zend_object *object,
                                          vphp_object_wrapper *wrapper,
                                          int index, zval *current) {
  zval *slot = OBJ_PROP_NUM(object, index);
  if (!Z_ISREF_P(slot)) {
    return NULL;
  }
  zend_property_info *info = object->ce->properties_info_table[index];
  if (!info || !vphp_reference_property_info(object, info->name) ||
      !vphp_read_v_field(wrapper, info->name, current)) {
    return NULL;
  }
  return slot;
}

static int vphp_compare_bound_reference_values(const void *previous, const void *current) {
  zval *before = (zval *)previous;
  zval *after = (zval *)current;
  // Keep nested references as identities. This also avoids recursing into
  // a PHP array that reaches itself through a reference.
  if (Z_ISREF_P(before) || Z_ISREF_P(after)) {
    return !(Z_ISREF_P(before) && Z_ISREF_P(after) &&
             Z_REF_P(before) == Z_REF_P(after));
  }
  if (vphp_inherited_value_unchanged(before, after)) {
    return 0;
  }
  // A detached V array can materialize a fresh Zend array on every read.
  if (Z_TYPE_P(before) == IS_ARRAY && Z_TYPE_P(after) == IS_ARRAY &&
      Z_ARRVAL_P(before)->nNextFreeElement == Z_ARRVAL_P(after)->nNextFreeElement) {
    return zend_hash_compare(Z_ARRVAL_P(before), Z_ARRVAL_P(after),
                             vphp_compare_bound_reference_values, true);
  }
  return 1;
}

static void vphp_import_bound_references(zend_object *object, HashTable **baseline) {
  vphp_object_wrapper *wrapper = vphp_obj_from_obj(object);
  if (baseline && *baseline != NULL) {
    zend_hash_clean(*baseline);
  }
  if (!wrapper->may_have_bound_references) {
    return;
  }
  for (int index = 0; index < object->ce->default_properties_count; index++) {
    zval current;
    zval *slot = vphp_read_referenced_v_field(object, wrapper, index, &current);
    if (slot == NULL) {
      continue;
    }
    zend_string *name = object->ce->properties_info_table[index]->name;
    if (vphp_property_was_unset(wrapper, name)) {
      zend_hash_del(wrapper->unset_bound_properties, name);
    }
    if (vphp_compare_bound_reference_values(&current, Z_REFVAL_P(slot)) != 0) {
      wrapper->write_handler(wrapper->v_ptr, ZSTR_VAL(name), (int)ZSTR_LEN(name),
                             Z_REFVAL_P(slot));
      if (baseline) {
        zval_ptr_dtor(&current);
        if (!vphp_read_v_field(wrapper, name, &current)) {
          continue;
        }
      }
    }
    if (baseline) {
      if (*baseline == NULL) {
        *baseline = zend_new_array(1);
      }
      zval snapshot;
      ZVAL_COPY_DEREF(&snapshot, &current);
      zend_hash_index_update(*baseline, index, &snapshot);
    }
    zval_ptr_dtor(&current);
  }
}

typedef struct vphp_bound_reference_update {
  struct vphp_bound_reference_update *next;
  zend_object *object;
  int index;
  zval reference;
  zval value;
} vphp_bound_reference_update;

typedef struct vphp_reference_object {
  struct vphp_reference_object *next;
  zend_object *object;
  vphp_task_native_pin *pin;
  HashTable *baseline;
} vphp_reference_object;

typedef struct {
  vphp_static_sync sync;
  vphp_reference_object *objects;
} vphp_reference_scope;

static vphp_bound_reference_update **vphp_collect_bound_reference_updates(
    vphp_reference_object *entry, vphp_bound_reference_update **tail) {
  if (entry->baseline == NULL) {
    return tail;
  }
  zend_object *object = entry->object;
  vphp_object_wrapper *wrapper = vphp_obj_from_obj(object);
  if (!wrapper->may_have_bound_references || !wrapper->write_handler) {
    return tail;
  }
  for (int index = 0; index < object->ce->default_properties_count; index++) {
    zval *baseline = zend_hash_index_find(entry->baseline, index);
    if (!baseline) {
      continue;
    }
    zval current;
    zval *slot = vphp_read_referenced_v_field(object, wrapper, index, &current);
    if (slot == NULL) {
      continue;
    }
    if (vphp_compare_bound_reference_values(baseline, &current) != 0 &&
        vphp_compare_bound_reference_values(Z_REFVAL_P(slot), &current) != 0) {
      vphp_bound_reference_update *update = emalloc(sizeof(*update));
      update->next = NULL;
      update->object = object;
      update->index = index;
      ZVAL_COPY(&update->reference, slot);
      ZVAL_COPY_DEREF(&update->value, &current);
      *tail = update;
      tail = &update->next;
    }
    zval_ptr_dtor(&current);
  }
  return tail;
}

static void vphp_import_reference_scope(void *target) {
  vphp_reference_scope *scope = target;
  for (vphp_reference_object *entry = scope->objects; entry; entry = entry->next) {
    vphp_import_bound_references(entry->object, &entry->baseline);
  }
}

static void vphp_export_reference_scope(void *target) {
  vphp_reference_scope *scope = target;
  vphp_bound_reference_update *updates = NULL;
  vphp_bound_reference_update **tail = &updates;
  // Compare against the V values at entry. A static table or another object
  // may already have written to the same PHP reference at this boundary.
  for (vphp_reference_object *entry = scope->objects; entry; entry = entry->next) {
    tail = vphp_collect_bound_reference_updates(entry, tail);
  }
  zend_object *pending_exception = EG(exception);
  EG(exception) = NULL;
  while (updates != NULL) {
    vphp_bound_reference_update *update = updates;
    updates = update->next;
    zval *slot = OBJ_PROP_NUM(update->object, update->index);
    if (!EG(exception) && Z_ISREF_P(slot) &&
        Z_REF_P(slot) == Z_REF(update->reference)) {
      zval previous;
      ZVAL_COPY(&previous, Z_REFVAL_P(slot));
      zend_try_assign_typed_ref_ex(Z_REF_P(slot), &update->value, true);
      zval_ptr_dtor(&previous);
    } else {
      zval_ptr_dtor(&update->value);
    }
    zval_ptr_dtor(&update->reference);
    efree(update);
  }
  for (vphp_reference_object *entry = scope->objects; entry; entry = entry->next) {
    vphp_import_bound_references(entry->object, NULL);
    if (entry->baseline != NULL) {
      zend_array_release(entry->baseline);
      entry->baseline = NULL;
    }
  }
  if (pending_exception != NULL) {
    if (EG(exception)) {
      zend_clear_exception();
    }
    EG(exception) = pending_exception;
  }
}

static void vphp_track_reference_object(zend_object *object,
                                         vphp_object_wrapper *wrapper,
                                         zend_execute_data *call) {
  if (!wrapper->v_ptr || !wrapper->prop_handler || !wrapper->write_handler) {
    return;
  }
  if (!call || !call->func || call->func->type != ZEND_INTERNAL_FUNCTION ||
      vphp_runtime_internal_call_depth == 0) {
    vphp_import_bound_references(object, NULL);
    return;
  }

  vphp_reference_scope *scope = NULL;
  vphp_static_sync **link = &vphp_active_static_request()->sync;
  for (vphp_static_sync *sync = *link; sync; sync = sync->previous) {
    if (sync->from_php == vphp_import_reference_scope) {
      vphp_reference_scope *active = sync->ce;
      for (vphp_reference_object *entry = active->objects; entry; entry = entry->next) {
        if (entry->object == object) {
          return;
        }
      }
      if (sync->call == call) {
        scope = active;
      }
    }
    if (sync->call == call) {
      link = &sync->previous;
    }
  }
  if (scope == NULL) {
    scope = emalloc(sizeof(*scope));
    scope->sync = (vphp_static_sync){
        .previous = *link,
        .call = call,
        .ce = scope,
        .from_php = vphp_import_reference_scope,
        .to_php = vphp_export_reference_scope,
    };
    scope->objects = NULL;
    // Keep generated static-table scopes on top so their defers can pop first.
    *link = &scope->sync;
  }
  vphp_reference_object *entry = emalloc(sizeof(*entry));
  entry->object = object;
  entry->next = scope->objects;
  entry->baseline = NULL;
  entry->pin = vphp_pin_native_receiver(object);
  scope->objects = entry;
  vphp_import_bound_references(object, &entry->baseline);
}

void *vphp_bound_object_pointer(zend_object *object) {
  vphp_object_wrapper *wrapper = vphp_obj_from_obj(object);
  if (!wrapper || !wrapper->v_ptr) {
    return NULL;
  }
  vphp_track_reference_object(object, wrapper, EG(current_execute_data));
  return wrapper->v_ptr;
}

static void vphp_track_instance_receiver(zend_execute_data *execute_data) {
  if (execute_data && Z_TYPE(execute_data->This) == IS_OBJECT) {
    zend_object *object = Z_OBJ(execute_data->This);
    vphp_track_reference_object(object, vphp_obj_from_obj(object), execute_data);
  }
}

static void vphp_finish_reference_scope(zend_execute_data *execute_data) {
  vphp_static_sync *sync = vphp_active_static_request()->sync;
  if (!sync || sync->call != execute_data ||
      sync->from_php != vphp_import_reference_scope) {
    return;
  }
  vphp_reference_scope *scope = sync->ce;
  vphp_reference_object *entry = scope->objects;
  vphp_end_static_sync(sync);
  while (entry != NULL) {
    vphp_reference_object *next = entry->next;
    vphp_unpin_native_receiver(entry->object, entry->pin);
    efree(entry);
    entry = next;
  }
}

static uint8_t vphp_current_user_opcode(void) {
  zend_execute_data *execute_data = EG(current_execute_data);
  if (!execute_data || !execute_data->func ||
      execute_data->func->type != ZEND_USER_FUNCTION || !execute_data->opline) {
    return ZEND_NOP;
  }
  return execute_data->opline->opcode;
}

static bool vphp_is_property_update_opcode(void) {
  switch (vphp_current_user_opcode()) {
    case ZEND_ASSIGN_OBJ_OP:
    case ZEND_PRE_INC_OBJ:
    case ZEND_PRE_DEC_OBJ:
    case ZEND_POST_INC_OBJ:
    case ZEND_POST_DEC_OBJ:
      return true;
    default:
      return false;
  }
}

static zval *vphp_get_property_ptr_ptr(zend_object *object, zend_string *member,
                                       int type, void **cache_slot) {
  vphp_object_wrapper *wrapper = vphp_obj_from_obj(object);
  bool active_reference = vphp_is_reference_slot(object, wrapper, member);
  if (type == BP_VAR_RW && !active_reference && vphp_is_property_update_opcode()) {
    zval current;
    if (vphp_read_bound_property(wrapper, member, &current)) {
      zval_ptr_dtor(&current);
      // The VM can implement these operations through read and write handlers.
      // Other opcodes can require a writable Zend slot for a PHP reference.
      return NULL;
    }
  }
  const zend_object_handlers *handlers =
      vphp_fallback_handlers(vphp_original_handlers_for(object));
  zend_property_info *info = type == BP_VAR_W && wrapper->write_handler &&
      handlers->get_property_ptr_ptr == zend_std_get_property_ptr_ptr
      ? vphp_reference_property_info(object, member) : NULL;
  zval current;
  bool bound = info && vphp_read_v_field(wrapper, member, &current);
  if (bound) {
    wrapper->may_have_bound_references = true;
    if (!active_reference && !vphp_property_was_unset(wrapper, member)) {
      zend_std_write_property(object, member, &current, NULL);
    }
    zval_ptr_dtor(&current);
    if (EG(exception)) {
      return &EG(error_zval);
    }
  }
  zval *slot = handlers->get_property_ptr_ptr != NULL
      ? handlers->get_property_ptr_ptr(object, member, type, cache_slot)
      : NULL;
  if (bound && cache_slot != NULL) {
    // Leave the type information available to the VM without caching the slot.
    cache_slot[0] = NULL;
  }
  return slot;
}

static bool vphp_uses_standard_property_storage(zend_object *object) {
  const zend_object_handlers *handlers = object->handlers;
  if (handlers->get_property_ptr_ptr == vphp_get_property_ptr_ptr) {
    handlers = vphp_original_handlers_for(object);
  }
  return handlers->get_property_ptr_ptr == zend_std_get_property_ptr_ptr;
}

zval *vphp_read_property(zend_object *object, zend_string *member, int type,
                         void **cache_slot, zval *rv) {
  vphp_object_wrapper *wrapper = vphp_obj_from_obj(object);
  bool use_v_handler = !vphp_is_reference_slot(object, wrapper, member);
#if PHP_VERSION_ID >= 80400
  use_v_handler = use_v_handler &&
      !vphp_has_zend_property_operation(object, member, ZEND_PROPERTY_HOOK_GET);
#endif
  if (use_v_handler && vphp_read_bound_property(wrapper, member, rv)) {
    return rv;
  }
  const zend_object_handlers *handlers =
      vphp_fallback_handlers(vphp_original_handlers_for(object));
  // A cached read could bypass this bridge after an unset or unbound read.
  if (handlers->read_property != NULL) {
    return handlers->read_property(object, member, type, NULL, rv);
  }
  return zend_std_read_property(object, member, type, NULL, rv);
}

static zval *vphp_dispatch_property_read(zend_object *obj, const char *name,
                                         int name_len, zval *rv,
                                         const zend_object_handlers *handlers) {
  if (EG(exception)) {
    return NULL;
  }
  zend_string *member = zend_string_init(name, name_len, 0);
  vphp_static_sync *sync = vphp_suspend_static_sync();
  zval *out = NULL;
  if (!EG(exception)) {
    out = handlers->read_property != NULL
        ? handlers->read_property(obj, member, BP_VAR_R, NULL, rv)
        : zend_get_std_object_handlers()->read_property(
              obj, member, BP_VAR_R, NULL, rv);
  }
  vphp_resume_static_sync(sync);
  zend_string_release(member);
  if (EG(exception)) {
    return NULL;
  }
  if (out != NULL && Z_ISREF_P(out)) {
    if (out == rv) {
      zval value;
      ZVAL_COPY_DEREF(&value, rv);
      zval_ptr_dtor(rv);
      ZVAL_COPY_VALUE(rv, &value);
    } else {
      ZVAL_DEREF(out);
    }
  }
  return out;
}

zval *vphp_read_property_compat(zend_object *obj, const char *name, int name_len,
                                zval *rv) {
  return vphp_dispatch_property_read(obj, name, name_len, rv, obj->handlers);
}

zval *vphp_read_inherited_property(zend_object *obj, const char *name,
                                    int name_len, zval *rv) {
  const zend_object_handlers *handlers =
      vphp_fallback_handlers(vphp_original_handlers_for(obj));
  return vphp_dispatch_property_read(obj, name, name_len, rv, handlers);
}

static zval *vphp_call_property_write(zend_object *obj, zend_string *member,
                                      zval *value, void **cache_slot,
                                      const zend_object_handlers *handlers) {
  return handlers->write_property != NULL
      ? handlers->write_property(obj, member, value, cache_slot)
      : zend_get_std_object_handlers()->write_property(
            obj, member, value, cache_slot);
}

void vphp_write_property_compat(zend_object *obj, const char *name, int name_len,
                                zval *value) {
  if (EG(exception)) {
    return;
  }
  zend_string *member = zend_string_init(name, name_len, 0);
  vphp_static_sync *sync = vphp_suspend_static_sync();
  if (!EG(exception)) {
    vphp_call_property_write(obj, member, value, NULL, obj->handlers);
  }
  vphp_resume_static_sync(sync);
  zend_string_release(member);
}

void vphp_write_inherited_property(zend_object *obj, const char *name,
                                    int name_len, zval *value) {
  const zend_object_handlers *handlers =
      vphp_fallback_handlers(vphp_original_handlers_for(obj));
  zend_string *member = zend_string_init(name, name_len, 0);
  // Generated receiver cleanup can commit a field with an exception pending.
  vphp_call_property_write(obj, member, value, NULL, handlers);
  zend_string_release(member);
}

static int vphp_has_property(zend_object *object, zend_string *member, int mode,
                             void **cache_slot) {
  vphp_object_wrapper *wrapper = vphp_obj_from_obj(object);
  bool use_v_handler = mode != ZEND_PROPERTY_EXISTS &&
      !vphp_is_reference_slot(object, wrapper, member);
#if PHP_VERSION_ID >= 80400
  use_v_handler = use_v_handler &&
      !vphp_has_zend_property_operation(object, member, ZEND_PROPERTY_HOOK_GET);
#endif
  zval current;
  if (use_v_handler &&
      vphp_read_bound_property(wrapper, member, &current)) {
    zval *value = &current;
    ZVAL_DEREF(value);
    int result = mode == ZEND_PROPERTY_ISSET
        ? Z_TYPE_P(value) != IS_NULL : zend_is_true(value);
    zval_ptr_dtor(&current);
    return result;
  }
  const zend_object_handlers *handlers =
      vphp_fallback_handlers(vphp_original_handlers_for(object));
  return handlers->has_property != NULL
      ? handlers->has_property(object, member, mode, NULL)
      : zend_std_has_property(object, member, mode, NULL);
}

static int vphp_dispatch_has_property(zend_object *obj, const char *name,
                                      int name_len, int mode) {
  if (EG(exception)) {
    return 0;
  }
  zend_string *member = zend_string_init(name, name_len, 0);
  vphp_static_sync *sync = vphp_suspend_static_sync();
  int result = !EG(exception) &&
      obj->handlers->has_property(obj, member, mode, NULL);
  vphp_resume_static_sync(sync);
  zend_string_release(member);
  return result;
}

int vphp_has_property_compat(zend_object *obj, const char *name, int name_len) {
  return vphp_dispatch_has_property(obj, name, name_len, ZEND_PROPERTY_EXISTS);
}

int vphp_isset_property_compat(zend_object *obj, const char *name, int name_len) {
  return vphp_dispatch_has_property(obj, name, name_len, ZEND_PROPERTY_ISSET);
}

typedef struct {
  HashTable *objects;
  HashTable *seen_objects;
  HashTable *seen_arrays;
  const HashTable *captured;
  HashTable *pinned;
  HashTable *partial_arrays;
  HashTable *references;
} vphp_plain_object_graph;

static zend_ulong vphp_plain_object_key(const zval *value) {
  return (zend_ulong)(uintptr_t)Z_OBJ_P(value);
}

static bool vphp_plain_object_layout(zend_object *object) {
  if (object->handlers != zend_get_std_object_handlers() ||
      (object->properties != NULL && HT_HAS_ITERATORS(object->properties))) {
    return false;
  }
#if PHP_VERSION_ID >= 80400
  if (zend_object_is_lazy(object)) {
    return false;
  }
#endif
  zend_class_entry *ce = object->ce;
  if (ce == zend_standard_class_def) {
    return true;
  }
  if (ce->type != ZEND_USER_CLASS || ce->default_properties_count == 0 ||
      ce->destructor || ce->__get || ce->__set || ce->__unset || ce->__isset) {
    return false;
  }
#if PHP_VERSION_ID >= 80400
  zend_property_info *property;
  ZEND_HASH_FOREACH_PTR(&ce->properties_info, property) {
    // Virtual hooks have no backing slot in properties_info_table.
    if (property->hooks) {
      return false;
    }
  } ZEND_HASH_FOREACH_END();
#endif
  if (object->properties != NULL) {
    zval *value;
    ZEND_HASH_FOREACH_VAL(object->properties, value) {
      if (Z_TYPE_P(value) != IS_INDIRECT) {
        return false;
      }
    } ZEND_HASH_FOREACH_END();
  }
  for (int i = 0; i < ce->default_properties_count; i++) {
    zend_property_info *info = ce->properties_info_table[i];
    if (info == NULL || !(info->flags & ZEND_ACC_PUBLIC) ||
        (info->flags & ZEND_ACC_READONLY)) {
      return false;
    }
#if PHP_VERSION_ID >= 80400
    if (info->flags & (ZEND_ACC_PROTECTED_SET | ZEND_ACC_PRIVATE_SET)) {
      return false;
    }
#endif
  }
  return true;
}

static bool vphp_plain_graph_enqueue(vphp_plain_object_graph *graph, zval *value) {
  zend_ulong key = vphp_plain_object_key(value);
  bool captured = graph->captured && zend_hash_index_exists(graph->captured, key);
  if (graph->pinned && zend_hash_index_exists(graph->pinned, key)) {
    return true;
  }
  if (!captured && graph->seen_objects &&
      zend_hash_index_exists(graph->seen_objects, key)) {
    return true;
  }
  if (!captured && !vphp_plain_object_layout(Z_OBJ_P(value))) {
    return false;
  }
  if (graph->pinned) {
    zval pin;
    ZVAL_COPY(&pin, value);
    zend_hash_index_add_new(graph->pinned, key, &pin);
  }
  if (!captured) {
    if (graph->objects == NULL) {
      graph->objects = zend_new_array(4);
      graph->seen_objects = zend_new_array(4);
    }
    zend_hash_index_add_empty_element(graph->seen_objects, key);
    zval owned;
    ZVAL_COPY(&owned, value);
    zend_hash_next_index_insert(graph->objects, &owned);
  }
  return true;
}

static bool vphp_plain_property_values(vphp_plain_object_graph *graph,
                                       const HashTable *values, unsigned depth);

static bool vphp_plain_scalar(const zval *value) {
  switch (Z_TYPE_P(value)) {
    case IS_NULL:
    case IS_FALSE:
    case IS_TRUE:
    case IS_LONG:
    case IS_DOUBLE:
    case IS_STRING:
      return true;
    default:
      return false;
  }
}

static bool vphp_plain_property_value(vphp_plain_object_graph *graph,
                                      zval *value, unsigned depth) {
  switch (Z_TYPE_P(value)) {
    case IS_ARRAY:
      return vphp_plain_property_values(graph, Z_ARRVAL_P(value), depth);
    case IS_OBJECT:
      return vphp_plain_graph_enqueue(graph, value);
    default:
      return vphp_plain_scalar(value);
  }
}

static bool vphp_plain_property_values(vphp_plain_object_graph *graph,
                                       const HashTable *values, unsigned depth) {
  if (depth == 0 || HT_HAS_ITERATORS(values)) {
    return false;
  }
  if (graph->seen_arrays == NULL) {
    graph->seen_arrays = zend_new_array(8);
  }
  zend_ulong key = (zend_ulong)(uintptr_t)values;
  zval *cached = zend_hash_index_find(graph->seen_arrays, key);
  if (cached != NULL) {
    return Z_TYPE_P(cached) == IS_TRUE;
  }
  bool safe = true;
  zval *value;
  ZEND_HASH_FOREACH_VAL(values, value) {
    if (!vphp_plain_property_value(graph, value, depth - 1)) {
      // Visit other elements even when this array cannot itself be restored.
      safe = false;
    }
  } ZEND_HASH_FOREACH_END();
  zval result;
  ZVAL_BOOL(&result, safe);
  zend_hash_index_update(graph->seen_arrays, key, &result);
  return safe;
}

static void vphp_plain_graph_release(vphp_plain_object_graph *graph) {
  if (graph->objects != NULL) {
    zend_array_release(graph->objects);
    zend_array_release(graph->seen_objects);
  }
  if (graph->seen_arrays != NULL) {
    zend_array_release(graph->seen_arrays);
  }
}

static zval *vphp_find_property(const HashTable *properties, zend_string *name,
                                zend_ulong index) {
  if (properties == NULL) {
    return NULL;
  }
  return name ? zend_hash_find(properties, name) : zend_hash_index_find(properties, index);
}

static void vphp_insert_property(HashTable *properties, zend_string *name,
                                   zend_ulong index, zval *value) {
  if (name) {
    zend_hash_add_new(properties, name, value);
  } else {
    zend_hash_index_add_new(properties, index, value);
  }
}

static bool vphp_capture_plain_value(vphp_plain_object_graph *graph, zval *value,
                                     unsigned depth, bool save_binding, zval *saved);

static bool vphp_reference_accepts_scalar(zend_reference *reference, const zval *value) {
  if (!vphp_plain_scalar(value)) {
    return false;
  }
  zend_property_info *property;
  ZEND_REF_FOREACH_TYPE_SOURCES(reference, property) {
#if PHP_VERSION_ID >= 80400
    if (property->hooks) {
      return false;
    }
#endif
    // Accept only exact types so rollback never coerces or throws.
    if (!ZEND_TYPE_CONTAINS_CODE(property->type, Z_TYPE_P(value))) {
      return false;
    }
  } ZEND_REF_FOREACH_TYPE_SOURCES_END();
  return true;
}

static bool vphp_capture_scalar_reference(vphp_plain_object_graph *graph, zval *value) {
  zend_reference *reference = Z_REF_P(value);
  zend_ulong key = (zend_ulong)(uintptr_t)reference;
  if (!vphp_reference_accepts_scalar(reference, Z_REFVAL_P(value))) {
    return false;
  }
  if (zend_hash_index_exists(graph->captured, key) ||
      (graph->references && zend_hash_index_exists(graph->references, key))) {
    return true;
  }
  if (graph->references == NULL) {
    graph->references = zend_new_array(4);
  }
  zval item, owned, saved;
  array_init_size(&item, 2);
  ZVAL_COPY(&owned, value);
  ZVAL_COPY(&saved, Z_REFVAL_P(value));
  zend_hash_next_index_insert(Z_ARRVAL(item), &owned);
  zend_hash_next_index_insert(Z_ARRVAL(item), &saved);
  zend_hash_index_add_new(graph->references, key, &item);
  return true;
}

static bool vphp_capture_plain_array(vphp_plain_object_graph *graph, zval *value,
                                     unsigned depth, zval *saved) {
  if (graph->seen_arrays == NULL) {
    graph->seen_arrays = zend_new_array(8);
  }
  HashTable *source = Z_ARRVAL_P(value);
  zend_ulong key = (zend_ulong)(uintptr_t)source;
  zval *cached = zend_hash_index_find(graph->seen_arrays, key);
  if (cached != NULL) {
    ZVAL_COPY(saved, cached);
    return !zend_hash_index_exists(graph->partial_arrays,
                                  (zend_ulong)(uintptr_t)Z_ARRVAL_P(cached));
  }
  HashTable *properties = zend_new_array(zend_hash_num_elements(source));
  bool complete = true;
  zend_string *name;
  zend_ulong index;
  zval *element;
  ZEND_HASH_FOREACH_KEY_VAL(source, index, name, element) {
    zval snapshot;
    if (!vphp_capture_plain_value(graph, element, depth - 1, false, &snapshot)) {
      complete = false;
    }
    vphp_insert_property(properties, name, index, &snapshot);
  } ZEND_HASH_FOREACH_END();
  if (complete) {
    zend_array_release(properties);
    ZVAL_COPY(saved, value);
  } else {
    properties->nNextFreeElement = source->nNextFreeElement;
    ZVAL_ARR(saved, properties);
    zend_hash_index_add_empty_element(graph->partial_arrays,
                                     (zend_ulong)(uintptr_t)properties);
  }
  zval cached_snapshot;
  ZVAL_COPY(&cached_snapshot, saved);
  zend_hash_index_add_new(graph->seen_arrays, key, &cached_snapshot);
  return complete;
}

static bool vphp_capture_plain_value(vphp_plain_object_graph *graph, zval *value,
                                     unsigned depth, bool save_binding, zval *saved) {
  if (Z_TYPE_P(value) == IS_ARRAY && depth != 0) {
    return vphp_capture_plain_array(graph, value, depth, saved);
  }
  if (Z_ISREF_P(value)) {
    if (vphp_capture_scalar_reference(graph, value) && save_binding) {
      ZVAL_COPY(saved, value);
      return true;
    }
  }
  if (Z_TYPE_P(value) != IS_ARRAY && vphp_plain_property_value(graph, value, 64)) {
    ZVAL_COPY(saved, value);
    return true;
  }
  // The key remains in the snapshot so this property is never treated as new.
  ZVAL_PTR(saved, NULL);
  return false;
}

static void vphp_save_plain_property(vphp_plain_object_graph *graph,
                                     HashTable *properties, zend_string *name,
                                     zend_ulong index, zval *value) {
  zval saved;
  vphp_capture_plain_value(graph, value, 64, true, &saved);
  vphp_insert_property(properties, name, index, &saved);
}

static void vphp_save_plain_properties(vphp_plain_object_graph *graph,
                                       zend_object *object, zval *snapshot) {
  array_init(snapshot);
  HashTable *saved = Z_ARRVAL_P(snapshot);
  if (object->ce == zend_standard_class_def) {
    if (object->properties != NULL) {
      zend_string *name;
      zend_ulong index;
      zval *value;
      ZEND_HASH_FOREACH_KEY_VAL(object->properties, index, name, value) {
        vphp_save_plain_property(graph, saved, name, index, value);
      } ZEND_HASH_FOREACH_END();
    }
    return;
  }
  for (int i = 0; i < object->ce->default_properties_count; i++) {
    vphp_save_plain_property(graph, saved, NULL, i, OBJ_PROP_NUM(object, i));
  }
}

static bool vphp_plain_discard_safe(zval *value, const HashTable *pinned) {
  if (value == NULL || Z_TYPE_P(value) == IS_UNDEF) {
    return true;
  }
  // A pinned object cannot be destroyed by replacing a property that points to it.
  vphp_plain_object_graph graph = { .captured = pinned };
  bool safe = vphp_plain_property_value(&graph, value, 64);
  for (uint32_t i = 0; safe && graph.objects != NULL &&
       i < zend_hash_num_elements(graph.objects); i++) {
    zend_object *object = Z_OBJ_P(zend_hash_index_find(graph.objects, i));
    if (object->ce == zend_standard_class_def) {
      safe = object->properties == NULL ||
          vphp_plain_property_values(&graph, object->properties, 64);
    } else {
      for (int j = 0; safe && j < object->ce->default_properties_count; j++) {
        zval *slot = OBJ_PROP_NUM(object, j);
        safe = Z_TYPE_P(slot) == IS_UNDEF ||
            vphp_plain_property_value(&graph, slot, 64);
      }
    }
  }
  vphp_plain_graph_release(&graph);
  return safe;
}

typedef struct {
  const HashTable *pinned;
  const HashTable *partial_arrays;
  HashTable *merged_arrays;
} vphp_plain_restore;

static bool vphp_can_restore_reference_binding(vphp_plain_restore *restore,
                                               zval *saved, zval *current) {
  if (!vphp_reference_accepts_scalar(Z_REF_P(saved), Z_REFVAL_P(saved))) {
    return false;
  }
  if (current != NULL && Z_ISREF_P(current)) {
    return vphp_plain_scalar(Z_REFVAL_P(current));
  }
  return vphp_plain_discard_safe(current, restore->pinned);
}

static bool vphp_merge_plain_value(vphp_plain_restore *restore, zval *saved,
                                   zval *current, unsigned depth, zval *result);

static HashTable *vphp_merge_plain_properties(vphp_plain_restore *restore,
                                             const HashTable *saved,
                                             const HashTable *current,
                                             unsigned depth) {
  HashTable *properties = zend_new_array(zend_hash_num_elements(saved));
  zend_string *name;
  zend_ulong index;
  zval *value;
  ZEND_HASH_FOREACH_KEY_VAL(saved, index, name, value) {
    zval merged;
    zval *existing = vphp_find_property(current, name, index);
    if (vphp_merge_plain_value(restore, value, existing, depth, &merged)) {
      vphp_insert_property(properties, name, index, &merged);
    }
  } ZEND_HASH_FOREACH_END();
  if (current != NULL) {
    ZEND_HASH_FOREACH_KEY_VAL(current, index, name, value) {
      if (vphp_find_property(saved, name, index) == NULL &&
          !vphp_plain_discard_safe(value, restore->pinned)) {
        zval kept;
        ZVAL_COPY(&kept, value);
        vphp_insert_property(properties, name, index, &kept);
      }
    } ZEND_HASH_FOREACH_END();
  }
  if (properties->nNextFreeElement < saved->nNextFreeElement) {
    properties->nNextFreeElement = saved->nNextFreeElement;
  }
  return properties;
}

static void vphp_merge_plain_arrays(vphp_plain_restore *restore,
                                    HashTable *saved, zval *current_value,
                                    unsigned depth, zval *result) {
  HashTable *current = current_value != NULL ? Z_ARRVAL_P(current_value) : NULL;
  zend_ulong saved_key = (zend_ulong)(uintptr_t)saved;
  zend_ulong current_key = (zend_ulong)(uintptr_t)current;
  zval *matches = zend_hash_index_find(restore->merged_arrays, saved_key);
  if (matches == NULL) {
    zval match_table;
    array_init(&match_table);
    matches = zend_hash_index_add_new(restore->merged_arrays, saved_key, &match_table);
  }
  HashTable *cache = Z_ARRVAL_P(matches);
  zval *cached = zend_hash_index_find(cache, current_key);
  if (cached != NULL) {
    ZVAL_COPY(result, zend_hash_index_find(Z_ARRVAL_P(cached), 0));
    return;
  }
  ZVAL_ARR(result, vphp_merge_plain_properties(restore, saved, current, depth - 1));
  zval entry, cached_result;
  array_init_size(&entry, 2);
  ZVAL_COPY(&cached_result, result);
  zend_hash_next_index_insert(Z_ARRVAL(entry), &cached_result);
  if (current_value != NULL) {
    // Keep identity keys valid even after a previous property's table was replaced.
    zval source;
    ZVAL_COPY(&source, current_value);
    zend_hash_next_index_insert(Z_ARRVAL(entry), &source);
  }
  zend_hash_index_add_new(cache, current_key, &entry);
}

static bool vphp_merge_plain_value(vphp_plain_restore *restore, zval *saved,
                                   zval *current, unsigned depth, zval *result) {
  bool discard_safe = false;
  if (Z_ISREF_P(saved)) {
    if (vphp_can_restore_reference_binding(restore, saved, current)) {
      ZVAL_COPY(result, saved);
      return true;
    }
  } else if (Z_TYPE_P(saved) != IS_PTR) {
    discard_safe = vphp_plain_discard_safe(current, restore->pinned);
    bool partial = Z_TYPE_P(saved) == IS_ARRAY &&
        zend_hash_index_exists(restore->partial_arrays, (zend_ulong)(uintptr_t)Z_ARRVAL_P(saved));
    if (!partial && discard_safe) {
      ZVAL_COPY(result, saved);
      return true;
    }
    if (Z_TYPE_P(saved) == IS_ARRAY && depth != 0 &&
        (discard_safe || (current != NULL && Z_TYPE_P(current) == IS_ARRAY &&
                          !HT_HAS_ITERATORS(Z_ARRVAL_P(current))))) {
      zval *existing = current != NULL && Z_TYPE_P(current) == IS_ARRAY ? current : NULL;
      vphp_merge_plain_arrays(restore, Z_ARRVAL_P(saved), existing, depth, result);
      return true;
    }
  }
  if (current == NULL || Z_TYPE_P(current) == IS_UNDEF) {
    return false;
  }
  ZVAL_COPY(result, current);
  return true;
}

static bool vphp_reference_has_property_source(zend_reference *reference,
                                               const zend_property_info *info) {
  zend_property_info *source;
  ZEND_REF_FOREACH_TYPE_SOURCES(reference, source) {
    if (source == info) {
      return true;
    }
  } ZEND_REF_FOREACH_TYPE_SOURCES_END();
  return false;
}

static void vphp_restore_declared_reference(vphp_plain_restore *restore,
                                            zend_property_info *info,
                                            zval *slot, zval *saved) {
  if ((Z_ISREF_P(slot) && Z_REF_P(slot) == Z_REF_P(saved)) ||
      !vphp_can_restore_reference_binding(restore, saved, slot)) {
    return;
  }
  if (ZEND_TYPE_IS_SET(info->type)) {
    if (!ZEND_TYPE_CONTAINS_CODE(info->type, Z_TYPE_P(Z_REFVAL_P(saved)))) {
      return;
    }
    if (Z_ISREF_P(slot)) {
      if (!vphp_reference_has_property_source(Z_REF_P(slot), info)) {
        return;
      }
      ZEND_REF_DEL_TYPE_SOURCE(Z_REF_P(slot), info);
    }
    ZEND_REF_ADD_TYPE_SOURCE(Z_REF_P(saved), info);
  }
  zval previous;
  ZVAL_COPY_VALUE(&previous, slot);
  ZVAL_COPY(slot, saved);
  Z_PROP_FLAG_P(slot) = 0;
  zval_ptr_dtor(&previous);
}

static void vphp_restore_plain_properties(vphp_plain_restore *restore,
                                          zend_object *object, zval *snapshot) {
  if (!vphp_plain_object_layout(object)) {
    return;
  }
  HashTable *saved = Z_ARRVAL_P(snapshot);
  if (object->ce == zend_standard_class_def) {
    HashTable *current = object->properties;
    // Copy skipped zvals verbatim, including references, before releasing the old table.
    object->properties = vphp_merge_plain_properties(restore, saved, current, 64);
    if (current != NULL) {
      zend_array_release(current);
    }
    return;
  }
  for (int i = 0; i < object->ce->default_properties_count; i++) {
    zval *slot = OBJ_PROP_NUM(object, i);
    zval *value = zend_hash_index_find(saved, i);
    if (Z_ISREF_P(value)) {
      vphp_restore_declared_reference(restore, object->ce->properties_info_table[i],
                                      slot, value);
      continue;
    }
    zval merged;
    if (Z_TYPE_P(value) != IS_PTR && !Z_ISREF_P(slot) &&
        vphp_merge_plain_value(restore, value, slot, 64, &merged)) {
      zval_ptr_dtor(slot);
      ZVAL_COPY_VALUE(slot, &merged);
      Z_PROP_FLAG_P(slot) = 0;
    }
  }
}

void *vphp_new_plain_object_tracker(void) {
  return zend_new_array(8);
}

void *vphp_capture_plain_object(void *tracker, zval *root) {
  HashTable *captured = tracker;
  if (root == NULL || Z_TYPE_P(root) != IS_OBJECT ||
      !vphp_plain_object_layout(Z_OBJ_P(root)) ||
      zend_hash_index_exists(captured, vphp_plain_object_key(root))) {
    return NULL;
  }
  vphp_plain_object_graph graph = {
      .captured = captured,
      .pinned = zend_new_array(4),
      .partial_arrays = zend_new_array(4),
  };
  vphp_plain_graph_enqueue(&graph, root);
  zval items;
  array_init(&items);
  // Enqueuing a child can grow the table. The queue's numeric indices stay stable.
  for (uint32_t i = 0; i < zend_hash_num_elements(graph.objects); i++) {
    zval *object = zend_hash_index_find(graph.objects, i);
    zval item, target, state;
    array_init_size(&item, 2);
    ZVAL_COPY(&target, object);
    vphp_save_plain_properties(&graph, Z_OBJ_P(&target), &state);
    zend_hash_next_index_insert(Z_ARRVAL(item), &target);
    zend_hash_next_index_insert(Z_ARRVAL(item), &state);
    zend_hash_next_index_insert(Z_ARRVAL(items), &item);
    zend_hash_index_add_empty_element(captured, vphp_plain_object_key(&target));
  }
  HashTable *group = zend_new_array(4);
  zval pinned, partial_arrays, references;
  ZVAL_ARR(&pinned, graph.pinned);
  zend_hash_next_index_insert(group, &items);
  zend_hash_next_index_insert(group, &pinned);
  ZVAL_ARR(&partial_arrays, graph.partial_arrays);
  zend_hash_next_index_insert(group, &partial_arrays);
  if (graph.references != NULL) {
    zend_ulong key;
    ZEND_HASH_FOREACH_NUM_KEY(graph.references, key) {
      zend_hash_index_add_empty_element(captured, key);
    } ZEND_HASH_FOREACH_END();
    ZVAL_ARR(&references, graph.references);
  } else {
    ZVAL_NULL(&references);
  }
  zend_hash_next_index_insert(group, &references);
  vphp_plain_graph_release(&graph);
  return group;
}

static void vphp_restore_scalar_references(zval *references) {
  if (Z_TYPE_P(references) != IS_ARRAY) {
    return;
  }
  zval *item;
  ZEND_HASH_FOREACH_VAL(Z_ARRVAL_P(references), item) {
    zval *owner = zend_hash_index_find(Z_ARRVAL_P(item), 0);
    zval *saved = zend_hash_index_find(Z_ARRVAL_P(item), 1);
    zval *target = Z_REFVAL_P(owner);
    if (vphp_plain_scalar(target) &&
        vphp_reference_accepts_scalar(Z_REF_P(owner), saved)) {
      zval previous;
      ZVAL_COPY_VALUE(&previous, target);
      ZVAL_COPY(target, saved);
      zval_ptr_dtor(&previous);
    }
  } ZEND_HASH_FOREACH_END();
}

void vphp_restore_plain_objects(void *handle) {
  HashTable *group = handle;
  HashTable *items = Z_ARRVAL_P(zend_hash_index_find(group, 0));
  zval *references = zend_hash_index_find(group, 3);
  vphp_plain_restore restore = {
      .pinned = Z_ARRVAL_P(zend_hash_index_find(group, 1)),
      .partial_arrays = Z_ARRVAL_P(zend_hash_index_find(group, 2)),
      .merged_arrays = zend_new_array(4),
  };
  // Restore values before reconnecting typed properties when their types permit it.
  vphp_restore_scalar_references(references);
  zval *item;
  ZEND_HASH_FOREACH_VAL(items, item) {
    zval *target = zend_hash_index_find(Z_ARRVAL_P(item), 0);
    zval *state = zend_hash_index_find(Z_ARRVAL_P(item), 1);
    vphp_restore_plain_properties(&restore, Z_OBJ_P(target), state);
  } ZEND_HASH_FOREACH_END();
  // Rebinding can remove a temporary type source that blocked the first pass.
  vphp_restore_scalar_references(references);
  zend_array_release(restore.merged_arrays);
}

void vphp_release_plain_object_state(void *handle) {
  if (handle != NULL) {
    zend_array_release((HashTable *)handle);
  }
}

static void vphp_unset_property(zend_object *object, zend_string *member,
                                void **cache_slot) {
  vphp_object_wrapper *wrapper = vphp_obj_from_obj(object);
  zend_property_info *info = zend_get_property_info(object->ce, member, true);
  zval current;
  bool bound = info && info != ZEND_WRONG_PROPERTY_INFO &&
      (info->flags & ZEND_ACC_PUBLIC) && !(info->flags & ZEND_ACC_STATIC);
#if PHP_VERSION_ID >= 80400
  bound = bound && info->hooks == NULL;
#endif
  bound = bound && vphp_read_bound_property(wrapper, member, &current);
  if (bound) {
    zval_ptr_dtor(&current);
    if (info->flags & ZEND_ACC_READONLY) {
      zend_throw_error(NULL, "Cannot unset readonly property %s::$%s",
                       ZSTR_VAL(info->ce->name), ZSTR_VAL(member));
      return;
    }
  }
  const zend_object_handlers *handlers =
      vphp_fallback_handlers(vphp_original_handlers_for(object));
  if (handlers->unset_property != NULL) {
    handlers->unset_property(object, member, cache_slot);
  } else {
    zend_std_unset_property(object, member, cache_slot);
  }
  if (bound && !EG(exception) && Z_ISUNDEF_P(OBJ_PROP(object, info->offset))) {
    if (wrapper->unset_bound_properties == NULL) {
      wrapper->unset_bound_properties = zend_new_array(1);
    }
    zend_hash_add_empty_element(wrapper->unset_bound_properties, member);
  }
}

void vphp_unset_property_compat(zend_object *obj, const char *name, int name_len) {
  if (EG(exception)) {
    return;
  }
  zend_string *member = zend_string_init(name, name_len, 0);
  vphp_static_sync *sync = vphp_suspend_static_sync();
  if (!EG(exception)) {
    obj->handlers->unset_property(obj, member, NULL);
  }
  vphp_resume_static_sync(sync);
  zend_string_release(member);
}

zval *vphp_write_property(zend_object *object, zend_string *member, zval *value,
                          void **cache_slot) {
  vphp_object_wrapper *wrapper = vphp_obj_from_obj(object);
  zend_property_info *prop_info =
      zend_get_property_info(object->ce, member, /* silent */ true);
  if (prop_info && prop_info != ZEND_WRONG_PROPERTY_INFO &&
      (prop_info->flags & ZEND_ACC_READONLY) && wrapper->v_ptr &&
      wrapper->prop_handler) {
    // Zend owns initialization and write checks for PHP-only properties.
    // A V-backed readonly field already has a value outside the Zend slot.
    zval current;
    ZVAL_UNDEF(&current);
    wrapper->prop_handler(wrapper->v_ptr, ZSTR_VAL(member),
                          (int)ZSTR_LEN(member), &current);
    if (!Z_ISUNDEF(current)) {
      zval_ptr_dtor(&current);
      vphp_zend_readonly_property_modification_error(object, member, prop_info);
      return &EG(error_zval);
    }
  }
  bool use_v_handler = wrapper->v_ptr && wrapper->write_handler;
#if PHP_VERSION_ID >= 80400
  use_v_handler = use_v_handler &&
      !vphp_has_zend_property_operation(object, member, ZEND_PROPERTY_HOOK_SET);
#endif
  const zend_object_handlers *handlers =
      vphp_fallback_handlers(vphp_original_handlers_for(object));
  bool was_unset = vphp_property_was_unset(wrapper, member);
  // Zend's cached assignment writes the slot directly and skips the V setter.
  zval *written = vphp_call_property_write(object, member, value, NULL, handlers);
  // Zend validates the assignment and exposes the value after type coercion.
  if (use_v_handler && written != NULL && written != &EG(error_zval) &&
      !EG(exception)) {
    zval *assigned = written;
    if (was_unset) {
      // A magic setter can accept the write without initializing the slot.
      if (!prop_info || prop_info == ZEND_WRONG_PROPERTY_INFO) {
        return written;
      }
      assigned = OBJ_PROP(object, prop_info->offset);
      if (Z_ISUNDEF_P(assigned)) {
        return written;
      }
      zend_hash_del(wrapper->unset_bound_properties, member);
    }
    ZVAL_DEREF(assigned);
    wrapper->write_handler(wrapper->v_ptr, ZSTR_VAL(member),
                           (int)ZSTR_LEN(member), assigned);
    if (!was_unset && Z_TYPE_P(value) != Z_TYPE_P(assigned) &&
        vphp_current_user_opcode() == ZEND_ASSIGN_OBJ_OP) {
      zval current;
      if (vphp_read_bound_property(wrapper, member, &current)) {
        zval_ptr_dtor(&current);
        // The VM returns this temporary from the compound assignment.
        zval result;
        ZVAL_COPY(&result, assigned);
        zval_ptr_dtor(value);
        ZVAL_COPY_VALUE(value, &result);
      }
    }
  }
  return written;
}

HashTable *vphp_get_properties(zend_object *object) {
  const zend_object_handlers *handlers =
      vphp_fallback_handlers(vphp_original_handlers_for(object));
  HashTable *props = handlers->get_properties != NULL
                         ? handlers->get_properties(object)
                         : zend_std_get_properties(object);
  vphp_object_wrapper *wrapper = vphp_obj_from_obj(object);
  if (wrapper->v_ptr && wrapper->sync_handler) {
    zval obj_zv;
    ZVAL_OBJ(&obj_zv, object);
    wrapper->sync_handler(wrapper->v_ptr, &obj_zv);
  }
  return props;
}

static HashTable *vphp_get_gc(zend_object *object, zval **table, int *n) {
  /* Trace the real property slots without running the V property synchronizer. */
  HashTable *properties = object->properties;
  *table = properties ? NULL : object->properties_table;
  *n = properties ? 0 : object->ce->default_properties_count;
  vphp_object_wrapper *wrapper = vphp_binding_for_obj(object, 0);
  if (!Z_REFCOUNTED(wrapper->php_state)) {
    return properties;
  }

  zend_get_gc_buffer *buffer = zend_get_gc_buffer_create();
  for (int i = 0; i < *n; i++) {
    zend_get_gc_buffer_add_zval(buffer, &(*table)[i]);
  }
  zend_get_gc_buffer_add_zval(buffer, &wrapper->php_state);
  zend_get_gc_buffer_use(buffer, table, n);
  return properties;
}

void vphp_init_handlers() {
  memcpy(&vphp_obj_handlers, zend_get_std_object_handlers(),
         sizeof(zend_object_handlers));
  vphp_obj_handlers.offset = offsetof(vphp_object_wrapper, std);
  vphp_obj_handlers.clone_obj = NULL;
#if PHP_VERSION_ID >= 80500
  vphp_obj_handlers.clone_obj_with = NULL;
#endif
  vphp_obj_handlers.free_obj = vphp_free_object_handler;
  vphp_obj_handlers.get_gc = vphp_get_gc;
  vphp_obj_handlers.read_property = vphp_read_property;
  vphp_obj_handlers.get_properties = vphp_get_properties;
  vphp_obj_handlers.write_property = vphp_write_property;
  vphp_obj_handlers.has_property = vphp_has_property;
  vphp_obj_handlers.unset_property = vphp_unset_property;
  vphp_obj_handlers.get_property_ptr_ptr = vphp_get_property_ptr_ptr;
}

void vphp_init_cloneable_object_handlers(zend_object_handlers *handlers,
                                         zend_object_clone_obj_t clone_obj) {
  if (vphp_obj_handlers.read_property == NULL) {
    vphp_init_handlers();
  }
  *handlers = vphp_obj_handlers;
  handlers->clone_obj = clone_obj;
#if PHP_VERSION_ID >= 80500
  handlers->clone_obj_with = zend_objects_clone_obj_with;
#endif
}

zend_object *vphp_clone_bound_object(zend_object *source,
                                      vphp_class_handlers *handlers,
                                      void (*clone_into)(void *, void *)) {
  vphp_object_wrapper *source_binding = vphp_obj_from_obj(source);
  void *source_ptr = source_binding->v_ptr;
  zend_object *target = source->ce->create_object(source->ce);
  if (source_ptr == NULL) {
    zend_throw_error(NULL, "Cannot clone uninitialized VPHP object of class %s",
                     ZSTR_VAL(source->ce->name));
    return target;
  }
  vphp_object_wrapper *binding = vphp_ensure_owned_instance_binding(target, handlers);
  if (binding->v_ptr == NULL) {
    zend_throw_error(NULL, "Cannot initialize VPHP clone of class %s",
                     ZSTR_VAL(source->ce->name));
    return target;
  }
  vphp_import_bound_references(source, NULL);
  clone_into(source_ptr, binding->v_ptr);
  if (!EG(exception) && handlers->init_php_state) {
    handlers->init_php_state(binding->v_ptr);
  }
  if (!EG(exception)) {
    binding->may_have_bound_references = source_binding->may_have_bound_references;
    if (source_binding->unset_bound_properties != NULL) {
      binding->unset_bound_properties =
          zend_array_dup(source_binding->unset_bound_properties);
    }
    zend_objects_clone_members(target, source);
  }
  return target;
}

zend_object *vphp_create_object_handler(zend_class_entry *ce) {
  if (vphp_obj_handlers.read_property == NULL) {
    vphp_init_handlers();
  }
  vphp_preload_auto_interfaces_for_class(ce);
  vphp_apply_auto_interface_bindings_for_class(ce);
  vphp_object_wrapper *obj = zend_object_alloc(sizeof(vphp_object_wrapper), ce);
  obj->magic = VPHP_MAGIC;
  obj->v_ptr = NULL;
  obj->owns_v_ptr = 0;
  obj->cleanup_raw = NULL;
  obj->free_raw = NULL;
  obj->original_handlers = NULL;
  obj->unset_bound_properties = NULL;
  obj->may_have_bound_references = false;
  obj->instance_handlers = NULL;
  ZVAL_UNDEF(&obj->php_state);
  zend_object_std_init(&obj->std, ce);
  object_properties_init(&obj->std, ce);
  obj->std.handlers = &vphp_obj_handlers;
  return &obj->std;
}

zend_object *vphp_create_inherited_object_handler(zend_class_entry *ce) {
  zend_object *obj = NULL;
  const zend_object_handlers *original_handlers = NULL;
  zend_object_handlers *cloned_handlers = NULL;
  vphp_object_wrapper *wrapper = NULL;
  if (vphp_obj_handlers.read_property == NULL) {
    vphp_init_handlers();
  }
  vphp_preload_auto_interfaces_for_class(ce);
  obj = vphp_resolve_inherited_parent_object(ce,
                                             vphp_create_inherited_object_handler);
  if (obj == NULL) {
    obj = vphp_create_object_handler(ce);
    vphp_init_inherited_fields(obj, ce);
    return obj;
  }
  vphp_apply_auto_interface_bindings_for_class(ce);
  original_handlers = obj->handlers;
  original_handlers = vphp_unwrap_inherited_handlers(original_handlers);
  cloned_handlers = vphp_clone_inherited_handlers(original_handlers);
  if (cloned_handlers != NULL) {
    wrapper = vphp_binding_for_obj(obj, 1);
    if (wrapper != NULL && wrapper != &vphp_null_wrapper) {
      wrapper->magic = VPHP_MAGIC;
      wrapper->original_handlers = original_handlers;
    }
    obj->handlers = cloned_handlers;
  }
  vphp_init_inherited_fields(obj, ce);
  return obj;
}

void vphp_bind_handlers_with_ownership(zend_object *obj, vphp_class_handlers *h,
                                       int owns_v_ptr) {
  vphp_object_wrapper *wrapper = vphp_binding_for_obj(obj, 1);
  char debug_buf[256];
  int debug_on = vphp_bridge_debug_enabled();
  if (wrapper == &vphp_null_wrapper) {
    return;
  }
  /*
   * Preserve existing ownership when rebinding the same PHP object.
   * A chainable return or temporary borrowed wrapper must not silently
   * downgrade an already-owned V instance to borrowed, or Zend will later
   * observe a different object lifetime contract than the one used at
   * construction time.
   */
  if (owns_v_ptr) {
    wrapper->owns_v_ptr = 1;
  }
  if (!(wrapper->owns_v_ptr && !owns_v_ptr && wrapper->v_ptr != NULL)) {
    wrapper->cleanup_raw = h->cleanup_raw;
    wrapper->free_raw = h->free_raw;
  } else if (debug_on) {
    snprintf(debug_buf, sizeof(debug_buf),
             "vphp_bind_handlers_with_ownership preserve_owned obj=%p wrapper=%p existing_v_ptr=%p incoming_v_ptr=%p",
             (void *)obj, (void *)wrapper, wrapper->v_ptr, h != NULL ? h->v_ptr : NULL);
    vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
  }
  if (h->v_ptr && !(wrapper->owns_v_ptr && !owns_v_ptr && wrapper->v_ptr != NULL &&
                    wrapper->v_ptr != h->v_ptr)) {
    wrapper->v_ptr = h->v_ptr;
    if (vphp_binding_uses_registry(obj)) {
      vphp_register_object(h->v_ptr, obj);
    }
  } else if (h->v_ptr && wrapper->owns_v_ptr && !owns_v_ptr &&
             wrapper->v_ptr != NULL && wrapper->v_ptr != h->v_ptr) {
    if (debug_on) {
      snprintf(debug_buf, sizeof(debug_buf),
               "vphp_bind_handlers_with_ownership skip_borrowed_rebind obj=%p wrapper=%p existing_v_ptr=%p incoming_v_ptr=%p",
               (void *)obj, (void *)wrapper, wrapper->v_ptr, h->v_ptr);
      vphp_bridge_debug_log("vphp-bridge-debug",debug_buf);
    }
  }
  wrapper->prop_handler = h->prop_handler;
  wrapper->write_handler = h->write_handler;
  wrapper->sync_handler = h->sync_handler;
}

vphp_object_wrapper *vphp_ensure_instance_binding(zend_object *obj,
                                                  vphp_class_handlers *h,
                                                  int owns_v_ptr) {
  vphp_object_wrapper *wrapper = vphp_binding_for_obj(obj, 1);
  if (wrapper == &vphp_null_wrapper) {
    return wrapper;
  }
  /* Inherited methods use the embedded parent payload at offset zero.
   * The existing binding still owns and manages the full derived payload. */
  if (wrapper->v_ptr && wrapper->owns_v_ptr &&
      vphp_object_uses_inline_wrapper(obj)) {
    return wrapper;
  }
  if (!wrapper->v_ptr && wrapper->instance_handlers) {
    h = wrapper->instance_handlers();
  }
  wrapper->cleanup_raw = h->cleanup_raw;
  wrapper->free_raw = h->free_raw;
  wrapper->prop_handler = h->prop_handler;
  wrapper->write_handler = h->write_handler;
  wrapper->sync_handler = h->sync_handler;
  if (wrapper->v_ptr == NULL && h->new_raw != NULL) {
    wrapper->owns_v_ptr = owns_v_ptr ? 1 : wrapper->owns_v_ptr;
    wrapper->v_ptr = h->new_raw();
    if (wrapper->v_ptr != NULL && vphp_binding_uses_registry(obj)) {
      vphp_register_object(wrapper->v_ptr, obj);
    }
  }
  return wrapper;
}

void vphp_bind_handlers(zend_object *obj, vphp_class_handlers *h) {
  vphp_bind_handlers_with_ownership(obj, h, 1);
}

void vphp_bind_owned_handlers(zend_object *obj, vphp_class_handlers *h) {
  vphp_bind_handlers_with_ownership(obj, h, VPHP_OWNS_VPTR);
}

void vphp_bind_borrowed_handlers(zend_object *obj, vphp_class_handlers *h) {
  vphp_bind_handlers_with_ownership(obj, h, VPHP_BORROWS_VPTR);
}

vphp_object_wrapper *vphp_ensure_owned_instance_binding(zend_object *obj,
                                                        vphp_class_handlers *h) {
  return vphp_ensure_instance_binding(obj, h, VPHP_OWNS_VPTR);
}

vphp_object_wrapper *vphp_ensure_borrowed_instance_binding(
    zend_object *obj, vphp_class_handlers *h) {
  return vphp_ensure_instance_binding(obj, h, VPHP_BORROWS_VPTR);
}

void vphp_init_owned_instance(zend_object *obj, vphp_class_handlers *h) {
  vphp_object_wrapper *wrapper = vphp_binding_for_obj(obj, 1);
  if (wrapper == &vphp_null_wrapper || h == NULL) {
    return;
  }
  if (wrapper->instance_handlers) {
    vphp_ensure_owned_instance_binding(obj, h);
    return;
  }
  if (wrapper->v_ptr == NULL && h->new_raw != NULL) {
    wrapper->v_ptr = h->new_raw();
    if (wrapper->v_ptr != NULL && vphp_binding_uses_registry(obj)) {
      vphp_register_object(wrapper->v_ptr, obj);
    }
  }
  vphp_bind_owned_handlers(obj, h);
}
