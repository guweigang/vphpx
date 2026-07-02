import rt

struct Class_ParagonIE_Sodium_Core32_HSalsa20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_HSalsa20.hsalsa20(var_in rt.PhpVal, var_k rt.PhpVal, var_c rt.PhpVal) string {
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_0 := iife_temp_0.strlen(var_k.clone())
	if rt.is_true(rt.less(iife_result_0, rt.new_int(32))) {
		rt.throw_exception(rt.new_object('RangeException', []string{},
			create_rangeexception(rt.new_string('Key must be 32 bytes long'))))
	}
	if rt.is_true(rt.identical(var_c, rt.new_null())) {
		mut var_x0 := create_paragonie_sodium_core32_int32(rt.create_array([
			rt.ArrayItem{ key: none, val: 24944 },
			rt.ArrayItem{ key: none, val: 30821 },
		]))
		mut var_x5 := create_paragonie_sodium_core32_int32(rt.create_array([
			rt.ArrayItem{ key: none, val: 13088 },
			rt.ArrayItem{ key: none, val: 25710 },
		]))
		mut var_x10 := create_paragonie_sodium_core32_int32(rt.create_array([
			rt.ArrayItem{ key: none, val: 31074 },
			rt.ArrayItem{ key: none, val: 11570 },
		]))
		mut var_x15 := create_paragonie_sodium_core32_int32(rt.create_array([
			rt.ArrayItem{ key: none, val: 27424 },
			rt.ArrayItem{ key: none, val: 25972 },
		]))
	} else {
		mut iife_temp_1 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		mut iife_result_1 := iife_temp_1.substr(var_c.clone(), rt.new_int(0), rt.new_int(4))
		mut iife_temp_2 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_2 := iife_temp_2.fromreversestring(iife_result_1)
		var_x0 = iife_result_2
		mut iife_temp_3 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		mut iife_result_3 := iife_temp_3.substr(var_c.clone(), rt.new_int(4), rt.new_int(4))
		mut iife_temp_4 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_4 := iife_temp_4.fromreversestring(iife_result_3)
		var_x5 = iife_result_4
		mut iife_temp_5 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		mut iife_result_5 := iife_temp_5.substr(var_c.clone(), rt.new_int(8), rt.new_int(4))
		mut iife_temp_6 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_6 := iife_temp_6.fromreversestring(iife_result_5)
		var_x10 = iife_result_6
		mut iife_temp_7 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		mut iife_result_7 := iife_temp_7.substr(var_c.clone(), rt.new_int(12), rt.new_int(4))
		mut iife_temp_8 := Class_ParagonIE_Sodium_Core32_Int32{}
		mut iife_result_8 := iife_temp_8.fromreversestring(iife_result_7)
		var_x15 = iife_result_8
	}
	mut iife_temp_9 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_9 := iife_temp_9.substr(var_k.clone(), rt.new_int(0), rt.new_int(4))
	mut iife_temp_10 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_10 := iife_temp_10.fromreversestring(iife_result_9)
	mut var_x1 := iife_result_10
	mut iife_temp_11 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_11 := iife_temp_11.substr(var_k.clone(), rt.new_int(4), rt.new_int(4))
	mut iife_temp_12 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_12 := iife_temp_12.fromreversestring(iife_result_11)
	mut var_x2 := iife_result_12
	mut iife_temp_13 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_13 := iife_temp_13.substr(var_k.clone(), rt.new_int(8), rt.new_int(4))
	mut iife_temp_14 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_14 := iife_temp_14.fromreversestring(iife_result_13)
	mut var_x3 := iife_result_14
	mut iife_temp_15 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_15 := iife_temp_15.substr(var_k.clone(), rt.new_int(12), rt.new_int(4))
	mut iife_temp_16 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_16 := iife_temp_16.fromreversestring(iife_result_15)
	mut var_x4 := iife_result_16
	mut iife_temp_17 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_17 := iife_temp_17.substr(var_in.clone(), rt.new_int(0), rt.new_int(4))
	mut iife_temp_18 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_18 := iife_temp_18.fromreversestring(iife_result_17)
	mut var_x6 := iife_result_18
	mut iife_temp_19 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_19 := iife_temp_19.substr(var_in.clone(), rt.new_int(4), rt.new_int(4))
	mut iife_temp_20 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_20 := iife_temp_20.fromreversestring(iife_result_19)
	mut var_x7 := iife_result_20
	mut iife_temp_21 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_21 := iife_temp_21.substr(var_in.clone(), rt.new_int(8), rt.new_int(4))
	mut iife_temp_22 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_22 := iife_temp_22.fromreversestring(iife_result_21)
	mut var_x8 := iife_result_22
	mut iife_temp_23 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_23 := iife_temp_23.substr(var_in.clone(), rt.new_int(12), rt.new_int(4))
	mut iife_temp_24 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_24 := iife_temp_24.fromreversestring(iife_result_23)
	mut var_x9 := iife_result_24
	mut iife_temp_25 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_25 := iife_temp_25.substr(var_k.clone(), rt.new_int(16), rt.new_int(4))
	mut iife_temp_26 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_26 := iife_temp_26.fromreversestring(iife_result_25)
	mut var_x11 := iife_result_26
	mut iife_temp_27 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_27 := iife_temp_27.substr(var_k.clone(), rt.new_int(20), rt.new_int(4))
	mut iife_temp_28 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_28 := iife_temp_28.fromreversestring(iife_result_27)
	mut var_x12 := iife_result_28
	mut iife_temp_29 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_29 := iife_temp_29.substr(var_k.clone(), rt.new_int(24), rt.new_int(4))
	mut iife_temp_30 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_30 := iife_temp_30.fromreversestring(iife_result_29)
	mut var_x13 := iife_result_30
	mut iife_temp_31 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_31 := iife_temp_31.substr(var_k.clone(), rt.new_int(28), rt.new_int(4))
	mut iife_temp_32 := Class_ParagonIE_Sodium_Core32_Int32{}
	mut iife_result_32 := iife_temp_32.fromreversestring(iife_result_31)
	mut var_x14 := iife_result_32
	mut var_i := Class_ParagonIE_Sodium_Core32_HSalsa20.rounds()
	for {
		if !(rt.is_true(rt.greater(var_i, rt.new_int(0)))) { break
		 }
		var_x4 = rt.call_method(var_x4, 'xorInt32', [
			rt.call_method(rt.call_method(var_x0, 'addInt32', [
				var_x12.clone()]), 'rotateLeft', [rt.new_int(7)]),
		])
		var_x8 = rt.call_method(var_x8, 'xorInt32', [
			rt.call_method(rt.call_method(var_x4, 'addInt32', [
				var_x0.clone()]), 'rotateLeft', [rt.new_int(9)]),
		])
		var_x12 = rt.call_method(var_x12, 'xorInt32', [
			rt.call_method(rt.call_method(var_x8, 'addInt32', [
				var_x4.clone()]), 'rotateLeft', [rt.new_int(13)]),
		])
		var_x0 = rt.call_method(var_x0, 'xorInt32', [
			rt.call_method(rt.call_method(var_x12, 'addInt32', [
				var_x8.clone()]), 'rotateLeft', [rt.new_int(18)]),
		])
		var_x9 = rt.call_method(var_x9, 'xorInt32', [
			rt.call_method(rt.call_method(var_x5, 'addInt32', [
				var_x1.clone()]), 'rotateLeft', [rt.new_int(7)]),
		])
		var_x13 = rt.call_method(var_x13, 'xorInt32', [
			rt.call_method(rt.call_method(var_x9, 'addInt32', [
				var_x5.clone()]), 'rotateLeft', [rt.new_int(9)]),
		])
		var_x1 = rt.call_method(var_x1, 'xorInt32', [
			rt.call_method(rt.call_method(var_x13, 'addInt32', [
				var_x9.clone()]), 'rotateLeft', [rt.new_int(13)]),
		])
		var_x5 = rt.call_method(var_x5, 'xorInt32', [
			rt.call_method(rt.call_method(var_x1, 'addInt32', [
				var_x13.clone()]), 'rotateLeft', [rt.new_int(18)]),
		])
		var_x14 = rt.call_method(var_x14, 'xorInt32', [
			rt.call_method(rt.call_method(var_x10, 'addInt32', [
				var_x6.clone()]), 'rotateLeft', [rt.new_int(7)]),
		])
		var_x2 = rt.call_method(var_x2, 'xorInt32', [
			rt.call_method(rt.call_method(var_x14, 'addInt32', [
				var_x10.clone()]), 'rotateLeft', [rt.new_int(9)]),
		])
		var_x6 = rt.call_method(var_x6, 'xorInt32', [
			rt.call_method(rt.call_method(var_x2, 'addInt32', [
				var_x14.clone()]), 'rotateLeft', [rt.new_int(13)]),
		])
		var_x10 = rt.call_method(var_x10, 'xorInt32', [
			rt.call_method(rt.call_method(var_x6, 'addInt32', [
				var_x2.clone()]), 'rotateLeft', [rt.new_int(18)]),
		])
		var_x3 = rt.call_method(var_x3, 'xorInt32', [
			rt.call_method(rt.call_method(var_x15, 'addInt32', [
				var_x11.clone()]), 'rotateLeft', [rt.new_int(7)]),
		])
		var_x7 = rt.call_method(var_x7, 'xorInt32', [
			rt.call_method(rt.call_method(var_x3, 'addInt32', [
				var_x15.clone()]), 'rotateLeft', [rt.new_int(9)]),
		])
		var_x11 = rt.call_method(var_x11, 'xorInt32', [
			rt.call_method(rt.call_method(var_x7, 'addInt32', [
				var_x3.clone()]), 'rotateLeft', [rt.new_int(13)]),
		])
		var_x15 = rt.call_method(var_x15, 'xorInt32', [
			rt.call_method(rt.call_method(var_x11, 'addInt32', [
				var_x7.clone()]), 'rotateLeft', [rt.new_int(18)]),
		])
		var_x1 = rt.call_method(var_x1, 'xorInt32', [
			rt.call_method(rt.call_method(var_x0, 'addInt32', [
				var_x3.clone()]), 'rotateLeft', [rt.new_int(7)]),
		])
		var_x2 = rt.call_method(var_x2, 'xorInt32', [
			rt.call_method(rt.call_method(var_x1, 'addInt32', [
				var_x0.clone()]), 'rotateLeft', [rt.new_int(9)]),
		])
		var_x3 = rt.call_method(var_x3, 'xorInt32', [
			rt.call_method(rt.call_method(var_x2, 'addInt32', [
				var_x1.clone()]), 'rotateLeft', [rt.new_int(13)]),
		])
		var_x0 = rt.call_method(var_x0, 'xorInt32', [
			rt.call_method(rt.call_method(var_x3, 'addInt32', [
				var_x2.clone()]), 'rotateLeft', [rt.new_int(18)]),
		])
		var_x6 = rt.call_method(var_x6, 'xorInt32', [
			rt.call_method(rt.call_method(var_x5, 'addInt32', [
				var_x4.clone()]), 'rotateLeft', [rt.new_int(7)]),
		])
		var_x7 = rt.call_method(var_x7, 'xorInt32', [
			rt.call_method(rt.call_method(var_x6, 'addInt32', [
				var_x5.clone()]), 'rotateLeft', [rt.new_int(9)]),
		])
		var_x4 = rt.call_method(var_x4, 'xorInt32', [
			rt.call_method(rt.call_method(var_x7, 'addInt32', [
				var_x6.clone()]), 'rotateLeft', [rt.new_int(13)]),
		])
		var_x5 = rt.call_method(var_x5, 'xorInt32', [
			rt.call_method(rt.call_method(var_x4, 'addInt32', [
				var_x7.clone()]), 'rotateLeft', [rt.new_int(18)]),
		])
		var_x11 = rt.call_method(var_x11, 'xorInt32', [
			rt.call_method(rt.call_method(var_x10, 'addInt32', [
				var_x9.clone()]), 'rotateLeft', [rt.new_int(7)]),
		])
		var_x8 = rt.call_method(var_x8, 'xorInt32', [
			rt.call_method(rt.call_method(var_x11, 'addInt32', [
				var_x10.clone()]), 'rotateLeft', [rt.new_int(9)]),
		])
		var_x9 = rt.call_method(var_x9, 'xorInt32', [
			rt.call_method(rt.call_method(var_x8, 'addInt32', [
				var_x11.clone()]), 'rotateLeft', [rt.new_int(13)]),
		])
		var_x10 = rt.call_method(var_x10, 'xorInt32', [
			rt.call_method(rt.call_method(var_x9, 'addInt32', [
				var_x8.clone()]), 'rotateLeft', [rt.new_int(18)]),
		])
		var_x12 = rt.call_method(var_x12, 'xorInt32', [
			rt.call_method(rt.call_method(var_x15, 'addInt32', [
				var_x14.clone()]), 'rotateLeft', [rt.new_int(7)]),
		])
		var_x13 = rt.call_method(var_x13, 'xorInt32', [
			rt.call_method(rt.call_method(var_x12, 'addInt32', [
				var_x15.clone()]), 'rotateLeft', [rt.new_int(9)]),
		])
		var_x14 = rt.call_method(var_x14, 'xorInt32', [
			rt.call_method(rt.call_method(var_x13, 'addInt32', [
				var_x12.clone()]), 'rotateLeft', [rt.new_int(13)]),
		])
		var_x15 = rt.call_method(var_x15, 'xorInt32', [
			rt.call_method(rt.call_method(var_x14, 'addInt32', [
				var_x13.clone()]), 'rotateLeft', [rt.new_int(18)]),
		])
		var_i = rt.sub(var_i, rt.new_int(2))
	}
	return (rt.call_method(var_x0, 'toReverseString', []rt.PhpVal{})).str() +
		(rt.call_method(var_x5, 'toReverseString', []rt.PhpVal{})).str() +
		(rt.call_method(var_x10, 'toReverseString', []rt.PhpVal{})).str() +
		(rt.call_method(var_x15, 'toReverseString', []rt.PhpVal{})).str() +
		(rt.call_method(var_x6, 'toReverseString', []rt.PhpVal{})).str() +
		(rt.call_method(var_x7, 'toReverseString', []rt.PhpVal{})).str() +
		(rt.call_method(var_x8, 'toReverseString', []rt.PhpVal{})).str() +
		(rt.call_method(var_x9, 'toReverseString', []rt.PhpVal{})).str()
}

struct Class_ParagonIE_Sodium_Core32_Salsa20 {
	rt.PhpObjectBase
}

struct Class_RangeException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int32 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_hsalsa20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_HSalsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_HSalsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_salsa20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Salsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Salsa20{
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

fn create_paragonie_sodium_core32_int32(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Int32 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Int32{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_HSalsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'hsalsa20' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core32_HSalsa20.hsalsa20(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_HSalsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_HSalsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Salsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Salsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Salsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core32_HSalsa20'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
