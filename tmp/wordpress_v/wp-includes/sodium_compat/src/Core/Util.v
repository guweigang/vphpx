import rt

pub fn Class_ParagonIE_Sodium_Core_Util.u32_max() i64 {
	return 4294967295
}
struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_Util.abs(var_integer rt.PhpVal, size i64) rt.PhpVal {
	mut size_mutated := size
	mut var_realSize := rt.new_int(rt.shift_left(rt.get_constant('PHP_INT_SIZE'), rt.new_int(3)) - 1)
	if rt.is_true(rt.new_int(size_mutated)) {
		rt.pre_dec(rt.new_int(size_mutated))
	} else {
		size_mutated = (var_realSize).to_i64()
	}
	mut var_negative := // unsupported expression: Expr_UnaryMinus
	return // unsupported expression: Expr_Cast_Int
}

fn Class_ParagonIE_Sodium_Core_Util.andstrings(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	mut var_b_mutated := var_b
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_a.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Argument 1 must be a string'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_b_mutated.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Argument 2 must be a string'))))
	}
	mut var_len := Class_ParagonIE_Sodium_Core_Util.strlen(var_a.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Both strings must be of equal length to combine with bitwise AND'))))
	}
	return rt.bitwise_and(var_a, var_b_mutated)
}

fn Class_ParagonIE_Sodium_Core_Util.bin2hex(var_binaryString rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_binaryString.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 1 must be a string, ' + (rt.call_function('gettype', [var_binaryString.dup()])).str() + ' given.')))
	}
	mut var_hex := rt.new_string(rt.new_string(''))
	mut var_len := Class_ParagonIE_Sodium_Core_Util.strlen(var_binaryString.dup())
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, var_len))) { break }
			mut var_chunk := rt.call_function('unpack', [rt.new_string('C'), var_binaryString.array_get(var_i)])
			mut var_c := rt.new_int(rt.bitwise_and(var_chunk.array_get(1), rt.new_int(15)))
			mut var_b := rt.new_int(rt.shift_right(var_chunk.array_get(1), rt.new_int(4)))
			// unsupported expression: Expr_AssignOp_Concat
			rt.pre_inc(var_i)
		}
	}
	return var_hex.dup()
}

fn Class_ParagonIE_Sodium_Core_Util.bin2hexupper(var_bin_string rt.PhpVal) rt.PhpVal {
	mut var_hex := rt.new_string(rt.new_string(''))
	mut var_len := Class_ParagonIE_Sodium_Core_Util.strlen(var_bin_string.dup())
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, var_len))) { break }
			mut var_chunk := rt.call_function('unpack', [rt.new_string('C'), var_bin_string.array_get(var_i)])
			mut var_c := rt.new_int(rt.bitwise_and(var_chunk.array_get(1), rt.new_int(15)))
			mut var_b := rt.new_int(rt.shift_right(var_chunk.array_get(1), rt.new_int(4)))
			// unsupported expression: Expr_AssignOp_Concat
			rt.pre_inc(var_i)
		}
	}
	return var_hex.dup()
}

fn Class_ParagonIE_Sodium_Core_Util.chrtoint(var_chr rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_chr.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 1 must be a string, ' + (rt.call_function('gettype', [var_chr.dup()])).str() + ' given.')))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('chrToInt() expects a string that is exactly 1 character long'))))
	}
	mut var_chunk := rt.call_function('unpack', [rt.new_string('C'), var_chr.dup()])
	return // unsupported expression: Expr_Cast_Int
}

fn Class_ParagonIE_Sodium_Core_Util.compare(var_left rt.PhpVal, var_right rt.PhpVal, var_len rt.PhpVal) rt.PhpVal {
	mut var_left_mutated := var_left
	mut var_right_mutated := var_right
	mut var_len_mutated := var_len
	mut var_leftLen := Class_ParagonIE_Sodium_Core_Util.strlen(var_left_mutated.dup())
	mut var_rightLen := Class_ParagonIE_Sodium_Core_Util.strlen(var_right_mutated.dup())
	if rt.is_true(rt.identical(var_len_mutated, rt.new_null())) {
		var_len_mutated = rt.call_function('max', [var_leftLen.dup(), var_rightLen.dup()])
		var_left_mutated = rt.call_function('str_pad', [var_left_mutated.dup(), var_len_mutated.dup(), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
		var_right_mutated = rt.call_function('str_pad', [var_right_mutated.dup(), var_len_mutated.dup(), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Argument #1 and argument #2 must have the same length'))))
	}
	mut var_gt := rt.new_int(rt.new_int(0))
	mut var_eq := rt.new_int(rt.new_int(1))
	mut var_i := var_len_mutated.dup()
	for rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.pre_dec(var_i)
		// unsupported expression: Expr_AssignOp_BitwiseOr
		// unsupported expression: Expr_AssignOp_BitwiseAnd
	}
	return rt.sub(rt.add(rt.add(var_gt, var_gt), var_eq), rt.new_int(1))
}

fn Class_ParagonIE_Sodium_Core_Util.declarescalartype(var_mixedVar rt.PhpVal, type string, argumentIndex i64)  {
	mut var_mixedVar_mutated := var_mixedVar
	mut type_mutated := type
	if rt.is_true(rt.identical(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(0))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(1))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Declared void, but passed a variable'))))
	}
	mut var_realType := rt.new_string(rt.new_string(rt.call_function('gettype', [var_mixedVar_mutated.dup()]).to_string().to_lower()))
	type_mutated = type_mutated.to_lower()
	mut switch_val_1 := rt.new_string(type_mutated)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('null'))) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument ' + argumentIndex.str() + ' must be null, ' + (var_realType).str() + ' given.')))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('integer'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('int'))) {
		mut var_allow := rt.create_array([rt.ArrayItem{ key: none, val: 'int' }, rt.ArrayItem{ key: none, val: 'integer' }])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(type_mutated).dup(), var_allow.dup()]))))) {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument ' + argumentIndex.str() + ' must be an integer, ' + (var_realType).str() + ' given.')))
		}
		var_mixedVar_mutated = // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('boolean'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('bool'))) {
		var_allow = rt.create_array([rt.ArrayItem{ key: none, val: 'bool' }, rt.ArrayItem{ key: none, val: 'boolean' }])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(type_mutated).dup(), var_allow.dup()]))))) {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument ' + argumentIndex.str() + ' must be a boolean, ' + (var_realType).str() + ' given.')))
		}
		var_mixedVar_mutated = // unsupported expression: Expr_Cast_Bool
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('string'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_mixedVar_mutated.dup().is_string()))))) {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument ' + argumentIndex.str() + ' must be a string, ' + (var_realType).str() + ' given.')))
		}
		var_mixedVar_mutated = // unsupported expression: Expr_Cast_String
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('decimal'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('double'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('float'))) {
		var_allow = rt.create_array([rt.ArrayItem{ key: none, val: 'decimal' }, rt.ArrayItem{ key: none, val: 'double' }, rt.ArrayItem{ key: none, val: 'float' }])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(type_mutated).dup(), var_allow.dup()]))))) {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument ' + argumentIndex.str() + ' must be a float, ' + (var_realType).str() + ' given.')))
		}
		var_mixedVar_mutated = // unsupported expression: Expr_Cast_Double
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('object'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_mixedVar_mutated.dup().is_object()))))) {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument ' + argumentIndex.str() + ' must be an object, ' + (var_realType).str() + ' given.')))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('array'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_mixedVar_mutated.dup().is_array()))))) {
			if rt.is_true(rt.new_bool(var_mixedVar_mutated.dup().is_object())) {
				if rt.is_true(rt.new_bool(rt.instance_of(var_mixedVar_mutated, 'ArrayAccess'))) {
					return rt.new_null()
				}
			}
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument ' + argumentIndex.str() + ' must be an array, ' + (var_realType).str() + ' given.')))
		}
	} else {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception('Unknown type (' + (var_realType).str() + ') does not match expect type (' + type_mutated + ')')))
	}
}

fn Class_ParagonIE_Sodium_Core_Util.hashequals(var_left rt.PhpVal, var_right rt.PhpVal) bool {
	mut var_left_mutated := var_left
	mut var_right_mutated := var_right
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_left_mutated.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 1 must be a string, ' + (rt.call_function('gettype', [var_left_mutated.dup()])).str() + ' given.')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_right_mutated.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 2 must be a string, ' + (rt.call_function('gettype', [var_right_mutated.dup()])).str() + ' given.')))
	}
	if rt.is_true(rt.call_function('is_callable', [rt.new_string('hash_equals')])) {
		return (rt.call_function('hash_equals', [var_left_mutated.dup(), var_right_mutated.dup()])).to_bool()
	}
	mut var_d := rt.new_int(rt.new_int(0))
	mut var_len := Class_ParagonIE_Sodium_Core_Util.strlen(var_left_mutated.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, var_len))) { break }
			// unsupported expression: Expr_AssignOp_BitwiseOr
			rt.pre_inc(var_i)
		}
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	return (rt.identical(var_left_mutated, var_right_mutated)).to_bool()
}

fn Class_ParagonIE_Sodium_Core_Util.hash_update(var_hs rt.PhpVal, var_data rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_update', [var_hs.dup(), var_data.dup()]))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('hash_update() failed'))))
	}
}

fn Class_ParagonIE_Sodium_Core_Util.hex2bin(var_hexString rt.PhpVal, ignore string, strictPadding bool) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_hexString.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 1 must be a string, ' + (rt.call_function('gettype', [var_hexString.dup()])).str() + ' given.')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.new_string(ignore).is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 2 must be a string, ' + (rt.call_function('gettype', [var_hexString.dup()])).str() + ' given.')))
	}
	mut var_hex_pos := rt.new_int(rt.new_int(0))
	mut var_bin := rt.new_string(rt.new_string(''))
	mut var_c_acc := rt.new_int(rt.new_int(0))
	mut var_hex_len := Class_ParagonIE_Sodium_Core_Util.strlen(var_hexString.dup())
	mut var_state := rt.new_int(rt.new_int(0))
	mut var_chunk := rt.call_function('unpack', [rt.new_string('C*'), var_hexString.dup()])
	for rt.is_true(rt.less(var_hex_pos, var_hex_len)) {
		rt.pre_inc(var_hex_pos)
		mut var_c := var_chunk.array_get(var_hex_pos)
		mut var_c_num := rt.new_int(rt.bitwise_xor(var_c, rt.new_int(48)))
		mut var_c_num0 := rt.new_int(rt.shift_right(rt.sub(var_c_num, rt.new_int(10)), rt.new_int(8)))
		mut var_c_alpha := rt.new_int(rt.bitwise_and(var_c, ~32) - 55)
		mut var_c_alpha0 := rt.new_int(rt.bitwise_xor(rt.sub(var_c_alpha, rt.new_int(10)), rt.sub(var_c_alpha, rt.new_int(16))) >> 8)
		if rt.bitwise_or(var_c_num0, var_c_alpha0) == 0 {
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_ignore.len > 0 && var_ignore != '0' && rt.is_true(rt.identical(var_state, rt.new_int(0))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				continue
			}
			rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(rt.new_string('hex2bin() only expects hexadecimal characters'))))
		}
		mut var_c_val := rt.new_int( | )
		if rt.is_true(rt.identical(var_state, rt.new_int(0))) {
			var_c_acc = 
		} else {
			
		}
		
	}
}

fn Class_ParagonIE_Sodium_Core_Util.intarraytostring(mut var_ints Class_array) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Util.inttochr(var_int rt.PhpVal) rt.PhpVal {
	mut var_int_mutated := var_int
}

fn Class_ParagonIE_Sodium_Core_Util.load_3(var_string rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Util.load_4(var_string rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Util.load64_le(var_string rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Util.memcmp(var_left rt.PhpVal, var_right rt.PhpVal) rt.PhpVal {
	mut var_left_mutated := var_left
	mut var_right_mutated := var_right
}

fn Class_ParagonIE_Sodium_Core_Util.mul(var_a rt.PhpVal, var_b rt.PhpVal, size i64) rt.PhpVal {
	mut var_b_mutated := var_b
	mut size_mutated := size
}

fn Class_ParagonIE_Sodium_Core_Util.numericto64bitinteger(var_num rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Util.store_3(var_int rt.PhpVal) rt.PhpVal {
	mut var_int_mutated := var_int
}

fn Class_ParagonIE_Sodium_Core_Util.store32_le(var_int rt.PhpVal) rt.PhpVal {
	mut var_int_mutated := var_int
}

fn Class_ParagonIE_Sodium_Core_Util.store_4(var_int rt.PhpVal) rt.PhpVal {
	mut var_int_mutated := var_int
}

fn Class_ParagonIE_Sodium_Core_Util.store64_le(var_int rt.PhpVal) string {
	mut var_int_mutated := var_int
}

fn Class_ParagonIE_Sodium_Core_Util.strlen(var_str rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Util.stringtointarray(var_string rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_Core_Util.substr(var_str rt.PhpVal, start i64, var_length rt.PhpVal) string {
	mut var_length_mutated := var_length
}

fn Class_ParagonIE_Sodium_Core_Util.verify_16(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core_Util.verify_32(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core_Util.xorstrings(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	mut var_b_mutated := var_b
}

fn Class_ParagonIE_Sodium_Core_Util.ismbstringoverride() rt.PhpVal {
}

struct Class_TypeError {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

struct Class_RangeException {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core_util() &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_typeerror() &Class_TypeError {
	mut obj := &Class_TypeError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_sodiumexception() &Class_SodiumException {
	mut obj := &Class_SodiumException{
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

fn (mut this Class_ParagonIE_Sodium_Core_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'abs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_Core_Util.abs(dispatch_arg_0, dispatch_arg_1)
		}
		'andStrings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core_Util.andstrings(dispatch_arg_0, dispatch_arg_1))
		}
		'bin2hex' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.bin2hex(dispatch_arg_0)
		}
		'bin2hexUpper' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.bin2hexupper(dispatch_arg_0)
		}
		'chrToInt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.chrtoint(dispatch_arg_0)
		}
		'compare' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.compare(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'declareScalarType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			Class_ParagonIE_Sodium_Core_Util.declarescalartype(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'hashEquals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_ParagonIE_Sodium_Core_Util.hashequals(dispatch_arg_0, dispatch_arg_1))
		}
		'hash_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_ParagonIE_Sodium_Core_Util.hash_update(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'hex2bin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return Class_ParagonIE_Sodium_Core_Util.hex2bin(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'intArrayToString' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ParagonIE_Sodium_Core_Util.intarraytostring(mut dispatch_arg_0)
		}
		'intToChr' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.inttochr(dispatch_arg_0)
		}
		'load_3' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.load_3(dispatch_arg_0)
		}
		'load_4' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.load_4(dispatch_arg_0)
		}
		'load64_le' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.load64_le(dispatch_arg_0)
		}
		'memcmp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.memcmp(dispatch_arg_0, dispatch_arg_1)
		}
		'mul' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_Core_Util.mul(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'numericTo64BitInteger' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.numericto64bitinteger(dispatch_arg_0)
		}
		'store_3' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.store_3(dispatch_arg_0)
		}
		'store32_le' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.store32_le(dispatch_arg_0)
		}
		'store_4' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.store_4(dispatch_arg_0)
		}
		'store64_le' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_Util.store64_le(dispatch_arg_0))
		}
		'strlen' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.strlen(dispatch_arg_0)
		}
		'stringToIntArray' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.stringtointarray(dispatch_arg_0)
		}
		'substr' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_Util.substr(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'verify_16' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.verify_16(dispatch_arg_0, dispatch_arg_1)
		}
		'verify_32' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.verify_32(dispatch_arg_0, dispatch_arg_1)
		}
		'xorStrings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.xorstrings(dispatch_arg_0, dispatch_arg_1)
		}
		'isMbStringOverride' {
			return Class_ParagonIE_Sodium_Core_Util.ismbstringoverride()
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_TypeError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_TypeError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_TypeError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_RangeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RangeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RangeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core_util_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core_Util'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
