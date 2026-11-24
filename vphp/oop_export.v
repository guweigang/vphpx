module vphp

import math
import vphp.object
import vphp.zend
import vphp.zval

// --- From zend_class_entry_type.v ---
pub type ZendClassEntry = zend.ZendClassEntry

pub fn (ce ZendClassEntry) set_static_prop[T](name string, val T) {
	if !ce.is_valid() {
		return
	}
	$if T is int || T is i64 || T is f64 || T is string || T is bool {
		mut owned := RequestOwnedZBox.new_null()
		defer {
			owned.release()
		}
		value := owned.to_zval()
		value.from_v[T](val) or { return }
		C.vphp_write_static_property_value(ce.raw_ptr(), &char(name.str), usize(name.len), value.raw_ptr())
	}
}

pub fn (ce ZendClassEntry) static_prop[T](name string) T {
	if !ce.is_valid() {
		return T{}
	}
	$if T is int || T is i64 || T is f64 || T is string || T is bool {
		value := C.vphp_read_static_property_value(ce.raw_ptr(), &char(name.str), usize(name.len))
		return ZVal.from_ptr(value).to_v[T]() or { T{} }
	}
	return T{}
}

// --- From zend_class_handlers_type.v ---
@[params]
pub struct ZendClassHandlersConfig {
pub:
	prop_handler  voidptr
	write_handler voidptr
	sync_handler  voidptr
	new_raw       voidptr
	cleanup_raw   voidptr
	free_raw      voidptr
}

pub struct ZendClassHandlers {}

pub fn ZendClassHandlers.new(config ZendClassHandlersConfig) voidptr {
	return zend.new_class_handlers(zend.ClassHandlersConfig{
		prop_handler:  config.prop_handler
		write_handler: config.write_handler
		sync_handler:  config.sync_handler
		new_raw:       config.new_raw
		cleanup_raw:   config.cleanup_raw
		free_raw:      config.free_raw
	})
}

pub fn ZendClassHandlers.new_typed(config zend.TypedClassHandlersConfig) voidptr {
	return zend.new_typed_class_handlers(config)
}

// --- From zend_object_type.v ---
pub struct ZendObject {
	handle object.Handle
}

pub fn ZendObject.invalid() ZendObject {
	return ZendObject{
		handle: object.Handle.invalid()
	}
}

pub fn ZendObject.from_ptr(ptr voidptr) ZendObject {
	return ZendObject{
		handle: object.Handle.from_ptr(ptr)
	}
}

pub fn ZendObject.current() ZendObject {
	obj_raw := zend.current_this_object()
	if obj_raw == 0 {
		return ZendObject.invalid()
	}
	return ZendObject.from_ptr(obj_raw)
}

pub fn ZendObject.from_zval(v ZVal) ZendObject {
	if !v.is_valid() || !v.is_object() {
		return ZendObject.invalid()
	}
	return ZendObject{
		handle: object.from_zval(v.handle())
	}
}

pub fn (obj ZendObject) is_valid() bool {
	return obj.handle.is_valid()
}

pub fn (obj ZendObject) raw_ptr() voidptr {
	return obj.handle.raw_ptr()
}

// --- From zend_object_lifecycle.v ---
fn object_binding_ownership(ownership OwnershipKind) object.BindingOwnership {
	return match ownership {
		.borrowed {
			.borrowed
		}
		.owned_request, .owned_persistent {
			.owned
		}
	}
}

fn wrap_existing_object(out zval.Handle, obj ZendObject) {
	object.wrap_existing_zval(out, obj.handle)
}

pub fn (obj ZendObject) add_ref() {
	if !obj.is_valid() {
		return
	}
	obj.handle.add_ref()
}

pub fn (obj ZendObject) release() {
	if !obj.is_valid() {
		return
	}
	obj.handle.release()
}

pub fn (obj ZendObject) bind_handlers(handlers object.ObjectHandlers, ownership OwnershipKind) {
	if !obj.is_valid() {
		return
	}
	match ownership {
		.borrowed {
			obj.handle.bind_borrowed_handlers(handlers)
		}
		.owned_request, .owned_persistent {
			obj.handle.bind_owned_handlers(handlers)
		}
	}
}

pub fn (obj ZendObject) ensure_binding_ptr(handlers object.ObjectHandlers, ownership OwnershipKind) voidptr {
	if !obj.is_valid() {
		// SAFETY: nil literal in unsafe context
		return unsafe { nil }
	}
	return obj.handle.ensure_binding_ptr(handlers, object_binding_ownership(ownership))
}

pub fn (obj ZendObject) init_owned_instance(handlers object.ObjectHandlers) {
	if !obj.is_valid() {
		return
	}
	obj.handle.init_owned_instance(handlers)
}

pub fn (obj ZendObject) bound_v_ptr() voidptr {
	if !obj.is_valid() {
		// SAFETY: nil literal in unsafe context
		return unsafe { nil }
	}
	return obj.handle.bound_v_ptr()
}

pub fn (obj ZendObject) to_request_owned_zval() ZVal {
	if !obj.is_valid() {
		return invalid_zval()
	}
	out := zval.new_request()
	if !out.is_valid() {
		return invalid_zval()
	}
	wrap_existing_object(out, obj)
	return adopt_handle_with_ownership(out, .owned_request)
}

// --- From zend_object_property.v ---
fn (obj ZendObject) read_property_with_ownership(name string, ownership OwnershipKind) ZVal {
	if !obj.is_valid() {
		return invalid_zval()
	}
	return adopt_read_result_handles(obj.handle.read_property(name), ownership)
}

fn (obj ZendObject) scalar_prop_or[T](name string, fallback T, convert fn (ZVal) T, options object.PropertyReadOptions) T {
	if !obj.is_valid() {
		return fallback
	}
	result := obj.handle.read_property(name, inherited_storage: options.inherited_storage)
	if !result.rv.is_valid() {
		return fallback
	}
	defer {
		zval.release_request(result.rv)
	}
	if !result.res.is_valid() {
		return fallback
	}
	value := ZVal.from_handle(result.res)
	if value.is_null() || value.is_undef() {
		return fallback
	}
	return convert(value)
}

pub fn (obj ZendObject) prop_string_or(name string, fallback string, options object.PropertyReadOptions) string {
	return obj.scalar_prop_or(name, fallback, fn (value ZVal) string {
		return value.to_string()
	}, options)
}

pub fn (obj ZendObject) prop_i64_or(name string, fallback i64, options object.PropertyReadOptions) i64 {
	return obj.scalar_prop_or(name, fallback, fn (value ZVal) i64 {
		return value.to_i64()
	}, options)
}

pub fn (obj ZendObject) prop_bool_or(name string, fallback bool, options object.PropertyReadOptions) bool {
	return obj.scalar_prop_or(name, fallback, fn (value ZVal) bool {
		return value.to_bool()
	}, options)
}

pub fn (obj ZendObject) prop_f64_or(name string, fallback f64, options object.PropertyReadOptions) f64 {
	return obj.scalar_prop_or(name, fallback, fn (value ZVal) f64 {
		return value.to_f64()
	}, options)
}

pub fn (obj ZendObject) prop_borrowed(name string) ZVal {
	return obj.read_property_with_ownership(name, .borrowed)
}

pub fn (obj ZendObject) prop_owned_request(name string) ZVal {
	return obj.read_property_with_ownership(name, .owned_request)
}

pub fn (obj ZendObject) prop_owned_persistent(name string) ZVal {
	return obj.read_property_with_ownership(name, .owned_persistent)
}

pub fn (obj ZendObject) inherited_value(name string) PhpValue {
	if !obj.is_valid() {
		return PhpValue.null()
	}
	result := obj.handle.read_property(name, inherited_storage: true)
	defer {
		if result.rv.is_valid() {
			zval.release_request(result.rv)
		}
	}
	return PhpValue.from_zval(copy_inherited_value(result.res.raw_ptr()))
}

pub fn snapshot_inherited_value(value PhpValue) PhpValue {
	return PhpValue.from_zval(copy_inherited_value(value.to_zval().raw_ptr()))
}

fn copy_inherited_value(source voidptr) ZVal {
	target := ZVal.new_null()
	C.vphp_copy_inherited_value(target.raw_ptr(), source)
	return target
}

pub fn (obj ZendObject) sync_inherited_value(name string, before PhpValue, after PhpValue) {
	old := before.to_zval()
	mut current := after.to_zval()
	if !current.is_valid() {
		current = ZVal.new_null()
	}
	if C.vphp_inherited_value_unchanged(old.raw_ptr(), current.raw_ptr()) {
		return
	}
	obj.sync_property_storage(name, current)
}

pub fn (obj ZendObject) set_prop(name string, value ZVal) {
	if !obj.is_valid() || !value.is_valid() {
		return
	}
	obj.handle.write_property_ptr(name, value.raw_ptr())
}

fn (obj ZendObject) sync_property_storage(name string, value ZVal) {
	if !obj.is_valid() || !value.is_valid() {
		return
	}
	obj.handle.write_inherited_property_ptr(name, value.raw_ptr())
}

fn (obj ZendObject) skip_bound_property_projection(name string) bool {
	return unsafe {
		C.vphp_skip_bound_property_projection(&C.zend_object(obj.raw_ptr()), &char(name.str), name.len)
	}
}

// sync_scalar_prop writes back a scalar modified by a generated V receiver.
pub fn (obj ZendObject) sync_scalar_prop[T](name string, before T, after T) {
	$if T is f64 {
		if math.f64_bits(before) == math.f64_bits(after) {
			return
		}
	} $else {
		if before == after {
			return
		}
	}
	mut owned := RequestOwnedZBox.new_null()
	defer {
		owned.release()
	}
	value := owned.to_zval()
	value.from_v[T](after) or { return }
	obj.sync_property_storage(name, value)
}

// init_inherited_field copies a V field default into its declared PHP slot.
pub fn (obj ZendObject) init_inherited_field[T](owner voidptr, name string, default_value T) {
	mut owned := RequestOwnedZBox.new_null()
	defer {
		owned.release()
	}
	value := owned.to_zval()
	$if T is PhpValue {
		mut initial := default_value
		value.copy_from(initial.to_zval())
		if initial.is_owned() {
			initial.release()
		}
	} $else {
		value.from_v[T](default_value) or { return }
	}
	C.vphp_init_inherited_field(obj.raw_ptr(), owner, &char(name.str), name.len, value.raw_ptr())
}

pub fn (obj ZendObject) set_prop_value(name string, value PhpValue) {
	obj.set_prop(name, value.to_zval())
}

pub fn (obj ZendObject) set_prop_input(name string, value PhpArgInput) {
	obj.set_prop(name, value.to_zval())
}

pub fn (obj ZendObject) has_prop(name string) bool {
	if !obj.is_valid() {
		return false
	}
	return obj.handle.has_property(name)
}

pub fn (obj ZendObject) isset_prop(name string) bool {
	if !obj.is_valid() {
		return false
	}
	return obj.handle.isset_property(name)
}

pub fn (obj ZendObject) unset_prop(name string) {
	if !obj.is_valid() {
		return
	}
	obj.handle.unset_property(name)
}
