import rt

struct Class_ParagonIE_Sodium_Core_SipHash {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_SipHash.sipround(mut var_v Class_array) rt.PhpVal {
	mut var_v_mutated := var_v
	mut list_tmp_1 := Class_ParagonIE_Sodium_Core_SipHash.add(mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: none, val: var_v_mutated.array_get(rt.new_int(0)) },
		rt.ArrayItem{ key: none, val: var_v_mutated.array_get(rt.new_int(1)) },
	])), mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: none, val: var_v_mutated.array_get(rt.new_int(2)) },
		rt.ArrayItem{ key: none, val: var_v_mutated.array_get(rt.new_int(3)) },
	])))
	var_v_mutated.array_get_mut(0) = list_tmp_1.array_get(0)
	var_v_mutated.array_get_mut(1) = list_tmp_1.array_get(1)
	mut list_tmp_2 := Class_ParagonIE_Sodium_Core_SipHash.rotl_64(rt.new_int((var_v_mutated.array_get(rt.new_int(2))).to_i64()),
		rt.new_int((var_v_mutated.array_get(rt.new_int(3))).to_i64()), rt.new_int(13))
	var_v_mutated.array_get_mut(2) = list_tmp_2.array_get(0)
	var_v_mutated.array_get_mut(3) = list_tmp_2.array_get(1)
	var_v_mutated.array_set(2,
		rt.new_int((var_v_mutated.array_get(rt.new_int(2))).to_i64()) ^ rt.new_int((var_v_mutated.array_get(rt.new_int(0))).to_i64()))
	var_v_mutated.array_set(3,
		rt.new_int((var_v_mutated.array_get(rt.new_int(3))).to_i64()) ^ rt.new_int((var_v_mutated.array_get(rt.new_int(1))).to_i64()))
	mut list_tmp_3 := Class_ParagonIE_Sodium_Core_SipHash.rotl_64(rt.new_int((var_v_mutated.array_get(rt.new_int(0))).to_i64()),
		rt.new_int((var_v_mutated.array_get(rt.new_int(1))).to_i64()), rt.new_int(32))
	var_v_mutated.array_get_mut(0) = list_tmp_3.array_get(0)
	var_v_mutated.array_get_mut(1) = list_tmp_3.array_get(1)
	mut list_tmp_4 := Class_ParagonIE_Sodium_Core_SipHash.add(mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_int((var_v_mutated.array_get(rt.new_int(4))).to_i64()) },
		rt.ArrayItem{ key: none, val: rt.new_int((var_v_mutated.array_get(rt.new_int(5))).to_i64()) },
	])), mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_int((var_v_mutated.array_get(rt.new_int(6))).to_i64()) },
		rt.ArrayItem{ key: none, val: rt.new_int((var_v_mutated.array_get(rt.new_int(7))).to_i64()) },
	])))
	var_v_mutated.array_get_mut(4) = list_tmp_4.array_get(0)
	var_v_mutated.array_get_mut(5) = list_tmp_4.array_get(1)
	mut list_tmp_5 := Class_ParagonIE_Sodium_Core_SipHash.rotl_64(rt.new_int((var_v_mutated.array_get(rt.new_int(6))).to_i64()),
		rt.new_int((var_v_mutated.array_get(rt.new_int(7))).to_i64()), rt.new_int(16))
	var_v_mutated.array_get_mut(6) = list_tmp_5.array_get(0)
	var_v_mutated.array_get_mut(7) = list_tmp_5.array_get(1)
	var_v_mutated.array_set(6,
		rt.new_int((var_v_mutated.array_get(rt.new_int(6))).to_i64()) ^ rt.new_int((var_v_mutated.array_get(rt.new_int(4))).to_i64()))
	var_v_mutated.array_set(7,
		rt.new_int((var_v_mutated.array_get(rt.new_int(7))).to_i64()) ^ rt.new_int((var_v_mutated.array_get(rt.new_int(5))).to_i64()))
	mut list_tmp_6 := Class_ParagonIE_Sodium_Core_SipHash.add(mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_int((var_v_mutated.array_get(rt.new_int(0))).to_i64()) },
		rt.ArrayItem{ key: none, val: rt.new_int((var_v_mutated.array_get(rt.new_int(1))).to_i64()) },
	])), mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_int((var_v_mutated.array_get(rt.new_int(6))).to_i64()) },
		rt.ArrayItem{ key: none, val: rt.new_int((var_v_mutated.array_get(rt.new_int(7))).to_i64()) },
	])))
	var_v_mutated.array_get_mut(0) = list_tmp_6.array_get(0)
	var_v_mutated.array_get_mut(1) = list_tmp_6.array_get(1)
	mut list_tmp_7 := Class_ParagonIE_Sodium_Core_SipHash.rotl_64(rt.new_int((var_v_mutated.array_get(rt.new_int(6))).to_i64()),
		rt.new_int((var_v_mutated.array_get(rt.new_int(7))).to_i64()), rt.new_int(21))
	var_v_mutated.array_get_mut(6) = list_tmp_7.array_get(0)
	var_v_mutated.array_get_mut(7) = list_tmp_7.array_get(1)
	var_v_mutated.array_set(6,
		rt.new_int((var_v_mutated.array_get(rt.new_int(6))).to_i64()) ^ rt.new_int((var_v_mutated.array_get(rt.new_int(0))).to_i64()))
	var_v_mutated.array_set(7,
		rt.new_int((var_v_mutated.array_get(rt.new_int(7))).to_i64()) ^ rt.new_int((var_v_mutated.array_get(rt.new_int(1))).to_i64()))
	mut list_tmp_8 := Class_ParagonIE_Sodium_Core_SipHash.add(mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_int((var_v_mutated.array_get(rt.new_int(4))).to_i64()) },
		rt.ArrayItem{ key: none, val: rt.new_int((var_v_mutated.array_get(rt.new_int(5))).to_i64()) },
	])), mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_int((var_v_mutated.array_get(rt.new_int(2))).to_i64()) },
		rt.ArrayItem{ key: none, val: rt.new_int((var_v_mutated.array_get(rt.new_int(3))).to_i64()) },
	])))
	var_v_mutated.array_get_mut(4) = list_tmp_8.array_get(0)
	var_v_mutated.array_get_mut(5) = list_tmp_8.array_get(1)
	mut list_tmp_9 := Class_ParagonIE_Sodium_Core_SipHash.rotl_64(rt.new_int((var_v_mutated.array_get(rt.new_int(2))).to_i64()),
		rt.new_int((var_v_mutated.array_get(rt.new_int(3))).to_i64()), rt.new_int(17))
	var_v_mutated.array_get_mut(2) = list_tmp_9.array_get(0)
	var_v_mutated.array_get_mut(3) = list_tmp_9.array_get(1)
	var_v_mutated.array_set(2,
		rt.new_int((var_v_mutated.array_get(rt.new_int(2))).to_i64()) ^ rt.new_int((var_v_mutated.array_get(rt.new_int(4))).to_i64()))
	var_v_mutated.array_set(3,
		rt.new_int((var_v_mutated.array_get(rt.new_int(3))).to_i64()) ^ rt.new_int((var_v_mutated.array_get(rt.new_int(5))).to_i64()))
	mut list_tmp_10 := Class_ParagonIE_Sodium_Core_SipHash.rotl_64(rt.new_int((var_v_mutated.array_get(rt.new_int(4))).to_i64()),
		rt.new_int((var_v_mutated.array_get(rt.new_int(5))).to_i64()), rt.new_int(32))
	var_v_mutated.array_get_mut(4) = list_tmp_10.array_get(0)
	var_v_mutated.array_get_mut(5) = list_tmp_10.array_get(1)
	return rt.new_object('array', []string{}, var_v_mutated)
}

fn Class_ParagonIE_Sodium_Core_SipHash.add(mut var_a Class_array, mut var_b Class_array) rt.PhpVal {
	mut var_b_mutated := var_b
	mut var_x1 := rt.add(var_a.array_get(rt.new_int(1)), var_b_mutated.array_get(rt.new_int(1)))
	mut var_c := rt.new_int(rt.shift_right(var_x1, rt.new_int(32)))
	mut var_x0 := rt.add(rt.add(var_a.array_get(rt.new_int(0)),
		var_b_mutated.array_get(rt.new_int(0))), var_c)
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.bitwise_and(var_x0, rt.new_int(4294967295)) },
		rt.ArrayItem{ key: none, val: rt.bitwise_and(var_x1, rt.new_int(4294967295)) },
	])
}

fn Class_ParagonIE_Sodium_Core_SipHash.rotl_64(var_int0 rt.PhpVal, var_int1 rt.PhpVal, var_c rt.PhpVal) rt.PhpVal {
	mut var_int0_mutated := var_int0
	mut var_int1_mutated := var_int1
	mut var_c_mutated := var_c
	rt.new_null()
	rt.new_null()
	rt.new_null()
	if rt.is_true(rt.identical(var_c_mutated, rt.new_int(32))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: var_int1_mutated },
			rt.ArrayItem{ key: none, val: var_int0_mutated }])
	}
	if rt.is_true(rt.greater(var_c_mutated, rt.new_int(31))) {
		mut var_tmp := var_int1_mutated.clone()
		var_int1_mutated = var_int0_mutated.clone()
		var_int0_mutated = var_tmp.clone()
		rt.new_null()
	}
	if rt.is_true(rt.identical(var_c_mutated, rt.new_int(0))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: var_int0_mutated },
			rt.ArrayItem{ key: none, val: var_int1_mutated }])
	}
	return rt.create_array([
		rt.ArrayItem{ key: none, val: 4294967295 & rt.shift_left(var_int0_mutated, var_c_mutated) | rt.shift_right(var_int1_mutated, rt.sub(rt.new_int(32),
			var_c_mutated)) },
		rt.ArrayItem{ key: none, val: 4294967295 & rt.shift_left(var_int1_mutated, var_c_mutated) | rt.shift_right(var_int0_mutated, rt.sub(rt.new_int(32),
			var_c_mutated)) },
	])
}

fn Class_ParagonIE_Sodium_Core_SipHash.siphash24(var_in rt.PhpVal, var_key rt.PhpVal) string {
	mut var_in_mutated := var_in
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core_SipHash{}
	mut iife_result_0 := iife_temp_0.strlen(var_in_mutated.clone())
	mut var_inlen := iife_result_0
	mut var_v := rt.create_array([rt.ArrayItem{ key: none, val: 1936682341 },
		rt.ArrayItem{ key: none, val: 1886610805 }, rt.ArrayItem{ key: none, val: 1685025377 },
		rt.ArrayItem{ key: none, val: 1852075885 }, rt.ArrayItem{ key: none, val: 1819895653 },
		rt.ArrayItem{ key: none, val: 1852142177 }, rt.ArrayItem{ key: none, val: 1952801890 },
		rt.ArrayItem{ key: none, val: 2037671283 }])
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core_SipHash{}
	mut iife_result_1 := iife_temp_1.substr(var_key.clone(), rt.new_int(4), rt.new_int(4))
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core_SipHash{}
	mut iife_result_2 := iife_temp_2.load_4(iife_result_1)
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core_SipHash{}
	mut iife_result_3 := iife_temp_3.substr(var_key.clone(), rt.new_int(0), rt.new_int(4))
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core_SipHash{}
	mut iife_result_4 := iife_temp_4.load_4(iife_result_3)
	mut iife_temp_5 := Class_ParagonIE_Sodium_Core_SipHash{}
	mut iife_result_5 := iife_temp_5.substr(var_key.clone(), rt.new_int(12), rt.new_int(4))
	mut iife_temp_6 := Class_ParagonIE_Sodium_Core_SipHash{}
	mut iife_result_6 := iife_temp_6.load_4(iife_result_5)
	mut iife_temp_7 := Class_ParagonIE_Sodium_Core_SipHash{}
	mut iife_result_7 := iife_temp_7.substr(var_key.clone(), rt.new_int(8), rt.new_int(4))
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core_SipHash{}
	mut iife_result_8 := iife_temp_8.load_4(iife_result_7)
	mut var_k := [iife_result_2, iife_result_4, iife_result_6, iife_result_8]
	mut var_b := [rt.shift_left(var_inlen, rt.new_int(24)), 0]
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	mut var_left := var_inlen.clone()
	for rt.is_true(rt.greater_equal(var_left, rt.new_int(8))) {
		mut iife_temp_9 := Class_ParagonIE_Sodium_Core_SipHash{}
		mut iife_result_9 := iife_temp_9.substr(var_in_mutated.clone(), rt.new_int(4),
			rt.new_int(4))
		mut iife_temp_10 := Class_ParagonIE_Sodium_Core_SipHash{}
		mut iife_result_10 := iife_temp_10.load_4(iife_result_9)
		mut iife_temp_11 := Class_ParagonIE_Sodium_Core_SipHash{}
		mut iife_result_11 := iife_temp_11.substr(var_in_mutated.clone(), rt.new_int(0),
			rt.new_int(4))
		mut iife_temp_12 := Class_ParagonIE_Sodium_Core_SipHash{}
		mut iife_result_12 := iife_temp_12.load_4(iife_result_11)
		mut var_m := [iife_result_10, iife_result_12]
		rt.new_null()
		rt.new_null()
		var_v =
			Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
		var_v =
			Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
		rt.new_null()
		rt.new_null()
		mut iife_temp_13 := Class_ParagonIE_Sodium_Core_SipHash{}
		mut iife_result_13 := iife_temp_13.substr(var_in_mutated.clone(), rt.new_int(8))
		var_in_mutated = iife_result_13
		var_left = rt.sub(var_left, rt.new_int(8))
	}
	mut switch_val_1 := var_left
	if rt.is_true(rt.equal(switch_val_1, rt.new_int(7))) {
		rt.new_null()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(6))) {
		rt.new_null()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(5))) {
		rt.new_null()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(4))) {
		rt.new_null()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(3))) {
		rt.new_null()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
		rt.new_null()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		rt.new_null()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) {
	}
	rt.new_null()
	rt.new_null()
	var_v = Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v = Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	rt.new_null()
	rt.new_null()
	rt.new_null()
	var_v = Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v = Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v = Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v = Class_ParagonIE_Sodium_Core_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	mut iife_temp_14 := Class_ParagonIE_Sodium_Core_SipHash{}
	mut iife_result_14 := iife_temp_14.store32_le(rt.new_int(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_v.array_get(rt.new_int(1)),
		var_v.array_get(rt.new_int(3))), var_v.array_get(rt.new_int(5))),
		var_v.array_get(rt.new_int(7)))))
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core_SipHash{}
	mut iife_result_15 := iife_temp_15.store32_le(rt.new_int(rt.bitwise_xor(rt.bitwise_xor(rt.bitwise_xor(var_v.array_get(rt.new_int(0)),
		var_v.array_get(rt.new_int(2))), var_v.array_get(rt.new_int(4))),
		var_v.array_get(rt.new_int(6)))))
	return iife_result_14.str() + iife_result_15.str()
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_siphash(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_SipHash {
	mut obj := &Class_ParagonIE_Sodium_Core_SipHash{
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

fn (mut this Class_ParagonIE_Sodium_Core_SipHash) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'sipRound' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_ParagonIE_Sodium_Core_SipHash.sipround(mut dispatch_arg_0)
		}
		'add' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return Class_ParagonIE_Sodium_Core_SipHash.add(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'rotl_64' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_SipHash.rotl_64(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'sipHash24' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_SipHash.siphash24(dispatch_arg_0,
				dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core_SipHash) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_SipHash) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_SipHash'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
