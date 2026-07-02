import rt

struct Class_WC_Discounts {
	rt.PhpObjectBase
pub mut:
	object    rt.PhpVal = rt.new_null()
	items     rt.PhpVal = rt.new_array()
	discounts rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Discounts) construct(var_object rt.PhpVal) {
	if rt.is_true(rt.call_function('is_a', [var_object.clone(),
		rt.new_string('WC_Cart')]))
	{
		this.set_items_from_cart(var_object.clone())
	} else if rt.is_true(rt.call_function('is_a', [var_object.clone(),
		rt.new_string('WC_Order')]))
	{
		this.set_items_from_order(var_object.clone())
	}
}

fn (mut this Class_WC_Discounts) set_items(var_items rt.PhpVal) {
	mut var_items_mutated := var_items
	this.items = var_items_mutated.clone()
	this.discounts = rt.new_array()
	rt.call_function('uasort', [this.items,
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Discounts', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'sort_by_price' },
		])])
}

fn (mut this Class_WC_Discounts) set_items_from_cart(var_cart rt.PhpVal) {
	this.items = rt.new_array()
	this.discounts = rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_cart.clone(), rt.new_string('WC_Cart')])))))
	{
		return
	}
	this.object = var_cart.clone()
	mut iter_1 := rt.call_method(var_cart, 'get_cart', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_cart_item := item_1.val
		mut var_key := item_1.key
		mut var_item := create_stdclass()
		rt.set_property(var_item, 'key', var_key.clone())
		rt.set_property(var_item, 'object', var_cart_item.clone())
		rt.set_property(var_item, 'product', var_cart_item.array_get(rt.new_string('data')))
		rt.set_property(var_item, 'quantity', var_cart_item.array_get(rt.new_string('quantity')))
		rt.set_property(var_item, 'price', rt.call_function('wc_add_number_precision_deep', [
			rt.new_float((rt.call_method(rt.get_property(var_item, 'product'), 'get_price',
				[]rt.PhpVal{})).to_f64()) * rt.new_float((rt.get_property(var_item, 'quantity')).to_f64()),
		]))
		this.items.array_set(var_key, var_item)
	}
	rt.call_function('uasort', [this.items,
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Discounts', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'sort_by_price' },
		])])
}

fn (mut this Class_WC_Discounts) set_items_from_order(var_order rt.PhpVal) {
	this.items = rt.new_array()
	this.discounts = rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_order.clone(), rt.new_string('WC_Order')])))))
	{
		return
	}
	this.object = var_order.clone()
	mut iter_2 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_order_item := item_2.val
		mut var_item := create_stdclass()
		rt.set_property(var_item, 'key', rt.call_method(var_order_item, 'get_id', []rt.PhpVal{}))
		rt.set_property(var_item, 'object', var_order_item.clone())
		rt.set_property(var_item, 'product', rt.call_method(var_order_item, 'get_product',
			[]rt.PhpVal{}))
		rt.set_property(var_item, 'quantity', rt.call_method(var_order_item, 'get_quantity',
			[]rt.PhpVal{}))
		rt.set_property(var_item, 'price', rt.call_function('wc_add_number_precision_deep', [
			rt.call_method(var_order_item, 'get_subtotal', []rt.PhpVal{}),
		]))
		if rt.is_true(rt.call_method(var_order, 'get_prices_include_tax', []rt.PhpVal{})) {
			rt.get_property(var_item, 'price') = rt.add(rt.get_property(var_item, 'price'), rt.call_function('wc_add_number_precision_deep', [
				rt.call_method(var_order_item, 'get_subtotal_tax', []rt.PhpVal{}),
			]))
		}
		this.items.array_set(rt.call_method(var_order_item, 'get_id', []rt.PhpVal{}), var_item)
	}
	rt.call_function('uasort', [this.items,
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Discounts', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'sort_by_price' },
		])])
}

fn (mut this Class_WC_Discounts) get_object() rt.PhpVal {
	return this.object
}

fn (mut this Class_WC_Discounts) get_items() rt.PhpVal {
	return this.items
}

fn (mut this Class_WC_Discounts) get_items_to_validate() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_coupon_get_items_to_validate'),
		this.get_items(),
		rt.new_object('WC_Discounts', []string{}, &this),
	])
}

fn (mut this Class_WC_Discounts) get_discount(var_key rt.PhpVal, in_cents bool) rt.PhpVal {
	mut var_item_discount_totals := this.get_discounts_by_item(in_cents)
	return if var_item_discount_totals.array_isset(var_key) {
		var_item_discount_totals.array_get(var_key)
	} else {
		rt.new_int(0)
	}
}

fn (mut this Class_WC_Discounts) get_discounts(in_cents bool) rt.PhpVal {
	mut var_discounts := this.discounts
	return if var_in_cents { var_discounts } else { rt.call_function('wc_remove_number_precision_deep', [
			var_discounts.clone(),
		]) }
}

fn (mut this Class_WC_Discounts) get_discounts_by_item(in_cents bool) rt.PhpVal {
	mut var_discounts := this.discounts
	mut var_item_discount_totals := rt.cast_array(rt.call_function('array_shift', [
		var_discounts.clone(),
	]))
	mut iter_3 := var_discounts.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_item_discounts := item_3.val
		mut iter_4 := var_item_discounts.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_item_discount := item_4.val
			mut var_item_key := item_4.key
			var_item_discount_totals.array_get(var_item_key) = rt.add(var_item_discount_totals.array_get(var_item_key),
				var_item_discount)
		}
	}
	return if var_in_cents { var_item_discount_totals } else { rt.call_function('wc_remove_number_precision_deep', [
			var_item_discount_totals.clone(),
		]) }
}

fn (mut this Class_WC_Discounts) get_discounts_by_coupon(in_cents bool) rt.PhpVal {
	mut var_coupon_discount_totals := rt.call_function('array_map', [
		rt.new_string('array_sum'),
		this.discounts,
	])
	return if var_in_cents { var_coupon_discount_totals } else { rt.call_function('wc_remove_number_precision_deep', [
			var_coupon_discount_totals.clone(),
		]) }
}

fn (mut this Class_WC_Discounts) get_discounted_price(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	return rt.call_function('wc_remove_number_precision_deep', [
		this.get_discounted_price_in_cents(var_item_mutated.clone()),
	])
}

fn (mut this Class_WC_Discounts) get_discounted_price_in_cents(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_0 := iife_temp_0.round(rt.sub(rt.get_property(var_item_mutated, 'price'), this.get_discount(rt.get_property(var_item_mutated,
		'key'), true)))
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_1 := iife_temp_1.round(rt.sub(rt.get_property(var_item_mutated, 'price'), this.get_discount(rt.get_property(var_item_mutated,
		'key'), true)))
	return rt.call_function('absint', [iife_result_0])
}

fn (mut this Class_WC_Discounts) apply_coupon(var_coupon rt.PhpVal, validate bool) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_coupon.clone(), rt.new_string('WC_Coupon')])))))
	{
		return (create_wp_error(rt.new_string('invalid_coupon'), rt.call_function('__', [
			rt.new_string('Invalid coupon'),
			rt.new_string('woocommerce'),
		]))).to_bool()
	}
	mut var_is_coupon_valid := rt.new_bool(if var_validate {
		this.is_coupon_valid(var_coupon.clone())
	} else {
		true
	})
	if rt.is_true(rt.call_function('is_wp_error', [var_is_coupon_valid.clone()])) {
		return var_is_coupon_valid.to_bool()
	}
	mut var_coupon_code := rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})
	if !(this.discounts.array_isset(var_coupon_code))
		|| !(this.discounts.array_get(var_coupon_code).is_array()) {
		this.discounts.array_set(var_coupon_code, rt.call_function('array_fill_keys', [
			rt.func_array_keys(this.items),
			rt.new_int(0),
		]))
	}
	mut var_items_to_apply := this.get_items_to_apply_coupon(var_coupon.clone())
	mut switch_val_1 := rt.call_method(var_coupon, 'get_discount_type', []rt.PhpVal{})
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('percent'))) {
		this.apply_coupon_percent(var_coupon.clone(), var_items_to_apply.clone())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('fixed_product'))) {
		this.apply_coupon_fixed_product(var_coupon.clone(), var_items_to_apply.clone(),
			rt.new_null())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('fixed_cart'))) {
		this.apply_coupon_fixed_cart(var_coupon.clone(), var_items_to_apply.clone(), rt.new_null())
	} else {
		this.apply_coupon_custom(var_coupon.clone(), var_items_to_apply.clone())
	}
	return true
}

fn (mut this Class_WC_Discounts) sort_by_price(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	mut var_price_1 := if rt.is_true(rt.greater(rt.get_property(var_a, 'quantity'), rt.new_int(1))) {
		rt.div(rt.get_property(var_a, 'price'), rt.get_property(var_a, 'quantity'))
	} else {
		rt.get_property(var_a, 'price')
	}
	mut var_price_2 := if rt.is_true(rt.greater(rt.get_property(var_b, 'quantity'), rt.new_int(1))) {
		rt.div(rt.get_property(var_b, 'price'), rt.get_property(var_b, 'quantity'))
	} else {
		rt.get_property(var_b, 'price')
	}
	if rt.is_true(rt.identical(var_price_1, var_price_2)) {
		return 0
	}
	return if rt.is_true(rt.less(var_price_1, var_price_2)) { 1 } else { -1 }
}

fn (mut this Class_WC_Discounts) filter_products_with_price(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	return rt.greater(this.get_discounted_price_in_cents(var_item_mutated.clone()), rt.new_int(0))
}

fn (mut this Class_WC_Discounts) get_items_to_apply_coupon(var_coupon rt.PhpVal) rt.PhpVal {
	mut var_items_to_apply := rt.new_array()
	mut iter_5 := this.get_items_to_validate().iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_item := item_5.val
		mut var_item_to_apply := var_item.dup()
		if rt.is_true(rt.identical(rt.new_int(0), this.get_discounted_price_in_cents(var_item_to_apply.clone())))
			|| rt.is_true(rt.greater_equal(rt.new_int(0), rt.get_property(var_item_to_apply, 'quantity'))) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_coupon, 'is_valid_for_product', [rt.get_property(var_item_to_apply, 'product'), rt.get_property(var_item_to_apply, 'object')])))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_coupon, 'is_valid_for_cart', []rt.PhpVal{}))))) {
			continue
		}
		var_items_to_apply.array_push(var_item_to_apply.clone())
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_coupon_get_items_to_apply'),
		var_items_to_apply.clone(),
		var_coupon.clone(),
		rt.new_object('WC_Discounts', []string{}, &this),
	])
}

fn (mut this Class_WC_Discounts) apply_coupon_percent(var_coupon rt.PhpVal, var_items_to_apply rt.PhpVal) rt.PhpVal {
	mut var_items_to_apply_mutated := var_items_to_apply
	mut var_total_discount := rt.new_int(0)
	mut var_cart_total := rt.new_int(0)
	mut var_limit_usage_qty := rt.new_int(0)
	mut var_applied_count := rt.new_int(0)
	mut var_adjust_final_discount := rt.new_bool(true)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.call_method(var_coupon,
		'get_limit_usage_to_x_items', []rt.PhpVal{})))))
	{
		var_limit_usage_qty = rt.call_method(var_coupon, 'get_limit_usage_to_x_items',
			[]rt.PhpVal{})
	}
	mut var_coupon_amount := rt.call_method(var_coupon, 'get_amount', []rt.PhpVal{})
	mut iter_6 := var_items_to_apply_mutated.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_item := item_6.val
		mut var_discounted_price := this.get_discounted_price_in_cents(var_item.clone())
		mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
		mut iife_result_2 := iife_temp_2.round(rt.get_property(var_item, 'price'))
		mut var_price_to_discount := if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_calc_discounts_sequentially'),
			rt.new_string('no'),
		])))
		{ var_discounted_price } else { iife_result_2 }
		mut var_apply_quantity := if rt.is_true(var_limit_usage_qty)
			&& rt.is_true(rt.less(rt.sub(var_limit_usage_qty, var_applied_count), rt.get_property(var_item, 'quantity'))) {
			rt.sub(var_limit_usage_qty, var_applied_count)
		} else {
			rt.get_property(var_item, 'quantity')
		}
		var_apply_quantity = rt.call_function('max', [rt.new_int(0),
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_coupon_get_apply_quantity'),
				var_apply_quantity.clone(),
				var_item.clone(),
				var_coupon.clone(),
				rt.new_object('WC_Discounts', []string{}, &this),
			])])
		var_price_to_discount = rt.mul(rt.div(var_price_to_discount, rt.get_property(var_item,
			'quantity')), var_apply_quantity)
		mut var_discount := rt.call_function('floor', [
			rt.mul(var_price_to_discount, rt.div(var_coupon_amount, rt.new_int(100))),
		])
		if rt.is_true(rt.call_function('is_a', [this.object, rt.new_string('WC_Cart')]))
			&& rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_coupon_get_discount_amount')])) {
			mut var_filtered_discount := rt.call_function('wc_add_number_precision', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_coupon_get_discount_amount'),
					rt.call_function('wc_remove_number_precision', [
						var_discount.clone()]),
					rt.call_function('wc_remove_number_precision', [
						var_price_to_discount.clone()]),
					rt.get_property(var_item, 'object'),
					rt.new_bool(false),
					var_coupon.clone(),
				]),
			])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_filtered_discount, var_discount)))) {
				var_discount = var_filtered_discount.clone()
				var_adjust_final_discount = rt.new_bool(false)
			}
		}
		var_discount = rt.call_function('wc_round_discount', [
			rt.call_function('min', [var_discounted_price.clone(),
				var_discount.clone()]),
			rt.new_int(0),
		])
		var_cart_total = rt.add(var_cart_total, var_price_to_discount)
		var_total_discount = rt.add(var_total_discount, var_discount)
		var_applied_count = rt.add(var_applied_count, var_apply_quantity)
		this.discounts.array_get(rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})).array_get(rt.get_property(var_item,
			'key')) = rt.add(this.discounts.array_get(rt.call_method(var_coupon, 'get_code',
			[]rt.PhpVal{})).array_get(rt.get_property(var_item, 'key')), var_discount)
	}
	mut var_cart_total_discount := rt.call_function('wc_round_discount', [
		rt.mul(var_cart_total, rt.div(var_coupon_amount, rt.new_int(100))),
		rt.new_int(0),
	])
	if rt.is_true(rt.less(var_total_discount, var_cart_total_discount))
		&& rt.is_true(var_adjust_final_discount) {
		var_total_discount = rt.add(var_total_discount, this.apply_coupon_remainder(var_coupon.clone(),
			var_items_to_apply_mutated.clone(), rt.sub(var_cart_total_discount, var_total_discount)))
	}
	return var_total_discount.clone()
}

fn (mut this Class_WC_Discounts) apply_coupon_fixed_product(var_coupon rt.PhpVal, var_items_to_apply rt.PhpVal, var_amount rt.PhpVal) rt.PhpVal {
	mut var_items_to_apply_mutated := var_items_to_apply
	mut var_amount_mutated := var_amount
	mut var_total_discount := rt.new_int(0)
	var_amount_mutated = if rt.is_true(var_amount_mutated) { var_amount_mutated } else { rt.call_function('wc_add_number_precision', [
			rt.new_float((rt.call_method(var_coupon, 'get_amount', []rt.PhpVal{})).to_f64()),
		]) }
	mut var_limit_usage_qty := rt.new_int(0)
	mut var_applied_count := rt.new_int(0)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.call_method(var_coupon,
		'get_limit_usage_to_x_items', []rt.PhpVal{})))))
	{
		var_limit_usage_qty = rt.call_method(var_coupon, 'get_limit_usage_to_x_items',
			[]rt.PhpVal{})
	}
	mut iter_7 := var_items_to_apply_mutated.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_item := item_7.val
		mut var_discounted_price := this.get_discounted_price_in_cents(var_item.clone())
		mut var_price_to_discount := if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_calc_discounts_sequentially'),
			rt.new_string('no'),
		])))
		{ var_discounted_price } else { rt.get_property(var_item, 'price') }
		if rt.is_true(var_limit_usage_qty) {
			mut var_apply_quantity := if rt.is_true(rt.less(rt.sub(var_limit_usage_qty,
				var_applied_count), rt.get_property(var_item, 'quantity')))
			{
				rt.sub(var_limit_usage_qty, var_applied_count)
			} else {
				rt.get_property(var_item, 'quantity')
			}
			var_apply_quantity = rt.call_function('max', [rt.new_int(0),
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_coupon_get_apply_quantity'),
					var_apply_quantity.clone(),
					var_item.clone(),
					var_coupon.clone(),
					rt.new_object('WC_Discounts', []string{}, &this),
				])])
			mut var_discount := rt.mul(rt.call_function('min', [
				var_amount_mutated.clone(),
				rt.div(rt.get_property(var_item, 'price'), rt.get_property(var_item,
					'quantity'))]),
				var_apply_quantity)
		} else {
			var_apply_quantity = rt.call_function('apply_filters', [
				rt.new_string('woocommerce_coupon_get_apply_quantity'),
				rt.get_property(var_item, 'quantity'),
				var_item.clone(),
				var_coupon.clone(),
				rt.new_object('WC_Discounts', []string{}, &this),
			])
			var_discount = rt.mul(var_amount_mutated, var_apply_quantity)
		}
		if rt.is_true(rt.call_function('is_a', [this.object, rt.new_string('WC_Cart')]))
			&& rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_coupon_get_discount_amount')])) {
			var_discount = rt.call_function('wc_add_number_precision', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_coupon_get_discount_amount'),
					rt.call_function('wc_remove_number_precision', [
						var_discount.clone()]),
					rt.call_function('wc_remove_number_precision', [
						var_price_to_discount.clone()]),
					rt.get_property(var_item, 'object'),
					rt.new_bool(false),
					var_coupon.clone(),
				]),
			])
		}
		var_discount = rt.call_function('min', [var_discounted_price.clone(),
			var_discount.clone()])
		var_total_discount = rt.add(var_total_discount, var_discount)
		var_applied_count = rt.add(var_applied_count, var_apply_quantity)
		this.discounts.array_get(rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})).array_get(rt.get_property(var_item,
			'key')) = rt.add(this.discounts.array_get(rt.call_method(var_coupon, 'get_code',
			[]rt.PhpVal{})).array_get(rt.get_property(var_item, 'key')), var_discount)
	}
	return var_total_discount.clone()
}

fn (mut this Class_WC_Discounts) apply_coupon_fixed_cart(var_coupon rt.PhpVal, var_items_to_apply rt.PhpVal, var_amount rt.PhpVal) rt.PhpVal {
	mut var_items_to_apply_mutated := var_items_to_apply
	mut var_amount_mutated := var_amount
	mut var_total_discount := rt.new_int(0)
	var_amount_mutated = if rt.is_true(var_amount_mutated) { var_amount_mutated } else { rt.call_function('wc_add_number_precision', [
			rt.new_float((rt.call_method(var_coupon, 'get_amount', []rt.PhpVal{})).to_f64()),
		]) }
	var_items_to_apply_mutated = rt.call_function('array_filter', [
		var_items_to_apply_mutated.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Discounts', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'filter_products_with_price' },
		])])
	mut var_item_count := rt.call_function('array_sum', [
		rt.call_function('wp_list_pluck', [var_items_to_apply_mutated.clone(),
			rt.new_string('quantity')]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_item_count)))) {
		return var_total_discount.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_amount_mutated)))) {
		var_total_discount = this.apply_coupon_fixed_product(var_coupon.clone(),
			var_items_to_apply_mutated.clone(), rt.new_int(0))
	} else {
		mut var_per_item_discount := rt.call_function('absint', [
			rt.div(var_amount_mutated, var_item_count),
		])
		if rt.is_true(rt.greater(var_per_item_discount, rt.new_int(0))) {
			var_total_discount = this.apply_coupon_fixed_product(var_coupon.clone(),
				var_items_to_apply_mutated.clone(), var_per_item_discount.clone())
			if rt.is_true(rt.greater(var_total_discount, rt.new_int(0)))
				&& rt.is_true(rt.less(var_total_discount, var_amount_mutated)) {
				var_total_discount = rt.add(var_total_discount, this.apply_coupon_fixed_cart(var_coupon.clone(),
					var_items_to_apply_mutated.clone(), rt.sub(var_amount_mutated,
					var_total_discount)))
			}
		} else if rt.is_true(rt.greater(var_amount_mutated, rt.new_int(0))) {
			var_total_discount = rt.add(var_total_discount, this.apply_coupon_remainder(var_coupon.clone(),
				var_items_to_apply_mutated.clone(), var_amount_mutated.clone()))
		}
	}
	return var_total_discount.clone()
}

fn (mut this Class_WC_Discounts) apply_coupon_custom(var_coupon rt.PhpVal, var_items_to_apply rt.PhpVal) rt.PhpVal {
	mut var_items_to_apply_mutated := var_items_to_apply
	mut var_limit_usage_qty := rt.new_int(0)
	mut var_applied_count := rt.new_int(0)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.call_method(var_coupon,
		'get_limit_usage_to_x_items', []rt.PhpVal{})))))
	{
		var_limit_usage_qty = rt.call_method(var_coupon, 'get_limit_usage_to_x_items',
			[]rt.PhpVal{})
	}
	mut iter_8 := var_items_to_apply_mutated.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_item := item_8.val
		mut var_discounted_price := this.get_discounted_price_in_cents(var_item.clone())
		mut var_price_to_discount := rt.call_function('wc_remove_number_precision', [
			if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
				rt.new_string('woocommerce_calc_discounts_sequentially'),
				rt.new_string('no'),
			])))
			{ var_discounted_price } else { rt.get_property(var_item, 'price') },
		])
		mut var_apply_quantity := if rt.is_true(var_limit_usage_qty)
			&& rt.is_true(rt.less(rt.sub(var_limit_usage_qty, var_applied_count), rt.get_property(var_item, 'quantity'))) {
			rt.sub(var_limit_usage_qty, var_applied_count)
		} else {
			rt.get_property(var_item, 'quantity')
		}
		var_apply_quantity = rt.call_function('max', [rt.new_int(0),
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_coupon_get_apply_quantity'),
				var_apply_quantity.clone(),
				var_item.clone(),
				var_coupon.clone(),
				rt.new_object('WC_Discounts', []string{}, &this),
			])])
		mut var_discount := rt.mul(rt.call_function('wc_add_number_precision', [
			rt.new_float((rt.call_method(var_coupon, 'get_discount_amount', [
				rt.div(var_price_to_discount, rt.get_property(var_item, 'quantity')),
				rt.get_property(var_item, 'object'),
				rt.new_bool(true),
			])).to_f64()),
		]), var_apply_quantity)
		var_discount = rt.call_function('wc_round_discount', [
			rt.call_function('min', [var_discounted_price.clone(),
				var_discount.clone()]),
			rt.new_int(0),
		])
		var_applied_count = rt.add(var_applied_count, var_apply_quantity)
		this.discounts.array_get(rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})).array_get(rt.get_property(var_item,
			'key')) = rt.add(this.discounts.array_get(rt.call_method(var_coupon, 'get_code',
			[]rt.PhpVal{})).array_get(rt.get_property(var_item, 'key')), var_discount)
	}
	this.discounts.array_set(rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}), rt.call_function('apply_filters', [
		rt.new_string('woocommerce_coupon_custom_discounts_array'),
		this.discounts.array_get(rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})),
		var_coupon.clone(),
	]))
	return rt.call_function('array_sum', [
		this.discounts.array_get(rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})),
	])
}

fn (mut this Class_WC_Discounts) apply_coupon_remainder(var_coupon rt.PhpVal, var_items_to_apply rt.PhpVal, var_amount rt.PhpVal) rt.PhpVal {
	mut var_items_to_apply_mutated := var_items_to_apply
	mut var_amount_mutated := var_amount
	mut var_total_discount := rt.new_int(0)
	mut iter_9 := var_items_to_apply_mutated.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_item := item_9.val
		mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
		mut iife_result_3 := iife_temp_3.ceil(rt.get_property(var_item, 'quantity'))
		mut var_quantity := iife_result_3
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, var_quantity))) { break
			 }
			mut var_price_to_discount := this.get_discounted_price_in_cents(var_item.clone())
			mut var_discount := rt.call_function('min', [var_price_to_discount.clone(),
				rt.new_int(1)])
			var_total_discount = rt.add(var_total_discount, var_discount)
			this.discounts.array_get(rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})).array_get(rt.get_property(var_item,
				'key')) = rt.add(this.discounts.array_get(rt.call_method(var_coupon, 'get_code',
				[]rt.PhpVal{})).array_get(rt.get_property(var_item, 'key')), var_discount)
			if rt.is_true(rt.greater_equal(var_total_discount, var_amount_mutated)) {
				break
			}
			rt.post_inc(var_i)
		}
		if rt.is_true(rt.greater_equal(var_total_discount, var_amount_mutated)) {
			break
		}
	}
	return var_total_discount.clone()
}

fn (mut this Class_WC_Discounts) validate_coupon_exists(var_coupon rt.PhpVal) bool {
	if (rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_coupon, 'get_id', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_coupon, 'get_virtual', []rt.PhpVal{}))))))
		|| rt.is_true(rt.identical(rt.new_string('trash'), rt.call_method(var_coupon, 'get_status', []rt.PhpVal{}))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Coupon "%s" cannot be applied because it does not exist.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}),
			]),
		]), rt.new_int(105))))
	}
	return true
}

fn (mut this Class_WC_Discounts) validate_coupon_usage_limit(var_coupon rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_coupon, 'get_usage_limit',
		[]rt.PhpVal{})))))
	{
		return true
	}
	mut var_usage_count := rt.call_method(var_coupon, 'get_usage_count', []rt.PhpVal{})
	mut var_data_store := rt.call_method(var_coupon, 'get_data_store', []rt.PhpVal{})
	mut var_tentative_usage_count := if rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_data_store },
			rt.ArrayItem{ key: none, val: 'get_tentative_usage_count' }]),
	])
	{ rt.call_method(var_data_store, 'get_tentative_usage_count', [
			rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}),
		]) } else { rt.new_int(0) }
	if rt.is_true(rt.less(rt.add(var_usage_count, var_tentative_usage_count), rt.call_method(var_coupon,
		'get_usage_limit', []rt.PhpVal{})))
	{
		return true
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_tentative_usage_count)) {
		mut var_error_code := Class_WC_Coupon.e_wc_coupon_usage_limit_reached()
	} else if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		mut var_recent_pending_orders := rt.call_function('wc_get_orders', [
			rt.create_array([rt.ArrayItem{ key: 'limit', val: 1 },
				rt.ArrayItem{ key: 'post_status', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.failed()
					},
					rt.ArrayItem{
						key: none
						val: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.pending()
					},
				]) }, rt.ArrayItem{ key: 'customer', val: rt.call_function('get_current_user_id',
					[]rt.PhpVal{}) }, rt.ArrayItem{ key: 'return', val: 'ids' }]),
		])
		if var_recent_pending_orders.clone().array_count() > 0 {
			var_error_code = Class_WC_Coupon.e_wc_coupon_usage_limit_coupon_stuck()
		} else {
			var_error_code = Class_WC_Coupon.e_wc_coupon_usage_limit_reached()
		}
	} else {
		var_error_code = Class_WC_Coupon.e_wc_coupon_usage_limit_coupon_stuck_guest()
	}
	rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_coupon,
		'get_coupon_error', [var_error_code.clone()]), var_error_code.clone())))
	return false
}

fn (mut this Class_WC_Discounts) validate_coupon_user_usage_limit(var_coupon rt.PhpVal, user_id i64) bool {
	mut user_id_mutated := user_id
	if user_id_mutated == 0 {
		if rt.is_true(rt.new_bool(rt.instance_of(this.object, 'WC_Order'))) {
			user_id_mutated =
				(rt.call_method(this.object, 'get_customer_id', []rt.PhpVal{})).to_i64()
		} else {
			user_id_mutated = (rt.call_function('get_current_user_id', []rt.PhpVal{})).to_i64()
		}
	}
	if rt.is_true(var_coupon) && rt.is_true(rt.new_int(user_id_mutated))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_validate_user_usage_limit'), rt.greater(rt.call_method(var_coupon, 'get_usage_limit_per_user', []rt.PhpVal{}), rt.new_int(0)), rt.new_int(user_id_mutated).clone(), var_coupon.clone(), rt.new_object('WC_Discounts', []string{}, &this)]))
		&& rt.is_true(rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_coupon, 'get_data_store', []rt.PhpVal{})) {
		mut var_data_store := rt.call_method(var_coupon, 'get_data_store', []rt.PhpVal{})
		mut var_usage_count := rt.call_method(var_data_store, 'get_usage_by_user_id', [
			var_coupon.clone(),
			rt.new_int(user_id_mutated).clone(),
		])
		if rt.is_true(rt.greater_equal(var_usage_count, rt.call_method(var_coupon,
			'get_usage_limit_per_user', []rt.PhpVal{})))
		{
			if rt.is_true(rt.greater(rt.call_method(var_data_store,
				'get_tentative_usages_for_user', [
				rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}),
				rt.create_array([rt.ArrayItem{ key: none, val: user_id_mutated }]),
			]), rt.new_int(0)))
			{
				mut var_error_message := rt.call_method(var_coupon, 'get_coupon_error', [
					Class_WC_Coupon.e_wc_coupon_usage_limit_coupon_stuck(),
				])
				mut var_error_code := Class_WC_Coupon.e_wc_coupon_usage_limit_coupon_stuck()
			} else {
				var_error_message = rt.call_method(var_coupon, 'get_coupon_error', [
					Class_WC_Coupon.e_wc_coupon_usage_limit_reached(),
				])
				var_error_code = Class_WC_Coupon.e_wc_coupon_usage_limit_reached()
			}
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(var_error_message.clone(),
				var_error_code.clone())))
		}
	}
	return true
}

fn (mut this Class_WC_Discounts) validate_coupon_expiry_date(var_coupon rt.PhpVal) bool {
	if rt.is_true(rt.call_method(var_coupon, 'get_date_expires', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_validate_expiry_date'), rt.greater(rt.call_function('time', []rt.PhpVal{}), rt.call_method(rt.call_method(var_coupon, 'get_date_expires', []rt.PhpVal{}), 'getTimestamp', []rt.PhpVal{})), var_coupon.clone(), rt.new_object('WC_Discounts', []string{}, &this)])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
			rt.call_function('esc_html__', [rt.new_string('Coupon "%s" has expired.'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_html', [rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})]),
		]), rt.new_int(107))))
	}
	return true
}

fn (mut this Class_WC_Discounts) validate_coupon_minimum_amount(var_coupon rt.PhpVal) bool {
	mut var_subtotal := rt.call_function('wc_remove_number_precision', [
		this.get_object_subtotal(),
	])
	if rt.is_true(rt.greater(rt.call_method(var_coupon, 'get_minimum_amount', []rt.PhpVal{}), rt.new_int(0)))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_validate_minimum_amount'), rt.greater(rt.call_method(var_coupon, 'get_minimum_amount', []rt.PhpVal{}), var_subtotal), var_coupon.clone(), var_subtotal.clone()])) {
		mut var_allowed_tags := {
			'span':  {
				'class': rt.new_bool(true)
			}
			'bdi':   rt.new_bool(true)
			'small': rt.new_bool(true)
		}
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('The minimum spend for coupon "%1$s" is %2$s.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}),
			]),
			rt.call_function('wp_kses', [
				rt.call_function('wc_price', [
					rt.call_method(var_coupon, 'get_minimum_amount', []rt.PhpVal{}),
				]),
				rt.create_array_from_native_map(var_allowed_tags),
			]),
		]), rt.new_int(108))))
	}
	return true
}

fn (mut this Class_WC_Discounts) validate_coupon_maximum_amount(var_coupon rt.PhpVal) bool {
	mut var_subtotal := rt.call_function('wc_remove_number_precision', [
		this.get_object_subtotal(),
	])
	if rt.is_true(rt.greater(rt.call_method(var_coupon, 'get_maximum_amount', []rt.PhpVal{}), rt.new_int(0)))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_validate_maximum_amount'), rt.less(rt.call_method(var_coupon, 'get_maximum_amount', []rt.PhpVal{}), var_subtotal), var_coupon.clone()])) {
		mut var_allowed_tags := {
			'span':  {
				'class': rt.new_bool(true)
			}
			'bdi':   rt.new_bool(true)
			'small': rt.new_bool(true)
		}
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('The maximum spend for coupon "%1$s" is %2$s.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}),
			]),
			rt.call_function('wp_kses', [
				rt.call_function('wc_price', [
					rt.call_method(var_coupon, 'get_maximum_amount', []rt.PhpVal{}),
				]),
				rt.create_array_from_native_map(var_allowed_tags),
			]),
		]), rt.new_int(112))))
	}
	return true
}

fn (mut this Class_WC_Discounts) validate_coupon_product_ids(var_coupon rt.PhpVal) bool {
	if rt.call_method(var_coupon, 'get_product_ids', []rt.PhpVal{}).array_count() > 0 {
		mut var_valid := rt.new_bool(false)
		mut iter_10 := this.get_items_to_validate().iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_item := item_10.val
			if rt.is_true(rt.get_property(var_item, 'product'))
				&& rt.is_true(rt.call_function('in_array', [rt.call_method(rt.get_property(var_item, 'product'), 'get_id', []rt.PhpVal{}), rt.call_method(var_coupon, 'get_product_ids', []rt.PhpVal{}), rt.new_bool(true)]))
				|| rt.is_true(rt.call_function('in_array', [rt.call_method(rt.get_property(var_item, 'product'), 'get_parent_id', []rt.PhpVal{}), rt.call_method(var_coupon, 'get_product_ids', []rt.PhpVal{}), rt.new_bool(true)])) {
				var_valid = rt.new_bool(true)
				break
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_valid)))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('Sorry, coupon "%s" is not applicable to selected products.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}),
				]),
			]), rt.new_int(109))))
		}
	}
	return true
}

fn (mut this Class_WC_Discounts) validate_coupon_product_categories(var_coupon rt.PhpVal) bool {
	if rt.call_method(var_coupon, 'get_product_categories', []rt.PhpVal{}).array_count() > 0 {
		mut var_valid := rt.new_bool(false)
		mut iter_11 := this.get_items_to_validate().iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_item := item_11.val
			if rt.is_true(rt.call_method(var_coupon, 'get_exclude_sale_items', []rt.PhpVal{}))
				&& rt.is_true(rt.get_property(var_item, 'product'))
				&& rt.is_true(rt.call_method(rt.get_property(var_item, 'product'), 'is_on_sale', []rt.PhpVal{})) {
				continue
			}
			mut var_product_cats := rt.call_function('wc_get_product_cat_ids', [
				rt.call_method(rt.get_property(var_item, 'product'), 'get_id', []rt.PhpVal{}),
			])
			if rt.is_true(rt.call_method(rt.get_property(var_item, 'product'), 'get_parent_id',
				[]rt.PhpVal{}))
			{
				var_product_cats = rt.call_function('array_merge', [
					var_product_cats.clone(),
					rt.call_function('wc_get_product_cat_ids', [
						rt.call_method(rt.get_property(var_item, 'product'), 'get_parent_id',
							[]rt.PhpVal{}),
					])])
			}
			if rt.call_function('array_intersect', [var_product_cats.clone(),
				rt.call_method(var_coupon, 'get_product_categories', []rt.PhpVal{})]).array_count() > 0 {
				var_valid = rt.new_bool(true)
				break
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_valid)))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('Sorry, coupon "%s" is not applicable to selected products.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}),
				]),
			]), rt.new_int(109))))
		}
	}
	return true
}

fn (mut this Class_WC_Discounts) validate_coupon_sale_items(var_coupon rt.PhpVal) bool {
	if rt.is_true(rt.call_method(var_coupon, 'get_exclude_sale_items', []rt.PhpVal{})) {
		mut var_valid := rt.new_bool(true)
		mut iter_12 := this.get_items_to_validate().iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_item := item_12.val
			if rt.is_true(rt.get_property(var_item, 'product'))
				&& rt.is_true(rt.call_method(rt.get_property(var_item, 'product'), 'is_on_sale', []rt.PhpVal{})) {
				var_valid = rt.new_bool(false)
				break
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_valid)))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('Sorry, coupon "%s" is not valid for sale items.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}),
				]),
			]), rt.new_int(110))))
		}
	}
	return true
}

fn (mut this Class_WC_Discounts) validate_coupon_excluded_items(var_coupon rt.PhpVal) bool {
	mut var_items := this.get_items_to_validate()
	if !(!rt.is_true(var_items))
		&& rt.is_true(rt.call_method(var_coupon, 'is_type', [rt.call_function('wc_get_product_coupon_types', []rt.PhpVal{})])) {
		mut var_valid := rt.new_bool(false)
		mut iter_13 := var_items.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_item := item_13.val
			if rt.is_true(rt.get_property(var_item, 'product'))
				&& rt.is_true(rt.call_method(var_coupon, 'is_valid_for_product', [rt.get_property(var_item, 'product'), rt.get_property(var_item, 'object')])) {
				var_valid = rt.new_bool(true)
				break
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_valid)))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('Sorry, coupon "%s" is not applicable to selected products.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}),
				]),
			]), rt.new_int(109))))
		}
	}
	return true
}

fn (mut this Class_WC_Discounts) validate_coupon_eligible_items(var_coupon rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_coupon, 'is_type', [
		rt.call_function('wc_get_product_coupon_types', []rt.PhpVal{}),
	])))))
	{
		this.validate_coupon_sale_items(var_coupon.clone())
		this.validate_coupon_excluded_product_ids(var_coupon.clone())
		this.validate_coupon_excluded_product_categories(var_coupon.clone())
	}
	return true
}

fn (mut this Class_WC_Discounts) validate_coupon_excluded_product_ids(var_coupon rt.PhpVal) bool {
	if rt.call_method(var_coupon, 'get_excluded_product_ids', []rt.PhpVal{}).array_count() > 0 {
		mut var_products := rt.new_array()
		mut iter_14 := this.get_items_to_validate().iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_item := item_14.val
			if (rt.is_true(rt.get_property(var_item, 'product'))
				&& rt.is_true(rt.call_function('in_array', [rt.call_method(rt.get_property(var_item, 'product'), 'get_id', []rt.PhpVal{}), rt.call_method(var_coupon, 'get_excluded_product_ids', []rt.PhpVal{}), rt.new_bool(true)])))
				|| rt.is_true(rt.call_function('in_array', [rt.call_method(rt.get_property(var_item, 'product'), 'get_parent_id', []rt.PhpVal{}), rt.call_method(var_coupon, 'get_excluded_product_ids', []rt.PhpVal{}), rt.new_bool(true)])) {
				var_products << rt.call_method(rt.get_property(var_item, 'product'), 'get_name',
					[]rt.PhpVal{})
			}
		}
		if !(!rt.is_true(var_products)) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('Sorry, coupon "%1$s" is not applicable to the products: %2$s.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}),
				]),
				rt.call_function('esc_html', [
					rt.call_function('implode', [rt.new_string(', '),
						rt.create_array_from_list(var_products)]),
				]),
			]), rt.new_int(113))))
		}
	}
	return true
}

fn (mut this Class_WC_Discounts) validate_coupon_excluded_product_categories(var_coupon rt.PhpVal) bool {
	if rt.call_method(var_coupon, 'get_excluded_product_categories', []rt.PhpVal{}).array_count() > 0 {
		mut var_categories := rt.new_array()
		mut iter_15 := this.get_items_to_validate().iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_item := item_15.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_item, 'product'))))) {
				continue
			}
			mut var_product_cats := rt.call_function('wc_get_product_cat_ids', [
				rt.call_method(rt.get_property(var_item, 'product'), 'get_id', []rt.PhpVal{}),
			])
			if rt.is_true(rt.call_method(rt.get_property(var_item, 'product'), 'get_parent_id',
				[]rt.PhpVal{}))
			{
				var_product_cats = rt.call_function('array_merge', [
					var_product_cats.clone(),
					rt.call_function('wc_get_product_cat_ids', [
						rt.call_method(rt.get_property(var_item, 'product'), 'get_parent_id',
							[]rt.PhpVal{}),
					])])
			}
			mut var_cat_id_list := rt.call_function('array_intersect', [
				var_product_cats.clone(),
				rt.call_method(var_coupon,
					'get_excluded_product_categories', []rt.PhpVal{})])
			if var_cat_id_list.clone().array_count() > 0 {
				mut iter_16 := var_cat_id_list.iterator()
				for {
					item_16 := iter_16.next() or { break }
					mut var_cat_id := item_16.val
					mut var_cat := rt.call_function('get_term', [
						var_cat_id.clone(), rt.new_string('product_cat')])
					var_categories << rt.get_property(var_cat, 'name')
				}
			}
		}
		if !(!rt.is_true(var_categories)) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('Sorry, coupon "%1$s" is not applicable to the categories: %2$s.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}),
				]),
				rt.call_function('esc_html', [
					rt.call_function('implode', [rt.new_string(', '),
						rt.call_function('array_unique', [
							rt.create_array_from_list(var_categories),
						])]),
				]),
			]), rt.new_int(114))))
		}
	}
	return true
}

fn (mut this Class_WC_Discounts) validate_coupon_allowed_emails(var_coupon rt.PhpVal) bool {
	mut var_restrictions := rt.call_method(var_coupon, 'get_email_restrictions', []rt.PhpVal{})
	if !(var_restrictions.clone().is_array()) || !rt.is_true(var_restrictions) {
		return true
	}
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	mut var_check_emails := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.get_property(var_user, 'user_email') },
	])
	if rt.is_true(rt.new_bool(rt.instance_of(this.object, 'WC_Cart'))) {
		var_check_emails.array_push(rt.call_method(rt.call_method(this.object, 'get_customer',
			[]rt.PhpVal{}), 'get_billing_email', []rt.PhpVal{}))
	} else if rt.is_true(rt.new_bool(rt.instance_of(this.object, 'WC_Order'))) {
		var_check_emails.array_push(rt.call_method(this.object, 'get_billing_email', []rt.PhpVal{}))
	}
	var_check_emails = rt.call_function('array_unique', [
		rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('strtolower'),
				rt.call_function('array_map', [rt.new_string('sanitize_email'),
					var_check_emails.clone()])]),
		]),
	])
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_DiscountsUtil{}
	mut iife_result_4 := iife_temp_4.is_coupon_emails_allowed(var_check_emails.clone(),
		var_restrictions.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_4)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_coupon,
			'get_coupon_error', [Class_WC_Coupon.e_wc_coupon_not_yours_removed()]),
			Class_WC_Coupon.e_wc_coupon_not_yours_removed())))
	}
	return true
}

fn (mut this Class_WC_Discounts) get_object_subtotal() rt.PhpVal {
	if rt.is_true(rt.call_function('is_a', [this.object, rt.new_string('WC_Cart')])) {
		return rt.call_function('wc_add_number_precision', [
			rt.new_float((rt.call_method(this.object, 'get_displayed_subtotal', []rt.PhpVal{})).to_f64()),
		])
	} else if rt.is_true(rt.call_function('is_a', [this.object, rt.new_string('WC_Order')])) {
		mut var_subtotal := rt.call_function('wc_add_number_precision', [
			rt.new_float((rt.call_method(this.object, 'get_subtotal', []rt.PhpVal{})).to_f64()),
		])
		if rt.is_true(rt.call_method(this.object, 'get_prices_include_tax', []rt.PhpVal{})) {
			mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
			mut iife_result_5 := iife_temp_5.round(rt.call_method(this.object, 'get_total_tax',
				[]rt.PhpVal{}), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
			mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
			mut iife_result_6 := iife_temp_6.round(rt.call_method(this.object, 'get_total_tax',
				[]rt.PhpVal{}), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
			var_subtotal = rt.add(var_subtotal, rt.call_function('wc_add_number_precision', [
				iife_result_5,
			]))
		}
		return var_subtotal.clone()
	} else {
		return rt.call_function('array_sum', [
			rt.call_function('wp_list_pluck', [this.items, rt.new_string('price')]),
		])
	}
	return rt.new_null()
}

fn (mut this Class_WC_Discounts) is_coupon_valid(var_coupon rt.PhpVal) bool {
	this.validate_coupon_exists(var_coupon.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.validate_coupon_usage_limit(var_coupon.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.validate_coupon_user_usage_limit(var_coupon.clone(), 0)
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.validate_coupon_expiry_date(var_coupon.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.validate_coupon_minimum_amount(var_coupon.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.validate_coupon_maximum_amount(var_coupon.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.validate_coupon_product_ids(var_coupon.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.validate_coupon_product_categories(var_coupon.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.validate_coupon_excluded_items(var_coupon.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.validate_coupon_eligible_items(var_coupon.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.validate_coupon_allowed_emails(var_coupon.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_coupon_is_valid'),
		rt.new_bool(true),
		var_coupon.clone(),
		rt.new_object('WC_Discounts', []string{}, &this),
	])))))
	{
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Coupon is not valid.'),
			rt.new_string('woocommerce'),
		]), Class_WC_Coupon.e_wc_coupon_invalid_filtered())))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		mut var_message := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_coupon_error'),
			if rt.call_method(var_e, 'getMessage', []rt.PhpVal{}).is_long() || rt.call_method(var_e, 'getMessage', []rt.PhpVal{}).is_double() { rt.call_method(var_coupon, 'get_coupon_error', [
					rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
				]) } else { rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) },
			rt.call_method(var_e, 'getCode', []rt.PhpVal{}),
			var_coupon.clone(),
		])
		mut var_additional_data := rt.create_array([
			rt.ArrayItem{ key: 'status', val: 400 },
		])
		mut var_context_coupon_errors := rt.call_method(var_coupon,
			'get_context_based_coupon_errors', [
			rt.call_method(var_e, 'getCode', []rt.PhpVal{}),
		])
		if !(!rt.is_true(var_context_coupon_errors)) {
			var_additional_data.array_set('details', var_context_coupon_errors.clone())
		}
		return (create_wp_error(rt.new_string('invalid_coupon'), var_message.clone(),
			var_additional_data.clone())).to_bool()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return true
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
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

struct Class_Automattic_WooCommerce_Utilities_DiscountsUtil {
	rt.PhpObjectBase
}

fn create_wc_discounts(arg_0 rt.PhpVal) &Class_WC_Discounts {
	mut obj := &Class_WC_Discounts{
		PhpObjectBase: rt.PhpObjectBase{}
		object:        rt.new_null()
		items:         rt.new_array()
		discounts:     rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
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

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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

fn create_automattic_woocommerce_utilities_discountsutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_DiscountsUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_DiscountsUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Discounts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'set_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_items(dispatch_arg_0)
			return rt.new_null()
		}
		'set_items_from_cart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_items_from_cart(dispatch_arg_0)
			return rt.new_null()
		}
		'set_items_from_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_items_from_order(dispatch_arg_0)
			return rt.new_null()
		}
		'get_object' {
			return this.get_object()
		}
		'get_items' {
			return this.get_items()
		}
		'get_items_to_validate' {
			return this.get_items_to_validate()
		}
		'get_discount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_discount(dispatch_arg_0, dispatch_arg_1)
		}
		'get_discounts' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_discounts(dispatch_arg_0)
		}
		'get_discounts_by_item' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_discounts_by_item(dispatch_arg_0)
		}
		'get_discounts_by_coupon' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_discounts_by_coupon(dispatch_arg_0)
		}
		'get_discounted_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_discounted_price(dispatch_arg_0)
		}
		'get_discounted_price_in_cents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_discounted_price_in_cents(dispatch_arg_0)
		}
		'apply_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.apply_coupon(dispatch_arg_0, dispatch_arg_1))
		}
		'sort_by_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.sort_by_price(dispatch_arg_0, dispatch_arg_1))
		}
		'filter_products_with_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_products_with_price(dispatch_arg_0)
		}
		'get_items_to_apply_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items_to_apply_coupon(dispatch_arg_0)
		}
		'apply_coupon_percent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.apply_coupon_percent(dispatch_arg_0, dispatch_arg_1)
		}
		'apply_coupon_fixed_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.apply_coupon_fixed_product(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'apply_coupon_fixed_cart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.apply_coupon_fixed_cart(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'apply_coupon_custom' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.apply_coupon_custom(dispatch_arg_0, dispatch_arg_1)
		}
		'apply_coupon_remainder' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.apply_coupon_remainder(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'validate_coupon_exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_exists(dispatch_arg_0))
		}
		'validate_coupon_usage_limit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_usage_limit(dispatch_arg_0))
		}
		'validate_coupon_user_usage_limit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.validate_coupon_user_usage_limit(dispatch_arg_0, dispatch_arg_1))
		}
		'validate_coupon_expiry_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_expiry_date(dispatch_arg_0))
		}
		'validate_coupon_minimum_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_minimum_amount(dispatch_arg_0))
		}
		'validate_coupon_maximum_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_maximum_amount(dispatch_arg_0))
		}
		'validate_coupon_product_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_product_ids(dispatch_arg_0))
		}
		'validate_coupon_product_categories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_product_categories(dispatch_arg_0))
		}
		'validate_coupon_sale_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_sale_items(dispatch_arg_0))
		}
		'validate_coupon_excluded_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_excluded_items(dispatch_arg_0))
		}
		'validate_coupon_eligible_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_eligible_items(dispatch_arg_0))
		}
		'validate_coupon_excluded_product_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_excluded_product_ids(dispatch_arg_0))
		}
		'validate_coupon_excluded_product_categories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_excluded_product_categories(dispatch_arg_0))
		}
		'validate_coupon_allowed_emails' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_coupon_allowed_emails(dispatch_arg_0))
		}
		'get_object_subtotal' {
			return this.get_object_subtotal()
		}
		'is_coupon_valid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_coupon_valid(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Discounts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'object' { return this.object }
		'items' { return this.items }
		'discounts' { return this.discounts }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Discounts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'object' {
			this.object = val
			return true
		}
		'items' {
			this.items = val
			return true
		}
		'discounts' {
			this.discounts = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Utilities_DiscountsUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_DiscountsUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_DiscountsUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
