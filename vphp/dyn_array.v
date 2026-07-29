module vphp

pub enum DynArrayKeyKind {
	deleted
	int_key
	str_key
}

pub struct DynArrayBucket {
pub mut:
	key_kind DynArrayKeyKind
	ikey     i64
	skey     string
	val      DynValue
}

pub struct DynArrayIterItem {
pub:
	key DynValue
	val DynValue
}

@[heap]
pub struct DynArray {
mut:
	buckets    []DynArrayBucket
	int_index  map[i64]int
	str_index  map[string]int
	n_next_idx i64
	cursor     int
}

pub fn DynArray.new() DynArray {
	return DynArray{
		buckets:    []DynArrayBucket{}
		int_index:  map[i64]int{}
		str_index:  map[string]int{}
		n_next_idx: 0
		cursor:     0
	}
}

pub fn DynArray.new_boxed() &DynArray {
	return &DynArray{
		buckets:    []DynArrayBucket{}
		int_index:  map[i64]int{}
		str_index:  map[string]int{}
		n_next_idx: 0
		cursor:     0
	}
}

pub fn DynArray.from_list(v []DynValue) &DynArray {
	mut out := DynArray.new_boxed()
	for item in v {
		out.push(item)
	}
	return out
}

pub fn DynArray.from_map(v map[string]DynValue) &DynArray {
	mut out := DynArray.new_boxed()
	for key, item in v {
		out.set_str(key, item)
	}
	return out
}

fn dyn_array_normalize_str_key(s string) ?i64 {
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

fn (mut arr DynArray) append_bucket(kind DynArrayKeyKind, ikey i64, skey string, val DynValue) {
	idx := arr.buckets.len
	arr.buckets << DynArrayBucket{
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

pub fn (arr &DynArray) get_int(key i64) DynValue {
	if idx := arr.int_index[key] {
		bucket := arr.buckets[idx]
		if bucket.key_kind == .int_key {
			return bucket.val.clone()
		}
	}
	return DynValue.null()
}

pub fn (arr &DynArray) get_str(key string) DynValue {
	if ikey := dyn_array_normalize_str_key(key) {
		return arr.get_int(ikey)
	}
	if idx := arr.str_index[key] {
		bucket := arr.buckets[idx]
		if bucket.key_kind == .str_key {
			return bucket.val.clone()
		}
	}
	return DynValue.null()
}

pub fn (arr &DynArray) get(key DynValue) DynValue {
	if key.type == .int_ {
		return arr.get_int(key.int_value())
	}
	return arr.get_str(key.to_string())
}

pub fn (arr &DynArray) to_list() []DynValue {
	mut out := []DynValue{}
	mut iter := arr.iter()
	for {
		item := iter.next() or { break }
		out << item.val
	}
	return out
}

pub fn (arr &DynArray) to_map() map[string]DynValue {
	mut out := map[string]DynValue{}
	mut iter := arr.iter()
	for {
		item := iter.next() or { break }
		out[item.key.to_string()] = item.val
	}
	return out
}

pub fn (mut arr DynArray) set_int(key i64, val DynValue) {
	if idx := arr.int_index[key] {
		if arr.buckets[idx].key_kind == .int_key {
			arr.buckets[idx].val = val.clone()
			return
		}
	}
	arr.append_bucket(.int_key, key, '', val)
}

pub fn (mut arr DynArray) set_str(key string, val DynValue) {
	if ikey := dyn_array_normalize_str_key(key) {
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

pub fn (mut arr DynArray) set(key DynValue, val DynValue) {
	if key.type == .int_ {
		arr.set_int(key.int_value(), val)
		return
	}
	arr.set_str(key.to_string(), val)
}

pub fn (mut arr DynArray) push(val DynValue) {
	arr.set_int(arr.n_next_idx, val)
}

pub fn (mut arr DynArray) delete_int(key i64) {
	if idx := arr.int_index[key] {
		if arr.buckets[idx].key_kind == .int_key {
			arr.buckets[idx].key_kind = .deleted
			arr.int_index.delete(key)
		}
	}
}

pub fn (mut arr DynArray) delete_str(key string) {
	if ikey := dyn_array_normalize_str_key(key) {
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

pub fn (arr &DynArray) count() int {
	mut n := 0
	for bucket in arr.buckets {
		if bucket.key_kind != .deleted {
			n++
		}
	}
	return n
}

pub struct DynArrayIterator {
	arr &DynArray
mut:
	index int
	limit int
}

pub fn (arr &DynArray) iter() DynArrayIterator {
	return DynArrayIterator{
		arr:   arr
		index: 0
		limit: arr.buckets.len
	}
}

pub fn (mut it DynArrayIterator) next() ?DynArrayIterItem {
	for it.index < it.limit {
		idx := it.index
		it.index++
		bucket := it.arr.buckets[idx]
		if bucket.key_kind == .deleted {
			continue
		}
		key := match bucket.key_kind {
			.int_key { DynValue.of_int(bucket.ikey) }
			.str_key { DynValue.of_string(bucket.skey) }
			else { DynValue.null() }
		}
		return DynArrayIterItem{
			key: key
			val: bucket.val.clone()
		}
	}
	return none
}

pub fn (arr &DynArray) clone_boxed() &DynArray {
	mut cloned := DynArray.new_boxed()
	cloned.n_next_idx = arr.n_next_idx
	cloned.cursor = arr.cursor
	for bucket in arr.buckets {
		idx := cloned.buckets.len
		cloned.buckets << DynArrayBucket{
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

pub fn (arr &DynArray) has_runtime_refs() bool {
	for bucket in arr.buckets {
		if bucket.key_kind != .deleted && bucket.val.has_runtime_refs() {
			return true
		}
	}
	return false
}

pub fn (arr &DynArray) has_request_refs() bool {
	for bucket in arr.buckets {
		if bucket.key_kind != .deleted && bucket.val.has_request_refs() {
			return true
		}
	}
	return false
}

pub fn (arr &DynArray) can_escape_request() bool {
	for bucket in arr.buckets {
		if bucket.key_kind != .deleted && !bucket.val.can_escape_request() {
			return false
		}
	}
	return true
}

fn (arr &DynArray) release_runtime_refs() {
	for bucket in arr.buckets {
		if bucket.key_kind != .deleted {
			bucket.val.release_runtime_refs()
		}
	}
}

pub fn (mut arr DynArray) release() {
	for i in 0 .. arr.buckets.len {
		arr.buckets[i].val.release()
	}
	arr.buckets = []DynArrayBucket{}
	arr.int_index = map[i64]int{}
	arr.str_index = map[string]int{}
	arr.n_next_idx = 0
	arr.cursor = 0
}
