module vphp

import vphp.zend

// PhpWeakMap wraps PHP's native object-keyed WeakMap.
pub struct PhpWeakMap {
	PhpObject
}

pub fn PhpWeakMap.from_zval(z ZVal) ?PhpWeakMap {
	if !z.is_object() || !z.is_instance_of('WeakMap') {
		return none
	}
	return PhpWeakMap{ PhpObject: PhpObject.borrowed(z) }
}

pub fn PhpWeakMap.must_from_zval(z ZVal) !PhpWeakMap {
	return PhpWeakMap.from_zval(z) or { error('zval is not a PHP WeakMap') }
}

// new returns a request-scoped handle.
pub fn PhpWeakMap.new() !PhpWeakMap {
	mut object := PhpClass.named('WeakMap').construct()!
	mut value := object.take_value()
	return PhpWeakMap.must_from_zval(value.move_to_request_scope().to_zval())
}

pub fn (m PhpWeakMap) set(key PhpObject, value PhpArgInput) ! {
	mut result := m.call_method('offsetSet', key, value)
	defer {
		result.release()
	}
	if has_exception() || !result.is_valid() {
		return error('PHP WeakMap::offsetSet() failed')
	}
}

// bind_reference replaces the entry's binding. PHP 8.6 also allows a new key.
pub fn (m PhpWeakMap) bind_reference(key PhpObject, reference PhpReference) ! {
	bound := m.PhpObject.value.with_request_zval(fn [key, reference] (map_zval ZVal) bool {
		return key.value.with_request_zval(fn [map_zval, reference] (key_zval ZVal) bool {
			return reference.value.with_request_zval(fn [map_zval, key_zval] (ref_zval ZVal) bool {
				return zend.weak_map_bind_reference(map_zval.raw, key_zval.raw, ref_zval.raw)
			})
		})
	})
	if !bound {
		return error('PHP WeakMap reference assignment failed')
	}
}

fn (m PhpWeakMap) find_entry(key PhpObject, reference bool) ?ZVal {
	raw := m.PhpObject.value.with_request_zval(fn [key, reference] (map_zval ZVal) voidptr {
		return key.value.with_request_zval(fn [map_zval, reference] (key_zval ZVal) voidptr {
			return zend.weak_map_find(map_zval.raw, key_zval.raw, reference)
		})
	})
	if raw == unsafe { nil } {
		return none
	}
	return adopt_raw_with_ownership(ZVal.from_ptr(raw).raw, .owned_request)
}

// find returns a request-owned value, including null, or none for a missing key.
pub fn (m PhpWeakMap) find(key PhpObject) ?PhpValue {
	return PhpValue.adopt_zval(m.find_entry(key, false)?)
}

// find_reference retains an existing binding without creating an entry or a reference.
pub fn (m PhpWeakMap) find_reference(key PhpObject) ?PhpReference {
	return PhpReference.from_request_owned_zbox(RequestOwnedZBox.adopt_zval(m.find_entry(key,
		true)?))
}

pub fn (m PhpWeakMap) remove(key PhpObject) ! {
	mut result := m.call_method('offsetUnset', key)
	defer {
		result.release()
	}
	if has_exception() || !result.is_valid() {
		return error('PHP WeakMap::offsetUnset() failed')
	}
}

pub fn (m PhpWeakMap) count() !i64 {
	mut result := m.call_method('count')
	defer {
		result.release()
	}
	if has_exception() || !result.is_int() {
		return error('PHP WeakMap::count() failed')
	}
	return result.to_i64()
}

pub fn (m PhpWeakMap) to_iterable() PhpIterable {
	return PhpIterable{ value: m.PhpObject.value.clone() }
}

pub fn (m PhpWeakMap) to_borrowed() PhpWeakMap {
	return PhpWeakMap{ PhpObject: m.PhpObject.to_borrowed() }
}

pub fn (m PhpWeakMap) borrowed() PhpWeakMap {
	return m.to_borrowed()
}

pub fn (m PhpWeakMap) to_request_owned() PhpWeakMap {
	return PhpWeakMap{ PhpObject: m.PhpObject.to_request_owned() }
}

pub fn (m PhpWeakMap) owned() PhpWeakMap {
	return m.to_request_owned()
}

pub fn (m PhpWeakMap) to_persistent_owned() PhpWeakMap {
	return PhpWeakMap{ PhpObject: m.PhpObject.to_persistent_owned() }
}

pub fn (m PhpWeakMap) retain() PhpWeakMap {
	return m.to_persistent_owned()
}
