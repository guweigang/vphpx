module vphp

import vphp.zend

type ExternalPhpInterfaceCheck = fn (string, ZVal) bool

__global (
	external_php_interface_check ExternalPhpInterfaceCheck
)

pub fn register_external_php_interface_check(check ExternalPhpInterfaceCheck) {
	unsafe {
		external_php_interface_check = check
	}
}

pub fn matches_external_php_interface(value ZVal, name string) bool {
	return zend.object_matches_external_interface(value.raw_ptr(), name)
}

// PhpInterface[T] holds a PHP object implementing the interface associated with T.
pub struct PhpInterface[T] {
mut:
	object PhpObject
}

interface PhpInterfaceValue {
	php_interface_zval() ZVal
mut:
	bind_php_interface_zval(z ZVal) !
}

// from_object checks the PHP interface and borrows the original object.
pub fn PhpInterface.from_object[T](object PhpObject) !PhpInterface[T] {
	mut value := PhpInterface[T]{}
	value.bind_php_interface_zval(object.to_zval())!
	return value
}

pub fn (value PhpInterface[T]) to_object() PhpObject {
	return value.object.borrowed()
}

// to_value exposes the original object as a borrowed PHP value.
pub fn (value PhpInterface[T]) to_value() PhpValue {
	return PhpValue.from_request_borrowed_zbox(value.object.to_borrowed_zbox())
}

fn (value PhpInterface[T]) php_interface_zval() ZVal {
	return value.object.to_zval()
}

fn (mut value PhpInterface[T]) bind_php_interface_zval(z ZVal) ! {
	type_name := typeof[T]().name
	parts := type_name.split('.')
	v_name := if parts.len > 1 { parts[parts.len - 2..].join('.') } else { 'main.' + type_name }
	if !matches_php_interface(v_name, z) {
		return error('expected PHP object implementing ${type_name}')
	}
	value.object = PhpObject.must_from_zval(z)!
}

fn matches_php_interface(v_name string, z ZVal) bool {
	ce := cached_class_entry('interface:' + v_name)
	if ce != unsafe { nil } {
		object := ZendObject.from_zval(z)
		return object.is_valid() && zend.object_is_instance_of(object.raw_ptr(), ce)
	}
	check := external_php_interface_check
	return check != unsafe { nil } && check(v_name, z)
}
