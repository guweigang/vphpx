import rt

struct Class_WC_Order_Data_Store_CPT {
	rt.PhpObjectBase
pub mut:
	internal_meta_keys              rt.PhpVal = rt.new_array()
	internal_data_store_key_getters rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Order_Data_Store_CPT) create(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_order_mutated,
		'get_order_key', []rt.PhpVal{})))
	{
		rt.call_method(var_order_mutated, 'set_order_key', [
			rt.call_function('wc_generate_order_key', []rt.PhpVal{}),
		])
	}
	this.Class_Abstract_WC_Order_Data_Store_CPT.create(var_order_mutated.clone())
	if rt.is_true(rt.call_function('in_array', [
		rt.call_method(var_order_mutated, 'get_status', [rt.new_string('edit')]),
		rt.create_array([rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft()
		}, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.draft() },
			rt.ArrayItem{ key: none, val: 'checkout-draft' }]),
		rt.new_bool(true),
	]))
	{
		return
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_new_order'),
		rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
		var_order_mutated.clone()])
}

fn (mut this Class_WC_Order_Data_Store_CPT) read_order_data(var_order rt.PhpVal, var_post_object rt.PhpVal) {
	mut var_order_mutated := var_order
	this.Class_Abstract_WC_Order_Data_Store_CPT.read_order_data(var_order_mutated.clone(),
		var_post_object.clone())
	mut var_id := rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})
	mut var_post_meta := rt.call_function('get_post_meta', [var_id.clone()])
	mut var_date_completed := if !(var_post_meta.array_get(rt.new_string('_date_completed')).array_get(rt.new_int(0))).is_null() {
		var_post_meta.array_get(rt.new_string('_date_completed')).array_get(rt.new_int(0))
	} else {
		rt.new_string('')
	}
	mut var_date_paid := if !(var_post_meta.array_get(rt.new_string('_date_paid')).array_get(rt.new_int(0))).is_null() {
		var_post_meta.array_get(rt.new_string('_date_paid')).array_get(rt.new_int(0))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_date_completed)))) {
		var_date_completed = if !(var_post_meta.array_get(rt.new_string('_completed_date')).array_get(rt.new_int(0))).is_null() {
			var_post_meta.array_get(rt.new_string('_completed_date')).array_get(rt.new_int(0))
		} else {
			rt.new_string('')
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_date_paid)))) {
		var_date_paid = if !(var_post_meta.array_get(rt.new_string('_paid_date')).array_get(rt.new_int(0))).is_null() {
			var_post_meta.array_get(rt.new_string('_paid_date')).array_get(rt.new_int(0))
		} else {
			rt.new_string('')
		}
	}
	rt.call_method(var_order_mutated, 'set_props', [
		rt.create_array([
			rt.ArrayItem{
				key: 'order_key'
				val: if !(var_post_meta.array_get(rt.new_string('_order_key')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_order_key')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'customer_id'
				val: if !(var_post_meta.array_get(rt.new_string('_customer_user')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_customer_user')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'billing_first_name'
				val: if !(var_post_meta.array_get(rt.new_string('_billing_first_name')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_billing_first_name')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'billing_last_name'
				val: if !(var_post_meta.array_get(rt.new_string('_billing_last_name')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_billing_last_name')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'billing_company'
				val: if !(var_post_meta.array_get(rt.new_string('_billing_company')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_billing_company')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'billing_address_1'
				val: if !(var_post_meta.array_get(rt.new_string('_billing_address_1')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_billing_address_1')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'billing_address_2'
				val: if !(var_post_meta.array_get(rt.new_string('_billing_address_2')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_billing_address_2')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'billing_city'
				val: if !(var_post_meta.array_get(rt.new_string('_billing_city')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_billing_city')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'billing_state'
				val: if !(var_post_meta.array_get(rt.new_string('_billing_state')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_billing_state')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'billing_postcode'
				val: if !(var_post_meta.array_get(rt.new_string('_billing_postcode')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_billing_postcode')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'billing_country'
				val: if !(var_post_meta.array_get(rt.new_string('_billing_country')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_billing_country')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'billing_email'
				val: if !(var_post_meta.array_get(rt.new_string('_billing_email')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_billing_email')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'billing_phone'
				val: if !(var_post_meta.array_get(rt.new_string('_billing_phone')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_billing_phone')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'shipping_first_name'
				val: if !(var_post_meta.array_get(rt.new_string('_shipping_first_name')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_shipping_first_name')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'shipping_last_name'
				val: if !(var_post_meta.array_get(rt.new_string('_shipping_last_name')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_shipping_last_name')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'shipping_company'
				val: if !(var_post_meta.array_get(rt.new_string('_shipping_company')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_shipping_company')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'shipping_address_1'
				val: if !(var_post_meta.array_get(rt.new_string('_shipping_address_1')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_shipping_address_1')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'shipping_address_2'
				val: if !(var_post_meta.array_get(rt.new_string('_shipping_address_2')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_shipping_address_2')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'shipping_city'
				val: if !(var_post_meta.array_get(rt.new_string('_shipping_city')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_shipping_city')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'shipping_state'
				val: if !(var_post_meta.array_get(rt.new_string('_shipping_state')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_shipping_state')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'shipping_postcode'
				val: if !(var_post_meta.array_get(rt.new_string('_shipping_postcode')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_shipping_postcode')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'shipping_country'
				val: if !(var_post_meta.array_get(rt.new_string('_shipping_country')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_shipping_country')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'shipping_phone'
				val: if !(var_post_meta.array_get(rt.new_string('_shipping_phone')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_shipping_phone')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'payment_method'
				val: if !(var_post_meta.array_get(rt.new_string('_payment_method')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_payment_method')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'payment_method_title'
				val: if !(var_post_meta.array_get(rt.new_string('_payment_method_title')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_payment_method_title')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'transaction_id'
				val: if !(var_post_meta.array_get(rt.new_string('_transaction_id')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_transaction_id')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'customer_ip_address'
				val: if !(var_post_meta.array_get(rt.new_string('_customer_ip_address')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_customer_ip_address')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'customer_user_agent'
				val: if !(var_post_meta.array_get(rt.new_string('_customer_user_agent')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_customer_user_agent')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'created_via'
				val: if !(var_post_meta.array_get(rt.new_string('_created_via')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_created_via')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{ key: 'date_completed', val: var_date_completed },
			rt.ArrayItem{ key: 'date_paid', val: var_date_paid },
			rt.ArrayItem{
				key: 'cart_hash'
				val: if !(var_post_meta.array_get(rt.new_string('_cart_hash')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_cart_hash')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{ key: 'customer_note', val: rt.get_property(var_post_object,
				'post_excerpt') },
			rt.ArrayItem{
				key: 'order_stock_reduced'
				val: if !(var_post_meta.array_get(rt.new_string('_order_stock_reduced')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_order_stock_reduced')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'download_permissions_granted'
				val: if !(var_post_meta.array_get(rt.new_string('_download_permissions_granted')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_download_permissions_granted')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{
				key: 'new_order_email_sent'
				val: if !(var_post_meta.array_get(rt.new_string('_new_order_email_sent')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_new_order_email_sent')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{ key: 'recorded_sales', val: rt.call_function('wc_string_to_bool', [
				if !(var_post_meta.array_get(rt.new_string('_recorded_sales')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_recorded_sales')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				},
			]) },
			rt.ArrayItem{
				key: 'recorded_coupon_usage_counts'
				val: if !(var_post_meta.array_get(rt.new_string('_recorded_coupon_usage_counts')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_recorded_coupon_usage_counts')).array_get(rt.new_int(0))
				} else {
					rt.new_string('')
				}
			},
		]),
	])
	if rt.is_true(this.cogs_is_enabled())
		&& rt.is_true(rt.call_method(var_order_mutated, 'has_cogs', []rt.PhpVal{})) {
		this.read_cogs_data(var_order_mutated.clone(), var_post_meta.clone())
	}
}

fn (mut this Class_WC_Order_Data_Store_CPT) update(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_mutated, 'get_date_paid', [rt.new_string('edit')])))))
		&& rt.is_true(rt.call_function('version_compare', [rt.call_method(var_order_mutated, 'get_version', [rt.new_string('edit')]), rt.new_string('3.0'), rt.new_string('<')])) {
		mut var_payment_complete_status := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_payment_complete_order_status'),
			if rt.is_true(rt.call_method(var_order_mutated, 'needs_processing', []rt.PhpVal{})) {
				Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			} else {
				Class_Automattic_WooCommerce_Enums_OrderStatus.completed()
			},
			rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
			var_order_mutated.clone(),
		])
		if rt.is_true(rt.call_method(var_order_mutated, 'has_status', [
			var_payment_complete_status.clone()]))
		{
			rt.call_method(var_order_mutated, 'set_date_paid', [
				rt.call_method(var_order_mutated, 'get_date_created', [
					rt.new_string('edit'),
				]),
			])
		}
	}
	mut var_previous_status := rt.call_function('get_post_status', [
		rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_previous_status))))
		&& rt.is_true(rt.identical(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), rt.new_int(0))) {
		var_previous_status = rt.new_string('new')
	}
	this.Class_Abstract_WC_Order_Data_Store_CPT.update(var_order_mutated.clone())
	mut var_current_status := rt.call_method(var_order_mutated, 'get_status', [
		rt.new_string('edit'),
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_0 := iife_temp_0.remove_status_prefix(var_previous_status.clone())
	var_previous_status = iife_result_0
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_1 := iife_temp_1.remove_status_prefix(var_current_status.clone())
	var_current_status = iife_result_1
	mut var_draft_statuses := [rt.new_string('new'),
		Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft(),
		Class_Automattic_WooCommerce_Enums_OrderStatus.draft(),
		rt.new_string('checkout-draft')]
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_status, var_previous_status))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_current_status.clone(), rt.create_array_from_list(var_draft_statuses), rt.new_bool(true)])))))
		&& rt.is_true(rt.call_function('in_array', [var_previous_status.clone(), rt.create_array_from_list(var_draft_statuses), rt.new_bool(true)])) {
		rt.call_function('do_action', [rt.new_string('woocommerce_new_order'),
			rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
			var_order_mutated.clone()])
		return
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_update_order'),
		rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
		var_order_mutated.clone()])
}

fn (mut this Class_WC_Order_Data_Store_CPT) update_post_meta(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_updated_props := []rt.PhpVal{}
	mut var_id := rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})
	mut var_meta_key_to_props := {
		'_order_key':                    'order_key'
		'_customer_user':                'customer_id'
		'_payment_method':               'payment_method'
		'_payment_method_title':         'payment_method_title'
		'_transaction_id':               'transaction_id'
		'_customer_ip_address':          'customer_ip_address'
		'_customer_user_agent':          'customer_user_agent'
		'_created_via':                  'created_via'
		'_date_completed':               'date_completed'
		'_date_paid':                    'date_paid'
		'_cart_hash':                    'cart_hash'
		'_download_permissions_granted': 'download_permissions_granted'
		'_recorded_sales':               'recorded_sales'
		'_recorded_coupon_usage_counts': 'recorded_coupon_usage_counts'
		'_new_order_email_sent':         'new_order_email_sent'
		'_order_stock_reduced':          'order_stock_reduced'
		'_cogs_total_value':             'cogs_total_value'
	}
	mut var_props_to_update := this.get_props_to_update(var_order_mutated.clone(),
		var_meta_key_to_props.clone())
	mut iter_1 := var_props_to_update.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_prop := item_1.val
		mut var_meta_key := item_1.key
		if rt.is_true(rt.identical(rt.new_string('cogs_total_value'), var_prop)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled())))) {
				continue
			}
			mut var_value := rt.call_method(var_order_mutated, 'get_cogs_total_value', [
				rt.new_string('edit'),
			])
			if this.handle_cogs_value_update(var_order_mutated.clone(), var_value.clone(),
				var_id.clone(), var_meta_key.clone(), var_updated_props.clone(), var_prop.clone())
			{
				continue
			}
		} else {
			var_value = rt.call_method(var_order_mutated, 'get_${var_prop.to_string()}', [
				rt.new_string('edit'),
			])
		}
		var_value = if var_value.clone().is_string() { rt.call_function('wp_slash', [
				var_value.clone(),
			]) } else { var_value }
		mut switch_val_1 := var_prop
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_paid')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('date_completed'))) {
			var_value = if !(var_value.clone().is_null()) {
				rt.call_method(var_value, 'getTimestamp', []rt.PhpVal{})
			} else {
				rt.new_string('')
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download_permissions_granted')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('recorded_sales')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('recorded_coupon_usage_counts')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('order_stock_reduced'))) {
			if var_value.clone().is_null() || rt.is_true(rt.identical(rt.new_string(''), var_value)) {
			}
			var_value = if var_value.clone().is_bool() { rt.call_function('wc_bool_to_string', [
					var_value.clone(),
				]) } else { var_value }
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('new_order_email_sent'))) {
			if var_value.clone().is_null() || rt.is_true(rt.identical(rt.new_string(''), var_value)) {
			}
			var_value = if var_value.clone().is_bool() { rt.call_function('wc_bool_to_string', [
					var_value.clone(),
				]) } else { var_value }
			var_value = rt.new_string((if rt.is_true(rt.identical(rt.new_string('yes'), var_value)) {
				'true'
			} else {
				'false'
			}).str())
		}
		if var_value.clone().is_bool()
			&& rt.is_true(rt.call_function('in_array', [var_prop.clone(), rt.call_function('array_values', [this.internal_data_store_key_getters]), rt.new_bool(true)])) {
			var_value = rt.call_function('wc_bool_to_string', [
				var_value.clone()])
		}
		mut var_updated := this.update_or_delete_post_meta(var_order_mutated.clone(),
			var_meta_key.clone(), var_value.clone())
		if rt.is_true(var_updated) {
			var_updated_props << var_prop.clone()
		}
	}
	mut var_address_props := {
		'billing':  {
			'_billing_first_name': rt.new_string('billing_first_name')
			'_billing_last_name':  rt.new_string('billing_last_name')
			'_billing_company':    rt.new_string('billing_company')
			'_billing_address_1':  rt.new_string('billing_address_1')
			'_billing_address_2':  rt.new_string('billing_address_2')
			'_billing_city':       rt.new_string('billing_city')
			'_billing_state':      rt.new_string('billing_state')
			'_billing_postcode':   rt.new_string('billing_postcode')
			'_billing_country':    rt.new_string('billing_country')
			'_billing_email':      rt.new_string('billing_email')
			'_billing_phone':      rt.new_string('billing_phone')
		}
		'shipping': {
			'_shipping_first_name': rt.new_string('shipping_first_name')
			'_shipping_last_name':  rt.new_string('shipping_last_name')
			'_shipping_company':    rt.new_string('shipping_company')
			'_shipping_address_1':  rt.new_string('shipping_address_1')
			'_shipping_address_2':  rt.new_string('shipping_address_2')
			'_shipping_city':       rt.new_string('shipping_city')
			'_shipping_state':      rt.new_string('shipping_state')
			'_shipping_postcode':   rt.new_string('shipping_postcode')
			'_shipping_country':    rt.new_string('shipping_country')
			'_shipping_phone':      rt.new_string('shipping_phone')
		}
	}
	for var_props_key, var_props in var_address_props {
		var_props_to_update = this.get_props_to_update(var_order_mutated.clone(), var_props.clone())
		mut iter_2 := var_props_to_update.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_prop := item_2.val
			mut var_meta_key := item_2.key
			mut var_value := rt.call_method(var_order_mutated, 'get_${var_prop.to_string()}', [
				rt.new_string('edit'),
			])
			var_value = if var_value.clone().is_string() { rt.call_function('wp_slash', [
					var_value.clone(),
				]) } else { var_value }
			mut var_updated := this.update_or_delete_post_meta(var_order_mutated.clone(),
				var_meta_key.clone(), var_value.clone())
			if rt.is_true(var_updated) {
				var_updated_props << var_prop.clone()
				var_updated_props << rt.new_string(props_key)
			}
		}
	}
	this.Class_Abstract_WC_Order_Data_Store_CPT.update_post_meta(var_order_mutated.clone())
	if rt.is_true(rt.call_function('in_array', [rt.new_string('billing'), rt.create_array_from_list(var_updated_props), rt.new_bool(true)]))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('metadata_exists', [rt.new_string('post'), var_id.clone(), rt.new_string('_billing_address_index')]))))) {
		rt.call_function('update_post_meta', [var_id.clone(),
			rt.new_string('_billing_address_index'),
			rt.call_function('implode', [
				rt.new_string(' '),
				rt.call_method(var_order_mutated, 'get_address', [
					rt.new_string('billing'),
				]),
			])])
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('shipping'), rt.create_array_from_list(var_updated_props), rt.new_bool(true)]))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('metadata_exists', [rt.new_string('post'), var_id.clone(), rt.new_string('_shipping_address_index')]))))) {
		rt.call_function('update_post_meta', [var_id.clone(),
			rt.new_string('_shipping_address_index'),
			rt.call_function('implode', [
				rt.new_string(' '),
				rt.call_method(var_order_mutated, 'get_address', [
					rt.new_string('shipping'),
				]),
			])])
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('date_paid'),
		rt.create_array_from_list(var_updated_props), rt.new_bool(true)]))
	{
		mut var_value := rt.call_method(var_order_mutated, 'get_date_paid', [
			rt.new_string('edit'),
		])
		rt.call_function('update_post_meta', [var_id.clone(),
			rt.new_string('_paid_date'), if !(var_value.clone().is_null()) { rt.call_method(var_value, 'date', [
					rt.new_string('Y-m-d H:i:s'),
				]) } else { rt.new_string('') }])
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('date_completed'),
		rt.create_array_from_list(var_updated_props), rt.new_bool(true)]))
	{
		var_value = rt.call_method(var_order_mutated, 'get_date_completed', [
			rt.new_string('edit'),
		])
		rt.call_function('update_post_meta', [var_id.clone(),
			rt.new_string('_completed_date'), if !(var_value.clone().is_null()) { rt.call_method(var_value, 'date', [
					rt.new_string('Y-m-d H:i:s'),
				]) } else { rt.new_string('') }])
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('customer_id'), rt.create_array_from_list(var_updated_props), rt.new_bool(true)]))
		|| rt.is_true(rt.call_function('in_array', [rt.new_string('billing_email'), rt.create_array_from_list(var_updated_props), rt.new_bool(true)])) {
		mut iife_temp_2 := Class_WC_Data_Store{}
		mut iife_result_2 := iife_temp_2.load(rt.new_string('customer-download'))
		mut var_data_store := iife_result_2
		rt.call_method(var_data_store, 'update_user_by_order_id', [
			var_id.clone(), rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{}),
			rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{})])
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('customer_id'),
		rt.create_array_from_list(var_updated_props), rt.new_bool(true)]))
	{
		rt.call_function('wc_update_user_last_active', [
			rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{}),
		])
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_order_object_updated_props'),
		var_order_mutated.clone(),
		rt.create_array_from_list(var_updated_props),
	])
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_post_excerpt(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	return rt.call_method(var_order_mutated, 'get_customer_note', []rt.PhpVal{})
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_order_key(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_order_mutated,
		'get_order_key', []rt.PhpVal{})))))
	{
		return rt.call_method(var_order_mutated, 'get_order_key', []rt.PhpVal{})
	}
	return this.Class_Abstract_WC_Order_Data_Store_CPT.get_order_key(var_order_mutated.clone())
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_total_refunded(var_order rt.PhpVal) f64 {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
	mut var_total := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT SUM( postmeta.meta_value )\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'postmeta')), rt.new_string(' AS postmeta\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
				'posts')),
				rt.new_string(" AS posts ON ( posts.post_type = 'shop_order_refund' AND posts.post_parent = %d )\n\t\t\t\tWHERE postmeta.meta_key = '_refund_amount'\n\t\t\t\tAND postmeta.post_id = posts.ID")),
			rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
		]),
	])
	return var_total.clone().to_f64()
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_order_id_by_order_key(var_order_key rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	if !rt.is_true(var_order_key) {
		return 0
	}
	return (rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT post_id FROM '), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string("postmeta WHERE meta_key = '_order_key' AND meta_value = %s")),
			var_order_key.clone(),
		]),
	])).to_i64()
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_order_count(var_status rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_status_mutated := var_status
	return rt.call_function('absint', [
		rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT COUNT( * ) FROM '), rt.get_property(var_wpdb,
					'posts')),
					rt.new_string(" WHERE post_type = 'shop_order' AND post_status = %s")),
				var_status_mutated.clone(),
			]),
		]),
	])
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_orders(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order_Data_Store_CPT::get_orders'),
		rt.new_string('3.1.0'),
		rt.new_string('Use wc_get_orders instead.'),
	])
	return rt.call_function('wc_get_orders', [var_args_mutated.clone()])
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_orders_generate_customer_meta_query(var_values rt.PhpVal, relation string) rt.PhpVal {
	mut var_values_mutated := var_values
	mut var_meta_query := rt.create_array([
		rt.ArrayItem{ key: 'relation', val: relation.to_upper() },
		rt.ArrayItem{ key: 'customer_emails', val: rt.create_array([
			rt.ArrayItem{ key: 'key', val: '_billing_email' },
			rt.ArrayItem{ key: 'value', val: []rt.PhpVal{} },
			rt.ArrayItem{ key: 'compare', val: 'IN' },
		]) },
		rt.ArrayItem{ key: 'customer_ids', val: rt.create_array([
			rt.ArrayItem{ key: 'key', val: '_customer_user' },
			rt.ArrayItem{ key: 'value', val: []rt.PhpVal{} },
			rt.ArrayItem{ key: 'compare', val: 'IN' },
		]) },
	])
	mut iter_3 := var_values_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			mut var_query_part := this.get_orders_generate_customer_meta_query(var_value.clone(),
				'and')
			if rt.is_true(rt.call_function('is_wp_error', [var_query_part.clone()])) {
				return var_query_part.clone()
			}
			var_meta_query.array_push(var_query_part.clone())
		} else if rt.is_true(rt.call_function('is_email', [var_value.clone()])) {
			var_meta_query.array_get_mut('customer_emails').array_get_mut('value').array_push(rt.call_function('sanitize_email', [
				var_value.clone(),
			]))
		} else if rt.is_true(rt.new_bool(var_value.clone().is_long()
			|| var_value.clone().is_double()))
		{
			var_meta_query.array_get_mut('customer_ids').array_get_mut('value').array_push(rt.call_function('absint', [
				var_value.clone(),
			]).to_string())
		} else {
			return create_wp_error(rt.new_string('woocommerce_query_invalid'), rt.call_function('__', [
				rt.new_string('Invalid customer query.'),
				rt.new_string('woocommerce'),
			]), var_values_mutated.clone())
		}
	}
	if !rt.is_true(var_meta_query.array_get(rt.new_string('customer_emails')).array_get(rt.new_string('value'))) {
		var_meta_query.array_unset(rt.new_string('customer_emails'))
		var_meta_query.array_unset(rt.new_string('relation'))
	}
	if !rt.is_true(var_meta_query.array_get(rt.new_string('customer_ids')).array_get(rt.new_string('value'))) {
		var_meta_query.array_unset(rt.new_string('customer_ids'))
		var_meta_query.array_unset(rt.new_string('relation'))
	}
	return var_meta_query.clone()
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_unpaid_orders(var_date rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_unpaid_orders := rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string((
				rt.concat(rt.concat(rt.new_string('SELECT posts.ID\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(" AS posts\n\t\t\t\tWHERE   posts.post_type   IN ('")) + (rt.call_function('implode', [rt.new_string("','"), rt.call_function('wc_get_order_types', []rt.PhpVal{})])).str() +
				"')\n\t\t\t\tAND     posts.post_status = '" +
				(Class_Automattic_WooCommerce_Enums_OrderInternalStatus.pending()).str() + "'\n\t\t\t\tAND     posts.post_modified < %s").str()),
			rt.call_function('gmdate', [
				rt.new_string('Y-m-d H:i:s'),
				rt.call_function('absint', [var_date.clone()]),
			]),
		]),
	])
	return var_unpaid_orders.clone()
}

fn (mut this Class_WC_Order_Data_Store_CPT) search_orders(var_term rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_search_fields := rt.call_function('array_map', [rt.new_string('wc_clean'),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_shop_order_search_fields'),
			rt.create_array([rt.ArrayItem{ key: none, val: '_billing_address_index' },
				rt.ArrayItem{ key: none, val: '_shipping_address_index' },
				rt.ArrayItem{ key: none, val: '_billing_last_name' },
				rt.ArrayItem{ key: none, val: '_billing_email' },
				rt.ArrayItem{ key: none, val: '_billing_phone' }]),
		])])
	mut var_order_ids := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(var_term.clone().is_long() || var_term.clone().is_double())) {
		var_order_ids.array_push(rt.call_function('absint', [
			var_term.clone()]))
	}
	if !(!rt.is_true(var_search_fields)) {
		var_order_ids = rt.call_function('array_unique', [
			rt.call_function('array_merge', [var_order_ids.clone(),
				rt.call_method(var_wpdb, 'get_col', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.new_string((
							rt.concat(rt.concat(rt.new_string('SELECT DISTINCT p1.post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(" p1 WHERE p1.meta_value LIKE %s AND p1.meta_key IN ('")) + (rt.call_function('implode', [rt.new_string("','"), rt.call_function('array_map', [rt.new_string('esc_sql'), var_search_fields.clone()])])).str() +
							"')").str()),
						rt.new_string('%' +
							(rt.call_method(var_wpdb, 'esc_like', [rt.call_function('wc_clean', [var_term.clone()])])).str() +
							'%'),
					]),
				]),
				rt.call_method(var_wpdb, 'get_col', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('SELECT order_id\n\t\t\t\t\t\t\tFROM '), rt.get_property(var_wpdb,
							'prefix')),
							rt.new_string('woocommerce_order_items as order_items\n\t\t\t\t\t\t\tWHERE order_item_name LIKE %s')),
						rt.new_string('%' +
							(rt.call_method(var_wpdb, 'esc_like', [rt.call_function('wc_clean', [var_term.clone()])])).str() +
							'%'),
					]),
				]),
				rt.call_method(var_wpdb, 'get_col', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT os.order_id FROM '), rt.get_property(var_wpdb,
							'prefix')),
							rt.new_string('wc_order_stats os\n\t\t\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
							'prefix')),
							rt.new_string('wc_customer_lookup cl ON os.customer_id = cl.customer_id\n\t\t\t\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
							'usermeta')),
							rt.new_string(" um ON cl.user_id = um.user_id\n\t\t\t\t\t\t\tWHERE (um.meta_key = 'billing_phone' OR um.meta_key = 'shipping_phone')\n\t\t\t\t\t\t\tAND um.meta_value = %s")),
						rt.call_function('wc_clean', [
							var_term.clone(),
						]),
					]),
				])]),
		])
	}
	var_order_ids = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shop_order_search_results'),
		var_order_ids.clone(),
		var_term.clone(),
		var_search_fields.clone(),
	])
	return rt.call_function('array_map', [rt.new_string('absint'),
		var_order_ids.clone()])
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_download_permissions_granted(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut iife_temp_3 := Class_WC_Order_Factory{}
	mut iife_result_3 := iife_temp_3.get_order_id(var_order_mutated.clone())
	mut var_order_id := iife_result_3
	return rt.call_function('wc_string_to_bool', [
		rt.call_function('get_post_meta', [var_order_id.clone(),
			rt.new_string('_download_permissions_granted'), rt.new_bool(true)]),
	])
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_download_permissions_granted(var_order rt.PhpVal, var_set rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated, 'WC_Order'))) {
		rt.call_method(var_order_mutated, 'set_download_permissions_granted', [
			var_set.clone(),
		])
	}
	mut iife_temp_4 := Class_WC_Order_Factory{}
	mut iife_result_4 := iife_temp_4.get_order_id(var_order_mutated.clone())
	mut var_order_id := iife_result_4
	rt.call_function('update_post_meta', [var_order_id.clone(),
		rt.new_string('_download_permissions_granted'),
		rt.call_function('wc_bool_to_string', [
			var_set.clone(),
		])])
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_recorded_sales(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut iife_temp_5 := Class_WC_Order_Factory{}
	mut iife_result_5 := iife_temp_5.get_order_id(var_order_mutated.clone())
	mut var_order_id := iife_result_5
	return rt.call_function('wc_string_to_bool', [
		rt.call_function('get_post_meta', [var_order_id.clone(),
			rt.new_string('_recorded_sales'), rt.new_bool(true)]),
	])
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_recorded_sales(var_order rt.PhpVal, var_set rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated, 'WC_Order'))) {
		rt.call_method(var_order_mutated, 'set_recorded_sales', [
			var_set.clone()])
	}
	mut iife_temp_6 := Class_WC_Order_Factory{}
	mut iife_result_6 := iife_temp_6.get_order_id(var_order_mutated.clone())
	mut var_order_id := iife_result_6
	rt.call_function('update_post_meta', [var_order_id.clone(),
		rt.new_string('_recorded_sales'), rt.call_function('wc_bool_to_string', [
			var_set.clone(),
		])])
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_recorded_coupon_usage_counts(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut iife_temp_7 := Class_WC_Order_Factory{}
	mut iife_result_7 := iife_temp_7.get_order_id(var_order_mutated.clone())
	mut var_order_id := iife_result_7
	return rt.call_function('wc_string_to_bool', [
		rt.call_function('get_post_meta', [var_order_id.clone(),
			rt.new_string('_recorded_coupon_usage_counts'), rt.new_bool(true)]),
	])
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_recorded_coupon_usage_counts(var_order rt.PhpVal, var_set rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated, 'WC_Order'))) {
		rt.call_method(var_order_mutated, 'set_recorded_coupon_usage_counts', [
			var_set.clone(),
		])
	}
	mut iife_temp_8 := Class_WC_Order_Factory{}
	mut iife_result_8 := iife_temp_8.get_order_id(var_order_mutated.clone())
	mut var_order_id := iife_result_8
	rt.call_function('update_post_meta', [var_order_id.clone(),
		rt.new_string('_recorded_coupon_usage_counts'),
		rt.call_function('wc_bool_to_string', [
			var_set.clone(),
		])])
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_email_sent(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut iife_temp_9 := Class_WC_Order_Factory{}
	mut iife_result_9 := iife_temp_9.get_order_id(var_order_mutated.clone())
	mut var_order_id := iife_result_9
	return rt.call_function('wc_string_to_bool', [
		rt.call_function('get_post_meta', [var_order_id.clone(),
			rt.new_string('_new_order_email_sent'), rt.new_bool(true)]),
	])
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_new_order_email_sent(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	return this.get_email_sent(var_order_mutated.clone())
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_email_sent(var_order rt.PhpVal, var_set rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated, 'WC_Order'))) {
		rt.call_method(var_order_mutated, 'set_new_order_email_sent', [
			var_set.clone()])
	}
	mut iife_temp_10 := Class_WC_Order_Factory{}
	mut iife_result_10 := iife_temp_10.get_order_id(var_order_mutated.clone())
	mut var_order_id := iife_result_10
	mut var_value := rt.call_function('wc_bool_to_string', [var_set.clone()])
	var_value = rt.new_string((if rt.is_true(rt.identical(rt.new_string('yes'), var_value)) {
		'true'
	} else {
		'false'
	}).str())
	rt.call_function('update_post_meta', [var_order_id.clone(),
		rt.new_string('_new_order_email_sent'), var_value.clone()])
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_new_order_email_sent(var_order rt.PhpVal, var_set rt.PhpVal) {
	mut var_order_mutated := var_order
	this.set_email_sent(var_order_mutated.clone(), var_set.clone())
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_coupon_held_keys(var_order rt.PhpVal, var_coupon_id rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_held_keys := rt.call_method(var_order_mutated, 'get_meta', [
		rt.new_string('_coupon_held_keys'),
	])
	if rt.is_true(var_coupon_id) {
		return if var_held_keys.array_isset(var_coupon_id) {
			var_held_keys.array_get(var_coupon_id)
		} else {
			rt.new_null()
		}
	}
	return var_held_keys.clone()
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_coupon_held_keys_for_users(var_order rt.PhpVal, var_coupon_id rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_held_keys_for_user := rt.call_method(var_order_mutated, 'get_meta', [
		rt.new_string('_coupon_held_keys_for_users'),
	])
	if rt.is_true(var_coupon_id) {
		return if var_held_keys_for_user.array_isset(var_coupon_id) {
			var_held_keys_for_user.array_get(var_coupon_id)
		} else {
			rt.new_null()
		}
	}
	return var_held_keys_for_user.clone()
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_coupon_held_keys(var_order rt.PhpVal, var_held_keys rt.PhpVal, var_held_keys_for_user rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_held_keys_mutated := var_held_keys
	mut var_held_keys_for_user_mutated := var_held_keys_for_user
	if var_held_keys_mutated.clone().is_array() && 0 < var_held_keys_mutated.clone().array_count() {
		rt.call_method(var_order_mutated, 'update_meta_data', [
			rt.new_string('_coupon_held_keys'),
			var_held_keys_mutated.clone(),
		])
	}
	if var_held_keys_for_user_mutated.clone().is_array()
		&& 0 < var_held_keys_for_user_mutated.clone().array_count() {
		rt.call_method(var_order_mutated, 'update_meta_data', [
			rt.new_string('_coupon_held_keys_for_users'),
			var_held_keys_for_user_mutated.clone(),
		])
	}
}

fn (mut this Class_WC_Order_Data_Store_CPT) release_held_coupons(var_order rt.PhpVal, save bool) {
	mut var_order_mutated := var_order
	mut var_coupon_held_keys := this.get_coupon_held_keys(var_order_mutated.clone(), rt.new_null())
	if rt.is_true(rt.new_bool(var_coupon_held_keys.clone().is_array())) {
		mut iter_4 := var_coupon_held_keys.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_meta_key := item_4.val
			mut var_coupon_id := item_4.key
			rt.call_function('delete_post_meta', [var_coupon_id.clone(),
				var_meta_key.clone()])
		}
	}
	rt.call_method(var_order_mutated, 'delete_meta_data', [
		rt.new_string('_coupon_held_keys'),
	])
	mut var_coupon_held_keys_for_users := this.get_coupon_held_keys_for_users(var_order_mutated.clone(),
		rt.new_null())
	if rt.is_true(rt.new_bool(var_coupon_held_keys_for_users.clone().is_array())) {
		mut iter_5 := var_coupon_held_keys_for_users.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_meta_key := item_5.val
			mut var_coupon_id := item_5.key
			rt.call_function('delete_post_meta', [var_coupon_id.clone(),
				var_meta_key.clone()])
		}
	}
	rt.call_method(var_order_mutated, 'delete_meta_data', [
		rt.new_string('_coupon_held_keys_for_users'),
	])
	if var_save {
		rt.call_method(var_order_mutated, 'save_meta_data', []rt.PhpVal{})
	}
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_stock_reduced(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut iife_temp_11 := Class_WC_Order_Factory{}
	mut iife_result_11 := iife_temp_11.get_order_id(var_order_mutated.clone())
	mut var_order_id := iife_result_11
	return rt.call_function('wc_string_to_bool', [
		rt.call_function('get_post_meta', [var_order_id.clone(),
			rt.new_string('_order_stock_reduced'), rt.new_bool(true)]),
	])
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_order_stock_reduced(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	return this.get_stock_reduced(var_order_mutated.clone())
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_stock_reduced(var_order rt.PhpVal, var_set rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated, 'WC_Order'))) {
		rt.call_method(var_order_mutated, 'set_order_stock_reduced', [
			var_set.clone()])
	}
	mut iife_temp_12 := Class_WC_Order_Factory{}
	mut iife_result_12 := iife_temp_12.get_order_id(var_order_mutated.clone())
	mut var_order_id := iife_result_12
	rt.call_function('update_post_meta', [var_order_id.clone(),
		rt.new_string('_order_stock_reduced'), rt.call_function('wc_bool_to_string', [
			var_set.clone(),
		])])
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_order_stock_reduced(var_order rt.PhpVal, var_set rt.PhpVal) {
	mut var_order_mutated := var_order
	this.set_stock_reduced(var_order_mutated.clone(), var_set.clone())
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_order_type(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	return rt.call_function('get_post_type', [var_order_mutated.clone()])
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_wp_query_args(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
	mut var_key_mapping := {
		'customer_id':    'customer_user'
		'status':         'post_status'
		'currency':       'order_currency'
		'version':        'order_version'
		'discount_total': 'cart_discount'
		'discount_tax':   'cart_discount_tax'
		'shipping_total': 'order_shipping'
		'shipping_tax':   'order_shipping_tax'
		'cart_tax':       'order_tax'
		'page':           'paged'
	}
	for var_query_key, var_db_key in var_key_mapping {
		if var_query_vars_mutated.array_isset(rt.new_string(query_key)) {
			var_query_vars_mutated.array_set(db_key,
				var_query_vars_mutated.array_get(rt.new_string(query_key)))
			var_query_vars_mutated.array_unset(rt.new_string(query_key))
		}
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('post_status')))) {
		if rt.is_true(rt.new_bool(var_query_vars_mutated.array_get(rt.new_string('post_status')).is_array())) {
			mut iter_6 := var_query_vars_mutated.array_get(rt.new_string('post_status')).iterator()
			for {
				item_6 := iter_6.next() or { break }
				mut var_status := item_6.val
				var_status = if rt.is_true(rt.call_function('wc_is_order_status', [
					rt.new_string('wc-' + var_status.str()),
				]))
				{ 'wc-' + var_status.str() } else { var_status }
			}
		} else {
			var_query_vars_mutated.array_set('post_status', if rt.is_true(rt.call_function('wc_is_order_status', [
				rt.new_string('wc-' +
					(var_query_vars_mutated.array_get(rt.new_string('post_status'))).str()),
			]))
			{
				'wc-' + (var_query_vars_mutated.array_get(rt.new_string('post_status'))).str()
			} else {
				var_query_vars_mutated.array_get(rt.new_string('post_status'))
			})
		}
	}
	mut var_wp_query_args :=
		this.Class_Abstract_WC_Order_Data_Store_CPT.get_wp_query_args(var_query_vars_mutated.clone())
	if !(var_wp_query_args.array_isset(rt.new_string('date_query'))) {
		var_wp_query_args.array_set('date_query', []rt.PhpVal{})
	}
	if !(var_wp_query_args.array_isset(rt.new_string('meta_query'))) {
		var_wp_query_args.array_set('meta_query', []rt.PhpVal{})
	}
	if !rt.is_true(var_wp_query_args.array_get(rt.new_string('orderby'))) {
		var_wp_query_args.array_set('orderby', 'ID')
	}
	if !rt.is_true(var_wp_query_args.array_get(rt.new_string('order'))) {
		var_wp_query_args.array_set('order', 'desc')
	}
	mut var_date_queries := {
		'date_created':   'post_date'
		'date_modified':  'post_modified'
		'date_completed': '_date_completed'
		'date_paid':      '_date_paid'
	}
	for var_query_var_key, var_db_key in var_date_queries {
		if var_query_vars_mutated.array_isset(rt.new_string(query_var_key))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars_mutated.array_get(rt.new_string(query_var_key)))))) {
			mut var_existing_queries := rt.call_function('wp_list_pluck', [
				var_wp_query_args.array_get(rt.new_string('meta_query')),
				rt.new_string('key'),
				rt.new_bool(true),
			])
			mut var_meta_query_index := rt.call_function('array_search', [
				rt.new_string(db_key),
				var_existing_queries.clone(),
				rt.new_bool(true),
			])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
				var_meta_query_index))))
			{
				var_wp_query_args.array_get(rt.new_string('meta_query')).array_unset(var_meta_query_index)
			}
			var_wp_query_args = this.parse_date_for_wp_query(var_query_vars_mutated.array_get(rt.new_string(query_var_key)),
				rt.new_string(db_key), var_wp_query_args.clone())
		}
	}
	if var_query_vars_mutated.array_isset(rt.new_string('customer'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars_mutated.array_get(rt.new_string('customer'))))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical([]rt.PhpVal{}, var_query_vars_mutated.array_get(rt.new_string('customer')))))) {
		mut var_values := if var_query_vars_mutated.array_get(rt.new_string('customer')).is_array() { var_query_vars_mutated.array_get(rt.new_string('customer')) } else { rt.create_array([
				rt.ArrayItem{
					key: none
					val: var_query_vars_mutated.array_get(rt.new_string('customer'))
				},
			]) }
		mut var_customer_query :=
			this.get_orders_generate_customer_meta_query(var_values.clone(), '')
		if rt.is_true(rt.call_function('is_wp_error', [var_customer_query.clone()])) {
			var_wp_query_args.array_get_mut('errors').array_push(var_customer_query.clone())
		} else {
			var_wp_query_args.array_get_mut('meta_query').array_push(var_customer_query.clone())
		}
	}
	if var_query_vars_mutated.array_isset(rt.new_string('anonymized')) {
		if rt.is_true(var_query_vars_mutated.array_get(rt.new_string('anonymized'))) {
			var_wp_query_args.array_get_mut('meta_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'key', val: '_anonymized' },
				rt.ArrayItem{ key: 'value', val: 'yes' },
			]))
		} else {
			var_wp_query_args.array_get_mut('meta_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'key', val: '_anonymized' },
				rt.ArrayItem{ key: 'compare', val: 'NOT EXISTS' },
			]))
		}
	}
	if var_query_vars_mutated.array_isset(rt.new_string('total')) {
		mut var_total_param := var_query_vars_mutated.array_get(rt.new_string('total'))
		var_query_vars_mutated.array_unset(rt.new_string('total'))
		if rt.is_true(rt.new_bool(var_total_param.clone().is_long()
			|| var_total_param.clone().is_double()))
		{
			var_total_param = rt.create_array([
				rt.ArrayItem{ key: 'value', val: var_total_param },
				rt.ArrayItem{ key: 'operator', val: '=' },
			])
		}
		mut var_total_query :=
			this.generate_total_query(mut rt.cast_object_ptr[Class_array](rt.cast_array(var_total_param)))
		if rt.is_true(var_total_query) {
			var_wp_query_args.array_get_mut('meta_query').array_push(var_total_query.clone())
		}
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('fulfillment_status')))) {
		mut iife_temp_13 :=
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}
		mut iife_result_13 :=
			iife_temp_13.get_order_fulfillment_status_meta_query(var_query_vars_mutated.array_get(rt.new_string('fulfillment_status')))
		mut var_meta_query := iife_result_13
		if !(!rt.is_true(var_meta_query)) {
			var_wp_query_args.array_get_mut('meta_query').array_push(var_meta_query.clone())
		}
	}
	if rt.is_true(rt.identical(rt.new_string('total'),
		var_wp_query_args.array_get(rt.new_string('orderby'))))
	{
		var_wp_query_args.array_set('orderby', 'meta_value_num')
		var_wp_query_args.array_set('meta_key', '_order_total')
		var_wp_query_args.array_set('meta_type', 'DECIMAL(10,' +
			(rt.call_function('wc_get_price_decimals', []rt.PhpVal{})).str() + ')')
	}
	if !(var_query_vars_mutated.array_isset(rt.new_string('paginate')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars_mutated.array_get(rt.new_string('paginate')))))) {
		var_wp_query_args.array_set('no_found_rows', true)
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_order_data_store_cpt_get_orders_query'),
		var_wp_query_args.clone(),
		var_query_vars_mutated.clone(),
		rt.new_object('WC_Order_Data_Store_CPT', ['Abstract_WC_Order_Data_Store_CPT',
			'WC_Object_Data_Store_Interface', 'WC_Order_Data_Store_Interface'], &this),
	])
}

fn (mut this Class_WC_Order_Data_Store_CPT) query(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
	mut var_unsupported_args := rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_order_data_store_cpt_query_unsupported_args'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'meta_query' },
			rt.ArrayItem{ key: none, val: 'field_query' }]),
	]))
	mut var_unsupported_args_in_query := rt.func_array_keys(rt.call_function('array_filter', [
		rt.call_function('array_intersect_key', [var_query_vars_mutated.clone(),
			rt.call_function('array_flip', [var_unsupported_args.clone()])]),
	]))
	if rt.is_true(var_unsupported_args_in_query)
		&& rt.is_true(rt.identical(rt.new_string(@STRUCT), rt.call_function('get_class', [rt.new_object('WC_Order_Data_Store_CPT', ['Abstract_WC_Order_Data_Store_CPT', 'WC_Object_Data_Store_Interface', 'WC_Order_Data_Store_Interface'], &this)]))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('Order query argument (%s) is not supported on the current order datastore.'),
						rt.new_string('Order query arguments (%s) are not supported on the current order datastore.'),
						rt.new_int(var_unsupported_args_in_query.clone().array_count()),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('implode', [
						rt.new_string(', '),
						var_unsupported_args_in_query.clone(),
					]),
				]),
			]),
			rt.new_string('9.2.0')])
	}
	mut var_args := this.get_wp_query_args(var_query_vars_mutated.clone())
	if !(!rt.is_true(var_args.array_get(rt.new_string('errors')))) {
		mut var_query := rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'posts', val: []rt.PhpVal{} },
			rt.ArrayItem{ key: 'found_posts', val: 0 },
			rt.ArrayItem{ key: 'max_num_pages', val: 0 },
		]))
	} else {
		var_query = create_wp_query(var_args.clone())
	}
	if var_query_vars_mutated.array_isset(rt.new_string('return'))
		&& rt.is_true(rt.identical(rt.new_string('ids'), var_query_vars_mutated.array_get(rt.new_string('return')))) {
		mut var_orders := rt.get_property(var_query, 'posts')
	} else {
		rt.call_function('update_post_caches', [rt.get_property(var_query, 'posts')])
		mut var_order_ids := rt.call_function('wp_list_pluck', [
			rt.get_property(var_query, 'posts'),
			rt.new_string('ID'),
		])
		var_orders = this.compile_orders(var_order_ids.clone(), var_query_vars_mutated.clone(),
			var_query.clone())
	}
	if var_query_vars_mutated.array_isset(rt.new_string('paginate'))
		&& rt.is_true(var_query_vars_mutated.array_get(rt.new_string('paginate'))) {
		return rt.new_object('stdClass', []string{}, rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'orders', val: var_orders },
			rt.ArrayItem{ key: 'total', val: rt.get_property(var_query, 'found_posts') },
			rt.ArrayItem{ key: 'max_num_pages', val: rt.get_property(var_query, 'max_num_pages') },
		])))
	}
	return var_orders.clone()
}

fn (mut this Class_WC_Order_Data_Store_CPT) compile_orders(var_order_ids rt.PhpVal, var_query_vars rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	mut var_order_ids_mutated := var_order_ids
	mut var_query_vars_mutated := var_query_vars
	mut var_query_mutated := var_query
	if !rt.is_true(var_order_ids_mutated) {
		return []rt.PhpVal{}
	}
	mut var_orders := []rt.PhpVal{}
	this.prime_caches_for_orders(var_order_ids_mutated.clone(), var_query_vars_mutated.clone())
	mut iter_7 := rt.get_property(var_query_mutated, 'posts').iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_post := item_7.val
		mut var_order := rt.call_function('wc_get_order', [var_post.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_order)) {
			continue
		}
		var_orders.array_push(var_order.clone())
	}
	return var_orders.clone()
}

fn (mut this Class_WC_Order_Data_Store_CPT) prime_caches_for_orders(var_order_ids rt.PhpVal, var_query_vars rt.PhpVal) {
	mut var_order_ids_mutated := var_order_ids
	mut var_query_vars_mutated := var_query_vars
	this.prime_raw_meta_cache_for_orders(var_order_ids_mutated.clone(),
		var_query_vars_mutated.clone())
	this.prime_order_item_caches_for_orders(var_order_ids_mutated.clone(),
		var_query_vars_mutated.clone())
	mut var_order_type := if !(var_query_vars_mutated.array_get(rt.new_string('type'))).is_null() {
		var_query_vars_mutated.array_get(rt.new_string('type'))
	} else {
		if !(var_query_vars_mutated.array_get(rt.new_string('post_type'))).is_null() {
			var_query_vars_mutated.array_get(rt.new_string('post_type'))
		} else {
			rt.new_string('')
		}
	}
	var_order_type = if var_order_type.clone().is_array() { var_order_type } else { rt.create_array([
			rt.ArrayItem{ key: none, val: var_order_type },
		]) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string('shop_order'),
		var_order_type.clone(),
		rt.new_bool(true),
	])))))
	{
		return
	}
	this.prime_refund_caches_for_orders(var_order_ids_mutated.clone(),
		var_query_vars_mutated.clone())
	this.prime_refund_total_caches_for_orders(var_order_ids_mutated.clone(),
		var_query_vars_mutated.clone())
}

fn (mut this Class_WC_Order_Data_Store_CPT) prime_raw_meta_cache_for_orders(var_order_ids rt.PhpVal, var_query_vars rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
	mut var_query_vars_mutated := var_query_vars
	if var_query_vars_mutated.array_isset(rt.new_string('fields'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_query_vars_mutated.array_get(rt.new_string('fields')))))) {
		if var_query_vars_mutated.array_get(rt.new_string('fields')).is_array()
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('meta_data'), var_query_vars_mutated.array_get(rt.new_string('fields')), rt.new_bool(true)]))))) {
			return
		}
	}
	mut var_cache_keys_mapping := []rt.PhpVal{}
	mut iter_8 := var_order_ids_mutated.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_order_id := item_8.val
		mut iife_temp_14 := Class_WC_Order{}
		mut iife_result_14 := iife_temp_14.generate_meta_cache_key(var_order_id.clone(),
			rt.new_string('orders'))
		var_cache_keys_mapping.array_set(var_order_id, iife_result_14)
	}
	mut var_cache_values := rt.call_function('wc_cache_get_multiple', [
		rt.call_function('array_values', [var_cache_keys_mapping.clone()]),
		rt.new_string('orders'),
	])
	mut var_non_cached_ids := []rt.PhpVal{}
	mut iter_9 := var_order_ids_mutated.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_order_id := item_9.val
		if rt.is_true(rt.identical(rt.new_bool(false),
			var_cache_values.array_get(var_cache_keys_mapping.array_get(var_order_id))))
		{
			var_non_cached_ids << var_order_id.clone()
		}
	}
	if !rt.is_true(var_non_cached_ids) {
		return
	}
	var_order_ids_mutated = rt.call_function('esc_sql', [
		rt.create_array_from_list(var_non_cached_ids),
	])
	mut var_order_ids_in := rt.new_string("'" +
		(rt.call_function('implode', [rt.new_string("', '"), var_order_ids_mutated.clone()])).str() +
		"'")
	mut var_raw_meta_data_array := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT post_id as object_id, meta_id, meta_key, meta_value\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
			'postmeta')), rt.new_string('\n\t\t\t\tWHERE post_id IN ( ')), var_order_ids_in),
			rt.new_string(' )\n\t\t\t\tORDER BY post_id')),
	])
	mut var_raw_meta_data_collection := []rt.PhpVal{}
	mut iter_10 := var_raw_meta_data_array.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_raw_meta_data := item_10.val
		if !(var_raw_meta_data_collection.array_isset(rt.get_property(var_raw_meta_data,
			'object_id'))) {
			var_raw_meta_data_collection.array_set(rt.get_property(var_raw_meta_data, 'object_id'),
				[]rt.PhpVal{})
		}
		var_raw_meta_data_collection.array_get_mut(rt.get_property(var_raw_meta_data, 'object_id')).array_push(var_raw_meta_data.clone())
	}
	mut iife_temp_15 := Class_WC_Order{}
	mut iife_result_15 := iife_temp_15.prime_raw_meta_data_cache(var_raw_meta_data_collection.clone(),
		rt.new_string('orders'))
}

fn (mut this Class_WC_Order_Data_Store_CPT) untrash_order(mut var_order Class_WC_Order) bool {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_untrash_post', [
		rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
	])))))
	{
		return false
	}
	rt.call_method(var_order_mutated, 'set_status', [
		rt.call_function('get_post_field', [rt.new_string('post_status'),
			rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})]),
	])
	return (rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Order_Data_Store_CPT) generate_total_query(mut var_total_params Class_array) rt.PhpVal {
	if !(var_total_params.array_isset(rt.new_string('value'))) {
		return rt.new_bool(false)
	}
	mut var_operator := if !(var_total_params.array_get(rt.new_string('operator'))).is_null() {
		var_total_params.array_get(rt.new_string('operator'))
	} else {
		rt.new_string('=')
	}
	mut var_value := var_total_params.array_get(rt.new_string('value'))
	mut var_supported_operators := ['=', '!=', '>', '>=', '<', '<=', 'BETWEEN', 'NOT BETWEEN']
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_operator.clone(), rt.create_array_from_list(var_supported_operators),
		rt.new_bool(true)])))))
	{
		return rt.new_bool(false)
	}
	if rt.is_true(rt.identical(rt.new_string('BETWEEN'), var_operator))
		|| rt.is_true(rt.identical(rt.new_string('NOT BETWEEN'), var_operator)) {
		if !(var_value.clone().is_array())
			|| rt.is_true(rt.new_bool(var_value.clone().array_count() != 2)) {
			return rt.new_bool(false)
		}
		mut var_value1 := rt.call_function('wc_format_decimal', [
			var_value.array_get(rt.new_int(0)),
			rt.call_function('wc_get_price_decimals', []rt.PhpVal{}),
		])
		mut var_value2 := rt.call_function('wc_format_decimal', [
			var_value.array_get(rt.new_int(1)),
			rt.call_function('wc_get_price_decimals', []rt.PhpVal{}),
		])
		if rt.is_true(rt.identical(rt.new_string('BETWEEN'), var_operator)) {
			return rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'key', val: '_order_total' },
					rt.ArrayItem{ key: 'value', val: rt.create_array([
						rt.ArrayItem{ key: none, val: var_value1 },
						rt.ArrayItem{ key: none, val: var_value2 },
					]) },
					rt.ArrayItem{ key: 'compare', val: 'BETWEEN' },
					rt.ArrayItem{ key: 'type', val: 'DECIMAL(10,' +
						(rt.call_function('wc_get_price_decimals', []rt.PhpVal{})).str() + ')' },
				]) },
			])
		} else {
			return rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'key', val: '_order_total' },
					rt.ArrayItem{ key: 'value', val: rt.create_array([
						rt.ArrayItem{ key: none, val: var_value1 },
						rt.ArrayItem{ key: none, val: var_value2 },
					]) },
					rt.ArrayItem{ key: 'compare', val: 'NOT BETWEEN' },
					rt.ArrayItem{ key: 'type', val: 'DECIMAL(10,' +
						(rt.call_function('wc_get_price_decimals', []rt.PhpVal{})).str() + ')' },
				]) },
			])
		}
	}
	if !(var_value.clone().is_long() || var_value.clone().is_double()) {
		return rt.new_bool(false)
	}
	return rt.create_array([rt.ArrayItem{ key: 'key', val: '_order_total' },
		rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_decimal', [
			var_value.clone(),
			rt.call_function('wc_get_price_decimals', []rt.PhpVal{}),
		]) }, rt.ArrayItem{ key: 'compare', val: var_operator },
		rt.ArrayItem{
			key: 'type'
			val: if rt.is_true(rt.identical(rt.new_string('='), var_operator)) {
				'CHAR'
			} else {
				'DECIMAL(10,' + (rt.call_function('wc_get_price_decimals', []rt.PhpVal{})).str() +
					')'
			}
		}])
}

fn (mut this Class_WC_Order_Data_Store_CPT) update_order_meta_from_object(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	this.Class_Abstract_WC_Order_Data_Store_CPT.update_order_meta_from_object(var_order_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled()))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_mutated, 'has_cogs', []rt.PhpVal{}))))) {
		return
	}
	mut var_cogs_value := rt.call_method(var_order_mutated, 'get_cogs_total_value', [
		rt.new_string('edit'),
	])
	var_cogs_value = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_save_order_cogs_value'),
		var_cogs_value.clone(),
		var_order_mutated.clone(),
	])
	if !(var_cogs_value.clone().is_null()) {
		if 0 == rt.new_float(var_cogs_value.to_f64()) {
			rt.call_function('delete_post_meta', [
				rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
				rt.new_string('_cogs_total_value'),
			])
		} else {
			rt.call_function('update_post_meta', [
				rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
				rt.new_string('_cogs_total_value'),
				var_cogs_value.clone(),
			])
		}
	}
}

fn (mut this Class_WC_Order_Data_Store_CPT) read_cogs_data(var_order rt.PhpVal, var_post_meta rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_post_meta_mutated := var_post_meta
	mut var_cogs_value := if var_post_meta_mutated.array_get(rt.new_string('_cogs_total_value')).array_isset(rt.new_int(0)) {
		rt.new_float((var_post_meta_mutated.array_get(rt.new_string('_cogs_total_value')).array_get(rt.new_int(0))).to_f64())
	} else {
		rt.new_int(0)
	}
	var_cogs_value = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_load_order_cogs_value'),
		var_cogs_value.clone(),
		var_order_mutated.clone(),
	])
	rt.call_method(var_order_mutated, 'set_cogs_total_value', [
		rt.new_float(var_cogs_value.to_f64()),
	])
	rt.call_method(var_order_mutated, 'apply_changes', []rt.PhpVal{})
}

fn (mut this Class_WC_Order_Data_Store_CPT) handle_cogs_value_update(var_order rt.PhpVal, var_value rt.PhpVal, var_order_id rt.PhpVal, var_meta_key rt.PhpVal, var_updated_props rt.PhpVal, var_prop rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_value_mutated := var_value
	mut var_order_id_mutated := var_order_id
	mut var_updated_props_mutated := var_updated_props
	if rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled()))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_mutated, 'has_cogs', []rt.PhpVal{}))))) {
		return true
	}
	var_value_mutated = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_save_order_cogs_value'),
		var_value_mutated.clone(),
		var_order_mutated.clone(),
	])
	if rt.is_true(rt.new_bool(var_value_mutated.clone().is_null())) {
		return true
	}
	if 0 == rt.new_float(var_value_mutated.to_f64()) {
		rt.call_function('delete_post_meta', [var_order_id_mutated.clone(),
			var_meta_key.clone()])
		var_updated_props_mutated.array_push(var_prop.clone())
		return true
	}
	return false
}

struct Class_Abstract_WC_Order_Data_Store_CPT {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Order_Factory {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WC_Order {
	rt.PhpObjectBase
}

fn create_wc_order_data_store_cpt(_args ...rt.PhpVal) &Class_WC_Order_Data_Store_CPT {
	mut obj := &Class_WC_Order_Data_Store_CPT{
		PhpObjectBase:                   rt.PhpObjectBase{}
		internal_meta_keys:              rt.new_array()
		internal_data_store_key_getters: rt.new_array()
	}
	return obj
}

fn create_abstract_wc_order_data_store_cpt(_args ...rt.PhpVal) &Class_Abstract_WC_Order_Data_Store_CPT {
	mut obj := &Class_Abstract_WC_Order_Data_Store_CPT{
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

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
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

fn create_wc_order_factory(_args ...rt.PhpVal) &Class_WC_Order_Factory {
	mut obj := &Class_WC_Order_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order(_args ...rt.PhpVal) &Class_WC_Order {
	mut obj := &Class_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create(dispatch_arg_0)
			return rt.new_null()
		}
		'read_order_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.read_order_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update(dispatch_arg_0)
			return rt.new_null()
		}
		'update_post_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_post_meta(dispatch_arg_0)
			return rt.new_null()
		}
		'get_post_excerpt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_post_excerpt(dispatch_arg_0)
		}
		'get_order_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_key(dispatch_arg_0)
		}
		'get_total_refunded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_float(this.get_total_refunded(dispatch_arg_0))
		}
		'get_order_id_by_order_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get_order_id_by_order_key(dispatch_arg_0))
		}
		'get_order_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_count(dispatch_arg_0)
		}
		'get_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_orders(dispatch_arg_0)
		}
		'get_orders_generate_customer_meta_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_orders_generate_customer_meta_query(dispatch_arg_0, dispatch_arg_1)
		}
		'get_unpaid_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_unpaid_orders(dispatch_arg_0)
		}
		'search_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.search_orders(dispatch_arg_0)
		}
		'get_download_permissions_granted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_download_permissions_granted(dispatch_arg_0)
		}
		'set_download_permissions_granted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_download_permissions_granted(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_recorded_sales' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_recorded_sales(dispatch_arg_0)
		}
		'set_recorded_sales' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_recorded_sales(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_recorded_coupon_usage_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_recorded_coupon_usage_counts(dispatch_arg_0)
		}
		'set_recorded_coupon_usage_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_recorded_coupon_usage_counts(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_email_sent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_email_sent(dispatch_arg_0)
		}
		'get_new_order_email_sent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_new_order_email_sent(dispatch_arg_0)
		}
		'set_email_sent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_email_sent(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_new_order_email_sent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_new_order_email_sent(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_coupon_held_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_coupon_held_keys(dispatch_arg_0, dispatch_arg_1)
		}
		'get_coupon_held_keys_for_users' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_coupon_held_keys_for_users(dispatch_arg_0, dispatch_arg_1)
		}
		'set_coupon_held_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.set_coupon_held_keys(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'release_held_coupons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.release_held_coupons(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_stock_reduced' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_stock_reduced(dispatch_arg_0)
		}
		'get_order_stock_reduced' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_stock_reduced(dispatch_arg_0)
		}
		'set_stock_reduced' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_stock_reduced(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_order_stock_reduced' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_order_stock_reduced(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_order_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_type(dispatch_arg_0)
		}
		'get_wp_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_wp_query_args(dispatch_arg_0)
		}
		'query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.query(dispatch_arg_0)
		}
		'compile_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.compile_orders(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prime_caches_for_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.prime_caches_for_orders(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'prime_raw_meta_cache_for_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.prime_raw_meta_cache_for_orders(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'untrash_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.untrash_order(mut dispatch_arg_0))
		}
		'generate_total_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.generate_total_query(mut dispatch_arg_0)
		}
		'update_order_meta_from_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_order_meta_from_object(dispatch_arg_0)
			return rt.new_null()
		}
		'read_cogs_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.read_cogs_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_cogs_value_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			return rt.new_bool(this.handle_cogs_value_update(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Order_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'internal_meta_keys' { return this.internal_meta_keys }
		'internal_data_store_key_getters' { return this.internal_data_store_key_getters }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Order_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'internal_meta_keys' {
			this.internal_meta_keys = val
			return true
		}
		'internal_data_store_key_getters' {
			this.internal_data_store_key_getters = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Abstract_WC_Order_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Order_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
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
