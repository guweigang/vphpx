import rt

struct Class_Services_JSON {
	rt.PhpObjectBase
pub mut:
			use rt.PhpVal = rt.new_null()
			_mb_strlen rt.PhpVal = rt.new_bool(false)
			_mb_substr rt.PhpVal = rt.new_bool(false)
			_mb_convert_encoding rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Services_JSON) construct(use i64) {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	this.use = rt.new_int(use)
	this._mb_strlen = rt.call_function('function_exists', [rt.new_string('mb_strlen')])
	this._mb_convert_encoding = rt.call_function('function_exists', [rt.new_string('mb_convert_encoding')])
	this._mb_substr = rt.call_function('function_exists', [rt.new_string('mb_substr')])
}

fn (mut this Class_Services_JSON) services_json(use i64) {
	rt.call_function('_deprecated_constructor', [rt.new_string('Services_JSON'), rt.new_string('5.3.0'), rt.call_function('get_class', [rt.new_object('Services_JSON', []string{}, &this)])])
	mut iife_temp_0 := Class_Services_JSON{}
	iife_temp_0.construct(use)
	rt.new_null()
}

fn (mut this Class_Services_JSON) utf162utf8(var_utf16 rt.PhpVal) string {
	mut var_utf16_mutated := var_utf16
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	if rt.is_true(this._mb_convert_encoding) {
		return (rt.call_function('mb_convert_encoding', [var_utf16_mutated.clone(), rt.new_string('UTF-8'), rt.new_string('UTF-16')])).str()
	}
	mut var_bytes := rt.new_int(rt.bitwise_or(rt.shift_left(rt.call_function('ord', [var_utf16_mutated.array_get(rt.new_int(0))]), rt.new_int(8)), rt.call_function('ord', [var_utf16_mutated.array_get(rt.new_int(1))])))
	mut switch_val_1 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_1, rt.equal(rt.bitwise_and(rt.new_int(127), var_bytes), var_bytes))) {
		return (rt.call_function('chr', [rt.bitwise_and(rt.new_int(127), var_bytes)])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.equal(rt.bitwise_and(rt.new_int(2047), var_bytes), var_bytes))) {
		return (rt.call_function('chr', [rt.new_int(192 | rt.shift_right(var_bytes, rt.new_int(6)) & 31)])).str() + (rt.call_function('chr', [rt.new_int(128 | rt.bitwise_and(var_bytes, rt.new_int(63)))])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.equal(rt.bitwise_and(rt.new_int(65535), var_bytes), var_bytes))) {
		return (rt.call_function('chr', [rt.new_int(224 | rt.shift_right(var_bytes, rt.new_int(12)) & 15)])).str() + (rt.call_function('chr', [rt.new_int(128 | rt.shift_right(var_bytes, rt.new_int(6)) & 63)])).str() + (rt.call_function('chr', [rt.new_int(128 | rt.bitwise_and(var_bytes, rt.new_int(63)))])).str()
	}
	return ''
}

fn (mut this Class_Services_JSON) utf82utf16(var_utf8 rt.PhpVal) string {
	mut var_utf8_mutated := var_utf8
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	if rt.is_true(this._mb_convert_encoding) {
		return (rt.call_function('mb_convert_encoding', [var_utf8_mutated.clone(), rt.new_string('UTF-16'), rt.new_string('UTF-8')])).str()
	}
	match this.strlen8(var_utf8_mutated.clone()) {
		1 {
			return (var_utf8_mutated).str()
		}
		2 {
			return (rt.call_function('chr', [rt.new_int(7 & rt.shift_right(rt.call_function('ord', [var_utf8_mutated.array_get(rt.new_int(0))]), rt.new_int(2)))])).str() + (rt.call_function('chr', [rt.new_int(192 & rt.shift_left(rt.call_function('ord', [var_utf8_mutated.array_get(rt.new_int(0))]), rt.new_int(6)) | rt.bitwise_and(rt.new_int(63), rt.call_function('ord', [var_utf8_mutated.array_get(rt.new_int(1))])))])).str()
		}
		3 {
			return (rt.call_function('chr', [rt.new_int(240 & rt.shift_left(rt.call_function('ord', [var_utf8_mutated.array_get(rt.new_int(0))]), rt.new_int(4)) | 15 & rt.shift_right(rt.call_function('ord', [var_utf8_mutated.array_get(rt.new_int(1))]), rt.new_int(2)))])).str() + (rt.call_function('chr', [rt.new_int(192 & rt.shift_left(rt.call_function('ord', [var_utf8_mutated.array_get(rt.new_int(1))]), rt.new_int(6)) | rt.bitwise_and(rt.new_int(127), rt.call_function('ord', [var_utf8_mutated.array_get(rt.new_int(2))])))])).str()
		}
	}
	return ''
}

fn (mut this Class_Services_JSON) encode(var_var rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	rt.call_function('header', [rt.new_string('Content-Type: application/json')])
	return this.encodeunsafe(var_var.clone())
}

fn (mut this Class_Services_JSON) encodeunsafe(var_var rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	mut var_lc := rt.call_function('setlocale', [rt.get_constant('LC_NUMERIC'), rt.new_int(0)])
	rt.call_function('setlocale', [rt.get_constant('LC_NUMERIC'), rt.new_string('C')])
	mut var_ret := this._encode(var_var.clone())
	rt.call_function('setlocale', [rt.get_constant('LC_NUMERIC'), var_lc.clone()])
	return var_ret.clone()
}

fn (mut this Class_Services_JSON) _encode(var_var rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	mut switch_val_3 := rt.call_function('gettype', [var_var.clone()])
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('boolean'))) {
		return rt.new_string((if rt.is_true(var_var) { 'true' } else { 'false' }).str())
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('NULL'))) {
		return rt.new_string('null')
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('integer'))) {
		return rt.new_int((var_var).to_i64())
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('double'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('float'))) {
		return rt.new_float((var_var).to_f64())
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('string'))) {
		mut var_ascii := rt.new_string('')
		mut var_strlen_var := rt.new_int(this.strlen8(var_var.clone()))
		mut var_c := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_c, var_strlen_var))) { break }
			mut var_ord_var_c := rt.call_function('ord', [var_var.array_get(var_c)])
			mut switch_val_4 := rt.new_bool(true)
			if rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(8)))) {
				var_ascii = rt.concat(var_ascii, rt.new_string('\\b'))
			} else if rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(9)))) {
				var_ascii = rt.concat(var_ascii, rt.new_string('\\t'))
			} else if rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(10)))) {
				var_ascii = rt.concat(var_ascii, rt.new_string('\\n'))
			} else if rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(12)))) {
				var_ascii = rt.concat(var_ascii, rt.new_string('\\f'))
			} else if rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(13)))) {
				var_ascii = rt.concat(var_ascii, rt.new_string('\\r'))
			} else if rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(34)))) || rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(47)))) || rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(92)))) {
				var_ascii = rt.concat(var_ascii, rt.new_string('\\' + (var_var.array_get(var_c)).str()))
			} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(rt.is_true(rt.greater_equal(var_ord_var_c, rt.new_int(32))) && rt.is_true(rt.less_equal(var_ord_var_c, rt.new_int(127)))))) {
				var_ascii = rt.concat(var_ascii, var_var.array_get(var_c))
			} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(rt.bitwise_and(var_ord_var_c, rt.new_int(224)) == 192))) {
				if rt.is_true(rt.greater_equal(rt.add(var_c, rt.new_int(1)), var_strlen_var)) {
					var_c = rt.add(var_c, rt.new_int(1))
					var_ascii = rt.concat(var_ascii, rt.new_string('?'))
				}
				mut var_char := rt.call_function('pack', [rt.new_string('C*'), var_ord_var_c.clone(), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(1)))])])
				var_c = rt.add(var_c, rt.new_int(1))
				mut var_utf16 := this.utf82utf16(var_char.clone())
				var_ascii = rt.concat(var_ascii, rt.call_function('sprintf', [rt.new_string('\\u%04s'), rt.call_function('bin2hex', [rt.create_array_from_list(var_utf16)])]))
			} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(rt.bitwise_and(var_ord_var_c, rt.new_int(240)) == 224))) {
				if rt.is_true(rt.greater_equal(rt.add(var_c, rt.new_int(2)), var_strlen_var)) {
					var_c = rt.add(var_c, rt.new_int(2))
					var_ascii = rt.concat(var_ascii, rt.new_string('?'))
				}
				var_char = rt.call_function('pack', [rt.new_string('C*'), var_ord_var_c.clone(), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(1)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(2)))])])
				var_c = rt.add(var_c, rt.new_int(2))
				var_utf16 = this.utf82utf16(var_char.clone())
				var_ascii = rt.concat(var_ascii, rt.call_function('sprintf', [rt.new_string('\\u%04s'), rt.call_function('bin2hex', [rt.create_array_from_list(var_utf16)])]))
			} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(rt.bitwise_and(var_ord_var_c, rt.new_int(248)) == 240))) {
				if rt.is_true(rt.greater_equal(rt.add(var_c, rt.new_int(3)), var_strlen_var)) {
					var_c = rt.add(var_c, rt.new_int(3))
					var_ascii = rt.concat(var_ascii, rt.new_string('?'))
				}
				var_char = rt.call_function('pack', [rt.new_string('C*'), var_ord_var_c.clone(), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(1)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(2)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(3)))])])
				var_c = rt.add(var_c, rt.new_int(3))
				var_utf16 = this.utf82utf16(var_char.clone())
				var_ascii = rt.concat(var_ascii, rt.call_function('sprintf', [rt.new_string('\\u%04s'), rt.call_function('bin2hex', [rt.create_array_from_list(var_utf16)])]))
			} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(rt.bitwise_and(var_ord_var_c, rt.new_int(252)) == 248))) {
				if rt.is_true(rt.greater_equal(rt.add(var_c, rt.new_int(4)), var_strlen_var)) {
					var_c = rt.add(var_c, rt.new_int(4))
					var_ascii = rt.concat(var_ascii, rt.new_string('?'))
				}
				var_char = rt.call_function('pack', [rt.new_string('C*'), var_ord_var_c.clone(), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(1)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(2)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(3)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(4)))])])
				var_c = rt.add(var_c, rt.new_int(4))
				var_utf16 = this.utf82utf16(var_char.clone())
				var_ascii = rt.concat(var_ascii, rt.call_function('sprintf', [rt.new_string('\\u%04s'), rt.call_function('bin2hex', [rt.create_array_from_list(var_utf16)])]))
			} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(rt.bitwise_and(var_ord_var_c, rt.new_int(254)) == 252))) {
				if rt.is_true(rt.greater_equal(rt.add(var_c, rt.new_int(5)), var_strlen_var)) {
					var_c = rt.add(var_c, rt.new_int(5))
					var_ascii = rt.concat(var_ascii, rt.new_string('?'))
				}
				var_char = rt.call_function('pack', [rt.new_string('C*'), var_ord_var_c.clone(), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(1)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(2)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(3)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(4)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(5)))])])
				var_c = rt.add(var_c, rt.new_int(5))
				var_utf16 = this.utf82utf16(var_char.clone())
				var_ascii = rt.concat(var_ascii, rt.call_function('sprintf', [rt.new_string('\\u%04s'), rt.call_function('bin2hex', [rt.create_array_from_list(var_utf16)])]))
			}
			rt.pre_inc(var_c)
		}
		return rt.new_string('"' + (var_ascii).str() + '"')
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('array'))) {
		if var_var.clone().is_array() && rt.is_true(rt.new_int(var_var.clone().array_count())) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.func_array_keys(var_var.clone()), rt.call_function('range', [rt.new_int(0), rt.new_int(var_var.clone().array_count() - 1)]))))) {
			mut var_properties := rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Services_JSON', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'name_value' }]), rt.func_array_keys(var_var.clone()), rt.call_function('array_values', [var_var.clone()])])
			mut iter_1 := var_properties.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_property := item_1.val
				mut iife_temp_1 := Class_Services_JSON{}
				mut iife_result_1 := iife_temp_1.iserror(var_property.clone())
				if rt.is_true(iife_result_1) {
					return var_property.clone()
				}
			}
			return rt.new_string('{' + (rt.call_function('join', [rt.new_string(','), var_properties.clone()])).str() + '}')
		}
		mut var_elements := rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Services_JSON', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_encode' }]), var_var.clone()])
		mut iter_2 := var_elements.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_element := item_2.val
			mut iife_temp_2 := Class_Services_JSON{}
			mut iife_result_2 := iife_temp_2.iserror(var_element.clone())
			if rt.is_true(iife_result_2) {
				return var_element.clone()
			}
		}
		return rt.new_string('[' + (rt.call_function('join', [rt.new_string(','), var_elements.clone()])).str() + ']')
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('object'))) {
		if rt.is_true(rt.bitwise_and(this.use, rt.get_constant('SERVICES_JSON_USE_TO_JSON'))) && rt.is_true(rt.call_function('method_exists', [var_var.clone(), rt.new_string('toJSON')])) {
			mut var_recode := rt.call_method(var_var, 'toJSON', []rt.PhpVal{})
			if rt.is_true(rt.call_function('method_exists', [var_recode.clone(), rt.new_string('toJSON')])) {
				return if rt.is_true(rt.bitwise_and(this.use, rt.get_constant('SERVICES_JSON_SUPPRESS_ERRORS'))) { rt.new_string('null') } else { create_services_json_error((rt.call_function('get_class', [var_var.clone()])).str() + ' toJSON returned an object with a toJSON method.') }
			}
			return this._encode(var_recode.clone())
		}
		mut var_vars := rt.call_function('get_object_vars', [var_var.clone()])
		var_properties = rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Services_JSON', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'name_value' }]), rt.func_array_keys(var_vars.clone()), rt.call_function('array_values', [var_vars.clone()])])
		mut iter_3 := var_properties.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_property := item_3.val
			mut iife_temp_3 := Class_Services_JSON{}
			mut iife_result_3 := iife_temp_3.iserror(var_property.clone())
			if rt.is_true(iife_result_3) {
				return var_property.clone()
			}
		}
		return rt.new_string('{' + (rt.call_function('join', [rt.new_string(','), var_properties.clone()])).str() + '}')
	} else {
		return if rt.is_true(rt.bitwise_and(this.use, rt.get_constant('SERVICES_JSON_SUPPRESS_ERRORS'))) { rt.new_string('null') } else { create_services_json_error((rt.call_function('gettype', [var_var.clone()])).str() + ' can not be encoded as JSON string') }
	}
	return rt.new_null()
}

fn (mut this Class_Services_JSON) name_value(var_name rt.PhpVal, var_value rt.PhpVal) string {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	mut var_encoded_value := this._encode(var_value.clone())
	mut iife_temp_4 := Class_Services_JSON{}
	mut iife_result_4 := iife_temp_4.iserror(var_encoded_value.clone())
	if rt.is_true(iife_result_4) {
		return (var_encoded_value).str()
	}
	return (this._encode(rt.new_string((var_name).str()))).str() + ':' + (var_encoded_value).str()
}

fn (mut this Class_Services_JSON) reduce_string(var_str rt.PhpVal) string {
	mut var_str_mutated := var_str
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	var_str_mutated = rt.call_function('preg_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '#^\\s*//(.+)$#m' }, rt.ArrayItem{ key: none, val: '#^\\s*/\\*(.+)\\*/#Us' }, rt.ArrayItem{ key: none, val: '#/\\*(.+)\\*/\\s*$#Us' }]), rt.new_string(''), var_str_mutated.clone()])
	return var_str_mutated.clone().to_string().trim_space()
}

fn (mut this Class_Services_JSON) decode(var_str rt.PhpVal) rt.PhpVal {
	mut var_str_mutated := var_str
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	var_str_mutated = rt.new_string(this.reduce_string(var_str_mutated.clone()))
	mut switch_val_5 := rt.new_string(var_str_mutated.clone().to_string().to_lower())
	if rt.is_true(rt.equal(switch_val_5, rt.new_string('true'))) {
		return rt.new_bool(true)
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('false'))) {
		return rt.new_bool(false)
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('null'))) {
		return rt.new_null()
	} else {
		mut var_m := rt.new_array()
		if rt.is_true(rt.new_bool(var_str_mutated.clone().is_long() || var_str_mutated.clone().is_double())) {
			return if rt.new_float((var_str_mutated).to_f64()) == rt.new_int((var_str_mutated).to_i64()) { rt.new_int((var_str_mutated).to_i64()) } else { rt.new_float((var_str_mutated).to_f64()) }
		} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^("|\').*(\\1)$/s'), var_str_mutated.clone(), var_m.clone()])) && rt.is_true(rt.equal(var_m.array_get(rt.new_int(1)), var_m.array_get(rt.new_int(2)))) {
			mut var_delim := this.substr8(var_str_mutated.clone(), rt.new_int(0), 1)
			mut var_chrs := this.substr8(var_str_mutated.clone(), rt.new_int(1), -1)
			mut var_utf8 := rt.new_string('')
			mut var_strlen_chrs := rt.new_int(this.strlen8(var_chrs.clone()))
			mut var_c := rt.new_int(0)
			for {
				if !(rt.is_true(rt.less(var_c, var_strlen_chrs))) { break }
				mut var_substr_chrs_c_2 := this.substr8(var_chrs.clone(), var_c.clone(), 2)
				mut var_ord_chrs_c := rt.call_function('ord', [var_chrs.array_get(var_c)])
				mut switch_val_6 := rt.new_bool(true)
				if rt.is_true(rt.equal(switch_val_6, rt.equal(var_substr_chrs_c_2, rt.new_string('\\b')))) {
					var_utf8 = rt.concat(var_utf8, rt.call_function('chr', [rt.new_int(8)]))
					rt.pre_inc(var_c)
				} else if rt.is_true(rt.equal(switch_val_6, rt.equal(var_substr_chrs_c_2, rt.new_string('\\t')))) {
					var_utf8 = rt.concat(var_utf8, rt.call_function('chr', [rt.new_int(9)]))
					rt.pre_inc(var_c)
				} else if rt.is_true(rt.equal(switch_val_6, rt.equal(var_substr_chrs_c_2, rt.new_string('\\n')))) {
					var_utf8 = rt.concat(var_utf8, rt.call_function('chr', [rt.new_int(10)]))
					rt.pre_inc(var_c)
				} else if rt.is_true(rt.equal(switch_val_6, rt.equal(var_substr_chrs_c_2, rt.new_string('\\f')))) {
					var_utf8 = rt.concat(var_utf8, rt.call_function('chr', [rt.new_int(12)]))
					rt.pre_inc(var_c)
				} else if rt.is_true(rt.equal(switch_val_6, rt.equal(var_substr_chrs_c_2, rt.new_string('\\r')))) {
					var_utf8 = rt.concat(var_utf8, rt.call_function('chr', [rt.new_int(13)]))
					rt.pre_inc(var_c)
				} else if rt.is_true(rt.equal(switch_val_6, rt.equal(var_substr_chrs_c_2, rt.new_string('\\"')))) || rt.is_true(rt.equal(switch_val_6, rt.equal(var_substr_chrs_c_2, rt.new_string('\\\'')))) || rt.is_true(rt.equal(switch_val_6, rt.equal(var_substr_chrs_c_2, rt.new_string('\\\\')))) || rt.is_true(rt.equal(switch_val_6, rt.equal(var_substr_chrs_c_2, rt.new_string('\\/')))) {
					if (rt.is_true(rt.equal(var_delim, rt.new_string('"'))) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_substr_chrs_c_2, rt.new_string('\\\'')))))) || (rt.is_true(rt.equal(var_delim, rt.new_string('\''))) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_substr_chrs_c_2, rt.new_string('\\"')))))) {
						var_utf8 = rt.concat(var_utf8, var_chrs.array_get(rt.pre_inc(var_c)))
					}
				} else if rt.is_true(rt.equal(switch_val_6, rt.call_function('preg_match', [rt.new_string('/\\\\u[0-9A-F]{4}/i'), this.substr8(var_chrs.clone(), var_c.clone(), 6)]))) {
					mut var_utf16 := (rt.call_function('chr', [rt.call_function('hexdec', [this.substr8(var_chrs.clone(), rt.add(var_c, rt.new_int(2)), 2)])])).str() + (rt.call_function('chr', [rt.call_function('hexdec', [this.substr8(var_chrs.clone(), rt.add(var_c, rt.new_int(4)), 2)])])).str()
					var_utf8 = rt.concat(var_utf8, this.utf162utf8(var_utf16.clone()))
					var_c = rt.add(var_c, rt.new_int(5))
				} else if rt.is_true(rt.equal(switch_val_6, rt.new_bool(rt.is_true(rt.greater_equal(var_ord_chrs_c, rt.new_int(32))) && rt.is_true(rt.less_equal(var_ord_chrs_c, rt.new_int(127)))))) {
					var_utf8 = rt.concat(var_utf8, var_chrs.array_get(var_c))
				} else if rt.is_true(rt.equal(switch_val_6, rt.new_bool(rt.bitwise_and(var_ord_chrs_c, rt.new_int(224)) == 192))) {
					var_utf8 = rt.concat(var_utf8, this.substr8(var_chrs.clone(), var_c.clone(), 2))
					rt.pre_inc(var_c)
				} else if rt.is_true(rt.equal(switch_val_6, rt.new_bool(rt.bitwise_and(var_ord_chrs_c, rt.new_int(240)) == 224))) {
					var_utf8 = rt.concat(var_utf8, this.substr8(var_chrs.clone(), var_c.clone(), 3))
					var_c = rt.add(var_c, rt.new_int(2))
				} else if rt.is_true(rt.equal(switch_val_6, rt.new_bool(rt.bitwise_and(var_ord_chrs_c, rt.new_int(248)) == 240))) {
					var_utf8 = rt.concat(var_utf8, this.substr8(var_chrs.clone(), var_c.clone(), 4))
					var_c = rt.add(var_c, rt.new_int(3))
				} else if rt.is_true(rt.equal(switch_val_6, rt.new_bool(rt.bitwise_and(var_ord_chrs_c, rt.new_int(252)) == 248))) {
					var_utf8 = rt.concat(var_utf8, this.substr8(var_chrs.clone(), var_c.clone(), 5))
					var_c = rt.add(var_c, rt.new_int(4))
				} else if rt.is_true(rt.equal(switch_val_6, rt.new_bool(rt.bitwise_and(var_ord_chrs_c, rt.new_int(254)) == 252))) {
					var_utf8 = rt.concat(var_utf8, this.substr8(var_chrs.clone(), var_c.clone(), 6))
					var_c = rt.add(var_c, rt.new_int(5))
				}
				rt.pre_inc(var_c)
			}
			return var_utf8.clone()
		} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\[.*\\]$/s'), var_str_mutated.clone()])) || rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\{.*\\}$/s'), var_str_mutated.clone()])) {
			if rt.is_true(rt.equal(var_str_mutated.array_get(rt.new_int(0)), rt.new_string('['))) {
			mut var_stk := rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('SERVICES_JSON_IN_ARR') }])
			mut var_arr := rt.new_array()
			} else {
				if rt.is_true(rt.bitwise_and(this.use, rt.get_constant('SERVICES_JSON_LOOSE_TYPE'))) {
				var_stk = rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('SERVICES_JSON_IN_OBJ') }])
				mut var_obj := rt.new_array()
				} else {
				var_stk = rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('SERVICES_JSON_IN_OBJ') }])
				var_obj = create_stdclass()
				}
			}
			var_stk.clone().array_push(rt.create_array([rt.ArrayItem{ key: 'what', val: rt.get_constant('SERVICES_JSON_SLICE') }, rt.ArrayItem{ key: 'where', val: 0 }, rt.ArrayItem{ key: 'delim', val: false }]))
			mut var_chrs := this.substr8(var_str_mutated.clone(), rt.new_int(1), -1)
			mut var_chrs := rt.new_string(this.reduce_string(var_chrs.clone()))
			if rt.is_true(rt.equal(var_chrs, rt.new_string(''))) {
				if rt.is_true(rt.equal(rt.call_function('reset', [var_stk.clone()]), rt.get_constant('SERVICES_JSON_IN_ARR'))) {
					return var_arr.clone()
				} else {
					return var_obj.clone()
				}
			}
			mut var_strlen_chrs := rt.new_int(this.strlen8(var_chrs.clone()))
			mut var_c := rt.new_int(0)
			for {
				if !(rt.is_true(rt.less_equal(var_c, var_strlen_chrs))) { break }
				mut var_top := rt.call_function('end', [var_stk.clone()])
				mut var_substr_chrs_c_2 := this.substr8(var_chrs.clone(), var_c.clone(), 2)
				if rt.is_true(rt.equal(var_c, var_strlen_chrs)) || (rt.is_true(rt.equal(var_chrs.array_get(var_c), rt.new_string(','))) && rt.is_true(rt.equal(var_top.array_get(rt.new_string('what')), rt.get_constant('SERVICES_JSON_SLICE')))) {
					mut var_slice := this.substr8(var_chrs.clone(), var_top.array_get(rt.new_string('where')), (rt.sub(var_c, var_top.array_get(rt.new_string('where')))).to_bool())
					var_stk.clone().array_push(rt.create_array([rt.ArrayItem{ key: 'what', val: rt.get_constant('SERVICES_JSON_SLICE') }, rt.ArrayItem{ key: 'where', val: rt.add(var_c, rt.new_int(1)) }, rt.ArrayItem{ key: 'delim', val: false }]))
					if rt.is_true(rt.equal(rt.call_function('reset', [var_stk.clone()]), rt.get_constant('SERVICES_JSON_IN_ARR'))) {
						var_arr.clone().array_push(this.decode(var_slice.clone()))
					} else if rt.is_true(rt.equal(rt.call_function('reset', [var_stk.clone()]), rt.get_constant('SERVICES_JSON_IN_OBJ'))) {
						mut var_parts := rt.new_array()
						if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*(["\'].*[^\\\\]["\'])\\s*:/Uis'), var_slice.clone(), var_parts.clone()])) {
							mut var_key := this.decode(var_parts.array_get(rt.new_int(1)))
							mut var_val := this.decode(rt.new_string((rt.call_function('substr', [var_slice.clone(), rt.new_int(var_parts.array_get(rt.new_int(0)).to_string().len)]).to_string().trim_space()).str()))
							if rt.is_true(rt.bitwise_and(this.use, rt.get_constant('SERVICES_JSON_LOOSE_TYPE'))) {
								var_obj.array_set(var_key, var_val.clone())
							} else {
								rt.set_property(var_obj, '{"nodeType":"Expr_Variable","line":833,"name":"key"}', var_val.clone())
							}
						} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*(\\w+)\\s*:/Uis'), var_slice.clone(), var_parts.clone()])) {
							var_key = var_parts.array_get(rt.new_int(1))
							var_val = this.decode(rt.new_string((rt.call_function('substr', [var_slice.clone(), rt.new_int(var_parts.array_get(rt.new_int(0)).to_string().len)]).to_string().trim_space()).str()))
							if rt.is_true(rt.bitwise_and(this.use, rt.get_constant('SERVICES_JSON_LOOSE_TYPE'))) {
								var_obj.array_set(var_key, var_val.clone())
							} else {
								rt.set_property(var_obj, '{"nodeType":"Expr_Variable","line":843,"name":"key"}', var_val.clone())
							}
						}
					}
				} else if rt.is_true(rt.equal(var_chrs.array_get(var_c), rt.new_string('"'))) || rt.is_true(rt.equal(var_chrs.array_get(var_c), rt.new_string('\''))) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_top.array_get(rt.new_string('what')), rt.get_constant('SERVICES_JSON_IN_STR'))))) {
					var_stk.clone().array_push(rt.create_array([rt.ArrayItem{ key: 'what', val: rt.get_constant('SERVICES_JSON_IN_STR') }, rt.ArrayItem{ key: 'where', val: var_c }, rt.ArrayItem{ key: 'delim', val: var_chrs.array_get(var_c) }]))
				} else if rt.is_true(rt.equal(var_chrs.array_get(var_c), var_top.array_get(rt.new_string('delim')))) && rt.is_true(rt.equal(var_top.array_get(rt.new_string('what')), rt.get_constant('SERVICES_JSON_IN_STR'))) && rt.is_true(rt.new_bool(this.strlen8(this.substr8(var_chrs.clone(), rt.new_int(0), (var_c).to_bool())) - this.strlen8(rt.new_string(this.substr8(var_chrs.clone(), rt.new_int(0), (var_c).to_bool()).to_string().trim_right(' \t\n\r'))) % 2 != 1)) {
					rt.call_function('array_pop', [var_stk.clone()])
				} else if rt.is_true(rt.equal(var_chrs.array_get(var_c), rt.new_string('['))) && rt.is_true(rt.call_function('in_array', [var_top.array_get(rt.new_string('what')), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('SERVICES_JSON_SLICE') }, rt.ArrayItem{ key: none, val: rt.get_constant('SERVICES_JSON_IN_ARR') }, rt.ArrayItem{ key: none, val: rt.get_constant('SERVICES_JSON_IN_OBJ') }])])) {
					var_stk.clone().array_push(rt.create_array([rt.ArrayItem{ key: 'what', val: rt.get_constant('SERVICES_JSON_IN_ARR') }, rt.ArrayItem{ key: 'where', val: var_c }, rt.ArrayItem{ key: 'delim', val: false }]))
				} else if rt.is_true(rt.equal(var_chrs.array_get(var_c), rt.new_string(']'))) && rt.is_true(rt.equal(var_top.array_get(rt.new_string('what')), rt.get_constant('SERVICES_JSON_IN_ARR'))) {
					rt.call_function('array_pop', [var_stk.clone()])
				} else if rt.is_true(rt.equal(var_chrs.array_get(var_c), rt.new_string('{'))) && rt.is_true(rt.call_function('in_array', [var_top.array_get(rt.new_string('what')), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('SERVICES_JSON_SLICE') }, rt.ArrayItem{ key: none, val: rt.get_constant('SERVICES_JSON_IN_ARR') }, rt.ArrayItem{ key: none, val: rt.get_constant('SERVICES_JSON_IN_OBJ') }])])) {
					var_stk.clone().array_push(rt.create_array([rt.ArrayItem{ key: 'what', val: rt.get_constant('SERVICES_JSON_IN_OBJ') }, rt.ArrayItem{ key: 'where', val: var_c }, rt.ArrayItem{ key: 'delim', val: false }]))
				} else if rt.is_true(rt.equal(var_chrs.array_get(var_c), rt.new_string('}'))) && rt.is_true(rt.equal(var_top.array_get(rt.new_string('what')), rt.get_constant('SERVICES_JSON_IN_OBJ'))) {
					rt.call_function('array_pop', [var_stk.clone()])
				} else if rt.is_true(rt.equal(var_substr_chrs_c_2, rt.new_string('/*'))) && rt.is_true(rt.call_function('in_array', [var_top.array_get(rt.new_string('what')), rt.create_array([rt.ArrayItem{ key: none, val: rt.get_constant('SERVICES_JSON_SLICE') }, rt.ArrayItem{ key: none, val: rt.get_constant('SERVICES_JSON_IN_ARR') }, rt.ArrayItem{ key: none, val: rt.get_constant('SERVICES_JSON_IN_OBJ') }])])) {
					var_stk.clone().array_push(rt.create_array([rt.ArrayItem{ key: 'what', val: rt.get_constant('SERVICES_JSON_IN_CMT') }, rt.ArrayItem{ key: 'where', val: var_c }, rt.ArrayItem{ key: 'delim', val: false }]))
					rt.post_inc(var_c)
				} else if rt.is_true(rt.equal(var_substr_chrs_c_2, rt.new_string('*/'))) && rt.is_true(rt.equal(var_top.array_get(rt.new_string('what')), rt.get_constant('SERVICES_JSON_IN_CMT'))) {
					rt.call_function('array_pop', [var_stk.clone()])
					rt.post_inc(var_c)
					mut var_i := var_top.array_get(rt.new_string('where'))
					for {
						if !(rt.is_true(rt.less_equal(var_i, var_c))) { break }
						var_chrs = rt.call_function('substr_replace', [var_chrs.clone(), rt.new_string(' '), var_i.clone(), rt.new_int(1)])
						rt.pre_inc(var_i)
					}
				}
				rt.pre_inc(var_c)
			}
			if rt.is_true(rt.equal(rt.call_function('reset', [var_stk.clone()]), rt.get_constant('SERVICES_JSON_IN_ARR'))) {
				return var_arr.clone()
			} else if rt.is_true(rt.equal(rt.call_function('reset', [var_stk.clone()]), rt.get_constant('SERVICES_JSON_IN_OBJ'))) {
				return var_obj.clone()
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_Services_JSON) iserror(var_data rt.PhpVal, var_code rt.PhpVal) bool {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('pear')])) {
		mut iife_temp_5 := Class_PEAR{}
		mut iife_result_5 := iife_temp_5.iserror(var_data.clone(), var_code.clone())
		return (iife_result_5).to_bool()
	} else if var_data.clone().is_object() && rt.is_true(rt.new_bool(rt.instance_of(var_data, 'services_json_error'))) || rt.is_true(rt.call_function('is_subclass_of', [var_data.clone(), rt.new_string('services_json_error')])) {
		return true
	}
	return false
}

fn (mut this Class_Services_JSON) strlen8(var_str rt.PhpVal) i64 {
	mut var_str_mutated := var_str
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	if rt.is_true(this._mb_strlen) {
		return (rt.call_function('mb_strlen', [var_str_mutated.clone(), rt.new_string('8bit')])).to_i64()
	}
	return var_str_mutated.clone().to_string().len
}

fn (mut this Class_Services_JSON) substr8(var_string rt.PhpVal, var_start rt.PhpVal, length bool) rt.PhpVal {
	mut length_mutated := length
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	if rt.is_true(rt.identical(rt.new_bool(length_mutated), rt.new_bool(false))) {
	length_mutated = (this.strlen8(var_string.clone()) - var_start).to_bool()
	}
	if rt.is_true(this._mb_substr) {
		return rt.call_function('mb_substr', [var_string.clone(), var_start.clone(), rt.new_bool(length_mutated).clone(), rt.new_string('8bit')])
	}
	return rt.call_function('substr', [var_string.clone(), var_start.clone(), rt.new_bool(length_mutated).clone()])
}

struct Class_Services_JSON_Error {
	rt.PhpObjectBase
}

fn (mut this Class_Services_JSON_Error) construct(message string, var_code rt.PhpVal, var_mode rt.PhpVal, var_options rt.PhpVal, var_userinfo rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	this.Class_PEAR_Error.pear_error(rt.new_string(message), var_code.clone(), var_mode.clone(), var_options.clone(), var_userinfo.clone())
}

fn (mut this Class_Services_JSON_Error) services_json_error(message string, var_code rt.PhpVal, var_mode rt.PhpVal, var_options rt.PhpVal, var_userinfo rt.PhpVal) {
	rt.call_function('_deprecated_constructor', [rt.new_string('Services_JSON_Error'), rt.new_string('5.3.0'), rt.call_function('get_class', [rt.new_object('Services_JSON_Error', ['PEAR_Error'], &this)])])
	mut iife_temp_6 := Class_Services_JSON_Error{}
	iife_temp_6.construct(message, var_code.clone(), var_mode.clone(), var_options.clone(), var_userinfo.clone())
	rt.new_null()
}

struct Class_Services_JSON_Error {
	rt.PhpObjectBase
}

fn (mut this Class_Services_JSON_Error) construct(message string, var_code rt.PhpVal, var_mode rt.PhpVal, var_options rt.PhpVal, var_userinfo rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
}

fn (mut this Class_Services_JSON_Error) services_json_error(message string, var_code rt.PhpVal, var_mode rt.PhpVal, var_options rt.PhpVal, var_userinfo rt.PhpVal) {
	rt.call_function('_deprecated_constructor', [rt.new_string('Services_JSON_Error'), rt.new_string('5.3.0'), rt.call_function('get_class', [rt.new_object('Services_JSON_Error', ['PEAR_Error'], &this)])])
	mut iife_temp_7 := Class_Services_JSON_Error{}
	iife_temp_7.construct(message, var_code.clone(), var_mode.clone(), var_options.clone(), var_userinfo.clone())
	rt.new_null()
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_PEAR {
	rt.PhpObjectBase
}

struct Class_PEAR_Error {
	rt.PhpObjectBase
}

fn create_services_json(use i64) &Class_Services_JSON {
	mut obj := &Class_Services_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
		use: rt.new_null()
		_mb_strlen: rt.new_bool(false)
		_mb_substr: rt.new_bool(false)
		_mb_convert_encoding: rt.new_bool(false)
	}
	obj.construct(use)
	return obj
}

fn create_services_json_error(message string, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) &Class_Services_JSON_Error {
	mut obj := &Class_Services_JSON_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(message, arg_1, arg_2, arg_3, arg_4)
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_pear(_args ...rt.PhpVal) &Class_PEAR {
	mut obj := &Class_PEAR{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_pear_error(_args ...rt.PhpVal) &Class_PEAR_Error {
	mut obj := &Class_PEAR_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Services_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'Services_JSON' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.services_json(dispatch_arg_0)
			return rt.new_null()
		}
		'utf162utf8' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.utf162utf8(dispatch_arg_0))
		}
		'utf82utf16' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.utf82utf16(dispatch_arg_0))
		}
		'encode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.encode(dispatch_arg_0)
		}
		'encodeUnsafe' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.encodeunsafe(dispatch_arg_0)
		}
		'_encode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._encode(dispatch_arg_0)
		}
		'name_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.name_value(dispatch_arg_0, dispatch_arg_1))
		}
		'reduce_string' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.reduce_string(dispatch_arg_0))
		}
		'decode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.decode(dispatch_arg_0)
		}
		'isError' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.iserror(dispatch_arg_0, dispatch_arg_1))
		}
		'strlen8' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.strlen8(dispatch_arg_0))
		}
		'substr8' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.substr8(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Services_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'use' { return this.use }
		'_mb_strlen' { return this._mb_strlen }
		'_mb_substr' { return this._mb_substr }
		'_mb_convert_encoding' { return this._mb_convert_encoding }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Services_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'use' { this.use = val; return true }
		'_mb_strlen' { this._mb_strlen = val; return true }
		'_mb_substr' { this._mb_substr = val; return true }
		'_mb_convert_encoding' { this._mb_convert_encoding = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Services_JSON_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'Services_JSON_Error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			this.services_json_error(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Services_JSON_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Services_JSON_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_PEAR) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PEAR) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PEAR) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_PEAR_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PEAR_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PEAR_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('_deprecated_file', [rt.call_function('basename', [rt.new_string(@FILE)]), rt.new_string('5.3.0'), rt.new_string(''), rt.new_string('The PHP native JSON extension is now a requirement.')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('Services_JSON')]))))) {
		rt.call_function('define', [rt.new_string('SERVICES_JSON_SLICE'), rt.new_int(1)])
		rt.call_function('define', [rt.new_string('SERVICES_JSON_IN_STR'), rt.new_int(2)])
		rt.call_function('define', [rt.new_string('SERVICES_JSON_IN_ARR'), rt.new_int(3)])
		rt.call_function('define', [rt.new_string('SERVICES_JSON_IN_OBJ'), rt.new_int(4)])
		rt.call_function('define', [rt.new_string('SERVICES_JSON_IN_CMT'), rt.new_int(5)])
		rt.call_function('define', [rt.new_string('SERVICES_JSON_LOOSE_TYPE'), rt.new_int(16)])
		rt.call_function('define', [rt.new_string('SERVICES_JSON_SUPPRESS_ERRORS'), rt.new_int(32)])
		rt.call_function('define', [rt.new_string('SERVICES_JSON_USE_TO_JSON'), rt.new_int(64)])
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('PEAR_Error')])) {
		} else {
		}
	}
}
