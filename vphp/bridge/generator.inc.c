/* The PHP VM owns the suspended frame. This factory translates between
 * native yield/send/throw and the extension's explicit producer steps. */
/* Resume kind values match PhpGeneratorResumeKind in php_generator_type.v. */
#define VPHP_GENERATOR_BODY(DELEGATE) \
    " (\\Closure $resume, $state): \\Generator {" \
    "  $value = null; $exception = null; $kind = 0;" \
    "  try { while (true) {" \
    "    $step = $resume($state, $value, $exception, $kind, false);" \
    "    $value = null; $exception = null;" \
    "    if ($step[0] === 1) { return $step[1]; }" \
    "    $kind = 1;" \
    "    try {" \
    DELEGATE \
    "      if (\\count($step) === 3) { $value = yield $step[1] => $step[2]; }" \
    "      else { $value = yield $step[1]; }" \
    "    } catch (\\Throwable $exception) {}" \
    "  } } finally { $resume($state, null, null, 0, true); }" \
    "}"

/* Transfer the delegate out of the step so Zend can release it before resuming V. */
static const char vphp_generator_factory[] = "static function" VPHP_GENERATOR_BODY(
    "if ($step[0] === 2) { $kind = 2; $value = yield from \\array_pop($step); continue; }");
static const char vphp_reference_generator_factory[] = "static function &" VPHP_GENERATOR_BODY("");

#undef VPHP_GENERATOR_BODY

typedef struct {
  void *state;
  vphp_generator_resume resume;
  vphp_generator_close close;
  vphp_generator_release release;
  zval capture;
  bool closed;
  bool release_capture_after_start;
  zend_object std;
} vphp_generator_state;

static zend_object_handlers vphp_generator_state_handlers;

static vphp_generator_state *vphp_generator_state_from_object(zend_object *object) {
  return (vphp_generator_state *)((char *)object - offsetof(vphp_generator_state, std));
}

static void vphp_release_generator_capture(vphp_generator_state *producer) {
  zval capture;
  ZVAL_COPY_VALUE(&capture, &producer->capture);
  ZVAL_UNDEF(&producer->capture);
  zval_ptr_dtor(&capture);
}

static void vphp_close_generator_state(vphp_generator_state *producer) {
  if (producer->closed) {
    return;
  }
  producer->closed = true;
  producer->close(producer->state, &producer->capture);
  vphp_release_generator_capture(producer);
}

static void vphp_generator_state_destroy(zend_object *object) {
  // An unstarted generator has no finally block to run. Follow PHP destructor
  // semantics if dropping its last reference happens while an exception unwinds.
  zend_object *pending = EG(exception);
  zend_execute_data *execute_data = EG(current_execute_data);
  const zend_op *previous_opline = EG(opline_before_exception);
  bool user_frame = execute_data && execute_data->func &&
                    ZEND_USER_CODE(execute_data->func->common.type);
  if (pending) {
    if (user_frame) {
      zend_rethrow_exception(execute_data);
      previous_opline = EG(opline_before_exception);
      execute_data->opline = previous_opline;
    }
    EG(exception) = NULL;
  }

  vphp_close_generator_state(vphp_generator_state_from_object(object));

  if (pending) {
    if (user_frame) {
      execute_data->opline = EG(exception_op);
      EG(opline_before_exception) = previous_opline;
    }
    if (EG(exception)) {
      zend_exception_set_previous(EG(exception), pending);
    } else {
      EG(exception) = pending;
    }
  }
}

static void vphp_generator_state_free(zend_object *object) {
  vphp_generator_state *producer = vphp_generator_state_from_object(object);
  producer->release(producer->state);
  zval_ptr_dtor(&producer->capture);
  zend_object_std_dtor(object);
}

static HashTable *vphp_generator_state_get_gc(zend_object *object, zval **table,
                                             int *n) {
  vphp_generator_state *producer = vphp_generator_state_from_object(object);
  *table = &producer->capture;
  *n = 1;
  return object->properties;
}

void vphp_init_generator_system(int module_number) {
  (void)module_number;
  memcpy(&vphp_generator_state_handlers, zend_get_std_object_handlers(),
         sizeof(zend_object_handlers));
  vphp_generator_state_handlers.offset = offsetof(vphp_generator_state, std);
  vphp_generator_state_handlers.dtor_obj = vphp_generator_state_destroy;
  vphp_generator_state_handlers.free_obj = vphp_generator_state_free;
  vphp_generator_state_handlers.get_gc = vphp_generator_state_get_gc;
  vphp_generator_state_handlers.clone_obj = NULL;
}

static void ZEND_FASTCALL vphp_generator_resume_handler(
    zend_execute_data *execute_data, zval *return_value) {
  zval *state, *sent, *exception;
  zend_long kind;
  bool close;
  ZEND_PARSE_PARAMETERS_START(5, 5)
    Z_PARAM_OBJECT(state)
    Z_PARAM_ZVAL(sent)
    Z_PARAM_ZVAL(exception)
    Z_PARAM_LONG(kind)
    Z_PARAM_BOOL(close)
  ZEND_PARSE_PARAMETERS_END();

  if (Z_OBJ_HT_P(state) != &vphp_generator_state_handlers) {
    zend_type_error("Invalid VPHP generator state");
    return;
  }
  vphp_generator_state *producer = vphp_generator_state_from_object(Z_OBJ_P(state));
  if (close) {
    vphp_close_generator_state(producer);
    return;
  }
  if (producer->closed) {
    zend_throw_error(NULL, "Cannot resume a closed VPHP generator producer");
    return;
  }
  producer->resume(producer->state, sent, exception, &producer->capture, (int)kind,
                   return_value);
  // The completed step owns its delegate. On failure, the PHP frame's finally
  // block releases the capture while unwinding the original exception.
  if (producer->release_capture_after_start && kind == 0 && !EG(exception)) {
    vphp_release_generator_capture(producer);
  }
}

bool vphp_create_generator(zval *result, zval *capture, void *state,
                           vphp_generator_resume resume,
                           vphp_generator_close close,
                           vphp_generator_release release, bool by_reference,
                           bool release_capture_after_start) {
  vphp_generator_state *producer = zend_object_alloc(sizeof(*producer),
                                                     zend_standard_class_def);
  producer->state = state;
  producer->resume = resume;
  producer->close = close;
  producer->release = release;
  producer->closed = false;
  producer->release_capture_after_start = release_capture_after_start;
  if (capture && !Z_ISUNDEF_P(capture)) {
    ZVAL_COPY(&producer->capture, capture);
  } else {
    ZVAL_NULL(&producer->capture);
  }
  zend_object_std_init(&producer->std, zend_standard_class_def);
  object_properties_init(&producer->std, zend_standard_class_def);
  producer->std.handlers = &vphp_generator_state_handlers;

  zval factory, callback, owner;
  ZVAL_UNDEF(&factory);
  ZVAL_UNDEF(&callback);
  ZVAL_OBJ(&owner, &producer->std);
  bool ok = false;
  const char *source = by_reference ? vphp_reference_generator_factory : vphp_generator_factory;
  if (!EG(exception) &&
      zend_eval_stringl(source, strlen(source),
                        &factory, "VPHP Generator Factory") == SUCCESS &&
      !EG(exception)) {
    zend_internal_function bridge = {0};
    bridge.type = ZEND_INTERNAL_FUNCTION;
    bridge.fn_flags = ZEND_ACC_PUBLIC | ZEND_ACC_CLOSURE;
    bridge.handler = vphp_generator_resume_handler;
    bridge.function_name = zend_string_init("VPHPGeneratorStep", 17, 0);
    bridge.num_args = bridge.required_num_args = 5;
    vphp_zend_create_closure(&callback, (zend_function *)&bridge);
    zend_string_release(bridge.function_name);
    zval *params[] = {&callback, &owner};
    ok = vphp_call_callable(&factory, result, 2, params) == SUCCESS &&
         !EG(exception);
  }
  zval_ptr_dtor(&callback);
  zval_ptr_dtor(&factory);
  zval_ptr_dtor(&owner);
  return ok;
}
