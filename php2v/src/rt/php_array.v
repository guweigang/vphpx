module rt

// ──────────────────────────────────────────────
// PhpArray -- 纯 V 实现的有序哈希表
// 语义兼容 PHP 的 zend_array（关联数组）
// ──────────────────────────────────────────────

// KeyKind 标记桶的键类型
pub enum KeyKind {
	deleted // 墓碑标记（已删除的桶）
	int_key
	str_key
}

// Bucket 保存一个键值对，按插入顺序排列
pub struct Bucket {
pub mut:
	key_kind KeyKind
	ikey     i64    // 整数键（key_kind == .int_key 时有效）
	skey     string // 字符串键（key_kind == .str_key 时有效）
	val      PhpVal // 值
}

// PhpArray 是 PHP 关联数组的纯 V 实现
// 特性：有序（插入顺序）、混合键类型（int+string）、O(1) 查找
@[heap]
pub struct PhpArray {
pub mut:
	buckets    []Bucket       // 有序桶数组（含墓碑）
	int_index  map[i64]int    // 整数键 → 桶索引（O(1) 查找）
	str_index  map[string]int // 字符串键 → 桶索引（O(1) 查找）
	n_next_idx i64            // 下一个自动递增索引（$arr[] = val）
	cursor     int            // 内部游标（模拟 PHP 内部数组指针）
}

// new 创建空的 PhpArray
pub fn PhpArray.new() PhpArray {
	return PhpArray{
		buckets:    []Bucket{}
		int_index:  map[i64]int{}
		str_index:  map[string]int{}
		n_next_idx: 0
		cursor:     0
	}
}

// ─── 内部辅助 ────────────────────────────────────

// normalize_str_key 检测数字字符串并转换为整数键
// PHP 中 $arr["123"] 等价于 $arr[123]，但 "01" 不等价于 1
fn normalize_str_key(s string) ?i64 {
	if s.len == 0 {
		return none
	}
	// 不允许前导零（除了 "0" 本身）
	if s.len > 1 && s[0] == `0` {
		return none
	}
	// 尝试解析为整数
	mut negative := false
	mut start := 0
	if s[0] == `-` {
		negative = true
		start = 1
		if s.len == 1 {
			return none
		}
		// 负数不允许前导零
		if s.len > 2 && s[1] == `0` {
			return none
		}
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

// append_bucket 追加一个新桶并更新索引
fn (mut pa PhpArray) append_bucket(kind KeyKind, ikey i64, skey string, val PhpVal) {
	idx := pa.buckets.len
	pa.buckets << Bucket{
		key_kind: kind
		ikey:     ikey
		skey:     skey
		val:      val
	}
	match kind {
		.int_key {
			pa.int_index[ikey] = idx
			// 更新 n_next_idx
			if ikey >= pa.n_next_idx {
				pa.n_next_idx = ikey + 1
			}
		}
		.str_key {
			pa.str_index[skey] = idx
		}
		else {}
	}
}

// update_bucket 更新已有桶的值
fn (mut pa PhpArray) update_bucket(idx int, val PhpVal) {
	pa.buckets[idx].val = val
}

// ─── 读取 ────────────────────────────────────────

// get_int 按整数键查找
pub fn (pa &PhpArray) get_int(key i64) PhpVal {
	if idx := pa.int_index[key] {
		bucket := pa.buckets[idx]
		if bucket.key_kind == .int_key {
			return bucket.val.dup()
		}
	}
	return new_null()
}

// get_str 按字符串键查找（自动处理数字字符串归一化）
pub fn (pa &PhpArray) get_str(key string) PhpVal {
	// 数字字符串归一化
	if ikey := normalize_str_key(key) {
		return pa.get_int(ikey)
	}
	if idx := pa.str_index[key] {
		bucket := pa.buckets[idx]
		if bucket.key_kind == .str_key {
			return bucket.val.dup()
		}
	}
	return new_null()
}

// get 按 PhpVal 键查找（根据键类型分发）
pub fn (pa &PhpArray) get(key PhpVal) PhpVal {
	typ := key.raw.u1.type_info & 0xff
	if typ == 4 { // IS_LONG
		return pa.get_int(key.to_i64())
	}
	return pa.get_str(key.to_string())
}

// ─── 写入 ────────────────────────────────────────

// set_int 设置整数键的值（更新已有或追加新桶）
pub fn (mut pa PhpArray) set_int(key i64, val PhpVal) {
	val_copy := val.dup()
	if idx := pa.int_index[key] {
		if pa.buckets[idx].key_kind == .int_key {
			pa.update_bucket(idx, val_copy)
			return
		}
	}
	pa.append_bucket(.int_key, key, '', val_copy)
}

// set_str 设置字符串键的值（自动处理数字字符串归一化）
pub fn (mut pa PhpArray) set_str(key string, val PhpVal) {
	// 数字字符串归一化
	if ikey := normalize_str_key(key) {
		pa.set_int(ikey, val)
		return
	}
	val_copy := val.dup()
	if idx := pa.str_index[key] {
		if pa.buckets[idx].key_kind == .str_key {
			pa.update_bucket(idx, val_copy)
			return
		}
	}
	pa.append_bucket(.str_key, 0, key, val_copy)
}

// set 按 PhpVal 键设置值
pub fn (mut pa PhpArray) set(key PhpVal, val PhpVal) {
	typ := key.raw.u1.type_info & 0xff
	if typ == 4 { // IS_LONG
		pa.set_int(key.to_i64(), val)
	} else {
		pa.set_str(key.to_string(), val)
	}
}

// push 追加元素（使用自动递增索引）
pub fn (mut pa PhpArray) push(val PhpVal) {
	key := pa.n_next_idx
	pa.set_int(key, val)
}

// ─── 删除 ────────────────────────────────────────

// del_int 删除整数键（标记为墓碑）
pub fn (mut pa PhpArray) del_int(key i64) {
	if idx := pa.int_index[key] {
		if pa.buckets[idx].key_kind == .int_key {
			pa.buckets[idx].key_kind = .deleted
			pa.int_index.delete(key)
		}
	}
}

// del_str 删除字符串键
pub fn (mut pa PhpArray) del_str(key string) {
	if ikey := normalize_str_key(key) {
		pa.del_int(ikey)
		return
	}
	if idx := pa.str_index[key] {
		if pa.buckets[idx].key_kind == .str_key {
			pa.buckets[idx].key_kind = .deleted
			pa.str_index.delete(key)
		}
	}
}

// del 按 PhpVal 键删除
pub fn (mut pa PhpArray) del(key PhpVal) {
	typ := key.raw.u1.type_info & 0xff
	if typ == 4 {
		pa.del_int(key.to_i64())
	} else {
		pa.del_str(key.to_string())
	}
}

// ─── 存在性检查 ──────────────────────────────────

// isset_int 检查整数键是否存在且值非 null
pub fn (pa &PhpArray) isset_int(key i64) bool {
	if idx := pa.int_index[key] {
		bucket := pa.buckets[idx]
		if bucket.key_kind == .int_key {
			return !bucket.val.is_null()
		}
	}
	return false
}

// isset_str 检查字符串键是否存在且值非 null
pub fn (pa &PhpArray) isset_str(key string) bool {
	if ikey := normalize_str_key(key) {
		return pa.isset_int(ikey)
	}
	if idx := pa.str_index[key] {
		bucket := pa.buckets[idx]
		if bucket.key_kind == .str_key {
			return !bucket.val.is_null()
		}
	}
	return false
}

// isset 按 PhpVal 键检查
pub fn (pa &PhpArray) isset(key PhpVal) bool {
	typ := key.raw.u1.type_info & 0xff
	if typ == 4 {
		return pa.isset_int(key.to_i64())
	}
	return pa.isset_str(key.to_string())
}

// ─── 计数 ────────────────────────────────────────

// count 返回存活条目数（跳过墓碑）
pub fn (pa &PhpArray) count() int {
	mut n := 0
	for bucket in pa.buckets {
		if bucket.key_kind != .deleted {
			n++
		}
	}
	return n
}

// ─── 迭代 ────────────────────────────────────────

// PhpArrayIterator 纯 V 的数组迭代器
pub struct PhpArrayIterator {
pub mut:
	arr   &PhpArray
	index int
	limit int
}

// iter 创建迭代器
pub fn (pa &PhpArray) iter() PhpArrayIterator {
	return PhpArrayIterator{
		arr:   pa
		index: 0
		limit: pa.buckets.len
	}
}

// next 返回下一个存活条目，跳过墓碑
pub fn (mut it PhpArrayIterator) next_iter() ?IterItem {
	for it.index < it.limit {
		idx := it.index
		it.index++
		bucket := it.arr.buckets[idx]
		if bucket.key_kind == .deleted {
			continue
		}
		mut k := new_null()
		match bucket.key_kind {
			.int_key {
				k = new_int(bucket.ikey)
			}
			.str_key {
				k = new_string(bucket.skey)
			}
			else {}
		}
		return IterItem{
			key: k
			val: bucket.val.dup()
		}
	}
	return none
}

// ─── 深拷贝 ──────────────────────────────────────

// dup 深拷贝整个 PhpArray（含所有桶和值）
pub fn (pa &PhpArray) dup() PhpArray {
	mut new_pa := PhpArray.new()
	new_pa.n_next_idx = pa.n_next_idx
	for bucket in pa.buckets {
		new_bucket := Bucket{
			key_kind: bucket.key_kind
			ikey:     bucket.ikey
			skey:     bucket.skey
			val:      bucket.val.dup()
		}
		idx := new_pa.buckets.len
		new_pa.buckets << new_bucket
		match bucket.key_kind {
			.int_key {
				new_pa.int_index[bucket.ikey] = idx
			}
			.str_key {
				new_pa.str_index[bucket.skey] = idx
			}
			else {}
		}
	}
	return new_pa
}

// ─── 从 ArrayItem 字面量构建 ─────────────────────

// from_items 从数组字面量的项构建 PhpArray
pub fn PhpArray.from_items(items []ArrayItem) PhpArray {
	mut pa := PhpArray.new()
	for item in items {
		if k := item.key {
			pa.set(k.to_php_val(), item.val.to_php_val())
		} else {
			pa.push(item.val.to_php_val())
		}
	}
	return pa
}

// ─── 存储到 C.zval / 从 C.zval 提取 ─────────────
// 这些函数桥接 PhpArray 与现有的 PhpVal 系统

// store_in_zval 将 PhpArray 存储到 zval 的 value 字段中
pub fn (pa &PhpArray) store_in_zval(z &C.zval) {
	unsafe {
		arr_ptr := &PhpArray(malloc(int(sizeof(PhpArray))))
		*arr_ptr = pa.dup()
		mut p := &voidptr(&z.value)
		*p = voidptr(arr_ptr)
	}
}

// extract_from_zval 从 zval 的 value 字段提取 PhpArray 指针
pub fn extract_from_zval(z &C.zval) &PhpArray {
	unsafe {
		p := &voidptr(&z.value)
		return &PhpArray(*p)
	}
}

// unshift 往数组头部插入元素，并重新分配所有数字键索引（从 0 开始）
pub fn (mut pa PhpArray) unshift(val PhpVal) {
	mut new_pa := PhpArray.new()
	new_pa.push(val)
	for b in pa.buckets {
		if b.key_kind == .deleted {
			continue
		}
		if b.key_kind == .int_key {
			new_pa.push(b.val)
		} else if b.key_kind == .str_key {
			new_pa.set_str(b.skey, b.val)
		}
	}
	pa.buckets = new_pa.buckets
	pa.int_index = new_pa.int_index.clone()
	pa.str_index = new_pa.str_index.clone()
	pa.n_next_idx = new_pa.n_next_idx
}

// pop 弹出并删除数组末尾的元素
pub fn (mut pa PhpArray) pop() PhpVal {
	for i := pa.buckets.len - 1; i >= 0; i-- {
		b := pa.buckets[i]
		if b.key_kind == .deleted {
			continue
		}
		val := b.val.dup()
		if b.key_kind == .int_key {
			pa.int_index.delete(b.ikey)
		} else if b.key_kind == .str_key {
			pa.str_index.delete(b.skey)
		}
		pa.buckets[i].key_kind = .deleted
		return val
	}
	return new_null()
}

// shift 弹出并删除数组开头的元素，重新分配所有数字键索引（从 0 开始）
pub fn (mut pa PhpArray) shift() PhpVal {
	mut first_val := new_null()
	mut found_first := false
	mut first_idx := -1
	for i := 0; i < pa.buckets.len; i++ {
		if pa.buckets[i].key_kind != .deleted {
			first_val = pa.buckets[i].val.dup()
			first_idx = i
			found_first = true
			break
		}
	}
	if !found_first {
		return new_null()
	}

	mut new_pa := PhpArray.new()
	for i := 0; i < pa.buckets.len; i++ {
		if i == first_idx || pa.buckets[i].key_kind == .deleted {
			continue
		}
		b := pa.buckets[i]
		if b.key_kind == .int_key {
			new_pa.push(b.val)
		} else if b.key_kind == .str_key {
			new_pa.set_str(b.skey, b.val)
		}
	}
	pa.buckets = new_pa.buckets
	pa.int_index = new_pa.int_index.clone()
	pa.str_index = new_pa.str_index.clone()
	pa.n_next_idx = new_pa.n_next_idx
	return first_val
}

// merge 合并两个 PhpArray，返回新的 PhpArray
pub fn (pa &PhpArray) merge(other &PhpArray) PhpArray {
	mut new_pa := PhpArray.new()
	for b in pa.buckets {
		if b.key_kind == .deleted {
			continue
		}
		if b.key_kind == .int_key {
			new_pa.push(b.val)
		} else if b.key_kind == .str_key {
			new_pa.set_str(b.skey, b.val)
		}
	}
	for b in other.buckets {
		if b.key_kind == .deleted {
			continue
		}
		if b.key_kind == .int_key {
			new_pa.push(b.val)
		} else if b.key_kind == .str_key {
			new_pa.set_str(b.skey, b.val)
		}
	}
	return new_pa
}

// reset 将内部指针指向第一个元素并返回其值
pub fn (mut pa PhpArray) reset() PhpVal {
	pa.cursor = 0
	for pa.cursor < pa.buckets.len {
		if pa.buckets[pa.cursor].key_kind != .deleted {
			return pa.buckets[pa.cursor].val.dup()
		}
		pa.cursor++
	}
	return new_bool(false)
}

// current 返回内部指针当前指向的元素的值
pub fn (pa &PhpArray) current() PhpVal {
	if pa.cursor >= 0 && pa.cursor < pa.buckets.len {
		b := pa.buckets[pa.cursor]
		if b.key_kind != .deleted {
			return b.val.dup()
		}
	}
	return new_bool(false)
}

// key 返回内部指针当前指向的元素的键
pub fn (pa &PhpArray) key() PhpVal {
	if pa.cursor >= 0 && pa.cursor < pa.buckets.len {
		b := pa.buckets[pa.cursor]
		if b.key_kind == .int_key {
			return new_int(b.ikey)
		} else if b.key_kind == .str_key {
			return new_string(b.skey)
		}
	}
	return new_null()
}

// next 将内部指针向后移动一位并返回移动后的元素值
pub fn (mut pa PhpArray) next() PhpVal {
	pa.cursor++
	for pa.cursor < pa.buckets.len {
		if pa.buckets[pa.cursor].key_kind != .deleted {
			return pa.buckets[pa.cursor].val.dup()
		}
		pa.cursor++
	}
	return new_bool(false)
}

// prev 将内部指针向前移动一位并返回移动后的元素值
pub fn (mut pa PhpArray) prev() PhpVal {
	if pa.cursor > 0 {
		pa.cursor--
		for pa.cursor >= 0 {
			if pa.buckets[pa.cursor].key_kind != .deleted {
				return pa.buckets[pa.cursor].val.dup()
			}
			pa.cursor--
		}
	}
	pa.cursor = -1
	return new_bool(false)
}

// end 将内部指针指向最后一个元素并返回其值
pub fn (mut pa PhpArray) end() PhpVal {
	pa.cursor = pa.buckets.len - 1
	for pa.cursor >= 0 {
		if pa.buckets[pa.cursor].key_kind != .deleted {
			return pa.buckets[pa.cursor].val.dup()
		}
		pa.cursor--
	}
	pa.cursor = -1
	return new_bool(false)
}


