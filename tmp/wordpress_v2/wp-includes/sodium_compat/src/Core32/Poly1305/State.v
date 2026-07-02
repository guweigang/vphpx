import rt

struct Class_ParagonIE_Sodium_Core32_Poly1305_State {
	rt.PhpObjectBase
pub mut:
	buffer   rt.PhpVal = rt.new_array()
	final    bool
	h        rt.PhpVal = rt.new_null()
	leftover rt.PhpVal = rt.new_int(0)
	r        rt.PhpVal = rt.new_null()
	pad      rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305_State) construct(key string) {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
	mut iife_result_0 := iife_temp_0.strlen(rt.new_string(key))
	if rt.is_true(rt.less(iife_result_0, rt.new_int(32))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
			create_invalidargumentexception(rt.new_string('Poly1305 requires a 32-byte key'))))
	}
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
	mut iife_result_1 := iife_temp_1.substr(rt.new_string(key), rt.new_int(0), rt.new_int(4))
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_2 := iife_temp_2.fromreversestring(iife_result_1)
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
	mut iife_result_3 := iife_temp_3.substr(rt.new_string(key), rt.new_int(3), rt.new_int(4))
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_4 := iife_temp_4.fromreversestring(iife_result_3)
	mut iife_temp_5 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
	mut iife_result_5 := iife_temp_5.substr(rt.new_string(key), rt.new_int(6), rt.new_int(4))
	mut iife_temp_6 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_6 := iife_temp_6.fromreversestring(iife_result_5)
	mut iife_temp_7 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
	mut iife_result_7 := iife_temp_7.substr(rt.new_string(key), rt.new_int(9), rt.new_int(4))
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_8 := iife_temp_8.fromreversestring(iife_result_7)
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
	mut iife_result_9 := iife_temp_9.substr(rt.new_string(key), rt.new_int(12), rt.new_int(4))
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_10 := iife_temp_10.fromreversestring(iife_result_9)
	this.r = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_method(rt.call_method(iife_result_2,
			'setUnsignedInt', [rt.new_bool(true)]), 'mask', [
			rt.new_int(67108863)]) },
		rt.ArrayItem{ key: none, val: rt.call_method(rt.call_method(rt.call_method(iife_result_4,
			'setUnsignedInt', [rt.new_bool(true)]), 'shiftRight', [
			rt.new_int(2)]), 'mask', [rt.new_int(67108611)]) },
		rt.ArrayItem{ key: none, val: rt.call_method(rt.call_method(rt.call_method(iife_result_6,
			'setUnsignedInt', [rt.new_bool(true)]), 'shiftRight', [
			rt.new_int(4)]), 'mask', [rt.new_int(67092735)]) },
		rt.ArrayItem{ key: none, val: rt.call_method(rt.call_method(rt.call_method(iife_result_8,
			'setUnsignedInt', [rt.new_bool(true)]), 'shiftRight', [
			rt.new_int(6)]), 'mask', [rt.new_int(66076671)]) },
		rt.ArrayItem{ key: none, val: rt.call_method(rt.call_method(rt.call_method(iife_result_10,
			'setUnsignedInt', [rt.new_bool(true)]), 'shiftRight', [
			rt.new_int(8)]), 'mask', [rt.new_int(1048575)]) },
	])
	this.h = rt.create_array([
		rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32(rt.create_array([
			rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 },
		]), rt.new_bool(true)) },
		rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32(rt.create_array([
			rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 },
		]), rt.new_bool(true)) },
		rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32(rt.create_array([
			rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 },
		]), rt.new_bool(true)) },
		rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32(rt.create_array([
			rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 },
		]), rt.new_bool(true)) },
		rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int32(rt.create_array([
			rt.ArrayItem{ key: none, val: 0 },
			rt.ArrayItem{ key: none, val: 0 },
		]), rt.new_bool(true)) },
	])
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
	mut iife_result_11 := iife_temp_11.substr(rt.new_string(key), rt.new_int(16), rt.new_int(4))
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_12 := iife_temp_12.fromreversestring(iife_result_11)
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
	mut iife_result_13 := iife_temp_13.substr(rt.new_string(key), rt.new_int(20), rt.new_int(4))
	mut iife_temp_14 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_14 := iife_temp_14.fromreversestring(iife_result_13)
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
	mut iife_result_15 := iife_temp_15.substr(rt.new_string(key), rt.new_int(24), rt.new_int(4))
	mut iife_temp_16 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_16 := iife_temp_16.fromreversestring(iife_result_15)
	mut iife_temp_17 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
	mut iife_result_17 := iife_temp_17.substr(rt.new_string(key), rt.new_int(28), rt.new_int(4))
	mut iife_temp_18 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_18 := iife_temp_18.fromreversestring(iife_result_17)
	this.pad = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_method(rt.call_method(iife_result_12,
			'setUnsignedInt', [rt.new_bool(true)]), 'toInt64', []rt.PhpVal{}) },
		rt.ArrayItem{ key: none, val: rt.call_method(rt.call_method(iife_result_14,
			'setUnsignedInt', [rt.new_bool(true)]), 'toInt64', []rt.PhpVal{}) },
		rt.ArrayItem{ key: none, val: rt.call_method(rt.call_method(iife_result_16,
			'setUnsignedInt', [rt.new_bool(true)]), 'toInt64', []rt.PhpVal{}) },
		rt.ArrayItem{ key: none, val: rt.call_method(rt.call_method(iife_result_18,
			'setUnsignedInt', [rt.new_bool(true)]), 'toInt64', []rt.PhpVal{}) },
	])
	this.leftover = rt.new_int(0)
	this.final = false
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305_State) update(message string) rt.PhpVal {
	mut message_mutated := message
	mut iife_temp_19 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
	mut iife_result_19 := iife_temp_19.strlen(rt.new_string(message_mutated))
	mut var_bytes := iife_result_19
	if rt.is_true(this.leftover) {
		mut var_want := rt.sub(Class_ParagonIE_Sodium_Core32_Poly1305.block_size(), this.leftover)
		if rt.is_true(rt.greater(var_want, var_bytes)) {
			var_want = var_bytes.clone()
		}
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, var_want))) { break
			 }
			mut iife_temp_20 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
			mut iife_result_20 :=
				iife_temp_20.chrtoint(rt.new_string(message_mutated).array_get(var_i))
			mut var_mi := iife_result_20
			this.buffer.array_set(rt.add(this.leftover, var_i), var_mi.clone())
			rt.pre_inc(var_i)
		}
		mut iife_temp_21 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
		mut iife_result_21 := iife_temp_21.substr(rt.new_string(message_mutated), var_want.clone())
		message_mutated = iife_result_21.str()
		mut iife_temp_22 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
		mut iife_result_22 := iife_temp_22.strlen(rt.new_string(message_mutated))
		var_bytes = iife_result_22
		this.leftover = rt.add(this.leftover, var_want)
		if rt.is_true(rt.less(this.leftover, Class_ParagonIE_Sodium_Core32_Poly1305.block_size())) {
			return rt.new_object('ParagonIE_Sodium_Core32_Poly1305_State', []string{}, this)
		}
		mut iife_temp_23 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
		mut iife_result_23 := iife_temp_23.intarraytostring(this.buffer)
		this.blocks(iife_result_23, Class_ParagonIE_Sodium_Core32_Poly1305.block_size())
		this.leftover = rt.new_int(0)
	}
	if rt.is_true(rt.greater_equal(var_bytes, Class_ParagonIE_Sodium_Core32_Poly1305.block_size())) {
		var_want = rt.new_int(rt.bitwise_and(var_bytes, rt.bitwise_not(rt.sub(Class_ParagonIE_Sodium_Core32_Poly1305.block_size(),
			rt.new_int(1)))))
		if rt.is_true(rt.greater_equal(var_want,
			Class_ParagonIE_Sodium_Core32_Poly1305.block_size()))
		{
			mut iife_temp_24 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
			mut iife_result_24 := iife_temp_24.substr(rt.new_string(message_mutated),
				rt.new_int(0), var_want.clone())
			mut var_block := iife_result_24
			mut iife_temp_25 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
			mut iife_result_25 := iife_temp_25.strlen(var_block.clone())
			if rt.is_true(rt.greater_equal(iife_result_25,
				Class_ParagonIE_Sodium_Core32_Poly1305.block_size()))
			{
				this.blocks(var_block.clone(), var_want.clone())
				mut iife_temp_26 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
				mut iife_result_26 := iife_temp_26.substr(rt.new_string(message_mutated),
					var_want.clone())
				message_mutated = iife_result_26.str()
				mut iife_temp_27 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
				mut iife_result_27 := iife_temp_27.strlen(rt.new_string(message_mutated))
				var_bytes = iife_result_27
			}
		}
	}
	if rt.is_true(var_bytes) {
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, var_bytes))) { break
			 }
			mut iife_temp_28 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
			mut iife_result_28 :=
				iife_temp_28.chrtoint(rt.new_string(message_mutated).array_get(var_i))
			mut var_mi := iife_result_28
			this.buffer.array_set(rt.add(this.leftover, var_i), var_mi.clone())
			rt.pre_inc(var_i)
		}
		this.leftover = rt.add(rt.new_int((this.leftover).to_i64()), var_bytes)
	}
	return rt.new_object('ParagonIE_Sodium_Core32_Poly1305_State', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305_State) blocks(var_message rt.PhpVal, var_bytes rt.PhpVal) rt.PhpVal {
	mut var_message_mutated := var_message
	mut var_bytes_mutated := var_bytes
	mut iife_temp_29 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
	mut iife_result_29 := iife_temp_29.strlen(var_message_mutated.clone())
	if rt.is_true(rt.less(iife_result_29, rt.new_int(16))) {
		var_message_mutated = rt.call_function('str_pad', [var_message_mutated.clone(),
			rt.new_int(16), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
	}
	mut iife_temp_30 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_30 := iife_temp_30.fromint(rt.new_int(if this.final { 0 } else { 1 << 24 }))
	mut var_hibit := iife_result_30
	rt.call_method(var_hibit, 'setUnsignedInt', [rt.new_bool(true)])
	mut var_zero := create_paragonie_sodium_core32_int64(rt.create_array([
		rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 },
	]), rt.new_bool(true))
	mut var_r0 := rt.call_method(this.r.array_get(rt.new_int(0)), 'toInt64', []rt.PhpVal{})
	mut var_r1 := rt.call_method(this.r.array_get(rt.new_int(1)), 'toInt64', []rt.PhpVal{})
	mut var_r2 := rt.call_method(this.r.array_get(rt.new_int(2)), 'toInt64', []rt.PhpVal{})
	mut var_r3 := rt.call_method(this.r.array_get(rt.new_int(3)), 'toInt64', []rt.PhpVal{})
	mut var_r4 := rt.call_method(this.r.array_get(rt.new_int(4)), 'toInt64', []rt.PhpVal{})
	mut var_s1 := rt.call_method(rt.call_method(var_r1, 'toInt64', []rt.PhpVal{}), 'mulInt', [
		rt.new_int(5),
		rt.new_int(3),
	])
	mut var_s2 := rt.call_method(rt.call_method(var_r2, 'toInt64', []rt.PhpVal{}), 'mulInt', [
		rt.new_int(5),
		rt.new_int(3),
	])
	mut var_s3 := rt.call_method(rt.call_method(var_r3, 'toInt64', []rt.PhpVal{}), 'mulInt', [
		rt.new_int(5),
		rt.new_int(3),
	])
	mut var_s4 := rt.call_method(rt.call_method(var_r4, 'toInt64', []rt.PhpVal{}), 'mulInt', [
		rt.new_int(5),
		rt.new_int(3),
	])
	mut var_h0 := this.h.array_get(rt.new_int(0))
	mut var_h1 := this.h.array_get(rt.new_int(1))
	mut var_h2 := this.h.array_get(rt.new_int(2))
	mut var_h3 := this.h.array_get(rt.new_int(3))
	mut var_h4 := this.h.array_get(rt.new_int(4))
	for rt.is_true(rt.greater_equal(var_bytes_mutated,
		Class_ParagonIE_Sodium_Core32_Poly1305.block_size())) {
		mut iife_temp_31 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
		mut iife_result_31 := iife_temp_31.substr(var_message_mutated.clone(), rt.new_int(0),
			rt.new_int(4))
		mut iife_temp_32 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_32 := iife_temp_32.fromreversestring(iife_result_31)
		var_h0 = rt.call_method(rt.call_method(var_h0, 'addInt32', [
			rt.call_method(iife_result_32, 'mask', [rt.new_int(67108863)]),
		]), 'toInt64', []rt.PhpVal{})
		mut iife_temp_33 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
		mut iife_result_33 := iife_temp_33.substr(var_message_mutated.clone(), rt.new_int(3),
			rt.new_int(4))
		mut iife_temp_34 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_34 := iife_temp_34.fromreversestring(iife_result_33)
		var_h1 = rt.call_method(rt.call_method(var_h1, 'addInt32', [
			rt.call_method(rt.call_method(iife_result_34, 'shiftRight', [
				rt.new_int(2)]), 'mask', [rt.new_int(67108863)]),
		]), 'toInt64', []rt.PhpVal{})
		mut iife_temp_35 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
		mut iife_result_35 := iife_temp_35.substr(var_message_mutated.clone(), rt.new_int(6),
			rt.new_int(4))
		mut iife_temp_36 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_36 := iife_temp_36.fromreversestring(iife_result_35)
		var_h2 = rt.call_method(rt.call_method(var_h2, 'addInt32', [
			rt.call_method(rt.call_method(iife_result_36, 'shiftRight', [
				rt.new_int(4)]), 'mask', [rt.new_int(67108863)]),
		]), 'toInt64', []rt.PhpVal{})
		mut iife_temp_37 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
		mut iife_result_37 := iife_temp_37.substr(var_message_mutated.clone(), rt.new_int(9),
			rt.new_int(4))
		mut iife_temp_38 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_38 := iife_temp_38.fromreversestring(iife_result_37)
		var_h3 = rt.call_method(rt.call_method(var_h3, 'addInt32', [
			rt.call_method(rt.call_method(iife_result_38, 'shiftRight', [
				rt.new_int(6)]), 'mask', [rt.new_int(67108863)]),
		]), 'toInt64', []rt.PhpVal{})
		mut iife_temp_39 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
		mut iife_result_39 := iife_temp_39.substr(var_message_mutated.clone(), rt.new_int(12),
			rt.new_int(4))
		mut iife_temp_40 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_40 := iife_temp_40.fromreversestring(iife_result_39)
		var_h4 = rt.call_method(rt.call_method(var_h4, 'addInt32', [
			rt.call_method(rt.call_method(iife_result_40, 'shiftRight', [
				rt.new_int(8)]), 'orInt32', [var_hibit.clone()]),
		]), 'toInt64', []rt.PhpVal{})
		mut var_d0 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_zero.addint64(rt.call_method(var_h0,
			'mulInt64', [var_r0.clone(), rt.new_int(27)])), 'addInt64', [
			rt.call_method(var_s4, 'mulInt64', [var_h1.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_s3, 'mulInt64', [var_h2.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_s2, 'mulInt64', [var_h3.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_s1, 'mulInt64', [var_h4.clone(),
				rt.new_int(27)]),
		])
		mut var_d1 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_zero.addint64(rt.call_method(var_h0,
			'mulInt64', [var_r1.clone(), rt.new_int(27)])), 'addInt64', [
			rt.call_method(var_h1, 'mulInt64', [var_r0.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_s4, 'mulInt64', [var_h2.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_s3, 'mulInt64', [var_h3.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_s2, 'mulInt64', [var_h4.clone(),
				rt.new_int(27)]),
		])
		mut var_d2 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_zero.addint64(rt.call_method(var_h0,
			'mulInt64', [var_r2.clone(), rt.new_int(27)])), 'addInt64', [
			rt.call_method(var_h1, 'mulInt64', [var_r1.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_h2, 'mulInt64', [var_r0.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_s4, 'mulInt64', [var_h3.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_s3, 'mulInt64', [var_h4.clone(),
				rt.new_int(27)]),
		])
		mut var_d3 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_zero.addint64(rt.call_method(var_h0,
			'mulInt64', [var_r3.clone(), rt.new_int(27)])), 'addInt64', [
			rt.call_method(var_h1, 'mulInt64', [var_r2.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_h2, 'mulInt64', [var_r1.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_h3, 'mulInt64', [var_r0.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_s4, 'mulInt64', [var_h4.clone(),
				rt.new_int(27)]),
		])
		mut var_d4 := rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_zero.addint64(rt.call_method(var_h0,
			'mulInt64', [var_r4.clone(), rt.new_int(27)])), 'addInt64', [
			rt.call_method(var_h1, 'mulInt64', [var_r3.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_h2, 'mulInt64', [var_r2.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_h3, 'mulInt64', [var_r1.clone(),
				rt.new_int(27)]),
		]), 'addInt64', [
			rt.call_method(var_h4, 'mulInt64', [var_r0.clone(),
				rt.new_int(27)]),
		])
		mut var_c := rt.call_method(var_d0, 'shiftRight', [rt.new_int(26)])
		var_h0 = rt.call_method(rt.call_method(var_d0, 'toInt32', []rt.PhpVal{}), 'mask', [
			rt.new_int(67108863),
		])
		var_d1 = rt.call_method(var_d1, 'addInt64', [var_c.clone()])
		var_c = rt.call_method(var_d1, 'shiftRight', [rt.new_int(26)])
		var_h1 = rt.call_method(rt.call_method(var_d1, 'toInt32', []rt.PhpVal{}), 'mask', [
			rt.new_int(67108863),
		])
		var_d2 = rt.call_method(var_d2, 'addInt64', [var_c.clone()])
		var_c = rt.call_method(var_d2, 'shiftRight', [rt.new_int(26)])
		var_h2 = rt.call_method(rt.call_method(var_d2, 'toInt32', []rt.PhpVal{}), 'mask', [
			rt.new_int(67108863),
		])
		var_d3 = rt.call_method(var_d3, 'addInt64', [var_c.clone()])
		var_c = rt.call_method(var_d3, 'shiftRight', [rt.new_int(26)])
		var_h3 = rt.call_method(rt.call_method(var_d3, 'toInt32', []rt.PhpVal{}), 'mask', [
			rt.new_int(67108863),
		])
		var_d4 = rt.call_method(var_d4, 'addInt64', [var_c.clone()])
		var_c = rt.call_method(var_d4, 'shiftRight', [rt.new_int(26)])
		var_h4 = rt.call_method(rt.call_method(var_d4, 'toInt32', []rt.PhpVal{}), 'mask', [
			rt.new_int(67108863),
		])
		var_h0 = rt.call_method(var_h0, 'addInt32', [
			rt.call_method(rt.call_method(var_c, 'toInt32', []rt.PhpVal{}), 'mulInt', [
				rt.new_int(5),
				rt.new_int(3),
			]),
		])
		var_c = rt.call_method(var_h0, 'shiftRight', [rt.new_int(26)])
		var_h0 = rt.call_method(var_h0, 'mask', [rt.new_int(67108863)])
		var_h1 = rt.call_method(var_h1, 'addInt32', [var_c.clone()])
		mut iife_temp_41 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
		mut iife_result_41 := iife_temp_41.substr(var_message_mutated.clone(),
			Class_ParagonIE_Sodium_Core32_Poly1305.block_size())
		var_message_mutated = iife_result_41
		var_bytes_mutated = rt.sub(var_bytes_mutated,
			Class_ParagonIE_Sodium_Core32_Poly1305.block_size())
	}
	this.h = rt.create_array([rt.ArrayItem{ key: none, val: var_h0 },
		rt.ArrayItem{ key: none, val: var_h1 }, rt.ArrayItem{ key: none, val: var_h2 },
		rt.ArrayItem{ key: none, val: var_h3 }, rt.ArrayItem{ key: none, val: var_h4 }])
	return rt.new_object('ParagonIE_Sodium_Core32_Poly1305_State', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305_State) finish() string {
	if rt.is_true(this.leftover) {
		mut var_i := this.leftover
		this.buffer.array_set(rt.post_inc(var_i), 1)
		for {
			if !(rt.is_true(rt.less(var_i, Class_ParagonIE_Sodium_Core32_Poly1305.block_size()))) { break
			 }
			this.buffer.array_set(var_i, 0)
			rt.pre_inc(var_i)
		}
		this.final = true
		mut iife_temp_42 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
		mut iife_result_42 := iife_temp_42.intarraytostring(this.buffer)
		mut iife_temp_43 := Class_ParagonIE_Sodium_Core32_Poly1305_State{}
		mut iife_result_43 := iife_temp_43.substr(iife_result_42, rt.new_int(0),
			Class_ParagonIE_Sodium_Core32_Poly1305.block_size())
		mut var_b := Class_ParagonIE_Sodium_Core32_Poly1305.block_size()
		this.blocks(iife_result_43, var_b)
	}
	mut var_h0 := this.h.array_get(rt.new_int(0))
	mut var_h1 := this.h.array_get(rt.new_int(1))
	mut var_h2 := this.h.array_get(rt.new_int(2))
	mut var_h3 := this.h.array_get(rt.new_int(3))
	mut var_h4 := this.h.array_get(rt.new_int(4))
	mut var_c := rt.call_method(var_h1, 'shiftRight', [rt.new_int(26)])
	var_h1 = rt.call_method(var_h1, 'mask', [rt.new_int(67108863)])
	var_h2 = rt.call_method(var_h2, 'addInt32', [var_c.clone()])
	var_c = rt.call_method(var_h2, 'shiftRight', [rt.new_int(26)])
	var_h2 = rt.call_method(var_h2, 'mask', [rt.new_int(67108863)])
	var_h3 = rt.call_method(var_h3, 'addInt32', [var_c.clone()])
	var_c = rt.call_method(var_h3, 'shiftRight', [rt.new_int(26)])
	var_h3 = rt.call_method(var_h3, 'mask', [rt.new_int(67108863)])
	var_h4 = rt.call_method(var_h4, 'addInt32', [var_c.clone()])
	var_c = rt.call_method(var_h4, 'shiftRight', [rt.new_int(26)])
	var_h4 = rt.call_method(var_h4, 'mask', [rt.new_int(67108863)])
	var_h0 = rt.call_method(var_h0, 'addInt32', [
		rt.call_method(var_c, 'mulInt', [rt.new_int(5), rt.new_int(3)]),
	])
	var_c = rt.call_method(var_h0, 'shiftRight', [rt.new_int(26)])
	var_h0 = rt.call_method(var_h0, 'mask', [rt.new_int(67108863)])
	var_h1 = rt.call_method(var_h1, 'addInt32', [var_c.clone()])
	mut var_g0 := rt.call_method(var_h0, 'addInt', [rt.new_int(5)])
	var_c = rt.call_method(var_g0, 'shiftRight', [rt.new_int(26)])
	var_g0 = rt.call_method(var_g0, 'mask', [rt.new_int(67108863)])
	mut var_g1 := rt.call_method(var_h1, 'addInt32', [var_c.clone()])
	var_c = rt.call_method(var_g1, 'shiftRight', [rt.new_int(26)])
	var_g1 = rt.call_method(var_g1, 'mask', [rt.new_int(67108863)])
	mut var_g2 := rt.call_method(var_h2, 'addInt32', [var_c.clone()])
	var_c = rt.call_method(var_g2, 'shiftRight', [rt.new_int(26)])
	var_g2 = rt.call_method(var_g2, 'mask', [rt.new_int(67108863)])
	mut var_g3 := rt.call_method(var_h3, 'addInt32', [var_c.clone()])
	var_c = rt.call_method(var_g3, 'shiftRight', [rt.new_int(26)])
	var_g3 = rt.call_method(var_g3, 'mask', [rt.new_int(67108863)])
	mut var_g4 := rt.call_method(rt.call_method(var_h4, 'addInt32', [
		var_c.clone()]), 'subInt', [rt.new_int(1 << 26)])
	mut var_mask := rt.new_int(
		rt.shift_right(rt.call_method(var_g4, 'toInt', []rt.PhpVal{}), rt.new_int(31)) + 1)
	var_g0 = rt.call_method(var_g0, 'mask', [var_mask.clone()])
	var_g1 = rt.call_method(var_g1, 'mask', [var_mask.clone()])
	var_g2 = rt.call_method(var_g2, 'mask', [var_mask.clone()])
	var_g3 = rt.call_method(var_g3, 'mask', [var_mask.clone()])
	var_g4 = rt.call_method(var_g4, 'mask', [var_mask.clone()])
	var_mask = rt.new_int(rt.bitwise_not(var_mask))
	var_h0 = rt.call_method(rt.call_method(var_h0, 'mask', [var_mask.clone()]), 'orInt32', [
		var_g0.clone(),
	])
	var_h1 = rt.call_method(rt.call_method(var_h1, 'mask', [var_mask.clone()]), 'orInt32', [
		var_g1.clone(),
	])
	var_h2 = rt.call_method(rt.call_method(var_h2, 'mask', [var_mask.clone()]), 'orInt32', [
		var_g2.clone(),
	])
	var_h3 = rt.call_method(rt.call_method(var_h3, 'mask', [var_mask.clone()]), 'orInt32', [
		var_g3.clone(),
	])
	var_h4 = rt.call_method(rt.call_method(var_h4, 'mask', [var_mask.clone()]), 'orInt32', [
		var_g4.clone(),
	])
	var_h0 = rt.call_method(var_h0, 'orInt32', [
		rt.call_method(var_h1, 'shiftLeft', [rt.new_int(26)]),
	])
	var_h1 = rt.call_method(rt.call_method(var_h1, 'shiftRight', [
		rt.new_int(6)]), 'orInt32', [
		rt.call_method(var_h2, 'shiftLeft', [rt.new_int(20)]),
	])
	var_h2 = rt.call_method(rt.call_method(var_h2, 'shiftRight', [
		rt.new_int(12)]), 'orInt32', [
		rt.call_method(var_h3, 'shiftLeft', [rt.new_int(14)]),
	])
	var_h3 = rt.call_method(rt.call_method(var_h3, 'shiftRight', [
		rt.new_int(18)]), 'orInt32', [
		rt.call_method(var_h4, 'shiftLeft', [rt.new_int(8)]),
	])
	mut var_f := rt.call_method(rt.call_method(var_h0, 'toInt64', []rt.PhpVal{}), 'addInt64', [
		this.pad.array_get(rt.new_int(0)),
	])
	var_h0 = rt.call_method(var_f, 'toInt32', []rt.PhpVal{})
	var_f = rt.call_method(rt.call_method(rt.call_method(var_h1, 'toInt64', []rt.PhpVal{}),
		'addInt64', [this.pad.array_get(rt.new_int(1))]), 'addInt', [
		rt.get_property(var_h0, 'overflow'),
	])
	var_h1 = rt.call_method(var_f, 'toInt32', []rt.PhpVal{})
	var_f = rt.call_method(rt.call_method(rt.call_method(var_h2, 'toInt64', []rt.PhpVal{}),
		'addInt64', [this.pad.array_get(rt.new_int(2))]), 'addInt', [
		rt.get_property(var_h1, 'overflow'),
	])
	var_h2 = rt.call_method(var_f, 'toInt32', []rt.PhpVal{})
	var_f = rt.call_method(rt.call_method(rt.call_method(var_h3, 'toInt64', []rt.PhpVal{}),
		'addInt64', [this.pad.array_get(rt.new_int(3))]), 'addInt', [
		rt.get_property(var_h2, 'overflow'),
	])
	var_h3 = rt.call_method(var_f, 'toInt32', []rt.PhpVal{})
	return (rt.call_method(var_h0, 'toReverseString', []rt.PhpVal{})).str() +
		(rt.call_method(var_h1, 'toReverseString', []rt.PhpVal{})).str() +
		(rt.call_method(var_h2, 'toReverseString', []rt.PhpVal{})).str() +
		(rt.call_method(var_h3, 'toReverseString', []rt.PhpVal{})).str()
}

struct Class_ParagonIE_Sodium_Core32_Util {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int32 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int64 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_poly1305_state(key string) &Class_ParagonIE_Sodium_Core32_Poly1305_State {
	mut obj := &Class_ParagonIE_Sodium_Core32_Poly1305_State{
		PhpObjectBase: rt.PhpObjectBase{}
		buffer:        rt.new_array()
		final:         false
		h:             rt.new_null()
		leftover:      rt.new_int(0)
		r:             rt.new_null()
		pad:           rt.new_null()
	}
	obj.construct(key)
	return obj
}

fn create_paragonie_sodium_core32_util(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Util {
	mut obj := &Class_ParagonIE_Sodium_Core32_Util{
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

fn create_paragonie_sodium_core32_int32(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Int32 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Int32{
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

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.update(dispatch_arg_0)
		}
		'blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.blocks(dispatch_arg_0, dispatch_arg_1)
		}
		'finish' {
			return rt.new_string(this.finish())
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_Poly1305_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'buffer' { return this.buffer }
		'final' { return rt.new_bool(this.final) }
		'h' { return this.h }
		'leftover' { return this.leftover }
		'r' { return this.r }
		'pad' { return this.pad }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'buffer' {
			this.buffer = val
			return true
		}
		'final' {
			this.final = val.to_bool()
			return true
		}
		'h' {
			this.h = val
			return true
		}
		'leftover' {
			this.leftover = val
			return true
		}
		'r' {
			this.r = val
			return true
		}
		'pad' {
			this.pad = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core32_Poly1305_State'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
