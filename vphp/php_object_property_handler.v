module vphp

import vphp.zval

pub struct PhpObjectPropertyHandler {}

pub fn PhpObjectPropertyHandler.name_from_ptr(name_ptr &char, name_len int) string {
	// SAFETY: C interop block with valid pointer arguments
	unsafe {
		return name_ptr.vstring_with_len(name_len).clone()
	}
}

pub fn PhpObjectPropertyHandler.return_from_ptr(rv voidptr) PhpReturn {
	return PhpReturn.from_ptr(rv)
}

pub fn PhpObjectPropertyHandler.value_from_ptr(value voidptr) ZVal {
	return ZVal.from_handle(zval.Handle.from_ptr(value))
}

pub fn PhpObjectPropertyHandler.return_value(ret PhpReturn, value PhpValue) {
	mut owned := value.clone_request_owned()
	defer {
		owned.release()
	}
	ret.zval(owned.to_zval())
}

// sync_property projects a V field into Zend storage during object inspection.
pub fn PhpObjectPropertyHandler.sync_property[T](obj ZVal, name string, value T) {
	target := ZendObject.from_zval(obj)
	if !target.is_valid() || target.skip_bound_property_projection(name) {
		return
	}
	$if T is ZVal {
		target.sync_property_storage(name, value)
	} $else $if T is PhpValue {
		mut owned := value.clone_request_owned()
		defer {
			owned.release()
		}
		target.sync_property_storage(name, owned.to_zval())
	} $else {
		mut owned := RequestOwnedZBox.new_null()
		defer {
			owned.release()
		}
		converted := owned.to_zval()
		converted.from_v[T](value) or { return }
		target.sync_property_storage(name, converted)
	}
}
