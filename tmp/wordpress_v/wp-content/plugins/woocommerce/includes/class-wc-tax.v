import rt
import crypto.md5

struct Class_WC_Tax {
	rt.PhpObjectBase
pub mut:
		precision rt.PhpVal = rt.new_null()
		round_at_subtotal rt.PhpVal = rt.new_bool(false)
}

fn Class_WC_Tax.init()  {
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_WC_Tax.maybe_remove_tax_class_rates(var_old_value rt.PhpVal, var_value rt.PhpVal)  {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Tax::maybe_remove_tax_class_rates'), rt.new_string('3.7'), rt.new_string('WC_Tax::delete_tax_class_by')])
	mut var_tax_classes := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string('\n'), var_value.dup()])])])
	mut var_existing_tax_classes := Class_WC_Tax.get_tax_classes()
	mut var_removed := rt.call_function('array_diff', [var_existing_tax_classes.dup(), var_tax_classes.dup()])
	{
		mut iter_1 := var_removed.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_name := item_1.val
			Class_WC_Tax.delete_tax_class_by(rt.new_string('name'), var_name.dup())
		}
	}
}

fn Class_WC_Tax.calc_tax(var_price rt.PhpVal, var_rates rt.PhpVal, price_includes_tax bool, deprecated bool) rt.PhpVal {
	mut var_price_mutated := var_price
	mut var_rates_mutated := var_rates
	if var_price_includes_tax {
		mut var_taxes := Class_WC_Tax.calc_inclusive_tax(var_price_mutated.dup(), var_rates_mutated.dup())
	} else {
		var_taxes = Class_WC_Tax.calc_exclusive_tax(var_price_mutated.dup(), var_rates_mutated.dup())
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_calc_tax'), var_taxes.dup(), var_price_mutated.dup(), var_rates_mutated.dup(), rt.new_bool(price_includes_tax), rt.new_bool(deprecated)])
}

fn Class_WC_Tax.calc_shipping_tax(var_price rt.PhpVal, var_rates rt.PhpVal) rt.PhpVal {
	mut var_price_mutated := var_price
	mut var_rates_mutated := var_rates
	mut var_shipping_prices_include_tax := rt.call_function('wc_string_to_bool', [rt.call_function('apply_filters', [rt.new_string('woocommerce_shipping_prices_include_tax'), rt.new_bool(false)])])
	if rt.is_true(var_shipping_prices_include_tax) {
		mut var_taxes := Class_WC_Tax.calc_inclusive_tax(var_price_mutated.dup(), var_rates_mutated.dup())
	} else {
		var_taxes = Class_WC_Tax.calc_exclusive_tax(var_price_mutated.dup(), var_rates_mutated.dup())
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_calc_shipping_tax'), var_taxes.dup(), var_price_mutated.dup(), var_rates_mutated.dup()])
}

fn Class_WC_Tax.round(var_in rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_tax_round'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.round(arg_0, arg_1) }(var_in.dup(), rt.call_function('wc_get_rounding_precision', []rt.PhpVal{})), var_in.dup()])
}

fn Class_WC_Tax.calc_inclusive_tax(var_price rt.PhpVal, var_rates rt.PhpVal) rt.PhpVal {
	mut var_price_mutated := var_price
	mut var_rates_mutated := var_rates
	mut var_taxes := rt.new_array()
	mut var_compound_rates := rt.new_array()
	mut var_regular_rates := rt.new_array()
	{
		mut iter_1 := var_rates_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_rate := item_1.val
			mut var_key := item_1.key
			var_taxes.array_set(var_key, 0)
			if rt.is_true(rt.identical(rt.new_string('yes'), var_rate.array_get('compound'))) {
				var_compound_rates.array_set(var_key, var_rate.array_get('rate'))
			} else {
				var_regular_rates.array_set(var_key, var_rate.array_get('rate'))
			}
		}
	}
	var_compound_rates = rt.call_function('array_reverse', [var_compound_rates.dup(), rt.new_bool(true)])
	mut var_non_compound_price := var_price_mutated.dup()
	{
		mut iter_1 := var_compound_rates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_compound_rate := item_1.val
			mut var_key := item_1.key
			mut var_tax_amount := rt.call_function('apply_filters', [rt.new_string('woocommerce_price_inc_tax_amount'), rt.sub(var_non_compound_price, rt.div(var_non_compound_price, rt.add(rt.new_int(1), rt.div(var_compound_rate, rt.new_int(100))))), var_key.dup(), var_rates_mutated.array_get(var_key), var_price_mutated.dup()])
			// unsupported expression: Expr_AssignOp_Plus
			var_non_compound_price = rt.sub(var_non_compound_price, var_tax_amount)
		}
	}
	mut var_regular_tax_rate := rt.add(rt.new_int(1), rt.div(rt.call_function('array_sum', [var_regular_rates.dup()]), rt.new_int(100)))
	{
		mut iter_1 := var_regular_rates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_regular_rate := item_1.val
			mut var_key := item_1.key
			mut var_the_rate := rt.div(rt.div(var_regular_rate, rt.new_int(100)), var_regular_tax_rate)
			mut var_net_price := rt.sub(var_price_mutated, rt.mul(var_the_rate, var_non_compound_price))
			mut var_tax_amount := rt.call_function('apply_filters', [rt.new_string('woocommerce_price_inc_tax_amount'), rt.sub(var_price_mutated, var_net_price), var_key.dup(), var_rates_mutated.array_get(var_key), var_price_mutated.dup()])
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	var_taxes = rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'round' }]), var_taxes.dup()])
	return var_taxes.dup()
}

fn Class_WC_Tax.calc_exclusive_tax(var_price rt.PhpVal, var_rates rt.PhpVal) rt.PhpVal {
	mut var_price_mutated := var_price
	mut var_rates_mutated := var_rates
	mut var_taxes := rt.new_array()
	var_price_mutated = // unsupported expression: Expr_Cast_Double
	if !(!rt.is_true(var_rates_mutated)) {
		{
			mut iter_1 := var_rates_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_rate := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.identical(rt.new_string('yes'), var_rate.array_get('compound'))) {
					continue
				}
				mut var_tax_amount := rt.new_float(var_price_mutated * var_rate.array_get('rate').to_f64() / 100)
				var_tax_amount = rt.call_function('apply_filters', [rt.new_string('woocommerce_price_ex_tax_amount'), var_tax_amount.dup(), var_key.dup(), var_rate.dup(), var_price_mutated.dup()])
				if !(var_taxes.array_isset(var_key)) {
					var_taxes.array_set(var_key, // unsupported expression: Expr_Cast_Double)
				} else {
					// unsupported expression: Expr_AssignOp_Plus
				}
			}
		}
		mut var_pre_compound_total := rt.call_function('array_sum', [var_taxes.dup()])
		{
			mut iter_1 := var_rates_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_rate := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.identical(rt.new_string('no'), var_rate.array_get('compound'))) {
					continue
				}
				mut var_the_price_inc_tax := rt.add(var_price_mutated, var_pre_compound_total)
				mut var_tax_amount := rt.new_float(var_the_price_inc_tax * var_rate.array_get('rate').to_f64() / 100)
				var_tax_amount = rt.call_function('apply_filters', [rt.new_string('woocommerce_price_ex_tax_amount'), var_tax_amount.dup(), var_key.dup(), var_rate.dup(), var_price_mutated.dup(), var_the_price_inc_tax.dup(), var_pre_compound_total.dup()])
				if !(var_taxes.array_isset(var_key)) {
					var_taxes.array_set(var_key, // unsupported expression: Expr_Cast_Double)
				} else {
					// unsupported expression: Expr_AssignOp_Plus
				}
				var_pre_compound_total = rt.call_function('array_sum', [var_taxes.dup()])
			}
		}
	}
	var_taxes = rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'round' }]), var_taxes.dup()])
	return var_taxes.dup()
}

fn Class_WC_Tax.find_rates(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'country', val: '' }, rt.ArrayItem{ key: 'state', val: '' }, rt.ArrayItem{ key: 'city', val: '' }, rt.ArrayItem{ key: 'postcode', val: '' }, rt.ArrayItem{ key: 'tax_class', val: '' }])])
	mut var_country := var_args_mutated.array_get('country')
	mut var_state := var_args_mutated.array_get('state')
	mut var_city := var_args_mutated.array_get('city')
	mut var_postcode := rt.call_function('wc_normalize_postcode', [rt.call_function('wc_clean', [var_args_mutated.array_get('postcode')])])
	mut var_tax_class := var_args_mutated.array_get('tax_class')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_country)))) {
		return rt.new_array()
	}
	mut var_cache_key := rt.new_string((fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_cache_prefix(arg_0) }(rt.new_string('taxes'))).str() + 'wc_tax_rates_' + md5.hexhash(rt.call_function('sprintf', [rt.new_string('%s+%s+%s+%s+%s'), var_country.dup(), var_state.dup(), var_city.dup(), var_postcode.dup(), var_tax_class.dup()]).to_string()))
	mut var_matched_tax_rates := rt.call_function('wp_cache_get', [var_cache_key.dup(), rt.new_string('taxes')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_matched_tax_rates)) {
		var_matched_tax_rates = Class_WC_Tax.get_matched_tax_rates(var_country.dup(), var_state.dup(), var_postcode.dup(), var_city.dup(), var_tax_class.dup())
		rt.call_function('wp_cache_set', [var_cache_key.dup(), var_matched_tax_rates.dup(), rt.new_string('taxes')])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_find_rates'), var_matched_tax_rates.dup(), var_args_mutated.dup()])
}

fn Class_WC_Tax.find_shipping_rates(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_rates := Class_WC_Tax.find_rates(var_args_mutated.dup())
	mut var_shipping_rates := rt.new_array()
	if rt.is_true(rt.new_bool(var_rates.dup().is_array())) {
		{
			mut iter_1 := var_rates.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_rate := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.identical(rt.new_string('yes'), var_rate.array_get('shipping'))) {
					var_shipping_rates.array_set(var_key, var_rate.dup())
				}
			}
		}
	}
	return var_shipping_rates.dup()
}

fn Class_WC_Tax.sort_rates_callback(var_rate1 rt.PhpVal, var_rate2 rt.PhpVal) i64 {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (if rt.is_true(rt.less(rt.get_property(var_rate1, 'tax_rate_priority'), rt.get_property(var_rate2, 'tax_rate_priority'))) { // unsupported expression: Expr_UnaryMinus } else { rt.new_int(1) }).to_i64()
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_rate1, 'tax_rate_country'))) {
			return 1
		}
		if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_rate2, 'tax_rate_country'))) {
			return (// unsupported expression: Expr_UnaryMinus).to_i64()
		}
		return (if rt.is_true(rt.greater(rt.call_function('strcmp', [rt.get_property(var_rate1, 'tax_rate_country'), rt.get_property(var_rate2, 'tax_rate_country')]), rt.new_int(0))) { rt.new_int(1) } else { // unsupported expression: Expr_UnaryMinus }).to_i64()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_rate1, 'tax_rate_state'))) {
			return 1
		}
		if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_rate2, 'tax_rate_state'))) {
			return (// unsupported expression: Expr_UnaryMinus).to_i64()
		}
		return (if rt.is_true(rt.greater(rt.call_function('strcmp', [rt.get_property(var_rate1, 'tax_rate_state'), rt.get_property(var_rate2, 'tax_rate_state')]), rt.new_int(0))) { rt.new_int(1) } else { // unsupported expression: Expr_UnaryMinus }).to_i64()
	}
	if rt.is_true(rt.new_bool(!(rt.get_property(var_rate1, 'postcode_count')).is_null() && !(rt.get_property(var_rate2, 'postcode_count')).is_null() && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return (if rt.is_true(rt.less(rt.get_property(var_rate1, 'postcode_count'), rt.get_property(var_rate2, 'postcode_count'))) { rt.new_int(1) } else { // unsupported expression: Expr_UnaryMinus }).to_i64()
	}
	if rt.is_true(rt.new_bool(!(rt.get_property(var_rate1, 'city_count')).is_null() && !(rt.get_property(var_rate2, 'city_count')).is_null() && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return (if rt.is_true(rt.less(rt.get_property(var_rate1, 'city_count'), rt.get_property(var_rate2, 'city_count'))) { rt.new_int(1) } else { // unsupported expression: Expr_UnaryMinus }).to_i64()
	}
	return (if rt.is_true(rt.less(rt.get_property(var_rate1, 'tax_rate_id'), rt.get_property(var_rate2, 'tax_rate_id'))) { // unsupported expression: Expr_UnaryMinus } else { rt.new_int(1) }).to_i64()
}

fn Class_WC_Tax.sort_rates(var_rates rt.PhpVal) rt.PhpVal {
	mut var_rates_mutated := var_rates
	rt.call_function('uasort', [var_rates_mutated.dup(), @STRUCT + '::sort_rates_callback'])
	mut var_i := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := var_rates_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_rate := item_1.val
			mut var_key := item_1.key
			rt.set_property(var_rates_mutated.array_get(var_key), 'tax_rate_order', rt.post_inc(var_i))
		}
	}
	return var_rates_mutated.dup()
}

fn Class_WC_Tax.get_matched_tax_rates(var_country rt.PhpVal, var_state rt.PhpVal, var_postcode rt.PhpVal, var_city rt.PhpVal, var_tax_class rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_country_mutated := var_country
	mut var_state_mutated := var_state
	mut var_postcode_mutated := var_postcode
	mut var_city_mutated := var_city
	mut var_tax_class_mutated := var_tax_class
	// unsupported statement: Stmt_Global
	mut var_criteria := rt.new_array()
	var_criteria << rt.call_method(var_wpdb, 'prepare', [rt.new_string('tax_rate_country IN ( %s, \'\' )'), rt.new_string(.dup().to_string().to_upper())])
	var_criteria << rt.call_method(, 'prepare', [, ])
	 << 
	
}

fn Class_WC_Tax.get_tax_location(tax_class string, var_customer rt.PhpVal) rt.PhpVal {
	mut tax_class_mutated := tax_class
	mut var_customer_mutated := var_customer
}

fn Class_WC_Tax.get_rates(tax_class string, var_customer rt.PhpVal) rt.PhpVal {
	mut tax_class_mutated := tax_class
	mut var_customer_mutated := var_customer
}

fn Class_WC_Tax.get_rates_from_location(var_tax_class rt.PhpVal, var_location rt.PhpVal, var_customer rt.PhpVal) rt.PhpVal {
	mut var_country := rt.new_null()
	mut var_state := rt.new_null()
	mut var_postcode := rt.new_null()
	mut var_city := rt.new_null()
	mut var_tax_class_mutated := var_tax_class
	mut var_location_mutated := var_location
	mut var_customer_mutated := var_customer
}

fn Class_WC_Tax.get_base_tax_rates(tax_class string) rt.PhpVal {
	mut tax_class_mutated := tax_class
}

fn Class_WC_Tax.get_shop_base_rate(tax_class string) rt.PhpVal {
	mut tax_class_mutated := tax_class
}

fn Class_WC_Tax.get_shipping_tax_rates(var_tax_class rt.PhpVal, var_customer rt.PhpVal) rt.PhpVal {
	mut var_country := rt.new_null()
	mut var_state := rt.new_null()
	mut var_postcode := rt.new_null()
	mut var_city := rt.new_null()
	mut var_tax_class_mutated := var_tax_class
	mut var_customer_mutated := var_customer
}

fn Class_WC_Tax.get_shipping_tax_class_from_cart_items() rt.PhpVal {
}

fn Class_WC_Tax.is_compound(var_key_or_rate rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Tax.get_rate_label(var_key_or_rate rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Tax.get_rate_percent(var_key_or_rate rt.PhpVal) rt.PhpVal {
}

fn Class_WC_Tax.get_rate_percent_value(var_key_or_rate rt.PhpVal) f64 {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Tax.get_rate_code(var_key_or_rate rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Tax.get_tax_total(var_taxes rt.PhpVal) rt.PhpVal {
	mut var_taxes_mutated := var_taxes
}

fn Class_WC_Tax.get_tax_rate_classes() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Tax.get_tax_classes() rt.PhpVal {
}

fn Class_WC_Tax.get_tax_class_slugs() rt.PhpVal {
}

fn Class_WC_Tax.create_tax_class(var_name rt.PhpVal, slug string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_name_mutated := var_name
	mut slug_mutated := slug
}

fn Class_WC_Tax.get_tax_class_by(var_field rt.PhpVal, var_item rt.PhpVal) rt.PhpVal {
	mut var_field_mutated := var_field
}

fn Class_WC_Tax.delete_tax_class_by(var_field rt.PhpVal, var_item rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_field_mutated := var_field
}

fn Class_WC_Tax.format_tax_rate_city(var_city rt.PhpVal) string {
	mut var_city_mutated := var_city
}

fn Class_WC_Tax.format_tax_rate_state(var_state rt.PhpVal) rt.PhpVal {
	mut var_state_mutated := var_state
}

fn Class_WC_Tax.format_tax_rate_country(var_country rt.PhpVal) rt.PhpVal {
	mut var_country_mutated := var_country
}

fn Class_WC_Tax.format_tax_rate_name(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
}

fn Class_WC_Tax.format_tax_rate(var_rate rt.PhpVal) rt.PhpVal {
	mut var_rate_mutated := var_rate
}

fn Class_WC_Tax.format_tax_rate_priority(var_priority rt.PhpVal) rt.PhpVal {
}

fn Class_WC_Tax.format_tax_rate_class(var_class rt.PhpVal) rt.PhpVal {
	mut var_class_mutated := var_class
}

fn Class_WC_Tax.prepare_tax_rate(var_tax_rate rt.PhpVal) rt.PhpVal {
	mut var_tax_rate_mutated := var_tax_rate
}

fn Class_WC_Tax._insert_tax_rate(var_tax_rate rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_tax_rate_mutated := var_tax_rate
}

fn Class_WC_Tax._get_tax_rate(var_tax_rate_id rt.PhpVal, var_output_type rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_tax_rate_id_mutated := var_tax_rate_id
}

fn Class_WC_Tax._update_tax_rate(var_tax_rate_id rt.PhpVal, var_tax_rate rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_tax_rate_id_mutated := var_tax_rate_id
	mut var_tax_rate_mutated := var_tax_rate
}

fn Class_WC_Tax._delete_tax_rate(var_tax_rate_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_tax_rate_id_mutated := var_tax_rate_id
}

fn Class_WC_Tax._update_tax_rate_postcodes(var_tax_rate_id rt.PhpVal, var_postcodes rt.PhpVal)  {
	mut var_tax_rate_id_mutated := var_tax_rate_id
	mut var_postcodes_mutated := var_postcodes
}

fn Class_WC_Tax._update_tax_rate_cities(var_tax_rate_id rt.PhpVal, var_cities rt.PhpVal)  {
	mut var_tax_rate_id_mutated := var_tax_rate_id
	mut var_cities_mutated := var_cities
}

fn Class_WC_Tax.update_tax_rate_locations(var_tax_rate_id rt.PhpVal, var_values rt.PhpVal, var_type rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_tax_rate_id_mutated := var_tax_rate_id
}

fn Class_WC_Tax.get_rates_for_tax_class(var_tax_class rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_tax_class_mutated := var_tax_class
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_wc_tax() &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
		precision: rt.new_null()
		round_at_subtotal: rt.new_bool(false)
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil() &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
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
			return Class_WC_Tax.calc_tax(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
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
			return Class_WC_Tax.get_matched_tax_rates(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
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
			return Class_WC_Tax.get_rates_from_location(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
			return Class_WC_Tax.is_compound(dispatch_arg_0)
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
			return Class_WC_Tax.delete_tax_class_by(dispatch_arg_0, dispatch_arg_1)
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
		else { return none }
	}
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'precision' { return this.precision }
		'round_at_subtotal' { return this.round_at_subtotal }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'precision' { this.precision = val; return true }
		'round_at_subtotal' { this.round_at_subtotal = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_tax_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
