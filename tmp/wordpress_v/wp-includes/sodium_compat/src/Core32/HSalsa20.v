import rt

struct Class_ParagonIE_Sodium_Core32_HSalsa20 {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core32_HSalsa20.hsalsa20(var_in rt.PhpVal, var_k rt.PhpVal, var_c rt.PhpVal) string {
	if rt.is_true(rt.less(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		return temp.strlen(arg_0)
	}(var_k.dup()), rt.new_int(32)))
	{
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
		var_x0 = fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
			return temp.fromreversestring(arg_0)
		}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
			return temp.substr(arg_0, arg_1, arg_2)
		}(var_c.dup(), rt.new_int(0), rt.new_int(4)))
		var_x5 = fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
			return temp.fromreversestring(arg_0)
		}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
			return temp.substr(arg_0, arg_1, arg_2)
		}(var_c.dup(), rt.new_int(4), rt.new_int(4)))
		var_x10 = fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
			return temp.fromreversestring(arg_0)
		}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
			return temp.substr(arg_0, arg_1, arg_2)
		}(var_c.dup(), rt.new_int(8), rt.new_int(4)))
		var_x15 = fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
			return temp.fromreversestring(arg_0)
		}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
			return temp.substr(arg_0, arg_1, arg_2)
		}(var_c.dup(), rt.new_int(12), rt.new_int(4)))
	}
	mut var_x1 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
		return temp.fromreversestring(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(0), rt.new_int(4)))
	mut var_x2 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
		return temp.fromreversestring(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(4), rt.new_int(4)))
	mut var_x3 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
		return temp.fromreversestring(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(8), rt.new_int(4)))
	mut var_x4 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
		return temp.fromreversestring(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(12), rt.new_int(4)))
	mut var_x6 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
		return temp.fromreversestring(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_in.dup(), rt.new_int(0), rt.new_int(4)))
	mut var_x7 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
		return temp.fromreversestring(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_in.dup(), rt.new_int(4), rt.new_int(4)))
	mut var_x8 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
		return temp.fromreversestring(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_in.dup(), rt.new_int(8), rt.new_int(4)))
	mut var_x9 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
		return temp.fromreversestring(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_in.dup(), rt.new_int(12), rt.new_int(4)))
	mut var_x11 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
		return temp.fromreversestring(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(16), rt.new_int(4)))
	mut var_x12 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
		return temp.fromreversestring(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(20), rt.new_int(4)))
	mut var_x13 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
		return temp.fromreversestring(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(24), rt.new_int(4)))
	mut var_x14 := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_Int32{}
		return temp.fromreversestring(arg_0)
	}(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
		mut temp := Class_ParagonIE_Sodium_Core32_HSalsa20{}
		return temp.substr(arg_0, arg_1, arg_2)
	}(var_k.dup(), rt.new_int(28), rt.new_int(4)))
	{
		mut var_i := Class_ParagonIE_Sodium_Core32_HSalsa20.rounds()
		for {
			if !(rt.is_true(rt.greater(var_i, rt.new_int(0)))) { break
			 }
			var_x4 = rt.call_method(var_x4, 'xorInt32', [
				rt.call_method(rt.call_method(var_x0, 'addInt32', [
					var_x12.dup()]), 'rotateLeft', [rt.new_int(7)]),
			])
			var_x8 = rt.call_method(var_x8, 'xorInt32', [
				rt.call_method(rt.call_method(var_x4, 'addInt32', [
					var_x0.dup()]), 'rotateLeft', [rt.new_int(9)]),
			])
			var_x12 = rt.call_method(var_x12, 'xorInt32', [
				rt.call_method(rt.call_method(var_x8, 'addInt32', [
					var_x4.dup()]), 'rotateLeft', [rt.new_int(13)]),
			])
			var_x0 = rt.call_method(var_x0, 'xorInt32', [
				rt.call_method(rt.call_method(var_x12, 'addInt32', [
					var_x8.dup()]), 'rotateLeft', [rt.new_int(18)]),
			])
			var_x9 = rt.call_method(var_x9, 'xorInt32', [
				rt.call_method(rt.call_method(var_x5, 'addInt32', [
					var_x1.dup()]), 'rotateLeft', [rt.new_int(7)]),
			])
			var_x13 = rt.call_method(var_x13, 'xorInt32', [
				rt.call_method(rt.call_method(var_x9, 'addInt32', [
					var_x5.dup()]), 'rotateLeft', [rt.new_int(9)]),
			])
			var_x1 = rt.call_method(var_x1, 'xorInt32', [
				rt.call_method(rt.call_method(var_x13, 'addInt32', [
					var_x9.dup()]), 'rotateLeft', [rt.new_int(13)]),
			])
			var_x5 = rt.call_method(var_x5, 'xorInt32', [
				rt.call_method(rt.call_method(var_x1, 'addInt32', [
					var_x13.dup()]), 'rotateLeft', [rt.new_int(18)]),
			])
			var_x14 = rt.call_method(var_x14, 'xorInt32', [
				rt.call_method(rt.call_method(var_x10, 'addInt32', [
					var_x6.dup()]), 'rotateLeft', [rt.new_int(7)]),
			])
			var_x2 = rt.call_method(var_x2, 'xorInt32', [
				rt.call_method(rt.call_method(var_x14, 'addInt32', [
					var_x10.dup()]), 'rotateLeft', [rt.new_int(9)]),
			])
			var_x6 = rt.call_method(var_x6, 'xorInt32', [
				rt.call_method(rt.call_method(var_x2, 'addInt32', [
					var_x14.dup()]), 'rotateLeft', [rt.new_int(13)]),
			])
			var_x10 = rt.call_method(var_x10, 'xorInt32', [
				rt.call_method(rt.call_method(var_x6, 'addInt32', [
					var_x2.dup()]), 'rotateLeft', [rt.new_int(18)]),
			])
			var_x3 = rt.call_method(var_x3, 'xorInt32', [
				rt.call_method(rt.call_method(var_x15, 'addInt32', [
					var_x11.dup()]), 'rotateLeft', [rt.new_int(7)]),
			])
			var_x7 = rt.call_method(var_x7, 'xorInt32', [
				rt.call_method(rt.call_method(var_x3, 'addInt32', [
					var_x15.dup()]), 'rotateLeft', [rt.new_int(9)]),
			])
			var_x11 = rt.call_method(var_x11, 'xorInt32', [
				rt.call_method(rt.call_method(var_x7, 'addInt32', [
					var_x3.dup()]), 'rotateLeft', [rt.new_int(13)]),
			])
			var_x15 = rt.call_method(var_x15, 'xorInt32', [
				rt.call_method(rt.call_method(var_x11, 'addInt32', [
					var_x7.dup()]), 'rotateLeft', [rt.new_int(18)]),
			])
			var_x1 = rt.call_method(var_x1, 'xorInt32', [
				rt.call_method(rt.call_method(var_x0, 'addInt32', [
					var_x3.dup()]), 'rotateLeft', [rt.new_int(7)]),
			])
			var_x2 = rt.call_method(var_x2, 'xorInt32', [
				rt.call_method(rt.call_method(var_x1, 'addInt32', [
					var_x0.dup()]), 'rotateLeft', [rt.new_int(9)]),
			])
			var_x3 = rt.call_method(var_x3, 'xorInt32', [
				rt.call_method(rt.call_method(var_x2, 'addInt32', [
					var_x1.dup()]), 'rotateLeft', [rt.new_int(13)]),
			])
			var_x0 = rt.call_method(var_x0, 'xorInt32', [
				rt.call_method(rt.call_method(var_x3, 'addInt32', [
					var_x2.dup()]), 'rotateLeft', [rt.new_int(18)]),
			])
			var_x6 = rt.call_method(var_x6, 'xorInt32', [
				rt.call_method(rt.call_method(var_x5, 'addInt32', [
					var_x4.dup()]), 'rotateLeft', [rt.new_int(7)]),
			])
			var_x7 = rt.call_method(var_x7, 'xorInt32', [
				rt.call_method(rt.call_method(var_x6, 'addInt32', [
					var_x5.dup()]), 'rotateLeft', [rt.new_int(9)]),
			])
			var_x4 = rt.call_method(var_x4, 'xorInt32', [
				rt.call_method(rt.call_method(var_x7, 'addInt32', [
					var_x6.dup()]), 'rotateLeft', [rt.new_int(13)]),
			])
			var_x5 = rt.call_method(var_x5, 'xorInt32', [
				rt.call_method(rt.call_method(var_x4, 'addInt32', [
					var_x7.dup()]), 'rotateLeft', [rt.new_int(18)]),
			])
			var_x11 = rt.call_method(var_x11, 'xorInt32', [
				rt.call_method(rt.call_method(var_x10, 'addInt32', [
					var_x9.dup()]), 'rotateLeft', [rt.new_int(7)]),
			])
			var_x8 = rt.call_method(var_x8, 'xorInt32', [
				rt.call_method(rt.call_method(var_x11, 'addInt32', [
					var_x10.dup()]), 'rotateLeft', [rt.new_int(9)]),
			])
			var_x9 = rt.call_method(var_x9, 'xorInt32', [
				rt.call_method(rt.call_method(var_x8, 'addInt32', [
					var_x11.dup()]), 'rotateLeft', [rt.new_int(13)]),
			])
			var_x10 = rt.call_method(var_x10, 'xorInt32', [
				rt.call_method(rt.call_method(var_x9, 'addInt32', [
					var_x8.dup()]), 'rotateLeft', [rt.new_int(18)]),
			])
			var_x12 = rt.call_method(var_x12, 'xorInt32', [
				rt.call_method(rt.call_method(var_x15, 'addInt32', [
					var_x14.dup()]), 'rotateLeft', [rt.new_int(7)]),
			])
			var_x13 = rt.call_method(var_x13, 'xorInt32', [
				rt.call_method(rt.call_method(var_x12, 'addInt32', [
					var_x15.dup()]), 'rotateLeft', [rt.new_int(9)]),
			])
			var_x14 = rt.call_method(var_x14, 'xorInt32', [
				rt.call_method(rt.call_method(var_x13, 'addInt32', [
					var_x12.dup()]), 'rotateLeft', [rt.new_int(13)]),
			])
			var_x15 = rt.call_method(var_x15, 'xorInt32', [
				rt.call_method(rt.call_method(var_x14, 'addInt32', [
					var_x13.dup()]), 'rotateLeft', [rt.new_int(18)]),
			])
			// unsupported expression: Expr_AssignOp_Minus
		}
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

fn create_paragonie_sodium_core32_hsalsa20() &Class_ParagonIE_Sodium_Core32_HSalsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_HSalsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_salsa20() &Class_ParagonIE_Sodium_Core32_Salsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Salsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_rangeexception() &Class_RangeException {
	mut obj := &Class_RangeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_int32() &Class_ParagonIE_Sodium_Core32_Int32 {
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

pub fn init_wp_includes_sodium_compat_src_core32_hsalsa20_php() {
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core32_HSalsa20'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
