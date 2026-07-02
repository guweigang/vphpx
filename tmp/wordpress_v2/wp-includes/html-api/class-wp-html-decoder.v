import rt

struct Class_WP_HTML_Decoder {
	rt.PhpObjectBase
}

fn Class_WP_HTML_Decoder.attribute_starts_with(var_haystack rt.PhpVal, var_search_text rt.PhpVal, case_sensitivity string) bool {
	mut var_token_length := rt.new_null()
	mut var_search_length := rt.new_int(var_search_text.clone().to_string().len)
	mut var_loose_case := rt.identical(rt.new_string('ascii-case-insensitive'),
		rt.new_string(case_sensitivity))
	mut var_haystack_end := rt.new_int(var_haystack.clone().to_string().len)
	mut var_search_at := rt.new_int(0)
	mut var_haystack_at := rt.new_int(0)
	for rt.is_true(rt.less(var_search_at, var_search_length))
		&& rt.is_true(rt.less(var_haystack_at, var_haystack_end)) {
		mut var_chars_match := if rt.is_true(var_loose_case) {
			rt.identical(rt.new_string(var_haystack.array_get(var_haystack_at).to_string().to_lower()),
				rt.new_string(var_search_text.array_get(var_search_at).to_string().to_lower()))
		} else {
			rt.identical(var_haystack.array_get(var_haystack_at),
				var_search_text.array_get(var_search_at))
		}
		mut var_is_introducer := rt.identical(rt.new_string('&'),
			var_haystack.array_get(var_haystack_at))
		mut var_next_chunk := if rt.is_true(var_is_introducer) {
			Class_WP_HTML_Decoder.read_character_reference('attribute', var_haystack.clone(),
				var_haystack_at.clone(), var_token_length.clone())
		} else {
			rt.new_null()
		}
		if rt.is_true(rt.identical(rt.new_null(), var_next_chunk))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_chars_match)))) {
			return false
		}
		if rt.is_true(rt.identical(rt.new_null(), var_next_chunk)) && rt.is_true(var_chars_match) {
			rt.pre_inc(var_haystack_at)
			rt.pre_inc(var_search_at)
			continue
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [
			var_search_text.clone(),
			var_next_chunk.clone(),
			var_search_at.clone(),
			rt.new_int(var_next_chunk.clone().to_string().len),
			var_loose_case.clone(),
		])))))
		{
			return false
		}
		var_haystack_at = rt.add(var_haystack_at, var_token_length)
		var_search_at = rt.add(var_search_at, rt.new_int(var_next_chunk.clone().to_string().len))
	}
	return true
}

fn Class_WP_HTML_Decoder.decode_text_node(var_text rt.PhpVal) string {
	return (Class_WP_HTML_Decoder.decode(rt.new_string('data'), var_text.clone())).str()
}

fn Class_WP_HTML_Decoder.decode_attribute(var_text rt.PhpVal) string {
	return (Class_WP_HTML_Decoder.decode(rt.new_string('attribute'), var_text.clone())).str()
}

fn Class_WP_HTML_Decoder.decode(var_context rt.PhpVal, var_text rt.PhpVal) string {
	mut var_token_length := rt.new_null()
	mut var_decoded := rt.new_string('')
	mut var_end := rt.new_int(var_text.clone().to_string().len)
	mut var_at := rt.new_int(0)
	mut var_was_at := rt.new_int(0)
	for rt.is_true(rt.less(var_at, var_end)) {
		mut var_next_character_reference_at := rt.call_function('strpos', [
			var_text.clone(), rt.new_string('&'), var_at.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_next_character_reference_at)) {
			break
		}
		mut var_character_reference := Class_WP_HTML_Decoder.read_character_reference(var_context.to_i64(),
			var_text.clone(), var_next_character_reference_at.clone(), var_token_length.clone())
		if !var_character_reference.is_null() {
			var_at = var_next_character_reference_at.clone()
			var_decoded = rt.concat(var_decoded, rt.call_function('substr', [
				var_text.clone(), var_was_at.clone(), rt.sub(var_at, var_was_at)]))
			var_decoded = rt.concat(var_decoded, var_character_reference)
			var_at = rt.add(var_at, var_token_length)
			var_was_at = var_at.clone()
			continue
		}
		rt.pre_inc(var_at)
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_was_at)) {
		return var_text.str()
	}
	if rt.is_true(rt.less(var_was_at, var_end)) {
		var_decoded = rt.concat(var_decoded, rt.call_function('substr', [
			var_text.clone(), var_was_at.clone(), rt.sub(var_end, var_was_at)]))
	}
	return var_decoded.str()
}

fn Class_WP_HTML_Decoder.read_character_reference(var_context rt.PhpVal, var_text rt.PhpVal, at i64, var_match_byte_length rt.PhpVal) rt.PhpVal {
	mut var_html5_named_character_references := rt.new_null()
	mut at_mutated := at
	mut var_match_byte_length_mutated := var_match_byte_length
	mut var_length := rt.new_int(var_text.clone().to_string().len)
	if rt.is_true(rt.greater_equal(at_mutated + 1, var_length)) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('&'),
		var_text.array_get(rt.new_int(at_mutated))))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('#'), var_text.array_get(rt.new_int(at_mutated + 1)))) {
		if rt.is_true(rt.greater_equal(at_mutated + 2, var_length)) {
			return rt.new_null()
		}
		mut var_digits_at := rt.new_int(at_mutated + 2)
		if rt.is_true(rt.identical(rt.new_string('x'), var_text.array_get(var_digits_at)))
			|| rt.is_true(rt.identical(rt.new_string('X'), var_text.array_get(var_digits_at))) {
			mut var_numeric_base := rt.new_int(16)
			mut var_numeric_digits := rt.new_string('0123456789abcdefABCDEF')
			mut var_max_digits := rt.new_int(6)
			rt.pre_inc(var_digits_at)
		} else {
			var_numeric_base = rt.new_int(10)
			var_numeric_digits = rt.new_string('0123456789')
			var_max_digits = rt.new_int(7)
		}
		mut var_zero_count := rt.call_function('strspn', [var_text.clone(),
			rt.new_string('0'), var_digits_at.clone()])
		mut var_digit_count := rt.call_function('strspn', [var_text.clone(),
			var_numeric_digits.clone(), rt.add(var_digits_at, var_zero_count)])
		mut var_after_digits := rt.add(rt.add(var_digits_at, var_zero_count), var_digit_count)
		mut var_has_semicolon := rt.new_bool(rt.is_true(rt.less(var_after_digits, var_length))
			&& rt.is_true(rt.identical(rt.new_string(';'), var_text.array_get(var_after_digits))))
		mut var_end_of_span := if rt.is_true(var_has_semicolon) {
			rt.add(var_after_digits, rt.new_int(1))
		} else {
			var_after_digits
		}
		if rt.is_true(rt.identical(rt.new_int(0), var_digit_count))
			&& rt.is_true(rt.identical(rt.new_int(0), var_zero_count)) {
			return rt.new_null()
		}
		if rt.is_true(rt.identical(rt.new_int(0), var_digit_count)) {
			var_match_byte_length_mutated = rt.sub(var_end_of_span, rt.new_int(at_mutated))
			return rt.new_string('�')
		}
		if rt.is_true(rt.greater(var_digit_count, var_max_digits)) {
			var_match_byte_length_mutated = rt.sub(var_end_of_span, rt.new_int(at_mutated))
			return rt.new_string('�')
		}
		mut var_digits := rt.call_function('substr', [var_text.clone(),
			rt.add(var_digits_at, var_zero_count), var_digit_count.clone()])
		mut var_code_point := rt.new_int(var_digits.clone().to_i64())
		if rt.is_true(rt.greater_equal(var_code_point, rt.new_int(128)))
			&& rt.is_true(rt.less_equal(var_code_point, rt.new_int(159))) {
			mut var_windows_1252_mapping := rt.create_array([
				rt.ArrayItem{ key: none, val: 8364 },
				rt.ArrayItem{ key: none, val: 129 },
				rt.ArrayItem{ key: none, val: 8218 },
				rt.ArrayItem{ key: none, val: 402 },
				rt.ArrayItem{ key: none, val: 8222 },
				rt.ArrayItem{ key: none, val: 8230 },
				rt.ArrayItem{ key: none, val: 8224 },
				rt.ArrayItem{ key: none, val: 8225 },
				rt.ArrayItem{ key: none, val: 710 },
				rt.ArrayItem{ key: none, val: 8240 },
				rt.ArrayItem{ key: none, val: 352 },
				rt.ArrayItem{ key: none, val: 8249 },
				rt.ArrayItem{ key: none, val: 338 },
				rt.ArrayItem{ key: none, val: 141 },
				rt.ArrayItem{ key: none, val: 381 },
				rt.ArrayItem{ key: none, val: 143 },
				rt.ArrayItem{ key: none, val: 144 },
				rt.ArrayItem{ key: none, val: 8216 },
				rt.ArrayItem{ key: none, val: 8217 },
				rt.ArrayItem{ key: none, val: 8220 },
				rt.ArrayItem{ key: none, val: 8221 },
				rt.ArrayItem{ key: none, val: 8226 },
				rt.ArrayItem{ key: none, val: 8211 },
				rt.ArrayItem{ key: none, val: 8212 },
				rt.ArrayItem{ key: none, val: 732 },
				rt.ArrayItem{ key: none, val: 8482 },
				rt.ArrayItem{ key: none, val: 353 },
				rt.ArrayItem{ key: none, val: 8250 },
				rt.ArrayItem{ key: none, val: 339 },
				rt.ArrayItem{ key: none, val: 157 },
				rt.ArrayItem{ key: none, val: 382 },
				rt.ArrayItem{ key: none, val: 376 },
			])
			var_code_point = var_windows_1252_mapping.array_get(rt.sub(var_code_point,
				rt.new_int(128)))
		}
		var_match_byte_length_mutated = rt.sub(var_end_of_span, rt.new_int(at_mutated))
		return Class_WP_HTML_Decoder.code_point_to_utf8_bytes(var_code_point.clone())
	}
	mut var_name_at := rt.new_int(at_mutated + 1)
	if rt.is_true(rt.greater(rt.add(var_name_at, rt.new_int(2)), var_length)) {
		return rt.new_null()
	}
	mut var_name_length := rt.new_int(0)
	mut var_replacement := rt.call_method(var_html5_named_character_references, 'read_token', [
		var_text.clone(),
		var_name_at.clone(),
		var_name_length.clone(),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_replacement)) {
		return rt.new_null()
	}
	mut var_after_name := rt.add(var_name_at, var_name_length)
	if rt.is_true(rt.identical(rt.new_string(';'), var_text.array_get(rt.sub(rt.add(var_name_at,
		var_name_length), rt.new_int(1)))))
	{
		var_match_byte_length_mutated = rt.sub(var_after_name, rt.new_int(at_mutated))
		return var_replacement.clone()
	}
	mut var_ambiguous_follower := rt.new_bool(rt.is_true(rt.less(var_after_name, var_length))
		&& rt.is_true(rt.less(var_name_at, var_length))
		&& rt.is_true(rt.call_function('ctype_alnum', [var_text.array_get(var_after_name)]))
		|| rt.is_true(rt.identical(rt.new_string('='), var_text.array_get(var_after_name))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ambiguous_follower)))) {
		var_match_byte_length_mutated = rt.sub(var_after_name, rt.new_int(at_mutated))
		return var_replacement.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('attribute'), var_context)) {
		return rt.new_null()
	}
	var_match_byte_length_mutated = rt.sub(var_after_name, rt.new_int(at_mutated))
	return var_replacement.clone()
}

fn Class_WP_HTML_Decoder.code_point_to_utf8_bytes(var_code_point rt.PhpVal) string {
	mut var_code_point_mutated := var_code_point
	if (rt.is_true(rt.less_equal(var_code_point_mutated, rt.new_int(0)))
		|| (rt.is_true(rt.greater_equal(var_code_point_mutated, rt.new_int(55296)))
		&& rt.is_true(rt.less_equal(var_code_point_mutated, rt.new_int(57343)))))
		|| rt.is_true(rt.greater(var_code_point_mutated, rt.new_int(1114111))) {
		return '�'
	}
	if rt.is_true(rt.less_equal(var_code_point_mutated, rt.new_int(127))) {
		return (rt.call_function('chr', [var_code_point_mutated.clone()])).str()
	}
	if rt.is_true(rt.less_equal(var_code_point_mutated, rt.new_int(2047))) {
		mut var_byte1 := rt.call_function('chr', [
			rt.shift_right(var_code_point_mutated, rt.new_int(6)) | 192,
		])
		mut var_byte2 := rt.call_function('chr', [
			rt.bitwise_and(var_code_point_mutated, rt.new_int(63)) | 128,
		])
		return '${var_byte1.to_string()}${var_byte2.to_string()}'
	}
	if rt.is_true(rt.less_equal(var_code_point_mutated, rt.new_int(65535))) {
		var_byte1 = rt.call_function('chr', [
			rt.shift_right(var_code_point_mutated, rt.new_int(12)) | 224,
		])
		var_byte2 = rt.call_function('chr', [
			rt.shift_right(var_code_point_mutated, rt.new_int(6)) & 63 | 128,
		])
		mut var_byte3 := rt.call_function('chr', [
			rt.bitwise_and(var_code_point_mutated, rt.new_int(63)) | 128,
		])
		return '${var_byte1.to_string()}${var_byte2.to_string()}${var_byte3.to_string()}'
	}
	var_byte1 = rt.call_function('chr', [
		rt.shift_right(var_code_point_mutated, rt.new_int(18)) | 240,
	])
	var_byte2 = rt.call_function('chr', [
		rt.shift_right(var_code_point_mutated, rt.new_int(12)) & 63 | 128,
	])
	var_byte3 = rt.call_function('chr', [
		rt.shift_right(var_code_point_mutated, rt.new_int(6)) & 63 | 128,
	])
	mut var_byte4 := rt.call_function('chr', [
		rt.bitwise_and(var_code_point_mutated, rt.new_int(63)) | 128,
	])
	return '${var_byte1.to_string()}${var_byte2.to_string()}${var_byte3.to_string()}${var_byte4.to_string()}'
}

fn create_wp_html_decoder(_args ...rt.PhpVal) &Class_WP_HTML_Decoder {
	mut obj := &Class_WP_HTML_Decoder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_HTML_Decoder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'attribute_starts_with' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WP_HTML_Decoder.attribute_starts_with(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
		}
		'decode_text_node' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_HTML_Decoder.decode_text_node(dispatch_arg_0))
		}
		'decode_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_HTML_Decoder.decode_attribute(dispatch_arg_0))
		}
		'decode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_WP_HTML_Decoder.decode(dispatch_arg_0, dispatch_arg_1))
		}
		'read_character_reference' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_WP_HTML_Decoder.read_character_reference(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
		}
		'code_point_to_utf8_bytes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_HTML_Decoder.code_point_to_utf8_bytes(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_HTML_Decoder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Decoder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
