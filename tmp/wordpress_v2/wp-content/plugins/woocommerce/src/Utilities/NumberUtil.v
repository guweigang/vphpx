import rt

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Utilities_NumberUtil.normalize(var_value rt.PhpVal, fallback i64) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_value_mutated.clone().is_string())) {
	var_value_mutated = rt.new_string(var_value_mutated.clone().to_string().trim_space())
	}
	if rt.is_true(rt.new_bool(var_value_mutated.clone().is_long() || var_value_mutated.clone().is_double())) {
		mut var_numeric_value := if var_value_mutated.clone().is_string() { rt.new_float(var_value_mutated.clone().to_f64()) } else { var_value_mutated }
		return if var_numeric_value.clone().is_long() { var_numeric_value } else { rt.call_function('round', [var_numeric_value.clone(), rt.get_constant('WC_ROUNDING_PRECISION')]) }
	}
	return rt.new_int(fallback)
}

fn Class_Automattic_WooCommerce_Utilities_NumberUtil.round(var_val rt.PhpVal, precision i64, mode i64) f64 {
	return (rt.call_function('round', [Class_Automattic_WooCommerce_Utilities_NumberUtil.normalize((var_val).to_i64()), rt.new_int(precision), rt.new_int(mode)])).to_f64()
}

fn Class_Automattic_WooCommerce_Utilities_NumberUtil.floor(var_val rt.PhpVal) f64 {
	return (rt.call_function('floor', [Class_Automattic_WooCommerce_Utilities_NumberUtil.normalize((var_val).to_i64())])).to_f64()
}

fn Class_Automattic_WooCommerce_Utilities_NumberUtil.ceil(var_val rt.PhpVal) f64 {
	return (rt.call_function('ceil', [Class_Automattic_WooCommerce_Utilities_NumberUtil.normalize((var_val).to_i64())])).to_f64()
}

fn Class_Automattic_WooCommerce_Utilities_NumberUtil.array_sum(mut var_arr Class_Automattic_WooCommerce_Utilities_array) f64 {
	mut var_sanitized_array := rt.call_function('array_map', [rt.new_string('floatval'), var_arr])
	return (rt.call_function('array_sum', [var_sanitized_array.clone()])).to_f64()
}

fn Class_Automattic_WooCommerce_Utilities_NumberUtil.sanitize_cost_in_current_locale(var_value rt.PhpVal) string {
	mut var_value_mutated := var_value
	var_value_mutated = if var_value_mutated.clone().is_null() { rt.new_string('') } else { var_value_mutated }
	var_value_mutated = rt.call_function('wp_kses_post', [rt.new_string(rt.call_function('wp_unslash', [var_value_mutated.clone()]).to_string().trim_space())])
	mut var_currency_symbol_encoded := rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{})
	mut var_currency_symbol_variations := rt.create_array([rt.ArrayItem{ key: none, val: var_currency_symbol_encoded }, rt.ArrayItem{ key: none, val: rt.call_function('wp_kses_normalize_entities', [var_currency_symbol_encoded.clone()]) }, rt.ArrayItem{ key: none, val: rt.call_function('html_entity_decode', [var_currency_symbol_encoded.clone(), rt.get_constant('ENT_COMPAT')]) }])
	var_value_mutated = rt.call_function('str_replace', [var_currency_symbol_variations.clone(), rt.new_string(''), var_value_mutated.clone()])
	mut var_decimal_point_count := rt.call_function('substr_count', [var_value_mutated.clone(), rt.new_string('.')])
	if rt.is_true(rt.identical(rt.new_int(1), var_decimal_point_count)) && var_value_mutated.clone().is_long() || var_value_mutated.clone().is_double() {
		return (var_value_mutated).str()
	}
	mut var_allowed_characters_regex := rt.call_function('sprintf', [rt.new_string('/^[0-9\\%s\\%s]*$/'), rt.call_function('wc_get_price_thousand_separator', []rt.PhpVal{}), rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [var_allowed_characters_regex.clone(), var_value_mutated.clone()]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Utilities_InvalidArgumentException', []string{}, create_automattic_woocommerce_utilities_invalidargumentexception(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is not a valid numeric value. Allowed characters are numbers, the thousand (%2$s), and decimal (%3$s) separators.'), rt.new_string('woocommerce')]), var_value_mutated.clone(), rt.call_function('wc_get_price_thousand_separator', []rt.PhpVal{}), rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{})])]))))
	}
	mut var_decimal_separator := rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{})
	mut var_thousand_separator := rt.call_function('wc_get_price_thousand_separator', []rt.PhpVal{})
	if rt.is_true(rt.greater(rt.call_function('substr_count', [var_value_mutated.clone(), var_decimal_separator.clone()]), rt.new_int(1))) || (rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_value_mutated.clone(), var_thousand_separator.clone()]))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_value_mutated.clone(), var_decimal_separator.clone()]))))) && rt.is_true(rt.less_equal(rt.call_function('strpos', [var_value_mutated.clone(), var_decimal_separator.clone()]), rt.call_function('strpos', [var_value_mutated.clone(), var_thousand_separator.clone()])))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Utilities_InvalidArgumentException', []string{}, create_automattic_woocommerce_utilities_invalidargumentexception(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s is not a valid numeric value: there should be one decimal separator and it has to be after the thousands separator.'), rt.new_string('woocommerce')]), var_value_mutated.clone()])]))))
	}
	var_value_mutated = rt.call_function('str_replace', [rt.call_function('wc_get_price_thousand_separator', []rt.PhpVal{}), rt.new_string(''), var_value_mutated.clone()])
	var_value_mutated = rt.call_function('str_replace', [rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{}), rt.new_string('.'), var_value_mutated.clone()])
	if rt.is_true(var_value_mutated) && !(var_value_mutated.clone().is_long() || var_value_mutated.clone().is_double()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Utilities_InvalidArgumentException', []string{}, create_automattic_woocommerce_utilities_invalidargumentexception(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s is not a valid numeric value.'), rt.new_string('woocommerce')]), var_value_mutated.clone()])]))))
	}
	return (var_value_mutated).str()
}

struct Class_Automattic_WooCommerce_Utilities_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Utilities_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'normalize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Utilities_NumberUtil.normalize(dispatch_arg_0, dispatch_arg_1)
		}
		'round' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_float(Class_Automattic_WooCommerce_Utilities_NumberUtil.round(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'floor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_float(Class_Automattic_WooCommerce_Utilities_NumberUtil.floor(dispatch_arg_0))
		}
		'ceil' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_float(Class_Automattic_WooCommerce_Utilities_NumberUtil.ceil(dispatch_arg_0))
		}
		'array_sum' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_float(Class_Automattic_WooCommerce_Utilities_NumberUtil.array_sum(mut dispatch_arg_0))
		}
		'sanitize_cost_in_current_locale' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_NumberUtil.sanitize_cost_in_current_locale(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
