module vphp

// PhpArrayAccess wraps an object implementing PHP's ArrayAccess interface.
pub struct PhpArrayAccess {
	PhpObject
}

pub fn PhpArrayAccess.from_zval(z ZVal) ?PhpArrayAccess {
	if !z.is_object() || !z.is_instance_of('ArrayAccess') {
		return none
	}
	return PhpArrayAccess{ PhpObject: PhpObject.borrowed(z) }
}

pub fn PhpArrayAccess.must_from_zval(z ZVal) !PhpArrayAccess {
	return PhpArrayAccess.from_zval(z) or { error('zval does not implement PHP ArrayAccess') }
}

pub fn (a PhpArrayAccess) has(key PhpArgInput) !bool {
	return a.with_method_result[PhpValue, bool]('offsetExists', fn (result PhpValue) bool {
		return result.to_bool()
	}, key)
}

// get returns a request-owned value. get_reference keeps a reference returned by offsetGet.
pub fn (a PhpArrayAccess) get(key PhpArgInput) !PhpValue {
	mut result := a.call_method('offsetGet', key)
	if has_exception() || !result.is_valid() || result.is_undef() {
		result.release()
		return error('PHP ArrayAccess::offsetGet() failed')
	}
	if reference := PhpReference.from_zval(result.to_zval()) {
		defer {
			result.release()
		}
		mut value := reference.deref().to_request_owned()
		if has_exception() {
			value.release()
			return error('PHP ArrayAccess::offsetGet() failed')
		}
		return value
	}
	return result
}

pub fn (a PhpArrayAccess) get_reference(key PhpArgInput) !PhpReference {
	return a.method_reference('offsetGet', key)
}

pub fn (a PhpArrayAccess) set(key PhpArgInput, value PhpArgInput) ! {
	a.call_offset_mutator('offsetSet', key, value)!
}

pub fn (a PhpArrayAccess) append(value PhpArgInput) ! {
	mut key := PhpNull.value()
	defer {
		key.release()
	}
	a.set(key, value)!
}

pub fn (a PhpArrayAccess) remove(key PhpArgInput) ! {
	a.call_offset_mutator('offsetUnset', key)!
}

fn (a PhpArrayAccess) call_offset_mutator(method string, args ...PhpArgInput) ! {
	mut result := a.call_method(method, ...args)
	defer {
		result.release()
	}
	if has_exception() || !result.is_valid() || result.is_undef() {
		return error('PHP ArrayAccess::${method}() failed')
	}
}

pub fn (a PhpArrayAccess) to_borrowed() PhpArrayAccess {
	return PhpArrayAccess{ PhpObject: a.PhpObject.to_borrowed() }
}

pub fn (a PhpArrayAccess) borrowed() PhpArrayAccess {
	return a.to_borrowed()
}

pub fn (a PhpArrayAccess) to_request_owned() PhpArrayAccess {
	return PhpArrayAccess{ PhpObject: a.PhpObject.to_request_owned() }
}

pub fn (a PhpArrayAccess) owned() PhpArrayAccess {
	return a.to_request_owned()
}

pub fn (a PhpArrayAccess) to_persistent_owned() PhpArrayAccess {
	return PhpArrayAccess{ PhpObject: a.PhpObject.to_persistent_owned() }
}

pub fn (a PhpArrayAccess) retain() PhpArrayAccess {
	return a.to_persistent_owned()
}
