import rt

struct Class_ParagonIE_Sodium_Core32_SipHash {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut var_v Class_array) rt.PhpVal {
	mut var_v_mutated := var_v
	var_v_mutated.array_set(0, rt.call_method(var_v_mutated.array_get(rt.new_int(0)), 'addInt64', [
		var_v_mutated.array_get(rt.new_int(1)),
	]))
	var_v_mutated.array_set(1, rt.call_method(var_v_mutated.array_get(rt.new_int(1)), 'rotateLeft', [
		rt.new_int(13),
	]))
	var_v_mutated.array_set(1, rt.call_method(var_v_mutated.array_get(rt.new_int(1)), 'xorInt64', [
		var_v_mutated.array_get(rt.new_int(0)),
	]))
	var_v_mutated.array_set(0, rt.call_method(var_v_mutated.array_get(rt.new_int(0)), 'rotateLeft', [
		rt.new_int(32),
	]))
	var_v_mutated.array_set(2, rt.call_method(var_v_mutated.array_get(rt.new_int(2)), 'addInt64', [
		var_v_mutated.array_get(rt.new_int(3)),
	]))
	var_v_mutated.array_set(3, rt.call_method(var_v_mutated.array_get(rt.new_int(3)), 'rotateLeft', [
		rt.new_int(16),
	]))
	var_v_mutated.array_set(3, rt.call_method(var_v_mutated.array_get(rt.new_int(3)), 'xorInt64', [
		var_v_mutated.array_get(rt.new_int(2)),
	]))
	var_v_mutated.array_set(0, rt.call_method(var_v_mutated.array_get(rt.new_int(0)), 'addInt64', [
		var_v_mutated.array_get(rt.new_int(3)),
	]))
	var_v_mutated.array_set(3, rt.call_method(var_v_mutated.array_get(rt.new_int(3)), 'rotateLeft', [
		rt.new_int(21),
	]))
	var_v_mutated.array_set(3, rt.call_method(var_v_mutated.array_get(rt.new_int(3)), 'xorInt64', [
		var_v_mutated.array_get(rt.new_int(0)),
	]))
	var_v_mutated.array_set(2, rt.call_method(var_v_mutated.array_get(rt.new_int(2)), 'addInt64', [
		var_v_mutated.array_get(rt.new_int(1)),
	]))
	var_v_mutated.array_set(1, rt.call_method(var_v_mutated.array_get(rt.new_int(1)), 'rotateLeft', [
		rt.new_int(17),
	]))
	var_v_mutated.array_set(1, rt.call_method(var_v_mutated.array_get(rt.new_int(1)), 'xorInt64', [
		var_v_mutated.array_get(rt.new_int(2)),
	]))
	var_v_mutated.array_set(2, rt.call_method(var_v_mutated.array_get(rt.new_int(2)), 'rotateLeft', [
		rt.new_int(32),
	]))
	return rt.new_object('array', []string{}, var_v_mutated)
}

fn Class_ParagonIE_Sodium_Core32_SipHash.siphash24(var_in rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_in_mutated := var_in
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core32_SipHash{}
	mut iife_result_0 := iife_temp_0.strlen(var_in_mutated.clone())
	mut var_inlen := iife_result_0
	mut var_v := rt.create_array([
		rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int64(rt.create_array([
			rt.ArrayItem{ key: none, val: 29551 },
			rt.ArrayItem{ key: none, val: 28005 },
			rt.ArrayItem{ key: none, val: 28787 },
			rt.ArrayItem{ key: none, val: 25973 },
		])) },
		rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int64(rt.create_array([
			rt.ArrayItem{ key: none, val: 25711 },
			rt.ArrayItem{ key: none, val: 29281 },
			rt.ArrayItem{ key: none, val: 28260 },
			rt.ArrayItem{ key: none, val: 28525 },
		])) },
		rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int64(rt.create_array([
			rt.ArrayItem{ key: none, val: 27769 },
			rt.ArrayItem{ key: none, val: 26469 },
			rt.ArrayItem{ key: none, val: 28261 },
			rt.ArrayItem{ key: none, val: 29281 },
		])) },
		rt.ArrayItem{ key: none, val: create_paragonie_sodium_core32_int64(rt.create_array([
			rt.ArrayItem{ key: none, val: 29797 },
			rt.ArrayItem{ key: none, val: 25698 },
			rt.ArrayItem{ key: none, val: 31092 },
			rt.ArrayItem{ key: none, val: 25971 },
		])) },
	])
	mut iife_temp_1 := Class_ParagonIE_Sodium_Core32_SipHash{}
	mut iife_result_1 := iife_temp_1.substr(var_key.clone(), rt.new_int(0), rt.new_int(8))
	mut iife_temp_2 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_2 := iife_temp_2.fromreversestring(iife_result_1)
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core32_SipHash{}
	mut iife_result_3 := iife_temp_3.substr(var_key.clone(), rt.new_int(8), rt.new_int(8))
	mut iife_temp_4 := Class_ParagonIE_Sodium_Core32_Int64{}
	mut iife_result_4 := iife_temp_4.fromreversestring(iife_result_3)
	mut var_k := [iife_result_2, iife_result_4]
	mut var_b := create_paragonie_sodium_core32_int64(rt.create_array([
		rt.ArrayItem{ key: none, val: rt.shift_left(var_inlen, rt.new_int(8)) & 65535 },
		rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 },
	]))
	var_v.array_set(3, rt.call_method(var_v.array_get(rt.new_int(3)), 'xorInt64', [
		var_k[1],
	]))
	var_v.array_set(2, rt.call_method(var_v.array_get(rt.new_int(2)), 'xorInt64', [
		var_k[0],
	]))
	var_v.array_set(1, rt.call_method(var_v.array_get(rt.new_int(1)), 'xorInt64', [
		var_k[1],
	]))
	var_v.array_set(0, rt.call_method(var_v.array_get(rt.new_int(0)), 'xorInt64', [
		var_k[0],
	]))
	mut var_left := var_inlen.clone()
	for rt.is_true(rt.greater_equal(var_left, rt.new_int(8))) {
		mut iife_temp_5 := Class_ParagonIE_Sodium_Core32_SipHash{}
		mut iife_result_5 := iife_temp_5.substr(var_in_mutated.clone(), rt.new_int(0),
			rt.new_int(8))
		mut iife_temp_6 := Class_ParagonIE_Sodium_Core32_Int64{}
		mut iife_result_6 := iife_temp_6.fromreversestring(iife_result_5)
		mut var_m := iife_result_6
		var_v.array_set(3, rt.call_method(var_v.array_get(rt.new_int(3)), 'xorInt64', [
			var_m.clone(),
		]))
		var_v =
			Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
		var_v =
			Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
		var_v.array_set(0, rt.call_method(var_v.array_get(rt.new_int(0)), 'xorInt64', [
			var_m.clone(),
		]))
		mut iife_temp_7 := Class_ParagonIE_Sodium_Core32_SipHash{}
		mut iife_result_7 := iife_temp_7.substr(var_in_mutated.clone(), rt.new_int(8))
		var_in_mutated = iife_result_7
		var_left = rt.sub(var_left, rt.new_int(8))
	}
	mut switch_val_1 := var_left
	if rt.is_true(rt.equal(switch_val_1, rt.new_int(7))) {
		mut iife_temp_8 := Class_ParagonIE_Sodium_Core32_SipHash{}
		mut iife_result_8 := iife_temp_8.chrtoint(var_in_mutated.array_get(rt.new_int(6)))
		mut iife_temp_9 := Class_ParagonIE_Sodium_Core32_Int64{}
		mut iife_result_9 := iife_temp_9.fromints(rt.new_int(0), rt.new_int(rt.shift_left(iife_result_8,
			rt.new_int(16))))
		var_b = rt.call_method(var_b, 'orInt64', [iife_result_9])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(6))) {
		mut iife_temp_10 := Class_ParagonIE_Sodium_Core32_SipHash{}
		mut iife_result_10 := iife_temp_10.chrtoint(var_in_mutated.array_get(rt.new_int(5)))
		mut iife_temp_11 := Class_ParagonIE_Sodium_Core32_Int64{}
		mut iife_result_11 := iife_temp_11.fromints(rt.new_int(0), rt.new_int(rt.shift_left(iife_result_10,
			rt.new_int(8))))
		var_b = rt.call_method(var_b, 'orInt64', [iife_result_11])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(5))) {
		mut iife_temp_12 := Class_ParagonIE_Sodium_Core32_SipHash{}
		mut iife_result_12 := iife_temp_12.chrtoint(var_in_mutated.array_get(rt.new_int(4)))
		mut iife_temp_13 := Class_ParagonIE_Sodium_Core32_Int64{}
		mut iife_result_13 := iife_temp_13.fromints(rt.new_int(0), iife_result_12)
		var_b = rt.call_method(var_b, 'orInt64', [iife_result_13])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(4))) {
		mut iife_temp_14 := Class_ParagonIE_Sodium_Core32_SipHash{}
		mut iife_result_14 := iife_temp_14.chrtoint(var_in_mutated.array_get(rt.new_int(3)))
		mut iife_temp_15 := Class_ParagonIE_Sodium_Core32_Int64{}
		mut iife_result_15 := iife_temp_15.fromints(rt.new_int(rt.shift_left(iife_result_14,
			rt.new_int(24))), rt.new_int(0))
		var_b = rt.call_method(var_b, 'orInt64', [iife_result_15])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(3))) {
		mut iife_temp_16 := Class_ParagonIE_Sodium_Core32_SipHash{}
		mut iife_result_16 := iife_temp_16.chrtoint(var_in_mutated.array_get(rt.new_int(2)))
		mut iife_temp_17 := Class_ParagonIE_Sodium_Core32_Int64{}
		mut iife_result_17 := iife_temp_17.fromints(rt.new_int(rt.shift_left(iife_result_16,
			rt.new_int(16))), rt.new_int(0))
		var_b = rt.call_method(var_b, 'orInt64', [iife_result_17])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
		mut iife_temp_18 := Class_ParagonIE_Sodium_Core32_SipHash{}
		mut iife_result_18 := iife_temp_18.chrtoint(var_in_mutated.array_get(rt.new_int(1)))
		mut iife_temp_19 := Class_ParagonIE_Sodium_Core32_Int64{}
		mut iife_result_19 := iife_temp_19.fromints(rt.new_int(rt.shift_left(iife_result_18,
			rt.new_int(8))), rt.new_int(0))
		var_b = rt.call_method(var_b, 'orInt64', [iife_result_19])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		mut iife_temp_20 := Class_ParagonIE_Sodium_Core32_SipHash{}
		mut iife_result_20 := iife_temp_20.chrtoint(var_in_mutated.array_get(rt.new_int(0)))
		mut iife_temp_21 := Class_ParagonIE_Sodium_Core32_Int64{}
		mut iife_result_21 := iife_temp_21.fromints(iife_result_20, rt.new_int(0))
		var_b = rt.call_method(var_b, 'orInt64', [iife_result_21])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) {
	}
	var_v.array_set(3, rt.call_method(var_v.array_get(rt.new_int(3)), 'xorInt64', [
		var_b.clone(),
	]))
	var_v =
		Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v =
		Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v.array_set(0, rt.call_method(var_v.array_get(rt.new_int(0)), 'xorInt64', [
		var_b.clone(),
	]))
	rt.new_null()
	var_v =
		Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v =
		Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v =
		Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v =
		Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	return rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_v.array_get(rt.new_int(0)),
		'xorInt64', [var_v.array_get(rt.new_int(1))]), 'xorInt64', [
		var_v.array_get(rt.new_int(2)),
	]), 'xorInt64', [var_v.array_get(rt.new_int(3))]), 'toReverseString', []rt.PhpVal{})
}

struct Class_ParagonIE_Sodium_Core32_Util {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int64 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_siphash(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_SipHash {
	mut obj := &Class_ParagonIE_Sodium_Core32_SipHash{
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

fn create_paragonie_sodium_core32_int64(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Int64 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Int64{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_SipHash) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'sipRound' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut dispatch_arg_0)
		}
		'sipHash24' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_SipHash.siphash24(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_SipHash) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_SipHash) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
		rt.new_string('ParagonIE_Sodium_Core32_SipHash'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
