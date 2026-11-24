module vphp

import vphp.zval

pub struct PhpIterable {
mut:
	value PhpValueZBox
}

pub fn PhpIterable.from_zval(z ZVal) ?PhpIterable {
	if z.is_array() || (z.is_object() && z.is_instance_of('Traversable')) {
		return PhpIterable{
			value: PhpValueZBox.from_zval(z)
		}
	}
	return none
}

pub fn PhpIterable.must_from_zval(z ZVal) !PhpIterable {
	iter := PhpIterable.from_zval(z) or { return error('zval is not iterable') }
	return iter
}

pub fn PhpIterable.from_request_owned_zbox(value RequestOwnedZBox) ?PhpIterable {
	z := value.to_zval()
	if z.is_array() || (z.is_object() && z.is_instance_of('Traversable')) {
		return PhpIterable{
			value: PhpValueZBox.request_owned(value)
		}
	}
	return none
}

pub fn PhpIterable.from_persistent_owned_zbox(value PersistentOwnedZBox) ?PhpIterable {
	if value.with_request_zval(fn (z ZVal) bool {
		return z.is_array() || (z.is_object() && z.is_instance_of('Traversable'))
	}) {
		return PhpIterable{
			value: PhpValueZBox.persistent_owned(value)
		}
	}
	return none
}

pub fn PhpIterable.from_persistent_zval(z ZVal) ?PhpIterable {
	return PhpIterable.from_persistent_owned_zbox(PersistentOwnedZBox.from_persistent_zval(z))
}

pub fn (i PhpIterable) to_zval() ZVal {
	return i.value.to_zval()
}

pub fn (i PhpIterable) to_value() PhpValue {
	return PhpValue{
		value: i.value.clone()
	}
}

pub fn (i PhpIterable) to_array() !PhpArray {
	if i.is_array() {
		return PhpArray{ value: i.value.clone() }
	}
	return i.collect(.keyed)
}

pub fn (i PhpIterable) to_list() !PhpArray {
	return i.collect(.values)
}

// each_value_while visits borrowed values in order. Returning false stops
// traversal before advancing to the next item. The result is false if stopped.
pub fn (i PhpIterable) each_value_while(callback fn (ZVal) bool) !bool {
	if !i.is_array() && !i.is_traversable() {
		return error('value is not iterable')
	}
	completed := i.to_zval().iterable_values_while(callback)
	if has_exception() {
		return error('PHP iterable traversal threw an exception')
	}
	return completed
}

// each_value_by_value_while visits a snapshot of each value before advancing.
// The snapshot is borrowed for the callback and keeps PHP object identity.
pub fn (i PhpIterable) each_value_by_value_while(callback fn (PhpValue) bool) !bool {
	return i.each_value_while(fn [callback] (z ZVal) bool {
		mut item := PhpValue.from_zval(z)
		mut snapshot := PhpValue.adopt_zval(item.take_zval_by_value())
		defer {
			snapshot.release()
		}
		return callback(snapshot.borrowed())
	})
}

// to_entries collects ordered [key, value] pairs, including repeated keys.
pub fn (i PhpIterable) to_entries() !PhpArray {
	return i.collect(.entries)
}

fn (i PhpIterable) collect(shape zval.IterableCollection) !PhpArray {
	if !i.is_array() && !i.is_traversable() {
		return error('value is not iterable')
	}
	mut result := PhpArray.new()
	zval.iterable_collect(i.to_zval().handle(), result.to_zval().handle(), shape)
	if has_exception() {
		result.release()
		return error('PHP iterator threw an exception')
	}
	return result
}

pub fn (i PhpIterable) to_borrowed() PhpIterable {
	return PhpIterable.from_zval(i.value.to_borrowed_zbox().to_zval()) or { i }
}

pub fn (i PhpIterable) borrowed() PhpIterable {
	return i.to_borrowed()
}

pub fn (i PhpIterable) borrow() PhpIterable {
	return i.to_borrowed()
}

pub fn (i PhpIterable) to_borrowed_zbox() RequestBorrowedZBox {
	return i.value.to_borrowed_zbox()
}

pub fn (i PhpIterable) to_request_owned() PhpIterable {
	return PhpIterable.from_request_owned_zbox(i.value.to_request_owned_zbox()) or {
		i.to_borrowed()
	}
}

pub fn (i PhpIterable) owned() PhpIterable {
	return i.to_request_owned()
}

pub fn (i PhpIterable) to_request_owned_zbox() RequestOwnedZBox {
	return i.value.to_request_owned_zbox()
}

pub fn (i PhpIterable) to_persistent_owned() PhpIterable {
	return PhpIterable.from_persistent_owned_zbox(i.value.to_persistent_owned_zbox()) or {
		i.to_borrowed()
	}
}

pub fn (i PhpIterable) retain() PhpIterable {
	return i.to_persistent_owned()
}

pub fn (i PhpIterable) retained() PhpIterable {
	return i.to_persistent_owned()
}

pub fn (i PhpIterable) to_persistent_owned_zbox() PersistentOwnedZBox {
	return i.value.to_persistent_owned_zbox()
}

pub fn (i PhpIterable) is_borrowed() bool {
	return i.value.is_borrowed()
}

pub fn (i PhpIterable) is_owned() bool {
	return i.value.is_request_owned()
}

pub fn (i PhpIterable) is_retained() bool {
	return i.value.is_retained()
}

pub fn (mut i PhpIterable) take_zval() ZVal {
	return i.value.take_zval()
}

pub fn (mut i PhpIterable) release() {
	i.value.release()
}

pub fn (i PhpIterable) is_array() bool {
	return i.to_zval().is_array()
}

pub fn (i PhpIterable) is_traversable() bool {
	return i.to_zval().is_object() && i.to_zval().is_instance_of('Traversable')
}

// count consumes Traversable input without calling current() or key().
pub fn (i PhpIterable) count() int {
	count := zval.iterable_count(i.to_zval().handle())
	return if count > max_int { max_int } else { int(count) }
}

pub fn (i PhpIterable) fold[T](init T, cb ForeachWithCtxCb[T]) T {
	return i.to_zval().foreach_with_ctx[T](init, cb)
}

pub fn (i PhpIterable) key_strings() []string {
	return i.to_zval().foreach_with_ctx[[]string]([]string{}, fn (key ZVal, _ ZVal, mut acc []string) {
		acc << key.to_string()
	})
}

pub fn (i PhpIterable) to_dyn_value() !DynValue {
	mut temp := i.to_request_owned_zbox()
	defer {
		temp.release()
	}
	return DynValue.from_zval(temp.to_zval())
}
