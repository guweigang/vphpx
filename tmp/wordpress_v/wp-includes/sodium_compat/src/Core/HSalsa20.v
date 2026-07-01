import rt

struct Class_ParagonIE_Sodium_Core_HSalsa20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_HSalsa20.hsalsa20(var_in rt.PhpVal, var_k rt.PhpVal, var_c rt.PhpVal) string {
	if rt.is_true(rt.identical(var_c, rt.new_null())) {
		mut var_x0 := rt.new_int(rt.new_int(1634760805))
		mut var_x5 := rt.new_int(rt.new_int(857760878))
		mut var_x10 := rt.new_int(rt.new_int(2036477234))
		mut var_x15 := rt.new_int(rt.new_int(1797285236))
	} else {
		var_x0 = fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
			return temp.load_4(arg_0)
		}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
			return temp.substr(arg_0, arg_1, arg_2)
		}(var_c.dup(), rt.new_int(0), rt.new_int(4)))
		var_x5 = fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
			return temp.load_4(arg_0)
		}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
			return temp.substr(arg_0, arg_1, arg_2)
		}(var_c.dup(), rt.new_int(4), rt.new_int(4)))
		var_x10 = fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
			return temp.load_4(arg_0)
		}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
			return temp.substr(arg_0, arg_1, arg_2)
		}(var_c.dup(), rt.new_int(8), rt.new_int(4)))
		var_x15 = fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
			return temp.load_4(arg_0)
		}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
			return temp.substr(arg_0, arg_1, arg_2)
		}(var_c.dup(), rt.new_int(12), rt.new_int(4)))
	}
	mut var_x1 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.load_4(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(0), rt.new_int(4)))
	mut var_x2 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.load_4(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(4), rt.new_int(4)))
	mut var_x3 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.load_4(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(8), rt.new_int(4)))
	mut var_x4 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.load_4(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(12), rt.new_int(4)))
	mut var_x11 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.load_4(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(16), rt.new_int(4)))
	mut var_x12 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.load_4(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(20), rt.new_int(4)))
	mut var_x13 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.load_4(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(24), rt.new_int(4)))
	mut var_x14 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.load_4(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(28), rt.new_int(4)))
	mut var_x6 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.load_4(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_in.dup(), rt.new_int(0), rt.new_int(4)))
	mut var_x7 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.load_4(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_in.dup(), rt.new_int(4), rt.new_int(4)))
	mut var_x8 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.load_4(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_in.dup(), rt.new_int(8), rt.new_int(4)))
	mut var_x9 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.load_4(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_in.dup(), rt.new_int(12), rt.new_int(4)))
	{
		mut var_i := Class_ParagonIE_Sodium_Core_HSalsa20.rounds()
		for {
			if !(rt.is_true(rt.greater(var_i, rt.new_int(0)))) { break
			 }
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
	return (fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.store32_le(arg_0)
	}(var_x0.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.store32_le(arg_0)
	}(var_x5.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.store32_le(arg_0)
	}(var_x10.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.store32_le(arg_0)
	}(var_x15.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.store32_le(arg_0)
	}(var_x6.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.store32_le(arg_0)
	}(var_x7.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.store32_le(arg_0)
	}(var_x8.dup())).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core_HSalsa20{}
		return temp.store32_le(arg_0)
	}(var_x9.dup())).str()
}

struct Class_ParagonIE_Sodium_Core_Salsa20 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_hsalsa20() &Class_ParagonIE_Sodium_Core_HSalsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core_HSalsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_salsa20() &Class_ParagonIE_Sodium_Core_Salsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core_Salsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_HSalsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'hsalsa20' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_HSalsa20.hsalsa20(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core_HSalsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_HSalsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_Salsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Salsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Salsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_sodium_compat_src_core_hsalsa20_php() {
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_HSalsa20'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
