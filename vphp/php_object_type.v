module vphp

import vphp.zend

// owned_object_php_state returns a borrowed array traced by PHP's collector.
// The inline PHP wrapper must own v_ptr and remain alive while the array is used.
pub fn owned_object_php_state(v_ptr voidptr) ?PhpArray {
	return PhpArray.from_zval(ZVal.from_ptr(zend.owned_object_php_state_ptr(v_ptr)))
}

pub struct PhpObject {
mut:
	value PhpValueZBox
}

pub fn PhpObject.invalid() PhpObject {
	return PhpObject{
		value: PhpValueZBox.from_zval(invalid_zval())
	}
}

pub fn PhpObject.from_zval(z ZVal) ?PhpObject {
	if !z.is_object() {
		return none
	}
	return PhpObject{
		value: PhpValueZBox.from_zval(z)
	}
}

pub fn PhpObject.adopt_zval(z ZVal) ?PhpObject {
	if !z.is_object() {
		return none
	}
	return PhpObject{
		value: PhpValueZBox.adopt_zval(z)
	}
}

pub fn PhpObject.borrowed(z ZVal) PhpObject {
	return PhpObject{
		value: PhpValueZBox.from_zval(z)
	}
}

pub fn PhpObject.borrowed_zbox(value RequestBorrowedZBox) PhpObject {
	return PhpObject{
		value: PhpValueZBox.borrowed(value)
	}
}

pub fn PhpObject.must_from_zval(z ZVal) !PhpObject {
	obj := PhpObject.from_zval(z) or { return error('zval is not object') }
	return obj
}

pub fn PhpObject.from_request_borrowed_zbox(value RequestBorrowedZBox) ?PhpObject {
	if !value.is_object() {
		return none
	}
	return PhpObject{
		value: PhpValueZBox.borrowed(value)
	}
}

pub fn PhpObject.from_request_owned_zbox(value RequestOwnedZBox) ?PhpObject {
	if !value.is_object() {
		return none
	}
	return PhpObject{
		value: PhpValueZBox.request_owned(value)
	}
}

pub fn PhpObject.current() ?PhpObject {
	z := PhpObject.current_request_owned_zval()
	if !z.is_valid() {
		return none
	}
	return PhpObject.from_zval(z)
}

pub fn PhpObject.current_request_owned_zval() ZVal {
	return ZendObject.current().to_request_owned_zval()
}

pub fn (o PhpObject) to_zval() ZVal {
	return o.value.to_zval()
}

pub fn (o PhpObject) to_value() PhpValue {
	return PhpValue{
		value: o.value.clone()
	}
}

pub fn (o PhpObject) borrowed_view() PhpObject {
	return o.to_borrowed()
}

pub fn (o PhpObject) borrowed() PhpObject {
	return o.to_borrowed()
}

pub fn (o PhpObject) borrow() PhpObject {
	return o.to_borrowed()
}

pub fn (o PhpObject) to_borrowed() PhpObject {
	return PhpObject{
		value: o.value.borrowed()
	}
}

pub fn (o PhpObject) to_borrowed_zbox() RequestBorrowedZBox {
	return o.value.to_borrowed_zbox()
}

pub fn (o PhpObject) to_request_owned() PhpObject {
	return PhpObject.from_request_owned_zbox(o.value.to_request_owned_zbox()) or { o.to_borrowed() }
}

pub fn (o PhpObject) owned() PhpObject {
	return o.to_request_owned()
}

pub fn (o PhpObject) to_request_owned_zbox() RequestOwnedZBox {
	return o.value.to_request_owned_zbox()
}

pub fn (mut o PhpObject) take_zval() ZVal {
	return o.value.take_zval()
}

pub fn (mut o PhpObject) take_value() PhpValue {
	return PhpValue.adopt_zval(o.take_zval())
}

pub fn PhpObject.from_persistent_owned_zbox(value PersistentOwnedZBox) ?PhpObject {
	if !value.is_object() {
		return none
	}
	return PhpObject{
		value: PhpValueZBox.persistent_owned(value)
	}
}

pub fn PhpObject.from_persistent_zval(z ZVal) ?PhpObject {
	return PhpObject.from_persistent_owned_zbox(PersistentOwnedZBox.from_persistent_zval(z))
}

pub fn (o PhpObject) to_persistent_owned() PhpObject {
	return PhpObject.from_persistent_owned_zbox(o.value.to_persistent_owned_zbox()) or {
		o.to_borrowed()
	}
}

pub fn (o PhpObject) retain() PhpObject {
	return o.to_persistent_owned()
}

pub fn (o PhpObject) retained() PhpObject {
	return o.to_persistent_owned()
}

pub fn (o PhpObject) to_persistent_owned_zbox() PersistentOwnedZBox {
	return o.value.to_persistent_owned_zbox()
}

pub fn (o PhpObject) is_borrowed() bool {
	return o.value.is_borrowed()
}

pub fn (o PhpObject) is_owned() bool {
	return o.value.is_request_owned()
}

pub fn (o PhpObject) is_retained() bool {
	return o.value.is_retained()
}

pub fn (o PhpObject) kind_name() string {
	return o.value.kind_name()
}

pub fn (o PhpObject) is_valid() bool {
	return o.value.is_valid()
}

pub fn (o PhpObject) clone() PhpObject {
	return PhpObject{
		value: o.value.clone()
	}
}

// clone_with creates a PHP clone using Zend's property update rules.
pub fn (o PhpObject) clone_with(properties PhpArray) !PhpObject {
	if !zend.clone_with_supported() {
		return error('PHP clone with updated properties requires PHP 8.5 or newer')
	}
	clone := PhpFunction.find('clone') or { return error('The PHP clone function is unavailable') }
	mut result := clone.invoke(o, properties)
	if has_exception() || !result.is_object() {
		result.release()
		return error('PHP clone did not return an object')
	}
	return PhpObject.adopt_zval(result.take_zval()) or { error('could not adopt the PHP clone') }
}

pub fn (o PhpObject) clone_request_owned() RequestOwnedZBox {
	return o.to_request_owned_zbox()
}

pub fn (o PhpObject) with_object[T](run fn (PhpObject) T) T {
	mut temp := o.clone_request_owned()
	defer {
		temp.release()
	}
	obj := PhpObject{
		value: PhpValueZBox.borrowed(temp.borrowed())
	}
	return run(obj)
}

pub fn (o PhpObject) to_v_object[T]() ?&T {
	return o.to_zval().to_object[T]()
}

pub fn (mut o PhpObject) release() {
	o.value.release()
}
