import rt

fn wc_string_to_bool(var_string rt.PhpVal) rt.PhpVal {
	var_string = if !(var_string).is_null() { var_string } else { rt.new_string('') }
	return if rt.is_true(rt.new_bool(var_string.dup().is_bool())) { var_string } else { rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('yes'), rt.new_string(var_string.dup().to_string().to_lower()))) || rt.is_true(rt.identical(rt.new_int(1), var_string)))) || rt.is_true(rt.identical(rt.new_string('true'), rt.new_string(var_string.dup().to_string().to_lower()))))) || rt.is_true(rt.identical(rt.new_string('1'), var_string))) }
}

fn wc_bool_to_string(var_bool rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_bool.dup().is_bool()))))) {
		var_bool = wc_string_to_bool(var_bool.dup())
	}
	return if rt.is_true(rt.identical(rt.new_bool(true), var_bool)) { 'yes' } else { 'no' }
}

fn wc_string_to_array(var_string rt.PhpVal, delimiter string) rt.PhpVal {
	var_string = if !(var_string).is_null() { var_string } else { rt.new_string('') }
	return if rt.is_true(rt.new_bool(var_string.dup().is_array())) { var_string } else { rt.call_function('array_filter', [rt.call_function('explode', [rt.new_string(delimiter), var_string.dup()])]) }
}

fn wc_sanitize_taxonomy_name(var_taxonomy rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('sanitize_taxonomy_name'), rt.call_function('urldecode', [rt.call_function('sanitize_title', [rt.call_function('urldecode', [if !(var_taxonomy).is_null() { var_taxonomy } else { rt.new_string('') }])])]), var_taxonomy.dup()])
}

fn wc_sanitize_permalink(var_value rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	var_value = rt.call_method(var_wpdb, 'strip_invalid_text_for_column', [rt.get_property(var_wpdb, 'options'), rt.new_string('option_value'), if !(var_value).is_null() { var_value } else { rt.new_string('') }])
	if rt.is_true(rt.call_function('is_wp_error', [var_value.dup()])) {
		var_value = rt.new_string(rt.new_string(''))
	}
	var_value = rt.call_function('esc_url_raw', [rt.new_string(var_value.dup().to_string().trim_space())])
	var_value = rt.call_function('str_replace', [rt.new_string('http://'), rt.new_string(''), var_value.dup()])
	return rt.call_function('untrailingslashit', [var_value.dup()])
}

fn wc_get_filename_from_url(var_file_url rt.PhpVal) rt.PhpVal {
	mut var_parts := rt.call_function('wp_parse_url', [var_file_url.dup()])
	if var_parts.array_isset(rt.new_string('path')) {
		return rt.call_function('basename', [var_parts.array_get('path')])
	}
	return rt.new_null()
}

fn wc_get_dimension(var_dimension rt.PhpVal, var_to_unit rt.PhpVal, from_unit string) rt.PhpVal {
	var_to_unit = var_to_unit.to_lower()
	if from_unit == '' {
		from_unit = rt.call_function('get_option', [rt.new_string('woocommerce_dimension_unit')]).to_string().to_lower()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut switch_val_1 := rt.new_string(from_unit)
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('in'))) {
			// unsupported expression: Expr_AssignOp_Mul
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('m'))) {
			// unsupported expression: Expr_AssignOp_Mul
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('mm'))) {
			// unsupported expression: Expr_AssignOp_Mul
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('yd'))) {
			// unsupported expression: Expr_AssignOp_Mul
		}
		mut switch_val_2 := rt.new_string(var_to_unit)
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('in'))) {
			// unsupported expression: Expr_AssignOp_Mul
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('m'))) {
			// unsupported expression: Expr_AssignOp_Mul
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mm'))) {
			// unsupported expression: Expr_AssignOp_Mul
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('yd'))) {
			// unsupported expression: Expr_AssignOp_Mul
		}
	}
	return if rt.is_true(rt.less(var_dimension, rt.new_int(0))) { rt.new_int(0) } else { var_dimension }
}

fn wc_get_weight(var_weight rt.PhpVal, var_to_unit rt.PhpVal, from_unit string) rt.PhpVal {
	var_weight = // unsupported expression: Expr_Cast_Double
	var_to_unit = var_to_unit.to_lower()
	if from_unit == '' {
		from_unit = rt.call_function('get_option', [rt.new_string('woocommerce_weight_unit')]).to_string().to_lower()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut switch_val_3 := rt.new_string(from_unit)
		if rt.is_true(rt.equal(switch_val_3, rt.new_string('g'))) {
			// unsupported expression: Expr_AssignOp_Mul
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('lbs'))) {
			// unsupported expression: Expr_AssignOp_Mul
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('oz'))) {
			// unsupported expression: Expr_AssignOp_Mul
		}
		mut switch_val_4 := rt.new_string(var_to_unit)
		if rt.is_true(rt.equal(switch_val_4, rt.new_string('g'))) {
			// unsupported expression: Expr_AssignOp_Mul
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('lbs'))) {
			// unsupported expression: Expr_AssignOp_Mul
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('oz'))) {
			// unsupported expression: Expr_AssignOp_Mul
		}
	}
	return if rt.is_true(rt.less(var_weight, rt.new_int(0))) { rt.new_int(0) } else { var_weight }
}

fn wc_trim_zeros(var_price rt.PhpVal) rt.PhpVal {
	return rt.call_function('preg_replace', ['/' + (rt.call_function('preg_quote', [wc_get_price_decimal_separator(), rt.new_string('/')])).str() + '0++$/', rt.new_string(''), if !(var_price).is_null() { var_price } else { rt.new_string('') }])
}

fn wc_round_tax_total(var_value rt.PhpVal, var_precision rt.PhpVal) rt.PhpVal {
	var_precision = if rt.is_true(rt.new_bool(var_precision.dup().is_null())) { wc_get_price_decimals() } else { rt.new_int(var_precision.dup().to_i64()) }
	mut var_rounded_tax := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.round(arg_0, arg_1, arg_2) }(var_value.dup(), var_precision.dup(), rt.call_function('wc_get_tax_rounding_mode', []rt.PhpVal{}))
	return rt.call_function('apply_filters', [rt.new_string('wc_round_tax_total'), var_rounded_tax.dup(), var_value.dup(), var_precision.dup(), rt.get_constant('WC_TAX_ROUNDING_MODE')])
}

fn wc_legacy_round_half_down(var_value rt.PhpVal, var_precision rt.PhpVal) rt.PhpVal {
	var_value = if !(wc_float_to_string(var_value.dup())).is_null() { wc_float_to_string(var_value.dup()) } else { rt.new_string('') }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_value = rt.call_function('explode', [rt.new_string('.'), var_value.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.greater(rt.new_int(var_value.array_get(1).to_string().len), var_precision)) && rt.is_true(rt.identical(rt.call_function('substr', [var_value.array_get(1), // unsupported expression: Expr_UnaryMinus]), rt.new_string('5'))))) {
			var_value.array_set(1, (rt.call_function('substr', [var_value.array_get(1), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])).str() + '4')
		}
		var_value = rt.call_function('implode', [rt.new_string('.'), var_value.dup()])
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.round(arg_0, arg_1) }(rt.new_float(var_value.dup().to_f64()), var_precision.dup())
}

fn wc_format_refund_total(var_amount rt.PhpVal) rt.PhpVal {
	return rt.mul(var_amount, // unsupported expression: Expr_UnaryMinus)
}

fn wc_format_decimal(var_number rt.PhpVal, dp bool, trim_zeros bool) string {
	var_number = if !(var_number).is_null() { var_number } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_string(''), var_number)) {
		return ''
	}
	mut var_locale := rt.call_function('localeconv', []rt.PhpVal{})
	mut var_decimals := [wc_get_price_decimal_separator(), var_locale.array_get('decimal_point'), var_locale.array_get('mon_decimal_point')]
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_number.dup().is_double()))))) {
		var_number = rt.call_function('str_replace', [var_decimals.dup(), rt.new_string('.'), var_number.dup()])
		var_number = rt.call_function('preg_replace', [rt.new_string('/\\.(?![^.]+$)|[^0-9.-]/'), rt.new_string(''), wc_clean(var_number.dup())])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		dp = if rt.is_true(rt.identical(rt.new_string(''), rt.new_bool(dp))) { wc_get_price_decimals() } else { rt.new_bool(dp) }.to_i64()
		var_number = rt.call_function('number_format', [rt.new_float(var_number.dup().to_f64()), rt.new_bool(dp), rt.new_string('.'), rt.new_string('')])
	} else if rt.is_true(rt.new_bool(var_number.dup().is_double())) {
		var_number = rt.call_function('str_replace', [var_decimals.dup(), rt.new_string('.'), rt.call_function('sprintf', ['%.' + (rt.call_function('wc_get_rounding_precision', []rt.PhpVal{})).str() + 'f', var_number.dup()])])
		trim_zeros = true
	}
	if rt.is_true(rt.new_bool(var_trim_zeros && rt.is_true(rt.call_function('strstr', [var_number.dup(), rt.new_string('.')])))) {
		var_number = rt.new_string(rt.new_string(var_number.dup().to_string().trim_right(' \t\n\r').trim_right(' \t\n\r')))
	}
	return (var_number).str()
}

fn wc_float_to_string(var_float rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_float.dup().is_double()))))) {
		return var_float.dup()
	}
	mut var_locale := rt.call_function('localeconv', []rt.PhpVal{})
	mut var_string := rt.new_string(rt.new_string(var_float.dup().to_string()))
	var_string = rt.call_function('str_replace', [var_locale.array_get('decimal_point'), rt.new_string('.'), var_string.dup()])
	return var_string.dup()
}

fn wc_format_localized_price(var_value rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_format_localized_price'), rt.call_function('str_replace', [rt.new_string('.'), wc_get_price_decimal_separator(), rt.new_string(var_value.dup().to_string())]), var_value.dup()])
}

fn wc_format_localized_decimal(var_value rt.PhpVal) rt.PhpVal {
	mut var_locale := rt.call_function('localeconv', []rt.PhpVal{})
	mut var_decimal_point := if var_locale.array_isset(rt.new_string('decimal_point')) { var_locale.array_get('decimal_point') } else { rt.new_string('.') }
	mut var_decimal := if !(!rt.is_true(wc_get_price_decimal_separator())) { wc_get_price_decimal_separator() } else { var_decimal_point }
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_format_localized_decimal'), rt.call_function('str_replace', [rt.new_string('.'), var_decimal.dup(), rt.new_string(var_value.dup().to_string())]), var_value.dup()])
}

fn wc_format_coupon_code(var_value rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_code'), var_value.dup()])
}

fn wc_sanitize_coupon_code(var_value rt.PhpVal) rt.PhpVal {
	var_value = rt.call_function('wp_kses', [rt.call_function('sanitize_post_field', [rt.new_string('post_title'), rt.call_function('html_entity_decode', [if !().is_null() {  } else {  }, rt.get_constant('ENT_COMPAT'), rt.call_function('get_bloginfo', [])]), rt.new_int(0), rt.new_string('db')]), rt.new_string('entities')])
	return if rt.is_true(rt.call_function('current_user_can', [rt.new_string('unfiltered_html')])) { var_value } else { rt.call_function('stripslashes', [var_value.dup()]) }
}

fn wc_clean(var_var rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_var.dup().is_array())) {
		return rt.call_function('array_map', [, .dup()])
	} else {
		return 
	}
	return rt.new_null()
}

fn wc_check_invalid_utf8(var_var rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_numberutil() &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_wc_formatting_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
