import rt

struct Class_ParagonIE_Sodium_Core32_Curve25519 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_0() rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}; return temp.fromarray(arg_0) }(rt.create_array([rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }]))
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_1() rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}; return temp.fromarray(arg_0) }(rt.create_array([rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(1)) }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }, rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32() }]))
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_add(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	mut var_arr := rt.new_array()
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
			var_arr.array_set(var_i, rt.call_method(var_f_mutated.array_get(var_i), 'addInt32', [var_g.array_get(var_i)]))
			rt.pre_inc(var_i)
		}
	}
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}; return temp.fromarray(arg_0) }(var_arr.dup())
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_cmov(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core32_Curve25519_Fe, b i64) rt.PhpVal {
	mut var_f_mutated := var_f
	mut b_mutated := b
	mut var_h := rt.new_array()
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_f_mutated.array_get(var_i), 'ParagonIE_Sodium_Core32_Int32')))))) {
				rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Expected Int32'))))
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_g.array_get(var_i), 'ParagonIE_Sodium_Core32_Int32')))))) {
				rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Expected Int32'))))
			}
			var_h.array_set(var_i, rt.call_method(var_f_mutated.array_get(var_i), 'xorInt32', [rt.call_method(rt.call_method(var_f_mutated.array_get(var_i), 'xorInt32', [var_g.array_get(var_i)]), 'mask', [rt.new_int(b_mutated).dup()])]))
			rt.pre_inc(var_i)
		}
	}
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}; return temp.fromarray(arg_0) }(var_h.dup())
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_copy(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
	mut var_h := // unsupported expression: Expr_Clone
	return var_h.dup()
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_frombytes(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(rt.new_string('Expected a 32-byte string.'))))
	}
	mut var_h0 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.load_4(arg_0) }(var_s_mutated.dup()))
	mut var_h1 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(4), rt.new_int(3))), rt.new_int(6))))
	mut var_h2 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(7), rt.new_int(3))), rt.new_int(5))))
	mut var_h3 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(10), rt.new_int(3))), rt.new_int(3))))
	mut var_h4 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(13), rt.new_int(3))), rt.new_int(2))))
	mut var_h5 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.load_4(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(16), rt.new_int(4))))
	mut var_h6 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(20), rt.new_int(3))), rt.new_int(7))))
	mut var_h7 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(23), rt.new_int(3))), rt.new_int(5))))
	mut var_h8 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(26), rt.new_int(3))), rt.new_int(4))))
	mut var_h9 := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(rt.new_int(rt.bitwise_and(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.load_3(arg_0) }(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519{}; return temp.substr(arg_0, arg_1, arg_2) }(var_s_mutated.dup(), rt.new_int(29), rt.new_int(3))), rt.new_int(8388607)) << 2))
	mut var_carry9 := rt.call_method(rt.call_method(var_h9, 'addInt', [1 << 24]), 'shiftRight', [rt.new_int(25)])
	var_h0 = rt.call_method(var_h0, 'addInt32', [rt.call_method(var_carry9, 'mulInt', [rt.new_int(19), rt.new_int(5)])])
	var_h9 = rt.call_method(var_h9, 'subInt32', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry1 := rt.call_method(rt.call_method(var_h1, 'addInt', [1 << 24]), 'shiftRight', [rt.new_int(25)])
	var_h2 = rt.call_method(var_h2, 'addInt32', [var_carry1.dup()])
	var_h1 = rt.call_method(var_h1, 'subInt32', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry3 := rt.call_method(rt.call_method(var_h3, 'addInt', [1 << 24]), 'shiftRight', [rt.new_int(25)])
	var_h4 = rt.call_method(var_h4, 'addInt32', [var_carry3.dup()])
	var_h3 = rt.call_method(var_h3, 'subInt32', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry5 := rt.call_method(rt.call_method(var_h5, 'addInt', [1 << 24]), 'shiftRight', [rt.new_int(25)])
	var_h6 = rt.call_method(var_h6, 'addInt32', [var_carry5.dup()])
	var_h5 = rt.call_method(var_h5, 'subInt32', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry7 := rt.call_method(rt.call_method(var_h7, 'addInt', [1 << 24]), 'shiftRight', [rt.new_int(25)])
	var_h8 = rt.call_method(var_h8, 'addInt32', [var_carry7.dup()])
	var_h7 = rt.call_method(var_h7, 'subInt32', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(25)])])
	mut var_carry0 := rt.call_method(rt.call_method(var_h0, 'addInt', [1 << 25]), 'shiftRight', [rt.new_int(26)])
	var_h1 = rt.call_method(var_h1, 'addInt32', [var_carry0.dup()])
	var_h0 = rt.call_method(var_h0, 'subInt32', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry2 := rt.call_method(rt.call_method(var_h2, 'addInt', [1 << 25]), 'shiftRight', [rt.new_int(26)])
	var_h3 = rt.call_method(var_h3, 'addInt32', [var_carry2.dup()])
	var_h2 = rt.call_method(var_h2, 'subInt32', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry4 := rt.call_method(rt.call_method(var_h4, 'addInt', [1 << 25]), 'shiftRight', [rt.new_int(26)])
	var_h5 = rt.call_method(var_h5, 'addInt32', [var_carry4.dup()])
	var_h4 = rt.call_method(var_h4, 'subInt32', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry6 := rt.call_method(rt.call_method(var_h6, 'addInt', [1 << 25]), 'shiftRight', [rt.new_int(26)])
	var_h7 = rt.call_method(var_h7, 'addInt32', [var_carry6.dup()])
	var_h6 = rt.call_method(var_h6, 'subInt32', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(26)])])
	mut var_carry8 := rt.call_method(rt.call_method(var_h8, 'addInt', [1 << 25]), 'shiftRight', [rt.new_int(26)])
	var_h9 = rt.call_method(var_h9, 'addInt32', [var_carry8.dup()])
	var_h8 = rt.call_method(var_h8, 'subInt32', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(26)])])
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Curve25519_Fe{}; return temp.fromarray(arg_0) }(rt.create_array([rt.ArrayItem{ key: none, val: var_h0 }, rt.ArrayItem{ key: none, val: var_h1 }, rt.ArrayItem{ key: none, val: var_h2 }, rt.ArrayItem{ key: none, val: var_h3 }, rt.ArrayItem{ key: none, val: var_h4 }, rt.ArrayItem{ key: none, val: var_h5 }, rt.ArrayItem{ key: none, val: var_h6 }, rt.ArrayItem{ key: none, val: var_h7 }, rt.ArrayItem{ key: none, val: var_h8 }, rt.ArrayItem{ key: none, val: var_h9 }]))
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_tobytes(mut var_h Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_h_mutated := var_h
	mut var_f := rt.new_array()
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
			var_f.array_set(var_i, rt.call_method(var_h_mutated.array_get(var_i), 'toInt64', []rt.PhpVal{}))
			rt.pre_inc(var_i)
		}
	}
	mut var_q := rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_f.array_get(9), 'mulInt', [rt.new_int(19), rt.new_int(5)]), 'addInt', [1 << 14]), 'shiftRight', [rt.new_int(25)]), 'addInt64', [var_f.array_get(0)]), 'shiftRight', [rt.new_int(26)]), 'addInt64', [var_f.array_get(1)]), 'shiftRight', [rt.new_int(25)]), 'addInt64', [var_f.array_get(2)]), 'shiftRight', [rt.new_int(26)]), 'addInt64', [var_f.array_get(3)]), 'shiftRight', [rt.new_int(25)]), 'addInt64', [var_f.array_get(4)]), 'shiftRight', [rt.new_int(26)]), 'addInt64', [var_f.array_get(5)]), 'shiftRight', [rt.new_int(25)]), 'addInt64', [var_f.array_get(6)]), 'shiftRight', [rt.new_int(26)]), 'addInt64', [var_f.array_get(7)]), 'shiftRight', [rt.new_int(25)]), 'addInt64', [var_f.array_get(8)]), 'shiftRight', [rt.new_int(26)]), 'addInt64', [var_f.array_get(9)]), 'shiftRight', [rt.new_int(25)])
	var_f.array_set(0, rt.call_method(var_f.array_get(0), 'addInt64', [rt.call_method(var_q, 'mulInt', [rt.new_int(19), rt.new_int(5)])]))
	mut var_carry0 := rt.call_method(var_f.array_get(0), 'shiftRight', [rt.new_int(26)])
	var_f.array_set(1, rt.call_method(var_f.array_get(1), 'addInt64', [var_carry0.dup()]))
	var_f.array_set(0, rt.call_method(var_f.array_get(0), 'subInt64', [rt.call_method(var_carry0, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry1 := rt.call_method(var_f.array_get(1), 'shiftRight', [rt.new_int(25)])
	var_f.array_set(2, rt.call_method(var_f.array_get(2), 'addInt64', [var_carry1.dup()]))
	var_f.array_set(1, rt.call_method(var_f.array_get(1), 'subInt64', [rt.call_method(var_carry1, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry2 := rt.call_method(var_f.array_get(2), 'shiftRight', [rt.new_int(26)])
	var_f.array_set(3, rt.call_method(var_f.array_get(3), 'addInt64', [var_carry2.dup()]))
	var_f.array_set(2, rt.call_method(var_f.array_get(2), 'subInt64', [rt.call_method(var_carry2, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry3 := rt.call_method(var_f.array_get(3), 'shiftRight', [rt.new_int(25)])
	var_f.array_set(4, rt.call_method(var_f.array_get(4), 'addInt64', [var_carry3.dup()]))
	var_f.array_set(3, rt.call_method(var_f.array_get(3), 'subInt64', [rt.call_method(var_carry3, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry4 := rt.call_method(var_f.array_get(4), 'shiftRight', [rt.new_int(26)])
	var_f.array_set(5, rt.call_method(var_f.array_get(5), 'addInt64', [var_carry4.dup()]))
	var_f.array_set(4, rt.call_method(var_f.array_get(4), 'subInt64', [rt.call_method(var_carry4, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry5 := rt.call_method(var_f.array_get(5), 'shiftRight', [rt.new_int(25)])
	var_f.array_set(6, rt.call_method(var_f.array_get(6), 'addInt64', [var_carry5.dup()]))
	var_f.array_set(5, rt.call_method(var_f.array_get(5), 'subInt64', [rt.call_method(var_carry5, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry6 := rt.call_method(var_f.array_get(6), 'shiftRight', [rt.new_int(26)])
	var_f.array_set(7, rt.call_method(var_f.array_get(7), 'addInt64', [var_carry6.dup()]))
	var_f.array_set(6, rt.call_method(var_f.array_get(6), 'subInt64', [rt.call_method(var_carry6, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry7 := rt.call_method(var_f.array_get(7), 'shiftRight', [rt.new_int(25)])
	var_f.array_set(8, rt.call_method(var_f.array_get(8), 'addInt64', [var_carry7.dup()]))
	var_f.array_set(7, rt.call_method(var_f.array_get(7), 'subInt64', [rt.call_method(var_carry7, 'shiftLeft', [rt.new_int(25)])]))
	mut var_carry8 := rt.call_method(var_f.array_get(8), 'shiftRight', [rt.new_int(26)])
	var_f.array_set(9, rt.call_method(var_f.array_get(9), 'addInt64', [var_carry8.dup()]))
	var_f.array_set(8, rt.call_method(var_f.array_get(8), 'subInt64', [rt.call_method(var_carry8, 'shiftLeft', [rt.new_int(26)])]))
	mut var_carry9 := rt.call_method(var_f.array_get(9), 'shiftRight', [rt.new_int(25)])
	var_f.array_set(9, rt.call_method(var_f.array_get(9), 'subInt64', [rt.call_method(var_carry9, 'shiftLeft', [rt.new_int(25)])]))
	mut var_h0 := rt.call_method(rt.call_method(var_f.array_get(0), 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_h1 := rt.call_method(rt.call_method(var_f.array_get(1), 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_h2 := rt.call_method(rt.call_method(var_f.array_get(2), 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_h3 := rt.call_method(rt.call_method(.array_get(), 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_h4 := rt.call_method(rt.call_method(, 'toInt32', []rt.PhpVal{}), 'toInt', []rt.PhpVal{})
	mut var_h5 := rt.call_method(, 'toInt', []rt.PhpVal{})
	mut var_h6 := 
	
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_isnegative(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_isnonzero(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe) bool {
	mut var_f_mutated := var_f
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_mul(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_neg(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_sq2(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_invert(mut var_Z Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_pow22523(mut var_z Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_z_mutated := var_z
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.fe_sub(mut var_f Class_ParagonIE_Sodium_Core32_Curve25519_Fe, mut var_g Class_ParagonIE_Sodium_Core32_Curve25519_Fe) rt.PhpVal {
	mut var_f_mutated := var_f
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_add(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3, mut var_q Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached) rt.PhpVal {
	mut var_q_mutated := var_q
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.slide(var_a rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_frombytes_negate_vartime(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_madd(mut var_R Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1, mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3, mut var_q Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp) rt.PhpVal {
	mut var_q_mutated := var_q
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_msub(mut var_R Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1, mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3, mut var_q Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp) rt.PhpVal {
	mut var_q_mutated := var_q
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p2(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p1p1_to_p3(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P1p1) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p2_0() rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p2_dbl(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_0() rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_to_cached(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_to_p2(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_tobytes(mut var_h Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3) rt.PhpVal {
	mut var_h_mutated := var_h
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_p3_dbl(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_precomp_0() rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.equal(var_b rt.PhpVal, var_c rt.PhpVal) i64 {
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.negative(var_char rt.PhpVal) i64 {
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.cmov(mut var_t Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp, mut var_u Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Precomp, var_b rt.PhpVal) rt.PhpVal {
	mut var_t_mutated := var_t
	mut var_u_mutated := var_u
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_select(pos i64, b i64) rt.PhpVal {
	mut b_mutated := b
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_sub(mut var_p Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3, mut var_q Class_ParagonIE_Sodium_Core32_Curve25519_Ge_Cached) rt.PhpVal {
	mut var_q_mutated := var_q
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_tobytes(mut var_h Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P2) rt.PhpVal {
	mut var_h_mutated := var_h
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_double_scalarmult_vartime(mut var_a Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3, mut var_A Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3, var_b rt.PhpVal) rt.PhpVal {
	mut var_Bi := rt.new_null()
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_scalarmult_base(var_a rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.sc_muladd(var_a rt.PhpVal, var_b rt.PhpVal, var_c rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.sc_reduce(var_s rt.PhpVal) rt.PhpVal {
	mut var_s_mutated := var_s
}

fn Class_ParagonIE_Sodium_Core32_Curve25519.ge_mul_l(mut var_A Class_ParagonIE_Sodium_Core32_Curve25519_Ge_P3) rt.PhpVal {
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

fn create_paragonie_sodium_core32_curve25519() &Class_ParagonIE_Sodium_Core32_Curve25519 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_curve25519_h() &Class_ParagonIE_Sodium_Core32_Curve25519_H {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519_H{
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

fn create_paragonie_sodium_core32_int32() &Class_ParagonIE_Sodium_Core32_Int32 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Int32{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_typeerror() &Class_TypeError {
	mut obj := &Class_TypeError{
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
			return Class_ParagonIE_Sodium_Core32_Curve25519.fe_isnegative(mut dispatch_arg_0)
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




pub fn init_wp_includes_sodium_compat_src_core32_curve25519_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core32_Curve25519'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
