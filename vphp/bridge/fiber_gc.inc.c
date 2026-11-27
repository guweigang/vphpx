extern bool vphp_has_boehm_gc(void);
extern void vphp_pause_v_gc(void);
extern void vphp_resume_v_gc(void);
extern void vphp_add_v_gc_roots(void *low, void *high);
extern void vphp_remove_v_gc_roots(void *low, void *high);

#if PHP_VERSION_ID >= 80300 && defined(ZEND_CHECK_STACK_LIMIT) && !defined(__SANITIZE_ADDRESS__)
#define VPHP_HAS_FIBER_STACK_BOUNDS 1
#else
#define VPHP_HAS_FIBER_STACK_BOUNDS 0
#endif

ZEND_TLS size_t vphp_live_fiber_stacks;
ZEND_TLS bool vphp_fiber_gc_paused;
ZEND_TLS bool vphp_fiber_gc_closing;

static void vphp_fiber_gc_pause(void) {
  if (!vphp_fiber_gc_paused) {
    vphp_pause_v_gc();
    vphp_fiber_gc_paused = true;
  }
}

static void vphp_fiber_gc_resume(void) {
  if (vphp_fiber_gc_paused) {
    vphp_fiber_gc_paused = false;
    vphp_resume_v_gc();
  }
}

#if VPHP_HAS_FIBER_STACK_BOUNDS
typedef struct vphp_fiber_gc_stack {
  zend_fiber_context *context;
  void *low;
  void *high;
  struct vphp_fiber_gc_stack *next;
} vphp_fiber_gc_stack;

ZEND_TLS vphp_fiber_gc_stack *vphp_fiber_gc_stacks;

static void vphp_fiber_gc_remove_roots(vphp_fiber_gc_stack *stack) {
  if (stack->low) {
    vphp_remove_v_gc_roots(stack->low, stack->high);
    stack->low = NULL;
    stack->high = NULL;
  }
}

static void vphp_fiber_gc_return_to_main(void) {
  if (!vphp_fiber_gc_paused || vphp_fiber_gc_closing ||
      EG(current_fiber_context) != EG(main_fiber_context)) {
    return;
  }
  for (vphp_fiber_gc_stack *stack = vphp_fiber_gc_stacks; stack; stack = stack->next) {
    zend_fiber_context *fiber = stack->context;
    // boost.context saves its registers on the stack. Other backends may
    // store their saved context elsewhere. Keep the pause in that case.
    if (fiber->status != ZEND_FIBER_STATUS_SUSPENDED || !fiber->stack) {
      return;
    }
    uintptr_t limit = (uintptr_t)zend_fiber_stack_limit(fiber->stack);
    void *base = zend_fiber_stack_base(fiber->stack);
    uintptr_t saved = (uintptr_t)fiber->handle;
    if (saved < limit || saved >= (uintptr_t)base) {
      return;
    }
    if (stack->low != fiber->handle || stack->high != base) {
      vphp_fiber_gc_remove_roots(stack);
      vphp_add_v_gc_roots(fiber->handle, base);
      stack->low = fiber->handle;
      stack->high = base;
    }
  }
  vphp_fiber_gc_resume();
}

#endif

static void vphp_fiber_gc_after_internal_call(const zend_function *function) {
#if VPHP_HAS_FIBER_STACK_BOUNDS
  if (!vphp_fiber_gc_paused || !function || function->common.scope != zend_ce_fiber) {
    return;
  }
  zend_string *name = function->common.function_name;
  if (name && (zend_string_equals_literal_ci(name, "start") ||
               zend_string_equals_literal_ci(name, "resume") ||
               zend_string_equals_literal_ci(name, "throw"))) {
    // The internal method has returned on the actual caller stack. A switch
    // observer itself runs before the machine stack has changed.
    vphp_fiber_gc_return_to_main();
  }
#endif
}

static void vphp_fiber_gc_init(zend_fiber_context *fiber) {
  if (!vphp_has_boehm_gc()) {
    return;
  }
  vphp_live_fiber_stacks++;
  vphp_fiber_gc_pause();
#if VPHP_HAS_FIBER_STACK_BOUNDS
  // Allocate the records outside the PHP request heap so the next request
  // can clear any leftovers if Zend bailed out of the previous request.
  vphp_fiber_gc_stack *stack = pecalloc(1, sizeof(*stack), 1);
  stack->context = fiber;
  stack->next = vphp_fiber_gc_stacks;
  vphp_fiber_gc_stacks = stack;
#endif
}

static void vphp_fiber_gc_switch(void) {
  if (vphp_live_fiber_stacks) {
    // A collector on another thread must finish before the native switch.
    vphp_fiber_gc_pause();
  }
}

static void vphp_fiber_gc_destroy(zend_fiber_context *fiber) {
  if (!vphp_live_fiber_stacks) {
    return;
  }
#if VPHP_HAS_FIBER_STACK_BOUNDS
  vphp_fiber_gc_stack **link = &vphp_fiber_gc_stacks;
  while (*link && (*link)->context != fiber) {
    link = &(*link)->next;
  }
  if (!*link) {
    return;
  }
  vphp_fiber_gc_stack *stack = *link;
  *link = stack->next;
  vphp_fiber_gc_remove_roots(stack);
  pefree(stack, 1);
#endif
  if (--vphp_live_fiber_stacks == 0) {
    vphp_fiber_gc_resume();
    return;
  }
#if VPHP_HAS_FIBER_STACK_BOUNDS
  vphp_fiber_gc_return_to_main();
#endif
}

static void vphp_fiber_gc_request_shutdown(void) {
  vphp_fiber_gc_closing = true;
  if (vphp_live_fiber_stacks) {
    vphp_fiber_gc_pause();
  }
#if VPHP_HAS_FIBER_STACK_BOUNDS
  for (vphp_fiber_gc_stack *stack = vphp_fiber_gc_stacks; stack; stack = stack->next) {
    vphp_fiber_gc_remove_roots(stack);
  }
#endif
}

static void vphp_fiber_gc_request_startup(void) {
  vphp_fiber_gc_request_shutdown();
#if VPHP_HAS_FIBER_STACK_BOUNDS
  while (vphp_fiber_gc_stacks) {
    vphp_fiber_gc_stack *stack = vphp_fiber_gc_stacks;
    vphp_fiber_gc_stacks = stack->next;
    pefree(stack, 1);
  }
#endif
  vphp_live_fiber_stacks = 0;
  vphp_fiber_gc_closing = false;
  vphp_fiber_gc_resume();
}

struct vphp_task_native_pin {
  struct vphp_task_native_pin **link;
  struct vphp_task_native_pin *next;
  zend_fiber_context *fiber;
  zend_object *object;
  zval *values;
  uint32_t value_count;
};

ZEND_TLS vphp_task_native_pin *vphp_task_native_pins = NULL;
ZEND_TLS zend_object_handlers vphp_task_fiber_handlers;
ZEND_TLS const zend_object_handlers *vphp_original_fiber_handlers;

static HashTable *vphp_task_fiber_get_gc(zend_object *object, zval **table, int *n) {
  HashTable *properties = vphp_original_fiber_handlers->get_gc(object, table, n);
  zend_fiber *fiber = (zend_fiber *)object;
  if (fiber->context.status != ZEND_FIBER_STATUS_SUSPENDED ||
      fiber->caller != NULL) {
    return properties;
  }

  zval *original = *table;
  zend_get_gc_buffer *buffer = zend_get_gc_buffer_create();
  if (original == buffer->start && *n > 0) {
    // Zend's Fiber handler already filled the shared GC buffer.
    buffer->cur = buffer->start + *n;
  } else {
    for (int i = 0; i < *n; i++) {
      zend_get_gc_buffer_add_zval(buffer, &original[i]);
    }
  }
  for (vphp_task_native_pin *pin = vphp_task_native_pins; pin; pin = pin->next) {
    if (pin->fiber != &fiber->context) {
      continue;
    }
    // The native bridge and the reference synchronizer each own their own
    // pin. Zend already visits the method frame's separate $this reference.
    if (pin->object) {
      zend_get_gc_buffer_add_obj(buffer, pin->object);
    }
    for (uint32_t i = 0; i < pin->value_count; i++) {
      zend_get_gc_buffer_add_zval(buffer, &pin->values[i]);
    }
  }
  // These slots own request zvals until their V scope on this Fiber unwinds.
  for (vphp_fiber_autorelease_pool *pool = vphp_fiber_autorelease_pools; pool; pool = pool->next) {
    if (pool->fiber == &fiber->context) {
      for (int i = 0; i < pool->pool.len; i++) {
        if (pool->pool.items[i]) {
          zend_get_gc_buffer_add_zval(buffer, pool->pool.items[i]);
        }
      }
      break;
    }
  }
#if PHP_VERSION_ID < 80700
  // Zend 8.2–8.6 traces userland frames and the receiver of an internal
  // method, but omits owned arguments of active internal calls.
  for (zend_execute_data *call = fiber->execute_data; call; call = call->prev_execute_data) {
    if (!call->func || call->func->type != ZEND_INTERNAL_FUNCTION) {
      continue;
    }
    uint32_t count = ZEND_CALL_NUM_ARGS(call);
    for (uint32_t i = 1; i <= count; i++) {
      zend_get_gc_buffer_add_zval(buffer, ZEND_CALL_ARG(call, i));
    }
    if (ZEND_CALL_INFO(call) & ZEND_CALL_HAS_EXTRA_NAMED_PARAMS) {
      zval named;
      ZVAL_ARR(&named, call->extra_named_params);
      zend_get_gc_buffer_add_zval(buffer, &named);
    }
  }
#endif
  zend_get_gc_buffer_use(buffer, table, n);
  return properties;
}

static void vphp_task_attach_fiber_gc(zend_object *object) {
  // PHP 8.2 exposes the Fiber handlers on the instance. Managed Fibers and
  // their handler copy stay in the Zend thread that created them.
  if (!vphp_original_fiber_handlers) {
    vphp_original_fiber_handlers = object->handlers;
    vphp_task_fiber_handlers = *object->handlers;
    vphp_task_fiber_handlers.get_gc = vphp_task_fiber_get_gc;
  }
  if (object->handlers == vphp_original_fiber_handlers) {
    object->handlers = &vphp_task_fiber_handlers;
  }
}

static vphp_task_native_pin *vphp_new_task_native_pin(void) {
  if (!vphp_task_can_suspend() || EG(active_fiber)->std.handlers != &vphp_task_fiber_handlers) {
    return NULL;
  }
  vphp_task_native_pin *pin = ecalloc(1, sizeof(*pin));
  pin->link = &vphp_task_native_pins;
  pin->next = vphp_task_native_pins;
  if (pin->next) {
    pin->next->link = &pin->next;
  }
  pin->fiber = &EG(active_fiber)->context;
  vphp_task_native_pins = pin;
  return pin;
}

vphp_task_native_pin *vphp_pin_native_receiver(zend_object *obj) {
  GC_ADDREF(obj);
  vphp_task_native_pin *pin = vphp_new_task_native_pin();
  if (pin) {
    pin->object = obj;
  }
  return pin;
}

static vphp_task_native_pin *vphp_task_trace_values(zval *values, uint32_t count) {
  if (!values || !count) {
    return NULL;
  }
  vphp_task_native_pin *pin = vphp_new_task_native_pin();
  if (pin) {
    pin->values = values;
    pin->value_count = count;
  }
  return pin;
}

static void vphp_task_untrace_values(vphp_task_native_pin *pin) {
  if (pin) {
    *pin->link = pin->next;
    if (pin->next) {
      pin->next->link = pin->link;
    }
    efree(pin);
  }
}

void vphp_unpin_native_receiver(zend_object *obj, vphp_task_native_pin *pin) {
  vphp_task_untrace_values(pin);
  OBJ_RELEASE(obj);
}

static void vphp_release_task_fiber_pins(zend_fiber_context *fiber) {
  // A bailout can bypass the ordinary bridge epilogues. Unlink all matching
  // entries before releasing their objects because a destructor can reenter.
  vphp_task_native_pin *released = NULL;
  vphp_task_native_pin **link = &vphp_task_native_pins;
  while (*link) {
    vphp_task_native_pin *pin = *link;
    if (pin->fiber != fiber) {
      link = &pin->next;
      continue;
    }
    *link = pin->next;
    if (*link) {
      (*link)->link = link;
    }
    pin->next = released;
    released = pin;
  }
  while (released) {
    vphp_task_native_pin *pin = released;
    released = pin->next;
    zend_object *obj = pin->object;
    efree(pin);
    if (obj) {
      OBJ_RELEASE(obj);
    }
  }
}
