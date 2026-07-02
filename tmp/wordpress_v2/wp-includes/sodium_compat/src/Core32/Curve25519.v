import rt

struct Class_ParagonIE_Sodium_Core32_Curve25519 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_0() rt.PhpVal {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
	mut iife_result_0 := iife_temp_0.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }]))
	return iife_result_0
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_1() rt.PhpVal {
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_1 := iife_temp_1.fromint(rt.new_int(1))
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
	mut iife_result_2 := iife_temp_2.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: iife_result_1 }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }]))
	return iife_result_2
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	mut var_arr := rt.new_array()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
		var_arr.array_set(var_i, rt.call_method(var_f_mutated.array_get(var_i), 'addInt32', [var_g.array_get(var_i)]))
		rt.pre_inc(var_i)
	}
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
	mut iife_result_3 := iife_temp_3.fromarray(var_arr.clone())
	return iife_result_3
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_cmov(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core32_Curve25519_Fe, b i64) rt.PhpVal {
	mut var_f_mutated := var_f
	mut b_mutated := b
	mut var_h := rt.new_array()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_f_mutated.array_get(var_i), 'ParagonIE_Sodium_Core32_Int32')))))) {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Expected Int32'))))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_g.array_get(var_i), 'ParagonIE_Sodium_Core32_Int32')))))) {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Expected Int32'))))
		}
		var_h.array_set(var_i, rt.call_method(var_f_mutated.array_get(var_i), 'xorInt32', [rt.call_method(rt.call_method(var_f_mutated.array_get(var_i), 'xorInt32', [var_g.array_get(var_i)]), 'mask', [rt.new_int(b_mutated).clone()])]))
		rt.pre_inc(var_i)
	}
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
	mut iife_result_4 := iife_temp_4.fromarray(var_h.clone())
	return iife_result_4
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_copy(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	mut var_h := var_f_mutated.dup()
	return var_h.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_frombytes(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
	mut iife_temp_5 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_5 := iife_temp_5.strlen(var_s_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_5, rt.new_int(32))))) {
		rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(rt.new_string('Expected a 32-byte string.'))))
	}
	mut iife_temp_6 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_6 := iife_temp_6.load_4(var_s_mutated.clone())
	mut iife_temp_7 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_7 := iife_temp_7.fromint(iife_result_6)
	mut var_h0 := iife_result_7
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_8 := iife_temp_8.substr(var_s_mutated.clone(), rt.new_int(4), rt.new_int(3))
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_9 := iife_temp_9.load_3(iife_result_8)
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_10 := iife_temp_10.fromint(rt.new_int(rt.shift_left(iife_result_9, rt.new_int(6))))
	mut var_h1 := iife_result_10
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_11 := iife_temp_11.substr(var_s_mutated.clone(), rt.new_int(7), rt.new_int(3))
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_12 := iife_temp_12.load_3(iife_result_11)
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_13 := iife_temp_13.fromint(rt.new_int(rt.shift_left(iife_result_12, rt.new_int(5))))
	mut var_h2 := iife_result_13
	mut iife_temp_14 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_14 := iife_temp_14.substr(var_s_mutated.clone(), rt.new_int(10), rt.new_int(3))
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_15 := iife_temp_15.load_3(iife_result_14)
	mut iife_temp_16 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_16 := iife_temp_16.fromint(rt.new_int(rt.shift_left(iife_result_15, rt.new_int(3))))
	mut var_h3 := iife_result_16
	mut iife_temp_17 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_17 := iife_temp_17.substr(var_s_mutated.clone(), rt.new_int(13), rt.new_int(3))
	mut iife_temp_18 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_18 := iife_temp_18.load_3(iife_result_17)
	mut iife_temp_19 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_19 := iife_temp_19.fromint(rt.new_int(rt.shift_left(iife_result_18, rt.new_int(2))))
	mut var_h4 := iife_result_19
	mut iife_temp_20 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_20 := iife_temp_20.substr(var_s_mutated.clone(), rt.new_int(16), rt.new_int(4))
	mut iife_temp_21 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_21 := iife_temp_21.load_4(iife_result_20)
	mut iife_temp_22 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_22 := iife_temp_22.fromint(iife_result_21)
	mut var_h5 := iife_result_22
	mut iife_temp_23 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_23 := iife_temp_23.substr(var_s_mutated.clone(), rt.new_int(20), rt.new_int(3))
	mut iife_temp_24 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_24 := iife_temp_24.load_3(iife_result_23)
	mut iife_temp_25 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_25 := iife_temp_25.fromint(rt.new_int(rt.shift_left(iife_result_24, rt.new_int(7))))
	mut var_h6 := iife_result_25
	mut iife_temp_26 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_26 := iife_temp_26.substr(var_s_mutated.clone(), rt.new_int(23), rt.new_int(3))
	mut iife_temp_27 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_27 := iife_temp_27.load_3(iife_result_26)
	mut iife_temp_28 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_28 := iife_temp_28.fromint(rt.new_int(rt.shift_left(iife_result_27, rt.new_int(5))))
	mut var_h7 := iife_result_28
	mut iife_temp_29 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_29 := iife_temp_29.substr(var_s_mutated.clone(), rt.new_int(26), rt.new_int(3))
	mut iife_temp_30 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_30 := iife_temp_30.load_3(iife_result_29)
	mut iife_temp_31 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_31 := iife_temp_31.fromint(rt.new_int(rt.shift_left(iife_result_30, rt.new_int(4))))
	mut var_h8 := iife_result_31
	mut iife_temp_32 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_32 := iife_temp_32.substr(var_s_mutated.clone(), rt.new_int(29), rt.new_int(3))
	mut iife_temp_33 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_33 := iife_temp_33.load_3(iife_result_32)
	mut iife_temp_34 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_34 := iife_temp_34.fromint(rt.new_int(rt.bitwise_and(iife_result_33, rt.new_int(8388607)) << 2))
	mut var_h9 := iife_result_34
	mut var_carry9 := rt.call_method(rt.call_method(var_h9, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h0 = rt.call_method(var_h0, 'addInt32', [rt.call_method(var_carry9, 'mulInt', [rt.new_int(19), rt.new_int(5)])])
	var_h9 = rt.call_method(var_h9, 'subInt32', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry1 := rt.call_method(rt.call_method(var_h1, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h2 = rt.call_method(var_h2, 'addInt32', [var_carry1.clone()])
	var_h1 = rt.call_method(var_h1, 'subInt32', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry3 := rt.call_method(rt.call_method(var_h3, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h4 = rt.call_method(var_h4, 'addInt32', [var_carry3.clone()])
	var_h3 = rt.call_method(var_h3, 'subInt32', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry5 := rt.call_method(rt.call_method(var_h5, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h6 = rt.call_method(var_h6, 'addInt32', [var_carry5.clone()])
	var_h5 = rt.call_method(var_h5, 'subInt32', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry7 := rt.call_method(rt.call_method(var_h7, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h8 = rt.call_method(var_h8, 'addInt32', [var_carry7.clone()])
	var_h7 = rt.call_method(var_h7, 'subInt32', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry0 := rt.call_method(rt.call_method(var_h0, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h1 = rt.call_method(var_h1, 'addInt32', [var_carry0.clone()])
	var_h0 = rt.call_method(var_h0, 'subInt32', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry2 := rt.call_method(rt.call_method(var_h2, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h3 = rt.call_method(var_h3, 'addInt32', [var_carry2.clone()])
	var_h2 = rt.call_method(var_h2, 'subInt32', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry4 := rt.call_method(rt.call_method(var_h4, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h5 = rt.call_method(var_h5, 'addInt32', [var_carry4.clone()])
	var_h4 = rt.call_method(var_h4, 'subInt32', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry6 := rt.call_method(rt.call_method(var_h6, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h7 = rt.call_method(var_h7, 'addInt32', [var_carry6.clone()])
	var_h6 = rt.call_method(var_h6, 'subInt32', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry8 := rt.call_method(rt.call_method(var_h8, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h9 = rt.call_method(var_h9, 'addInt32', [var_carry8.clone()])
	var_h8 = rt.call_method(var_h8, 'subInt32', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(26)])])
	mut iife_temp_35 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
	mut iife_result_35 := iife_temp_35.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: var_h0 }, rt.ArrayItem{ key: none, val: var_h1 }, rt.ArrayItem{ key: none, val: var_h2 }, rt.ArrayItem{ key: none, val: var_h3 }, rt.ArrayItem{ key: none, val: var_h4 }, rt.ArrayItem{ key: none, val: var_h5 }, rt.ArrayItem{ key: none, val: var_h6 }, rt.ArrayItem{ key: none, val: var_h7 }, rt.ArrayItem{ key: none, val: var_h8 }, rt.ArrayItem{ key: none, val: var_h9 }]))
	return iife_result_35
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_tobytes(mut var_h Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_h_mutated := var_h
	mut var_f := rt.new_array()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
		var_f.array_set(var_i, rt.call_method(var_h_mutated.array_get(var_i), 'toInt64', []rt.PhpVal{}))
		rt.pre_inc(var_i)
	}
	mut var_q := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f.array_get(rt.new_int(9)), 'mulInt', [rt.new_int(19), rt.new_int(5)]), 'addInt', [rt.new_int(1 << 14)]), 'shiftRight', [rt.new_int(25)]), 'addInt64', [var_f.array_get(rt.new_int(0))]), 'shiftRight', [rt.new_int(26)]), 'addInt64', [var_f.array_get(rt.new_int(1))]), 'shiftRight', [rt.new_int(25)]), 'addInt64', [var_f.array_get(rt.new_int(2))]), 'shiftRight', [rt.new_int(26)]), 'addInt64', [var_f.array_get(rt.new_int(3))]), 'shiftRight', [rt.new_int(25)]), 'addInt64', [var_f.array_get(rt.new_int(4))]), 'shiftRight', [rt.new_int(26)]), 'addInt64', [var_f.array_get(rt.new_int(5))]), 'shiftRight', [rt.new_int(25)]), 'addInt64', [var_f.array_get(rt.new_int(6))]), 'shiftRight', [rt.new_int(26)]), 'addInt64', [var_f.array_get(rt.new_int(7))]), 'shiftRight', [rt.new_int(25)]), 'addInt64', [var_f.array_get(rt.new_int(8))]), 'shiftRight', [rt.new_int(26)]), 'addInt64', [var_f.array_get(rt.new_int(9))]), 'shiftRight', [rt.new_int(25)])
	var_f.array_set(0, rt.call_method(var_f.array_get(rt.new_int(0)), 'addInt64', [rt.call_method(var_q, 'mulInt', [rt.new_int(19), rt.new_int(5)])]))
	mut var_carry0 := rt.call_method(var_f.array_get(rt.new_int(0)), 'shiftRight', [rt.new_int(26)])
	var_f.array_set(1, rt.call_method(var_f.array_get(rt.new_int(1)), 'addInt64', [var_carry0.clone()]))
	var_f.array_set(0, rt.call_method(var_f.array_get(rt.new_int(0)), 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry1 := rt.call_method(var_f.array_get(rt.new_int(1)), 'shiftRight', [rt.new_int(25)])
	var_f.array_set(2, rt.call_method(var_f.array_get(rt.new_int(2)), 'addInt64', [var_carry1.clone()]))
	var_f.array_set(1, rt.call_method(var_f.array_get(rt.new_int(1)), 'subInt64', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry2 := rt.call_method(var_f.array_get(rt.new_int(2)), 'shiftRight', [rt.new_int(26)])
	var_f.array_set(3, rt.call_method(var_f.array_get(rt.new_int(3)), 'addInt64', [var_carry2.clone()]))
	var_f.array_set(2, rt.call_method(var_f.array_get(rt.new_int(2)), 'subInt64', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry3 := rt.call_method(var_f.array_get(rt.new_int(3)), 'shiftRight', [rt.new_int(25)])
	var_f.array_set(4, rt.call_method(var_f.array_get(rt.new_int(4)), 'addInt64', [var_carry3.clone()]))
	var_f.array_set(3, rt.call_method(var_f.array_get(rt.new_int(3)), 'subInt64', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry4 := rt.call_method(var_f.array_get(rt.new_int(4)), 'shiftRight', [rt.new_int(26)])
	var_f.array_set(5, rt.call_method(var_f.array_get(rt.new_int(5)), 'addInt64', [var_carry4.clone()]))
	var_f.array_set(4, rt.call_method(var_f.array_get(rt.new_int(4)), 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry5 := rt.call_method(var_f.array_get(rt.new_int(5)), 'shiftRight', [rt.new_int(25)])
	var_f.array_set(6, rt.call_method(var_f.array_get(rt.new_int(6)), 'addInt64', [var_carry5.clone()]))
	var_f.array_set(5, rt.call_method(var_f.array_get(rt.new_int(5)), 'subInt64', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry6 := rt.call_method(var_f.array_get(rt.new_int(6)), 'shiftRight', [rt.new_int(26)])
	var_f.array_set(7, rt.call_method(var_f.array_get(rt.new_int(7)), 'addInt64', [var_carry6.clone()]))
	var_f.array_set(6, rt.call_method(var_f.array_get(rt.new_int(6)), 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry7 := rt.call_method(var_f.array_get(rt.new_int(7)), 'shiftRight', [rt.new_int(25)])
	var_f.array_set(8, rt.call_method(var_f.array_get(rt.new_int(8)), 'addInt64', [var_carry7.clone()]))
	var_f.array_set(7, rt.call_method(var_f.array_get(rt.new_int(7)), 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry8 := rt.call_method(var_f.array_get(rt.new_int(8)), 'shiftRight', [rt.new_int(26)])
	var_f.array_set(9, rt.call_method(var_f.array_get(rt.new_int(9)), 'addInt64', [var_carry8.clone()]))
	var_f.array_set(8, rt.call_method(var_f.array_get(rt.new_int(8)), 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry9 := rt.call_method(var_f.array_get(rt.new_int(9)), 'shiftRight', [rt.new_int(25)])
	var_f.array_set(9, rt.call_method(var_f.array_get(rt.new_int(9)), 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(25)])]))
	mut var_h0 := rt.call_method(rt.call_method(var_f.array_get(rt.new_int(0)), 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_h1 := rt.call_method(rt.call_method(var_f.array_get(rt.new_int(1)), 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_h2 := rt.call_method(rt.call_method(var_f.array_get(rt.new_int(2)), 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_h3 := rt.call_method(rt.call_method(var_f.array_get(rt.new_int(3)), 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_h4 := rt.call_method(rt.call_method(var_f.array_get(rt.new_int(4)), 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_h5 := rt.call_method(rt.call_method(var_f.array_get(rt.new_int(5)), 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_h6 := rt.call_method(rt.call_method(var_f.array_get(rt.new_int(6)), 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_h7 := rt.call_method(rt.call_method(var_f.array_get(rt.new_int(7)), 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_h8 := rt.call_method(rt.call_method(var_f.array_get(rt.new_int(8)), 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_h9 := rt.call_method(rt.call_method(var_f.array_get(rt.new_int(9)), 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_s := rt.create_array([rt.ArrayItem{ key: none, val: rt.shift_right(var_h0, rt.new_int(0)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h0, rt.new_int(8)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h0, rt.new_int(16)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h0, rt.new_int(24)) | rt.shift_left(var_h1, rt.new_int(2)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h1, rt.new_int(6)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h1, rt.new_int(14)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h1, rt.new_int(22)) | rt.shift_left(var_h2, rt.new_int(3)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h2, rt.new_int(5)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h2, rt.new_int(13)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h2, rt.new_int(21)) | rt.shift_left(var_h3, rt.new_int(5)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h3, rt.new_int(3)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h3, rt.new_int(11)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h3, rt.new_int(19)) | rt.shift_left(var_h4, rt.new_int(6)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h4, rt.new_int(2)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h4, rt.new_int(10)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h4, rt.new_int(18)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h5, rt.new_int(0)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h5, rt.new_int(8)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h5, rt.new_int(16)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h5, rt.new_int(24)) | rt.shift_left(var_h6, rt.new_int(1)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h6, rt.new_int(7)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h6, rt.new_int(15)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h6, rt.new_int(23)) | rt.shift_left(var_h7, rt.new_int(3)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h7, rt.new_int(5)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h7, rt.new_int(13)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h7, rt.new_int(21)) | rt.shift_left(var_h8, rt.new_int(4)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h8, rt.new_int(4)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h8, rt.new_int(12)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h8, rt.new_int(20)) | rt.shift_left(var_h9, rt.new_int(6)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h9, rt.new_int(2)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h9, rt.new_int(10)) & 255 }, rt.ArrayItem{ key: none, val: rt.shift_right(var_h9, rt.new_int(18)) & 255 }])
	mut iife_temp_36 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_36 := iife_temp_36.intarraytostring(var_s.clone())
	return iife_result_36
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_isnegative(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe) i64 {
	mut var_f_mutated := var_f
	mut var_str := Class_ParagonIE_Sodium_Core32_Curve25519.fe_tobytes(mut var_f_mutated)
	mut iife_temp_37 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_37 := iife_temp_37.chrtoint(var_str.array_get(rt.new_int(0)))
	return rt.bitwise_and(iife_result_37, rt.new_int(1))
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_isnonzero(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe) bool {
	mut var_f_mutated := var_f
	mut var_zero := rt.new_null()
	if rt.is_true(rt.identical(var_zero, rt.new_null())) {
	var_zero = rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(32)])
	}
	mut var_str := Class_ParagonIE_Sodium_Core32_Curve25519.fe_tobytes(mut var_f_mutated)
	mut iife_temp_38 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_38 := iife_temp_38.verify_32(var_str.clone(), var_zero.clone())
	return !(rt.is_true(iife_result_38))
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	mut var_f0 := rt.call_method(var_f_mutated.array_get(rt.new_int(0)), 'toInt64', []rt.PhpVal{})
	mut var_f1 := rt.call_method(var_f_mutated.array_get(rt.new_int(1)), 'toInt64', []rt.PhpVal{})
	mut var_f2 := rt.call_method(var_f_mutated.array_get(rt.new_int(2)), 'toInt64', []rt.PhpVal{})
	mut var_f3 := rt.call_method(var_f_mutated.array_get(rt.new_int(3)), 'toInt64', []rt.PhpVal{})
	mut var_f4 := rt.call_method(var_f_mutated.array_get(rt.new_int(4)), 'toInt64', []rt.PhpVal{})
	mut var_f5 := rt.call_method(var_f_mutated.array_get(rt.new_int(5)), 'toInt64', []rt.PhpVal{})
	mut var_f6 := rt.call_method(var_f_mutated.array_get(rt.new_int(6)), 'toInt64', []rt.PhpVal{})
	mut var_f7 := rt.call_method(var_f_mutated.array_get(rt.new_int(7)), 'toInt64', []rt.PhpVal{})
	mut var_f8 := rt.call_method(var_f_mutated.array_get(rt.new_int(8)), 'toInt64', []rt.PhpVal{})
	mut var_f9 := rt.call_method(var_f_mutated.array_get(rt.new_int(9)), 'toInt64', []rt.PhpVal{})
	mut var_g0 := rt.call_method(var_g.array_get(rt.new_int(0)), 'toInt64', []rt.PhpVal{})
	mut var_g1 := rt.call_method(var_g.array_get(rt.new_int(1)), 'toInt64', []rt.PhpVal{})
	mut var_g2 := rt.call_method(var_g.array_get(rt.new_int(2)), 'toInt64', []rt.PhpVal{})
	mut var_g3 := rt.call_method(var_g.array_get(rt.new_int(3)), 'toInt64', []rt.PhpVal{})
	mut var_g4 := rt.call_method(var_g.array_get(rt.new_int(4)), 'toInt64', []rt.PhpVal{})
	mut var_g5 := rt.call_method(var_g.array_get(rt.new_int(5)), 'toInt64', []rt.PhpVal{})
	mut var_g6 := rt.call_method(var_g.array_get(rt.new_int(6)), 'toInt64', []rt.PhpVal{})
	mut var_g7 := rt.call_method(var_g.array_get(rt.new_int(7)), 'toInt64', []rt.PhpVal{})
	mut var_g8 := rt.call_method(var_g.array_get(rt.new_int(8)), 'toInt64', []rt.PhpVal{})
	mut var_g9 := rt.call_method(var_g.array_get(rt.new_int(9)), 'toInt64', []rt.PhpVal{})
	mut var_g1_19 := rt.call_method(var_g1, 'mulInt', [rt.new_int(19), rt.new_int(5)])
	mut var_g2_19 := rt.call_method(var_g2, 'mulInt', [rt.new_int(19), rt.new_int(5)])
	mut var_g3_19 := rt.call_method(var_g3, 'mulInt', [rt.new_int(19), rt.new_int(5)])
	mut var_g4_19 := rt.call_method(var_g4, 'mulInt', [rt.new_int(19), rt.new_int(5)])
	mut var_g5_19 := rt.call_method(var_g5, 'mulInt', [rt.new_int(19), rt.new_int(5)])
	mut var_g6_19 := rt.call_method(var_g6, 'mulInt', [rt.new_int(19), rt.new_int(5)])
	mut var_g7_19 := rt.call_method(var_g7, 'mulInt', [rt.new_int(19), rt.new_int(5)])
	mut var_g8_19 := rt.call_method(var_g8, 'mulInt', [rt.new_int(19), rt.new_int(5)])
	mut var_g9_19 := rt.call_method(var_g9, 'mulInt', [rt.new_int(19), rt.new_int(5)])
	mut var_f1_2 := rt.call_method(var_f1, 'shiftLeft', [rt.new_int(1)])
	mut var_f3_2 := rt.call_method(var_f3, 'shiftLeft', [rt.new_int(1)])
	mut var_f5_2 := rt.call_method(var_f5, 'shiftLeft', [rt.new_int(1)])
	mut var_f7_2 := rt.call_method(var_f7, 'shiftLeft', [rt.new_int(1)])
	mut var_f9_2 := rt.call_method(var_f9, 'shiftLeft', [rt.new_int(1)])
	mut var_f0g0 := rt.call_method(var_f0, 'mulInt64', [var_g0.clone(), rt.new_int(27)])
	mut var_f0g1 := rt.call_method(var_f0, 'mulInt64', [var_g1.clone(), rt.new_int(27)])
	mut var_f0g2 := rt.call_method(var_f0, 'mulInt64', [var_g2.clone(), rt.new_int(27)])
	mut var_f0g3 := rt.call_method(var_f0, 'mulInt64', [var_g3.clone(), rt.new_int(27)])
	mut var_f0g4 := rt.call_method(var_f0, 'mulInt64', [var_g4.clone(), rt.new_int(27)])
	mut var_f0g5 := rt.call_method(var_f0, 'mulInt64', [var_g5.clone(), rt.new_int(27)])
	mut var_f0g6 := rt.call_method(var_f0, 'mulInt64', [var_g6.clone(), rt.new_int(27)])
	mut var_f0g7 := rt.call_method(var_f0, 'mulInt64', [var_g7.clone(), rt.new_int(27)])
	mut var_f0g8 := rt.call_method(var_f0, 'mulInt64', [var_g8.clone(), rt.new_int(27)])
	mut var_f0g9 := rt.call_method(var_f0, 'mulInt64', [var_g9.clone(), rt.new_int(27)])
	mut var_f1g0 := rt.call_method(var_f1, 'mulInt64', [var_g0.clone(), rt.new_int(27)])
	mut var_f1g1_2 := rt.call_method(var_f1_2, 'mulInt64', [var_g1.clone(), rt.new_int(27)])
	mut var_f1g2 := rt.call_method(var_f1, 'mulInt64', [var_g2.clone(), rt.new_int(27)])
	mut var_f1g3_2 := rt.call_method(var_f1_2, 'mulInt64', [var_g3.clone(), rt.new_int(27)])
	mut var_f1g4 := rt.call_method(var_f1, 'mulInt64', [var_g4.clone(), rt.new_int(30)])
	mut var_f1g5_2 := rt.call_method(var_f1_2, 'mulInt64', [var_g5.clone(), rt.new_int(30)])
	mut var_f1g6 := rt.call_method(var_f1, 'mulInt64', [var_g6.clone(), rt.new_int(30)])
	mut var_f1g7_2 := rt.call_method(var_f1_2, 'mulInt64', [var_g7.clone(), rt.new_int(30)])
	mut var_f1g8 := rt.call_method(var_f1, 'mulInt64', [var_g8.clone(), rt.new_int(30)])
	mut var_f1g9_38 := rt.call_method(var_g9_19, 'mulInt64', [var_f1_2.clone(), rt.new_int(30)])
	mut var_f2g0 := rt.call_method(var_f2, 'mulInt64', [var_g0.clone(), rt.new_int(30)])
	mut var_f2g1 := rt.call_method(var_f2, 'mulInt64', [var_g1.clone(), rt.new_int(29)])
	mut var_f2g2 := rt.call_method(var_f2, 'mulInt64', [var_g2.clone(), rt.new_int(30)])
	mut var_f2g3 := rt.call_method(var_f2, 'mulInt64', [var_g3.clone(), rt.new_int(29)])
	mut var_f2g4 := rt.call_method(var_f2, 'mulInt64', [var_g4.clone(), rt.new_int(30)])
	mut var_f2g5 := rt.call_method(var_f2, 'mulInt64', [var_g5.clone(), rt.new_int(29)])
	mut var_f2g6 := rt.call_method(var_f2, 'mulInt64', [var_g6.clone(), rt.new_int(30)])
	mut var_f2g7 := rt.call_method(var_f2, 'mulInt64', [var_g7.clone(), rt.new_int(29)])
	mut var_f2g8_19 := rt.call_method(var_g8_19, 'mulInt64', [var_f2.clone(), rt.new_int(30)])
	mut var_f2g9_19 := rt.call_method(var_g9_19, 'mulInt64', [var_f2.clone(), rt.new_int(30)])
	mut var_f3g0 := rt.call_method(var_f3, 'mulInt64', [var_g0.clone(), rt.new_int(30)])
	mut var_f3g1_2 := rt.call_method(var_f3_2, 'mulInt64', [var_g1.clone(), rt.new_int(30)])
	mut var_f3g2 := rt.call_method(var_f3, 'mulInt64', [var_g2.clone(), rt.new_int(30)])
	mut var_f3g3_2 := rt.call_method(var_f3_2, 'mulInt64', [var_g3.clone(), rt.new_int(30)])
	mut var_f3g4 := rt.call_method(var_f3, 'mulInt64', [var_g4.clone(), rt.new_int(30)])
	mut var_f3g5_2 := rt.call_method(var_f3_2, 'mulInt64', [var_g5.clone(), rt.new_int(30)])
	mut var_f3g6 := rt.call_method(var_f3, 'mulInt64', [var_g6.clone(), rt.new_int(30)])
	mut var_f3g7_38 := rt.call_method(var_g7_19, 'mulInt64', [var_f3_2.clone(), rt.new_int(30)])
	mut var_f3g8_19 := rt.call_method(var_g8_19, 'mulInt64', [var_f3.clone(), rt.new_int(30)])
	mut var_f3g9_38 := rt.call_method(var_g9_19, 'mulInt64', [var_f3_2.clone(), rt.new_int(30)])
	mut var_f4g0 := rt.call_method(var_f4, 'mulInt64', [var_g0.clone(), rt.new_int(30)])
	mut var_f4g1 := rt.call_method(var_f4, 'mulInt64', [var_g1.clone(), rt.new_int(30)])
	mut var_f4g2 := rt.call_method(var_f4, 'mulInt64', [var_g2.clone(), rt.new_int(30)])
	mut var_f4g3 := rt.call_method(var_f4, 'mulInt64', [var_g3.clone(), rt.new_int(30)])
	mut var_f4g4 := rt.call_method(var_f4, 'mulInt64', [var_g4.clone(), rt.new_int(30)])
	mut var_f4g5 := rt.call_method(var_f4, 'mulInt64', [var_g5.clone(), rt.new_int(30)])
	mut var_f4g6_19 := rt.call_method(var_g6_19, 'mulInt64', [var_f4.clone(), rt.new_int(30)])
	mut var_f4g7_19 := rt.call_method(var_g7_19, 'mulInt64', [var_f4.clone(), rt.new_int(30)])
	mut var_f4g8_19 := rt.call_method(var_g8_19, 'mulInt64', [var_f4.clone(), rt.new_int(30)])
	mut var_f4g9_19 := rt.call_method(var_g9_19, 'mulInt64', [var_f4.clone(), rt.new_int(30)])
	mut var_f5g0 := rt.call_method(var_f5, 'mulInt64', [var_g0.clone(), rt.new_int(30)])
	mut var_f5g1_2 := rt.call_method(var_f5_2, 'mulInt64', [var_g1.clone(), rt.new_int(30)])
	mut var_f5g2 := rt.call_method(var_f5, 'mulInt64', [var_g2.clone(), rt.new_int(30)])
	mut var_f5g3_2 := rt.call_method(var_f5_2, 'mulInt64', [var_g3.clone(), rt.new_int(30)])
	mut var_f5g4 := rt.call_method(var_f5, 'mulInt64', [var_g4.clone(), rt.new_int(30)])
	mut var_f5g5_38 := rt.call_method(var_g5_19, 'mulInt64', [var_f5_2.clone(), rt.new_int(30)])
	mut var_f5g6_19 := rt.call_method(var_g6_19, 'mulInt64', [var_f5.clone(), rt.new_int(30)])
	mut var_f5g7_38 := rt.call_method(var_g7_19, 'mulInt64', [var_f5_2.clone(), rt.new_int(30)])
	mut var_f5g8_19 := rt.call_method(var_g8_19, 'mulInt64', [var_f5.clone(), rt.new_int(30)])
	mut var_f5g9_38 := rt.call_method(var_g9_19, 'mulInt64', [var_f5_2.clone(), rt.new_int(30)])
	mut var_f6g0 := rt.call_method(var_f6, 'mulInt64', [var_g0.clone(), rt.new_int(30)])
	mut var_f6g1 := rt.call_method(var_f6, 'mulInt64', [var_g1.clone(), rt.new_int(30)])
	mut var_f6g2 := rt.call_method(var_f6, 'mulInt64', [var_g2.clone(), rt.new_int(30)])
	mut var_f6g3 := rt.call_method(var_f6, 'mulInt64', [var_g3.clone(), rt.new_int(30)])
	mut var_f6g4_19 := rt.call_method(var_g4_19, 'mulInt64', [var_f6.clone(), rt.new_int(30)])
	mut var_f6g5_19 := rt.call_method(var_g5_19, 'mulInt64', [var_f6.clone(), rt.new_int(30)])
	mut var_f6g6_19 := rt.call_method(var_g6_19, 'mulInt64', [var_f6.clone(), rt.new_int(30)])
	mut var_f6g7_19 := rt.call_method(var_g7_19, 'mulInt64', [var_f6.clone(), rt.new_int(30)])
	mut var_f6g8_19 := rt.call_method(var_g8_19, 'mulInt64', [var_f6.clone(), rt.new_int(30)])
	mut var_f6g9_19 := rt.call_method(var_g9_19, 'mulInt64', [var_f6.clone(), rt.new_int(30)])
	mut var_f7g0 := rt.call_method(var_f7, 'mulInt64', [var_g0.clone(), rt.new_int(30)])
	mut var_f7g1_2 := rt.call_method(var_g1, 'mulInt64', [var_f7_2.clone(), rt.new_int(30)])
	mut var_f7g2 := rt.call_method(var_f7, 'mulInt64', [var_g2.clone(), rt.new_int(30)])
	mut var_f7g3_38 := rt.call_method(var_g3_19, 'mulInt64', [var_f7_2.clone(), rt.new_int(30)])
	mut var_f7g4_19 := rt.call_method(var_g4_19, 'mulInt64', [var_f7.clone(), rt.new_int(30)])
	mut var_f7g5_38 := rt.call_method(var_g5_19, 'mulInt64', [var_f7_2.clone(), rt.new_int(30)])
	mut var_f7g6_19 := rt.call_method(var_g6_19, 'mulInt64', [var_f7.clone(), rt.new_int(30)])
	mut var_f7g7_38 := rt.call_method(var_g7_19, 'mulInt64', [var_f7_2.clone(), rt.new_int(30)])
	mut var_f7g8_19 := rt.call_method(var_g8_19, 'mulInt64', [var_f7.clone(), rt.new_int(30)])
	mut var_f7g9_38 := rt.call_method(var_g9_19, 'mulInt64', [var_f7_2.clone(), rt.new_int(30)])
	mut var_f8g0 := rt.call_method(var_f8, 'mulInt64', [var_g0.clone(), rt.new_int(30)])
	mut var_f8g1 := rt.call_method(var_f8, 'mulInt64', [var_g1.clone(), rt.new_int(29)])
	mut var_f8g2_19 := rt.call_method(var_g2_19, 'mulInt64', [var_f8.clone(), rt.new_int(30)])
	mut var_f8g3_19 := rt.call_method(var_g3_19, 'mulInt64', [var_f8.clone(), rt.new_int(30)])
	mut var_f8g4_19 := rt.call_method(var_g4_19, 'mulInt64', [var_f8.clone(), rt.new_int(30)])
	mut var_f8g5_19 := rt.call_method(var_g5_19, 'mulInt64', [var_f8.clone(), rt.new_int(30)])
	mut var_f8g6_19 := rt.call_method(var_g6_19, 'mulInt64', [var_f8.clone(), rt.new_int(30)])
	mut var_f8g7_19 := rt.call_method(var_g7_19, 'mulInt64', [var_f8.clone(), rt.new_int(30)])
	mut var_f8g8_19 := rt.call_method(var_g8_19, 'mulInt64', [var_f8.clone(), rt.new_int(30)])
	mut var_f8g9_19 := rt.call_method(var_g9_19, 'mulInt64', [var_f8.clone(), rt.new_int(30)])
	mut var_f9g0 := rt.call_method(var_f9, 'mulInt64', [var_g0.clone(), rt.new_int(30)])
	mut var_f9g1_38 := rt.call_method(var_g1_19, 'mulInt64', [var_f9_2.clone(), rt.new_int(30)])
	mut var_f9g2_19 := rt.call_method(var_g2_19, 'mulInt64', [var_f9.clone(), rt.new_int(30)])
	mut var_f9g3_38 := rt.call_method(var_g3_19, 'mulInt64', [var_f9_2.clone(), rt.new_int(30)])
	mut var_f9g4_19 := rt.call_method(var_g4_19, 'mulInt64', [var_f9.clone(), rt.new_int(30)])
	mut var_f9g5_38 := rt.call_method(var_g5_19, 'mulInt64', [var_f9_2.clone(), rt.new_int(30)])
	mut var_f9g6_19 := rt.call_method(var_g6_19, 'mulInt64', [var_f9.clone(), rt.new_int(30)])
	mut var_f9g7_38 := rt.call_method(var_g7_19, 'mulInt64', [var_f9_2.clone(), rt.new_int(30)])
	mut var_f9g8_19 := rt.call_method(var_g8_19, 'mulInt64', [var_f9.clone(), rt.new_int(30)])
	mut var_f9g9_38 := rt.call_method(var_g9_19, 'mulInt64', [var_f9_2.clone(), rt.new_int(30)])
	mut var_h0 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0g0, 'addInt64', [var_f1g9_38.clone()]), 'addInt64', [var_f2g8_19.clone()]), 'addInt64', [var_f3g7_38.clone()]), 'addInt64', [var_f4g6_19.clone()]), 'addInt64', [var_f5g5_38.clone()]), 'addInt64', [var_f6g4_19.clone()]), 'addInt64', [var_f7g3_38.clone()]), 'addInt64', [var_f8g2_19.clone()]), 'addInt64', [var_f9g1_38.clone()])
	mut var_h1 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0g1, 'addInt64', [var_f1g0.clone()]), 'addInt64', [var_f2g9_19.clone()]), 'addInt64', [var_f3g8_19.clone()]), 'addInt64', [var_f4g7_19.clone()]), 'addInt64', [var_f5g6_19.clone()]), 'addInt64', [var_f6g5_19.clone()]), 'addInt64', [var_f7g4_19.clone()]), 'addInt64', [var_f8g3_19.clone()]), 'addInt64', [var_f9g2_19.clone()])
	mut var_h2 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0g2, 'addInt64', [var_f1g1_2.clone()]), 'addInt64', [var_f2g0.clone()]), 'addInt64', [var_f3g9_38.clone()]), 'addInt64', [var_f4g8_19.clone()]), 'addInt64', [var_f5g7_38.clone()]), 'addInt64', [var_f6g6_19.clone()]), 'addInt64', [var_f7g5_38.clone()]), 'addInt64', [var_f8g4_19.clone()]), 'addInt64', [var_f9g3_38.clone()])
	mut var_h3 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0g3, 'addInt64', [var_f1g2.clone()]), 'addInt64', [var_f2g1.clone()]), 'addInt64', [var_f3g0.clone()]), 'addInt64', [var_f4g9_19.clone()]), 'addInt64', [var_f5g8_19.clone()]), 'addInt64', [var_f6g7_19.clone()]), 'addInt64', [var_f7g6_19.clone()]), 'addInt64', [var_f8g5_19.clone()]), 'addInt64', [var_f9g4_19.clone()])
	mut var_h4 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0g4, 'addInt64', [var_f1g3_2.clone()]), 'addInt64', [var_f2g2.clone()]), 'addInt64', [var_f3g1_2.clone()]), 'addInt64', [var_f4g0.clone()]), 'addInt64', [var_f5g9_38.clone()]), 'addInt64', [var_f6g8_19.clone()]), 'addInt64', [var_f7g7_38.clone()]), 'addInt64', [var_f8g6_19.clone()]), 'addInt64', [var_f9g5_38.clone()])
	mut var_h5 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0g5, 'addInt64', [var_f1g4.clone()]), 'addInt64', [var_f2g3.clone()]), 'addInt64', [var_f3g2.clone()]), 'addInt64', [var_f4g1.clone()]), 'addInt64', [var_f5g0.clone()]), 'addInt64', [var_f6g9_19.clone()]), 'addInt64', [var_f7g8_19.clone()]), 'addInt64', [var_f8g7_19.clone()]), 'addInt64', [var_f9g6_19.clone()])
	mut var_h6 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0g6, 'addInt64', [var_f1g5_2.clone()]), 'addInt64', [var_f2g4.clone()]), 'addInt64', [var_f3g3_2.clone()]), 'addInt64', [var_f4g2.clone()]), 'addInt64', [var_f5g1_2.clone()]), 'addInt64', [var_f6g0.clone()]), 'addInt64', [var_f7g9_38.clone()]), 'addInt64', [var_f8g8_19.clone()]), 'addInt64', [var_f9g7_38.clone()])
	mut var_h7 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0g7, 'addInt64', [var_f1g6.clone()]), 'addInt64', [var_f2g5.clone()]), 'addInt64', [var_f3g4.clone()]), 'addInt64', [var_f4g3.clone()]), 'addInt64', [var_f5g2.clone()]), 'addInt64', [var_f6g1.clone()]), 'addInt64', [var_f7g0.clone()]), 'addInt64', [var_f8g9_19.clone()]), 'addInt64', [var_f9g8_19.clone()])
	mut var_h8 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0g8, 'addInt64', [var_f1g7_2.clone()]), 'addInt64', [var_f2g6.clone()]), 'addInt64', [var_f3g5_2.clone()]), 'addInt64', [var_f4g4.clone()]), 'addInt64', [var_f5g3_2.clone()]), 'addInt64', [var_f6g2.clone()]), 'addInt64', [var_f7g1_2.clone()]), 'addInt64', [var_f8g0.clone()]), 'addInt64', [var_f9g9_38.clone()])
	mut var_h9 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0g9, 'addInt64', [var_f1g8.clone()]), 'addInt64', [var_f2g7.clone()]), 'addInt64', [var_f3g6.clone()]), 'addInt64', [var_f4g5.clone()]), 'addInt64', [var_f5g4.clone()]), 'addInt64', [var_f6g3.clone()]), 'addInt64', [var_f7g2.clone()]), 'addInt64', [var_f8g1.clone()]), 'addInt64', [var_f9g0.clone()])
	mut var_carry0 := rt.call_method(rt.call_method(var_h0, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h1 = rt.call_method(var_h1, 'addInt64', [var_carry0.clone()])
	var_h0 = rt.call_method(var_h0, 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry4 := rt.call_method(rt.call_method(var_h4, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h5 = rt.call_method(var_h5, 'addInt64', [var_carry4.clone()])
	var_h4 = rt.call_method(var_h4, 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry1 := rt.call_method(rt.call_method(var_h1, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h2 = rt.call_method(var_h2, 'addInt64', [var_carry1.clone()])
	var_h1 = rt.call_method(var_h1, 'subInt64', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry5 := rt.call_method(rt.call_method(var_h5, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h6 = rt.call_method(var_h6, 'addInt64', [var_carry5.clone()])
	var_h5 = rt.call_method(var_h5, 'subInt64', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry2 := rt.call_method(rt.call_method(var_h2, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h3 = rt.call_method(var_h3, 'addInt64', [var_carry2.clone()])
	var_h2 = rt.call_method(var_h2, 'subInt64', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry6 := rt.call_method(rt.call_method(var_h6, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h7 = rt.call_method(var_h7, 'addInt64', [var_carry6.clone()])
	var_h6 = rt.call_method(var_h6, 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry3 := rt.call_method(rt.call_method(var_h3, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h4 = rt.call_method(var_h4, 'addInt64', [var_carry3.clone()])
	var_h3 = rt.call_method(var_h3, 'subInt64', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry7 := rt.call_method(rt.call_method(var_h7, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h8 = rt.call_method(var_h8, 'addInt64', [var_carry7.clone()])
	var_h7 = rt.call_method(var_h7, 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(25)])])
	var_carry4 = rt.call_method(rt.call_method(var_h4, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h5 = rt.call_method(var_h5, 'addInt64', [var_carry4.clone()])
	var_h4 = rt.call_method(var_h4, 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry8 := rt.call_method(rt.call_method(var_h8, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h9 = rt.call_method(var_h9, 'addInt64', [var_carry8.clone()])
	var_h8 = rt.call_method(var_h8, 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry9 := rt.call_method(rt.call_method(var_h9, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h0 = rt.call_method(var_h0, 'addInt64', [rt.call_method(var_carry9, 'mulInt', [rt.new_int(19), rt.new_int(5)])])
	var_h9 = rt.call_method(var_h9, 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(25)])])
	var_carry0 = rt.call_method(rt.call_method(var_h0, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h1 = rt.call_method(var_h1, 'addInt64', [var_carry0.clone()])
	var_h0 = rt.call_method(var_h0, 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(26)])])
	mut iife_temp_39 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
	mut iife_result_39 := iife_temp_39.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_h0, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h1, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h2, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h3, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h4, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h5, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h6, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h7, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h8, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h9, 'toInt32', []rt.PhpVal{}) }]))
	return iife_result_39
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_neg(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	mut var_h := create_paragonie_sodium_core32_curve25519_fe()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
		var_h.array_set(var_i, rt.call_method(var_h.array_get(var_i), 'subInt32', [var_f_mutated.array_get(var_i)]))
		rt.pre_inc(var_i)
	}
	return var_h.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	mut var_f0 := rt.call_method(var_f_mutated.array_get(rt.new_int(0)), 'toInt64', []rt.PhpVal{})
	mut var_f1 := rt.call_method(var_f_mutated.array_get(rt.new_int(1)), 'toInt64', []rt.PhpVal{})
	mut var_f2 := rt.call_method(var_f_mutated.array_get(rt.new_int(2)), 'toInt64', []rt.PhpVal{})
	mut var_f3 := rt.call_method(var_f_mutated.array_get(rt.new_int(3)), 'toInt64', []rt.PhpVal{})
	mut var_f4 := rt.call_method(var_f_mutated.array_get(rt.new_int(4)), 'toInt64', []rt.PhpVal{})
	mut var_f5 := rt.call_method(var_f_mutated.array_get(rt.new_int(5)), 'toInt64', []rt.PhpVal{})
	mut var_f6 := rt.call_method(var_f_mutated.array_get(rt.new_int(6)), 'toInt64', []rt.PhpVal{})
	mut var_f7 := rt.call_method(var_f_mutated.array_get(rt.new_int(7)), 'toInt64', []rt.PhpVal{})
	mut var_f8 := rt.call_method(var_f_mutated.array_get(rt.new_int(8)), 'toInt64', []rt.PhpVal{})
	mut var_f9 := rt.call_method(var_f_mutated.array_get(rt.new_int(9)), 'toInt64', []rt.PhpVal{})
	mut var_f0_2 := rt.call_method(var_f0, 'shiftLeft', [rt.new_int(1)])
	mut var_f1_2 := rt.call_method(var_f1, 'shiftLeft', [rt.new_int(1)])
	mut var_f2_2 := rt.call_method(var_f2, 'shiftLeft', [rt.new_int(1)])
	mut var_f3_2 := rt.call_method(var_f3, 'shiftLeft', [rt.new_int(1)])
	mut var_f4_2 := rt.call_method(var_f4, 'shiftLeft', [rt.new_int(1)])
	mut var_f5_2 := rt.call_method(var_f5, 'shiftLeft', [rt.new_int(1)])
	mut var_f6_2 := rt.call_method(var_f6, 'shiftLeft', [rt.new_int(1)])
	mut var_f7_2 := rt.call_method(var_f7, 'shiftLeft', [rt.new_int(1)])
	mut var_f5_38 := rt.call_method(var_f5, 'mulInt', [rt.new_int(38), rt.new_int(6)])
	mut var_f6_19 := rt.call_method(var_f6, 'mulInt', [rt.new_int(19), rt.new_int(5)])
	mut var_f7_38 := rt.call_method(var_f7, 'mulInt', [rt.new_int(38), rt.new_int(6)])
	mut var_f8_19 := rt.call_method(var_f8, 'mulInt', [rt.new_int(19), rt.new_int(5)])
	mut var_f9_38 := rt.call_method(var_f9, 'mulInt', [rt.new_int(38), rt.new_int(6)])
	mut var_f0f0 := rt.call_method(var_f0, 'mulInt64', [var_f0.clone(), rt.new_int(28)])
	mut var_f0f1_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f1.clone(), rt.new_int(28)])
	mut var_f0f2_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f2.clone(), rt.new_int(28)])
	mut var_f0f3_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f3.clone(), rt.new_int(28)])
	mut var_f0f4_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f4.clone(), rt.new_int(28)])
	mut var_f0f5_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f5.clone(), rt.new_int(28)])
	mut var_f0f6_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f6.clone(), rt.new_int(28)])
	mut var_f0f7_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f7.clone(), rt.new_int(28)])
	mut var_f0f8_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f8.clone(), rt.new_int(28)])
	mut var_f0f9_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f9.clone(), rt.new_int(28)])
	mut var_f1f1_2 := rt.call_method(var_f1_2, 'mulInt64', [var_f1.clone(), rt.new_int(28)])
	mut var_f1f2_2 := rt.call_method(var_f1_2, 'mulInt64', [var_f2.clone(), rt.new_int(28)])
	mut var_f1f3_4 := rt.call_method(var_f1_2, 'mulInt64', [var_f3_2.clone(), rt.new_int(28)])
	mut var_f1f4_2 := rt.call_method(var_f1_2, 'mulInt64', [var_f4.clone(), rt.new_int(28)])
	mut var_f1f5_4 := rt.call_method(var_f1_2, 'mulInt64', [var_f5_2.clone(), rt.new_int(30)])
	mut var_f1f6_2 := rt.call_method(var_f1_2, 'mulInt64', [var_f6.clone(), rt.new_int(28)])
	mut var_f1f7_4 := rt.call_method(var_f1_2, 'mulInt64', [var_f7_2.clone(), rt.new_int(28)])
	mut var_f1f8_2 := rt.call_method(var_f1_2, 'mulInt64', [var_f8.clone(), rt.new_int(28)])
	mut var_f1f9_76 := rt.call_method(var_f9_38, 'mulInt64', [var_f1_2.clone(), rt.new_int(30)])
	mut var_f2f2 := rt.call_method(var_f2, 'mulInt64', [var_f2.clone(), rt.new_int(28)])
	mut var_f2f3_2 := rt.call_method(var_f2_2, 'mulInt64', [var_f3.clone(), rt.new_int(28)])
	mut var_f2f4_2 := rt.call_method(var_f2_2, 'mulInt64', [var_f4.clone(), rt.new_int(28)])
	mut var_f2f5_2 := rt.call_method(var_f2_2, 'mulInt64', [var_f5.clone(), rt.new_int(28)])
	mut var_f2f6_2 := rt.call_method(var_f2_2, 'mulInt64', [var_f6.clone(), rt.new_int(28)])
	mut var_f2f7_2 := rt.call_method(var_f2_2, 'mulInt64', [var_f7.clone(), rt.new_int(28)])
	mut var_f2f8_38 := rt.call_method(var_f8_19, 'mulInt64', [var_f2_2.clone(), rt.new_int(30)])
	mut var_f2f9_38 := rt.call_method(var_f9_38, 'mulInt64', [var_f2.clone(), rt.new_int(30)])
	mut var_f3f3_2 := rt.call_method(var_f3_2, 'mulInt64', [var_f3.clone(), rt.new_int(28)])
	mut var_f3f4_2 := rt.call_method(var_f3_2, 'mulInt64', [var_f4.clone(), rt.new_int(28)])
	mut var_f3f5_4 := rt.call_method(var_f3_2, 'mulInt64', [var_f5_2.clone(), rt.new_int(30)])
	mut var_f3f6_2 := rt.call_method(var_f3_2, 'mulInt64', [var_f6.clone(), rt.new_int(28)])
	mut var_f3f7_76 := rt.call_method(var_f7_38, 'mulInt64', [var_f3_2.clone(), rt.new_int(30)])
	mut var_f3f8_38 := rt.call_method(var_f8_19, 'mulInt64', [var_f3_2.clone(), rt.new_int(30)])
	mut var_f3f9_76 := rt.call_method(var_f9_38, 'mulInt64', [var_f3_2.clone(), rt.new_int(30)])
	mut var_f4f4 := rt.call_method(var_f4, 'mulInt64', [var_f4.clone(), rt.new_int(28)])
	mut var_f4f5_2 := rt.call_method(var_f4_2, 'mulInt64', [var_f5.clone(), rt.new_int(28)])
	mut var_f4f6_38 := rt.call_method(var_f6_19, 'mulInt64', [var_f4_2.clone(), rt.new_int(30)])
	mut var_f4f7_38 := rt.call_method(var_f7_38, 'mulInt64', [var_f4.clone(), rt.new_int(30)])
	mut var_f4f8_38 := rt.call_method(var_f8_19, 'mulInt64', [var_f4_2.clone(), rt.new_int(30)])
	mut var_f4f9_38 := rt.call_method(var_f9_38, 'mulInt64', [var_f4.clone(), rt.new_int(30)])
	mut var_f5f5_38 := rt.call_method(var_f5_38, 'mulInt64', [var_f5.clone(), rt.new_int(30)])
	mut var_f5f6_38 := rt.call_method(var_f6_19, 'mulInt64', [var_f5_2.clone(), rt.new_int(30)])
	mut var_f5f7_76 := rt.call_method(var_f7_38, 'mulInt64', [var_f5_2.clone(), rt.new_int(30)])
	mut var_f5f8_38 := rt.call_method(var_f8_19, 'mulInt64', [var_f5_2.clone(), rt.new_int(30)])
	mut var_f5f9_76 := rt.call_method(var_f9_38, 'mulInt64', [var_f5_2.clone(), rt.new_int(30)])
	mut var_f6f6_19 := rt.call_method(var_f6_19, 'mulInt64', [var_f6.clone(), rt.new_int(30)])
	mut var_f6f7_38 := rt.call_method(var_f7_38, 'mulInt64', [var_f6.clone(), rt.new_int(30)])
	mut var_f6f8_38 := rt.call_method(var_f8_19, 'mulInt64', [var_f6_2.clone(), rt.new_int(30)])
	mut var_f6f9_38 := rt.call_method(var_f9_38, 'mulInt64', [var_f6.clone(), rt.new_int(30)])
	mut var_f7f7_38 := rt.call_method(var_f7_38, 'mulInt64', [var_f7.clone(), rt.new_int(28)])
	mut var_f7f8_38 := rt.call_method(var_f8_19, 'mulInt64', [var_f7_2.clone(), rt.new_int(30)])
	mut var_f7f9_76 := rt.call_method(var_f9_38, 'mulInt64', [var_f7_2.clone(), rt.new_int(30)])
	mut var_f8f8_19 := rt.call_method(var_f8_19, 'mulInt64', [var_f8.clone(), rt.new_int(30)])
	mut var_f8f9_38 := rt.call_method(var_f9_38, 'mulInt64', [var_f8.clone(), rt.new_int(30)])
	mut var_f9f9_38 := rt.call_method(var_f9_38, 'mulInt64', [var_f9.clone(), rt.new_int(28)])
	mut var_h0 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f0, 'addInt64', [var_f1f9_76.clone()]), 'addInt64', [var_f2f8_38.clone()]), 'addInt64', [var_f3f7_76.clone()]), 'addInt64', [var_f4f6_38.clone()]), 'addInt64', [var_f5f5_38.clone()])
	mut var_h1 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f1_2, 'addInt64', [var_f2f9_38.clone()]), 'addInt64', [var_f3f8_38.clone()]), 'addInt64', [var_f4f7_38.clone()]), 'addInt64', [var_f5f6_38.clone()])
	mut var_h2 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f2_2, 'addInt64', [var_f1f1_2.clone()]), 'addInt64', [var_f3f9_76.clone()]), 'addInt64', [var_f4f8_38.clone()]), 'addInt64', [var_f5f7_76.clone()]), 'addInt64', [var_f6f6_19.clone()])
	mut var_h3 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f3_2, 'addInt64', [var_f1f2_2.clone()]), 'addInt64', [var_f4f9_38.clone()]), 'addInt64', [var_f5f8_38.clone()]), 'addInt64', [var_f6f7_38.clone()])
	mut var_h4 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f4_2, 'addInt64', [var_f1f3_4.clone()]), 'addInt64', [var_f2f2.clone()]), 'addInt64', [var_f5f9_76.clone()]), 'addInt64', [var_f6f8_38.clone()]), 'addInt64', [var_f7f7_38.clone()])
	mut var_h5 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f5_2, 'addInt64', [var_f1f4_2.clone()]), 'addInt64', [var_f2f3_2.clone()]), 'addInt64', [var_f6f9_38.clone()]), 'addInt64', [var_f7f8_38.clone()])
	mut var_h6 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f6_2, 'addInt64', [var_f1f5_4.clone()]), 'addInt64', [var_f2f4_2.clone()]), 'addInt64', [var_f3f3_2.clone()]), 'addInt64', [var_f7f9_76.clone()]), 'addInt64', [var_f8f8_19.clone()])
	mut var_h7 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f7_2, 'addInt64', [var_f1f6_2.clone()]), 'addInt64', [var_f2f5_2.clone()]), 'addInt64', [var_f3f4_2.clone()]), 'addInt64', [var_f8f9_38.clone()])
	mut var_h8 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f8_2, 'addInt64', [var_f1f7_4.clone()]), 'addInt64', [var_f2f6_2.clone()]), 'addInt64', [var_f3f5_4.clone()]), 'addInt64', [var_f4f4.clone()]), 'addInt64', [var_f9f9_38.clone()])
	mut var_h9 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f9_2, 'addInt64', [var_f1f8_2.clone()]), 'addInt64', [var_f2f7_2.clone()]), 'addInt64', [var_f3f6_2.clone()]), 'addInt64', [var_f4f5_2.clone()])
	mut var_carry0 := rt.call_method(rt.call_method(var_h0, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h1 = rt.call_method(var_h1, 'addInt64', [var_carry0.clone()])
	var_h0 = rt.call_method(var_h0, 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry4 := rt.call_method(rt.call_method(var_h4, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h5 = rt.call_method(var_h5, 'addInt64', [var_carry4.clone()])
	var_h4 = rt.call_method(var_h4, 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry1 := rt.call_method(rt.call_method(var_h1, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h2 = rt.call_method(var_h2, 'addInt64', [var_carry1.clone()])
	var_h1 = rt.call_method(var_h1, 'subInt64', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry5 := rt.call_method(rt.call_method(var_h5, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h6 = rt.call_method(var_h6, 'addInt64', [var_carry5.clone()])
	var_h5 = rt.call_method(var_h5, 'subInt64', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry2 := rt.call_method(rt.call_method(var_h2, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h3 = rt.call_method(var_h3, 'addInt64', [var_carry2.clone()])
	var_h2 = rt.call_method(var_h2, 'subInt64', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry6 := rt.call_method(rt.call_method(var_h6, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h7 = rt.call_method(var_h7, 'addInt64', [var_carry6.clone()])
	var_h6 = rt.call_method(var_h6, 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry3 := rt.call_method(rt.call_method(var_h3, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h4 = rt.call_method(var_h4, 'addInt64', [var_carry3.clone()])
	var_h3 = rt.call_method(var_h3, 'subInt64', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry7 := rt.call_method(rt.call_method(var_h7, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h8 = rt.call_method(var_h8, 'addInt64', [var_carry7.clone()])
	var_h7 = rt.call_method(var_h7, 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(25)])])
	var_carry4 = rt.call_method(rt.call_method(var_h4, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h5 = rt.call_method(var_h5, 'addInt64', [var_carry4.clone()])
	var_h4 = rt.call_method(var_h4, 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry8 := rt.call_method(rt.call_method(var_h8, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h9 = rt.call_method(var_h9, 'addInt64', [var_carry8.clone()])
	var_h8 = rt.call_method(var_h8, 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry9 := rt.call_method(rt.call_method(var_h9, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h0 = rt.call_method(var_h0, 'addInt64', [rt.call_method(var_carry9, 'mulInt', [rt.new_int(19), rt.new_int(5)])])
	var_h9 = rt.call_method(var_h9, 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(25)])])
	var_carry0 = rt.call_method(rt.call_method(var_h0, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h1 = rt.call_method(var_h1, 'addInt64', [var_carry0.clone()])
	var_h0 = rt.call_method(var_h0, 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(26)])])
	mut iife_temp_40 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
	mut iife_result_40 := iife_temp_40.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_h0, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h1, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h2, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h3, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h4, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h5, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h6, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h7, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h8, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h9, 'toInt32', []rt.PhpVal{}) }]))
	return iife_result_40
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq2(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	mut var_f0 := rt.call_method(var_f_mutated.array_get(rt.new_int(0)), 'toInt64', []rt.PhpVal{})
	mut var_f1 := rt.call_method(var_f_mutated.array_get(rt.new_int(1)), 'toInt64', []rt.PhpVal{})
	mut var_f2 := rt.call_method(var_f_mutated.array_get(rt.new_int(2)), 'toInt64', []rt.PhpVal{})
	mut var_f3 := rt.call_method(var_f_mutated.array_get(rt.new_int(3)), 'toInt64', []rt.PhpVal{})
	mut var_f4 := rt.call_method(var_f_mutated.array_get(rt.new_int(4)), 'toInt64', []rt.PhpVal{})
	mut var_f5 := rt.call_method(var_f_mutated.array_get(rt.new_int(5)), 'toInt64', []rt.PhpVal{})
	mut var_f6 := rt.call_method(var_f_mutated.array_get(rt.new_int(6)), 'toInt64', []rt.PhpVal{})
	mut var_f7 := rt.call_method(var_f_mutated.array_get(rt.new_int(7)), 'toInt64', []rt.PhpVal{})
	mut var_f8 := rt.call_method(var_f_mutated.array_get(rt.new_int(8)), 'toInt64', []rt.PhpVal{})
	mut var_f9 := rt.call_method(var_f_mutated.array_get(rt.new_int(9)), 'toInt64', []rt.PhpVal{})
	mut var_f0_2 := rt.call_method(var_f0, 'shiftLeft', [rt.new_int(1)])
	mut var_f1_2 := rt.call_method(var_f1, 'shiftLeft', [rt.new_int(1)])
	mut var_f2_2 := rt.call_method(var_f2, 'shiftLeft', [rt.new_int(1)])
	mut var_f3_2 := rt.call_method(var_f3, 'shiftLeft', [rt.new_int(1)])
	mut var_f4_2 := rt.call_method(var_f4, 'shiftLeft', [rt.new_int(1)])
	mut var_f5_2 := rt.call_method(var_f5, 'shiftLeft', [rt.new_int(1)])
	mut var_f6_2 := rt.call_method(var_f6, 'shiftLeft', [rt.new_int(1)])
	mut var_f7_2 := rt.call_method(var_f7, 'shiftLeft', [rt.new_int(1)])
	mut var_f5_38 := rt.call_method(var_f5, 'mulInt', [rt.new_int(38), rt.new_int(6)])
	mut var_f6_19 := rt.call_method(var_f6, 'mulInt', [rt.new_int(19), rt.new_int(5)])
	mut var_f7_38 := rt.call_method(var_f7, 'mulInt', [rt.new_int(38), rt.new_int(6)])
	mut var_f8_19 := rt.call_method(var_f8, 'mulInt', [rt.new_int(19), rt.new_int(5)])
	mut var_f9_38 := rt.call_method(var_f9, 'mulInt', [rt.new_int(38), rt.new_int(6)])
	mut var_f0f0 := rt.call_method(var_f0, 'mulInt64', [var_f0.clone(), rt.new_int(28)])
	mut var_f0f1_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f1.clone(), rt.new_int(28)])
	mut var_f0f2_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f2.clone(), rt.new_int(28)])
	mut var_f0f3_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f3.clone(), rt.new_int(28)])
	mut var_f0f4_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f4.clone(), rt.new_int(28)])
	mut var_f0f5_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f5.clone(), rt.new_int(28)])
	mut var_f0f6_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f6.clone(), rt.new_int(28)])
	mut var_f0f7_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f7.clone(), rt.new_int(28)])
	mut var_f0f8_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f8.clone(), rt.new_int(28)])
	mut var_f0f9_2 := rt.call_method(var_f0_2, 'mulInt64', [var_f9.clone(), rt.new_int(28)])
	mut var_f1f1_2 := rt.call_method(var_f1_2, 'mulInt64', [var_f1.clone(), rt.new_int(28)])
	mut var_f1f2_2 := rt.call_method(var_f1_2, 'mulInt64', [var_f2.clone(), rt.new_int(28)])
	mut var_f1f3_4 := rt.call_method(var_f1_2, 'mulInt64', [var_f3_2.clone(), rt.new_int(29)])
	mut var_f1f4_2 := rt.call_method(var_f1_2, 'mulInt64', [var_f4.clone(), rt.new_int(28)])
	mut var_f1f5_4 := rt.call_method(var_f1_2, 'mulInt64', [var_f5_2.clone(), rt.new_int(29)])
	mut var_f1f6_2 := rt.call_method(var_f1_2, 'mulInt64', [var_f6.clone(), rt.new_int(28)])
	mut var_f1f7_4 := rt.call_method(var_f1_2, 'mulInt64', [var_f7_2.clone(), rt.new_int(29)])
	mut var_f1f8_2 := rt.call_method(var_f1_2, 'mulInt64', [var_f8.clone(), rt.new_int(28)])
	mut var_f1f9_76 := rt.call_method(var_f9_38, 'mulInt64', [var_f1_2.clone(), rt.new_int(29)])
	mut var_f2f2 := rt.call_method(var_f2, 'mulInt64', [var_f2.clone(), rt.new_int(28)])
	mut var_f2f3_2 := rt.call_method(var_f2_2, 'mulInt64', [var_f3.clone(), rt.new_int(28)])
	mut var_f2f4_2 := rt.call_method(var_f2_2, 'mulInt64', [var_f4.clone(), rt.new_int(28)])
	mut var_f2f5_2 := rt.call_method(var_f2_2, 'mulInt64', [var_f5.clone(), rt.new_int(28)])
	mut var_f2f6_2 := rt.call_method(var_f2_2, 'mulInt64', [var_f6.clone(), rt.new_int(28)])
	mut var_f2f7_2 := rt.call_method(var_f2_2, 'mulInt64', [var_f7.clone(), rt.new_int(28)])
	mut var_f2f8_38 := rt.call_method(var_f8_19, 'mulInt64', [var_f2_2.clone(), rt.new_int(29)])
	mut var_f2f9_38 := rt.call_method(var_f9_38, 'mulInt64', [var_f2.clone(), rt.new_int(29)])
	mut var_f3f3_2 := rt.call_method(var_f3_2, 'mulInt64', [var_f3.clone(), rt.new_int(28)])
	mut var_f3f4_2 := rt.call_method(var_f3_2, 'mulInt64', [var_f4.clone(), rt.new_int(28)])
	mut var_f3f5_4 := rt.call_method(var_f3_2, 'mulInt64', [var_f5_2.clone(), rt.new_int(28)])
	mut var_f3f6_2 := rt.call_method(var_f3_2, 'mulInt64', [var_f6.clone(), rt.new_int(28)])
	mut var_f3f7_76 := rt.call_method(var_f7_38, 'mulInt64', [var_f3_2.clone(), rt.new_int(29)])
	mut var_f3f8_38 := rt.call_method(var_f8_19, 'mulInt64', [var_f3_2.clone(), rt.new_int(29)])
	mut var_f3f9_76 := rt.call_method(var_f9_38, 'mulInt64', [var_f3_2.clone(), rt.new_int(29)])
	mut var_f4f4 := rt.call_method(var_f4, 'mulInt64', [var_f4.clone(), rt.new_int(28)])
	mut var_f4f5_2 := rt.call_method(var_f4_2, 'mulInt64', [var_f5.clone(), rt.new_int(28)])
	mut var_f4f6_38 := rt.call_method(var_f6_19, 'mulInt64', [var_f4_2.clone(), rt.new_int(29)])
	mut var_f4f7_38 := rt.call_method(var_f7_38, 'mulInt64', [var_f4.clone(), rt.new_int(29)])
	mut var_f4f8_38 := rt.call_method(var_f8_19, 'mulInt64', [var_f4_2.clone(), rt.new_int(29)])
	mut var_f4f9_38 := rt.call_method(var_f9_38, 'mulInt64', [var_f4.clone(), rt.new_int(29)])
	mut var_f5f5_38 := rt.call_method(var_f5_38, 'mulInt64', [var_f5.clone(), rt.new_int(29)])
	mut var_f5f6_38 := rt.call_method(var_f6_19, 'mulInt64', [var_f5_2.clone(), rt.new_int(29)])
	mut var_f5f7_76 := rt.call_method(var_f7_38, 'mulInt64', [var_f5_2.clone(), rt.new_int(29)])
	mut var_f5f8_38 := rt.call_method(var_f8_19, 'mulInt64', [var_f5_2.clone(), rt.new_int(29)])
	mut var_f5f9_76 := rt.call_method(var_f9_38, 'mulInt64', [var_f5_2.clone(), rt.new_int(29)])
	mut var_f6f6_19 := rt.call_method(var_f6_19, 'mulInt64', [var_f6.clone(), rt.new_int(29)])
	mut var_f6f7_38 := rt.call_method(var_f7_38, 'mulInt64', [var_f6.clone(), rt.new_int(29)])
	mut var_f6f8_38 := rt.call_method(var_f8_19, 'mulInt64', [var_f6_2.clone(), rt.new_int(29)])
	mut var_f6f9_38 := rt.call_method(var_f9_38, 'mulInt64', [var_f6.clone(), rt.new_int(29)])
	mut var_f7f7_38 := rt.call_method(var_f7_38, 'mulInt64', [var_f7.clone(), rt.new_int(29)])
	mut var_f7f8_38 := rt.call_method(var_f8_19, 'mulInt64', [var_f7_2.clone(), rt.new_int(29)])
	mut var_f7f9_76 := rt.call_method(var_f9_38, 'mulInt64', [var_f7_2.clone(), rt.new_int(29)])
	mut var_f8f8_19 := rt.call_method(var_f8_19, 'mulInt64', [var_f8.clone(), rt.new_int(29)])
	mut var_f8f9_38 := rt.call_method(var_f9_38, 'mulInt64', [var_f8.clone(), rt.new_int(29)])
	mut var_f9f9_38 := rt.call_method(var_f9_38, 'mulInt64', [var_f9.clone(), rt.new_int(29)])
	mut var_h0 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f0, 'addInt64', [var_f1f9_76.clone()]), 'addInt64', [var_f2f8_38.clone()]), 'addInt64', [var_f3f7_76.clone()]), 'addInt64', [var_f4f6_38.clone()]), 'addInt64', [var_f5f5_38.clone()])
	mut var_h1 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f1_2, 'addInt64', [var_f2f9_38.clone()]), 'addInt64', [var_f3f8_38.clone()]), 'addInt64', [var_f4f7_38.clone()]), 'addInt64', [var_f5f6_38.clone()])
	mut var_h2 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f2_2, 'addInt64', [var_f1f1_2.clone()]), 'addInt64', [var_f3f9_76.clone()]), 'addInt64', [var_f4f8_38.clone()]), 'addInt64', [var_f5f7_76.clone()]), 'addInt64', [var_f6f6_19.clone()])
	mut var_h3 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f3_2, 'addInt64', [var_f1f2_2.clone()]), 'addInt64', [var_f4f9_38.clone()]), 'addInt64', [var_f5f8_38.clone()]), 'addInt64', [var_f6f7_38.clone()])
	mut var_h4 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f4_2, 'addInt64', [var_f1f3_4.clone()]), 'addInt64', [var_f2f2.clone()]), 'addInt64', [var_f5f9_76.clone()]), 'addInt64', [var_f6f8_38.clone()]), 'addInt64', [var_f7f7_38.clone()])
	mut var_h5 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f5_2, 'addInt64', [var_f1f4_2.clone()]), 'addInt64', [var_f2f3_2.clone()]), 'addInt64', [var_f6f9_38.clone()]), 'addInt64', [var_f7f8_38.clone()])
	mut var_h6 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f6_2, 'addInt64', [var_f1f5_4.clone()]), 'addInt64', [var_f2f4_2.clone()]), 'addInt64', [var_f3f3_2.clone()]), 'addInt64', [var_f7f9_76.clone()]), 'addInt64', [var_f8f8_19.clone()])
	mut var_h7 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f7_2, 'addInt64', [var_f1f6_2.clone()]), 'addInt64', [var_f2f5_2.clone()]), 'addInt64', [var_f3f4_2.clone()]), 'addInt64', [var_f8f9_38.clone()])
	mut var_h8 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f8_2, 'addInt64', [var_f1f7_4.clone()]), 'addInt64', [var_f2f6_2.clone()]), 'addInt64', [var_f3f5_4.clone()]), 'addInt64', [var_f4f4.clone()]), 'addInt64', [var_f9f9_38.clone()])
	mut var_h9 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f0f9_2, 'addInt64', [var_f1f8_2.clone()]), 'addInt64', [var_f2f7_2.clone()]), 'addInt64', [var_f3f6_2.clone()]), 'addInt64', [var_f4f5_2.clone()])
	var_h0 = rt.call_method(var_h0, 'shiftLeft', [rt.new_int(1)])
	var_h1 = rt.call_method(var_h1, 'shiftLeft', [rt.new_int(1)])
	var_h2 = rt.call_method(var_h2, 'shiftLeft', [rt.new_int(1)])
	var_h3 = rt.call_method(var_h3, 'shiftLeft', [rt.new_int(1)])
	var_h4 = rt.call_method(var_h4, 'shiftLeft', [rt.new_int(1)])
	var_h5 = rt.call_method(var_h5, 'shiftLeft', [rt.new_int(1)])
	var_h6 = rt.call_method(var_h6, 'shiftLeft', [rt.new_int(1)])
	var_h7 = rt.call_method(var_h7, 'shiftLeft', [rt.new_int(1)])
	var_h8 = rt.call_method(var_h8, 'shiftLeft', [rt.new_int(1)])
	var_h9 = rt.call_method(var_h9, 'shiftLeft', [rt.new_int(1)])
	mut var_carry0 := rt.call_method(rt.call_method(var_h0, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h1 = rt.call_method(var_h1, 'addInt64', [var_carry0.clone()])
	var_h0 = rt.call_method(var_h0, 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry4 := rt.call_method(rt.call_method(var_h4, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h5 = rt.call_method(var_h5, 'addInt64', [var_carry4.clone()])
	var_h4 = rt.call_method(var_h4, 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry1 := rt.call_method(rt.call_method(var_h1, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h2 = rt.call_method(var_h2, 'addInt64', [var_carry1.clone()])
	var_h1 = rt.call_method(var_h1, 'subInt64', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry5 := rt.call_method(rt.call_method(var_h5, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h6 = rt.call_method(var_h6, 'addInt64', [var_carry5.clone()])
	var_h5 = rt.call_method(var_h5, 'subInt64', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry2 := rt.call_method(rt.call_method(var_h2, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h3 = rt.call_method(var_h3, 'addInt64', [var_carry2.clone()])
	var_h2 = rt.call_method(var_h2, 'subInt64', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry6 := rt.call_method(rt.call_method(var_h6, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h7 = rt.call_method(var_h7, 'addInt64', [var_carry6.clone()])
	var_h6 = rt.call_method(var_h6, 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry3 := rt.call_method(rt.call_method(var_h3, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h4 = rt.call_method(var_h4, 'addInt64', [var_carry3.clone()])
	var_h3 = rt.call_method(var_h3, 'subInt64', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry7 := rt.call_method(rt.call_method(var_h7, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h8 = rt.call_method(var_h8, 'addInt64', [var_carry7.clone()])
	var_h7 = rt.call_method(var_h7, 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(25)])])
	var_carry4 = rt.call_method(rt.call_method(var_h4, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h5 = rt.call_method(var_h5, 'addInt64', [var_carry4.clone()])
	var_h4 = rt.call_method(var_h4, 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry8 := rt.call_method(rt.call_method(var_h8, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h9 = rt.call_method(var_h9, 'addInt64', [var_carry8.clone()])
	var_h8 = rt.call_method(var_h8, 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry9 := rt.call_method(rt.call_method(var_h9, 'addInt', [rt.new_int(1 << 24)]), 'shiftRight', [rt.new_int(25)])
	var_h0 = rt.call_method(var_h0, 'addInt64', [rt.call_method(var_carry9, 'mulInt', [rt.new_int(19), rt.new_int(5)])])
	var_h9 = rt.call_method(var_h9, 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(25)])])
	var_carry0 = rt.call_method(rt.call_method(var_h0, 'addInt', [rt.new_int(1 << 25)]), 'shiftRight', [rt.new_int(26)])
	var_h1 = rt.call_method(var_h1, 'addInt64', [var_carry0.clone()])
	var_h0 = rt.call_method(var_h0, 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(26)])])
	mut iife_temp_41 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
	mut iife_result_41 := iife_temp_41.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_h0, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h1, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h2, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h3, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h4, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h5, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h6, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h7, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h8, 'toInt32', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_method(var_h9, 'toInt32', []rt.PhpVal{}) }]))
	return iife_result_41
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_invert(mut var_Z Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_z := var_Z.dup()
	mut var_t0 := Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_z))
	mut var_t1 := Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_z), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_t0 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	mut var_t2 := Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2))
	var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(5)))) { break }
		var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2))
		rt.pre_inc(var_i)
	}
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_i = rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
		var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2))
		rt.pre_inc(var_i)
	}
	var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	mut var_t3 := Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2))
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(20)))) { break }
		var_t3 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t3))
		rt.pre_inc(var_i)
	}
	var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t3), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2))
	var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2))
	var_i = rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
		var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2))
		rt.pre_inc(var_i)
	}
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_i = rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(50)))) { break }
		var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2))
		rt.pre_inc(var_i)
	}
	var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_t3 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2))
	var_i = rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(100)))) { break }
		var_t3 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t3))
		rt.pre_inc(var_i)
	}
	var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t3), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2))
	var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2))
	var_i = rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(50)))) { break }
		var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2))
		rt.pre_inc(var_i)
	}
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_i = rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(5)))) { break }
		var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
		rt.pre_inc(var_i)
	}
	return Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_pow22523(mut var_z Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_z_mutated := var_z
	mut var_t0 := Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut var_z_mutated)
	mut var_t1 := Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut var_z_mutated, mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_t0 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_t0 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	var_t0 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(5)))) { break }
		var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
		rt.pre_inc(var_i)
	}
	var_t0 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	var_i = rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
		var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
		rt.pre_inc(var_i)
	}
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	mut var_t2 := Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(20)))) { break }
		var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2))
		rt.pre_inc(var_i)
	}
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_i = rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
		var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
		rt.pre_inc(var_i)
	}
	var_t0 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	var_i = rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(50)))) { break }
		var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
		rt.pre_inc(var_i)
	}
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_i = rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(100)))) { break }
		var_t2 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2))
		rt.pre_inc(var_i)
	}
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
	var_i = rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(50)))) { break }
		var_t1 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1))
		rt.pre_inc(var_i)
	}
	var_t0 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t1), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	var_t0 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	var_t0 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0))
	return Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0), mut var_z_mutated)
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	mut iife_temp_42 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
	mut iife_result_42 := iife_temp_42.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_f_mutated.array_get(rt.new_int(0)), 'subInt32', [var_g.array_get(rt.new_int(0))]) }, rt.ArrayItem{ key: none, val: rt.call_method(var_f_mutated.array_get(rt.new_int(1)), 'subInt32', [var_g.array_get(rt.new_int(1))]) }, rt.ArrayItem{ key: none, val: rt.call_method(var_f_mutated.array_get(rt.new_int(2)), 'subInt32', [var_g.array_get(rt.new_int(2))]) }, rt.ArrayItem{ key: none, val: rt.call_method(var_f_mutated.array_get(rt.new_int(3)), 'subInt32', [var_g.array_get(rt.new_int(3))]) }, rt.ArrayItem{ key: none, val: rt.call_method(var_f_mutated.array_get(rt.new_int(4)), 'subInt32', [var_g.array_get(rt.new_int(4))]) }, rt.ArrayItem{ key: none, val: rt.call_method(var_f_mutated.array_get(rt.new_int(5)), 'subInt32', [var_g.array_get(rt.new_int(5))]) }, rt.ArrayItem{ key: none, val: rt.call_method(var_f_mutated.array_get(rt.new_int(6)), 'subInt32', [var_g.array_get(rt.new_int(6))]) }, rt.ArrayItem{ key: none, val: rt.call_method(var_f_mutated.array_get(rt.new_int(7)), 'subInt32', [var_g.array_get(rt.new_int(7))]) }, rt.ArrayItem{ key: none, val: rt.call_method(var_f_mutated.array_get(rt.new_int(8)), 'subInt32', [var_g.array_get(rt.new_int(8))]) }, rt.ArrayItem{ key: none, val: rt.call_method(var_f_mutated.array_get(rt.new_int(9)), 'subInt32', [var_g.array_get(rt.new_int(9))]) }]))
	return iife_result_42
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_add(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3, mut var_q Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached) rt.PhpVal {
	mut var_q_mutated := var_q
	mut var_r := create_paragonie_sodium_core32_curve25519_ge_p1p1()
	rt.set_property(var_r, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X'))))
	rt.set_property(var_r, 'Z', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_q_mutated, 'YplusX'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_q_mutated, 'YminusX'))))
	rt.set_property(var_r, 'T', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_q_mutated, 'T2d')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'T'))))
	rt.set_property(var_r, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_q_mutated, 'Z'))))
	mut var_t0 := Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'X')))
	rt.set_property(var_r, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Y'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Y'))))
	rt.set_property(var_r, 'Z', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'T'))))
	rt.set_property(var_r, 'T', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'T'))))
	return var_r.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.slide(var_a rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
	mut iife_temp_43 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_43 := iife_temp_43.strlen(var_a_mutated.clone())
	if rt.is_true(rt.less(iife_result_43, rt.new_int(256))) {
		mut iife_temp_44 := Class_ParagonIE_Sodium_Core32_Curve25519{}
		mut iife_result_44 := iife_temp_44.strlen(var_a_mutated.clone())
		if rt.is_true(rt.less(iife_result_44, rt.new_int(16))) {
		var_a_mutated = rt.call_function('str_pad', [var_a_mutated.clone(), rt.new_int(256), rt.new_string('0'), rt.get_constant('STR_PAD_RIGHT')])
		}
	}
	mut var_r := rt.new_array()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(256)))) { break }
		mut iife_temp_45 := Class_ParagonIE_Sodium_Core32_Curve25519{}
		mut iife_result_45 := iife_temp_45.chrtoint(var_a_mutated.array_get(rt.new_int(rt.shift_right(var_i, rt.new_int(3)))))
		var_r.array_set(var_i, 1 & rt.shift_right(iife_result_45, rt.bitwise_and(var_i, rt.new_int(7))))
		rt.pre_inc(var_i)
	}
	var_i = rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(256)))) { break }
		if rt.is_true(var_r.array_get(var_i)) {
			mut var_b := rt.new_int(1)
			for {
				if !(rt.is_true(rt.less_equal(var_b, rt.new_int(6))) && rt.is_true(rt.less(rt.add(var_i, var_b), rt.new_int(256)))) { break }
				if rt.is_true(var_r.array_get(rt.add(var_i, var_b))) {
					if rt.is_true(rt.less_equal(rt.add(var_r.array_get(var_i), rt.shift_left(var_r.array_get(rt.add(var_i, var_b)), var_b)), rt.new_int(15))) {
						var_r.array_get(var_i) = rt.add(var_r.array_get(var_i), rt.shift_left(var_r.array_get(rt.add(var_i, var_b)), var_b))
						var_r.array_set(rt.add(var_i, var_b), 0)
					} else if rt.is_true(rt.greater_equal(rt.sub(var_r.array_get(var_i), rt.shift_left(var_r.array_get(rt.add(var_i, var_b)), var_b)), -15)) {
						var_r.array_get(var_i) = rt.sub(var_r.array_get(var_i), rt.shift_left(var_r.array_get(rt.add(var_i, var_b)), var_b))
						mut var_k := rt.add(var_i, var_b)
						for {
							if !(rt.is_true(rt.less(var_k, rt.new_int(256)))) { break }
							if rt.is_true(rt.new_bool(!(rt.is_true(var_r.array_get(var_k))))) {
								var_r.array_set(var_k, 1)
								break
							}
							var_r.array_set(var_k, 0)
							rt.pre_inc(var_k)
						}
					} else {
						break
					}
				}
				rt.pre_inc(var_b)
			}
		}
		rt.pre_inc(var_i)
	}
	return var_r.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_frombytes_negate_vartime(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
	mut var_d := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_d)))) {
	mut iife_temp_46 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_46 := iife_temp_46.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd').array_get(rt.new_int(0)))
	mut iife_temp_47 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_47 := iife_temp_47.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd').array_get(rt.new_int(1)))
	mut iife_temp_48 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_48 := iife_temp_48.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd').array_get(rt.new_int(2)))
	mut iife_temp_49 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_49 := iife_temp_49.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd').array_get(rt.new_int(3)))
	mut iife_temp_50 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_50 := iife_temp_50.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd').array_get(rt.new_int(4)))
	mut iife_temp_51 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_51 := iife_temp_51.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd').array_get(rt.new_int(5)))
	mut iife_temp_52 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_52 := iife_temp_52.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd').array_get(rt.new_int(6)))
	mut iife_temp_53 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_53 := iife_temp_53.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd').array_get(rt.new_int(7)))
	mut iife_temp_54 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_54 := iife_temp_54.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd').array_get(rt.new_int(8)))
	mut iife_temp_55 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_55 := iife_temp_55.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd').array_get(rt.new_int(9)))
	mut iife_temp_56 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
	mut iife_result_56 := iife_temp_56.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: iife_result_46 }, rt.ArrayItem{ key: none, val: iife_result_47 }, rt.ArrayItem{ key: none, val: iife_result_48 }, rt.ArrayItem{ key: none, val: iife_result_49 }, rt.ArrayItem{ key: none, val: iife_result_50 }, rt.ArrayItem{ key: none, val: iife_result_51 }, rt.ArrayItem{ key: none, val: iife_result_52 }, rt.ArrayItem{ key: none, val: iife_result_53 }, rt.ArrayItem{ key: none, val: iife_result_54 }, rt.ArrayItem{ key: none, val: iife_result_55 }]))
	var_d = iife_result_56
	}
	mut var_h := create_paragonie_sodium_core32_curve25519_ge_p3(Class_ParagonIE_Sodium_Core32_Curve25519.fe_0(), Class_ParagonIE_Sodium_Core32_Curve25519.fe_frombytes(var_s_mutated.clone()), Class_ParagonIE_Sodium_Core32_Curve25519.fe_1())
	mut var_u := Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h, 'Y')))
	mut var_v := Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_u), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_d))
	var_u = Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_u), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h, 'Z')))
	var_v = Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_v), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h, 'Z')))
	mut var_v3 := Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_v))
	var_v3 = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_v3), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_v))
	rt.set_property(var_h, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_v3)))
	rt.set_property(var_h, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_v)))
	rt.set_property(var_h, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_u)))
	rt.set_property(var_h, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_pow22523(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h, 'X'))))
	rt.set_property(var_h, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_v3)))
	rt.set_property(var_h, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_u)))
	mut var_vxx := Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h, 'X')))
	var_vxx = Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_vxx), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_v))
	mut var_check := Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_vxx), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_u))
	if rt.is_true(Class_ParagonIE_Sodium_Core32_Curve25519.fe_isnonzero(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_check))) {
		var_check = Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_vxx), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_u))
		if rt.is_true(Class_ParagonIE_Sodium_Core32_Curve25519.fe_isnonzero(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_check))) {
			rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(rt.new_string('Internal check failed.'))))
		}
		mut iife_temp_57 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
		mut iife_result_57 := iife_temp_57.fromintarray(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'sqrtm1'))
		rt.set_property(var_h, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](iife_result_57)))
	}
	mut iife_temp_58 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_58 := iife_temp_58.chrtoint(var_s_mutated.array_get(rt.new_int(31)))
	mut var_i := iife_result_58
	if rt.is_true(rt.identical(Class_ParagonIE_Sodium_Core32_Curve25519.fe_isnegative(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h, 'X'))), rt.shift_right(var_i, rt.new_int(7)))) {
		rt.set_property(var_h, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_neg(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h, 'X'))))
	}
	rt.set_property(var_h, 'T', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h, 'Y'))))
	return var_h.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_madd(mut var_R Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1, mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3, mut var_q Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp) rt.PhpVal {
	mut var_q_mutated := var_q
	mut var_r := var_R.dup()
	rt.set_property(var_r, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X'))))
	rt.set_property(var_r, 'Z', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_q_mutated, 'yplusx'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_q_mutated, 'yminusx'))))
	rt.set_property(var_r, 'T', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_q_mutated, 'xy2d')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'T'))))
	mut var_t0 := Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Z').dup()), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Z').dup()))
	rt.set_property(var_r, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Y'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Y'))))
	rt.set_property(var_r, 'Z', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'T'))))
	rt.set_property(var_r, 'T', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'T'))))
	return var_r.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_msub(mut var_R Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1, mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3, mut var_q Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp) rt.PhpVal {
	mut var_q_mutated := var_q
	mut var_r := var_R.dup()
	rt.set_property(var_r, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X'))))
	rt.set_property(var_r, 'Z', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_q_mutated, 'yminusx'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_q_mutated, 'yplusx'))))
	rt.set_property(var_r, 'T', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_q_mutated, 'xy2d')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'T'))))
	mut var_t0 := Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Z')))
	rt.set_property(var_r, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Y'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Y'))))
	rt.set_property(var_r, 'Z', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'T'))))
	rt.set_property(var_r, 'T', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'T'))))
	return var_r.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p2(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1) rt.PhpVal {
	mut var_r := create_paragonie_sodium_core32_curve25519_ge_p2()
	rt.set_property(var_r, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'T'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Z'))))
	rt.set_property(var_r, 'Z', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'T'))))
	return var_r.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1) rt.PhpVal {
	mut var_r := create_paragonie_sodium_core32_curve25519_ge_p3()
	rt.set_property(var_r, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'T'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Z'))))
	rt.set_property(var_r, 'Z', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'T'))))
	rt.set_property(var_r, 'T', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y'))))
	return var_r.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p2_0() rt.PhpVal {
	return rt.new_object('ParagonIE_Sodium_Core32_Curve25519_Ge_P2', []string{}, create_paragonie_sodium_core32_curve25519_ge_p2(Class_ParagonIE_Sodium_Core32_Curve25519.fe_0(), Class_ParagonIE_Sodium_Core32_Curve25519.fe_1(), Class_ParagonIE_Sodium_Core32_Curve25519.fe_1()))
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p2_dbl(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2) rt.PhpVal {
	mut var_r := create_paragonie_sodium_core32_curve25519_ge_p1p1()
	rt.set_property(var_r, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X'))))
	rt.set_property(var_r, 'Z', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y'))))
	rt.set_property(var_r, 'T', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq2(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Z'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y'))))
	mut var_t0 := Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Y')))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'X'))))
	rt.set_property(var_r, 'Z', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'X'))))
	rt.set_property(var_r, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Y'))))
	rt.set_property(var_r, 'T', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'T')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Z'))))
	return var_r.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_0() rt.PhpVal {
	return rt.new_object('ParagonIE_Sodium_Core32_Curve25519_Ge_P3', []string{}, create_paragonie_sodium_core32_curve25519_ge_p3(Class_ParagonIE_Sodium_Core32_Curve25519.fe_0(), Class_ParagonIE_Sodium_Core32_Curve25519.fe_1(), Class_ParagonIE_Sodium_Core32_Curve25519.fe_1(), Class_ParagonIE_Sodium_Core32_Curve25519.fe_0()))
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_to_cached(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3) rt.PhpVal {
	mut var_d2 := rt.new_null()
	if rt.is_true(rt.identical(var_d2, rt.new_null())) {
	mut iife_temp_59 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_59 := iife_temp_59.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd2').array_get(rt.new_int(0)))
	mut iife_temp_60 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_60 := iife_temp_60.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd2').array_get(rt.new_int(1)))
	mut iife_temp_61 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_61 := iife_temp_61.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd2').array_get(rt.new_int(2)))
	mut iife_temp_62 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_62 := iife_temp_62.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd2').array_get(rt.new_int(3)))
	mut iife_temp_63 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_63 := iife_temp_63.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd2').array_get(rt.new_int(4)))
	mut iife_temp_64 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_64 := iife_temp_64.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd2').array_get(rt.new_int(5)))
	mut iife_temp_65 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_65 := iife_temp_65.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd2').array_get(rt.new_int(6)))
	mut iife_temp_66 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_66 := iife_temp_66.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd2').array_get(rt.new_int(7)))
	mut iife_temp_67 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_67 := iife_temp_67.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd2').array_get(rt.new_int(8)))
	mut iife_temp_68 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_68 := iife_temp_68.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'd2').array_get(rt.new_int(9)))
	mut iife_temp_69 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
	mut iife_result_69 := iife_temp_69.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: iife_result_59 }, rt.ArrayItem{ key: none, val: iife_result_60 }, rt.ArrayItem{ key: none, val: iife_result_61 }, rt.ArrayItem{ key: none, val: iife_result_62 }, rt.ArrayItem{ key: none, val: iife_result_63 }, rt.ArrayItem{ key: none, val: iife_result_64 }, rt.ArrayItem{ key: none, val: iife_result_65 }, rt.ArrayItem{ key: none, val: iife_result_66 }, rt.ArrayItem{ key: none, val: iife_result_67 }, rt.ArrayItem{ key: none, val: iife_result_68 }]))
	var_d2 = iife_result_69
	}
	mut var_r := create_paragonie_sodium_core32_curve25519_ge_cached()
	rt.set_property(var_r, 'YplusX', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X'))))
	rt.set_property(var_r, 'YminusX', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X'))))
	rt.set_property(var_r, 'Z', Class_ParagonIE_Sodium_Core32_Curve25519.fe_copy(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Z'))))
	rt.set_property(var_r, 'T2d', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'T')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_d2)))
	return var_r.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_to_p2(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3) rt.PhpVal {
	return rt.new_object('ParagonIE_Sodium_Core32_Curve25519_Ge_P2', []string{}, create_paragonie_sodium_core32_curve25519_ge_p2(rt.get_property(var_p, 'X'), rt.get_property(var_p, 'Y'), rt.get_property(var_p, 'Z')))
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_tobytes(mut var_h Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3) rt.PhpVal {
	mut var_h_mutated := var_h
	mut var_recip := Class_ParagonIE_Sodium_Core32_Curve25519.fe_invert(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h_mutated, 'Z')))
	mut var_x := Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h_mutated, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_recip))
	mut var_y := Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h_mutated, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_recip))
	mut var_s := Class_ParagonIE_Sodium_Core32_Curve25519.fe_tobytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_y))
	mut iife_temp_70 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_70 := iife_temp_70.chrtoint(var_s.array_get(rt.new_int(31)))
	mut iife_temp_71 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_71 := iife_temp_71.inttochr(rt.new_int(rt.bitwise_xor(iife_result_70, rt.shift_left(Class_ParagonIE_Sodium_Core32_Curve25519.fe_isnegative(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_x)), rt.new_int(7)))))
	var_s.array_set(31, iife_result_71)
	return var_s.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_dbl(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3) rt.PhpVal {
	mut var_q := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_to_p2(mut var_p)
	return Class_ParagonIE_Sodium_Core32_Curve25519.ge_p2_dbl(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2](var_q))
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_precomp_0() rt.PhpVal {
	return rt.new_object('ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp', []string{}, create_paragonie_sodium_core32_curve25519_ge_precomp(Class_ParagonIE_Sodium_Core32_Curve25519.fe_1(), Class_ParagonIE_Sodium_Core32_Curve25519.fe_1(), Class_ParagonIE_Sodium_Core32_Curve25519.fe_0()))
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.equal(var_b rt.PhpVal, var_c rt.PhpVal) i64 {
	mut var_b_mutated := var_b
	mut var_b0 := rt.new_int(rt.bitwise_and(var_b_mutated, rt.new_int(65535)))
	mut var_b1 := rt.new_int(rt.shift_right(var_b_mutated, rt.new_int(16)) & 65535)
	mut var_c0 := rt.new_int(rt.bitwise_and(var_c, rt.new_int(65535)))
	mut var_c1 := rt.new_int(rt.shift_right(var_c, rt.new_int(16)) & 65535)
	mut var_d0 := rt.new_int(rt.bitwise_xor(var_b0, var_c0) - 1 >> 31)
	mut var_d1 := rt.new_int(rt.bitwise_xor(var_b1, var_c1) - 1 >> 31)
	return rt.bitwise_and(var_d0, var_d1) & 1
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.negative(var_char rt.PhpVal) i64 {
	if rt.is_true(rt.new_bool(var_char.clone().is_long())) {
		return if rt.is_true(rt.less(var_char, rt.new_int(0))) { 1 } else { 0 }
	}
	mut iife_temp_72 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_72 := iife_temp_72.substr(var_char.clone(), rt.new_int(0), rt.new_int(1))
	mut iife_temp_73 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_73 := iife_temp_73.chrtoint(iife_result_72)
	mut var_x := iife_result_73
	return rt.shift_right(var_x, rt.new_int(31))
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.cmov(mut var_t Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp, mut var_u Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp, var_b rt.PhpVal) rt.PhpVal {
	mut var_t_mutated := var_t
	mut var_u_mutated := var_u
	mut var_b_mutated := var_b
	if !(var_b_mutated.clone().is_long()) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Expected an integer.'))))
	}
	return rt.new_object('ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp', []string{}, create_paragonie_sodium_core32_curve25519_ge_precomp(Class_ParagonIE_Sodium_Core32_Curve25519.fe_cmov(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_t_mutated, 'yplusx')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_u_mutated, 'yplusx')), (var_b_mutated).to_i64()), Class_ParagonIE_Sodium_Core32_Curve25519.fe_cmov(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_t_mutated, 'yminusx')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_u_mutated, 'yminusx')), (var_b_mutated).to_i64()), Class_ParagonIE_Sodium_Core32_Curve25519.fe_cmov(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_t_mutated, 'xy2d')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_u_mutated, 'xy2d')), (var_b_mutated).to_i64())))
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_select(pos i64, b i64) rt.PhpVal {
	mut b_mutated := b
	mut var_base := rt.new_null()
	if rt.is_true(rt.identical(var_base, rt.new_null())) {
		var_base = rt.new_array()
		mut iter_1 := rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_bas := item_1.val
			mut var_i := item_1.key
			mut var_j := rt.new_int(0)
			for {
				if !(rt.is_true(rt.less(var_j, rt.new_int(8)))) { break }
				mut iife_temp_74 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_74 := iife_temp_74.fromint(var_bas.array_get(var_j).array_get(rt.new_int(0)).array_get(rt.new_int(0)))
				mut iife_temp_75 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_75 := iife_temp_75.fromint(var_bas.array_get(var_j).array_get(rt.new_int(0)).array_get(rt.new_int(1)))
				mut iife_temp_76 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_76 := iife_temp_76.fromint(var_bas.array_get(var_j).array_get(rt.new_int(0)).array_get(rt.new_int(2)))
				mut iife_temp_77 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_77 := iife_temp_77.fromint(var_bas.array_get(var_j).array_get(rt.new_int(0)).array_get(rt.new_int(3)))
				mut iife_temp_78 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_78 := iife_temp_78.fromint(var_bas.array_get(var_j).array_get(rt.new_int(0)).array_get(rt.new_int(4)))
				mut iife_temp_79 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_79 := iife_temp_79.fromint(var_bas.array_get(var_j).array_get(rt.new_int(0)).array_get(rt.new_int(5)))
				mut iife_temp_80 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_80 := iife_temp_80.fromint(var_bas.array_get(var_j).array_get(rt.new_int(0)).array_get(rt.new_int(6)))
				mut iife_temp_81 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_81 := iife_temp_81.fromint(var_bas.array_get(var_j).array_get(rt.new_int(0)).array_get(rt.new_int(7)))
				mut iife_temp_82 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_82 := iife_temp_82.fromint(var_bas.array_get(var_j).array_get(rt.new_int(0)).array_get(rt.new_int(8)))
				mut iife_temp_83 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_83 := iife_temp_83.fromint(var_bas.array_get(var_j).array_get(rt.new_int(0)).array_get(rt.new_int(9)))
				mut iife_temp_84 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
				mut iife_result_84 := iife_temp_84.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: iife_result_74 }, rt.ArrayItem{ key: none, val: iife_result_75 }, rt.ArrayItem{ key: none, val: iife_result_76 }, rt.ArrayItem{ key: none, val: iife_result_77 }, rt.ArrayItem{ key: none, val: iife_result_78 }, rt.ArrayItem{ key: none, val: iife_result_79 }, rt.ArrayItem{ key: none, val: iife_result_80 }, rt.ArrayItem{ key: none, val: iife_result_81 }, rt.ArrayItem{ key: none, val: iife_result_82 }, rt.ArrayItem{ key: none, val: iife_result_83 }]))
				mut iife_temp_85 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_85 := iife_temp_85.fromint(var_bas.array_get(var_j).array_get(rt.new_int(1)).array_get(rt.new_int(0)))
				mut iife_temp_86 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_86 := iife_temp_86.fromint(var_bas.array_get(var_j).array_get(rt.new_int(1)).array_get(rt.new_int(1)))
				mut iife_temp_87 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_87 := iife_temp_87.fromint(var_bas.array_get(var_j).array_get(rt.new_int(1)).array_get(rt.new_int(2)))
				mut iife_temp_88 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_88 := iife_temp_88.fromint(var_bas.array_get(var_j).array_get(rt.new_int(1)).array_get(rt.new_int(3)))
				mut iife_temp_89 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_89 := iife_temp_89.fromint(var_bas.array_get(var_j).array_get(rt.new_int(1)).array_get(rt.new_int(4)))
				mut iife_temp_90 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_90 := iife_temp_90.fromint(var_bas.array_get(var_j).array_get(rt.new_int(1)).array_get(rt.new_int(5)))
				mut iife_temp_91 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_91 := iife_temp_91.fromint(var_bas.array_get(var_j).array_get(rt.new_int(1)).array_get(rt.new_int(6)))
				mut iife_temp_92 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_92 := iife_temp_92.fromint(var_bas.array_get(var_j).array_get(rt.new_int(1)).array_get(rt.new_int(7)))
				mut iife_temp_93 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_93 := iife_temp_93.fromint(var_bas.array_get(var_j).array_get(rt.new_int(1)).array_get(rt.new_int(8)))
				mut iife_temp_94 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_94 := iife_temp_94.fromint(var_bas.array_get(var_j).array_get(rt.new_int(1)).array_get(rt.new_int(9)))
				mut iife_temp_95 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
				mut iife_result_95 := iife_temp_95.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: iife_result_85 }, rt.ArrayItem{ key: none, val: iife_result_86 }, rt.ArrayItem{ key: none, val: iife_result_87 }, rt.ArrayItem{ key: none, val: iife_result_88 }, rt.ArrayItem{ key: none, val: iife_result_89 }, rt.ArrayItem{ key: none, val: iife_result_90 }, rt.ArrayItem{ key: none, val: iife_result_91 }, rt.ArrayItem{ key: none, val: iife_result_92 }, rt.ArrayItem{ key: none, val: iife_result_93 }, rt.ArrayItem{ key: none, val: iife_result_94 }]))
				mut iife_temp_96 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_96 := iife_temp_96.fromint(var_bas.array_get(var_j).array_get(rt.new_int(2)).array_get(rt.new_int(0)))
				mut iife_temp_97 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_97 := iife_temp_97.fromint(var_bas.array_get(var_j).array_get(rt.new_int(2)).array_get(rt.new_int(1)))
				mut iife_temp_98 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_98 := iife_temp_98.fromint(var_bas.array_get(var_j).array_get(rt.new_int(2)).array_get(rt.new_int(2)))
				mut iife_temp_99 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_99 := iife_temp_99.fromint(var_bas.array_get(var_j).array_get(rt.new_int(2)).array_get(rt.new_int(3)))
				mut iife_temp_100 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_100 := iife_temp_100.fromint(var_bas.array_get(var_j).array_get(rt.new_int(2)).array_get(rt.new_int(4)))
				mut iife_temp_101 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_101 := iife_temp_101.fromint(var_bas.array_get(var_j).array_get(rt.new_int(2)).array_get(rt.new_int(5)))
				mut iife_temp_102 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_102 := iife_temp_102.fromint(var_bas.array_get(var_j).array_get(rt.new_int(2)).array_get(rt.new_int(6)))
				mut iife_temp_103 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_103 := iife_temp_103.fromint(var_bas.array_get(var_j).array_get(rt.new_int(2)).array_get(rt.new_int(7)))
				mut iife_temp_104 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_104 := iife_temp_104.fromint(var_bas.array_get(var_j).array_get(rt.new_int(2)).array_get(rt.new_int(8)))
				mut iife_temp_105 := Class_ParagonIE_Sodium_Core32_Int32{}
				mut iife_result_105 := iife_temp_105.fromint(var_bas.array_get(var_j).array_get(rt.new_int(2)).array_get(rt.new_int(9)))
				mut iife_temp_106 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
				mut iife_result_106 := iife_temp_106.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: iife_result_96 }, rt.ArrayItem{ key: none, val: iife_result_97 }, rt.ArrayItem{ key: none, val: iife_result_98 }, rt.ArrayItem{ key: none, val: iife_result_99 }, rt.ArrayItem{ key: none, val: iife_result_100 }, rt.ArrayItem{ key: none, val: iife_result_101 }, rt.ArrayItem{ key: none, val: iife_result_102 }, rt.ArrayItem{ key: none, val: iife_result_103 }, rt.ArrayItem{ key: none, val: iife_result_104 }, rt.ArrayItem{ key: none, val: iife_result_105 }]))
				var_base.array_get_mut(var_i).array_set(var_j, create_paragonie_sodium_core32_curve25519_ge_precomp(iife_result_84, iife_result_95, iife_result_106))
				rt.pre_inc(var_j)
			}
		}
	}
	if !(rt.new_int(pos).is_long()) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Position must be an integer'))))
	}
	if pos < 0 || pos > 31 {
		rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(rt.new_string('Position is out of range [0, 31]'))))
	}
	mut var_bnegative := Class_ParagonIE_Sodium_Core32_Curve25519.negative(rt.new_int(b_mutated))
	mut var_babs := rt.new_int(b_mutated - rt.bitwise_and(rt.sub(rt.new_int(0), var_bnegative), rt.new_int(b_mutated)) << 1)
	mut var_t := Class_ParagonIE_Sodium_Core32_Curve25519.ge_precomp_0()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(8)))) { break }
		var_t = Class_ParagonIE_Sodium_Core32_Curve25519.cmov(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp](var_t), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp](var_base.array_get(rt.new_int(pos)).array_get(var_i)), rt.sub(rt.new_int(0), Class_ParagonIE_Sodium_Core32_Curve25519.equal(var_babs.clone(), rt.add(var_i, rt.new_int(1)))))
		rt.pre_inc(var_i)
	}
	mut var_minusT := create_paragonie_sodium_core32_curve25519_ge_precomp(Class_ParagonIE_Sodium_Core32_Curve25519.fe_copy(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_t, 'yminusx'))), Class_ParagonIE_Sodium_Core32_Curve25519.fe_copy(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_t, 'yplusx'))), Class_ParagonIE_Sodium_Core32_Curve25519.fe_neg(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_t, 'xy2d'))))
	return Class_ParagonIE_Sodium_Core32_Curve25519.cmov(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp](var_t), mut var_minusT, rt.sub(rt.new_int(0), var_bnegative))
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_sub(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3, mut var_q Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached) rt.PhpVal {
	mut var_q_mutated := var_q
	mut var_r := create_paragonie_sodium_core32_curve25519_ge_p1p1()
	rt.set_property(var_r, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'X'))))
	rt.set_property(var_r, 'Z', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_q_mutated, 'YminusX'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_q_mutated, 'YplusX'))))
	rt.set_property(var_r, 'T', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_q_mutated, 'T2d')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'T'))))
	rt.set_property(var_r, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_p, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_q_mutated, 'Z'))))
	mut var_t0 := Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'X')))
	rt.set_property(var_r, 'X', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Y'))))
	rt.set_property(var_r, 'Y', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Z')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'Y'))))
	rt.set_property(var_r, 'Z', Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'T'))))
	rt.set_property(var_r, 'T', Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_t0), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_r, 'T'))))
	return var_r.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_tobytes(mut var_h Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2) rt.PhpVal {
	mut var_h_mutated := var_h
	mut var_recip := Class_ParagonIE_Sodium_Core32_Curve25519.fe_invert(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h_mutated, 'Z')))
	mut var_x := Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h_mutated, 'X')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_recip))
	mut var_y := Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](rt.get_property(var_h_mutated, 'Y')), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_recip))
	mut var_s := Class_ParagonIE_Sodium_Core32_Curve25519.fe_tobytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_y))
	mut iife_temp_107 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_107 := iife_temp_107.chrtoint(var_s.array_get(rt.new_int(31)))
	mut iife_temp_108 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_108 := iife_temp_108.inttochr(rt.new_int(rt.bitwise_xor(iife_result_107, rt.shift_left(Class_ParagonIE_Sodium_Core32_Curve25519.fe_isnegative(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](var_x)), rt.new_int(7)))))
	var_s.array_set(31, iife_result_108)
	return var_s.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_double_scalarmult_vartime(mut var_a Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3, mut var_A Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3, var_b rt.PhpVal) rt.PhpVal {
	mut var_Bi := rt.new_null()
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
	mut var_Ai := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_Bi)))) {
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(8)))) { break }
			mut iife_temp_109 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_109 := iife_temp_109.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(0)).array_get(rt.new_int(0)))
			mut iife_temp_110 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_110 := iife_temp_110.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(0)).array_get(rt.new_int(1)))
			mut iife_temp_111 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_111 := iife_temp_111.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(0)).array_get(rt.new_int(2)))
			mut iife_temp_112 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_112 := iife_temp_112.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(0)).array_get(rt.new_int(3)))
			mut iife_temp_113 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_113 := iife_temp_113.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(0)).array_get(rt.new_int(4)))
			mut iife_temp_114 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_114 := iife_temp_114.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(0)).array_get(rt.new_int(5)))
			mut iife_temp_115 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_115 := iife_temp_115.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(0)).array_get(rt.new_int(6)))
			mut iife_temp_116 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_116 := iife_temp_116.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(0)).array_get(rt.new_int(7)))
			mut iife_temp_117 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_117 := iife_temp_117.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(0)).array_get(rt.new_int(8)))
			mut iife_temp_118 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_118 := iife_temp_118.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(0)).array_get(rt.new_int(9)))
			mut iife_temp_119 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
			mut iife_result_119 := iife_temp_119.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: iife_result_109 }, rt.ArrayItem{ key: none, val: iife_result_110 }, rt.ArrayItem{ key: none, val: iife_result_111 }, rt.ArrayItem{ key: none, val: iife_result_112 }, rt.ArrayItem{ key: none, val: iife_result_113 }, rt.ArrayItem{ key: none, val: iife_result_114 }, rt.ArrayItem{ key: none, val: iife_result_115 }, rt.ArrayItem{ key: none, val: iife_result_116 }, rt.ArrayItem{ key: none, val: iife_result_117 }, rt.ArrayItem{ key: none, val: iife_result_118 }]))
			mut iife_temp_120 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_120 := iife_temp_120.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(1)).array_get(rt.new_int(0)))
			mut iife_temp_121 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_121 := iife_temp_121.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(1)).array_get(rt.new_int(1)))
			mut iife_temp_122 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_122 := iife_temp_122.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(1)).array_get(rt.new_int(2)))
			mut iife_temp_123 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_123 := iife_temp_123.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(1)).array_get(rt.new_int(3)))
			mut iife_temp_124 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_124 := iife_temp_124.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(1)).array_get(rt.new_int(4)))
			mut iife_temp_125 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_125 := iife_temp_125.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(1)).array_get(rt.new_int(5)))
			mut iife_temp_126 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_126 := iife_temp_126.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(1)).array_get(rt.new_int(6)))
			mut iife_temp_127 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_127 := iife_temp_127.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(1)).array_get(rt.new_int(7)))
			mut iife_temp_128 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_128 := iife_temp_128.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(1)).array_get(rt.new_int(8)))
			mut iife_temp_129 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_129 := iife_temp_129.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(1)).array_get(rt.new_int(9)))
			mut iife_temp_130 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
			mut iife_result_130 := iife_temp_130.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: iife_result_120 }, rt.ArrayItem{ key: none, val: iife_result_121 }, rt.ArrayItem{ key: none, val: iife_result_122 }, rt.ArrayItem{ key: none, val: iife_result_123 }, rt.ArrayItem{ key: none, val: iife_result_124 }, rt.ArrayItem{ key: none, val: iife_result_125 }, rt.ArrayItem{ key: none, val: iife_result_126 }, rt.ArrayItem{ key: none, val: iife_result_127 }, rt.ArrayItem{ key: none, val: iife_result_128 }, rt.ArrayItem{ key: none, val: iife_result_129 }]))
			mut iife_temp_131 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_131 := iife_temp_131.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(2)).array_get(rt.new_int(0)))
			mut iife_temp_132 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_132 := iife_temp_132.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(2)).array_get(rt.new_int(1)))
			mut iife_temp_133 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_133 := iife_temp_133.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(2)).array_get(rt.new_int(2)))
			mut iife_temp_134 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_134 := iife_temp_134.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(2)).array_get(rt.new_int(3)))
			mut iife_temp_135 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_135 := iife_temp_135.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(2)).array_get(rt.new_int(4)))
			mut iife_temp_136 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_136 := iife_temp_136.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(2)).array_get(rt.new_int(5)))
			mut iife_temp_137 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_137 := iife_temp_137.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(2)).array_get(rt.new_int(6)))
			mut iife_temp_138 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_138 := iife_temp_138.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(2)).array_get(rt.new_int(7)))
			mut iife_temp_139 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_139 := iife_temp_139.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(2)).array_get(rt.new_int(8)))
			mut iife_temp_140 := Class_ParagonIE_Sodium_Core32_Int32{}
			mut iife_result_140 := iife_temp_140.fromint(rt.get_static_prop('ParagonIE_Sodium_Core32_Curve25519', 'base2').array_get(var_i).array_get(rt.new_int(2)).array_get(rt.new_int(9)))
			mut iife_temp_141 := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}
			mut iife_result_141 := iife_temp_141.fromarray(rt.create_array([rt.ArrayItem{ key: none, val: iife_result_131 }, rt.ArrayItem{ key: none, val: iife_result_132 }, rt.ArrayItem{ key: none, val: iife_result_133 }, rt.ArrayItem{ key: none, val: iife_result_134 }, rt.ArrayItem{ key: none, val: iife_result_135 }, rt.ArrayItem{ key: none, val: iife_result_136 }, rt.ArrayItem{ key: none, val: iife_result_137 }, rt.ArrayItem{ key: none, val: iife_result_138 }, rt.ArrayItem{ key: none, val: iife_result_139 }, rt.ArrayItem{ key: none, val: iife_result_140 }]))
			var_Bi.array_set(var_i, create_paragonie_sodium_core32_curve25519_ge_precomp(iife_result_119, iife_result_130, iife_result_141))
			rt.pre_inc(var_i)
		}
	}
	var_i = rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(8)))) { break }
		var_Ai.array_set(var_i, create_paragonie_sodium_core32_curve25519_ge_cached(Class_ParagonIE_Sodium_Core32_Curve25519.fe_0(), Class_ParagonIE_Sodium_Core32_Curve25519.fe_0(), Class_ParagonIE_Sodium_Core32_Curve25519.fe_0(), Class_ParagonIE_Sodium_Core32_Curve25519.fe_0()))
		rt.pre_inc(var_i)
	}
	mut var_aslide := Class_ParagonIE_Sodium_Core32_Curve25519.slide(rt.new_object('ParagonIE_Sodium_Core32_Curve25519_Ge_P3', []string{}, var_a_mutated))
	mut var_bslide := Class_ParagonIE_Sodium_Core32_Curve25519.slide(var_b_mutated.clone())
	var_Ai.array_set(0, Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_to_cached(mut var_A))
	mut var_t := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_dbl(mut var_A)
	mut var_A2 := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_t))
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(7)))) { break }
		var_t = Class_ParagonIE_Sodium_Core32_Curve25519.ge_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](var_A2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached](var_Ai.array_get(var_i)))
		mut var_u := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_t))
		var_Ai.array_set(rt.add(var_i, rt.new_int(1)), Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_to_cached(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](var_u)))
		rt.pre_inc(var_i)
	}
	mut var_r := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p2_0()
	mut var_i := rt.new_int(255)
	for {
		if !(rt.is_true(rt.greater_equal(var_i, rt.new_int(0)))) { break }
		if rt.is_true(var_aslide.array_get(var_i)) || rt.is_true(var_bslide.array_get(var_i)) {
			break
		}
		rt.pre_dec(var_i)
	}
	for {
		if !(rt.is_true(rt.greater_equal(var_i, rt.new_int(0)))) { break }
		mut var_t := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p2_dbl(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2](var_r))
		if rt.is_true(rt.greater(var_aslide.array_get(var_i), rt.new_int(0))) {
		mut var_u := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_t))
		var_t = Class_ParagonIE_Sodium_Core32_Curve25519.ge_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](var_u), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached](var_Ai.array_get(rt.new_int((rt.call_function('floor', [rt.div(var_aslide.array_get(var_i), rt.new_int(2))])).to_i64()))))
		} else if rt.is_true(rt.less(var_aslide.array_get(var_i), rt.new_int(0))) {
		var_u = Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_t))
		var_t = Class_ParagonIE_Sodium_Core32_Curve25519.ge_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](var_u), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached](var_Ai.array_get(rt.new_int((rt.call_function('floor', [rt.div(rt.sub(rt.new_int(0), var_aslide.array_get(var_i)), rt.new_int(2))])).to_i64()))))
		}
		if rt.is_true(rt.greater(var_bslide.array_get(var_i), rt.new_int(0))) {
		var_u = Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_t))
		mut var_index := rt.new_int((rt.call_function('floor', [rt.div(var_bslide.array_get(var_i), rt.new_int(2))])).to_i64())
		mut var_thisB := var_Bi.array_get(var_index)
		var_t = Class_ParagonIE_Sodium_Core32_Curve25519.ge_madd(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_t), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](var_u), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp](var_thisB))
		} else if rt.is_true(rt.less(var_bslide.array_get(var_i), rt.new_int(0))) {
		var_u = Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_t))
		var_index = rt.new_int((rt.call_function('floor', [rt.div(rt.sub(rt.new_int(0), var_bslide.array_get(var_i)), rt.new_int(2))])).to_i64())
		var_thisB = var_Bi.array_get(var_index)
		var_t = Class_ParagonIE_Sodium_Core32_Curve25519.ge_msub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_t), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](var_u), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp](var_thisB))
		}
		var_r = Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p2(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_t))
		rt.pre_dec(var_i)
	}
	return var_r.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_scalarmult_base(var_a rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
	mut var_e := rt.new_array()
	mut var_r := create_paragonie_sodium_core32_curve25519_ge_p1p1()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(32)))) { break }
		mut var_dbl := rt.new_int((var_i).to_i64()) << 1
		mut iife_temp_142 := Class_ParagonIE_Sodium_Core32_Curve25519{}
		mut iife_result_142 := iife_temp_142.chrtoint(var_a_mutated.array_get(var_i))
		var_e.array_set(var_dbl, rt.new_int((iife_result_142).to_i64()) & 15)
		mut iife_temp_143 := Class_ParagonIE_Sodium_Core32_Curve25519{}
		mut iife_result_143 := iife_temp_143.chrtoint(var_a_mutated.array_get(var_i))
		var_e.array_set(rt.add(var_dbl, rt.new_int(1)), rt.shift_right(iife_result_143, rt.new_int(4)) & 15)
		rt.pre_inc(var_i)
	}
	mut var_carry := rt.new_int(0)
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(63)))) { break }
		var_e.array_get(var_i) = rt.add(var_e.array_get(var_i), var_carry)
		var_carry = rt.add(var_e.array_get(var_i), rt.new_int(8))
		rt.new_null()
		var_e.array_get(var_i) = rt.sub(var_e.array_get(var_i), rt.shift_left(var_carry, rt.new_int(4)))
		rt.pre_inc(var_i)
	}
	var_e.array_get(rt.new_int(63)) = rt.add(var_e.array_get(rt.new_int(63)), rt.new_int((var_carry).to_i64()))
	mut var_h := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_0()
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(64)))) { break }
		mut var_t := Class_ParagonIE_Sodium_Core32_Curve25519.ge_select(rt.new_int((rt.call_function('floor', [rt.div(var_i, rt.new_int(2))])).to_i64()), rt.new_int((var_e.array_get(var_i)).to_i64()))
		var_r = Class_ParagonIE_Sodium_Core32_Curve25519.ge_madd(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_r), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](var_h), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp](var_t))
		var_h = Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_r))
		var_i = rt.add(var_i, rt.new_int(2))
	}
	var_r = Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_dbl(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](var_h))
	mut var_s := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p2(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_r))
	var_r = Class_ParagonIE_Sodium_Core32_Curve25519.ge_p2_dbl(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2](var_s))
	var_s = Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p2(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_r))
	var_r = Class_ParagonIE_Sodium_Core32_Curve25519.ge_p2_dbl(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2](var_s))
	var_s = Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p2(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_r))
	var_r = Class_ParagonIE_Sodium_Core32_Curve25519.ge_p2_dbl(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2](var_s))
	var_h = Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_r))
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(64)))) { break }
		mut var_t := Class_ParagonIE_Sodium_Core32_Curve25519.ge_select(rt.shift_right(var_i, rt.new_int(1)), rt.new_int((var_e.array_get(var_i)).to_i64()))
		mut var_r := Class_ParagonIE_Sodium_Core32_Curve25519.ge_madd(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_r), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](var_h), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp](var_t))
		mut var_h := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_r))
		var_i = rt.add(var_i, rt.new_int(2))
	}
	return var_h.clone()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.sc_muladd(var_a rt.PhpVal, var_b rt.PhpVal, var_c rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
	mut iife_temp_144 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_144 := iife_temp_144.substr(var_a_mutated.clone(), rt.new_int(0), rt.new_int(3))
	mut iife_temp_145 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_145 := iife_temp_145.load_3(iife_result_144)
	mut iife_temp_146 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_146 := iife_temp_146.fromint(rt.new_int(rt.bitwise_and(rt.new_int(2097151), iife_result_145)))
	mut var_a0 := iife_result_146
	mut iife_temp_147 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_147 := iife_temp_147.substr(var_a_mutated.clone(), rt.new_int(2), rt.new_int(4))
	mut iife_temp_148 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_148 := iife_temp_148.load_4(iife_result_147)
	mut iife_temp_149 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_149 := iife_temp_149.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_148, rt.new_int(5))))
	mut var_a1 := iife_result_149
	mut iife_temp_150 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_150 := iife_temp_150.substr(var_a_mutated.clone(), rt.new_int(5), rt.new_int(3))
	mut iife_temp_151 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_151 := iife_temp_151.load_3(iife_result_150)
	mut iife_temp_152 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_152 := iife_temp_152.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_151, rt.new_int(2))))
	mut var_a2 := iife_result_152
	mut iife_temp_153 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_153 := iife_temp_153.substr(var_a_mutated.clone(), rt.new_int(7), rt.new_int(4))
	mut iife_temp_154 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_154 := iife_temp_154.load_4(iife_result_153)
	mut iife_temp_155 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_155 := iife_temp_155.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_154, rt.new_int(7))))
	mut var_a3 := iife_result_155
	mut iife_temp_156 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_156 := iife_temp_156.substr(var_a_mutated.clone(), rt.new_int(10), rt.new_int(4))
	mut iife_temp_157 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_157 := iife_temp_157.load_4(iife_result_156)
	mut iife_temp_158 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_158 := iife_temp_158.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_157, rt.new_int(4))))
	mut var_a4 := iife_result_158
	mut iife_temp_159 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_159 := iife_temp_159.substr(var_a_mutated.clone(), rt.new_int(13), rt.new_int(3))
	mut iife_temp_160 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_160 := iife_temp_160.load_3(iife_result_159)
	mut iife_temp_161 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_161 := iife_temp_161.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_160, rt.new_int(1))))
	mut var_a5 := iife_result_161
	mut iife_temp_162 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_162 := iife_temp_162.substr(var_a_mutated.clone(), rt.new_int(15), rt.new_int(4))
	mut iife_temp_163 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_163 := iife_temp_163.load_4(iife_result_162)
	mut iife_temp_164 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_164 := iife_temp_164.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_163, rt.new_int(6))))
	mut var_a6 := iife_result_164
	mut iife_temp_165 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_165 := iife_temp_165.substr(var_a_mutated.clone(), rt.new_int(18), rt.new_int(3))
	mut iife_temp_166 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_166 := iife_temp_166.load_3(iife_result_165)
	mut iife_temp_167 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_167 := iife_temp_167.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_166, rt.new_int(3))))
	mut var_a7 := iife_result_167
	mut iife_temp_168 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_168 := iife_temp_168.substr(var_a_mutated.clone(), rt.new_int(21), rt.new_int(3))
	mut iife_temp_169 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_169 := iife_temp_169.load_3(iife_result_168)
	mut iife_temp_170 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_170 := iife_temp_170.fromint(rt.new_int(rt.bitwise_and(rt.new_int(2097151), iife_result_169)))
	mut var_a8 := iife_result_170
	mut iife_temp_171 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_171 := iife_temp_171.substr(var_a_mutated.clone(), rt.new_int(23), rt.new_int(4))
	mut iife_temp_172 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_172 := iife_temp_172.load_4(iife_result_171)
	mut iife_temp_173 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_173 := iife_temp_173.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_172, rt.new_int(5))))
	mut var_a9 := iife_result_173
	mut iife_temp_174 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_174 := iife_temp_174.substr(var_a_mutated.clone(), rt.new_int(26), rt.new_int(3))
	mut iife_temp_175 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_175 := iife_temp_175.load_3(iife_result_174)
	mut iife_temp_176 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_176 := iife_temp_176.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_175, rt.new_int(2))))
	mut var_a10 := iife_result_176
	mut iife_temp_177 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_177 := iife_temp_177.substr(var_a_mutated.clone(), rt.new_int(28), rt.new_int(4))
	mut iife_temp_178 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_178 := iife_temp_178.load_4(iife_result_177)
	mut iife_temp_179 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_179 := iife_temp_179.fromint(rt.new_int(536870911 & rt.shift_right(iife_result_178, rt.new_int(7))))
	mut var_a11 := iife_result_179
	mut iife_temp_180 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_180 := iife_temp_180.substr(var_b_mutated.clone(), rt.new_int(0), rt.new_int(3))
	mut iife_temp_181 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_181 := iife_temp_181.load_3(iife_result_180)
	mut iife_temp_182 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_182 := iife_temp_182.fromint(rt.new_int(rt.bitwise_and(rt.new_int(2097151), iife_result_181)))
	mut var_b0 := iife_result_182
	mut iife_temp_183 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_183 := iife_temp_183.substr(var_b_mutated.clone(), rt.new_int(2), rt.new_int(4))
	mut iife_temp_184 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_184 := iife_temp_184.load_4(iife_result_183)
	mut iife_temp_185 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_185 := iife_temp_185.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_184, rt.new_int(5))))
	mut var_b1 := iife_result_185
	mut iife_temp_186 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_186 := iife_temp_186.substr(var_b_mutated.clone(), rt.new_int(5), rt.new_int(3))
	mut iife_temp_187 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_187 := iife_temp_187.load_3(iife_result_186)
	mut iife_temp_188 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_188 := iife_temp_188.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_187, rt.new_int(2))))
	mut var_b2 := iife_result_188
	mut iife_temp_189 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_189 := iife_temp_189.substr(var_b_mutated.clone(), rt.new_int(7), rt.new_int(4))
	mut iife_temp_190 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_190 := iife_temp_190.load_4(iife_result_189)
	mut iife_temp_191 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_191 := iife_temp_191.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_190, rt.new_int(7))))
	mut var_b3 := iife_result_191
	mut iife_temp_192 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_192 := iife_temp_192.substr(var_b_mutated.clone(), rt.new_int(10), rt.new_int(4))
	mut iife_temp_193 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_193 := iife_temp_193.load_4(iife_result_192)
	mut iife_temp_194 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_194 := iife_temp_194.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_193, rt.new_int(4))))
	mut var_b4 := iife_result_194
	mut iife_temp_195 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_195 := iife_temp_195.substr(var_b_mutated.clone(), rt.new_int(13), rt.new_int(3))
	mut iife_temp_196 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_196 := iife_temp_196.load_3(iife_result_195)
	mut iife_temp_197 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_197 := iife_temp_197.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_196, rt.new_int(1))))
	mut var_b5 := iife_result_197
	mut iife_temp_198 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_198 := iife_temp_198.substr(var_b_mutated.clone(), rt.new_int(15), rt.new_int(4))
	mut iife_temp_199 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_199 := iife_temp_199.load_4(iife_result_198)
	mut iife_temp_200 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_200 := iife_temp_200.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_199, rt.new_int(6))))
	mut var_b6 := iife_result_200
	mut iife_temp_201 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_201 := iife_temp_201.substr(var_b_mutated.clone(), rt.new_int(18), rt.new_int(3))
	mut iife_temp_202 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_202 := iife_temp_202.load_3(iife_result_201)
	mut iife_temp_203 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_203 := iife_temp_203.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_202, rt.new_int(3))))
	mut var_b7 := iife_result_203
	mut iife_temp_204 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_204 := iife_temp_204.substr(var_b_mutated.clone(), rt.new_int(21), rt.new_int(3))
	mut iife_temp_205 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_205 := iife_temp_205.load_3(iife_result_204)
	mut iife_temp_206 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_206 := iife_temp_206.fromint(rt.new_int(rt.bitwise_and(rt.new_int(2097151), iife_result_205)))
	mut var_b8 := iife_result_206
	mut iife_temp_207 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_207 := iife_temp_207.substr(var_b_mutated.clone(), rt.new_int(23), rt.new_int(4))
	mut iife_temp_208 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_208 := iife_temp_208.load_4(iife_result_207)
	mut iife_temp_209 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_209 := iife_temp_209.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_208, rt.new_int(5))))
	mut var_b9 := iife_result_209
	mut iife_temp_210 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_210 := iife_temp_210.substr(var_b_mutated.clone(), rt.new_int(26), rt.new_int(3))
	mut iife_temp_211 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_211 := iife_temp_211.load_3(iife_result_210)
	mut iife_temp_212 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_212 := iife_temp_212.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_211, rt.new_int(2))))
	mut var_b10 := iife_result_212
	mut iife_temp_213 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_213 := iife_temp_213.substr(var_b_mutated.clone(), rt.new_int(28), rt.new_int(4))
	mut iife_temp_214 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_214 := iife_temp_214.load_4(iife_result_213)
	mut iife_temp_215 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_215 := iife_temp_215.fromint(rt.new_int(536870911 & rt.shift_right(iife_result_214, rt.new_int(7))))
	mut var_b11 := iife_result_215
	mut iife_temp_216 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_216 := iife_temp_216.substr(var_c.clone(), rt.new_int(0), rt.new_int(3))
	mut iife_temp_217 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_217 := iife_temp_217.load_3(iife_result_216)
	mut iife_temp_218 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_218 := iife_temp_218.fromint(rt.new_int(rt.bitwise_and(rt.new_int(2097151), iife_result_217)))
	mut var_c0 := iife_result_218
	mut iife_temp_219 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_219 := iife_temp_219.substr(var_c.clone(), rt.new_int(2), rt.new_int(4))
	mut iife_temp_220 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_220 := iife_temp_220.load_4(iife_result_219)
	mut iife_temp_221 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_221 := iife_temp_221.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_220, rt.new_int(5))))
	mut var_c1 := iife_result_221
	mut iife_temp_222 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_222 := iife_temp_222.substr(var_c.clone(), rt.new_int(5), rt.new_int(3))
	mut iife_temp_223 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_223 := iife_temp_223.load_3(iife_result_222)
	mut iife_temp_224 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_224 := iife_temp_224.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_223, rt.new_int(2))))
	mut var_c2 := iife_result_224
	mut iife_temp_225 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_225 := iife_temp_225.substr(var_c.clone(), rt.new_int(7), rt.new_int(4))
	mut iife_temp_226 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_226 := iife_temp_226.load_4(iife_result_225)
	mut iife_temp_227 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_227 := iife_temp_227.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_226, rt.new_int(7))))
	mut var_c3 := iife_result_227
	mut iife_temp_228 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_228 := iife_temp_228.substr(var_c.clone(), rt.new_int(10), rt.new_int(4))
	mut iife_temp_229 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_229 := iife_temp_229.load_4(iife_result_228)
	mut iife_temp_230 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_230 := iife_temp_230.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_229, rt.new_int(4))))
	mut var_c4 := iife_result_230
	mut iife_temp_231 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_231 := iife_temp_231.substr(var_c.clone(), rt.new_int(13), rt.new_int(3))
	mut iife_temp_232 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_232 := iife_temp_232.load_3(iife_result_231)
	mut iife_temp_233 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_233 := iife_temp_233.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_232, rt.new_int(1))))
	mut var_c5 := iife_result_233
	mut iife_temp_234 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_234 := iife_temp_234.substr(var_c.clone(), rt.new_int(15), rt.new_int(4))
	mut iife_temp_235 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_235 := iife_temp_235.load_4(iife_result_234)
	mut iife_temp_236 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_236 := iife_temp_236.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_235, rt.new_int(6))))
	mut var_c6 := iife_result_236
	mut iife_temp_237 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_237 := iife_temp_237.substr(var_c.clone(), rt.new_int(18), rt.new_int(3))
	mut iife_temp_238 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_238 := iife_temp_238.load_3(iife_result_237)
	mut iife_temp_239 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_239 := iife_temp_239.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_238, rt.new_int(3))))
	mut var_c7 := iife_result_239
	mut iife_temp_240 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_240 := iife_temp_240.substr(var_c.clone(), rt.new_int(21), rt.new_int(3))
	mut iife_temp_241 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_241 := iife_temp_241.load_3(iife_result_240)
	mut iife_temp_242 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_242 := iife_temp_242.fromint(rt.new_int(rt.bitwise_and(rt.new_int(2097151), iife_result_241)))
	mut var_c8 := iife_result_242
	mut iife_temp_243 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_243 := iife_temp_243.substr(var_c.clone(), rt.new_int(23), rt.new_int(4))
	mut iife_temp_244 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_244 := iife_temp_244.load_4(iife_result_243)
	mut iife_temp_245 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_245 := iife_temp_245.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_244, rt.new_int(5))))
	mut var_c9 := iife_result_245
	mut iife_temp_246 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_246 := iife_temp_246.substr(var_c.clone(), rt.new_int(26), rt.new_int(3))
	mut iife_temp_247 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_247 := iife_temp_247.load_3(iife_result_246)
	mut iife_temp_248 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_248 := iife_temp_248.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_247, rt.new_int(2))))
	mut var_c10 := iife_result_248
	mut iife_temp_249 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_249 := iife_temp_249.substr(var_c.clone(), rt.new_int(28), rt.new_int(4))
	mut iife_temp_250 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_250 := iife_temp_250.load_4(iife_result_249)
	mut iife_temp_251 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_251 := iife_temp_251.fromint(rt.new_int(536870911 & rt.shift_right(iife_result_250, rt.new_int(7))))
	mut var_c11 := iife_result_251
	mut var_s0 := rt.call_method(var_c0, 'addInt64', [rt.call_method(var_a0, 'mulInt64', [var_b0.clone(), rt.new_int(24)])])
	mut var_s1 := rt.call_method(rt.call_method(var_c1, 'addInt64', [rt.call_method(var_a0, 'mulInt64', [var_b1.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a1, 'mulInt64', [var_b0.clone(), rt.new_int(24)])])
	mut var_s2 := rt.call_method(rt.call_method(rt.call_method(var_c2, 'addInt64', [rt.call_method(var_a0, 'mulInt64', [var_b2.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a1, 'mulInt64', [var_b1.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a2, 'mulInt64', [var_b0.clone(), rt.new_int(24)])])
	mut var_s3 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_c3, 'addInt64', [rt.call_method(var_a0, 'mulInt64', [var_b3.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a1, 'mulInt64', [var_b2.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a2, 'mulInt64', [var_b1.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a3, 'mulInt64', [var_b0.clone(), rt.new_int(24)])])
	mut var_s4 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_c4, 'addInt64', [rt.call_method(var_a0, 'mulInt64', [var_b4.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a1, 'mulInt64', [var_b3.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a2, 'mulInt64', [var_b2.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a3, 'mulInt64', [var_b1.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a4, 'mulInt64', [var_b0.clone(), rt.new_int(24)])])
	mut var_s5 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_c5, 'addInt64', [rt.call_method(var_a0, 'mulInt64', [var_b5.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a1, 'mulInt64', [var_b4.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a2, 'mulInt64', [var_b3.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a3, 'mulInt64', [var_b2.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a4, 'mulInt64', [var_b1.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a5, 'mulInt64', [var_b0.clone(), rt.new_int(24)])])
	mut var_s6 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_c6, 'addInt64', [rt.call_method(var_a0, 'mulInt64', [var_b6.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a1, 'mulInt64', [var_b5.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a2, 'mulInt64', [var_b4.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a3, 'mulInt64', [var_b3.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a4, 'mulInt64', [var_b2.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a5, 'mulInt64', [var_b1.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a6, 'mulInt64', [var_b0.clone(), rt.new_int(24)])])
	mut var_s7 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_c7, 'addInt64', [rt.call_method(var_a0, 'mulInt64', [var_b7.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a1, 'mulInt64', [var_b6.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a2, 'mulInt64', [var_b5.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a3, 'mulInt64', [var_b4.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a4, 'mulInt64', [var_b3.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a5, 'mulInt64', [var_b2.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a6, 'mulInt64', [var_b1.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a7, 'mulInt64', [var_b0.clone(), rt.new_int(24)])])
	mut var_s8 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_c8, 'addInt64', [rt.call_method(var_a0, 'mulInt64', [var_b8.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a1, 'mulInt64', [var_b7.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a2, 'mulInt64', [var_b6.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a3, 'mulInt64', [var_b5.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a4, 'mulInt64', [var_b4.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a5, 'mulInt64', [var_b3.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a6, 'mulInt64', [var_b2.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a7, 'mulInt64', [var_b1.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a8, 'mulInt64', [var_b0.clone(), rt.new_int(24)])])
	mut var_s9 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_c9, 'addInt64', [rt.call_method(var_a0, 'mulInt64', [var_b9.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a1, 'mulInt64', [var_b8.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a2, 'mulInt64', [var_b7.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a3, 'mulInt64', [var_b6.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a4, 'mulInt64', [var_b5.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a5, 'mulInt64', [var_b4.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a6, 'mulInt64', [var_b3.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a7, 'mulInt64', [var_b2.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a8, 'mulInt64', [var_b1.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a9, 'mulInt64', [var_b0.clone(), rt.new_int(24)])])
	mut var_s10 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_c10, 'addInt64', [rt.call_method(var_a0, 'mulInt64', [var_b10.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a1, 'mulInt64', [var_b9.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a2, 'mulInt64', [var_b8.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a3, 'mulInt64', [var_b7.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a4, 'mulInt64', [var_b6.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a5, 'mulInt64', [var_b5.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a6, 'mulInt64', [var_b4.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a7, 'mulInt64', [var_b3.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a8, 'mulInt64', [var_b2.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a9, 'mulInt64', [var_b1.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a10, 'mulInt64', [var_b0.clone(), rt.new_int(24)])])
	mut var_s11 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_c11, 'addInt64', [rt.call_method(var_a0, 'mulInt64', [var_b11.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a1, 'mulInt64', [var_b10.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a2, 'mulInt64', [var_b9.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a3, 'mulInt64', [var_b8.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a4, 'mulInt64', [var_b7.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a5, 'mulInt64', [var_b6.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a6, 'mulInt64', [var_b5.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a7, 'mulInt64', [var_b4.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a8, 'mulInt64', [var_b3.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a9, 'mulInt64', [var_b2.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a10, 'mulInt64', [var_b1.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a11, 'mulInt64', [var_b0.clone(), rt.new_int(24)])])
	mut var_s12 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_a1, 'mulInt64', [var_b11.clone(), rt.new_int(24)]), 'addInt64', [rt.call_method(var_a2, 'mulInt64', [var_b10.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a3, 'mulInt64', [var_b9.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a4, 'mulInt64', [var_b8.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a5, 'mulInt64', [var_b7.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a6, 'mulInt64', [var_b6.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a7, 'mulInt64', [var_b5.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a8, 'mulInt64', [var_b4.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a9, 'mulInt64', [var_b3.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a10, 'mulInt64', [var_b2.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a11, 'mulInt64', [var_b1.clone(), rt.new_int(24)])])
	mut var_s13 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_a2, 'mulInt64', [var_b11.clone(), rt.new_int(24)]), 'addInt64', [rt.call_method(var_a3, 'mulInt64', [var_b10.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a4, 'mulInt64', [var_b9.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a5, 'mulInt64', [var_b8.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a6, 'mulInt64', [var_b7.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a7, 'mulInt64', [var_b6.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a8, 'mulInt64', [var_b5.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a9, 'mulInt64', [var_b4.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a10, 'mulInt64', [var_b3.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a11, 'mulInt64', [var_b2.clone(), rt.new_int(24)])])
	mut var_s14 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_a3, 'mulInt64', [var_b11.clone(), rt.new_int(24)]), 'addInt64', [rt.call_method(var_a4, 'mulInt64', [var_b10.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a5, 'mulInt64', [var_b9.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a6, 'mulInt64', [var_b8.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a7, 'mulInt64', [var_b7.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a8, 'mulInt64', [var_b6.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a9, 'mulInt64', [var_b5.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a10, 'mulInt64', [var_b4.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a11, 'mulInt64', [var_b3.clone(), rt.new_int(24)])])
	mut var_s15 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_a4, 'mulInt64', [var_b11.clone(), rt.new_int(24)]), 'addInt64', [rt.call_method(var_a5, 'mulInt64', [var_b10.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a6, 'mulInt64', [var_b9.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a7, 'mulInt64', [var_b8.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a8, 'mulInt64', [var_b7.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a9, 'mulInt64', [var_b6.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a10, 'mulInt64', [var_b5.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a11, 'mulInt64', [var_b4.clone(), rt.new_int(24)])])
	mut var_s16 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_a5, 'mulInt64', [var_b11.clone(), rt.new_int(24)]), 'addInt64', [rt.call_method(var_a6, 'mulInt64', [var_b10.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a7, 'mulInt64', [var_b9.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a8, 'mulInt64', [var_b8.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a9, 'mulInt64', [var_b7.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a10, 'mulInt64', [var_b6.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a11, 'mulInt64', [var_b5.clone(), rt.new_int(24)])])
	mut var_s17 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_a6, 'mulInt64', [var_b11.clone(), rt.new_int(24)]), 'addInt64', [rt.call_method(var_a7, 'mulInt64', [var_b10.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a8, 'mulInt64', [var_b9.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a9, 'mulInt64', [var_b8.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a10, 'mulInt64', [var_b7.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a11, 'mulInt64', [var_b6.clone(), rt.new_int(24)])])
	mut var_s18 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_a7, 'mulInt64', [var_b11.clone(), rt.new_int(24)]), 'addInt64', [rt.call_method(var_a8, 'mulInt64', [var_b10.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a9, 'mulInt64', [var_b9.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a10, 'mulInt64', [var_b8.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a11, 'mulInt64', [var_b7.clone(), rt.new_int(24)])])
	mut var_s19 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_a8, 'mulInt64', [var_b11.clone(), rt.new_int(24)]), 'addInt64', [rt.call_method(var_a9, 'mulInt64', [var_b10.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a10, 'mulInt64', [var_b9.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a11, 'mulInt64', [var_b8.clone(), rt.new_int(24)])])
	mut var_s20 := rt.call_method(rt.call_method(rt.call_method(var_a9, 'mulInt64', [var_b11.clone(), rt.new_int(24)]), 'addInt64', [rt.call_method(var_a10, 'mulInt64', [var_b10.clone(), rt.new_int(24)])]), 'addInt64', [rt.call_method(var_a11, 'mulInt64', [var_b9.clone(), rt.new_int(24)])])
	mut var_s21 := rt.call_method(rt.call_method(var_a10, 'mulInt64', [var_b11.clone(), rt.new_int(24)]), 'addInt64', [rt.call_method(var_a11, 'mulInt64', [var_b10.clone(), rt.new_int(24)])])
	mut var_s22 := rt.call_method(var_a11, 'mulInt64', [var_b11.clone(), rt.new_int(24)])
	mut var_s23 := create_paragonie_sodium_core32_int64()
	mut var_carry0 := rt.call_method(rt.call_method(var_s0, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s1 = rt.call_method(var_s1, 'addInt64', [var_carry0.clone()])
	var_s0 = rt.call_method(var_s0, 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry2 := rt.call_method(rt.call_method(var_s2, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s3 = rt.call_method(var_s3, 'addInt64', [var_carry2.clone()])
	var_s2 = rt.call_method(var_s2, 'subInt64', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry4 := rt.call_method(rt.call_method(var_s4, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s5 = rt.call_method(var_s5, 'addInt64', [var_carry4.clone()])
	var_s4 = rt.call_method(var_s4, 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry6 := rt.call_method(rt.call_method(var_s6, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s7 = rt.call_method(var_s7, 'addInt64', [var_carry6.clone()])
	var_s6 = rt.call_method(var_s6, 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry8 := rt.call_method(rt.call_method(var_s8, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s9 = rt.call_method(var_s9, 'addInt64', [var_carry8.clone()])
	var_s8 = rt.call_method(var_s8, 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry10 := rt.call_method(rt.call_method(var_s10, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s11 = rt.call_method(var_s11, 'addInt64', [var_carry10.clone()])
	var_s10 = rt.call_method(var_s10, 'subInt64', [rt.call_method(var_carry10, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry12 := rt.call_method(rt.call_method(var_s12, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s13 = rt.call_method(var_s13, 'addInt64', [var_carry12.clone()])
	var_s12 = rt.call_method(var_s12, 'subInt64', [rt.call_method(var_carry12, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry14 := rt.call_method(rt.call_method(var_s14, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s15 = rt.call_method(var_s15, 'addInt64', [var_carry14.clone()])
	var_s14 = rt.call_method(var_s14, 'subInt64', [rt.call_method(var_carry14, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry16 := rt.call_method(rt.call_method(var_s16, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s17 = rt.call_method(var_s17, 'addInt64', [var_carry16.clone()])
	var_s16 = rt.call_method(var_s16, 'subInt64', [rt.call_method(var_carry16, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry18 := rt.call_method(rt.call_method(var_s18, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s19 = rt.call_method(var_s19, 'addInt64', [var_carry18.clone()])
	var_s18 = rt.call_method(var_s18, 'subInt64', [rt.call_method(var_carry18, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry20 := rt.call_method(rt.call_method(var_s20, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s21 = rt.call_method(var_s21, 'addInt64', [var_carry20.clone()])
	var_s20 = rt.call_method(var_s20, 'subInt64', [rt.call_method(var_carry20, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry22 := rt.call_method(rt.call_method(var_s22, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s23 = rt.call_method(var_s23, 'addInt64', [var_carry22.clone()])
	var_s22 = rt.call_method(var_s22, 'subInt64', [rt.call_method(var_carry22, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry1 := rt.call_method(rt.call_method(var_s1, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s2 = rt.call_method(var_s2, 'addInt64', [var_carry1.clone()])
	var_s1 = rt.call_method(var_s1, 'subInt64', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry3 := rt.call_method(rt.call_method(var_s3, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s4 = rt.call_method(var_s4, 'addInt64', [var_carry3.clone()])
	var_s3 = rt.call_method(var_s3, 'subInt64', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry5 := rt.call_method(rt.call_method(var_s5, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s6 = rt.call_method(var_s6, 'addInt64', [var_carry5.clone()])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry7 := rt.call_method(rt.call_method(var_s7, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s8 = rt.call_method(var_s8, 'addInt64', [var_carry7.clone()])
	var_s7 = rt.call_method(var_s7, 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry9 := rt.call_method(rt.call_method(var_s9, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s10 = rt.call_method(var_s10, 'addInt64', [var_carry9.clone()])
	var_s9 = rt.call_method(var_s9, 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry11 := rt.call_method(rt.call_method(var_s11, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s12 = rt.call_method(var_s12, 'addInt64', [var_carry11.clone()])
	var_s11 = rt.call_method(var_s11, 'subInt64', [rt.call_method(var_carry11, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry13 := rt.call_method(rt.call_method(var_s13, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s14 = rt.call_method(var_s14, 'addInt64', [var_carry13.clone()])
	var_s13 = rt.call_method(var_s13, 'subInt64', [rt.call_method(var_carry13, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry15 := rt.call_method(rt.call_method(var_s15, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s16 = rt.call_method(var_s16, 'addInt64', [var_carry15.clone()])
	var_s15 = rt.call_method(var_s15, 'subInt64', [rt.call_method(var_carry15, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry17 := rt.call_method(rt.call_method(var_s17, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s18 = rt.call_method(var_s18, 'addInt64', [var_carry17.clone()])
	var_s17 = rt.call_method(var_s17, 'subInt64', [rt.call_method(var_carry17, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry19 := rt.call_method(rt.call_method(var_s19, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s20 = rt.call_method(var_s20, 'addInt64', [var_carry19.clone()])
	var_s19 = rt.call_method(var_s19, 'subInt64', [rt.call_method(var_carry19, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry21 := rt.call_method(rt.call_method(var_s21, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s22 = rt.call_method(var_s22, 'addInt64', [var_carry21.clone()])
	var_s21 = rt.call_method(var_s21, 'subInt64', [rt.call_method(var_carry21, 'shiftLeft', [rt.new_int(21)])])
	var_s11 = rt.call_method(var_s11, 'addInt64', [rt.call_method(var_s23, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s12 = rt.call_method(var_s12, 'addInt64', [rt.call_method(var_s23, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s13 = rt.call_method(var_s13, 'addInt64', [rt.call_method(var_s23, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s14 = rt.call_method(var_s14, 'subInt64', [rt.call_method(var_s23, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s15 = rt.call_method(var_s15, 'addInt64', [rt.call_method(var_s23, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s16 = rt.call_method(var_s16, 'subInt64', [rt.call_method(var_s23, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s10 = rt.call_method(var_s10, 'addInt64', [rt.call_method(var_s22, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s11 = rt.call_method(var_s11, 'addInt64', [rt.call_method(var_s22, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s12 = rt.call_method(var_s12, 'addInt64', [rt.call_method(var_s22, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s13 = rt.call_method(var_s13, 'subInt64', [rt.call_method(var_s22, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s14 = rt.call_method(var_s14, 'addInt64', [rt.call_method(var_s22, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s15 = rt.call_method(var_s15, 'subInt64', [rt.call_method(var_s22, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s9 = rt.call_method(var_s9, 'addInt64', [rt.call_method(var_s21, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s10 = rt.call_method(var_s10, 'addInt64', [rt.call_method(var_s21, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s11 = rt.call_method(var_s11, 'addInt64', [rt.call_method(var_s21, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s12 = rt.call_method(var_s12, 'subInt64', [rt.call_method(var_s21, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s13 = rt.call_method(var_s13, 'addInt64', [rt.call_method(var_s21, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s14 = rt.call_method(var_s14, 'subInt64', [rt.call_method(var_s21, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s8 = rt.call_method(var_s8, 'addInt64', [rt.call_method(var_s20, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s9 = rt.call_method(var_s9, 'addInt64', [rt.call_method(var_s20, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s10 = rt.call_method(var_s10, 'addInt64', [rt.call_method(var_s20, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s11 = rt.call_method(var_s11, 'subInt64', [rt.call_method(var_s20, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s12 = rt.call_method(var_s12, 'addInt64', [rt.call_method(var_s20, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s13 = rt.call_method(var_s13, 'subInt64', [rt.call_method(var_s20, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s7 = rt.call_method(var_s7, 'addInt64', [rt.call_method(var_s19, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s8 = rt.call_method(var_s8, 'addInt64', [rt.call_method(var_s19, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s9 = rt.call_method(var_s9, 'addInt64', [rt.call_method(var_s19, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s10 = rt.call_method(var_s10, 'subInt64', [rt.call_method(var_s19, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s11 = rt.call_method(var_s11, 'addInt64', [rt.call_method(var_s19, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s12 = rt.call_method(var_s12, 'subInt64', [rt.call_method(var_s19, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s6 = rt.call_method(var_s6, 'addInt64', [rt.call_method(var_s18, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s7 = rt.call_method(var_s7, 'addInt64', [rt.call_method(var_s18, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s8 = rt.call_method(var_s8, 'addInt64', [rt.call_method(var_s18, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s9 = rt.call_method(var_s9, 'subInt64', [rt.call_method(var_s18, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s10 = rt.call_method(var_s10, 'addInt64', [rt.call_method(var_s18, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s11 = rt.call_method(var_s11, 'subInt64', [rt.call_method(var_s18, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_carry6 = rt.call_method(rt.call_method(var_s6, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s7 = rt.call_method(var_s7, 'addInt64', [var_carry6.clone()])
	var_s6 = rt.call_method(var_s6, 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(21)])])
	var_carry8 = rt.call_method(rt.call_method(var_s8, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s9 = rt.call_method(var_s9, 'addInt64', [var_carry8.clone()])
	var_s8 = rt.call_method(var_s8, 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(21)])])
	var_carry10 = rt.call_method(rt.call_method(var_s10, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s11 = rt.call_method(var_s11, 'addInt64', [var_carry10.clone()])
	var_s10 = rt.call_method(var_s10, 'subInt64', [rt.call_method(var_carry10, 'shiftLeft', [rt.new_int(21)])])
	var_carry12 = rt.call_method(rt.call_method(var_s12, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s13 = rt.call_method(var_s13, 'addInt64', [var_carry12.clone()])
	var_s12 = rt.call_method(var_s12, 'subInt64', [rt.call_method(var_carry12, 'shiftLeft', [rt.new_int(21)])])
	var_carry14 = rt.call_method(rt.call_method(var_s14, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s15 = rt.call_method(var_s15, 'addInt64', [var_carry14.clone()])
	var_s14 = rt.call_method(var_s14, 'subInt64', [rt.call_method(var_carry14, 'shiftLeft', [rt.new_int(21)])])
	var_carry16 = rt.call_method(rt.call_method(var_s16, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s17 = rt.call_method(var_s17, 'addInt64', [var_carry16.clone()])
	var_s16 = rt.call_method(var_s16, 'subInt64', [rt.call_method(var_carry16, 'shiftLeft', [rt.new_int(21)])])
	var_carry7 = rt.call_method(rt.call_method(var_s7, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s8 = rt.call_method(var_s8, 'addInt64', [var_carry7.clone()])
	var_s7 = rt.call_method(var_s7, 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(21)])])
	var_carry9 = rt.call_method(rt.call_method(var_s9, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s10 = rt.call_method(var_s10, 'addInt64', [var_carry9.clone()])
	var_s9 = rt.call_method(var_s9, 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(21)])])
	var_carry11 = rt.call_method(rt.call_method(var_s11, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s12 = rt.call_method(var_s12, 'addInt64', [var_carry11.clone()])
	var_s11 = rt.call_method(var_s11, 'subInt64', [rt.call_method(var_carry11, 'shiftLeft', [rt.new_int(21)])])
	var_carry13 = rt.call_method(rt.call_method(var_s13, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s14 = rt.call_method(var_s14, 'addInt64', [var_carry13.clone()])
	var_s13 = rt.call_method(var_s13, 'subInt64', [rt.call_method(var_carry13, 'shiftLeft', [rt.new_int(21)])])
	var_carry15 = rt.call_method(rt.call_method(var_s15, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s16 = rt.call_method(var_s16, 'addInt64', [var_carry15.clone()])
	var_s15 = rt.call_method(var_s15, 'subInt64', [rt.call_method(var_carry15, 'shiftLeft', [rt.new_int(21)])])
	var_s5 = rt.call_method(var_s5, 'addInt64', [rt.call_method(var_s17, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s6 = rt.call_method(var_s6, 'addInt64', [rt.call_method(var_s17, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s7 = rt.call_method(var_s7, 'addInt64', [rt.call_method(var_s17, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s8 = rt.call_method(var_s8, 'subInt64', [rt.call_method(var_s17, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s9 = rt.call_method(var_s9, 'addInt64', [rt.call_method(var_s17, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s10 = rt.call_method(var_s10, 'subInt64', [rt.call_method(var_s17, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s4 = rt.call_method(var_s4, 'addInt64', [rt.call_method(var_s16, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s5 = rt.call_method(var_s5, 'addInt64', [rt.call_method(var_s16, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s6 = rt.call_method(var_s6, 'addInt64', [rt.call_method(var_s16, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s7 = rt.call_method(var_s7, 'subInt64', [rt.call_method(var_s16, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s8 = rt.call_method(var_s8, 'addInt64', [rt.call_method(var_s16, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s9 = rt.call_method(var_s9, 'subInt64', [rt.call_method(var_s16, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s3 = rt.call_method(var_s3, 'addInt64', [rt.call_method(var_s15, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s4 = rt.call_method(var_s4, 'addInt64', [rt.call_method(var_s15, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s5 = rt.call_method(var_s5, 'addInt64', [rt.call_method(var_s15, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s6 = rt.call_method(var_s6, 'subInt64', [rt.call_method(var_s15, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s7 = rt.call_method(var_s7, 'addInt64', [rt.call_method(var_s15, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s8 = rt.call_method(var_s8, 'subInt64', [rt.call_method(var_s15, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s2 = rt.call_method(var_s2, 'addInt64', [rt.call_method(var_s14, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s3 = rt.call_method(var_s3, 'addInt64', [rt.call_method(var_s14, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s4 = rt.call_method(var_s4, 'addInt64', [rt.call_method(var_s14, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_s14, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s6 = rt.call_method(var_s6, 'addInt64', [rt.call_method(var_s14, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s7 = rt.call_method(var_s7, 'subInt64', [rt.call_method(var_s14, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s1 = rt.call_method(var_s1, 'addInt64', [rt.call_method(var_s13, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s2 = rt.call_method(var_s2, 'addInt64', [rt.call_method(var_s13, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s3 = rt.call_method(var_s3, 'addInt64', [rt.call_method(var_s13, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s4 = rt.call_method(var_s4, 'subInt64', [rt.call_method(var_s13, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s5 = rt.call_method(var_s5, 'addInt64', [rt.call_method(var_s13, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s6 = rt.call_method(var_s6, 'subInt64', [rt.call_method(var_s13, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s0 = rt.call_method(var_s0, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s1 = rt.call_method(var_s1, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s2 = rt.call_method(var_s2, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s3 = rt.call_method(var_s3, 'subInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s4 = rt.call_method(var_s4, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s12 = create_paragonie_sodium_core32_int64()
	var_carry0 = rt.call_method(rt.call_method(var_s0, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s1 = rt.call_method(var_s1, 'addInt64', [var_carry0.clone()])
	var_s0 = rt.call_method(var_s0, 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(21)])])
	var_carry2 = rt.call_method(rt.call_method(var_s2, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s3 = rt.call_method(var_s3, 'addInt64', [var_carry2.clone()])
	var_s2 = rt.call_method(var_s2, 'subInt64', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(21)])])
	var_carry4 = rt.call_method(rt.call_method(var_s4, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s5 = rt.call_method(var_s5, 'addInt64', [var_carry4.clone()])
	var_s4 = rt.call_method(var_s4, 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(21)])])
	var_carry6 = rt.call_method(rt.call_method(var_s6, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s7 = rt.call_method(var_s7, 'addInt64', [var_carry6.clone()])
	var_s6 = rt.call_method(var_s6, 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(21)])])
	var_carry8 = rt.call_method(rt.call_method(var_s8, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s9 = rt.call_method(var_s9, 'addInt64', [var_carry8.clone()])
	var_s8 = rt.call_method(var_s8, 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(21)])])
	var_carry10 = rt.call_method(rt.call_method(var_s10, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s11 = rt.call_method(var_s11, 'addInt64', [var_carry10.clone()])
	var_s10 = rt.call_method(var_s10, 'subInt64', [rt.call_method(var_carry10, 'shiftLeft', [rt.new_int(21)])])
	var_carry1 = rt.call_method(rt.call_method(var_s1, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s2 = rt.call_method(var_s2, 'addInt64', [var_carry1.clone()])
	var_s1 = rt.call_method(var_s1, 'subInt64', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(21)])])
	var_carry3 = rt.call_method(rt.call_method(var_s3, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s4 = rt.call_method(var_s4, 'addInt64', [var_carry3.clone()])
	var_s3 = rt.call_method(var_s3, 'subInt64', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(21)])])
	var_carry5 = rt.call_method(rt.call_method(var_s5, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s6 = rt.call_method(var_s6, 'addInt64', [var_carry5.clone()])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(21)])])
	var_carry7 = rt.call_method(rt.call_method(var_s7, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s8 = rt.call_method(var_s8, 'addInt64', [var_carry7.clone()])
	var_s7 = rt.call_method(var_s7, 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(21)])])
	var_carry9 = rt.call_method(rt.call_method(var_s9, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s10 = rt.call_method(var_s10, 'addInt64', [var_carry9.clone()])
	var_s9 = rt.call_method(var_s9, 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(21)])])
	var_carry11 = rt.call_method(rt.call_method(var_s11, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s12 = rt.call_method(var_s12, 'addInt64', [var_carry11.clone()])
	var_s11 = rt.call_method(var_s11, 'subInt64', [rt.call_method(var_carry11, 'shiftLeft', [rt.new_int(21)])])
	var_s0 = rt.call_method(var_s0, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s1 = rt.call_method(var_s1, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s2 = rt.call_method(var_s2, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s3 = rt.call_method(var_s3, 'subInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s4 = rt.call_method(var_s4, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s12 = create_paragonie_sodium_core32_int64()
	var_carry0 = rt.call_method(var_s0, 'shiftRight', [rt.new_int(21)])
	var_s1 = rt.call_method(var_s1, 'addInt64', [var_carry0.clone()])
	var_s0 = rt.call_method(var_s0, 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(21)])])
	var_carry1 = rt.call_method(var_s1, 'shiftRight', [rt.new_int(21)])
	var_s2 = rt.call_method(var_s2, 'addInt64', [var_carry1.clone()])
	var_s1 = rt.call_method(var_s1, 'subInt64', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(21)])])
	var_carry2 = rt.call_method(var_s2, 'shiftRight', [rt.new_int(21)])
	var_s3 = rt.call_method(var_s3, 'addInt64', [var_carry2.clone()])
	var_s2 = rt.call_method(var_s2, 'subInt64', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(21)])])
	var_carry3 = rt.call_method(var_s3, 'shiftRight', [rt.new_int(21)])
	var_s4 = rt.call_method(var_s4, 'addInt64', [var_carry3.clone()])
	var_s3 = rt.call_method(var_s3, 'subInt64', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(21)])])
	var_carry4 = rt.call_method(var_s4, 'shiftRight', [rt.new_int(21)])
	var_s5 = rt.call_method(var_s5, 'addInt64', [var_carry4.clone()])
	var_s4 = rt.call_method(var_s4, 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(21)])])
	var_carry5 = rt.call_method(var_s5, 'shiftRight', [rt.new_int(21)])
	var_s6 = rt.call_method(var_s6, 'addInt64', [var_carry5.clone()])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(21)])])
	var_carry6 = rt.call_method(var_s6, 'shiftRight', [rt.new_int(21)])
	var_s7 = rt.call_method(var_s7, 'addInt64', [var_carry6.clone()])
	var_s6 = rt.call_method(var_s6, 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(21)])])
	var_carry7 = rt.call_method(var_s7, 'shiftRight', [rt.new_int(21)])
	var_s8 = rt.call_method(var_s8, 'addInt64', [var_carry7.clone()])
	var_s7 = rt.call_method(var_s7, 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(21)])])
	var_carry8 = rt.call_method(var_s8, 'shiftRight', [rt.new_int(21)])
	var_s9 = rt.call_method(var_s9, 'addInt64', [var_carry8.clone()])
	var_s8 = rt.call_method(var_s8, 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(21)])])
	var_carry9 = rt.call_method(var_s9, 'shiftRight', [rt.new_int(21)])
	var_s10 = rt.call_method(var_s10, 'addInt64', [var_carry9.clone()])
	var_s9 = rt.call_method(var_s9, 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(21)])])
	var_carry10 = rt.call_method(var_s10, 'shiftRight', [rt.new_int(21)])
	var_s11 = rt.call_method(var_s11, 'addInt64', [var_carry10.clone()])
	var_s10 = rt.call_method(var_s10, 'subInt64', [rt.call_method(var_carry10, 'shiftLeft', [rt.new_int(21)])])
	var_carry11 = rt.call_method(var_s11, 'shiftRight', [rt.new_int(21)])
	var_s12 = rt.call_method(var_s12, 'addInt64', [var_carry11.clone()])
	var_s11 = rt.call_method(var_s11, 'subInt64', [rt.call_method(var_carry11, 'shiftLeft', [rt.new_int(21)])])
	var_s0 = rt.call_method(var_s0, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s1 = rt.call_method(var_s1, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s2 = rt.call_method(var_s2, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s3 = rt.call_method(var_s3, 'subInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s4 = rt.call_method(var_s4, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_carry0 = rt.call_method(var_s0, 'shiftRight', [rt.new_int(21)])
	var_s1 = rt.call_method(var_s1, 'addInt64', [var_carry0.clone()])
	var_s0 = rt.call_method(var_s0, 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(21)])])
	var_carry1 = rt.call_method(var_s1, 'shiftRight', [rt.new_int(21)])
	var_s2 = rt.call_method(var_s2, 'addInt64', [var_carry1.clone()])
	var_s1 = rt.call_method(var_s1, 'subInt64', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(21)])])
	var_carry2 = rt.call_method(var_s2, 'shiftRight', [rt.new_int(21)])
	var_s3 = rt.call_method(var_s3, 'addInt64', [var_carry2.clone()])
	var_s2 = rt.call_method(var_s2, 'subInt64', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(21)])])
	var_carry3 = rt.call_method(var_s3, 'shiftRight', [rt.new_int(21)])
	var_s4 = rt.call_method(var_s4, 'addInt64', [var_carry3.clone()])
	var_s3 = rt.call_method(var_s3, 'subInt64', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(21)])])
	var_carry4 = rt.call_method(var_s4, 'shiftRight', [rt.new_int(21)])
	var_s5 = rt.call_method(var_s5, 'addInt64', [var_carry4.clone()])
	var_s4 = rt.call_method(var_s4, 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(21)])])
	var_carry5 = rt.call_method(var_s5, 'shiftRight', [rt.new_int(21)])
	var_s6 = rt.call_method(var_s6, 'addInt64', [var_carry5.clone()])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(21)])])
	var_carry6 = rt.call_method(var_s6, 'shiftRight', [rt.new_int(21)])
	var_s7 = rt.call_method(var_s7, 'addInt64', [var_carry6.clone()])
	var_s6 = rt.call_method(var_s6, 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(21)])])
	var_carry7 = rt.call_method(var_s7, 'shiftRight', [rt.new_int(21)])
	var_s8 = rt.call_method(var_s8, 'addInt64', [var_carry7.clone()])
	var_s7 = rt.call_method(var_s7, 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(21)])])
	var_carry8 = rt.call_method(var_s10, 'shiftRight', [rt.new_int(21)])
	var_s9 = rt.call_method(var_s9, 'addInt64', [var_carry8.clone()])
	var_s8 = rt.call_method(var_s8, 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(21)])])
	var_carry9 = rt.call_method(var_s9, 'shiftRight', [rt.new_int(21)])
	var_s10 = rt.call_method(var_s10, 'addInt64', [var_carry9.clone()])
	var_s9 = rt.call_method(var_s9, 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(21)])])
	var_carry10 = rt.call_method(var_s10, 'shiftRight', [rt.new_int(21)])
	var_s11 = rt.call_method(var_s11, 'addInt64', [var_carry10.clone()])
	var_s10 = rt.call_method(var_s10, 'subInt64', [rt.call_method(var_carry10, 'shiftLeft', [rt.new_int(21)])])
	mut var_S0 := rt.call_method(var_s0, 'toInt', []rt.PhpVal{})
	mut var_S1 := rt.call_method(var_s1, 'toInt', []rt.PhpVal{})
	mut var_S2 := rt.call_method(var_s2, 'toInt', []rt.PhpVal{})
	mut var_S3 := rt.call_method(var_s3, 'toInt', []rt.PhpVal{})
	mut var_S4 := rt.call_method(var_s4, 'toInt', []rt.PhpVal{})
	mut var_S5 := rt.call_method(var_s5, 'toInt', []rt.PhpVal{})
	mut var_S6 := rt.call_method(var_s6, 'toInt', []rt.PhpVal{})
	mut var_S7 := rt.call_method(var_s7, 'toInt', []rt.PhpVal{})
	mut var_S8 := rt.call_method(var_s8, 'toInt', []rt.PhpVal{})
	mut var_S9 := rt.call_method(var_s9, 'toInt', []rt.PhpVal{})
	mut var_S10 := rt.call_method(var_s10, 'toInt', []rt.PhpVal{})
	mut var_S11 := rt.call_method(var_s11, 'toInt', []rt.PhpVal{})
	mut var_arr := rt.create_array([rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S0, rt.new_int(0)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S0, rt.new_int(8)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S0, rt.new_int(16)) | rt.shift_left(var_S1, rt.new_int(5)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S1, rt.new_int(3)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S1, rt.new_int(11)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S1, rt.new_int(19)) | rt.shift_left(var_S2, rt.new_int(2)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S2, rt.new_int(6)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S2, rt.new_int(14)) | rt.shift_left(var_S3, rt.new_int(7)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S3, rt.new_int(1)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S3, rt.new_int(9)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S3, rt.new_int(17)) | rt.shift_left(var_S4, rt.new_int(4)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S4, rt.new_int(4)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S4, rt.new_int(12)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S4, rt.new_int(20)) | rt.shift_left(var_S5, rt.new_int(1)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S5, rt.new_int(7)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S5, rt.new_int(15)) | rt.shift_left(var_S6, rt.new_int(6)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S6, rt.new_int(2)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S6, rt.new_int(10)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S6, rt.new_int(18)) | rt.shift_left(var_S7, rt.new_int(3)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S7, rt.new_int(5)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S7, rt.new_int(13)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S8, rt.new_int(0)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S8, rt.new_int(8)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S8, rt.new_int(16)) | rt.shift_left(var_S9, rt.new_int(5)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S9, rt.new_int(3)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S9, rt.new_int(11)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S9, rt.new_int(19)) | rt.shift_left(var_S10, rt.new_int(2)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S10, rt.new_int(6)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S10, rt.new_int(14)) | rt.shift_left(var_S11, rt.new_int(7)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S11, rt.new_int(1)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S11, rt.new_int(9)) }, rt.ArrayItem{ key: none, val: 255 & rt.shift_right(var_S11, rt.new_int(17)) }])
	mut iife_temp_252 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_252 := iife_temp_252.intarraytostring(var_arr.clone())
	return iife_result_252
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.sc_reduce(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
	mut iife_temp_253 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_253 := iife_temp_253.substr(var_s_mutated.clone(), rt.new_int(0), rt.new_int(3))
	mut iife_temp_254 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_254 := iife_temp_254.load_3(iife_result_253)
	mut iife_temp_255 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_255 := iife_temp_255.fromint(rt.new_int(rt.bitwise_and(rt.new_int(2097151), iife_result_254)))
	mut var_s0 := iife_result_255
	mut iife_temp_256 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_256 := iife_temp_256.substr(var_s_mutated.clone(), rt.new_int(2), rt.new_int(4))
	mut iife_temp_257 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_257 := iife_temp_257.load_4(iife_result_256)
	mut iife_temp_258 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_258 := iife_temp_258.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_257, rt.new_int(5))))
	mut var_s1 := iife_result_258
	mut iife_temp_259 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_259 := iife_temp_259.substr(var_s_mutated.clone(), rt.new_int(5), rt.new_int(3))
	mut iife_temp_260 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_260 := iife_temp_260.load_3(iife_result_259)
	mut iife_temp_261 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_261 := iife_temp_261.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_260, rt.new_int(2))))
	mut var_s2 := iife_result_261
	mut iife_temp_262 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_262 := iife_temp_262.substr(var_s_mutated.clone(), rt.new_int(7), rt.new_int(4))
	mut iife_temp_263 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_263 := iife_temp_263.load_4(iife_result_262)
	mut iife_temp_264 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_264 := iife_temp_264.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_263, rt.new_int(7))))
	mut var_s3 := iife_result_264
	mut iife_temp_265 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_265 := iife_temp_265.substr(var_s_mutated.clone(), rt.new_int(10), rt.new_int(4))
	mut iife_temp_266 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_266 := iife_temp_266.load_4(iife_result_265)
	mut iife_temp_267 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_267 := iife_temp_267.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_266, rt.new_int(4))))
	mut var_s4 := iife_result_267
	mut iife_temp_268 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_268 := iife_temp_268.substr(var_s_mutated.clone(), rt.new_int(13), rt.new_int(3))
	mut iife_temp_269 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_269 := iife_temp_269.load_3(iife_result_268)
	mut iife_temp_270 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_270 := iife_temp_270.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_269, rt.new_int(1))))
	mut var_s5 := iife_result_270
	mut iife_temp_271 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_271 := iife_temp_271.substr(var_s_mutated.clone(), rt.new_int(15), rt.new_int(4))
	mut iife_temp_272 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_272 := iife_temp_272.load_4(iife_result_271)
	mut iife_temp_273 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_273 := iife_temp_273.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_272, rt.new_int(6))))
	mut var_s6 := iife_result_273
	mut iife_temp_274 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_274 := iife_temp_274.substr(var_s_mutated.clone(), rt.new_int(18), rt.new_int(4))
	mut iife_temp_275 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_275 := iife_temp_275.load_3(iife_result_274)
	mut iife_temp_276 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_276 := iife_temp_276.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_275, rt.new_int(3))))
	mut var_s7 := iife_result_276
	mut iife_temp_277 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_277 := iife_temp_277.substr(var_s_mutated.clone(), rt.new_int(21), rt.new_int(3))
	mut iife_temp_278 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_278 := iife_temp_278.load_3(iife_result_277)
	mut iife_temp_279 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_279 := iife_temp_279.fromint(rt.new_int(rt.bitwise_and(rt.new_int(2097151), iife_result_278)))
	mut var_s8 := iife_result_279
	mut iife_temp_280 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_280 := iife_temp_280.substr(var_s_mutated.clone(), rt.new_int(23), rt.new_int(4))
	mut iife_temp_281 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_281 := iife_temp_281.load_4(iife_result_280)
	mut iife_temp_282 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_282 := iife_temp_282.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_281, rt.new_int(5))))
	mut var_s9 := iife_result_282
	mut iife_temp_283 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_283 := iife_temp_283.substr(var_s_mutated.clone(), rt.new_int(26), rt.new_int(3))
	mut iife_temp_284 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_284 := iife_temp_284.load_3(iife_result_283)
	mut iife_temp_285 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_285 := iife_temp_285.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_284, rt.new_int(2))))
	mut var_s10 := iife_result_285
	mut iife_temp_286 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_286 := iife_temp_286.substr(var_s_mutated.clone(), rt.new_int(28), rt.new_int(4))
	mut iife_temp_287 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_287 := iife_temp_287.load_4(iife_result_286)
	mut iife_temp_288 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_288 := iife_temp_288.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_287, rt.new_int(7))))
	mut var_s11 := iife_result_288
	mut iife_temp_289 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_289 := iife_temp_289.substr(var_s_mutated.clone(), rt.new_int(31), rt.new_int(4))
	mut iife_temp_290 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_290 := iife_temp_290.load_4(iife_result_289)
	mut iife_temp_291 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_291 := iife_temp_291.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_290, rt.new_int(4))))
	mut var_s12 := iife_result_291
	mut iife_temp_292 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_292 := iife_temp_292.substr(var_s_mutated.clone(), rt.new_int(34), rt.new_int(3))
	mut iife_temp_293 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_293 := iife_temp_293.load_3(iife_result_292)
	mut iife_temp_294 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_294 := iife_temp_294.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_293, rt.new_int(1))))
	mut var_s13 := iife_result_294
	mut iife_temp_295 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_295 := iife_temp_295.substr(var_s_mutated.clone(), rt.new_int(36), rt.new_int(4))
	mut iife_temp_296 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_296 := iife_temp_296.load_4(iife_result_295)
	mut iife_temp_297 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_297 := iife_temp_297.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_296, rt.new_int(6))))
	mut var_s14 := iife_result_297
	mut iife_temp_298 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_298 := iife_temp_298.substr(var_s_mutated.clone(), rt.new_int(39), rt.new_int(4))
	mut iife_temp_299 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_299 := iife_temp_299.load_3(iife_result_298)
	mut iife_temp_300 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_300 := iife_temp_300.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_299, rt.new_int(3))))
	mut var_s15 := iife_result_300
	mut iife_temp_301 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_301 := iife_temp_301.substr(var_s_mutated.clone(), rt.new_int(42), rt.new_int(3))
	mut iife_temp_302 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_302 := iife_temp_302.load_3(iife_result_301)
	mut iife_temp_303 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_303 := iife_temp_303.fromint(rt.new_int(rt.bitwise_and(rt.new_int(2097151), iife_result_302)))
	mut var_s16 := iife_result_303
	mut iife_temp_304 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_304 := iife_temp_304.substr(var_s_mutated.clone(), rt.new_int(44), rt.new_int(4))
	mut iife_temp_305 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_305 := iife_temp_305.load_4(iife_result_304)
	mut iife_temp_306 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_306 := iife_temp_306.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_305, rt.new_int(5))))
	mut var_s17 := iife_result_306
	mut iife_temp_307 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_307 := iife_temp_307.substr(var_s_mutated.clone(), rt.new_int(47), rt.new_int(3))
	mut iife_temp_308 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_308 := iife_temp_308.load_3(iife_result_307)
	mut iife_temp_309 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_309 := iife_temp_309.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_308, rt.new_int(2))))
	mut var_s18 := iife_result_309
	mut iife_temp_310 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_310 := iife_temp_310.substr(var_s_mutated.clone(), rt.new_int(49), rt.new_int(4))
	mut iife_temp_311 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_311 := iife_temp_311.load_4(iife_result_310)
	mut iife_temp_312 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_312 := iife_temp_312.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_311, rt.new_int(7))))
	mut var_s19 := iife_result_312
	mut iife_temp_313 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_313 := iife_temp_313.substr(var_s_mutated.clone(), rt.new_int(52), rt.new_int(4))
	mut iife_temp_314 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_314 := iife_temp_314.load_4(iife_result_313)
	mut iife_temp_315 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_315 := iife_temp_315.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_314, rt.new_int(4))))
	mut var_s20 := iife_result_315
	mut iife_temp_316 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_316 := iife_temp_316.substr(var_s_mutated.clone(), rt.new_int(55), rt.new_int(3))
	mut iife_temp_317 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_317 := iife_temp_317.load_3(iife_result_316)
	mut iife_temp_318 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_318 := iife_temp_318.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_317, rt.new_int(1))))
	mut var_s21 := iife_result_318
	mut iife_temp_319 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_319 := iife_temp_319.substr(var_s_mutated.clone(), rt.new_int(57), rt.new_int(4))
	mut iife_temp_320 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_320 := iife_temp_320.load_4(iife_result_319)
	mut iife_temp_321 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_321 := iife_temp_321.fromint(rt.new_int(2097151 & rt.shift_right(iife_result_320, rt.new_int(6))))
	mut var_s22 := iife_result_321
	mut iife_temp_322 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_322 := iife_temp_322.substr(var_s_mutated.clone(), rt.new_int(60), rt.new_int(4))
	mut iife_temp_323 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_323 := iife_temp_323.load_4(iife_result_322)
	mut iife_temp_324 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_324 := iife_temp_324.fromint(rt.new_int(536870911 & rt.shift_right(iife_result_323, rt.new_int(3))))
	mut var_s23 := iife_result_324
	var_s11 = rt.call_method(var_s11, 'addInt64', [rt.call_method(var_s23, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s12 = rt.call_method(var_s12, 'addInt64', [rt.call_method(var_s23, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s13 = rt.call_method(var_s13, 'addInt64', [rt.call_method(var_s23, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s14 = rt.call_method(var_s14, 'subInt64', [rt.call_method(var_s23, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s15 = rt.call_method(var_s15, 'addInt64', [rt.call_method(var_s23, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s16 = rt.call_method(var_s16, 'subInt64', [rt.call_method(var_s23, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s10 = rt.call_method(var_s10, 'addInt64', [rt.call_method(var_s22, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s11 = rt.call_method(var_s11, 'addInt64', [rt.call_method(var_s22, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s12 = rt.call_method(var_s12, 'addInt64', [rt.call_method(var_s22, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s13 = rt.call_method(var_s13, 'subInt64', [rt.call_method(var_s22, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s14 = rt.call_method(var_s14, 'addInt64', [rt.call_method(var_s22, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s15 = rt.call_method(var_s15, 'subInt64', [rt.call_method(var_s22, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s9 = rt.call_method(var_s9, 'addInt64', [rt.call_method(var_s21, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s10 = rt.call_method(var_s10, 'addInt64', [rt.call_method(var_s21, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s11 = rt.call_method(var_s11, 'addInt64', [rt.call_method(var_s21, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s12 = rt.call_method(var_s12, 'subInt64', [rt.call_method(var_s21, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s13 = rt.call_method(var_s13, 'addInt64', [rt.call_method(var_s21, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s14 = rt.call_method(var_s14, 'subInt64', [rt.call_method(var_s21, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s8 = rt.call_method(var_s8, 'addInt64', [rt.call_method(var_s20, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s9 = rt.call_method(var_s9, 'addInt64', [rt.call_method(var_s20, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s10 = rt.call_method(var_s10, 'addInt64', [rt.call_method(var_s20, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s11 = rt.call_method(var_s11, 'subInt64', [rt.call_method(var_s20, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s12 = rt.call_method(var_s12, 'addInt64', [rt.call_method(var_s20, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s13 = rt.call_method(var_s13, 'subInt64', [rt.call_method(var_s20, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s7 = rt.call_method(var_s7, 'addInt64', [rt.call_method(var_s19, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s8 = rt.call_method(var_s8, 'addInt64', [rt.call_method(var_s19, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s9 = rt.call_method(var_s9, 'addInt64', [rt.call_method(var_s19, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s10 = rt.call_method(var_s10, 'subInt64', [rt.call_method(var_s19, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s11 = rt.call_method(var_s11, 'addInt64', [rt.call_method(var_s19, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s12 = rt.call_method(var_s12, 'subInt64', [rt.call_method(var_s19, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s6 = rt.call_method(var_s6, 'addInt64', [rt.call_method(var_s18, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s7 = rt.call_method(var_s7, 'addInt64', [rt.call_method(var_s18, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s8 = rt.call_method(var_s8, 'addInt64', [rt.call_method(var_s18, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s9 = rt.call_method(var_s9, 'subInt64', [rt.call_method(var_s18, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s10 = rt.call_method(var_s10, 'addInt64', [rt.call_method(var_s18, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s11 = rt.call_method(var_s11, 'subInt64', [rt.call_method(var_s18, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	mut var_carry6 := rt.call_method(rt.call_method(var_s6, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s7 = rt.call_method(var_s7, 'addInt64', [var_carry6.clone()])
	var_s6 = rt.call_method(var_s6, 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry8 := rt.call_method(rt.call_method(var_s8, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s9 = rt.call_method(var_s9, 'addInt64', [var_carry8.clone()])
	var_s8 = rt.call_method(var_s8, 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry10 := rt.call_method(rt.call_method(var_s10, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s11 = rt.call_method(var_s11, 'addInt64', [var_carry10.clone()])
	var_s10 = rt.call_method(var_s10, 'subInt64', [rt.call_method(var_carry10, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry12 := rt.call_method(rt.call_method(var_s12, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s13 = rt.call_method(var_s13, 'addInt64', [var_carry12.clone()])
	var_s12 = rt.call_method(var_s12, 'subInt64', [rt.call_method(var_carry12, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry14 := rt.call_method(rt.call_method(var_s14, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s15 = rt.call_method(var_s15, 'addInt64', [var_carry14.clone()])
	var_s14 = rt.call_method(var_s14, 'subInt64', [rt.call_method(var_carry14, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry16 := rt.call_method(rt.call_method(var_s16, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s17 = rt.call_method(var_s17, 'addInt64', [var_carry16.clone()])
	var_s16 = rt.call_method(var_s16, 'subInt64', [rt.call_method(var_carry16, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry7 := rt.call_method(rt.call_method(var_s7, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s8 = rt.call_method(var_s8, 'addInt64', [var_carry7.clone()])
	var_s7 = rt.call_method(var_s7, 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry9 := rt.call_method(rt.call_method(var_s9, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s10 = rt.call_method(var_s10, 'addInt64', [var_carry9.clone()])
	var_s9 = rt.call_method(var_s9, 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry11 := rt.call_method(rt.call_method(var_s11, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s12 = rt.call_method(var_s12, 'addInt64', [var_carry11.clone()])
	var_s11 = rt.call_method(var_s11, 'subInt64', [rt.call_method(var_carry11, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry13 := rt.call_method(rt.call_method(var_s13, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s14 = rt.call_method(var_s14, 'addInt64', [var_carry13.clone()])
	var_s13 = rt.call_method(var_s13, 'subInt64', [rt.call_method(var_carry13, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry15 := rt.call_method(rt.call_method(var_s15, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s16 = rt.call_method(var_s16, 'addInt64', [var_carry15.clone()])
	var_s15 = rt.call_method(var_s15, 'subInt64', [rt.call_method(var_carry15, 'shiftLeft', [rt.new_int(21)])])
	var_s5 = rt.call_method(var_s5, 'addInt64', [rt.call_method(var_s17, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s6 = rt.call_method(var_s6, 'addInt64', [rt.call_method(var_s17, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s7 = rt.call_method(var_s7, 'addInt64', [rt.call_method(var_s17, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s8 = rt.call_method(var_s8, 'subInt64', [rt.call_method(var_s17, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s9 = rt.call_method(var_s9, 'addInt64', [rt.call_method(var_s17, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s10 = rt.call_method(var_s10, 'subInt64', [rt.call_method(var_s17, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s4 = rt.call_method(var_s4, 'addInt64', [rt.call_method(var_s16, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s5 = rt.call_method(var_s5, 'addInt64', [rt.call_method(var_s16, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s6 = rt.call_method(var_s6, 'addInt64', [rt.call_method(var_s16, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s7 = rt.call_method(var_s7, 'subInt64', [rt.call_method(var_s16, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s8 = rt.call_method(var_s8, 'addInt64', [rt.call_method(var_s16, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s9 = rt.call_method(var_s9, 'subInt64', [rt.call_method(var_s16, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s3 = rt.call_method(var_s3, 'addInt64', [rt.call_method(var_s15, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s4 = rt.call_method(var_s4, 'addInt64', [rt.call_method(var_s15, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s5 = rt.call_method(var_s5, 'addInt64', [rt.call_method(var_s15, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s6 = rt.call_method(var_s6, 'subInt64', [rt.call_method(var_s15, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s7 = rt.call_method(var_s7, 'addInt64', [rt.call_method(var_s15, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s8 = rt.call_method(var_s8, 'subInt64', [rt.call_method(var_s15, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s2 = rt.call_method(var_s2, 'addInt64', [rt.call_method(var_s14, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s3 = rt.call_method(var_s3, 'addInt64', [rt.call_method(var_s14, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s4 = rt.call_method(var_s4, 'addInt64', [rt.call_method(var_s14, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_s14, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s6 = rt.call_method(var_s6, 'addInt64', [rt.call_method(var_s14, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s7 = rt.call_method(var_s7, 'subInt64', [rt.call_method(var_s14, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s1 = rt.call_method(var_s1, 'addInt64', [rt.call_method(var_s13, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s2 = rt.call_method(var_s2, 'addInt64', [rt.call_method(var_s13, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s3 = rt.call_method(var_s3, 'addInt64', [rt.call_method(var_s13, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s4 = rt.call_method(var_s4, 'subInt64', [rt.call_method(var_s13, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s5 = rt.call_method(var_s5, 'addInt64', [rt.call_method(var_s13, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s6 = rt.call_method(var_s6, 'subInt64', [rt.call_method(var_s13, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s0 = rt.call_method(var_s0, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s1 = rt.call_method(var_s1, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s2 = rt.call_method(var_s2, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s3 = rt.call_method(var_s3, 'subInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s4 = rt.call_method(var_s4, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s12 = create_paragonie_sodium_core32_int64()
	mut var_carry0 := rt.call_method(rt.call_method(var_s0, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s1 = rt.call_method(var_s1, 'addInt64', [var_carry0.clone()])
	var_s0 = rt.call_method(var_s0, 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry2 := rt.call_method(rt.call_method(var_s2, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s3 = rt.call_method(var_s3, 'addInt64', [var_carry2.clone()])
	var_s2 = rt.call_method(var_s2, 'subInt64', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry4 := rt.call_method(rt.call_method(var_s4, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s5 = rt.call_method(var_s5, 'addInt64', [var_carry4.clone()])
	var_s4 = rt.call_method(var_s4, 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(21)])])
	var_carry6 = rt.call_method(rt.call_method(var_s6, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s7 = rt.call_method(var_s7, 'addInt64', [var_carry6.clone()])
	var_s6 = rt.call_method(var_s6, 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(21)])])
	var_carry8 = rt.call_method(rt.call_method(var_s8, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s9 = rt.call_method(var_s9, 'addInt64', [var_carry8.clone()])
	var_s8 = rt.call_method(var_s8, 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(21)])])
	var_carry10 = rt.call_method(rt.call_method(var_s10, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s11 = rt.call_method(var_s11, 'addInt64', [var_carry10.clone()])
	var_s10 = rt.call_method(var_s10, 'subInt64', [rt.call_method(var_carry10, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry1 := rt.call_method(rt.call_method(var_s1, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s2 = rt.call_method(var_s2, 'addInt64', [var_carry1.clone()])
	var_s1 = rt.call_method(var_s1, 'subInt64', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry3 := rt.call_method(rt.call_method(var_s3, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s4 = rt.call_method(var_s4, 'addInt64', [var_carry3.clone()])
	var_s3 = rt.call_method(var_s3, 'subInt64', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(21)])])
	mut var_carry5 := rt.call_method(rt.call_method(var_s5, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s6 = rt.call_method(var_s6, 'addInt64', [var_carry5.clone()])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(21)])])
	var_carry7 = rt.call_method(rt.call_method(var_s7, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s8 = rt.call_method(var_s8, 'addInt64', [var_carry7.clone()])
	var_s7 = rt.call_method(var_s7, 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(21)])])
	var_carry9 = rt.call_method(rt.call_method(var_s9, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s10 = rt.call_method(var_s10, 'addInt64', [var_carry9.clone()])
	var_s9 = rt.call_method(var_s9, 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(21)])])
	var_carry11 = rt.call_method(rt.call_method(var_s11, 'addInt', [rt.new_int(1 << 20)]), 'shiftRight', [rt.new_int(21)])
	var_s12 = rt.call_method(var_s12, 'addInt64', [var_carry11.clone()])
	var_s11 = rt.call_method(var_s11, 'subInt64', [rt.call_method(var_carry11, 'shiftLeft', [rt.new_int(21)])])
	var_s0 = rt.call_method(var_s0, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s1 = rt.call_method(var_s1, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s2 = rt.call_method(var_s2, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s3 = rt.call_method(var_s3, 'subInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s4 = rt.call_method(var_s4, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_s12 = create_paragonie_sodium_core32_int64()
	var_carry0 = rt.call_method(var_s0, 'shiftRight', [rt.new_int(21)])
	var_s1 = rt.call_method(var_s1, 'addInt64', [var_carry0.clone()])
	var_s0 = rt.call_method(var_s0, 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(21)])])
	var_carry1 = rt.call_method(var_s1, 'shiftRight', [rt.new_int(21)])
	var_s2 = rt.call_method(var_s2, 'addInt64', [var_carry1.clone()])
	var_s1 = rt.call_method(var_s1, 'subInt64', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(21)])])
	var_carry2 = rt.call_method(var_s2, 'shiftRight', [rt.new_int(21)])
	var_s3 = rt.call_method(var_s3, 'addInt64', [var_carry2.clone()])
	var_s2 = rt.call_method(var_s2, 'subInt64', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(21)])])
	var_carry3 = rt.call_method(var_s3, 'shiftRight', [rt.new_int(21)])
	var_s4 = rt.call_method(var_s4, 'addInt64', [var_carry3.clone()])
	var_s3 = rt.call_method(var_s3, 'subInt64', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(21)])])
	var_carry4 = rt.call_method(var_s4, 'shiftRight', [rt.new_int(21)])
	var_s5 = rt.call_method(var_s5, 'addInt64', [var_carry4.clone()])
	var_s4 = rt.call_method(var_s4, 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(21)])])
	var_carry5 = rt.call_method(var_s5, 'shiftRight', [rt.new_int(21)])
	var_s6 = rt.call_method(var_s6, 'addInt64', [var_carry5.clone()])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(21)])])
	var_carry6 = rt.call_method(var_s6, 'shiftRight', [rt.new_int(21)])
	var_s7 = rt.call_method(var_s7, 'addInt64', [var_carry6.clone()])
	var_s6 = rt.call_method(var_s6, 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(21)])])
	var_carry7 = rt.call_method(var_s7, 'shiftRight', [rt.new_int(21)])
	var_s8 = rt.call_method(var_s8, 'addInt64', [var_carry7.clone()])
	var_s7 = rt.call_method(var_s7, 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(21)])])
	var_carry8 = rt.call_method(var_s8, 'shiftRight', [rt.new_int(21)])
	var_s9 = rt.call_method(var_s9, 'addInt64', [var_carry8.clone()])
	var_s8 = rt.call_method(var_s8, 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(21)])])
	var_carry9 = rt.call_method(var_s9, 'shiftRight', [rt.new_int(21)])
	var_s10 = rt.call_method(var_s10, 'addInt64', [var_carry9.clone()])
	var_s9 = rt.call_method(var_s9, 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(21)])])
	var_carry10 = rt.call_method(var_s10, 'shiftRight', [rt.new_int(21)])
	var_s11 = rt.call_method(var_s11, 'addInt64', [var_carry10.clone()])
	var_s10 = rt.call_method(var_s10, 'subInt64', [rt.call_method(var_carry10, 'shiftLeft', [rt.new_int(21)])])
	var_carry11 = rt.call_method(var_s11, 'shiftRight', [rt.new_int(21)])
	var_s12 = rt.call_method(var_s12, 'addInt64', [var_carry11.clone()])
	var_s11 = rt.call_method(var_s11, 'subInt64', [rt.call_method(var_carry11, 'shiftLeft', [rt.new_int(21)])])
	var_s0 = rt.call_method(var_s0, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(666643), rt.new_int(20)])])
	var_s1 = rt.call_method(var_s1, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(470296), rt.new_int(19)])])
	var_s2 = rt.call_method(var_s2, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(654183), rt.new_int(20)])])
	var_s3 = rt.call_method(var_s3, 'subInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(997805), rt.new_int(20)])])
	var_s4 = rt.call_method(var_s4, 'addInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(136657), rt.new_int(18)])])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_s12, 'mulInt', [rt.new_int(683901), rt.new_int(20)])])
	var_carry0 = rt.call_method(var_s0, 'shiftRight', [rt.new_int(21)])
	var_s1 = rt.call_method(var_s1, 'addInt64', [var_carry0.clone()])
	var_s0 = rt.call_method(var_s0, 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(21)])])
	var_carry1 = rt.call_method(var_s1, 'shiftRight', [rt.new_int(21)])
	var_s2 = rt.call_method(var_s2, 'addInt64', [var_carry1.clone()])
	var_s1 = rt.call_method(var_s1, 'subInt64', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(21)])])
	var_carry2 = rt.call_method(var_s2, 'shiftRight', [rt.new_int(21)])
	var_s3 = rt.call_method(var_s3, 'addInt64', [var_carry2.clone()])
	var_s2 = rt.call_method(var_s2, 'subInt64', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(21)])])
	var_carry3 = rt.call_method(var_s3, 'shiftRight', [rt.new_int(21)])
	var_s4 = rt.call_method(var_s4, 'addInt64', [var_carry3.clone()])
	var_s3 = rt.call_method(var_s3, 'subInt64', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(21)])])
	var_carry4 = rt.call_method(var_s4, 'shiftRight', [rt.new_int(21)])
	var_s5 = rt.call_method(var_s5, 'addInt64', [var_carry4.clone()])
	var_s4 = rt.call_method(var_s4, 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(21)])])
	var_carry5 = rt.call_method(var_s5, 'shiftRight', [rt.new_int(21)])
	var_s6 = rt.call_method(var_s6, 'addInt64', [var_carry5.clone()])
	var_s5 = rt.call_method(var_s5, 'subInt64', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(21)])])
	var_carry6 = rt.call_method(var_s6, 'shiftRight', [rt.new_int(21)])
	var_s7 = rt.call_method(var_s7, 'addInt64', [var_carry6.clone()])
	var_s6 = rt.call_method(var_s6, 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(21)])])
	var_carry7 = rt.call_method(var_s7, 'shiftRight', [rt.new_int(21)])
	var_s8 = rt.call_method(var_s8, 'addInt64', [var_carry7.clone()])
	var_s7 = rt.call_method(var_s7, 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(21)])])
	var_carry8 = rt.call_method(var_s8, 'shiftRight', [rt.new_int(21)])
	var_s9 = rt.call_method(var_s9, 'addInt64', [var_carry8.clone()])
	var_s8 = rt.call_method(var_s8, 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(21)])])
	var_carry9 = rt.call_method(var_s9, 'shiftRight', [rt.new_int(21)])
	var_s10 = rt.call_method(var_s10, 'addInt64', [var_carry9.clone()])
	var_s9 = rt.call_method(var_s9, 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(21)])])
	var_carry10 = rt.call_method(var_s10, 'shiftRight', [rt.new_int(21)])
	var_s11 = rt.call_method(var_s11, 'addInt64', [var_carry10.clone()])
	var_s10 = rt.call_method(var_s10, 'subInt64', [rt.call_method(var_carry10, 'shiftLeft', [rt.new_int(21)])])
	mut var_S0 := rt.call_method(rt.call_method(var_s0, 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_S1 := rt.call_method(rt.call_method(var_s1, 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_S2 := rt.call_method(rt.call_method(var_s2, 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_S3 := rt.call_method(rt.call_method(var_s3, 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_S4 := rt.call_method(rt.call_method(var_s4, 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_S5 := rt.call_method(rt.call_method(var_s5, 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_S6 := rt.call_method(rt.call_method(var_s6, 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_S7 := rt.call_method(rt.call_method(var_s7, 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_S8 := rt.call_method(rt.call_method(var_s8, 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_S9 := rt.call_method(rt.call_method(var_s9, 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_S10 := rt.call_method(rt.call_method(var_s10, 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_S11 := rt.call_method(rt.call_method(var_s11, 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_arr := rt.create_array([rt.ArrayItem{ key: none, val: rt.shift_right(var_S0, rt.new_int(0)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S0, rt.new_int(8)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S0, rt.new_int(16)) | rt.shift_left(var_S1, rt.new_int(5)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S1, rt.new_int(3)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S1, rt.new_int(11)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S1, rt.new_int(19)) | rt.shift_left(var_S2, rt.new_int(2)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S2, rt.new_int(6)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S2, rt.new_int(14)) | rt.shift_left(var_S3, rt.new_int(7)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S3, rt.new_int(1)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S3, rt.new_int(9)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S3, rt.new_int(17)) | rt.shift_left(var_S4, rt.new_int(4)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S4, rt.new_int(4)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S4, rt.new_int(12)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S4, rt.new_int(20)) | rt.shift_left(var_S5, rt.new_int(1)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S5, rt.new_int(7)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S5, rt.new_int(15)) | rt.shift_left(var_S6, rt.new_int(6)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S6, rt.new_int(2)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S6, rt.new_int(10)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S6, rt.new_int(18)) | rt.shift_left(var_S7, rt.new_int(3)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S7, rt.new_int(5)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S7, rt.new_int(13)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S8, rt.new_int(0)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S8, rt.new_int(8)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S8, rt.new_int(16)) | rt.shift_left(var_S9, rt.new_int(5)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S9, rt.new_int(3)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S9, rt.new_int(11)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S9, rt.new_int(19)) | rt.shift_left(var_S10, rt.new_int(2)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S10, rt.new_int(6)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S10, rt.new_int(14)) | rt.shift_left(var_S11, rt.new_int(7)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S11, rt.new_int(1)) }, rt.ArrayItem{ key: none, val: rt.shift_right(var_S11, rt.new_int(9)) }, rt.ArrayItem{ key: none, val: rt.new_int((var_S11).to_i64()) >> 17 }])
	mut iife_temp_325 := Class_ParagonIE_Sodium_Core32_Curve25519{}
	mut iife_result_325 := iife_temp_325.intarraytostring(var_arr.clone())
	return iife_result_325
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_mul_l(mut var_A Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3) rt.PhpVal {
	mut var_aslide := rt.create_array([rt.ArrayItem{ key: none, val: 13 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: -1 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: -11 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: -5 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: -3 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: -13 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 7 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 3 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: -13 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 5 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 11 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 11 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: -13 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: -3 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: -1 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 3 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: -11 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 15 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: -1 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: -1 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 7 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 5 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 1 }])
	mut var_Ai := rt.new_array()
	var_Ai.array_set(0, Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_to_cached(mut var_A))
	mut var_t := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_dbl(mut var_A)
	mut var_A2 := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_t))
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(8)))) { break }
		var_t = Class_ParagonIE_Sodium_Core32_Curve25519.ge_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](var_A2), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached](var_Ai.array_get(rt.sub(var_i, rt.new_int(1)))))
		mut var_u := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_t))
		var_Ai.array_set(var_i, Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_to_cached(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](var_u)))
		rt.pre_inc(var_i)
	}
	mut var_r := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_0()
	mut var_i := rt.new_int(252)
	for {
		if !(rt.is_true(rt.greater_equal(var_i, rt.new_int(0)))) { break }
		var_t = Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_dbl(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](var_r))
		if rt.is_true(rt.greater(var_aslide.array_get(var_i), rt.new_int(0))) {
		mut var_u := Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_t))
		var_t = Class_ParagonIE_Sodium_Core32_Curve25519.ge_add(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](var_u), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached](var_Ai.array_get(rt.new_int((rt.div(var_aslide.array_get(var_i), rt.new_int(2))).to_i64()))))
		} else if rt.is_true(rt.less(var_aslide.array_get(var_i), rt.new_int(0))) {
		var_u = Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_t))
		var_t = Class_ParagonIE_Sodium_Core32_Curve25519.ge_sub(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](var_u), mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached](var_Ai.array_get(rt.new_int((rt.div(rt.sub(rt.new_int(0), var_aslide.array_get(var_i)), rt.new_int(2))).to_i64()))))
		}
		rt.pre_dec(var_i)
	}
	return Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](var_t))
}

struct Class_ParagonIE_Sodium_Core32_Curve25519_H {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Curve25519_Fe {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int32 {
	rt.PhpObjectBase
}

struct Class_TypeError {
	rt.PhpObjectBase
}

struct Class_RangeException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int64 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_curve25519(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Curve25519 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_curve25519_h(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Curve25519_H {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519_H{
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

fn create_paragonie_sodium_core32_int32(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Int32 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Int32{
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

fn create_rangeexception(_args ...rt.PhpVal) &Class_RangeException {
	mut obj := &Class_RangeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_curve25519_ge_p1p1(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_curve25519_ge_p3(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_curve25519_ge_p2(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_curve25519_ge_cached(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_curve25519_ge_precomp(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_int64(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Int64 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Int64{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fe_0' {
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_0()
		}
		'fe_1' {
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_1()
		}
		'fe_add' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'fe_cmov' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_cmov(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'fe_copy' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_copy(mut dispatch_arg_0)
		}
		'fe_frombytes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_frombytes(dispatch_arg_0)
		}
		'fe_tobytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_tobytes(mut dispatch_arg_0)
		}
		'fe_isnegative' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(Class_ParagonIE_Sodium_Core32_Curve25519.fe_isnegative(mut dispatch_arg_0))
		}
		'fe_isnonzero' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(Class_ParagonIE_Sodium_Core32_Curve25519.fe_isnonzero(mut dispatch_arg_0))
		}
		'fe_mul' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'fe_neg' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_neg(mut dispatch_arg_0)
		}
		'fe_sq' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut dispatch_arg_0)
		}
		'fe_sq2' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq2(mut dispatch_arg_0)
		}
		'fe_invert' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_invert(mut dispatch_arg_0)
		}
		'fe_pow22523' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_pow22523(mut dispatch_arg_0)
		}
		'fe_sub' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Fe](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'ge_add' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_add(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'slide' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Curve25519.slide(dispatch_arg_0)
		}
		'ge_frombytes_negate_vartime' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_frombytes_negate_vartime(dispatch_arg_0)
		}
		'ge_madd' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_madd(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'ge_msub' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_msub(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'ge_p1p1_to_p2' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p2(mut dispatch_arg_0)
		}
		'ge_p1p1_to_p3' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut dispatch_arg_0)
		}
		'ge_p2_0' {
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_p2_0()
		}
		'ge_p2_dbl' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_p2_dbl(mut dispatch_arg_0)
		}
		'ge_p3_0' {
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_0()
		}
		'ge_p3_to_cached' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_to_cached(mut dispatch_arg_0)
		}
		'ge_p3_to_p2' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_to_p2(mut dispatch_arg_0)
		}
		'ge_p3_tobytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_tobytes(mut dispatch_arg_0)
		}
		'ge_p3_dbl' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_dbl(mut dispatch_arg_0)
		}
		'ge_precomp_0' {
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_precomp_0()
		}
		'equal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core32_Curve25519.equal(dispatch_arg_0, dispatch_arg_1))
		}
		'negative' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core32_Curve25519.negative(dispatch_arg_0))
		}
		'cmov' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Curve25519.cmov(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'ge_select' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_select(dispatch_arg_0, dispatch_arg_1)
		}
		'ge_sub' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_sub(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'ge_tobytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_tobytes(mut dispatch_arg_0)
		}
		'ge_double_scalarmult_vartime' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_double_scalarmult_vartime(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'ge_scalarmult_base' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_scalarmult_base(dispatch_arg_0)
		}
		'sc_muladd' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Curve25519.sc_muladd(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'sc_reduce' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Curve25519.sc_reduce(dispatch_arg_0)
		}
		'ge_mul_l' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core32_Curve25519.ge_mul_l(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_H) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519_H) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_H) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_ParagonIE_Sodium_Core32_Int32) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Int32) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int32) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_RangeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RangeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RangeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_Int64) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Int64) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int64) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core32_Curve25519'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
