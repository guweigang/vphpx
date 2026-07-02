import rt

struct Class_ParagonIE_Sodium_Core_HChaCha20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_HChaCha20.hchacha20(var_in rt.PhpVal, var_key rt.PhpVal, var_c rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_0 := iife_temp_0.strlen(var_in.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_0, rt.new_int(16))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Argument 1 must be 16 bytes'))))
	}
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_1 := iife_temp_1.strlen(var_key.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_1, rt.new_int(32))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Argument 2 must be 32 bytes'))))
	}
	mut var_ctx := []rt.PhpVal{}
	if rt.is_true(rt.identical(var_c, rt.new_null())) {
		var_ctx[0] = rt.new_int(1634760805)
		var_ctx[1] = rt.new_int(857760878)
		var_ctx[2] = rt.new_int(2036477234)
		var_ctx[3] = rt.new_int(1797285236)
	} else {
		mut iife_temp_2 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_2 := iife_temp_2.substr(var_c.clone(), rt.new_int(0), rt.new_int(4))
		mut iife_temp_3 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_3 := iife_temp_3.load_4(iife_result_2)
		var_ctx[0] = iife_result_3
		mut iife_temp_4 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_4 := iife_temp_4.substr(var_c.clone(), rt.new_int(4), rt.new_int(4))
		mut iife_temp_5 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_5 := iife_temp_5.load_4(iife_result_4)
		var_ctx[1] = iife_result_5
		mut iife_temp_6 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_6 := iife_temp_6.substr(var_c.clone(), rt.new_int(8), rt.new_int(4))
		mut iife_temp_7 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_7 := iife_temp_7.load_4(iife_result_6)
		var_ctx[2] = iife_result_7
		mut iife_temp_8 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_8 := iife_temp_8.substr(var_c.clone(), rt.new_int(12), rt.new_int(4))
		mut iife_temp_9 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_9 := iife_temp_9.load_4(iife_result_8)
		var_ctx[3] = iife_result_9
	}
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_10 := iife_temp_10.substr(var_key.clone(), rt.new_int(0), rt.new_int(4))
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_11 := iife_temp_11.load_4(iife_result_10)
	var_ctx[4] = iife_result_11
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_12 := iife_temp_12.substr(var_key.clone(), rt.new_int(4), rt.new_int(4))
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_13 := iife_temp_13.load_4(iife_result_12)
	var_ctx[5] = iife_result_13
	mut iife_temp_14 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_14 := iife_temp_14.substr(var_key.clone(), rt.new_int(8), rt.new_int(4))
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_15 := iife_temp_15.load_4(iife_result_14)
	var_ctx[6] = iife_result_15
	mut iife_temp_16 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_16 := iife_temp_16.substr(var_key.clone(), rt.new_int(12), rt.new_int(4))
	mut iife_temp_17 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_17 := iife_temp_17.load_4(iife_result_16)
	var_ctx[7] = iife_result_17
	mut iife_temp_18 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_18 := iife_temp_18.substr(var_key.clone(), rt.new_int(16), rt.new_int(4))
	mut iife_temp_19 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_19 := iife_temp_19.load_4(iife_result_18)
	var_ctx[8] = iife_result_19
	mut iife_temp_20 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_20 := iife_temp_20.substr(var_key.clone(), rt.new_int(20), rt.new_int(4))
	mut iife_temp_21 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_21 := iife_temp_21.load_4(iife_result_20)
	var_ctx[9] = iife_result_21
	mut iife_temp_22 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_22 := iife_temp_22.substr(var_key.clone(), rt.new_int(24), rt.new_int(4))
	mut iife_temp_23 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_23 := iife_temp_23.load_4(iife_result_22)
	var_ctx[10] = iife_result_23
	mut iife_temp_24 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_24 := iife_temp_24.substr(var_key.clone(), rt.new_int(28), rt.new_int(4))
	mut iife_temp_25 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_25 := iife_temp_25.load_4(iife_result_24)
	var_ctx[11] = iife_result_25
	mut iife_temp_26 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_26 := iife_temp_26.substr(var_in.clone(), rt.new_int(0), rt.new_int(4))
	mut iife_temp_27 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_27 := iife_temp_27.load_4(iife_result_26)
	var_ctx[12] = iife_result_27
	mut iife_temp_28 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_28 := iife_temp_28.substr(var_in.clone(), rt.new_int(4), rt.new_int(4))
	mut iife_temp_29 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_29 := iife_temp_29.load_4(iife_result_28)
	var_ctx[13] = iife_result_29
	mut iife_temp_30 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_30 := iife_temp_30.substr(var_in.clone(), rt.new_int(8), rt.new_int(4))
	mut iife_temp_31 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_31 := iife_temp_31.load_4(iife_result_30)
	var_ctx[14] = iife_result_31
	mut iife_temp_32 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_32 := iife_temp_32.substr(var_in.clone(), rt.new_int(12), rt.new_int(4))
	mut iife_temp_33 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_33 := iife_temp_33.load_4(iife_result_32)
	var_ctx[15] = iife_result_33
	return Class_ParagonIE_Sodium_Core_HChaCha20.hchacha20bytes(mut rt.cast_object_ptr[Class_array](var_ctx))
}

fn Class_ParagonIE_Sodium_Core_HChaCha20.hchacha20bytes(mut var_ctx Class_array) string {
	mut var_ctx_mutated := var_ctx
	mut var_x0 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(0))).to_i64())
	mut var_x1 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(1))).to_i64())
	mut var_x2 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(2))).to_i64())
	mut var_x3 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(3))).to_i64())
	mut var_x4 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(4))).to_i64())
	mut var_x5 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(5))).to_i64())
	mut var_x6 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(6))).to_i64())
	mut var_x7 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(7))).to_i64())
	mut var_x8 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(8))).to_i64())
	mut var_x9 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(9))).to_i64())
	mut var_x10 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(10))).to_i64())
	mut var_x11 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(11))).to_i64())
	mut var_x12 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(12))).to_i64())
	mut var_x13 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(13))).to_i64())
	mut var_x14 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(14))).to_i64())
	mut var_x15 := rt.new_int((var_ctx_mutated.array_get(rt.new_int(15))).to_i64())
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break
		 }
		mut iife_temp_34 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_34 := iife_temp_34.quarterround(var_x0.clone(), var_x4.clone(),
			var_x8.clone(), var_x12.clone())
		mut list_tmp_1 := iife_result_34
		var_x0 = list_tmp_1.array_get(0)
		var_x4 = list_tmp_1.array_get(1)
		var_x8 = list_tmp_1.array_get(2)
		var_x12 = list_tmp_1.array_get(3)
		mut iife_temp_35 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_35 := iife_temp_35.quarterround(var_x1.clone(), var_x5.clone(),
			var_x9.clone(), var_x13.clone())
		mut list_tmp_2 := iife_result_35
		var_x1 = list_tmp_2.array_get(0)
		var_x5 = list_tmp_2.array_get(1)
		var_x9 = list_tmp_2.array_get(2)
		var_x13 = list_tmp_2.array_get(3)
		mut iife_temp_36 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_36 := iife_temp_36.quarterround(var_x2.clone(), var_x6.clone(),
			var_x10.clone(), var_x14.clone())
		mut list_tmp_3 := iife_result_36
		var_x2 = list_tmp_3.array_get(0)
		var_x6 = list_tmp_3.array_get(1)
		var_x10 = list_tmp_3.array_get(2)
		var_x14 = list_tmp_3.array_get(3)
		mut iife_temp_37 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_37 := iife_temp_37.quarterround(var_x3.clone(), var_x7.clone(),
			var_x11.clone(), var_x15.clone())
		mut list_tmp_4 := iife_result_37
		var_x3 = list_tmp_4.array_get(0)
		var_x7 = list_tmp_4.array_get(1)
		var_x11 = list_tmp_4.array_get(2)
		var_x15 = list_tmp_4.array_get(3)
		mut iife_temp_38 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_38 := iife_temp_38.quarterround(var_x0.clone(), var_x5.clone(),
			var_x10.clone(), var_x15.clone())
		mut list_tmp_5 := iife_result_38
		var_x0 = list_tmp_5.array_get(0)
		var_x5 = list_tmp_5.array_get(1)
		var_x10 = list_tmp_5.array_get(2)
		var_x15 = list_tmp_5.array_get(3)
		mut iife_temp_39 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_39 := iife_temp_39.quarterround(var_x1.clone(), var_x6.clone(),
			var_x11.clone(), var_x12.clone())
		mut list_tmp_6 := iife_result_39
		var_x1 = list_tmp_6.array_get(0)
		var_x6 = list_tmp_6.array_get(1)
		var_x11 = list_tmp_6.array_get(2)
		var_x12 = list_tmp_6.array_get(3)
		mut iife_temp_40 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_40 := iife_temp_40.quarterround(var_x2.clone(), var_x7.clone(),
			var_x8.clone(), var_x13.clone())
		mut list_tmp_7 := iife_result_40
		var_x2 = list_tmp_7.array_get(0)
		var_x7 = list_tmp_7.array_get(1)
		var_x8 = list_tmp_7.array_get(2)
		var_x13 = list_tmp_7.array_get(3)
		mut iife_temp_41 := Class_ParagonIE_Sodium_Core_HChaCha20{}
		mut iife_result_41 := iife_temp_41.quarterround(var_x3.clone(), var_x4.clone(),
			var_x9.clone(), var_x14.clone())
		mut list_tmp_8 := iife_result_41
		var_x3 = list_tmp_8.array_get(0)
		var_x4 = list_tmp_8.array_get(1)
		var_x9 = list_tmp_8.array_get(2)
		var_x14 = list_tmp_8.array_get(3)
		rt.pre_inc(var_i)
	}
	mut iife_temp_42 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_42 := iife_temp_42.store32_le(rt.new_int(rt.bitwise_and(var_x0,
		rt.new_int(4294967295))))
	mut iife_temp_43 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_43 := iife_temp_43.store32_le(rt.new_int(rt.bitwise_and(var_x1,
		rt.new_int(4294967295))))
	mut iife_temp_44 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_44 := iife_temp_44.store32_le(rt.new_int(rt.bitwise_and(var_x2,
		rt.new_int(4294967295))))
	mut iife_temp_45 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_45 := iife_temp_45.store32_le(rt.new_int(rt.bitwise_and(var_x3,
		rt.new_int(4294967295))))
	mut iife_temp_46 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_46 := iife_temp_46.store32_le(rt.new_int(rt.bitwise_and(var_x12,
		rt.new_int(4294967295))))
	mut iife_temp_47 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_47 := iife_temp_47.store32_le(rt.new_int(rt.bitwise_and(var_x13,
		rt.new_int(4294967295))))
	mut iife_temp_48 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_48 := iife_temp_48.store32_le(rt.new_int(rt.bitwise_and(var_x14,
		rt.new_int(4294967295))))
	mut iife_temp_49 := Class_ParagonIE_Sodium_Core_HChaCha20{}
	mut iife_result_49 := iife_temp_49.store32_le(rt.new_int(rt.bitwise_and(var_x15,
		rt.new_int(4294967295))))
	return iife_result_42.str() + iife_result_43.str() + iife_result_44.str() +
		iife_result_45.str() + iife_result_46.str() + iife_result_47.str() + iife_result_48.str() +
		iife_result_49.str()
}

struct Class_ParagonIE_Sodium_Core_ChaCha20 {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_hchacha20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_HChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core_HChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_chacha20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_ChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core_ChaCha20{
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

fn (mut this Class_ParagonIE_Sodium_Core_HChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'hChaCha20' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_HChaCha20.hchacha20(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'hChaCha20Bytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_ParagonIE_Sodium_Core_HChaCha20.hchacha20bytes(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core_HChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_HChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_ChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_HChaCha20'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
