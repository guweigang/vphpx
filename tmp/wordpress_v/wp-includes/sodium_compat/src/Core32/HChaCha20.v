import rt

struct Class_ParagonIE_Sodium_Core32_HChaCha20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_HChaCha20.hchacha20(in string, key string, var_c rt.PhpVal) rt.PhpVal {
	mut var_ctx := []rt.PhpVal{}
	if rt.is_true(rt.identical(var_c, rt.new_null())) {
		var_ctx[0] = create_paragonie_sodium_core32_int32(rt.create_array([rt.ArrayItem{ key: none, val: 24944 }, rt.ArrayItem{ key: none, val: 30821 }]))
		var_ctx[1] = create_paragonie_sodium_core32_int32(rt.create_array([rt.ArrayItem{ key: none, val: 13088 }, rt.ArrayItem{ key: none, val: 25710 }]))
		var_ctx[2] = create_paragonie_sodium_core32_int32(rt.create_array([rt.ArrayItem{ key: none, val: 31074 }, rt.ArrayItem{ key: none, val: 11570 }]))
		var_ctx[3] = create_paragonie_sodium_core32_int32(rt.create_array([rt.ArrayItem{ key: none, val: 27424 }, rt.ArrayItem{ key: none, val: 25972 }]))
	} else {
		var_ctx[0] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_c.dup(), rt.new_int(0), rt.new_int(4)))
		var_ctx[1] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_c.dup(), rt.new_int(4), rt.new_int(4)))
		var_ctx[2] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_c.dup(), rt.new_int(8), rt.new_int(4)))
		var_ctx[3] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(var_c.dup(), rt.new_int(12), rt.new_int(4)))
	}
	var_ctx[4] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(0), rt.new_int(4)))
	var_ctx[5] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(4), rt.new_int(4)))
	var_ctx[6] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(8), rt.new_int(4)))
	var_ctx[7] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(12), rt.new_int(4)))
	var_ctx[8] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(16), rt.new_int(4)))
	var_ctx[9] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(20), rt.new_int(4)))
	var_ctx[10] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(24), rt.new_int(4)))
	var_ctx[11] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(key), rt.new_int(28), rt.new_int(4)))
	var_ctx[12] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(in), rt.new_int(0), rt.new_int(4)))
	var_ctx[13] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(in), rt.new_int(4), rt.new_int(4)))
	var_ctx[14] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(in), rt.new_int(8), rt.new_int(4)))
	var_ctx[15] = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromreversestring(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_HChaCha20{}; return temp.substr(arg_0, arg_1, arg_2) }(rt.new_string(in), rt.new_int(12), rt.new_int(4)))
	return Class_ParagonIE_Sodium_Core32_HChaCha20.hchacha20bytes(mut rt.cast_object_ptr[Class_array](var_ctx))
}

fn Class_ParagonIE_Sodium_Core32_HChaCha20.hchacha20bytes(mut var_ctx Class_array) string {
	mut var_ctx_mutated := var_ctx
	mut var_x0 := var_ctx_mutated.array_get(0)
	mut var_x1 := var_ctx_mutated.array_get(1)
	mut var_x2 := var_ctx_mutated.array_get(2)
	mut var_x3 := var_ctx_mutated.array_get(3)
	mut var_x4 := var_ctx_mutated.array_get(4)
	mut var_x5 := var_ctx_mutated.array_get(5)
	mut var_x6 := var_ctx_mutated.array_get(6)
	mut var_x7 := var_ctx_mutated.array_get(7)
	mut var_x8 := var_ctx_mutated.array_get(8)
	mut var_x9 := var_ctx_mutated.array_get(9)
	mut var_x10 := var_ctx_mutated.array_get(10)
	mut var_x11 := var_ctx_mutated.array_get(11)
	mut var_x12 := var_ctx_mutated.array_get(12)
	mut var_x13 := var_ctx_mutated.array_get(13)
	mut var_x14 := var_ctx_mutated.array_get(14)
	mut var_x15 := var_ctx_mutated.array_get(15)
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
	return (rt.call_method(var_x0, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x1, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x2, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x3, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x12, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x13, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x14, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x15, 'toReverseString', []rt.PhpVal{})).str()
}

struct Class_ParagonIE_Sodium_Core32_ChaCha20 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int32 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_hchacha20() &Class_ParagonIE_Sodium_Core32_HChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_HChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_chacha20() &Class_ParagonIE_Sodium_Core32_ChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_ChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_int32() &Class_ParagonIE_Sodium_Core32_Int32 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Int32{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_HChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'hChaCha20' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_HChaCha20.hchacha20(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'hChaCha20Bytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_ParagonIE_Sodium_Core32_HChaCha20.hchacha20bytes(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_HChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_HChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_Int32) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Int32) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int32) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core32_hchacha20_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core32_HChaCha20'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
