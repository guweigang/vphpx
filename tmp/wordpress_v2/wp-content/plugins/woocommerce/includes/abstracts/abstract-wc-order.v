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

fn (mut this Class_WC_Abstract_Order) construct(order i64) {
	mut order_mutated := order
	if this.has_cogs() && rt.is_true(this.cogs_is_enabled()) {
		this.data.array_set('cogs_total_value', 0)
	}
	this.Class_WC_Abstract_Legacy_Order.construct(rt.new_int(order_mutated))
	if rt.new_int(order_mutated).clone().is_long() || rt.new_int(order_mutated).clone().is_double() && order_mutated > 0 {
		this.set_id(rt.new_int(order_mutated))
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(order_mutated), 'self'))) {
		this.set_id(rt.call_method(rt.new_int(order_mutated), 'get_id', []rt.PhpVal{}))
	} else if !(!rt.is_true(rt.get_property(rt.new_int(order_mutated), 'ID'))) {
		this.set_id(rt.get_property(rt.new_int(order_mutated), 'ID'))
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(this.data_store_name)
	this.dispatch_set_prop('data_store', iife_result_0)
	if rt.is_true(rt.greater(this.get_id(), rt.new_int(0))) {
		rt.call_method(rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store'), 'read', [rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
	}
}

fn (mut this Class_WC_Abstract_Order) magic_clone() {
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
	rt.call_function('do_action', [rt.new_string('woocommerce_before_' + (this.object_type).str() + '_object_save'), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store')])
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
	rt.call_function('do_action', [rt.new_string('woocommerce_after_' + (this.object_type).str() + '_object_save'), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		mut var_message_id := if rt.is_true(this.get_id()) { this.get_id() } else { rt.call_function('__', [rt.new_string('(no ID)'), rt.new_string('woocommerce')]) }
		this.handle_exception(var_e.clone(), (rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Error saving order ID %1$s.'), rt.new_string('woocommerce')]), var_message_id.clone()])])).str())
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return this.get_id()
}

fn (mut this Class_WC_Abstract_Order) handle_exception(var_e rt.PhpVal, message string) {
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.new_string(message), rt.create_array([rt.ArrayItem{ key: 'order', val: rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this) }, rt.ArrayItem{ key: 'error', val: var_e }])])
}

fn (mut this Class_WC_Abstract_Order) save_items() {
	mut var_items_changed := rt.new_bool(false)
	mut iter_1 := this.items_to_delete.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		rt.call_method(var_item, 'delete', []rt.PhpVal{})
	var_items_changed = rt.new_bool(true)
	}
	this.items_to_delete = rt.new_array()
	mut iter_2 := this.items.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_items := item_2.val
		mut var_item_group := item_2.key
		if rt.is_true(rt.new_bool(var_items.clone().is_array())) {
			var_items = rt.call_function('array_filter', [var_items.clone()])
			mut iter_3 := var_items.iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_item := item_3.val
				mut var_item_key := item_3.key
				rt.call_method(var_item, 'set_order_id', [this.get_id()])
				mut var_item_id := rt.call_method(var_item, 'save', []rt.PhpVal{})
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_item_id, var_item_key)))) {
					this.items.array_get_mut(var_item_group).array_set(var_item_id, var_item.clone())
					this.items.array_get(var_item_group).array_unset(var_item_key)
				var_items_changed = rt.new_bool(true)
				}
			}
		}
	}
	if rt.is_true(var_items_changed) {
		rt.call_function('wp_cache_delete', [rt.new_string('order-needs-processing-' + (this.get_id()).str()), rt.new_string('orders')])
		mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
		mut iife_result_1 := iife_temp_1.orders_cache_usage_is_enabled()
		if rt.is_true(iife_result_1) {
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
	if !rt.is_true(var_status) && rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) {
	var_status = rt.call_function('apply_filters', [rt.new_string('woocommerce_default_order_status'), Class_Automattic_WooCommerce_Enums_OrderStatus.pending()])
	}
	return var_status.clone()
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
	mut var_total_discount := rt.new_float((this.get_discount_total('')).to_f64())
	} else {
	var_total_discount = rt.new_float((this.get_discount_total('')).to_f64()) + rt.new_float((this.get_discount_tax('')).to_f64())
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_2 := iife_temp_2.round(var_total_discount.clone(), rt.get_constant('WC_ROUNDING_PRECISION'))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_get_total_discount'), iife_result_2, rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
}

fn (mut this Class_WC_Abstract_Order) get_subtotal() rt.PhpVal {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_3 := iife_temp_3.round(this.get_cart_subtotal_for_order(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
	mut var_subtotal := iife_result_3
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_get_subtotal'), rt.new_float((var_subtotal).to_f64()), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
}

fn (mut this Class_WC_Abstract_Order) get_tax_totals() rt.PhpVal {
	mut var_tax_totals := rt.new_array()
	mut iter_4 := this.get_items('tax').iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_tax := item_4.val
		mut var_key := item_4.key
		mut var_code := rt.call_method(var_tax, 'get_rate_code', []rt.PhpVal{})
		if !(var_tax_totals.array_isset(var_code)) {
			var_tax_totals.array_set(var_code, create_stdclass())
			rt.set_property(var_tax_totals.array_get(var_code), 'amount', rt.new_int(0))
		}
		rt.set_property(var_tax_totals.array_get(var_code), 'id', var_key.clone())
		rt.set_property(var_tax_totals.array_get(var_code), 'rate_id', rt.call_method(var_tax, 'get_rate_id', []rt.PhpVal{}))
		rt.set_property(var_tax_totals.array_get(var_code), 'is_compound', rt.call_method(var_tax, 'is_compound', []rt.PhpVal{}))
		rt.set_property(var_tax_totals.array_get(var_code), 'label', rt.call_method(var_tax, 'get_label', []rt.PhpVal{}))
		rt.get_property(var_tax_totals.array_get(var_code), 'amount') = rt.add(rt.get_property(var_tax_totals.array_get(var_code), 'amount'), rt.new_float((rt.call_method(var_tax, 'get_tax_total', []rt.PhpVal{})).to_f64()) + rt.new_float((rt.call_method(var_tax, 'get_shipping_tax_total', []rt.PhpVal{})).to_f64()))
		rt.set_property(var_tax_totals.array_get(var_code), 'formatted_amount', rt.call_function('wc_price', [rt.get_property(var_tax_totals.array_get(var_code), 'amount'), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency('') }])]))
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_order_hide_zero_taxes'), rt.new_bool(true)])) {
	mut var_amounts := rt.call_function('array_filter', [rt.call_function('wp_list_pluck', [var_tax_totals.clone(), rt.new_string('amount')])])
	var_tax_totals = rt.call_function('array_intersect_key', [var_tax_totals.clone(), var_amounts.clone()])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_get_tax_totals'), var_tax_totals.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
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
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo{}
	mut iife_result_4 := iife_temp_4.get_card_info(rt.new_object('WC_Abstract_Order', []string{}, this))
	return iife_result_4
}

fn (mut this Class_WC_Abstract_Order) set_parent_id(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	if rt.is_true(var_value_mutated) && rt.is_true(rt.identical(var_value_mutated, this.get_id())) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_get_order', [var_value_mutated.clone()]))))) {
		this.error(rt.new_string('order_invalid_parent_id'), rt.call_function('__', [rt.new_string('Invalid parent ID'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('parent_id'), rt.call_function('absint', [var_value_mutated.clone()]))
}

fn (mut this Class_WC_Abstract_Order) set_status(var_new_status rt.PhpVal) rt.PhpVal {
	mut var_new_status_mutated := var_new_status
	mut var_old_status := this.get_status('')
	mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_5 := iife_temp_5.remove_status_prefix(rt.new_string((var_new_status_mutated).str()))
	var_new_status_mutated = iife_result_5
	mut var_status_exceptions := [Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft(), Class_Automattic_WooCommerce_Enums_OrderStatus.trash()]
	if rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'object_read'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('wc-' + (var_new_status_mutated).str()), this.get_valid_statuses(), rt.new_bool(true)]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_new_status_mutated.clone(), rt.create_array_from_list(var_status_exceptions), rt.new_bool(true)]))))) {
		var_new_status_mutated = Class_Automattic_WooCommerce_Enums_OrderStatus.pending()
		}
		if rt.is_true(var_old_status) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft(), var_old_status)) || (rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('wc-' + (var_old_status).str()), this.get_valid_statuses(), rt.new_bool(true)]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_old_status.clone(), rt.create_array_from_list(var_status_exceptions), rt.new_bool(true)])))))) {
		var_old_status = Class_Automattic_WooCommerce_Enums_OrderStatus.pending()
		}
	}
	this.set_prop(rt.new_string('status'), var_new_status_mutated.clone())
	return rt.create_array([rt.ArrayItem{ key: 'from', val: var_old_status }, rt.ArrayItem{ key: 'to', val: var_new_status_mutated }])
}

fn (mut this Class_WC_Abstract_Order) set_version(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('version'), var_value_mutated.clone())
}

fn (mut this Class_WC_Abstract_Order) set_currency(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	if rt.is_true(var_value_mutated) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value_mutated.clone(), rt.func_array_keys(rt.call_function('get_woocommerce_currencies', []rt.PhpVal{})), rt.new_bool(true)]))))) {
		this.error(rt.new_string('order_invalid_currency'), rt.call_function('__', [rt.new_string('Invalid currency code'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('currency'), if rt.is_true(var_value_mutated) { var_value_mutated } else { rt.call_function('get_woocommerce_currency', []rt.PhpVal{}) })
}

fn (mut this Class_WC_Abstract_Order) set_prices_include_tax(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('prices_include_tax'), rt.new_bool((var_value_mutated).to_bool()))
}

fn (mut this Class_WC_Abstract_Order) set_date_created(var_date rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_created'), var_date.clone())
}

fn (mut this Class_WC_Abstract_Order) set_date_modified(var_date rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_modified'), var_date.clone())
}

fn (mut this Class_WC_Abstract_Order) set_discount_total(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('discount_total'), rt.call_function('wc_format_decimal', [var_value_mutated.clone(), rt.new_bool(false), rt.new_bool(true)]))
}

fn (mut this Class_WC_Abstract_Order) set_discount_tax(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('discount_tax'), rt.call_function('wc_format_decimal', [var_value_mutated.clone(), rt.new_bool(false), rt.new_bool(true)]))
}

fn (mut this Class_WC_Abstract_Order) set_shipping_total(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('shipping_total'), rt.call_function('wc_format_decimal', [var_value_mutated.clone(), rt.new_bool(false), rt.new_bool(true)]))
}

fn (mut this Class_WC_Abstract_Order) set_shipping_tax(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('shipping_tax'), rt.call_function('wc_format_decimal', [var_value_mutated.clone(), rt.new_bool(false), rt.new_bool(true)]))
	this.set_total_tax(rt.new_float((this.get_cart_tax('')).to_f64()) + rt.new_float((this.get_shipping_tax('')).to_f64()))
}

fn (mut this Class_WC_Abstract_Order) set_cart_tax(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('cart_tax'), rt.call_function('wc_format_decimal', [var_value_mutated.clone(), rt.new_bool(false), rt.new_bool(true)]))
	this.set_total_tax(rt.new_float((this.get_cart_tax('')).to_f64()) + rt.new_float((this.get_shipping_tax('')).to_f64()))
}

fn (mut this Class_WC_Abstract_Order) set_total_tax(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_6 := iife_temp_6.round(var_value_mutated.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
	mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_7 := iife_temp_7.round(var_value_mutated.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
	this.set_prop(rt.new_string('total_tax'), rt.call_function('wc_format_decimal', [iife_result_6]))
}

fn (mut this Class_WC_Abstract_Order) set_total(var_value rt.PhpVal, deprecated string) rt.PhpVal {
	mut var_value_mutated := var_value
	if var_deprecated.len > 0 && var_deprecated != '0' {
		rt.call_function('wc_deprecated_argument', [rt.new_string('total_type'), rt.new_string('3.0'), rt.new_string('Use dedicated total setter methods instead.')])
		return this.legacy_set_total(var_value_mutated.clone(), rt.new_string(deprecated))
	}
	if !(var_value_mutated.clone().is_string()) || 0 == var_value_mutated.clone().to_string().len {
	var_value_mutated = rt.new_float((var_value_mutated).to_f64())
	}
	this.set_prop(rt.new_string('total'), rt.call_function('wc_format_decimal', [var_value_mutated.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]))
	return rt.new_null()
}

fn (mut this Class_WC_Abstract_Order) set_recorded_coupon_usage_counts(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('recorded_coupon_usage_counts'), rt.call_function('wc_string_to_bool', [var_value_mutated.clone()]))
}

fn (mut this Class_WC_Abstract_Order) remove_order_items(var_type rt.PhpVal) {
	mut var_type_mutated := var_type
	rt.call_function('do_action', [rt.new_string('woocommerce_remove_order_items'), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), var_type_mutated.clone()])
	if !(!rt.is_true(var_type_mutated)) {
		rt.call_method(rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store'), 'delete_items', [rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), var_type_mutated.clone()])
		mut var_group := this.type_to_group(var_type_mutated.clone())
		if rt.is_true(var_group) {
			this.items.array_unset(var_group)
		}
	} else {
		rt.call_method(rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store'), 'delete_items', [rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
		this.items = rt.new_array()
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_removed_order_items'), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), var_type_mutated.clone()])
}

fn (mut this Class_WC_Abstract_Order) type_to_group(var_type rt.PhpVal) rt.PhpVal {
	mut var_type_mutated := var_type
	mut var_type_to_group := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_type_to_group'), this.item_types_to_group])
	return if !(var_type_to_group.array_get(var_type_mutated)).is_null() { var_type_to_group.array_get(var_type_mutated) } else { rt.new_string('') }
}

fn (mut this Class_WC_Abstract_Order) get_items(types string) rt.PhpVal {
	mut var_item := rt.new_null()
	mut types_mutated := types
	mut var_items := rt.new_array()
	types_mutated = (rt.call_function('array_filter', [rt.cast_array(rt.new_string(types_mutated))])).str()
	mut iter_5 := rt.new_string(types_mutated).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_type := item_5.val
		mut var_group := this.type_to_group(var_type.clone())
		if rt.is_true(var_group) {
			if !(this.items.array_isset(var_group)) {
				mut var_read_items := rt.call_function('array_filter', [rt.call_method(rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store'), 'read_items', [rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), var_type.clone()])])
				if rt.is_true(rt.identical(rt.new_string('line_item'), var_type)) && !(!rt.is_true(var_read_items)) {
					closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
						mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
						return if rt.is_true(rt.call_method(var_item, 'get_variation_id', []rt.PhpVal{})) { rt.call_method(var_item, 'get_variation_id', []rt.PhpVal{}) } else { rt.call_method(var_item, 'get_product_id', []rt.PhpVal{}) }
						}
					closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
						mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
						return if rt.is_true(rt.call_method(var_item, 'get_variation_id', []rt.PhpVal{})) { rt.call_method(var_item, 'get_variation_id', []rt.PhpVal{}) } else { rt.call_method(var_item, 'get_product_id', []rt.PhpVal{}) }
						}
					mut var_product_ids := rt.call_function('array_map', [rt.new_closure(closure_9_fn), var_read_items.clone()])
					var_product_ids = rt.call_function('array_unique', [rt.call_function('array_filter', [var_product_ids.clone()])])
					rt.call_function('_prime_post_caches', [var_product_ids.clone()])
				}
				this.items.array_set(var_group, var_read_items.clone())
			}
		var_items = rt.add(var_items, this.items.array_get(var_group))
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_get_items'), var_items.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), rt.new_string(types_mutated).clone()])
}

fn (mut this Class_WC_Abstract_Order) get_values_for_total(var_field rt.PhpVal) rt.PhpVal {
	closure_11_fn := fn [var_field] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('wc_add_number_precision', [rt.new_float((var_item.array_get(var_field)).to_f64()), rt.new_bool(false)])
		}
	closure_12_fn := fn [var_field] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('wc_add_number_precision', [rt.new_float((var_item.array_get(var_field)).to_f64()), rt.new_bool(false)])
		}
	mut var_items := rt.call_function('array_map', [rt.new_closure(closure_11_fn), rt.call_function('array_values', [this.get_items('')])])
	return var_items.clone()
}

fn (mut this Class_WC_Abstract_Order) get_coupons() rt.PhpVal {
	return this.get_items('coupon')
}

fn (mut this Class_WC_Abstract_Order) get_fees() rt.PhpVal {
	return this.get_items('fee')
}

fn (mut this Class_WC_Abstract_Order) get_taxes() rt.PhpVal {
	return this.get_items('tax')
}

fn (mut this Class_WC_Abstract_Order) get_shipping_methods() rt.PhpVal {
	return this.get_items('shipping')
}

fn (mut this Class_WC_Abstract_Order) get_shipping_method() rt.PhpVal {
	mut var_names := rt.new_array()
	mut iter_6 := this.get_shipping_methods().iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_shipping_method := item_6.val
		var_names << rt.call_method(var_shipping_method, 'get_name', []rt.PhpVal{})
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_shipping_method'), rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_names)]), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
}

fn (mut this Class_WC_Abstract_Order) get_coupon_codes() rt.PhpVal {
	mut var_coupon_codes := rt.new_array()
	mut var_coupons := this.get_items('coupon')
	if rt.is_true(var_coupons) {
		mut iter_7 := var_coupons.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_coupon := item_7.val
			var_coupon_codes << rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})
		}
	}
	return var_coupon_codes.clone()
}

fn (mut this Class_WC_Abstract_Order) get_item_count(item_type string) rt.PhpVal {
	mut var_items := this.get_items(if item_type == '' { 'line_item' } else { item_type })
	mut var_count := rt.new_int(0)
	mut iter_8 := var_items.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_item := item_8.val
		var_count = rt.add(var_count, rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_item_count'), var_count.clone(), rt.new_string(item_type), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
}

fn (mut this Class_WC_Abstract_Order) get_item(var_item_id rt.PhpVal, load_from_db bool) bool {
	mut var_item_id_mutated := var_item_id
	if var_load_from_db {
		mut iife_temp_12 := Class_WC_Order_Factory{}
		mut iife_result_12 := iife_temp_12.get_order_item(var_item_id_mutated.clone())
		return (iife_result_12).to_bool()
	}
	if rt.is_true(this.items) {
		mut iter_9 := this.items.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_items := item_9.val
			mut var_group := item_9.key
			if var_items.array_isset(var_item_id_mutated) {
				return (var_items.array_get(var_item_id_mutated)).to_bool()
			}
		}
	}
	mut var_type := rt.call_method(rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store'), 'get_order_item_type', [rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), var_item_id_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_type)))) {
		return false
	}
	mut var_items := this.get_items((var_type).str())
	return (if !(!rt.is_true(var_items.array_get(var_item_id_mutated))) { var_items.array_get(var_item_id_mutated) } else { rt.new_bool(false) }).to_bool()
}

fn (mut this Class_WC_Abstract_Order) get_items_key(var_item rt.PhpVal) string {
	mut var_item_mutated := var_item
	if rt.is_true(rt.call_function('is_a', [var_item_mutated.clone(), rt.new_string('WC_Order_Item_Product')])) {
		return 'line_items'
	} else if rt.is_true(rt.call_function('is_a', [var_item_mutated.clone(), rt.new_string('WC_Order_Item_Fee')])) {
		return 'fee_lines'
	} else if rt.is_true(rt.call_function('is_a', [var_item_mutated.clone(), rt.new_string('WC_Order_Item_Shipping')])) {
		return 'shipping_lines'
	} else if rt.is_true(rt.call_function('is_a', [var_item_mutated.clone(), rt.new_string('WC_Order_Item_Tax')])) {
		return 'tax_lines'
	} else if rt.is_true(rt.call_function('is_a', [var_item_mutated.clone(), rt.new_string('WC_Order_Item_Coupon')])) {
		return 'coupon_lines'
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_get_items_key'), rt.new_string(''), var_item_mutated.clone()])).str()
}

fn (mut this Class_WC_Abstract_Order) remove_item(var_item_id rt.PhpVal) bool {
	mut var_item_id_mutated := var_item_id
	mut var_item := rt.new_bool(this.get_item(var_item_id_mutated.clone(), false))
	mut var_items_key := if rt.is_true(var_item) { this.get_items_key(var_item.clone()) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_items_key)))) {
		return false
	}
	this.items_to_delete.array_push(var_item.clone())
	this.items.array_get(var_items_key).array_unset(rt.call_method(var_item, 'get_id', []rt.PhpVal{}))
	return false
}

fn (mut this Class_WC_Abstract_Order) add_item(var_item rt.PhpVal) bool {
	mut var_item_mutated := var_item
	mut var_items_key := rt.new_string(this.get_items_key(var_item_mutated.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_items_key)))) {
		return false
	}
	if !(this.items.array_isset(var_items_key)) {
		this.items.array_set(var_items_key, this.get_items((rt.call_method(var_item_mutated, 'get_type', []rt.PhpVal{})).str()))
	}
	rt.call_method(var_item_mutated, 'set_order_id', [this.get_id()])
	mut var_item_id := rt.call_method(var_item_mutated, 'get_id', []rt.PhpVal{})
	if rt.is_true(var_item_id) {
		this.items.array_get_mut(var_items_key).array_set(var_item_id, var_item_mutated.clone())
	} else {
		this.items.array_get_mut(var_items_key).array_set('new:' + (var_items_key).str() + this.items.array_get(var_items_key).array_count().str(), var_item_mutated.clone())
	}
	return false
}

fn (mut this Class_WC_Abstract_Order) hold_applied_coupons(var_billing_email rt.PhpVal) {
	mut var_held_keys := rt.new_array()
	mut var_held_keys_for_user := rt.new_array()
	mut var_error := rt.new_null()
	mut iter_10 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'get_applied_coupons', []rt.PhpVal{}).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_code := item_10.val
		mut var_coupon := create_wc_coupon(var_code.clone())
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_coupon, 'get_data_store', []rt.PhpVal{}))))) {
			continue
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(rt.less(rt.new_int(0), rt.call_method(var_coupon, 'get_usage_limit', []rt.PhpVal{}))) {
			mut var_held_key := this.hold_coupon(var_coupon.clone())
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			if rt.is_true(var_held_key) {
				var_held_keys.array_set(rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}), var_held_key.clone())
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(rt.less(rt.new_int(0), rt.call_method(var_coupon, 'get_usage_limit_per_user', []rt.PhpVal{}))) {
			if !(!(var_user_ids_and_emails).is_null()) {
				mut var_user_alias := if rt.is_true(rt.call_function('get_current_user_id', []rt.PhpVal{})) { rt.get_property(rt.call_function('wp_get_current_user', []rt.PhpVal{}), 'ID') } else { rt.call_function('sanitize_email', [var_billing_email.clone()]) }
				if rt.has_exception() { unsafe { goto catch_label_2 } }
				mut var_user_ids_and_emails := this.get_billing_and_current_user_ids_and_aliases(var_billing_email.clone())
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			mut var_held_key_for_user := this.hold_coupon_for_users(var_coupon.clone(), var_user_ids_and_emails.clone(), var_user_alias.clone())
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			if rt.is_true(var_held_key_for_user) {
				var_held_keys_for_user.array_set(rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}), var_held_key_for_user.clone())
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto finally_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		var_error = var_e
		unsafe { goto finally_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto finally_label_2 }
	}

finally_label_2:
	if 0 < var_held_keys_for_user.clone().array_count() || 0 < var_held_keys.clone().array_count() {
		rt.call_method(this.get_data_store(), 'set_coupon_held_keys', [rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), var_held_keys.clone(), var_held_keys_for_user.clone()])
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_error, 'Exception'))) {
		rt.throw_exception(var_error)
	}
	if rt.has_exception() { return }

end_label_2:
}

fn (mut this Class_WC_Abstract_Order) hold_coupon(var_coupon rt.PhpVal) rt.PhpVal {
	mut var_coupon_mutated := var_coupon
	mut var_result := rt.call_method(rt.call_method(var_coupon_mutated, 'get_data_store', []rt.PhpVal{}), 'check_and_hold_coupon', [var_coupon_mutated.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An unexpected error happened while applying the Coupon %s.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_coupon_mutated, 'get_code', []rt.PhpVal{})])]))))
	} else if rt.is_true(rt.identical(rt.new_int(0), var_result)) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Coupon %s was used in another transaction during this checkout, and coupon usage limit is reached. Please remove the coupon and try again.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_coupon_mutated, 'get_code', []rt.PhpVal{})])]))))
	}
	return var_result.clone()
}

fn (mut this Class_WC_Abstract_Order) hold_coupon_for_users(var_coupon rt.PhpVal, var_user_ids_and_emails rt.PhpVal, var_user_alias rt.PhpVal) rt.PhpVal {
	mut var_coupon_mutated := var_coupon
	mut var_user_ids_and_emails_mutated := var_user_ids_and_emails
	mut var_user_alias_mutated := var_user_alias
	mut var_result := rt.call_method(rt.call_method(var_coupon_mutated, 'get_data_store', []rt.PhpVal{}), 'check_and_hold_coupon_for_user', [var_coupon_mutated.clone(), var_user_ids_and_emails_mutated.clone(), var_user_alias_mutated.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An unexpected error happened while applying the Coupon %s.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_coupon_mutated, 'get_code', []rt.PhpVal{})])]))))
	} else if rt.is_true(rt.identical(rt.new_int(0), var_result)) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You have used this coupon %s in another transaction during this checkout, and coupon usage limit is reached. Please remove the coupon and try again.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_coupon_mutated, 'get_code', []rt.PhpVal{})])]))))
	}
	return var_result.clone()
}

fn (mut this Class_WC_Abstract_Order) get_billing_and_current_user_ids_and_aliases(var_billing_email rt.PhpVal) rt.PhpVal {
	mut var_emails := rt.create_array([rt.ArrayItem{ key: none, val: var_billing_email }])
	if rt.is_true(rt.call_function('get_current_user_id', []rt.PhpVal{})) {
		var_emails.array_push(rt.get_property(rt.call_function('wp_get_current_user', []rt.PhpVal{}), 'user_email'))
	}
	var_emails = rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('strtolower'), rt.call_function('array_map', [rt.new_string('sanitize_email'), var_emails.clone()])])])
	mut var_user_ids := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Customers_SearchService.class()]), 'find_user_ids_by_billing_email_for_coupons_usage_lookup', [var_emails.clone()])
	return rt.call_function('array_merge', [var_user_ids.clone(), var_emails.clone()])
}

fn (mut this Class_WC_Abstract_Order) apply_coupon(var_raw_coupon rt.PhpVal) bool {
	if rt.is_true(rt.call_function('is_a', [var_raw_coupon.clone(), rt.new_string('WC_Coupon')])) {
	mut var_coupon := var_raw_coupon
	} else if rt.is_true(rt.new_bool(var_raw_coupon.clone().is_string())) {
		mut var_code := rt.call_function('wc_format_coupon_code', [var_raw_coupon.clone()])
		var_coupon = create_wc_coupon(var_code.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_same_coupon', [rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}), var_code.clone()]))))) {
			return (create_wp_error(rt.new_string('invalid_coupon'), rt.call_function('__', [rt.new_string('Invalid coupon code'), rt.new_string('woocommerce')]))).to_bool()
		}
	} else {
		return (create_wp_error(rt.new_string('invalid_coupon'), rt.call_function('__', [rt.new_string('Invalid coupon'), rt.new_string('woocommerce')]))).to_bool()
	}
	mut var_applied_coupons := this.get_items('coupon')
	mut iter_11 := var_applied_coupons.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_applied_coupon := item_11.val
		if rt.is_true(rt.call_function('wc_is_same_coupon', [rt.call_method(var_applied_coupon, 'get_code', []rt.PhpVal{}), rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})])) {
			return (create_wp_error(rt.new_string('invalid_coupon'), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Coupon code "%s" already applied!'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_method(var_coupon, 'get_code', []rt.PhpVal{})])]))).to_bool()
		}
	}
	mut var_discounts := create_wc_discounts(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this))
	mut var_applied := var_discounts.apply_coupon(var_coupon.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_applied.clone()])) {
		return (var_applied).to_bool()
	}
	mut var_data_store := rt.call_method(var_coupon, 'get_data_store', []rt.PhpVal{})
	if rt.is_true(var_data_store) && rt.is_true(rt.identical(rt.new_int(0), this.get_customer_id())) {
		mut var_usage_count := rt.call_method(var_data_store, 'get_usage_by_email', [var_coupon.clone(), this.get_billing_email()])
		if rt.is_true(rt.less(rt.new_int(0), rt.call_method(var_coupon, 'get_usage_limit_per_user', []rt.PhpVal{}))) && rt.is_true(rt.greater_equal(var_usage_count, rt.call_method(var_coupon, 'get_usage_limit_per_user', []rt.PhpVal{}))) {
			return (create_wp_error(rt.new_string('invalid_coupon'), rt.call_method(var_coupon, 'get_coupon_error', [rt.new_int(106)]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_order_applied_coupon'), var_coupon.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
	this.set_coupon_discount_amounts(rt.new_object('WC_Discounts', []string{}, var_discounts))
	this.save()
	this.recalculate_coupons()
	mut var_used_by := rt.new_int(this.get_user_id(''))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_used_by)))) {
	var_used_by = this.get_billing_email()
	}
	mut var_order_data_store := this.get_data_store()
	if rt.is_true(rt.call_method(var_order_data_store, 'get_recorded_coupon_usage_counts', [rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])) {
		rt.call_method(var_coupon, 'increase_usage_count', [var_used_by.clone()])
	}
	rt.call_function('wc_update_coupon_usage_counts', [this.get_id()])
	return true
}

fn (mut this Class_WC_Abstract_Order) remove_coupon(var_code rt.PhpVal) bool {
	mut var_code_mutated := var_code
	mut var_coupons := this.get_items('coupon')
	mut iter_12 := var_coupons.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_coupon := item_12.val
		mut var_item_id := item_12.key
		if rt.is_true(rt.call_function('wc_is_same_coupon', [rt.call_method(var_coupon, 'get_code', []rt.PhpVal{}), var_code_mutated.clone()])) {
			this.remove_item(var_item_id.clone())
			mut var_coupon_object := create_wc_coupon(var_code_mutated.clone())
			rt.call_method(var_coupon_object, 'decrease_usage_count', [rt.new_int(this.get_user_id(''))])
			this.recalculate_coupons()
			return true
		}
	}
	return false
}

fn (mut this Class_WC_Abstract_Order) recalculate_coupons() {
	mut iter_13 := this.get_items('').iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_item := item_13.val
		rt.call_method(var_item, 'set_total', [rt.call_method(var_item, 'get_subtotal', []rt.PhpVal{})])
		rt.call_method(var_item, 'set_total_tax', [rt.call_method(var_item, 'get_subtotal_tax', []rt.PhpVal{})])
	}
	mut var_discounts := create_wc_discounts(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this))
	mut iter_14 := this.get_items('coupon').iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_coupon_item := item_14.val
		mut var_coupon_code := rt.call_method(var_coupon_item, 'get_code', []rt.PhpVal{})
		mut var_coupon_id := rt.call_function('wc_get_coupon_id_by_code', [var_coupon_code.clone()])
		if rt.is_true(var_coupon_id) {
		mut var_coupon_object := create_wc_coupon(var_coupon_id.clone())
		} else {
			var_coupon_object = this.get_temporary_coupon(mut rt.cast_object_ptr[Class_WC_Order_Item_Coupon](var_coupon_item))
			rt.call_method(var_coupon_object, 'set_code', [var_coupon_code.clone()])
			rt.call_method(var_coupon_object, 'set_virtual', [rt.new_bool(true)])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_coupon_object, 'get_amount', []rt.PhpVal{}))))) {
				if rt.is_true(this.get_prices_include_tax('')) {
					rt.call_method(var_coupon_object, 'set_amount', [rt.new_float((rt.call_method(var_coupon_item, 'get_discount', []rt.PhpVal{})).to_f64()) + rt.new_float((rt.call_method(var_coupon_item, 'get_discount_tax', []rt.PhpVal{})).to_f64())])
				} else {
					rt.call_method(var_coupon_object, 'set_amount', [rt.call_method(var_coupon_item, 'get_discount', []rt.PhpVal{})])
				}
				rt.call_method(var_coupon_object, 'set_discount_type', [rt.new_string('fixed_cart')])
			}
		}
		var_coupon_object = rt.call_function('apply_filters', [rt.new_string('woocommerce_order_recalculate_coupons_coupon_object'), var_coupon_object.clone(), var_coupon_code.clone(), var_coupon_item.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
		if rt.is_true(var_coupon_object) {
			var_discounts.apply_coupon(var_coupon_object.clone(), rt.new_bool(false))
		}
	}
	this.set_coupon_discount_amounts(rt.new_object('WC_Discounts', []string{}, var_discounts))
	this.set_item_discount_amounts(rt.new_object('WC_Discounts', []string{}, var_discounts))
	this.calculate_totals(true)
}

fn (mut this Class_WC_Abstract_Order) get_temporary_coupon(mut var_coupon_item Class_WC_Order_Item_Coupon) rt.PhpVal {
	mut var_coupon_item_mutated := var_coupon_item
	mut var_coupon_object := create_wc_coupon()
	mut var_coupon_info := rt.call_method(var_coupon_item_mutated, 'get_meta', [rt.new_string('coupon_info'), rt.new_bool(true)])
	if rt.is_true(var_coupon_info) {
		rt.call_method(var_coupon_object, 'set_short_info', [var_coupon_info.clone()])
		return var_coupon_object.clone()
	}
	mut var_coupon_data := rt.call_method(var_coupon_item_mutated, 'get_meta', [rt.new_string('coupon_data'), rt.new_bool(true)])
	if rt.is_true(var_coupon_data) {
		rt.call_method(var_coupon_object, 'set_props', [rt.cast_array(var_coupon_data)])
	}
	return var_coupon_object.clone()
}

fn (mut this Class_WC_Abstract_Order) set_item_discount_amounts(var_discounts rt.PhpVal) {
	mut var_discounts_mutated := var_discounts
	mut var_item_discounts := var_discounts_mutated.get_discounts_by_item()
	mut var_tax_location := this.get_tax_location(rt.new_null())
	var_tax_location = rt.create_array([rt.ArrayItem{ key: none, val: var_tax_location.array_get(rt.new_string('country')) }, rt.ArrayItem{ key: none, val: var_tax_location.array_get(rt.new_string('state')) }, rt.ArrayItem{ key: none, val: var_tax_location.array_get(rt.new_string('postcode')) }, rt.ArrayItem{ key: none, val: var_tax_location.array_get(rt.new_string('city')) }])
	if rt.is_true(var_item_discounts) {
		mut iter_15 := var_item_discounts.iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_amount := item_15.val
			mut var_item_id := item_15.key
			mut var_item := rt.new_bool(this.get_item(var_item_id.clone(), false))
			if rt.is_true(this.get_prices_include_tax('')) && rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), rt.call_method(var_item, 'get_tax_status', []rt.PhpVal{}))) {
			mut iife_temp_13 := Class_WC_Tax{}
			mut iife_result_13 := iife_temp_13.calc_tax(var_amount.clone(), this.get_tax_rates(rt.call_method(var_item, 'get_tax_class', []rt.PhpVal{}), var_tax_location.clone(), rt.new_null()), rt.new_bool(true))
			mut var_taxes := iife_result_13
			var_amount = rt.sub(var_amount, rt.call_function('array_sum', [var_taxes.clone()]))
			}
			rt.call_method(var_item, 'set_total', [rt.call_function('max', [rt.new_int(0), rt.sub(rt.call_method(var_item, 'get_total', []rt.PhpVal{}), var_amount)])])
		}
	}
}

fn (mut this Class_WC_Abstract_Order) set_coupon_discount_amounts(var_discounts rt.PhpVal) {
	mut var_discounts_mutated := var_discounts
	mut var_coupons := this.get_items('coupon')
	mut var_coupon_code_to_id := rt.call_function('wc_list_pluck', [var_coupons.clone(), rt.new_string('get_id'), rt.new_string('get_code')])
	mut var_all_discounts := var_discounts_mutated.get_discounts()
	mut var_coupon_discounts := var_discounts_mutated.get_discounts_by_coupon()
	mut var_tax_location := this.get_tax_location(rt.new_null())
	var_tax_location = rt.create_array([rt.ArrayItem{ key: none, val: var_tax_location.array_get(rt.new_string('country')) }, rt.ArrayItem{ key: none, val: var_tax_location.array_get(rt.new_string('state')) }, rt.ArrayItem{ key: none, val: var_tax_location.array_get(rt.new_string('postcode')) }, rt.ArrayItem{ key: none, val: var_tax_location.array_get(rt.new_string('city')) }])
	if rt.is_true(var_coupon_discounts) {
		mut iter_16 := var_coupon_discounts.iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_amount := item_16.val
			mut var_coupon_code := item_16.key
			mut var_item_id := if var_coupon_code_to_id.array_isset(var_coupon_code) { var_coupon_code_to_id.array_get(var_coupon_code) } else { rt.new_int(0) }
			if rt.is_true(rt.new_bool(!(rt.is_true(var_item_id)))) {
				mut var_coupon_item := create_wc_order_item_coupon()
				rt.call_method(var_coupon_item, 'set_code', [var_coupon_code.clone()])
				mut var_coupon_id := rt.call_function('wc_get_coupon_id_by_code', [var_coupon_code.clone()])
				mut var_coupon := create_wc_coupon(var_coupon_id.clone())
				mut var_coupon_info := rt.call_method(var_coupon, 'get_short_info', []rt.PhpVal{})
				rt.call_method(var_coupon_item, 'add_meta_data', [rt.new_string('coupon_info'), var_coupon_info.clone()])
			} else {
			var_coupon_item = rt.new_bool(this.get_item(var_item_id.clone(), false))
			}
			mut var_discount_tax := rt.new_int(0)
			mut iter_17 := var_all_discounts.array_get(var_coupon_code).iterator()
			for {
				item_17 := iter_17.next() or { break }
				mut var_item_discount_amount := item_17.val
				mut var_item_id_shadow := item_17.key
				mut var_item := rt.new_bool(this.get_item(var_item_id_shadow.clone(), false))
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), rt.call_method(var_item, 'get_tax_status', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{}))))) {
					continue
				}
				mut iife_temp_14 := Class_WC_Tax{}
				mut iife_result_14 := iife_temp_14.calc_tax(var_item_discount_amount.clone(), this.get_tax_rates(rt.call_method(var_item, 'get_tax_class', []rt.PhpVal{}), var_tax_location.clone(), rt.new_null()), this.get_prices_include_tax(''))
				mut iife_temp_15 := Class_WC_Tax{}
				mut iife_result_15 := iife_temp_15.calc_tax(var_item_discount_amount.clone(), this.get_tax_rates(rt.call_method(var_item, 'get_tax_class', []rt.PhpVal{}), var_tax_location.clone(), rt.new_null()), this.get_prices_include_tax(''))
				mut var_taxes := rt.call_function('array_sum', [iife_result_14])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_tax_round_at_subtotal')]))))) {
				var_taxes = rt.call_function('wc_round_tax_total', [var_taxes.clone()])
				}
				var_discount_tax = rt.add(var_discount_tax, var_taxes)
				if rt.is_true(this.get_prices_include_tax('')) {
				var_amount = rt.sub(var_amount, var_taxes)
				}
			}
			rt.call_method(var_coupon_item, 'set_discount', [var_amount.clone()])
			rt.call_method(var_coupon_item, 'set_discount_tax', [var_discount_tax.clone()])
			this.add_item(var_coupon_item.clone())
		}
	}
}

fn (mut this Class_WC_Abstract_Order) add_product(var_product rt.PhpVal, qty i64, var_args rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_args_mutated := var_args
	if rt.is_true(var_product_mutated) {
	mut iife_temp_16 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_16 := iife_temp_16.get_value_or_default(var_args_mutated.clone(), rt.new_string('order'))
	mut var_order := iife_result_16
	mut var_total := rt.call_function('wc_get_price_excluding_tax', [var_product_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'qty', val: qty }, rt.ArrayItem{ key: 'order', val: var_order }])])
	mut var_default_args := { 'name': rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{}), 'tax_class': rt.call_method(var_product_mutated, 'get_tax_class', []rt.PhpVal{}), 'product_id': if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) { rt.call_method(var_product_mutated, 'get_parent_id', []rt.PhpVal{}) } else { rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}) }, 'variation_id': if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) { rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}) } else { rt.new_int(0) }, 'variation': if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) { rt.call_method(var_product_mutated, 'get_attributes', []rt.PhpVal{}) } else { rt.new_array() }, 'subtotal': var_total, 'total': var_total, 'quantity': rt.new_int(qty) }
	} else {
	var_default_args = { 'quantity': rt.new_int(qty) }
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(), rt.create_array_from_native_map(var_default_args)])
	if var_args_mutated.array_isset(rt.new_string('totals')) {
		mut iter_18 := var_args_mutated.array_get(rt.new_string('totals')).iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_value := item_18.val
			mut var_key := item_18.key
			if rt.is_true(rt.identical(rt.new_string('tax'), var_key)) {
				var_args_mutated.array_set('total_tax', var_value.clone())
			} else if rt.is_true(rt.identical(rt.new_string('tax_data'), var_key)) {
				var_args_mutated.array_set('taxes', var_value.clone())
			} else {
				var_args_mutated.array_set(var_key, var_value.clone())
			}
		}
	}
	mut var_item := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()]), 'get_instance_of', [Class_WC_Order_Item_Product.class()])
	rt.call_method(var_item, 'set_props', [var_args_mutated.clone()])
	rt.call_method(var_item, 'set_backorder_meta', []rt.PhpVal{})
	rt.call_method(var_item, 'set_order_id', [this.get_id()])
	rt.call_method(var_item, 'save', []rt.PhpVal{})
	this.add_item(var_item.clone())
	rt.call_function('wc_do_deprecated_action', [rt.new_string('woocommerce_order_add_product'), rt.create_array([rt.ArrayItem{ key: none, val: this.get_id() }, rt.ArrayItem{ key: none, val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: var_product_mutated }, rt.ArrayItem{ key: none, val: qty }, rt.ArrayItem{ key: none, val: var_args_mutated }]), rt.new_string('3.0'), rt.new_string('woocommerce_new_order_item action instead')])
	rt.call_function('wp_cache_delete', [rt.new_string('order-needs-processing-' + (this.get_id()).str()), rt.new_string('orders')])
	return rt.call_method(var_item, 'get_id', []rt.PhpVal{})
}

fn (mut this Class_WC_Abstract_Order) add_payment_token(var_token rt.PhpVal) bool {
	if !rt.is_true(var_token) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_token, 'WC_Payment_Token')))))) {
		return false
	}
	mut var_token_ids := rt.call_method(rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store'), 'get_payment_token_ids', [rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
	var_token_ids.array_push(rt.call_method(var_token, 'get_id', []rt.PhpVal{}))
	rt.call_method(rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store'), 'update_payment_token_ids', [rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), var_token_ids.clone()])
	rt.call_function('do_action', [rt.new_string('woocommerce_payment_token_added_to_order'), this.get_id(), rt.call_method(var_token, 'get_id', []rt.PhpVal{}), var_token.clone(), var_token_ids.clone()])
	return (rt.call_method(var_token, 'get_id', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Abstract_Order) get_payment_tokens() rt.PhpVal {
	return rt.call_method(rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store'), 'get_payment_token_ids', [rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
}

fn (mut this Class_WC_Abstract_Order) calculate_shipping() rt.PhpVal {
	mut var_shipping_total := rt.new_int(0)
	mut iter_19 := this.get_shipping_methods().iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_shipping := item_19.val
		var_shipping_total = rt.add(var_shipping_total, rt.new_float((rt.call_method(var_shipping, 'get_total', []rt.PhpVal{})).to_f64()))
	}
	this.set_shipping_total(var_shipping_total.clone())
	this.save()
	return this.get_shipping_total('')
}

fn (mut this Class_WC_Abstract_Order) get_items_tax_classes() rt.PhpVal {
	mut var_found_tax_classes := rt.new_array()
	mut iter_20 := this.get_items('').iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_item := item_20.val
		if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_item }, rt.ArrayItem{ key: none, val: 'get_tax_status' }])]) && rt.is_true(rt.call_function('in_array', [rt.call_method(var_item, 'get_tax_status', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.shipping() }]), rt.new_bool(true)])) {
			var_found_tax_classes << rt.call_method(var_item, 'get_tax_class', []rt.PhpVal{})
		}
	}
	return rt.call_function('array_unique', [rt.create_array_from_list(var_found_tax_classes)])
}

fn (mut this Class_WC_Abstract_Order) get_tax_location(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_tax_based_on := rt.call_function('get_option', [rt.new_string('woocommerce_tax_based_on')])
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_TaxBasedOn.shipping(), var_tax_based_on)) && rt.is_true(rt.new_bool(!(rt.is_true(this.get_shipping_country())))) {
	var_tax_based_on = Class_Automattic_WooCommerce_Enums_TaxBasedOn.billing()
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'country', val: if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_TaxBasedOn.billing(), var_tax_based_on)) { this.get_billing_country() } else { this.get_shipping_country() } }, rt.ArrayItem{ key: 'state', val: if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_TaxBasedOn.billing(), var_tax_based_on)) { this.get_billing_state() } else { this.get_shipping_state() } }, rt.ArrayItem{ key: 'postcode', val: if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_TaxBasedOn.billing(), var_tax_based_on)) { this.get_billing_postcode() } else { this.get_shipping_postcode() } }, rt.ArrayItem{ key: 'city', val: if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_TaxBasedOn.billing(), var_tax_based_on)) { this.get_billing_city() } else { this.get_shipping_city() } }])])
	mut var_apply_base_tax := rt.identical(rt.new_bool(true), rt.call_function('apply_filters', [rt.new_string('woocommerce_apply_base_tax_for_local_pickup'), rt.new_bool(true)]))
	mut var_local_pickup_methods := rt.call_function('apply_filters', [rt.new_string('woocommerce_local_pickup_methods'), rt.create_array([rt.ArrayItem{ key: none, val: 'legacy_local_pickup' }, rt.ArrayItem{ key: none, val: 'local_pickup' }])])
	mut iife_temp_17 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
	mut iife_result_17 := iife_temp_17.select(this.get_shipping_methods(), rt.new_string('get_method_id'), Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_object_method())
	mut var_shipping_method_ids := iife_result_17
	if rt.is_true(var_apply_base_tax) && rt.call_function('array_intersect', [var_shipping_method_ids.clone(), var_local_pickup_methods.clone()]).array_count() > 0 {
	var_tax_based_on = Class_Automattic_WooCommerce_Enums_TaxBasedOn.base()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_TaxBasedOn.base(), var_tax_based_on)) || !rt.is_true(var_args_mutated.array_get(rt.new_string('country'))) {
		var_args_mutated.array_set('country', rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{}))
		var_args_mutated.array_set('state', rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_state', []rt.PhpVal{}))
		var_args_mutated.array_set('postcode', rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_postcode', []rt.PhpVal{}))
		var_args_mutated.array_set('city', rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_city', []rt.PhpVal{}))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_get_tax_location'), var_args_mutated.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
}

fn (mut this Class_WC_Abstract_Order) get_taxable_location(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	return this.get_tax_location(var_args_mutated.clone())
}

fn (mut this Class_WC_Abstract_Order) get_tax_rates(var_tax_class rt.PhpVal, var_location_args rt.PhpVal, var_customer rt.PhpVal) rt.PhpVal {
	mut var_tax_location := this.get_tax_location(var_location_args.clone())
	var_tax_location = rt.create_array([rt.ArrayItem{ key: none, val: var_tax_location.array_get(rt.new_string('country')) }, rt.ArrayItem{ key: none, val: var_tax_location.array_get(rt.new_string('state')) }, rt.ArrayItem{ key: none, val: var_tax_location.array_get(rt.new_string('postcode')) }, rt.ArrayItem{ key: none, val: var_tax_location.array_get(rt.new_string('city')) }])
	mut iife_temp_18 := Class_WC_Tax{}
	mut iife_result_18 := iife_temp_18.get_rates_from_location(var_tax_class.clone(), var_tax_location.clone(), var_customer.clone())
	return iife_result_18
}

fn (mut this Class_WC_Abstract_Order) calculate_taxes(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	rt.call_function('do_action', [rt.new_string('woocommerce_order_before_calculate_taxes'), var_args_mutated.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
	mut var_calculate_tax_for := this.get_tax_location(var_args_mutated.clone())
	mut var_shipping_tax_class := rt.call_function('get_option', [rt.new_string('woocommerce_shipping_tax_class')])
	if rt.is_true(rt.identical(rt.new_string('inherit'), var_shipping_tax_class)) {
	mut iife_temp_19 := Class_WC_Tax{}
	mut iife_result_19 := iife_temp_19.get_tax_class_slugs()
	mut iife_temp_20 := Class_WC_Tax{}
	mut iife_result_20 := iife_temp_20.get_tax_class_slugs()
	mut var_found_classes := rt.call_function('array_intersect', [rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: '' }]), iife_result_19]), this.get_items_tax_classes()])
	var_shipping_tax_class = if rt.is_true(rt.new_int(var_found_classes.clone().array_count())) { rt.call_function('current', [var_found_classes.clone()]) } else { rt.new_bool(false) }
	}
	mut var_is_vat_exempt := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_is_vat_exempt'), rt.identical(rt.new_string('yes'), this.get_meta(rt.new_string('is_vat_exempt'))), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
	mut iter_21 := this.get_items((rt.create_array([rt.ArrayItem{ key: none, val: 'line_item' }, rt.ArrayItem{ key: none, val: 'fee' }])).str()).iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_item := item_21.val
		mut var_item_id := item_21.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_vat_exempt)))) {
			rt.call_method(var_item, 'calculate_taxes', [var_calculate_tax_for.clone()])
		} else {
			rt.call_method(var_item, 'set_taxes', [rt.new_bool(false)])
		}
	}
	mut iter_22 := this.get_shipping_methods().iterator()
	for {
		item_22 := iter_22.next() or { break }
		mut var_item := item_22.val
		mut var_item_id := item_22.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_shipping_tax_class)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_vat_exempt)))) {
			rt.call_method(var_item, 'calculate_taxes', [rt.call_function('array_merge', [var_calculate_tax_for.clone(), rt.create_array([rt.ArrayItem{ key: 'tax_class', val: var_shipping_tax_class }])])])
		} else {
			rt.call_method(var_item, 'set_taxes', [rt.new_bool(false)])
		}
	}
	this.update_taxes()
}

fn (mut this Class_WC_Abstract_Order) get_total_fees() rt.PhpVal {
	closure_22_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_carry := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_item := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.new_float(var_carry + rt.new_float((rt.call_method(var_item, 'get_total', []rt.PhpVal{})).to_f64()))
		}
	return rt.call_function('array_reduce', [this.get_fees(), rt.new_closure(closure_22_fn), rt.new_float(0)])
}

fn (mut this Class_WC_Abstract_Order) update_taxes() {
	mut var_cart_taxes := rt.new_array()
	mut var_shipping_taxes := rt.new_array()
	mut var_existing_taxes := this.get_taxes()
	mut var_saved_rate_ids := rt.new_array()
	mut iter_23 := this.get_items((rt.create_array([rt.ArrayItem{ key: none, val: 'line_item' }, rt.ArrayItem{ key: none, val: 'fee' }])).str()).iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_item := item_23.val
		mut var_item_id := item_23.key
		mut var_taxes := rt.call_method(var_item, 'get_taxes', []rt.PhpVal{})
		mut iter_24 := var_taxes.array_get(rt.new_string('total')).iterator()
		for {
			item_24 := iter_24.next() or { break }
			mut var_tax := item_24.val
			mut var_tax_rate_id := item_24.key
			mut var_tax_amount := rt.new_float((this.round_line_tax(var_tax.clone(), rt.new_bool(false))).to_f64())
			var_cart_taxes.array_set(var_tax_rate_id, if var_cart_taxes.array_isset(var_tax_rate_id) { rt.new_float((var_cart_taxes.array_get(var_tax_rate_id)).to_f64()) + var_tax_amount } else { var_tax_amount })
		}
	}
	mut iter_25 := this.get_shipping_methods().iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_item := item_25.val
		mut var_item_id := item_25.key
		mut var_taxes := rt.call_method(var_item, 'get_taxes', []rt.PhpVal{})
		mut iter_26 := var_taxes.array_get(rt.new_string('total')).iterator()
		for {
			item_26 := iter_26.next() or { break }
			mut var_tax := item_26.val
			mut var_tax_rate_id := item_26.key
			mut var_tax_amount := rt.new_float((var_tax).to_f64())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_tax_round_at_subtotal')]))))) {
			var_tax_amount = rt.call_function('wc_round_tax_total', [var_tax_amount.clone()])
			}
			var_shipping_taxes.array_set(var_tax_rate_id, if var_shipping_taxes.array_isset(var_tax_rate_id) { rt.new_float((var_shipping_taxes.array_get(var_tax_rate_id)).to_f64()) + var_tax_amount } else { var_tax_amount })
		}
	}
	mut iter_27 := var_existing_taxes.iterator()
	for {
		item_27 := iter_27.next() or { break }
		mut var_tax := item_27.val
		if (rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cart_taxes.clone().array_isset(rt.call_method(var_tax, 'get_rate_id', []rt.PhpVal{}))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_shipping_taxes.clone().array_isset(rt.call_method(var_tax, 'get_rate_id', []rt.PhpVal{})))))))) || rt.is_true(rt.call_function('in_array', [rt.call_method(var_tax, 'get_rate_id', []rt.PhpVal{}), rt.create_array_from_list(var_saved_rate_ids), rt.new_bool(true)])) {
			this.remove_item(rt.call_method(var_tax, 'get_id', []rt.PhpVal{}))
			continue
		}
		var_saved_rate_ids << rt.call_method(var_tax, 'get_rate_id', []rt.PhpVal{})
		rt.call_method(var_tax, 'set_rate', [rt.call_method(var_tax, 'get_rate_id', []rt.PhpVal{})])
		rt.call_method(var_tax, 'set_tax_total', [if var_cart_taxes.array_isset(rt.call_method(var_tax, 'get_rate_id', []rt.PhpVal{})) { var_cart_taxes.array_get(rt.call_method(var_tax, 'get_rate_id', []rt.PhpVal{})) } else { rt.new_int(0) }])
		mut iife_temp_22 := Class_WC_Tax{}
		mut iife_result_22 := iife_temp_22.get_rate_label(rt.call_method(var_tax, 'get_rate_id', []rt.PhpVal{}))
		rt.call_method(var_tax, 'set_label', [iife_result_22])
		rt.call_method(var_tax, 'set_shipping_tax_total', [if !(!rt.is_true(var_shipping_taxes.array_get(rt.call_method(var_tax, 'get_rate_id', []rt.PhpVal{})))) { var_shipping_taxes.array_get(rt.call_method(var_tax, 'get_rate_id', []rt.PhpVal{})) } else { rt.new_int(0) }])
		rt.call_method(var_tax, 'save', []rt.PhpVal{})
	}
	mut var_new_rate_ids := rt.call_function('wp_parse_id_list', [rt.call_function('array_diff', [rt.func_array_keys(rt.add(var_cart_taxes, var_shipping_taxes)), rt.create_array_from_list(var_saved_rate_ids)])])
	mut iter_28 := var_new_rate_ids.iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_tax_rate_id := item_28.val
		mut var_item := create_wc_order_item_tax()
		rt.call_method(var_item, 'set_rate', [var_tax_rate_id.clone()])
		rt.call_method(var_item, 'set_tax_total', [if var_cart_taxes.array_isset(var_tax_rate_id) { var_cart_taxes.array_get(var_tax_rate_id) } else { rt.new_int(0) }])
		rt.call_method(var_item, 'set_shipping_tax_total', [if !(!rt.is_true(var_shipping_taxes.array_get(var_tax_rate_id))) { var_shipping_taxes.array_get(var_tax_rate_id) } else { rt.new_int(0) }])
		this.add_item(var_item.clone())
	}
	this.set_shipping_tax(rt.call_function('array_sum', [var_shipping_taxes.clone()]))
	this.set_cart_tax(rt.call_function('array_sum', [var_cart_taxes.clone()]))
	this.save()
}

fn (mut this Class_WC_Abstract_Order) get_cart_subtotal_for_order() rt.PhpVal {
	return rt.call_function('wc_remove_number_precision', [this.get_rounded_items_total(this.get_values_for_total(rt.new_string('subtotal')))])
}

fn (mut this Class_WC_Abstract_Order) get_cart_total_for_order() rt.PhpVal {
	return rt.call_function('wc_remove_number_precision', [this.get_rounded_items_total(this.get_values_for_total(rt.new_string('total')))])
}

fn (mut this Class_WC_Abstract_Order) calculate_totals(and_taxes bool) rt.PhpVal {
	rt.call_function('do_action', [rt.new_string('woocommerce_order_before_calculate_totals'), rt.new_bool(and_taxes), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
	mut var_fees_total := rt.new_int(0)
	mut var_shipping_total := rt.new_int(0)
	mut var_cart_subtotal_tax := rt.new_int(0)
	mut var_cart_total_tax := rt.new_int(0)
	mut var_cart_subtotal := this.get_cart_subtotal_for_order()
	mut var_cart_total := rt.new_float((this.get_cart_total_for_order()).to_f64())
	mut iter_29 := this.get_shipping_methods().iterator()
	for {
		item_29 := iter_29.next() or { break }
		mut var_shipping := item_29.val
		mut iife_temp_23 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
		mut iife_result_23 := iife_temp_23.round(rt.call_method(var_shipping, 'get_total', []rt.PhpVal{}), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
		var_shipping_total = rt.add(var_shipping_total, iife_result_23)
	}
	this.set_shipping_total(var_shipping_total.clone())
	mut iter_30 := this.get_fees().iterator()
	for {
		item_30 := iter_30.next() or { break }
		mut var_item := item_30.val
		mut var_fee_total := rt.new_float((rt.call_method(var_item, 'get_total', []rt.PhpVal{})).to_f64())
		if rt.is_true(rt.greater(rt.new_int(0), var_fee_total)) {
			mut iife_temp_24 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
			mut iife_result_24 := iife_temp_24.round(rt.add(rt.add(var_cart_total, var_fees_total), var_shipping_total), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
			mut var_max_discount := rt.mul(iife_result_24, -1)
			if rt.is_true(rt.less(var_fee_total, var_max_discount)) && rt.is_true(rt.greater(rt.new_int(0), var_max_discount)) {
				rt.call_method(var_item, 'set_total', [var_max_discount.clone()])
			}
		}
		var_fees_total = rt.add(var_fees_total, rt.new_float((rt.call_method(var_item, 'get_total', []rt.PhpVal{})).to_f64()))
	}
	if var_and_taxes {
		this.calculate_taxes(rt.new_null())
	}
	mut iter_31 := this.get_items('').iterator()
	for {
		item_31 := iter_31.next() or { break }
		mut var_item := item_31.val
		mut var_taxes := rt.call_method(var_item, 'get_taxes', []rt.PhpVal{})
		mut iter_32 := var_taxes.array_get(rt.new_string('total')).iterator()
		for {
			item_32 := iter_32.next() or { break }
			mut var_tax := item_32.val
			mut var_tax_rate_id := item_32.key
			var_cart_total_tax = rt.add(var_cart_total_tax, rt.new_float((var_tax).to_f64()))
		}
		mut iter_33 := var_taxes.array_get(rt.new_string('subtotal')).iterator()
		for {
			item_33 := iter_33.next() or { break }
			mut var_tax := item_33.val
			mut var_tax_rate_id := item_33.key
			var_cart_subtotal_tax = rt.add(var_cart_subtotal_tax, rt.new_float((var_tax).to_f64()))
		}
	}
	mut iife_temp_25 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_25 := iife_temp_25.round(rt.sub(var_cart_subtotal, var_cart_total), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
	this.set_discount_total(iife_result_25)
	this.set_discount_tax(rt.call_function('wc_round_tax_total', [rt.sub(var_cart_subtotal_tax, var_cart_total_tax)]))
	mut iife_temp_26 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_26 := iife_temp_26.round(rt.new_float(var_cart_total + var_fees_total + rt.new_float((this.get_shipping_total('')).to_f64()) + rt.new_float((this.get_cart_tax('')).to_f64()) + rt.new_float((this.get_shipping_tax('')).to_f64())), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
	this.set_total(iife_result_26, '')
	if this.has_cogs() && rt.is_true(this.cogs_is_enabled()) {
		this.calculate_cogs_total_value()
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_order_after_calculate_totals'), rt.new_bool(and_taxes), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
	this.save()
	return this.get_total('')
}

fn (mut this Class_WC_Abstract_Order) get_item_subtotal(var_item rt.PhpVal, inc_tax bool, round bool) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_subtotal := rt.new_int(0)
	if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_item_mutated }, rt.ArrayItem{ key: none, val: 'get_subtotal' }])]) && rt.is_true(rt.call_method(var_item_mutated, 'get_quantity', []rt.PhpVal{})) {
		if var_inc_tax {
		var_subtotal = rt.new_float((rt.call_method(var_item_mutated, 'get_subtotal', []rt.PhpVal{})).to_f64()) + rt.new_float((rt.call_method(var_item_mutated, 'get_subtotal_tax', []rt.PhpVal{})).to_f64()) / rt.call_method(var_item_mutated, 'get_quantity', []rt.PhpVal{})
		} else {
		var_subtotal = rt.new_float((rt.call_method(var_item_mutated, 'get_subtotal', []rt.PhpVal{})).to_f64()) / rt.call_method(var_item_mutated, 'get_quantity', []rt.PhpVal{})
		}
	mut iife_temp_27 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_27 := iife_temp_27.round(var_subtotal.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
	var_subtotal = if var_round { iife_result_27 } else { var_subtotal }
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_amount_item_subtotal'), var_subtotal.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), var_item_mutated.clone(), rt.new_bool(inc_tax), rt.new_bool(round)])
}

fn (mut this Class_WC_Abstract_Order) get_line_subtotal(var_item rt.PhpVal, inc_tax bool, round bool) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_subtotal := rt.new_int(0)
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_item_mutated }, rt.ArrayItem{ key: none, val: 'get_subtotal' }])])) {
		if var_inc_tax {
		var_subtotal = rt.new_float((rt.call_method(var_item_mutated, 'get_subtotal', []rt.PhpVal{})).to_f64()) + rt.new_float((rt.call_method(var_item_mutated, 'get_subtotal_tax', []rt.PhpVal{})).to_f64())
		} else {
		var_subtotal = rt.new_float((rt.call_method(var_item_mutated, 'get_subtotal', []rt.PhpVal{})).to_f64())
		}
	mut iife_temp_28 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_28 := iife_temp_28.round(var_subtotal.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
	var_subtotal = if var_round { iife_result_28 } else { var_subtotal }
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_amount_line_subtotal'), var_subtotal.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), var_item_mutated.clone(), rt.new_bool(inc_tax), rt.new_bool(round)])
}

fn (mut this Class_WC_Abstract_Order) get_item_total(var_item rt.PhpVal, inc_tax bool, round bool) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_total := rt.new_int(0)
	if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_item_mutated }, rt.ArrayItem{ key: none, val: 'get_total' }])]) && rt.is_true(rt.call_method(var_item_mutated, 'get_quantity', []rt.PhpVal{})) {
		if var_inc_tax {
		var_total = rt.new_float((rt.call_method(var_item_mutated, 'get_total', []rt.PhpVal{})).to_f64()) + rt.new_float((rt.call_method(var_item_mutated, 'get_total_tax', []rt.PhpVal{})).to_f64()) / rt.call_method(var_item_mutated, 'get_quantity', []rt.PhpVal{})
		} else {
		var_total = rt.new_float((rt.call_method(var_item_mutated, 'get_total', []rt.PhpVal{})).to_f64()) / rt.call_method(var_item_mutated, 'get_quantity', []rt.PhpVal{})
		}
	mut iife_temp_29 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_29 := iife_temp_29.round(var_total.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
	var_total = if var_round { iife_result_29 } else { var_total }
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_amount_item_total'), var_total.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), var_item_mutated.clone(), rt.new_bool(inc_tax), rt.new_bool(round)])
}

fn (mut this Class_WC_Abstract_Order) get_line_total(var_item rt.PhpVal, inc_tax bool, round bool) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_total := rt.new_int(0)
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_item_mutated }, rt.ArrayItem{ key: none, val: 'get_total' }])])) {
	var_total = rt.new_float(if var_inc_tax { rt.new_float((rt.call_method(var_item_mutated, 'get_total', []rt.PhpVal{})).to_f64()) + rt.new_float((rt.call_method(var_item_mutated, 'get_total_tax', []rt.PhpVal{})).to_f64()) } else { rt.new_float((rt.call_method(var_item_mutated, 'get_total', []rt.PhpVal{})).to_f64()) })
	mut iife_temp_30 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_30 := iife_temp_30.round(var_total.clone(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
	var_total = if var_round { iife_result_30 } else { var_total }
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_amount_line_total'), var_total.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), var_item_mutated.clone(), rt.new_bool(inc_tax), rt.new_bool(round)])
}

fn (mut this Class_WC_Abstract_Order) get_item_tax(var_item rt.PhpVal, round bool) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_tax := rt.new_int(0)
	if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_item_mutated }, rt.ArrayItem{ key: none, val: 'get_total_tax' }])]) && rt.is_true(rt.call_method(var_item_mutated, 'get_quantity', []rt.PhpVal{})) {
	var_tax = rt.div(rt.call_method(var_item_mutated, 'get_total_tax', []rt.PhpVal{}), rt.call_method(var_item_mutated, 'get_quantity', []rt.PhpVal{}))
	var_tax = if var_round { rt.call_function('wc_round_tax_total', [var_tax.clone()]) } else { var_tax }
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_amount_item_tax'), var_tax.clone(), var_item_mutated.clone(), rt.new_bool(round), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
}

fn (mut this Class_WC_Abstract_Order) get_line_tax(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_amount_line_tax'), if rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_item_mutated }, rt.ArrayItem{ key: none, val: 'get_total_tax' }])]) { rt.call_function('wc_round_tax_total', [rt.call_method(var_item_mutated, 'get_total_tax', []rt.PhpVal{})]) } else { rt.new_int(0) }, var_item_mutated.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
}

fn (mut this Class_WC_Abstract_Order) get_formatted_line_subtotal(var_item rt.PhpVal, tax_display string) rt.PhpVal {
	mut var_item_mutated := var_item
	mut tax_display_mutated := tax_display
	tax_display_mutated = (if rt.is_true(rt.new_string(tax_display_mutated)) { rt.new_string(tax_display_mutated) } else { rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_cart')]) }).str()
	if rt.is_true(rt.identical(rt.new_string('excl'), rt.new_string(tax_display_mutated))) {
	mut var_ex_tax_label := rt.new_int(if rt.is_true(this.get_prices_include_tax('')) { 1 } else { 0 })
	mut var_subtotal := rt.call_function('wc_price', [this.get_line_subtotal(var_item_mutated.clone(), false, false), rt.create_array([rt.ArrayItem{ key: 'ex_tax_label', val: var_ex_tax_label }, rt.ArrayItem{ key: 'currency', val: this.get_currency('') }])])
	} else {
	var_subtotal = rt.call_function('wc_price', [this.get_line_subtotal(var_item_mutated.clone(), true, false), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency('') }])])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_formatted_line_subtotal'), var_subtotal.clone(), var_item_mutated.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
}

fn (mut this Class_WC_Abstract_Order) get_formatted_order_total() rt.PhpVal {
	mut var_formatted_total := rt.call_function('wc_price', [this.get_total(''), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency('') }])])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_formatted_order_total'), var_formatted_total.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
}

fn (mut this Class_WC_Abstract_Order) get_subtotal_to_display(compound bool, tax_display string) string {
	mut tax_display_mutated := tax_display
	tax_display_mutated = (if rt.is_true(rt.new_string(tax_display_mutated)) { rt.new_string(tax_display_mutated) } else { rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_cart')]) }).str()
	mut var_subtotal := rt.new_float((this.get_cart_subtotal_for_order()).to_f64())
	if !(var_compound) {
		if rt.is_true(rt.identical(rt.new_string('incl'), rt.new_string(tax_display_mutated))) {
			mut var_subtotal_taxes := rt.new_int(0)
			mut iter_34 := this.get_items('').iterator()
			for {
				item_34 := iter_34.next() or { break }
				mut var_item := item_34.val
				mut iife_temp_31 := Class_WC_Abstract_Order{}
				mut iife_result_31 := iife_temp_31.round_line_tax(rt.new_float((rt.call_method(var_item, 'get_subtotal_tax', []rt.PhpVal{})).to_f64()), rt.new_bool(false))
				var_subtotal_taxes = rt.add(var_subtotal_taxes, iife_result_31)
			}
			var_subtotal = rt.add(var_subtotal, rt.call_function('wc_round_tax_total', [var_subtotal_taxes.clone()]))
		}
		var_subtotal = rt.call_function('wc_price', [var_subtotal.clone(), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency('') }])])
		if rt.is_true(rt.identical(rt.new_string('excl'), rt.new_string(tax_display_mutated))) && rt.is_true(this.get_prices_include_tax('')) && rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
			var_subtotal = rt.concat(var_subtotal, rt.new_string(' <small class="tax_label">' + (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'ex_tax_or_vat', []rt.PhpVal{})).str() + '</small>'))
		}
	} else {
		if rt.is_true(rt.identical(rt.new_string('incl'), rt.new_string(tax_display_mutated))) {
			return ''
		}
		var_subtotal = rt.add(var_subtotal, rt.new_float((this.get_shipping_total('')).to_f64()))
		mut iter_35 := this.get_taxes().iterator()
		for {
			item_35 := iter_35.next() or { break }
			mut var_tax := item_35.val
			if rt.is_true(rt.call_method(var_tax, 'is_compound', []rt.PhpVal{})) {
				continue
			}
		var_subtotal = rt.new_float(var_subtotal + rt.new_float((rt.call_method(var_tax, 'get_tax_total', []rt.PhpVal{})).to_f64()) + rt.new_float((rt.call_method(var_tax, 'get_shipping_tax_total', []rt.PhpVal{})).to_f64()))
		}
	var_subtotal = rt.new_float(var_subtotal - rt.new_float((this.get_total_discount(false)).to_f64()))
	var_subtotal = rt.call_function('wc_price', [var_subtotal.clone(), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency('') }])])
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_order_subtotal_to_display'), var_subtotal.clone(), rt.new_bool(compound), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])).str()
}

fn (mut this Class_WC_Abstract_Order) get_shipping_to_display(tax_display string) rt.PhpVal {
	mut tax_display_mutated := tax_display
	tax_display_mutated = (if rt.is_true(rt.new_string(tax_display_mutated)) { rt.new_string(tax_display_mutated) } else { rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_cart')]) }).str()
	if rt.is_true(rt.less(rt.new_int(0), rt.call_function('abs', [rt.new_float((this.get_shipping_total('')).to_f64())]))) {
		if rt.is_true(rt.identical(rt.new_string('excl'), rt.new_string(tax_display_mutated))) {
			mut var_shipping := rt.call_function('wc_price', [this.get_shipping_total(''), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency('') }])])
			if rt.new_float((this.get_shipping_tax('')).to_f64()) > 0 && rt.is_true(this.get_prices_include_tax('')) {
				var_shipping = rt.concat(var_shipping, rt.call_function('apply_filters', [rt.new_string('woocommerce_order_shipping_to_display_tax_label'), rt.new_string('&nbsp;<small class="tax_label">' + (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'ex_tax_or_vat', []rt.PhpVal{})).str() + '</small>'), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), rt.new_string(tax_display_mutated).clone()]))
			}
		} else {
			var_shipping = rt.call_function('wc_price', [rt.new_float((this.get_shipping_total('')).to_f64()) + rt.new_float((this.get_shipping_tax('')).to_f64()), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency('') }])])
			if rt.new_float((this.get_shipping_tax('')).to_f64()) > 0 && rt.is_true(rt.new_bool(!(rt.is_true(this.get_prices_include_tax(''))))) {
				var_shipping = rt.concat(var_shipping, rt.call_function('apply_filters', [rt.new_string('woocommerce_order_shipping_to_display_tax_label'), rt.new_string('&nbsp;<small class="tax_label">' + (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'inc_tax_or_vat', []rt.PhpVal{})).str() + '</small>'), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), rt.new_string(tax_display_mutated).clone()]))
			}
		}
		var_shipping = rt.concat(var_shipping, rt.call_function('apply_filters', [rt.new_string('woocommerce_order_shipping_to_display_shipped_via'), rt.new_string('&nbsp;<small class="shipped_via">' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('via %s'), rt.new_string('woocommerce')]), this.get_shipping_method()])).str() + '</small>'), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)]))
	} else if rt.is_true(this.get_shipping_method()) {
	var_shipping = this.get_shipping_method()
	} else {
	var_shipping = rt.call_function('__', [rt.new_string('Free!'), rt.new_string('woocommerce')])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_shipping_to_display'), var_shipping.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), rt.new_string(tax_display_mutated).clone()])
}

fn (mut this Class_WC_Abstract_Order) get_discount_to_display(tax_display string) rt.PhpVal {
	mut tax_display_mutated := tax_display
	tax_display_mutated = (if rt.is_true(rt.new_string(tax_display_mutated)) { rt.new_string(tax_display_mutated) } else { rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_cart')]) }).str()
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_discount_to_display'), rt.call_function('wc_price', [this.get_total_discount((rt.identical(rt.new_string('excl'), rt.new_string(tax_display_mutated))).to_bool()), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency('') }])]), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
}

fn (mut this Class_WC_Abstract_Order) add_order_item_totals_subtotal_row(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal) {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
	mut var_subtotal := rt.new_string(this.get_subtotal_to_display(false, (var_tax_display_mutated).str()))
	if rt.is_true(var_subtotal) {
		var_total_rows_mutated.array_set('cart_subtotal', rt.create_array([rt.ArrayItem{ key: 'type', val: 'subtotal' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Subtotal:'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: var_subtotal }]))
	}
}

fn (mut this Class_WC_Abstract_Order) add_order_item_totals_discount_row(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal) {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
	if rt.is_true(rt.greater(this.get_total_discount(false), rt.new_int(0))) {
		var_total_rows_mutated.array_set('discount', rt.create_array([rt.ArrayItem{ key: 'type', val: 'discount' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Discount:'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: '-' + (this.get_discount_to_display((var_tax_display_mutated).str())).str() }]))
	}
}

fn (mut this Class_WC_Abstract_Order) add_order_item_totals_shipping_row(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal) {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
	if rt.is_true(this.get_shipping_method()) {
		var_total_rows_mutated.array_set('shipping', rt.create_array([rt.ArrayItem{ key: 'type', val: 'shipping' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Shipping:'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: this.get_shipping_to_display((var_tax_display_mutated).str()) }, rt.ArrayItem{ key: 'meta', val: this.get_shipping_method() }]))
	}
}

fn (mut this Class_WC_Abstract_Order) add_order_item_totals_fee_rows(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal) {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
	mut var_fees := this.get_fees()
	if rt.is_true(var_fees) {
		mut iter_36 := var_fees.iterator()
		for {
			item_36 := iter_36.next() or { break }
			mut var_fee := item_36.val
			mut var_id := item_36.key
			if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_get_order_item_totals_excl_free_fees'), rt.new_bool(!rt.is_true(var_fee.array_get(rt.new_string('line_total'))) && !rt.is_true(var_fee.array_get(rt.new_string('line_tax')))), var_id.clone()])) {
				continue
			}
			var_total_rows_mutated.array_set('fee_' + (rt.call_method(var_fee, 'get_id', []rt.PhpVal{})).str(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'fee' }, rt.ArrayItem{ key: 'label', val: (rt.call_method(var_fee, 'get_name', []rt.PhpVal{})).str() + ':' }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_price', [rt.new_float(if rt.is_true(rt.identical(rt.new_string('excl'), var_tax_display_mutated)) { rt.new_float((rt.call_method(var_fee, 'get_total', []rt.PhpVal{})).to_f64()) } else { rt.new_float((rt.call_method(var_fee, 'get_total', []rt.PhpVal{})).to_f64()) + rt.new_float((rt.call_method(var_fee, 'get_total_tax', []rt.PhpVal{})).to_f64()) }), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency('') }])]) }]))
		}
	}
}

fn (mut this Class_WC_Abstract_Order) add_order_item_totals_tax_rows(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal) {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
	if rt.is_true(rt.identical(rt.new_string('excl'), var_tax_display_mutated)) && rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		if rt.is_true(rt.identical(rt.new_string('itemized'), rt.call_function('get_option', [rt.new_string('woocommerce_tax_total_display')]))) {
			mut iter_37 := this.get_tax_totals().iterator()
			for {
				item_37 := iter_37.next() or { break }
				mut var_tax := item_37.val
				mut var_code := item_37.key
				var_total_rows_mutated.array_set(rt.call_function('sanitize_title', [var_code.clone()]), rt.create_array([rt.ArrayItem{ key: 'type', val: 'tax' }, rt.ArrayItem{ key: 'label', val: (rt.get_property(var_tax, 'label')).str() + ':' }, rt.ArrayItem{ key: 'value', val: rt.get_property(var_tax, 'formatted_amount') }]))
			}
		} else {
			var_total_rows_mutated.array_set('tax', rt.create_array([rt.ArrayItem{ key: 'type', val: 'tax' }, rt.ArrayItem{ key: 'label', val: (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'tax_or_vat', []rt.PhpVal{})).str() + ':' }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_price', [this.get_total_tax(''), rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency('') }])]) }]))
		}
	}
}

fn (mut this Class_WC_Abstract_Order) add_order_item_totals_total_row(var_total_rows rt.PhpVal, var_tax_display rt.PhpVal) {
	mut var_total_rows_mutated := var_total_rows
	mut var_tax_display_mutated := var_tax_display
	var_total_rows_mutated.array_set('order_total', rt.create_array([rt.ArrayItem{ key: 'type', val: 'total' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Total:'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: this.get_formatted_order_total(var_tax_display_mutated.clone()) }]))
}

fn (mut this Class_WC_Abstract_Order) get_order_item_totals(tax_display string) rt.PhpVal {
	mut tax_display_mutated := tax_display
	tax_display_mutated = (if rt.is_true(rt.new_string(tax_display_mutated)) { rt.new_string(tax_display_mutated) } else { rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_cart')]) }).str()
	mut var_total_rows := rt.new_array()
	this.add_order_item_totals_subtotal_row(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	this.add_order_item_totals_discount_row(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	this.add_order_item_totals_shipping_row(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	this.add_order_item_totals_fee_rows(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	this.add_order_item_totals_tax_rows(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	this.add_order_item_totals_total_row(var_total_rows.clone(), rt.new_string(tax_display_mutated))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_order_item_totals'), var_total_rows.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), rt.new_string(tax_display_mutated).clone()])
}

fn (mut this Class_WC_Abstract_Order) has_status(var_status rt.PhpVal) rt.PhpVal {
	mut var_status_mutated := var_status
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_has_status'), rt.new_bool(var_status_mutated.clone().is_array() && rt.is_true(rt.call_function('in_array', [this.get_status(''), var_status_mutated.clone(), rt.new_bool(true)])) || rt.is_true(rt.identical(this.get_status(''), var_status_mutated))), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), var_status_mutated.clone()])
}

fn (mut this Class_WC_Abstract_Order) has_shipping_method(var_method_id rt.PhpVal) bool {
	mut iter_38 := this.get_shipping_methods().iterator()
	for {
		item_38 := iter_38.next() or { break }
		mut var_shipping_method := item_38.val
		if rt.is_true(rt.identical(rt.call_function('strpos', [rt.call_method(var_shipping_method, 'get_method_id', []rt.PhpVal{}), var_method_id.clone()]), rt.new_int(0))) {
			return true
		}
	}
	return false
}

fn (mut this Class_WC_Abstract_Order) needs_shipping() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_shipping_enabled', []rt.PhpVal{}))))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_function('wc_get_shipping_method_count', [rt.new_bool(true)]))) {
		return false
	}
	mut var_needs_shipping := rt.new_bool(false)
	mut iter_39 := this.get_items('').iterator()
	for {
		item_39 := iter_39.next() or { break }
		mut var_item := item_39.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_item.clone(), rt.new_string('WC_Order_Item_Product')]))))) {
			continue
		}
		mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_a', [var_product.clone(), rt.new_string('WC_Product')])) && rt.is_true(rt.call_method(var_product, 'needs_shipping', []rt.PhpVal{})) {
			var_needs_shipping = rt.new_bool(true)
			break
		}
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_order_needs_shipping'), var_needs_shipping.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])).to_bool()
}

fn (mut this Class_WC_Abstract_Order) has_free_item() bool {
	mut iter_40 := this.get_items('').iterator()
	for {
		item_40 := iter_40.next() or { break }
		mut var_item := item_40.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_item, 'get_total', []rt.PhpVal{}))))) {
			return true
		}
	}
	return false
}

fn (mut this Class_WC_Abstract_Order) get_title() string {
	if rt.is_true(rt.call_function('method_exists', [rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store'), rt.new_string('get_title')])) {
		return (rt.call_method(rt.get_property(rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this), 'data_store'), 'get_title', [rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])).str()
	} else {
		return (rt.call_function('__', [rt.new_string('Order'), rt.new_string('woocommerce')])).str()
	}
	return ''
}

fn (mut this Class_WC_Abstract_Order) has_cogs() bool {
	return false
}

fn (mut this Class_WC_Abstract_Order) calculate_cogs_total_value() f64 {
	if !(this.has_cogs()) || rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD)))))) {
		return 0
	}
	mut var_cogs_value := rt.new_float(this.calculate_cogs_total_value_core())
	var_cogs_value = rt.call_function('apply_filters', [rt.new_string('woocommerce_calculated_order_cogs_value'), var_cogs_value.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])
	this.set_cogs_total_value((var_cogs_value).to_f64())
	return (var_cogs_value).to_f64()
}

fn (mut this Class_WC_Abstract_Order) calculate_cogs_total_value_core() f64 {
	mut var_value := rt.new_int(0)
	mut iter_41 := rt.func_array_keys(this.item_types_to_group).iterator()
	for {
		item_41 := iter_41.next() or { break }
		mut var_item_type := item_41.val
		mut var_order_items := this.get_items((var_item_type).str())
		mut iter_42 := var_order_items.iterator()
		for {
			item_42 := iter_42.next() or { break }
			mut var_item := item_42.val
			if rt.is_true(rt.call_method(var_item, 'has_cogs', []rt.PhpVal{})) {
				rt.call_method(var_item, 'calculate_cogs_value', []rt.PhpVal{})
				var_value = rt.add(var_value, rt.call_method(var_item, 'get_cogs_value', []rt.PhpVal{}))
			}
		}
	}
	return (var_value).to_f64()
}

fn (mut this Class_WC_Abstract_Order) get_cogs_total_value() f64 {
	return rt.new_float((if this.has_cogs() && rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD))) { this.get_prop(rt.new_string('cogs_total_value')) } else { rt.new_int(0) }).to_f64())
}

fn (mut this Class_WC_Abstract_Order) set_cogs_total_value(value f64) {
	mut value_mutated := value
	if this.has_cogs() && rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD))) {
		this.set_prop(rt.new_string('cogs_total_value'), rt.new_float(value_mutated))
	}
}

fn (mut this Class_WC_Abstract_Order) get_cogs_total_value_html(mut var_wc_price_arg Class_?array) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled(rt.new_string(@METHOD)))))) || !(this.has_cogs()) {
		return ''
	}
	mut var_cogs_total_value := rt.new_float(this.get_cogs_total_value())
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_order_cogs_total_value_html'), rt.call_function('wc_price', [var_cogs_total_value.clone(), if !(var_wc_price_arg).is_null() { var_wc_price_arg } else { rt.create_array([rt.ArrayItem{ key: 'currency', val: this.get_currency('') }]) }]), var_cogs_total_value.clone(), rt.new_object('WC_Abstract_Order', ['WC_Abstract_Legacy_Order'], &this)])).str()
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

struct Class_WC_Order_Factory {
	rt.PhpObjectBase
}

struct Class_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Discounts {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Tax {
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

fn create_wc_abstract_legacy_order(_args ...rt.PhpVal) &Class_WC_Abstract_Legacy_Order {
	mut obj := &Class_WC_Abstract_Legacy_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
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

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_orders_paymentinfo(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_factory(_args ...rt.PhpVal) &Class_WC_Order_Factory {
	mut obj := &Class_WC_Order_Factory{
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

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
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

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_coupon(_args ...rt.PhpVal) &Class_WC_Order_Item_Coupon {
	mut obj := &Class_WC_Order_Item_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_tax(_args ...rt.PhpVal) &Class_WC_Order_Item_Tax {
	mut obj := &Class_WC_Order_Item_Tax{
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


fn (mut this Class_WC_Order_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
		else { return none }
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
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WC_Discounts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Discounts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Discounts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Order_Item_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Item_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/legacy/abstract-wc-legacy-order.php', '4')
}
