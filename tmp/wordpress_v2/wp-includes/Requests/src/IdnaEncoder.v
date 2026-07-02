import rt

pub fn Class_WpOrg_Requests_IdnaEncoder.ace_prefix() string {
	return 'xn--'
}
pub fn Class_WpOrg_Requests_IdnaEncoder.max_length() i64 {
	return 64
}
pub fn Class_WpOrg_Requests_IdnaEncoder.bootstrap_base() i64 {
	return 36
}
pub fn Class_WpOrg_Requests_IdnaEncoder.bootstrap_tmin() i64 {
	return 1
}
pub fn Class_WpOrg_Requests_IdnaEncoder.bootstrap_tmax() i64 {
	return 26
}
pub fn Class_WpOrg_Requests_IdnaEncoder.bootstrap_skew() i64 {
	return 38
}
pub fn Class_WpOrg_Requests_IdnaEncoder.bootstrap_damp() i64 {
	return 700
}
pub fn Class_WpOrg_Requests_IdnaEncoder.bootstrap_initial_bias() i64 {
	return 72
}
pub fn Class_WpOrg_Requests_IdnaEncoder.bootstrap_initial_n() i64 {
	return 128
}
struct Class_WpOrg_Requests_IdnaEncoder {
	rt.PhpObjectBase
}

fn Class_WpOrg_Requests_IdnaEncoder.encode(var_hostname rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_WpOrg_Requests_Utility_InputValidator{}
	mut iife_result_0 := iife_temp_0.is_string_or_stringable(var_hostname.clone())
	if rt.is_true(rt.identical(iife_result_0, rt.new_bool(false))) {
		mut iife_temp_1 := Class_WpOrg_Requests_Exception_InvalidArgument{}
		mut iife_result_1 := iife_temp_1.create(rt.new_int(1), rt.new_string('$hostname'), rt.new_string('string|Stringable'), rt.call_function('gettype', [var_hostname.clone()]))
		rt.throw_exception(iife_result_1)
	}
	mut var_parts := rt.call_function('explode', [rt.new_string('.'), var_hostname.clone()])
	mut iter_1 := var_parts.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_part := item_1.val
	var_part = Class_WpOrg_Requests_IdnaEncoder.to_ascii(var_part.clone())
	}
	return rt.call_function('implode', [rt.new_string('.'), var_parts.clone()])
}

fn Class_WpOrg_Requests_IdnaEncoder.to_ascii(var_text rt.PhpVal) rt.PhpVal {
	mut var_text_mutated := var_text
	if rt.is_true(Class_WpOrg_Requests_IdnaEncoder.is_ascii(var_text_mutated.clone())) {
		if rt.is_true(rt.less(rt.new_int(var_text_mutated.clone().to_string().len), Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.max_length())) {
			return var_text_mutated.clone()
		}
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Provided string is too long'), rt.new_string('idna.provided_too_long'), var_text_mutated.clone())))
	}
	var_text_mutated = Class_WpOrg_Requests_IdnaEncoder.nameprep(var_text_mutated.clone())
	if rt.is_true(Class_WpOrg_Requests_IdnaEncoder.is_ascii(var_text_mutated.clone())) {
		if rt.is_true(rt.less(rt.new_int(var_text_mutated.clone().to_string().len), Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.max_length())) {
			return var_text_mutated.clone()
		}
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Prepared string is too long'), rt.new_string('idna.prepared_too_long'), var_text_mutated.clone())))
	}
	if rt.is_true(rt.identical(rt.call_function('strpos', [var_text_mutated.clone(), Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.ace_prefix()]), rt.new_int(0))) {
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Provided string begins with ACE prefix'), rt.new_string('idna.provided_is_prefixed'), var_text_mutated.clone())))
	}
	var_text_mutated = Class_WpOrg_Requests_IdnaEncoder.punycode_encode(var_text_mutated.clone())
	var_text_mutated = rt.new_string((Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.ace_prefix()).str() + (var_text_mutated).str())
	if rt.is_true(rt.less(rt.new_int(var_text_mutated.clone().to_string().len), Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.max_length())) {
		return var_text_mutated.clone()
	}
	rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Encoded string is too long'), rt.new_string('idna.encoded_too_long'), var_text_mutated.clone())))
	return rt.new_null()
}

fn Class_WpOrg_Requests_IdnaEncoder.is_ascii(var_text rt.PhpVal) bool {
	mut var_text_mutated := var_text
	return rt.new_bool(!rt.is_true(rt.identical(rt.call_function('preg_match', [rt.new_string('/(?:[^\\x00-\\x7F])/'), var_text_mutated.clone()]), rt.new_int(1))))
}

fn Class_WpOrg_Requests_IdnaEncoder.nameprep(var_text rt.PhpVal) rt.PhpVal {
	mut var_text_mutated := var_text
	return var_text_mutated.clone()
}

fn Class_WpOrg_Requests_IdnaEncoder.utf8_to_codepoints(var_input rt.PhpVal) rt.PhpVal {
	mut var_codepoints := rt.new_array()
	mut var_strlen := rt.new_int(var_input.clone().to_string().len)
	mut var_position := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_position, var_strlen))) { break }
		mut var_value := rt.call_function('ord', [var_input.array_get(var_position)])
		if rt.bitwise_not(var_value) & 128 == 128 {
		mut var_character := var_value.clone()
		mut var_length := rt.new_int(1)
		mut var_remaining := rt.new_int(0)
		} else if rt.bitwise_and(var_value, rt.new_int(224)) == 192 {
		var_character = rt.new_int(rt.bitwise_and(var_value, rt.new_int(31)) << 6)
		var_length = rt.new_int(2)
		var_remaining = rt.new_int(1)
		} else if rt.bitwise_and(var_value, rt.new_int(240)) == 224 {
		var_character = rt.new_int(rt.bitwise_and(var_value, rt.new_int(15)) << 12)
		var_length = rt.new_int(3)
		var_remaining = rt.new_int(2)
		} else if rt.bitwise_and(var_value, rt.new_int(248)) == 240 {
		var_character = rt.new_int(rt.bitwise_and(var_value, rt.new_int(7)) << 18)
		var_length = rt.new_int(4)
		var_remaining = rt.new_int(3)
		} else {
			rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Invalid Unicode codepoint'), rt.new_string('idna.invalidcodepoint'), var_value.clone())))
		}
		if rt.is_true(rt.greater(var_remaining, rt.new_int(0))) {
			if rt.is_true(rt.greater(rt.add(var_position, var_length), var_strlen)) {
				rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Invalid Unicode codepoint'), rt.new_string('idna.invalidcodepoint'), var_character.clone())))
			}
			rt.post_inc(var_position)
			for {
				if !(rt.is_true(rt.greater(var_remaining, rt.new_int(0)))) { break }
				var_value = rt.call_function('ord', [var_input.array_get(var_position)])
				if rt.is_true(rt.new_bool(rt.bitwise_and(var_value, rt.new_int(192)) != 128)) {
					rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Invalid Unicode codepoint'), rt.new_string('idna.invalidcodepoint'), var_character.clone())))
				}
				rt.pre_dec(var_remaining)
				rt.new_null()
				rt.post_inc(var_position)
			}
			rt.post_dec(var_position)
		}
		if (((((rt.is_true(rt.greater(var_length, rt.new_int(1))) && rt.is_true(rt.less_equal(var_character, rt.new_int(127)))) || (rt.is_true(rt.greater(var_length, rt.new_int(2))) && rt.is_true(rt.less_equal(var_character, rt.new_int(2047))))) || (rt.is_true(rt.greater(var_length, rt.new_int(3))) && rt.is_true(rt.less_equal(var_character, rt.new_int(65535))))) || rt.bitwise_and(var_character, rt.new_int(65534)) == 65534) || (rt.is_true(rt.greater_equal(var_character, rt.new_int(64976))) && rt.is_true(rt.less_equal(var_character, rt.new_int(65007))))) || ((((rt.is_true(rt.greater(var_character, rt.new_int(55295))) && rt.is_true(rt.less(var_character, rt.new_int(63744)))) || rt.is_true(rt.less(var_character, rt.new_int(32)))) || (rt.is_true(rt.greater(var_character, rt.new_int(126))) && rt.is_true(rt.less(var_character, rt.new_int(160))))) || rt.is_true(rt.greater(var_character, rt.new_int(983037)))) {
			rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Invalid Unicode codepoint'), rt.new_string('idna.invalidcodepoint'), var_character.clone())))
		}
		var_codepoints.array_push(var_character.clone())
		rt.post_inc(var_position)
	}
	return var_codepoints.clone()
}

fn Class_WpOrg_Requests_IdnaEncoder.punycode_encode(var_input rt.PhpVal) rt.PhpVal {
	mut var_output := rt.new_string('')
	mut var_n := Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_initial_n()
	mut var_delta := rt.new_int(0)
	mut var_bias := Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_initial_bias()
	mut var_h := rt.new_int(0)
	mut var_b := rt.new_int(0)
	mut var_codepoints := Class_WpOrg_Requests_IdnaEncoder.utf8_to_codepoints(var_input.clone())
	mut var_extended := rt.new_array()
	mut iter_2 := var_codepoints.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_char := item_2.val
		if rt.is_true(rt.less(var_char, rt.new_int(128))) {
			var_output = rt.concat(var_output, rt.call_function('chr', [var_char.clone()]))
			rt.post_inc(var_h)
		} else if rt.is_true(rt.less(var_char, var_n)) {
			rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.new_string('Invalid character'), rt.new_string('idna.character_outside_domain'), var_char.clone())))
		} else {
			var_extended.array_set(var_char, true)
		}
	}
	var_extended = rt.func_array_keys(var_extended.clone())
	rt.call_function('sort', [var_extended.clone()])
	var_b = var_h.clone()
	if var_output.clone().to_string().len > 0 {
		var_output = rt.concat(var_output, rt.new_string('-'))
	}
	mut var_codepointcount := rt.new_int(var_codepoints.clone().array_count())
	for rt.is_true(rt.less(var_h, var_codepointcount)) {
		mut var_m := rt.call_function('array_shift', [var_extended.clone()])
		var_delta = rt.add(var_delta, rt.mul(rt.sub(var_m, var_n), rt.add(var_h, rt.new_int(1))))
		var_n = var_m.clone()
		mut var_num := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_num, var_codepointcount))) { break }
			mut var_c := var_codepoints.array_get(var_num)
			if rt.is_true(rt.less(var_c, var_n)) {
				rt.post_inc(var_delta)
			} else if rt.is_true(rt.identical(var_c, var_n)) {
				mut var_q := var_delta.clone()
				mut var_k := Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_base()
				for {
					if rt.is_true(rt.less_equal(var_k, rt.add(var_bias, Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_tmin()))) {
					mut var_t := Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_tmin()
					} else if rt.is_true(rt.greater_equal(var_k, rt.add(var_bias, Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_tmax()))) {
					var_t = Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_tmax()
					} else {
					var_t = rt.sub(var_k, var_bias)
					}
					if rt.is_true(rt.less(var_q, var_t)) {
						break
					}
					mut var_digit := rt.new_int((rt.add(var_t, rt.mod_(rt.sub(var_q, var_t), rt.sub(Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_base(), var_t)))).to_i64())
					var_output = rt.concat(var_output, Class_WpOrg_Requests_IdnaEncoder.digit_to_char(var_digit.clone()))
					var_q = rt.new_int((rt.call_function('floor', [rt.div(rt.sub(var_q, var_t), rt.sub(Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_base(), var_t))])).to_i64())
					var_k = rt.add(var_k, Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_base())
				}
				var_output = rt.concat(var_output, Class_WpOrg_Requests_IdnaEncoder.digit_to_char(var_q.clone()))
				mut var_bias := Class_WpOrg_Requests_IdnaEncoder.adapt(var_delta.clone(), rt.add(var_h, rt.new_int(1)), rt.identical(var_h, var_b))
				mut var_delta := rt.new_int(0)
				rt.post_inc(var_h)
			}
			rt.post_inc(var_num)
		}
		rt.post_inc(var_delta)
		rt.post_inc(var_n)
	}
	return var_output.clone()
}

fn Class_WpOrg_Requests_IdnaEncoder.digit_to_char(var_digit rt.PhpVal) rt.PhpVal {
	mut var_digit_mutated := var_digit
	if rt.is_true(rt.less(var_digit_mutated, rt.new_int(0))) || rt.is_true(rt.greater(var_digit_mutated, rt.new_int(35))) {
		rt.throw_exception(rt.new_object('WpOrg_Requests_Exception', []string{}, create_wporg_requests_exception(rt.call_function('sprintf', [rt.new_string('Invalid digit %d'), var_digit_mutated.clone()]), rt.new_string('idna.invalid_digit'), var_digit_mutated.clone())))
	}
	mut var_digits := rt.new_string('abcdefghijklmnopqrstuvwxyz0123456789')
	return rt.call_function('substr', [var_digits.clone(), var_digit_mutated.clone(), rt.new_int(1)])
}

fn Class_WpOrg_Requests_IdnaEncoder.adapt(var_delta rt.PhpVal, var_numpoints rt.PhpVal, var_firsttime rt.PhpVal) rt.PhpVal {
	mut var_delta_mutated := var_delta
	if rt.is_true(var_firsttime) {
	var_delta_mutated = rt.call_function('floor', [rt.div(var_delta_mutated, Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_damp())])
	} else {
	var_delta_mutated = rt.call_function('floor', [rt.div(var_delta_mutated, rt.new_int(2))])
	}
	var_delta_mutated = rt.add(var_delta_mutated, rt.call_function('floor', [rt.div(var_delta_mutated, var_numpoints)]))
	mut var_k := rt.new_int(0)
	mut var_max := rt.call_function('floor', [rt.div(rt.mul(rt.sub(Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_base(), Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_tmin()), Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_tmax()), rt.new_int(2))])
	for rt.is_true(rt.greater(var_delta_mutated, var_max)) {
		var_delta_mutated = rt.call_function('floor', [rt.div(var_delta_mutated, rt.sub(Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_base(), Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_tmin()))])
		var_k = rt.add(var_k, Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_base())
	}
	return rt.add(var_k, rt.call_function('floor', [rt.div(rt.mul(rt.add(rt.sub(Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_base(), Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_tmin()), rt.new_int(1)), var_delta_mutated), rt.add(var_delta_mutated, Class_WpOrg_Requests_WpOrg_Requests_IdnaEncoder.bootstrap_skew()))]))
}

struct Class_WpOrg_Requests_Utility_InputValidator {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception_InvalidArgument {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Exception {
	rt.PhpObjectBase
}

fn create_wporg_requests_idnaencoder(_args ...rt.PhpVal) &Class_WpOrg_Requests_IdnaEncoder {
	mut obj := &Class_WpOrg_Requests_IdnaEncoder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_utility_inputvalidator(_args ...rt.PhpVal) &Class_WpOrg_Requests_Utility_InputValidator {
	mut obj := &Class_WpOrg_Requests_Utility_InputValidator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception_invalidargument(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception_InvalidArgument {
	mut obj := &Class_WpOrg_Requests_Exception_InvalidArgument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_exception(_args ...rt.PhpVal) &Class_WpOrg_Requests_Exception {
	mut obj := &Class_WpOrg_Requests_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WpOrg_Requests_IdnaEncoder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'encode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WpOrg_Requests_IdnaEncoder.encode(dispatch_arg_0)
		}
		'to_ascii' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WpOrg_Requests_IdnaEncoder.to_ascii(dispatch_arg_0)
		}
		'is_ascii' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WpOrg_Requests_IdnaEncoder.is_ascii(dispatch_arg_0))
		}
		'nameprep' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WpOrg_Requests_IdnaEncoder.nameprep(dispatch_arg_0)
		}
		'utf8_to_codepoints' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WpOrg_Requests_IdnaEncoder.utf8_to_codepoints(dispatch_arg_0)
		}
		'punycode_encode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WpOrg_Requests_IdnaEncoder.punycode_encode(dispatch_arg_0)
		}
		'digit_to_char' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WpOrg_Requests_IdnaEncoder.digit_to_char(dispatch_arg_0)
		}
		'adapt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WpOrg_Requests_IdnaEncoder.adapt(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_WpOrg_Requests_IdnaEncoder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_IdnaEncoder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Utility_InputValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Utility_InputValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception_InvalidArgument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WpOrg_Requests_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
