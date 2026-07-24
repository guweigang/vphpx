module rt

import os

pub type HybridDispatcherFn = fn (string, []PhpVal) PhpVal

fn get_set_hybrid_dispatcher(f ?HybridDispatcherFn, is_set bool) ?HybridDispatcherFn {
	unsafe {
		mut static dispatcher := ?HybridDispatcherFn(none)
		if is_set {
			dispatcher = f
		}
		return dispatcher
	}
}

pub fn register_hybrid_dispatcher(f HybridDispatcherFn) {
	get_set_hybrid_dispatcher(f, true)
}

// call_function 调度 PHP 函数调用
pub fn call_function(name string, args []PhpVal) PhpVal {
	fn_name := name.to_lower()
	if fn_name.contains('::') {
		if dispatcher := get_set_hybrid_dispatcher(none, false) {
			return dispatcher(name, args)
		}
		return new_null()
	}
	match fn_name {
		'define' {
			if args.len >= 2 {
				cname := args[0].to_string()
				cval := args[1]
				register_constant(cname, cval)
				return new_bool(true)
			}
			return new_bool(false)
		}
		'defined' {
			if args.len >= 1 {
				cname := args[0].to_string()
				return new_bool(has_constant(cname))
			}
			return new_bool(false)
		}
		'get_class' {
			if args.len > 0 && args[0].is_object() {
				obj := args[0]
				obj_ptr := obj.get_object()
				if voidptr(obj_ptr) != unsafe { nil } {
					return new_string(obj_ptr.class_name)
				}
			}
			return call_zend_function(name, args)
		}
		'get_parent_class' {
			if args.len > 0 {
				obj := args[0]
				if obj.is_object() {
					obj_ptr := obj.get_object()
					if voidptr(obj_ptr) != unsafe { nil } {
						if obj_ptr.parents.len > 0 {
							return new_string(obj_ptr.parents[0])
						}
						return new_bool(false)
					}
				} else if obj.is_string() {
					class_name := obj.to_string()
					if parent := get_class_parent_name(class_name) {
						return new_string(parent)
					}
					return new_bool(false)
				}
			}
			return call_zend_function(name, args)
		}
		'is_a' {
			if args.len > 1 {
				obj := args[0]
				class_name := args[1].to_string()
				allow_string := if args.len > 2 { args[2].to_bool() } else { false }
				if obj.is_object() {
					obj_ptr := obj.get_object()
					if voidptr(obj_ptr) != unsafe { nil } {
						lower_class := class_name.to_lower()
						if obj_ptr.class_name.to_lower() == lower_class {
							return new_bool(true)
						}
						for p in obj_ptr.parents {
							if p.to_lower() == lower_class {
								return new_bool(true)
							}
						}
						return new_bool(false)
					}
				} else if allow_string && obj.is_string() {
					subj_name := obj.to_string()
					lower_class := class_name.to_lower()
					if subj_name.to_lower() == lower_class {
						return new_bool(true)
					}
					if is_subclass_of_by_name(subj_name, class_name) {
						return new_bool(true)
					}
					return new_bool(false)
				}
			}
			return call_zend_function(name, args)
		}
		'is_subclass_of' {
			if args.len > 1 {
				obj := args[0]
				class_name := args[1].to_string()
				allow_string := if args.len > 2 { args[2].to_bool() } else { true }
				if obj.is_object() {
					obj_ptr := obj.get_object()
					if voidptr(obj_ptr) != unsafe { nil } {
						lower_class := class_name.to_lower()
						for p in obj_ptr.parents {
							if p.to_lower() == lower_class {
								return new_bool(true)
							}
						}
						return new_bool(false)
					}
				} else if allow_string && obj.is_string() {
					subj_name := obj.to_string()
					if is_subclass_of_by_name(subj_name, class_name) {
						return new_bool(true)
					}
					return new_bool(false)
				}
			}
			return call_zend_function(name, args)
		}
		'method_exists' {
			if args.len > 1 {
				obj := args[0]
				method_name := args[1].to_string()
				if obj.is_object() {
					obj_ptr := obj.get_object()
					if voidptr(obj_ptr) != unsafe { nil } {
						mut obj_impl := obj_ptr.obj
						return new_bool(obj_impl.has_method(method_name))
					}
				} else if obj.is_string() {
					class_name := obj.to_string()
					return new_bool(class_has_method(class_name, method_name))
				}
			}
			return call_zend_function(name, args)
		}
		'property_exists' {
			if args.len > 1 {
				obj := args[0]
				prop_name := args[1].to_string()
				if obj.is_object() {
					obj_ptr := obj.get_object()
					if voidptr(obj_ptr) != unsafe { nil } {
						mut obj_impl := obj_ptr.obj
						return new_bool(obj_impl.has_property(prop_name))
					}
				} else if obj.is_string() {
					class_name := obj.to_string()
					return new_bool(class_has_property(class_name, prop_name))
				}
			}
			return call_zend_function(name, args)
		}
		'spl_object_hash' {
			if args.len > 0 && args[0].is_object() {
				obj := args[0]
				obj_ptr := obj.get_object()
				if voidptr(obj_ptr) != unsafe { nil } {
					ptr_val := u64(voidptr(obj_ptr))
					hex_str := ptr_val.hex()
					padded := '0000000000000000' + hex_str
					return new_string(padded)
				}
			}
			return call_zend_function(name, args)
		}
		'strlen' {
			if args.len > 0 {
				return new_int(args[0].to_string().len)
			}
			return new_int(0)
		}
		'strtoupper' {
			if args.len > 0 {
				return new_string(args[0].to_string().to_upper())
			}
			return new_string('')
		}
		'strtolower' {
			if args.len > 0 {
				return new_string(args[0].to_string().to_lower())
			}
			return new_string('')
		}
		'count' {
			if args.len > 0 {
				if args[0].is_array() {
					return new_int(args[0].array_count())
				}
				if args[0].is_null() {
					return new_int(0)
				}
				return new_int(1)
			}
			return new_int(0)
		}
		'eval' {
			if args.len > 0 {
				z_ret := new_zval()
				code_str := args[0].to_string()
				unsafe {
					res := C.php2v_eval_string(code_str.str, usize(code_str.len), z_ret)
					if res == 0 {
						return PhpVal{ raw: z_ret }
					}
					free(z_ret)
				}
			}
			return new_null()
		}
		'current' {
			if args.len >= 1 && args[0].is_array() {
				pa := extract_from_zval(args[0].raw)
				return pa.current()
			}
			return new_bool(false)
		}
		'next' {
			if args.len >= 1 && args[0].is_array() {
				mut pa := unsafe { &PhpArray(voidptr(extract_from_zval(args[0].raw))) }
				unsafe {
					return pa.next()
				}
			}
			return new_bool(false)
		}
		'prev' {
			if args.len >= 1 && args[0].is_array() {
				mut pa := unsafe { &PhpArray(voidptr(extract_from_zval(args[0].raw))) }
				unsafe {
					return pa.prev()
				}
			}
			return new_bool(false)
		}
		'reset' {
			if args.len >= 1 && args[0].is_array() {
				mut pa := unsafe { &PhpArray(voidptr(extract_from_zval(args[0].raw))) }
				unsafe {
					return pa.reset()
				}
			}
			return new_bool(false)
		}
		'end' {
			if args.len >= 1 && args[0].is_array() {
				mut pa := unsafe { &PhpArray(voidptr(extract_from_zval(args[0].raw))) }
				unsafe {
					return pa.end()
				}
			}
			return new_bool(false)
		}
		'key' {
			if args.len >= 1 && args[0].is_array() {
				pa := extract_from_zval(args[0].raw)
				return pa.key()
			}
			return new_null()
		}
		'array_unshift' {
			if args.len >= 2 && args[0].is_array() {
				mut pa := unsafe { &PhpArray(voidptr(extract_from_zval(args[0].raw))) }
				for i := args.len - 1; i >= 1; i-- {
					unsafe {
						pa.unshift(args[i])
					}
				}
				return new_int(pa.count())
			}
			return new_int(0)
		}
		'array_shift' {
			if args.len >= 1 && args[0].is_array() {
				mut pa := unsafe { &PhpArray(voidptr(extract_from_zval(args[0].raw))) }
				unsafe {
					return pa.shift()
				}
			}
			return new_null()
		}
		'array_push' {
			if args.len >= 2 && args[0].is_array() {
				mut pa := unsafe { &PhpArray(voidptr(extract_from_zval(args[0].raw))) }
				for i := 1; i < args.len; i++ {
					unsafe {
						pa.push(args[i])
					}
				}
				return new_int(pa.count())
			}
			return new_int(0)
		}
		'array_pop' {
			if args.len >= 1 && args[0].is_array() {
				mut pa := unsafe { &PhpArray(voidptr(extract_from_zval(args[0].raw))) }
				unsafe {
					return pa.pop()
				}
			}
			return new_null()
		}
		'array_merge' {
			mut res_pa := PhpArray.new()
			for arg in args {
				if arg.is_array() {
					other := extract_from_zval(arg.raw)
					res_pa = res_pa.merge(other)
				}
			}
			mut z := new_zval()
			res_pa.store_in_zval(z)
			z.u1.type_info = 7 // IS_ARRAY
			return PhpVal{ raw: z }
		}
		'call_user_func' {
			if args.len > 0 {
				cb := args[0]
				cb_args := args[1..]
				return call_callable(cb, cb_args)
			}
			return new_null()
		}
		'call_user_func_array' {
			if args.len > 0 {
				cb := args[0]
				mut cb_args := []PhpVal{}
				if args.len > 1 && args[1].is_array() {
					pa := unsafe { extract_from_zval(args[1].raw) }
					mut it := pa.iter()
					for {
						item := it.next_iter() or { break }
						cb_args << item.val
					}
				}
				return call_callable(cb, cb_args)
			}
			return new_null()
		}
		else {
			// 通用动态内置函数绑定
			z_ret := new_zval()
			mut z_args := []&C.zval{}
			for arg in args {
				z_args << arg.raw
			}
			unsafe {
				res := C.php2v_call_zend_function(name.str, usize(name.len), z_ret, u32(args.len), z_args.data)
				if res == 0 { // SUCCESS
					return PhpVal{ raw: z_ret }
				}
				free(z_ret)
			}
			eprintln('Warning: calling unsupported function: ${name}')
			return new_null()
		}
	}
}

pub fn include_file(path string, incl_type string) PhpVal {
	normalized := os.real_path(path)
	
	// incl_type 映射：
	// '1' = include
	// '2' = include_once
	// '3' = require
	// '4' = require_once
	
	is_once := incl_type == '2' || incl_type == '4'
	
	if is_once && is_included(normalized) {
		return new_int(1)
	}
	
	mut r := get_registry()
	if normalized in r.include_registry {
		mark_included(normalized)
		func_to_run := r.include_registry[normalized]
		return func_to_run()
	}
	
	mark_included(normalized)
	unsafe {
		_ = C.php2v_execute_file(path.str)
	}
	return new_int(1)
}

// define_constant 在运行时定义用户空间常量
pub fn define_constant(name string, val PhpVal) {
	unsafe {
		C.php2v_register_constant(name.str, usize(name.len), val.raw)
	}
}

// get_constant 在运行时获取常量值，若未定义会抛出 PHP 异常并返回 null
pub fn get_constant(name string) PhpVal {
	if has_constant(name) {
		return get_v_constant(name)
	}
	z_ret := new_zval()
	unsafe {
		res := C.php2v_get_constant(name.str, usize(name.len), z_ret)
		if res == 1 {
			return PhpVal{ raw: z_ret }
		}
		free(z_ret)
	}
	return new_null()
}

// call_zend_function 动态在全局函数表中查找并调用函数
pub fn call_zend_function(name string, args []PhpVal) PhpVal {
	z_ret := new_zval()
	mut z_args := []&C.zval{}
	for arg in args {
		z_args << arg.raw
	}
	unsafe {
		res := C.php2v_call_zend_function(name.str, usize(name.len), z_ret, u32(args.len), z_args.data)
		if res == 0 {
			return PhpVal{ raw: z_ret }
		}
		free(z_ret)
	}
	return new_null()
}
