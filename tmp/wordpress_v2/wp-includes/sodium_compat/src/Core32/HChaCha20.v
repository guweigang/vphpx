import rt

struct Class_ParagonIE_Sodium_Core32_HChaCha20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_HChaCha20.hchacha20(in string, key string, var_c rt.PhpVal) rt.PhpVal {
	mut var_ctx := []rt.PhpVal{}
	if rt.is_true(rt.identical(var_c, rt.new_null())) {
		var_ctx[0] = create_paragonie_sodium_core32_int32(rt.create_array([rt.ArrayItem{ key: none, val: 24944 }, rt.ArrayItem{ key: none, val: 30821 }]))
		var_ctx[1] = create_paragonie_sodium_core32_int32(rt.create_array([rt.ArrayItem{ key: none, val: 13088 }, rt.ArrayItem{ key: none, val: 25710 }]))
		var_ctx[2] = create_paragonie_sodium_core32_int32(rt.create_array([rt.ArrayItem{ key: none, val: 31074 }, rt.ArrayItem{ key: none, val: 11570 }]))
		var_ctx[3] = create_paragonie_sodium_core32_int32(rt.create_array([rt.ArrayItem{ key: none, val: 27424 }, rt.ArrayItem{ key: none, val: 25972 }]))
	} else {
		mut iife_temp_0 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
		mut iife_result_0 := iife_temp_0.substr(var_c.clone(), rt.new_int(0), rt.new_int(4))
		mut iife_temp_1 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_1 := iife_temp_1.fromreversestring(iife_result_0)
		var_ctx[0] = iife_result_1
		mut iife_temp_2 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
		mut iife_result_2 := iife_temp_2.substr(var_c.clone(), rt.new_int(4), rt.new_int(4))
		mut iife_temp_3 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_3 := iife_temp_3.fromreversestring(iife_result_2)
		var_ctx[1] = iife_result_3
		mut iife_temp_4 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
		mut iife_result_4 := iife_temp_4.substr(var_c.clone(), rt.new_int(8), rt.new_int(4))
		mut iife_temp_5 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_5 := iife_temp_5.fromreversestring(iife_result_4)
		var_ctx[2] = iife_result_5
		mut iife_temp_6 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
		mut iife_result_6 := iife_temp_6.substr(var_c.clone(), rt.new_int(12), rt.new_int(4))
		mut iife_temp_7 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_7 := iife_temp_7.fromreversestring(iife_result_6)
		var_ctx[3] = iife_result_7
	}
	mut iife_temp_8 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_8 := iife_temp_8.substr(rt.new_string(key), rt.new_int(0), rt.new_int(4))
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_9 := iife_temp_9.fromreversestring(iife_result_8)
	var_ctx[4] = iife_result_9
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_10 := iife_temp_10.substr(rt.new_string(key), rt.new_int(4), rt.new_int(4))
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_11 := iife_temp_11.fromreversestring(iife_result_10)
	var_ctx[5] = iife_result_11
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_12 := iife_temp_12.substr(rt.new_string(key), rt.new_int(8), rt.new_int(4))
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_13 := iife_temp_13.fromreversestring(iife_result_12)
	var_ctx[6] = iife_result_13
	mut iife_temp_14 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_14 := iife_temp_14.substr(rt.new_string(key), rt.new_int(12), rt.new_int(4))
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_15 := iife_temp_15.fromreversestring(iife_result_14)
	var_ctx[7] = iife_result_15
	mut iife_temp_16 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_16 := iife_temp_16.substr(rt.new_string(key), rt.new_int(16), rt.new_int(4))
	mut iife_temp_17 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_17 := iife_temp_17.fromreversestring(iife_result_16)
	var_ctx[8] = iife_result_17
	mut iife_temp_18 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_18 := iife_temp_18.substr(rt.new_string(key), rt.new_int(20), rt.new_int(4))
	mut iife_temp_19 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_19 := iife_temp_19.fromreversestring(iife_result_18)
	var_ctx[9] = iife_result_19
	mut iife_temp_20 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_20 := iife_temp_20.substr(rt.new_string(key), rt.new_int(24), rt.new_int(4))
	mut iife_temp_21 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_21 := iife_temp_21.fromreversestring(iife_result_20)
	var_ctx[10] = iife_result_21
	mut iife_temp_22 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_22 := iife_temp_22.substr(rt.new_string(key), rt.new_int(28), rt.new_int(4))
	mut iife_temp_23 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_23 := iife_temp_23.fromreversestring(iife_result_22)
	var_ctx[11] = iife_result_23
	mut iife_temp_24 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_24 := iife_temp_24.substr(rt.new_string(in), rt.new_int(0), rt.new_int(4))
	mut iife_temp_25 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_25 := iife_temp_25.fromreversestring(iife_result_24)
	var_ctx[12] = iife_result_25
	mut iife_temp_26 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_26 := iife_temp_26.substr(rt.new_string(in), rt.new_int(4), rt.new_int(4))
	mut iife_temp_27 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_27 := iife_temp_27.fromreversestring(iife_result_26)
	var_ctx[13] = iife_result_27
	mut iife_temp_28 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_28 := iife_temp_28.substr(rt.new_string(in), rt.new_int(8), rt.new_int(4))
	mut iife_temp_29 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_29 := iife_temp_29.fromreversestring(iife_result_28)
	var_ctx[14] = iife_result_29
	mut iife_temp_30 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
	mut iife_result_30 := iife_temp_30.substr(rt.new_string(in), rt.new_int(12), rt.new_int(4))
	mut iife_temp_31 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_31 := iife_temp_31.fromreversestring(iife_result_30)
	var_ctx[15] = iife_result_31
	return Class_ParagonIE_Sodium_Core32_HChaCha20.hchacha20bytes(mut rt.cast_object_ptr[Class_array](var_ctx))
}

fn Class_ParagonIE_Sodium_Core32_HChaCha20.hchacha20bytes(mut var_ctx Class_array) string {
	mut var_ctx_mutated := var_ctx
	mut var_x0 := var_ctx_mutated.array_get(rt.new_int(0))
	mut var_x1 := var_ctx_mutated.array_get(rt.new_int(1))
	mut var_x2 := var_ctx_mutated.array_get(rt.new_int(2))
	mut var_x3 := var_ctx_mutated.array_get(rt.new_int(3))
	mut var_x4 := var_ctx_mutated.array_get(rt.new_int(4))
	mut var_x5 := var_ctx_mutated.array_get(rt.new_int(5))
	mut var_x6 := var_ctx_mutated.array_get(rt.new_int(6))
	mut var_x7 := var_ctx_mutated.array_get(rt.new_int(7))
	mut var_x8 := var_ctx_mutated.array_get(rt.new_int(8))
	mut var_x9 := var_ctx_mutated.array_get(rt.new_int(9))
	mut var_x10 := var_ctx_mutated.array_get(rt.new_int(10))
	mut var_x11 := var_ctx_mutated.array_get(rt.new_int(11))
	mut var_x12 := var_ctx_mutated.array_get(rt.new_int(12))
	mut var_x13 := var_ctx_mutated.array_get(rt.new_int(13))
	mut var_x14 := var_ctx_mutated.array_get(rt.new_int(14))
	mut var_x15 := var_ctx_mutated.array_get(rt.new_int(15))
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(10)))) { break }
		mut iife_temp_32 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
		mut iife_result_32 := iife_temp_32.quarterround(var_x0.clone(), var_x4.clone(), var_x8.clone(), var_x12.clone())
		mut list_tmp_1 := iife_result_32
		var_x0 = (list_tmp_1).array_get(0)
		var_x4 = (list_tmp_1).array_get(1)
		var_x8 = (list_tmp_1).array_get(2)
		var_x12 = (list_tmp_1).array_get(3)
		mut iife_temp_33 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
		mut iife_result_33 := iife_temp_33.quarterround(var_x1.clone(), var_x5.clone(), var_x9.clone(), var_x13.clone())
		mut list_tmp_2 := iife_result_33
		var_x1 = (list_tmp_2).array_get(0)
		var_x5 = (list_tmp_2).array_get(1)
		var_x9 = (list_tmp_2).array_get(2)
		var_x13 = (list_tmp_2).array_get(3)
		mut iife_temp_34 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
		mut iife_result_34 := iife_temp_34.quarterround(var_x2.clone(), var_x6.clone(), var_x10.clone(), var_x14.clone())
		mut list_tmp_3 := iife_result_34
		var_x2 = (list_tmp_3).array_get(0)
		var_x6 = (list_tmp_3).array_get(1)
		var_x10 = (list_tmp_3).array_get(2)
		var_x14 = (list_tmp_3).array_get(3)
		mut iife_temp_35 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
		mut iife_result_35 := iife_temp_35.quarterround(var_x3.clone(), var_x7.clone(), var_x11.clone(), var_x15.clone())
		mut list_tmp_4 := iife_result_35
		var_x3 = (list_tmp_4).array_get(0)
		var_x7 = (list_tmp_4).array_get(1)
		var_x11 = (list_tmp_4).array_get(2)
		var_x15 = (list_tmp_4).array_get(3)
		mut iife_temp_36 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
		mut iife_result_36 := iife_temp_36.quarterround(var_x0.clone(), var_x5.clone(), var_x10.clone(), var_x15.clone())
		mut list_tmp_5 := iife_result_36
		var_x0 = (list_tmp_5).array_get(0)
		var_x5 = (list_tmp_5).array_get(1)
		var_x10 = (list_tmp_5).array_get(2)
		var_x15 = (list_tmp_5).array_get(3)
		mut iife_temp_37 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
		mut iife_result_37 := iife_temp_37.quarterround(var_x1.clone(), var_x6.clone(), var_x11.clone(), var_x12.clone())
		mut list_tmp_6 := iife_result_37
		var_x1 = (list_tmp_6).array_get(0)
		var_x6 = (list_tmp_6).array_get(1)
		var_x11 = (list_tmp_6).array_get(2)
		var_x12 = (list_tmp_6).array_get(3)
		mut iife_temp_38 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
		mut iife_result_38 := iife_temp_38.quarterround(var_x2.clone(), var_x7.clone(), var_x8.clone(), var_x13.clone())
		mut list_tmp_7 := iife_result_38
		var_x2 = (list_tmp_7).array_get(0)
		var_x7 = (list_tmp_7).array_get(1)
		var_x8 = (list_tmp_7).array_get(2)
		var_x13 = (list_tmp_7).array_get(3)
		mut iife_temp_39 := Class_ParagonIE_Sodium_Core32_HChaCha20{}
		mut iife_result_39 := iife_temp_39.quarterround(var_x3.clone(), var_x4.clone(), var_x9.clone(), var_x14.clone())
		mut list_tmp_8 := iife_result_39
		var_x3 = (list_tmp_8).array_get(0)
		var_x4 = (list_tmp_8).array_get(1)
		var_x9 = (list_tmp_8).array_get(2)
		var_x14 = (list_tmp_8).array_get(3)
		rt.pre_inc(var_i)
	}
	return (rt.call_method(var_x0, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x1, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x2, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x3, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x12, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x13, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x14, 'toReverseString', []rt.PhpVal{})).str() + (rt.call_method(var_x15, 'toReverseString', []rt.PhpVal{})).str()
}

struct Class_ParagonIE_Sodium_Core32_ChaCha20 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int32 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_hchacha20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_HChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_HChaCha20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_chacha20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_ChaCha20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_ChaCha20{
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

fn (mut this Class_ParagonIE_Sodium_Core32_HChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'hChaCha20' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_HChaCha20.hchacha20(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'hChaCha20Bytes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_ParagonIE_Sodium_Core32_HChaCha20.hchacha20bytes(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_HChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_HChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_ChaCha20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core32_HChaCha20'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
