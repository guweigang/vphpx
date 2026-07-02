import rt

struct Class_ParagonIE_Sodium_Core32_X25519 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_X25519.fe_cswap(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core32_Curve25519_Fe, b i64) {
	mut var_f_mutated := var_f
	mut var_g_mutated := var_g
	mut b_mutated := b
	mut var_f0 := rt.new_int((rt.call_method(var_f_mutated.array_get(rt.new_int(0)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_f1 := rt.new_int((rt.call_method(var_f_mutated.array_get(rt.new_int(1)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_f2 := rt.new_int((rt.call_method(var_f_mutated.array_get(rt.new_int(2)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_f3 := rt.new_int((rt.call_method(var_f_mutated.array_get(rt.new_int(3)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_f4 := rt.new_int((rt.call_method(var_f_mutated.array_get(rt.new_int(4)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_f5 := rt.new_int((rt.call_method(var_f_mutated.array_get(rt.new_int(5)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_f6 := rt.new_int((rt.call_method(var_f_mutated.array_get(rt.new_int(6)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_f7 := rt.new_int((rt.call_method(var_f_mutated.array_get(rt.new_int(7)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_f8 := rt.new_int((rt.call_method(var_f_mutated.array_get(rt.new_int(8)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_f9 := rt.new_int((rt.call_method(var_f_mutated.array_get(rt.new_int(9)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_g0 := rt.new_int((rt.call_method(var_g_mutated.array_get(rt.new_int(0)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_g1 := rt.new_int((rt.call_method(var_g_mutated.array_get(rt.new_int(1)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_g2 := rt.new_int((rt.call_method(var_g_mutated.array_get(rt.new_int(2)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_g3 := rt.new_int((rt.call_method(var_g_mutated.array_get(rt.new_int(3)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_g4 := rt.new_int((rt.call_method(var_g_mutated.array_get(rt.new_int(4)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_g5 := rt.new_int((rt.call_method(var_g_mutated.array_get(rt.new_int(5)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_g6 := rt.new_int((rt.call_method(var_g_mutated.array_get(rt.new_int(6)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_g7 := rt.new_int((rt.call_method(var_g_mutated.array_get(rt.new_int(7)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_g8 := rt.new_int((rt.call_method(var_g_mutated.array_get(rt.new_int(8)), 'toInt', []rt.PhpVal{})).to_i64())
	mut var_g9 := rt.new_int((rt.call_method(var_g_mutated.array_get(rt.new_int(9)), 'toInt', []rt.PhpVal{})).to_i64())
	b_mutated = -b_mutated
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
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_0 := iife_temp_0.fromint(rt.new_int(rt.bitwise_xor(var_f0, var_x0)))
	var_f_mutated.array_set(0, iife_result_0)
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_1 := iife_temp_1.fromint(rt.new_int(rt.bitwise_xor(var_f1, var_x1)))
	var_f_mutated.array_set(1, iife_result_1)
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_2 := iife_temp_2.fromint(rt.new_int(rt.bitwise_xor(var_f2, var_x2)))
	var_f_mutated.array_set(2, iife_result_2)
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_3 := iife_temp_3.fromint(rt.new_int(rt.bitwise_xor(var_f3, var_x3)))
	var_f_mutated.array_set(3, iife_result_3)
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_4 := iife_temp_4.fromint(rt.new_int(rt.bitwise_xor(var_f4, var_x4)))
	var_f_mutated.array_set(4, iife_result_4)
	mut iife_temp_5 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_5 := iife_temp_5.fromint(rt.new_int(rt.bitwise_xor(var_f5, var_x5)))
	var_f_mutated.array_set(5, iife_result_5)
	mut iife_temp_6 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_6 := iife_temp_6.fromint(rt.new_int(rt.bitwise_xor(var_f6, var_x6)))
	var_f_mutated.array_set(6, iife_result_6)
	mut iife_temp_7 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_7 := iife_temp_7.fromint(rt.new_int(rt.bitwise_xor(var_f7, var_x7)))
	var_f_mutated.array_set(7, iife_result_7)
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_8 := iife_temp_8.fromint(rt.new_int(rt.bitwise_xor(var_f8, var_x8)))
	var_f_mutated.array_set(8, iife_result_8)
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_9 := iife_temp_9.fromint(rt.new_int(rt.bitwise_xor(var_f9, var_x9)))
	var_f_mutated.array_set(9, iife_result_9)
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_10 := iife_temp_10.fromint(rt.new_int(rt.bitwise_xor(var_g0, var_x0)))
	var_g_mutated.array_set(0, iife_result_10)
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_11 := iife_temp_11.fromint(rt.new_int(rt.bitwise_xor(var_g1, var_x1)))
	var_g_mutated.array_set(1, iife_result_11)
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_12 := iife_temp_12.fromint(rt.new_int(rt.bitwise_xor(var_g2, var_x2)))
	var_g_mutated.array_set(2, iife_result_12)
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_13 := iife_temp_13.fromint(rt.new_int(rt.bitwise_xor(var_g3, var_x3)))
	var_g_mutated.array_set(3, iife_result_13)
	mut iife_temp_14 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_14 := iife_temp_14.fromint(rt.new_int(rt.bitwise_xor(var_g4, var_x4)))
	var_g_mutated.array_set(4, iife_result_14)
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_15 := iife_temp_15.fromint(rt.new_int(rt.bitwise_xor(var_g5, var_x5)))
	var_g_mutated.array_set(5, iife_result_15)
	mut iife_temp_16 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_16 := iife_temp_16.fromint(rt.new_int(rt.bitwise_xor(var_g6, var_x6)))
	var_g_mutated.array_set(6, iife_result_16)
	mut iife_temp_17 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_17 := iife_temp_17.fromint(rt.new_int(rt.bitwise_xor(var_g7, var_x7)))
	var_g_mutated.array_set(7, iife_result_17)
	mut iife_temp_18 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_18 := iife_temp_18.fromint(rt.new_int(rt.bitwise_xor(var_g8, var_x8)))
	var_g_mutated.array_set(8, iife_result_18)
	mut iife_temp_19 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_19 := iife_temp_19.fromint(rt.new_int(rt.bitwise_xor(var_g9, var_x9)))
	var_g_mutated.array_set(9, iife_result_19)
}

fn Class_ParagonIE_Sodium_Core32_X25519.fe_mul121666(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	mut var_h := rt.new_array()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
		var_h.array_set(var_i, rt.call_method(rt.call_method(var_f_mutated.array_get(var_i), 'toInt64', []rt.PhpVal{}), 'mulInt', [rt.new_int(121666), rt.new_int(17)]))
		rt.pre_inc(var_i)
	}
	mut var_carry9 := rt.call_method(rt.call_method(var_h.array_get(rt.new_int(9)), 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h.array_set(0, rt.call_method(var_h.array_get(rt.new_int(0)), 'addInt64', [rt.call_method(var_carry9, 'mulInt', [rt.new_int(19), rt.new_int(5)])]))
	var_h.array_set(9, rt.call_method(var_h.array_get(rt.new_int(9)), 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry1 := rt.call_method(rt.call_method(var_h.array_get(rt.new_int(1)), 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h.array_set(2, rt.call_method(var_h.array_get(rt.new_int(2)), 'addInt64', [var_carry1.clone()]))
	var_h.array_set(1, rt.call_method(var_h.array_get(rt.new_int(1)), 'subInt64', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry3 := rt.call_method(rt.call_method(var_h.array_get(rt.new_int(3)), 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h.array_set(4, rt.call_method(var_h.array_get(rt.new_int(4)), 'addInt64', [var_carry3.clone()]))
	var_h.array_set(3, rt.call_method(var_h.array_get(rt.new_int(3)), 'subInt64', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry5 := rt.call_method(rt.call_method(var_h.array_get(rt.new_int(5)), 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h.array_set(6, rt.call_method(var_h.array_get(rt.new_int(6)), 'addInt64', [var_carry5.clone()]))
	var_h.array_set(5, rt.call_method(var_h.array_get(rt.new_int(5)), 'subInt64', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry7 := rt.call_method(rt.call_method(var_h.array_get(rt.new_int(7)), 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h.array_set(8, rt.call_method(var_h.array_get(rt.new_int(8)), 'addInt64', [var_carry7.clone()]))
	var_h.array_set(7, rt.call_method(var_h.array_get(rt.new_int(7)), 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry0 := rt.call_method(rt.call_method(var_h.array_get(rt.new_int(0)), 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h.array_set(1, rt.call_method(var_h.array_get(rt.new_int(1)), 'addInt64', [var_carry0.clone()]))
	var_h.array_set(0, rt.call_method(var_h.array_get(rt.new_int(0)), 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry2 := rt.call_method(rt.call_method(var_h.array_get(rt.new_int(2)), 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h.array_set(3, rt.call_method(var_h.array_get(rt.new_int(3)), 'addInt64', [var_carry2.clone()]))
	var_h.array_set(2, rt.call_method(var_h.array_get(rt.new_int(2)), 'subInt64', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry4 := rt.call_method(rt.call_method(var_h.array_get(rt.new_int(4)), 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h.array_set(5, rt.call_method(var_h.array_get(rt.new_int(5)), 'addInt64', [var_carry4.clone()]))
	var_h.array_set(4, rt.call_method(var_h.array_get(rt.new_int(4)), 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry6 := rt.call_method(rt.call_method(var_h.array_get(rt.new_int(6)), 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h.array_set(7, rt.call_method(var_h.array_get(rt.new_int(7)), 'addInt64', [var_carry6.clone()]))
	var_h.array_set(6, rt.call_method(var_h.array_get(rt.new_int(6)), 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry8 := rt.call_method(rt.call_method(var_h.array_get(rt.new_int(8)), 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h.array_set(9, rt.call_method(var_h.array_get(rt.new_int(9)), 'addInt64', [var_carry8.clone()]))
	var_h.array_set(8, rt.call_method(var_h.array_get(rt.new_int(8)), 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(26)])]))
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
		var_h.array_set(var_i, rt.call_method(var_h.array_get(var_i), 'toInt32', []rt.PhpVal{}))
		rt.pre_inc(var_i)
	}
	mut var_h2 := var_h.clone()
	mut iife_temp_20 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
	mut iife_result_20 := iife_temp_20.fromarray(var_h2.clone())
	return iife_result_20
}

fn Class_ParagonIE_Sodium_Core32_X25519.crypto_scalarmult_curve25519_ref10(var_n rt.PhpVal, var_p rt.PhpVal) string {
	mut var_e := rt.new_string('' + (var_n).str())
	mut iife_temp_21 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_21 := iife_temp_21.chrtoint(var_e.array_get(rt.new_int(0)))
	mut iife_temp_22 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_22 := iife_temp_22.inttochr(rt.new_int(rt.bitwise_and(iife_result_21, rt.new_int(248))))
	var_e.array_set(0, iife_result_22)
	mut iife_temp_23 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_23 := iife_temp_23.chrtoint(var_e.array_get(rt.new_int(31)))
	mut iife_temp_24 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_24 := iife_temp_24.inttochr(rt.new_int(rt.bitwise_and(iife_result_23, rt.new_int(127)) | 64))
	var_e.array_set(31, iife_result_24)
	mut iife_temp_25 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_25 := iife_temp_25.fe_frombytes(var_p.clone())
	mut var_x1 := iife_result_25
	mut iife_temp_26 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_26 := iife_temp_26.fe_1()
	mut var_x2 := iife_result_26
	mut iife_temp_27 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_27 := iife_temp_27.fe_0()
	mut var_z2 := iife_result_27
	mut iife_temp_28 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_28 := iife_temp_28.fe_copy(var_x1.clone())
	mut var_x3 := iife_result_28
	mut iife_temp_29 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_29 := iife_temp_29.fe_1()
	mut var_z3 := iife_result_29
	mut var_swap := rt.new_int(0)
	mut var_pos := rt.new_int(254)
	for {
		if !(rt.is_true(rt.greater_equal(var_pos, rt.new_int(0)))) { break }
		mut iife_temp_30 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_30 := iife_temp_30.chrtoint(var_e.array_get(rt.new_int((rt.call_function('floor', [rt.div(var_pos, rt.new_int(8))])).to_i64())))
		mut var_b := rt.new_int(rt.shift_right(iife_result_30, rt.bitwise_and(var_pos, rt.new_int(7))))
		rt.new_null()
		rt.new_null()
		Class_ParagonIE_Sodium_Core32_X25519.fe_cswap(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_x2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_x3), (var_swap).to_i64())
		Class_ParagonIE_Sodium_Core32_X25519.fe_cswap(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_z2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_z3), (var_swap).to_i64())
		var_swap = var_b.clone()
		mut iife_temp_31 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_31 := iife_temp_31.fe_sub(var_x3.clone(), var_z3.clone())
		mut var_tmp0 := iife_result_31
		mut iife_temp_32 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_32 := iife_temp_32.fe_sub(var_x2.clone(), var_z2.clone())
		mut var_tmp1 := iife_result_32
		mut iife_temp_33 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_33 := iife_temp_33.fe_add(var_x2.clone(), var_z2.clone())
		var_x2 = iife_result_33
		mut iife_temp_34 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_34 := iife_temp_34.fe_add(var_x3.clone(), var_z3.clone())
		var_z2 = iife_result_34
		mut iife_temp_35 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_35 := iife_temp_35.fe_mul(var_tmp0.clone(), var_x2.clone())
		var_z3 = iife_result_35
		mut iife_temp_36 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_36 := iife_temp_36.fe_mul(var_z2.clone(), var_tmp1.clone())
		var_z2 = iife_result_36
		mut iife_temp_37 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_37 := iife_temp_37.fe_sq(var_tmp1.clone())
		var_tmp0 = iife_result_37
		mut iife_temp_38 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_38 := iife_temp_38.fe_sq(var_x2.clone())
		var_tmp1 = iife_result_38
		mut iife_temp_39 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_39 := iife_temp_39.fe_add(var_z3.clone(), var_z2.clone())
		var_x3 = iife_result_39
		mut iife_temp_40 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_40 := iife_temp_40.fe_sub(var_z3.clone(), var_z2.clone())
		var_z2 = iife_result_40
		mut iife_temp_41 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_41 := iife_temp_41.fe_mul(var_tmp1.clone(), var_tmp0.clone())
		var_x2 = iife_result_41
		mut iife_temp_42 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_42 := iife_temp_42.fe_sub(var_tmp1.clone(), var_tmp0.clone())
		var_tmp1 = iife_result_42
		mut iife_temp_43 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_43 := iife_temp_43.fe_sq(var_z2.clone())
		var_z2 = iife_result_43
		var_z3 = Class_ParagonIE_Sodium_Core32_X25519.fe_mul121666(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_tmp1))
		mut iife_temp_44 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_44 := iife_temp_44.fe_sq(var_x3.clone())
		var_x3 = iife_result_44
		mut iife_temp_45 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_45 := iife_temp_45.fe_add(var_tmp0.clone(), var_z3.clone())
		var_tmp0 = iife_result_45
		mut iife_temp_46 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_46 := iife_temp_46.fe_mul(var_x1.clone(), var_z2.clone())
		var_z3 = iife_result_46
		mut iife_temp_47 := Class_ParagonIE_Sodium_Core32_X25519{}
		mut iife_result_47 := iife_temp_47.fe_mul(var_tmp1.clone(), var_tmp0.clone())
		var_z2 = iife_result_47
		rt.pre_dec(var_pos)
	}
	Class_ParagonIE_Sodium_Core32_X25519.fe_cswap(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_x2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_x3), (var_swap).to_i64())
	Class_ParagonIE_Sodium_Core32_X25519.fe_cswap(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_z2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_z3), (var_swap).to_i64())
	mut iife_temp_48 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_48 := iife_temp_48.fe_invert(var_z2.clone())
	mut var_z2 := iife_result_48
	mut iife_temp_49 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_49 := iife_temp_49.fe_mul(var_x2.clone(), var_z2.clone())
	mut var_x2 := iife_result_49
	mut iife_temp_50 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_50 := iife_temp_50.fe_tobytes(var_x2.clone())
	return (iife_result_50).str()
}

fn Class_ParagonIE_Sodium_Core32_X25519.edwards_to_montgomery(mut var_edwardsY Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_edwardsZ Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut iife_temp_51 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_51 := iife_temp_51.fe_add(rt.new_object('ParagonIE_Sodium_Core32_Curve25519_Fe', []string{}, var_edwardsZ), rt.new_object('ParagonIE_Sodium_Core32_Curve25519_Fe', []string{}, var_edwardsY))
	mut var_tempX := iife_result_51
	mut iife_temp_52 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_52 := iife_temp_52.fe_sub(rt.new_object('ParagonIE_Sodium_Core32_Curve25519_Fe', []string{}, var_edwardsZ), rt.new_object('ParagonIE_Sodium_Core32_Curve25519_Fe', []string{}, var_edwardsY))
	mut var_tempZ := iife_result_52
	mut iife_temp_53 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_53 := iife_temp_53.fe_invert(var_tempZ.clone())
	var_tempZ = iife_result_53
	mut iife_temp_54 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_54 := iife_temp_54.fe_mul(var_tempX.clone(), var_tempZ.clone())
	return iife_result_54
}

fn Class_ParagonIE_Sodium_Core32_X25519.crypto_scalarmult_curve25519_ref10_base(var_n rt.PhpVal) rt.PhpVal {
	mut var_e := rt.new_string('' + (var_n).str())
	mut iife_temp_55 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_55 := iife_temp_55.chrtoint(var_e.array_get(rt.new_int(0)))
	mut iife_temp_56 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_56 := iife_temp_56.inttochr(rt.new_int(rt.bitwise_and(iife_result_55, rt.new_int(248))))
	var_e.array_set(0, iife_result_56)
	mut iife_temp_57 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_57 := iife_temp_57.chrtoint(var_e.array_get(rt.new_int(31)))
	mut iife_temp_58 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_58 := iife_temp_58.inttochr(rt.new_int(rt.bitwise_and(iife_result_57, rt.new_int(127)) | 64))
	var_e.array_set(31, iife_result_58)
	mut iife_temp_59 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_59 := iife_temp_59.ge_scalarmult_base(var_e.clone())
	mut var_A := iife_result_59
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(var_A, 'Y'), 'ParagonIE_Sodium_Core32_Curve25519_Fe')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(var_A, 'Z'), 'ParagonIE_Sodium_Core32_Curve25519_Fe')))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Null points encountered'))))
	}
	mut var_pk := Class_ParagonIE_Sodium_Core32_X25519.edwards_to_montgomery(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_A, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_A, 'Z')))
	mut iife_temp_60 := Class_ParagonIE_Sodium_Core32_X25519{}
	mut iife_result_60 := iife_temp_60.fe_tobytes(var_pk.clone())
	return iife_result_60
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

struct Class_TypeError {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_x25519(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_X25519 {
	mut obj := &Class_ParagonIE_Sodium_Core32_X25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_curve25519(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Curve25519 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_int32(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Int32 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Int32{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_curve25519_fe(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Curve25519_Fe {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519_Fe{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_typeerror(_args ...rt.PhpVal) &Class_TypeError {
	mut obj := &Class_TypeError{
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
			return rt.new_string(Class_ParagonIE_Sodium_Core32_X25519.crypto_scalarmult_curve25519_ref10(dispatch_arg_0, dispatch_arg_1))
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


fn (mut this Class_TypeError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_TypeError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_TypeError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core32_X25519'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
