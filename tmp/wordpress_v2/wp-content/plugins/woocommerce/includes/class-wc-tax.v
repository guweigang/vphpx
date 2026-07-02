import rt
import crypto.md5

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn init_static_wc_tax() {
	rt.init_static_prop('WC_Tax', 'precision', rt.new_null())
	rt.init_static_prop('WC_Tax', 'round_at_subtotal', rt.new_bool(false))
}

fn Class_WC_Tax.init() {
	rt.set_static_prop('WC_Tax', 'precision', rt.call_function('wc_get_rounding_precision',
		[]rt.PhpVal{}))
	rt.set_static_prop('WC_Tax', 'round_at_subtotal', rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_tax_round_at_subtotal'),
	])))
}

fn Class_WC_Tax.maybe_remove_tax_class_rates(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Tax::maybe_remove_tax_class_rates'),
		rt.new_string('3.7'),
		rt.new_string('WC_Tax::delete_tax_class_by'),
	])
	mut var_tax_classes := rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_string('trim'),
			rt.call_function('explode', [rt.new_string('\n'),
				var_value.clone()])]),
	])
	mut var_existing_tax_classes := Class_WC_Tax.get_tax_classes()
	mut var_removed := rt.call_function('array_diff', [var_existing_tax_classes.clone(),
		var_tax_classes.clone()])
	mut iter_1 := var_removed.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_name := item_1.val
		Class_WC_Tax.delete_tax_class_by(rt.new_string('name'), var_name.clone())
	}
}

fn Class_WC_Tax.calc_tax(var_price rt.PhpVal, var_rates rt.PhpVal, price_includes_tax bool, deprecated bool) rt.PhpVal {
	mut var_price_mutated := var_price
	mut var_rates_mutated := var_rates
	if var_price_includes_tax {
		mut var_taxes := Class_WC_Tax.calc_inclusive_tax(var_price_mutated.clone(),
			var_rates_mutated.clone())
	} else {
		var_taxes = Class_WC_Tax.calc_exclusive_tax(var_price_mutated.clone(),
			var_rates_mutated.clone())
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_calc_tax'),
		var_taxes.clone(), var_price_mutated.clone(), var_rates_mutated.clone(),
		rt.new_bool(price_includes_tax), rt.new_bool(deprecated)])
}

fn Class_WC_Tax.calc_shipping_tax(var_price rt.PhpVal, var_rates rt.PhpVal) rt.PhpVal {
	mut var_price_mutated := var_price
	mut var_rates_mutated := var_rates
	mut var_shipping_prices_include_tax := rt.call_function('wc_string_to_bool', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_shipping_prices_include_tax'),
			rt.new_bool(false),
		]),
	])
	if rt.is_true(var_shipping_prices_include_tax) {
		mut var_taxes := Class_WC_Tax.calc_inclusive_tax(var_price_mutated.clone(),
			var_rates_mutated.clone())
	} else {
		var_taxes = Class_WC_Tax.calc_exclusive_tax(var_price_mutated.clone(),
			var_rates_mutated.clone())
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_calc_shipping_tax'),
		var_taxes.clone(),
		var_price_mutated.clone(),
		var_rates_mutated.clone(),
	])
}

fn Class_WC_Tax.round(var_in rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_0 := iife_temp_0.round(var_in.clone(), rt.call_function('wc_get_rounding_precision',
		[]rt.PhpVal{}))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_tax_round'), iife_result_0,
		var_in.clone()])
}

fn Class_WC_Tax.calc_inclusive_tax(var_price rt.PhpVal, var_rates rt.PhpVal) rt.PhpVal {
	mut var_price_mutated := var_price
	mut var_rates_mutated := var_rates
	mut var_taxes := rt.new_array()
	mut var_compound_rates := rt.new_array()
	mut var_regular_rates := rt.new_array()
	mut iter_2 := var_rates_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_rate := item_2.val
		mut var_key := item_2.key
		var_taxes.array_set(var_key, 0)
		if rt.is_true(rt.identical(rt.new_string('yes'),
			var_rate.array_get(rt.new_string('compound'))))
		{
			var_compound_rates.array_set(var_key, var_rate.array_get(rt.new_string('rate')))
		} else {
			var_regular_rates.array_set(var_key, var_rate.array_get(rt.new_string('rate')))
		}
	}
	var_compound_rates = rt.call_function('array_reverse', [var_compound_rates.clone(),
		rt.new_bool(true)])
	mut var_non_compound_price := var_price_mutated.clone()
	mut iter_3 := var_compound_rates.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_compound_rate := item_3.val
		mut var_key := item_3.key
		mut var_tax_amount := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_price_inc_tax_amount'),
			rt.sub(var_non_compound_price, rt.div(var_non_compound_price, rt.add(rt.new_int(1), rt.div(var_compound_rate,
				rt.new_int(100))))),
			var_key.clone(),
			var_rates_mutated.array_get(var_key),
			var_price_mutated.clone(),
		])
		var_taxes.array_get(var_key) = rt.add(var_taxes.array_get(var_key), var_tax_amount)
		var_non_compound_price = rt.sub(var_non_compound_price, var_tax_amount)
	}
	mut var_regular_tax_rate := rt.add(rt.new_int(1), rt.div(rt.call_function('array_sum', [
		var_regular_rates.clone(),
	]), rt.new_int(100)))
	mut iter_4 := var_regular_rates.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_regular_rate := item_4.val
		mut var_key := item_4.key
		mut var_the_rate := rt.div(rt.div(var_regular_rate, rt.new_int(100)), var_regular_tax_rate)
		mut var_net_price := rt.sub(var_price_mutated, rt.mul(var_the_rate, var_non_compound_price))
		mut var_tax_amount := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_price_inc_tax_amount'),
			rt.sub(var_price_mutated, var_net_price),
			var_key.clone(),
			var_rates_mutated.array_get(var_key),
			var_price_mutated.clone(),
		])
		var_taxes.array_get(var_key) = rt.add(var_taxes.array_get(var_key), var_tax_amount)
	}
	var_taxes = rt.call_function('array_map', [
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'round' }]),
		var_taxes.clone(),
	])
	return var_taxes.clone()
}

fn Class_WC_Tax.calc_exclusive_tax(var_price rt.PhpVal, var_rates rt.PhpVal) rt.PhpVal {
	mut var_price_mutated := var_price
	mut var_rates_mutated := var_rates
	mut var_taxes := rt.new_array()
	var_price_mutated = rt.new_float(var_price_mutated.to_f64())
	if !(!rt.is_true(var_rates_mutated)) {
		mut iter_5 := var_rates_mutated.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_rate := item_5.val
			mut var_key := item_5.key
			if rt.is_true(rt.identical(rt.new_string('yes'),
				var_rate.array_get(rt.new_string('compound'))))
			{
				continue
			}
			mut var_tax_amount :=
				rt.new_float(var_price_mutated * var_rate.array_get(rt.new_string('rate')).to_f64() / 100)
			var_tax_amount = rt.call_function('apply_filters', [
				rt.new_string('woocommerce_price_ex_tax_amount'),
				var_tax_amount.clone(),
				var_key.clone(),
				var_rate.clone(),
				var_price_mutated.clone(),
			])
			if !(var_taxes.array_isset(var_key)) {
				var_taxes.array_set(var_key, rt.new_float(var_tax_amount.to_f64()))
			} else {
				var_taxes.array_get(var_key) = rt.add(var_taxes.array_get(var_key),
					rt.new_float(var_tax_amount.to_f64()))
			}
		}
		mut var_pre_compound_total := rt.call_function('array_sum', [
			var_taxes.clone()])
		mut iter_6 := var_rates_mutated.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_rate := item_6.val
			mut var_key := item_6.key
			if rt.is_true(rt.identical(rt.new_string('no'),
				var_rate.array_get(rt.new_string('compound'))))
			{
				continue
			}
			mut var_the_price_inc_tax := rt.add(var_price_mutated, var_pre_compound_total)
			mut var_tax_amount :=
				rt.new_float(var_the_price_inc_tax * var_rate.array_get(rt.new_string('rate')).to_f64() / 100)
			var_tax_amount = rt.call_function('apply_filters', [
				rt.new_string('woocommerce_price_ex_tax_amount'),
				var_tax_amount.clone(),
				var_key.clone(),
				var_rate.clone(),
				var_price_mutated.clone(),
				var_the_price_inc_tax.clone(),
				var_pre_compound_total.clone(),
			])
			if !(var_taxes.array_isset(var_key)) {
				var_taxes.array_set(var_key, rt.new_float(var_tax_amount.to_f64()))
			} else {
				var_taxes.array_get(var_key) = rt.add(var_taxes.array_get(var_key),
					rt.new_float(var_tax_amount.to_f64()))
			}
			var_pre_compound_total = rt.call_function('array_sum', [
				var_taxes.clone()])
		}
	}
	var_taxes = rt.call_function('array_map', [
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'round' }]),
		var_taxes.clone(),
	])
	return var_taxes.clone()
}

fn Class_WC_Tax.find_rates(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'country', val: '' },
			rt.ArrayItem{ key: 'state', val: '' }, rt.ArrayItem{ key: 'city', val: '' },
			rt.ArrayItem{ key: 'postcode', val: '' }, rt.ArrayItem{ key: 'tax_class', val: '' }])])
	mut var_country := var_args_mutated.array_get(rt.new_string('country'))
	mut var_state := var_args_mutated.array_get(rt.new_string('state'))
	mut var_city := var_args_mutated.array_get(rt.new_string('city'))
	mut var_postcode := rt.call_function('wc_normalize_postcode', [
		rt.call_function('wc_clean', [var_args_mutated.array_get(rt.new_string('postcode'))]),
	])
	mut var_tax_class := var_args_mutated.array_get(rt.new_string('tax_class'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_country)))) {
		return rt.new_array()
	}
	mut iife_temp_1 := Class_WC_Cache_Helper{}
	mut iife_result_1 := iife_temp_1.get_cache_prefix(rt.new_string('taxes'))
	mut var_cache_key := rt.new_string(iife_result_1.str() + 'wc_tax_rates_' +
		md5.hexhash(rt.call_function('sprintf', [rt.new_string('%s+%s+%s+%s+%s'), var_country.clone(), var_state.clone(), var_city.clone(), var_postcode.clone(), var_tax_class.clone()]).to_string()))
	mut var_matched_tax_rates := rt.call_function('wp_cache_get', [
		var_cache_key.clone(), rt.new_string('taxes')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_matched_tax_rates)) {
		var_matched_tax_rates = Class_WC_Tax.get_matched_tax_rates(var_country.clone(),
			var_state.clone(), var_postcode.clone(), var_city.clone(), var_tax_class.clone())
		rt.call_function('wp_cache_set', [var_cache_key.clone(),
			var_matched_tax_rates.clone(), rt.new_string('taxes')])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_find_rates'),
		var_matched_tax_rates.clone(), var_args_mutated.clone()])
}

fn Class_WC_Tax.find_shipping_rates(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_rates := Class_WC_Tax.find_rates(var_args_mutated.clone())
	mut var_shipping_rates := rt.new_array()
	if rt.is_true(rt.new_bool(var_rates.clone().is_array())) {
		mut iter_7 := var_rates.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_rate := item_7.val
			mut var_key := item_7.key
			if rt.is_true(rt.identical(rt.new_string('yes'),
				var_rate.array_get(rt.new_string('shipping'))))
			{
				var_shipping_rates.array_set(var_key, var_rate.clone())
			}
		}
	}
	return var_shipping_rates.clone()
}

fn Class_WC_Tax.sort_rates_callback(var_rate1 rt.PhpVal, var_rate2 rt.PhpVal) i64 {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_rate1,
		'tax_rate_priority'), rt.get_property(var_rate2, 'tax_rate_priority')))))
	{
		return if rt.is_true(rt.less(rt.get_property(var_rate1, 'tax_rate_priority'), rt.get_property(var_rate2,
			'tax_rate_priority')))
		{
			-1
		} else {
			1
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_rate1,
		'tax_rate_country'), rt.get_property(var_rate2, 'tax_rate_country')))))
	{
		if rt.is_true(rt.identical(rt.new_string(''),
			rt.get_property(var_rate1, 'tax_rate_country')))
		{
			return 1
		}
		if rt.is_true(rt.identical(rt.new_string(''),
			rt.get_property(var_rate2, 'tax_rate_country')))
		{
			return -1
		}
		return if rt.is_true(rt.greater(rt.call_function('strcmp', [
			rt.get_property(var_rate1, 'tax_rate_country'),
			rt.get_property(var_rate2, 'tax_rate_country'),
		]), rt.new_int(0)))
		{ 1 } else { -1 }
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_rate1, 'tax_rate_state'), rt.get_property(var_rate2,
		'tax_rate_state')))))
	{
		if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_rate1, 'tax_rate_state'))) {
			return 1
		}
		if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_rate2, 'tax_rate_state'))) {
			return -1
		}
		return if rt.is_true(rt.greater(rt.call_function('strcmp', [
			rt.get_property(var_rate1, 'tax_rate_state'),
			rt.get_property(var_rate2, 'tax_rate_state'),
		]), rt.new_int(0)))
		{ 1 } else { -1 }
	}
	if !(rt.get_property(var_rate1, 'postcode_count')).is_null()
		&& !(rt.get_property(var_rate2, 'postcode_count')).is_null()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_rate1, 'postcode_count'), rt.get_property(var_rate2, 'postcode_count'))))) {
		return if rt.is_true(rt.less(rt.get_property(var_rate1, 'postcode_count'), rt.get_property(var_rate2,
			'postcode_count')))
		{
			1
		} else {
			-1
		}
	}
	if !(rt.get_property(var_rate1, 'city_count')).is_null()
		&& !(rt.get_property(var_rate2, 'city_count')).is_null()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_rate1, 'city_count'), rt.get_property(var_rate2, 'city_count'))))) {
		return if rt.is_true(rt.less(rt.get_property(var_rate1, 'city_count'), rt.get_property(var_rate2,
			'city_count')))
		{
			1
		} else {
			-1
		}
	}
	return if rt.is_true(rt.less(rt.get_property(var_rate1, 'tax_rate_id'), rt.get_property(var_rate2,
		'tax_rate_id')))
	{
		-1
	} else {
		1
	}
}

fn Class_WC_Tax.sort_rates(var_rates rt.PhpVal) rt.PhpVal {
	mut var_rates_mutated := var_rates
	rt.call_function('uasort', [var_rates_mutated.clone(),
		rt.new_string(@STRUCT + '::sort_rates_callback')])
	mut var_i := rt.new_int(0)
	mut iter_8 := var_rates_mutated.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_rate := item_8.val
		mut var_key := item_8.key
		rt.set_property(var_rates_mutated.array_get(var_key), 'tax_rate_order', rt.post_inc(var_i))
	}
	return var_rates_mutated.clone()
}

fn Class_WC_Tax.get_matched_tax_rates(var_country rt.PhpVal, var_state rt.PhpVal, var_postcode rt.PhpVal, var_city rt.PhpVal, var_tax_class rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_country_mutated := var_country
	mut var_state_mutated := var_state
	mut var_postcode_mutated := var_postcode
	mut var_city_mutated := var_city
	mut var_tax_class_mutated := var_tax_class
	mut var_criteria := rt.new_array()
	var_criteria << rt.call_method(var_wpdb, 'prepare', [
		rt.new_string("tax_rate_country IN ( %s, '' )"),
		rt.new_string(var_country_mutated.clone().to_string().to_upper()),
	])
	var_criteria << rt.call_method(var_wpdb, 'prepare', [
		rt.new_string("tax_rate_state IN ( %s, '' )"),
		rt.new_string(var_state_mutated.clone().to_string().to_upper()),
	])
	var_criteria << rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('tax_rate_class = %s'),
		rt.call_function('sanitize_title', [var_tax_class_mutated.clone()]),
	])
	mut var_postcode_search := rt.call_function('wc_get_wildcard_postcodes', [
		var_postcode_mutated.clone(), var_country_mutated.clone()])
	mut var_postcode_ranges := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('SELECT tax_rate_id, location_code FROM '), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string("woocommerce_tax_rate_locations WHERE location_type = 'postcode' AND location_code LIKE '%...%';")),
	])
	if rt.is_true(var_postcode_ranges) {
		mut var_matches := rt.call_function('wc_postcode_location_matcher', [
			var_postcode_mutated.clone(), var_postcode_ranges.clone(),
			rt.new_string('tax_rate_id'), rt.new_string('location_code'),
			var_country_mutated.clone()])
		if !(!rt.is_true(var_matches)) {
			mut iter_9 := var_matches.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_matched_postcodes := item_9.val
				var_postcode_search = rt.call_function('array_merge', [
					var_postcode_search.clone(), var_matched_postcodes.clone()])
			}
		}
	}
	var_postcode_search = rt.call_function('array_unique', [var_postcode_search.clone()])
	mut var_locations_criteria := rt.new_array()
	var_locations_criteria << 'locations.location_type IS NULL'
	var_locations_criteria <<
		"\n\t\t\tlocations.location_type = 'postcode' AND locations.location_code IN ('" + (rt.call_function('implode', [rt.new_string("','"), rt.call_function('array_map', [rt.new_string('esc_sql'), var_postcode_search.clone()])])).str() +
		"')\n\t\t\tAND (\n\t\t\t\t( locations2.location_type = 'city' AND locations2.location_code = '" + (rt.call_function('esc_sql', [rt.new_string(var_city_mutated.clone().to_string().to_upper())])).str() +
		rt.concat(rt.concat(rt.new_string("' )\n\t\t\t\tOR NOT EXISTS (\n\t\t\t\t\tSELECT sub.tax_rate_id FROM "), rt.get_property(var_wpdb, 'prefix')), rt.new_string("woocommerce_tax_rate_locations as sub\n\t\t\t\t\tWHERE sub.location_type = 'city'\n\t\t\t\t\tAND sub.tax_rate_id = tax_rates.tax_rate_id\n\t\t\t\t)\n\t\t\t)\n\t\t"))
	var_locations_criteria <<
		"\n\t\t\tlocations.location_type = 'city' AND locations.location_code = '" +
		(rt.call_function('esc_sql', [rt.new_string(var_city_mutated.clone().to_string().to_upper())])).str() +
		rt.concat(rt.concat(rt.new_string("'\n\t\t\tAND NOT EXISTS (\n\t\t\t\tSELECT sub.tax_rate_id FROM "), rt.get_property(var_wpdb, 'prefix')), rt.new_string("woocommerce_tax_rate_locations as sub\n\t\t\t\tWHERE sub.location_type = 'postcode'\n\t\t\t\tAND sub.tax_rate_id = tax_rates.tax_rate_id\n\t\t\t)\n\t\t"))
	var_criteria <<
		'( ( ' + (rt.call_function('implode', [rt.new_string(' ) OR ( '), rt.create_array_from_list(var_locations_criteria)])).str() +
		' ) )'
	mut var_criteria_string := rt.call_function('implode', [rt.new_string(' AND '),
		rt.create_array_from_list(var_criteria)])
	mut var_found_rates := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT tax_rates.*, COUNT( locations.location_id ) as postcode_count, COUNT( locations2.location_id ) as city_count\n\t\t\tFROM '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('woocommerce_tax_rates as tax_rates\n\t\t\tLEFT OUTER JOIN ')), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string('woocommerce_tax_rate_locations as locations ON tax_rates.tax_rate_id = locations.tax_rate_id\n\t\t\tLEFT OUTER JOIN ')), rt.get_property(var_wpdb,
			'prefix')),
			rt.new_string('woocommerce_tax_rate_locations as locations2 ON tax_rates.tax_rate_id = locations2.tax_rate_id\n\t\t\tWHERE 1=1 AND ')),
			var_criteria_string),
			rt.new_string('\n\t\t\tGROUP BY tax_rates.tax_rate_id\n\t\t\tORDER BY tax_rates.tax_rate_priority\n\t\t\t')),
	])
	var_found_rates = Class_WC_Tax.sort_rates(var_found_rates.clone())
	mut var_matched_tax_rates := rt.new_array()
	mut var_found_priority := rt.new_array()
	mut iter_10 := var_found_rates.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_found_rate := item_10.val
		if rt.is_true(rt.call_function('in_array', [
			rt.get_property(var_found_rate, 'tax_rate_priority'),
			rt.create_array_from_list(var_found_priority),
			rt.new_bool(true),
		]))
		{
			continue
		}
		var_matched_tax_rates.array_set(rt.get_property(var_found_rate, 'tax_rate_id'), rt.create_array([
			rt.ArrayItem{ key: 'rate', val: rt.new_float((rt.get_property(var_found_rate,
				'tax_rate')).to_f64()) },
			rt.ArrayItem{ key: 'label', val: rt.get_property(var_found_rate, 'tax_rate_name') },
			rt.ArrayItem{
				key: 'shipping'
				val: if rt.is_true(rt.get_property(var_found_rate, 'tax_rate_shipping')) {
					'yes'
				} else {
					'no'
				}
			},
			rt.ArrayItem{
				key: 'compound'
				val: if rt.is_true(rt.get_property(var_found_rate, 'tax_rate_compound')) {
					'yes'
				} else {
					'no'
				}
			},
		]))
		var_found_priority << rt.get_property(var_found_rate, 'tax_rate_priority')
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_matched_tax_rates'),
		var_matched_tax_rates.clone(),
		var_country_mutated.clone(),
		var_state_mutated.clone(),
		var_postcode_mutated.clone(),
		var_city_mutated.clone(),
		var_tax_class_mutated.clone(),
	])
}

fn Class_WC_Tax.get_tax_location(tax_class string, var_customer rt.PhpVal) rt.PhpVal {
	mut tax_class_mutated := tax_class
	mut var_customer_mutated := var_customer
	mut var_location := rt.new_array()
	if var_customer_mutated.clone().is_null()
		&& rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer')) {
		var_customer_mutated = rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer')
	}
	if !(!rt.is_true(var_customer_mutated)) {
		var_location = rt.call_method(var_customer_mutated, 'get_taxable_address', []rt.PhpVal{})
	} else if rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{}))
		|| rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.base(), rt.call_function('get_option', [rt.new_string('woocommerce_default_customer_address')])))
		|| rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_TaxBasedOn.base(), rt.call_function('get_option', [rt.new_string('woocommerce_tax_based_on')]))) {
		var_location = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_base_state', []rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_base_postcode', []rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_base_city', []rt.PhpVal{}) },
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_tax_location'),
		var_location.clone(),
		rt.new_string(tax_class_mutated).clone(),
		var_customer_mutated.clone(),
	])
}

fn Class_WC_Tax.get_rates(tax_class string, var_customer rt.PhpVal) rt.PhpVal {
	mut tax_class_mutated := tax_class
	mut var_customer_mutated := var_customer
	tax_class_mutated = (rt.call_function('sanitize_title', [
		rt.new_string(tax_class_mutated).clone()])).str()
	mut var_location := Class_WC_Tax.get_tax_location(tax_class_mutated,
		var_customer_mutated.clone())
	return Class_WC_Tax.get_rates_from_location(rt.new_string(tax_class_mutated),
		var_location.clone(), var_customer_mutated.clone())
}

fn Class_WC_Tax.get_rates_from_location(var_tax_class rt.PhpVal, var_location rt.PhpVal, var_customer rt.PhpVal) rt.PhpVal {
	mut var_country := rt.new_null()
	mut var_state := rt.new_null()
	mut var_postcode := rt.new_null()
	mut var_city := rt.new_null()
	mut var_tax_class_mutated := var_tax_class
	mut var_location_mutated := var_location
	mut var_customer_mutated := var_customer
	var_tax_class_mutated = rt.call_function('sanitize_title', [
		var_tax_class_mutated.clone()])
	mut var_matched_tax_rates := rt.new_array()
	if var_location_mutated.clone().array_count() == 4 {
		mut list_tmp_1 := var_location_mutated
		var_country = list_tmp_1.array_get(0)
		var_state = list_tmp_1.array_get(1)
		var_postcode = list_tmp_1.array_get(2)
		var_city = list_tmp_1.array_get(3)
		var_matched_tax_rates = Class_WC_Tax.find_rates(rt.create_array([
			rt.ArrayItem{ key: 'country', val: var_country },
			rt.ArrayItem{ key: 'state', val: var_state },
			rt.ArrayItem{ key: 'postcode', val: var_postcode },
			rt.ArrayItem{ key: 'city', val: var_city },
			rt.ArrayItem{ key: 'tax_class', val: var_tax_class_mutated },
		]))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_matched_rates'),
		var_matched_tax_rates.clone(), var_tax_class_mutated.clone(),
		var_customer_mutated.clone()])
}

fn Class_WC_Tax.get_base_tax_rates(tax_class string) rt.PhpVal {
	mut tax_class_mutated := tax_class
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_base_tax_rates'),
		Class_WC_Tax.find_rates(rt.create_array([
			rt.ArrayItem{ key: 'country', val: rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'state', val: rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_base_state', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'postcode', val: rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_base_postcode', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'city', val: rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_base_city', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'tax_class', val: tax_class_mutated },
		])),
		rt.new_string(tax_class_mutated).clone(),
	])
}

fn Class_WC_Tax.get_shop_base_rate(tax_class string) rt.PhpVal {
	mut tax_class_mutated := tax_class
	return Class_WC_Tax.get_base_tax_rates(tax_class_mutated)
}

fn Class_WC_Tax.get_shipping_tax_rates(var_tax_class rt.PhpVal, var_customer rt.PhpVal) rt.PhpVal {
	mut var_country := rt.new_null()
	mut var_state := rt.new_null()
	mut var_postcode := rt.new_null()
	mut var_city := rt.new_null()
	mut var_tax_class_mutated := var_tax_class
	mut var_customer_mutated := var_customer
	mut var_shipping_tax_class := rt.call_function('get_option', [
		rt.new_string('woocommerce_shipping_tax_class'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('inherit'),
		var_shipping_tax_class))))
	{
		var_tax_class_mutated = var_shipping_tax_class.clone()
	}
	if rt.is_true(rt.new_bool(var_tax_class_mutated.clone().is_null())) {
		var_tax_class_mutated = Class_WC_Tax.get_shipping_tax_class_from_cart_items()
	}
	if rt.is_true(rt.new_bool(var_tax_class_mutated.clone().is_null())) {
		return rt.new_array()
	}
	mut var_location := Class_WC_Tax.get_tax_location(var_tax_class_mutated.str(),
		var_customer_mutated.clone())
	mut var_cart := if !(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')).is_null() {
		rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')
	} else {
		rt.new_null()
	}
	var_tax_class_mutated = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_tax_class'),
		var_tax_class_mutated.clone(),
		var_cart.clone(),
		var_customer_mutated.clone(),
		var_location.clone(),
	])
	if rt.is_true(rt.new_bool(var_tax_class_mutated.clone().is_null())) {
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(4 != var_location.clone().array_count())) {
		return rt.new_array()
	}
	mut list_tmp_2 := var_location
	var_country = list_tmp_2.array_get(0)
	var_state = list_tmp_2.array_get(1)
	var_postcode = list_tmp_2.array_get(2)
	var_city = list_tmp_2.array_get(3)
	return Class_WC_Tax.find_shipping_rates(rt.create_array([
		rt.ArrayItem{ key: 'country', val: var_country },
		rt.ArrayItem{ key: 'state', val: var_state },
		rt.ArrayItem{ key: 'postcode', val: var_postcode },
		rt.ArrayItem{ key: 'city', val: var_city },
		rt.ArrayItem{ key: 'tax_class', val: var_tax_class_mutated },
	]))
}

fn Class_WC_Tax.get_shipping_tax_class_from_cart_items() rt.PhpVal {
	mut var_standard_tax_class := rt.new_string('')
	mut var_cart := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_cart, 'get_cart', []rt.PhpVal{}))))) {
		return var_standard_tax_class.clone()
	}
	mut var_cart_tax_classes := rt.call_method(var_cart, 'get_cart_item_tax_classes_for_shipping',
		[]rt.PhpVal{})
	if !rt.is_true(var_cart_tax_classes) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('in_array', [var_standard_tax_class.clone(),
		var_cart_tax_classes.clone(), rt.new_bool(true)]))
	{
		return var_standard_tax_class.clone()
	}
	if 1 == var_cart_tax_classes.clone().array_count() {
		return rt.call_function('reset', [var_cart_tax_classes.clone()])
	}
	mut var_tax_class_slugs := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_tax_class_slugs)) {
		var_tax_class_slugs = Class_WC_Tax.get_tax_class_slugs()
	}
	mut iter_11 := var_tax_class_slugs.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_tax_class_slug := item_11.val
		if rt.is_true(rt.call_function('in_array', [var_tax_class_slug.clone(),
			var_cart_tax_classes.clone(), rt.new_bool(true)]))
		{
			return var_tax_class_slug.clone()
		}
	}
	return var_standard_tax_class.clone()
}

fn Class_WC_Tax.is_compound(var_key_or_rate rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(var_key_or_rate.clone().is_object())) {
		mut var_key := rt.get_property(var_key_or_rate, 'tax_rate_id')
		mut var_compound := rt.get_property(var_key_or_rate, 'tax_rate_compound')
	} else {
		var_key = var_key_or_rate
		var_compound = rt.new_bool((rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT tax_rate_compound FROM '), rt.get_property(var_wpdb,
					'prefix')), rt.new_string('woocommerce_tax_rates WHERE tax_rate_id = %s')),
				var_key.clone(),
			]),
		])).to_bool())
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rate_compound'),
		var_compound.clone(),
		var_key.clone(),
	])).to_bool()
}

fn Class_WC_Tax.get_rate_label(var_key_or_rate rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(var_key_or_rate.clone().is_object())) {
		mut var_key := rt.get_property(var_key_or_rate, 'tax_rate_id')
		mut var_rate_name := rt.get_property(var_key_or_rate, 'tax_rate_name')
	} else {
		var_key = var_key_or_rate
		var_rate_name = rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT tax_rate_name FROM '), rt.get_property(var_wpdb,
					'prefix')), rt.new_string('woocommerce_tax_rates WHERE tax_rate_id = %s')),
				var_key.clone(),
			]),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_rate_name)))) {
		var_rate_name = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'countries'), 'tax_or_vat', []rt.PhpVal{})
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rate_label'),
		var_rate_name.clone(), var_key.clone()])
}

fn Class_WC_Tax.get_rate_percent(var_key_or_rate rt.PhpVal) rt.PhpVal {
	mut var_rate_percent_value := Class_WC_Tax.get_rate_percent_value(var_key_or_rate.clone())
	mut var_tax_rate_id := if var_key_or_rate.clone().is_object() {
		rt.get_property(var_key_or_rate, 'tax_rate_id')
	} else {
		var_key_or_rate
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rate_percent'),
		rt.new_string(var_rate_percent_value.str() + '%'), var_tax_rate_id.clone()])
}

fn Class_WC_Tax.get_rate_percent_value(var_key_or_rate rt.PhpVal) f64 {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(var_key_or_rate.clone().is_object())) {
		mut var_tax_rate := rt.get_property(var_key_or_rate, 'tax_rate')
	} else {
		mut var_key := var_key_or_rate
		var_tax_rate = rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT tax_rate FROM '), rt.get_property(var_wpdb,
					'prefix')), rt.new_string('woocommerce_tax_rates WHERE tax_rate_id = %s')),
				var_key.clone(),
			]),
		])
	}
	return var_tax_rate.clone().to_f64()
}

fn Class_WC_Tax.get_rate_code(var_key_or_rate rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(var_key_or_rate.clone().is_object())) {
		mut var_key := rt.get_property(var_key_or_rate, 'tax_rate_id')
		mut var_rate := var_key_or_rate
	} else {
		var_key = var_key_or_rate
		var_rate = rt.call_method(var_wpdb, 'get_row', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT tax_rate_country, tax_rate_state, tax_rate_name, tax_rate_priority FROM '), rt.get_property(var_wpdb,
					'prefix')), rt.new_string('woocommerce_tax_rates WHERE tax_rate_id = %s')),
				var_key.clone(),
			]),
		])
	}
	mut var_code_string := rt.new_string('')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_rate)))) {
		mut var_code := rt.new_array()
		var_code << rt.get_property(var_rate, 'tax_rate_country')
		var_code << rt.get_property(var_rate, 'tax_rate_state')
		var_code << if rt.is_true(rt.get_property(var_rate, 'tax_rate_name')) {
			rt.get_property(var_rate, 'tax_rate_name')
		} else {
			rt.new_string('TAX')
		}
		var_code << rt.call_function('absint', [
			rt.get_property(var_rate, 'tax_rate_priority'),
		])
		var_code_string = rt.new_string(rt.call_function('implode', [
			rt.new_string('-'), rt.call_function('array_filter', [
				rt.create_array_from_list(var_code),
			])]).to_string().to_upper())
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rate_code'),
		var_code_string.clone(), var_key.clone()])
}

fn Class_WC_Tax.get_tax_total(var_taxes rt.PhpVal) rt.PhpVal {
	mut var_taxes_mutated := var_taxes
	return rt.call_function('array_sum', [var_taxes_mutated.clone()])
}

fn Class_WC_Tax.get_tax_rate_classes() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_cache_key := rt.new_string('tax-rate-classes')
	mut var_tax_rate_classes := rt.call_function('wp_cache_get', [
		var_cache_key.clone(), rt.new_string('taxes')])
	if !(var_tax_rate_classes.clone().is_array()) {
		var_tax_rate_classes = rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT * FROM '), rt.get_property(var_wpdb,
				'wc_tax_rate_classes')), rt.new_string(' ORDER BY name;\n\t\t\t\t')),
		])
		rt.call_function('wp_cache_set', [var_cache_key.clone(),
			var_tax_rate_classes.clone(), rt.new_string('taxes')])
	}
	return var_tax_rate_classes.clone()
}

fn Class_WC_Tax.get_tax_classes() rt.PhpVal {
	return rt.call_function('wp_list_pluck', [Class_WC_Tax.get_tax_rate_classes(),
		rt.new_string('name')])
}

fn Class_WC_Tax.get_tax_class_slugs() rt.PhpVal {
	return rt.call_function('wp_list_pluck', [Class_WC_Tax.get_tax_rate_classes(),
		rt.new_string('slug')])
}

fn Class_WC_Tax.create_tax_class(var_name rt.PhpVal, slug string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_name_mutated := var_name
	mut slug_mutated := slug
	if !rt.is_true(var_name_mutated) {
		return create_wp_error(rt.new_string('tax_class_invalid_name'), rt.call_function('__', [
			rt.new_string('Tax class requires a valid name'),
			rt.new_string('woocommerce'),
		]))
	}
	mut var_existing := Class_WC_Tax.get_tax_classes()
	mut var_existing_slugs := Class_WC_Tax.get_tax_class_slugs()
	var_name_mutated = rt.call_function('wc_clean', [var_name_mutated.clone()])
	if rt.is_true(rt.call_function('in_array', [var_name_mutated.clone(),
		var_existing.clone(), rt.new_bool(true)]))
	{
		return create_wp_error(rt.new_string('tax_class_exists'), rt.call_function('__', [
			rt.new_string('Tax class already exists'),
			rt.new_string('woocommerce'),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(slug_mutated))))) {
		slug_mutated = (rt.call_function('sanitize_title', [var_name_mutated.clone()])).str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(slug_mutated))))) {
		return create_wp_error(rt.new_string('tax_class_slug_invalid'), rt.call_function('__', [
			rt.new_string('Tax class slug is invalid'),
			rt.new_string('woocommerce'),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string(slug_mutated).clone(),
		var_existing_slugs.clone(), rt.new_bool(true)]))
	{
		return create_wp_error(rt.new_string('tax_class_slug_exists'), rt.call_function('__', [
			rt.new_string('Tax class slug already exists'),
			rt.new_string('woocommerce'),
		]))
	}
	mut var_insert := rt.call_method(var_wpdb, 'insert', [
		rt.get_property(var_wpdb, 'wc_tax_rate_classes'),
		rt.create_array([rt.ArrayItem{ key: 'name', val: var_name_mutated },
			rt.ArrayItem{ key: 'slug', val: slug_mutated }]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_insert.clone()])) {
		return create_wp_error(rt.new_string('tax_class_insert_error'), rt.call_method(var_insert,
			'get_error_message', []rt.PhpVal{}))
	}
	rt.call_function('wp_cache_delete', [rt.new_string('tax-rate-classes'),
		rt.new_string('taxes')])
	return rt.create_array([rt.ArrayItem{ key: 'name', val: var_name_mutated },
		rt.ArrayItem{ key: 'slug', val: slug_mutated }])
}

fn Class_WC_Tax.get_tax_class_by(var_field rt.PhpVal, var_item rt.PhpVal) rt.PhpVal {
	mut var_field_mutated := var_field
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_field_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'slug' }]),
		rt.new_bool(true)])))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_field'), rt.call_function('__', [
			rt.new_string('Invalid field'),
			rt.new_string('woocommerce'),
		])))
	}
	if rt.is_true(rt.identical(rt.new_string('id'), var_field_mutated)) {
		var_field_mutated = rt.new_string('tax_rate_class_id')
	}
	mut var_matches := rt.call_function('wp_list_filter', [
		Class_WC_Tax.get_tax_rate_classes(),
		rt.create_array([rt.ArrayItem{ key: var_field_mutated, val: var_item }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_matches)))) {
		return rt.new_bool(false)
	}
	mut var_tax_class := rt.call_function('current', [var_matches.clone()])
	return rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.get_property(var_tax_class, 'name') },
		rt.ArrayItem{ key: 'slug', val: rt.get_property(var_tax_class, 'slug') },
	])
}

fn Class_WC_Tax.delete_tax_class_by(var_field rt.PhpVal, var_item rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_field_mutated := var_field
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_field_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'slug' }]),
		rt.new_bool(true)])))))
	{
		return (create_wp_error(rt.new_string('invalid_field'), rt.call_function('__', [
			rt.new_string('Invalid field'),
			rt.new_string('woocommerce'),
		]))).to_bool()
	}
	mut var_tax_class := Class_WC_Tax.get_tax_class_by(var_field_mutated.clone(), var_item.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tax_class)))) {
		return (create_wp_error(rt.new_string('invalid_tax_class'), rt.call_function('__', [
			rt.new_string('Invalid tax class'),
			rt.new_string('woocommerce'),
		]))).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('id'), var_field_mutated)) {
		var_field_mutated = rt.new_string('tax_rate_class_id')
	}
	mut var_delete := rt.call_method(var_wpdb, 'delete', [
		rt.get_property(var_wpdb, 'wc_tax_rate_classes'),
		rt.create_array([rt.ArrayItem{ key: var_field_mutated, val: var_item }]),
	])
	if rt.is_true(var_delete) {
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
					'prefix')), rt.new_string('woocommerce_tax_rates WHERE tax_rate_class = %s;')),
				var_tax_class.array_get(rt.new_string('slug')),
			]),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE locations FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_tax_rate_locations locations LEFT JOIN ')), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string('woocommerce_tax_rates rates ON rates.tax_rate_id = locations.tax_rate_id WHERE rates.tax_rate_id IS NULL;')),
		])
	}
	rt.call_function('wp_cache_delete', [rt.new_string('tax-rate-classes'),
		rt.new_string('taxes')])
	mut iife_temp_2 := Class_WC_Cache_Helper{}
	mut iife_result_2 := iife_temp_2.invalidate_cache_group(rt.new_string('taxes'))
	return var_delete.to_bool()
}

fn Class_WC_Tax.format_tax_rate_city(var_city rt.PhpVal) string {
	mut var_city_mutated := var_city
	return var_city_mutated.clone().to_string().trim_space().to_upper()
}

fn Class_WC_Tax.format_tax_rate_state(var_state rt.PhpVal) rt.PhpVal {
	mut var_state_mutated := var_state
	var_state_mutated = rt.new_string(var_state_mutated.clone().to_string().to_upper())
	return if rt.is_true(rt.identical(rt.new_string('*'), var_state_mutated)) {
		rt.new_string('')
	} else {
		var_state_mutated
	}
}

fn Class_WC_Tax.format_tax_rate_country(var_country rt.PhpVal) rt.PhpVal {
	mut var_country_mutated := var_country
	var_country_mutated = rt.new_string(var_country_mutated.clone().to_string().to_upper())
	return if rt.is_true(rt.identical(rt.new_string('*'), var_country_mutated)) {
		rt.new_string('')
	} else {
		var_country_mutated
	}
}

fn Class_WC_Tax.format_tax_rate_name(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
	return if rt.is_true(var_name_mutated) { var_name_mutated } else { rt.call_function('__', [
			rt.new_string('Tax'),
			rt.new_string('woocommerce'),
		]) }
}

fn Class_WC_Tax.format_tax_rate(var_rate rt.PhpVal) rt.PhpVal {
	mut var_rate_mutated := var_rate
	return rt.call_function('number_format', [rt.new_float(var_rate_mutated.to_f64()),
		rt.new_int(4), rt.new_string('.'), rt.new_string('')])
}

fn Class_WC_Tax.format_tax_rate_priority(var_priority rt.PhpVal) rt.PhpVal {
	return rt.call_function('absint', [var_priority.clone()])
}

fn Class_WC_Tax.format_tax_rate_class(var_class rt.PhpVal) rt.PhpVal {
	mut var_class_mutated := var_class
	var_class_mutated = rt.call_function('sanitize_title', [var_class_mutated.clone()])
	mut var_classes := Class_WC_Tax.get_tax_class_slugs()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_class_mutated.clone(), var_classes.clone(), rt.new_bool(true)])))))
	{
		var_class_mutated = rt.new_string('')
	}
	return if rt.is_true(rt.identical(rt.new_string('standard'), var_class_mutated)) {
		rt.new_string('')
	} else {
		var_class_mutated
	}
}

fn Class_WC_Tax.prepare_tax_rate(var_tax_rate rt.PhpVal) rt.PhpVal {
	mut var_tax_rate_mutated := var_tax_rate
	mut iter_12 := var_tax_rate_mutated.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_value := item_12.val
		mut var_key := item_12.key
		if rt.is_true(rt.call_function('method_exists', [rt.new_string(@STRUCT),
			rt.new_string('format_' + var_key.str())]))
		{
			if rt.is_true(rt.identical(rt.new_string('tax_rate_state'), var_key)) {
				var_tax_rate_mutated.array_set(var_key, rt.call_function('call_user_func', [
					rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
						rt.ArrayItem{ key: none, val: 'format_' + var_key.str() }]),
					rt.call_function('sanitize_key', [var_value.clone()]),
				]))
			} else {
				var_tax_rate_mutated.array_set(var_key, rt.call_function('call_user_func', [
					rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
						rt.ArrayItem{ key: none, val: 'format_' + var_key.str() }]),
					var_value.clone(),
				]))
			}
		}
	}
	return var_tax_rate_mutated.clone()
}

fn Class_WC_Tax._insert_tax_rate(var_tax_rate rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_tax_rate_mutated := var_tax_rate
	rt.call_method(var_wpdb, 'insert', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_tax_rates'),
		Class_WC_Tax.prepare_tax_rate(var_tax_rate_mutated.clone()),
	])
	mut var_tax_rate_id := rt.get_property(var_wpdb, 'insert_id')
	mut iife_temp_3 := Class_WC_Cache_Helper{}
	mut iife_result_3 := iife_temp_3.invalidate_cache_group(rt.new_string('taxes'))
	rt.call_function('do_action', [rt.new_string('woocommerce_tax_rate_added'),
		var_tax_rate_id.clone(), var_tax_rate_mutated.clone()])
	return var_tax_rate_id.clone()
}

fn Class_WC_Tax._get_tax_rate(var_tax_rate_id rt.PhpVal, var_output_type rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_tax_rate_id_mutated := var_tax_rate_id
	return rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tSELECT *\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string('woocommerce_tax_rates\n\t\t\t\t\tWHERE tax_rate_id = %d\n\t\t\t\t')),
			var_tax_rate_id_mutated.clone(),
		]),
		var_output_type.clone(),
	])
}

fn Class_WC_Tax._update_tax_rate(var_tax_rate_id rt.PhpVal, var_tax_rate rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_tax_rate_id_mutated := var_tax_rate_id
	mut var_tax_rate_mutated := var_tax_rate
	var_tax_rate_id_mutated = rt.call_function('absint', [var_tax_rate_id_mutated.clone()])
	rt.call_method(var_wpdb, 'update', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_tax_rates'),
		Class_WC_Tax.prepare_tax_rate(var_tax_rate_mutated.clone()),
		rt.create_array([
			rt.ArrayItem{ key: 'tax_rate_id', val: var_tax_rate_id_mutated },
		]),
	])
	mut iife_temp_4 := Class_WC_Cache_Helper{}
	mut iife_result_4 := iife_temp_4.invalidate_cache_group(rt.new_string('taxes'))
	rt.call_function('do_action', [rt.new_string('woocommerce_tax_rate_updated'),
		var_tax_rate_id_mutated.clone(), var_tax_rate_mutated.clone()])
}

fn Class_WC_Tax._delete_tax_rate(var_tax_rate_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_tax_rate_id_mutated := var_tax_rate_id
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_tax_rate_locations WHERE tax_rate_id = %d;')),
			var_tax_rate_id_mutated.clone(),
		]),
	])
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_tax_rates WHERE tax_rate_id = %d;')),
			var_tax_rate_id_mutated.clone(),
		]),
	])
	mut iife_temp_5 := Class_WC_Cache_Helper{}
	mut iife_result_5 := iife_temp_5.invalidate_cache_group(rt.new_string('taxes'))
	rt.call_function('do_action', [rt.new_string('woocommerce_tax_rate_deleted'),
		var_tax_rate_id_mutated.clone()])
}

fn Class_WC_Tax._update_tax_rate_postcodes(var_tax_rate_id rt.PhpVal, var_postcodes rt.PhpVal) {
	mut var_tax_rate_id_mutated := var_tax_rate_id
	mut var_postcodes_mutated := var_postcodes
	if !(var_postcodes_mutated.clone().is_array()) {
		var_postcodes_mutated = rt.call_function('explode', [
			rt.new_string(';'), var_postcodes_mutated.clone()])
	}
	mut iter_13 := var_postcodes_mutated.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_postcode := item_13.val
		mut var_key := item_13.key
		var_postcodes_mutated.array_set(var_key, rt.call_function('str_replace', [
			rt.new_string((rt.call_function('chr', [rt.new_int(226)])).str() +
				(rt.call_function('chr', [rt.new_int(128)])).str() +
				(rt.call_function('chr', [rt.new_int(166)])).str()),
			rt.new_string('...'),
			var_postcode.clone(),
		]).to_string().trim_space().to_upper())
	}
	Class_WC_Tax.update_tax_rate_locations(var_tax_rate_id_mutated.clone(), rt.call_function('array_diff', [
		rt.call_function('array_filter', [var_postcodes_mutated.clone()]),
		rt.create_array([rt.ArrayItem{ key: none, val: '*' }]),
	]), rt.new_string('postcode'))
}

fn Class_WC_Tax._update_tax_rate_cities(var_tax_rate_id rt.PhpVal, var_cities rt.PhpVal) {
	mut var_tax_rate_id_mutated := var_tax_rate_id
	mut var_cities_mutated := var_cities
	if !(var_cities_mutated.clone().is_array()) {
		var_cities_mutated = rt.call_function('explode', [rt.new_string(';'),
			var_cities_mutated.clone()])
	}
	var_cities_mutated = rt.call_function('array_filter', [
		rt.call_function('array_diff', [
			rt.call_function('array_map', [
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'format_tax_rate_city' }]),
				var_cities_mutated.clone(),
			]),
			rt.create_array([
				rt.ArrayItem{ key: none, val: '*' },
			]),
		]),
	])
	Class_WC_Tax.update_tax_rate_locations(var_tax_rate_id_mutated.clone(),
		var_cities_mutated.clone(), rt.new_string('city'))
}

fn Class_WC_Tax.update_tax_rate_locations(var_tax_rate_id rt.PhpVal, var_values rt.PhpVal, var_type rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_tax_rate_id_mutated := var_tax_rate_id
	var_tax_rate_id_mutated = rt.call_function('absint', [var_tax_rate_id_mutated.clone()])
	rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_tax_rate_locations WHERE tax_rate_id = %d AND location_type = %s;')),
			var_tax_rate_id_mutated.clone(),
			var_type.clone(),
		]),
	])
	if var_values.clone().array_count() > 0 {
		mut var_sql := rt.new_string("( '" +
			(rt.call_function('implode', [rt.new_string("', ${var_tax_rate_id.to_string()}, '" + (rt.call_function('esc_sql', [var_type.clone()])).str() +
			"' ),( '"), rt.call_function('array_map', [rt.new_string('esc_sql'), var_values.clone()])])).str() +
			"', ${var_tax_rate_id.to_string()}, '" +
			(rt.call_function('esc_sql', [var_type.clone()])).str() + "' )")
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string('woocommerce_tax_rate_locations ( location_code, tax_rate_id, location_type ) VALUES ')),
				var_sql), rt.new_string(';')),
		])
	}
	mut iife_temp_6 := Class_WC_Cache_Helper{}
	mut iife_result_6 := iife_temp_6.invalidate_cache_group(rt.new_string('taxes'))
}

fn Class_WC_Tax.get_rates_for_tax_class(var_tax_class rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_tax_class_mutated := var_tax_class
	var_tax_class_mutated = Class_WC_Tax.format_tax_rate_class(var_tax_class_mutated.clone())
	mut var_rates := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM `'), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_tax_rates` WHERE `tax_rate_class` = %s;')),
			var_tax_class_mutated.clone(),
		]),
	])
	mut var_locations := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('SELECT * FROM `'), rt.get_property(var_wpdb, 'prefix')),
			rt.new_string('woocommerce_tax_rate_locations`')),
	])
	if !(!rt.is_true(var_rates)) {
		var_rates = rt.call_function('array_combine', [
			rt.call_function('wp_list_pluck', [var_rates.clone(),
				rt.new_string('tax_rate_id')]),
			var_rates.clone(),
		])
	}
	mut iter_14 := var_locations.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_location := item_14.val
		if !(var_rates.array_isset(rt.get_property(var_location, 'tax_rate_id'))) {
			continue
		}
		if !(!(rt.get_property(var_rates.array_get(rt.get_property(var_location, 'tax_rate_id')),
			'{"nodeType":"Expr_PropertyFetch","line":1286,"var":{"nodeType":"Expr_Variable","line":1286,"name":"location"},"name":"location_type"}')).is_null()) {
			rt.set_property(var_rates.array_get(rt.get_property(var_location, 'tax_rate_id')),
				'{"nodeType":"Expr_PropertyFetch","line":1287,"var":{"nodeType":"Expr_Variable","line":1287,"name":"location"},"name":"location_type"}',
				rt.new_array())
		}
		rt.get_property(var_rates.array_get(rt.get_property(var_location, 'tax_rate_id')),
			'{"nodeType":"Expr_PropertyFetch","line":1289,"var":{"nodeType":"Expr_Variable","line":1289,"name":"location"},"name":"location_type"}').array_push(rt.get_property(var_location,
			'location_code'))
	}
	mut iter_15 := var_rates.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_rate := item_15.val
		mut var_rate_id := item_15.key
		rt.set_property(var_rates.array_get(var_rate_id), 'postcode_count', if !(rt.get_property(var_rates.array_get(var_rate_id),
			'postcode')).is_null() {
			rt.get_property(var_rates.array_get(var_rate_id), 'postcode').array_count()
		} else {
			0
		})
		rt.set_property(var_rates.array_get(var_rate_id), 'city_count', if !(rt.get_property(var_rates.array_get(var_rate_id),
			'city')).is_null() {
			rt.get_property(var_rates.array_get(var_rate_id), 'city').array_count()
		} else {
			0
		})
	}
	var_rates = Class_WC_Tax.sort_rates(var_rates.clone())
	return var_rates.clone()
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Tax.init()
			return rt.new_null()
		}
		'maybe_remove_tax_class_rates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Tax.maybe_remove_tax_class_rates(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'calc_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return Class_WC_Tax.calc_tax(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'calc_shipping_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Tax.calc_shipping_tax(dispatch_arg_0, dispatch_arg_1)
		}
		'round' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.round(dispatch_arg_0)
		}
		'calc_inclusive_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Tax.calc_inclusive_tax(dispatch_arg_0, dispatch_arg_1)
		}
		'calc_exclusive_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Tax.calc_exclusive_tax(dispatch_arg_0, dispatch_arg_1)
		}
		'find_rates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.find_rates(dispatch_arg_0)
		}
		'find_shipping_rates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.find_shipping_rates(dispatch_arg_0)
		}
		'sort_rates_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(Class_WC_Tax.sort_rates_callback(dispatch_arg_0, dispatch_arg_1))
		}
		'sort_rates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.sort_rates(dispatch_arg_0)
		}
		'get_matched_tax_rates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return Class_WC_Tax.get_matched_tax_rates(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'get_tax_location' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Tax.get_tax_location(dispatch_arg_0, dispatch_arg_1)
		}
		'get_rates' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Tax.get_rates(dispatch_arg_0, dispatch_arg_1)
		}
		'get_rates_from_location' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_Tax.get_rates_from_location(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'get_base_tax_rates' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_Tax.get_base_tax_rates(dispatch_arg_0)
		}
		'get_shop_base_rate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_Tax.get_shop_base_rate(dispatch_arg_0)
		}
		'get_shipping_tax_rates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Tax.get_shipping_tax_rates(dispatch_arg_0, dispatch_arg_1)
		}
		'get_shipping_tax_class_from_cart_items' {
			return Class_WC_Tax.get_shipping_tax_class_from_cart_items()
		}
		'is_compound' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Tax.is_compound(dispatch_arg_0))
		}
		'get_rate_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.get_rate_label(dispatch_arg_0)
		}
		'get_rate_percent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.get_rate_percent(dispatch_arg_0)
		}
		'get_rate_percent_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_float(Class_WC_Tax.get_rate_percent_value(dispatch_arg_0))
		}
		'get_rate_code' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.get_rate_code(dispatch_arg_0)
		}
		'get_tax_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.get_tax_total(dispatch_arg_0)
		}
		'get_tax_rate_classes' {
			return Class_WC_Tax.get_tax_rate_classes()
		}
		'get_tax_classes' {
			return Class_WC_Tax.get_tax_classes()
		}
		'get_tax_class_slugs' {
			return Class_WC_Tax.get_tax_class_slugs()
		}
		'create_tax_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WC_Tax.create_tax_class(dispatch_arg_0, dispatch_arg_1)
		}
		'get_tax_class_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Tax.get_tax_class_by(dispatch_arg_0, dispatch_arg_1)
		}
		'delete_tax_class_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Tax.delete_tax_class_by(dispatch_arg_0, dispatch_arg_1))
		}
		'format_tax_rate_city' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Tax.format_tax_rate_city(dispatch_arg_0))
		}
		'format_tax_rate_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.format_tax_rate_state(dispatch_arg_0)
		}
		'format_tax_rate_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.format_tax_rate_country(dispatch_arg_0)
		}
		'format_tax_rate_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.format_tax_rate_name(dispatch_arg_0)
		}
		'format_tax_rate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.format_tax_rate(dispatch_arg_0)
		}
		'format_tax_rate_priority' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.format_tax_rate_priority(dispatch_arg_0)
		}
		'format_tax_rate_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.format_tax_rate_class(dispatch_arg_0)
		}
		'prepare_tax_rate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.prepare_tax_rate(dispatch_arg_0)
		}
		'_insert_tax_rate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax._insert_tax_rate(dispatch_arg_0)
		}
		'_get_tax_rate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Tax._get_tax_rate(dispatch_arg_0, dispatch_arg_1)
		}
		'_update_tax_rate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Tax._update_tax_rate(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'_delete_tax_rate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Tax._delete_tax_rate(dispatch_arg_0)
			return rt.new_null()
		}
		'_update_tax_rate_postcodes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Tax._update_tax_rate_postcodes(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'_update_tax_rate_cities' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Tax._update_tax_rate_cities(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_tax_rate_locations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WC_Tax.update_tax_rate_locations(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_rates_for_tax_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tax.get_rates_for_tax_class(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	Class_WC_Tax.init()
}
