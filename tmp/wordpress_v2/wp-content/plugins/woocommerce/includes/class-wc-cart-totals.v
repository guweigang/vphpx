import rt

struct Class_WC_Cart_Totals {
	rt.PhpObjectBase
pub mut:
	cart                       rt.PhpVal = rt.new_null()
	items                      rt.PhpVal = rt.new_array()
	fees                       rt.PhpVal = rt.new_array()
	shipping                   rt.PhpVal = rt.new_array()
	coupons                    rt.PhpVal = rt.new_array()
	coupon_discount_totals     rt.PhpVal = rt.new_array()
	coupon_discount_tax_totals rt.PhpVal = rt.new_array()
	calculate_tax              bool
	totals                     rt.PhpVal = rt.new_array()
	item_tax_rates             rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Cart_Totals) construct(var_cart rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_cart.clone(), rt.new_string('WC_Cart')])))))
	{
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(rt.new_string('A valid WC_Cart object is required'))))
	}
	mut var_customer := rt.call_method(var_cart, 'get_customer', []rt.PhpVal{})
	mut var_is_customer_vat_exempt := rt.new_bool(rt.is_true(var_customer)
		&& rt.is_true(rt.call_method(var_customer, 'get_is_vat_exempt', []rt.PhpVal{})))
	this.cart = var_cart.clone()
	this.calculate_tax = rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_customer_vat_exempt))))
	this.calculate()
}

fn (mut this Class_WC_Cart_Totals) calculate() {
	this.calculate_item_totals()
	this.calculate_shipping_totals()
	this.calculate_fee_totals()
	this.calculate_totals()
}

fn (mut this Class_WC_Cart_Totals) get_default_item_props() rt.PhpVal {
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'object', val: rt.new_null() },
		rt.ArrayItem{ key: 'tax_class', val: '' },
		rt.ArrayItem{ key: 'taxable', val: false },
		rt.ArrayItem{ key: 'quantity', val: 0 },
		rt.ArrayItem{ key: 'product', val: false },
		rt.ArrayItem{ key: 'price_includes_tax', val: false },
		rt.ArrayItem{ key: 'subtotal', val: 0 },
		rt.ArrayItem{ key: 'subtotal_tax', val: 0 },
		rt.ArrayItem{ key: 'subtotal_taxes', val: rt.new_array() },
		rt.ArrayItem{ key: 'total', val: 0 },
		rt.ArrayItem{ key: 'total_tax', val: 0 },
		rt.ArrayItem{ key: 'taxes', val: rt.new_array() },
	]))
}

fn (mut this Class_WC_Cart_Totals) get_default_fee_props() rt.PhpVal {
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'object', val: rt.new_null() },
		rt.ArrayItem{ key: 'tax_class', val: '' },
		rt.ArrayItem{ key: 'taxable', val: false },
		rt.ArrayItem{ key: 'total_tax', val: 0 },
		rt.ArrayItem{ key: 'taxes', val: rt.new_array() },
	]))
}

fn (mut this Class_WC_Cart_Totals) get_default_shipping_props() rt.PhpVal {
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'object', val: rt.new_null() },
		rt.ArrayItem{ key: 'tax_class', val: '' },
		rt.ArrayItem{ key: 'taxable', val: false },
		rt.ArrayItem{ key: 'total', val: 0 },
		rt.ArrayItem{ key: 'total_tax', val: 0 },
		rt.ArrayItem{ key: 'taxes', val: rt.new_array() },
	]))
}

fn (mut this Class_WC_Cart_Totals) get_items_from_cart() {
	this.items = rt.new_array()
	mut iter_1 := rt.call_method(this.cart, 'get_cart', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_cart_item := item_1.val
		mut var_cart_item_key := item_1.key
		mut var_item := this.get_default_item_props()
		rt.set_property(var_item, 'key', var_cart_item_key.clone())
		rt.set_property(var_item, 'object', var_cart_item.clone())
		rt.set_property(var_item, 'tax_class', rt.call_method(var_cart_item.array_get(rt.new_string('data')),
			'get_tax_class', []rt.PhpVal{}))
		rt.set_property(var_item, 'taxable', rt.identical(Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), rt.call_method(var_cart_item.array_get(rt.new_string('data')),
			'get_tax_status', []rt.PhpVal{})))
		rt.set_property(var_item, 'price_includes_tax', rt.call_function('wc_prices_include_tax',
			[]rt.PhpVal{}))
		rt.set_property(var_item, 'quantity', var_cart_item.array_get(rt.new_string('quantity')))
		rt.set_property(var_item, 'price', rt.call_function('wc_add_number_precision_deep', [
			rt.new_float((rt.call_method(var_cart_item.array_get(rt.new_string('data')),
				'get_price', []rt.PhpVal{})).to_f64()) * rt.new_float((var_cart_item.array_get(rt.new_string('quantity'))).to_f64()),
		]))
		rt.set_property(var_item, 'product', var_cart_item.array_get(rt.new_string('data')))
		rt.set_property(var_item, 'tax_rates', this.get_item_tax_rates(var_item.clone()))
		this.items.array_set(var_cart_item_key, var_item.clone())
	}
}

fn (mut this Class_WC_Cart_Totals) get_tax_class_costs() rt.PhpVal {
	mut var_item_tax_classes := rt.call_function('wp_list_pluck', [this.items,
		rt.new_string('tax_class')])
	mut var_shipping_tax_classes := rt.call_function('wp_list_pluck', [this.shipping,
		rt.new_string('tax_class')])
	mut var_fee_tax_classes := rt.call_function('wp_list_pluck',
		[this.fees, rt.new_string('tax_class')])
	mut var_costs := rt.call_function('array_fill_keys', [
		rt.add(rt.add(var_item_tax_classes, var_shipping_tax_classes), var_fee_tax_classes),
		rt.new_int(0),
	])
	var_costs.array_set('non-taxable', 0)
	mut iter_2 := rt.add(rt.add(this.items, this.fees), this.shipping).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_item := item_2.val
		if rt.is_true(rt.greater(rt.new_int(0), rt.get_property(var_item, 'total'))) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_item, 'taxable'))))) {
			var_costs.array_get(rt.new_string('non-taxable')) = rt.add(var_costs.array_get(rt.new_string('non-taxable')), rt.get_property(var_item,
				'total'))
		} else if rt.is_true(rt.identical(rt.new_string('inherit'), rt.get_property(var_item,
			'tax_class')))
		{
			var_costs.array_get(rt.call_function('reset', [var_item_tax_classes.clone()])) = rt.add(var_costs.array_get(rt.call_function('reset', [
				var_item_tax_classes.clone(),
			])), rt.get_property(var_item, 'total'))
		} else {
			var_costs.array_get(rt.get_property(var_item, 'tax_class')) = rt.add(var_costs.array_get(rt.get_property(var_item,
				'tax_class')), rt.get_property(var_item, 'total'))
		}
	}
	return rt.call_function('array_filter', [var_costs.clone()])
}

fn (mut this Class_WC_Cart_Totals) get_fees_from_cart() {
	this.fees = rt.new_array()
	rt.call_method(this.cart, 'calculate_fees', []rt.PhpVal{})
	mut var_fee_running_total := rt.new_int(0)
	mut iter_3 := rt.call_method(this.cart, 'get_fees', []rt.PhpVal{}).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_fee_object := item_3.val
		mut var_fee_key := item_3.key
		mut var_fee := this.get_default_fee_props()
		rt.set_property(var_fee, 'object', var_fee_object.clone())
		rt.set_property(var_fee, 'tax_class', rt.get_property(rt.get_property(var_fee, 'object'),
			'tax_class'))
		rt.set_property(var_fee, 'taxable', rt.get_property(rt.get_property(var_fee, 'object'),
			'taxable'))
		rt.set_property(var_fee, 'total', rt.call_function('wc_add_number_precision_deep', [
			rt.get_property(rt.get_property(var_fee, 'object'), 'amount'),
		]))
		if rt.is_true(rt.greater(rt.new_int(0), rt.get_property(var_fee, 'total'))) {
			mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
			mut iife_result_0 := iife_temp_0.round(rt.add(rt.add(this.get_total('items_total', true),
				var_fee_running_total), this.get_total('shipping_total', true)))
			mut var_max_discount := rt.mul(iife_result_0, -1)
			if rt.is_true(rt.less(rt.get_property(var_fee, 'total'), var_max_discount)) {
				rt.set_property(var_fee, 'total', var_max_discount.clone())
			}
		}
		var_fee_running_total = rt.add(var_fee_running_total, rt.get_property(var_fee, 'total'))
		if this.calculate_tax {
			if rt.is_true(rt.greater(rt.new_int(0), rt.get_property(var_fee, 'total'))) {
				mut var_tax_class_costs := this.get_tax_class_costs()
				mut var_total_cost := rt.call_function('array_sum', [
					var_tax_class_costs.clone()])
				if rt.is_true(var_total_cost) {
					mut iter_4 := var_tax_class_costs.iterator()
					for {
						item_4 := iter_4.next() or { break }
						mut var_tax_class_cost := item_4.val
						mut var_tax_class := item_4.key
						if rt.is_true(rt.identical(rt.new_string('non-taxable'), var_tax_class)) {
							continue
						}
						mut var_proportion := rt.div(var_tax_class_cost, var_total_cost)
						mut var_cart_discount_proportion := rt.mul(rt.get_property(var_fee, 'total'),
							var_proportion)
						mut iife_temp_1 := Class_WC_Tax{}
						mut iife_result_1 := iife_temp_1.get_rates(var_tax_class.clone())
						mut iife_temp_2 := Class_WC_Tax{}
						mut iife_result_2 := iife_temp_2.calc_tax(rt.mul(rt.get_property(var_fee,
							'total'), var_proportion), iife_result_1)
						rt.set_property(var_fee, 'taxes', rt.call_function('wc_array_merge_recursive_numeric', [
							rt.get_property(var_fee, 'taxes'),
							iife_result_2,
						]))
					}
				}
			} else if rt.is_true(rt.get_property(rt.get_property(var_fee, 'object'), 'taxable')) {
				mut iife_temp_3 := Class_WC_Tax{}
				mut iife_result_3 := iife_temp_3.get_rates(rt.get_property(var_fee, 'tax_class'), rt.call_method(this.cart,
					'get_customer', []rt.PhpVal{}))
				mut iife_temp_4 := Class_WC_Tax{}
				mut iife_result_4 := iife_temp_4.calc_tax(rt.get_property(var_fee, 'total'),
					iife_result_3, rt.new_bool(false))
				rt.set_property(var_fee, 'taxes', iife_result_4)
			}
		}
		rt.set_property(var_fee, 'taxes', rt.call_function('apply_filters', [
			rt.new_string('woocommerce_cart_totals_get_fees_from_cart_taxes'),
			rt.get_property(var_fee, 'taxes'),
			var_fee.clone(),
			rt.new_object('WC_Cart_Totals', []string{}, &this),
		]))
		rt.set_property(var_fee, 'total_tax', rt.call_function('array_sum', [
			rt.call_function('array_map', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Totals', []string{}, &this) },
					rt.ArrayItem{ key: none, val: 'round_line_tax' },
				]),
				rt.get_property(var_fee, 'taxes'),
			]),
		]))
		rt.set_property(rt.get_property(var_fee, 'object'), 'total', rt.call_function('wc_remove_number_precision_deep', [
			rt.get_property(var_fee, 'total'),
		]))
		rt.set_property(rt.get_property(var_fee, 'object'), 'tax_data', rt.call_function('wc_remove_number_precision_deep', [
			rt.get_property(var_fee, 'taxes'),
		]))
		rt.set_property(rt.get_property(var_fee, 'object'), 'tax', rt.call_function('wc_remove_number_precision_deep', [
			rt.get_property(var_fee, 'total_tax'),
		]))
		this.fees.array_set(var_fee_key, var_fee.clone())
	}
}

fn (mut this Class_WC_Cart_Totals) get_shipping_from_cart() {
	mut var_default_shipping_props := this.get_default_shipping_props()
	closure_6_fn := fn [var_default_shipping_props] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_shipping_object := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_shipping_line := var_default_shipping_props.dup()
		rt.set_property(var_shipping_line, 'object', var_shipping_object.clone())
		rt.set_property(var_shipping_line, 'tax_class', rt.call_function('get_option', [
			rt.new_string('woocommerce_shipping_tax_class'),
			rt.new_string('inherit'),
		]))
		rt.set_property(var_shipping_line, 'taxable', rt.new_bool(true))
		rt.set_property(var_shipping_line, 'total', rt.call_function('wc_add_number_precision_deep', [
			rt.get_property(var_shipping_object, 'cost'),
		]))
		rt.set_property(var_shipping_line, 'taxes', rt.call_function('array_map', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Totals', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'round_item_subtotal' },
			]),
			rt.call_function('wc_add_number_precision_deep', [
				rt.get_property(var_shipping_object, 'taxes'),
				rt.new_bool(false),
			]),
		]))
		rt.set_property(var_shipping_line, 'total_tax', rt.call_function('array_sum', [
			rt.get_property(var_shipping_line, 'taxes'),
		]))
		return
	}
	closure_7_fn := fn [var_default_shipping_props] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_shipping_object := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_shipping_line := var_default_shipping_props.dup()
		rt.set_property(var_shipping_line, 'object', var_shipping_object.clone())
		rt.set_property(var_shipping_line, 'tax_class', rt.call_function('get_option', [
			rt.new_string('woocommerce_shipping_tax_class'),
			rt.new_string('inherit'),
		]))
		rt.set_property(var_shipping_line, 'taxable', rt.new_bool(true))
		rt.set_property(var_shipping_line, 'total', rt.call_function('wc_add_number_precision_deep', [
			rt.get_property(var_shipping_object, 'cost'),
		]))
		rt.set_property(var_shipping_line, 'taxes', rt.call_function('array_map', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Totals', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'round_item_subtotal' },
			]),
			rt.call_function('wc_add_number_precision_deep', [
				rt.get_property(var_shipping_object, 'taxes'),
				rt.new_bool(false),
			]),
		]))
		rt.set_property(var_shipping_line, 'total_tax', rt.call_function('array_sum', [
			rt.get_property(var_shipping_line, 'taxes'),
		]))
		return
	}
	this.shipping = rt.call_function('array_map', [rt.new_closure(closure_6_fn),
		rt.call_method(this.cart, 'calculate_shipping', []rt.PhpVal{})])
}

fn (mut this Class_WC_Cart_Totals) get_coupons_from_cart() {
	this.coupons = rt.call_method(this.cart, 'get_coupons', []rt.PhpVal{})
	mut iter_5 := this.coupons.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_coupon := item_5.val
		mut switch_val_1 := rt.call_method(var_coupon, 'get_discount_type', []rt.PhpVal{})
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('fixed_product'))) {
			rt.set_property(var_coupon, 'sort', rt.new_int(1))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('percent'))) {
			rt.set_property(var_coupon, 'sort', rt.new_int(2))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('fixed_cart'))) {
			rt.set_property(var_coupon, 'sort', rt.new_int(3))
		} else {
			rt.set_property(var_coupon, 'sort', rt.new_int(0))
		}
		rt.set_property(var_coupon, 'sort', rt.call_function('apply_filters', [
			rt.new_string('woocommerce_coupon_sort'),
			rt.get_property(var_coupon, 'sort'),
			var_coupon.clone(),
		]))
	}
	rt.call_function('uasort', [this.coupons,
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Totals', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'sort_coupons_callback' },
		])])
}

fn (mut this Class_WC_Cart_Totals) sort_coupons_callback(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if rt.is_true(rt.identical(rt.get_property(var_a, 'sort'), rt.get_property(var_b, 'sort'))) {
		if rt.is_true(rt.identical(rt.call_method(var_a, 'get_limit_usage_to_x_items',
			[]rt.PhpVal{}), rt.call_method(var_b, 'get_limit_usage_to_x_items', []rt.PhpVal{})))
		{
			if rt.is_true(rt.identical(rt.call_method(var_a, 'get_amount', []rt.PhpVal{}), rt.call_method(var_b,
				'get_amount', []rt.PhpVal{})))
			{
				return (rt.sub(rt.call_method(var_b, 'get_id', []rt.PhpVal{}), rt.call_method(var_a,
					'get_id', []rt.PhpVal{}))).to_i64()
			}
			return if rt.is_true(rt.less(rt.call_method(var_a, 'get_amount', []rt.PhpVal{}), rt.call_method(var_b,
				'get_amount', []rt.PhpVal{})))
			{
				-1
			} else {
				1
			}
		}
		return if rt.is_true(rt.less(rt.call_method(var_a, 'get_limit_usage_to_x_items',
			[]rt.PhpVal{}), rt.call_method(var_b, 'get_limit_usage_to_x_items', []rt.PhpVal{})))
		{
			-1
		} else {
			1
		}
	}
	return if rt.is_true(rt.less(rt.get_property(var_a, 'sort'), rt.get_property(var_b, 'sort'))) {
		-1
	} else {
		1
	}
}

fn (mut this Class_WC_Cart_Totals) remove_item_base_taxes(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	if rt.is_true(rt.get_property(var_item_mutated, 'price_includes_tax'))
		&& rt.is_true(rt.get_property(var_item_mutated, 'taxable')) {
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_adjust_non_base_location_prices'),
			rt.new_bool(true),
		]))
		{
			mut iife_temp_7 := Class_WC_Tax{}
			mut iife_result_7 := iife_temp_7.get_base_tax_rates(rt.call_method(rt.get_property(var_item_mutated,
				'product'), 'get_tax_class', [rt.new_string('unfiltered')]))
			mut var_base_tax_rates := iife_result_7
		} else {
			var_base_tax_rates = rt.get_property(var_item_mutated, 'tax_rates')
		}
		mut iife_temp_8 := Class_WC_Tax{}
		mut iife_result_8 := iife_temp_8.calc_tax(rt.get_property(var_item_mutated, 'price'),
			var_base_tax_rates.clone(), rt.new_bool(true))
		mut var_taxes := iife_result_8
		mut iife_temp_9 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
		mut iife_result_9 := iife_temp_9.round(rt.sub(rt.get_property(var_item_mutated, 'price'), rt.call_function('array_sum', [
			var_taxes.clone(),
		])))
		rt.set_property(var_item_mutated, 'price', iife_result_9)
		rt.set_property(var_item_mutated, 'price_includes_tax', rt.new_bool(false))
	}
	return var_item_mutated.clone()
}

fn (mut this Class_WC_Cart_Totals) adjust_non_base_location_price(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	if rt.is_true(rt.get_property(var_item_mutated, 'price_includes_tax'))
		&& rt.is_true(rt.get_property(var_item_mutated, 'taxable')) {
		mut iife_temp_10 := Class_WC_Tax{}
		mut iife_result_10 := iife_temp_10.get_base_tax_rates(rt.call_method(rt.get_property(var_item_mutated,
			'product'), 'get_tax_class', [rt.new_string('unfiltered')]))
		mut var_base_tax_rates := iife_result_10
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_item_mutated,
			'tax_rates'), var_base_tax_rates))))
		{
			mut iife_temp_11 := Class_WC_Tax{}
			mut iife_result_11 := iife_temp_11.calc_tax(rt.get_property(var_item_mutated, 'price'),
				var_base_tax_rates.clone(), rt.new_bool(true))
			mut var_taxes := iife_result_11
			mut iife_temp_12 := Class_WC_Tax{}
			mut iife_result_12 := iife_temp_12.calc_tax(rt.sub(rt.get_property(var_item_mutated,
				'price'), rt.call_function('array_sum', [var_taxes.clone()])), rt.get_property(var_item_mutated,
				'tax_rates'), rt.new_bool(false))
			mut var_new_taxes := iife_result_12
			rt.set_property(var_item_mutated, 'price', rt.add(rt.sub(rt.get_property(var_item_mutated,
				'price'), rt.call_function('array_sum', [var_taxes.clone()])), rt.call_function('array_sum', [
				var_new_taxes.clone(),
			])))
		}
	}
	return var_item_mutated.clone()
}

fn (mut this Class_WC_Cart_Totals) get_discounted_price_in_cents(var_item_key rt.PhpVal) rt.PhpVal {
	mut var_item := this.items.array_get(var_item_key)
	mut var_price := if this.coupon_discount_totals.array_isset(var_item_key) {
		rt.sub(rt.get_property(var_item, 'price'),
			this.coupon_discount_totals.array_get(var_item_key))
	} else {
		rt.get_property(var_item, 'price')
	}
	return var_price.clone()
}

fn (mut this Class_WC_Cart_Totals) get_item_tax_rates(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{}))))) {
		return rt.new_array()
	}
	mut var_tax_class := rt.call_method(rt.get_property(var_item_mutated, 'product'),
		'get_tax_class', []rt.PhpVal{})
	mut iife_temp_13 := Class_WC_Tax{}
	mut iife_result_13 := iife_temp_13.get_rates(rt.call_method(rt.get_property(var_item_mutated,
		'product'), 'get_tax_class', []rt.PhpVal{}), rt.call_method(this.cart, 'get_customer',
		[]rt.PhpVal{}))
	mut var_item_tax_rates := if this.item_tax_rates.array_isset(var_tax_class) {
		this.item_tax_rates.array_get(var_tax_class)
	} else {
		this.item_tax_rates.array_set(var_tax_class, iife_result_13)
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_totals_get_item_tax_rates'),
		var_item_tax_rates.clone(),
		var_item_mutated.clone(),
		this.cart,
	])
}

fn (mut this Class_WC_Cart_Totals) get_item_costs_by_tax_class() rt.PhpVal {
	mut var_tax_classes := rt.create_array([rt.ArrayItem{ key: 'non-taxable', val: 0 }])
	mut iter_6 := rt.add(rt.add(this.items, this.fees), this.shipping).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_item := item_6.val
		if !(var_tax_classes.array_isset(rt.get_property(var_item, 'tax_class'))) {
			var_tax_classes.array_set(rt.get_property(var_item, 'tax_class'), 0)
		}
		if rt.is_true(rt.get_property(var_item, 'taxable')) {
			var_tax_classes.array_get(rt.get_property(var_item, 'tax_class')) = rt.add(var_tax_classes.array_get(rt.get_property(var_item,
				'tax_class')), rt.get_property(var_item, 'total'))
		} else {
			var_tax_classes.array_get(rt.new_string('non-taxable')) = rt.add(var_tax_classes.array_get(rt.new_string('non-taxable')), rt.get_property(var_item,
				'total'))
		}
	}
	return var_tax_classes.clone()
}

fn (mut this Class_WC_Cart_Totals) get_total(key string, in_cents bool) rt.PhpVal {
	mut var_totals := this.get_totals(in_cents)
	return if var_totals.array_isset(rt.new_string(key)) {
		var_totals.array_get(rt.new_string(key))
	} else {
		rt.new_int(0)
	}
}

fn (mut this Class_WC_Cart_Totals) set_total(var_key rt.PhpVal, var_total rt.PhpVal) {
	this.totals.array_set(var_key, var_total.clone())
}

fn (mut this Class_WC_Cart_Totals) get_totals(in_cents bool) rt.PhpVal {
	return if var_in_cents { this.totals } else { rt.call_function('wc_remove_number_precision_deep', [
			this.totals,
		]) }
}

fn (mut this Class_WC_Cart_Totals) get_values_for_total(var_field rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_values', [
		rt.call_function('wp_list_pluck', [this.items, var_field.clone()]),
	])
}

fn (mut this Class_WC_Cart_Totals) get_merged_taxes(in_cents bool, var_types rt.PhpVal) rt.PhpVal {
	mut var_types_mutated := var_types
	mut var_items := rt.new_array()
	mut var_taxes := rt.new_array()
	if rt.is_true(rt.new_bool(var_types_mutated.clone().is_string())) {
		var_types_mutated = rt.create_array([
			rt.ArrayItem{ key: none, val: var_types_mutated },
		])
	}
	mut iter_7 := var_types_mutated.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_type := item_7.val
		if !(rt.get_property(rt.new_object('WC_Cart_Totals', []string{}, &this),
			'{"nodeType":"Expr_Variable","line":589,"name":"type"}')).is_null() {
			var_items = rt.call_function('array_merge', [var_items.clone(),
				rt.get_property(rt.new_object('WC_Cart_Totals', []string{}, &this),
					'{"nodeType":"Expr_Variable","line":590,"name":"type"}')])
		}
	}
	mut iter_8 := var_items.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_item := item_8.val
		mut iter_9 := rt.get_property(var_item, 'taxes').iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_rate := item_9.val
			mut var_rate_id := item_9.key
			if !(var_taxes.array_isset(var_rate_id)) {
				var_taxes.array_set(var_rate_id, 0)
			}
			var_taxes.array_get(var_rate_id) = rt.add(var_taxes.array_get(var_rate_id),
				this.round_line_tax(var_rate.clone()))
		}
	}
	return if var_in_cents { var_taxes } else { rt.call_function('wc_remove_number_precision_deep', [
			var_taxes.clone(),
		]) }
}

fn (mut this Class_WC_Cart_Totals) round_merged_taxes(var_taxes rt.PhpVal) rt.PhpVal {
	mut var_taxes_mutated := var_taxes
	mut iter_10 := var_taxes_mutated.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_tax := item_10.val
		mut var_rate_id := item_10.key
		var_taxes_mutated.array_set(var_rate_id, this.round_line_tax(var_tax.clone()))
	}
	return var_taxes_mutated.clone()
}

fn (mut this Class_WC_Cart_Totals) combine_item_taxes(var_item_taxes rt.PhpVal) rt.PhpVal {
	mut var_merged_taxes := rt.new_array()
	mut iter_11 := var_item_taxes.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_taxes := item_11.val
		mut iter_12 := var_taxes.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_tax_amount := item_12.val
			mut var_tax_id := item_12.key
			if !(var_merged_taxes.array_isset(var_tax_id)) {
				var_merged_taxes.array_set(var_tax_id, 0)
			}
			var_merged_taxes.array_get(var_tax_id) = rt.add(var_merged_taxes.array_get(var_tax_id),
				var_tax_amount)
		}
	}
	return var_merged_taxes.clone()
}

fn (mut this Class_WC_Cart_Totals) calculate_item_totals() {
	this.get_items_from_cart()
	this.calculate_item_subtotals()
	this.calculate_discounts()
	mut iter_13 := this.items.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_item := item_13.val
		mut var_item_key := item_13.key
		rt.set_property(var_item, 'total', this.get_discounted_price_in_cents(var_item_key.clone()))
		rt.set_property(var_item, 'total_tax', rt.new_int(0))
		if rt.is_true(rt.call_function('has_filter', [
			rt.new_string('woocommerce_get_discounted_price'),
		]))
		{
			rt.set_property(var_item, 'total', rt.call_function('wc_add_number_precision', [
				rt.new_float((rt.call_function('apply_filters', [
					rt.new_string('woocommerce_get_discounted_price'),
					rt.call_function('wc_remove_number_precision', [
						rt.get_property(var_item, 'total'),
					]),
					rt.get_property(var_item, 'object'),
					this.cart,
				])).to_f64()),
			]))
		}
		if this.calculate_tax
			&& rt.is_true(rt.call_method(rt.get_property(var_item, 'product'), 'is_taxable', []rt.PhpVal{})) {
			mut iife_temp_14 := Class_WC_Tax{}
			mut iife_result_14 := iife_temp_14.calc_tax(rt.get_property(var_item, 'total'), rt.get_property(var_item,
				'tax_rates'), rt.get_property(var_item, 'price_includes_tax'))
			mut var_total_taxes := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_calculate_item_totals_taxes'),
				iife_result_14,
				var_item.clone(),
				rt.new_object('WC_Cart_Totals', []string{}, &this),
			])
			rt.set_property(var_item, 'taxes', var_total_taxes.clone())
			rt.set_property(var_item, 'total_tax', rt.call_function('array_sum', [
				rt.call_function('array_map', [
					rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Totals', []string{},
							&this) },
						rt.ArrayItem{ key: none, val: 'round_line_tax' },
					]),
					rt.get_property(var_item, 'taxes'),
				]),
			]))
			if rt.is_true(rt.get_property(var_item, 'price_includes_tax')) {
				rt.set_property(var_item, 'total', rt.sub(rt.get_property(var_item, 'total'), rt.call_function('array_sum', [
					rt.get_property(var_item, 'taxes'),
				])))
			}
		}
		rt.get_property(this.cart, 'cart_contents').array_get_mut(var_item_key).array_get_mut('line_tax_data').array_set('total', rt.call_function('wc_remove_number_precision_deep', [
			rt.get_property(var_item, 'taxes'),
		]))
		rt.get_property(this.cart, 'cart_contents').array_get_mut(var_item_key).array_set('line_total', rt.call_function('wc_remove_number_precision', [
			rt.get_property(var_item, 'total'),
		]))
		rt.get_property(this.cart, 'cart_contents').array_get_mut(var_item_key).array_set('line_tax', rt.call_function('wc_remove_number_precision', [
			rt.get_property(var_item, 'total_tax'),
		]))
	}
	mut var_items_total :=
		this.get_rounded_items_total(this.get_values_for_total(rt.new_string('total')))
	this.set_total(rt.new_string('items_total'), var_items_total.clone())
	this.set_total(rt.new_string('items_total_tax'), rt.call_function('array_sum', [
		rt.call_function('array_values', [
			rt.call_function('wp_list_pluck', [this.items, rt.new_string('total_tax')]),
		]),
	]))
	rt.call_method(this.cart, 'set_cart_contents_total', [
		this.get_total('items_total', false),
	])
	rt.call_method(this.cart, 'set_cart_contents_tax', [
		rt.call_function('array_sum', [
			this.get_merged_taxes(false, rt.new_string('items')),
		]),
	])
	rt.call_method(this.cart, 'set_cart_contents_taxes', [
		this.get_merged_taxes(false, rt.new_string('items')),
	])
}

fn (mut this Class_WC_Cart_Totals) calculate_item_subtotals() {
	mut var_merged_subtotal_taxes := rt.new_array()
	mut var_adjust_non_base_location_prices := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_adjust_non_base_location_prices'),
		rt.new_bool(true),
	])
	mut var_customer := rt.call_method(this.cart, 'get_customer', []rt.PhpVal{})
	mut var_is_customer_vat_exempt := rt.new_bool(rt.is_true(var_customer)
		&& rt.is_true(rt.call_method(var_customer, 'get_is_vat_exempt', []rt.PhpVal{})))
	mut iter_14 := this.items.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_item := item_14.val
		mut var_item_key := item_14.key
		if rt.is_true(rt.get_property(var_item, 'price_includes_tax')) {
			if rt.is_true(var_is_customer_vat_exempt) {
				var_item = this.remove_item_base_taxes(var_item.clone())
			} else if rt.is_true(var_adjust_non_base_location_prices) {
				var_item = this.adjust_non_base_location_price(var_item.clone())
			}
		}
		rt.set_property(var_item, 'subtotal', rt.get_property(var_item, 'price'))
		if this.calculate_tax
			&& rt.is_true(rt.call_method(rt.get_property(var_item, 'product'), 'is_taxable', []rt.PhpVal{})) {
			mut iife_temp_15 := Class_WC_Tax{}
			mut iife_result_15 := iife_temp_15.calc_tax(rt.get_property(var_item, 'subtotal'), rt.get_property(var_item,
				'tax_rates'), rt.get_property(var_item, 'price_includes_tax'))
			rt.set_property(var_item, 'subtotal_taxes', iife_result_15)
			rt.set_property(var_item, 'subtotal_tax', rt.call_function('array_sum', [
				rt.call_function('array_map', [
					rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart_Totals', []string{},
							&this) },
						rt.ArrayItem{ key: none, val: 'round_line_tax' },
					]),
					rt.get_property(var_item, 'subtotal_taxes'),
				]),
			]))
			if rt.is_true(rt.get_property(var_item, 'price_includes_tax')) {
				rt.set_property(var_item, 'subtotal', rt.sub(rt.get_property(var_item, 'subtotal'), rt.call_function('array_sum', [
					rt.get_property(var_item, 'subtotal_taxes'),
				])))
			}
			mut iter_15 := rt.get_property(var_item, 'subtotal_taxes').iterator()
			for {
				item_15 := iter_15.next() or { break }
				mut var_rate := item_15.val
				mut var_rate_id := item_15.key
				if !(var_merged_subtotal_taxes.array_isset(var_rate_id)) {
					var_merged_subtotal_taxes.array_set(var_rate_id, 0)
				}
				var_merged_subtotal_taxes.array_get(var_rate_id) = rt.add(var_merged_subtotal_taxes.array_get(var_rate_id),
					this.round_line_tax(var_rate.clone()))
			}
		}
		rt.get_property(this.cart, 'cart_contents').array_get_mut(var_item_key).array_set('line_tax_data', rt.create_array([
			rt.ArrayItem{ key: 'subtotal', val: rt.call_function('wc_remove_number_precision_deep', [
				rt.get_property(var_item, 'subtotal_taxes'),
			]) },
		]))
		rt.get_property(this.cart, 'cart_contents').array_get_mut(var_item_key).array_set('line_subtotal', rt.call_function('wc_remove_number_precision', [
			rt.get_property(var_item, 'subtotal'),
		]))
		rt.get_property(this.cart, 'cart_contents').array_get_mut(var_item_key).array_set('line_subtotal_tax', rt.call_function('wc_remove_number_precision', [
			rt.get_property(var_item, 'subtotal_tax'),
		]))
	}
	mut var_items_subtotal :=
		this.get_rounded_items_total(this.get_values_for_total(rt.new_string('subtotal')))
	this.set_total(rt.new_string('items_subtotal'), var_items_subtotal.clone())
	this.set_total(rt.new_string('items_subtotal_tax'), rt.call_function('array_sum', [
		var_merged_subtotal_taxes.clone(),
	]))
	rt.call_method(this.cart, 'set_subtotal', [this.get_total('items_subtotal', false)])
	rt.call_method(this.cart, 'set_subtotal_tax', [
		this.get_total('items_subtotal_tax', false),
	])
}

fn (mut this Class_WC_Cart_Totals) calculate_discounts() {
	this.get_coupons_from_cart()
	mut var_discounts := create_wc_discounts(this.cart)
	var_discounts.set_items(this.items)
	mut iter_16 := this.coupons.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_coupon := item_16.val
		var_discounts.apply_coupon(var_coupon.clone())
	}
	mut var_coupon_discount_amounts := var_discounts.get_discounts_by_coupon(rt.new_bool(true))
	mut var_coupon_discount_tax_amounts := rt.new_array()
	if this.calculate_tax {
		mut iter_17 := var_discounts.get_discounts(rt.new_bool(true)).iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_coupon_discounts := item_17.val
			mut var_coupon_code := item_17.key
			var_coupon_discount_tax_amounts.array_set(var_coupon_code, 0)
			mut iter_18 := var_coupon_discounts.iterator()
			for {
				item_18 := iter_18.next() or { break }
				mut var_coupon_discount := item_18.val
				mut var_item_key := item_18.key
				mut var_item := this.items.array_get(var_item_key)
				if rt.is_true(rt.call_method(rt.get_property(var_item, 'product'), 'is_taxable',
					[]rt.PhpVal{}))
				{
					mut iife_temp_16 := Class_WC_Tax{}
					mut iife_result_16 := iife_temp_16.calc_tax(var_coupon_discount.clone(), rt.get_property(var_item,
						'tax_rates'), rt.get_property(var_item, 'price_includes_tax'))
					mut iife_temp_17 := Class_WC_Tax{}
					mut iife_result_17 := iife_temp_17.calc_tax(var_coupon_discount.clone(), rt.get_property(var_item,
						'tax_rates'), rt.get_property(var_item, 'price_includes_tax'))
					mut var_item_tax := rt.call_function('array_sum', [iife_result_16])
					var_coupon_discount_tax_amounts.array_get(var_coupon_code) = rt.add(var_coupon_discount_tax_amounts.array_get(var_coupon_code),
						var_item_tax)
					if rt.is_true(rt.get_property(var_item, 'price_includes_tax')) {
						var_coupon_discount_amounts.array_get(var_coupon_code) = rt.sub(var_coupon_discount_amounts.array_get(var_coupon_code),
							var_item_tax)
					}
				}
			}
		}
	}
	this.coupon_discount_totals =
		rt.cast_array(var_discounts.get_discounts_by_item(rt.new_bool(true)))
	this.coupon_discount_tax_totals = var_coupon_discount_tax_amounts.clone()
	if rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{})) {
		this.set_total(rt.new_string('discounts_total'), rt.sub(rt.call_function('array_sum', [
			this.coupon_discount_totals,
		]), rt.call_function('array_sum', [this.coupon_discount_tax_totals])))
		this.set_total(rt.new_string('discounts_tax_total'), rt.call_function('array_sum', [
			this.coupon_discount_tax_totals,
		]))
	} else {
		this.set_total(rt.new_string('discounts_total'), rt.call_function('array_sum', [
			this.coupon_discount_totals,
		]))
		this.set_total(rt.new_string('discounts_tax_total'), rt.call_function('array_sum', [
			this.coupon_discount_tax_totals,
		]))
	}
	rt.call_method(this.cart, 'set_coupon_discount_totals', [
		rt.call_function('wc_remove_number_precision_deep', [
			var_coupon_discount_amounts.clone()]),
	])
	rt.call_method(this.cart, 'set_coupon_discount_tax_totals', [
		rt.call_function('wc_remove_number_precision_deep', [
			var_coupon_discount_tax_amounts.clone()]),
	])
	rt.call_method(this.cart, 'set_discount_total', [
		this.get_total('discounts_total', false),
	])
	rt.call_method(this.cart, 'set_discount_tax', [
		this.get_total('discounts_tax_total', false),
	])
}

fn (mut this Class_WC_Cart_Totals) calculate_fee_totals() {
	this.get_fees_from_cart()
	this.set_total(rt.new_string('fees_total'), rt.call_function('array_sum', [
		rt.call_function('wp_list_pluck', [this.fees, rt.new_string('total')]),
	]))
	this.set_total(rt.new_string('fees_total_tax'), rt.call_function('array_sum', [
		rt.call_function('wp_list_pluck', [this.fees, rt.new_string('total_tax')]),
	]))
	rt.call_method(rt.call_method(this.cart, 'fees_api', []rt.PhpVal{}), 'set_fees', [
		rt.call_function('wp_list_pluck', [this.fees, rt.new_string('object')]),
	])
	rt.call_method(this.cart, 'set_fee_total', [
		rt.call_function('wc_remove_number_precision_deep', [
			rt.call_function('array_sum', [
				rt.call_function('wp_list_pluck', [this.fees, rt.new_string('total')]),
			]),
		]),
	])
	rt.call_method(this.cart, 'set_fee_tax', [
		rt.call_function('wc_remove_number_precision_deep', [
			rt.call_function('array_sum', [
				rt.call_function('wp_list_pluck', [this.fees, rt.new_string('total_tax')]),
			]),
		]),
	])
	rt.call_method(this.cart, 'set_fee_taxes', [
		rt.call_function('wc_remove_number_precision_deep', [
			this.combine_item_taxes(rt.call_function('wp_list_pluck',
				[this.fees, rt.new_string('taxes')])),
		]),
	])
}

fn (mut this Class_WC_Cart_Totals) calculate_shipping_totals() {
	this.get_shipping_from_cart()
	this.set_total(rt.new_string('shipping_total'), rt.call_function('array_sum', [
		rt.call_function('wp_list_pluck', [this.shipping, rt.new_string('total')]),
	]))
	this.set_total(rt.new_string('shipping_tax_total'), rt.call_function('array_sum', [
		rt.call_function('wp_list_pluck', [this.shipping, rt.new_string('total_tax')]),
	]))
	rt.call_method(this.cart, 'set_shipping_total', [
		this.get_total('shipping_total', false),
	])
	rt.call_method(this.cart, 'set_shipping_tax', [
		this.get_total('shipping_tax_total', false),
	])
	rt.call_method(this.cart, 'set_shipping_taxes', [
		rt.call_function('wc_remove_number_precision_deep', [
			this.combine_item_taxes(rt.call_function('wp_list_pluck', [this.shipping,
				rt.new_string('taxes')])),
		]),
	])
}

fn (mut this Class_WC_Cart_Totals) calculate_totals() {
	mut iife_temp_18 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_18 := iife_temp_18.round(rt.add(rt.add(rt.add(this.get_total('items_total', true),
		this.get_total('fees_total', true)), this.get_total('shipping_total', true)), rt.call_function('array_sum', [
		this.get_merged_taxes(true, rt.new_null()),
	])), rt.new_int(0))
	this.set_total(rt.new_string('total'), iife_result_18)
	mut var_items_tax := rt.call_function('array_sum', [
		this.get_merged_taxes(false, rt.create_array([
			rt.ArrayItem{ key: none, val: 'items' },
		])),
	])
	mut iife_temp_19 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_19 := iife_temp_19.round(rt.call_function('array_sum', [
		this.get_merged_taxes(false, rt.create_array([
			rt.ArrayItem{ key: none, val: 'fees' },
			rt.ArrayItem{ key: none, val: 'shipping' },
		])),
	]), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
	mut var_shipping_and_fee_taxes := iife_result_19
	rt.call_method(this.cart, 'set_total_tax', [
		rt.add(var_items_tax, var_shipping_and_fee_taxes),
	])
	if rt.is_true(rt.call_function('has_action', [
		rt.new_string('woocommerce_calculate_totals'),
	]))
	{
		rt.call_function('do_action', [rt.new_string('woocommerce_calculate_totals'), this.cart])
	}
	rt.call_method(this.cart, 'set_total', [
		rt.call_function('max', [rt.new_int(0),
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_calculated_total'),
				this.get_total('total', false),
				this.cart,
			])]),
	])
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_WC_Discounts {
	rt.PhpObjectBase
}

fn create_wc_cart_totals(arg_0 rt.PhpVal) &Class_WC_Cart_Totals {
	mut obj := &Class_WC_Cart_Totals{
		PhpObjectBase:              rt.PhpObjectBase{}
		cart:                       rt.new_null()
		items:                      rt.new_array()
		fees:                       rt.new_array()
		shipping:                   rt.new_array()
		coupons:                    rt.new_array()
		coupon_discount_totals:     rt.new_array()
		coupon_discount_tax_totals: rt.new_array()
		calculate_tax:              false
		totals:                     rt.new_array()
		item_tax_rates:             rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_discounts(_args ...rt.PhpVal) &Class_WC_Discounts {
	mut obj := &Class_WC_Discounts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Cart_Totals) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'calculate' {
			this.calculate()
			return rt.new_null()
		}
		'get_default_item_props' {
			return this.get_default_item_props()
		}
		'get_default_fee_props' {
			return this.get_default_fee_props()
		}
		'get_default_shipping_props' {
			return this.get_default_shipping_props()
		}
		'get_items_from_cart' {
			this.get_items_from_cart()
			return rt.new_null()
		}
		'get_tax_class_costs' {
			return this.get_tax_class_costs()
		}
		'get_fees_from_cart' {
			this.get_fees_from_cart()
			return rt.new_null()
		}
		'get_shipping_from_cart' {
			this.get_shipping_from_cart()
			return rt.new_null()
		}
		'get_coupons_from_cart' {
			this.get_coupons_from_cart()
			return rt.new_null()
		}
		'sort_coupons_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.sort_coupons_callback(dispatch_arg_0, dispatch_arg_1))
		}
		'remove_item_base_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_item_base_taxes(dispatch_arg_0)
		}
		'adjust_non_base_location_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.adjust_non_base_location_price(dispatch_arg_0)
		}
		'get_discounted_price_in_cents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_discounted_price_in_cents(dispatch_arg_0)
		}
		'get_item_tax_rates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_tax_rates(dispatch_arg_0)
		}
		'get_item_costs_by_tax_class' {
			return this.get_item_costs_by_tax_class()
		}
		'get_total' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_total(dispatch_arg_0, dispatch_arg_1)
		}
		'set_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_total(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_totals' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_totals(dispatch_arg_0)
		}
		'get_values_for_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_values_for_total(dispatch_arg_0)
		}
		'get_merged_taxes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_merged_taxes(dispatch_arg_0, dispatch_arg_1)
		}
		'round_merged_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.round_merged_taxes(dispatch_arg_0)
		}
		'combine_item_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.combine_item_taxes(dispatch_arg_0)
		}
		'calculate_item_totals' {
			this.calculate_item_totals()
			return rt.new_null()
		}
		'calculate_item_subtotals' {
			this.calculate_item_subtotals()
			return rt.new_null()
		}
		'calculate_discounts' {
			this.calculate_discounts()
			return rt.new_null()
		}
		'calculate_fee_totals' {
			this.calculate_fee_totals()
			return rt.new_null()
		}
		'calculate_shipping_totals' {
			this.calculate_shipping_totals()
			return rt.new_null()
		}
		'calculate_totals' {
			this.calculate_totals()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Cart_Totals) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cart' { return this.cart }
		'items' { return this.items }
		'fees' { return this.fees }
		'shipping' { return this.shipping }
		'coupons' { return this.coupons }
		'coupon_discount_totals' { return this.coupon_discount_totals }
		'coupon_discount_tax_totals' { return this.coupon_discount_tax_totals }
		'calculate_tax' { return rt.new_bool(this.calculate_tax) }
		'totals' { return this.totals }
		'item_tax_rates' { return this.item_tax_rates }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Cart_Totals) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cart' {
			this.cart = val
			return true
		}
		'items' {
			this.items = val
			return true
		}
		'fees' {
			this.fees = val
			return true
		}
		'shipping' {
			this.shipping = val
			return true
		}
		'coupons' {
			this.coupons = val
			return true
		}
		'coupon_discount_totals' {
			this.coupon_discount_totals = val
			return true
		}
		'coupon_discount_tax_totals' {
			this.coupon_discount_tax_totals = val
			return true
		}
		'calculate_tax' {
			this.calculate_tax = val.to_bool()
			return true
		}
		'totals' {
			this.totals = val
			return true
		}
		'item_tax_rates' {
			this.item_tax_rates = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Discounts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Discounts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Discounts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
