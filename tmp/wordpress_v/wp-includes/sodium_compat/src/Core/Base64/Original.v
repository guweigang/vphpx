import rt

struct Class_ParagonIE_Sodium_Core_Base64_Original {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_Base64_Original.encode(var_src rt.PhpVal) rt.PhpVal {
	mut var_src_mutated := var_src
	return Class_ParagonIE_Sodium_Core_Base64_Original.doencode((var_src_mutated).to_bool(), rt.new_bool(true))
}

fn Class_ParagonIE_Sodium_Core_Base64_Original.encodeunpadded(var_src rt.PhpVal) rt.PhpVal {
	mut var_src_mutated := var_src
	return Class_ParagonIE_Sodium_Core_Base64_Original.doencode((var_src_mutated).to_bool(), rt.new_bool(false))
}

fn Class_ParagonIE_Sodium_Core_Base64_Original.doencode(var_src rt.PhpVal, pad bool) rt.PhpVal {
	mut var_src_mutated := var_src
	mut var_dest := rt.new_string(rt.new_string(''))
	mut var_srcLen := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.strlen(arg_0) }(var_src_mutated.dup())
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less_equal(rt.add(var_i, rt.new_int(3)), var_srcLen))) { break }
			mut var_chunk := rt.call_function('unpack', [rt.new_string('C*'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(var_src_mutated.dup(), var_i.dup(), rt.new_int(3))])
			mut var_b0 := var_chunk.array_get(1)
			mut var_b1 := var_chunk.array_get(2)
			mut var_b2 := var_chunk.array_get(3)
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	if rt.is_true(rt.less(var_i, var_srcLen)) {
		mut var_chunk := rt.call_function('unpack', [rt.new_string('C*'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(var_src_mutated.dup(), var_i.dup(), rt.sub(var_srcLen, var_i))])
		mut var_b0 := var_chunk.array_get(1)
		if rt.is_true(rt.less(rt.add(var_i, rt.new_int(1)), var_srcLen)) {
			mut var_b1 := var_chunk.array_get(2)
			// unsupported expression: Expr_AssignOp_Concat
			if var_pad {
				// unsupported expression: Expr_AssignOp_Concat
			}
		} else {
			// unsupported expression: Expr_AssignOp_Concat
			if var_pad {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	return var_dest.dup()
}

fn Class_ParagonIE_Sodium_Core_Base64_Original.decode(var_src rt.PhpVal, strictPadding bool) string {
	mut var_src_mutated := var_src
	mut var_srcLen := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.strlen(arg_0) }(var_src_mutated.dup())
	if rt.is_true(rt.identical(var_srcLen, rt.new_int(0))) {
		return ''
	}
	if var_strictPadding {
		if rt.bitwise_and(var_srcLen, rt.new_int(3)) == 0 {
			if rt.is_true(rt.identical(var_src_mutated.array_get(rt.sub(var_srcLen, rt.new_int(1))), rt.new_string('='))) {
				rt.post_dec(var_srcLen)
				if rt.is_true(rt.identical(var_src_mutated.array_get(rt.sub(var_srcLen, rt.new_int(1))), rt.new_string('='))) {
					rt.post_dec(var_srcLen)
				}
			}
		}
		if rt.bitwise_and(var_srcLen, rt.new_int(3)) == 1 {
			rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(rt.new_string('Incorrect padding'))))
		}
		if rt.is_true(rt.identical(var_src_mutated.array_get(rt.sub(var_srcLen, rt.new_int(1))), rt.new_string('='))) {
			rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(rt.new_string('Incorrect padding'))))
		}
	} else {
		var_src_mutated = rt.new_string(rt.new_string(var_src_mutated.dup().to_string().trim_right(' \t\n\r')))
		var_srcLen = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.strlen(arg_0) }(var_src_mutated.dup())
	}
	mut var_err := rt.new_int(rt.new_int(0))
	mut var_dest := rt.new_string(rt.new_string(''))
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less_equal(rt.add(var_i, rt.new_int(4)), var_srcLen))) { break }
			mut var_chunk := rt.call_function('unpack', [rt.new_string('C*'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(var_src_mutated.dup(), var_i.dup(), rt.new_int(4))])
			mut var_c0 := Class_ParagonIE_Sodium_Core_Base64_Original.decode6bits(var_chunk.array_get(1))
			mut var_c1 := Class_ParagonIE_Sodium_Core_Base64_Original.decode6bits(var_chunk.array_get(2))
			mut var_c2 := Class_ParagonIE_Sodium_Core_Base64_Original.decode6bits(var_chunk.array_get(3))
			mut var_c3 := Class_ParagonIE_Sodium_Core_Base64_Original.decode6bits(var_chunk.array_get(4))
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_BitwiseOr
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	if rt.is_true(rt.less(var_i, var_srcLen)) {
		mut var_chunk := rt.call_function('unpack', [rt.new_string('C*'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core_Util{}; return temp.substr(arg_0, arg_1, arg_2) }(var_src_mutated.dup(), var_i.dup(), rt.sub(var_srcLen, var_i))])
		mut var_c0 := Class_ParagonIE_Sodium_Core_Base64_Original.decode6bits(var_chunk.array_get(1))
		if rt.is_true(rt.less(rt.add(var_i, rt.new_int(2)), var_srcLen)) {
			mut var_c1 := Class_ParagonIE_Sodium_Core_Base64_Original.decode6bits(var_chunk.array_get(2))
			mut var_c2 := Class_ParagonIE_Sodium_Core_Base64_Original.decode6bits(var_chunk.array_get(3))
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_BitwiseOr
		} else if rt.is_true(rt.less(rt.add(var_i, rt.new_int(1)), var_srcLen)) {
			var_c1 = Class_ParagonIE_Sodium_Core_Base64_Original.decode6bits(var_chunk.array_get(2))
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_BitwiseOr
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_i, var_srcLen)) && var_strictPadding)) {
			// unsupported expression: Expr_AssignOp_BitwiseOr
		}
	}
	mut var_check := rt.identical(var_err, rt.new_int(0))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_check)))) {
		rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(rt.new_string('Base64::decode() only expects characters in the correct base64 alphabet'))))
	}
	return (var_dest).str()
}

fn Class_ParagonIE_Sodium_Core_Base64_Original.decodenopadding(var_encodedString rt.PhpVal) string {
	mut var_srcLen := rt.new_null()
	var_srcLen = rt.new_int(rt.new_int(var_encodedString.dup().to_string().len))
	if rt.is_true(rt.identical(var_srcLen, rt.new_int(0))) {
		return ''
	}
	if rt.bitwise_and(var_srcLen, rt.new_int(3)) == 0 {
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_encodedString.array_get(rt.sub(var_srcLen, rt.new_int(1))), rt.new_string('='))) || rt.is_true(rt.identical(var_encodedString.array_get(rt.sub(var_srcLen, rt.new_int(2))), rt.new_string('='))))) {
			rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('decodeNoPadding() doesn\'t tolerate padding'))))
		}
	}
	return (Class_ParagonIE_Sodium_Core_Base64_Original.decode((var_encodedString).to_bool(), rt.new_bool(true))).str()
}

fn Class_ParagonIE_Sodium_Core_Base64_Original.decode6bits(var_src rt.PhpVal) rt.PhpVal {
	mut var_src_mutated := var_src
	mut var_ret := // unsupported expression: Expr_UnaryMinus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	return var_ret.dup()
}

fn Class_ParagonIE_Sodium_Core_Base64_Original.encode6bits(var_src rt.PhpVal) rt.PhpVal {
	mut var_src_mutated := var_src
	mut var_diff := rt.new_int(rt.new_int(65))
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Minus
	// unsupported expression: Expr_AssignOp_Minus
	// unsupported expression: Expr_AssignOp_Plus
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

fn create_paragonie_sodium_core_base64_original() &Class_ParagonIE_Sodium_Core_Base64_Original {
	mut obj := &Class_ParagonIE_Sodium_Core_Base64_Original{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_util() &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
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

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core_Base64_Original) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'encode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Base64_Original.encode(dispatch_arg_0)
		}
		'encodeUnpadded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Base64_Original.encodeunpadded(dispatch_arg_0)
		}
		'doEncode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_ParagonIE_Sodium_Core_Base64_Original.doencode(dispatch_arg_0, dispatch_arg_1)
		}
		'decode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class_ParagonIE_Sodium_Core_Base64_Original.decode(dispatch_arg_0, dispatch_arg_1))
		}
		'decodeNoPadding' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_Base64_Original.decodenopadding(dispatch_arg_0))
		}
		'decode6Bits' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Base64_Original.decode6bits(dispatch_arg_0)
		}
		'encode6Bits' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Base64_Original.encode6bits(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_Base64_Original) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Base64_Original) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_sodium_compat_src_core_base64_original_php() {
}
