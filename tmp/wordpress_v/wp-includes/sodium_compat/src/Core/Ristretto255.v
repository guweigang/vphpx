import rt

pub fn Class_ParagonIE_Sodium_Core_Ristretto255.crypto_core_ristretto255_hashbytes() i64 {
	return 64
}
pub fn Class_ParagonIE_Sodium_Core_Ristretto255.hash_sc_l() i64 {
	return 48
}
pub fn Class_ParagonIE_Sodium_Core_Ristretto255.core_h2c_sha256() i64 {
	return 1
}
pub fn Class_ParagonIE_Sodium_Core_Ristretto255.core_h2c_sha512() i64 {
	return 2
}
struct Class_ParagonIE_Sodium_Core_Ristretto255 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.fe_cneg(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe, var_b rt.PhpVal) rt.PhpVal {
	mut var_negf := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_neg(arg_0) }(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_f))
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_cmov(arg_0, arg_1, arg_2) }(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_f), var_negf.dup(), var_b.dup())
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.fe_abs(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	return Class_ParagonIE_Sodium_Core_Ristretto255.fe_cneg(mut var_f, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_isnegative(arg_0) }(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_f)))
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.fe_iszero(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe) i64 {
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.identical(var_zero, rt.new_null())) {
		mut var_zero := rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(32)])
	}
	mut var_str := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_tobytes(arg_0) }(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_f))
	mut var_d := rt.new_int(rt.new_int(0))
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(32)))) { break }
			// unsupported expression: Expr_AssignOp_BitwiseOr
			rt.pre_inc(var_i)
		}
	}
	return rt.shift_right(rt.sub(var_d, rt.new_int(1)), rt.new_int(31)) & 1
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_sqrt_ratio_m1(mut var_u Class_ParagonIE_Sodium_Core_Curve25519_Fe, mut var_v Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_u_mutated := var_u
	mut var_v_mutated := var_v
	mut var_sqrtm1 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}; return temp.fromarray(arg_0) }(// unsupported expression: Expr_StaticPropertyFetch)
	mut var_v3 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_sq(arg_0) }(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_v_mutated)), rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_v_mutated))
	mut var_x := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_sq(arg_0) }(var_v3.dup()), rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_u_mutated)), rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_v_mutated))
	var_x = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_pow22523(arg_0) }(var_x.dup()), var_v3.dup()), rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_u_mutated))
	mut var_vxx := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_sq(arg_0) }(var_x.dup()), rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_v_mutated))
	mut var_m_root_check := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_sub(arg_0, arg_1) }(var_vxx.dup(), rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_u_mutated))
	mut var_p_root_check := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_add(arg_0, arg_1) }(var_vxx.dup(), rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_u_mutated))
	mut var_f_root_check := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_u_mutated), var_sqrtm1.dup())
	var_f_root_check = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_add(arg_0, arg_1) }(var_vxx.dup(), var_f_root_check.dup())
	mut var_has_m_root := Class_ParagonIE_Sodium_Core_Ristretto255.fe_iszero(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_m_root_check))
	mut var_has_p_root := Class_ParagonIE_Sodium_Core_Ristretto255.fe_iszero(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_p_root_check))
	mut var_has_f_root := Class_ParagonIE_Sodium_Core_Ristretto255.fe_iszero(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_f_root_check))
	mut var_x_sqrtm1 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(var_x.dup(), var_sqrtm1.dup())
	var_x = Class_ParagonIE_Sodium_Core_Ristretto255.fe_abs(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_cmov(arg_0, arg_1, arg_2) }(var_x.dup(), var_x_sqrtm1.dup(), rt.new_int(rt.bitwise_or(var_has_p_root, var_has_f_root)))))
	return rt.create_array([rt.ArrayItem{ key: 'x', val: var_x }, rt.ArrayItem{ key: 'nonsquare', val: rt.bitwise_or(var_has_m_root, var_has_p_root) }])
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_point_is_canonical(var_s rt.PhpVal) i64 {
	mut var_s_mutated := var_s
	mut var_c := rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.chrtoint(arg_0) }(var_s_mutated.array_get(31)), rt.new_int(127)) ^ 127)
	{
		mut var_i := rt.new_int(rt.new_int(30))
		for {
			if !(rt.is_true(rt.greater(var_i, rt.new_int(0)))) { break }
			// unsupported expression: Expr_AssignOp_BitwiseOr
			rt.pre_dec(var_i)
		}
	}
	var_c = rt.new_int(rt.shift_right(rt.sub(var_c, rt.new_int(1)), rt.new_int(8)))
	mut var_d := rt.new_int(rt.shift_right(rt.sub(237 - 1, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.chrtoint(arg_0) }(var_s_mutated.array_get(0))), rt.new_int(8)))
	mut var_e := rt.new_int(rt.shift_right(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.chrtoint(arg_0) }(var_s_mutated.array_get(31)), rt.new_int(7)))
	return 1 - rt.bitwise_or(rt.bitwise_or(rt.bitwise_and(var_c, var_d), var_e), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.chrtoint(arg_0) }(var_s_mutated.array_get(0))) & 1
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_frombytes(var_s rt.PhpVal, skipCanonicalCheck bool) rt.PhpVal {
	mut var_s_mutated := var_s
	if !(var_skipCanonicalCheck) {
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_point_is_canonical(var_s_mutated.dup()))))) {
			rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('S is not canonical'))))
		}
	}
	mut var_s_ := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_frombytes(arg_0) }(var_s_mutated.dup())
	mut var_ss := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_sq(arg_0) }(var_s_.dup())
	mut var_u1 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_sub(arg_0, arg_1) }(fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_1() }(), var_ss.dup())
	mut var_u1u1 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_sq(arg_0) }(var_u1.dup())
	mut var_u2 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_add(arg_0, arg_1) }(fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_1() }(), var_ss.dup())
	mut var_u2u2 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_sq(arg_0) }(var_u2.dup())
	mut var_v := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}; return temp.fromarray(arg_0) }(// unsupported expression: Expr_StaticPropertyFetch), var_u1u1.dup())
	var_v = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_neg(arg_0) }(var_v.dup())
	var_v = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_sub(arg_0, arg_1) }(var_v.dup(), var_u2u2.dup())
	mut var_v_u2u2 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(var_v.dup(), var_u2u2.dup())
	mut var_one := fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_1() }()
	mut var_result := Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_sqrt_ratio_m1(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_one), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_v_u2u2))
	mut var_inv_sqrt := var_result.array_get('x')
	mut var_notsquare := var_result.array_get('nonsquare')
	mut var_h := create_paragonie_sodium_core_curve25519_ge_p3()
	rt.set_property(var_h, 'X', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(var_inv_sqrt.dup(), var_u2.dup()))
	rt.set_property(var_h, 'Y', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(var_inv_sqrt.dup(), rt.get_property(var_h, 'X')), var_v.dup()))
	rt.set_property(var_h, 'X', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(rt.get_property(var_h, 'X'), var_s_.dup()))
	rt.set_property(var_h, 'X', Class_ParagonIE_Sodium_Core_Ristretto255.fe_abs(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_add(arg_0, arg_1) }(rt.get_property(var_h, 'X'), rt.get_property(var_h, 'X')))))
	rt.set_property(var_h, 'Y', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(var_u1.dup(), rt.get_property(var_h, 'Y')))
	rt.set_property(var_h, 'Z', fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_1() }())
	rt.set_property(var_h, 'T', fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(rt.get_property(var_h, 'X'), rt.get_property(var_h, 'Y')))
	mut var_res := // unsupported expression: Expr_UnaryMinus
	return rt.create_array([rt.ArrayItem{ key: 'h', val: var_h }, rt.ArrayItem{ key: 'res', val: var_res }])
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_p3_tobytes(mut var_h Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) rt.PhpVal {
	mut var_h_mutated := var_h
	mut var_sqrtm1 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}; return temp.fromarray(arg_0) }(// unsupported expression: Expr_StaticPropertyFetch)
	mut var_invsqrtamd := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}; return temp.fromarray(arg_0) }(// unsupported expression: Expr_StaticPropertyFetch)
	mut var_u1 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_add(arg_0, arg_1) }(rt.get_property(var_h_mutated, 'Z'), rt.get_property(var_h_mutated, 'Y'))
	mut var_zmy := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_sub(arg_0, arg_1) }(rt.get_property(var_h_mutated, 'Z'), rt.get_property(var_h_mutated, 'Y'))
	var_u1 = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(var_u1.dup(), var_zmy.dup())
	mut var_u2 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(rt.get_property(var_h_mutated, 'X'), rt.get_property(var_h_mutated, 'Y'))
	mut var_u1_u2u2 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_sq(arg_0) }(var_u2.dup()), var_u1.dup())
	mut var_one := fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_1() }()
	mut var_result := Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_sqrt_ratio_m1(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_one), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_u1_u2u2))
	mut var_inv_sqrt := var_result.array_get('x')
	mut var_den1 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(var_inv_sqrt.dup(), var_u1.dup())
	mut var_den2 := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(var_inv_sqrt.dup(), var_u2.dup())
	mut var_z_inv := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(rt.get_property(var_h_mutated, 'T'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(var_den1.dup(), var_den2.dup()))
	mut var_ix := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(rt.get_property(var_h_mutated, 'X'), var_sqrtm1.dup())
	mut var_iy := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(rt.get_property(var_h_mutated, 'Y'), var_sqrtm1.dup())
	mut var_eden := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(var_den1.dup(), var_invsqrtamd.dup())
	mut var_t_z_inv := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(rt.get_property(var_h_mutated, 'T'), var_z_inv.dup())
	mut var_rotate := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_isnegative(arg_0) }(var_t_z_inv.dup())
	mut var_x_ := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_copy(arg_0) }(rt.get_property(var_h_mutated, 'X'))
	mut var_y_ := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_copy(arg_0) }(rt.get_property(var_h_mutated, 'Y'))
	mut var_den_inv := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_copy(arg_0) }(var_den2.dup())
	var_x_ = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_cmov(arg_0, arg_1, arg_2) }(var_x_.dup(), var_iy.dup(), var_rotate.dup())
	var_y_ = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_cmov(arg_0, arg_1, arg_2) }(var_y_.dup(), var_ix.dup(), var_rotate.dup())
	var_den_inv = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_cmov(arg_0, arg_1, arg_2) }(var_den_inv.dup(), var_eden.dup(), var_rotate.dup())
	mut var_x_z_inv := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(var_x_.dup(), var_z_inv.dup())
	var_y_ = Class_ParagonIE_Sodium_Core_Ristretto255.fe_cneg(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_y_), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_isnegative(arg_0) }(var_x_z_inv.dup()))
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_tobytes(arg_0) }(Class_ParagonIE_Sodium_Core_Ristretto255.fe_abs(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(var_den_inv.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_sub(arg_0, arg_1) }(rt.get_property(var_h_mutated, 'Z'), var_y_.dup())))))
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_elligator(mut var_t Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_t_mutated := var_t
	mut var_sqrtm1 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}; return temp.fromarray(arg_0) }(// unsupported expression: Expr_StaticPropertyFetch)
	mut var_onemsqd := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}; return temp.fromarray(arg_0) }(// unsupported expression: Expr_StaticPropertyFetch)
	mut var_d := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}; return temp.fromarray(arg_0) }(// unsupported expression: Expr_StaticPropertyFetch)
	mut var_sqdmone := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}; return temp.fromarray(arg_0) }(// unsupported expression: Expr_StaticPropertyFetch)
	mut var_sqrtadm1 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519_Fe{}; return temp.fromarray(arg_0) }(// unsupported expression: Expr_StaticPropertyFetch)
	mut var_one := fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_1() }()
	mut var_r := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(var_sqrtm1.dup(), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_sq(arg_0) }(rt.new_object('ParagonIE_Sodium_Core_Curve25519_Fe', []string{}, var_t_mutated)))
	mut var_u := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_add(arg_0, arg_1) }(var_r.dup(), var_one.dup()), var_onemsqd.dup())
	mut var_c := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_neg(arg_0) }(fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_1() }())
	mut var_rpd := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_add(arg_0, arg_1) }(var_r.dup(), var_d.dup())
	mut var_v := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_sub(arg_0, arg_1) }(var_c.dup(), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Ristretto255{}; return temp.fe_mul(arg_0, arg_1) }(.dup(), .dup())), var_rpd.dup())
	mut var_result := Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_sqrt_ratio_m1(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_u), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](var_v))
	mut var_s := .array_get()
	mut var_wasnt_square := 
	
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_from_hash(var_h rt.PhpVal) rt.PhpVal {
	mut var_h_mutated := var_h
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.is_valid_point(var_p rt.PhpVal) i64 {
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_add(var_p rt.PhpVal, var_q rt.PhpVal) rt.PhpVal {
	mut var_q_mutated := var_q
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_sub(var_p rt.PhpVal, var_q rt.PhpVal) rt.PhpVal {
	mut var_q_mutated := var_q
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash_sha256(var_hLen rt.PhpVal, var_ctx rt.PhpVal, var_msg rt.PhpVal) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash_sha512(var_hLen rt.PhpVal, var_ctx rt.PhpVal, var_msg rt.PhpVal) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash(var_hLen rt.PhpVal, var_ctx rt.PhpVal, var_msg rt.PhpVal, var_hash_alg rt.PhpVal)  {
	mut var_ctx_mutated := var_ctx
}

fn Class_ParagonIE_Sodium_Core_Ristretto255._string_to_element(var_ctx rt.PhpVal, var_msg rt.PhpVal, var_hash_alg rt.PhpVal) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_random() rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_random() rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_complement(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_invert(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_negate(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_add(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_sub(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_mul(var_x rt.PhpVal, var_y rt.PhpVal) rt.PhpVal {
	mut var_x_mutated := var_x
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_from_string(var_ctx rt.PhpVal, var_msg rt.PhpVal, var_hash_alg rt.PhpVal) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_reduce(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.scalarmult_ristretto255(var_n rt.PhpVal, var_p rt.PhpVal) rt.PhpVal {
	mut var_n_mutated := var_n
}

fn Class_ParagonIE_Sodium_Core_Ristretto255.scalarmult_ristretto255_base(var_n rt.PhpVal) rt.PhpVal {
	mut var_n_mutated := var_n
}

struct Class_ParagonIE_Sodium_Core_Ed25519 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_Curve25519_Fe {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_ristretto255() &Class_ParagonIE_Sodium_Core_Ristretto255 {
	mut obj := &Class_ParagonIE_Sodium_Core_Ristretto255{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_ed25519() &Class_ParagonIE_Sodium_Core_Ed25519 {
	mut obj := &Class_ParagonIE_Sodium_Core_Ed25519{
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

fn create_sodiumexception() &Class_SodiumException {
	mut obj := &Class_SodiumException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_curve25519_ge_p3() &Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3 {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_Ristretto255) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fe_cneg' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.fe_cneg(mut dispatch_arg_0, dispatch_arg_1)
		}
		'fe_abs' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Ristretto255.fe_abs(mut dispatch_arg_0)
		}
		'fe_iszero' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(Class_ParagonIE_Sodium_Core_Ristretto255.fe_iszero(mut dispatch_arg_0))
		}
		'ristretto255_sqrt_ratio_m1' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_sqrt_ratio_m1(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'ristretto255_point_is_canonical' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_point_is_canonical(dispatch_arg_0))
		}
		'ristretto255_frombytes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_frombytes(dispatch_arg_0, dispatch_arg_1)
		}
		'ristretto255_p3_tobytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_p3_tobytes(mut dispatch_arg_0)
		}
		'ristretto255_elligator' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_elligator(mut dispatch_arg_0)
		}
		'ristretto255_from_hash' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_from_hash(dispatch_arg_0)
		}
		'is_valid_point' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core_Ristretto255.is_valid_point(dispatch_arg_0))
		}
		'ristretto255_add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_add(dispatch_arg_0, dispatch_arg_1)
		}
		'ristretto255_sub' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_sub(dispatch_arg_0, dispatch_arg_1)
		}
		'h2c_string_to_hash_sha256' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash_sha256(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'h2c_string_to_hash_sha512' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash_sha512(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'h2c_string_to_hash' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			Class_ParagonIE_Sodium_Core_Ristretto255.h2c_string_to_hash(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'_string_to_element' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255._string_to_element(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'ristretto255_random' {
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_random()
		}
		'ristretto255_scalar_random' {
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_random()
		}
		'ristretto255_scalar_complement' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_complement(dispatch_arg_0)
		}
		'ristretto255_scalar_invert' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_invert(dispatch_arg_0)
		}
		'ristretto255_scalar_negate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_negate(dispatch_arg_0)
		}
		'ristretto255_scalar_add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_add(dispatch_arg_0, dispatch_arg_1)
		}
		'ristretto255_scalar_sub' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_sub(dispatch_arg_0, dispatch_arg_1)
		}
		'ristretto255_scalar_mul' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_mul(dispatch_arg_0, dispatch_arg_1)
		}
		'ristretto255_scalar_from_string' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_from_string(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'ristretto255_scalar_reduce' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.ristretto255_scalar_reduce(dispatch_arg_0)
		}
		'scalarmult_ristretto255' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.scalarmult_ristretto255(dispatch_arg_0, dispatch_arg_1)
		}
		'scalarmult_ristretto255_base' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Ristretto255.scalarmult_ristretto255_base(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_Ristretto255) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Ristretto255) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core_Ed25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Ed25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Ed25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_SodiumException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SodiumException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SodiumException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core_ristretto255_php() {
}
