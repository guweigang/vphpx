module rt

#include <php.h>

#include "rt_helper.h"

fn C.php2v_hash_get_entry(ht voidptr, index u32, val &&C.zval, key &&voidptr, num_key &u64) int
fn C.php2v_call_zend_function(name &char, name_len usize, retval &C.zval, param_count u32, params &&C.zval) int
fn C.php2v_eval_string(str &char, len usize, retval &C.zval) int
fn C.php2v_register_constant(name &char, len usize, val &C.zval) int
fn C.php2v_get_constant(name &char, len usize, val &C.zval) int

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

pub fn new_bool(b bool) PhpVal {
	z := new_zval()
	unsafe {
		z.u1.type_info = if b { u32(3) } else { u32(2) } // IS_TRUE / IS_FALSE
	}
	return PhpVal{ raw: z }
}

pub fn new_null() PhpVal {
	z := new_zval()
	unsafe {
		z.u1.type_info = 1 // IS_NULL
	}
	return PhpVal{ raw: z }
}

pub fn new_string(s string) PhpVal {
	z := new_zval()
	unsafe {
		str_ptr := C.zend_string_init(s.str, usize(s.len), false)
		mut p := &voidptr(&z.value)
		*p = str_ptr
		z.u1.type_info = 6 // IS_STRING
	}
	return PhpVal{ raw: z }
}

// to_string 零拷贝读取 Zend 字符串或转换标量值为 V 字符串
pub fn (v PhpVal) to_string() string {
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

// array_count 从 zend_array (zend_hash) 结构体中读取已使用的元素个数
pub fn (v PhpVal) array_count() int {
	unsafe {
		if !v.is_array() { return 0 }
		p_arr := &voidptr(&v.raw.value)
		arr_ptr := *p_arr
		if arr_ptr == 0 { return 0 }
		num_ptr := &u32(charptr(arr_ptr) + 28)
		return int(*num_ptr)
	}
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

// Zend 数组操作外部 C 函数声明
fn C.zend_new_array(size u32) voidptr
fn C.zend_hash_index_update(ht voidptr, h u64, pData voidptr) voidptr
fn C.zend_hash_str_update(ht voidptr, key &char, len usize, pData voidptr) voidptr
fn C.zend_hash_next_index_insert(ht voidptr, pData voidptr) voidptr
fn C.zend_hash_index_find(ht voidptr, h u64) &C.zval
fn C.zend_hash_str_find(ht voidptr, key &char, len usize) &C.zval

// ArrayItem 表示数组字面量的一个键值项
pub struct ArrayItem {
pub:
	key ?PhpVal
	val PhpVal
}

// new_array 创建一个空的 PHP 数组 zval
pub fn new_array() PhpVal {
	z := new_zval()
	unsafe {
		arr_ptr := C.zend_new_array(0)
		mut p := &voidptr(&z.value)
		*p = arr_ptr
		z.u1.type_info = 7 // IS_ARRAY
	}
	return PhpVal{ raw: z }
}

// create_array 接收项数组并构建完整的 PHP 关联或索引数组
pub fn create_array(items []ArrayItem) PhpVal {
	arr := new_array()
	for item in items {
		if k := item.key {
			arr.array_set(k, item.val)
		} else {
			arr.array_push(item.val)
		}
	}
	return arr
}

// array_set 根据键更新或设置数组项 (支持整数键和字符串键)
pub fn (v PhpVal) array_set(key PhpVal, val PhpVal) {
	unsafe {
		if !v.is_array() { return }
		p_arr := &voidptr(&v.raw.value)
		arr_ptr := *p_arr
		if arr_ptr == 0 { return }
		
		val_dup := val.dup()
		typ := key.raw.u1.type_info & 0xff
		if typ == 4 { // IS_LONG
			h := key.to_i64()
			C.zend_hash_index_update(arr_ptr, u64(h), val_dup.raw)
		} else {
			k_str := key.to_string()
			C.zend_hash_str_update(arr_ptr, k_str.str, usize(k_str.len), val_dup.raw)
		}
	}
}

// array_push 向数组末尾追加元素
pub fn (v PhpVal) array_push(val PhpVal) {
	unsafe {
		if !v.is_array() { return }
		p_arr := &voidptr(&v.raw.value)
		arr_ptr := *p_arr
		if arr_ptr == 0 { return }
		
		val_dup := val.dup()
		C.zend_hash_next_index_insert(arr_ptr, val_dup.raw)
	}
}

// array_get 从数组中获取指定键对应的元素
pub fn (v PhpVal) array_get(key PhpVal) PhpVal {
	unsafe {
		if !v.is_array() { return new_null() }
		p_arr := &voidptr(&v.raw.value)
		arr_ptr := *p_arr
		if arr_ptr == 0 { return new_null() }
		
		typ := key.raw.u1.type_info & 0xff
		mut res_zval := &C.zval(nil)
		if typ == 4 { // IS_LONG
			h := key.to_i64()
			res_zval = C.zend_hash_index_find(arr_ptr, u64(h))
		} else {
			k_str := key.to_string()
			res_zval = C.zend_hash_str_find(arr_ptr, k_str.str, usize(k_str.len))
		}
		
		if res_zval == 0 {
			return new_null()
		}
		return PhpVal{ raw: res_zval }.dup()
	}
}

// array_isset 检查数组中指定键对应的元素是否存在且不为 null
pub fn (v PhpVal) array_isset(key PhpVal) bool {
	unsafe {
		if !v.is_array() { return false }
		p_arr := &voidptr(&v.raw.value)
		arr_ptr := *p_arr
		if arr_ptr == 0 { return false }
		
		typ := key.raw.u1.type_info & 0xff
		mut res_zval := &C.zval(nil)
		if typ == 4 { // IS_LONG
			h := key.to_i64()
			res_zval = C.zend_hash_index_find(arr_ptr, u64(h))
		} else {
			k_str := key.to_string()
			res_zval = C.zend_hash_str_find(arr_ptr, k_str.str, usize(k_str.len))
		}
		
		if res_zval == 0 {
			return false
		}
		return (res_zval.u1.type_info & 0xff) != 1 // 1 is IS_NULL
	}
}

// ArrayIterator 包装了对 PHP 数组的外部迭代状态
pub struct ArrayIterator {
pub mut:
	arr   PhpVal
	index u32
	limit u32
}

pub struct IterItem {
pub:
	key PhpVal
	val PhpVal
}

pub fn (v PhpVal) iterator() ArrayIterator {
	unsafe {
		if !v.is_array() {
			return ArrayIterator{ arr: v, index: 0, limit: 0 }
		}
		p_arr := &voidptr(&v.raw.value)
		arr_ptr := *p_arr
		if arr_ptr == 0 {
			return ArrayIterator{ arr: v, index: 0, limit: 0 }
		}
		// HashTable 结构体中偏移 24 字节为已使用的 Bucket 数量 (nNumUsed)
		n_used_ptr := &u32(charptr(arr_ptr) + 24)
		return ArrayIterator{
			arr: v
			index: 0
			limit: *n_used_ptr
		}
	}
}

pub fn (mut it ArrayIterator) next() ?IterItem {
	unsafe {
		if it.index >= it.limit { return none }
		p_arr := &voidptr(&it.arr.raw.value)
		arr_ptr := *p_arr
		if arr_ptr == 0 { return none }
		
		mut val_zval := &C.zval(nil)
		mut key_zstr := voidptr(0)
		mut num_key := u64(0)
		
		for it.index < it.limit {
			curr_idx := it.index
			it.index++
			
			res := C.php2v_hash_get_entry(arr_ptr, curr_idx, &val_zval, &key_zstr, &num_key)
			if res == 1 {
				mut k := new_null()
				if key_zstr != 0 {
					len_ptr := &usize(charptr(key_zstr) + 16)
					val_ptr := charptr(key_zstr) + 24
					k = new_string(tos(val_ptr, int(*len_ptr)))
				} else {
					k = new_int(i64(num_key))
				}
				
				return IterItem{
					key: k
					val: PhpVal{ raw: val_zval }.dup()
				}
			}
		}
		return none
	}
}

// IPhpObject 接口，提供动态的多态方法/属性路由契约
pub interface IPhpObject {
mut:
	dispatch_method(method_name string, args []PhpVal) PhpVal
	dispatch_get_prop(prop_name string) PhpVal
	dispatch_set_prop(prop_name string, val PhpVal)
}

// PhpObjectBase 结构体可作为 PHP 类的通用嵌入基类，提供默认实现以隐式实现 IPhpObject
pub struct PhpObjectBase {}

pub fn (mut this PhpObjectBase) dispatch_method(method_name string, args []PhpVal) PhpVal {
	return new_null()
}

pub fn (this &PhpObjectBase) dispatch_get_prop(prop_name string) PhpVal {
	return new_null()
}

pub fn (mut this PhpObjectBase) dispatch_set_prop(prop_name string, val PhpVal) {}

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
	return obj_info.obj.dispatch_method(method_name, args)
}

// get_property 公共运行时分发器
pub fn get_property(obj PhpVal, prop_name string) PhpVal {
	if !obj.is_object() { return new_null() }
	mut obj_info := obj.get_object()
	if voidptr(obj_info) == 0 {
		return new_null()
	}
	return obj_info.obj.dispatch_get_prop(prop_name)
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

// Exception & Superglobal FFI Bindings
fn C.php2v_has_exception() int
fn C.php2v_get_and_clear_exception(retval &C.zval)
fn C.php2v_throw_exception_object(ex &C.zval)
fn C.php2v_get_superglobal(name &char, len usize, retval &C.zval) int
fn C.php2v_register_global(name &char, len usize, val &C.zval)
fn C.php2v_instance_of(obj &C.zval, class_name &char, len usize) int
fn C.php2v_call_method(obj &C.zval, name &char, len usize, retval &C.zval, param_count u32, params voidptr) int

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
