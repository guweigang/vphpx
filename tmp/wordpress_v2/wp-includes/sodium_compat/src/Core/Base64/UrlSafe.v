import rt

struct Class_ParagonIE_Sodium_Core_Base64_UrlSafe {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encode(var_src rt.PhpVal) rt.PhpVal {
	mut var_src_mutated := var_src
	return Class_ParagonIE_Sodium_Core_Base64_UrlSafe.doencode(var_src_mutated.to_bool(),
		rt.new_bool(true))
}

fn Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encodeunpadded(var_src rt.PhpVal) rt.PhpVal {
	mut var_src_mutated := var_src
	return Class_ParagonIE_Sodium_Core_Base64_UrlSafe.doencode(var_src_mutated.to_bool(),
		rt.new_bool(false))
}

fn Class_ParagonIE_Sodium_Core_Base64_UrlSafe.doencode(var_src rt.PhpVal, pad bool) rt.PhpVal {
	mut var_src_mutated := var_src
	mut var_dest := rt.new_string('')
	mut iife_temp_0 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_0 := iife_temp_0.strlen(var_src_mutated.clone())
	mut var_srcLen := iife_result_0
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less_equal(rt.add(var_i, rt.new_int(3)), var_srcLen))) { break
		 }
		mut iife_temp_1 := Class_ParagonIE_Sodium_Core_Util{}
		mut iife_result_1 := iife_temp_1.substr(var_src_mutated.clone(), var_i.clone(),
			rt.new_int(3))
		mut var_chunk := rt.call_function('unpack', [rt.new_string('C*'), iife_result_1])
		mut var_b0 := var_chunk.array_get(rt.new_int(1))
		mut var_b1 := var_chunk.array_get(rt.new_int(2))
		mut var_b2 := var_chunk.array_get(rt.new_int(3))
		var_dest = rt.concat(var_dest, rt.new_string(
			(Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encode6bits(rt.new_int(rt.shift_right(var_b0, rt.new_int(2))))).str() +
			(Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encode6bits(rt.new_int(rt.shift_left(var_b0, rt.new_int(4)) | rt.shift_right(var_b1, rt.new_int(4)) & 63))).str() +
			(Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encode6bits(rt.new_int(rt.shift_left(var_b1, rt.new_int(2)) | rt.shift_right(var_b2, rt.new_int(6)) & 63))).str() +(Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encode6bits(rt.new_int(rt.bitwise_and(var_b2, rt.new_int(63))))).str()))
		var_i = rt.add(var_i, rt.new_int(3))
	}
	if rt.is_true(rt.less(var_i, var_srcLen)) {
		mut iife_temp_2 := Class_ParagonIE_Sodium_Core_Util{}
		mut iife_result_2 := iife_temp_2.substr(var_src_mutated.clone(), var_i.clone(), rt.sub(var_srcLen,
			var_i))
		mut var_chunk := rt.call_function('unpack', [rt.new_string('C*'), iife_result_2])
		mut var_b0 := var_chunk.array_get(rt.new_int(1))
		if rt.is_true(rt.less(rt.add(var_i, rt.new_int(1)), var_srcLen)) {
			mut var_b1 := var_chunk.array_get(rt.new_int(2))
			var_dest = rt.concat(var_dest, rt.new_string(
				(Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encode6bits(rt.new_int(rt.shift_right(var_b0, rt.new_int(2))))).str() +
				(Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encode6bits(rt.new_int(rt.shift_left(var_b0, rt.new_int(4)) | rt.shift_right(var_b1, rt.new_int(4)) & 63))).str() +(Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encode6bits(rt.new_int(rt.shift_left(var_b1, rt.new_int(2)) & 63))).str()))
			if var_pad {
				var_dest = rt.concat(var_dest, rt.new_string('='))
			}
		} else {
			var_dest = rt.concat(var_dest, rt.new_string(
				(Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encode6bits(rt.new_int(rt.shift_right(var_b0, rt.new_int(2))))).str() +(Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encode6bits(rt.new_int(rt.shift_left(var_b0, rt.new_int(4)) & 63))).str()))
			if var_pad {
				var_dest = rt.concat(var_dest, rt.new_string('=='))
			}
		}
	}
	return var_dest.clone()
}

fn Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decode(var_src rt.PhpVal, strictPadding bool) string {
	mut var_src_mutated := var_src
	mut iife_temp_3 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_3 := iife_temp_3.strlen(var_src_mutated.clone())
	mut var_srcLen := iife_result_3
	if rt.is_true(rt.identical(var_srcLen, rt.new_int(0))) {
		return ''
	}
	if var_strictPadding {
		if rt.bitwise_and(var_srcLen, rt.new_int(3)) == 0 {
			if rt.is_true(rt.identical(var_src_mutated.array_get(rt.sub(var_srcLen, rt.new_int(1))),
				rt.new_string('=')))
			{
				rt.post_dec(var_srcLen)
				if rt.is_true(rt.identical(var_src_mutated.array_get(rt.sub(var_srcLen,
					rt.new_int(1))), rt.new_string('=')))
				{
					rt.post_dec(var_srcLen)
				}
			}
		}
		if rt.bitwise_and(var_srcLen, rt.new_int(3)) == 1 {
			rt.throw_exception(rt.new_object('RangeException', []string{},
				create_rangeexception(rt.new_string('Incorrect padding'))))
		}
		if rt.is_true(rt.identical(var_src_mutated.array_get(rt.sub(var_srcLen, rt.new_int(1))),
			rt.new_string('=')))
		{
			rt.throw_exception(rt.new_object('RangeException', []string{},
				create_rangeexception(rt.new_string('Incorrect padding'))))
		}
	} else {
		var_src_mutated = rt.new_string(var_src_mutated.clone().to_string().trim_right(' \t\n\r'))
		mut iife_temp_4 := Class_ParagonIE_Sodium_Core_Util{}
		mut iife_result_4 := iife_temp_4.strlen(var_src_mutated.clone())
		var_srcLen = iife_result_4
	}
	mut var_err := rt.new_int(0)
	mut var_dest := rt.new_string('')
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less_equal(rt.add(var_i, rt.new_int(4)), var_srcLen))) { break
		 }
		mut iife_temp_5 := Class_ParagonIE_Sodium_Core_Util{}
		mut iife_result_5 := iife_temp_5.substr(var_src_mutated.clone(), var_i.clone(),
			rt.new_int(4))
		mut var_chunk := rt.call_function('unpack', [rt.new_string('C*'), iife_result_5])
		mut var_c0 :=
			Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decode6bits(var_chunk.array_get(rt.new_int(1)))
		mut var_c1 :=
			Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decode6bits(var_chunk.array_get(rt.new_int(2)))
		mut var_c2 :=
			Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decode6bits(var_chunk.array_get(rt.new_int(3)))
		mut var_c3 :=
			Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decode6bits(var_chunk.array_get(rt.new_int(4)))
		var_dest = rt.concat(var_dest, rt.call_function('pack', [
			rt.new_string('CCC'),
			rt.shift_left(var_c0, rt.new_int(2)) | rt.shift_right(var_c1,
				rt.new_int(4)) & 255,
			rt.shift_left(var_c1, rt.new_int(4)) | rt.shift_right(var_c2, rt.new_int(2)) & 255,
			rt.bitwise_or(rt.shift_left(var_c2, rt.new_int(6)), var_c3) & 255]))
		rt.new_null()
		var_i = rt.add(var_i, rt.new_int(4))
	}
	if rt.is_true(rt.less(var_i, var_srcLen)) {
		mut iife_temp_6 := Class_ParagonIE_Sodium_Core_Util{}
		mut iife_result_6 := iife_temp_6.substr(var_src_mutated.clone(), var_i.clone(), rt.sub(var_srcLen,
			var_i))
		mut var_chunk := rt.call_function('unpack', [rt.new_string('C*'), iife_result_6])
		mut var_c0 :=
			Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decode6bits(var_chunk.array_get(rt.new_int(1)))
		if rt.is_true(rt.less(rt.add(var_i, rt.new_int(2)), var_srcLen)) {
			mut var_c1 :=
				Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decode6bits(var_chunk.array_get(rt.new_int(2)))
			mut var_c2 :=
				Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decode6bits(var_chunk.array_get(rt.new_int(3)))
			var_dest = rt.concat(var_dest, rt.call_function('pack', [
				rt.new_string('CC'),
				rt.shift_left(var_c0, rt.new_int(2)) | rt.shift_right(var_c1,
					rt.new_int(4)) & 255,
				rt.shift_left(var_c1, rt.new_int(4)) | rt.shift_right(var_c2, rt.new_int(2)) & 255]))
			rt.new_null()
		} else if rt.is_true(rt.less(rt.add(var_i, rt.new_int(1)), var_srcLen)) {
			var_c1 =
				Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decode6bits(var_chunk.array_get(rt.new_int(2)))
			var_dest = rt.concat(var_dest, rt.call_function('pack', [
				rt.new_string('C'),
				rt.shift_left(var_c0, rt.new_int(2)) | rt.shift_right(var_c1,
					rt.new_int(4)) & 255]))
			rt.new_null()
		} else if rt.is_true(rt.less(var_i, var_srcLen)) && var_strictPadding {
			rt.new_null()
		}
	}
	mut var_check := rt.identical(var_err, rt.new_int(0))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_check)))) {
		rt.throw_exception(rt.new_object('RangeException', []string{},
			create_rangeexception(rt.new_string('Base64::decode() only expects characters in the correct base64 alphabet'))))
	}
	return var_dest.str()
}

fn Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decodenopadding(var_encodedString rt.PhpVal) string {
	mut var_srcLen := rt.new_int(var_encodedString.clone().to_string().len)
	if rt.is_true(rt.identical(var_srcLen, rt.new_int(0))) {
		return ''
	}
	if rt.bitwise_and(var_srcLen, rt.new_int(3)) == 0 {
		if rt.is_true(rt.identical(var_encodedString.array_get(rt.sub(var_srcLen, rt.new_int(1))), rt.new_string('=')))
			|| rt.is_true(rt.identical(var_encodedString.array_get(rt.sub(var_srcLen, rt.new_int(2))), rt.new_string('='))) {
			rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
				create_invalidargumentexception(rt.new_string("decodeNoPadding() doesn't tolerate padding"))))
		}
	}
	return (Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decode(var_encodedString.to_bool(),
		rt.new_bool(true))).str()
}

fn Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decode6bits(var_src rt.PhpVal) rt.PhpVal {
	mut var_src_mutated := var_src
	mut var_ret := rt.new_int(-1)
	var_ret = rt.add(var_ret, rt.bitwise_and(rt.bitwise_and(rt.sub(rt.new_int(64), var_src_mutated), rt.sub(var_src_mutated,
		rt.new_int(91))) >> 8, rt.sub(var_src_mutated, rt.new_int(64))))
	var_ret = rt.add(var_ret, rt.bitwise_and(rt.bitwise_and(rt.sub(rt.new_int(96), var_src_mutated), rt.sub(var_src_mutated,
		rt.new_int(123))) >> 8, rt.sub(var_src_mutated, rt.new_int(70))))
	var_ret = rt.add(var_ret, rt.bitwise_and(rt.bitwise_and(rt.sub(rt.new_int(47), var_src_mutated), rt.sub(var_src_mutated,
		rt.new_int(58))) >> 8, rt.add(var_src_mutated, rt.new_int(5))))
	var_ret = rt.add(var_ret, rt.bitwise_and(rt.sub(rt.new_int(44), var_src_mutated), rt.sub(var_src_mutated,
		rt.new_int(46))) >> 8 & 63)
	var_ret = rt.add(var_ret, rt.bitwise_and(rt.sub(rt.new_int(94), var_src_mutated), rt.sub(var_src_mutated,
		rt.new_int(96))) >> 8 & 64)
	return var_ret.clone()
}

fn Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encode6bits(var_src rt.PhpVal) rt.PhpVal {
	mut var_src_mutated := var_src
	mut var_diff := rt.new_int(65)
	var_diff = rt.add(var_diff, rt.shift_right(rt.sub(rt.new_int(25), var_src_mutated),
		rt.new_int(8)) & 6)
	var_diff = rt.sub(var_diff, rt.shift_right(rt.sub(rt.new_int(51), var_src_mutated),
		rt.new_int(8)) & 75)
	var_diff = rt.sub(var_diff, rt.shift_right(rt.sub(rt.new_int(61), var_src_mutated),
		rt.new_int(8)) & 13)
	var_diff = rt.add(var_diff, rt.shift_right(rt.sub(rt.new_int(62), var_src_mutated),
		rt.new_int(8)) & 49)
	return rt.call_function('pack', [rt.new_string('C'), rt.add(var_src_mutated, var_diff)])
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

struct Class_RangeException {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_base64_urlsafe(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Base64_UrlSafe {
	mut obj := &Class_ParagonIE_Sodium_Core_Base64_UrlSafe{
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

fn create_rangeexception(_args ...rt.PhpVal) &Class_RangeException {
	mut obj := &Class_RangeException{
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

fn (mut this Class_ParagonIE_Sodium_Core_Base64_UrlSafe) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'encode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encode(dispatch_arg_0)
		}
		'encodeUnpadded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encodeunpadded(dispatch_arg_0)
		}
		'doEncode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_ParagonIE_Sodium_Core_Base64_UrlSafe.doencode(dispatch_arg_0,
				dispatch_arg_1)
		}
		'decode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decode(dispatch_arg_0,
				dispatch_arg_1))
		}
		'decodeNoPadding' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decodenopadding(dispatch_arg_0))
		}
		'decode6Bits' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Base64_UrlSafe.decode6bits(dispatch_arg_0)
		}
		'encode6Bits' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Base64_UrlSafe.encode6bits(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_ParagonIE_Sodium_Core_Base64_UrlSafe) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Base64_UrlSafe) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_RangeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RangeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RangeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
