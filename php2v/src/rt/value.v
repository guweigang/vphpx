module rt

import strings

#include <php.h>

#include "rt_helper.h"

fn C.php2v_set_last_mysql_conn(conn voidptr)
fn C.php2v_get_last_mysql_conn() voidptr
fn C.php2v_execute_file(filepath &char) int

fn C.php2v_call_zend_function(name &char, name_len usize, retval &C.zval, param_count u32, params &&C.zval) int
fn C.php2v_call_zend_callable(callable &C.zval, retval &C.zval, param_count u32, params voidptr) int
fn C.php2v_eval_string(str &char, len usize, retval &C.zval) int
fn C.php2v_register_constant(name &char, len usize, val &C.zval) int
fn C.php2v_get_constant(name &char, len usize, val &C.zval) int
fn C.increment_function(op &C.zval) int
fn C.decrement_function(op &C.zval) int
fn C.bitwise_and_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.bitwise_or_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.bitwise_xor_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.shift_left_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.shift_right_function(result &C.zval, op1 &C.zval, op2 &C.zval) int
fn C.bitwise_not_function(result &C.zval, op1 &C.zval) int



// 声明 Zend zval 的底层内存结构
@[typedef]
pub struct C.zval {
pub mut:
	value usize
	u1    C.zval_u1
}

@[typedef]
pub struct C.zval_u1 {
pub mut:
	type_info u32
}

// PhpVal 包装了底层的 C.zval 指针
pub struct PhpVal {
pub mut:
	raw &C.zval
}

// 声明 Zend zend_string 构造器
fn C.zend_string_init(str &char, len usize, persistent bool) voidptr

// new_zval 在 C 堆上分配一个 zval 并清零 (初始化为 IS_UNDEF 状态)
fn new_zval() &C.zval {
	unsafe {
		z := &C.zval(malloc(int(sizeof(C.zval))))
		mut p := &usize(&z.value)
		*p = 0
		z.u1.type_info = 0 // IS_UNDEF
		return z
	}
}

pub fn new_int(n i64) PhpVal {
	z := new_zval()
	unsafe {
		mut p := &i64(&z.value)
		*p = n
		z.u1.type_info = 4 // IS_LONG
	}
	return PhpVal{ raw: z }
}

pub fn new_float(f f64) PhpVal {
	z := new_zval()
	unsafe {
		mut p := &f64(&z.value)
		*p = f
		z.u1.type_info = 5 // IS_DOUBLE
	}
	return PhpVal{ raw: z }
}

fn C.php2v_get_null() &C.zval
fn C.php2v_get_true() &C.zval
fn C.php2v_get_false() &C.zval

pub fn new_bool(b bool) PhpVal {
	if b {
		return PhpVal{ raw: C.php2v_get_true() }
	} else {
		return PhpVal{ raw: C.php2v_get_false() }
	}
}

pub fn new_null() PhpVal {
	return PhpVal{ raw: C.php2v_get_null() }
}

pub fn new_string(s string) PhpVal {
	z := new_zval()
	unsafe {
		str_ptr := C.zend_string_init(s.str, usize(s.len), true)
		mut p := &voidptr(&z.value)
		*p = str_ptr
		z.u1.type_info = 6 // IS_STRING
	}
	return PhpVal{ raw: z }
}

// to_string 零拷贝读取 Zend 字符串或转换标量值为 V 字符串
pub fn (v PhpVal) to_string() string {
	return v.str()
}

// str() 方法使 PhpVal 可以在字符串插值中使用，类似 PHP 的 __toString()
pub fn (v PhpVal) str() string {
	unsafe {
		if v.raw == 0 {
			return ''
		}
		typ := v.raw.u1.type_info & 0xff
		match typ {
			1 { return '' }
			2 { return '' }
			3 { return '1' }
			4 {
				p := &i64(&v.raw.value)
				return (*p).str()
			}
			5 {
				p := &f64(&v.raw.value)
				return (*p).str()
			}
			6 {
				p_str := &voidptr(&v.raw.value)
				str_ptr := *p_str
				if str_ptr == 0 {
					return ''
				}
				len_ptr := &usize(charptr(str_ptr) + 16)
				val_ptr := charptr(str_ptr) + 24
				return tos(val_ptr, int(*len_ptr))
			}
			else {
				return ''
			}
		}
	}
}

pub fn (v PhpVal) to_bool() bool {
	unsafe {
		if v.raw == 0 { return false }
		typ := v.raw.u1.type_info & 0xff
		return typ == 3
	}
}

pub fn (v PhpVal) to_i64() i64 {
	unsafe {
		if v.raw == 0 { return 0 }
		typ := v.raw.u1.type_info & 0xff
		if typ == 4 {
			p := &i64(&v.raw.value)
			return *p
		}
		return 0
	}
}

pub fn (v PhpVal) to_f64() f64 {
	unsafe {
		if v.raw == 0 { return 0.0 }
		typ := v.raw.u1.type_info & 0xff
		if typ == 5 {
			p := &f64(&v.raw.value)
			return *p
		}
		return 0.0
	}
}

pub fn (v PhpVal) is_valid() bool {
	return v.raw != 0
}

pub fn (v PhpVal) is_null() bool {
	return v.raw != 0 && (v.raw.u1.type_info & 0xff) == 1
}

pub fn (v PhpVal) is_bool() bool {
	if v.raw == 0 { return false }
	typ := v.raw.u1.type_info & 0xff
	return typ == 2 || typ == 3
}

pub fn (v PhpVal) is_long() bool {
	return v.raw != 0 && (v.raw.u1.type_info & 0xff) == 4
}

pub fn (v PhpVal) is_double() bool {
	return v.raw != 0 && (v.raw.u1.type_info & 0xff) == 5
}

pub fn (v PhpVal) is_string() bool {
	return v.raw != 0 && (v.raw.u1.type_info & 0xff) == 6
}

pub fn (v PhpVal) is_array() bool {
	return v.raw != 0 && (v.raw.u1.type_info & 0xff) == 7
}

fn C.convert_to_array(op &C.zval) int

pub fn cast_array(val PhpVal) PhpVal {
	if val.is_array() {
		return val.dup()
	}
	mut res := val.dup()
	C.convert_to_array(res.raw)
	return res
}

// array_count 返回数组中存活元素的数量（纯 V 实现）
pub fn (v PhpVal) array_count() int {
	if !v.is_array() { return 0 }
	pa := unsafe { extract_from_zval(v.raw) }
	return pa.count()
}

// dup 执行写时复制赋值语义并增加 zend_string 引用计数
pub fn (v PhpVal) dup() PhpVal {
	if v.raw == 0 {
		return PhpVal{ raw: unsafe { nil } }
	}
	z := new_zval()
	unsafe {
		mut p := &usize(&z.value)
		p_src := &usize(&v.raw.value)
		*p = *p_src
		z.u1.type_info = v.raw.u1.type_info
		typ := v.raw.u1.type_info & 0xff
		if typ == 6 {
			p_str := &voidptr(&v.raw.value)
			str_ptr := *p_str
			if str_ptr != 0 {
				ref_ptr := &u32(str_ptr)
				(*ref_ptr)++
			}
		}
	}
	return PhpVal{ raw: z }
}

// clone 是 dup 的别名，用于统一 .clone() 调用语法（V 原生数组/映射也用 .clone()）
pub fn (v PhpVal) clone() PhpVal {
	return v.dup()
}


pub type PhpKey = string | int | i64 | PhpVal
pub type PhpArg = string | int | i64 | bool | f64 | PhpVal

pub fn (k PhpKey) to_php_val() PhpVal {
	match k {
		PhpVal { return k }
		int { return new_int(k) }
		i64 { return new_int(k) }
		string { return new_string(k) }
	}
}

pub fn (a PhpArg) to_php_val() PhpVal {
	match a {
		PhpVal { return a }
		int { return new_int(a) }
		i64 { return new_int(a) }
		string { return new_string(a) }
		bool { return new_bool(a) }
		f64 { return new_float(a) }
	}
}

// ArrayItem 表示数组字面量的一个键值项
pub struct ArrayItem {
pub:
	key ?PhpKey
	val PhpArg
}

// new_array 创建一个空的 PHP 数组 zval（纯 V 实现）
pub fn new_array() PhpVal {
	mut z := new_zval()
	pa := PhpArray.new()
	pa.store_in_zval(z)
	z.u1.type_info = 7 // IS_ARRAY
	return PhpVal{ raw: z }
}

// create_array 从数组字面量项构建完整的 PHP 数组（纯 V 实现）
pub fn create_array(items []ArrayItem) PhpVal {
	mut z := new_zval()
	pa := PhpArray.from_items(items)
	pa.store_in_zval(z)
	z.u1.type_info = 7 // IS_ARRAY
	return PhpVal{ raw: z }
}

// create_array_from_list 从 PhpVal 列表中快速构建带有顺序数字键的 PHP 数组
pub fn create_array_from_list(vals []PhpVal) PhpVal {
	mut items := []ArrayItem{}
	for val in vals {
		items << ArrayItem{
			key: none
			val: val
		}
	}
	return create_array(items)
}

pub fn create_array_from_list_string(vals []string) PhpVal {
	mut items := []ArrayItem{}
	for val in vals {
		items << ArrayItem{
			key: none
			val: new_string(val)
		}
	}
	return create_array(items)
}

pub fn create_array_from_list_int(vals []i64) PhpVal {
	mut items := []ArrayItem{}
	for val in vals {
		items << ArrayItem{
			key: none
			val: new_int(val)
		}
	}
	return create_array(items)
}

pub fn create_array_from_list_float(vals []f64) PhpVal {
	mut items := []ArrayItem{}
	for val in vals {
		items << ArrayItem{
			key: none
			val: new_float(val)
		}
	}
	return create_array(items)
}

pub fn create_array_from_list_bool(vals []bool) PhpVal {
	mut items := []ArrayItem{}
	for val in vals {
		items << ArrayItem{
			key: none
			val: new_bool(val)
		}
	}
	return create_array(items)
}

// create_array_from_native_map 将 V 原生 map[string]PhpVal 转为 PHP 数组 PhpVal
pub fn create_array_from_native_map(m map[string]PhpVal) PhpVal {
	mut items := []ArrayItem{}
	for key, val in m {
		items << ArrayItem{
			key: PhpKey(key)
			val: val
		}
	}
	return create_array(items)
}

pub fn create_array_from_native_map_string(m map[string]string) PhpVal {
	mut items := []ArrayItem{}
	for key, val in m {
		items << ArrayItem{
			key: PhpKey(key)
			val: new_string(val)
		}
	}
	return create_array(items)
}

pub fn create_array_from_native_map_int(m map[string]i64) PhpVal {
	mut items := []ArrayItem{}
	for key, val in m {
		items << ArrayItem{
			key: PhpKey(key)
			val: new_int(val)
		}
	}
	return create_array(items)
}

pub fn create_array_from_native_map_float(m map[string]f64) PhpVal {
	mut items := []ArrayItem{}
	for key, val in m {
		items << ArrayItem{
			key: PhpKey(key)
			val: new_float(val)
		}
	}
	return create_array(items)
}

pub fn create_array_from_native_map_bool(m map[string]bool) PhpVal {
	mut items := []ArrayItem{}
	for key, val in m {
		items << ArrayItem{
			key: PhpKey(key)
			val: new_bool(val)
		}
	}
	return create_array(items)
}

// func_array_keys 纯 V 语言版的 array_keys 键获取实现（避免跨越 FFI 边界）
pub fn func_array_keys(v PhpVal) PhpVal {
	if !v.is_array() { return new_array() }
	pa := unsafe { extract_from_zval(v.raw) }
	mut keys := []PhpVal{}
	for bucket in pa.buckets {
		match bucket.key_kind {
			.int_key { keys << new_int(bucket.ikey) }
			.str_key { keys << new_string(bucket.skey) }
			else {}
		}
	}
	return create_array_from_list(keys)
}

// array_set 根据键更新或设置数组项（纯 V 实现）
pub fn (v PhpVal) array_set(key PhpKey, val PhpArg) {
	if !v.is_array() { return }
	mut pa := unsafe { extract_from_zval(v.raw) }
	pa.set(key.to_php_val(), val.to_php_val())
}

// array_push 向数组末尾追加元素（纯 V 实现）
pub fn (v PhpVal) array_push(val PhpArg) {
	if !v.is_array() { return }
	mut pa := unsafe { extract_from_zval(v.raw) }
	pa.push(val.to_php_val())
}

// array_push_mut 向数组末尾追加一个空数组，并返回该新数组的可变引用（用于嵌套空维追加如 $arr[][] = $val）
pub fn (mut v PhpVal) array_push_mut() PhpVal {
	if !v.is_array() {
		mut pa_self := PhpArray.new()
		pa_self.store_in_zval(v.raw)
		v.raw.u1.type_info = 7
	}
	mut pa := unsafe { extract_from_zval(v.raw) }
	empty_arr := new_array()
	pa.push(empty_arr)
	return empty_arr
}

// array_get 从数组中获取指定键对应的元素（纯 V 实现）
pub fn (v PhpVal) array_get(key PhpKey) PhpVal {
	if !v.is_array() { return new_null() }
	pa := unsafe { extract_from_zval(v.raw) }
	return pa.get(key.to_php_val())
}

// array_get_mut 获取指定键对应的元素的可变引用（如果不存在或不是数组，则自动就地初始化为空数组，实现 Auto-vivification）
pub fn (mut v PhpVal) array_get_mut(key PhpKey) PhpVal {
	if !v.is_array() {
		mut pa_self := PhpArray.new()
		pa_self.store_in_zval(v.raw)
		v.raw.u1.type_info = 7
	}
	mut pa := unsafe { extract_from_zval(v.raw) }
	k_val := key.to_php_val()
	if !pa.isset(k_val) {
		empty_arr := new_array()
		pa.set(k_val, empty_arr)
		return empty_arr
	}
	mut sub_val := pa.get(k_val)
	if !sub_val.is_array() {
		mut pa_sub := PhpArray.new()
		pa_sub.store_in_zval(sub_val.raw)
		sub_val.raw.u1.type_info = 7
	}
	return sub_val
}

// array_get_mut_nested 递归获取多维数组的最后一层，并在必要时自动就地初始化，支持链式写操作
pub fn (v PhpVal) array_get_mut_nested(keys []PhpVal) PhpVal {
	mut current := v
	for key in keys {
		current = current.array_get_mut(key)
	}
	return current
}

// array_isset 检查数组中指定键是否存在且值非 null（纯 V 实现）
pub fn (v PhpVal) array_isset(key PhpKey) bool {
	if !v.is_array() { return false }
	pa := unsafe { extract_from_zval(v.raw) }
	return pa.isset(key.to_php_val())
}

// array_unset 删除数组中指定键对应的元素（纯 V 实现，标记为墓碑）
pub fn (v PhpVal) array_unset(key PhpKey) {
	if !v.is_array() { return }
	mut pa := unsafe { extract_from_zval(v.raw) }
	pa.del(key.to_php_val())
}

// ArrayIterator 包装了对 PHP 数组的外部迭代状态（纯 V 实现）
pub struct ArrayIterator {
pub mut:
	arr   PhpVal
	index int
	limit int
}

pub struct IterItem {
pub:
	key PhpVal
	val PhpVal
}

pub fn (v PhpVal) iterator() ArrayIterator {
	if !v.is_array() {
		return ArrayIterator{ arr: v, index: 0, limit: 0 }
	}
	pa := unsafe { extract_from_zval(v.raw) }
	return ArrayIterator{
		arr:   v
		index: 0
		limit: pa.buckets.len
	}
}

pub fn (mut it ArrayIterator) next() ?IterItem {
	if it.index >= it.limit { return none }
	pa := unsafe { extract_from_zval(it.arr.raw) }
	for it.index < it.limit {
		idx := it.index
		it.index++
		bucket := pa.buckets[idx]
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

// IPhpObject 接口，提供动态的多态方法/属性路由契约
pub interface IPhpObject {
mut:
	dispatch_method(method_name string, args []PhpVal) ?PhpVal
	dispatch_get_prop(prop_name string) ?PhpVal
	dispatch_set_prop(prop_name string, val PhpVal) bool
	has_method(method_name string) bool
	has_property(prop_name string) bool
}

// PhpObjectBase 结构体可作为 PHP 类的通用嵌入基类，提供默认实现以隐式实现 IPhpObject
pub struct PhpObjectBase {
pub mut:
	dynamic_props map[string]PhpVal
}

pub fn (mut this PhpObjectBase) dispatch_method(method_name string, args []PhpVal) ?PhpVal {
	return none
}

pub fn (this &PhpObjectBase) dispatch_get_prop(prop_name string) ?PhpVal {
	if prop_name in this.dynamic_props {
		return this.dynamic_props[prop_name] or { new_null() }
	}
	return none
}

pub fn (mut this PhpObjectBase) dispatch_set_prop(prop_name string, val PhpVal) bool {
	if this.dynamic_props.len == 0 {
		unsafe {
			mut self := &PhpObjectBase(&this)
			self.dynamic_props = map[string]PhpVal{}
		}
	}
	unsafe {
		mut self := &PhpObjectBase(&this)
		self.dynamic_props[prop_name] = val
	}
	return true
}

pub fn (mut this PhpObjectBase) has_method(method_name string) bool {
	return false
}

pub fn (mut this PhpObjectBase) has_property(prop_name string) bool {
	return prop_name in this.dynamic_props
}

pub const magic_php_object = u64(0x56504850585F4F42)

// PhpObject 承载 AOT 中的 PHP 对象
pub struct PhpObject {
pub mut:
	magic      u64
	class_name string
	parents    []string
	obj        IPhpObject
}

// new_object 将实现 IPhpObject 接口的结构体及类名封装为弱类型的 PhpVal
pub fn new_object(class_name string, parents []string, obj IPhpObject) PhpVal {
	z := new_zval()
	unsafe {
		mut p_obj := &PhpObject(malloc(int(sizeof(PhpObject))))
		p_obj.magic = magic_php_object
		p_obj.class_name = class_name
		p_obj.parents = parents
		p_obj.obj = obj
		
		mut p := &voidptr(&z.value)
		*p = p_obj
		z.u1.type_info = 8 // IS_OBJECT
	}
	return PhpVal{ raw: z }
}

// call_zend_callable 底层利用 Zend 引擎动态调用任何可调用对象 (zval)
pub fn call_zend_callable(cb PhpVal, args []PhpVal) PhpVal {
	z := new_zval()
	mut raw_args := []&C.zval{}
	for a in args {
		raw_args << a.raw
	}
	unsafe {
		res := C.php2v_call_zend_callable(cb.raw, z, u32(args.len), raw_args.data)
		if res == 0 {
			return PhpVal{ raw: z }
		}
		free(z)
	}
	return new_null()
}

// call_method 公共运行时分发器，基于 IPhpObject 接口实现多态派发
pub fn call_method(obj PhpVal, method_name string, args []PhpVal) PhpVal {
	if !obj.is_object() { return new_null() }
	mut obj_info := obj.get_object()
	if voidptr(obj_info) == 0 {
		z := new_zval()
		mut raw_args := []&C.zval{}
		for a in args {
			raw_args << a.raw
		}
		C.php2v_call_method(obj.raw, method_name.str, usize(method_name.len), z, u32(args.len), raw_args.data)
		return PhpVal{ raw: z }
	}
	return obj_info.obj.dispatch_method(method_name, args) or { new_null() }
}

// get_property 公共运行时分发器
pub fn get_property(obj PhpVal, prop_name string) PhpVal {
	if !obj.is_object() { return new_null() }
	mut obj_info := obj.get_object()
	if voidptr(obj_info) == 0 {
		return new_null()
	}
	return obj_info.obj.dispatch_get_prop(prop_name) or { new_null() }
}

// set_property 公共运行时分发器
pub fn set_property(obj PhpVal, prop_name string, val PhpVal) {
	if !obj.is_object() { return }
	mut obj_info := obj.get_object()
	if voidptr(obj_info) == 0 {
		return
	}
	obj_info.obj.dispatch_set_prop(prop_name, val)
}

pub fn (v PhpVal) is_object() bool {
	return v.raw != 0 && (v.raw.u1.type_info & 0xff) == 8
}

pub fn (v PhpVal) get_object() &PhpObject {
	unsafe {
		if !v.is_object() { return &PhpObject(nil) }
		p_ptr := &voidptr(&v.raw.value)
		p := *p_ptr
		if p == 0 { return &PhpObject(nil) }
		p_obj := &PhpObject(p)
		if p_obj.magic == magic_php_object {
			return p_obj
		}
		return &PhpObject(nil)
	}
}

pub fn cast_object_ptr[T](v PhpVal) &T {
	mut obj_info := v.get_object()
	if voidptr(obj_info) == 0 {
		return unsafe { &T(nil) }
	}
	if obj_info.obj is &T {
		return obj_info.obj as &T
	}
	return unsafe { &T(nil) }
}

// array_to_object PHP (object) cast: 将 PhpVal 数组转为 stdClass 对象
pub fn array_to_object(val PhpVal) PhpVal {
	if val.is_object() {
		return val
	}
	mut base := PhpObjectBase{}
	if val.is_array() {
		mut iter := val.iterator()
		for {
			item := iter.next() or { break }
			key_str := item.key.str()
			base.dispatch_set_prop(key_str, item.val)
		}
	} else if !val.is_null() {
		base.dispatch_set_prop('0', val)
	}
	return new_object('stdClass', []string{}, base)
}

// Closure support: store V native fn as PhpVal
pub const magic_php_closure = u64(0x56504850585F434C) // 'VHPX_CL'

pub struct PhpClosure {
pub mut:
	magic   u64
	this_ptr PhpVal  // 绑定的 this 对象（可以是 new_null()）
	invoke  fn (PhpVal, []PhpVal) PhpVal = unsafe { nil }
}

// new_closure 将 V 原生 fn 封装为 PhpVal
pub fn new_closure(invoke fn (PhpVal, []PhpVal) PhpVal) PhpVal {
	z := new_zval()
	unsafe {
		mut p_closure := &PhpClosure(malloc(int(sizeof(PhpClosure))))
		p_closure.magic = magic_php_closure
		p_closure.this_ptr = new_null()
		p_closure.invoke = invoke
		
		mut p := &voidptr(&z.value)
		*p = p_closure
		z.u1.type_info = 9 // IS_CLOSURE (custom type)
	}
	return PhpVal{ raw: z }
}

pub fn (v PhpVal) is_closure() bool {
	return v.raw != 0 && (v.raw.u1.type_info & 0xff) == 9
}

pub fn (v PhpVal) get_closure() &PhpClosure {
	unsafe {
		if !v.is_closure() { return &PhpClosure(nil) }
		p_ptr := &voidptr(&v.raw.value)
		p := *p_ptr
		if p == 0 { return &PhpClosure(nil) }
		p_closure := &PhpClosure(p)
		if p_closure.magic == magic_php_closure {
			return p_closure
		}
		return &PhpClosure(nil)
	}
}

// call_closure_val 直接调用闭包 fn
pub fn call_closure_val(cb PhpVal, args []PhpVal) PhpVal {
	if !cb.is_closure() { return new_null() }
	closure := cb.get_closure()
	if closure == unsafe { nil } || closure.invoke == unsafe { nil } {
		return new_null()
	}
	return closure.invoke(closure.this_ptr, args)
}

// json_encode 将 PhpVal 转换为 JSON 字符串（纯 V 实现，无需调用 PHP）
pub fn json_encode(v PhpVal) string {
	if v.raw == 0 {
		return 'null'
	}
	typ := unsafe { v.raw.u1.type_info & 0xff }
	return match typ {
		1 { 'null' } // IS_NULL
		2 { 'false' } // IS_FALSE
		3 { 'true' } // IS_TRUE
		4 { v.to_string() } // IS_LONG
		5 { v.to_string() } // IS_DOUBLE
		6 { json_encode_string(v.to_string()) } // IS_STRING
		7 { json_encode_array(v) } // IS_ARRAY
		else { 'null' }
	}
}

fn json_encode_string(s string) string {
	mut sb := strings.new_builder(s.len + 2)
	sb.write_u8(`"`)
	for c in s.bytes() {
		match c {
			`"` { sb.write_string('\\"') }
			`\\` { sb.write_string('\\\\') }
			`\n` { sb.write_string('\\n') }
			`\r` { sb.write_string('\\r') }
			`\t` { sb.write_string('\\t') }
			else {
				if c < 0x20 {
					sb.write_string('\\u${c:02x}')
				} else {
					sb.write_u8(c)
				}
			}
		}
	}
	sb.write_u8(`"`)
	return sb.str()
}

fn json_encode_array(v PhpVal) string {
	pa := unsafe { extract_from_zval(v.raw) }
	if pa.buckets.len == 0 {
		return '[]'
	}
	// 判断是 JSON 数组还是对象：所有键都是连续整数 0,1,2...
	mut is_list := true
	mut expected_idx := i64(0)
	for bucket in pa.buckets {
		if bucket.key_kind == .deleted {
			continue
		}
		if bucket.key_kind != .int_key || bucket.ikey != expected_idx {
			is_list = false
			break
		}
		expected_idx++
	}
	mut sb := strings.new_builder(64)
	if is_list {
		sb.write_u8(`[`)
		mut first := true
		for bucket in pa.buckets {
			if bucket.key_kind == .deleted {
				continue
			}
			if !first {
				sb.write_u8(`,`)
			}
			first = false
			sb.write_string(json_encode(bucket.val))
		}
		sb.write_u8(`]`)
	} else {
		sb.write_u8(`{`)
		mut first := true
		for bucket in pa.buckets {
			if bucket.key_kind == .deleted {
				continue
			}
			if !first {
				sb.write_u8(`,`)
			}
			first = false
			key_str := if bucket.key_kind == .str_key {
				json_encode_string(bucket.skey)
			} else {
				'${bucket.ikey}'
			}
			sb.write_string('${key_str}:${json_encode(bucket.val)}')
		}
		sb.write_u8(`}`)
	}
	return sb.str()
}

// Exception & Superglobal FFI Bindings
fn C.php2v_has_exception() int
fn C.php2v_get_and_clear_exception(retval &C.zval)
fn C.php2v_throw_exception_object(ex &C.zval)
fn C.php2v_get_superglobal(name &char, len usize, retval &C.zval) int
fn C.php2v_register_global(name &char, len usize, val &C.zval)
fn C.php2v_instance_of(obj &C.zval, class_name &char, len usize) int
fn C.php2v_call_method(obj &C.zval, name &char, len usize, retval &C.zval, param_count u32, params voidptr) int
fn C.php2v_get_current_ctx() voidptr
fn C.php2v_set_current_ctx(ctx voidptr)
fn C.php2v_zstr_val(zstr voidptr) &char
fn C.php2v_zstr_len(zstr voidptr) usize

pub fn has_exception() bool {
	return C.php2v_has_exception() != 0
}

pub fn get_and_clear_exception() PhpVal {
	z := new_zval()
	C.php2v_get_and_clear_exception(z)
	return PhpVal{ raw: z }
}

pub fn throw_exception(ex PhpVal) {
	C.php2v_throw_exception_object(ex.raw)
}

pub fn get_superglobal(name string) PhpVal {
	z := new_zval()
	C.php2v_get_superglobal(name.str, usize(name.len), z)
	return PhpVal{ raw: z }
}

pub fn register_global(name string, val PhpVal) {
	C.php2v_register_global(name.str, usize(name.len), val.raw)
}

pub fn instance_of(obj PhpVal, class_name string) bool {
	if !obj.is_object() { return false }
	mut obj_info := obj.get_object()
	if voidptr(obj_info) == 0 {
		return C.php2v_instance_of(obj.raw, class_name.str, usize(class_name.len)) != 0
	}
	if obj_info.class_name == class_name {
		return true
	}
	for parent in obj_info.parents {
		if parent == class_name {
			return true
		}
	}
	return false
}

pub fn post_inc(v PhpVal) PhpVal {
	old := v.dup()
	unsafe {
		C.increment_function(v.raw)
	}
	return old
}

pub fn post_dec(v PhpVal) PhpVal {
	old := v.dup()
	unsafe {
		C.decrement_function(v.raw)
	}
	return old
}

pub fn pre_inc(v PhpVal) PhpVal {
	unsafe {
		C.increment_function(v.raw)
	}
	return v
}

pub fn pre_dec(v PhpVal) PhpVal {
	unsafe {
		C.decrement_function(v.raw)
	}
	return v
}

pub fn bitwise_and(a PhpVal, b PhpVal) PhpVal {
	z := new_zval()
	unsafe {
		C.bitwise_and_function(z, a.raw, b.raw)
	}
	return PhpVal{ raw: z }
}

pub fn bitwise_or(a PhpVal, b PhpVal) PhpVal {
	z := new_zval()
	unsafe {
		C.bitwise_or_function(z, a.raw, b.raw)
	}
	return PhpVal{ raw: z }
}

pub fn bitwise_xor(a PhpVal, b PhpVal) PhpVal {
	z := new_zval()
	unsafe {
		C.bitwise_xor_function(z, a.raw, b.raw)
	}
	return PhpVal{ raw: z }
}

pub fn shift_left(a PhpVal, b PhpVal) PhpVal {
	z := new_zval()
	unsafe {
		C.shift_left_function(z, a.raw, b.raw)
	}
	return PhpVal{ raw: z }
}

pub fn shift_right(a PhpVal, b PhpVal) PhpVal {
	z := new_zval()
	unsafe {
		C.shift_right_function(z, a.raw, b.raw)
	}
	return PhpVal{ raw: z }
}

pub fn bitwise_not(a PhpVal) PhpVal {
	z := new_zval()
	unsafe {
		C.bitwise_not_function(z, a.raw)
	}
	return PhpVal{ raw: z }
}

pub fn create_array_from_list_with_base(base []PhpVal, extra []PhpVal) PhpVal {
	mut arr := new_array()
	for v in base {
		arr.array_push(v)
	}
	for v in extra {
		arr.array_push(v)
	}
	return arr
}

pub fn func_get_arg_helper(extra []PhpVal, idx PhpVal) PhpVal {
	i := idx.to_i64()
	if i >= 0 && i < extra.len {
		return extra[i].clone()
	}
	return new_null()
}

pub fn func_get_arg_helper_with_base(base []PhpVal, extra []PhpVal, idx PhpVal) PhpVal {
	i := idx.to_i64()
	if i >= 0 && i < base.len {
		return base[i].clone()
	}
	offset := i - base.len
	if offset >= 0 && offset < extra.len {
		return extra[offset].clone()
	}
	return new_null()
}

pub fn is_null(v PhpVal) bool {
	return v.is_null()
}

pub fn ternary(cond bool, if_val PhpVal, else_val PhpVal) PhpVal {
	if cond {
		return if_val
	} else {
		return else_val
	}
}

pub fn coalesce(left PhpVal, right PhpVal) PhpVal {
	if left.raw != 0 && (left.raw.u1.type_info & 0xff) != 1 {
		return left
	}
	return right
}

pub fn ternary_string(cond bool, if_val string, else_val string) string {
	if cond {
		return if_val
	} else {
		return else_val
	}
}

pub fn ternary_int(cond bool, if_val i64, else_val i64) i64 {
	if cond {
		return if_val
	} else {
		return else_val
	}
}
