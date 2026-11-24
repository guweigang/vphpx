module vphp

import vphp.zend

pub struct PhpReference {
mut:
	value PhpValueZBox
}

// hook_backing returns the current &get hook's reference to its Zend backing slot.
pub fn PhpReference.hook_backing() PhpReference {
	return PhpReference.from_zval(ZVal.from_ptr(zend.current_hook_backing_reference())) or {
		PhpReference{}
	}
}

// hook_storage borrows a writable PHP storage property on the current hook receiver.
pub fn PhpReference.hook_storage(name string) PhpReference {
	return PhpReference.from_zval(ZVal.from_ptr(zend.current_hook_storage_reference(name))) or {
		PhpReference{}
	}
}

// this_property borrows a declared PHP storage slot writable from the current instance method.
pub fn PhpReference.this_property(name string) !PhpReference {
	return PhpReference.must_from_zval(ZVal.from_ptr(zend.current_property_reference(name)))
}

// static_property borrows a PHP static slot on the current method's called class.
pub fn PhpReference.static_property(name string) !PhpReference {
	return PhpReference.must_from_zval(ZVal.from_ptr(zend.current_static_property_reference(name)))
}

pub fn PhpReference.from_zval(z ZVal) ?PhpReference {
	if z.type_id() != .reference {
		return none
	}
	return PhpReference{
		value: PhpValueZBox.from_zval(z)
	}
}

pub fn PhpReference.must_from_zval(z ZVal) !PhpReference {
	ref := PhpReference.from_zval(z) or { return error('zval is not reference') }
	return ref
}

pub fn PhpReference.from_request_owned_zbox(value RequestOwnedZBox) ?PhpReference {
	if value.to_zval().type_id() != .reference {
		return none
	}
	return PhpReference{
		value: PhpValueZBox.request_owned(value)
	}
}

pub fn PhpReference.from_persistent_owned_zbox(value PersistentOwnedZBox) ?PhpReference {
	if value.to_zval().type_id() != .reference {
		return none
	}
	return PhpReference{
		value: PhpValueZBox.persistent_owned(value)
	}
}

pub fn PhpReference.from_persistent_zval(z ZVal) ?PhpReference {
	return PhpReference.from_persistent_owned_zbox(PersistentOwnedZBox.from_persistent_zval(z))
}

pub fn (r PhpReference) to_zval() ZVal {
	return r.value.to_zval()
}

// to_value keeps the reference cell available to reference-aware APIs.
pub fn (r PhpReference) to_value() PhpValue {
	return PhpValue{
		value: r.value.clone()
	}
}

pub fn (r PhpReference) to_borrowed() PhpReference {
	return PhpReference.from_zval(r.value.to_borrowed_zbox().to_zval()) or { r }
}

pub fn (r PhpReference) borrowed() PhpReference {
	return r.to_borrowed()
}

pub fn (r PhpReference) borrow() PhpReference {
	return r.to_borrowed()
}

pub fn (r PhpReference) to_borrowed_zbox() RequestBorrowedZBox {
	return r.value.to_borrowed_zbox()
}

pub fn (r PhpReference) to_request_owned() PhpReference {
	return PhpReference.from_request_owned_zbox(r.value.to_request_owned_zbox()) or {
		r.to_borrowed()
	}
}

pub fn (r PhpReference) owned() PhpReference {
	return r.to_request_owned()
}

pub fn (r PhpReference) to_request_owned_zbox() RequestOwnedZBox {
	return r.value.to_request_owned_zbox()
}

pub fn (r PhpReference) to_persistent_owned() PhpReference {
	return PhpReference.from_persistent_owned_zbox(r.value.to_persistent_owned_zbox()) or {
		r.to_borrowed()
	}
}

pub fn (r PhpReference) retain() PhpReference {
	return r.to_persistent_owned()
}

pub fn (r PhpReference) retained() PhpReference {
	return r.to_persistent_owned()
}

pub fn (r PhpReference) to_persistent_owned_zbox() PersistentOwnedZBox {
	return r.value.to_persistent_owned_zbox()
}

pub fn (r PhpReference) is_borrowed() bool {
	return r.value.is_borrowed()
}

pub fn (r PhpReference) is_owned() bool {
	return r.value.is_request_owned()
}

pub fn (r PhpReference) is_retained() bool {
	return r.value.is_retained()
}

pub fn (mut r PhpReference) take_zval() ZVal {
	return r.value.take_zval()
}

pub fn (mut r PhpReference) release() {
	r.value.release()
}

pub fn (r PhpReference) deref() PhpValue {
	value := r.to_zval().reference_value()
	if !value.is_valid() {
		return PhpValue.from_zval(invalid_zval())
	}
	return PhpValue.from_zval(value)
}

pub fn (r PhpReference) set(value ZVal) {
	r.to_zval().set_reference_value(value)
}

pub fn (r PhpReference) set_value(value PhpValue) {
	r.set(value.to_zval())
}
