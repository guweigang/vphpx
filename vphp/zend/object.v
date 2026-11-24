module zend

fn C.vphp_owned_object_php_state(v_ptr voidptr) &C.zval
fn C.vphp_weak_map_find(entries &C.zval, key &C.zval, reference bool) &C.zval
fn C.vphp_weak_map_bind_reference(entries &C.zval, key &C.zval, reference &C.zval) bool
fn C.vphp_lazy_objects_supported() bool
fn C.vphp_clone_with_supported() bool
fn C.vphp_object_is_uninitialized_lazy(value &C.zval) bool

pub fn owned_object_php_state_ptr(v_ptr voidptr) voidptr {
	return C.vphp_owned_object_php_state(v_ptr)
}

pub fn weak_map_find(entries &C.zval, key &C.zval, reference bool) voidptr {
	return C.vphp_weak_map_find(entries, key, reference)
}

pub fn weak_map_bind_reference(entries &C.zval, key &C.zval, reference &C.zval) bool {
	return C.vphp_weak_map_bind_reference(entries, key, reference)
}

pub fn lazy_objects_supported() bool {
	return C.vphp_lazy_objects_supported()
}

pub fn clone_with_supported() bool {
	return C.vphp_clone_with_supported()
}

pub fn object_is_uninitialized_lazy(value &C.zval) bool {
	return C.vphp_object_is_uninitialized_lazy(value)
}

pub fn new_plain_object_tracker() voidptr {
	return C.vphp_new_plain_object_tracker()
}

pub fn capture_plain_object(tracker voidptr, root voidptr) voidptr {
	return C.vphp_capture_plain_object(tracker, unsafe { &C.zval(root) })
}

pub fn restore_plain_objects(handle voidptr) {
	C.vphp_restore_plain_objects(handle)
}

pub fn release_plain_object_state(handle voidptr) {
	C.vphp_release_plain_object_state(handle)
}

fn C.vphp_object_is_instance_of(obj voidptr, ce voidptr) bool
fn C.vphp_object_matches_external_interface(value &C.zval, name &char, len int) bool
fn C.vphp_object_method_required_params(value &C.zval, name &char, name_len usize) int

pub fn object_method_required_params(value &C.zval, name string) int {
	return C.vphp_object_method_required_params(value, name.str, usize(name.len))
}

pub fn object_is_instance_of(obj voidptr, ce voidptr) bool {
	return C.vphp_object_is_instance_of(obj, ce)
}

pub fn object_matches_external_interface(value voidptr, name string) bool {
	return C.vphp_object_matches_external_interface(unsafe { &C.zval(value) }, &char(name.str),
		name.len)
}

pub fn allocate_contiguous_object(ce voidptr, v_size usize) voidptr {
	return C.vphp_allocate_contiguous_object(ce, v_size)
}

pub fn object_add_ref(obj &C.zend_object) {
	C.vphp_object_addref(obj)
}

pub fn object_add_ref_ptr(obj voidptr) {
	object_add_ref( // SAFETY: obj is a valid zend_object pointer from Zend runtime
	unsafe { &C.zend_object(obj) })
}

pub fn object_release(obj &C.zend_object) {
	C.vphp_object_release(obj)
}

pub fn object_release_ptr(obj voidptr) {
	object_release( // SAFETY: obj is a valid zend_object pointer from Zend runtime
	unsafe { &C.zend_object(obj) })
}

pub fn bind_borrowed_handlers(obj &C.zend_object, handlers voidptr) {
	C.vphp_bind_borrowed_handlers(obj, handlers)
}

pub fn bind_borrowed_handlers_ptr(obj voidptr, handlers voidptr) {
	bind_borrowed_handlers( // SAFETY: obj is a valid zend_object pointer from Zend runtime
	unsafe { &C.zend_object(obj) }, handlers)
}

pub fn bind_owned_handlers(obj &C.zend_object, handlers voidptr) {
	C.vphp_bind_owned_handlers(obj, handlers)
}

pub fn bind_owned_handlers_ptr(obj voidptr, handlers voidptr) {
	bind_owned_handlers( // SAFETY: obj is a valid zend_object pointer from Zend runtime
	unsafe { &C.zend_object(obj) }, handlers)
}

pub fn ensure_borrowed_instance_binding(obj &C.zend_object, handlers voidptr) &C.vphp_object_wrapper {
	return C.vphp_ensure_borrowed_instance_binding(obj, handlers)
}

pub fn ensure_borrowed_instance_binding_ptr(obj voidptr, handlers voidptr) voidptr {
	return ensure_borrowed_instance_binding( // SAFETY: obj is a valid zend_object pointer from Zend runtime
	unsafe { &C.zend_object(obj) }, handlers)
}

pub fn ensure_owned_instance_binding(obj &C.zend_object, handlers voidptr) &C.vphp_object_wrapper {
	return C.vphp_ensure_owned_instance_binding(obj, handlers)
}

pub fn ensure_owned_instance_binding_ptr(obj voidptr, handlers voidptr) voidptr {
	return ensure_owned_instance_binding( // SAFETY: obj is a valid zend_object pointer from Zend runtime
	unsafe { &C.zend_object(obj) }, handlers)
}

pub fn init_owned_instance(obj &C.zend_object, handlers voidptr) {
	C.vphp_init_owned_instance(obj, handlers)
}

pub fn init_owned_instance_ptr(obj voidptr, handlers voidptr) {
	init_owned_instance( // SAFETY: obj is a valid zend_object pointer from Zend runtime
	unsafe { &C.zend_object(obj) }, handlers)
}

pub fn object_wrapper(obj &C.zend_object) &C.vphp_object_wrapper {
	return C.vphp_obj_from_obj(obj)
}

pub fn object_wrapper_ptr(obj voidptr) voidptr {
	return object_wrapper( // SAFETY: obj is a valid zend_object pointer from Zend runtime
	unsafe { &C.zend_object(obj) })
}

pub fn object_wrapper_v_ptr(wrapper_ptr voidptr) voidptr {
	wrapper := unsafe { &C.vphp_object_wrapper(wrapper_ptr) }
	if isnil(wrapper) {
		// SAFETY: nil literal in unsafe context
		return unsafe { nil }
	}
	return wrapper.v_ptr
}

pub fn object_bound_v_ptr(obj voidptr) voidptr {
	return unsafe { C.vphp_bound_object_pointer(&C.zend_object(obj)) }
}

pub fn wrap_existing_object(out &C.zval, obj &C.zend_object) {
	C.vphp_wrap_existing_object(out, obj)
}

pub fn wrap_existing_object_ptr(out voidptr, obj voidptr) {
	wrap_existing_object( // SAFETY: out is a valid zval pointer from Zend runtime
	unsafe { &C.zval(out) }, // SAFETY: obj is a valid zend_object pointer from Zend runtime
		unsafe { &C.zend_object(obj) })
}

pub fn current_this_object() voidptr {
	return C.vphp_get_current_this_object()
}

pub fn current_hook_backing_reference() &C.zval {
	return C.vphp_current_hook_backing_reference()
}

pub fn current_hook_storage_reference(name string) &C.zval {
	return C.vphp_current_hook_storage_reference(name.str, usize(name.len))
}

pub fn current_property_reference(name string) &C.zval {
	return C.vphp_current_property_reference(name.str, usize(name.len))
}

pub fn current_static_property_reference(name string) &C.zval {
	return C.vphp_current_static_property_reference(name.str, usize(name.len))
}

pub fn object_from_zval(v &C.zval) &C.zend_object {
	return C.vphp_get_obj_from_zval(v)
}

pub fn object_from_zval_ptr(v voidptr) voidptr {
	return object_from_zval( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) })
}

pub fn return_unbound_object(ret &C.zval, v_ptr voidptr, ce voidptr) {
	C.vphp_return_obj(ret, v_ptr, ce)
}

pub fn return_unbound_object_ptr(ret voidptr, v_ptr voidptr, ce voidptr) {
	return_unbound_object( // SAFETY: ret is a valid zval pointer from Zend runtime
	unsafe { &C.zval(ret) }, v_ptr, ce)
}

pub fn return_borrowed_object(ret &C.zval, v_ptr voidptr, ce voidptr, handlers voidptr) {
	C.vphp_return_borrowed_object(ret, v_ptr, ce, handlers)
}

pub fn return_borrowed_object_ptr(ret voidptr, v_ptr voidptr, ce voidptr, handlers voidptr) {
	return_borrowed_object( // SAFETY: ret is a valid zval pointer from Zend runtime
	unsafe { &C.zval(ret) }, v_ptr, ce, handlers)
}

pub fn return_owned_object(ret &C.zval, v_ptr voidptr, ce voidptr, handlers voidptr) {
	C.vphp_return_owned_object(ret, v_ptr, ce, handlers)
}

pub fn return_owned_object_ptr(ret voidptr, v_ptr voidptr, ce voidptr, handlers voidptr) {
	return_owned_object( // SAFETY: ret is a valid zval pointer from Zend runtime
	unsafe { &C.zval(ret) }, v_ptr, ce, handlers)
}

pub fn read_property(obj &C.zend_object, name string, rv &C.zval) &C.zval {
	return C.vphp_read_property_compat(obj, &char(name.str), name.len, rv)
}

pub fn read_property_ptr(obj voidptr, name string, rv voidptr) voidptr {
	return read_property( // SAFETY: obj is a valid zend_object pointer from Zend runtime
	unsafe { &C.zend_object(obj) }, name, // SAFETY: rv is a valid zval pointer from Zend runtime
		unsafe { &C.zval(rv) })
}

pub fn read_inherited_property_ptr(obj voidptr, name string, rv voidptr) voidptr {
	return unsafe { C.vphp_read_inherited_property(&C.zend_object(obj), &char(name.str), name.len, &C.zval(rv)) }
}

pub fn write_property(obj &C.zend_object, name string, value &C.zval) {
	C.vphp_write_property_compat(obj, &char(name.str), name.len, value)
}

pub fn write_property_ptr(obj voidptr, name string, value voidptr) {
	write_property( // SAFETY: obj is a valid zend_object pointer from Zend runtime
	unsafe { &C.zend_object(obj) }, name, // SAFETY: value is a valid zval pointer from Zend runtime
		unsafe { &C.zval(value) })
}

pub fn write_inherited_property_ptr(obj voidptr, name string, value voidptr) {
	unsafe { C.vphp_write_inherited_property(&C.zend_object(obj), &char(name.str), name.len, &C.zval(value)) }
}

pub fn has_property(obj &C.zend_object, name string) bool {
	return C.vphp_has_property_compat(obj, &char(name.str), name.len) == 1
}

pub fn has_property_ptr(obj voidptr, name string) bool {
	return has_property( // SAFETY: obj is a valid zend_object pointer from Zend runtime
	unsafe { &C.zend_object(obj) }, name)
}

pub fn isset_property(obj &C.zend_object, name string) bool {
	return C.vphp_isset_property_compat(obj, &char(name.str), name.len) == 1
}

pub fn isset_property_ptr(obj voidptr, name string) bool {
	return isset_property( // SAFETY: obj is a valid zend_object pointer from Zend runtime
	unsafe { &C.zend_object(obj) }, name)
}

pub fn unset_property(obj &C.zend_object, name string) {
	C.vphp_unset_property_compat(obj, &char(name.str), name.len)
}

pub fn unset_property_ptr(obj voidptr, name string) {
	unset_property( // SAFETY: obj is a valid zend_object pointer from Zend runtime
	unsafe { &C.zend_object(obj) }, name)
}

pub fn init_object_zval(v &C.zval) {
	// SAFETY: C bridge call vphp_object_init with valid arguments
	unsafe { C.vphp_object_init(v) }
}

pub fn add_property_string(v &C.zval, key string, val string) {
	// SAFETY: C interop with valid arguments
	unsafe { C.add_property_stringl(v, &char(key.str), &char(val.str), val.len) }
}

pub fn update_property_string(v &C.zval, key string, val string) {
	// SAFETY: C interop with valid arguments
	unsafe { C.vphp_update_property_string(v, &char(key.str), key.len, &char(val.str)) }
}

pub fn add_property_long(v &C.zval, key string, val i64) {
	// SAFETY: C interop with valid arguments
	unsafe { C.add_property_long(v, &char(key.str), val) }
}

pub fn add_property_double(v &C.zval, key string, val f64) {
	// SAFETY: C interop with valid arguments
	unsafe { C.vphp_add_property_double(v, &char(key.str), val) }
}

pub fn add_property_bool(v &C.zval, key string, val bool) {
	// SAFETY: C interop with valid arguments
	unsafe { C.add_property_bool(v, &char(key.str), val) }
}

pub fn object_class_name(v &C.zval) string {
	// SAFETY: C interop block with valid pointer arguments
	unsafe {
		mut len := 0
		name := C.vphp_get_object_class_name(v, &len)
		if name == 0 || len <= 0 {
			return ''
		}
		return name.vstring_with_len(len).clone()
	}
}

pub fn object_parent_class_name(v &C.zval) string {
	// SAFETY: C interop block with valid pointer arguments
	unsafe {
		mut len := 0
		name := C.vphp_get_parent_class_name(v, &len)
		if name == 0 || len <= 0 {
			return ''
		}
		return name.vstring_with_len(len).clone()
	}
}

pub fn object_class_is_internal(v &C.zval) bool {
	return C.vphp_class_is_internal(v) == 1
}
