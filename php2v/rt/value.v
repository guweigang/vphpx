module rt

#include <php.h>

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
