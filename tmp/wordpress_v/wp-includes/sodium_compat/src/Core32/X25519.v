import rt

struct Class_ParagonIE_Sodium_Core32_X25519 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_X25519.fe_cswap(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core32_Curve25519_Fe, b i64)  {
	mut var_f_mutated := var_f
	mut var_g_mutated := var_g
	mut b_mutated := b
	mut var_f0 := // unsupported expression: Expr_Cast_Int
	mut var_f1 := // unsupported expression: Expr_Cast_Int
	mut var_f2 := // unsupported expression: Expr_Cast_Int
	mut var_f3 := // unsupported expression: Expr_Cast_Int
	mut var_f4 := // unsupported expression: Expr_Cast_Int
	mut var_f5 := // unsupported expression: Expr_Cast_Int
	mut var_f6 := // unsupported expression: Expr_Cast_Int
	mut var_f7 := // unsupported expression: Expr_Cast_Int
	mut var_f8 := // unsupported expression: Expr_Cast_Int
	mut var_f9 := // unsupported expression: Expr_Cast_Int
	mut var_g0 := // unsupported expression: Expr_Cast_Int
	mut var_g1 := // unsupported expression: Expr_Cast_Int
	mut var_g2 := // unsupported expression: Expr_Cast_Int
	mut var_g3 := // unsupported expression: Expr_Cast_Int
	mut var_g4 := // unsupported expression: Expr_Cast_Int
	mut var_g5 := // unsupported expression: Expr_Cast_Int
	mut var_g6 := // unsupported expression: Expr_Cast_Int
	mut var_g7 := // unsupported expression: Expr_Cast_Int
	mut var_g8 := // unsupported expression: Expr_Cast_Int
	mut var_g9 := // unsupported expression: Expr_Cast_Int
	b_mutated = (// unsupported expression: Expr_UnaryMinus).to_i64()
	mut var_x0 := rt.new_int(rt.bitwise_xor(var_f0, var_g0) & b_mutated)
	mut var_x1 := rt.new_int(rt.bitwise_xor(var_f1, var_g1) & b_mutated)
	mut var_x2 := rt.new_int(rt.bitwise_xor(var_f2, var_g2) & b_mutated)
	mut var_x3 := rt.new_int(rt.bitwise_xor(var_f3, var_g3) & b_mutated)
	mut var_x4 := rt.new_int(rt.bitwise_xor(var_f4, var_g4) & b_mutated)
	mut var_x5 := rt.new_int(rt.bitwise_xor(var_f5, var_g5) & b_mutated)
	mut var_x6 := rt.new_int(rt.bitwise_xor(var_f6, var_g6) & b_mutated)
	mut var_x7 := rt.new_int(rt.bitwise_xor(var_f7, var_g7) & b_mutated)
	mut var_x8 := rt.new_int(rt.bitwise_xor(var_f8, var_g8) & b_mutated)
	mut var_x9 := rt.new_int(rt.bitwise_xor(var_f9, var_g9) & b_mutated)
	var_f_mutated.array_set(0, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_f0, var_x0))))
	var_f_mutated.array_set(1, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_f1, var_x1))))
	var_f_mutated.array_set(2, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_f2, var_x2))))
	var_f_mutated.array_set(3, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_f3, var_x3))))
	var_f_mutated.array_set(4, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_f4, var_x4))))
	var_f_mutated.array_set(5, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_f5, var_x5))))
	var_f_mutated.array_set(6, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_f6, var_x6))))
	var_f_mutated.array_set(7, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_f7, var_x7))))
	var_f_mutated.array_set(8, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_f8, var_x8))))
	var_f_mutated.array_set(9, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_f9, var_x9))))
	var_g_mutated.array_set(0, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_g0, var_x0))))
	var_g_mutated.array_set(1, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_g1, var_x1))))
	var_g_mutated.array_set(2, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_g2, var_x2))))
	var_g_mutated.array_set(3, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_g3, var_x3))))
	var_g_mutated.array_set(4, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_g4, var_x4))))
	var_g_mutated.array_set(5, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_g5, var_x5))))
	var_g_mutated.array_set(6, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_g6, var_x6))))
	var_g_mutated.array_set(7, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_g7, var_x7))))
	var_g_mutated.array_set(8, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_g8, var_x8))))
	var_g_mutated.array_set(9, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_xor(var_g9, var_x9))))
}

fn Class_ParagonIE_Sodium_Core32_X25519.fe_mul121666(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	mut var_h := rt.new_array()
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
			var_h.array_set(var_i, rt.call_method(rt.call_method(var_f_mutated.array_get(var_i), 'toInt64', []rt.PhpVal{}), 'mulInt', [rt.new_int(121666), rt.new_int(17)]))
			rt.pre_inc(var_i)
		}
	}
	mut var_carry9 := rt.call_method(rt.call_method(var_h.array_get(9), 'addInt', [1 << 24]), 'shiftRight', [rt.new_int(25)])
	var_h.array_set(0, rt.call_method(var_h.array_get(0), 'addInt64', [rt.call_method(var_carry9, 'mulInt', [rt.new_int(19), rt.new_int(5)])]))
	var_h.array_set(9, rt.call_method(var_h.array_get(9), 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry1 := rt.call_method(rt.call_method(var_h.array_get(1), 'addInt', [1 << 24]), 'shiftRight', [rt.new_int(25)])
	var_h.array_set(2, rt.call_method(var_h.array_get(2), 'addInt64', [var_carry1.dup()]))
	var_h.array_set(1, rt.call_method(var_h.array_get(1), 'subInt64', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry3 := rt.call_method(rt.call_method(var_h.array_get(3), 'addInt', [1 << 24]), 'shiftRight', [rt.new_int(25)])
	var_h.array_set(4, rt.call_method(var_h.array_get(4), 'addInt64', [var_carry3.dup()]))
	var_h.array_set(3, rt.call_method(var_h.array_get(3), 'subInt64', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry5 := rt.call_method(rt.call_method(var_h.array_get(5), 'addInt', [1 << 24]), 'shiftRight', [rt.new_int(25)])
	var_h.array_set(6, rt.call_method(var_h.array_get(6), 'addInt64', [var_carry5.dup()]))
	var_h.array_set(5, rt.call_method(var_h.array_get(5), 'subInt64', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry7 := rt.call_method(rt.call_method(var_h.array_get(7), 'addInt', [1 << 24]), 'shiftRight', [rt.new_int(25)])
	var_h.array_set(8, rt.call_method(var_h.array_get(8), 'addInt64', [var_carry7.dup()]))
	var_h.array_set(7, rt.call_method(var_h.array_get(7), 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry0 := rt.call_method(rt.call_method(var_h.array_get(0), 'addInt', [1 << 25]), 'shiftRight', [rt.new_int(26)])
	var_h.array_set(1, rt.call_method(var_h.array_get(1), 'addInt64', [var_carry0.dup()]))
	var_h.array_set(0, rt.call_method(var_h.array_get(0), 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry2 := rt.call_method(rt.call_method(var_h.array_get(2), 'addInt', [1 << 25]), 'shiftRight', [rt.new_int(26)])
	var_h.array_set(3, rt.call_method(var_h.array_get(3), 'addInt64', [var_carry2.dup()]))
	var_h.array_set(2, rt.call_method(var_h.array_get(2), 'subInt64', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry4 := rt.call_method(rt.call_method(var_h.array_get(4), 'addInt', [1 << 25]), 'shiftRight', [rt.new_int(26)])
	var_h.array_set(5, rt.call_method(var_h.array_get(5), 'addInt64', [var_carry4.dup()]))
	var_h.array_set(4, rt.call_method(var_h.array_get(4), 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry6 := rt.call_method(rt.call_method(var_h.array_get(6), 'addInt', [1 << 25]), 'shiftRight', [rt.new_int(26)])
	var_h.array_set(7, rt.call_method(var_h.array_get(7), 'addInt64', [var_carry6.dup()]))
	var_h.array_set(6, rt.call_method(var_h.array_get(6), 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry8 := rt.call_method(rt.call_method(var_h.array_get(8), 'addInt', [1 << 25]), 'shiftRight', [rt.new_int(26)])
	var_h.array_set(9, rt.call_method(var_h.array_get(9), 'addInt64', [var_carry8.dup()]))
	var_h.array_set(8, rt.call_method(var_h.array_get(8), 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(26)])]))
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
			var_h.array_set(var_i, rt.call_method(var_h.array_get(var_i), 'toInt32', []rt.PhpVal{}))
			rt.pre_inc(var_i)
		}
	}
	mut var_h2 := var_h.dup()
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}; return temp.fromarray(arg_0) }(var_h2.dup())
}

fn Class_ParagonIE_Sodium_Core32_X25519.crypto_scalarmult_curve25519_ref10(var_n rt.PhpVal, var_p rt.PhpVal) rt.PhpVal {
	mut var_e := rt.new_string('' + (var_n).str())
	var_e.array_set(0, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_X25519{}; return temp.inttochr(arg_0) }(rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_X25519{}; return temp.chrtoint(arg_0) }(var_e.array_get(0)), rt.new_int(248)))))
	var_e.array_set(31, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_X25519{}; return temp.inttochr(arg_0) }(rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_X25519{}; return temp.chrtoint(arg_0) }(), rt.new_int(127)) | 64)))
	mut var_x1 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_X25519{}; return temp.fe_frombytes(arg_0) }(var_p.dup())
	mut var_x2 := fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_X25519{}; return temp.fe_1() }()
	mut var_z2 := fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_X25519{}; return temp.fe_0() }()
	mut var_x3 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_X25519{}; return temp.fe_copy(arg_0) }(var_x1.dup())
	mut var_z3 := fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_X25519{}; return temp.fe_1() }()
	mut var_swap := rt.new_int()
	{
		
		for {
			if !(rt.is_true()) { break }
			
		}
	}
}

fn Class_ParagonIE_Sodium_Core32_X25519.edwards_to_montgomery(mut var_edwardsY Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_edwardsZ Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_X25519.crypto_scalarmult_curve25519_ref10_base(var_n rt.PhpVal) rt.PhpVal {
}

struct Class_ParagonIE_Sodium_Core32_Curve25519 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int32 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Curve25519_Fe {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_x25519() &Class_ParagonIE_Sodium_Core32_X25519 {
	mut obj := &Class_ParagonIE_Sodium_Core32_X25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_curve25519() &Class_ParagonIE_Sodium_Core32_Curve25519 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519{
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

fn create_paragonie_sodium_core32_curve25519_fe() &Class_ParagonIE_Sodium_Core32_Curve25519_Fe {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519_Fe{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_X25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fe_cswap' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			Class_ParagonIE_Sodium_Core32_X25519.fe_cswap(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'fe_mul121666' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_X25519.fe_mul121666(mut dispatch_arg_0)
		}
		'crypto_scalarmult_curve25519_ref10' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_X25519.crypto_scalarmult_curve25519_ref10(dispatch_arg_0, dispatch_arg_1)
		}
		'edwards_to_montgomery' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_X25519.edwards_to_montgomery(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'crypto_scalarmult_curve25519_ref10_base' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_X25519.crypto_scalarmult_curve25519_ref10_base(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_X25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_X25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Fe) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519_Fe) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Fe) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core32_x25519_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core32_X25519'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
