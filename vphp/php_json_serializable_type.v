module vphp

// PhpJsonSerializable wraps an object implementing PHP's JsonSerializable interface.
pub struct PhpJsonSerializable {
	PhpObject
}

pub fn PhpJsonSerializable.from_zval(z ZVal) ?PhpJsonSerializable {
	if !z.is_object() || !z.is_instance_of('JsonSerializable') {
		return none
	}
	return PhpJsonSerializable{ PhpObject: PhpObject.borrowed(z) }
}

pub fn PhpJsonSerializable.must_from_zval(z ZVal) !PhpJsonSerializable {
	return PhpJsonSerializable.from_zval(z) or { error('zval does not implement PHP JsonSerializable') }
}

// serialize calls jsonSerialize and returns its value in the current request scope.
pub fn (s PhpJsonSerializable) serialize() !PhpValue {
	mut result := s.call_method('jsonSerialize')
	if has_exception() || !result.is_valid() || result.is_undef() {
		result.release()
		return error('PHP JsonSerializable::jsonSerialize() failed')
	}
	value := result.move_to_request_scope_by_value()
	if has_exception() {
		return error('PHP JsonSerializable::jsonSerialize() failed')
	}
	return value
}

// encode gives the whole object to PHP's JSON encoder.
pub fn (s PhpJsonSerializable) encode() !string {
	return PhpJson.encode_or_throw(s.to_zval())
}

pub fn (s PhpJsonSerializable) to_borrowed() PhpJsonSerializable {
	return PhpJsonSerializable{ PhpObject: s.PhpObject.to_borrowed() }
}

pub fn (s PhpJsonSerializable) borrowed() PhpJsonSerializable {
	return s.to_borrowed()
}

pub fn (s PhpJsonSerializable) to_request_owned() PhpJsonSerializable {
	return PhpJsonSerializable{ PhpObject: s.PhpObject.to_request_owned() }
}

pub fn (s PhpJsonSerializable) owned() PhpJsonSerializable {
	return s.to_request_owned()
}

pub fn (s PhpJsonSerializable) to_persistent_owned() PhpJsonSerializable {
	return PhpJsonSerializable{ PhpObject: s.PhpObject.to_persistent_owned() }
}

pub fn (s PhpJsonSerializable) retain() PhpJsonSerializable {
	return s.to_persistent_owned()
}
