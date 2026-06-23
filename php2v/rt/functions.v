module rt

// call_function 调度 PHP 函数调用
pub fn call_function(name string, args []PhpVal) PhpVal {
	match name {
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
