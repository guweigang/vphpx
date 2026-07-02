import rt

struct Class_ParagonIE_Sodium_Core32_ChaCha20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_ChaCha20.quarterround(mut var_a Class_ParagonIE_Sodium_Core32_Int32, mut var_b Class_ParagonIE_Sodium_Core32_Int32, mut var_c Class_ParagonIE_Sodium_Core32_Int32, mut var_d Class_ParagonIE_Sodium_Core32_Int32) rt.PhpVal {
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
	mut var_c_mutated := var_c
	mut var_d_mutated := var_d
	var_a_mutated = rt.call_method(var_a_mutated, 'addInt32', [var_b_mutated])
	var_d_mutated = rt.call_method(rt.call_method(var_d_mutated, 'xorInt32', [
		var_a_mutated,
	]), 'rotateLeft', [rt.new_int(16)])
	var_c_mutated = rt.call_method(var_c_mutated, 'addInt32', [var_d_mutated])
	var_b_mutated = rt.call_method(rt.call_method(var_b_mutated, 'xorInt32', [
		var_c_mutated,
	]), 'rotateLeft', [rt.new_int(12)])
	var_a_mutated = rt.call_method(var_a_mutated, 'addInt32', [var_b_mutated])
	var_d_mutated = rt.call_method(rt.call_method(var_d_mutated, 'xorInt32', [
		var_a_mutated,
	]), 'rotateLeft', [rt.new_int(8)])
	var_c_mutated = rt.call_method(var_c_mutated, 'addInt32', [var_d_mutated])
	var_b_mutated = rt.call_method(rt.call_method(var_b_mutated, 'xorInt32', [
		var_c_mutated,
	]), 'rotateLeft', [rt.new_int(7)])
	return rt.create_array([rt.ArrayItem{ key: none, val: var_a_mutated },
		rt.ArrayItem{ key: none, val: var_b_mutated }, rt.ArrayItem{ key: none, val: var_c_mutated },
		rt.ArrayItem{ key: none, val: var_d_mutated }])
}

fn Class_ParagonIE_Sodium_Core32_ChaCha20.encryptbytes(mut var_ctx Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx, message string) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
	mut message_mutated := message
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
	mut iife_result_0 := iife_temp_0.strlen(rt.new_string(message_mutated))
	mut var_bytes := iife_result_0
	mut var_j0 := var_ctx_mutated.array_get(rt.new_int(0))
	mut var_j1 := var_ctx_mutated.array_get(rt.new_int(1))
	mut var_j2 := var_ctx_mutated.array_get(rt.new_int(2))
	mut var_j3 := var_ctx_mutated.array_get(rt.new_int(3))
	mut var_j4 := var_ctx_mutated.array_get(rt.new_int(4))
	mut var_j5 := var_ctx_mutated.array_get(rt.new_int(5))
	mut var_j6 := var_ctx_mutated.array_get(rt.new_int(6))
	mut var_j7 := var_ctx_mutated.array_get(rt.new_int(7))
	mut var_j8 := var_ctx_mutated.array_get(rt.new_int(8))
	mut var_j9 := var_ctx_mutated.array_get(rt.new_int(9))
	mut var_j10 := var_ctx_mutated.array_get(rt.new_int(10))
	mut var_j11 := var_ctx_mutated.array_get(rt.new_int(11))
	mut var_j12 := var_ctx_mutated.array_get(rt.new_int(12))
	mut var_j13 := var_ctx_mutated.array_get(rt.new_int(13))
	mut var_j14 := var_ctx_mutated.array_get(rt.new_int(14))
	mut var_j15 := var_ctx_mutated.array_get(rt.new_int(15))
	mut var_c := rt.new_string('')
	for {
		if rt.is_true(rt.less(var_bytes, rt.new_int(64))) {
			message_mutated = message_mutated +(rt.call_function('str_repeat', [rt.new_string(''), rt.sub(rt.new_int(64), var_bytes)])).str()
		}
		mut var_x0 := var_j0.dup()
		mut var_x1 := var_j1.dup()
		mut var_x2 := var_j2.dup()
		mut var_x3 := var_j3.dup()
		mut var_x4 := var_j4.dup()
		mut var_x5 := var_j5.dup()
		mut var_x6 := var_j6.dup()
		mut var_x7 := var_j7.dup()
		mut var_x8 := var_j8.dup()
		mut var_x9 := var_j9.dup()
		mut var_x10 := var_j10.dup()
		mut var_x11 := var_j11.dup()
		mut var_x12 := var_j12.dup()
		mut var_x13 := var_j13.dup()
		mut var_x14 := var_j14.dup()
		mut var_x15 := var_j15.dup()
		mut var_i := rt.new_int(20)
		for {
			if !(rt.is_true(rt.greater(var_i, rt.new_int(0)))) { break
			 }
			mut list_tmp_1 := Class_ParagonIE_Sodium_Core32_ChaCha20.quarterround(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x0), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x4), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x8), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x12))
			var_x0 = list_tmp_1.array_get(0)
			var_x4 = list_tmp_1.array_get(1)
			var_x8 = list_tmp_1.array_get(2)
			var_x12 = list_tmp_1.array_get(3)
			mut list_tmp_2 := Class_ParagonIE_Sodium_Core32_ChaCha20.quarterround(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x1), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x5), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x9), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x13))
			var_x1 = list_tmp_2.array_get(0)
			var_x5 = list_tmp_2.array_get(1)
			var_x9 = list_tmp_2.array_get(2)
			var_x13 = list_tmp_2.array_get(3)
			mut list_tmp_3 := Class_ParagonIE_Sodium_Core32_ChaCha20.quarterround(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x2), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x6), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x10), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x14))
			var_x2 = list_tmp_3.array_get(0)
			var_x6 = list_tmp_3.array_get(1)
			var_x10 = list_tmp_3.array_get(2)
			var_x14 = list_tmp_3.array_get(3)
			mut list_tmp_4 := Class_ParagonIE_Sodium_Core32_ChaCha20.quarterround(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x3), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x7), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x11), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x15))
			var_x3 = list_tmp_4.array_get(0)
			var_x7 = list_tmp_4.array_get(1)
			var_x11 = list_tmp_4.array_get(2)
			var_x15 = list_tmp_4.array_get(3)
			mut list_tmp_5 := Class_ParagonIE_Sodium_Core32_ChaCha20.quarterround(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x0), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x5), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x10), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x15))
			var_x0 = list_tmp_5.array_get(0)
			var_x5 = list_tmp_5.array_get(1)
			var_x10 = list_tmp_5.array_get(2)
			var_x15 = list_tmp_5.array_get(3)
			mut list_tmp_6 := Class_ParagonIE_Sodium_Core32_ChaCha20.quarterround(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x1), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x6), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x11), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x12))
			var_x1 = list_tmp_6.array_get(0)
			var_x6 = list_tmp_6.array_get(1)
			var_x11 = list_tmp_6.array_get(2)
			var_x12 = list_tmp_6.array_get(3)
			mut list_tmp_7 := Class_ParagonIE_Sodium_Core32_ChaCha20.quarterround(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x2), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x7), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x8), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x13))
			var_x2 = list_tmp_7.array_get(0)
			var_x7 = list_tmp_7.array_get(1)
			var_x8 = list_tmp_7.array_get(2)
			var_x13 = list_tmp_7.array_get(3)
			mut list_tmp_8 := Class_ParagonIE_Sodium_Core32_ChaCha20.quarterround(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x3), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x4), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x9), mut
				rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](var_x14))
			var_x3 = list_tmp_8.array_get(0)
			var_x4 = list_tmp_8.array_get(1)
			var_x9 = list_tmp_8.array_get(2)
			var_x14 = list_tmp_8.array_get(3)
			var_i = rt.sub(var_i, rt.new_int(2))
		}
		var_x0 = rt.call_method(var_x0, 'addInt32', [var_j0.clone()])
		var_x1 = rt.call_method(var_x1, 'addInt32', [var_j1.clone()])
		var_x2 = rt.call_method(var_x2, 'addInt32', [var_j2.clone()])
		var_x3 = rt.call_method(var_x3, 'addInt32', [var_j3.clone()])
		var_x4 = rt.call_method(var_x4, 'addInt32', [var_j4.clone()])
		var_x5 = rt.call_method(var_x5, 'addInt32', [var_j5.clone()])
		var_x6 = rt.call_method(var_x6, 'addInt32', [var_j6.clone()])
		var_x7 = rt.call_method(var_x7, 'addInt32', [var_j7.clone()])
		var_x8 = rt.call_method(var_x8, 'addInt32', [var_j8.clone()])
		var_x9 = rt.call_method(var_x9, 'addInt32', [var_j9.clone()])
		var_x10 = rt.call_method(var_x10, 'addInt32', [var_j10.clone()])
		var_x11 = rt.call_method(var_x11, 'addInt32', [var_j11.clone()])
		var_x12 = rt.call_method(var_x12, 'addInt32', [var_j12.clone()])
		var_x13 = rt.call_method(var_x13, 'addInt32', [var_j13.clone()])
		var_x14 = rt.call_method(var_x14, 'addInt32', [var_j14.clone()])
		var_x15 = rt.call_method(var_x15, 'addInt32', [var_j15.clone()])
		mut iife_temp_1 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_1 := iife_temp_1.substr(rt.new_string(message_mutated), rt.new_int(0),
			rt.new_int(4))
		mut iife_temp_2 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_2 := iife_temp_2.fromreversestring(iife_result_1)
		var_x0 = rt.call_method(var_x0, 'xorInt32', [iife_result_2])
		mut iife_temp_3 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_3 := iife_temp_3.substr(rt.new_string(message_mutated), rt.new_int(4),
			rt.new_int(4))
		mut iife_temp_4 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_4 := iife_temp_4.fromreversestring(iife_result_3)
		var_x1 = rt.call_method(var_x1, 'xorInt32', [iife_result_4])
		mut iife_temp_5 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_5 := iife_temp_5.substr(rt.new_string(message_mutated), rt.new_int(8),
			rt.new_int(4))
		mut iife_temp_6 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_6 := iife_temp_6.fromreversestring(iife_result_5)
		var_x2 = rt.call_method(var_x2, 'xorInt32', [iife_result_6])
		mut iife_temp_7 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_7 := iife_temp_7.substr(rt.new_string(message_mutated), rt.new_int(12),
			rt.new_int(4))
		mut iife_temp_8 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_8 := iife_temp_8.fromreversestring(iife_result_7)
		var_x3 = rt.call_method(var_x3, 'xorInt32', [iife_result_8])
		mut iife_temp_9 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_9 := iife_temp_9.substr(rt.new_string(message_mutated), rt.new_int(16),
			rt.new_int(4))
		mut iife_temp_10 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_10 := iife_temp_10.fromreversestring(iife_result_9)
		var_x4 = rt.call_method(var_x4, 'xorInt32', [iife_result_10])
		mut iife_temp_11 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_11 := iife_temp_11.substr(rt.new_string(message_mutated), rt.new_int(20),
			rt.new_int(4))
		mut iife_temp_12 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_12 := iife_temp_12.fromreversestring(iife_result_11)
		var_x5 = rt.call_method(var_x5, 'xorInt32', [iife_result_12])
		mut iife_temp_13 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_13 := iife_temp_13.substr(rt.new_string(message_mutated), rt.new_int(24),
			rt.new_int(4))
		mut iife_temp_14 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_14 := iife_temp_14.fromreversestring(iife_result_13)
		var_x6 = rt.call_method(var_x6, 'xorInt32', [iife_result_14])
		mut iife_temp_15 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_15 := iife_temp_15.substr(rt.new_string(message_mutated), rt.new_int(28),
			rt.new_int(4))
		mut iife_temp_16 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_16 := iife_temp_16.fromreversestring(iife_result_15)
		var_x7 = rt.call_method(var_x7, 'xorInt32', [iife_result_16])
		mut iife_temp_17 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_17 := iife_temp_17.substr(rt.new_string(message_mutated), rt.new_int(32),
			rt.new_int(4))
		mut iife_temp_18 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_18 := iife_temp_18.fromreversestring(iife_result_17)
		var_x8 = rt.call_method(var_x8, 'xorInt32', [iife_result_18])
		mut iife_temp_19 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_19 := iife_temp_19.substr(rt.new_string(message_mutated), rt.new_int(36),
			rt.new_int(4))
		mut iife_temp_20 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_20 := iife_temp_20.fromreversestring(iife_result_19)
		var_x9 = rt.call_method(var_x9, 'xorInt32', [iife_result_20])
		mut iife_temp_21 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_21 := iife_temp_21.substr(rt.new_string(message_mutated), rt.new_int(40),
			rt.new_int(4))
		mut iife_temp_22 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_22 := iife_temp_22.fromreversestring(iife_result_21)
		var_x10 = rt.call_method(var_x10, 'xorInt32', [iife_result_22])
		mut iife_temp_23 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_23 := iife_temp_23.substr(rt.new_string(message_mutated), rt.new_int(44),
			rt.new_int(4))
		mut iife_temp_24 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_24 := iife_temp_24.fromreversestring(iife_result_23)
		var_x11 = rt.call_method(var_x11, 'xorInt32', [iife_result_24])
		mut iife_temp_25 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_25 := iife_temp_25.substr(rt.new_string(message_mutated), rt.new_int(48),
			rt.new_int(4))
		mut iife_temp_26 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_26 := iife_temp_26.fromreversestring(iife_result_25)
		var_x12 = rt.call_method(var_x12, 'xorInt32', [iife_result_26])
		mut iife_temp_27 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_27 := iife_temp_27.substr(rt.new_string(message_mutated), rt.new_int(52),
			rt.new_int(4))
		mut iife_temp_28 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_28 := iife_temp_28.fromreversestring(iife_result_27)
		var_x13 = rt.call_method(var_x13, 'xorInt32', [iife_result_28])
		mut iife_temp_29 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_29 := iife_temp_29.substr(rt.new_string(message_mutated), rt.new_int(56),
			rt.new_int(4))
		mut iife_temp_30 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_30 := iife_temp_30.fromreversestring(iife_result_29)
		var_x14 = rt.call_method(var_x14, 'xorInt32', [iife_result_30])
		mut iife_temp_31 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_31 := iife_temp_31.substr(rt.new_string(message_mutated), rt.new_int(60),
			rt.new_int(4))
		mut iife_temp_32 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_32 := iife_temp_32.fromreversestring(iife_result_31)
		var_x15 = rt.call_method(var_x15, 'xorInt32', [iife_result_32])
		var_j12 = rt.call_method(var_j12, 'addInt', [rt.new_int(1)])
		if rt.is_true(rt.identical(rt.get_property(var_j12, 'limbs').array_get(rt.new_int(0)), rt.new_int(0)))
			&& rt.is_true(rt.identical(rt.get_property(var_j12, 'limbs').array_get(rt.new_int(1)), rt.new_int(0))) {
			var_j13 = rt.call_method(var_j13, 'addInt', [rt.new_int(1)])
		}
		mut var_block := rt.new_string(
			(rt.call_method(var_x0, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x1, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x2, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x3, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x4, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x5, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x6, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x7, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x8, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x9, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x10, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x11, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x12, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x13, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x14, 'toReverseString', []rt.PhpVal{})).str() +
			(rt.call_method(var_x15, 'toReverseString', []rt.PhpVal{})).str())
		if rt.is_true(rt.less(var_bytes, rt.new_int(64))) {
			mut iife_temp_33 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
			mut iife_result_33 := iife_temp_33.substr(var_block.clone(), rt.new_int(0),
				var_bytes.clone())
			var_c = rt.concat(var_c, iife_result_33)
			break
		}
		var_c = rt.concat(var_c, var_block)
		var_bytes = rt.sub(var_bytes, rt.new_int(64))
		if rt.is_true(rt.less_equal(var_bytes, rt.new_int(0))) {
			break
		}
		mut iife_temp_34 := Class_ParagonIE_Sodium_Core32_ChaCha20{}
		mut iife_result_34 := iife_temp_34.substr(rt.new_string(message_mutated), rt.new_int(64))
		message_mutated = iife_result_34.str()
	}
	var_ctx_mutated.array_set(12, var_j12.clone())
	var_ctx_mutated.array_set(13, var_j13.clone())
	return var_c.clone()
}

fn Class_ParagonIE_Sodium_Core32_ChaCha20.stream(len i64, nonce string, key string) rt.PhpVal {
	return Class_ParagonIE_Sodium_Core32_ChaCha20.encryptbytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx](create_paragonie_sodium_core32_chacha20_ctx(rt.new_string(key),
		rt.new_string(nonce))), (rt.call_function('str_repeat', [
		rt.new_string(''), rt.new_int(len)])).str())
}

fn Class_ParagonIE_Sodium_Core32_ChaCha20.ietfstream(var_len rt.PhpVal, nonce string, key string) rt.PhpVal {
	return Class_ParagonIE_Sodium_Core32_ChaCha20.encryptbytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx](create_paragonie_sodium_core32_chacha20_ietfctx(rt.new_string(key),
		rt.new_string(nonce))), (rt.call_function('str_repeat', [
		rt.new_string(''), var_len.clone()])).str())
}

fn Class_ParagonIE_Sodium_Core32_ChaCha20.ietfstreamxoric(var_message rt.PhpVal, nonce string, key string, ic string) rt.PhpVal {
	mut var_message_mutated := var_message
	return Class_ParagonIE_Sodium_Core32_ChaCha20.encryptbytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx](create_paragonie_sodium_core32_chacha20_ietfctx(rt.new_string(key),
		rt.new_string(nonce), rt.new_string(ic))), var_message_mutated.str())
}

fn Class_ParagonIE_Sodium_Core32_ChaCha20.streamxoric(var_message rt.PhpVal, nonce string, key string, ic string) rt.PhpVal {
	mut var_message_mutated := var_message
	return Class_ParagonIE_Sodium_Core32_ChaCha20.encryptbytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx](create_paragonie_sodium_core32_chacha20_ctx(rt.new_string(key),
		rt.new_string(nonce), rt.new_string(ic))), var_message_mutated.str())
}

struct Class_ParagonIE_Sodium_Core32_Util {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int32 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_chacha20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_ChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_ChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_util(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Util {
	mut obj := &Class_ParagonIE_Sodium_Core32_Util{
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

fn create_paragonie_sodium_core32_chacha20_ctx(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx {
	mut obj := &Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_chacha20_ietfctx(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx {
	mut obj := &Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'quarterRound' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Int32](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			return Class_ParagonIE_Sodium_Core32_ChaCha20.quarterround(mut dispatch_arg_0, mut
				dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
		}
		'encryptBytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core32_ChaCha20.encryptbytes(mut dispatch_arg_0,
				dispatch_arg_1)
		}
		'stream' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core32_ChaCha20.stream(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'ietfStream' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core32_ChaCha20.ietfstream(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'ietfStreamXorIc' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core32_ChaCha20.ietfstreamxoric(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'streamXorIc' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core32_ChaCha20.streamxoric(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_Ctx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20_IetfCtx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core32_ChaCha20'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
