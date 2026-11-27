module vphp

// PhpWeakReference wraps a native PHP handle that does not keep its target alive.
pub struct PhpWeakReference {
	PhpObject
}

pub fn PhpWeakReference.from_zval(z ZVal) ?PhpWeakReference {
	if !z.is_object() || !z.is_instance_of('WeakReference') {
		return none
	}
	return PhpWeakReference{ PhpObject: PhpObject.borrowed(z) }
}

pub fn PhpWeakReference.must_from_zval(z ZVal) !PhpWeakReference {
	return PhpWeakReference.from_zval(z) or { error('zval is not a PHP WeakReference') }
}

// create returns a request-scoped handle for the original PHP object.
pub fn PhpWeakReference.create(target PhpObject) !PhpWeakReference {
	mut value := PhpClass.named('WeakReference').call_static('create', target)
	if has_exception() || !value.is_object() {
		value.release()
		return error('PHP WeakReference::create() failed')
	}
	return PhpWeakReference.must_from_zval(value.move_to_request_scope().to_zval())
}

// get returns an owned handle that pins a live target until released.
// An expired reference returns none.
pub fn (r PhpWeakReference) get() ?PhpObject {
	mut value := r.call_method('get')
	if has_exception() || !value.is_object() {
		value.release()
		return none
	}
	return PhpObject.adopt_zval(value.take_zval())
}

pub fn (r PhpWeakReference) to_borrowed() PhpWeakReference {
	return PhpWeakReference{ PhpObject: r.PhpObject.to_borrowed() }
}

pub fn (r PhpWeakReference) borrowed() PhpWeakReference {
	return r.to_borrowed()
}

pub fn (r PhpWeakReference) to_request_owned() PhpWeakReference {
	return PhpWeakReference{ PhpObject: r.PhpObject.to_request_owned() }
}

pub fn (r PhpWeakReference) owned() PhpWeakReference {
	return r.to_request_owned()
}

pub fn (r PhpWeakReference) to_persistent_owned() PhpWeakReference {
	return PhpWeakReference{ PhpObject: r.PhpObject.to_persistent_owned() }
}

pub fn (r PhpWeakReference) retain() PhpWeakReference {
	return r.to_persistent_owned()
}
