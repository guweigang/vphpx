import rt

struct Class_ParagonIE_Sodium_Core_SipHash {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_SipHash.sipround(mut var_v Class_array) rt.PhpVal {
	mut var_v_mutated := var_v
	// unsupported assign target: Expr_List
	// unsupported assign target: Expr_List
	var_v_mutated.array_set(2, rt.bitwise_xor(// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int))
	var_v_mutated.array_set(3, rt.bitwise_xor(// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int))
	// unsupported assign target: Expr_List
	// unsupported assign target: Expr_List
	// unsupported assign target: Expr_List
	var_v_mutated.array_set(6, rt.bitwise_xor(// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int))
	var_v_mutated.array_set(7, rt.bitwise_xor(// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int))
	// unsupported assign target: Expr_List
	// unsupported assign target: Expr_List
	var_v_mutated.array_set(6, rt.bitwise_xor(// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int))
	var_v_mutated.array_set(7, rt.bitwise_xor(// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int))
	// unsupported assign target: Expr_List
	// unsupported assign target: Expr_List
	var_v_mutated.array_set(2, rt.bitwise_xor(// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int))
	var_v_mutated.array_set(3, rt.bitwise_xor(// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int))
	// unsupported assign target: Expr_List
	return rt.new_object('array', []string{}, var_v_mutated)
}

fn Class_ParagonIE_Sodium_Core_SipHash.add(mut var_a Class_array, mut var_b Class_array) rt.PhpVal {
	mut var_b_mutated := var_b
	mut var_x1 := rt.add(var_a.array_get(1), var_b_mutated.array_get(1))
	mut var_c := rt.new_int(rt.shift_right(var_x1, rt.new_int(32)))
	mut var_x0 := rt.add(rt.add(var_a.array_get(0), var_b_mutated.array_get(0)), var_c)
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.bitwise_and(var_x0, rt.new_int(4294967295)) }, rt.ArrayItem{ key: none, val: rt.bitwise_and(var_x1, rt.new_int(4294967295)) }])
}

fn Class_ParagonIE_Sodium_Core_SipHash.rotl_64(var_int0 rt.PhpVal, var_int1 rt.PhpVal, var_c rt.PhpVal) rt.PhpVal {
	mut var_int0_mutated := var_int0
	mut var_int1_mutated := var_int1
	mut var_c_mutated := var_c
	// unsupported expression: Expr_AssignOp_BitwiseAnd
	// unsupported expression: Expr_AssignOp_BitwiseAnd
	// unsupported expression: Expr_AssignOp_BitwiseAnd
	if rt.is_true(rt.identical(var_c_mutated, rt.new_int(32))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: var_int1_mutated }, rt.ArrayItem{ key: none, val: var_int0_mutated }])
	}
	if rt.is_true(rt.greater(var_c_mutated, rt.new_int(31))) {
		mut var_tmp := var_int1_mutated.dup()
		var_int1_mutated = var_int0_mutated.dup()
		var_int0_mutated = var_tmp.dup()
		// unsupported expression: Expr_AssignOp_BitwiseAnd
	}
	if rt.is_true(rt.identical(var_c_mutated, rt.new_int(0))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: var_int0_mutated }, rt.ArrayItem{ key: none, val: var_int1_mutated }])
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: 4294967295 & rt.shift_left(var_int0_mutated, var_c_mutated) | rt.shift_right(var_int1_mutated, rt.sub(rt.new_int(32), var_c_mutated)) }, rt.ArrayItem{ key: none, val: 4294967295 & rt.shift_left(var_int1_mutated, var_c_mutated) | rt.shift_right(var_int0_mutated, rt.sub(rt.new_int(32), var_c_mutated)) }])
}

fn Class_ParagonIE_Sodium_Core_SipHash.siphash24(var_in rt.PhpVal, var_key rt.PhpVal) string {
	mut var_in_mutated := var_in
	mut var_inlen := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.strlen(arg_0) }(var_in_mutated.dup())
	mut var_v := rt.create_array([rt.ArrayItem{ key: none, val: 1936682341 }, rt.ArrayItem{ key: none, val: 1886610805 }, rt.ArrayItem{ key: none, val: 1685025377 }, rt.ArrayItem{ key: none, val: 1852075885 }, rt.ArrayItem{ key: none, val: 1819895653 }, rt.ArrayItem{ key: none, val: 1852142177 }, rt.ArrayItem{ key: none, val: 1952801890 }, rt.ArrayItem{ key: none, val: 2037671283 }])
	mut var_k := [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.substr(arg_0, arg_1, arg_2) }(var_key.dup(), rt.new_int(4), rt.new_int(4))), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.substr(arg_0, arg_1, arg_2) }(var_key.dup(), rt.new_int(0), rt.new_int(4))), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.substr(arg_0, arg_1, arg_2) }(var_key.dup(), rt.new_int(12), rt.new_int(4))), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.substr(arg_0, arg_1, arg_2) }(var_key.dup(), rt.new_int(8), rt.new_int(4)))]
	mut var_b := [rt.shift_left(var_inlen, rt.new_int(24)), 0]
	// unsupported expression: Expr_AssignOp_BitwiseXor
	// unsupported expression: Expr_AssignOp_BitwiseXor
	// unsupported expression: Expr_AssignOp_BitwiseXor
	// unsupported expression: Expr_AssignOp_BitwiseXor
	// unsupported expression: Expr_AssignOp_BitwiseXor
	// unsupported expression: Expr_AssignOp_BitwiseXor
	// unsupported expression: Expr_AssignOp_BitwiseXor
	// unsupported expression: Expr_AssignOp_BitwiseXor
	mut var_left := var_inlen.dup()
	for rt.is_true(rt.greater_equal(var_left, rt.new_int(8))) {
		mut var_m := [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.substr(arg_0, arg_1, arg_2) }(var_in_mutated.dup(), rt.new_int(4), rt.new_int(4))), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.substr(arg_0, arg_1, arg_2) }(var_in_mutated.dup(), rt.new_int(0), rt.new_int(4)))]
		// unsupported expression: Expr_AssignOp_BitwiseXor
		// unsupported expression: Expr_AssignOp_BitwiseXor
		var_v = Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
		var_v = Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
		// unsupported expression: Expr_AssignOp_BitwiseXor
		// unsupported expression: Expr_AssignOp_BitwiseXor
		var_in_mutated = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.substr(arg_0, arg_1) }(var_in_mutated.dup(), rt.new_int(8))
		// unsupported expression: Expr_AssignOp_Minus
	}
	mut switch_val_1 := var_left
	if rt.is_true(rt.equal(switch_val_1, rt.new_int(7))) {
		// unsupported expression: Expr_AssignOp_BitwiseOr
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(6))) {
		// unsupported expression: Expr_AssignOp_BitwiseOr
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(5))) {
		// unsupported expression: Expr_AssignOp_BitwiseOr
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(4))) {
		// unsupported expression: Expr_AssignOp_BitwiseOr
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(3))) {
		// unsupported expression: Expr_AssignOp_BitwiseOr
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
		// unsupported expression: Expr_AssignOp_BitwiseOr
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		// unsupported expression: Expr_AssignOp_BitwiseOr
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) {
	}
	// unsupported expression: Expr_AssignOp_BitwiseXor
	// unsupported expression: Expr_AssignOp_BitwiseXor
	var_v = Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v = Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	// unsupported expression: Expr_AssignOp_BitwiseXor
	// unsupported expression: Expr_AssignOp_BitwiseXor
	// unsupported expression: Expr_AssignOp_BitwiseXor
	var_v = Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v = Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v = Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v = Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	return (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.store32_le(arg_0) }(rt.new_int(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_v.array_get(1), var_v.array_get(3)), var_v.array_get(5)), var_v.array_get(7))))).str() + (fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_SipHash{}; return temp.store32_le(arg_0) }(rt.new_int(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_v.array_get(0), var_v.array_get(2)), var_v.array_get(4)), var_v.array_get(6))))).str()
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_siphash() &Class_ParagonIE_Sodium_Core_SipHash {
	mut obj := &Class_ParagonIE_Sodium_Core_SipHash{
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

fn (mut this Class_ParagonIE_Sodium_Core_SipHash) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'sipRound' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_SipHash.sipround(mut dispatch_arg_0)
		}
		'add' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_SipHash.add(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'rotl_64' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_SipHash.rotl_64(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'sipHash24' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_SipHash.siphash24(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_SipHash) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_SipHash) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_sodium_compat_src_core_siphash_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_SipHash'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
