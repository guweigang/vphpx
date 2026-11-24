typedef struct {
  void *value;
  void (*release)(void *);
} vphp_request_static_slot;

typedef struct vphp_static_sync {
  struct vphp_static_sync *previous;
  zend_execute_data *call;
  void *ce;
  void (*from_php)(void *);
  void (*to_php)(void *);
} vphp_static_sync;

typedef struct vphp_static_request_frame {
  HashTable slots;
  bool initialized;
  vphp_static_sync *sync;
  struct vphp_static_request_frame *previous;
  struct vphp_static_request_frame *next;
  zend_fiber_context *fiber;
  const vphp_static_request_property *properties;
  size_t property_count;
  HashTable snapshots;
  zval deferred;
} vphp_static_request_frame;

typedef struct {
  zval *property;
  zend_property_info *info;
  zval saved;
  zval saved_referent;
  zval discarded;
  zval parked_reference;
  bool captured;
} vphp_static_request_snapshot;

ZEND_TLS vphp_static_request_frame vphp_root_static_request;
ZEND_TLS vphp_static_request_frame *vphp_current_static_request;
ZEND_TLS vphp_static_request_frame *vphp_static_requests;

static vphp_static_request_frame *vphp_active_static_request(void) {
  return vphp_current_static_request ? vphp_current_static_request
                                     : &vphp_root_static_request;
}

void *vphp_current_static_sync_class(void (*from_php)(void *)) {
  for (vphp_static_sync *sync = vphp_active_static_request()->sync; sync;
       sync = sync->previous) {
    if (sync->from_php == from_php) {
      return sync->ce;
    }
  }
  return NULL;
}

void *vphp_static_shadow_owner(zend_class_entry *ce, const char *base,
                               size_t base_len, const char *fields,
                               size_t fields_len) {
  // The nearest class that redeclares any table field identifies this view
  // of the table. Further subclasses that inherit these fields reuse it.
  for (zend_class_entry *owner = ce; owner; owner = owner->parent) {
    if (zend_binary_strcasecmp(ZSTR_VAL(owner->name), ZSTR_LEN(owner->name),
                              base, base_len) == 0) {
      break;
    }
    for (const char *field = fields; field < fields + fields_len;) {
      size_t len = strlen(field);
      zend_property_info *info =
          zend_hash_str_find_ptr(&ce->properties_info, field, len);
      if (info && info->ce == owner) {
        return owner;
      }
      field += len + 1;
    }
  }
  return NULL;
}

static void vphp_release_request_static_slot(zval *entry) {
  vphp_request_static_slot *slot = Z_PTR_P(entry);
  slot->release(slot->value);
  efree(slot);
}

static void vphp_destroy_static_request_frame(vphp_static_request_frame *frame) {
  if (frame->initialized) {
    zend_hash_destroy(&frame->slots);
    frame->initialized = false;
  }
  frame->sync = NULL;
}

static void vphp_clear_static_request(void) {
  vphp_current_static_request = NULL;
  vphp_static_requests = NULL;
  vphp_destroy_static_request_frame(&vphp_root_static_request);
}

void *vphp_find_request_static_state(const char *key, size_t key_len) {
  vphp_static_request_frame *frame = vphp_active_static_request();
  if (!frame->initialized) {
    return NULL;
  }
  vphp_request_static_slot *slot =
      zend_hash_str_find_ptr(&frame->slots, key, key_len);
  return slot ? slot->value : NULL;
}

void vphp_store_request_static_state(const char *key, size_t key_len,
                                     void *value, void (*release)(void *)) {
  vphp_static_request_frame *frame = vphp_active_static_request();
  if (!frame->initialized) {
    zend_hash_init(&frame->slots, 4, NULL, vphp_release_request_static_slot, 0);
    frame->initialized = true;
  }
  vphp_request_static_slot *slot = emalloc(sizeof(*slot));
  slot->value = value;
  slot->release = release;
  zend_hash_str_update_ptr(&frame->slots, key, key_len, slot);
}

void *vphp_begin_static_sync(void *ce, void (*from_php)(void *),
                              void (*to_php)(void *)) {
  vphp_static_request_frame *frame = vphp_active_static_request();
  vphp_static_sync *sync = emalloc(sizeof(*sync));
  sync->previous = frame->sync;
  sync->call = EG(current_execute_data);
  sync->ce = ce;
  sync->from_php = from_php;
  sync->to_php = to_php;
  from_php(ce);
  frame->sync = sync;
  return sync;
}

void vphp_end_static_sync(void *scope) {
  vphp_static_request_frame *frame = vphp_active_static_request();
  vphp_static_sync *sync = scope;
  ZEND_ASSERT(frame->sync == sync);
  frame->sync = sync->previous;
  sync->to_php(sync->ce);
  efree(sync);
}

// A PHP callback can change the backing properties and enter more V methods.
// While PHP runs, only the V methods it enters should be active.
static vphp_static_sync *vphp_suspend_static_sync(void) {
  vphp_static_request_frame *frame = vphp_active_static_request();
  vphp_static_sync *active = frame->sync;
  frame->sync = NULL;
  for (vphp_static_sync *sync = active; sync; sync = sync->previous) {
    sync->to_php(sync->ce);
  }
  return active;
}

static void vphp_resume_static_sync(vphp_static_sync *active) {
  for (vphp_static_sync *sync = active; sync; sync = sync->previous) {
    sync->from_php(sync->ce);
  }
  vphp_active_static_request()->sync = active;
}

static bool vphp_uses_static_request_trait(const zend_class_entry *ce,
                                           const zend_class_entry *trait) {
  for (uint32_t i = 0; i < ce->num_traits; i++) {
    const zend_class_entry *used =
        zend_hash_find_ptr(EG(class_table), ce->trait_names[i].lc_name);
    if (used && (used == trait || vphp_uses_static_request_trait(used, trait))) {
      return true;
    }
  }
  return false;
}

static bool vphp_inherits_static_request_trait(const zend_class_entry *ce,
                                               const zend_class_entry *trait) {
  for (; ce; ce = ce->parent) {
    if (vphp_uses_static_request_trait(ce, trait)) {
      return true;
    }
  }
  return false;
}

// Only materialized storage can hold values left by an earlier dispatch.
static void vphp_collect_static_request_slots(
    HashTable *snapshots, const vphp_static_request_property *properties,
    size_t count) {
  zend_class_entry *ce;
  ZEND_HASH_FOREACH_PTR(EG(class_table), ce) {
    if (!(ce->ce_flags & ZEND_ACC_LINKED) || (ce->ce_flags & ZEND_ACC_TRAIT) ||
        !ce->default_static_members_count || !CE_STATIC_MEMBERS(ce)) {
      continue;
    }
    for (size_t i = 0; i < count; i++) {
      const vphp_static_request_property *spec = &properties[i];
      zend_class_entry *root = *spec->ce;
      if (!root) {
        continue;
      }
      bool trait = (root->ce_flags & ZEND_ACC_TRAIT) != 0;
      zend_property_info *info =
          zend_hash_str_find_ptr(&ce->properties_info, spec->name, spec->name_len);
      if (!info || !(info->flags & ZEND_ACC_STATIC)) {
        continue;
      }
      // PHP 8.2 may reuse a compatible slot declared above the trait consumer.
      if (trait ? !vphp_inherits_static_request_trait(ce, root)
                : (info->ce != ce || !instanceof_function(ce, root))) {
        continue;
      }
      // A PHP subclass can declare a name whose VPHP declaration is gated off.
      const zend_property_info *declared =
          zend_hash_str_find_ptr(&root->properties_info, spec->name, spec->name_len);
      if (!declared || !(declared->flags & ZEND_ACC_STATIC)) {
        continue;
      }
      zval *slot = &CE_STATIC_MEMBERS(ce)[info->offset];
      ZVAL_DEINDIRECT(slot);
      zend_ulong key = (zend_ulong)(uintptr_t)slot;
      if (!zend_hash_index_exists(snapshots, key)) {
        vphp_static_request_snapshot snapshot = {.property = slot, .info = info};
        zend_hash_index_add_mem(snapshots, key, &snapshot, sizeof(snapshot));
      }
    }
  } ZEND_HASH_FOREACH_END();
}

static bool vphp_copy_static_request_default(
    const vphp_static_request_snapshot *snapshot, zval *value) {
  zend_property_info *info = snapshot->info;
  zval *initial = &info->ce->default_static_members_table[info->offset];
  ZVAL_DEINDIRECT(initial);
  ZVAL_COPY(value, initial);
  // Zend may leave an AST in the declaration after resolving the live slot.
  if (Z_TYPE_P(value) == IS_CONSTANT_AST) {
    int reporting = EG(error_reporting);
    int handler_reporting = EG(user_error_handler_error_reporting);
    if (Z_TYPE_P(snapshot->property) != IS_CONSTANT_AST) {
      // The live slot has already emitted diagnostics for this initializer.
      EG(error_reporting) = 0;
      EG(user_error_handler_error_reporting) = 0;
    }
    zend_result status = zval_update_constant_ex(value, info->ce);
    EG(user_error_handler_error_reporting) = handler_reporting;
    EG(error_reporting) = reporting;
    if (status == FAILURE ||
        (ZEND_TYPE_IS_SET(info->type) &&
         !zend_verify_property_type(info, value, true))) {
      zval_ptr_dtor(value);
      return false;
    }
  }
  return true;
}

static void vphp_detach_static_request_reference(zval *slot,
                                                 zend_property_info *info) {
  if (Z_ISREF_P(slot) && ZEND_TYPE_IS_SET(info->type)) {
    ZEND_REF_DEL_TYPE_SOURCE(Z_REF_P(slot), info);
  }
}

static bool vphp_reset_static_request_slots(HashTable *snapshots) {
  vphp_static_request_snapshot *snapshot;
  ZEND_HASH_FOREACH_PTR(snapshots, snapshot) {
    zval initial;
    if (!vphp_copy_static_request_default(snapshot, &initial)) {
      return false;
    }
    zval *slot = snapshot->property;
    ZVAL_COPY_VALUE(&snapshot->saved, slot);
    snapshot->captured = true;
    if (Z_ISREF_P(slot)) {
      // Keep the original type source on the saved reference. Aliases held
      // by PHP still have to satisfy the outer property's type.
      ZVAL_COPY(&snapshot->saved_referent, Z_REFVAL_P(slot));
    }
    ZVAL_COPY_VALUE(slot, &initial);
  } ZEND_HASH_FOREACH_END();
  return true;
}

static void vphp_restore_static_request_slots(HashTable *snapshots,
                                              bool dispatched) {
  vphp_static_request_snapshot *snapshot;
  ZEND_HASH_REVERSE_FOREACH_PTR(snapshots, snapshot) {
    zval value;
    if (snapshot->captured) {
      ZVAL_COPY_VALUE(&value, &snapshot->saved);
    } else if (!dispatched || !vphp_copy_static_request_default(snapshot, &value)) {
      continue;
    }
    zval *slot = snapshot->property;
    vphp_detach_static_request_reference(slot, snapshot->info);
    ZVAL_COPY_VALUE(&snapshot->discarded, slot);
    ZVAL_COPY_VALUE(slot, &value);
    if (snapshot->captured && Z_ISREF_P(slot)) {
      zval *referent = Z_REFVAL_P(slot);
      zval previous;
      ZVAL_COPY_VALUE(&previous, referent);
      ZVAL_COPY_VALUE(referent, &snapshot->saved_referent);
      ZVAL_COPY_VALUE(&snapshot->saved_referent, &previous);
    }
  } ZEND_HASH_FOREACH_END();

  // Destructors can access other static properties or enter another logical
  // request. Release the inner values only after all outer bindings are live.
  ZEND_HASH_REVERSE_FOREACH_PTR(snapshots, snapshot) {
    zval_ptr_dtor(&snapshot->discarded);
    zval_ptr_dtor(&snapshot->saved_referent);
  } ZEND_HASH_FOREACH_END();
}

static void vphp_free_static_request_snapshot(zval *entry) {
  efree(Z_PTR_P(entry));
}

static void vphp_swap_static_values(zval *left, zval *right) {
  zval value;
  ZVAL_COPY_VALUE(&value, left);
  ZVAL_COPY_VALUE(left, right);
  ZVAL_COPY_VALUE(right, &value);
}

// Drop these values during scope cleanup, where destructors can reenter PHP.
static void vphp_defer_static_value(vphp_static_request_frame *frame, zval *value) {
  if (Z_REFCOUNTED_P(value)) {
    if (Z_ISUNDEF(frame->deferred)) {
      array_init(&frame->deferred);
    }
    add_next_index_zval(&frame->deferred, value);
  }
  ZVAL_UNDEF(value);
}

// A slot first materialized while a frame runs belongs to that frame. When
// first seen on resume, its live value instead belongs to the parent scope.
static void vphp_complete_static_request_image(vphp_static_request_frame *frame) {
  vphp_collect_static_request_slots(&frame->snapshots, frame->properties,
                                    frame->property_count);
  vphp_static_request_snapshot *snapshot;
  ZEND_HASH_FOREACH_PTR(&frame->snapshots, snapshot) {
    if (snapshot->captured || Z_TYPE_P(snapshot->property) == IS_CONSTANT_AST) {
      continue;
    }
    snapshot->captured = vphp_copy_static_request_default(snapshot, &snapshot->saved);
  } ZEND_HASH_FOREACH_END();
}

static void vphp_park_static_request(vphp_static_request_frame *frame) {
  vphp_complete_static_request_image(frame);
  vphp_static_request_snapshot *snapshot;
  ZEND_HASH_REVERSE_FOREACH_PTR(&frame->snapshots, snapshot) {
    if (!snapshot->captured) {
      continue;
    }
    if (Z_ISREF(snapshot->saved)) {
      ZVAL_COPY(&snapshot->parked_reference, &snapshot->saved);
      if (Z_ISUNDEF(snapshot->saved_referent)) {
        ZVAL_COPY(&snapshot->saved_referent, Z_REFVAL(snapshot->saved));
      }
      vphp_swap_static_values(Z_REFVAL(snapshot->saved), &snapshot->saved_referent);
    }
    vphp_swap_static_values(snapshot->property, &snapshot->saved);
  } ZEND_HASH_FOREACH_END();
}

static void vphp_unpark_static_request(vphp_static_request_frame *frame) {
  // Reverse the parking order both across nested frames and within a frame.
  // Several slots can share a reference, so each referent swap must unwind.
  if (frame->previous) {
    vphp_unpark_static_request(frame->previous);
  }
  vphp_complete_static_request_image(frame);
  vphp_static_request_snapshot *snapshot;
  ZEND_HASH_FOREACH_PTR(&frame->snapshots, snapshot) {
    if (!snapshot->captured) {
      continue;
    }
    vphp_swap_static_values(snapshot->property, &snapshot->saved);
    if (Z_ISREF(snapshot->saved) && Z_ISREF(snapshot->parked_reference) &&
        Z_REF(snapshot->saved) == Z_REF(snapshot->parked_reference)) {
      vphp_swap_static_values(Z_REFVAL(snapshot->saved), &snapshot->saved_referent);
      // The reinstated parent image still keeps this reference alive.
      Z_DELREF(snapshot->parked_reference);
      ZVAL_UNDEF(&snapshot->parked_reference);
    } else {
      vphp_defer_static_value(frame, &snapshot->saved_referent);
      if (Z_ISREF(snapshot->saved)) {
        ZVAL_COPY(&snapshot->saved_referent, Z_REFVAL(snapshot->saved));
      }
    }
    vphp_defer_static_value(frame, &snapshot->parked_reference);
  } ZEND_HASH_FOREACH_END();
}

static void vphp_switch_static_request(zend_fiber_context *from,
                                        zend_fiber_context *to) {
  if (!vphp_static_requests) {
    return;
  }
  if (vphp_current_static_request && vphp_current_static_request->fiber != from) {
    return;
  }
  for (vphp_static_request_frame *frame = vphp_current_static_request;
       frame; frame = frame->previous) {
    vphp_park_static_request(frame);
  }
  vphp_static_request_frame *next = vphp_static_requests;
  while (next && next->fiber != to) {
    next = next->next;
  }
  vphp_current_static_request = next;
  if (next) {
    vphp_unpark_static_request(next);
  }
}

// PHP's physical request hooks do not run between dispatches in CLI workers.
// Temporarily replace each backing PHP property with its declared default.
void vphp_run_static_request(INTERNAL_FUNCTION_PARAMETERS,
                              const vphp_static_request_property *properties,
                              size_t count) {
  zend_fcall_info fci;
  zend_fcall_info_cache fcc;
  ZEND_PARSE_PARAMETERS_START(1, 1)
    Z_PARAM_FUNC(fci, fcc)
  ZEND_PARSE_PARAMETERS_END();

  vphp_static_request_frame *frame = ecalloc(1, sizeof(*frame));
  HashTable *snapshots = &frame->snapshots;
  zend_hash_init(snapshots, count, NULL, vphp_free_static_request_snapshot, 0);
  vphp_collect_static_request_slots(snapshots, properties, count);

  frame->properties = properties;
  frame->property_count = count;
  frame->fiber = EG(current_fiber_context);
  frame->previous = vphp_current_static_request;
  frame->next = vphp_static_requests;
  vphp_static_requests = frame;
  vphp_current_static_request = frame;
  fci.retval = return_value;
  volatile bool dispatched = false;
  volatile bool bailed_out = false;
  zend_try {
    if (vphp_reset_static_request_slots(snapshots)) {
      dispatched = true;
      zend_call_function(&fci, &fcc);
    }
  } zend_catch {
    bailed_out = true;
  } zend_end_try();
  vphp_static_request_frame **link = &vphp_static_requests;
  while (*link != frame) {
    link = &(*link)->next;
  }
  *link = frame->next;
  vphp_current_static_request = frame->previous;
  vphp_destroy_static_request_frame(frame);

  // Classes loaded and slots initialized during this dispatch have no outer
  // value to restore. Leave them at their declarations for the enclosing code.
  bool reset_new_slots = dispatched && !bailed_out;
  if (reset_new_slots) {
    vphp_collect_static_request_slots(snapshots, properties, count);
  }
  // Cleanup can invoke PHP destructors that start another request scope.
  // Keep this exception on the stack so nested cleanup cannot consume it.
  zend_object *pending_exception = reset_new_slots ? EG(exception) : NULL;
  if (pending_exception) {
    EG(exception) = NULL;
  }
  vphp_restore_static_request_slots(snapshots, reset_new_slots);
  zval_ptr_dtor(&frame->deferred);
  if (pending_exception) {
    if (EG(exception)) {
      zend_exception_set_previous(EG(exception), pending_exception);
    } else {
      EG(exception) = pending_exception;
    }
  }
  zend_hash_destroy(snapshots);
  efree(frame);
  if (bailed_out) {
    zend_bailout();
  }
}
