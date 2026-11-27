module vphp

// PhpCountable wraps an object implementing PHP's Countable interface.
pub struct PhpCountable {
	PhpObject
}

pub fn PhpCountable.from_zval(z ZVal) ?PhpCountable {
	if !z.is_object() || !z.is_instance_of('Countable') {
		return none
	}
	return PhpCountable{ PhpObject: PhpObject.borrowed(z) }
}

pub fn PhpCountable.must_from_zval(z ZVal) !PhpCountable {
	return PhpCountable.from_zval(z) or { error('zval does not implement PHP Countable') }
}

// count uses PHP's count() so internal object handlers and userland overrides are honored.
pub fn (c PhpCountable) count() !i64 {
	mut result := PhpFunction.named('count').call[PhpInt](c.PhpObject)!
	defer {
		result.release()
	}
	return result.value()
}

pub fn (c PhpCountable) to_borrowed() PhpCountable {
	return PhpCountable{ PhpObject: c.PhpObject.to_borrowed() }
}

pub fn (c PhpCountable) borrowed() PhpCountable {
	return c.to_borrowed()
}

pub fn (c PhpCountable) to_request_owned() PhpCountable {
	return PhpCountable{ PhpObject: c.PhpObject.to_request_owned() }
}

pub fn (c PhpCountable) owned() PhpCountable {
	return c.to_request_owned()
}

pub fn (c PhpCountable) to_persistent_owned() PhpCountable {
	return PhpCountable{ PhpObject: c.PhpObject.to_persistent_owned() }
}

pub fn (c PhpCountable) retain() PhpCountable {
	return c.to_persistent_owned()
}
