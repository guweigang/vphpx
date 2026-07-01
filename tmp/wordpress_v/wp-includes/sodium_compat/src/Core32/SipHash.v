import rt

struct Class_ParagonIE_Sodium_Core32_SipHash {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut var_v Class_array) rt.PhpVal {
	mut var_v_mutated := var_v
	var_v_mutated.array_set(0, rt.call_method(var_v_mutated.array_get(0), 'addInt64', [
		var_v_mutated.array_get(1),
	]))
	var_v_mutated.array_set(1, rt.call_method(var_v_mutated.array_get(1), 'rotateLeft', [
		rt.new_int(13),
	]))
	var_v_mutated.array_set(1, rt.call_method(var_v_mutated.array_get(1), 'xorInt64', [
		var_v_mutated.array_get(0),
	]))
	var_v_mutated.array_set(0, rt.call_method(var_v_mutated.array_get(0), 'rotateLeft', [
		rt.new_int(32),
	]))
	var_v_mutated.array_set(2, rt.call_method(var_v_mutated.array_get(2), 'addInt64', [
		var_v_mutated.array_get(3),
	]))
	var_v_mutated.array_set(3, rt.call_method(var_v_mutated.array_get(3), 'rotateLeft', [
		rt.new_int(16),
	]))
	var_v_mutated.array_set(3, rt.call_method(var_v_mutated.array_get(3), 'xorInt64', [
		var_v_mutated.array_get(2),
	]))
	var_v_mutated.array_set(0, rt.call_method(var_v_mutated.array_get(0), 'addInt64', [
		var_v_mutated.array_get(3),
	]))
	var_v_mutated.array_set(3, rt.call_method(var_v_mutated.array_get(3), 'rotateLeft', [
		rt.new_int(21),
	]))
	var_v_mutated.array_set(3, rt.call_method(var_v_mutated.array_get(3), 'xorInt64', [
		var_v_mutated.array_get(0),
	]))
	var_v_mutated.array_set(2, rt.call_method(var_v_mutated.array_get(2), 'addInt64', [
		var_v_mutated.array_get(1),
	]))
	var_v_mutated.array_set(1, rt.call_method(var_v_mutated.array_get(1), 'rotateLeft', [
		rt.new_int(17),
	]))
	var_v_mutated.array_set(1, rt.call_method(var_v_mutated.array_get(1), 'xorInt64', [
		var_v_mutated.array_get(2),
	]))
	var_v_mutated.array_set(2, rt.call_method(var_v_mutated.array_get(2), 'rotateLeft', [
		rt.new_int(32),
	]))
	return rt.new_object('array', []string{}, var_v_mutated)
}

fn Class_ParagonIE_Sodium_Core32_SipHash.siphash24(var_in rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_in_mutated := var_in
	mut var_inlen := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_SipHash{}
		return temp.strlen(arg_0)
	}(var_in_mutated.dup())
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
	mut var_k := [fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Int64{}
		return temp.fromreversestring(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_SipHash{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_key.dup(), rt.new_int(0), rt.new_int(8))),
		fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_Int64{}
			return temp.fromreversestring(arg_0)
		}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_SipHash{}
			return temp.substr(arg_0, arg_1, arg_2)
		}(var_key.dup(), rt.new_int(8), rt.new_int(8)))]
	mut var_b := create_paragonie_sodium_core32_int64(rt.create_array([
		rt.ArrayItem{ key: none, val: rt.shift_left(var_inlen, rt.new_int(8)) & 65535 },
		rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 },
		rt.ArrayItem{ key: none, val: 0 },
	]))
	var_v.array_set(3, rt.call_method(var_v.array_get(3), 'xorInt64', [
		var_k.array_get(1)]))
	var_v.array_set(2, rt.call_method(var_v.array_get(2), 'xorInt64', [
		var_k.array_get(0)]))
	var_v.array_set(1, rt.call_method(var_v.array_get(1), 'xorInt64', [
		var_k.array_get(1)]))
	var_v.array_set(0, rt.call_method(var_v.array_get(0), 'xorInt64', [
		var_k.array_get(0)]))
	mut var_left := var_inlen.dup()
	for rt.is_true(rt.greater_equal(var_left, rt.new_int(8))) {
		mut var_m := fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_Int64{}
			return temp.fromreversestring(arg_0)
		}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_SipHash{}
			return temp.substr(arg_0, arg_1, arg_2)
		}(var_in_mutated.dup(), rt.new_int(0), rt.new_int(8)))
		var_v.array_set(3, rt.call_method(var_v.array_get(3), 'xorInt64', [
			var_m.dup()]))
		var_v =
			Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
		var_v =
			Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
		var_v.array_set(0, rt.call_method(var_v.array_get(0), 'xorInt64', [
			var_m.dup()]))
		var_in_mutated = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_SipHash{}
			return temp.substr(arg_0, arg_1)
		}(var_in_mutated.dup(), rt.new_int(8))
		// unsupported expression: Expr_AssignOp_Minus
	}
	mut switch_val_1 := var_left
	if rt.is_true(rt.equal(switch_val_1, rt.new_int(7))) {
		var_b = rt.call_method(var_b, 'orInt64', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_Int64{}
			return temp.fromints(arg_0, arg_1)
		}(rt.new_int(0), rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_SipHash{}
			return temp.chrtoint(arg_0)
		}(var_in_mutated.array_get(6)), rt.new_int(16))))])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(6))) {
		var_b = rt.call_method(var_b, 'orInt64', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_Int64{}
			return temp.fromints(arg_0, arg_1)
		}(rt.new_int(0), rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_SipHash{}
			return temp.chrtoint(arg_0)
		}(var_in_mutated.array_get(5)), rt.new_int(8))))])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(5))) {
		var_b = rt.call_method(var_b, 'orInt64', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_Int64{}
			return temp.fromints(arg_0, arg_1)
		}(rt.new_int(0), fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_SipHash{}
			return temp.chrtoint(arg_0)
		}(var_in_mutated.array_get(4)))])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(4))) {
		var_b = rt.call_method(var_b, 'orInt64', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_Int64{}
			return temp.fromints(arg_0, arg_1)
		}(rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_SipHash{}
			return temp.chrtoint(arg_0)
		}(var_in_mutated.array_get(3)), rt.new_int(24))), rt.new_int(0))])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(3))) {
		var_b = rt.call_method(var_b, 'orInt64', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_Int64{}
			return temp.fromints(arg_0, arg_1)
		}(rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_SipHash{}
			return temp.chrtoint(arg_0)
		}(var_in_mutated.array_get(2)), rt.new_int(16))), rt.new_int(0))])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
		var_b = rt.call_method(var_b, 'orInt64', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_Int64{}
			return temp.fromints(arg_0, arg_1)
		}(rt.new_int(rt.shift_left(fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_SipHash{}
			return temp.chrtoint(arg_0)
		}(var_in_mutated.array_get(1)), rt.new_int(8))), rt.new_int(0))])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		var_b = rt.call_method(var_b, 'orInt64', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_Int64{}
			return temp.fromints(arg_0, arg_1)
		}(fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_SipHash{}
			return temp.chrtoint(arg_0)
		}(var_in_mutated.array_get(0)), rt.new_int(0))])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) {
	}
	var_v.array_set(3, rt.call_method(var_v.array_get(3), 'xorInt64', [
		var_b.dup()]))
	var_v =
		Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v =
		Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v.array_set(0, rt.call_method(var_v.array_get(0), 'xorInt64', [
		var_b.dup()]))
	// unsupported expression: Expr_AssignOp_BitwiseXor
	var_v =
		Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v =
		Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v =
		Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	var_v =
		Class_ParagonIE_Sodium_Core32_SipHash.sipround(mut rt.cast_object_ptr[Class_array](var_v))
	return rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_v.array_get(0),
		'xorInt64', [var_v.array_get(1)]), 'xorInt64', [var_v.array_get(2)]), 'xorInt64', [
		var_v.array_get(3),
	]), 'toReverseString', []rt.PhpVal{})
}

struct Class_ParagonIE_Sodium_Core32_Util {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int64 {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_siphash() &Class_ParagonIE_Sodium_Core32_SipHash {
	mut obj := &Class_ParagonIE_Sodium_Core32_SipHash{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_util() &Class_ParagonIE_Sodium_Core32_Util {
	mut obj := &Class_ParagonIE_Sodium_Core32_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_int64() &Class_ParagonIE_Sodium_Core32_Int64 {
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

pub fn init_wp_includes_sodium_compat_src_core32_siphash_php() {
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core32_SipHash'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
