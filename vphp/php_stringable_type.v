module vphp

// PhpStringable wraps an object implementing PHP's Stringable interface.
pub struct PhpStringable {
	PhpObject
}

pub fn PhpStringable.from_zval(z ZVal) ?PhpStringable {
	if !z.is_object() || !z.is_instance_of('Stringable') {
		return none
	}
	return PhpStringable{ PhpObject: PhpObject.borrowed(z) }
}

pub fn PhpStringable.must_from_zval(z ZVal) !PhpStringable {
	return PhpStringable.from_zval(z) or { error('zval does not implement PHP Stringable') }
}

// stringify uses PHP's string cast and leaves conversion exceptions pending.
pub fn (s PhpStringable) stringify() !string {
	if !s.is_valid() || has_exception() {
		return error('PHP Stringable conversion failed')
	}
	text := s.PhpObject.value.with_request_zval(fn (value ZVal) string {
		return value.to_string()
	})
	if has_exception() {
		return error('PHP Stringable conversion failed')
	}
	return text
}

pub fn (s PhpStringable) to_borrowed() PhpStringable {
	return PhpStringable{ PhpObject: s.PhpObject.to_borrowed() }
}

pub fn (s PhpStringable) borrowed() PhpStringable {
	return s.to_borrowed()
}

pub fn (s PhpStringable) to_request_owned() PhpStringable {
	return PhpStringable{ PhpObject: s.PhpObject.to_request_owned() }
}

pub fn (s PhpStringable) owned() PhpStringable {
	return s.to_request_owned()
}

pub fn (s PhpStringable) to_persistent_owned() PhpStringable {
	return PhpStringable{ PhpObject: s.PhpObject.to_persistent_owned() }
}

pub fn (s PhpStringable) retain() PhpStringable {
	return s.to_persistent_owned()
}
