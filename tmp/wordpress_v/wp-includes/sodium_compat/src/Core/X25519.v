import rt

struct Class_ParagonIE_Sodium_Core_X25519 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_X25519.fe_cswap(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core_Curve25519_Fe, b i64)  {
	mut b_mutated := b
	b_mutated = (// unsupported expression: Expr_UnaryMinus).to_i64()
	mut var_x0 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e0'), rt.get_property(var_g, 'e0')) & b_mutated)
	mut var_x1 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e1'), rt.get_property(var_g, 'e1')) & b_mutated)
	mut var_x2 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e2'), rt.get_property(var_g, 'e2')) & b_mutated)
	mut var_x3 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e3'), rt.get_property(var_g, 'e3')) & b_mutated)
	mut var_x4 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e4'), rt.get_property(var_g, 'e4')) & b_mutated)
	mut var_x5 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e5'), rt.get_property(var_g, 'e5')) & b_mutated)
	mut var_x6 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e6'), rt.get_property(var_g, 'e6')) & b_mutated)
	mut var_x7 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e7'), rt.get_property(var_g, 'e7')) & b_mutated)
	mut var_x8 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e8'), rt.get_property(var_g, 'e8')) & b_mutated)
	mut var_x9 := rt.new_int(rt.bitwise_xor(rt.get_property(var_f, 'e9'), rt.get_property(var_g, 'e9')) & b_mutated)
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
}

fn Class_ParagonIE_Sodium_Core_X25519.fe_mul121666(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_h0 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.mul(arg_0, arg_1, arg_2) }(rt.get_property(var_f, 'e0'), rt.new_int(121666), rt.new_int(17))
	mut var_h1 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.mul(arg_0, arg_1, arg_2) }(rt.get_property(var_f, 'e1'), rt.new_int(121666), rt.new_int(17))
	mut var_h2 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.mul(arg_0, arg_1, arg_2) }(rt.get_property(var_f, 'e2'), rt.new_int(121666), rt.new_int(17))
	mut var_h3 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.mul(arg_0, arg_1, arg_2) }(rt.get_property(var_f, 'e3'), rt.new_int(121666), rt.new_int(17))
	mut var_h4 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.mul(arg_0, arg_1, arg_2) }(rt.get_property(var_f, 'e4'), rt.new_int(121666), rt.new_int(17))
	mut var_h5 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.mul(arg_0, arg_1, arg_2) }(rt.get_property(var_f, 'e5'), rt.new_int(121666), rt.new_int(17))
	mut var_h6 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.mul(arg_0, arg_1, arg_2) }(rt.get_property(var_f, 'e6'), rt.new_int(121666), rt.new_int(17))
	mut var_h7 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.mul(arg_0, arg_1, arg_2) }(rt.get_property(var_f, 'e7'), rt.new_int(121666), rt.new_int(17))
	mut var_h8 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.mul(arg_0, arg_1, arg_2) }(rt.get_property(var_f, 'e8'), rt.new_int(121666), rt.new_int(17))
	mut var_h9 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.mul(arg_0, arg_1, arg_2) }(rt.get_property(var_f, 'e9'), rt.new_int(121666), rt.new_int(17))
	mut var_carry9 := rt.new_int(rt.shift_right(rt.add(var_h9, 1 << 24), rt.new_int(25)))
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Minus
	mut var_carry1 := rt.new_int(rt.shift_right(rt.add(var_h1, 1 << 24), rt.new_int(25)))
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Minus
	mut var_carry3 := rt.new_int(rt.shift_right(rt.add(var_h3, 1 << 24), rt.new_int(25)))
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Minus
	mut var_carry5 := rt.new_int(rt.shift_right(rt.add(var_h5, 1 << 24), rt.new_int(25)))
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Minus
	mut var_carry7 := rt.new_int(rt.shift_right(rt.add(var_h7, 1 << 24), rt.new_int(25)))
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Minus
	mut var_carry0 := rt.new_int(rt.shift_right(rt.add(var_h0, 1 << 25), rt.new_int(26)))
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Minus
	mut var_carry2 := rt.new_int(rt.shift_right(rt.add(var_h2, 1 << 25), rt.new_int(26)))
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Minus
	mut var_carry4 := rt.new_int(rt.shift_right(rt.add(var_h4, 1 << 25), rt.new_int(26)))
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Minus
	mut var_carry6 := rt.new_int(rt.shift_right(rt.add(var_h6, 1 << 25), rt.new_int(26)))
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Minus
	mut var_carry8 := rt.new_int(rt.shift_right(rt.add(var_h8, 1 << 25), rt.new_int(26)))
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Minus
	return create_paragonie_sodium_core_curve25519_fe(var_h0.dup(), var_h1.dup(), var_h2.dup(), var_h3.dup(), var_h4.dup(), var_h5.dup(), var_h6.dup(), var_h7.dup(), var_h8.dup(), var_h9.dup())
}

fn Class_ParagonIE_Sodium_Core_X25519.crypto_scalarmult_curve25519_ref10(var_n rt.PhpVal, var_p rt.PhpVal) rt.PhpVal {
	mut var_e := rt.new_string('' + (var_n).str())
	var_e.array_set(0, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.inttochr(arg_0) }(rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.chrtoint(arg_0) }(var_e.array_get(0)), rt.new_int(248)))))
	var_e.array_set(31, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.inttochr(arg_0) }(rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.chrtoint(arg_0) }(var_e.array_get(31)), rt.new_int(127)) | 64)))
	mut var_x1 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.fe_frombytes(arg_0) }(var_p.dup())
	mut var_x2 := fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.fe_1() }()
	mut var_z2 := fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.fe_0() }()
	mut var_x3 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.fe_copy(arg_0) }(var_x1.dup())
	mut var_z3 := fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.fe_1() }()
	mut var_swap := rt.new_int(rt.new_int(0))
	{
		mut var_pos := rt.new_int(rt.new_int(254))
		for {
			if !(rt.is_true(rt.greater_equal(var_pos, rt.new_int(0)))) { break }
			mut var_b := rt.new_int(rt.shift_right(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.chrtoint(arg_0) }(var_e.array_get(// unsupported expression: Expr_Cast_Int)), rt.bitwise_and(var_pos, rt.new_int(7))))
			// unsupported expression: Expr_AssignOp_BitwiseAnd
			// unsupported expression: Expr_AssignOp_BitwiseXor
			Class_ParagonIE_Sodium_Core_X25519.fe_cswap(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_x2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_x3), (var_swap).to_i64())
			Class_ParagonIE_Sodium_Core_X25519.fe_cswap(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_z2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_z3), (var_swap).to_i64())
			var_swap = var_b.dup()
			mut var_tmp0 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.fe_sub(arg_0, arg_1) }(var_x3.dup(), var_z3.dup())
			mut var_tmp1 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.fe_sub(arg_0, arg_1) }(var_x2.dup(), var_z2.dup())
			var_x2 = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.fe_add(arg_0, arg_1) }(var_x2.dup(), var_z2.dup())
			var_z2 = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.fe_add(arg_0, arg_1) }(var_x3.dup(), var_z3.dup())
			var_z3 = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.fe_mul(arg_0, arg_1) }(var_tmp0.dup(), var_x2.dup())
			var_z2 = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.fe_mul(arg_0, arg_1) }(var_z2.dup(), var_tmp1.dup())
			var_tmp0 = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.fe_sq(arg_0) }(var_tmp1.dup())
			var_tmp1 = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_X25519{}; return temp.fe_sq(arg_0) }(.dup())
			var_x3 = 
			
			
		}
	}
}

fn Class_ParagonIE_Sodium_Core_X25519.edwards_to_montgomery(mut var_edwardsY Class_ParagonIE_Sodium_Core_Curve25519_Fe, mut var_edwardsZ Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_X25519.crypto_scalarmult_curve25519_ref10_base(var_n rt.PhpVal) rt.PhpVal {
}

struct Class_ParagonIE_Sodium_Core_Curve25519 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_Curve25519_Fe {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_x25519() &Class_ParagonIE_Sodium_Core_X25519 {
	mut obj := &Class_ParagonIE_Sodium_Core_X25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_curve25519() &Class_ParagonIE_Sodium_Core_Curve25519 {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_curve25519_fe() &Class_ParagonIE_Sodium_Core_Curve25519_Fe {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_Fe{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_X25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fe_cswap' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			Class_ParagonIE_Sodium_Core_X25519.fe_cswap(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'fe_mul121666' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_X25519.fe_mul121666(mut dispatch_arg_0)
		}
		'crypto_scalarmult_curve25519_ref10' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_X25519.crypto_scalarmult_curve25519_ref10(dispatch_arg_0, dispatch_arg_1)
		}
		'edwards_to_montgomery' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_X25519.edwards_to_montgomery(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'crypto_scalarmult_curve25519_ref10_base' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_X25519.crypto_scalarmult_curve25519_ref10_base(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_X25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_X25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core_Curve25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Fe) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519_Fe) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Fe) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core_x25519_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_X25519'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
