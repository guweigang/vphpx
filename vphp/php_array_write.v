module vphp

pub fn (a PhpArray) assoc(key string, value PhpArgInput) {
	raw := value.to_zval()
	a.to_zval().add_assoc_zval(key, raw)
}

pub fn (a PhpArray) assoc_zval(key string, value ZVal) {
	a.to_zval().add_assoc_zval(key, value)
}

pub fn (a PhpArray) index_zval(index i64, value ZVal) {
	a.to_zval().add_index_zval(index, value)
}

// remove returns true if the PHP key existed, even when its value was null.
// Numeric strings follow PHP's key conversion rules.
pub fn (a PhpArray) remove(key string) bool {
	return a.to_zval().remove_array_key(key)
}

// remove_index deletes a PHP integer key without reindexing the array.
pub fn (a PhpArray) remove_index(index i64) bool {
	return a.to_zval().remove_array_index(index)
}

pub fn (a PhpArray) set(key string, value PhpArgInput) {
	a.assoc(key, value)
}

pub fn (a PhpArray) set_value(key string, value PhpValue) {
	mut copy := value.to_request_owned()
	defer { copy.release() }
	a.assoc_zval(key, copy.to_zval())
}

// set_callable copies a PHP callable into the array and releases any temporary
// request handle needed to materialize a retained callable.
pub fn (a PhpArray) set_callable(key string, callable PhpCallable) {
	callable.callable.with_request_zval(fn [a, key] (raw ZVal) bool {
		a.assoc_zval(key, raw)
		return true
	})
}

pub fn (a PhpArray) set_zval(key string, value ZVal) {
	a.assoc_zval(key, value)
}

pub fn (a PhpArray) set_request_owned_zbox(key string, value RequestOwnedZBox) {
	mut wrapped := PhpValue.from_request_owned_zbox(value)
	a.set(key, wrapped)
	wrapped.release()
}

pub fn (a PhpArray) string(key string, value string) {
	a.to_zval().add_assoc_string(key, value)
}

pub fn (a PhpArray) int(key string, value i64) {
	a.to_zval().add_assoc_long(key, value)
}

pub fn (a PhpArray) double(key string, value f64) {
	a.to_zval().add_assoc_double(key, value)
}

pub fn (a PhpArray) bool(key string, value bool) {
	a.to_zval().add_assoc_bool(key, value)
}

pub fn (a PhpArray) null_value(key string) {
	a.assoc(key, PhpNull.value())
}

pub fn (a PhpArray) next(value PhpArgInput) {
	a.to_zval().add_next_val(value.to_zval())
}

pub fn (a PhpArray) next_zval(value ZVal) {
	a.to_zval().add_next_val(value)
}

pub fn (a PhpArray) push(value PhpArgInput) {
	a.next(value)
}

pub fn (a PhpArray) push_value(value PhpValue) {
	value.value.with_request_zval(fn [a] (raw ZVal) bool {
		a.next_zval(raw)
		return true
	})
}

pub fn (a PhpArray) push_zval(value ZVal) {
	a.next_zval(value)
}

pub fn (a PhpArray) push_string(value string) {
	a.to_zval().push_string(value)
}
