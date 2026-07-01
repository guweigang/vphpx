import rt

pub fn Class_ParagonIE_Sodium_Core_Salsa20.rounds() i64 {
	return 20
}
struct Class_ParagonIE_Sodium_Core_Salsa20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_Salsa20.core_salsa20(var_in rt.PhpVal, var_k rt.PhpVal, var_c rt.PhpVal) string {
	mut var_in_mutated := var_in
	mut var_c_mutated := var_c
	if rt.is_true(rt.less(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.strlen(arg_0) }(var_k.dup()), rt.new_int(32))) {
		rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(rt.new_string('Key must be 32 bytes long'))))
	}
	if rt.is_true(rt.identical(var_c_mutated, rt.new_null())) {
		mut var_j0 := mut var_x0 := rt.new_int(rt.new_int(1634760805))
		mut var_j5 := mut var_x5 := rt.new_int(rt.new_int(857760878))
		mut var_j10 := mut var_x10 := rt.new_int(rt.new_int(2036477234))
		mut var_j15 := mut var_x15 := rt.new_int(rt.new_int(1797285236))
	} else {
		var_j0 = var_x0 = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_c_mutated.dup(), rt.new_int(0), rt.new_int(4)))
		var_j5 = var_x5 = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_c_mutated.dup(), rt.new_int(4), rt.new_int(4)))
		var_j10 = var_x10 = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_c_mutated.dup(), rt.new_int(8), rt.new_int(4)))
		var_j15 = var_x15 = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_c_mutated.dup(), rt.new_int(12), rt.new_int(4)))
	}
	mut var_j1 := mut var_x1 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_k.dup(), rt.new_int(0), rt.new_int(4)))
	mut var_j2 := mut var_x2 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_k.dup(), rt.new_int(4), rt.new_int(4)))
	mut var_j3 := mut var_x3 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_k.dup(), rt.new_int(8), rt.new_int(4)))
	mut var_j4 := mut var_x4 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_k.dup(), rt.new_int(12), rt.new_int(4)))
	mut var_j6 := mut var_x6 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_in_mutated.dup(), rt.new_int(0), rt.new_int(4)))
	mut var_j7 := mut var_x7 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_in_mutated.dup(), rt.new_int(4), rt.new_int(4)))
	mut var_j8 := mut var_x8 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_in_mutated.dup(), rt.new_int(8), rt.new_int(4)))
	mut var_j9 := mut var_x9 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_in_mutated.dup(), rt.new_int(12), rt.new_int(4)))
	mut var_j11 := mut var_x11 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_k.dup(), rt.new_int(16), rt.new_int(4)))
	mut var_j12 := mut var_x12 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_k.dup(), rt.new_int(20), rt.new_int(4)))
	mut var_j13 := mut var_x13 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_k.dup(), rt.new_int(24), rt.new_int(4)))
	mut var_j14 := mut var_x14 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_k.dup(), rt.new_int(28), rt.new_int(4)))
	{
		mut var_i := rt.new_int(Class_ParagonIE_Sodium_Core_Salsa20.rounds())
		for {
			if !(rt.is_true(rt.greater(var_i, rt.new_int(0)))) { break }
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_BitwiseXor
			// unsupported expression: Expr_AssignOp_Minus
		}
	}
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x0.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x1.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x2.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x3.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x4.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x5.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x6.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x7.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x8.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x9.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x10.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x11.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x12.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x13.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x14.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.store32_le(arg_0) }(var_x15.dup())).str()
}

fn Class_ParagonIE_Sodium_Core_Salsa20.salsa20(var_len rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(rt.new_string('Key must be 32 bytes long'))))
	}
	mut var_kcopy := rt.new_string('' + (var_key).str())
	mut var_in := rt.new_string(rt.concat(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_nonce.dup(), rt.new_int(0), rt.new_int(8)), rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(8)])))
	mut var_c := rt.new_string(rt.new_string(''))
	for rt.is_true(rt.greater_equal(var_len, rt.new_int(64))) {
		// unsupported expression: Expr_AssignOp_Concat
		mut var_u := rt.new_int(rt.new_int(1))
		{
			mut var_i := rt.new_int(rt.new_int(8))
			for {
				if !(rt.is_true(rt.less(var_i, rt.new_int(16)))) { break }
				// unsupported expression: Expr_AssignOp_Plus
				var_in.array_set(var_i, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.inttochr(arg_0) }(rt.new_int(rt.bitwise_and(var_u, rt.new_int(255)))))
				// unsupported expression: Expr_AssignOp_ShiftRight
				rt.pre_inc(var_i)
			}
		}
		// unsupported expression: Expr_AssignOp_Minus
	}
	if rt.is_true(rt.greater(var_len, rt.new_int(0))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_kcopy.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'SodiumException') {
		mut var_ex := var_e_1.dup()
		var_kcopy = rt.new_null()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return var_c.dup()
}

fn Class_ParagonIE_Sodium_Core_Salsa20.salsa20_xor_ic(var_m rt.PhpVal, var_n rt.PhpVal, var_ic rt.PhpVal, var_k rt.PhpVal) string {
	mut var_m_mutated := var_m
	mut var_mlen := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.strlen(arg_0) }(var_m_mutated.dup())
	if rt.is_true(rt.less(var_mlen, rt.new_int(1))) {
		return ''
	}
	mut var_kcopy := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_k.dup(), rt.new_int(0), rt.new_int(32))
	mut var_in := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Salsa20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_n.dup(), rt.new_int(0), rt.new_int(8))
	// unsupported expression: Expr_AssignOp_Concat
	mut var_c := rt.new_string(rt.new_string(''))
	for rt.is_true(rt.greater_equal(var_mlen, rt.new_int(64))) {
		mut var_block := Class_ParagonIE_Sodium_Core_Salsa20.core_salsa20(.dup(), .dup(), )
		// unsupported expression: Expr_AssignOp_Concat
		
	}
}

fn Class_ParagonIE_Sodium_Core_Salsa20.salsa20_xor(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Salsa20.rotate(var_u rt.PhpVal, var_c rt.PhpVal) rt.PhpVal {
	mut var_u_mutated := var_u
	mut var_c_mutated := var_c
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

struct Class_RangeException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Compat {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_salsa20() &Class_ParagonIE_Sodium_Core_Salsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core_Salsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_util() &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_rangeexception() &Class_RangeException {
	mut obj := &Class_RangeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_compat() &Class_ParagonIE_Sodium_Compat {
	mut obj := &Class_ParagonIE_Sodium_Compat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_Salsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'core_salsa20' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_Salsa20.core_salsa20(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'salsa20' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Salsa20.salsa20(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'salsa20_xor_ic' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_Salsa20.salsa20_xor_ic(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'salsa20_xor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Salsa20.salsa20_xor(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'rotate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Salsa20.rotate(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_Salsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Salsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_RangeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RangeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RangeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Compat) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Compat) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Compat) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core_salsa20_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_Salsa20'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
