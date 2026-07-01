import rt

struct Class_ParagonIE_Sodium_Core_Curve25519 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_0() rt.PhpVal {
	return create_paragonie_sodium_core_curve25519_fe()
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_1() rt.PhpVal {
	mut var_fe := create_paragonie_sodium_core_curve25519_fe()
	rt.set_property(var_fe, 'e0', rt.new_int(1))
	return mut var_fe
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_add(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	mut var_g_mutated := var_g
	return create_paragonie_sodium_core_curve25519_fe(// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int)
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_cmov(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core_Curve25519_Fe, b i64) rt.PhpVal {
	mut var_f_mutated := var_f
	mut var_g_mutated := var_g
	mut b_mutated := b
	mut var_h := create_paragonie_sodium_core_curve25519_fe()
	// unsupported expression: Expr_AssignOp_Mul
	mut var_x := rt.new_int(rt.bitwise_xor(rt.get_property(var_f_mutated, 'e0'), rt.get_property(var_g_mutated, 'e0')) & b_mutated)
	rt.set_property(var_h, 'e0', rt.bitwise_xor(rt.get_property(var_f_mutated, 'e0'), var_x))
	var_x = rt.new_int(rt.bitwise_xor(rt.get_property(var_f_mutated, 'e1'), rt.get_property(var_g_mutated, 'e1')) & b_mutated)
	rt.set_property(var_h, 'e1', rt.bitwise_xor(rt.get_property(var_f_mutated, 'e1'), var_x))
	var_x = rt.new_int(rt.bitwise_xor(rt.get_property(var_f_mutated, 'e2'), rt.get_property(var_g_mutated, 'e2')) & b_mutated)
	rt.set_property(var_h, 'e2', rt.bitwise_xor(rt.get_property(var_f_mutated, 'e2'), var_x))
	var_x = rt.new_int(rt.bitwise_xor(rt.get_property(var_f_mutated, 'e3'), rt.get_property(var_g_mutated, 'e3')) & b_mutated)
	rt.set_property(var_h, 'e3', rt.bitwise_xor(rt.get_property(var_f_mutated, 'e3'), var_x))
	var_x = rt.new_int(rt.bitwise_xor(rt.get_property(var_f_mutated, 'e4'), rt.get_property(var_g_mutated, 'e4')) & b_mutated)
	rt.set_property(var_h, 'e4', rt.bitwise_xor(rt.get_property(var_f_mutated, 'e4'), var_x))
	var_x = rt.new_int(rt.bitwise_xor(rt.get_property(var_f_mutated, 'e5'), rt.get_property(var_g_mutated, 'e5')) & b_mutated)
	rt.set_property(var_h, 'e5', rt.bitwise_xor(rt.get_property(var_f_mutated, 'e5'), var_x))
	var_x = rt.new_int(rt.bitwise_xor(rt.get_property(var_f_mutated, 'e6'), rt.get_property(var_g_mutated, 'e6')) & b_mutated)
	rt.set_property(var_h, 'e6', rt.bitwise_xor(rt.get_property(var_f_mutated, 'e6'), var_x))
	var_x = rt.new_int(rt.bitwise_xor(rt.get_property(var_f_mutated, 'e7'), rt.get_property(var_g_mutated, 'e7')) & b_mutated)
	rt.set_property(var_h, 'e7', rt.bitwise_xor(rt.get_property(var_f_mutated, 'e7'), var_x))
	var_x = rt.new_int(rt.bitwise_xor(rt.get_property(var_f_mutated, 'e8'), rt.get_property(var_g_mutated, 'e8')) & b_mutated)
	rt.set_property(var_h, 'e8', rt.bitwise_xor(rt.get_property(var_f_mutated, 'e8'), var_x))
	var_x = rt.new_int(rt.bitwise_xor(rt.get_property(var_f_mutated, 'e9'), rt.get_property(var_g_mutated, 'e9')) & b_mutated)
	rt.set_property(var_h, 'e9', rt.bitwise_xor(rt.get_property(var_f_mutated, 'e9'), var_x))
	return var_h.dup()
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_copy(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	return // unsupported expression: Expr_Clone
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_frombytes(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(rt.new_string('Expected a 32-byte string.'))))
	}
	mut var_h0 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.load_4(arg_0) }(var_s_mutated.dup())
	mut var_h1 := rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(4), rt.new_int(3))), rt.new_int(6)))
	mut var_h2 := rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(7), rt.new_int(3))), rt.new_int(5)))
	mut var_h3 := rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(10), rt.new_int(3))), rt.new_int(3)))
	mut var_h4 := rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(13), rt.new_int(3))), rt.new_int(2)))
	mut var_h5 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(16), rt.new_int(4)))
	mut var_h6 := rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(20), rt.new_int(3))), rt.new_int(7)))
	mut var_h7 := rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(23), rt.new_int(3))), rt.new_int(5)))
	mut var_h8 := rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(26), rt.new_int(3))), rt.new_int(4)))
	mut var_h9 := rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(29), rt.new_int(3))), rt.new_int(8388607)) << 2)
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
	return create_paragonie_sodium_core_curve25519_fe(// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int)
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_tobytes(mut var_h Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_h_mutated := var_h
	mut var_h0 := // unsupported expression: Expr_Cast_Int
	mut var_h1 := // unsupported expression: Expr_Cast_Int
	mut var_h2 := // unsupported expression: Expr_Cast_Int
	mut var_h3 := // unsupported expression: Expr_Cast_Int
	mut var_h4 := // unsupported expression: Expr_Cast_Int
	mut var_h5 := // unsupported expression: Expr_Cast_Int
	mut var_h6 := // unsupported expression: Expr_Cast_Int
	mut var_h7 := // unsupported expression: Expr_Cast_Int
	mut var_h8 := // unsupported expression: Expr_Cast_Int
	mut var_h9 := // unsupported expression: Expr_Cast_Int
	mut var_q := rt.new_int(rt.shift_right(rt.add(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Curve25519{}; return temp.mul(arg_0, arg_1, arg_2) }(var_h9.dup(), rt.new_int(19), rt.new_int(5)), 1 << 24), rt.new_int(25)))
	var_q = rt.new_int(rt.shift_right(rt.add(var_h0, var_q), rt.new_int(26)))
	var_q = rt.new_int(rt.shift_right(rt.add(var_h1, var_q), rt.new_int(25)))
	var_q = rt.new_int(rt.shift_right(rt.add(var_h2, var_q), rt.new_int(26)))
	var_q = rt.new_int(rt.shift_right(rt.add(var_h3, var_q), rt.new_int(25)))
	var_q = rt.new_int(rt.shift_right(rt.add(var_h4, var_q), rt.new_int(26)))
	var_q = rt.new_int(rt.shift_right(rt.add(var_h5, var_q), rt.new_int(25)))
	var_q = rt.new_int(rt.shift_right(rt.add(var_h6, var_q), rt.new_int(26)))
	var_q = rt.new_int(rt.shift_right(rt.add(var_h7, var_q), rt.new_int(25)))
	var_q = rt.new_int(rt.shift_right(rt.add(var_h8, var_q), rt.new_int(26)))
	var_q = rt.new_int(rt.shift_right(rt.add(var_h9, var_q), rt.new_int(25)))
	// unsupported expression: Expr_AssignOp_Plus
	mut var_carry0 := rt.new_int(rt.shift_right(var_h0, rt.new_int(26)))
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Minus
	mut var_carry1 := rt.new_int()
	
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_isnegative(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_isnonzero(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe) bool {
	mut var_f_mutated := var_f
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_mul(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	mut var_g_mutated := var_g
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_neg(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_sq(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_sq2(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_invert(mut var_Z Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_pow22523(mut var_z Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_z_mutated := var_z
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_sub(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	mut var_g_mutated := var_g
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_add(mut var_p Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3, mut var_q Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached) rt.PhpVal {
	mut var_q_mutated := var_q
}

fn Class_ParagonIE_Sodium_Core_Curve25519.slide(var_a rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_frombytes_negate_vartime(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_madd(mut var_R Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1, mut var_p Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3, mut var_q Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp) rt.PhpVal {
	mut var_q_mutated := var_q
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_msub(mut var_R Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1, mut var_p Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3, mut var_q Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp) rt.PhpVal {
	mut var_q_mutated := var_q
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_p1p1_to_p2(mut var_p Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_p1p1_to_p3(mut var_p Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_p2_0() rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_p2_dbl(mut var_p Class_ParagonIE_Sodium_Core_Curve25519_Ge_P2) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_p3_0() rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_p3_to_cached(mut var_p Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_p3_to_p2(mut var_p Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_p3_tobytes(mut var_h Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) rt.PhpVal {
	mut var_h_mutated := var_h
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_p3_dbl(mut var_p Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_precomp_0() rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Curve25519.equal(var_b rt.PhpVal, var_c rt.PhpVal) i64 {
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core_Curve25519.negative(var_char rt.PhpVal) i64 {
}

fn Class_ParagonIE_Sodium_Core_Curve25519.cmov(mut var_t Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp, mut var_u Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp, var_b rt.PhpVal) rt.PhpVal {
	mut var_t_mutated := var_t
	mut var_u_mutated := var_u
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_cmov_cached(mut var_t Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached, mut var_u Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached, var_b rt.PhpVal) rt.PhpVal {
	mut var_t_mutated := var_t
	mut var_u_mutated := var_u
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_cmov8_cached(mut var_cached Class_array, var_b rt.PhpVal) rt.PhpVal {
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_select(pos i64, b i64) rt.PhpVal {
	mut b_mutated := b
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_sub(mut var_p Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3, mut var_q Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached) rt.PhpVal {
	mut var_q_mutated := var_q
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_tobytes(mut var_h Class_ParagonIE_Sodium_Core_Curve25519_Ge_P2) rt.PhpVal {
	mut var_h_mutated := var_h
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_double_scalarmult_vartime(mut var_a Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3, mut var_A Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3, var_b rt.PhpVal) rt.PhpVal {
	mut var_Bi := rt.new_null()
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_scalarmult(var_a rt.PhpVal, var_p rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_scalarmult_base(var_a rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
}

fn Class_ParagonIE_Sodium_Core_Curve25519.sc_muladd(var_a rt.PhpVal, var_b rt.PhpVal, var_c rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core_Curve25519.sc_reduce(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
}

fn Class_ParagonIE_Sodium_Core_Curve25519.ge_mul_l(mut var_A Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Curve25519.sc25519_mul(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core_Curve25519.sc25519_sq(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
}

fn Class_ParagonIE_Sodium_Core_Curve25519.sc25519_sqmul(var_s rt.PhpVal, var_n rt.PhpVal, var_a rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
	mut var_a_mutated := var_a
}

fn Class_ParagonIE_Sodium_Core_Curve25519.sc25519_invert(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
}

fn Class_ParagonIE_Sodium_Core_Curve25519.clamp(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
}

fn Class_ParagonIE_Sodium_Core_Curve25519.fe_normalize(mut var_f Class_ParagonIE_Sodium_Core_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
}

struct Class_ParagonIE_Sodium_Core_Curve25519_H {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_Curve25519_Fe {
	rt.PhpObjectBase
}

struct Class_RangeException {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_curve25519() &Class_ParagonIE_Sodium_Core_Curve25519 {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_curve25519_h() &Class_ParagonIE_Sodium_Core_Curve25519_H {
	mut obj := &Class_ParagonIE_Sodium_Core_Curve25519_H{
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

fn create_rangeexception() &Class_RangeException {
	mut obj := &Class_RangeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fe_0' {
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_0()
		}
		'fe_1' {
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_1()
		}
		'fe_add' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_add(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'fe_cmov' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_cmov(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'fe_copy' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_copy(mut dispatch_arg_0)
		}
		'fe_frombytes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_frombytes(dispatch_arg_0)
		}
		'fe_tobytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_tobytes(mut dispatch_arg_0)
		}
		'fe_isnegative' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_isnegative(mut dispatch_arg_0)
		}
		'fe_isnonzero' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(Class_ParagonIE_Sodium_Core_Curve25519.fe_isnonzero(mut dispatch_arg_0))
		}
		'fe_mul' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_mul(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'fe_neg' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_neg(mut dispatch_arg_0)
		}
		'fe_sq' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_sq(mut dispatch_arg_0)
		}
		'fe_sq2' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_sq2(mut dispatch_arg_0)
		}
		'fe_invert' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_invert(mut dispatch_arg_0)
		}
		'fe_pow22523' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_pow22523(mut dispatch_arg_0)
		}
		'fe_sub' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_sub(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'ge_add' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_add(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'slide' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.slide(dispatch_arg_0)
		}
		'ge_frombytes_negate_vartime' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_frombytes_negate_vartime(dispatch_arg_0)
		}
		'ge_madd' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_madd(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'ge_msub' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_msub(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'ge_p1p1_to_p2' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_p1p1_to_p2(mut dispatch_arg_0)
		}
		'ge_p1p1_to_p3' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P1p1](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_p1p1_to_p3(mut dispatch_arg_0)
		}
		'ge_p2_0' {
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_p2_0()
		}
		'ge_p2_dbl' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P2](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_p2_dbl(mut dispatch_arg_0)
		}
		'ge_p3_0' {
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_p3_0()
		}
		'ge_p3_to_cached' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_p3_to_cached(mut dispatch_arg_0)
		}
		'ge_p3_to_p2' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_p3_to_p2(mut dispatch_arg_0)
		}
		'ge_p3_tobytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_p3_tobytes(mut dispatch_arg_0)
		}
		'ge_p3_dbl' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_p3_dbl(mut dispatch_arg_0)
		}
		'ge_precomp_0' {
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_precomp_0()
		}
		'equal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core_Curve25519.equal(dispatch_arg_0, dispatch_arg_1))
		}
		'negative' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core_Curve25519.negative(dispatch_arg_0))
		}
		'cmov' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_Precomp](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.cmov(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'ge_cmov_cached' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_cmov_cached(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'ge_cmov8_cached' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_cmov8_cached(mut dispatch_arg_0, dispatch_arg_1)
		}
		'ge_select' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_select(dispatch_arg_0, dispatch_arg_1)
		}
		'ge_sub' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_Cached](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_sub(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'ge_tobytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P2](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_tobytes(mut dispatch_arg_0)
		}
		'ge_double_scalarmult_vartime' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_double_scalarmult_vartime(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'ge_scalarmult' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_scalarmult(dispatch_arg_0, dispatch_arg_1)
		}
		'ge_scalarmult_base' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_scalarmult_base(dispatch_arg_0)
		}
		'sc_muladd' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.sc_muladd(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'sc_reduce' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.sc_reduce(dispatch_arg_0)
		}
		'ge_mul_l' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.ge_mul_l(mut dispatch_arg_0)
		}
		'sc25519_mul' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.sc25519_mul(dispatch_arg_0, dispatch_arg_1)
		}
		'sc25519_sq' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.sc25519_sq(dispatch_arg_0)
		}
		'sc25519_sqmul' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.sc25519_sqmul(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'sc25519_invert' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.sc25519_invert(dispatch_arg_0)
		}
		'clamp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Curve25519.clamp(dispatch_arg_0)
		}
		'fe_normalize' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Curve25519.fe_normalize(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_H) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Curve25519_H) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Curve25519_H) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_RangeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RangeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RangeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core_curve25519_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_Curve25519'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
