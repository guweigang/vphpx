import rt

struct Class_ParagonIE_Sodium_Core_HChaCha20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_HChaCha20.hchacha20(var_in rt.PhpVal, var_key rt.PhpVal, var_c rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Argument 1 must be 16 bytes'))))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Argument 2 must be 32 bytes'))))
	}
	mut var_ctx := []rt.PhpVal{}
	if rt.is_true(rt.identical(var_c, rt.new_null())) {
		var_ctx[0] = rt.new_int(1634760805)
		var_ctx[1] = rt.new_int(857760878)
		var_ctx[2] = rt.new_int(2036477234)
		var_ctx[3] = rt.new_int(1797285236)
	} else {
		var_ctx[0] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_c.dup(), rt.new_int(0), rt.new_int(4)))
		var_ctx[1] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_c.dup(), rt.new_int(4), rt.new_int(4)))
		var_ctx[2] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_c.dup(), rt.new_int(8), rt.new_int(4)))
		var_ctx[3] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_c.dup(), rt.new_int(12), rt.new_int(4)))
	}
	var_ctx[4] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_key.dup(), rt.new_int(0), rt.new_int(4)))
	var_ctx[5] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_key.dup(), rt.new_int(4), rt.new_int(4)))
	var_ctx[6] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_key.dup(), rt.new_int(8), rt.new_int(4)))
	var_ctx[7] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_key.dup(), rt.new_int(12), rt.new_int(4)))
	var_ctx[8] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_key.dup(), rt.new_int(16), rt.new_int(4)))
	var_ctx[9] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_key.dup(), rt.new_int(20), rt.new_int(4)))
	var_ctx[10] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_key.dup(), rt.new_int(24), rt.new_int(4)))
	var_ctx[11] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_key.dup(), rt.new_int(28), rt.new_int(4)))
	var_ctx[12] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_in.dup(), rt.new_int(0), rt.new_int(4)))
	var_ctx[13] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_in.dup(), rt.new_int(4), rt.new_int(4)))
	var_ctx[14] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_in.dup(), rt.new_int(8), rt.new_int(4)))
	var_ctx[15] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_in.dup(), rt.new_int(12), rt.new_int(4)))
	return Class_ParagonIE_Sodium_Core_HChaCha20.hchacha20bytes(mut rt.cast_object_ptr[Class_array](var_ctx))
}

fn Class_ParagonIE_Sodium_Core_HChaCha20.hchacha20bytes(mut var_ctx Class_array) string {
	mut var_ctx_mutated := var_ctx
	mut var_x0 := // unsupported expression: Expr_Cast_Int
	mut var_x1 := // unsupported expression: Expr_Cast_Int
	mut var_x2 := // unsupported expression: Expr_Cast_Int
	mut var_x3 := // unsupported expression: Expr_Cast_Int
	mut var_x4 := // unsupported expression: Expr_Cast_Int
	mut var_x5 := // unsupported expression: Expr_Cast_Int
	mut var_x6 := // unsupported expression: Expr_Cast_Int
	mut var_x7 := // unsupported expression: Expr_Cast_Int
	mut var_x8 := // unsupported expression: Expr_Cast_Int
	mut var_x9 := // unsupported expression: Expr_Cast_Int
	mut var_x10 := // unsupported expression: Expr_Cast_Int
	mut var_x11 := // unsupported expression: Expr_Cast_Int
	mut var_x12 := // unsupported expression: Expr_Cast_Int
	mut var_x13 := // unsupported expression: Expr_Cast_Int
	mut var_x14 := // unsupported expression: Expr_Cast_Int
	mut var_x15 := // unsupported expression: Expr_Cast_Int
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
			// unsupported assign target: Expr_List
			// unsupported assign target: Expr_List
			// unsupported assign target: Expr_List
			// unsupported assign target: Expr_List
			// unsupported assign target: Expr_List
			// unsupported assign target: Expr_List
			// unsupported assign target: Expr_List
			// unsupported assign target: Expr_List
			rt.pre_inc(var_i)
		}
	}
	return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.store32_le(arg_0) }(// unsupported expression: Expr_Cast_Int)).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.store32_le(arg_0) }(// unsupported expression: Expr_Cast_Int)).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.store32_le(arg_0) }(// unsupported expression: Expr_Cast_Int)).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.store32_le(arg_0) }(// unsupported expression: Expr_Cast_Int)).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.store32_le(arg_0) }(// unsupported expression: Expr_Cast_Int)).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.store32_le(arg_0) }(// unsupported expression: Expr_Cast_Int)).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.store32_le(arg_0) }(// unsupported expression: Expr_Cast_Int)).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_HChaCha20{}; return temp.store32_le(arg_0) }(// unsupported expression: Expr_Cast_Int)).str()
}

struct Class_ParagonIE_Sodium_Core_ChaCha20 {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_hchacha20() &Class_ParagonIE_Sodium_Core_HChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core_HChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_chacha20() &Class_ParagonIE_Sodium_Core_ChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_sodiumexception() &Class_SodiumException {
	mut obj := &Class_SodiumException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_HChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'hChaCha20' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_HChaCha20.hchacha20(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'hChaCha20Bytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_ParagonIE_Sodium_Core_HChaCha20.hchacha20bytes(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_HChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_HChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SodiumException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SodiumException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SodiumException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core_hchacha20_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_HChaCha20'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
