import rt

struct Class_ParagonIE_Sodium_Core_Poly1305_State {
	rt.PhpObjectBase
pub mut:
	buffer   rt.PhpVal = rt.new_array()
	final    bool
	h        rt.PhpVal = rt.new_null()
	leftover rt.PhpVal = rt.new_int(0)
	r        rt.PhpVal = rt.new_null()
	pad      rt.PhpVal = rt.new_null()
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) construct(key string) {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_0 := iife_temp_0.strlen(rt.new_string(key))
	if rt.is_true(rt.less(iife_result_0, rt.new_int(32))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
			create_invalidargumentexception(rt.new_string('Poly1305 requires a 32-byte key'))))
	}
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_1 := iife_temp_1.substr(rt.new_string(key), rt.new_int(0), rt.new_int(4))
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_2 := iife_temp_2.load_4(iife_result_1)
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_3 := iife_temp_3.substr(rt.new_string(key), rt.new_int(3), rt.new_int(4))
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_4 := iife_temp_4.load_4(iife_result_3)
	mut iife_temp_5 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_5 := iife_temp_5.substr(rt.new_string(key), rt.new_int(6), rt.new_int(4))
	mut iife_temp_6 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_6 := iife_temp_6.load_4(iife_result_5)
	mut iife_temp_7 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_7 := iife_temp_7.substr(rt.new_string(key), rt.new_int(9), rt.new_int(4))
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_8 := iife_temp_8.load_4(iife_result_7)
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_9 := iife_temp_9.substr(rt.new_string(key), rt.new_int(12), rt.new_int(4))
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_10 := iife_temp_10.load_4(iife_result_9)
	this.r = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.bitwise_and(iife_result_2, rt.new_int(67108863)) },
		rt.ArrayItem{ key: none, val: rt.shift_right(iife_result_4, rt.new_int(2)) & 67108611 },
		rt.ArrayItem{ key: none, val: rt.shift_right(iife_result_6, rt.new_int(4)) & 67092735 },
		rt.ArrayItem{ key: none, val: rt.shift_right(iife_result_8, rt.new_int(6)) & 66076671 },
		rt.ArrayItem{ key: none, val: rt.shift_right(iife_result_10, rt.new_int(8)) & 1048575 },
	])
	this.h = rt.create_array([rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 0 }])
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_11 := iife_temp_11.substr(rt.new_string(key), rt.new_int(16), rt.new_int(4))
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_12 := iife_temp_12.load_4(iife_result_11)
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_13 := iife_temp_13.substr(rt.new_string(key), rt.new_int(20), rt.new_int(4))
	mut iife_temp_14 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_14 := iife_temp_14.load_4(iife_result_13)
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_15 := iife_temp_15.substr(rt.new_string(key), rt.new_int(24), rt.new_int(4))
	mut iife_temp_16 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_16 := iife_temp_16.load_4(iife_result_15)
	mut iife_temp_17 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_17 := iife_temp_17.substr(rt.new_string(key), rt.new_int(28), rt.new_int(4))
	mut iife_temp_18 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_18 := iife_temp_18.load_4(iife_result_17)
	this.pad = rt.create_array([rt.ArrayItem{ key: none, val: iife_result_12 },
		rt.ArrayItem{ key: none, val: iife_result_14 }, rt.ArrayItem{ key: none, val: iife_result_16 },
		rt.ArrayItem{ key: none, val: iife_result_18 }])
	this.leftover = rt.new_int(0)
	this.final = false
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) magic_destruct() {
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
	this.leftover = rt.new_int(0)
	this.final = true
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) update(message string) rt.PhpVal {
	mut message_mutated := message
	mut iife_temp_19 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_19 := iife_temp_19.strlen(rt.new_string(message_mutated))
	mut var_bytes := iife_result_19
	if rt.is_true(rt.less(var_bytes, rt.new_int(1))) {
		return rt.new_object('ParagonIE_Sodium_Core_Poly1305_State', []string{}, this)
	}
	if rt.is_true(this.leftover) {
		mut var_want := rt.sub(Class_ParagonIE_Sodium_Core_Poly1305.block_size(), this.leftover)
		if rt.is_true(rt.greater(var_want, var_bytes)) {
			var_want = var_bytes.clone()
		}
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, var_want))) { break
			 }
			mut iife_temp_20 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
			mut iife_result_20 :=
				iife_temp_20.chrtoint(rt.new_string(message_mutated).array_get(var_i))
			mut var_mi := iife_result_20
			this.buffer.array_set(rt.add(this.leftover, var_i), var_mi.clone())
			rt.pre_inc(var_i)
		}
		mut iife_temp_21 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_21 := iife_temp_21.substr(rt.new_string(message_mutated), var_want.clone())
		message_mutated = iife_result_21.str()
		mut iife_temp_22 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_22 := iife_temp_22.strlen(rt.new_string(message_mutated))
		var_bytes = iife_result_22
		this.leftover = rt.add(this.leftover, var_want)
		if rt.is_true(rt.less(this.leftover, Class_ParagonIE_Sodium_Core_Poly1305.block_size())) {
			return rt.new_object('ParagonIE_Sodium_Core_Poly1305_State', []string{}, this)
		}
		mut iife_temp_23 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_23 := iife_temp_23.intarraytostring(this.buffer)
		this.blocks(iife_result_23, Class_ParagonIE_Sodium_Core_Poly1305.block_size())
		this.leftover = rt.new_int(0)
	}
	if rt.is_true(rt.greater_equal(var_bytes, Class_ParagonIE_Sodium_Core_Poly1305.block_size())) {
		var_want = rt.new_int(rt.bitwise_and(var_bytes, rt.bitwise_not(rt.sub(Class_ParagonIE_Sodium_Core_Poly1305.block_size(),
			rt.new_int(1)))))
		if rt.is_true(rt.greater_equal(var_want, Class_ParagonIE_Sodium_Core_Poly1305.block_size())) {
			mut iife_temp_24 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
			mut iife_result_24 := iife_temp_24.substr(rt.new_string(message_mutated),
				rt.new_int(0), var_want.clone())
			mut var_block := iife_result_24
			mut iife_temp_25 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
			mut iife_result_25 := iife_temp_25.strlen(var_block.clone())
			if rt.is_true(rt.greater_equal(iife_result_25,
				Class_ParagonIE_Sodium_Core_Poly1305.block_size()))
			{
				this.blocks(var_block.clone(), var_want.clone())
				mut iife_temp_26 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
				mut iife_result_26 := iife_temp_26.substr(rt.new_string(message_mutated),
					var_want.clone())
				message_mutated = iife_result_26.str()
				mut iife_temp_27 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
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
			mut iife_temp_28 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
			mut iife_result_28 :=
				iife_temp_28.chrtoint(rt.new_string(message_mutated).array_get(var_i))
			mut var_mi := iife_result_28
			this.buffer.array_set(rt.add(this.leftover, var_i), var_mi.clone())
			rt.pre_inc(var_i)
		}
		this.leftover = rt.add(rt.new_int((this.leftover).to_i64()), var_bytes)
	}
	return rt.new_object('ParagonIE_Sodium_Core_Poly1305_State', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) blocks(var_message rt.PhpVal, var_bytes rt.PhpVal) rt.PhpVal {
	mut var_message_mutated := var_message
	mut var_bytes_mutated := var_bytes
	mut iife_temp_29 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_29 := iife_temp_29.strlen(var_message_mutated.clone())
	if rt.is_true(rt.less(iife_result_29, rt.new_int(16))) {
		var_message_mutated = rt.call_function('str_pad', [var_message_mutated.clone(),
			rt.new_int(16), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
	}
	mut var_hibit := rt.new_int(if this.final { 0 } else { 1 << 24 })
	mut var_r0 := rt.new_int((this.r.array_get(rt.new_int(0))).to_i64())
	mut var_r1 := rt.new_int((this.r.array_get(rt.new_int(1))).to_i64())
	mut var_r2 := rt.new_int((this.r.array_get(rt.new_int(2))).to_i64())
	mut var_r3 := rt.new_int((this.r.array_get(rt.new_int(3))).to_i64())
	mut var_r4 := rt.new_int((this.r.array_get(rt.new_int(4))).to_i64())
	mut iife_temp_30 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_30 := iife_temp_30.mul(var_r1.clone(), rt.new_int(5), rt.new_int(3))
	mut var_s1 := iife_result_30
	mut iife_temp_31 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_31 := iife_temp_31.mul(var_r2.clone(), rt.new_int(5), rt.new_int(3))
	mut var_s2 := iife_result_31
	mut iife_temp_32 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_32 := iife_temp_32.mul(var_r3.clone(), rt.new_int(5), rt.new_int(3))
	mut var_s3 := iife_result_32
	mut iife_temp_33 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_33 := iife_temp_33.mul(var_r4.clone(), rt.new_int(5), rt.new_int(3))
	mut var_s4 := iife_result_33
	mut var_h0 := this.h.array_get(rt.new_int(0))
	mut var_h1 := this.h.array_get(rt.new_int(1))
	mut var_h2 := this.h.array_get(rt.new_int(2))
	mut var_h3 := this.h.array_get(rt.new_int(3))
	mut var_h4 := this.h.array_get(rt.new_int(4))
	for rt.is_true(rt.greater_equal(var_bytes_mutated,
		Class_ParagonIE_Sodium_Core_Poly1305.block_size())) {
		mut iife_temp_34 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_34 := iife_temp_34.substr(var_message_mutated.clone(), rt.new_int(0),
			rt.new_int(4))
		mut iife_temp_35 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_35 := iife_temp_35.load_4(iife_result_34)
		var_h0 = rt.add(var_h0, rt.bitwise_and(iife_result_35, rt.new_int(67108863)))
		mut iife_temp_36 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_36 := iife_temp_36.substr(var_message_mutated.clone(), rt.new_int(3),
			rt.new_int(4))
		mut iife_temp_37 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_37 := iife_temp_37.load_4(iife_result_36)
		var_h1 = rt.add(var_h1, rt.shift_right(iife_result_37, rt.new_int(2)) & 67108863)
		mut iife_temp_38 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_38 := iife_temp_38.substr(var_message_mutated.clone(), rt.new_int(6),
			rt.new_int(4))
		mut iife_temp_39 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_39 := iife_temp_39.load_4(iife_result_38)
		var_h2 = rt.add(var_h2, rt.shift_right(iife_result_39, rt.new_int(4)) & 67108863)
		mut iife_temp_40 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_40 := iife_temp_40.substr(var_message_mutated.clone(), rt.new_int(9),
			rt.new_int(4))
		mut iife_temp_41 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_41 := iife_temp_41.load_4(iife_result_40)
		var_h3 = rt.add(var_h3, rt.shift_right(iife_result_41, rt.new_int(6)) & 67108863)
		mut iife_temp_42 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_42 := iife_temp_42.substr(var_message_mutated.clone(), rt.new_int(12),
			rt.new_int(4))
		mut iife_temp_43 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_43 := iife_temp_43.load_4(iife_result_42)
		var_h4 = rt.add(var_h4, rt.bitwise_or(rt.shift_right(iife_result_43, rt.new_int(8)),
			var_hibit))
		mut iife_temp_44 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_44 := iife_temp_44.mul(var_h0.clone(), var_r0.clone(), rt.new_int(27))
		mut iife_temp_45 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_45 := iife_temp_45.mul(var_s4.clone(), var_h1.clone(), rt.new_int(27))
		mut iife_temp_46 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_46 := iife_temp_46.mul(var_s3.clone(), var_h2.clone(), rt.new_int(27))
		mut iife_temp_47 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_47 := iife_temp_47.mul(var_s2.clone(), var_h3.clone(), rt.new_int(27))
		mut iife_temp_48 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_48 := iife_temp_48.mul(var_s1.clone(), var_h4.clone(), rt.new_int(27))
		mut var_d0 := rt.add(rt.add(rt.add(rt.add(iife_result_44, iife_result_45), iife_result_46),
			iife_result_47), iife_result_48)
		mut iife_temp_49 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_49 := iife_temp_49.mul(var_h0.clone(), var_r1.clone(), rt.new_int(27))
		mut iife_temp_50 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_50 := iife_temp_50.mul(var_h1.clone(), var_r0.clone(), rt.new_int(27))
		mut iife_temp_51 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_51 := iife_temp_51.mul(var_s4.clone(), var_h2.clone(), rt.new_int(27))
		mut iife_temp_52 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_52 := iife_temp_52.mul(var_s3.clone(), var_h3.clone(), rt.new_int(27))
		mut iife_temp_53 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_53 := iife_temp_53.mul(var_s2.clone(), var_h4.clone(), rt.new_int(27))
		mut var_d1 := rt.add(rt.add(rt.add(rt.add(iife_result_49, iife_result_50), iife_result_51),
			iife_result_52), iife_result_53)
		mut iife_temp_54 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_54 := iife_temp_54.mul(var_h0.clone(), var_r2.clone(), rt.new_int(27))
		mut iife_temp_55 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_55 := iife_temp_55.mul(var_h1.clone(), var_r1.clone(), rt.new_int(27))
		mut iife_temp_56 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_56 := iife_temp_56.mul(var_h2.clone(), var_r0.clone(), rt.new_int(27))
		mut iife_temp_57 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_57 := iife_temp_57.mul(var_s4.clone(), var_h3.clone(), rt.new_int(27))
		mut iife_temp_58 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_58 := iife_temp_58.mul(var_s3.clone(), var_h4.clone(), rt.new_int(27))
		mut var_d2 := rt.add(rt.add(rt.add(rt.add(iife_result_54, iife_result_55), iife_result_56),
			iife_result_57), iife_result_58)
		mut iife_temp_59 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_59 := iife_temp_59.mul(var_h0.clone(), var_r3.clone(), rt.new_int(27))
		mut iife_temp_60 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_60 := iife_temp_60.mul(var_h1.clone(), var_r2.clone(), rt.new_int(27))
		mut iife_temp_61 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_61 := iife_temp_61.mul(var_h2.clone(), var_r1.clone(), rt.new_int(27))
		mut iife_temp_62 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_62 := iife_temp_62.mul(var_h3.clone(), var_r0.clone(), rt.new_int(27))
		mut iife_temp_63 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_63 := iife_temp_63.mul(var_s4.clone(), var_h4.clone(), rt.new_int(27))
		mut var_d3 := rt.add(rt.add(rt.add(rt.add(iife_result_59, iife_result_60), iife_result_61),
			iife_result_62), iife_result_63)
		mut iife_temp_64 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_64 := iife_temp_64.mul(var_h0.clone(), var_r4.clone(), rt.new_int(27))
		mut iife_temp_65 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_65 := iife_temp_65.mul(var_h1.clone(), var_r3.clone(), rt.new_int(27))
		mut iife_temp_66 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_66 := iife_temp_66.mul(var_h2.clone(), var_r2.clone(), rt.new_int(27))
		mut iife_temp_67 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_67 := iife_temp_67.mul(var_h3.clone(), var_r1.clone(), rt.new_int(27))
		mut iife_temp_68 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_68 := iife_temp_68.mul(var_h4.clone(), var_r0.clone(), rt.new_int(27))
		mut var_d4 := rt.add(rt.add(rt.add(rt.add(iife_result_64, iife_result_65), iife_result_66),
			iife_result_67), iife_result_68)
		mut var_c := rt.new_int(rt.shift_right(var_d0, rt.new_int(26)))
		var_h0 = rt.new_int(rt.bitwise_and(var_d0, rt.new_int(67108863)))
		var_d1 = rt.add(var_d1, var_c)
		var_c = rt.new_int(rt.shift_right(var_d1, rt.new_int(26)))
		var_h1 = rt.new_int(rt.bitwise_and(var_d1, rt.new_int(67108863)))
		var_d2 = rt.add(var_d2, var_c)
		var_c = rt.new_int(rt.shift_right(var_d2, rt.new_int(26)))
		var_h2 = rt.new_int(rt.bitwise_and(var_d2, rt.new_int(67108863)))
		var_d3 = rt.add(var_d3, var_c)
		var_c = rt.new_int(rt.shift_right(var_d3, rt.new_int(26)))
		var_h3 = rt.new_int(rt.bitwise_and(var_d3, rt.new_int(67108863)))
		var_d4 = rt.add(var_d4, var_c)
		var_c = rt.new_int(rt.shift_right(var_d4, rt.new_int(26)))
		var_h4 = rt.new_int(rt.bitwise_and(var_d4, rt.new_int(67108863)))
		mut iife_temp_69 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_69 := iife_temp_69.mul(var_c.clone(), rt.new_int(5), rt.new_int(3))
		var_h0 = rt.add(var_h0, rt.new_int(iife_result_69.to_i64()))
		var_c = rt.new_int(rt.shift_right(var_h0, rt.new_int(26)))
		rt.new_null()
		var_h1 = rt.add(var_h1, var_c)
		mut iife_temp_70 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_70 := iife_temp_70.substr(var_message_mutated.clone(),
			Class_ParagonIE_Sodium_Core_Poly1305.block_size())
		var_message_mutated = iife_result_70
		var_bytes_mutated = rt.sub(var_bytes_mutated,
			Class_ParagonIE_Sodium_Core_Poly1305.block_size())
	}
	this.h = rt.create_array([
		rt.ArrayItem{ key: none, val: rt.bitwise_and(var_h0, rt.new_int(4294967295)) },
		rt.ArrayItem{ key: none, val: rt.bitwise_and(var_h1, rt.new_int(4294967295)) },
		rt.ArrayItem{ key: none, val: rt.bitwise_and(var_h2, rt.new_int(4294967295)) },
		rt.ArrayItem{ key: none, val: rt.bitwise_and(var_h3, rt.new_int(4294967295)) },
		rt.ArrayItem{ key: none, val: rt.bitwise_and(var_h4, rt.new_int(4294967295)) },
	])
	return rt.new_object('ParagonIE_Sodium_Core_Poly1305_State', []string{}, this)
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) finish() string {
	if rt.is_true(this.leftover) {
		mut var_i := this.leftover
		this.buffer.array_set(rt.post_inc(var_i), 1)
		for {
			if !(rt.is_true(rt.less(var_i, Class_ParagonIE_Sodium_Core_Poly1305.block_size()))) { break
			 }
			this.buffer.array_set(var_i, 0)
			rt.pre_inc(var_i)
		}
		this.final = true
		mut iife_temp_71 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_71 := iife_temp_71.intarraytostring(this.buffer)
		mut iife_temp_72 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
		mut iife_result_72 := iife_temp_72.substr(iife_result_71, rt.new_int(0),
			Class_ParagonIE_Sodium_Core_Poly1305.block_size())
		this.blocks(iife_result_72, Class_ParagonIE_Sodium_Core_Poly1305.block_size())
	}
	mut var_h0 := rt.new_int((this.h.array_get(rt.new_int(0))).to_i64())
	mut var_h1 := rt.new_int((this.h.array_get(rt.new_int(1))).to_i64())
	mut var_h2 := rt.new_int((this.h.array_get(rt.new_int(2))).to_i64())
	mut var_h3 := rt.new_int((this.h.array_get(rt.new_int(3))).to_i64())
	mut var_h4 := rt.new_int((this.h.array_get(rt.new_int(4))).to_i64())
	mut var_c := rt.new_int(rt.shift_right(var_h1, rt.new_int(26)))
	rt.new_null()
	var_h2 = rt.add(var_h2, var_c)
	var_c = rt.new_int(rt.shift_right(var_h2, rt.new_int(26)))
	rt.new_null()
	var_h3 = rt.add(var_h3, var_c)
	var_c = rt.new_int(rt.shift_right(var_h3, rt.new_int(26)))
	rt.new_null()
	var_h4 = rt.add(var_h4, var_c)
	var_c = rt.new_int(rt.shift_right(var_h4, rt.new_int(26)))
	rt.new_null()
	mut iife_temp_73 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_73 := iife_temp_73.mul(var_c.clone(), rt.new_int(5), rt.new_int(3))
	var_h0 = rt.add(var_h0, iife_result_73)
	var_c = rt.new_int(rt.shift_right(var_h0, rt.new_int(26)))
	rt.new_null()
	var_h1 = rt.add(var_h1, var_c)
	mut var_g0 := rt.add(var_h0, rt.new_int(5))
	var_c = rt.new_int(rt.shift_right(var_g0, rt.new_int(26)))
	rt.new_null()
	mut var_g1 := rt.add(var_h1, var_c)
	var_c = rt.new_int(rt.shift_right(var_g1, rt.new_int(26)))
	rt.new_null()
	mut var_g2 := rt.add(var_h2, var_c)
	var_c = rt.new_int(rt.shift_right(var_g2, rt.new_int(26)))
	rt.new_null()
	mut var_g3 := rt.add(var_h3, var_c)
	var_c = rt.new_int(rt.shift_right(var_g3, rt.new_int(26)))
	rt.new_null()
	mut var_g4 := rt.new_int(rt.bitwise_and(rt.sub(rt.add(var_h4, var_c), 1 << 26),
		rt.new_int(4294967295)))
	mut var_mask := rt.new_int(rt.shift_right(var_g4, rt.new_int(31)) - 1)
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	var_mask = rt.new_int(rt.bitwise_not(var_mask) & 4294967295)
	var_h0 = rt.new_int(rt.bitwise_or(rt.bitwise_and(var_h0, var_mask), var_g0))
	var_h1 = rt.new_int(rt.bitwise_or(rt.bitwise_and(var_h1, var_mask), var_g1))
	var_h2 = rt.new_int(rt.bitwise_or(rt.bitwise_and(var_h2, var_mask), var_g2))
	var_h3 = rt.new_int(rt.bitwise_or(rt.bitwise_and(var_h3, var_mask), var_g3))
	var_h4 = rt.new_int(rt.bitwise_or(rt.bitwise_and(var_h4, var_mask), var_g4))
	var_h0 = rt.new_int(rt.bitwise_or(var_h0, rt.shift_left(var_h1, rt.new_int(26))) & 4294967295)
	var_h1 = rt.new_int(rt.shift_right(var_h1, rt.new_int(6)) | rt.shift_left(var_h2,
		rt.new_int(20)) & 4294967295)
	var_h2 = rt.new_int(rt.shift_right(var_h2, rt.new_int(12)) | rt.shift_left(var_h3,
		rt.new_int(14)) & 4294967295)
	var_h3 = rt.new_int(rt.shift_right(var_h3, rt.new_int(18)) | rt.shift_left(var_h4,
		rt.new_int(8)) & 4294967295)
	mut var_f := rt.new_int((rt.add(var_h0, this.pad.array_get(rt.new_int(0)))).to_i64())
	var_h0 = rt.new_int(var_f.to_i64())
	var_f = rt.new_int((rt.add(rt.add(var_h1, this.pad.array_get(rt.new_int(1))), rt.shift_right(var_f,
		rt.new_int(32)))).to_i64())
	var_h1 = rt.new_int(var_f.to_i64())
	var_f = rt.new_int((rt.add(rt.add(var_h2, this.pad.array_get(rt.new_int(2))), rt.shift_right(var_f,
		rt.new_int(32)))).to_i64())
	var_h2 = rt.new_int(var_f.to_i64())
	var_f = rt.new_int((rt.add(rt.add(var_h3, this.pad.array_get(rt.new_int(3))), rt.shift_right(var_f,
		rt.new_int(32)))).to_i64())
	var_h3 = rt.new_int(var_f.to_i64())
	mut iife_temp_74 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_74 := iife_temp_74.store32_le(rt.new_int(rt.bitwise_and(var_h0,
		rt.new_int(4294967295))))
	mut iife_temp_75 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_75 := iife_temp_75.store32_le(rt.new_int(rt.bitwise_and(var_h1,
		rt.new_int(4294967295))))
	mut iife_temp_76 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_76 := iife_temp_76.store32_le(rt.new_int(rt.bitwise_and(var_h2,
		rt.new_int(4294967295))))
	mut iife_temp_77 := Class_ParagonIE_Sodium_Core_Poly1305_State{}
	mut iife_result_77 := iife_temp_77.store32_le(rt.new_int(rt.bitwise_and(var_h3,
		rt.new_int(4294967295))))
	return iife_result_74.str() + iife_result_75.str() + iife_result_76.str() + iife_result_77.str()
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_poly1305_state(key string) &Class_ParagonIE_Sodium_Core_Poly1305_State {
	mut obj := &Class_ParagonIE_Sodium_Core_Poly1305_State{
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

fn create_paragonie_sodium_core_util(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
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

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'__destruct' {
			this.magic_destruct()
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

fn (this &Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
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

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_ParagonIE_Sodium_Core_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_Poly1305_State'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
