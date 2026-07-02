import rt

struct Class_ParagonIE_Sodium_Core_ChaCha20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_ChaCha20.rotate(var_v rt.PhpVal, var_n rt.PhpVal) i64 {
	rt.new_null()
	rt.new_null()
	return 4294967295 & rt.shift_left(var_v, var_n) | rt.shift_right(var_v, rt.sub(rt.new_int(32),
		var_n))
}

fn Class_ParagonIE_Sodium_Core_ChaCha20.quarterround(var_a rt.PhpVal, var_b rt.PhpVal, var_c rt.PhpVal, var_d rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
	mut var_b_mutated := var_b
	mut var_c_mutated := var_c
	mut var_d_mutated := var_d
	var_a_mutated = rt.new_int(rt.bitwise_and(rt.add(var_a_mutated, var_b_mutated),
		rt.new_int(4294967295)))
	var_d_mutated = Class_ParagonIE_Sodium_Core_ChaCha20.rotate(rt.new_int(rt.bitwise_xor(var_d_mutated,
		var_a_mutated)), rt.new_int(16))
	var_c_mutated = rt.new_int(rt.bitwise_and(rt.add(var_c_mutated, var_d_mutated),
		rt.new_int(4294967295)))
	var_b_mutated = Class_ParagonIE_Sodium_Core_ChaCha20.rotate(rt.new_int(rt.bitwise_xor(var_b_mutated,
		var_c_mutated)), rt.new_int(12))
	var_a_mutated = rt.new_int(rt.bitwise_and(rt.add(var_a_mutated, var_b_mutated),
		rt.new_int(4294967295)))
	var_d_mutated = Class_ParagonIE_Sodium_Core_ChaCha20.rotate(rt.new_int(rt.bitwise_xor(var_d_mutated,
		var_a_mutated)), rt.new_int(8))
	var_c_mutated = rt.new_int(rt.bitwise_and(rt.add(var_c_mutated, var_d_mutated),
		rt.new_int(4294967295)))
	var_b_mutated = Class_ParagonIE_Sodium_Core_ChaCha20.rotate(rt.new_int(rt.bitwise_xor(var_b_mutated,
		var_c_mutated)), rt.new_int(7))
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_int(var_a_mutated.to_i64()) },
		rt.ArrayItem{ key: none, val: rt.new_int(var_b_mutated.to_i64()) },
		rt.ArrayItem{ key: none, val: rt.new_int(var_c_mutated.to_i64()) },
		rt.ArrayItem{ key: none, val: rt.new_int(var_d_mutated.to_i64()) },
	])
}

fn Class_ParagonIE_Sodium_Core_ChaCha20.encryptbytes(mut var_ctx Class_ParagonIE_Sodium_Core_ChaCha20_Ctx, message string) rt.PhpVal {
	mut var_ctx_mutated := var_ctx
	mut message_mutated := message
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core_ChaCha20{}
	mut iife_result_0 := iife_temp_0.strlen(rt.new_string(message_mutated))
	mut var_bytes := iife_result_0
	mut var_j0 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(0))).to_i64())
	mut var_j1 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(1))).to_i64())
	mut var_j2 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(2))).to_i64())
	mut var_j3 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(3))).to_i64())
	mut var_j4 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(4))).to_i64())
	mut var_j5 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(5))).to_i64())
	mut var_j6 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(6))).to_i64())
	mut var_j7 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(7))).to_i64())
	mut var_j8 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(8))).to_i64())
	mut var_j9 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(9))).to_i64())
	mut var_j10 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(10))).to_i64())
	mut var_j11 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(11))).to_i64())
	mut var_j12 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(12))).to_i64())
	mut var_j13 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(13))).to_i64())
	mut var_j14 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(14))).to_i64())
	mut var_j15 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(15))).to_i64())
	mut var_c := rt.new_string('')
	for {
		if rt.is_true(rt.less(var_bytes, rt.new_int(64))) {
			message_mutated = message_mutated +(rt.call_function('str_repeat', [rt.new_string(''), rt.sub(rt.new_int(64), var_bytes)])).str()
		}
		mut var_x0 := rt.new_int(var_j0.to_i64())
		mut var_x1 := rt.new_int(var_j1.to_i64())
		mut var_x2 := rt.new_int(var_j2.to_i64())
		mut var_x3 := rt.new_int(var_j3.to_i64())
		mut var_x4 := rt.new_int(var_j4.to_i64())
		mut var_x5 := rt.new_int(var_j5.to_i64())
		mut var_x6 := rt.new_int(var_j6.to_i64())
		mut var_x7 := rt.new_int(var_j7.to_i64())
		mut var_x8 := rt.new_int(var_j8.to_i64())
		mut var_x9 := rt.new_int(var_j9.to_i64())
		mut var_x10 := rt.new_int(var_j10.to_i64())
		mut var_x11 := rt.new_int(var_j11.to_i64())
		mut var_x12 := rt.new_int(var_j12.to_i64())
		mut var_x13 := rt.new_int(var_j13.to_i64())
		mut var_x14 := rt.new_int(var_j14.to_i64())
		mut var_x15 := rt.new_int(var_j15.to_i64())
		mut var_i := rt.new_int(20)
		for {
			if !(rt.is_true(rt.greater(var_i, rt.new_int(0)))) { break
			 }
			mut list_tmp_1 := Class_ParagonIE_Sodium_Core_ChaCha20.quarterround(var_x0.clone(),
				var_x4.clone(), var_x8.clone(), var_x12.clone())
			var_x0 = list_tmp_1.array_get(0)
			var_x4 = list_tmp_1.array_get(1)
			var_x8 = list_tmp_1.array_get(2)
			var_x12 = list_tmp_1.array_get(3)
			mut list_tmp_2 := Class_ParagonIE_Sodium_Core_ChaCha20.quarterround(var_x1.clone(),
				var_x5.clone(), var_x9.clone(), var_x13.clone())
			var_x1 = list_tmp_2.array_get(0)
			var_x5 = list_tmp_2.array_get(1)
			var_x9 = list_tmp_2.array_get(2)
			var_x13 = list_tmp_2.array_get(3)
			mut list_tmp_3 := Class_ParagonIE_Sodium_Core_ChaCha20.quarterround(var_x2.clone(),
				var_x6.clone(), var_x10.clone(), var_x14.clone())
			var_x2 = list_tmp_3.array_get(0)
			var_x6 = list_tmp_3.array_get(1)
			var_x10 = list_tmp_3.array_get(2)
			var_x14 = list_tmp_3.array_get(3)
			mut list_tmp_4 := Class_ParagonIE_Sodium_Core_ChaCha20.quarterround(var_x3.clone(),
				var_x7.clone(), var_x11.clone(), var_x15.clone())
			var_x3 = list_tmp_4.array_get(0)
			var_x7 = list_tmp_4.array_get(1)
			var_x11 = list_tmp_4.array_get(2)
			var_x15 = list_tmp_4.array_get(3)
			mut list_tmp_5 := Class_ParagonIE_Sodium_Core_ChaCha20.quarterround(var_x0.clone(),
				var_x5.clone(), var_x10.clone(), var_x15.clone())
			var_x0 = list_tmp_5.array_get(0)
			var_x5 = list_tmp_5.array_get(1)
			var_x10 = list_tmp_5.array_get(2)
			var_x15 = list_tmp_5.array_get(3)
			mut list_tmp_6 := Class_ParagonIE_Sodium_Core_ChaCha20.quarterround(var_x1.clone(),
				var_x6.clone(), var_x11.clone(), var_x12.clone())
			var_x1 = list_tmp_6.array_get(0)
			var_x6 = list_tmp_6.array_get(1)
			var_x11 = list_tmp_6.array_get(2)
			var_x12 = list_tmp_6.array_get(3)
			mut list_tmp_7 := Class_ParagonIE_Sodium_Core_ChaCha20.quarterround(var_x2.clone(),
				var_x7.clone(), var_x8.clone(), var_x13.clone())
			var_x2 = list_tmp_7.array_get(0)
			var_x7 = list_tmp_7.array_get(1)
			var_x8 = list_tmp_7.array_get(2)
			var_x13 = list_tmp_7.array_get(3)
			mut list_tmp_8 := Class_ParagonIE_Sodium_Core_ChaCha20.quarterround(var_x3.clone(),
				var_x4.clone(), var_x9.clone(), var_x14.clone())
			var_x3 = list_tmp_8.array_get(0)
			var_x4 = list_tmp_8.array_get(1)
			var_x9 = list_tmp_8.array_get(2)
			var_x14 = list_tmp_8.array_get(3)
			var_i = rt.sub(var_i, rt.new_int(2))
		}
		var_x0 = rt.add(rt.bitwise_and(var_x0, rt.new_int(4294967295)), var_j0)
		var_x1 = rt.add(rt.bitwise_and(var_x1, rt.new_int(4294967295)), var_j1)
		var_x2 = rt.add(rt.bitwise_and(var_x2, rt.new_int(4294967295)), var_j2)
		var_x3 = rt.add(rt.bitwise_and(var_x3, rt.new_int(4294967295)), var_j3)
		var_x4 = rt.add(rt.bitwise_and(var_x4, rt.new_int(4294967295)), var_j4)
		var_x5 = rt.add(rt.bitwise_and(var_x5, rt.new_int(4294967295)), var_j5)
		var_x6 = rt.add(rt.bitwise_and(var_x6, rt.new_int(4294967295)), var_j6)
		var_x7 = rt.add(rt.bitwise_and(var_x7, rt.new_int(4294967295)), var_j7)
		var_x8 = rt.add(rt.bitwise_and(var_x8, rt.new_int(4294967295)), var_j8)
		var_x9 = rt.add(rt.bitwise_and(var_x9, rt.new_int(4294967295)), var_j9)
		var_x10 = rt.add(rt.bitwise_and(var_x10, rt.new_int(4294967295)), var_j10)
		var_x11 = rt.add(rt.bitwise_and(var_x11, rt.new_int(4294967295)), var_j11)
		var_x12 = rt.add(rt.bitwise_and(var_x12, rt.new_int(4294967295)), var_j12)
		var_x13 = rt.add(rt.bitwise_and(var_x13, rt.new_int(4294967295)), var_j13)
		var_x14 = rt.add(rt.bitwise_and(var_x14, rt.new_int(4294967295)), var_j14)
		var_x15 = rt.add(rt.bitwise_and(var_x15, rt.new_int(4294967295)), var_j15)
		rt.new_null()
		rt.new_null()
		rt.new_null()
		rt.new_null()
		rt.new_null()
		rt.new_null()
		rt.new_null()
		rt.new_null()
		rt.new_null()
		rt.new_null()
		rt.new_null()
		rt.new_null()
		rt.new_null()
		rt.new_null()
		rt.new_null()
		rt.new_null()
		rt.pre_inc(var_j12)
		if rt.is_true(rt.bitwise_and(var_j12, rt.new_int(4026531840))) {
			rt.throw_exception(rt.new_object('SodiumException', []string{},
				create_sodiumexception(rt.new_string('Overflow'))))
		}
		mut iife_temp_1 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_1 := iife_temp_1.store32_le(rt.new_int(rt.bitwise_and(var_x0,
			rt.new_int(4294967295))))
		mut iife_temp_2 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_2 := iife_temp_2.store32_le(rt.new_int(rt.bitwise_and(var_x1,
			rt.new_int(4294967295))))
		mut iife_temp_3 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_3 := iife_temp_3.store32_le(rt.new_int(rt.bitwise_and(var_x2,
			rt.new_int(4294967295))))
		mut iife_temp_4 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_4 := iife_temp_4.store32_le(rt.new_int(rt.bitwise_and(var_x3,
			rt.new_int(4294967295))))
		mut iife_temp_5 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_5 := iife_temp_5.store32_le(rt.new_int(rt.bitwise_and(var_x4,
			rt.new_int(4294967295))))
		mut iife_temp_6 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_6 := iife_temp_6.store32_le(rt.new_int(rt.bitwise_and(var_x5,
			rt.new_int(4294967295))))
		mut iife_temp_7 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_7 := iife_temp_7.store32_le(rt.new_int(rt.bitwise_and(var_x6,
			rt.new_int(4294967295))))
		mut iife_temp_8 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_8 := iife_temp_8.store32_le(rt.new_int(rt.bitwise_and(var_x7,
			rt.new_int(4294967295))))
		mut iife_temp_9 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_9 := iife_temp_9.store32_le(rt.new_int(rt.bitwise_and(var_x8,
			rt.new_int(4294967295))))
		mut iife_temp_10 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_10 := iife_temp_10.store32_le(rt.new_int(rt.bitwise_and(var_x9,
			rt.new_int(4294967295))))
		mut iife_temp_11 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_11 := iife_temp_11.store32_le(rt.new_int(rt.bitwise_and(var_x10,
			rt.new_int(4294967295))))
		mut iife_temp_12 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_12 := iife_temp_12.store32_le(rt.new_int(rt.bitwise_and(var_x11,
			rt.new_int(4294967295))))
		mut iife_temp_13 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_13 := iife_temp_13.store32_le(rt.new_int(rt.bitwise_and(var_x12,
			rt.new_int(4294967295))))
		mut iife_temp_14 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_14 := iife_temp_14.store32_le(rt.new_int(rt.bitwise_and(var_x13,
			rt.new_int(4294967295))))
		mut iife_temp_15 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_15 := iife_temp_15.store32_le(rt.new_int(rt.bitwise_and(var_x14,
			rt.new_int(4294967295))))
		mut iife_temp_16 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_16 := iife_temp_16.store32_le(rt.new_int(rt.bitwise_and(var_x15,
			rt.new_int(4294967295))))
		mut var_block := rt.new_string(iife_result_1.str() + iife_result_2.str() +
			iife_result_3.str() + iife_result_4.str() + iife_result_5.str() + iife_result_6.str() +
			iife_result_7.str() + iife_result_8.str() + iife_result_9.str() + iife_result_10.str() +
			iife_result_11.str() + iife_result_12.str() + iife_result_13.str() +
			iife_result_14.str() + iife_result_15.str() + iife_result_16.str())
		if rt.is_true(rt.less(var_bytes, rt.new_int(64))) {
			mut iife_temp_17 := Class_ParagonIE_Sodium_Core_ChaCha20{}
			mut iife_result_17 := iife_temp_17.substr(var_block.clone(), rt.new_int(0),
				var_bytes.clone())
			var_c = rt.concat(var_c, iife_result_17)
			break
		}
		var_c = rt.concat(var_c, var_block)
		var_bytes = rt.sub(var_bytes, rt.new_int(64))
		if rt.is_true(rt.less_equal(var_bytes, rt.new_int(0))) {
			break
		}
		mut iife_temp_18 := Class_ParagonIE_Sodium_Core_ChaCha20{}
		mut iife_result_18 := iife_temp_18.substr(rt.new_string(message_mutated), rt.new_int(64))
		message_mutated = iife_result_18.str()
	}
	var_ctx_mutated.array_set(12, var_j12.clone())
	var_ctx_mutated.array_set(13, var_j13.clone())
	return var_c.clone()
}

fn Class_ParagonIE_Sodium_Core_ChaCha20.stream(var_len rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return Class_ParagonIE_Sodium_Core_ChaCha20.encryptbytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_ChaCha20_Ctx](create_paragonie_sodium_core_chacha20_ctx(var_key.clone(),
		var_nonce.clone())), (rt.call_function('str_repeat', [
		rt.new_string(''), var_len.clone()])).str())
}

fn Class_ParagonIE_Sodium_Core_ChaCha20.ietfstream(var_len rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	return Class_ParagonIE_Sodium_Core_ChaCha20.encryptbytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_ChaCha20_Ctx](create_paragonie_sodium_core_chacha20_ietfctx(var_key.clone(),
		var_nonce.clone())), (rt.call_function('str_repeat', [
		rt.new_string(''), var_len.clone()])).str())
}

fn Class_ParagonIE_Sodium_Core_ChaCha20.ietfstreamxoric(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal, ic string) rt.PhpVal {
	mut var_message_mutated := var_message
	return Class_ParagonIE_Sodium_Core_ChaCha20.encryptbytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_ChaCha20_Ctx](create_paragonie_sodium_core_chacha20_ietfctx(var_key.clone(),
		var_nonce.clone(), rt.new_string(ic))), var_message_mutated.str())
}

fn Class_ParagonIE_Sodium_Core_ChaCha20.streamxoric(var_message rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal, ic string) rt.PhpVal {
	mut var_message_mutated := var_message
	return Class_ParagonIE_Sodium_Core_ChaCha20.encryptbytes(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_ChaCha20_Ctx](create_paragonie_sodium_core_chacha20_ctx(var_key.clone(),
		var_nonce.clone(), rt.new_string(ic))), var_message_mutated.str())
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_ChaCha20_Ctx {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_chacha20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_ChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_util(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_sodiumexception(_args ...rt.PhpVal) &Class_SodiumException {
	mut obj := &Class_SodiumException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_chacha20_ctx(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_chacha20_ietfctx(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'rotate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core_ChaCha20.rotate(dispatch_arg_0,
				dispatch_arg_1))
		}
		'quarterRound' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_ChaCha20.quarterround(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'encryptBytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_ChaCha20_Ctx](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core_ChaCha20.encryptbytes(mut dispatch_arg_0,
				dispatch_arg_1)
		}
		'stream' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_ChaCha20.stream(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'ietfStream' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_ChaCha20.ietfstream(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'ietfStreamXorIc' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core_ChaCha20.ietfstreamxoric(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'streamXorIc' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return Class_ParagonIE_Sodium_Core_ChaCha20.streamxoric(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_SodiumException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SodiumException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SodiumException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_Ctx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20_IetfCtx) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_ChaCha20'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
