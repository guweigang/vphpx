module zend

fn C.vphp_iterable_foreach_while(input &C.zval, ctx voidptr, callback fn (voidptr, &C.zval, &C.zval) bool)

pub fn iterable_foreach_while(input voidptr, ctx voidptr, callback fn (voidptr, &C.zval, &C.zval) bool) {
	unsafe { C.vphp_iterable_foreach_while(&C.zval(input), ctx, callback) }
}

pub fn iterable_collect_ptr(input voidptr, output voidptr, shape int) {
	unsafe { C.vphp_iterable_collect(&C.zval(input), &C.zval(output), shape) }
}

pub fn iterable_count_ptr(input voidptr) i64 {
	return unsafe { C.vphp_iterable_count(&C.zval(input)) }
}

pub fn array_init(v &C.zval) {
	// SAFETY: C bridge call vphp_return_array_start with valid arguments
	unsafe { C.vphp_return_array_start(v) }
}

pub fn array_init_ptr(v voidptr) {
	array_init( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) })
}

pub fn array_add_assoc_string(v &C.zval, key string, val string) {
	// SAFETY: C interop with valid arguments
	unsafe { C.vphp_array_add_assoc_string(v, &char(key.str), usize(key.len), &char(val.str), usize(val.len)) }
}

pub fn array_add_assoc_string_ptr(v voidptr, key string, val string) {
	array_add_assoc_string( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) }, key, val)
}

pub fn array_add_assoc_long(v &C.zval, key string, val i64) {
	// SAFETY: C interop with valid arguments
	unsafe { C.vphp_array_add_assoc_long(v, &char(key.str), usize(key.len), val) }
}

pub fn array_add_assoc_long_ptr(v voidptr, key string, val i64) {
	array_add_assoc_long( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) }, key, val)
}

pub fn array_add_assoc_double(v &C.zval, key string, val f64) {
	// SAFETY: C interop with valid arguments
	unsafe { C.vphp_array_add_assoc_double(v, &char(key.str), usize(key.len), val) }
}

pub fn array_add_assoc_double_ptr(v voidptr, key string, val f64) {
	array_add_assoc_double( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) }, key, val)
}

pub fn array_add_assoc_bool(v &C.zval, key string, val bool) {
	b_val := if val { 1 } else { 0 }
	// SAFETY: C interop with valid arguments
	unsafe { C.vphp_array_add_assoc_bool(v, &char(key.str), usize(key.len), b_val) }
}

pub fn array_add_assoc_bool_ptr(v voidptr, key string, val bool) {
	array_add_assoc_bool( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) }, key, val)
}

pub fn array_add_assoc_zval(v &C.zval, key string, val &C.zval) {
	// SAFETY: C interop with valid arguments
	unsafe { C.vphp_array_add_assoc_zval_len(v, &char(key.str), usize(key.len), val) }
}

pub fn array_add_assoc_zval_ptr(v voidptr, key string, val voidptr) {
	array_add_assoc_zval( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) }, key, // SAFETY: val is a valid zval pointer from Zend runtime
		unsafe { &C.zval(val) })
}

pub fn array_add_index_zval(v &C.zval, index i64, val &C.zval) {
	// SAFETY: C interop with valid arguments
	unsafe { C.vphp_array_add_index_zval(v, index, val) }
}

pub fn array_add_index_zval_ptr(v voidptr, index i64, val voidptr) {
	array_add_index_zval( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) }, index, // SAFETY: val is a valid zval pointer from Zend runtime
		unsafe { &C.zval(val) })
}

pub fn array_push_string(v &C.zval, s string) {
	// SAFETY: C interop with valid arguments
	unsafe { C.vphp_array_push_stringl(v, &char(s.str), s.len) }
}

pub fn array_push_string_ptr(v voidptr, s string) {
	array_push_string( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) }, s)
}

pub fn array_push_long(v &C.zval, val i64) {
	// SAFETY: C bridge call vphp_array_push_long with valid arguments
	unsafe { C.vphp_array_push_long(v, val) }
}

pub fn array_push_long_ptr(v voidptr, val i64) {
	array_push_long( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) }, val)
}

pub fn array_push_double(v &C.zval, val f64) {
	// SAFETY: C bridge call vphp_array_push_double with valid arguments
	unsafe { C.vphp_array_push_double(v, val) }
}

pub fn array_push_double_ptr(v voidptr, val f64) {
	array_push_double( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) }, val)
}

pub fn array_push_bool(v &C.zval, val bool) {
	b_val := if val { 1 } else { 0 }
	// SAFETY: C bridge call vphp_array_push_long with valid arguments
	unsafe { C.vphp_array_push_long(v, b_val) }
}

pub fn array_push_bool_ptr(v voidptr, val bool) {
	array_push_bool( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) }, val)
}

pub fn array_add_next_zval(v &C.zval, val &C.zval) {
	// SAFETY: C bridge call vphp_array_add_next_zval with valid arguments
	unsafe { C.vphp_array_add_next_zval(v, val) }
}

pub fn array_add_next_zval_ptr(v voidptr, val voidptr) {
	array_add_next_zval( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) }, // SAFETY: val is a valid zval pointer from Zend runtime
		unsafe { &C.zval(val) })
}

pub fn array_count(v &C.zval) int {
	return C.vphp_array_count(v)
}

pub fn array_count_ptr(v voidptr) int {
	return array_count( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) })
}

pub fn array_next_index_ptr(v voidptr) i64 {
	return unsafe { C.vphp_array_next_index(&C.zval(v)) }
}

pub fn array_restore_next_index_ptr(v voidptr, index i64) {
	unsafe { C.vphp_array_restore_next_index(&C.zval(v), index) }
}

pub fn array_snapshot_ptr(source voidptr, target voidptr) {
	unsafe { C.vphp_array_snapshot(&C.zval(source), &C.zval(target)) }
}

pub fn array_get_index(v &C.zval, index int) &C.zval {
	return C.vphp_array_get_index(v, i64(index))
}

pub fn array_get_index_ptr(v voidptr, index int) voidptr {
	return array_get_index( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) }, index)
}

pub fn array_get_key(v &C.zval, key string) &C.zval {
	return C.vphp_array_get_key(v, &char(key.str), key.len)
}

pub fn array_get_key_ptr(v voidptr, key string) voidptr {
	return array_get_key( // SAFETY: v is a valid zval pointer from Zend runtime
	unsafe { &C.zval(v) }, key)
}

pub fn array_find_string_key_ptr(v voidptr, key string) voidptr {
	return unsafe { C.vphp_array_find_string_key(&C.zval(v), &char(key.str), usize(key.len)) }
}

pub fn array_find_key_ptr(v voidptr, key voidptr) voidptr {
	return unsafe { C.vphp_array_find_key(&C.zval(v), &C.zval(key)) }
}

pub fn array_remove_key_ptr(v voidptr, key string) bool {
	return unsafe { C.vphp_array_remove_key(&C.zval(v), &char(key.str), usize(key.len)) }
}

pub fn array_remove_index_ptr(v voidptr, index i64) bool {
	return unsafe { C.vphp_array_remove_index(&C.zval(v), index) }
}
