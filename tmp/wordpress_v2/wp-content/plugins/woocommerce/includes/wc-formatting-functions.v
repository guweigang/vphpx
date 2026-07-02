import rt

fn wc_string_to_bool(var_string_arg rt.PhpVal) rt.PhpVal {
	mut var_string := var_string_arg
	var_string = if !var_string.is_null() { var_string } else { rt.new_string('') }
	return if var_string.clone().is_bool() {
		var_string
	} else {
		rt.new_bool(
			rt.is_true(rt.identical(rt.new_string('yes'), rt.new_string(var_string.clone().to_string().to_lower())))
			|| rt.is_true(rt.identical(rt.new_int(1), var_string))
			|| rt.is_true(rt.identical(rt.new_string('true'), rt.new_string(var_string.clone().to_string().to_lower())))
			|| rt.is_true(rt.identical(rt.new_string('1'), var_string)))
	}
}

fn wc_bool_to_string(var_bool_arg rt.PhpVal) string {
	mut var_bool := var_bool_arg
	if !(var_bool.clone().is_bool()) {
		var_bool = wc_string_to_bool(var_bool.clone())
	}
	return if rt.is_true(rt.identical(rt.new_bool(true), var_bool)) { 'yes' } else { 'no' }
}

fn wc_string_to_array(var_string_arg rt.PhpVal, delimiter string) rt.PhpVal {
	mut var_delimiter := delimiter
	mut var_string := var_string_arg
	var_string = if !var_string.is_null() { var_string } else { rt.new_string('') }
	return if var_string.clone().is_array() { var_string } else { rt.call_function('array_filter', [
			rt.call_function('explode', [rt.new_string(delimiter),
				var_string.clone()]),
		]) }
}

fn wc_sanitize_taxonomy_name(var_taxonomy rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('sanitize_taxonomy_name'),
		rt.call_function('urldecode', [
			rt.call_function('sanitize_title', [
				rt.call_function('urldecode', [if !var_taxonomy.is_null() {
					var_taxonomy
				} else {
					rt.new_string('')
				}]),
			]),
		]),
		var_taxonomy.clone()])
}

fn wc_sanitize_permalink(var_value_arg rt.PhpVal) rt.PhpVal {
	mut var_value := var_value_arg
	mut var_wpdb := rt.new_null()
	var_value = rt.call_method(var_wpdb, 'strip_invalid_text_for_column', [
		rt.get_property(var_wpdb, 'options'),
		rt.new_string('option_value'),
		if !var_value.is_null() { var_value } else { rt.new_string('') },
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_value.clone()])) {
		var_value = rt.new_string('')
	}
	var_value = rt.call_function('esc_url_raw', [
		rt.new_string(var_value.clone().to_string().trim_space()),
	])
	var_value = rt.call_function('str_replace', [rt.new_string('http://'),
		rt.new_string(''), var_value.clone()])
	return rt.call_function('untrailingslashit', [var_value.clone()])
}

fn wc_get_filename_from_url(var_file_url rt.PhpVal) rt.PhpVal {
	mut var_parts := rt.new_null()
	var_parts = rt.call_function('wp_parse_url', [var_file_url.clone()])
	if var_parts.array_isset(rt.new_string('path')) {
		return rt.call_function('basename', [var_parts.array_get(rt.new_string('path'))])
	}
	return rt.new_null()
}

fn wc_get_dimension(var_dimension rt.PhpVal, var_to_unit_arg rt.PhpVal, from_unit string) rt.PhpVal {
	mut var_from_unit := from_unit
	mut var_to_unit := var_to_unit_arg
	var_to_unit = var_to_unit.to_lower()
	if var_from_unit == '' {
		var_from_unit = rt.call_function('get_option', [
			rt.new_string('woocommerce_dimension_unit'),
		]).to_string().to_lower()
	}
	if rt.is_true(rt.new_bool(var_from_unit != var_to_unit)) {
		mut switch_val_1 := rt.new_string(var_from_unit.str())
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('in'))) {
			var_dimension = rt.mul(var_dimension, rt.new_float(2.54))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('m'))) {
			var_dimension = rt.mul(var_dimension, rt.new_int(100))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('mm'))) {
			var_dimension = rt.mul(var_dimension, rt.new_float(0.1))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('yd'))) {
			var_dimension = rt.mul(var_dimension, rt.new_float(91.44))
		}
		mut switch_val_2 := rt.new_string(var_to_unit.str())
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('in'))) {
			var_dimension = rt.mul(var_dimension, rt.new_float(0.3937))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('m'))) {
			var_dimension = rt.mul(var_dimension, rt.new_float(0.01))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('mm'))) {
			var_dimension = rt.mul(var_dimension, rt.new_int(10))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('yd'))) {
			var_dimension = rt.mul(var_dimension, rt.new_float(0.010936133))
		}
	}
	return if rt.is_true(rt.less(var_dimension, rt.new_int(0))) {
		rt.new_int(0)
	} else {
		var_dimension
	}
}

fn wc_get_weight(var_weight_arg rt.PhpVal, var_to_unit_arg rt.PhpVal, from_unit string) rt.PhpVal {
	mut var_from_unit := from_unit
	mut var_weight := var_weight_arg
	mut var_to_unit := var_to_unit_arg
	var_weight = rt.new_float(var_weight.to_f64())
	var_to_unit = var_to_unit.to_lower()
	if var_from_unit == '' {
		var_from_unit = rt.call_function('get_option', [
			rt.new_string('woocommerce_weight_unit'),
		]).to_string().to_lower()
	}
	if rt.is_true(rt.new_bool(var_from_unit != var_to_unit)) {
		mut switch_val_3 := rt.new_string(var_from_unit.str())
		if rt.is_true(rt.equal(switch_val_3, rt.new_string('g'))) {
			var_weight = rt.mul(var_weight, rt.new_float(0.001))
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('lbs'))) {
			var_weight = rt.mul(var_weight, rt.new_float(0.453592))
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('oz'))) {
			var_weight = rt.mul(var_weight, rt.new_float(0.0283495))
		}
		mut switch_val_4 := rt.new_string(var_to_unit.str())
		if rt.is_true(rt.equal(switch_val_4, rt.new_string('g'))) {
			var_weight = rt.mul(var_weight, rt.new_int(1000))
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('lbs'))) {
			var_weight = rt.mul(var_weight, rt.new_float(2.20462))
		} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('oz'))) {
			var_weight = rt.mul(var_weight, rt.new_float(35.274))
		}
	}
	return if rt.is_true(rt.less(var_weight, rt.new_int(0))) { rt.new_int(0) } else { var_weight }
}

fn wc_trim_zeros(var_price rt.PhpVal) rt.PhpVal {
	return rt.call_function('preg_replace', [
		rt.new_string('/' +
			(rt.call_function('preg_quote', [wc_get_price_decimal_separator(), rt.new_string('/')])).str() +
			'0++$/'),
		rt.new_string(''),
		if !var_price.is_null() { var_price } else { rt.new_string('') },
	])
}

fn wc_round_tax_total(var_value rt.PhpVal, var_precision_arg rt.PhpVal) rt.PhpVal {
	mut var_precision := var_precision_arg
	mut var_rounded_tax := rt.new_null()
	var_precision = if var_precision.clone().is_null() {
		wc_get_price_decimals()
	} else {
		rt.new_int(var_precision.clone().to_i64())
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_0 := iife_temp_0.round(var_value.clone(), var_precision.clone(), rt.call_function('wc_get_tax_rounding_mode',
		[]rt.PhpVal{}))
	var_rounded_tax = iife_result_0
	return rt.call_function('apply_filters', [rt.new_string('wc_round_tax_total'),
		var_rounded_tax.clone(), var_value.clone(), var_precision.clone(),
		rt.get_constant('WC_TAX_ROUNDING_MODE')])
}

fn wc_legacy_round_half_down(var_value_arg rt.PhpVal, var_precision rt.PhpVal) rt.PhpVal {
	mut var_value := var_value_arg
	var_value = if !(wc_float_to_string(var_value.clone())).is_null() {
		wc_float_to_string(var_value.clone())
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strstr', [
		var_value.clone(),
		rt.new_string('.'),
	])))))
	{
		var_value = rt.call_function('explode', [rt.new_string('.'),
			var_value.clone()])
		if rt.is_true(rt.greater(rt.new_int(var_value.array_get(rt.new_int(1)).to_string().len), var_precision))
			&& rt.is_true(rt.identical(rt.call_function('substr', [var_value.array_get(rt.new_int(1)), rt.new_int(-1)]), rt.new_string('5'))) {
			var_value.array_set(1,
				(rt.call_function('substr', [var_value.array_get(rt.new_int(1)), rt.new_int(0), rt.new_int(-1)])).str() +
				'4')
		}
		var_value = rt.call_function('implode', [rt.new_string('.'),
			var_value.clone()])
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_1 := iife_temp_1.round(rt.new_float(var_value.clone().to_f64()),
		var_precision.clone())
	return iife_result_1
}

fn wc_format_refund_total(var_amount rt.PhpVal) rt.PhpVal {
	return rt.mul(var_amount, -1)
}

fn wc_format_decimal(var_number_arg rt.PhpVal, dp bool, trim_zeros bool) string {
	mut var_dp := dp
	mut var_trim_zeros := trim_zeros
	mut var_number := var_number_arg
	mut var_locale := rt.new_null()
	mut var_decimals := []rt.PhpVal{}
	var_number = if !var_number.is_null() { var_number } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_string(''), var_number)) {
		return ''
	}
	var_locale = rt.call_function('localeconv', []rt.PhpVal{})
	var_decimals = [wc_get_price_decimal_separator(), var_locale.array_get(rt.new_string('decimal_point')),
		var_locale.array_get(rt.new_string('mon_decimal_point'))]
	if !(var_number.clone().is_double()) {
		var_number = rt.call_function('str_replace', [
			rt.create_array_from_list(var_decimals),
			rt.new_string('.'),
			var_number.clone(),
		])
		var_number = rt.call_function('preg_replace', [
			rt.new_string('/\\.(?![^.]+$)|[^0-9.-]/'),
			rt.new_string(''),
			wc_clean(var_number.clone()),
		])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_dp))))) {
		var_dp = if rt.is_true(rt.identical(rt.new_string(''), rt.new_bool(var_dp))) {
			wc_get_price_decimals()
		} else {
			rt.new_bool(var_dp)
		}.to_i64()
		var_number = rt.call_function('number_format', [
			rt.new_float(var_number.clone().to_f64()),
			rt.new_bool(var_dp),
			rt.new_string('.'),
			rt.new_string(''),
		])
	} else if rt.is_true(rt.new_bool(var_number.clone().is_double())) {
		var_number = rt.call_function('str_replace', [
			rt.create_array_from_list(var_decimals),
			rt.new_string('.'),
			rt.call_function('sprintf', [
				rt.new_string('%.' +
					(rt.call_function('wc_get_rounding_precision', []rt.PhpVal{})).str() + 'f'),
				var_number.clone(),
			]),
		])
		var_trim_zeros = true
	}
	if var_trim_zeros
		&& rt.is_true(rt.call_function('strstr', [var_number.clone(), rt.new_string('.')])) {
		var_number =
			rt.new_string(var_number.clone().to_string().trim_right(' \t\n\r').trim_right(' \t\n\r'))
	}
	return var_number.str()
}

fn wc_float_to_string(var_float rt.PhpVal) rt.PhpVal {
	mut var_locale := rt.new_null()
	mut var_string := rt.new_null()
	if !(var_float.clone().is_double()) {
		return var_float.clone()
	}
	var_locale = rt.call_function('localeconv', []rt.PhpVal{})
	var_string = rt.new_string(var_float.clone().to_string())
	var_string = rt.call_function('str_replace', [
		var_locale.array_get(rt.new_string('decimal_point')),
		rt.new_string('.'),
		var_string.clone(),
	])
	return var_string.clone()
}

fn wc_format_localized_price(var_value rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_format_localized_price'),
		rt.call_function('str_replace', [rt.new_string('.'), wc_get_price_decimal_separator(),
			rt.new_string(var_value.clone().to_string())]),
		var_value.clone(),
	])
}

fn wc_format_localized_decimal(var_value rt.PhpVal) rt.PhpVal {
	mut var_locale := rt.new_null()
	mut var_decimal_point := rt.new_null()
	mut var_decimal := rt.new_null()
	var_locale = rt.call_function('localeconv', []rt.PhpVal{})
	var_decimal_point = if var_locale.array_isset(rt.new_string('decimal_point')) {
		var_locale.array_get(rt.new_string('decimal_point'))
	} else {
		rt.new_string('.')
	}
	var_decimal = if !(!rt.is_true(wc_get_price_decimal_separator())) {
		wc_get_price_decimal_separator()
	} else {
		var_decimal_point
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_format_localized_decimal'),
		rt.call_function('str_replace', [rt.new_string('.'), var_decimal.clone(),
			rt.new_string(var_value.clone().to_string())]),
		var_value.clone(),
	])
}

fn wc_format_coupon_code(var_value rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_code'),
		var_value.clone()])
}

fn wc_sanitize_coupon_code(var_value_arg rt.PhpVal) rt.PhpVal {
	mut var_value := var_value_arg
	var_value = rt.call_function('wp_kses', [
		rt.call_function('sanitize_post_field', [rt.new_string('post_title'),
			rt.call_function('html_entity_decode', [if !var_value.is_null() {
				var_value
			} else {
				rt.new_string('')
			}, rt.get_constant('ENT_COMPAT'),
				rt.call_function('get_bloginfo', [rt.new_string('charset')])]),
			rt.new_int(0), rt.new_string('db')]),
		rt.new_string('entities'),
	])
	return if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('unfiltered_html'),
	]))
	{ var_value } else { rt.call_function('stripslashes', [var_value.clone()]) }
}

fn wc_clean(var_var rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_var.clone().is_array())) {
		return rt.call_function('array_map', [rt.new_string('wc_clean'),
			var_var.clone()])
	} else {
		return if rt.is_true(rt.call_function('is_scalar', [var_var.clone()])) { rt.call_function('sanitize_text_field', [
				var_var.clone(),
			]) } else { var_var }
	}
	return rt.new_null()
}

fn wc_check_invalid_utf8(var_var rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_var.clone().is_array())) {
		return rt.call_function('array_map', [rt.new_string('wc_check_invalid_utf8'),
			var_var.clone()])
	} else {
		return rt.call_function('wp_check_invalid_utf8', [var_var.clone()])
	}
	return rt.new_null()
}

fn wc_sanitize_textarea(var_var rt.PhpVal) rt.PhpVal {
	return rt.call_function('implode', [rt.new_string('\n'),
		rt.call_function('array_map', [rt.new_string('wc_clean'),
			rt.call_function('explode', [rt.new_string('\n'), if !var_var.is_null() {
				var_var
			} else {
				rt.new_string('')
			}])])])
}

fn wc_sanitize_tooltip(var_var rt.PhpVal) rt.PhpVal {
	return rt.call_function('htmlspecialchars', [
		rt.call_function('wp_kses', [
			rt.call_function('html_entity_decode', [if !var_var.is_null() {
				var_var
			} else {
				rt.new_string('')
			}]),
			rt.create_array([rt.ArrayItem{ key: 'br', val: rt.new_array() },
				rt.ArrayItem{ key: 'em', val: rt.new_array() },
				rt.ArrayItem{ key: 'strong', val: rt.new_array() },
				rt.ArrayItem{ key: 'small', val: rt.new_array() },
				rt.ArrayItem{ key: 'span', val: rt.new_array() },
				rt.ArrayItem{ key: 'ul', val: rt.new_array() },
				rt.ArrayItem{ key: 'li', val: rt.new_array() },
				rt.ArrayItem{ key: 'ol', val: rt.new_array() },
				rt.ArrayItem{ key: 'p', val: rt.new_array() }]),
		]),
	])
}

fn wc_array_overlay(var_a1 rt.PhpVal, var_a2 rt.PhpVal) rt.PhpVal {
	mut var_v := rt.new_null()
	mut var_k := rt.new_null()
	mut iter_1 := var_a1.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_v_shadow := item_1.val
		mut var_k_shadow := item_1.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_a2.clone().array_isset(var_k_shadow.clone())))))) {
			continue
		}
		if var_v_shadow.clone().is_array() && var_a2.array_get(var_k_shadow).is_array() {
			var_a1.array_set(var_k_shadow, wc_array_overlay(var_v_shadow.clone(),
				var_a2.array_get(var_k_shadow)))
		} else {
			var_a1.array_set(var_k_shadow, var_a2.array_get(var_k_shadow))
		}
	}
	return var_a1.clone()
}

fn wc_stock_amount(amount i64) rt.PhpVal {
	mut var_amount := amount
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_2 := iife_temp_2.normalize(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_stock_amount'),
		rt.new_int(amount),
	]), rt.new_int(amount).to_i64())
	return iife_result_2
}

fn wc_is_stock_amount_integer() rt.PhpVal {
	return rt.identical(wc_stock_amount(1), rt.new_int(1))
}

fn get_woocommerce_price_format() rt.PhpVal {
	mut var_currency_pos := rt.new_null()
	mut var_format := ''
	var_currency_pos = rt.call_function('get_option', [
		rt.new_string('woocommerce_currency_pos'),
	])
	var_format = '%1$s%2$s'
	mut switch_val_5 := var_currency_pos
	if rt.is_true(rt.equal(switch_val_5, rt.new_string('left'))) {
		var_format = '%1$s%2$s'
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('right'))) {
		var_format = '%2$s%1$s'
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('left_space'))) {
		var_format = '%1$s&nbsp;%2$s'
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('right_space'))) {
		var_format = '%2$s&nbsp;%1$s'
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_price_format'),
		rt.new_string(var_format.str()).clone(), var_currency_pos.clone()])
}

fn wc_get_price_thousand_separator() rt.PhpVal {
	return rt.call_function('stripslashes', [
		rt.call_function('apply_filters', [
			rt.new_string('wc_get_price_thousand_separator'),
			rt.call_function('get_option', [
				rt.new_string('woocommerce_price_thousand_sep'),
			]),
		]),
	])
}

fn wc_get_price_decimal_separator() rt.PhpVal {
	mut var_separator := rt.new_null()
	var_separator = rt.call_function('apply_filters', [
		rt.new_string('wc_get_price_decimal_separator'),
		rt.call_function('get_option', [rt.new_string('woocommerce_price_decimal_sep')]),
	])
	return if rt.is_true(var_separator) { rt.call_function('stripslashes', [
			var_separator.clone()]) } else { rt.new_string('.') }
}

fn wc_get_price_decimals() rt.PhpVal {
	return rt.call_function('absint', [
		rt.call_function('apply_filters', [rt.new_string('wc_get_price_decimals'),
			rt.call_function('get_option', [
				rt.new_string('woocommerce_price_num_decimals'),
				rt.new_int(2),
			])]),
	])
}

fn wc_price(var_price_arg rt.PhpVal, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_price := var_price_arg
	mut var_args := var_args_arg
	mut var_original_price := rt.new_null()
	mut var_unformatted_price := rt.new_null()
	mut var_negative := false
	mut var_formatted_price := rt.new_null()
	mut var_aria_hidden := ''
	mut var_return := rt.new_null()
	var_args = rt.call_function('apply_filters', [rt.new_string('wc_price_args'),
		rt.call_function('wp_parse_args', [var_args.clone(),
			rt.create_array([rt.ArrayItem{ key: 'ex_tax_label', val: false },
				rt.ArrayItem{ key: 'currency', val: '' }, rt.ArrayItem{
					key: 'decimal_separator'
					val: wc_get_price_decimal_separator()
				}, rt.ArrayItem{ key: 'thousand_separator', val: wc_get_price_thousand_separator() },
				rt.ArrayItem{ key: 'decimals', val: wc_get_price_decimals() },
				rt.ArrayItem{ key: 'price_format', val: get_woocommerce_price_format() },
				rt.ArrayItem{ key: 'in_span', val: true }, rt.ArrayItem{
					key: 'aria-hidden'
					val: false
				}])])])
	var_original_price = var_price.clone()
	var_price = rt.new_float(var_price.to_f64())
	var_unformatted_price = var_price.clone()
	var_negative = (rt.less(var_price, rt.new_int(0))).to_bool()
	var_price = rt.call_function('apply_filters', [
		rt.new_string('raw_woocommerce_price'),
		if var_negative { rt.mul(var_price, -1) } else { var_price },
		var_original_price.clone(),
	])
	var_price = rt.call_function('apply_filters', [
		rt.new_string('formatted_woocommerce_price'),
		rt.call_function('number_format', [var_price.clone(),
			var_args.array_get(rt.new_string('decimals')),
			var_args.array_get(rt.new_string('decimal_separator')),
			var_args.array_get(rt.new_string('thousand_separator'))]),
		var_price.clone(),
		var_args.array_get(rt.new_string('decimals')),
		var_args.array_get(rt.new_string('decimal_separator')),
		var_args.array_get(rt.new_string('thousand_separator')),
		var_original_price.clone(),
	])
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_price_trim_zeros'), rt.new_bool(false)]))
		&& rt.is_true(rt.greater(var_args.array_get(rt.new_string('decimals')), rt.new_int(0))) {
		var_price = wc_trim_zeros(var_price.clone())
	}
	if rt.is_true(var_args.array_get(rt.new_string('in_span'))) {
		var_formatted_price = rt.new_string((if var_negative { '-' } else { '' } +
			(rt.call_function('sprintf', [var_args.array_get(rt.new_string('price_format')), rt.new_string('<span class="woocommerce-Price-currencySymbol">' + (rt.call_function('get_woocommerce_currency_symbol', [var_args.array_get(rt.new_string('currency'))])).str() +
			'</span>'), var_price.clone()])).str()).str())
		var_aria_hidden = if rt.is_true(var_args.array_get(rt.new_string('aria-hidden'))) {
			' aria-hidden="true"'
		} else {
			''
		}
		var_return = rt.new_string('<span class="woocommerce-Price-amount amount"' +
			var_aria_hidden + '><bdi>' + var_formatted_price.str() + '</bdi></span>')
	} else {
		var_formatted_price =
			rt.new_string((if var_negative { '-' } else { '' } +(rt.call_function('sprintf', [var_args.array_get(rt.new_string('price_format')), rt.call_function('get_woocommerce_currency_symbol', [var_args.array_get(rt.new_string('currency'))]), var_price.clone()])).str()).str())
		var_return = var_formatted_price.clone()
	}
	if rt.is_true(var_args.array_get(rt.new_string('ex_tax_label')))
		&& rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		var_return = rt.concat(var_return, rt.new_string(
			' <small class="woocommerce-Price-taxLabel tax_label">' +
			(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'ex_tax_or_vat', []rt.PhpVal{})).str() +
			'</small>'))
	}
	return rt.call_function('apply_filters', [rt.new_string('wc_price'),
		var_return.clone(), var_price.clone(), var_args.clone(),
		var_unformatted_price.clone(), var_original_price.clone()])
}

fn wc_let_to_num(var_size_arg rt.PhpVal) rt.PhpVal {
	mut var_size := var_size_arg
	mut var_l := rt.new_null()
	mut var_ret := rt.new_null()
	var_size = if !var_size.is_null() { var_size } else { rt.new_string('') }
	var_l = rt.call_function('substr', [var_size.clone(), rt.new_int(-1)])
	var_ret = rt.new_int((rt.call_function('substr', [var_size.clone(),
		rt.new_int(0), rt.new_int(-1)])).to_i64())
	mut switch_val_6 := rt.new_string(var_l.clone().to_string().to_upper())
	if rt.is_true(rt.equal(switch_val_6, rt.new_string('P'))) {
		var_ret = rt.mul(var_ret, rt.new_int(1024))
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('T'))) {
		var_ret = rt.mul(var_ret, rt.new_int(1024))
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('G'))) {
		var_ret = rt.mul(var_ret, rt.new_int(1024))
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('M'))) {
		var_ret = rt.mul(var_ret, rt.new_int(1024))
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('K'))) {
		var_ret = rt.mul(var_ret, rt.new_int(1024))
	}
	return var_ret.clone()
}

fn wc_date_format() rt.PhpVal {
	mut var_date_format := rt.new_null()
	var_date_format = rt.call_function('get_option', [rt.new_string('date_format')])
	if !rt.is_true(var_date_format) {
		var_date_format = rt.new_string('F j, Y')
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_date_format'),
		var_date_format.clone()])
}

fn wc_time_format() rt.PhpVal {
	mut var_time_format := rt.new_null()
	var_time_format = rt.call_function('get_option', [rt.new_string('time_format')])
	if !rt.is_true(var_time_format) {
		var_time_format = rt.new_string('g:i a')
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_time_format'),
		var_time_format.clone()])
}

fn wc_string_to_timestamp(var_time_string_arg rt.PhpVal, var_from_timestamp rt.PhpVal) rt.PhpVal {
	mut var_time_string := var_time_string_arg
	mut var_original_timezone := rt.new_null()
	mut var_next_timestamp := rt.new_null()
	var_time_string = if !var_time_string.is_null() { var_time_string } else { rt.new_string('') }
	var_original_timezone = rt.call_function('date_default_timezone_get', []rt.PhpVal{})
	rt.call_function('date_default_timezone_set', [rt.new_string('UTC')])
	if rt.is_true(rt.identical(rt.new_null(), var_from_timestamp)) {
		var_next_timestamp = rt.call_function('strtotime', [var_time_string.clone()])
	} else {
		var_next_timestamp = rt.call_function('strtotime', [var_time_string.clone(),
			var_from_timestamp.clone()])
	}
	rt.call_function('date_default_timezone_set', [var_original_timezone.clone()])
	return var_next_timestamp.clone()
}

fn wc_string_to_datetime(var_time_string_arg rt.PhpVal) rt.PhpVal {
	mut var_time_string := var_time_string_arg
	mut var_date_bits := []rt.PhpVal{}
	mut var_offset := rt.new_null()
	mut var_timestamp := rt.new_null()
	mut var_datetime := rt.new_null()
	var_time_string = if !var_time_string.is_null() { var_time_string } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [
		rt.new_string('/^(\\d{4})-(\\d{2})-(\\d{2})T(\\d{2}):(\\d{2}):(\\d{2})(Z|((-|\\+)\\d{2}:\\d{2}))$/'),
		var_time_string.clone(),
		rt.create_array_from_list(var_date_bits),
	])))
	{
		var_offset = if !(!rt.is_true(var_date_bits[7])) { rt.call_function('iso8601_timezone_to_offset', [
				var_date_bits[7],
			]) } else { rt.new_float(wc_timezone_offset()) }
		var_timestamp = rt.sub(rt.call_function('gmmktime', [var_date_bits[4], var_date_bits[5],
			var_date_bits[6], var_date_bits[2], var_date_bits[3], var_date_bits[1]]), var_offset)
	} else {
		var_timestamp = wc_string_to_timestamp(rt.call_function('get_gmt_from_date', [
			rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
				wc_string_to_timestamp(var_time_string.clone(), rt.new_null())]),
		]), rt.new_null())
	}
	var_datetime = create_wc_datetime(rt.new_string('@${var_timestamp.to_string()}'),
		create_datetimezone(rt.new_string('UTC')))
	if rt.is_true(rt.call_function('get_option', [rt.new_string('timezone_string')])) {
		var_datetime.settimezone(create_datetimezone(rt.new_string(wc_timezone_string())))
	} else {
		var_datetime.set_utc_offset(rt.new_float(wc_timezone_offset()))
	}
	return mut var_datetime
}

fn wc_timezone_string() string {
	mut var_timezone := rt.new_null()
	mut var_utc_offset := rt.new_null()
	mut var_abbr := rt.new_null()
	mut var_city := map[string]rt.PhpVal{}
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_timezone_string'),
	]))
	{
		return (rt.call_function('wp_timezone_string', []rt.PhpVal{})).str()
	}
	var_timezone = rt.call_function('get_option', [rt.new_string('timezone_string')])
	if rt.is_true(var_timezone) {
		return var_timezone.str()
	}
	var_utc_offset = rt.new_float(rt.call_function('get_option', [
		rt.new_string('gmt_offset'),
		rt.new_int(0),
	]).to_f64())
	if !(var_utc_offset.clone().is_long() || var_utc_offset.clone().is_double())
		|| rt.is_true(rt.identical(rt.new_float(0), var_utc_offset)) {
		return 'UTC'
	}
	var_utc_offset = rt.new_int((rt.mul(var_utc_offset, rt.new_int(3600))).to_i64())
	var_timezone = rt.call_function('timezone_name_from_abbr', [
		rt.new_string(''), var_utc_offset.clone()])
	if rt.is_true(var_timezone) {
		return var_timezone.str()
	}
	mut iter_2 := rt.call_function('timezone_abbreviations_list', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_abbr_shadow := item_2.val
		mut iter_3 := var_abbr_shadow.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_city_shadow := item_3.val
			if rt.is_true(rt.identical((rt.call_function('date', [rt.new_string('I')])).to_bool(), (var_city_shadow['dst']).to_bool())) && rt.is_true(var_city_shadow['timezone_id'])
				&& rt.is_true(rt.identical(rt.new_int(var_city_shadow['offset'].to_i64()), var_utc_offset)) {
				return (var_city_shadow['timezone_id']).str()
			}
		}
	}
	return 'UTC'
}

fn wc_timezone_offset() f64 {
	mut var_timezone := rt.new_null()
	mut var_timezone_object := rt.new_null()
	var_timezone = rt.call_function('get_option', [rt.new_string('timezone_string')])
	if rt.is_true(var_timezone) {
		var_timezone_object = create_datetimezone(var_timezone.clone())
		return (var_timezone_object.getoffset(create_datetime(rt.new_string('now')))).to_f64()
	} else {
		return rt.call_function('get_option', [rt.new_string('gmt_offset'),
			rt.new_int(0)]).to_f64() * rt.get_constant('HOUR_IN_SECONDS')
	}
	return 0.0
}

fn wc_flatten_meta_callback(var_value rt.PhpVal) rt.PhpVal {
	return if var_value.clone().is_array() { rt.call_function('current', [
			var_value.clone()]) } else { var_value }
}

fn wc_rgb_from_hex(var_color_arg rt.PhpVal) rt.PhpVal {
	mut var_color := var_color_arg
	mut var_rgb := map[string]rt.PhpVal{}
	var_color = rt.call_function('str_replace', [rt.new_string('#'),
		rt.new_string(''), if !var_color.is_null() { var_color } else { rt.new_string('000') }])
	var_color = rt.call_function('preg_replace', [rt.new_string('~^(.)(.)(.)$~'),
		rt.new_string('$1$1$2$2$3$3'), var_color.clone()])
	var_rgb = rt.new_array()
	var_rgb['R'] = rt.call_function('hexdec', [
		rt.new_string(
			(var_color.array_get(rt.new_int(0))).str() + (var_color.array_get(rt.new_int(1))).str()),
	])
	var_rgb['G'] = rt.call_function('hexdec', [
		rt.new_string(
			(var_color.array_get(rt.new_int(2))).str() + (var_color.array_get(rt.new_int(3))).str()),
	])
	var_rgb['B'] = rt.call_function('hexdec', [
		rt.new_string(
			(var_color.array_get(rt.new_int(4))).str() + (var_color.array_get(rt.new_int(5))).str()),
	])
	return var_rgb.clone()
}

fn wc_hex_darker(var_color_arg rt.PhpVal, factor i64) string {
	mut var_factor := factor
	mut var_color := var_color_arg
	mut var_base := rt.new_null()
	mut var_v := rt.new_null()
	mut var_k := rt.new_null()
	mut var_amount := rt.new_null()
	mut var_new_decimal := rt.new_null()
	mut var_new_hex_component := rt.new_null()
	var_base = wc_rgb_from_hex(rt.new_string(var_color.str()).clone())
	var_color = '#'
	mut iter_4 := var_base.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_v_shadow := item_4.val
		mut var_k_shadow := item_4.key
		var_amount = rt.div(var_v_shadow, rt.new_int(100))
		mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
		mut iife_result_3 := iife_temp_3.round(rt.mul(var_amount, rt.new_int(factor)))
		var_amount = iife_result_3
		var_new_decimal = rt.sub(var_v_shadow, var_amount)
		var_new_hex_component = rt.call_function('dechex', [var_new_decimal.clone()])
		if var_new_hex_component.clone().to_string().len < 2 {
			var_new_hex_component = rt.new_string('0' + var_new_hex_component.str())
		}
		var_color = var_color + var_new_hex_component.str()
	}
	return var_color
}

fn wc_hex_lighter(var_color_arg rt.PhpVal, factor i64) string {
	mut var_factor := factor
	mut var_color := var_color_arg
	mut var_base := rt.new_null()
	mut var_v := rt.new_null()
	mut var_k := rt.new_null()
	mut var_amount := rt.new_null()
	mut var_new_decimal := rt.new_null()
	mut var_new_hex_component := rt.new_null()
	var_base = wc_rgb_from_hex(rt.new_string(var_color.str()).clone())
	var_color = '#'
	mut iter_5 := var_base.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_v_shadow := item_5.val
		mut var_k_shadow := item_5.key
		var_amount = rt.sub(rt.new_int(255), var_v_shadow)
		var_amount = rt.div(var_amount, rt.new_int(100))
		mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
		mut iife_result_4 := iife_temp_4.round(rt.mul(var_amount, rt.new_int(factor)))
		var_amount = iife_result_4
		var_new_decimal = rt.add(var_v_shadow, var_amount)
		var_new_hex_component = rt.call_function('dechex', [var_new_decimal.clone()])
		if var_new_hex_component.clone().to_string().len < 2 {
			var_new_hex_component = rt.new_string('0' + var_new_hex_component.str())
		}
		var_color = var_color + var_new_hex_component.str()
	}
	return var_color
}

fn wc_hex_is_light(var_color rt.PhpVal) rt.PhpVal {
	mut var_hex := rt.new_null()
	mut var_c_r := rt.new_null()
	mut var_c_g := rt.new_null()
	mut var_c_b := rt.new_null()
	mut var_brightness := rt.new_null()
	var_hex = rt.call_function('str_replace', [rt.new_string('#'),
		rt.new_string(''), if !var_color.is_null() { var_color } else { rt.new_string('') }])
	var_c_r = rt.call_function('hexdec', [
		rt.call_function('substr', [var_hex.clone(), rt.new_int(0),
			rt.new_int(2)]),
	])
	var_c_g = rt.call_function('hexdec', [
		rt.call_function('substr', [var_hex.clone(), rt.new_int(2),
			rt.new_int(2)]),
	])
	var_c_b = rt.call_function('hexdec', [
		rt.call_function('substr', [var_hex.clone(), rt.new_int(4),
			rt.new_int(2)]),
	])
	var_brightness = rt.div(rt.add(rt.add(rt.mul(var_c_r, rt.new_int(299)), rt.mul(var_c_g,
		rt.new_int(587))), rt.mul(var_c_b, rt.new_int(114))), rt.new_int(1000))
	return rt.greater(var_brightness, rt.new_int(155))
}

fn wc_light_or_dark(var_color rt.PhpVal, dark string, light string) string {
	mut var_dark := dark
	mut var_light := light
	return if rt.is_true(wc_hex_is_light(var_color.clone())) { dark } else { light }
}

fn wc_format_hex(var_hex_arg rt.PhpVal) rt.PhpVal {
	mut var_hex := var_hex_arg
	var_hex = rt.new_string(rt.call_function('str_replace', [
		rt.new_string('#'), rt.new_string(''), if !var_hex.is_null() {
			var_hex
		} else {
			rt.new_string('')
		}]).to_string().trim_space())
	if var_hex.clone().to_string().len == 3 {
		var_hex = rt.new_string((var_hex.array_get(rt.new_int(0))).str() +
			(var_hex.array_get(rt.new_int(0))).str() + (var_hex.array_get(rt.new_int(1))).str() +
			(var_hex.array_get(rt.new_int(1))).str() + (var_hex.array_get(rt.new_int(2))).str() +
			(var_hex.array_get(rt.new_int(2))).str())
	}
	return if rt.is_true(var_hex) { '#' + var_hex.str() } else { rt.new_null() }
}

fn wc_format_postcode(var_postcode_arg rt.PhpVal, var_country rt.PhpVal) rt.PhpVal {
	mut var_postcode := var_postcode_arg
	var_postcode = wc_normalize_postcode(if !var_postcode.is_null() {
		var_postcode
	} else {
		rt.new_string('')
	})
	mut switch_val_7 := var_country
	if rt.is_true(rt.equal(switch_val_7, rt.new_string('SE'))) {
		var_postcode = rt.call_function('substr_replace', [var_postcode.clone(),
			rt.new_string(' '), rt.new_int(-2), rt.new_int(0)])
	} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('CA')))
		|| rt.is_true(rt.equal(switch_val_7, rt.new_string('GB'))) {
		var_postcode = rt.call_function('substr_replace', [var_postcode.clone(),
			rt.new_string(' '), rt.new_int(-3), rt.new_int(0)])
	} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('IE'))) {
		var_postcode = rt.call_function('substr_replace', [var_postcode.clone(),
			rt.new_string(' '), rt.new_int(3), rt.new_int(0)])
	} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('BR')))
		|| rt.is_true(rt.equal(switch_val_7, rt.new_string('PL'))) {
		var_postcode = rt.call_function('substr_replace', [var_postcode.clone(),
			rt.new_string('-'), rt.new_int(-3), rt.new_int(0)])
	} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('JP'))) {
		var_postcode = rt.call_function('substr_replace', [var_postcode.clone(),
			rt.new_string('-'), rt.new_int(3), rt.new_int(0)])
	} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('PT'))) {
		var_postcode = rt.call_function('substr_replace', [var_postcode.clone(),
			rt.new_string('-'), rt.new_int(4), rt.new_int(0)])
	} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('PR')))
		|| rt.is_true(rt.equal(switch_val_7, rt.new_string('US')))
		|| rt.is_true(rt.equal(switch_val_7, rt.new_string('MN'))) {
		var_postcode = rt.new_string(rt.call_function('substr_replace', [
			var_postcode.clone(), rt.new_string('-'), rt.new_int(5),
			rt.new_int(0)]).to_string().trim_right(' \t\n\r'))
	} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('NL'))) {
		var_postcode = rt.call_function('substr_replace', [var_postcode.clone(),
			rt.new_string(' '), rt.new_int(4), rt.new_int(0)])
	} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('LV'))) {
		var_postcode = rt.call_function('preg_replace', [
			rt.new_string('/^(LV)?-?(\\d+)$/'),
			rt.new_string('LV-${2}'),
			var_postcode.clone(),
		])
	} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('CZ')))
		|| rt.is_true(rt.equal(switch_val_7, rt.new_string('SK'))) {
		var_postcode = rt.call_function('preg_replace', [
			rt.concat(rt.concat(rt.new_string('/^('), var_country), rt.new_string(')-?(\\d+)$/')),
			rt.new_string('${1}-${2}'),
			var_postcode.clone(),
		])
		var_postcode = rt.call_function('substr_replace', [var_postcode.clone(),
			rt.new_string(' '), rt.new_int(-2), rt.new_int(0)])
	} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('DK'))) {
		var_postcode = rt.call_function('preg_replace', [rt.new_string('/^(DK)(.+)$/'),
			rt.new_string('${1}-${2}'), var_postcode.clone()])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_format_postcode'),
		rt.new_string(var_postcode.clone().to_string().trim_space()),
		var_country.clone(),
	])
}

fn wc_normalize_postcode(var_postcode rt.PhpVal) rt.PhpVal {
	return rt.call_function('preg_replace', [rt.new_string('/[\\s\\-]/'),
		rt.new_string(''),
		rt.new_string(wc_strtoupper(if !var_postcode.is_null() {
			var_postcode
		} else {
			rt.new_string('')
		}).to_string().trim_space())])
}

fn wc_format_phone_number(var_phone_arg rt.PhpVal) string {
	mut var_phone := var_phone_arg
	var_phone = if !var_phone.is_null() { var_phone } else { rt.new_string('') }
	mut iife_temp_5 := Class_WC_Validation{}
	mut iife_result_5 := iife_temp_5.is_phone(var_phone.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_5)))) {
		return ''
	}
	return (rt.call_function('preg_replace', [rt.new_string('/[^0-9\\+\\-\\(\\)\\s]/'),
		rt.new_string('-'),
		rt.call_function('preg_replace', [
			rt.new_string('/[\\x00-\\x1F\\x7F-\\xFF]/'),
			rt.new_string(''),
			var_phone.clone(),
		])])).str()
}

fn wc_sanitize_phone_number(var_phone rt.PhpVal) rt.PhpVal {
	return rt.call_function('preg_replace', [rt.new_string('/[^\\d+]/'),
		rt.new_string(''), if !var_phone.is_null() { var_phone } else { rt.new_string('') }])
}

fn wc_strtoupper(var_string_arg rt.PhpVal) rt.PhpVal {
	mut var_string := var_string_arg
	var_string = if !var_string.is_null() { var_string } else { rt.new_string('') }
	return if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('mb_strtoupper'),
	]))
	{
		rt.call_function('mb_strtoupper', [var_string.clone()])
	} else {
		rt.new_string(var_string.clone().to_string().to_upper())
	}
}

fn wc_strtolower(var_string_arg rt.PhpVal) rt.PhpVal {
	mut var_string := var_string_arg
	var_string = if !var_string.is_null() { var_string } else { rt.new_string('') }
	return if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('mb_strtolower'),
	]))
	{
		rt.call_function('mb_strtolower', [var_string.clone()])
	} else {
		rt.new_string(var_string.clone().to_string().to_lower())
	}
}

fn wc_trim_string(var_string_arg rt.PhpVal, chars i64, suffix string) rt.PhpVal {
	mut var_chars := chars
	mut var_suffix := suffix
	mut var_string := var_string_arg
	var_string = if !var_string.is_null() { var_string } else { rt.new_string('') }
	if var_string.clone().to_string().len > chars {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_substr')])) {
			var_string = rt.new_string(
				(rt.call_function('mb_substr', [var_string.clone(), rt.new_int(0), rt.sub(rt.new_int(chars), rt.call_function('mb_strlen', [rt.new_string(suffix)]))])).str() +
				suffix)
		} else {
			var_string = rt.new_string(
				(rt.call_function('substr', [var_string.clone(), rt.new_int(0), rt.new_int(chars - suffix.len)])).str() +
				suffix)
		}
	}
	return var_string.clone()
}

fn wc_format_content(var_raw_string_arg rt.PhpVal) rt.PhpVal {
	mut var_raw_string := var_raw_string_arg
	var_raw_string = if !var_raw_string.is_null() { var_raw_string } else { rt.new_string('') }
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_format_content'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_short_description'),
			var_raw_string.clone(),
		]),
		var_raw_string.clone(),
	])
}

fn wc_format_product_short_description(var_content rt.PhpVal) rt.PhpVal {
	mut var_markdown := rt.new_null()
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WPCom_Markdown')])) {
		mut iife_temp_6 := Class_WPCom_Markdown{}
		mut iife_result_6 := iife_temp_6.get_instance()
		var_markdown = iife_result_6
		return rt.call_function('wpautop', [
			rt.call_method(var_markdown, 'transform', [var_content.clone(),
				rt.create_array([rt.ArrayItem{ key: 'unslash', val: false }])]),
		])
	}
	return var_content.clone()
}

fn wc_format_option_price_separators(var_value rt.PhpVal, var_option rt.PhpVal, var_raw_value rt.PhpVal) rt.PhpVal {
	return rt.call_function('wp_kses_post', [if !var_raw_value.is_null() {
		var_raw_value
	} else {
		rt.new_string('')
	}])
}

fn wc_format_option_price_num_decimals(var_value rt.PhpVal, var_option rt.PhpVal, var_raw_value rt.PhpVal) rt.PhpVal {
	return if var_raw_value.clone().is_null() { rt.new_int(2) } else { rt.call_function('absint', [
			var_raw_value.clone(),
		]) }
}

fn wc_format_option_hold_stock_minutes(var_value_arg rt.PhpVal, var_option rt.PhpVal, var_raw_value rt.PhpVal) rt.PhpVal {
	mut var_value := var_value_arg
	mut var_cancel_unpaid_interval := rt.new_null()
	var_value = if !(!rt.is_true(var_raw_value)) { rt.call_function('absint', [
			var_raw_value.clone(),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('as_unschedule_all_actions'),
	]))
	{
		rt.call_function('as_unschedule_all_actions', [
			rt.new_string('woocommerce_cancel_unpaid_orders'),
		])
	} else {
		rt.call_function('wp_clear_scheduled_hook', [
			rt.new_string('woocommerce_cancel_unpaid_orders'),
		])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value)))) {
		var_cancel_unpaid_interval = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_cancel_unpaid_orders_interval_minutes'),
			rt.call_function('absint', [var_value.clone()]),
		])
		if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('as_schedule_single_action'),
		]))
		{
			rt.call_function('as_schedule_single_action', [
				rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.call_function('absint', [
					var_cancel_unpaid_interval.clone(),
				]), rt.new_int(60))),
				rt.new_string('woocommerce_cancel_unpaid_orders'),
				rt.new_array(),
				rt.new_string('woocommerce'),
				rt.new_bool(true),
			])
		} else {
			rt.call_function('wp_schedule_single_event', [
				rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.call_function('absint', [
					var_cancel_unpaid_interval.clone(),
				]), rt.new_int(60))),
				rt.new_string('woocommerce_cancel_unpaid_orders'),
			])
		}
	}
	return var_value.clone()
}

fn wc_sanitize_term_text_based(var_term rt.PhpVal) string {
	return rt.call_function('wp_strip_all_tags', [
		rt.call_function('wp_unslash', [if !var_term.is_null() {
			var_term
		} else {
			rt.new_string('')
		}]),
	]).to_string().trim_space()
}

fn wc_make_numeric_postcode(var_postcode_arg rt.PhpVal) string {
	mut var_postcode := var_postcode_arg
	mut var_postcode_length := i64(0)
	mut var_letters_to_numbers := rt.new_null()
	mut var_numeric_postcode := ''
	mut var_i := i64(0)
	var_postcode = rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: ' ' },
			rt.ArrayItem{ key: none, val: '-' }]),
		rt.new_string(''),
		if !var_postcode.is_null() { var_postcode } else { rt.new_string('') },
	])
	var_postcode_length = var_postcode.clone().to_string().len
	var_letters_to_numbers = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: none, val: 0 }]),
		rt.call_function('range', [rt.new_string('A'), rt.new_string('Z')]),
	])
	var_letters_to_numbers = rt.call_function('array_flip', [
		var_letters_to_numbers.clone()])
	var_numeric_postcode = ''
	var_i = 0
	for {
		if !(var_i < var_postcode_length) { break
		 }
		if rt.is_true(rt.new_bool(var_postcode.array_get(rt.new_int(var_i)).is_long()
			|| var_postcode.array_get(rt.new_int(var_i)).is_double()))
		{
			var_numeric_postcode = var_numeric_postcode +(rt.call_function('str_pad', [var_postcode.array_get(rt.new_int(var_i)), rt.new_int(2), rt.new_string('0'), rt.get_constant('STR_PAD_LEFT')])).str()
		} else if var_letters_to_numbers.array_isset(var_postcode.array_get(rt.new_int(var_i))) {
			var_numeric_postcode = var_numeric_postcode +(rt.call_function('str_pad', [var_letters_to_numbers.array_get(var_postcode.array_get(rt.new_int(var_i))), rt.new_int(2), rt.new_string('0'), rt.get_constant('STR_PAD_LEFT')])).str()
		} else {
			var_numeric_postcode = var_numeric_postcode + '00'
		}
		var_i += 1
	}
	return var_numeric_postcode
}

fn wc_format_stock_for_display(var_product rt.PhpVal) rt.PhpVal {
	mut var_display := rt.new_null()
	mut var_stock_amount := rt.new_null()
	var_display = rt.call_function('__', [rt.new_string('In stock'),
		rt.new_string('woocommerce')])
	var_stock_amount = rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{})
	mut switch_val_8 := rt.call_function('get_option', [
		rt.new_string('woocommerce_stock_format'),
	])
	if rt.is_true(rt.equal(switch_val_8, rt.new_string('low_amount'))) {
		if rt.is_true(rt.less_equal(var_stock_amount, rt.call_function('wc_get_low_stock_amount', [
			var_product.clone(),
		])))
		{
			var_display = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Only %s left in stock'),
					rt.new_string('woocommerce')]),
				wc_format_stock_quantity_for_display(var_stock_amount.clone(), var_product.clone()),
			])
		}
	} else if rt.is_true(rt.equal(switch_val_8, rt.new_string(''))) {
		var_display = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s in stock'),
				rt.new_string('woocommerce')]),
			wc_format_stock_quantity_for_display(var_stock_amount.clone(), var_product.clone()),
		])
	}
	if rt.is_true(rt.call_method(var_product, 'backorders_allowed', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_product, 'backorders_require_notification', []rt.PhpVal{})) {
		var_display = rt.concat(var_display,
			rt.new_string(' ' +(rt.call_function('__', [rt.new_string('(can be backordered)'), rt.new_string('woocommerce')])).str()))
	}
	return var_display.clone()
}

fn wc_format_stock_quantity_for_display(var_stock_quantity rt.PhpVal, var_product rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_format_stock_quantity'),
		var_stock_quantity.clone(),
		var_product.clone(),
	])
}

fn wc_format_sale_price(var_regular_price rt.PhpVal, var_sale_price rt.PhpVal) rt.PhpVal {
	mut var_formatted_regular_price := rt.new_null()
	mut var_formatted_sale_price := rt.new_null()
	mut var_price := rt.new_null()
	var_formatted_regular_price = if var_regular_price.clone().is_long()
		|| var_regular_price.clone().is_double() {
		wc_price(var_regular_price.clone(), rt.new_null())
	} else {
		var_regular_price
	}
	var_formatted_sale_price = if var_sale_price.clone().is_long()
		|| var_sale_price.clone().is_double() {
		wc_price(var_sale_price.clone(), rt.new_null())
	} else {
		var_sale_price
	}
	var_price = rt.new_string('<del aria-hidden="true">' + var_formatted_regular_price.str() +
		'</del> ')
	var_price = rt.concat(var_price, rt.new_string('<span class="screen-reader-text">'))
	var_price = rt.concat(var_price, rt.call_function('esc_html', [
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Original price was: %s.'),
				rt.new_string('woocommerce')]),
			rt.call_function('wp_strip_all_tags', [var_formatted_regular_price.clone()]),
		]),
	]))
	var_price = rt.concat(var_price, rt.new_string('</span>'))
	var_price = rt.concat(var_price, rt.new_string('<ins aria-hidden="true">' +
		var_formatted_sale_price.str() + '</ins>'))
	var_price = rt.concat(var_price, rt.new_string('<span class="screen-reader-text">'))
	var_price = rt.concat(var_price, rt.call_function('esc_html', [
		rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Current price is: %s.'),
				rt.new_string('woocommerce')]),
			rt.call_function('wp_strip_all_tags', [var_formatted_sale_price.clone()]),
		]),
	]))
	var_price = rt.concat(var_price, rt.new_string('</span>'))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_format_sale_price'),
		var_price.clone(),
		var_regular_price.clone(),
		var_sale_price.clone(),
	])
}

fn wc_format_price_range(var_from rt.PhpVal, var_to rt.PhpVal) rt.PhpVal {
	mut var_price := rt.new_null()
	var_price = rt.call_function('sprintf', [
		rt.call_function('_x', [
			rt.new_string('%1$s <span aria-hidden="true">&ndash;</span> %2$s'),
			rt.new_string('Price range: from-to'),
			rt.new_string('woocommerce'),
		]),
		if var_from.clone().is_long() || var_from.clone().is_double() { wc_price(var_from.clone(), rt.create_array([
				rt.ArrayItem{ key: 'aria-hidden', val: true },
			])) } else { var_from },
		if var_to.clone().is_long() || var_to.clone().is_double() { wc_price(var_to.clone(), rt.create_array([
				rt.ArrayItem{ key: 'aria-hidden', val: true },
			])) } else { var_to },
	])
	var_price = rt.concat(var_price, rt.new_string('<span class="screen-reader-text">'))
	var_price = rt.concat(var_price, rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Price range: %1$s through %2$s'),
			rt.new_string('woocommerce')]),
		if var_from.clone().is_long() || var_from.clone().is_double() { rt.call_function('wp_strip_all_tags', [
				wc_price(var_from.clone(), rt.new_null())]) } else { rt.call_function('wp_strip_all_tags', [
				var_from.clone()]) },
		if var_to.clone().is_long() || var_to.clone().is_double() { rt.call_function('wp_strip_all_tags', [
				wc_price(var_to.clone(), rt.new_null())]) } else { rt.call_function('wp_strip_all_tags', [
				var_to.clone()]) },
	]))
	var_price = rt.concat(var_price, rt.new_string('</span>'))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_format_price_range'),
		var_price.clone(),
		var_from.clone(),
		var_to.clone(),
	])
}

fn wc_format_weight(var_weight rt.PhpVal) rt.PhpVal {
	mut var_weight_string := rt.new_null()
	mut var_weight_label := rt.new_null()
	var_weight_string = wc_format_localized_decimal(var_weight.clone())
	if !(!rt.is_true(var_weight_string)) {
		mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
		mut iife_result_7 := iife_temp_7.get_weight_unit_label(rt.call_function('get_option', [
			rt.new_string('woocommerce_weight_unit'),
		]))
		var_weight_label = iife_result_7
		var_weight_string = rt.call_function('sprintf', [
			rt.call_function('_x', [rt.new_string('%1$s %2$s'),
				rt.new_string('formatted weight'), rt.new_string('woocommerce')]),
			var_weight_string.clone(),
			var_weight_label.clone(),
		])
	} else {
		var_weight_string = rt.call_function('__', [rt.new_string('N/A'),
			rt.new_string('woocommerce')])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_format_weight'),
		var_weight_string.clone(), var_weight.clone()])
}

fn wc_format_dimensions(var_dimensions rt.PhpVal) rt.PhpVal {
	mut var_dimension_string := rt.new_null()
	mut var_dimension_label := rt.new_null()
	var_dimension_string = rt.call_function('implode', [rt.new_string(' &times; '),
		rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('wc_format_localized_decimal'),
				var_dimensions.clone()]),
		])])
	if !(!rt.is_true(var_dimension_string)) {
		mut iife_temp_8 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
		mut iife_result_8 := iife_temp_8.get_dimensions_unit_label(rt.call_function('get_option', [
			rt.new_string('woocommerce_dimension_unit'),
		]))
		var_dimension_label = iife_result_8
		var_dimension_string = rt.call_function('sprintf', [
			rt.call_function('_x', [rt.new_string('%1$s %2$s'),
				rt.new_string('formatted dimensions'), rt.new_string('woocommerce')]),
			var_dimension_string.clone(),
			var_dimension_label.clone(),
		])
	} else {
		var_dimension_string = rt.call_function('__', [rt.new_string('N/A'),
			rt.new_string('woocommerce')])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_format_dimensions'),
		var_dimension_string.clone(),
		var_dimensions.clone(),
	])
}

fn wc_format_datetime(var_date rt.PhpVal, format string) string {
	mut var_format := format
	if !(var_format.len > 0 && var_format != '0') {
		var_format = (wc_date_format()).str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_date.clone(), rt.new_string('WC_DateTime')])))))
	{
		return ''
	}
	return (rt.call_method(var_date, 'date_i18n', [rt.new_string(var_format.str())])).str()
}

fn wc_do_oembeds(var_content_arg rt.PhpVal) rt.PhpVal {
	mut var_content := var_content_arg
	mut var_wp_embed := rt.new_null()
	var_content = rt.call_method(var_wp_embed, 'autoembed', [if !var_content.is_null() {
		var_content
	} else {
		rt.new_string('')
	}])
	return var_content.clone()
}

fn wc_get_string_before_colon(var_string rt.PhpVal) string {
	return rt.call_function('current', [
		rt.call_function('explode', [rt.new_string(':'), rt.new_string(var_string.str())]),
	]).to_string().trim_space()
}

fn wc_array_merge_recursive_numeric() rt.PhpVal {
	mut var_arrays := rt.new_null()
	mut var_array := rt.new_null()
	mut var_key := rt.new_null()
	mut var_final := rt.new_null()
	mut var_b := rt.new_null()
	mut var_value := rt.new_null()
	var_arrays = rt.call_function('func_get_args', []rt.PhpVal{})
	if 1 == var_arrays.clone().array_count() {
		return var_arrays.array_get(rt.new_int(0))
	}
	mut iter_6 := var_arrays.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_array_shadow := item_6.val
		mut var_key_shadow := item_6.key
		if !(var_array_shadow.clone().is_array()) {
			var_arrays.array_unset(var_key_shadow)
		}
	}
	var_final = rt.call_function('array_shift', [var_arrays.clone()])
	mut iter_7 := var_arrays.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_b_shadow := item_7.val
		mut iter_8 := var_final.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_value_shadow := item_8.val
			mut var_key_shadow := item_8.key
			if !(var_b_shadow.array_isset(var_key_shadow)) {
				var_final.array_set(var_key_shadow, var_value_shadow.clone())
			} else {
				if var_value_shadow.clone().is_long()
					|| var_value_shadow.clone().is_double()
					&& var_b_shadow.array_get(var_key_shadow).is_long()
					|| var_b_shadow.array_get(var_key_shadow).is_double() {
					var_final.array_set(var_key_shadow, rt.add(var_value_shadow,
						var_b_shadow.array_get(var_key_shadow)))
				} else if var_value_shadow.clone().is_array()
					&& var_b_shadow.array_get(var_key_shadow).is_array() {
					var_final.array_set(var_key_shadow, wc_array_merge_recursive_numeric())
				} else {
					var_final.array_set(var_key_shadow, var_b_shadow.array_get(var_key_shadow))
				}
			}
		}
		mut iter_9 := var_b_shadow.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_value_shadow := item_9.val
			mut var_key_shadow := item_9.key
			if !(var_final.array_isset(var_key_shadow)) {
				var_final.array_set(var_key_shadow, var_value_shadow.clone())
			}
		}
	}
	return var_final.clone()
}

fn wc_implode_html_attributes(var_raw_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes := []rt.PhpVal{}
	mut var_value := rt.new_null()
	mut var_name := rt.new_null()
	var_attributes = rt.new_array()
	mut iter_10 := var_raw_attributes.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_value_shadow := item_10.val
		mut var_name_shadow := item_10.key
		var_attributes << (rt.call_function('esc_attr', [var_name_shadow.clone()])).str() + '="' +
			(rt.call_function('esc_attr', [var_value_shadow.clone()])).str() + '"'
	}
	return rt.call_function('implode',
		[rt.new_string(' '), rt.create_array_from_list(var_attributes)])
}

fn wc_esc_json(var_json rt.PhpVal, html bool) rt.PhpVal {
	mut var_html := html
	return rt.call_function('_wp_specialchars', [var_json.clone(), if var_html {
		rt.get_constant('ENT_NOQUOTES')
	} else {
		rt.get_constant('ENT_QUOTES')
	}, rt.new_string('UTF-8'), rt.new_bool(true)])
}

fn wc_parse_relative_date_option(var_raw_value rt.PhpVal) rt.PhpVal {
	mut var_periods := map[string]rt.PhpVal{}
	mut var_value := rt.new_null()
	var_periods = {
		'days':   rt.call_function('__', [rt.new_string('Day(s)'),
			rt.new_string('woocommerce')])
		'weeks':  rt.call_function('__', [rt.new_string('Week(s)'),
			rt.new_string('woocommerce')])
		'months': rt.call_function('__', [rt.new_string('Month(s)'),
			rt.new_string('woocommerce')])
		'years':  rt.call_function('__', [rt.new_string('Year(s)'),
			rt.new_string('woocommerce')])
	}
	var_value = rt.call_function('wp_parse_args', [rt.cast_array(var_raw_value),
		rt.create_array([rt.ArrayItem{ key: 'number', val: '' },
			rt.ArrayItem{ key: 'unit', val: 'days' }])])
	var_value.array_set('number', if !(!rt.is_true(var_value.array_get(rt.new_string('number')))) { rt.call_function('absint', [
			var_value.array_get(rt.new_string('number')),
		]) } else { rt.new_string('') })
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_value.array_get(rt.new_string('unit')),
		rt.func_array_keys(rt.create_array_from_native_map(var_periods)),
		rt.new_bool(true),
	])))))
	{
		var_value.array_set('unit', 'days')
	}
	return var_value.clone()
}

fn wc_sanitize_endpoint_slug(var_raw_value rt.PhpVal) rt.PhpVal {
	return rt.call_function('sanitize_title', [if !var_raw_value.is_null() {
		var_raw_value
	} else {
		rt.new_string('')
	}])
}

fn wc_remove_non_displayable_chars(raw_value string) string {
	mut var_raw_value := raw_value
	mut var_remove_chars := []rt.PhpVal{}
	var_remove_chars = ['­', '​', '‌', '‍', '‎', '‏', '‪', '‫', '‬', '‭', '‮',
		'﻿', '￹', '￺', '￻']
	return (rt.call_function('str_replace', [rt.create_array_from_list(var_remove_chars),
		rt.new_string(''), rt.new_string(raw_value)])).str()
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WC_DateTime {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_WC_Validation {
	rt.PhpObjectBase
}

struct Class_WPCom_Markdown {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_I18nUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_datetime(_args ...rt.PhpVal) &Class_WC_DateTime {
	mut obj := &Class_WC_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone(_args ...rt.PhpVal) &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_validation(_args ...rt.PhpVal) &Class_WC_Validation {
	mut obj := &Class_WC_Validation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wpcom_markdown(_args ...rt.PhpVal) &Class_WPCom_Markdown {
	mut obj := &Class_WPCom_Markdown{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_i18nutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_I18nUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_I18nUtil{
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

fn (mut this Class_WC_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Validation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Validation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Validation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WPCom_Markdown) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WPCom_Markdown) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WPCom_Markdown) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_rgb_from_hex'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_hex_darker'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_hex_lighter'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_hex_is_light'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_light_or_dark'),
	])))))
	{
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_format_hex'),
	])))))
	{
	}
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_price_decimal_sep'),
		rt.new_string('wc_format_option_price_separators'),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_price_thousand_sep'),
		rt.new_string('wc_format_option_price_separators'),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_price_num_decimals'),
		rt.new_string('wc_format_option_price_num_decimals'),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_hold_stock_minutes'),
		rt.new_string('wc_format_option_hold_stock_minutes'),
		rt.new_int(10),
		rt.new_int(3),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_make_numeric_postcode'),
	])))))
	{
	}
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_checkout_pay_endpoint'),
		rt.new_string('wc_sanitize_endpoint_slug'),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_checkout_order_received_endpoint'),
		rt.new_string('wc_sanitize_endpoint_slug'),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_myaccount_add_payment_method_endpoint'),
		rt.new_string('wc_sanitize_endpoint_slug'),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_myaccount_delete_payment_method_endpoint'),
		rt.new_string('wc_sanitize_endpoint_slug'),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_myaccount_set_default_payment_method_endpoint'),
		rt.new_string('wc_sanitize_endpoint_slug'),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_myaccount_orders_endpoint'),
		rt.new_string('wc_sanitize_endpoint_slug'),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_myaccount_view_order_endpoint'),
		rt.new_string('wc_sanitize_endpoint_slug'),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_myaccount_downloads_endpoint'),
		rt.new_string('wc_sanitize_endpoint_slug'),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_myaccount_edit_account_endpoint'),
		rt.new_string('wc_sanitize_endpoint_slug'),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_myaccount_edit_address_endpoint'),
		rt.new_string('wc_sanitize_endpoint_slug'),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_myaccount_payment_methods_endpoint'),
		rt.new_string('wc_sanitize_endpoint_slug'),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_myaccount_lost_password_endpoint'),
		rt.new_string('wc_sanitize_endpoint_slug'),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_admin_settings_sanitize_option_woocommerce_logout_endpoint'),
		rt.new_string('wc_sanitize_endpoint_slug'),
		rt.new_int(10),
		rt.new_int(1),
	])
}
