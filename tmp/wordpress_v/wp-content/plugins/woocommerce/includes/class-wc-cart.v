import rt

struct Class_WC_Cart {
	rt.PhpObjectBase
pub mut:
		cart_context rt.PhpVal = rt.new_string('shortcode')
		cart_contents rt.PhpVal = rt.new_array()
		removed_cart_contents rt.PhpVal = rt.new_array()
		applied_coupons rt.PhpVal = rt.new_array()
		shipping_methods rt.PhpVal = rt.new_null()
		has_calculated_shipping bool
		default_totals rt.PhpVal = rt.new_array()
		totals rt.PhpVal = rt.new_array()
		session rt.PhpVal = rt.new_null()
		fees_api rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Cart) construct()  {
	this.session = create_wc_cart_session(rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this).dup())
	this.fees_api = create_wc_cart_fees()
	rt.call_method(this.session, 'init', []rt.PhpVal{})
	rt.call_function('add_action', [rt.new_string('woocommerce_add_to_cart'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) }, rt.ArrayItem{ key: none, val: 'calculate_totals' }]), rt.new_int(20), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('woocommerce_applied_coupon'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) }, rt.ArrayItem{ key: none, val: 'calculate_totals' }]), rt.new_int(20), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('woocommerce_removed_coupon'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) }, rt.ArrayItem{ key: none, val: 'calculate_totals' }]), rt.new_int(20), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('woocommerce_cart_item_removed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) }, rt.ArrayItem{ key: none, val: 'calculate_totals' }]), rt.new_int(20), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('woocommerce_cart_item_restored'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) }, rt.ArrayItem{ key: none, val: 'calculate_totals' }]), rt.new_int(20), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('woocommerce_check_cart_items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) }, rt.ArrayItem{ key: none, val: 'check_cart_items' }]), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_check_cart_items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) }, rt.ArrayItem{ key: none, val: 'check_cart_coupons' }]), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_after_checkout_validation'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this) }, rt.ArrayItem{ key: none, val: 'check_customer_coupons' }]), rt.new_int(1), rt.new_int(2)])
}

fn (mut this Class_WC_Cart) magic_clone()  {
	this.session = // unsupported expression: Expr_Clone
	this.fees_api = // unsupported expression: Expr_Clone
	rt.call_method(this.session, 'set_cart', [rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this)])
}

fn (mut this Class_WC_Cart) get_cart_contents() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_cart_contents'), rt.cast_array(this.cart_contents)])
}

fn (mut this Class_WC_Cart) get_removed_cart_contents() rt.PhpVal {
	return rt.cast_array(this.removed_cart_contents)
}

fn (mut this Class_WC_Cart) get_applied_coupons() rt.PhpVal {
	return rt.cast_array(this.applied_coupons)
}

fn (mut this Class_WC_Cart) get_coupon_discount_totals() rt.PhpVal {
	return rt.cast_array(rt.get_property(rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this), 'coupon_discount_totals'))
}

fn (mut this Class_WC_Cart) get_coupon_discount_tax_totals() rt.PhpVal {
	return rt.cast_array(rt.get_property(rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this), 'coupon_discount_tax_totals'))
}

fn (mut this Class_WC_Cart) get_totals() rt.PhpVal {
	return if !rt.is_true(this.totals) { this.default_totals } else { this.totals }
}

fn (mut this Class_WC_Cart) get_totals_var(var_key rt.PhpVal) rt.PhpVal {
	return if this.totals.array_isset(var_key) { this.totals.array_get(var_key) } else { this.default_totals.array_get(var_key) }
}

fn (mut this Class_WC_Cart) get_subtotal() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('subtotal'))])
}

fn (mut this Class_WC_Cart) get_subtotal_tax() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('subtotal_tax'))])
}

fn (mut this Class_WC_Cart) get_discount_total() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('discount_total'))])
}

fn (mut this Class_WC_Cart) get_discount_tax() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('discount_tax'))])
}

fn (mut this Class_WC_Cart) get_shipping_total() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('shipping_total'))])
}

fn (mut this Class_WC_Cart) get_shipping_tax() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('shipping_tax'))])
}

fn (mut this Class_WC_Cart) get_cart_contents_total() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('cart_contents_total'))])
}

fn (mut this Class_WC_Cart) get_cart_contents_tax() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('cart_contents_tax'))])
}

fn (mut this Class_WC_Cart) get_total(context string) rt.PhpVal {
	mut var_total := rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('total'))])
	return if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) { rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_total'), rt.call_function('wc_price', [var_total.dup()])]) } else { var_total }
}

fn (mut this Class_WC_Cart) get_total_tax() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('total_tax'))])
}

fn (mut this Class_WC_Cart) get_fee_total() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('fee_total'))])
}

fn (mut this Class_WC_Cart) get_fee_tax() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('fee_tax'))])
}

fn (mut this Class_WC_Cart) get_shipping_taxes() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('shipping_taxes'))])
}

fn (mut this Class_WC_Cart) get_cart_contents_taxes() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('cart_contents_taxes'))])
}

fn (mut this Class_WC_Cart) get_fee_taxes() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, this.get_totals_var(rt.new_string('fee_taxes'))])
}

fn (mut this Class_WC_Cart) display_prices_including_tax() rt.PhpVal {
	return rt.call_function('apply_filters', ['woocommerce_cart_' + @FN, rt.identical(rt.new_string('incl'), this.get_tax_price_display_mode())])
}

fn (mut this Class_WC_Cart) set_cart_contents(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.cart_contents = rt.cast_array(var_value_mutated)
}

fn (mut this Class_WC_Cart) set_removed_cart_contents(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.removed_cart_contents = rt.cast_array(var_value_mutated)
}

fn (mut this Class_WC_Cart) set_applied_coupons(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.applied_coupons = rt.cast_array(var_value_mutated)
}

fn (mut this Class_WC_Cart) set_coupon_discount_totals(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.dispatch_set_prop('coupon_discount_totals', rt.cast_array(var_value_mutated))
}

fn (mut this Class_WC_Cart) set_coupon_discount_tax_totals(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.dispatch_set_prop('coupon_discount_tax_totals', rt.cast_array(var_value_mutated))
}

fn (mut this Class_WC_Cart) set_totals(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals = rt.call_function('wp_parse_args', [var_value_mutated.dup(), this.default_totals])
}

fn (mut this Class_WC_Cart) set_subtotal(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('subtotal', rt.call_function('wc_format_decimal', [var_value_mutated.dup()]))
}

fn (mut this Class_WC_Cart) set_subtotal_tax(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('subtotal_tax', var_value_mutated.dup())
}

fn (mut this Class_WC_Cart) set_discount_total(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('discount_total', var_value_mutated.dup())
}

fn (mut this Class_WC_Cart) set_discount_tax(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('discount_tax', var_value_mutated.dup())
}

fn (mut this Class_WC_Cart) set_shipping_total(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('shipping_total', rt.call_function('wc_format_decimal', [var_value_mutated.dup()]))
}

fn (mut this Class_WC_Cart) set_shipping_tax(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('shipping_tax', var_value_mutated.dup())
}

fn (mut this Class_WC_Cart) set_cart_contents_total(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('cart_contents_total', rt.call_function('wc_format_decimal', [var_value_mutated.dup()]))
}

fn (mut this Class_WC_Cart) set_cart_contents_tax(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('cart_contents_tax', var_value_mutated.dup())
}

fn (mut this Class_WC_Cart) set_total(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('total', rt.call_function('wc_format_decimal', [var_value_mutated.dup(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]))
}

fn (mut this Class_WC_Cart) set_total_tax(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('total_tax', rt.call_function('wc_round_tax_total', [var_value_mutated.dup()]))
}

fn (mut this Class_WC_Cart) set_fee_total(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('fee_total', rt.call_function('wc_format_decimal', [var_value_mutated.dup()]))
}

fn (mut this Class_WC_Cart) set_fee_tax(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('fee_tax', var_value_mutated.dup())
}

fn (mut this Class_WC_Cart) set_shipping_taxes(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('shipping_taxes', rt.cast_array(var_value_mutated))
}

fn (mut this Class_WC_Cart) set_cart_contents_taxes(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('cart_contents_taxes', rt.cast_array(var_value_mutated))
}

fn (mut this Class_WC_Cart) set_fee_taxes(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.totals.array_set('fee_taxes', rt.cast_array(var_value_mutated))
}

fn (mut this Class_WC_Cart) get_taxes() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_get_taxes'), rt.call_function('wc_array_merge_recursive_numeric', [this.get_shipping_taxes(), this.get_cart_contents_taxes(), this.get_fee_taxes()]), rt.new_object('WC_Cart', ['WC_Legacy_Cart'], &this)])
}

fn (mut this Class_WC_Cart) get_cart() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('wp_loaded')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Get cart should not be called before the wp_loaded action.'), rt.new_string('woocommerce')]), rt.new_string('2.3')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_load_cart_from_session')]))))) {
		rt.call_method(this.session, 'get_cart_from_session', []rt.PhpVal{})
	}
	return rt.call_function('array_filter', [this.get_cart_contents()])
}

fn (mut this Class_WC_Cart) get_cart_item(var_item_key rt.PhpVal) rt.PhpVal {
	return if this.cart_contents.array_isset(var_item_key) { this.cart_contents.array_get(var_item_key) } else { rt.new_array() }
}

fn (mut this Class_WC_Cart) is_empty() bool {
	return rt.new_bool(0 == this.get_cart().array_count())
}

fn (mut this Class_WC_Cart) empty_cart(clear_persistent_cart bool)  {
	rt.call_function('do_action', [rt.new_string('woocommerce_before_cart_emptied'), rt.new_bool(clear_persistent_cart)])
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
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'reset_shipping', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_cart_emptied'), rt.new_bool(clear_persistent_cart)])
}

fn (mut this Class_WC_Cart) get_cart_contents_count() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_contents_count'), rt.call_function('array_sum', [rt.call_function('wp_list_pluck', [this.get_cart(), rt.new_string('quantity')])])])
}

fn (mut this Class_WC_Cart) get_cart_contents_weight() rt.PhpVal {
	mut var_weight := rt.new_float(rt.new_float(0))
	{
		mut iter_1 := this.get_cart().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_values := item_1.val
			if rt.is_true(rt.call_method(var_values.array_get('data'), 'has_weight', []rt.PhpVal{})) {
				// unsupported expression: Expr_AssignOp_Plus
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_cart_contents_weight'), var_weight.dup()])
}

fn (mut this Class_WC_Cart) get_cart_item_quantities() rt.PhpVal {
	mut var_quantities := rt.new_array()
	{
		mut iter_1 := this.get_cart().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_values := item_1.val
			mut var_product := var_values.array_get('data')
			var_quantities.array_set(rt.call_method(, 'get_stock_managed_by_id', []rt.PhpVal{}), if .array_isset() {  } else {  })
		}
	}
	return var_quantities.dup()
}

fn (mut this Class_WC_Cart) check_cart_items() rt.PhpVal {
	
}

fn (mut this Class_WC_Cart) check_cart_coupons()  {
}

fn (mut this Class_WC_Cart) check_cart_item_validity() rt.PhpVal {
}

fn (mut this Class_WC_Cart) check_cart_item_sold_individually() rt.PhpVal {
}

fn (mut this Class_WC_Cart) check_cart_item_stock() rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_item_data(var_cart_item rt.PhpVal, flat bool) rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_cross_sells() rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_remove_url(var_cart_item_key rt.PhpVal) rt.PhpVal {
	mut var_cart_item_key_mutated := var_cart_item_key
}

fn (mut this Class_WC_Cart) get_undo_url(var_cart_item_key rt.PhpVal) rt.PhpVal {
	mut var_cart_item_key_mutated := var_cart_item_key
}

fn (mut this Class_WC_Cart) get_tax_totals() rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_cart_item_tax_classes() rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_cart_item_tax_classes_for_shipping() rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_displayed_subtotal() rt.PhpVal {
}

fn (mut this Class_WC_Cart) find_product_in_cart(cart_id bool) string {
	mut cart_id_mutated := cart_id
}

fn (mut this Class_WC_Cart) generate_cart_id(var_product_id rt.PhpVal, variation_id i64, var_variation rt.PhpVal, var_cart_item_data rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
	mut variation_id_mutated := variation_id
	mut var_variation_mutated := var_variation
	mut var_cart_item_data_mutated := var_cart_item_data
}

fn (mut this Class_WC_Cart) add_to_cart(product_id i64, quantity i64, variation_id i64, var_variation rt.PhpVal, var_cart_item_data rt.PhpVal) bool {
	mut product_id_mutated := product_id
	mut quantity_mutated := quantity
	mut variation_id_mutated := variation_id
	mut var_variation_mutated := var_variation
	mut var_cart_item_data_mutated := var_cart_item_data
	return false
}

fn (mut this Class_WC_Cart) remove_cart_item(var_cart_item_key rt.PhpVal) bool {
	mut var_cart_item_key_mutated := var_cart_item_key
}

fn (mut this Class_WC_Cart) restore_cart_item(var_cart_item_key rt.PhpVal) bool {
	mut var_cart_item_key_mutated := var_cart_item_key
}

fn (mut this Class_WC_Cart) set_quantity(var_cart_item_key rt.PhpVal, quantity i64, refresh_totals bool) bool {
	mut var_cart_item_key_mutated := var_cart_item_key
	mut quantity_mutated := quantity
}

fn (mut this Class_WC_Cart) get_customer() rt.PhpVal {
}

fn (mut this Class_WC_Cart) calculate_totals()  {
}

fn (mut this Class_WC_Cart) needs_payment() rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_shipping_methods() rt.PhpVal {
}

fn (mut this Class_WC_Cart) has_calculated_shipping() bool {
}

fn (mut this Class_WC_Cart) calculate_shipping() rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_chosen_shipping_methods(var_calculated_shipping_packages rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Cart) filter_items_needing_shipping(var_item rt.PhpVal) bool {
}

fn (mut this Class_WC_Cart) get_items_needing_shipping() rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_shipping_packages() rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_shipping_package_name(var_package rt.PhpVal, var_index rt.PhpVal, var_total_packages rt.PhpVal) rt.PhpVal {
	mut var_index_mutated := var_index
}

fn (mut this Class_WC_Cart) needs_shipping() bool {
}

fn (mut this Class_WC_Cart) needs_shipping_address() rt.PhpVal {
}

fn (mut this Class_WC_Cart) show_shipping() bool {
}

fn (mut this Class_WC_Cart) get_cart_shipping_total() rt.PhpVal {
}

fn (mut this Class_WC_Cart) check_customer_coupons(var_posted rt.PhpVal)  {
}

fn (mut this Class_WC_Cart) is_coupon_emails_allowed(var_check_emails rt.PhpVal, var_restrictions rt.PhpVal) rt.PhpVal {
	mut var_check_emails_mutated := var_check_emails
	mut var_restrictions_mutated := var_restrictions
}

fn (mut this Class_WC_Cart) has_discount(coupon_code string) bool {
	mut coupon_code_mutated := coupon_code
}

fn (mut this Class_WC_Cart) apply_coupon(var_coupon_code rt.PhpVal) bool {
	mut var_coupon_code_mutated := var_coupon_code
}

fn (mut this Class_WC_Cart) get_coupons(var_deprecated rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_coupon_discount_amount(var_code rt.PhpVal, ex_tax bool) rt.PhpVal {
	mut var_code_mutated := var_code
}

fn (mut this Class_WC_Cart) get_coupon_discount_tax_amount(var_code rt.PhpVal) rt.PhpVal {
	mut var_code_mutated := var_code
}

fn (mut this Class_WC_Cart) remove_coupons(var_deprecated rt.PhpVal)  {
}

fn (mut this Class_WC_Cart) remove_coupon(var_coupon_code rt.PhpVal) bool {
	mut var_coupon_code_mutated := var_coupon_code
}

fn (mut this Class_WC_Cart) calculate_fees()  {
}

fn (mut this Class_WC_Cart) fees_api() rt.PhpVal {
}

fn (mut this Class_WC_Cart) add_fee(var_name rt.PhpVal, var_amount rt.PhpVal, taxable bool, tax_class string)  {
}

fn (mut this Class_WC_Cart) get_fees() rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_total_ex_tax() rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_cart_total() rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_cart_subtotal(compound bool) rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_product_price(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
}

fn (mut this Class_WC_Cart) get_product_subtotal(var_product rt.PhpVal, var_quantity rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_quantity_mutated := var_quantity
}

fn (mut this Class_WC_Cart) get_cart_tax() rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_tax_amount(var_tax_rate_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_shipping_tax_amount(var_tax_rate_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_taxes_total(compound bool, display bool) rt.PhpVal {
}

fn (mut this Class_WC_Cart) get_total_discount() rt.PhpVal {
}

fn (mut this Class_WC_Cart) reset_totals()  {
}

fn (mut this Class_WC_Cart) get_tax_price_display_mode() string {
}

fn (mut this Class_WC_Cart) get_cart_hash() rt.PhpVal {
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

fn create_wc_cart() &Class_WC_Cart {
	mut obj := &Class_WC_Cart{
		PhpObjectBase: rt.PhpObjectBase{}
		cart_context: rt.new_string('shortcode')
		cart_contents: rt.new_array()
		removed_cart_contents: rt.new_array()
		applied_coupons: rt.new_array()
		shipping_methods: rt.new_null()
		has_calculated_shipping: false
		default_totals: rt.new_array()
		totals: rt.new_array()
		session: rt.new_null()
		fees_api: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_legacy_cart() &Class_WC_Legacy_Cart {
	mut obj := &Class_WC_Legacy_Cart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cart_session() &Class_WC_Cart_Session {
	mut obj := &Class_WC_Cart_Session{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cart_fees() &Class_WC_Cart_Fees {
	mut obj := &Class_WC_Cart_Fees{
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
			return this.generate_cart_id(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'add_to_cart' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(this.add_to_cart(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
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
		else { return none }
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
		'cart_context' { this.cart_context = val; return true }
		'cart_contents' { this.cart_contents = val; return true }
		'removed_cart_contents' { this.removed_cart_contents = val; return true }
		'applied_coupons' { this.applied_coupons = val; return true }
		'shipping_methods' { this.shipping_methods = val; return true }
		'has_calculated_shipping' { this.has_calculated_shipping = (val).to_bool(); return true }
		'default_totals' { this.default_totals = val; return true }
		'totals' { this.totals = val; return true }
		'session' { this.session = val; return true }
		'fees_api' { this.fees_api = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_cart_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/legacy/class-wc-legacy-cart.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-cart-fees.php', '4')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/class-wc-cart-session.php', '4')
}
