module zval

import vphp.zend

pub fn array_init(handle Handle) {
	if !handle.is_valid() {
		return
	}
	zend.array_init_ptr(handle.raw_ptr())
}

pub fn array_add_assoc_string(handle Handle, key string, val string) {
	if !handle.is_valid() {
		return
	}
	zend.array_add_assoc_string_ptr(handle.raw_ptr(), key, val)
}

pub fn array_add_assoc_long(handle Handle, key string, val i64) {
	if !handle.is_valid() {
		return
	}
	zend.array_add_assoc_long_ptr(handle.raw_ptr(), key, val)
}

pub fn array_add_assoc_double(handle Handle, key string, val f64) {
	if !handle.is_valid() {
		return
	}
	zend.array_add_assoc_double_ptr(handle.raw_ptr(), key, val)
}

pub fn array_add_assoc_bool(handle Handle, key string, val bool) {
	if !handle.is_valid() {
		return
	}
	zend.array_add_assoc_bool_ptr(handle.raw_ptr(), key, val)
}

pub fn array_add_assoc_zval(handle Handle, key string, val Handle) {
	if !handle.is_valid() || !val.is_valid() {
		return
	}
	zend.array_add_assoc_zval_ptr(handle.raw_ptr(), key, val.raw_ptr())
}

pub fn array_add_index_zval(handle Handle, index i64, val Handle) {
	if !handle.is_valid() || !val.is_valid() {
		return
	}
	zend.array_add_index_zval_ptr(handle.raw_ptr(), index, val.raw_ptr())
}

pub fn array_push_string(handle Handle, s string) {
	if !handle.is_valid() {
		return
	}
	zend.array_push_string_ptr(handle.raw_ptr(), s)
}

pub fn array_push_long(handle Handle, val i64) {
	if !handle.is_valid() {
		return
	}
	zend.array_push_long_ptr(handle.raw_ptr(), val)
}

pub fn array_push_double(handle Handle, val f64) {
	if !handle.is_valid() {
		return
	}
	zend.array_push_double_ptr(handle.raw_ptr(), val)
}

pub fn array_push_bool(handle Handle, val bool) {
	if !handle.is_valid() {
		return
	}
	zend.array_push_bool_ptr(handle.raw_ptr(), val)
}

pub fn array_add_next_zval(handle Handle, val Handle) {
	if !handle.is_valid() || !val.is_valid() {
		return
	}
	zend.array_add_next_zval_ptr(handle.raw_ptr(), val.raw_ptr())
}

pub fn array_count(handle Handle) int {
	if !handle.is_valid() {
		return 0
	}
	return zend.array_count_ptr(handle.raw_ptr())
}

pub fn array_next_index(handle Handle) i64 {
	return zend.array_next_index_ptr(handle.raw_ptr())
}

pub fn array_restore_next_index(handle Handle, index i64) {
	zend.array_restore_next_index_ptr(handle.raw_ptr(), index)
}

pub fn array_snapshot(source Handle, target Handle) {
	zend.array_snapshot_ptr(source.raw_ptr(), target.raw_ptr())
}

pub enum IterableCollection {
	values
	entries
	keyed
}

pub fn iterable_collect(input Handle, output Handle, shape IterableCollection) {
	zend.iterable_collect_ptr(input.raw_ptr(), output.raw_ptr(), int(shape))
}

pub fn iterable_count(input Handle) i64 {
	return zend.iterable_count_ptr(input.raw_ptr())
}

pub fn array_get_index(handle Handle, index int) Handle {
	if !handle.is_valid() {
		return Handle.invalid()
	}
	return Handle.from_ptr(zend.array_get_index_ptr(handle.raw_ptr(), index))
}

pub fn array_get_key(handle Handle, key string) Handle {
	if !handle.is_valid() {
		return Handle.invalid()
	}
	return Handle.from_ptr(zend.array_get_key_ptr(handle.raw_ptr(), key))
}

pub fn array_find_key(handle Handle, key Handle) Handle {
	return Handle.from_ptr(zend.array_find_key_ptr(handle.raw_ptr(), key.raw_ptr()))
}

pub fn array_find_string_key(handle Handle, key string) Handle {
	return Handle.from_ptr(zend.array_find_string_key_ptr(handle.raw_ptr(), key))
}

pub fn array_remove_key(handle Handle, key string) bool {
	return zend.array_remove_key_ptr(handle.raw_ptr(), key)
}

pub fn array_remove_index(handle Handle, index i64) bool {
	return zend.array_remove_index_ptr(handle.raw_ptr(), index)
}

pub fn is_null(handle Handle) bool {
	if !handle.is_valid() {
		return true
	}
	return zend.zval_is_null_ptr(handle.raw_ptr())
}
