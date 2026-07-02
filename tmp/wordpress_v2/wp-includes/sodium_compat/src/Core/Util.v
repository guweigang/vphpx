import rt

pub fn Class_ParagonIE_Sodium_Core_Util.u32_max() i64 {
	return 4294967295
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_Core_Util.abs(var_integer rt.PhpVal, size i64) i64 {
	mut size_mutated := size
	mut var_realSize :=
		rt.new_int(rt.shift_left(rt.get_constant('PHP_INT_SIZE'), rt.new_int(3)) - 1)
	if rt.is_true(rt.new_int(size_mutated)) {
		rt.pre_dec(rt.new_int(size_mutated))
	} else {
		size_mutated = var_realSize.to_i64()
	}
	mut var_negative := rt.new_int(-rt.shift_right(var_integer, rt.new_int(size_mutated)) & 1)
	return rt.bitwise_xor(var_integer, var_negative) +
		rt.shift_right(var_negative, var_realSize) & 1
}

fn Class_ParagonIE_Sodium_Core_Util.andstrings(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	mut var_b_mutated := var_b
	if !(var_a.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 1 must be a string'))))
	}
	if !(var_b_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 2 must be a string'))))
	}
	mut var_len := Class_ParagonIE_Sodium_Core_Util.strlen(var_a.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_ParagonIE_Sodium_Core_Util.strlen(var_b_mutated.clone()),
		var_len))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Both strings must be of equal length to combine with bitwise AND'))))
	}
	return rt.bitwise_and(var_a, var_b_mutated)
}

fn Class_ParagonIE_Sodium_Core_Util.bin2hex(var_binaryString rt.PhpVal) rt.PhpVal {
	if !(var_binaryString.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_binaryString.clone()])).str() + ' given.')))
	}
	mut var_hex := rt.new_string('')
	mut var_len := Class_ParagonIE_Sodium_Core_Util.strlen(var_binaryString.clone())
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_len))) { break
		 }
		mut var_chunk := rt.call_function('unpack', [rt.new_string('C'),
			var_binaryString.array_get(var_i)])
		mut var_c := rt.new_int(rt.bitwise_and(var_chunk.array_get(rt.new_int(1)), rt.new_int(15)))
		mut var_b := rt.new_int(rt.shift_right(var_chunk.array_get(rt.new_int(1)), rt.new_int(4)))
		var_hex = rt.concat(var_hex, rt.call_function('pack', [
			rt.new_string('CC'),
			rt.add(rt.add(rt.new_int(87), var_b), rt.shift_right(rt.sub(var_b,
				rt.new_int(10)), rt.new_int(8)) & ~38),
			rt.add(rt.add(rt.new_int(87), var_c), rt.shift_right(rt.sub(var_c, rt.new_int(10)),
				rt.new_int(8)) & ~38)]))
		rt.pre_inc(var_i)
	}
	return var_hex.clone()
}

fn Class_ParagonIE_Sodium_Core_Util.bin2hexupper(var_bin_string rt.PhpVal) rt.PhpVal {
	mut var_hex := rt.new_string('')
	mut var_len := Class_ParagonIE_Sodium_Core_Util.strlen(var_bin_string.clone())
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_len))) { break
		 }
		mut var_chunk := rt.call_function('unpack', [rt.new_string('C'),
			var_bin_string.array_get(var_i)])
		mut var_c := rt.new_int(rt.bitwise_and(var_chunk.array_get(rt.new_int(1)), rt.new_int(15)))
		mut var_b := rt.new_int(rt.shift_right(var_chunk.array_get(rt.new_int(1)), rt.new_int(4)))
		var_hex = rt.concat(var_hex, rt.call_function('pack', [
			rt.new_string('CC'),
			rt.add(rt.add(rt.new_int(55), var_b), rt.shift_right(rt.sub(var_b,
				rt.new_int(10)), rt.new_int(8)) & ~6),
			rt.add(rt.add(rt.new_int(55), var_c), rt.shift_right(rt.sub(var_c, rt.new_int(10)),
				rt.new_int(8)) & ~6)]))
		rt.pre_inc(var_i)
	}
	return var_hex.clone()
}

fn Class_ParagonIE_Sodium_Core_Util.chrtoint(var_chr rt.PhpVal) i64 {
	if !(var_chr.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_chr.clone()])).str() + ' given.')))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_ParagonIE_Sodium_Core_Util.strlen(var_chr.clone()),
		rt.new_int(1)))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('chrToInt() expects a string that is exactly 1 character long'))))
	}
	mut var_chunk := rt.call_function('unpack', [rt.new_string('C'),
		var_chr.clone()])
	return rt.new_int((var_chunk.array_get(rt.new_int(1))).to_i64())
}

fn Class_ParagonIE_Sodium_Core_Util.compare(var_left rt.PhpVal, var_right rt.PhpVal, var_len rt.PhpVal) rt.PhpVal {
	mut var_left_mutated := var_left
	mut var_right_mutated := var_right
	mut var_len_mutated := var_len
	mut var_leftLen := Class_ParagonIE_Sodium_Core_Util.strlen(var_left_mutated.clone())
	mut var_rightLen := Class_ParagonIE_Sodium_Core_Util.strlen(var_right_mutated.clone())
	if rt.is_true(rt.identical(var_len_mutated, rt.new_null())) {
		var_len_mutated = rt.call_function('max', [var_leftLen.clone(),
			var_rightLen.clone()])
		var_left_mutated = rt.call_function('str_pad', [var_left_mutated.clone(),
			var_len_mutated.clone(), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
		var_right_mutated = rt.call_function('str_pad', [var_right_mutated.clone(),
			var_len_mutated.clone(), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_leftLen, var_rightLen)))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Argument #1 and argument #2 must have the same length'))))
	}
	mut var_gt := rt.new_int(0)
	mut var_eq := rt.new_int(1)
	mut var_i := var_len_mutated.clone()
	for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_i, rt.new_int(0))))) {
		rt.pre_dec(var_i)
		rt.new_null()
		rt.new_null()
	}
	return rt.sub(rt.add(rt.add(var_gt, var_gt), var_eq), rt.new_int(1))
}

fn Class_ParagonIE_Sodium_Core_Util.declarescalartype(var_mixedVar rt.PhpVal, type string, argumentIndex i64) {
	mut var_mixedVar_mutated := var_mixedVar
	mut type_mutated := type
	if rt.is_true(rt.identical(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(0))) {
		return
	}
	if rt.is_true(rt.identical(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(1))) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Declared void, but passed a variable'))))
	}
	mut var_realType := rt.new_string(rt.call_function('gettype', [
		var_mixedVar_mutated.clone()]).to_string().to_lower())
	type_mutated = type_mutated.to_lower()
	mut switch_val_1 := rt.new_string(type_mutated)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('null'))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_mixedVar_mutated, rt.new_null())))) {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument ' + argumentIndex.str() + ' must be null, ' + var_realType.str() +
				' given.')))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('integer')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('int'))) {
		mut var_allow := rt.create_array([rt.ArrayItem{ key: none, val: 'int' },
			rt.ArrayItem{ key: none, val: 'integer' }])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.new_string(type_mutated).clone(), var_allow.clone()])))))
		{
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument ' + argumentIndex.str() + ' must be an integer, ' + var_realType.str() +
				' given.')))
		}
		var_mixedVar_mutated = rt.new_int(var_mixedVar_mutated.to_i64())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('boolean')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('bool'))) {
		var_allow = rt.create_array([rt.ArrayItem{ key: none, val: 'bool' },
			rt.ArrayItem{ key: none, val: 'boolean' }])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.new_string(type_mutated).clone(), var_allow.clone()])))))
		{
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument ' + argumentIndex.str() + ' must be a boolean, ' + var_realType.str() +
				' given.')))
		}
		var_mixedVar_mutated = rt.new_bool(var_mixedVar_mutated.to_bool())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('string'))) {
		if !(var_mixedVar_mutated.clone().is_string()) {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument ' + argumentIndex.str() + ' must be a string, ' + var_realType.str() +
				' given.')))
		}
		var_mixedVar_mutated = rt.new_string(var_mixedVar_mutated.str())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('decimal')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('double')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('float'))) {
		var_allow = rt.create_array([rt.ArrayItem{ key: none, val: 'decimal' },
			rt.ArrayItem{ key: none, val: 'double' }, rt.ArrayItem{ key: none, val: 'float' }])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.new_string(type_mutated).clone(), var_allow.clone()])))))
		{
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument ' + argumentIndex.str() + ' must be a float, ' + var_realType.str() +
				' given.')))
		}
		var_mixedVar_mutated = rt.new_float(var_mixedVar_mutated.to_f64())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('object'))) {
		if !(var_mixedVar_mutated.clone().is_object()) {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument ' + argumentIndex.str() + ' must be an object, ' + var_realType.str() +
				' given.')))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('array'))) {
		if !(var_mixedVar_mutated.clone().is_array()) {
			if rt.is_true(rt.new_bool(var_mixedVar_mutated.clone().is_object())) {
				if rt.is_true(rt.new_bool(rt.instance_of(var_mixedVar_mutated, 'ArrayAccess'))) {
					return
				}
			}
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument ' + argumentIndex.str() + ' must be an array, ' + var_realType.str() +
				' given.')))
		}
	} else {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(
			'Unknown type (' + var_realType.str() +
			') does not match expect type (' + type_mutated + ')')))
	}
}

fn Class_ParagonIE_Sodium_Core_Util.hashequals(var_left rt.PhpVal, var_right rt.PhpVal) bool {
	mut var_left_mutated := var_left
	mut var_right_mutated := var_right
	if !(var_left_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_left_mutated.clone()])).str() + ' given.')))
	}
	if !(var_right_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 2 must be a string, ' +
			(rt.call_function('gettype', [var_right_mutated.clone()])).str() + ' given.')))
	}
	if rt.is_true(rt.call_function('is_callable', [rt.new_string('hash_equals')])) {
		return (rt.call_function('hash_equals', [var_left_mutated.clone(),
			var_right_mutated.clone()])).to_bool()
	}
	mut var_d := rt.new_int(0)
	mut var_len := Class_ParagonIE_Sodium_Core_Util.strlen(var_left_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_len,
		Class_ParagonIE_Sodium_Core_Util.strlen(var_right_mutated.clone())))))
	{
		return false
	}
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_len))) { break
		 }
		rt.new_null()
		rt.pre_inc(var_i)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_d, rt.new_int(0))))) {
		return false
	}
	return (rt.identical(var_left_mutated, var_right_mutated)).to_bool()
}

fn Class_ParagonIE_Sodium_Core_Util.hash_update(var_hs rt.PhpVal, var_data rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_update', [
		var_hs.clone(), var_data.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('hash_update() failed'))))
	}
}

fn Class_ParagonIE_Sodium_Core_Util.hex2bin(var_hexString rt.PhpVal, ignore string, strictPadding bool) rt.PhpVal {
	if !(var_hexString.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_hexString.clone()])).str() + ' given.')))
	}
	if !(rt.new_string(ignore).is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 2 must be a string, ' +
			(rt.call_function('gettype', [var_hexString.clone()])).str() + ' given.')))
	}
	mut var_hex_pos := rt.new_int(0)
	mut var_bin := rt.new_string('')
	mut var_c_acc := rt.new_int(0)
	mut var_hex_len := Class_ParagonIE_Sodium_Core_Util.strlen(var_hexString.clone())
	mut var_state := rt.new_int(0)
	mut var_chunk := rt.call_function('unpack', [rt.new_string('C*'),
		var_hexString.clone()])
	for rt.is_true(rt.less(var_hex_pos, var_hex_len)) {
		rt.pre_inc(var_hex_pos)
		mut var_c := var_chunk.array_get(var_hex_pos)
		mut var_c_num := rt.new_int(rt.bitwise_xor(var_c, rt.new_int(48)))
		mut var_c_num0 := rt.new_int(rt.shift_right(rt.sub(var_c_num, rt.new_int(10)),
			rt.new_int(8)))
		mut var_c_alpha := rt.new_int(rt.bitwise_and(var_c, ~32) - 55)
		mut var_c_alpha0 := rt.new_int(rt.bitwise_xor(rt.sub(var_c_alpha, rt.new_int(10)), rt.sub(var_c_alpha,
			rt.new_int(16))) >> 8)
		if rt.bitwise_or(var_c_num0, var_c_alpha0) == 0 {
			if var_ignore.len > 0 && var_ignore != '0'
				&& rt.is_true(rt.identical(var_state, rt.new_int(0)))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(ignore), Class_ParagonIE_Sodium_Core_Util.inttochr(var_c.clone())]), rt.new_bool(false))))) {
				continue
			}
			rt.throw_exception(rt.new_object('RangeException', []string{},
				create_rangeexception(rt.new_string('hex2bin() only expects hexadecimal characters'))))
		}
		mut var_c_val := rt.new_int(rt.bitwise_and(var_c_num0, var_c_num) | rt.bitwise_and(var_c_alpha,
			var_c_alpha0))
		if rt.is_true(rt.identical(var_state, rt.new_int(0))) {
			var_c_acc = rt.mul(var_c_val, rt.new_int(16))
		} else {
			var_bin = rt.concat(var_bin, rt.call_function('pack', [
				rt.new_string('C'), rt.bitwise_or(var_c_acc, var_c_val)]))
		}
		rt.new_null()
	}
	if var_strictPadding
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_state, rt.new_int(0))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Expected an even number of hexadecimal characters'))))
	}
	return var_bin.clone()
}

fn Class_ParagonIE_Sodium_Core_Util.intarraytostring(mut var_ints Class_array) string {
	mut var_args := var_ints
	mut iter_1 := var_args.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_v := item_1.val
		mut var_i := item_1.key
		var_args.array_set(var_i, rt.bitwise_and(var_v, rt.new_int(255)))
	}
	rt.call_function('array_unshift', [var_args.clone(),
		rt.call_function('str_repeat', [rt.new_string('C'), rt.new_int(var_ints.array_count())])])
	return (rt.call_function('call_user_func_array', [rt.new_string('pack'),
		var_args.clone()])).str()
}

fn Class_ParagonIE_Sodium_Core_Util.inttochr(var_int rt.PhpVal) rt.PhpVal {
	mut var_int_mutated := var_int
	return rt.call_function('pack', [rt.new_string('C'), var_int_mutated.clone()])
}

fn Class_ParagonIE_Sodium_Core_Util.load_3(var_string rt.PhpVal) i64 {
	if !(var_string.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_string.clone()])).str() + ' given.')))
	}
	if rt.is_true(rt.less(Class_ParagonIE_Sodium_Core_Util.strlen(var_string.clone()),
		rt.new_int(3)))
	{
		rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(
			'String must be 3 bytes or more; ' +
			(Class_ParagonIE_Sodium_Core_Util.strlen(var_string.clone())).str() + ' given.')))
	}
	mut var_unpacked := rt.call_function('unpack', [rt.new_string('V'),
		rt.new_string(var_string.str() + '')])
	return rt.bitwise_and(var_unpacked.array_get(rt.new_int(1)), rt.new_int(16777215))
}

fn Class_ParagonIE_Sodium_Core_Util.load_4(var_string rt.PhpVal) i64 {
	if !(var_string.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_string.clone()])).str() + ' given.')))
	}
	if rt.is_true(rt.less(Class_ParagonIE_Sodium_Core_Util.strlen(var_string.clone()),
		rt.new_int(4)))
	{
		rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(
			'String must be 4 bytes or more; ' +
			(Class_ParagonIE_Sodium_Core_Util.strlen(var_string.clone())).str() + ' given.')))
	}
	mut var_unpacked := rt.call_function('unpack', [rt.new_string('V'),
		var_string.clone()])
	return rt.new_int((var_unpacked.array_get(rt.new_int(1))).to_i64())
}

fn Class_ParagonIE_Sodium_Core_Util.load64_le(var_string rt.PhpVal) i64 {
	if !(var_string.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_string.clone()])).str() + ' given.')))
	}
	if rt.is_true(rt.less(Class_ParagonIE_Sodium_Core_Util.strlen(var_string.clone()),
		rt.new_int(4)))
	{
		rt.throw_exception(rt.new_object('RangeException', []string{}, create_rangeexception(
			'String must be 4 bytes or more; ' +
			(Class_ParagonIE_Sodium_Core_Util.strlen(var_string.clone())).str() + ' given.')))
	}
	if rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(50603)))
		&& rt.is_true(rt.identical(rt.get_constant('PHP_INT_SIZE'), rt.new_int(8))) {
		mut var_unpacked := rt.call_function('unpack', [rt.new_string('P'),
			var_string.clone()])
		return rt.new_int((var_unpacked.array_get(rt.new_int(1))).to_i64())
	}
	mut var_result := rt.new_int(rt.bitwise_and(Class_ParagonIE_Sodium_Core_Util.chrtoint(var_string.array_get(rt.new_int(0))),
		rt.new_int(255)))
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	rt.new_null()
	return rt.new_int(var_result.to_i64())
}

fn Class_ParagonIE_Sodium_Core_Util.memcmp(var_left rt.PhpVal, var_right rt.PhpVal) rt.PhpVal {
	mut var_left_mutated := var_left
	mut var_right_mutated := var_right
	mut var_e := rt.new_int(i64(!(rt.is_true(Class_ParagonIE_Sodium_Core_Util.hashequals(var_left_mutated.clone(),
		var_right_mutated.clone())))))
	return rt.sub(rt.new_int(0), var_e)
}

fn Class_ParagonIE_Sodium_Core_Util.mul(var_a rt.PhpVal, var_b rt.PhpVal, size i64) i64 {
	mut var_b_mutated := var_b
	mut size_mutated := size
	if rt.is_true(rt.get_static_prop('ParagonIE_Sodium_Compat', 'fastMult')) {
		return rt.new_int((rt.mul(var_a, var_b_mutated)).to_i64())
	}
	mut var_defaultSize := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_defaultSize)))) {
		var_defaultSize =
			rt.new_int(rt.shift_left(rt.get_constant('PHP_INT_SIZE'), rt.new_int(3)) - 1)
	}
	if size_mutated < 1 {
		size_mutated = var_defaultSize.to_i64()
	}
	mut var_c := rt.new_int(0)
	mut var_mask :=
		rt.new_int(-rt.shift_right(var_b_mutated, rt.new_int(var_defaultSize.to_i64())) & 1)
	var_b_mutated = rt.new_int(rt.bitwise_and(var_b_mutated, rt.bitwise_not(var_mask)) | rt.bitwise_and(var_mask, rt.sub(rt.new_int(0),
		var_b_mutated)))
	mut var_i := rt.new_int(size_mutated).clone()
	for {
		if !(rt.is_true(rt.greater_equal(var_i, rt.new_int(0)))) { break
		 }
		var_c = rt.add(var_c, rt.bitwise_and(var_a, -rt.bitwise_and(var_b_mutated, rt.new_int(1))))
		rt.new_null()
		rt.new_null()
		rt.pre_dec(var_i)
	}
	var_c = rt.new_int((rt.bitwise_and(var_c, -1)).to_i64())
	return rt.bitwise_and(var_c, rt.bitwise_not(var_mask)) | rt.bitwise_and(var_mask, rt.sub(rt.new_int(0),
		var_c))
}

fn Class_ParagonIE_Sodium_Core_Util.numericto64bitinteger(var_num rt.PhpVal) rt.PhpVal {
	mut var_high := rt.new_int(0)
	if rt.is_true(rt.identical(rt.get_constant('PHP_INT_SIZE'), rt.new_int(4))) {
		mut var_low := rt.new_int(var_num.to_i64())
	} else {
		var_low = rt.new_int(rt.bitwise_and(var_num, rt.new_int(4294967295)))
	}
	if rt.is_true(rt.greater_equal(rt.call_function('abs', [var_num.clone()]), rt.new_int(1))) {
		if rt.is_true(rt.greater(var_num, rt.new_int(0))) {
			var_high = rt.call_function('min', [
				rt.call_function('floor', [rt.div(var_num, rt.new_int(4294967296))]),
				rt.new_int(4294967295),
			])
		} else {
			var_high = rt.new_int(~rt.bitwise_not(rt.call_function('ceil', [
				rt.div(rt.sub(var_num, ~rt.bitwise_not(var_num)), rt.new_int(4294967296)),
			])))
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_int(var_high.to_i64()) },
		rt.ArrayItem{ key: none, val: rt.new_int(var_low.to_i64()) },
	])
}

fn Class_ParagonIE_Sodium_Core_Util.store_3(var_int rt.PhpVal) rt.PhpVal {
	mut var_int_mutated := var_int
	if !(var_int_mutated.clone().is_long()) {
		if rt.is_true(rt.new_bool(var_int_mutated.clone().is_long()
			|| var_int_mutated.clone().is_double()))
		{
			var_int_mutated = rt.new_int(var_int_mutated.to_i64())
		} else {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument 1 must be an integer, ' +
				(rt.call_function('gettype', [var_int_mutated.clone()])).str() + ' given.')))
		}
	}
	mut var_packed := rt.call_function('pack', [rt.new_string('N'),
		var_int_mutated.clone()])
	return Class_ParagonIE_Sodium_Core_Util.substr(var_packed.to_i64(), rt.new_int(1),
		rt.new_int(3))
}

fn Class_ParagonIE_Sodium_Core_Util.store32_le(var_int rt.PhpVal) rt.PhpVal {
	mut var_int_mutated := var_int
	if !(var_int_mutated.clone().is_long()) {
		if rt.is_true(rt.new_bool(var_int_mutated.clone().is_long()
			|| var_int_mutated.clone().is_double()))
		{
			var_int_mutated = rt.new_int(var_int_mutated.to_i64())
		} else {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument 1 must be an integer, ' +
				(rt.call_function('gettype', [var_int_mutated.clone()])).str() + ' given.')))
		}
	}
	mut var_packed := rt.call_function('pack', [rt.new_string('V'),
		var_int_mutated.clone()])
	return var_packed.clone()
}

fn Class_ParagonIE_Sodium_Core_Util.store_4(var_int rt.PhpVal) rt.PhpVal {
	mut var_int_mutated := var_int
	if !(var_int_mutated.clone().is_long()) {
		if rt.is_true(rt.new_bool(var_int_mutated.clone().is_long()
			|| var_int_mutated.clone().is_double()))
		{
			var_int_mutated = rt.new_int(var_int_mutated.to_i64())
		} else {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument 1 must be an integer, ' +
				(rt.call_function('gettype', [var_int_mutated.clone()])).str() + ' given.')))
		}
	}
	mut var_packed := rt.call_function('pack', [rt.new_string('N'),
		var_int_mutated.clone()])
	return var_packed.clone()
}

fn Class_ParagonIE_Sodium_Core_Util.store64_le(var_int rt.PhpVal) string {
	mut var_int_mutated := var_int
	if !(var_int_mutated.clone().is_long()) {
		if rt.is_true(rt.new_bool(var_int_mutated.clone().is_long()
			|| var_int_mutated.clone().is_double()))
		{
			var_int_mutated = rt.new_int(var_int_mutated.to_i64())
		} else {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument 1 must be an integer, ' +
				(rt.call_function('gettype', [var_int_mutated.clone()])).str() + ' given.')))
		}
	}
	if rt.is_true(rt.identical(rt.get_constant('PHP_INT_SIZE'), rt.new_int(8))) {
		if rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(50603))) {
			mut var_packed := rt.call_function('pack', [rt.new_string('P'),
				var_int_mutated.clone()])
			return var_packed.str()
		}
		return
			(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.bitwise_and(var_int_mutated, rt.new_int(255))))).str() +
			(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.shift_right(var_int_mutated, rt.new_int(8)) & 255))).str() +
			(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.shift_right(var_int_mutated, rt.new_int(16)) & 255))).str() +
			(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.shift_right(var_int_mutated, rt.new_int(24)) & 255))).str() +
			(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.shift_right(var_int_mutated, rt.new_int(32)) & 255))).str() +
			(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.shift_right(var_int_mutated, rt.new_int(40)) & 255))).str() +
			(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.shift_right(var_int_mutated, rt.new_int(48)) & 255))).str() +(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.shift_right(var_int_mutated, rt.new_int(56)) & 255))).str()
	}
	if rt.is_true(rt.greater(var_int_mutated, rt.get_constant('PHP_INT_MAX'))) {
		mut list_tmp_1 :=
			Class_ParagonIE_Sodium_Core_Util.numericto64bitinteger(var_int_mutated.clone())
		mut var_hiB := list_tmp_1.array_get(0)
		var_int_mutated = list_tmp_1.array_get(1)
	} else {
		var_hiB = rt.new_int(0)
	}
	return
		(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.bitwise_and(var_int_mutated, rt.new_int(255))))).str() +
		(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.shift_right(var_int_mutated, rt.new_int(8)) & 255))).str() +
		(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.shift_right(var_int_mutated, rt.new_int(16)) & 255))).str() +
		(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.shift_right(var_int_mutated, rt.new_int(24)) & 255))).str() +
		(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.bitwise_and(var_hiB, rt.new_int(255))))).str() +
		(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.shift_right(var_hiB, rt.new_int(8)) & 255))).str() +
		(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.shift_right(var_hiB, rt.new_int(16)) & 255))).str() +(Class_ParagonIE_Sodium_Core_Util.inttochr(rt.new_int(rt.shift_right(var_hiB, rt.new_int(24)) & 255))).str()
}

fn Class_ParagonIE_Sodium_Core_Util.strlen(var_str rt.PhpVal) i64 {
	if !(var_str.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('String expected'))))
	}
	return rt.new_int((if rt.is_true(Class_ParagonIE_Sodium_Core_Util.ismbstringoverride()) { rt.call_function('mb_strlen', [
			var_str.clone(),
			rt.new_string('8bit'),
		]) } else { rt.new_int(var_str.clone().to_string().len) }).to_i64())
}

fn Class_ParagonIE_Sodium_Core_Util.stringtointarray(var_string rt.PhpVal) rt.PhpVal {
	if !(var_string.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('String expected'))))
	}
	mut var_values := rt.call_function('array_values', [
		rt.call_function('unpack', [rt.new_string('C*'), var_string.clone()]),
	])
	return var_values.clone()
}

fn Class_ParagonIE_Sodium_Core_Util.substr(var_str rt.PhpVal, start i64, var_length rt.PhpVal) string {
	mut var_length_mutated := var_length
	if !(var_str.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('String expected'))))
	}
	if rt.is_true(rt.identical(var_length_mutated, rt.new_int(0))) {
		return ''
	}
	if rt.is_true(Class_ParagonIE_Sodium_Core_Util.ismbstringoverride()) {
		if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(50400)))
			&& rt.is_true(rt.identical(var_length_mutated, rt.new_null())) {
			var_length_mutated = Class_ParagonIE_Sodium_Core_Util.strlen(var_str.clone())
		}
		mut var_sub := rt.new_string((rt.call_function('mb_substr', [
			var_str.clone(), rt.new_int(start), var_length_mutated.clone(),
			rt.new_string('8bit')])).str())
	} else if rt.is_true(rt.identical(var_length_mutated, rt.new_null())) {
		var_sub = rt.new_string((rt.call_function('substr', [
			var_str.clone(), rt.new_int(start)])).str())
	} else {
		var_sub = rt.new_string((rt.call_function('substr', [
			var_str.clone(), rt.new_int(start), var_length_mutated.clone()])).str())
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_sub, rt.new_string(''))))) {
		return var_sub.str()
	}
	return ''
}

fn Class_ParagonIE_Sodium_Core_Util.verify_16(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	mut var_b_mutated := var_b
	if !(var_a.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('String expected'))))
	}
	if !(var_b_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('String expected'))))
	}
	return Class_ParagonIE_Sodium_Core_Util.hashequals(Class_ParagonIE_Sodium_Core_Util.substr(var_a.to_i64(),
		rt.new_int(0), rt.new_int(16)), Class_ParagonIE_Sodium_Core_Util.substr(var_b_mutated.to_i64(),
		rt.new_int(0), rt.new_int(16)))
}

fn Class_ParagonIE_Sodium_Core_Util.verify_32(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	mut var_b_mutated := var_b
	if !(var_a.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('String expected'))))
	}
	if !(var_b_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('String expected'))))
	}
	return Class_ParagonIE_Sodium_Core_Util.hashequals(Class_ParagonIE_Sodium_Core_Util.substr(var_a.to_i64(),
		rt.new_int(0), rt.new_int(32)), Class_ParagonIE_Sodium_Core_Util.substr(var_b_mutated.to_i64(),
		rt.new_int(0), rt.new_int(32)))
}

fn Class_ParagonIE_Sodium_Core_Util.xorstrings(var_a rt.PhpVal, var_b rt.PhpVal) string {
	mut var_b_mutated := var_b
	if !(var_a.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 1 must be a string'))))
	}
	if !(var_b_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 2 must be a string'))))
	}
	return rt.bitwise_xor(var_a, var_b_mutated).str()
}

fn Class_ParagonIE_Sodium_Core_Util.ismbstringoverride() rt.PhpVal {
	mut var_mbstring := rt.new_null()
	if rt.is_true(rt.identical(var_mbstring, rt.new_null())) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
			rt.new_string('MB_OVERLOAD_STRING'),
		])))))
		{
			var_mbstring = rt.new_bool(false)
			return var_mbstring.clone()
		}
		var_mbstring = rt.new_bool(
			rt.is_true(rt.call_function('extension_loaded', [rt.new_string('mbstring')]))
			&& rt.is_true(rt.call_function('defined', [rt.new_string('MB_OVERLOAD_STRING')]))
			&& rt.is_true(rt.new_int((rt.call_function('ini_get', [rt.new_string('mbstring.func_overload')])).to_i64()) & 2))
	}
	return var_mbstring.clone()
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

fn create_paragonie_sodium_core_util(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_typeerror(_args ...rt.PhpVal) &Class_TypeError {
	mut obj := &Class_TypeError{
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

fn create_rangeexception(_args ...rt.PhpVal) &Class_RangeException {
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
			return rt.new_int(Class_ParagonIE_Sodium_Core_Util.abs(dispatch_arg_0, dispatch_arg_1))
		}
		'andStrings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core_Util.andstrings(dispatch_arg_0,
				dispatch_arg_1))
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
			return rt.new_int(Class_ParagonIE_Sodium_Core_Util.chrtoint(dispatch_arg_0))
		}
		'compare' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.compare(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'declareScalarType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			Class_ParagonIE_Sodium_Core_Util.declarescalartype(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
			return rt.new_null()
		}
		'hashEquals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_ParagonIE_Sodium_Core_Util.hashequals(dispatch_arg_0,
				dispatch_arg_1))
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
			return Class_ParagonIE_Sodium_Core_Util.hex2bin(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'intArrayToString' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_ParagonIE_Sodium_Core_Util.intarraytostring(mut dispatch_arg_0))
		}
		'intToChr' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.inttochr(dispatch_arg_0)
		}
		'load_3' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core_Util.load_3(dispatch_arg_0))
		}
		'load_4' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core_Util.load_4(dispatch_arg_0))
		}
		'load64_le' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_Core_Util.load64_le(dispatch_arg_0))
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
			return rt.new_int(Class_ParagonIE_Sodium_Core_Util.mul(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
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
			return rt.new_int(Class_ParagonIE_Sodium_Core_Util.strlen(dispatch_arg_0))
		}
		'stringToIntArray' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core_Util.stringtointarray(dispatch_arg_0)
		}
		'substr' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(Class_ParagonIE_Sodium_Core_Util.substr(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
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
			return rt.new_string(Class_ParagonIE_Sodium_Core_Util.xorstrings(dispatch_arg_0,
				dispatch_arg_1))
		}
		'isMbStringOverride' {
			return Class_ParagonIE_Sodium_Core_Util.ismbstringoverride()
		}
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Core_Util'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}
