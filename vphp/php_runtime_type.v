module vphp

import vphp.zend

// Values are the Zend zval type tags from zend_types.h.
pub enum PHPType {
	unknown   = -1
	undef     = 0
	null      = 1
	false_    = 2
	true_     = 3
	long      = 4
	double    = 5
	string    = 6
	array     = 7
	object    = 8
	resource  = 9
	reference = 10
}

pub fn PHPType.from_id(id int) PHPType {
	return match id {
		zend.is_undef { .undef }
		zend.is_null { .null }
		zend.is_false { .false_ }
		zend.is_true { .true_ }
		zend.is_long { .long }
		zend.is_double { .double }
		zend.is_string { .string }
		zend.is_array { .array }
		zend.is_object { .object }
		zend.is_resource { .resource }
		zend.is_reference { .reference }
		else { .unknown }
	}
}

pub fn (t PHPType) name() string {
	return match t {
		.unknown { 'unknown' }
		.undef { 'undefined' }
		.null { 'null' }
		.false_, .true_ { 'boolean' }
		.long { 'integer' }
		.double { 'float' }
		.string { 'string' }
		.array { 'array' }
		.object { 'object' }
		.resource { 'resource' }
		.reference { 'reference' }
	}
}

pub fn (t PHPType) is_bool() bool {
	return t == .false_ || t == .true_
}

pub fn (t PHPType) is_numeric() bool {
	return t == .long || t == .double
}
