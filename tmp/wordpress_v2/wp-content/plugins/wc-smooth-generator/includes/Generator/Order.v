import rt

pub fn Class_WC_SmoothGenerator_Generator_Order.second_refund_probability() i64 {
	return 25
}

pub fn Class_WC_SmoothGenerator_Generator_Order.max_partial_refund_ratio() f64 {
	return 0.5
}

pub fn Class_WC_SmoothGenerator_Generator_Order.first_refund_max_days() i64 {
	return 60
}

pub fn Class_WC_SmoothGenerator_Generator_Order.second_refund_max_days() i64 {
	return 30
}

pub fn Class_WC_SmoothGenerator_Generator_Order.refund_type_none() i64 {
	return 0
}

pub fn Class_WC_SmoothGenerator_Generator_Order.refund_type_full() i64 {
	return 1
}

pub fn Class_WC_SmoothGenerator_Generator_Order.refund_type_partial() i64 {
	return 2
}

pub fn Class_WC_SmoothGenerator_Generator_Order.refund_type_multi() i64 {
	return 3
}

pub fn Class_WC_SmoothGenerator_Generator_Order.refund_distribution_full_ratio() f64 {
	return 0.5
}

pub fn Class_WC_SmoothGenerator_Generator_Order.refund_distribution_partial_ratio() f64 {
	return 0.25
}

struct Class_WC_SmoothGenerator_Generator_Order {
	rt.PhpObjectBase
}

fn Class_WC_SmoothGenerator_Generator_Order.generate(save bool, var_assoc_args rt.PhpVal, var_date rt.PhpVal, var_include_coupon rt.PhpVal, var_refund_type rt.PhpVal) bool {
	mut var_date_mutated := var_date
	mut var_include_coupon_mutated := var_include_coupon
	mut var_refund_type_mutated := var_refund_type
	this.Class_WC_SmoothGenerator_Generator_Generator.maybe_initialize_generators()
	mut var_order := create_wc_smoothgenerator_generator_wc_order()
	mut var_customer := Class_WC_SmoothGenerator_Generator_Order.get_customer()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_customer,
		'WC_SmoothGenerator_Generator_WC_Customer'))))))
	{
		rt.call_function('error_log', [
			rt.new_string('Order generation failed: Could not generate or retrieve customer'),
		])
		return false
	}
	mut var_products := Class_WC_SmoothGenerator_Generator_Order.get_random_products(1, 10)
	if !rt.is_true(var_products) {
		rt.call_function('error_log', [
			rt.new_string('Order generation failed: No products available to add to order'),
		])
		return false
	}
	mut iter_1 := var_products.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_product := item_1.val
		mut var_quantity := rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Order',
			'faker'), 'numberBetween', [rt.new_int(1), rt.new_int(10)])
		rt.call_method(var_order, 'add_product', [var_product.clone(),
			var_quantity.clone()])
	}
	rt.call_method(var_order, 'set_customer_id', [
		rt.call_method(var_customer, 'get_id', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_created_via', [rt.new_string('smooth-generator')])
	rt.call_method(var_order, 'set_currency', [
		rt.call_function('get_woocommerce_currency', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_billing_first_name', [
		rt.call_method(var_customer, 'get_billing_first_name', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_billing_last_name', [
		rt.call_method(var_customer, 'get_billing_last_name', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_billing_address_1', [
		rt.call_method(var_customer, 'get_billing_address_1', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_billing_address_2', [
		rt.call_method(var_customer, 'get_billing_address_2', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_billing_email', [
		rt.call_method(var_customer, 'get_billing_email', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_billing_phone', [
		rt.call_method(var_customer, 'get_billing_phone', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_billing_city', [
		rt.call_method(var_customer, 'get_billing_city', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_billing_postcode', [
		rt.call_method(var_customer, 'get_billing_postcode', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_billing_state', [
		rt.call_method(var_customer, 'get_billing_state', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_billing_country', [
		rt.call_method(var_customer, 'get_billing_country', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_billing_company', [
		rt.call_method(var_customer, 'get_billing_company', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_shipping_first_name', [
		rt.call_method(var_customer, 'get_shipping_first_name', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_shipping_last_name', [
		rt.call_method(var_customer, 'get_shipping_last_name', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_shipping_address_1', [
		rt.call_method(var_customer, 'get_shipping_address_1', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_shipping_address_2', [
		rt.call_method(var_customer, 'get_shipping_address_2', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_shipping_city', [
		rt.call_method(var_customer, 'get_shipping_city', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_shipping_postcode', [
		rt.call_method(var_customer, 'get_shipping_postcode', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_shipping_state', [
		rt.call_method(var_customer, 'get_shipping_state', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_shipping_country', [
		rt.call_method(var_customer, 'get_shipping_country', []rt.PhpVal{}),
	])
	rt.call_method(var_order, 'set_shipping_company', [
		rt.call_method(var_customer, 'get_shipping_company', []rt.PhpVal{}),
	])
	if rt.is_true(rt.less_equal(rt.call_function('rand', [rt.new_int(0),
		rt.new_int(100)]), rt.new_int(20)))
	{
		mut var_country_code := rt.call_method(var_order, 'get_shipping_country', []rt.PhpVal{})
		mut var_calculate_tax_for := rt.create_array([
			rt.ArrayItem{ key: 'country', val: var_country_code },
			rt.ArrayItem{ key: 'state', val: '' },
			rt.ArrayItem{ key: 'postcode', val: '' },
			rt.ArrayItem{ key: 'city', val: '' },
		])
		mut var_fee := create_wc_smoothgenerator_generator_wc_order_item_fee()
		mut var_randomAmount := rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Order',
			'faker'), 'randomFloat', [rt.new_int(2), rt.new_float(0.05),
			rt.new_int(100)])
		var_fee.set_name(rt.new_string('Extra Fee'))
		var_fee.set_amount(var_randomAmount.clone())
		var_fee.set_tax_class(rt.new_string(''))
		var_fee.set_tax_status(rt.new_string('taxable'))
		var_fee.set_total(var_randomAmount.clone())
		var_fee.calculate_taxes(var_calculate_tax_for.clone())
		rt.call_method(var_order, 'add_item', [var_fee])
	}
	mut var_status := Class_WC_SmoothGenerator_Generator_Order.get_status(var_assoc_args.clone())
	rt.call_method(var_order, 'set_status', [var_status.clone()])
	rt.call_method(var_order, 'calculate_totals', [rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_null(), var_date_mutated)) {
		var_date_mutated =
			Class_WC_SmoothGenerator_Generator_Order.get_date_created(var_assoc_args.clone())
	}
	var_date_mutated = rt.concat(var_date_mutated, rt.new_string(' ' +
		(rt.call_function('wp_rand', [rt.new_int(0), rt.new_int(23)])).str() + ':00:00'))
	rt.call_method(var_order, 'set_date_created', [var_date_mutated.clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_include_coupon_mutated)) {
		var_include_coupon_mutated =
			rt.new_bool(!(!rt.is_true(var_assoc_args.array_get(rt.new_string('coupons')))))
	}
	if var_assoc_args.array_isset(rt.new_string('coupon-ratio'))
		&& rt.is_true(rt.identical(rt.new_null(), var_include_coupon_mutated)) {
		mut var_coupon_ratio :=
			rt.new_float(var_assoc_args.array_get(rt.new_string('coupon-ratio')).to_f64())
		if rt.is_true(rt.less(var_coupon_ratio, rt.new_float(0)))
			|| rt.is_true(rt.greater(var_coupon_ratio, rt.new_float(1))) {
			var_coupon_ratio = rt.call_function('max', [rt.new_float(0),
				rt.call_function('min', [rt.new_float(1), var_coupon_ratio.clone()])])
		}
		if rt.is_true(rt.greater_equal(var_coupon_ratio, rt.new_float(1))) {
			var_include_coupon_mutated = rt.new_bool(true)
		} else if rt.is_true(rt.greater(var_coupon_ratio, rt.new_int(0)))
			&& rt.is_true(rt.less_equal(rt.call_function('wp_rand', [rt.new_int(1), rt.new_int(100)]), rt.mul(var_coupon_ratio, rt.new_int(100)))) {
			var_include_coupon_mutated = rt.new_bool(true)
		} else {
			var_include_coupon_mutated = rt.new_bool(false)
		}
	}
	if rt.is_true(var_include_coupon_mutated) {
		mut var_coupon := Class_WC_SmoothGenerator_Generator_Order.get_or_create_coupon()
		if rt.is_true(var_coupon) {
			mut var_apply_result := rt.call_method(var_order, 'apply_coupon', [
				var_coupon.clone(),
			])
			if rt.is_true(rt.call_function('is_wp_error', [var_apply_result.clone()])) {
				rt.call_function('error_log', [
					rt.new_string('Coupon application failed: ' +
						(rt.call_method(var_apply_result, 'get_error_message', []rt.PhpVal{})).str() +
						' (Coupon: ' + (rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})).str() +
						')'),
				])
			} else {
				rt.call_method(var_order, 'calculate_totals', [
					rt.new_bool(true)])
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.less(rt.call_function('strtotime', [
		var_date_mutated.clone(),
	]), rt.call_function('strtotime', [rt.new_string('2024-01-09')]))))))
	{
		mut iife_temp_0 := Class_WC_SmoothGenerator_Generator_OrderAttribution{}
		mut iife_result_0 := iife_temp_0.add_order_attribution_meta(var_order.clone(),
			var_assoc_args.clone())
		mut var_attribution_result := iife_result_0
		if rt.is_true(var_attribution_result)
			&& rt.is_true(rt.call_function('is_wp_error', [var_attribution_result.clone()])) {
			rt.call_function('error_log', [
				rt.new_string('Order attribution meta addition failed: ' +(rt.call_method(var_attribution_result, 'get_error_message', []rt.PhpVal{})).str()),
			])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('completed'), var_status))
		|| rt.is_true(rt.identical(rt.new_string('processing'), var_status)) {
		mut var_date_paid := rt.call_function('date', [rt.new_string('Y-m-d H:i:s'),
			rt.add(rt.call_function('strtotime', [var_date_mutated.clone()]), rt.mul(rt.call_function('wp_rand', [
				rt.new_int(0), rt.new_int(36)]), rt.get_constant('HOUR_IN_SECONDS')))])
		rt.call_method(var_order, 'set_date_paid', [var_date_paid.clone()])
		if rt.is_true(rt.identical(rt.new_string('completed'), var_status)) {
			mut var_date_completed := rt.call_function('date', [
				rt.new_string('Y-m-d H:i:s'),
				rt.add(rt.call_function('strtotime', [var_date_paid.clone()]), rt.mul(rt.call_function('wp_rand', [
					rt.new_int(0), rt.new_int(36)]), rt.get_constant('HOUR_IN_SECONDS'))),
			])
			rt.call_method(var_order, 'set_date_completed', [
				var_date_completed.clone()])
		}
	}
	if var_save {
		mut var_save_result := rt.call_method(var_order, 'save', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_wp_error', [var_save_result.clone()])) {
			rt.call_function('error_log', [
				rt.new_string('Order save failed: ' +
					(rt.call_method(var_save_result, 'get_error_message', []rt.PhpVal{})).str()),
			])
			return false
		}
		if var_assoc_args.array_isset(rt.new_string('refund-ratio'))
			&& rt.is_true(rt.identical(rt.new_string('completed'), var_status)) {
			if rt.is_true(rt.identical(rt.new_null(), var_refund_type_mutated)) {
				mut var_refund_ratio :=
					rt.new_float(var_assoc_args.array_get(rt.new_string('refund-ratio')).to_f64())
				if rt.is_true(rt.less(var_refund_ratio, rt.new_float(0)))
					|| rt.is_true(rt.greater(var_refund_ratio, rt.new_float(1))) {
					var_refund_ratio = rt.call_function('max', [
						rt.new_float(0),
						rt.call_function('min', [
							rt.new_float(1), var_refund_ratio.clone()])])
				}
				var_refund_type_mutated =
					Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_none()
				if rt.is_true(rt.greater_equal(var_refund_ratio, rt.new_float(1))) {
					var_refund_type_mutated =
						Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_full()
				} else if rt.is_true(rt.greater(var_refund_ratio, rt.new_int(0)))
					&& rt.is_true(rt.less_equal(rt.call_function('wp_rand', [rt.new_int(1), rt.new_int(100)]), rt.mul(var_refund_ratio, rt.new_int(100)))) {
					var_refund_type_mutated = if rt.is_true(rt.call_function('wp_rand', [
						rt.new_int(0),
						rt.new_int(1),
					]))
					{
						Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_full()
					} else {
						Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_partial()
					}
					if rt.is_true(rt.identical(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_partial(), var_refund_type_mutated))
						&& rt.is_true(rt.less_equal(rt.call_function('wp_rand', [rt.new_int(1), rt.new_int(100)]), Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.second_refund_probability())) {
						var_refund_type_mutated =
							Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_multi()
					}
				}
			}
			if rt.is_true(rt.identical(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_full(),
				var_refund_type_mutated))
			{
				Class_WC_SmoothGenerator_Generator_Order.create_refund(var_order.to_bool(),
					rt.new_bool(false), rt.new_null(), rt.new_bool(true))
			} else if rt.is_true(rt.identical(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_partial(),
				var_refund_type_mutated))
			{
				Class_WC_SmoothGenerator_Generator_Order.create_refund(var_order.to_bool(),
					rt.new_bool(true), rt.new_null(), rt.new_bool(false))
			} else if rt.is_true(rt.identical(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_multi(),
				var_refund_type_mutated))
			{
				mut var_first_refund := Class_WC_SmoothGenerator_Generator_Order.create_refund(var_order.to_bool(),
					rt.new_bool(true), rt.new_null(), rt.new_bool(false))
				if rt.is_true(var_first_refund) && var_first_refund.clone().is_object() {
					Class_WC_SmoothGenerator_Generator_Order.create_refund(var_order.to_bool(),
						rt.new_bool(true), var_first_refund.clone(), rt.new_bool(false))
				}
			}
		}
	}
	rt.call_function('do_action', [rt.new_string('smoothgenerator_order_generated'),
		var_order.clone()])
	return var_order.to_bool()
}

fn Class_WC_SmoothGenerator_Generator_Order.batch(var_amount rt.PhpVal, mut var_args Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_amount_mutated := var_amount
	mut iife_temp_1 := Class_WC_SmoothGenerator_Generator_Order{}
	mut iife_result_1 := iife_temp_1.validate_batch_amount(var_amount_mutated.clone())
	var_amount_mutated = iife_result_1
	if rt.is_true(rt.call_function('is_wp_error', [var_amount_mutated.clone()])) {
		rt.call_function('error_log', [
			rt.new_string('Batch generation failed: ' +
				(rt.call_method(var_amount_mutated, 'get_error_message', []rt.PhpVal{})).str()),
		])
		return var_amount_mutated.clone()
	}
	mut var_coupons_remaining := rt.new_int(0)
	if var_args.array_isset(rt.new_string('coupon-ratio')) {
		mut var_coupon_ratio :=
			rt.new_float(var_args.array_get(rt.new_string('coupon-ratio')).to_f64())
		var_coupon_ratio = rt.call_function('max', [rt.new_float(0),
			rt.call_function('min', [rt.new_float(1), var_coupon_ratio.clone()])])
		var_coupons_remaining = rt.new_int((rt.call_function('round', [
			rt.mul(var_amount_mutated, var_coupon_ratio),
		])).to_i64())
	}
	mut var_full_remaining := rt.new_int(0)
	mut var_partial_remaining := rt.new_int(0)
	mut var_multi_remaining := rt.new_int(0)
	if var_args.array_isset(rt.new_string('refund-ratio'))
		&& rt.is_true(rt.identical(rt.new_string('completed'), if !(var_args.array_get(rt.new_string('status'))).is_null() { var_args.array_get(rt.new_string('status')) } else { rt.new_string('') })) {
		mut var_refund_ratio :=
			rt.new_float(var_args.array_get(rt.new_string('refund-ratio')).to_f64())
		var_refund_ratio = rt.call_function('max', [rt.new_float(0),
			rt.call_function('min', [rt.new_float(1), var_refund_ratio.clone()])])
		mut var_total_refunds := rt.new_int((rt.call_function('round', [
			rt.mul(var_amount_mutated, var_refund_ratio),
		])).to_i64())
		var_full_remaining = rt.new_int((rt.call_function('floor', [
			rt.mul(var_total_refunds,
				Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_distribution_full_ratio()),
		])).to_i64())
		var_partial_remaining = rt.new_int((rt.call_function('floor', [
			rt.mul(var_total_refunds,
				Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_distribution_partial_ratio()),
		])).to_i64())
		var_multi_remaining = rt.sub(rt.sub(var_total_refunds, var_full_remaining),
			var_partial_remaining)
	}
	mut var_dates := rt.new_null()
	if !(!rt.is_true(var_args.array_get(rt.new_string('date-start')))) {
		var_dates = Class_WC_SmoothGenerator_Generator_Order.generate_batch_dates(var_amount_mutated.clone(), rt.new_object('WC_SmoothGenerator_Generator_array',
			[]string{}, var_args))
	}
	mut var_order_ids := rt.new_array()
	mut var_orders_remaining := var_amount_mutated.clone()
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less_equal(var_i, var_amount_mutated))) { break
		 }
		mut var_date := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_dates)))) && !(!rt.is_true(var_dates)) { rt.call_function('array_shift', [
				var_dates.clone(),
			]) } else { rt.new_null() }
		mut var_include_coupon := rt.new_null()
		if var_args.array_isset(rt.new_string('coupon-ratio')) {
			var_include_coupon = rt.less_equal(rt.call_function('wp_rand', [
				rt.new_int(1),
				var_orders_remaining.clone(),
			]), var_coupons_remaining)
			if rt.is_true(var_include_coupon) {
				rt.post_dec(var_coupons_remaining)
			}
		}
		mut var_refund_type := rt.new_null()
		if var_args.array_isset(rt.new_string('refund-ratio'))
			&& rt.is_true(rt.identical(rt.new_string('completed'), if !(var_args.array_get(rt.new_string('status'))).is_null() { var_args.array_get(rt.new_string('status')) } else { rt.new_string('') })) {
			mut var_total_refund_remaining := rt.add(rt.add(var_full_remaining,
				var_partial_remaining), var_multi_remaining)
			if rt.is_true(rt.greater(var_total_refund_remaining, rt.new_int(0)))
				&& rt.is_true(rt.less_equal(rt.call_function('wp_rand', [rt.new_int(1), var_orders_remaining.clone()]), var_total_refund_remaining)) {
				mut var_full_threshold := var_full_remaining.clone()
				mut var_partial_threshold := rt.add(var_full_remaining, var_partial_remaining)
				mut var_rand := rt.call_function('wp_rand', [
					rt.new_int(1), var_total_refund_remaining.clone()])
				if rt.is_true(rt.less_equal(var_rand, var_full_threshold)) {
					var_refund_type =
						Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_full()
					rt.post_dec(var_full_remaining)
				} else if rt.is_true(rt.less_equal(var_rand, var_partial_threshold)) {
					var_refund_type =
						Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_partial()
					rt.post_dec(var_partial_remaining)
				} else {
					var_refund_type =
						Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_multi()
					rt.post_dec(var_multi_remaining)
				}
			} else {
				var_refund_type =
					Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_none()
			}
		}
		rt.post_dec(var_orders_remaining)
		mut var_order := Class_WC_SmoothGenerator_Generator_Order.generate(true, rt.new_object('WC_SmoothGenerator_Generator_array',
			[]string{}, var_args), var_date.clone(), var_include_coupon.clone(),
			var_refund_type.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order,
			'WC_SmoothGenerator_Generator_WC_Order'))))))
		{
			rt.call_function('error_log', [
				rt.new_string('Batch generation failed: Order ${var_i.to_string()} of ${var_amount.to_string()} could not be generated'),
			])
			rt.post_inc(var_orders_remaining)
			if rt.is_true(var_include_coupon) && var_args.array_isset(rt.new_string('coupon-ratio')) {
				rt.post_inc(var_coupons_remaining)
			}
			if var_args.array_isset(rt.new_string('refund-ratio'))
				&& rt.is_true(rt.identical(rt.new_string('completed'), if !(var_args.array_get(rt.new_string('status'))).is_null() { var_args.array_get(rt.new_string('status')) } else { rt.new_string('') }))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_refund_type)))) {
				if rt.is_true(rt.identical(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_full(),
					var_refund_type))
				{
					rt.post_inc(var_full_remaining)
				} else if rt.is_true(rt.identical(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_partial(),
					var_refund_type))
				{
					rt.post_inc(var_partial_remaining)
				} else if rt.is_true(rt.identical(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.refund_type_multi(),
					var_refund_type))
				{
					rt.post_inc(var_multi_remaining)
				}
			}
			continue
		}
		var_order_ids.array_push(rt.call_method(var_order, 'get_id', []rt.PhpVal{}))
		rt.post_inc(var_i)
	}
	return var_order_ids.clone()
}

fn Class_WC_SmoothGenerator_Generator_Order.get_customer() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_guest := rt.new_bool((rt.call_function('wp_rand', [
		rt.new_int(0), rt.new_int(1)])).to_bool())
	mut var_existing := rt.new_bool((rt.call_function('wp_rand', [
		rt.new_int(0), rt.new_int(1)])).to_bool())
	if rt.is_true(var_existing) {
		mut var_total_users := rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb, 'users')),
		])).to_i64())
		mut var_offset := rt.call_function('wp_rand', [rt.new_int(0),
			var_total_users.clone()])
		mut var_user_id := rt.new_int((rt.call_method(var_wpdb, 'get_var', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
				'users')), rt.new_string(' ORDER BY rand() LIMIT ')), var_offset),
				rt.new_string(', 1')),
		])).to_i64())
		return rt.new_object('WC_SmoothGenerator_Generator_WC_Customer', []string{},
			create_wc_smoothgenerator_generator_wc_customer(var_user_id.clone()))
	}
	mut iife_temp_2 := Class_WC_SmoothGenerator_Generator_Customer{}
	mut iife_result_2 := iife_temp_2.generate(rt.new_bool(!(rt.is_true(var_guest))))
	mut var_customer := iife_result_2
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_customer,
		'WC_SmoothGenerator_Generator_WC_Customer'))))))
	{
		rt.call_function('error_log', [
			rt.new_string('Customer generation failed: Customer::generate() returned invalid result'),
		])
	}
	return var_customer.clone()
}

fn Class_WC_SmoothGenerator_Generator_Order.get_date_created(var_assoc_args rt.PhpVal) rt.PhpVal {
	mut var_current := rt.call_function('date', [rt.new_string('Y-m-d'),
		rt.call_function('time', []rt.PhpVal{})])
	if !(!rt.is_true(var_assoc_args.array_get(rt.new_string('date-start'))))
		&& !rt.is_true(var_assoc_args.array_get(rt.new_string('date-end'))) {
		mut var_start := var_assoc_args.array_get(rt.new_string('date-start'))
		mut var_end := var_current.clone()
	} else if !(!rt.is_true(var_assoc_args.array_get(rt.new_string('date-start'))))
		&& !(!rt.is_true(var_assoc_args.array_get(rt.new_string('date-end')))) {
		var_start = var_assoc_args.array_get(rt.new_string('date-start'))
		var_end = var_assoc_args.array_get(rt.new_string('date-end'))
	} else {
		return var_current.clone()
	}
	mut var_start_timestamp := rt.call_function('strtotime', [
		var_start.clone()])
	mut var_end_timestamp := rt.call_function('strtotime', [var_end.clone()])
	mut var_days_between := rt.new_int((rt.div(rt.sub(var_end_timestamp, var_start_timestamp),
		rt.get_constant('DAY_IN_SECONDS'))).to_i64())
	if rt.is_true(rt.identical(rt.new_int(0), var_days_between)) {
		return rt.call_function('date', [rt.new_string('Y-m-d'),
			var_start_timestamp.clone()])
	}
	mut var_random_days := rt.call_function('wp_rand', [rt.new_int(0),
		var_days_between.clone()])
	return rt.call_function('date', [rt.new_string('Y-m-d'),
		rt.add(var_start_timestamp, rt.mul(var_random_days, rt.get_constant('DAY_IN_SECONDS')))])
}

fn Class_WC_SmoothGenerator_Generator_Order.get_status(var_assoc_args rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_assoc_args.array_get(rt.new_string('status')))) {
		return var_assoc_args.array_get(rt.new_string('status'))
	} else {
		mut iife_temp_3 := Class_WC_SmoothGenerator_Generator_Order{}
		mut iife_result_3 := iife_temp_3.random_weighted_element(rt.create_array([
			rt.ArrayItem{ key: 'completed', val: 70 },
			rt.ArrayItem{ key: 'processing', val: 15 },
			rt.ArrayItem{ key: 'on-hold', val: 5 },
			rt.ArrayItem{ key: 'failed', val: 10 },
		]))
		return iife_result_3
	}
	return rt.new_null()
}

fn Class_WC_SmoothGenerator_Generator_Order.get_random_products(min_amount i64, max_amount i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_products := rt.new_array()
	mut var_num_existing_products := rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		rt.concat(rt.concat(rt.new_string('SELECT COUNT( DISTINCT ID )\n\t\t\tFROM '), rt.get_property(var_wpdb,
			'posts')),
			rt.new_string("\n\t\t\tWHERE 1=1\n\t\t\tAND post_type='product'\n\t\t\tAND post_status='publish'")),
	])).to_i64())
	if rt.is_true(rt.identical(var_num_existing_products, rt.new_int(0))) {
		rt.call_function('error_log', [
			rt.new_string('No published products found in database'),
		])
		return rt.new_array()
	}
	mut var_num_products_to_get := rt.call_function('wp_rand', [
		rt.new_int(min_amount), rt.new_int(max_amount)])
	if rt.is_true(rt.greater(var_num_products_to_get, var_num_existing_products)) {
		var_num_products_to_get = var_num_existing_products.clone()
	}
	mut var_query := create_wc_smoothgenerator_generator_wc_product_query(rt.create_array([
		rt.ArrayItem{ key: 'limit', val: var_num_products_to_get },
		rt.ArrayItem{ key: 'return', val: 'ids' },
		rt.ArrayItem{ key: 'orderby', val: 'rand' },
	]))
	mut var_product_ids := var_query.get_products()
	if !rt.is_true(var_product_ids) {
		rt.call_function('error_log', [
			rt.new_string('WC_Product_Query returned no product IDs'),
		])
		return rt.new_array()
	}
	mut iter_2 := var_product_ids.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_product_id := item_2.val
		mut var_product := rt.call_function('wc_get_product', [
			var_product_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
			rt.call_function('error_log', [
				rt.new_string('Failed to retrieve product with ID: ${var_product_id.to_string()}'),
			])
			continue
		}
		if rt.is_true(rt.call_method(var_product, 'is_type', [
			rt.new_string('variable')]))
		{
			mut var_available_variations := rt.call_method(var_product, 'get_available_variations',
				[]rt.PhpVal{})
			if !rt.is_true(var_available_variations) {
				continue
			}
			mut var_index := rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Order',
				'faker'), 'numberBetween', [rt.new_int(0),
				rt.new_int(var_available_variations.clone().array_count() - 1)])
			mut var_variation :=
				create_wc_smoothgenerator_generator_wc_product_variation(var_available_variations.array_get(var_index).array_get(rt.new_string('variation_id')))
			if rt.is_true(var_variation) && rt.is_true(var_variation.exists()) {
				var_products.array_push(var_variation)
			}
		} else {
			var_products.array_push(var_product.clone())
		}
	}
	return var_products.clone()
}

fn Class_WC_SmoothGenerator_Generator_Order.get_or_create_coupon() bool {
	mut iife_temp_4 := Class_WC_SmoothGenerator_Generator_Coupon{}
	mut iife_result_4 := iife_temp_4.get_random()
	mut var_coupon := iife_result_4
	if rt.is_true(rt.identical(rt.new_bool(false), var_coupon)) {
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_CLI')])) {
			mut iife_temp_5 := Class_WC_SmoothGenerator_Generator_WP_CLI{}
			mut iife_result_5 :=
				iife_temp_5.log(rt.new_string('No coupons found. Creating 6 coupons (3 fixed cart $5-$50, 3 percentage 5%-25%)...'))
		}
		mut iife_temp_6 := Class_WC_SmoothGenerator_Generator_Coupon{}
		mut iife_result_6 := iife_temp_6.batch(rt.new_int(3), rt.create_array([
			rt.ArrayItem{ key: 'min', val: 5 },
			rt.ArrayItem{ key: 'max', val: 50 },
			rt.ArrayItem{ key: 'discount_type', val: 'fixed_cart' },
		]))
		mut var_fixed_result := iife_result_6
		mut iife_temp_7 := Class_WC_SmoothGenerator_Generator_Coupon{}
		mut iife_result_7 := iife_temp_7.batch(rt.new_int(3), rt.create_array([
			rt.ArrayItem{ key: 'min', val: 5 },
			rt.ArrayItem{ key: 'max', val: 25 },
			rt.ArrayItem{ key: 'discount_type', val: 'percent' },
		]))
		mut var_percent_result := iife_result_7
		if rt.is_true(rt.call_function('is_wp_error', [var_fixed_result.clone()]))
			|| rt.is_true(rt.call_function('is_wp_error', [var_percent_result.clone()])) {
			mut var_error_message := rt.new_string('Coupon creation failed: ')
			if rt.is_true(rt.call_function('is_wp_error', [var_fixed_result.clone()])) {
				var_error_message = rt.concat(var_error_message, rt.new_string(
					'Fixed coupons error: ' +
					(rt.call_method(var_fixed_result, 'get_error_message', []rt.PhpVal{})).str() +
					' '))
			}
			if rt.is_true(rt.call_function('is_wp_error', [var_percent_result.clone()])) {
				var_error_message = rt.concat(var_error_message, rt.new_string(
					'Percentage coupons error: ' +
					(rt.call_method(var_percent_result, 'get_error_message', []rt.PhpVal{})).str()))
			}
			rt.call_function('error_log', [var_error_message.clone()])
			return false
		}
		mut iife_temp_8 := Class_WC_SmoothGenerator_Generator_Coupon{}
		mut iife_result_8 := iife_temp_8.get_random()
		var_coupon = iife_result_8
	}
	return var_coupon.to_bool()
}

fn Class_WC_SmoothGenerator_Generator_Order.create_refund(var_order rt.PhpVal, force_partial bool, var_previous_refund rt.PhpVal, var_force_full rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut force_partial_mutated := force_partial
	mut var_force_full_mutated := var_force_full
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated,
		'WC_SmoothGenerator_Generator_WC_Order'))))))
	{
		rt.call_function('error_log', [
			rt.new_string('Error: Order is not an instance of \\WC_Order: ' +
				(println(var_order_mutated.clone().to_string())).str()),
		])
		return false
	}
	mut var_existing_refunds := rt.call_method(var_order_mutated, 'get_refunds', []rt.PhpVal{})
	if !(!rt.is_true(var_existing_refunds)) {
		force_partial_mutated = true
		var_force_full_mutated = rt.new_bool(false)
	}
	mut var_refunded_qty_by_item :=
		Class_WC_SmoothGenerator_Generator_Order.calculate_refunded_quantities(var_existing_refunds.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_force_full_mutated)))) {
		mut var_is_full_refund := var_force_full_mutated.clone()
	} else {
		var_is_full_refund = if rt.is_true(rt.new_bool(force_partial_mutated)) { rt.new_bool(false) } else { rt.call_function('wp_rand', [
				rt.new_int(0),
				rt.new_int(1),
			]) }
	}
	mut var_line_items := if rt.is_true(var_is_full_refund) {
		Class_WC_SmoothGenerator_Generator_Order.build_full_refund_items(var_order_mutated.clone(),
			var_refunded_qty_by_item.clone())
	} else {
		Class_WC_SmoothGenerator_Generator_Order.build_partial_refund_items(var_order_mutated.clone(),
			var_refunded_qty_by_item.clone())
	}
	if !rt.is_true(var_line_items) {
		rt.call_function('error_log', [
			rt.call_function('sprintf', [
				rt.new_string('Refund skipped for order %d: No line items to refund. Order has %d items.'),
				rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
				rt.new_int(rt.call_method(var_order_mutated, 'get_items', [
					rt.create_array([rt.ArrayItem{ key: none, val: 'line_item' },
						rt.ArrayItem{ key: none, val: 'fee' }]),
				]).array_count()),
			]),
		])
		return false
	}
	mut var_totals :=
		Class_WC_SmoothGenerator_Generator_Order.calculate_refund_totals(var_line_items.clone())
	mut var_refund_amount := var_totals.array_get(rt.new_string('amount'))
	mut var_total_items := var_totals.array_get(rt.new_string('total_items'))
	mut var_total_qty := var_totals.array_get(rt.new_string('total_qty'))
	if rt.is_true(var_is_full_refund) {
		var_refund_amount = rt.call_function('round', [
			rt.sub(rt.call_method(var_order_mutated, 'get_total', []rt.PhpVal{}), rt.call_method(var_order_mutated,
				'get_total_refunded', []rt.PhpVal{})),
			rt.new_int(2),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_full_refund)))) {
		mut var_max_partial_refund := rt.mul(rt.call_method(var_order_mutated, 'get_total',
			[]rt.PhpVal{}),
			Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.max_partial_refund_ratio())
		for rt.is_true(rt.greater_equal(var_refund_amount, var_max_partial_refund))
			&& var_line_items.clone().array_count() > 1 {
			var_line_items.array_unset(rt.call_function('array_rand', [
				var_line_items.clone()]))
			var_totals =
				Class_WC_SmoothGenerator_Generator_Order.calculate_refund_totals(var_line_items.clone())
			var_refund_amount = var_totals.array_get(rt.new_string('amount'))
			var_total_items = var_totals.array_get(rt.new_string('total_items'))
			var_total_qty = var_totals.array_get(rt.new_string('total_qty'))
		}
	}
	mut var_max_refund := rt.call_function('round', [
		rt.sub(rt.call_method(var_order_mutated, 'get_total', []rt.PhpVal{}), rt.call_method(var_order_mutated,
			'get_total_refunded', []rt.PhpVal{})),
		rt.new_int(2),
	])
	if rt.is_true(rt.greater(var_refund_amount, var_max_refund)) {
		var_refund_amount = var_max_refund.clone()
	}
	if rt.is_true(rt.less_equal(var_refund_amount, rt.new_int(0))) {
		rt.call_function('error_log', [
			rt.call_function('sprintf', [
				rt.new_string('Refund skipped for order %d: Invalid refund amount (%s). Order total: %s, Already refunded: %s'),
				rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
				var_refund_amount.clone(),
				rt.call_method(var_order_mutated, 'get_total', []rt.PhpVal{}),
				rt.call_method(var_order_mutated, 'get_total_refunded', []rt.PhpVal{}),
			]),
		])
		return false
	}
	mut var_reason := if rt.is_true(var_is_full_refund) { rt.new_string('Full refund') } else { rt.call_function('sprintf', [
			rt.new_string('Partial refund - %d %s, %d %s'),
			var_total_items.clone(),
			rt.new_string((if rt.is_true(rt.identical(var_total_items, rt.new_int(1))) {
				'product'
			} else {
				'products'
			}).str()),
			var_total_qty.clone(),
			rt.new_string((if rt.is_true(rt.identical(var_total_qty, rt.new_int(1))) {
				'item'
			} else {
				'items'
			}).str()),
		])
	 }
	mut var_refund_date := Class_WC_SmoothGenerator_Generator_Order.calculate_refund_date(var_order_mutated.clone(),
		var_previous_refund.clone())
	mut var_refund := rt.call_function('wc_create_refund', [
		rt.create_array([
			rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order_mutated, 'get_id',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'amount', val: var_refund_amount },
			rt.ArrayItem{ key: 'reason', val: var_reason },
			rt.ArrayItem{ key: 'line_items', val: var_line_items },
			rt.ArrayItem{ key: 'date_created', val: var_refund_date },
		]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_refund.clone()])) {
		rt.call_function('error_log', [
			rt.call_function('sprintf', [
				rt.new_string('Refund creation failed for order %d:\nError: %s\nCalculated Amount: %s\nOrder Total: %s\nOrder Refunded Total: %s\nReason: %s\nLine Items: %s'),
				rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
				rt.call_method(var_refund, 'get_error_message', []rt.PhpVal{}),
				var_refund_amount.clone(),
				rt.call_method(var_order_mutated, 'get_total', []rt.PhpVal{}),
				rt.call_method(var_order_mutated, 'get_total_refunded', []rt.PhpVal{}),
				var_reason.clone(),
				println(var_line_items.clone().to_string()),
			]),
		])
		return false
	}
	if rt.is_true(var_is_full_refund) {
		rt.call_method(var_order_mutated, 'set_status', [rt.new_string('refunded')])
		rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
	}
	return var_refund.to_bool()
}

fn Class_WC_SmoothGenerator_Generator_Order.calculate_refunded_quantities(var_existing_refunds rt.PhpVal) rt.PhpVal {
	mut var_existing_refunds_mutated := var_existing_refunds
	mut var_refunded_qty_by_item := rt.new_array()
	mut iter_3 := var_existing_refunds_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_existing_refund := item_3.val
		mut iter_4 := rt.call_method(var_existing_refund, 'get_items', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'line_item' },
				rt.ArrayItem{ key: none, val: 'fee' }]),
		]).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_refund_item := item_4.val
			mut var_item_id := rt.call_method(var_refund_item, 'get_meta', [
				rt.new_string('_refunded_item_id'),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_item_id)))) {
				continue
			}
			if !(var_refunded_qty_by_item.array_isset(var_item_id)) {
				var_refunded_qty_by_item.array_set(var_item_id, 0)
			}
			var_refunded_qty_by_item.array_get(var_item_id) = rt.add(var_refunded_qty_by_item.array_get(var_item_id), rt.call_function('abs', [
				rt.call_method(var_refund_item, 'get_quantity', []rt.PhpVal{}),
			]))
		}
	}
	return var_refunded_qty_by_item.clone()
}

fn Class_WC_SmoothGenerator_Generator_Order.build_refund_line_item(var_item rt.PhpVal, var_refund_qty rt.PhpVal, var_original_qty rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_refund_qty_mutated := var_refund_qty
	mut var_original_qty_mutated := var_original_qty
	mut var_taxes := rt.call_method(var_item_mutated, 'get_taxes', []rt.PhpVal{})
	mut var_refund_tax := rt.new_array()
	if !(!rt.is_true(var_taxes.array_get(rt.new_string('total'))))
		&& rt.is_true(rt.greater(var_original_qty_mutated, rt.new_int(0))) {
		mut iter_5 := var_taxes.array_get(rt.new_string('total')).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_tax_amount := item_5.val
			mut var_tax_id := item_5.key
			mut var_tax_per_unit := rt.div(var_tax_amount, var_original_qty_mutated)
			var_refund_tax.array_set(var_tax_id, rt.mul(rt.mul(var_tax_per_unit,
				var_refund_qty_mutated), -1))
		}
	}
	mut var_total_per_unit := if rt.is_true(rt.greater(var_original_qty_mutated, rt.new_int(0))) {
		rt.div(rt.call_method(var_item_mutated, 'get_total', []rt.PhpVal{}),
			var_original_qty_mutated)
	} else {
		rt.new_int(0)
	}
	mut var_refund_total := rt.mul(var_total_per_unit, var_refund_qty_mutated)
	return rt.create_array([rt.ArrayItem{ key: 'qty', val: var_refund_qty_mutated },
		rt.ArrayItem{ key: 'refund_total', val: rt.mul(var_refund_total, -1) },
		rt.ArrayItem{ key: 'refund_tax', val: var_refund_tax }])
}

fn Class_WC_SmoothGenerator_Generator_Order.build_full_refund_items(var_order rt.PhpVal, var_refunded_qty_by_item rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_refunded_qty_by_item_mutated := var_refunded_qty_by_item
	mut var_line_items := rt.new_array()
	mut iter_6 := rt.call_method(var_order_mutated, 'get_items', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'line_item' },
			rt.ArrayItem{ key: none, val: 'fee' }]),
	]).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_item := item_6.val
		mut var_item_id := item_6.key
		mut var_original_qty := rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})
		mut var_refunded_qty := if var_refunded_qty_by_item_mutated.array_isset(var_item_id) {
			var_refunded_qty_by_item_mutated.array_get(var_item_id)
		} else {
			rt.new_int(0)
		}
		mut var_remaining_qty := rt.sub(var_original_qty, var_refunded_qty)
		if rt.is_true(rt.less_equal(var_remaining_qty, rt.new_int(0)))
			|| rt.is_true(rt.less_equal(var_original_qty, rt.new_int(0))) {
			continue
		}
		var_line_items.array_set(var_item_id, Class_WC_SmoothGenerator_Generator_Order.build_refund_line_item(var_item.clone(),
			var_remaining_qty.clone(), var_original_qty.clone()))
	}
	return var_line_items.clone()
}

fn Class_WC_SmoothGenerator_Generator_Order.build_partial_refund_items(var_order rt.PhpVal, var_refunded_qty_by_item rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_refunded_qty_by_item_mutated := var_refunded_qty_by_item
	mut var_items := rt.call_method(var_order_mutated, 'get_items', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'line_item' },
			rt.ArrayItem{ key: none, val: 'fee' }]),
	])
	mut var_line_items := rt.new_array()
	mut var_refund_full_items := rt.new_bool((rt.call_function('wp_rand', [
		rt.new_int(0), rt.new_int(1)])).to_bool())
	if rt.is_true(var_refund_full_items) && var_items.clone().array_count() > 2 {
		mut var_items_array := rt.call_function('array_values', [
			var_items.clone()])
		mut var_num_to_refund := rt.call_function('wp_rand', [
			rt.new_int(1), rt.new_int(var_items_array.clone().array_count() - 1)])
		mut var_items_to_refund := rt.call_function('array_rand', [
			var_items_array.clone(), var_num_to_refund.clone()])
		if !(var_items_to_refund.clone().is_array()) {
			var_items_to_refund = rt.create_array([
				rt.ArrayItem{ key: none, val: var_items_to_refund },
			])
		}
		mut iter_7 := var_items_to_refund.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_index := item_7.val
			mut var_item := var_items_array.array_get(var_index)
			mut var_item_id := rt.call_method(var_item, 'get_id', []rt.PhpVal{})
			mut var_original_qty := rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})
			mut var_refunded_qty := if var_refunded_qty_by_item_mutated.array_isset(var_item_id) {
				var_refunded_qty_by_item_mutated.array_get(var_item_id)
			} else {
				rt.new_int(0)
			}
			mut var_remaining_qty := rt.sub(var_original_qty, var_refunded_qty)
			if rt.is_true(rt.less_equal(var_remaining_qty, rt.new_int(0)))
				|| rt.is_true(rt.less_equal(var_original_qty, rt.new_int(0))) {
				continue
			}
			var_line_items.array_set(var_item_id, Class_WC_SmoothGenerator_Generator_Order.build_refund_line_item(var_item.clone(),
				var_remaining_qty.clone(), var_original_qty.clone()))
		}
	} else {
		mut iter_8 := var_items.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_item := item_8.val
			mut var_item_id := item_8.key
			mut var_original_qty := rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})
			mut var_refunded_qty := if var_refunded_qty_by_item_mutated.array_isset(var_item_id) {
				var_refunded_qty_by_item_mutated.array_get(var_item_id)
			} else {
				rt.new_int(0)
			}
			mut var_remaining_qty := rt.sub(var_original_qty, var_refunded_qty)
			if rt.is_true(rt.less_equal(var_remaining_qty, rt.new_int(1)))
				|| rt.is_true(rt.less_equal(var_original_qty, rt.new_int(0))) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('line_item'), rt.call_method(var_item,
				'get_type', []rt.PhpVal{})))
			{
				mut var_refund_qty := rt.call_function('wp_rand', [
					rt.new_int(1), rt.sub(var_remaining_qty, rt.new_int(1))])
				var_line_items.array_set(var_item_id, Class_WC_SmoothGenerator_Generator_Order.build_refund_line_item(var_item.clone(),
					var_refund_qty.clone(), var_original_qty.clone()))
				break
			}
		}
		if !rt.is_true(var_line_items) && var_items.clone().array_count() > 0 {
			var_items_array = rt.call_function('array_values', [
				var_items.clone()])
			rt.call_function('shuffle', [var_items_array.clone()])
			mut iter_9 := var_items_array.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_item := item_9.val
				mut var_item_id := rt.call_method(var_item, 'get_id', []rt.PhpVal{})
				mut var_original_qty := rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})
				mut var_refunded_qty := if var_refunded_qty_by_item_mutated.array_isset(var_item_id) {
					var_refunded_qty_by_item_mutated.array_get(var_item_id)
				} else {
					rt.new_int(0)
				}
				mut var_remaining_qty := rt.sub(var_original_qty, var_refunded_qty)
				if rt.is_true(rt.less_equal(var_remaining_qty, rt.new_int(0)))
					|| rt.is_true(rt.less_equal(var_original_qty, rt.new_int(0))) {
					continue
				}
				var_line_items.array_set(var_item_id, Class_WC_SmoothGenerator_Generator_Order.build_refund_line_item(var_item.clone(),
					var_remaining_qty.clone(), var_original_qty.clone()))
				break
			}
		}
	}
	return var_line_items.clone()
}

fn Class_WC_SmoothGenerator_Generator_Order.calculate_refund_totals(var_line_items rt.PhpVal) rt.PhpVal {
	mut var_line_items_mutated := var_line_items
	mut var_refund_amount := rt.new_int(0)
	mut var_total_items := rt.new_int(0)
	mut var_total_qty := rt.new_int(0)
	mut iter_10 := var_line_items_mutated.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_item_data := item_10.val
		var_refund_amount = rt.add(var_refund_amount, rt.call_function('abs', [
			var_item_data.array_get(rt.new_string('refund_total')),
		]))
		rt.post_inc(var_total_items)
		var_total_qty = rt.add(var_total_qty, var_item_data.array_get(rt.new_string('qty')))
		if !(!rt.is_true(var_item_data.array_get(rt.new_string('refund_tax')))) {
			mut iter_11 := var_item_data.array_get(rt.new_string('refund_tax')).iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_tax_amount := item_11.val
				var_refund_amount = rt.add(var_refund_amount, rt.call_function('abs', [
					var_tax_amount.clone(),
				]))
			}
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'amount', val: rt.call_function('round', [
			var_refund_amount.clone(), rt.new_int(2)]) },
		rt.ArrayItem{ key: 'total_items', val: var_total_items },
		rt.ArrayItem{ key: 'total_qty', val: var_total_qty },
	])
}

fn Class_WC_SmoothGenerator_Generator_Order.calculate_refund_date(var_order rt.PhpVal, var_previous_refund rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_now := rt.call_function('time', []rt.PhpVal{})
	if rt.is_true(var_previous_refund) {
		mut var_base_timestamp := rt.call_function('strtotime', [
			rt.call_method(rt.call_method(var_previous_refund, 'get_date_created', []rt.PhpVal{}),
				'date', [rt.new_string('Y-m-d H:i:s')]),
		])
		mut var_max_timestamp := rt.call_function('min', [
			rt.add(var_base_timestamp, rt.mul(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.second_refund_max_days(),
				rt.get_constant('DAY_IN_SECONDS'))),
			var_now.clone(),
		])
		if rt.is_true(rt.less_equal(var_max_timestamp, var_base_timestamp)) {
			mut var_refund_timestamp := rt.add(var_base_timestamp,
				rt.get_constant('HOUR_IN_SECONDS'))
		} else {
			var_refund_timestamp = rt.call_function('wp_rand', [
				rt.add(var_base_timestamp, rt.new_int(1)),
				var_max_timestamp.clone(),
			])
		}
	} else {
		mut var_completion_timestamp := rt.call_function('strtotime', [
			rt.call_method(rt.call_method(var_order_mutated, 'get_date_completed', []rt.PhpVal{}),
				'date', [rt.new_string('Y-m-d H:i:s')]),
		])
		var_max_timestamp = rt.call_function('min', [
			rt.add(var_completion_timestamp, rt.mul(Class_WC_SmoothGenerator_Generator_WC_SmoothGenerator_Generator_Order.first_refund_max_days(),
				rt.get_constant('DAY_IN_SECONDS'))),
			var_now.clone(),
		])
		if rt.is_true(rt.less(var_max_timestamp, var_completion_timestamp)) {
			var_refund_timestamp = var_now.clone()
		} else if rt.is_true(rt.equal(var_max_timestamp, var_completion_timestamp)) {
			var_refund_timestamp = var_completion_timestamp.clone()
		} else {
			var_refund_timestamp = rt.call_function('wp_rand', [
				var_completion_timestamp.clone(), var_max_timestamp.clone()])
		}
	}
	return rt.call_function('date', [rt.new_string('Y-m-d H:i:s'),
		var_refund_timestamp.clone()])
}

fn Class_WC_SmoothGenerator_Generator_Order.generate_batch_dates(var_count rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_current := rt.call_function('date', [rt.new_string('Y-m-d'),
		rt.call_function('time', []rt.PhpVal{})])
	if !(!rt.is_true(var_args.array_get(rt.new_string('date-start'))))
		&& !rt.is_true(var_args.array_get(rt.new_string('date-end'))) {
		mut var_start := var_args.array_get(rt.new_string('date-start'))
		mut var_end := var_current.clone()
	} else if !(!rt.is_true(var_args.array_get(rt.new_string('date-start'))))
		&& !(!rt.is_true(var_args.array_get(rt.new_string('date-end')))) {
		var_start = var_args.array_get(rt.new_string('date-start'))
		var_end = var_args.array_get(rt.new_string('date-end'))
	} else {
		return rt.call_function('array_fill', [rt.new_int(0),
			var_count.clone(), var_current.clone()])
	}
	mut var_start_timestamp := rt.call_function('strtotime', [
		var_start.clone()])
	mut var_end_timestamp := rt.call_function('strtotime', [var_end.clone()])
	mut var_days_between := rt.new_int((rt.div(rt.sub(var_end_timestamp, var_start_timestamp),
		rt.get_constant('DAY_IN_SECONDS'))).to_i64())
	if rt.is_true(rt.identical(rt.new_int(0), var_days_between)) {
		return rt.call_function('array_fill', [rt.new_int(0),
			var_count.clone(),
			rt.call_function('date', [rt.new_string('Y-m-d'),
				var_start_timestamp.clone()])])
	}
	mut var_dates := rt.new_array()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_count))) { break
		 }
		mut var_random_days := rt.call_function('wp_rand', [rt.new_int(0),
			var_days_between.clone()])
		var_dates.array_push(rt.call_function('date', [rt.new_string('Y-m-d'),
			rt.add(var_start_timestamp, rt.mul(var_random_days, rt.get_constant('DAY_IN_SECONDS')))]))
		rt.post_inc(var_i)
	}
	rt.call_function('sort', [var_dates.clone()])
	return var_dates.clone()
}

struct Class_WC_SmoothGenerator_Generator_Generator {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WC_Order {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WC_Order_Item_Fee {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_OrderAttribution {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WC_Customer {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_Customer {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WC_Product_Query {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WC_Product_Variation {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_Coupon {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WP_CLI {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_generator_order(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Order {
	mut obj := &Class_WC_SmoothGenerator_Generator_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_generator(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Generator {
	mut obj := &Class_WC_SmoothGenerator_Generator_Generator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_order(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_WC_Order {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_order_item_fee(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_WC_Order_Item_Fee {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Order_Item_Fee{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_orderattribution(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_OrderAttribution {
	mut obj := &Class_WC_SmoothGenerator_Generator_OrderAttribution{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_customer(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_WC_Customer {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_customer(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Customer {
	mut obj := &Class_WC_SmoothGenerator_Generator_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_product_query(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_WC_Product_Query {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Product_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_product_variation(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_WC_Product_Variation {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Product_Variation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_coupon(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Coupon {
	mut obj := &Class_WC_SmoothGenerator_Generator_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wp_cli(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_WP_CLI {
	mut obj := &Class_WC_SmoothGenerator_Generator_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Generator_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(Class_WC_SmoothGenerator_Generator_Order.generate(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'batch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return Class_WC_SmoothGenerator_Generator_Order.batch(dispatch_arg_0, mut
				dispatch_arg_1)
		}
		'get_customer' {
			return Class_WC_SmoothGenerator_Generator_Order.get_customer()
		}
		'get_date_created' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.get_date_created(dispatch_arg_0)
		}
		'get_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.get_status(dispatch_arg_0)
		}
		'get_random_products' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_WC_SmoothGenerator_Generator_Order.get_random_products(dispatch_arg_0,
				dispatch_arg_1)
		}
		'get_or_create_coupon' {
			return rt.new_bool(Class_WC_SmoothGenerator_Generator_Order.get_or_create_coupon())
		}
		'create_refund' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(Class_WC_SmoothGenerator_Generator_Order.create_refund(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'calculate_refunded_quantities' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.calculate_refunded_quantities(dispatch_arg_0)
		}
		'build_refund_line_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.build_refund_line_item(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'build_full_refund_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.build_full_refund_items(dispatch_arg_0,
				dispatch_arg_1)
		}
		'build_partial_refund_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.build_partial_refund_items(dispatch_arg_0,
				dispatch_arg_1)
		}
		'calculate_refund_totals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.calculate_refund_totals(dispatch_arg_0)
		}
		'calculate_refund_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.calculate_refund_date(dispatch_arg_0,
				dispatch_arg_1)
		}
		'generate_batch_dates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Order.generate_batch_dates(dispatch_arg_0,
				dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_SmoothGenerator_Generator_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Generator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Generator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Generator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Order_Item_Fee) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WC_Order_Item_Fee) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Order_Item_Fee) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_OrderAttribution) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_OrderAttribution) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_OrderAttribution) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Product_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WC_Product_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Product_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Product_Variation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WC_Product_Variation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Product_Variation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
