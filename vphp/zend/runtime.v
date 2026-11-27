module zend

pub fn C.emalloc(size usize) voidptr
pub fn C.efree(ptr voidptr)
fn C.builtin___v_free(ptr voidptr)

pub fn emalloc(size usize) voidptr {
	return C.emalloc(size)
}

pub fn efree(ptr voidptr) {
	C.efree(ptr)
}

pub fn v_runtime_free(ptr voidptr) {
	C.builtin___v_free(ptr)
}

pub fn throw_exception(msg string, code int) {
	// SAFETY: C interop with valid arguments
	unsafe { C.vphp_throw(&char(msg.str), code) }
}

pub fn throw_exception_class(class_name string, msg string, code int) {
	// SAFETY: C interop with valid arguments
	unsafe { C.vphp_throw_class(&char(class_name.str), &char(msg.str), code) }
}

pub fn throw_exception_object(exception &C.zval) {
	C.vphp_throw_object(exception)
}

pub fn throw_exception_object_ptr(exception voidptr) {
	throw_exception_object( // SAFETY: exception is a valid zval pointer from Zend runtime
	unsafe { &C.zval(exception) })
}

pub fn has_exception() bool {
	return C.vphp_has_exception()
}

pub fn exception_message() string {
	mut buffer := []u8{len: 2048}
	written := unsafe { C.vphp_exception_message(&char(&buffer[0]), buffer.len) }
	if written <= 0 {
		return ''
	}
	// SAFETY: buffer contains valid UTF-8 of known length
	return unsafe { (&char(&buffer[0])).vstring_with_len(written).clone() }
}

pub fn exception_message_opt() ?string {
	if !has_exception() {
		return none
	}
	msg := exception_message()
	if msg == '' {
		return none
	}
	return msg
}

pub fn clear_exception() {
	C.vphp_clear_exception()
}

pub fn take_exception(result voidptr) bool {
	return unsafe { C.vphp_take_exception(&C.zval(result)) }
}

pub fn append_exception(primary voidptr, previous voidptr) {
	unsafe { C.vphp_append_exception(&C.zval(primary), &C.zval(previous)) }
}

pub fn report_error(level int, msg string) {
	// SAFETY: C interop block with valid pointer arguments
	unsafe {
		C.vphp_error(level, &char(msg.str))
	}
}

pub fn output_write(msg string) {
	// SAFETY: C interop block with valid pointer arguments
	unsafe {
		C.vphp_output_write(&char(msg.str), msg.len)
	}
}

fn C.vphp_init_fiber_observers()
fn C.vphp_current_fiber_id() usize
fn C.GC_disable()
fn C.GC_enable()
fn C.GC_add_roots(voidptr, voidptr)
fn C.GC_remove_roots(voidptr, voidptr)

@[export: 'vphp_has_boehm_gc']
fn has_boehm_gc() bool {
	$if gcboehm ? {
		return true
	} $else {
		return false
	}
}

@[export: 'vphp_pause_v_gc']
fn pause_v_gc() {
	$if gcboehm ? {
		C.GC_disable()
	}
}

@[export: 'vphp_resume_v_gc']
fn resume_v_gc() {
	$if gcboehm ? {
		C.GC_enable()
	}
}

@[export: 'vphp_add_v_gc_roots']
fn add_v_gc_roots(low voidptr, high voidptr) {
	$if gcboehm ? {
		C.GC_add_roots(low, high)
	}
}

@[export: 'vphp_remove_v_gc_roots']
fn remove_v_gc_roots(low voidptr, high voidptr) {
	$if gcboehm ? {
		C.GC_remove_roots(low, high)
	}
}

pub fn current_fiber_id() usize {
	return C.vphp_current_fiber_id()
}

pub fn framework_init(module_number int) {
	// SAFETY: C interop block with valid pointer arguments
	unsafe {
		C.vphp_init_registry()
		C.vphp_init_resource_system(module_number)
		C.vphp_init_generator_system(module_number)
		C.vphp_init_fiber_observers()
		C.vphp_install_runtime_binding_hooks()
	}
}

pub fn uninstall_runtime_binding_hooks() {
	C.vphp_uninstall_runtime_binding_hooks()
}

pub fn autorelease_shutdown() {
	C.vphp_autorelease_shutdown()
}

pub fn shutdown_registry() {
	C.vphp_shutdown_registry()
}

pub fn request_startup() {
	C.vphp_request_startup()
}

pub fn request_shutdown() {
	C.vphp_request_shutdown()
}

pub fn active_globals_ptr() voidptr {
	return C.vphp_get_active_globals()
}

pub fn autorelease_mark() int {
	return C.vphp_autorelease_mark()
}

pub fn autorelease_add(z &C.zval) {
	C.vphp_autorelease_add(z)
}

pub fn autorelease_add_ptr(z voidptr) {
	autorelease_add( // SAFETY: z is a valid zval pointer from Zend runtime
	unsafe { &C.zval(z) })
}

pub fn autorelease_forget(z &C.zval) {
	C.vphp_autorelease_forget(z)
}

pub fn autorelease_forget_ptr(z voidptr) {
	autorelease_forget( // SAFETY: z is a valid zval pointer from Zend runtime
	unsafe { &C.zval(z) })
}

pub fn autorelease_drain(mark int) {
	C.vphp_autorelease_drain(mark)
}
