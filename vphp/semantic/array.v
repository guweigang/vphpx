module semantic

pub enum KeyKind {
	deleted
	int_key
	str_key
}

pub struct Bucket {
pub mut:
	key_kind KeyKind
	ikey     i64
	skey     string
	val      Value
}

pub struct IterItem {
pub:
	key Value
	val Value
}

@[heap]
pub struct Array {
mut:
	buckets    []Bucket
	int_index  map[i64]int
	str_index  map[string]int
	n_next_idx i64
	cursor     int
}

pub fn Array.new() Array {
	return Array{
		buckets:    []Bucket{}
		int_index:  map[i64]int{}
		str_index:  map[string]int{}
		n_next_idx: 0
		cursor:     0
	}
}

pub fn Array.new_boxed() &Array {
	return &Array{
		buckets:    []Bucket{}
		int_index:  map[i64]int{}
		str_index:  map[string]int{}
		n_next_idx: 0
		cursor:     0
	}
}

fn normalize_str_key(s string) ?i64 {
	if s.len == 0 {
		return none
	}
	mut negative := false
	mut start := 0
	if s[0] == `-` {
		negative = true
		start = 1
		if s.len == 1 {
			return none
		}
		if s.len > 2 && s[1] == `0` {
			return none
		}
	} else if s.len > 1 && s[0] == `0` {
		return none
	}
	mut result := i64(0)
	for i in start .. s.len {
		if s[i] < `0` || s[i] > `9` {
			return none
		}
		result = result * 10 + i64(s[i] - `0`)
	}
	if negative {
		result = -result
	}
	return result
}

fn (mut arr Array) append_bucket(kind KeyKind, ikey i64, skey string, val Value) {
	idx := arr.buckets.len
	arr.buckets << Bucket{
		key_kind: kind
		ikey:     ikey
		skey:     skey
		val:      val.clone()
	}
	match kind {
		.int_key {
			arr.int_index[ikey] = idx
			if ikey >= arr.n_next_idx {
				arr.n_next_idx = ikey + 1
			}
		}
		.str_key {
			arr.str_index[skey] = idx
		}
		else {}
	}
}

pub fn (arr &Array) get_int(key i64) Value {
	if idx := arr.int_index[key] {
		bucket := arr.buckets[idx]
		if bucket.key_kind == .int_key {
			return bucket.val.clone()
		}
	}
	return null_value()
}

pub fn (arr &Array) get_str(key string) Value {
	if ikey := normalize_str_key(key) {
		return arr.get_int(ikey)
	}
	if idx := arr.str_index[key] {
		bucket := arr.buckets[idx]
		if bucket.key_kind == .str_key {
			return bucket.val.clone()
		}
	}
	return null_value()
}

pub fn (arr &Array) get(key Value) Value {
	return match key {
		IntValue { arr.get_int(key.value) }
		else { arr.get_str(key.to_string()) }
	}
}

pub fn (mut arr Array) set_int(key i64, val Value) {
	if idx := arr.int_index[key] {
		if arr.buckets[idx].key_kind == .int_key {
			arr.buckets[idx].val = val.clone()
			return
		}
	}
	arr.append_bucket(.int_key, key, '', val)
}

pub fn (mut arr Array) set_str(key string, val Value) {
	if ikey := normalize_str_key(key) {
		arr.set_int(ikey, val)
		return
	}
	if idx := arr.str_index[key] {
		if arr.buckets[idx].key_kind == .str_key {
			arr.buckets[idx].val = val.clone()
			return
		}
	}
	arr.append_bucket(.str_key, 0, key, val)
}

pub fn (mut arr Array) set(key Value, val Value) {
	match key {
		IntValue { arr.set_int(key.value, val) }
		else { arr.set_str(key.to_string(), val) }
	}
}

pub fn (mut arr Array) push(val Value) {
	arr.set_int(arr.n_next_idx, val)
}

pub fn (mut arr Array) delete_int(key i64) {
	if idx := arr.int_index[key] {
		if arr.buckets[idx].key_kind == .int_key {
			arr.buckets[idx].key_kind = .deleted
			arr.int_index.delete(key)
		}
	}
}

pub fn (mut arr Array) delete_str(key string) {
	if ikey := normalize_str_key(key) {
		arr.delete_int(ikey)
		return
	}
	if idx := arr.str_index[key] {
		if arr.buckets[idx].key_kind == .str_key {
			arr.buckets[idx].key_kind = .deleted
			arr.str_index.delete(key)
		}
	}
}

pub fn (mut arr Array) delete(key Value) {
	match key {
		IntValue { arr.delete_int(key.value) }
		else { arr.delete_str(key.to_string()) }
	}
}

pub fn (arr &Array) isset_int(key i64) bool {
	if idx := arr.int_index[key] {
		bucket := arr.buckets[idx]
		return bucket.key_kind == .int_key && !bucket.val.is_null()
	}
	return false
}

pub fn (arr &Array) isset_str(key string) bool {
	if ikey := normalize_str_key(key) {
		return arr.isset_int(ikey)
	}
	if idx := arr.str_index[key] {
		bucket := arr.buckets[idx]
		return bucket.key_kind == .str_key && !bucket.val.is_null()
	}
	return false
}

pub fn (arr &Array) isset(key Value) bool {
	return match key {
		IntValue { arr.isset_int(key.value) }
		else { arr.isset_str(key.to_string()) }
	}
}

pub fn (arr &Array) count() int {
	mut n := 0
	for bucket in arr.buckets {
		if bucket.key_kind != .deleted {
			n++
		}
	}
	return n
}

pub struct ArrayIterator {
	arr &Array
mut:
	index int
	limit int
}

pub fn (arr &Array) iter() ArrayIterator {
	return ArrayIterator{
		arr:   arr
		index: 0
		limit: arr.buckets.len
	}
}

pub fn (mut it ArrayIterator) next() ?IterItem {
	for it.index < it.limit {
		idx := it.index
		it.index++
		bucket := it.arr.buckets[idx]
		if bucket.key_kind == .deleted {
			continue
		}
		key := match bucket.key_kind {
			.int_key { int_value(bucket.ikey) }
			.str_key { string_value(bucket.skey) }
			else { null_value() }
		}
		return IterItem{
			key: key
			val: bucket.val.clone()
		}
	}
	return none
}

pub fn (arr &Array) clone_boxed() &Array {
	mut cloned := Array.new_boxed()
	cloned.n_next_idx = arr.n_next_idx
	cloned.cursor = arr.cursor
	for bucket in arr.buckets {
		idx := cloned.buckets.len
		cloned.buckets << Bucket{
			key_kind: bucket.key_kind
			ikey:     bucket.ikey
			skey:     bucket.skey
			val:      bucket.val.clone()
		}
		match bucket.key_kind {
			.int_key { cloned.int_index[bucket.ikey] = idx }
			.str_key { cloned.str_index[bucket.skey] = idx }
			else {}
		}
	}
	return cloned
}
