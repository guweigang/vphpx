import rt

struct Class_WC_Abstract_Order {
	rt.PhpObjectBase
pub mut:
		data rt.PhpVal = rt.new_array()
		legacy_datastore_props rt.PhpVal = rt.new_array()
		items rt.PhpVal = rt.new_array()
		items_to_delete rt.PhpVal = rt.new_array()
		cache_group rt.PhpVal = rt.new_string('orders')
		data_store_name rt.PhpVal = rt.new_string('order')
		object_type rt.PhpVal = rt.new_string('order')
		item_types_to_group rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Abstract_Order) construct(order i64)  {
	mut order_mutated := order
	if rt.is_true(rt.new_bool(this.has_cogs() && rt.is_true(this.cogs_is_enabled()))) {
		this.data.array_set('cogs_total_value', 0)
	}
	this.Class_WC_Abstract_Legacy_Order.construct(rt.new_int(order_mutated))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.new_int(order_mutated).dup().is_long() || rt.new_int(order_mutated).dup().is_double())) && order_mutated > 0)) {
		this.set_id(rt.new_int(order_mutated))
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(order_mutated), 'self'))) {
		this.set_id(rt.call_method(rt.new_int(order_mutated), 'get_id', []rt.PhpVal{}))
	} else if !(!rt.is_true(rt.get_property(rt.new_int(order_mutated), 'ID'))) {
		this.set_id(rt.get_property(rt.new_int(order_mutated), 'ID'))
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	this.dispatch_set_prop('data_store', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(this.data_store_name))
	if rt.is_true(rt.greater(this.get_id(), rt.new_int(0))) {
		rt.call_method(rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store'), 'read', [rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
	}
}

fn (mut this Class_WC_Abstract_Order) magic_clone()  {
}

fn (mut this Class_WC_Abstract_Order) get_type() string {
	return 'shop_order'
}

fn (mut this Class_WC_Abstract_Order) get_data() rt.PhpVal {
	return rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'id', val: this.get_id() }]), this.data, rt.create_array([rt.ArrayItem{ key: 'meta_data', val: this.get_meta_data() }, rt.ArrayItem{ key: 'line_items', val: this.get_items('line_item') }, rt.ArrayItem{ key: 'tax_lines', val: this.get_items('tax') }, rt.ArrayItem{ key: 'shipping_lines', val: this.get_items('shipping') }, rt.ArrayItem{ key: 'fee_lines', val: this.get_items('fee') }, rt.ArrayItem{ key: 'coupon_lines', val: this.get_items('coupon') }])])
}

fn (mut this Class_WC_Abstract_Order) save() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store'))))) {
		return this.get_id()
	}
	rt.call_function('do_action', ['woocommerce_before_' + (this.object_type).str() + '_object_save', rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(this.get_id()) {
		rt.call_method(rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store'), 'update', [rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	} else {
		rt.call_method(rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store'), 'create', [rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.save_items()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('do_action', ['woocommerce_after_' + (this.object_type).str() + '_object_save', rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		mut var_message_id := if rt.is_true(this.get_id()) { this.get_id() } else { rt.call_function('__', [rt.new_string('(no ID)'), rt.new_string('woocommerce')]) }
		this.handle_exception(var_e.dup(), (rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Error saving order ID %1$s.'), rt.new_string('woocommerce')]), var_message_id.dup()])])).str())
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return this.get_id()
}

fn (mut this Class_WC_Abstract_Order) handle_exception(var_e rt.PhpVal, message string)  {
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string(message), rt.create_array([rt.ArrayItem{ key: 'order', val: rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this) }, rt.ArrayItem{ key: 'error', val: var_e }])])
}

fn (mut this Class_WC_Abstract_Order) save_items()  {
	mut var_items_changed := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := this.items_to_delete.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			rt.call_method(var_item, 'delete', []rt.PhpVal{})
			var_items_changed = rt.new_bool(rt.new_bool(true))
		}
	}
	this.items_to_delete = rt.new_array()
	{
		mut iter_1 := this.items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_items := item_1.val
			mut var_item_group := item_1.key
			if rt.is_true(rt.new_bool(var_items.dup().is_array())) {
				var_items = rt.call_function('array_filter', [var_items.dup()])
				{
					mut iter_2 := var_items.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_item := item_2.val
						mut var_item_key := item_2.key
						rt.call_method(var_item, 'set_order_id', [this.get_id()])
						mut var_item_id := rt.call_method(var_item, 'save', []rt.PhpVal{})
						if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
							this.items.array_get_mut(var_item_group).array_set(var_item_id, var_item.dup())
							this.items.array_get(var_item_group).array_unset(var_item_key)
							var_items_changed = rt.new_bool(rt.new_bool(true))
						}
					}
				}
			}
		}
	}
	if rt.is_true(var_items_changed) {
		rt.call_function('wp_cache_delete', ['order-needs-processing-' + (this.get_id()).str(), rt.new_string('orders')])
		if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.orders_cache_usage_is_enabled() }()) {
			rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Caches_OrderCache.class()]), 'remove', [this.get_id()])
		}
	}
}

fn (mut this Class_WC_Abstract_Order) get_parent_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('parent_id'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_currency(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('currency'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_version(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('version'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_prices_include_tax(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('prices_include_tax'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_date_created(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_created'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_date_modified(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_modified'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_date_paid(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_paid'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_date_completed(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_completed'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_status(context string) rt.PhpVal {
	mut var_status := this.get_prop(rt.new_string('status'), rt.new_string(context))
	if rt.is_true(rt.new_bool(!rt.is_true(var_status) && rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))))) {
		var_status = rt.call_function('apply_filters', [rt.new_string('woocommerce_default_order_status'), Class_Automattic_WooCommerce_Enums_OrderStatus.pending()])
	}
	return var_status.dup()
}

fn (mut this Class_WC_Abstract_Order) get_discount_total(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('discount_total'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_discount_tax(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('discount_tax'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_shipping_total(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('shipping_total'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_shipping_tax(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('shipping_tax'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_cart_tax(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('cart_tax'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_total(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('total'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_total_tax(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('total_tax'), rt.new_string(context))
}

fn (mut this Class_WC_Abstract_Order) get_total_discount(ex_tax bool) rt.PhpVal {
	if var_ex_tax {
		mut var_total_discount := // unsupported expression: Expr_Cast_Double
	} else {
		var_total_discount = rt.add(// unsupported expression: Expr_Cast_Double, // unsupported expression: Expr_Cast_Double)
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_get_total_discount'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.round(arg_0, arg_1) }(var_total_discount.dup(), rt.get_constant('WC_ROUNDING_PRECISION')), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
}

fn (mut this Class_WC_Abstract_Order) get_subtotal() rt.PhpVal {
	mut var_subtotal := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.round(arg_0, arg_1) }(this.get_cart_subtotal_for_order(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_get_subtotal'), // unsupported expression: Expr_Cast_Double, rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
}

fn (mut this Class_WC_Abstract_Order) get_tax_totals() rt.PhpVal {
	mut var_tax_totals := rt.new_array()
	{
		mut iter_1 := this.get_items('tax').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax := item_1.val
			mut var_key := item_1.key
			mut var_code := rt.call_method(var_tax, 'get_rate_code', []rt.PhpVal{})
			if !(var_tax_totals.array_isset(var_code)) {
				var_tax_totals.array_set(var_code, create_stdclass())
				rt.set_property(var_tax_totals.array_get(var_code), 'amount', rt.new_int(0))
			}
			rt.set_property(var_tax_totals.array_get(var_code), 'id', var_key.dup())
			rt.set_property(var_tax_totals.array_get(var_code), 'rate_id', rt.call_method(var_tax, 'get_rate_id', []rt.PhpVal{}))
			rt.set_property(var_tax_totals.array_get(var_code), 'is_compound', rt.call_method(var_tax, 'is_compound', []rt.PhpVal{}))
			rt.set_property(var_tax_totals.array_get(var_code), 'label', rt.call_method(var_tax, 'get_label', []rt.PhpVal{}))
			// unsupported expression: Expr_AssignOp_Plus
			rt.set_property(var_tax_totals.array_get(var_code), 'formatted_amount', rt.call_function('wc_price', [rt.get_property(var_tax_totals.array_get(var_code), 'amount'), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency('') }])]))
		}
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_order_hide_zero_taxes'), rt.new_bool(true)])) {
		mut var_amounts := rt.call_function('array_filter', [rt.call_function('wp_list_pluck', [var_tax_totals.dup(), rt.new_string('amount')])])
		var_tax_totals = rt.call_function('array_intersect_key', [var_tax_totals.dup(), var_amounts.dup()])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_get_tax_totals'), var_tax_totals.dup(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
}

fn (mut this Class_WC_Abstract_Order) get_valid_statuses() rt.PhpVal {
	return rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{}))
}

fn (mut this Class_WC_Abstract_Order) get_user_id(context string) i64 {
	return 0
}

fn (mut this Class_WC_Abstract_Order) get_user() bool {
	return false
}

fn (mut this Class_WC_Abstract_Order) get_recorded_coupon_usage_counts(context string) rt.PhpVal {
	return rt.call_function('wc_string_to_bool', [this.get_prop(rt.new_string('recorded_coupon_usage_counts'), rt.new_string(context))])
}

fn (mut this Class_WC_Abstract_Order) get_base_data() rt.PhpVal {
	return rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'id', val: this.get_id() }]), this.data])
}

fn (mut this Class_WC_Abstract_Order) get_payment_card_info() rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo{}; return temp.get_card_info(arg_0) }(rt.new_object('WC_Abstract_Order', []string{}, this))
}

fn (mut this Class_WC_Abstract_Order) set_parent_id(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(rt.is_true(var_value_mutated) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_value_mutated, this.get_id())) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_get_order', [var_value_mutated.dup()]))))))))) {
		this.error(rt.new_string('order_invalid_parent_id'), rt.call_function('__', [rt.new_string('Invalid parent ID'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('parent_id'), rt.call_function('absint', [var_value_mutated.dup()]))
}

fn (mut this Class_WC_Abstract_Order) set_status(var_new_status rt.PhpVal) rt.PhpVal {
	mut var_new_status_mutated := var_new_status
	mut var_old_status := this.get_status('')
	var_new_status_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.remove_status_prefix(arg_0) }()
	mut var_status_exceptions := 
	if rt.is_true() {
	}
	
}

fn (mut this Class_WC_Abstract_Order) set_version(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Abstract_Order) set_currency(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Abstract_Order) set_prices_include_tax(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Abstract_Order) set_date_created(var_date rt.PhpVal)  {
}

fn (mut this Class_WC_Abstract_Order) set_date_modified(var_date rt.PhpVal)  {
}

fn (mut this Class_WC_Abstract_Order) set_discount_total(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Abstract_Order) set_discount_tax(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Abstract_Order) set_shipping_total(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Abstract_Order) set_shipping_tax(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Abstract_Order) set_cart_tax(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Abstract_Order) set_total_tax(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Abstract_Order) set_total(var_value rt.PhpVal, deprecated string) rt.PhpVal {
	mut var_value_mutated := var_value
	return rt.new_null()
}

fn (mut this Class_WC_Abstract_Order) set_recorded_coupon_usage_counts(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Abstract_Order) remove_order_items(var_type rt.PhpVal)  {
	mut var_type_mutated := var_type
}

fn (mut this Class_WC_Abstract_Order) type_to_group(var_type rt.PhpVal) rt.PhpVal {
	mut var_type_mutated := var_type
}

fn (mut this Class_WC_Abstract_Order) get_items(types string) rt.PhpVal {
	mut var_item := rt.new_null()
	mut types_mutated := types
}

fn (mut this Class_WC_Abstract_Order) get_values_for_total(var_field rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) get_coupons() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) get_fees() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) get_taxes() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) get_shipping_methods() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) get_shipping_method() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) get_coupon_codes() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) get_item_count(item_type string) rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) get_item(var_item_id rt.PhpVal, load_from_db bool) bool {
	mut var_item_id_mutated := var_item_id
}

fn (mut this Class_WC_Abstract_Order) get_items_key(var_item rt.PhpVal) string {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_Abstract_Order) remove_item(var_item_id rt.PhpVal) bool {
	mut var_item_id_mutated := var_item_id
	return false
}

fn (mut this Class_WC_Abstract_Order) add_item(var_item rt.PhpVal) bool {
	mut var_item_mutated := var_item
	return false
}

fn (mut this Class_WC_Abstract_Order) hold_applied_coupons(var_billing_email rt.PhpVal)  {
}

fn (mut this Class_WC_Abstract_Order) hold_coupon(var_coupon rt.PhpVal) rt.PhpVal {
	mut var_coupon_mutated := var_coupon
}

fn (mut this Class_WC_Abstract_Order) hold_coupon_for_users(var_coupon rt.PhpVal, var_user_ids_and_emails rt.PhpVal, var_user_alias rt.PhpVal) rt.PhpVal {
	mut var_coupon_mutated := var_coupon
	mut var_user_ids_and_emails_mutated := var_user_ids_and_emails
	mut var_user_alias_mutated := var_user_alias
}

fn (mut this Class_WC_Abstract_Order) get_billing_and_current_user_ids_and_aliases(var_billing_email rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) apply_coupon(var_raw_coupon rt.PhpVal) bool {
}

fn (mut this Class_WC_Abstract_Order) remove_coupon(var_code rt.PhpVal) bool {
	mut var_code_mutated := var_code
}

fn (mut this Class_WC_Abstract_Order) recalculate_coupons()  {
}

fn (mut this Class_WC_Abstract_Order) get_temporary_coupon(mut var_coupon_item Class_WC_Order_Item_Coupon) rt.PhpVal {
	mut var_coupon_item_mutated := var_coupon_item
}

fn (mut this Class_WC_Abstract_Order) set_item_discount_amounts(var_discounts rt.PhpVal)  {
	mut var_discounts_mutated := var_discounts
}

fn (mut this Class_WC_Abstract_Order) set_coupon_discount_amounts(var_discounts rt.PhpVal)  {
	mut var_discounts_mutated := var_discounts
}

fn (mut this Class_WC_Abstract_Order) add_product(var_product rt.PhpVal, qty i64, var_args rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Abstract_Order) add_payment_token(var_token rt.PhpVal) bool {
}

fn (mut this Class_WC_Abstract_Order) get_payment_tokens() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) calculate_shipping() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) get_items_tax_classes() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) get_tax_location(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Abstract_Order) get_taxable_location(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Abstract_Order) get_tax_rates(var_tax_class rt.PhpVal, var_location_args rt.PhpVal, var_customer rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) calculate_taxes(var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Abstract_Order) get_total_fees() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) update_taxes()  {
}

fn (mut this Class_WC_Abstract_Order) get_cart_subtotal_for_order() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) get_cart_total_for_order() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) calculate_totals(and_taxes bool) rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) get_item_subtotal(var_item rt.PhpVal, inc_tax bool, round bool) rt.PhpVal {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_Abstract_Order) get_line_subtotal(var_item rt.PhpVal, inc_tax bool, round bool) rt.PhpVal {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_Abstract_Order) get_item_total(var_item rt.PhpVal, inc_tax bool, round bool) rt.PhpVal {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_Abstract_Order) get_line_total(var_item rt.PhpVal, inc_tax bool, round bool) rt.PhpVal {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_Abstract_Order) get_item_tax(var_item rt.PhpVal, round bool) rt.PhpVal {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_Abstract_Order) get_line_tax(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
}

fn (mut this Class_WC_Abstract_Order) get_formatted_line_subtotal(var_item rt.PhpVal, tax_display string) rt.PhpVal {
	mut var_item_mutated := var_item
	mut tax_display_mutated := tax_display
}

fn (mut this Class_WC_Abstract_Order) get_formatted_order_total() rt.PhpVal {
}

fn (mut this Class_WC_Abstract_Order) get_subtotal_to_display(compound bool, tax_display string) string {
	mut tax_display_mutated := tax_display
}

fn (mut this Class_WC_Abstract_Order) get_shipping_to_display(tax_display string) rt.PhpVal {
	mut tax_display_mutated := tax_display
}

fn (mut this Class_WC_Abstract_Order) get_discount_to_display(tax_display string) rt.PhpVal {
	mut tax_display_mutated := tax_display
}

fn (mut this Class_WC_Abstract_Order) add_order_item_totals_subtotal_row(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal)  {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
}

fn (mut this Class_WC_Abstract_Order) add_order_item_totals_discount_row(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal)  {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
}

fn (mut this Class_WC_Abstract_Order) add_order_item_totals_shipping_row(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal)  {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
}

fn (mut this Class_WC_Abstract_Order) add_order_item_totals_fee_rows(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal)  {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
}

fn (mut this Class_WC_Abstract_Order) add_order_item_totals_tax_rows(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal)  {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
}

fn (mut this Class_WC_Abstract_Order) add_order_item_totals_total_row(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal)  {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
}

fn (mut this Class_WC_Abstract_Order) get_order_item_totals(tax_display string) rt.PhpVal {
	mut tax_display_mutated := tax_display
}

fn (mut this Class_WC_Abstract_Order) has_status(var_status rt.PhpVal) rt.PhpVal {
	mut var_status_mutated := var_status
}

fn (mut this Class_WC_Abstract_Order) has_shipping_method(var_method_id rt.PhpVal) bool {
}

fn (mut this Class_WC_Abstract_Order) needs_shipping() bool {
}

fn (mut this Class_WC_Abstract_Order) has_free_item() bool {
}

fn (mut this Class_WC_Abstract_Order) get_title() string {
	return ''
}

fn (mut this Class_WC_Abstract_Order) has_cogs() bool {
}

fn (mut this Class_WC_Abstract_Order) calculate_cogs_total_value() f64 {
}

fn (mut this Class_WC_Abstract_Order) calculate_cogs_total_value_core() f64 {
}

fn (mut this Class_WC_Abstract_Order) get_cogs_total_value() f64 {
}

fn (mut this Class_WC_Abstract_Order) set_cogs_total_value(value f64)  {
	mut value_mutated := value
}

fn (mut this Class_WC_Abstract_Order) get_cogs_total_value_html(mut var_wc_price_arg Class_?array) string {
}

struct Class_WC_Abstract_Legacy_Order {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo {
	rt.PhpObjectBase
}

fn create_wc_abstract_order(order i64) &Class_WC_Abstract_Order {
	mut obj := &Class_WC_Abstract_Order{
		PhpObjectBase: rt.PhpObjectBase{}
		data: rt.new_array()
		legacy_datastore_props: rt.new_array()
		items: rt.new_array()
		items_to_delete: rt.new_array()
		cache_group: rt.new_string('orders')
		data_store_name: rt.new_string('order')
		object_type: rt.new_string('order')
		item_types_to_group: rt.new_array()
	}
	obj.construct(order)
	return obj
}

fn create_wc_abstract_legacy_order() &Class_WC_Abstract_Legacy_Order {
	mut obj := &Class_WC_Abstract_Legacy_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil() &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_orders_paymentinfo() &Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Abstract_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'get_type' {
			return rt.new_string(this.get_type())
		}
		'get_data' {
			return this.get_data()
		}
		'save' {
			return this.save()
		}
		'handle_exception' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.handle_exception(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'save_items' {
			this.save_items()
			return rt.new_null()
		}
		'get_parent_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_parent_id(dispatch_arg_0)
		}
		'get_currency' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_currency(dispatch_arg_0)
		}
		'get_version' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_version(dispatch_arg_0)
		}
		'get_prices_include_tax' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_prices_include_tax(dispatch_arg_0)
		}
		'get_date_created' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_created(dispatch_arg_0)
		}
		'get_date_modified' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_modified(dispatch_arg_0)
		}
		'get_date_paid' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_paid(dispatch_arg_0)
		}
		'get_date_completed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_completed(dispatch_arg_0)
		}
		'get_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_status(dispatch_arg_0)
		}
		'get_discount_total' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_discount_total(dispatch_arg_0)
		}
		'get_discount_tax' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_discount_tax(dispatch_arg_0)
		}
		'get_shipping_total' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_total(dispatch_arg_0)
		}
		'get_shipping_tax' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_tax(dispatch_arg_0)
		}
		'get_cart_tax' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_cart_tax(dispatch_arg_0)
		}
		'get_total' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_total(dispatch_arg_0)
		}
		'get_total_tax' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_total_tax(dispatch_arg_0)
		}
		'get_total_discount' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_total_discount(dispatch_arg_0)
		}
		'get_subtotal' {
			return this.get_subtotal()
		}
		'get_tax_totals' {
			return this.get_tax_totals()
		}
		'get_valid_statuses' {
			return this.get_valid_statuses()
		}
		'get_user_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_int(this.get_user_id(dispatch_arg_0))
		}
		'get_user' {
			return rt.new_bool(this.get_user())
		}
		'get_recorded_coupon_usage_counts' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_recorded_coupon_usage_counts(dispatch_arg_0)
		}
		'get_base_data' {
			return this.get_base_data()
		}
		'get_payment_card_info' {
			return this.get_payment_card_info()
		}
		'set_parent_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_parent_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_status(dispatch_arg_0)
		}
		'set_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_version(dispatch_arg_0)
			return rt.new_null()
		}
		'set_currency' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_currency(dispatch_arg_0)
			return rt.new_null()
		}
		'set_prices_include_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_prices_include_tax(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_created' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_created(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_modified' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_modified(dispatch_arg_0)
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
		'set_cart_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_cart_tax(dispatch_arg_0)
			return rt.new_null()
		}
		'set_total_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_total_tax(dispatch_arg_0)
			return rt.new_null()
		}
		'set_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.set_total(dispatch_arg_0, dispatch_arg_1)
		}
		'set_recorded_coupon_usage_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_recorded_coupon_usage_counts(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_order_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_order_items(dispatch_arg_0)
			return rt.new_null()
		}
		'type_to_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.type_to_group(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_items(dispatch_arg_0)
		}
		'get_values_for_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_values_for_total(dispatch_arg_0)
		}
		'get_coupons' {
			return this.get_coupons()
		}
		'get_fees' {
			return this.get_fees()
		}
		'get_taxes' {
			return this.get_taxes()
		}
		'get_shipping_methods' {
			return this.get_shipping_methods()
		}
		'get_shipping_method' {
			return this.get_shipping_method()
		}
		'get_coupon_codes' {
			return this.get_coupon_codes()
		}
		'get_item_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_item_count(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.get_item(dispatch_arg_0, dispatch_arg_1))
		}
		'get_items_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_items_key(dispatch_arg_0))
		}
		'remove_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.remove_item(dispatch_arg_0))
		}
		'add_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.add_item(dispatch_arg_0))
		}
		'hold_applied_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.hold_applied_coupons(dispatch_arg_0)
			return rt.new_null()
		}
		'hold_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.hold_coupon(dispatch_arg_0)
		}
		'hold_coupon_for_users' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.hold_coupon_for_users(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_billing_and_current_user_ids_and_aliases' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_billing_and_current_user_ids_and_aliases(dispatch_arg_0)
		}
		'apply_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.apply_coupon(dispatch_arg_0))
		}
		'remove_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.remove_coupon(dispatch_arg_0))
		}
		'recalculate_coupons' {
			this.recalculate_coupons()
			return rt.new_null()
		}
		'get_temporary_coupon' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order_Item_Coupon](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_temporary_coupon(mut dispatch_arg_0)
		}
		'set_item_discount_amounts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_item_discount_amounts(dispatch_arg_0)
			return rt.new_null()
		}
		'set_coupon_discount_amounts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_coupon_discount_amounts(dispatch_arg_0)
			return rt.new_null()
		}
		'add_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.add_product(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'add_payment_token' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.add_payment_token(dispatch_arg_0))
		}
		'get_payment_tokens' {
			return this.get_payment_tokens()
		}
		'calculate_shipping' {
			return this.calculate_shipping()
		}
		'get_items_tax_classes' {
			return this.get_items_tax_classes()
		}
		'get_tax_location' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_tax_location(dispatch_arg_0)
		}
		'get_taxable_location' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_taxable_location(dispatch_arg_0)
		}
		'get_tax_rates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_tax_rates(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'calculate_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.calculate_taxes(dispatch_arg_0)
			return rt.new_null()
		}
		'get_total_fees' {
			return this.get_total_fees()
		}
		'update_taxes' {
			this.update_taxes()
			return rt.new_null()
		}
		'get_cart_subtotal_for_order' {
			return this.get_cart_subtotal_for_order()
		}
		'get_cart_total_for_order' {
			return this.get_cart_total_for_order()
		}
		'calculate_totals' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.calculate_totals(dispatch_arg_0)
		}
		'get_item_subtotal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_item_subtotal(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_line_subtotal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_line_subtotal(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_item_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_item_total(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_line_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_line_total(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_item_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_item_tax(dispatch_arg_0, dispatch_arg_1)
		}
		'get_line_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_line_tax(dispatch_arg_0)
		}
		'get_formatted_line_subtotal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_formatted_line_subtotal(dispatch_arg_0, dispatch_arg_1)
		}
		'get_formatted_order_total' {
			return this.get_formatted_order_total()
		}
		'get_subtotal_to_display' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_subtotal_to_display(dispatch_arg_0, dispatch_arg_1))
		}
		'get_shipping_to_display' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_shipping_to_display(dispatch_arg_0)
		}
		'get_discount_to_display' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_discount_to_display(dispatch_arg_0)
		}
		'add_order_item_totals_subtotal_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_order_item_totals_subtotal_row(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_order_item_totals_discount_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_order_item_totals_discount_row(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_order_item_totals_shipping_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_order_item_totals_shipping_row(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_order_item_totals_fee_rows' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_order_item_totals_fee_rows(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_order_item_totals_tax_rows' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_order_item_totals_tax_rows(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_order_item_totals_total_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_order_item_totals_total_row(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_order_item_totals' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_order_item_totals(dispatch_arg_0)
		}
		'has_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.has_status(dispatch_arg_0)
		}
		'has_shipping_method' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_shipping_method(dispatch_arg_0))
		}
		'needs_shipping' {
			return rt.new_bool(this.needs_shipping())
		}
		'has_free_item' {
			return rt.new_bool(this.has_free_item())
		}
		'get_title' {
			return rt.new_string(this.get_title())
		}
		'has_cogs' {
			return rt.new_bool(this.has_cogs())
		}
		'calculate_cogs_total_value' {
			return rt.new_float(this.calculate_cogs_total_value())
		}
		'calculate_cogs_total_value_core' {
			return rt.new_float(this.calculate_cogs_total_value_core())
		}
		'get_cogs_total_value' {
			return rt.new_float(this.get_cogs_total_value())
		}
		'set_cogs_total_value' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_f64()
			this.set_cogs_total_value(dispatch_arg_0)
			return rt.new_null()
		}
		'get_cogs_total_value_html' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_cogs_total_value_html(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WC_Abstract_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'legacy_datastore_props' { return this.legacy_datastore_props }
		'items' { return this.items }
		'items_to_delete' { return this.items_to_delete }
		'cache_group' { return this.cache_group }
		'data_store_name' { return this.data_store_name }
		'object_type' { return this.object_type }
		'item_types_to_group' { return this.item_types_to_group }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Abstract_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' { this.data = val; return true }
		'legacy_datastore_props' { this.legacy_datastore_props = val; return true }
		'items' { this.items = val; return true }
		'items_to_delete' { this.items_to_delete = val; return true }
		'cache_group' { this.cache_group = val; return true }
		'data_store_name' { this.data_store_name = val; return true }
		'object_type' { this.object_type = val; return true }
		'item_types_to_group' { this.item_types_to_group = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Abstract_Legacy_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Abstract_Legacy_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Abstract_Legacy_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_abstracts_abstract_wc_order_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/legacy/abstract-wc-legacy-order.php', '4')
}
