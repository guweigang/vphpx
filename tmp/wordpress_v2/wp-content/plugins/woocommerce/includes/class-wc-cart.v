import rt
import crypto.md5

struct Class_WC_Cart {
	rt.PhpObjectBase
pub mut:
	cart_context            rt.PhpVal = rt.new_string('shortcode')
	cart_contents           rt.PhpVal = rt.new_array()
	removed_cart_contents   rt.PhpVal = rt.new_array()
	applied_coupons         rt.PhpVal = rt.new_array()
	shipping_methods        rt.PhpVal = rt.new_null()
	has_calculated_shipping bool
	default_totals          rt.PhpVal = rt.new_array()
	totals                  rt.PhpVal = rt.new_array()
	session                 rt.PhpVal = rt.new_null()
	fees_api                rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Cart) construct() {
	this.session = create_wc_cart_session(rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this))
	this.fees_api = create_wc_cart_fees()
	rt.call_method(this.session, 'init', []rt.PhpVal{})
	rt.call_function('add_action', [rt.new_string('woocommerce_add_to_cart'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) },
			rt.ArrayItem{ key: none, val: 'calculate_totals' },
		]),
		rt.new_int(20), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('woocommerce_applied_coupon'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) },
			rt.ArrayItem{ key: none, val: 'calculate_totals' },
		]),
		rt.new_int(20), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('woocommerce_removed_coupon'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) },
			rt.ArrayItem{ key: none, val: 'calculate_totals' },
		]),
		rt.new_int(20), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('woocommerce_cart_item_removed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) },
			rt.ArrayItem{ key: none, val: 'calculate_totals' },
		]),
		rt.new_int(20), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('woocommerce_cart_item_restored'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) },
			rt.ArrayItem{ key: none, val: 'calculate_totals' },
		]),
		rt.new_int(20), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('woocommerce_check_cart_items'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) },
			rt.ArrayItem{ key: none, val: 'check_cart_items' },
		]),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_check_cart_items'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) },
			rt.ArrayItem{ key: none, val: 'check_cart_coupons' },
		]),
		rt.new_int(1)])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_after_checkout_validation'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) },
			rt.ArrayItem{ key: none, val: 'check_customer_coupons' },
		]),
		rt.new_int(1),
		rt.new_int(2),
	])
}

fn (mut this Class_WC_Cart) magic_clone() {
	this.session = this.session.dup()
	this.fees_api = this.fees_api.dup()
	rt.call_method(this.session, 'set_cart', [
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this),
	])
}

fn (mut this Class_WC_Cart) get_cart_contents() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_cart_contents'),
		rt.cast_array(this.cart_contents),
	])
}

fn (mut this Class_WC_Cart) get_removed_cart_contents() rt.PhpVal {
	return rt.cast_array(this.removed_cart_contents)
}

fn (mut this Class_WC_Cart) get_applied_coupons() rt.PhpVal {
	return rt.cast_array(this.applied_coupons)
}

fn (mut this Class_WC_Cart) get_coupon_discount_totals() rt.PhpVal {
	return rt.cast_array(rt.get_property(rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this),
		'coupon_discount_totals'))
}

fn (mut this Class_WC_Cart) get_coupon_discount_tax_totals() rt.PhpVal {
	return rt.cast_array(rt.get_property(rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this),
		'coupon_discount_tax_totals'))
}

fn (mut this Class_WC_Cart) get_totals() rt.PhpVal {
	return if !rt.is_true(this.totals) { this.default_totals } else { this.totals }
}

fn (mut this Class_WC_Cart) get_totals_var(var_key rt.PhpVal) rt.PhpVal {
	return if this.totals.array_isset(var_key) {
		this.totals.array_get(var_key)
	} else {
		this.default_totals.array_get(var_key)
	}
}

fn (mut this Class_WC_Cart) get_subtotal() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('subtotal'))])
}

fn (mut this Class_WC_Cart) get_subtotal_tax() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('subtotal_tax'))])
}

fn (mut this Class_WC_Cart) get_discount_total() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('discount_total'))])
}

fn (mut this Class_WC_Cart) get_discount_tax() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('discount_tax'))])
}

fn (mut this Class_WC_Cart) get_shipping_total() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('shipping_total'))])
}

fn (mut this Class_WC_Cart) get_shipping_tax() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('shipping_tax'))])
}

fn (mut this Class_WC_Cart) get_cart_contents_total() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('cart_contents_total'))])
}

fn (mut this Class_WC_Cart) get_cart_contents_tax() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('cart_contents_tax'))])
}

fn (mut this Class_WC_Cart) get_total(context string) rt.PhpVal {
	mut var_total := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('total')),
	])
	return if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) { rt.call_function('apply_filters', [
			rt.new_string('woocommerce_cart_total'),
			rt.call_function('wc_price', [var_total.clone()]),
		]) } else { var_total }
}

fn (mut this Class_WC_Cart) get_total_tax() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('total_tax'))])
}

fn (mut this Class_WC_Cart) get_fee_total() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('fee_total'))])
}

fn (mut this Class_WC_Cart) get_fee_tax() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('fee_tax'))])
}

fn (mut this Class_WC_Cart) get_shipping_taxes() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('shipping_taxes'))])
}

fn (mut this Class_WC_Cart) get_cart_contents_taxes() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('cart_contents_taxes'))])
}

fn (mut this Class_WC_Cart) get_fee_taxes() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		this.get_totals_var(rt.new_string('fee_taxes'))])
}

fn (mut this Class_WC_Cart) display_prices_including_tax() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_' + @FN),
		rt.identical(rt.new_string('incl'), this.get_tax_price_display_mode())])
}

fn (mut this Class_WC_Cart) set_cart_contents(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.cart_contents = rt.cast_array(var_value_mutated)
}

fn (mut this Class_WC_Cart) set_removed_cart_contents(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.removed_cart_contents = rt.cast_array(var_value_mutated)
}

fn (mut this Class_WC_Cart) set_applied_coupons(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.applied_coupons = rt.cast_array(var_value_mutated)
}

fn (mut this Class_WC_Cart) set_coupon_discount_totals(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.dispatch_set_prop('coupon_discount_totals', rt.cast_array(var_value_mutated))
}

fn (mut this Class_WC_Cart) set_coupon_discount_tax_totals(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.dispatch_set_prop('coupon_discount_tax_totals', rt.cast_array(var_value_mutated))
}

fn (mut this Class_WC_Cart) set_totals(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals = rt.call_function('wp_parse_args',
		[var_value_mutated.clone(), this.default_totals])
}

fn (mut this Class_WC_Cart) set_subtotal(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('subtotal', rt.call_function('wc_format_decimal', [
		var_value_mutated.clone()]))
}

fn (mut this Class_WC_Cart) set_subtotal_tax(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('subtotal_tax', var_value_mutated.clone())
}

fn (mut this Class_WC_Cart) set_discount_total(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('discount_total', var_value_mutated.clone())
}

fn (mut this Class_WC_Cart) set_discount_tax(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('discount_tax', var_value_mutated.clone())
}

fn (mut this Class_WC_Cart) set_shipping_total(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('shipping_total', rt.call_function('wc_format_decimal', [
		var_value_mutated.clone(),
	]))
}

fn (mut this Class_WC_Cart) set_shipping_tax(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('shipping_tax', var_value_mutated.clone())
}

fn (mut this Class_WC_Cart) set_cart_contents_total(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('cart_contents_total', rt.call_function('wc_format_decimal', [
		var_value_mutated.clone(),
	]))
}

fn (mut this Class_WC_Cart) set_cart_contents_tax(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('cart_contents_tax', var_value_mutated.clone())
}

fn (mut this Class_WC_Cart) set_total(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('total', rt.call_function('wc_format_decimal', [
		var_value_mutated.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]))
}

fn (mut this Class_WC_Cart) set_total_tax(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('total_tax', rt.call_function('wc_round_tax_total', [
		var_value_mutated.clone(),
	]))
}

fn (mut this Class_WC_Cart) set_fee_total(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('fee_total', rt.call_function('wc_format_decimal', [
		var_value_mutated.clone()]))
}

fn (mut this Class_WC_Cart) set_fee_tax(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('fee_tax', var_value_mutated.clone())
}

fn (mut this Class_WC_Cart) set_shipping_taxes(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('shipping_taxes', rt.cast_array(var_value_mutated))
}

fn (mut this Class_WC_Cart) set_cart_contents_taxes(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('cart_contents_taxes', rt.cast_array(var_value_mutated))
}

fn (mut this Class_WC_Cart) set_fee_taxes(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.totals.array_set('fee_taxes', rt.cast_array(var_value_mutated))
}

fn (mut this Class_WC_Cart) get_taxes() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_get_taxes'),
		rt.call_function('wc_array_merge_recursive_numeric', [
			this.get_shipping_taxes(), this.get_cart_contents_taxes(),
			this.get_fee_taxes()]),
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this),
	])
}

fn (mut this Class_WC_Cart) get_cart() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [
		rt.new_string('wp_loaded'),
	])))))
	{
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Get cart should not be called before the wp_loaded action.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('2.3')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [
		rt.new_string('woocommerce_load_cart_from_session'),
	])))))
	{
		rt.call_method(this.session, 'get_cart_from_session', []rt.PhpVal{})
	}
	return rt.call_function('array_filter', [this.get_cart_contents()])
}

fn (mut this Class_WC_Cart) get_cart_item(var_item_key rt.PhpVal) rt.PhpVal {
	return if this.cart_contents.array_isset(var_item_key) {
		this.cart_contents.array_get(var_item_key)
	} else {
		rt.new_array()
	}
}

fn (mut this Class_WC_Cart) is_empty() bool {
	return rt.new_bool(0 == this.get_cart().array_count())
}

fn (mut this Class_WC_Cart) empty_cart(clear_persistent_cart bool) {
	rt.call_function('do_action', [rt.new_string('woocommerce_before_cart_emptied'),
		rt.new_bool(clear_persistent_cart)])
	this.cart_contents = rt.new_array()
	this.removed_cart_contents = rt.new_array()
	this.shipping_methods = rt.new_array()
	this.dispatch_set_prop('coupon_discount_totals', rt.new_array())
	this.dispatch_set_prop('coupon_discount_tax_totals', rt.new_array())
	this.applied_coupons = rt.new_array()
	this.totals = this.default_totals
	if var_clear_persistent_cart {
		rt.call_method(this.session, 'persistent_cart_destroy', []rt.PhpVal{})
	}
	rt.call_method(this.fees_api, 'remove_all_fees', []rt.PhpVal{})
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}),
		'reset_shipping', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_cart_emptied'),
		rt.new_bool(clear_persistent_cart)])
}

fn (mut this Class_WC_Cart) get_cart_contents_count() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_contents_count'),
		rt.call_function('array_sum', [
			rt.call_function('wp_list_pluck', [this.get_cart(),
				rt.new_string('quantity')]),
		]),
	])
}

fn (mut this Class_WC_Cart) get_cart_contents_weight() rt.PhpVal {
	mut var_weight := rt.new_float(0)
	mut iter_1 := this.get_cart().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_values := item_1.val
		if rt.is_true(rt.call_method(var_values.array_get(rt.new_string('data')), 'has_weight',
			[]rt.PhpVal{}))
		{
			var_weight = rt.add(var_weight, rt.new_float((rt.call_method(var_values.array_get(rt.new_string('data')),
				'get_weight', []rt.PhpVal{})).to_f64()) * var_values.array_get(rt.new_string('quantity')))
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_contents_weight'),
		var_weight.clone(),
	])
}

fn (mut this Class_WC_Cart) get_cart_item_quantities() rt.PhpVal {
	mut var_quantities := rt.new_array()
	mut iter_2 := this.get_cart().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_values := item_2.val
		mut var_product := var_values.array_get(rt.new_string('data'))
		var_quantities.array_set(rt.call_method(var_product, 'get_stock_managed_by_id',
			[]rt.PhpVal{}), if var_quantities.array_isset(rt.call_method(var_product,
			'get_stock_managed_by_id', []rt.PhpVal{}))
		{
			rt.add(var_quantities.array_get(rt.call_method(var_product, 'get_stock_managed_by_id',
				[]rt.PhpVal{})), var_values.array_get(rt.new_string('quantity')))
		} else {
			var_values.array_get(rt.new_string('quantity'))
		})
	}
	return var_quantities.clone()
}

fn (mut this Class_WC_Cart) check_cart_items() rt.PhpVal {
	mut var_return := rt.new_bool(true)
	mut var_result := this.check_cart_item_validity()
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.call_function('wc_add_notice', [
			rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}),
			rt.new_string('error'),
		])
		var_return = rt.new_bool(false)
	}
	var_result = this.check_cart_item_sold_individually()
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		mut iter_3 := rt.call_method(var_result, 'get_error_messages', []rt.PhpVal{}).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_message := item_3.val
			rt.call_function('wc_add_notice', [var_message.clone(),
				rt.new_string('error')])
		}
		var_return = rt.new_bool(false)
	}
	var_result = this.check_cart_item_stock()
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.call_function('wc_add_notice', [
			rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}),
			rt.new_string('error'),
		])
		var_return = rt.new_bool(false)
	}
	return var_return.clone()
}

fn (mut this Class_WC_Cart) check_cart_coupons() {
	mut iter_4 := this.get_applied_coupons().iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_code := item_4.val
		mut var_coupon := create_wc_coupon(var_code.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_coupon.is_valid())))) {
			var_coupon.add_coupon_message(Class_WC_Coupon.e_wc_coupon_invalid_removed())
			this.remove_coupon(var_code.clone())
		}
	}
}

fn (mut this Class_WC_Cart) check_cart_item_validity() rt.PhpVal {
	mut var_return := rt.new_bool(true)
	mut iter_5 := this.get_cart().iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_values := item_5.val
		mut var_cart_item_key := item_5.key
		mut var_product := var_values.array_get(rt.new_string('data'))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_product))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'exists', []rt.PhpVal{})))))
			|| rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.trash(), rt.call_method(var_product, 'get_status', []rt.PhpVal{}))) {
			this.set_quantity(var_cart_item_key.clone(), 0, false)
			var_return = create_wp_error(rt.new_string('invalid'), rt.call_function('__', [
				rt.new_string('An item which is no longer available was removed from your cart.'),
				rt.new_string('woocommerce'),
			]))
		}
	}
	return var_return.clone()
}

fn (mut this Class_WC_Cart) check_cart_item_sold_individually() rt.PhpVal {
	mut var_errors := create_wp_error()
	mut iter_6 := this.get_cart().iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_values := item_6.val
		mut var_cart_item_key := item_6.key
		mut var_product := var_values.array_get(rt.new_string('data'))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_product))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'exists', []rt.PhpVal{}))))) {
			continue
		}
		mut var_product_id := if rt.is_true(var_values.array_get(rt.new_string('variation_id'))) {
			var_values.array_get(rt.new_string('variation_id'))
		} else {
			var_values.array_get(rt.new_string('product_id'))
		}
		mut var_product_to_check := rt.call_function('wc_get_product', [
			var_product_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_product_to_check))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_to_check, 'exists', []rt.PhpVal{}))))) {
			continue
		}
		if rt.is_true(rt.call_method(var_product_to_check, 'is_sold_individually', []rt.PhpVal{}))
			&& rt.is_true(rt.greater(var_values.array_get(rt.new_string('quantity')), rt.new_int(1))) {
			this.cart_contents.array_get_mut(var_cart_item_key).array_set('data',
				var_product_to_check.clone())
			this.set_quantity(var_cart_item_key.clone(), 1, false)
			var_errors.add(rt.new_string('sold-individually'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('You can only have 1 %s in your cart.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_method(var_product_to_check, 'get_name', []rt.PhpVal{}),
			]))
		}
	}
	return if rt.is_true(var_errors.has_errors()) { var_errors } else { rt.new_bool(true) }
}

fn (mut this Class_WC_Cart) check_cart_item_stock() rt.PhpVal {
	mut var_error := create_wp_error()
	mut var_product_qty_in_cart := this.get_cart_item_quantities()
	mut var_current_session_order_id := if !(rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'order_awaiting_payment')).is_null() { rt.call_function('absint', [
			rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'order_awaiting_payment'),
		]) } else { rt.call_function('absint', [
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [
				rt.new_string('store_api_draft_order'),
				rt.new_int(0),
			]),
		]) }
	mut iter_7 := this.get_cart().iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_values := item_7.val
		mut var_product := var_values.array_get(rt.new_string('data'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_in_stock',
			[]rt.PhpVal{})))))
		{
			var_error.add(rt.new_string('out-of-stock'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Sorry, "%s" is not in stock. Please edit your cart and try again. We apologize for any inconvenience caused.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
			]))
			return rt.new_object('WP_Error', []string{}, var_error)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'managing_stock', []rt.PhpVal{})))))
			|| rt.is_true(rt.call_method(var_product, 'backorders_allowed', []rt.PhpVal{})) {
			continue
		}
		mut var_held_stock := rt.call_function('wc_get_held_stock_quantity', [
			var_product.clone(), var_current_session_order_id.clone()])
		mut var_required_stock := var_product_qty_in_cart.array_get(rt.call_method(var_product,
			'get_stock_managed_by_id', []rt.PhpVal{}))
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_cart_item_required_stock_is_not_enough'),
			rt.less(rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{}), rt.add(var_held_stock,
				var_required_stock)),
			var_product.clone(),
			var_values.clone(),
		]))
		{
			var_error.add(rt.new_string('out-of-stock'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Sorry, we do not have enough "%1$s" in stock to fulfill your order (%2$s available). We apologize for any inconvenience caused.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
				rt.call_function('wc_format_stock_quantity_for_display', [
					rt.sub(rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{}),
						var_held_stock),
					var_product.clone(),
				]),
			]))
			return rt.new_object('WP_Error', []string{}, var_error)
		}
	}
	return rt.new_bool(true)
}

fn (mut this Class_WC_Cart) get_item_data(var_cart_item rt.PhpVal, flat bool) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Cart::get_item_data'),
		rt.new_string('3.3'), rt.new_string('wc_get_formatted_cart_item_data')])
	return rt.call_function('wc_get_formatted_cart_item_data', [
		var_cart_item.clone(), rt.new_bool(flat)])
}

fn (mut this Class_WC_Cart) get_cross_sells() rt.PhpVal {
	mut var_cross_sells := rt.new_array()
	mut var_in_cart := rt.new_array()
	if !(this.is_empty()) {
		mut iter_8 := this.get_cart().iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_values := item_8.val
			if rt.is_true(rt.greater(var_values.array_get(rt.new_string('quantity')), rt.new_int(0))) {
				var_cross_sells = rt.call_function('array_merge', [
					rt.call_method(var_values.array_get(rt.new_string('data')),
						'get_cross_sell_ids', []rt.PhpVal{}),
					var_cross_sells.clone(),
				])
				var_in_cart << var_values.array_get(rt.new_string('product_id'))
				if rt.is_true(rt.call_method(var_values.array_get(rt.new_string('data')),
					'is_type', [
					Class_Automattic_WooCommerce_Enums_ProductType.variation(),
				]))
				{
					var_in_cart << var_values.array_get(rt.new_string('variation_id'))
				}
			}
		}
	}
	var_cross_sells = rt.call_function('array_diff', [var_cross_sells.clone(),
		rt.create_array_from_list(var_in_cart)])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_crosssell_ids'),
		rt.call_function('wp_parse_id_list', [var_cross_sells.clone()]),
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this),
	])
}

fn (mut this Class_WC_Cart) get_remove_url(var_cart_item_key rt.PhpVal) rt.PhpVal {
	mut var_cart_item_key_mutated := var_cart_item_key
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Cart::get_remove_url'),
		rt.new_string('3.3'), rt.new_string('wc_get_cart_remove_url')])
	return rt.call_function('wc_get_cart_remove_url', [var_cart_item_key_mutated.clone()])
}

fn (mut this Class_WC_Cart) get_undo_url(var_cart_item_key rt.PhpVal) rt.PhpVal {
	mut var_cart_item_key_mutated := var_cart_item_key
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Cart::get_undo_url'),
		rt.new_string('3.3'), rt.new_string('wc_get_cart_undo_url')])
	return rt.call_function('wc_get_cart_undo_url', [var_cart_item_key_mutated.clone()])
}

fn (mut this Class_WC_Cart) get_tax_totals() rt.PhpVal {
	mut var_shipping_taxes := this.get_shipping_taxes()
	mut var_taxes := this.get_taxes()
	mut var_tax_totals := rt.new_array()
	mut iter_9 := var_taxes.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_tax := item_9.val
		mut var_key := item_9.key
		mut iife_temp_0 := Class_WC_Tax{}
		mut iife_result_0 := iife_temp_0.get_rate_code(var_key.clone())
		mut var_code := iife_result_0
		if rt.is_true(var_code)
			|| rt.is_true(rt.identical(rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_remove_taxes_zero_rate_id'), rt.new_string('zero-rated')]), var_key)) {
			if !(var_tax_totals.array_isset(var_code)) {
				var_tax_totals.array_set(var_code, create_stdclass())
				rt.set_property(var_tax_totals.array_get(var_code), 'amount', rt.new_int(0))
			}
			rt.set_property(var_tax_totals.array_get(var_code), 'tax_rate_id', var_key.clone())
			mut iife_temp_1 := Class_WC_Tax{}
			mut iife_result_1 := iife_temp_1.is_compound(var_key.clone())
			rt.set_property(var_tax_totals.array_get(var_code), 'is_compound', iife_result_1)
			mut iife_temp_2 := Class_WC_Tax{}
			mut iife_result_2 := iife_temp_2.get_rate_label(var_key.clone())
			rt.set_property(var_tax_totals.array_get(var_code), 'label', iife_result_2)
			if var_shipping_taxes.array_isset(var_key) {
				var_tax = rt.sub(var_tax, var_shipping_taxes.array_get(var_key))
				var_tax = rt.call_function('wc_round_tax_total', [
					var_tax.clone()])
				mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
				mut iife_result_3 := iife_temp_3.round(var_shipping_taxes.array_get(var_key), rt.call_function('wc_get_price_decimals',
					[]rt.PhpVal{}))
				var_tax = rt.add(var_tax, iife_result_3)
				var_shipping_taxes.array_unset(var_key)
			}
			rt.get_property(var_tax_totals.array_get(var_code), 'amount') = rt.add(rt.get_property(var_tax_totals.array_get(var_code),
				'amount'), rt.call_function('wc_round_tax_total', [
				var_tax.clone()]))
			rt.set_property(var_tax_totals.array_get(var_code), 'formatted_amount', rt.call_function('wc_price', [
				rt.get_property(var_tax_totals.array_get(var_code), 'amount'),
			]))
		}
	}
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_hide_zero_taxes'),
		rt.new_bool(true),
	]))
	{
		mut var_amounts := rt.call_function('array_filter', [
			rt.call_function('wp_list_pluck', [var_tax_totals.clone(),
				rt.new_string('amount')]),
		])
		var_tax_totals = rt.call_function('array_intersect_key', [
			var_tax_totals.clone(), var_amounts.clone()])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_tax_totals'),
		var_tax_totals.clone(),
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this),
	])
}

fn (mut this Class_WC_Cart) get_cart_item_tax_classes() rt.PhpVal {
	mut var_found_tax_classes := rt.new_array()
	mut iter_10 := this.get_cart().iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_item := item_10.val
		if rt.is_true(var_item.array_get(rt.new_string('data')))
			&& rt.is_true(rt.call_method(var_item.array_get(rt.new_string('data')), 'is_taxable', []rt.PhpVal{}))
			|| rt.is_true(rt.call_method(var_item.array_get(rt.new_string('data')), 'is_shipping_taxable', []rt.PhpVal{})) {
			var_found_tax_classes << rt.call_method(var_item.array_get(rt.new_string('data')),
				'get_tax_class', []rt.PhpVal{})
		}
	}
	return rt.call_function('array_unique', [
		rt.create_array_from_list(var_found_tax_classes),
	])
}

fn (mut this Class_WC_Cart) get_cart_item_tax_classes_for_shipping() rt.PhpVal {
	mut var_found_tax_classes := rt.new_array()
	mut iter_11 := this.get_cart().iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_item := item_11.val
		if rt.is_true(var_item.array_get(rt.new_string('data')))
			&& rt.is_true(rt.call_method(var_item.array_get(rt.new_string('data')), 'is_shipping_taxable', []rt.PhpVal{})) {
			var_found_tax_classes << rt.call_method(var_item.array_get(rt.new_string('data')),
				'get_tax_class', []rt.PhpVal{})
		}
	}
	return rt.call_function('array_unique', [
		rt.create_array_from_list(var_found_tax_classes),
	])
}

fn (mut this Class_WC_Cart) get_displayed_subtotal() rt.PhpVal {
	return if rt.is_true(this.display_prices_including_tax()) {
		rt.add(this.get_subtotal(), this.get_subtotal_tax())
	} else {
		this.get_subtotal()
	}
}

fn (mut this Class_WC_Cart) find_product_in_cart(cart_id bool) string {
	mut cart_id_mutated := cart_id
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
		rt.new_bool(cart_id_mutated)))))
	{
		if this.cart_contents.is_array()
			&& this.cart_contents.array_isset(rt.new_bool(cart_id_mutated)) {
			return cart_id_mutated
		}
	}
	return ''
}

fn (mut this Class_WC_Cart) generate_cart_id(var_product_id rt.PhpVal, variation_id i64, var_variation rt.PhpVal, var_cart_item_data rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
	mut variation_id_mutated := variation_id
	mut var_variation_mutated := var_variation
	mut var_cart_item_data_mutated := var_cart_item_data
	mut var_id_parts := [var_product_id_mutated]
	if rt.is_true(rt.new_int(variation_id_mutated))
		&& rt.is_true(rt.new_bool(0 != variation_id_mutated)) {
		var_id_parts << rt.new_int(variation_id_mutated).clone()
	}
	if var_variation_mutated.clone().is_array() && !(!rt.is_true(var_variation_mutated)) {
		mut var_variation_key := rt.new_string('')
		mut iter_12 := var_variation_mutated.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_value := item_12.val
			mut var_key := item_12.key
			var_variation_key = rt.concat(var_variation_key, rt.new_string(
				var_key.clone().to_string().trim_space() +
				var_value.clone().to_string().trim_space()))
		}
		var_id_parts << var_variation_key.clone()
	}
	if var_cart_item_data_mutated.clone().is_array() && !(!rt.is_true(var_cart_item_data_mutated)) {
		mut var_cart_item_data_key := rt.new_string('')
		mut iter_13 := var_cart_item_data_mutated.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_value := item_13.val
			mut var_key := item_13.key
			if var_value.clone().is_array() || var_value.clone().is_object() {
				var_value = rt.call_function('http_build_query', [
					var_value.clone()])
			}
			var_cart_item_data_key = rt.concat(var_cart_item_data_key, rt.new_string(
				var_key.clone().to_string().trim_space() +
				var_value.clone().to_string().trim_space()))
		}
		var_id_parts << var_cart_item_data_key.clone()
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_id'),
		rt.new_string(md5.hexhash(rt.call_function('implode', [
			rt.new_string('_'), rt.create_array_from_list(var_id_parts)]).to_string())),
		var_product_id_mutated.clone(), rt.new_int(variation_id_mutated).clone(),
		var_variation_mutated.clone(), var_cart_item_data_mutated.clone()])
}

fn (mut this Class_WC_Cart) add_to_cart(product_id i64, quantity i64, variation_id i64, var_variation rt.PhpVal, var_cart_item_data rt.PhpVal) bool {
	mut product_id_mutated := product_id
	mut quantity_mutated := quantity
	mut variation_id_mutated := variation_id
	mut var_variation_mutated := var_variation
	mut var_cart_item_data_mutated := var_cart_item_data
	product_id_mutated =
		(rt.call_function('absint', [rt.new_int(product_id_mutated).clone()])).to_i64()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	variation_id_mutated =
		(rt.call_function('absint', [rt.new_int(variation_id_mutated).clone()])).to_i64()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.identical(rt.new_string('product_variation'), rt.call_function('get_post_type', [
		rt.new_int(product_id_mutated).clone(),
	])))
	{
		variation_id_mutated = product_id_mutated
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		product_id_mutated = (rt.call_function('wp_get_post_parent_id', [
			rt.new_int(variation_id_mutated).clone()])).to_i64()
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
	mut var_product_data := rt.call_function('wc_get_product', [
		rt.new_int(if rt.is_true(rt.new_int(variation_id_mutated)) {
			variation_id_mutated
		} else {
			product_id_mutated
		}),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	quantity_mutated = (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_add_to_cart_quantity'),
		rt.new_int(quantity_mutated).clone(),
		rt.new_int(product_id_mutated).clone(),
	])).to_i64()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if quantity_mutated <= 0 || rt.is_true(rt.new_bool(!(rt.is_true(var_product_data))))
		|| rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.trash(), rt.call_method(var_product_data, 'get_status', []rt.PhpVal{}))) {
		return false
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(variation_id_mutated)))))
		&& rt.is_true(rt.call_method(var_product_data, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Please choose product options by visiting <a href="%1$s" title="%2$s">%2$s</a>.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_url', [
				rt.call_method(var_product_data, 'get_permalink', []rt.PhpVal{}),
			]),
			rt.call_function('esc_html', [
				rt.call_method(var_product_data, 'get_name', []rt.PhpVal{}),
			]),
		]))))
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
	if rt.is_true(rt.call_method(var_product_data, 'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.variation(),
	]))
	{
		mut var_missing_attributes := rt.new_array()
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut var_parent_data := rt.call_function('wc_get_product', [
			rt.call_method(var_product_data, 'get_parent_id', []rt.PhpVal{}),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut var_variation_attributes := rt.call_method(var_product_data,
			'get_variation_attributes', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_variation_attributes = rt.call_function('array_filter', [
			var_variation_attributes.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut var_posted_attributes := rt.new_array()
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut iter_14 := rt.call_method(var_parent_data, 'get_attributes', []rt.PhpVal{}).iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_attribute := item_14.val
			if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute.array_get(rt.new_string('is_variation')))))) {
				continue
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
			mut var_attribute_key :=
				rt.new_string('attribute_' +(rt.call_function('sanitize_title', [var_attribute.array_get(rt.new_string('name'))])).str())
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			if var_variation_mutated.array_isset(var_attribute_key) {
				if rt.is_true(var_attribute.array_get(rt.new_string('is_taxonomy'))) {
					mut var_value := rt.call_function('sanitize_title', [
						rt.call_function('wp_unslash',
							[var_variation_mutated.array_get(var_attribute_key)]),
					])
					if rt.has_exception() {
						unsafe {
							goto catch_label_1
						}
					}
					if rt.has_exception() {
						unsafe {
							goto catch_label_1
						}
					}
				} else {
					var_value = rt.call_function('html_entity_decode', [
						rt.call_function('wc_clean', [
							rt.call_function('wp_unslash', [
								var_variation_mutated.array_get(var_attribute_key),
							]),
						]),
						rt.get_constant('ENT_QUOTES'),
						rt.call_function('get_bloginfo', [
							rt.new_string('charset'),
						]),
					])
					if rt.has_exception() {
						unsafe {
							goto catch_label_1
						}
					}
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
				if !(!rt.is_true(var_value))
					|| rt.is_true(rt.identical(rt.new_string('0'), var_value)) {
					var_posted_attributes.array_set(var_attribute_key, var_value.clone())
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
			}
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
		mut var_posted_and_variation_attributes := rt.call_function('array_merge', [
			var_variation_attributes.clone(),
			var_posted_attributes.clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if variation_id_mutated == 0 {
			mut iife_temp_4 := Class_WC_Data_Store{}
			mut iife_result_4 := iife_temp_4.load(rt.new_string('product'))
			mut var_data_store := iife_result_4
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			variation_id_mutated = (rt.call_method(var_data_store,
				'find_matching_product_variation', [var_parent_data.clone(),
				var_posted_attributes.clone()])).to_i64()
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
		if variation_id_mutated == 0 {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
				rt.new_string('Please choose product options&hellip;'),
				rt.new_string('woocommerce'),
			]))))
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
		mut var_variation_data := rt.call_function('wc_get_product_variation_attributes', [
			rt.new_int(variation_id_mutated).clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut var_attributes := rt.new_array()
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut iter_15 := rt.call_method(var_parent_data, 'get_attributes', []rt.PhpVal{}).iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_attribute := item_15.val
			if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute.array_get(rt.new_string('is_variation')))))) {
				continue
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
			mut var_attribute_key :=
				rt.new_string('attribute_' +(rt.call_function('sanitize_title', [var_attribute.array_get(rt.new_string('name'))])).str())
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			mut var_valid_value := if var_variation_data.array_isset(var_attribute_key) {
				var_variation_data.array_get(var_attribute_key)
			} else {
				rt.new_string('')
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			if var_posted_and_variation_attributes.array_isset(var_attribute_key) {
				mut var_value := var_posted_and_variation_attributes.array_get(var_attribute_key)
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
				if rt.is_true(rt.identical(var_valid_value, var_value)) {
					var_attributes.array_set(var_attribute_key, var_value.clone())
					if rt.has_exception() {
						unsafe {
							goto catch_label_1
						}
					}
				} else if rt.is_true(rt.identical(rt.new_string(''), var_valid_value))
					&& rt.is_true(rt.call_function('in_array', [var_value.clone(), rt.call_method(var_attribute, 'get_slugs', []rt.PhpVal{}), rt.new_bool(true)])) {
					var_attributes.array_set(var_attribute_key, var_value.clone())
					if rt.has_exception() {
						unsafe {
							goto catch_label_1
						}
					}
				} else {
					rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Invalid value posted for %s'),
							rt.new_string('woocommerce'),
						]),
						rt.call_function('wc_attribute_label', [
							var_attribute.array_get(rt.new_string('name')),
						]),
					]))))
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
			} else if rt.is_true(rt.identical(rt.new_string(''), var_valid_value)) {
				var_missing_attributes.array_push(rt.call_function('wc_attribute_label', [
					var_attribute.array_get(rt.new_string('name')),
				]))
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
			var_variation_mutated = var_attributes.clone()
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
		if !(!rt.is_true(var_missing_attributes)) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s is a required field'),
					rt.new_string('%s are required fields'),
					rt.new_int(var_missing_attributes.clone().array_count()),
					rt.new_string('woocommerce')]),
				rt.call_function('wc_format_list_of_items', [
					var_missing_attributes.clone()]),
			]))))
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
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if 0 < variation_id_mutated
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_data, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_product_data, 'get_parent_id', []rt.PhpVal{}), rt.new_int(product_id_mutated))))) {
		mut var_product := rt.call_function('wc_get_product', [
			rt.new_int(product_id_mutated).clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
				rt.new_string('The selected product is invalid.'),
				rt.new_string('woocommerce'),
			]))))
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
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The selected product isn\'t a variation of %2$s, please choose product options by visiting <a href="%1$s" title="%2$s">%2$s</a>.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_url', [
				rt.call_method(var_product, 'get_permalink', []rt.PhpVal{}),
			]),
			rt.call_function('esc_html', [
				rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
			]),
		]))))
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
	var_cart_item_data_mutated = rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_add_cart_item_data'),
		var_cart_item_data_mutated.clone(),
		rt.new_int(product_id_mutated).clone(),
		rt.new_int(variation_id_mutated).clone(),
		rt.new_int(quantity_mutated).clone(),
	]))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_cart_id := this.generate_cart_id(rt.new_int(product_id_mutated), variation_id_mutated,
		var_variation_mutated.clone(), var_cart_item_data_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_cart_item_key := rt.new_string(this.find_product_in_cart(var_cart_id.to_bool()))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.call_method(var_product_data, 'is_sold_individually', []rt.PhpVal{})) {
		quantity_mutated = (rt.call_function('apply_filters', [
			rt.new_string('woocommerce_add_to_cart_sold_individually_quantity'),
			rt.new_int(1),
			rt.new_int(quantity_mutated).clone(),
			rt.new_int(product_id_mutated).clone(),
			rt.new_int(variation_id_mutated).clone(),
			var_cart_item_data_mutated.clone(),
		])).to_i64()
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		mut var_found_in_cart := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_add_to_cart_sold_individually_found_in_cart'),
			rt.new_bool(rt.is_true(var_cart_item_key)
				&& rt.is_true(rt.greater(this.cart_contents.array_get(var_cart_item_key).array_get(rt.new_string('quantity')), rt.new_int(0)))),
			rt.new_int(product_id_mutated).clone(),
			rt.new_int(variation_id_mutated).clone(),
			var_cart_item_data_mutated.clone(),
			var_cart_id.clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if rt.is_true(var_found_in_cart) {
			mut var_message := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('You cannot add another "%s" to your cart.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_method(var_product_data, 'get_name', []rt.PhpVal{}),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			var_message = rt.call_function('apply_filters', [
				rt.new_string('woocommerce_cart_product_cannot_add_another_message'),
				var_message.clone(),
				var_product_data.clone(),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			mut var_wp_button_class := rt.new_string((if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [
				rt.new_string('button'),
			]))
			{
				' ' +(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str()
			} else {
				''
			}).str())
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			mut iife_temp_5 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
			mut iife_result_5 := iife_temp_5.has_cart_page()
			if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_5)))) {
				var_message = rt.call_function('sprintf', [rt.new_string('%s'),
					rt.call_function('esc_html', [var_message.clone()])])
				if rt.has_exception() {
					unsafe {
						goto catch_label_1
					}
				}
			} else {
				var_message = rt.call_function('sprintf', [
					rt.new_string('%s <a href="%s" class="button wc-forward%s">%s</a>'),
					var_message.clone(),
					rt.call_function('esc_url', [
						rt.call_function('wc_get_cart_url', []rt.PhpVal{}),
					]),
					rt.call_function('esc_attr', [
						var_wp_button_class.clone(),
					]),
					rt.call_function('__', [
						rt.new_string('View cart'),
						rt.new_string('woocommerce'),
					]),
				])
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
			rt.throw_exception(rt.new_object('Exception', []string{},
				create_exception(var_message.clone())))
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
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_data, 'is_purchasable',
		[]rt.PhpVal{})))))
	{
		var_message = rt.call_function('__', [
			rt.new_string('Sorry, this product cannot be purchased.'),
			rt.new_string('woocommerce'),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_message = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_cart_product_cannot_be_purchased_message'),
			var_message.clone(),
			var_product_data.clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(var_message.clone())))
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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_data, 'is_in_stock',
		[]rt.PhpVal{})))))
	{
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('You cannot add &quot;%s&quot; to the cart because the product is out of stock.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_product_data, 'get_name', []rt.PhpVal{}),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_message = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_cart_product_out_of_stock_message'),
			var_message.clone(),
			var_product_data.clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(var_message.clone())))
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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_data, 'has_enough_stock', [
		rt.new_int(quantity_mutated).clone(),
	])))))
	{
		mut var_stock_quantity := rt.call_method(var_product_data, 'get_stock_quantity',
			[]rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('You cannot add that amount of &quot;%1$s&quot; to the cart because there is not enough stock (%2$s remaining).'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_product_data, 'get_name', []rt.PhpVal{}),
			rt.call_function('wc_format_stock_quantity_for_display', [
				var_stock_quantity.clone(),
				var_product_data.clone(),
			]),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_message = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_cart_product_not_enough_stock_message'),
			var_message.clone(),
			var_product_data.clone(),
			var_stock_quantity.clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(var_message.clone())))
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
	if rt.is_true(rt.call_method(var_product_data, 'managing_stock', []rt.PhpVal{})) {
		mut var_products_qty_in_cart := this.get_cart_item_quantities()
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if var_products_qty_in_cart.array_isset(rt.call_method(var_product_data, 'get_stock_managed_by_id', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_data, 'has_enough_stock', [rt.add(var_products_qty_in_cart.array_get(rt.call_method(var_product_data, 'get_stock_managed_by_id', []rt.PhpVal{})), rt.new_int(quantity_mutated))]))))) {
			var_stock_quantity = rt.call_method(var_product_data, 'get_stock_quantity',
				[]rt.PhpVal{})
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			mut var_stock_quantity_in_cart := var_products_qty_in_cart.array_get(rt.call_method(var_product_data,
				'get_stock_managed_by_id', []rt.PhpVal{}))
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			var_wp_button_class = rt.new_string((if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [
				rt.new_string('button'),
			]))
			{
				' ' +(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str()
			} else {
				''
			}).str())
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			mut iife_temp_6 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
			mut iife_result_6 := iife_temp_6.has_cart_page()
			var_message = if rt.is_true(iife_result_6) {
				rt.call_function('sprintf', [
					rt.new_string('%s <a href="%s" class="button wc-forward%s">%s</a>'),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('You cannot add that amount to the cart &mdash; we have %1$s in stock and you already have %2$s in your cart.'),
							rt.new_string('woocommerce'),
						]),
						rt.call_function('wc_format_stock_quantity_for_display', [
							var_stock_quantity.clone(),
							var_product_data.clone(),
						]),
						rt.call_function('wc_format_stock_quantity_for_display', [
							var_stock_quantity_in_cart.clone(),
							var_product_data.clone(),
						]),
					]),
					rt.call_function('esc_url', [
						rt.call_function('wc_get_cart_url', []rt.PhpVal{}),
					]),
					rt.call_function('esc_attr', [
						var_wp_button_class.clone(),
					]),
					rt.call_function('__', [
						rt.new_string('View cart'),
						rt.new_string('woocommerce'),
					]),
				])
			} else {
				rt.call_function('sprintf', [rt.new_string('%s'),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('You cannot add that amount to the cart &mdash; we have %1$s in stock and you already have %2$s in your cart.'),
							rt.new_string('woocommerce'),
						]),
						rt.call_function('wc_format_stock_quantity_for_display', [
							var_stock_quantity.clone(),
							var_product_data.clone(),
						]),
						rt.call_function('wc_format_stock_quantity_for_display', [
							var_stock_quantity_in_cart.clone(),
							var_product_data.clone(),
						]),
					])])
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			var_message = rt.call_function('apply_filters', [
				rt.new_string('woocommerce_cart_product_not_enough_stock_already_in_cart_message'),
				var_message.clone(),
				var_product_data.clone(),
				var_stock_quantity.clone(),
				var_stock_quantity_in_cart.clone(),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			rt.throw_exception(rt.new_object('Exception', []string{},
				create_exception(var_message.clone())))
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
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_item_was_already_in_cart := rt.new_bool(false)
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(var_cart_item_key) {
		mut var_new_quantity := rt.add(rt.new_int(quantity_mutated),
			this.cart_contents.array_get(var_cart_item_key).array_get(rt.new_string('quantity')))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		this.set_quantity(var_cart_item_key.clone(), var_new_quantity.to_i64(), false)
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_item_was_already_in_cart = rt.new_bool(true)
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	} else {
		var_cart_item_key = var_cart_id.clone()
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		this.cart_contents.array_set(var_cart_item_key, rt.call_function('apply_filters', [
			rt.new_string('woocommerce_add_cart_item'),
			rt.call_function('array_merge', [var_cart_item_data_mutated.clone(),
				rt.create_array([rt.ArrayItem{ key: 'key', val: var_cart_item_key },
					rt.ArrayItem{ key: 'product_id', val: product_id_mutated },
					rt.ArrayItem{ key: 'variation_id', val: variation_id_mutated },
					rt.ArrayItem{ key: 'variation', val: var_variation_mutated },
					rt.ArrayItem{ key: 'quantity', val: quantity_mutated },
					rt.ArrayItem{ key: 'data', val: var_product_data },
					rt.ArrayItem{ key: 'data_hash', val: rt.call_function('wc_get_cart_item_data_hash', [
						var_product_data.clone(),
					]) }])]),
			var_cart_item_key.clone(),
		]))
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
	this.cart_contents = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_contents_changed'),
		this.cart_contents,
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_add_to_cart'),
		var_cart_item_key.clone(), rt.new_int(product_id_mutated).clone(),
		rt.new_int(quantity_mutated).clone(), rt.new_int(variation_id_mutated).clone(),
		var_variation_mutated.clone(), var_cart_item_data_mutated.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return var_cart_item_key.to_bool()
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		if rt.is_true(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})) {
			rt.call_function('wc_add_notice', [
				rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
				rt.new_string('error'),
			])
		}
		return false
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
	return false
}

fn (mut this Class_WC_Cart) remove_cart_item(var_cart_item_key rt.PhpVal) bool {
	mut var_cart_item_key_mutated := var_cart_item_key
	if this.cart_contents.array_isset(var_cart_item_key_mutated) {
		this.removed_cart_contents.array_set(var_cart_item_key_mutated,
			this.cart_contents.array_get(var_cart_item_key_mutated))
		this.removed_cart_contents.array_get(var_cart_item_key_mutated).array_unset(rt.new_string('data'))
		rt.call_function('do_action', [rt.new_string('woocommerce_remove_cart_item'),
			var_cart_item_key_mutated.clone(), rt.new_object('WC_Cart', [
				'WC_Legacy_Cart',
			], &this)])
		this.cart_contents.array_unset(var_cart_item_key_mutated)
		rt.call_function('do_action', [rt.new_string('woocommerce_cart_item_removed'),
			var_cart_item_key_mutated.clone(), rt.new_object('WC_Cart', [
				'WC_Legacy_Cart',
			], &this)])
		return true
	}
	return false
}

fn (mut this Class_WC_Cart) restore_cart_item(var_cart_item_key rt.PhpVal) bool {
	mut var_cart_item_key_mutated := var_cart_item_key
	if this.removed_cart_contents.array_isset(var_cart_item_key_mutated) {
		mut var_restore_item := this.removed_cart_contents.array_get(var_cart_item_key_mutated)
		this.cart_contents.array_set(var_cart_item_key_mutated, var_restore_item.clone())
		this.cart_contents.array_get_mut(var_cart_item_key_mutated).array_set('data', rt.call_function('wc_get_product', [
			if rt.is_true(var_restore_item.array_get(rt.new_string('variation_id'))) {
				var_restore_item.array_get(rt.new_string('variation_id'))
			} else {
				var_restore_item.array_get(rt.new_string('product_id'))
			},
		]))
		rt.call_function('do_action', [rt.new_string('woocommerce_restore_cart_item'),
			var_cart_item_key_mutated.clone(), rt.new_object('WC_Cart', [
				'WC_Legacy_Cart',
			], &this)])
		this.removed_cart_contents.array_unset(var_cart_item_key_mutated)
		rt.call_function('do_action', [rt.new_string('woocommerce_cart_item_restored'),
			var_cart_item_key_mutated.clone(), rt.new_object('WC_Cart', [
				'WC_Legacy_Cart',
			], &this)])
		return true
	}
	return false
}

fn (mut this Class_WC_Cart) set_quantity(var_cart_item_key rt.PhpVal, quantity i64, refresh_totals bool) bool {
	mut var_cart_item_key_mutated := var_cart_item_key
	mut quantity_mutated := quantity
	if 0 == quantity_mutated || quantity_mutated < 0 {
		rt.call_function('wc_do_deprecated_action', [
			rt.new_string('woocommerce_before_cart_item_quantity_zero'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_cart_item_key_mutated },
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', [
					'WC_Legacy_Cart',
				], &this) }]),
			rt.new_string('3.7.0'),
			rt.new_string('woocommerce_remove_cart_item'),
		])
		return this.remove_cart_item(var_cart_item_key_mutated.clone())
	}
	mut var_old_quantity :=
		this.cart_contents.array_get(var_cart_item_key_mutated).array_get(rt.new_string('quantity'))
	this.cart_contents.array_get_mut(var_cart_item_key_mutated).array_set('quantity',
		quantity_mutated)
	rt.call_function('do_action', [
		rt.new_string('woocommerce_after_cart_item_quantity_update'),
		var_cart_item_key_mutated.clone(),
		rt.new_int(quantity_mutated).clone(),
		var_old_quantity.clone(),
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this),
	])
	if var_refresh_totals {
		this.calculate_totals()
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_cart_item_set_quantity'),
		var_cart_item_key_mutated.clone(), rt.new_int(quantity_mutated).clone(),
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this)])
	return true
}

fn (mut this Class_WC_Cart) get_customer() rt.PhpVal {
	return rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer')
}

fn (mut this Class_WC_Cart) calculate_totals() {
	this.reset_totals()
	if this.is_empty() {
		rt.call_method(this.session, 'set_session', []rt.PhpVal{})
		return
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_before_calculate_totals'),
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this)])
	create_wc_cart_totals(rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this))
	rt.call_function('do_action', [rt.new_string('woocommerce_after_calculate_totals'),
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this)])
}

fn (mut this Class_WC_Cart) needs_payment() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_needs_payment'),
		rt.less(rt.new_int(0), this.get_total('edit')),
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this),
	])
}

fn (mut this Class_WC_Cart) get_shipping_methods() rt.PhpVal {
	return this.shipping_methods
}

fn (mut this Class_WC_Cart) has_calculated_shipping() bool {
	return this.has_calculated_shipping
}

fn (mut this Class_WC_Cart) calculate_shipping() rt.PhpVal {
	this.set_shipping_total(rt.new_int(0))
	this.set_shipping_tax(rt.new_int(0))
	this.set_shipping_taxes(rt.new_array())
	this.shipping_methods = rt.new_array()
	this.has_calculated_shipping = false
	if !(this.needs_shipping()) || !(this.show_shipping()) {
		return this.shipping_methods
	}
	this.has_calculated_shipping = true
	this.shipping_methods = this.get_chosen_shipping_methods(rt.call_method(rt.call_method(rt.call_function('WC',
		[]rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'calculate_shipping', [
		this.get_shipping_packages(),
	]))
	mut var_shipping_costs := rt.call_function('wp_list_pluck', [this.shipping_methods,
		rt.new_string('cost')])
	mut var_shipping_taxes := rt.call_function('wp_list_pluck', [this.shipping_methods,
		rt.new_string('taxes')])
	mut var_merged_taxes := rt.new_array()
	mut iter_16 := var_shipping_taxes.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_taxes := item_16.val
		mut iter_17 := var_taxes.iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_tax_amount := item_17.val
			mut var_tax_id := item_17.key
			var_merged_taxes.array_set(var_tax_id, rt.add(if !(var_merged_taxes.array_get(var_tax_id)).is_null() {
				var_merged_taxes.array_get(var_tax_id)
			} else {
				rt.new_int(0)
			}, var_tax_amount))
		}
	}
	this.set_shipping_total(rt.call_function('array_sum', [
		rt.call_function('array_filter', [var_shipping_costs.clone()]),
	]))
	this.set_shipping_tax(rt.call_function('array_sum', [var_merged_taxes.clone()]))
	this.set_shipping_taxes(var_merged_taxes.clone())
	return this.shipping_methods
}

fn (mut this Class_WC_Cart) get_chosen_shipping_methods(var_calculated_shipping_packages rt.PhpVal) rt.PhpVal {
	mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_ShippingUtil{}
	mut iife_result_7 :=
		iife_temp_7.get_selected_shipping_rates_from_packages(var_calculated_shipping_packages.clone())
	return iife_result_7
}

fn (mut this Class_WC_Cart) filter_items_needing_shipping(var_item rt.PhpVal) bool {
	mut var_product := var_item.array_get(rt.new_string('data'))
	return rt.is_true(var_product)
		&& rt.is_true(rt.call_method(var_product, 'needs_shipping', []rt.PhpVal{}))
}

fn (mut this Class_WC_Cart) get_items_needing_shipping() rt.PhpVal {
	return rt.call_function('array_filter', [this.get_cart(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) },
			rt.ArrayItem{ key: none, val: 'filter_items_needing_shipping' },
		])])
}

fn (mut this Class_WC_Cart) get_shipping_packages() rt.PhpVal {
	mut var_shipping_packages := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_shipping_packages'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'contents', val: this.get_items_needing_shipping() },
				rt.ArrayItem{ key: 'contents_cost', val: rt.call_function('array_sum', [
					rt.call_function('wp_list_pluck', [this.get_items_needing_shipping(),
						rt.new_string('line_total')]),
				]) },
				rt.ArrayItem{ key: 'applied_coupons', val: this.get_applied_coupons() },
				rt.ArrayItem{ key: 'user', val: rt.create_array([
					rt.ArrayItem{ key: 'ID', val: rt.call_function('get_current_user_id',
						[]rt.PhpVal{}) },
				]) },
				rt.ArrayItem{ key: 'destination', val: rt.create_array([
					rt.ArrayItem{ key: 'country', val: rt.call_method(this.get_customer(),
						'get_shipping_country', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'state', val: rt.call_method(this.get_customer(),
						'get_shipping_state', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'postcode', val: rt.call_method(this.get_customer(),
						'get_shipping_postcode', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'city', val: rt.call_method(this.get_customer(),
						'get_shipping_city', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'address', val: rt.call_method(this.get_customer(),
						'get_shipping_address', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'address_1', val: rt.call_method(this.get_customer(),
						'get_shipping_address_1', []rt.PhpVal{}) },
					rt.ArrayItem{ key: 'address_2', val: rt.call_method(this.get_customer(),
						'get_shipping_address_2', []rt.PhpVal{}) },
				]) },
				rt.ArrayItem{ key: 'cart_subtotal', val: this.get_displayed_subtotal() },
			]) },
		]),
	])
	if !(var_shipping_packages.clone().is_array()) || !rt.is_true(var_shipping_packages) {
		return rt.new_array()
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_package := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(!rt.is_true(var_package))
			&& rt.create_array_from_native_map(var_package).is_array())
	}
	var_shipping_packages = rt.call_function('array_filter', [
		var_shipping_packages.clone(), rt.new_closure(closure_9_fn)])
	mut var_index := rt.new_int(1)
	mut iter_18 := var_shipping_packages.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_package := item_18.val
		mut var_key := item_18.key
		var_shipping_packages.array_get_mut(var_key).array_set('package_id', if !(var_package.array_get(rt.new_string('package_id'))).is_null() {
			var_package.array_get(rt.new_string('package_id'))
		} else {
			var_key
		})
		var_shipping_packages.array_get_mut(var_key).array_set('package_name', this.get_shipping_package_name(var_shipping_packages.array_get(var_key),
			var_index.clone(), rt.new_int(var_shipping_packages.clone().array_count())))
		rt.pre_inc(var_index)
	}
	return var_shipping_packages.clone()
}

fn (mut this Class_WC_Cart) get_shipping_package_name(var_package rt.PhpVal, var_index rt.PhpVal, var_total_packages rt.PhpVal) rt.PhpVal {
	mut var_index_mutated := var_index
	mut var_shipping_package_name := rt.call_function('_x', [
		rt.new_string('Shipment'), rt.new_string('shipping packages'),
		rt.new_string('woocommerce')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), var_total_packages)))) {
		var_shipping_package_name = rt.call_function('sprintf', [
			rt.call_function('_x', [rt.new_string('Shipment %d'),
				rt.new_string('shipping packages'), rt.new_string('woocommerce')]),
			var_index_mutated.clone(),
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_package_name'),
		var_shipping_package_name.clone(),
		var_package.array_get(rt.new_string('package_id')),
		var_package.clone(),
		var_total_packages.clone(),
	])
}

fn (mut this Class_WC_Cart) needs_shipping() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_shipping_enabled', []rt.PhpVal{})))))
		|| rt.is_true(rt.identical(rt.new_int(0), rt.call_function('wc_get_shipping_method_count', [rt.new_bool(true)]))) {
		return false
	}
	mut var_needs_shipping := rt.new_bool(false)
	mut iter_19 := this.get_cart_contents().iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_values := item_19.val
		if rt.is_true(rt.call_method(var_values.array_get(rt.new_string('data')), 'needs_shipping',
			[]rt.PhpVal{}))
		{
			var_needs_shipping = rt.new_bool(true)
			break
		}
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_needs_shipping'),
		var_needs_shipping.clone(),
	])).to_bool()
}

fn (mut this Class_WC_Cart) needs_shipping_address() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_needs_shipping_address'),
		rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), this.needs_shipping()))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_ship_to_billing_address_only', []rt.PhpVal{})))))),
	])
}

fn (mut this Class_WC_Cart) show_shipping() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_shipping_enabled', []rt.PhpVal{})))))
		|| rt.is_true(rt.identical(rt.new_int(0), rt.call_function('wc_get_shipping_method_count', [rt.new_bool(true)])))
		|| rt.is_true(rt.new_bool(!(rt.is_true(this.get_cart_contents())))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_shipping_cost_requires_address'),
	])))
	{
		mut iife_temp_9 := Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{}
		mut iife_result_9 := iife_temp_9.is_local_pickup_enabled()
		if rt.is_true(iife_result_9) {
			return (rt.call_function('apply_filters', [
				rt.new_string('woocommerce_cart_ready_to_calc_shipping'),
				rt.new_bool(true),
			])).to_bool()
		}
		if rt.is_true(rt.identical(rt.new_string('shortcode'), this.cart_context)) {
			mut var_country := rt.call_method(this.get_customer(), 'get_shipping_country',
				[]rt.PhpVal{})
			if rt.is_true(rt.new_bool(!(rt.is_true(var_country)))) {
				return false
			}
			mut var_country_fields := rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_address_fields', [
				var_country.clone(), rt.new_string('shipping_')])
			mut var_checkout_fields := rt.call_method(rt.call_method(rt.call_function('WC',
				[]rt.PhpVal{}), 'checkout', []rt.PhpVal{}), 'get_checkout_fields', []rt.PhpVal{})
			mut var_state_enabled := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_shipping_calculator_enable_state'),
				rt.new_bool(true),
			])
			mut var_state_required := rt.new_bool(
				var_country_fields.array_isset(rt.new_string('shipping_state'))
				&& rt.is_true(var_country_fields.array_get(rt.new_string('shipping_state')).array_get(rt.new_string('required'))))
			mut var_checkout_state_field_exists :=
				rt.new_bool(var_checkout_fields.array_get(rt.new_string('shipping')).array_isset(rt.new_string('shipping_state')))
			if rt.is_true(var_state_enabled) && rt.is_true(var_state_required)
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.get_customer(), 'get_shipping_state', []rt.PhpVal{})))))
				&& rt.is_true(var_checkout_state_field_exists) {
				return false
			}
			mut var_postcode_enabled := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_shipping_calculator_enable_postcode'),
				rt.new_bool(true),
			])
			mut var_postcode_required := rt.new_bool(
				var_country_fields.array_isset(rt.new_string('shipping_postcode'))
				&& rt.is_true(var_country_fields.array_get(rt.new_string('shipping_postcode')).array_get(rt.new_string('required'))))
			mut var_checkout_postcode_field_exists :=
				rt.new_bool(var_checkout_fields.array_get(rt.new_string('shipping')).array_isset(rt.new_string('shipping_postcode')))
			if rt.is_true(var_postcode_enabled) && rt.is_true(var_postcode_required)
				&& rt.is_true(rt.identical(rt.new_string(''), rt.call_method(this.get_customer(), 'get_shipping_postcode', []rt.PhpVal{})))
				&& rt.is_true(var_checkout_postcode_field_exists) {
				return false
			}
		} else {
			mut var_customer := this.get_customer()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_customer, 'WC_Customer'))))))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'has_full_shipping_address', []rt.PhpVal{}))))) {
				return false
			}
		}
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_ready_to_calc_shipping'),
		rt.new_bool(true),
	])).to_bool()
}

fn (mut this Class_WC_Cart) get_cart_shipping_total() rt.PhpVal {
	mut var_total := rt.call_function('__', [rt.new_string('Free!'),
		rt.new_string('woocommerce')])
	if rt.is_true(rt.less(rt.new_int(0), this.get_shipping_total())) {
		if rt.is_true(this.display_prices_including_tax()) {
			var_total = rt.call_function('wc_price', [
				rt.add(rt.get_property(rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this),
					'shipping_total'), rt.get_property(rt.new_object('WC_Cart', ['WC_Legacy_Cart'],
					&this), 'shipping_tax_total')),
			])
			if rt.is_true(rt.greater(rt.get_property(rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this), 'shipping_tax_total'), rt.new_int(0)))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{}))))) {
				var_total = rt.concat(var_total, rt.new_string(' <small class="tax_label">' +
					(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'inc_tax_or_vat', []rt.PhpVal{})).str() +
					'</small>'))
			}
		} else {
			var_total = rt.call_function('wc_price', [
				rt.get_property(rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this),
					'shipping_total'),
			])
			if rt.is_true(rt.greater(rt.get_property(rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this), 'shipping_tax_total'), rt.new_int(0)))
				&& rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{})) {
				var_total = rt.concat(var_total, rt.new_string(' <small class="tax_label">' +
					(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'ex_tax_or_vat', []rt.PhpVal{})).str() +
					'</small>'))
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_shipping_total'),
		var_total.clone(),
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this),
	])
}

fn (mut this Class_WC_Cart) check_customer_coupons(var_posted rt.PhpVal) {
	mut iter_20 := this.get_applied_coupons().iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_code := item_20.val
		mut var_coupon := create_wc_coupon(var_code.clone())
		if rt.is_true(var_coupon.is_valid()) {
			mut var_current_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
			mut var_billing_email := if var_posted.array_isset(rt.new_string('billing_email')) {
				var_posted.array_get(rt.new_string('billing_email'))
			} else {
				rt.new_string('')
			}
			mut var_check_emails := rt.call_function('array_unique', [
				rt.call_function('array_filter', [
					rt.call_function('array_map', [rt.new_string('strtolower'),
						rt.call_function('array_map', [rt.new_string('sanitize_email'),
							rt.create_array([
								rt.ArrayItem{ key: none, val: var_billing_email },
								rt.ArrayItem{ key: none, val: rt.get_property(var_current_user,
									'user_email') },
							])])]),
				]),
			])
			mut var_restrictions := var_coupon.get_email_restrictions()
			mut iife_temp_10 := Class_Automattic_WooCommerce_Utilities_DiscountsUtil{}
			mut iife_result_10 := iife_temp_10.is_coupon_emails_allowed(var_check_emails.clone(),
				var_restrictions.clone())
			if var_restrictions.clone().is_array() && 0 < var_restrictions.clone().array_count()
				&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_10)))) {
				var_coupon.add_coupon_message(Class_WC_Coupon.e_wc_coupon_not_yours_removed())
				this.remove_coupon(var_code.clone())
			}
			mut var_coupon_usage_limit := var_coupon.get_usage_limit_per_user()
			if rt.is_true(rt.less(rt.new_int(0), var_coupon_usage_limit))
				&& rt.is_true(rt.identical(rt.new_int(0), rt.call_function('get_current_user_id', []rt.PhpVal{}))) {
				mut var_coupon_data_store := var_coupon.get_data_store()
				var_billing_email = rt.new_string(rt.call_function('sanitize_email', [
					var_billing_email.clone(),
				]).to_string().to_lower())
				if rt.is_true(var_coupon_data_store)
					&& rt.is_true(rt.greater_equal(rt.call_method(var_coupon_data_store, 'get_usage_by_email', [var_coupon, var_billing_email.clone()]), var_coupon_usage_limit)) {
					if rt.is_true(rt.call_method(var_coupon_data_store,
						'get_tentative_usages_for_user', [var_coupon.get_id(),
						rt.create_array([
							rt.ArrayItem{ key: none, val: var_billing_email },
						])]))
					{
						var_coupon.add_coupon_message(Class_WC_Coupon.e_wc_coupon_usage_limit_coupon_stuck_guest())
					} else {
						var_coupon.add_coupon_message(Class_WC_Coupon.e_wc_coupon_usage_limit_reached())
					}
				}
			}
		}
	}
}

fn (mut this Class_WC_Cart) is_coupon_emails_allowed(var_check_emails rt.PhpVal, var_restrictions rt.PhpVal) rt.PhpVal {
	mut var_check_emails_mutated := var_check_emails
	mut var_restrictions_mutated := var_restrictions
	rt.call_function('wc_doing_it_wrong', [
		rt.new_string('WC_Cart::is_coupon_emails_allowed'),
		rt.call_function('__', [
			rt.new_string('This method has been deprecated and will be removed soon. Use Automattic\\WooCommerce\\Utilities\\DiscountsUtil::is_coupon_emails_allowed instead.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('9.0.0'),
	])
	mut iife_temp_11 := Class_Automattic_WooCommerce_Utilities_DiscountsUtil{}
	mut iife_result_11 := iife_temp_11.is_coupon_emails_allowed(var_check_emails_mutated.clone(),
		var_restrictions_mutated.clone())
	return iife_result_11
}

fn (mut this Class_WC_Cart) has_discount(coupon_code string) bool {
	mut coupon_code_mutated := coupon_code
	mut var_applied_coupons := this.get_applied_coupons()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(coupon_code_mutated))))) {
		return rt.new_bool(var_applied_coupons.clone().array_count() > 0)
	}
	coupon_code_mutated = (rt.call_function('wc_format_coupon_code', [
		rt.new_string(coupon_code_mutated).clone()])).str()
	mut iter_21 := var_applied_coupons.iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_applied_coupon := item_21.val
		if rt.is_true(rt.call_function('wc_is_same_coupon', [
			var_applied_coupon.clone(), rt.new_string(coupon_code_mutated).clone()]))
		{
			return true
		}
	}
	return false
}

fn (mut this Class_WC_Cart) apply_coupon(var_coupon_code rt.PhpVal) bool {
	mut var_coupon_code_mutated := var_coupon_code
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_coupons_enabled', []rt.PhpVal{}))))) {
		return false
	}
	var_coupon_code_mutated = rt.call_function('wc_format_coupon_code', [
		var_coupon_code_mutated.clone()])
	mut var_the_coupon := create_wc_coupon(var_coupon_code_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_same_coupon', [
		var_the_coupon.get_code(),
		var_coupon_code_mutated.clone(),
	])))))
	{
		var_the_coupon.set_code(var_coupon_code_mutated.clone())
		var_the_coupon.add_coupon_message(Class_WC_Coupon.e_wc_coupon_not_exist())
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_the_coupon.is_valid())))) {
		rt.call_function('wc_add_notice', [var_the_coupon.get_error_message(),
			rt.new_string('error')])
		return false
	}
	if this.has_discount(var_coupon_code_mutated.str()) {
		var_the_coupon.add_coupon_message(Class_WC_Coupon.e_wc_coupon_already_applied())
		return false
	}
	if rt.is_true(var_the_coupon.get_individual_use()) {
		mut var_coupons_to_keep := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_apply_individual_use_coupon'),
			rt.new_array(),
			var_the_coupon,
			this.applied_coupons,
		])
		mut iter_22 := this.applied_coupons.iterator()
		for {
			item_22 := iter_22.next() or { break }
			mut var_applied_coupon := item_22.val
			mut var_keep_key := rt.call_function('array_search', [
				var_applied_coupon.clone(), var_coupons_to_keep.clone(),
				rt.new_bool(true)])
			if rt.is_true(rt.identical(rt.new_bool(false), var_keep_key)) {
				this.remove_coupon(var_applied_coupon.clone())
			} else {
				var_coupons_to_keep.array_unset(var_keep_key)
			}
		}
		if !(!rt.is_true(var_coupons_to_keep)) {
			this.applied_coupons = rt.add(this.applied_coupons, var_coupons_to_keep)
		}
	}
	if rt.is_true(this.applied_coupons) {
		mut iter_23 := this.applied_coupons.iterator()
		for {
			item_23 := iter_23.next() or { break }
			mut var_code := item_23.val
			mut var_coupon := create_wc_coupon(var_code.clone())
			if rt.is_true(var_coupon.get_individual_use())
				&& rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('apply_filters', [rt.new_string('woocommerce_apply_with_individual_use_coupon'), rt.new_bool(false), var_the_coupon, var_coupon, this.applied_coupons]))) {
				var_coupon.add_coupon_message(Class_WC_Coupon.e_wc_coupon_already_applied_indiv_use_only())
				return false
			}
		}
	}
	this.applied_coupons.array_push(var_coupon_code_mutated.clone())
	if rt.is_true(var_the_coupon.get_free_shipping()) {
		mut var_packages := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
			'shipping', []rt.PhpVal{}), 'get_packages', []rt.PhpVal{})
		mut var_chosen_shipping_methods := rt.call_method(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'session'), 'get', [rt.new_string('chosen_shipping_methods')])
		mut iter_24 := var_packages.iterator()
		for {
			item_24 := iter_24.next() or { break }
			mut var_package := item_24.val
			mut var_i := item_24.key
			var_chosen_shipping_methods.array_set(var_i, 'free_shipping')
		}
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
			rt.new_string('chosen_shipping_methods'),
			var_chosen_shipping_methods.clone(),
		])
	}
	var_the_coupon.add_coupon_message(Class_WC_Coupon.wc_coupon_success())
	rt.call_function('do_action', [rt.new_string('woocommerce_applied_coupon'),
		var_coupon_code_mutated.clone()])
	return true
}

fn (mut this Class_WC_Cart) get_coupons(var_deprecated rt.PhpVal) rt.PhpVal {
	mut var_coupons := rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('order'), var_deprecated)) {
		return var_coupons.clone()
	}
	mut iter_25 := this.get_applied_coupons().iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_code := item_25.val
		mut var_coupon := create_wc_coupon(var_code.clone())
		var_coupons.array_set(var_code, var_coupon)
	}
	return var_coupons.clone()
}

fn (mut this Class_WC_Cart) get_coupon_discount_amount(var_code rt.PhpVal, ex_tax bool) rt.PhpVal {
	mut var_code_mutated := var_code
	mut var_totals := this.get_coupon_discount_totals()
	mut var_discount_amount := rt.new_int(0)
	mut iter_26 := var_totals.iterator()
	for {
		item_26 := iter_26.next() or { break }
		mut var_value := item_26.val
		mut var_key := item_26.key
		if rt.is_true(rt.call_function('wc_is_same_coupon', [
			var_key.clone(), var_code_mutated.clone()]))
		{
			var_discount_amount = var_value.clone()
			break
		}
	}
	if !var_ex_tax {
		var_discount_amount = rt.add(var_discount_amount,
			this.get_coupon_discount_tax_amount(var_code_mutated.clone()))
	}
	return rt.call_function('wc_cart_round_discount', [var_discount_amount.clone(),
		rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
}

fn (mut this Class_WC_Cart) get_coupon_discount_tax_amount(var_code rt.PhpVal) rt.PhpVal {
	mut var_code_mutated := var_code
	mut var_totals := this.get_coupon_discount_tax_totals()
	mut var_tax_amount := rt.new_int(0)
	mut iter_27 := var_totals.iterator()
	for {
		item_27 := iter_27.next() or { break }
		mut var_value := item_27.val
		mut var_key := item_27.key
		if rt.is_true(rt.call_function('wc_is_same_coupon', [
			var_key.clone(), var_code_mutated.clone()]))
		{
			var_tax_amount = var_value.clone()
			break
		}
	}
	return rt.call_function('wc_cart_round_discount', [var_tax_amount.clone(),
		rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
}

fn (mut this Class_WC_Cart) remove_coupons(var_deprecated rt.PhpVal) {
	this.set_coupon_discount_totals(rt.new_array())
	this.set_coupon_discount_tax_totals(rt.new_array())
	this.set_applied_coupons(rt.new_array())
	rt.call_method(this.session, 'set_session', []rt.PhpVal{})
}

fn (mut this Class_WC_Cart) remove_coupon(var_coupon_code rt.PhpVal) bool {
	mut var_coupon_code_mutated := var_coupon_code
	var_coupon_code_mutated = rt.call_function('wc_format_coupon_code', [
		var_coupon_code_mutated.clone()])
	mut iter_28 := this.get_applied_coupons().iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_applied_coupon := item_28.val
		mut var_key := item_28.key
		if rt.is_true(rt.call_function('wc_is_same_coupon', [
			var_applied_coupon.clone(), var_coupon_code_mutated.clone()]))
		{
			this.applied_coupons.array_unset(var_key)
			break
		}
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
		rt.new_string('refresh_totals'),
		rt.new_bool(true),
	])
	rt.call_function('do_action', [rt.new_string('woocommerce_removed_coupon'),
		var_coupon_code_mutated.clone()])
	return true
}

fn (mut this Class_WC_Cart) calculate_fees() {
	rt.call_function('do_action', [rt.new_string('woocommerce_cart_calculate_fees'),
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this)])
}

fn (mut this Class_WC_Cart) fees_api() rt.PhpVal {
	return this.fees_api
}

fn (mut this Class_WC_Cart) add_fee(var_name rt.PhpVal, var_amount rt.PhpVal, taxable bool, tax_class string) {
	rt.call_method(this.fees_api(), 'add_fee', [
		rt.create_array([rt.ArrayItem{ key: 'name', val: var_name },
			rt.ArrayItem{ key: 'amount', val: rt.new_float(var_amount.to_f64()) },
			rt.ArrayItem{ key: 'taxable', val: taxable }, rt.ArrayItem{
				key: 'tax_class'
				val: tax_class
			}]),
	])
}

fn (mut this Class_WC_Cart) get_fees() rt.PhpVal {
	mut var_fees := rt.call_method(this.fees_api(), 'get_fees', []rt.PhpVal{})
	if rt.is_true(rt.call_function('property_exists', [
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this),
		rt.new_string('fees'),
	]))
	{
		var_fees = rt.add(var_fees, rt.cast_array(rt.get_property(rt.new_object('WC_Cart', [
			'WC_Legacy_Cart',
		], &this), 'fees')))
	}
	return var_fees.clone()
}

fn (mut this Class_WC_Cart) get_total_ex_tax() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_total_ex_tax'),
		rt.call_function('wc_price', [
			rt.call_function('max', [rt.new_int(0), rt.sub(this.get_total('edit'),
				this.get_total_tax())]),
		]),
	])
}

fn (mut this Class_WC_Cart) get_cart_total() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_contents_total'),
		rt.call_function('wc_price', [if rt.is_true(rt.call_function('wc_prices_include_tax',
			[]rt.PhpVal{}))
		{
			rt.add(this.get_cart_contents_total(), this.get_cart_contents_tax())
		} else {
			this.get_cart_contents_total()
		}]),
	])
}

fn (mut this Class_WC_Cart) get_cart_subtotal(compound bool) rt.PhpVal {
	if var_compound {
		mut var_cart_subtotal := rt.call_function('wc_price', [
			rt.add(rt.add(this.get_cart_contents_total(), this.get_shipping_total()), this.get_taxes_total(false,
				false)),
		])
	} else if rt.is_true(this.display_prices_including_tax()) {
		var_cart_subtotal = rt.call_function('wc_price', [
			rt.add(this.get_subtotal(), this.get_subtotal_tax()),
		])
		if rt.is_true(rt.greater(this.get_subtotal_tax(), rt.new_int(0)))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{}))))) {
			var_cart_subtotal = rt.concat(var_cart_subtotal, rt.new_string(
				' <small class="tax_label">' +
				(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'inc_tax_or_vat', []rt.PhpVal{})).str() +
				'</small>'))
		}
	} else {
		var_cart_subtotal = rt.call_function('wc_price', [this.get_subtotal()])
		if rt.is_true(rt.greater(this.get_subtotal_tax(), rt.new_int(0)))
			&& rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{})) {
			var_cart_subtotal = rt.concat(var_cart_subtotal, rt.new_string(
				' <small class="tax_label">' +
				(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'ex_tax_or_vat', []rt.PhpVal{})).str() +
				'</small>'))
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_subtotal'),
		var_cart_subtotal.clone(), rt.new_bool(compound),
		rt.new_object('WC_Cart', [
			'WC_Legacy_Cart',
		], &this)])
}

fn (mut this Class_WC_Cart) get_product_price(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	if rt.is_true(this.display_prices_including_tax()) {
		mut var_product_price := rt.call_function('wc_get_price_including_tax', [
			var_product_mutated.clone(),
		])
	} else {
		var_product_price = rt.call_function('wc_get_price_excluding_tax', [
			var_product_mutated.clone()])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_product_price'),
		rt.call_function('wc_price', [var_product_price.clone()]),
		var_product_mutated.clone(),
	])
}

fn (mut this Class_WC_Cart) get_product_subtotal(var_product rt.PhpVal, var_quantity rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_quantity_mutated := var_quantity
	mut var_price := rt.call_method(var_product_mutated, 'get_price', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_product_mutated, 'is_taxable', []rt.PhpVal{})) {
		if rt.is_true(this.display_prices_including_tax()) {
			mut var_row_price := rt.call_function('wc_get_price_including_tax', [
				var_product_mutated.clone(),
				rt.create_array([rt.ArrayItem{ key: 'qty', val: var_quantity_mutated }]),
			])
			mut var_product_subtotal := rt.call_function('wc_price', [
				var_row_price.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{})))))
				&& rt.is_true(rt.greater(this.get_subtotal_tax(), rt.new_int(0))) {
				var_product_subtotal = rt.concat(var_product_subtotal, rt.new_string(
					' <small class="tax_label">' +
					(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'inc_tax_or_vat', []rt.PhpVal{})).str() +
					'</small>'))
			}
		} else {
			var_row_price = rt.call_function('wc_get_price_excluding_tax', [
				var_product_mutated.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'qty', val: var_quantity_mutated },
				])])
			var_product_subtotal = rt.call_function('wc_price', [
				var_row_price.clone()])
			if rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{}))
				&& rt.is_true(rt.greater(this.get_subtotal_tax(), rt.new_int(0))) {
				var_product_subtotal = rt.concat(var_product_subtotal, rt.new_string(
					' <small class="tax_label">' +
					(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'ex_tax_or_vat', []rt.PhpVal{})).str() +
					'</small>'))
			}
		}
	} else {
		var_row_price = rt.new_float(var_price.to_f64()) * rt.new_float(var_quantity_mutated.to_f64())
		var_product_subtotal = rt.call_function('wc_price', [
			var_row_price.clone()])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_product_subtotal'),
		var_product_subtotal.clone(),
		var_product_mutated.clone(),
		var_quantity_mutated.clone(),
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this),
	])
}

fn (mut this Class_WC_Cart) get_cart_tax() rt.PhpVal {
	mut var_cart_total_tax := rt.call_function('wc_round_tax_total', [
		rt.add(rt.add(this.get_cart_contents_tax(), this.get_shipping_tax()), this.get_fee_tax()),
	])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_cart_tax'),
		if rt.is_true(var_cart_total_tax) { rt.call_function('wc_price', [
				var_cart_total_tax.clone()]) } else { rt.new_string('') }])
}

fn (mut this Class_WC_Cart) get_tax_amount(var_tax_rate_id rt.PhpVal) rt.PhpVal {
	mut var_taxes := rt.call_function('wc_array_merge_recursive_numeric', [
		this.get_cart_contents_taxes(),
		this.get_fee_taxes(),
	])
	return if var_taxes.array_isset(var_tax_rate_id) {
		var_taxes.array_get(var_tax_rate_id)
	} else {
		rt.new_int(0)
	}
}

fn (mut this Class_WC_Cart) get_shipping_tax_amount(var_tax_rate_id rt.PhpVal) rt.PhpVal {
	mut var_taxes := this.get_shipping_taxes()
	return if var_taxes.array_isset(var_tax_rate_id) {
		var_taxes.array_get(var_tax_rate_id)
	} else {
		rt.new_int(0)
	}
}

fn (mut this Class_WC_Cart) get_taxes_total(compound bool, display bool) rt.PhpVal {
	mut var_total := rt.new_int(0)
	mut var_taxes := this.get_taxes()
	mut iter_29 := var_taxes.iterator()
	for {
		item_29 := iter_29.next() or { break }
		mut var_tax := item_29.val
		mut var_key := item_29.key
		mut iife_temp_12 := Class_WC_Tax{}
		mut iife_result_12 := iife_temp_12.is_compound(var_key.clone())
		if !var_compound && rt.is_true(iife_result_12) {
			continue
		}
		var_total = rt.add(var_total, var_tax)
	}
	if var_display {
		var_total = rt.call_function('wc_format_decimal', [var_total.clone(),
			rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_taxes_total'),
		var_total.clone(),
		rt.new_bool(compound),
		rt.new_bool(display),
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this),
	])
}

fn (mut this Class_WC_Cart) get_total_discount() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cart_total_discount'),
		if rt.is_true(this.get_discount_total()) { rt.call_function('wc_price', [
				this.get_discount_total(),
			]) } else { rt.new_bool(false) },
		rt.new_object('WC_Cart', [
			'WC_Legacy_Cart',
		], &this),
	])
}

fn (mut this Class_WC_Cart) reset_totals() {
	this.totals = this.default_totals
	rt.call_method(this.fees_api, 'remove_all_fees', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_cart_reset'),
		rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this), rt.new_bool(false)])
}

fn (mut this Class_WC_Cart) get_tax_price_display_mode() string {
	if rt.is_true(this.get_customer())
		&& rt.is_true(rt.call_method(this.get_customer(), 'get_is_vat_exempt', []rt.PhpVal{})) {
		return 'excl'
	}
	return (rt.call_function('get_option', [
		rt.new_string('woocommerce_tax_display_cart'),
	])).str()
}

fn (mut this Class_WC_Cart) get_cart_hash() rt.PhpVal {
	mut var_cart_session := rt.call_method(this.session, 'get_cart_for_session', []rt.PhpVal{})
	mut var_hash := rt.new_string((if rt.is_true(var_cart_session) {
		md5.hexhash((rt.call_function('wp_json_encode', [var_cart_session.clone()])).str() +
			(this.get_total('edit')).str())
	} else {
		''
	}).str())
	var_hash = rt.call_function('apply_filters_deprecated', [
		rt.new_string('woocommerce_add_to_cart_hash'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_hash },
			rt.ArrayItem{ key: none, val: var_cart_session }]),
		rt.new_string('3.6.0'),
		rt.new_string('woocommerce_cart_hash'),
	])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_hash'),
		var_hash.clone(), var_cart_session.clone()])
}

struct Class_WC_Legacy_Cart {
	rt.PhpObjectBase
}

struct Class_WC_Cart_Session {
	rt.PhpObjectBase
}

struct Class_WC_Cart_Fees {
	rt.PhpObjectBase
}

struct Class_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
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

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

struct Class_WC_Cart_Totals {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ShippingUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_DiscountsUtil {
	rt.PhpObjectBase
}

fn create_wc_cart() &Class_WC_Cart {
	mut obj := &Class_WC_Cart{
		PhpObjectBase:           rt.PhpObjectBase{}
		cart_context:            rt.new_string('shortcode')
		cart_contents:           rt.new_array()
		removed_cart_contents:   rt.new_array()
		applied_coupons:         rt.new_array()
		shipping_methods:        rt.new_null()
		has_calculated_shipping: false
		default_totals:          rt.new_array()
		totals:                  rt.new_array()
		session:                 rt.new_null()
		fees_api:                rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_legacy_cart(_args ...rt.PhpVal) &Class_WC_Legacy_Cart {
	mut obj := &Class_WC_Legacy_Cart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cart_session(_args ...rt.PhpVal) &Class_WC_Cart_Session {
	mut obj := &Class_WC_Cart_Session{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cart_fees(_args ...rt.PhpVal) &Class_WC_Cart_Fees {
	mut obj := &Class_WC_Cart_Fees{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_coupon(_args ...rt.PhpVal) &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
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

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cart_totals(_args ...rt.PhpVal) &Class_WC_Cart_Totals {
	mut obj := &Class_WC_Cart_Totals{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_shippingutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ShippingUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ShippingUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_localpickuputils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_discountsutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_DiscountsUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_DiscountsUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Cart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'get_cart_contents' {
			return this.get_cart_contents()
		}
		'get_removed_cart_contents' {
			return this.get_removed_cart_contents()
		}
		'get_applied_coupons' {
			return this.get_applied_coupons()
		}
		'get_coupon_discount_totals' {
			return this.get_coupon_discount_totals()
		}
		'get_coupon_discount_tax_totals' {
			return this.get_coupon_discount_tax_totals()
		}
		'get_totals' {
			return this.get_totals()
		}
		'get_totals_var' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_totals_var(dispatch_arg_0)
		}
		'get_subtotal' {
			return this.get_subtotal()
		}
		'get_subtotal_tax' {
			return this.get_subtotal_tax()
		}
		'get_discount_total' {
			return this.get_discount_total()
		}
		'get_discount_tax' {
			return this.get_discount_tax()
		}
		'get_shipping_total' {
			return this.get_shipping_total()
		}
		'get_shipping_tax' {
			return this.get_shipping_tax()
		}
		'get_cart_contents_total' {
			return this.get_cart_contents_total()
		}
		'get_cart_contents_tax' {
			return this.get_cart_contents_tax()
		}
		'get_total' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_total(dispatch_arg_0)
		}
		'get_total_tax' {
			return this.get_total_tax()
		}
		'get_fee_total' {
			return this.get_fee_total()
		}
		'get_fee_tax' {
			return this.get_fee_tax()
		}
		'get_shipping_taxes' {
			return this.get_shipping_taxes()
		}
		'get_cart_contents_taxes' {
			return this.get_cart_contents_taxes()
		}
		'get_fee_taxes' {
			return this.get_fee_taxes()
		}
		'display_prices_including_tax' {
			return this.display_prices_including_tax()
		}
		'set_cart_contents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_cart_contents(dispatch_arg_0)
			return rt.new_null()
		}
		'set_removed_cart_contents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_removed_cart_contents(dispatch_arg_0)
			return rt.new_null()
		}
		'set_applied_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_applied_coupons(dispatch_arg_0)
			return rt.new_null()
		}
		'set_coupon_discount_totals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_coupon_discount_totals(dispatch_arg_0)
			return rt.new_null()
		}
		'set_coupon_discount_tax_totals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_coupon_discount_tax_totals(dispatch_arg_0)
			return rt.new_null()
		}
		'set_totals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_totals(dispatch_arg_0)
			return rt.new_null()
		}
		'set_subtotal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_subtotal(dispatch_arg_0)
			return rt.new_null()
		}
		'set_subtotal_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_subtotal_tax(dispatch_arg_0)
			return rt.new_null()
		}
		'set_discount_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_discount_total(dispatch_arg_0)
			return rt.new_null()
		}
		'set_discount_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_discount_tax(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_total(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_tax(dispatch_arg_0)
			return rt.new_null()
		}
		'set_cart_contents_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_cart_contents_total(dispatch_arg_0)
			return rt.new_null()
		}
		'set_cart_contents_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_cart_contents_tax(dispatch_arg_0)
			return rt.new_null()
		}
		'set_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_total(dispatch_arg_0)
			return rt.new_null()
		}
		'set_total_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_total_tax(dispatch_arg_0)
			return rt.new_null()
		}
		'set_fee_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_fee_total(dispatch_arg_0)
			return rt.new_null()
		}
		'set_fee_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_fee_tax(dispatch_arg_0)
			return rt.new_null()
		}
		'set_shipping_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_shipping_taxes(dispatch_arg_0)
			return rt.new_null()
		}
		'set_cart_contents_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_cart_contents_taxes(dispatch_arg_0)
			return rt.new_null()
		}
		'set_fee_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_fee_taxes(dispatch_arg_0)
			return rt.new_null()
		}
		'get_taxes' {
			return this.get_taxes()
		}
		'get_cart' {
			return this.get_cart()
		}
		'get_cart_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_cart_item(dispatch_arg_0)
		}
		'is_empty' {
			return rt.new_bool(this.is_empty())
		}
		'empty_cart' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.empty_cart(dispatch_arg_0)
			return rt.new_null()
		}
		'get_cart_contents_count' {
			return this.get_cart_contents_count()
		}
		'get_cart_contents_weight' {
			return this.get_cart_contents_weight()
		}
		'get_cart_item_quantities' {
			return this.get_cart_item_quantities()
		}
		'check_cart_items' {
			return this.check_cart_items()
		}
		'check_cart_coupons' {
			this.check_cart_coupons()
			return rt.new_null()
		}
		'check_cart_item_validity' {
			return this.check_cart_item_validity()
		}
		'check_cart_item_sold_individually' {
			return this.check_cart_item_sold_individually()
		}
		'check_cart_item_stock' {
			return this.check_cart_item_stock()
		}
		'get_item_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_item_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_cross_sells' {
			return this.get_cross_sells()
		}
		'get_remove_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_remove_url(dispatch_arg_0)
		}
		'get_undo_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_undo_url(dispatch_arg_0)
		}
		'get_tax_totals' {
			return this.get_tax_totals()
		}
		'get_cart_item_tax_classes' {
			return this.get_cart_item_tax_classes()
		}
		'get_cart_item_tax_classes_for_shipping' {
			return this.get_cart_item_tax_classes_for_shipping()
		}
		'get_displayed_subtotal' {
			return this.get_displayed_subtotal()
		}
		'find_product_in_cart' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.find_product_in_cart(dispatch_arg_0))
		}
		'generate_cart_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.generate_cart_id(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'add_to_cart' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(this.add_to_cart(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4))
		}
		'remove_cart_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.remove_cart_item(dispatch_arg_0))
		}
		'restore_cart_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.restore_cart_item(dispatch_arg_0))
		}
		'set_quantity' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.set_quantity(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_customer' {
			return this.get_customer()
		}
		'calculate_totals' {
			this.calculate_totals()
			return rt.new_null()
		}
		'needs_payment' {
			return this.needs_payment()
		}
		'get_shipping_methods' {
			return this.get_shipping_methods()
		}
		'has_calculated_shipping' {
			return rt.new_bool(this.has_calculated_shipping())
		}
		'calculate_shipping' {
			return this.calculate_shipping()
		}
		'get_chosen_shipping_methods' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_chosen_shipping_methods(dispatch_arg_0)
		}
		'filter_items_needing_shipping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.filter_items_needing_shipping(dispatch_arg_0))
		}
		'get_items_needing_shipping' {
			return this.get_items_needing_shipping()
		}
		'get_shipping_packages' {
			return this.get_shipping_packages()
		}
		'get_shipping_package_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_shipping_package_name(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'needs_shipping' {
			return rt.new_bool(this.needs_shipping())
		}
		'needs_shipping_address' {
			return this.needs_shipping_address()
		}
		'show_shipping' {
			return rt.new_bool(this.show_shipping())
		}
		'get_cart_shipping_total' {
			return this.get_cart_shipping_total()
		}
		'check_customer_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.check_customer_coupons(dispatch_arg_0)
			return rt.new_null()
		}
		'is_coupon_emails_allowed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.is_coupon_emails_allowed(dispatch_arg_0, dispatch_arg_1)
		}
		'has_discount' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_discount(dispatch_arg_0))
		}
		'apply_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.apply_coupon(dispatch_arg_0))
		}
		'get_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_coupons(dispatch_arg_0)
		}
		'get_coupon_discount_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_coupon_discount_amount(dispatch_arg_0, dispatch_arg_1)
		}
		'get_coupon_discount_tax_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_coupon_discount_tax_amount(dispatch_arg_0)
		}
		'remove_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_coupons(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.remove_coupon(dispatch_arg_0))
		}
		'calculate_fees' {
			this.calculate_fees()
			return rt.new_null()
		}
		'fees_api' {
			return this.fees_api()
		}
		'add_fee' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.add_fee(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'get_fees' {
			return this.get_fees()
		}
		'get_total_ex_tax' {
			return this.get_total_ex_tax()
		}
		'get_cart_total' {
			return this.get_cart_total()
		}
		'get_cart_subtotal' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_cart_subtotal(dispatch_arg_0)
		}
		'get_product_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_price(dispatch_arg_0)
		}
		'get_product_subtotal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_product_subtotal(dispatch_arg_0, dispatch_arg_1)
		}
		'get_cart_tax' {
			return this.get_cart_tax()
		}
		'get_tax_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_tax_amount(dispatch_arg_0)
		}
		'get_shipping_tax_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_shipping_tax_amount(dispatch_arg_0)
		}
		'get_taxes_total' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_taxes_total(dispatch_arg_0, dispatch_arg_1)
		}
		'get_total_discount' {
			return this.get_total_discount()
		}
		'reset_totals' {
			this.reset_totals()
			return rt.new_null()
		}
		'get_tax_price_display_mode' {
			return rt.new_string(this.get_tax_price_display_mode())
		}
		'get_cart_hash' {
			return this.get_cart_hash()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Cart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cart_context' { return this.cart_context }
		'cart_contents' { return this.cart_contents }
		'removed_cart_contents' { return this.removed_cart_contents }
		'applied_coupons' { return this.applied_coupons }
		'shipping_methods' { return this.shipping_methods }
		'has_calculated_shipping' { return rt.new_bool(this.has_calculated_shipping) }
		'default_totals' { return this.default_totals }
		'totals' { return this.totals }
		'session' { return this.session }
		'fees_api' { return this.fees_api }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Cart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cart_context' {
			this.cart_context = val
			return true
		}
		'cart_contents' {
			this.cart_contents = val
			return true
		}
		'removed_cart_contents' {
			this.removed_cart_contents = val
			return true
		}
		'applied_coupons' {
			this.applied_coupons = val
			return true
		}
		'shipping_methods' {
			this.shipping_methods = val
			return true
		}
		'has_calculated_shipping' {
			this.has_calculated_shipping = val.to_bool()
			return true
		}
		'default_totals' {
			this.default_totals = val
			return true
		}
		'totals' {
			this.totals = val
			return true
		}
		'session' {
			this.session = val
			return true
		}
		'fees_api' {
			this.fees_api = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Legacy_Cart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Legacy_Cart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Legacy_Cart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Cart_Session) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cart_Session) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cart_Session) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Cart_Fees) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cart_Fees) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cart_Fees) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Cart_Totals) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cart_Totals) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cart_Totals) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ShippingUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ShippingUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ShippingUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_LocalPickupUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/legacy/class-wc-legacy-cart.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-cart-fees.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-cart-session.php',
		'4')
}
