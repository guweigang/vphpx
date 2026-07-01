import rt

struct Class_WC_Order_Data_Store_CPT {
	rt.PhpObjectBase
pub mut:
		internal_meta_keys rt.PhpVal = rt.new_array()
		internal_data_store_key_getters rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Order_Data_Store_CPT) create(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
	if rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_order_mutated, 'get_order_key', []rt.PhpVal{}))) {
		rt.call_method(var_order_mutated, 'set_order_key', [rt.call_function('wc_generate_order_key', []rt.PhpVal{})])
	}
	this.Class_Abstract_WC_Order_Data_Store_CPT.create(var_order_mutated.dup())
	if rt.is_true(rt.call_function('in_array', [rt.call_method(var_order_mutated, 'get_status', [rt.new_string('edit')]), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.draft() }, rt.ArrayItem{ key: none, val: 'checkout-draft' }]), rt.new_bool(true)])) {
		return rt.new_null()
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_new_order'), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), var_order_mutated.dup()])
}

fn (mut this Class_WC_Order_Data_Store_CPT) read_order_data(var_order rt.PhpVal, var_post_object rt.PhpVal)  {
	mut var_order_mutated := var_order
	this.Class_Abstract_WC_Order_Data_Store_CPT.read_order_data(var_order_mutated.dup(), var_post_object.dup())
	mut var_id := rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})
	mut var_post_meta := rt.call_function('get_post_meta', [var_id.dup()])
	mut var_date_completed := if !(var_post_meta.array_get('_date_completed').array_get(0)).is_null() { var_post_meta.array_get('_date_completed').array_get(0) } else { rt.new_string('') }
	mut var_date_paid := if !(var_post_meta.array_get('_date_paid').array_get(0)).is_null() { var_post_meta.array_get('_date_paid').array_get(0) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_date_completed)))) {
		var_date_completed = if !(var_post_meta.array_get('_completed_date').array_get(0)).is_null() { var_post_meta.array_get('_completed_date').array_get(0) } else { rt.new_string('') }
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_date_paid)))) {
		var_date_paid = if !(var_post_meta.array_get('_paid_date').array_get(0)).is_null() { var_post_meta.array_get('_paid_date').array_get(0) } else { rt.new_string('') }
	}
	rt.call_method(var_order_mutated, 'set_props', [rt.create_array([rt.ArrayItem{ key: 'order_key', val: if !(var_post_meta.array_get('_order_key').array_get(0)).is_null() { var_post_meta.array_get('_order_key').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'customer_id', val: if !(var_post_meta.array_get('_customer_user').array_get(0)).is_null() { var_post_meta.array_get('_customer_user').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'billing_first_name', val: if !(var_post_meta.array_get('_billing_first_name').array_get(0)).is_null() { var_post_meta.array_get('_billing_first_name').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'billing_last_name', val: if !(var_post_meta.array_get('_billing_last_name').array_get(0)).is_null() { var_post_meta.array_get('_billing_last_name').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'billing_company', val: if !(var_post_meta.array_get('_billing_company').array_get(0)).is_null() { var_post_meta.array_get('_billing_company').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'billing_address_1', val: if !(var_post_meta.array_get('_billing_address_1').array_get(0)).is_null() { var_post_meta.array_get('_billing_address_1').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'billing_address_2', val: if !(var_post_meta.array_get('_billing_address_2').array_get(0)).is_null() { var_post_meta.array_get('_billing_address_2').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'billing_city', val: if !(var_post_meta.array_get('_billing_city').array_get(0)).is_null() { var_post_meta.array_get('_billing_city').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'billing_state', val: if !(var_post_meta.array_get('_billing_state').array_get(0)).is_null() { var_post_meta.array_get('_billing_state').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'billing_postcode', val: if !(var_post_meta.array_get('_billing_postcode').array_get(0)).is_null() { var_post_meta.array_get('_billing_postcode').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'billing_country', val: if !(var_post_meta.array_get('_billing_country').array_get(0)).is_null() { var_post_meta.array_get('_billing_country').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'billing_email', val: if !(var_post_meta.array_get('_billing_email').array_get(0)).is_null() { var_post_meta.array_get('_billing_email').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'billing_phone', val: if !(var_post_meta.array_get('_billing_phone').array_get(0)).is_null() { var_post_meta.array_get('_billing_phone').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'shipping_first_name', val: if !(var_post_meta.array_get('_shipping_first_name').array_get(0)).is_null() { var_post_meta.array_get('_shipping_first_name').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'shipping_last_name', val: if !(var_post_meta.array_get('_shipping_last_name').array_get(0)).is_null() { var_post_meta.array_get('_shipping_last_name').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'shipping_company', val: if !(var_post_meta.array_get('_shipping_company').array_get(0)).is_null() { var_post_meta.array_get('_shipping_company').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'shipping_address_1', val: if !(var_post_meta.array_get('_shipping_address_1').array_get(0)).is_null() { var_post_meta.array_get('_shipping_address_1').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'shipping_address_2', val: if !(var_post_meta.array_get('_shipping_address_2').array_get(0)).is_null() { var_post_meta.array_get('_shipping_address_2').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'shipping_city', val: if !(var_post_meta.array_get('_shipping_city').array_get(0)).is_null() { var_post_meta.array_get('_shipping_city').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'shipping_state', val: if !(var_post_meta.array_get('_shipping_state').array_get(0)).is_null() { var_post_meta.array_get('_shipping_state').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'shipping_postcode', val: if !(var_post_meta.array_get('_shipping_postcode').array_get(0)).is_null() { var_post_meta.array_get('_shipping_postcode').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'shipping_country', val: if !(var_post_meta.array_get('_shipping_country').array_get(0)).is_null() { var_post_meta.array_get('_shipping_country').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'shipping_phone', val: if !(var_post_meta.array_get('_shipping_phone').array_get(0)).is_null() { var_post_meta.array_get('_shipping_phone').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'payment_method', val: if !(var_post_meta.array_get('_payment_method').array_get(0)).is_null() { var_post_meta.array_get('_payment_method').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'payment_method_title', val: if !(var_post_meta.array_get('_payment_method_title').array_get(0)).is_null() { var_post_meta.array_get('_payment_method_title').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'transaction_id', val: if !(var_post_meta.array_get('_transaction_id').array_get(0)).is_null() { var_post_meta.array_get('_transaction_id').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'customer_ip_address', val: if !(var_post_meta.array_get('_customer_ip_address').array_get(0)).is_null() { var_post_meta.array_get('_customer_ip_address').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'customer_user_agent', val: if !(var_post_meta.array_get('_customer_user_agent').array_get(0)).is_null() { var_post_meta.array_get('_customer_user_agent').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'created_via', val: if !(var_post_meta.array_get('_created_via').array_get(0)).is_null() { var_post_meta.array_get('_created_via').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'date_completed', val: var_date_completed }, rt.ArrayItem{ key: 'date_paid', val: var_date_paid }, rt.ArrayItem{ key: 'cart_hash', val: if !(var_post_meta.array_get('_cart_hash').array_get(0)).is_null() { var_post_meta.array_get('_cart_hash').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'customer_note', val: rt.get_property(var_post_object, 'post_excerpt') }, rt.ArrayItem{ key: 'order_stock_reduced', val: if !(var_post_meta.array_get('_order_stock_reduced').array_get(0)).is_null() { var_post_meta.array_get('_order_stock_reduced').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'download_permissions_granted', val: if !(var_post_meta.array_get('_download_permissions_granted').array_get(0)).is_null() { var_post_meta.array_get('_download_permissions_granted').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'new_order_email_sent', val: if !(var_post_meta.array_get('_new_order_email_sent').array_get(0)).is_null() { var_post_meta.array_get('_new_order_email_sent').array_get(0) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'recorded_sales', val: rt.call_function('wc_string_to_bool', [if !(var_post_meta.array_get('_recorded_sales').array_get(0)).is_null() { var_post_meta.array_get('_recorded_sales').array_get(0) } else { rt.new_string('') }]) }, rt.ArrayItem{ key: 'recorded_coupon_usage_counts', val: if !(var_post_meta.array_get('_recorded_coupon_usage_counts').array_get(0)).is_null() { var_post_meta.array_get('_recorded_coupon_usage_counts').array_get(0) } else { rt.new_string('') } }])])
	if rt.is_true(rt.new_bool(rt.is_true(this.cogs_is_enabled()) && rt.is_true(rt.call_method(var_order_mutated, 'has_cogs', []rt.PhpVal{})))) {
		this.read_cogs_data(var_order_mutated.dup(), var_post_meta.dup())
	}
}

fn (mut this Class_WC_Order_Data_Store_CPT) update(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_mutated, 'get_date_paid', [rt.new_string('edit')]))))) && rt.is_true(rt.call_function('version_compare', [rt.call_method(var_order_mutated, 'get_version', [rt.new_string('edit')]), rt.new_string('3.0'), rt.new_string('<')])))) {
		mut var_payment_complete_status := rt.call_function('apply_filters', [rt.new_string('woocommerce_payment_complete_order_status'), if rt.is_true(rt.call_method(var_order_mutated, 'needs_processing', []rt.PhpVal{})) { Class_Automattic_WooCommerce_Enums_OrderStatus.processing() } else { Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }, rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), var_order_mutated.dup()])
		if rt.is_true(rt.call_method(var_order_mutated, 'has_status', [var_payment_complete_status.dup()])) {
			rt.call_method(var_order_mutated, 'set_date_paid', [rt.call_method(var_order_mutated, 'get_date_created', [rt.new_string('edit')])])
		}
	}
	mut var_previous_status := rt.call_function('get_post_status', [rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_previous_status)))) && rt.is_true(rt.identical(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), rt.new_int(0))))) {
		var_previous_status = rt.new_string(rt.new_string('new'))
	}
	this.Class_Abstract_WC_Order_Data_Store_CPT.update(var_order_mutated.dup())
	mut var_current_status := rt.call_method(var_order_mutated, 'get_status', [rt.new_string('edit')])
	var_previous_status = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.remove_status_prefix(arg_0) }(var_previous_status.dup())
	var_current_status = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.remove_status_prefix(arg_0) }(var_current_status.dup())
	mut var_draft_statuses := [rt.new_string('new'), Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft(), Class_Automattic_WooCommerce_Enums_OrderStatus.draft(), rt.new_string('checkout-draft')]
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_current_status.dup(), var_draft_statuses.dup(), rt.new_bool(true)]))))))) && rt.is_true(rt.call_function('in_array', [var_previous_status.dup(), var_draft_statuses.dup(), rt.new_bool(true)])))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_new_order'), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), var_order_mutated.dup()])
		return rt.new_null()
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_update_order'), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}), var_order_mutated.dup()])
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_WC_Order_Data_Store_CPT) update_post_meta(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
	mut var_updated_props := []rt.PhpVal{}
	mut var_id := rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})
	mut var_meta_key_to_props := { '_order_key': 'order_key', '_customer_user': 'customer_id', '_payment_method': 'payment_method', '_payment_method_title': 'payment_method_title', '_transaction_id': 'transaction_id', '_customer_ip_address': 'customer_ip_address', '_customer_user_agent': 'customer_user_agent', '_created_via': 'created_via', '_date_completed': 'date_completed', '_date_paid': 'date_paid', '_cart_hash': 'cart_hash', '_download_permissions_granted': 'download_permissions_granted', '_recorded_sales': 'recorded_sales', '_recorded_coupon_usage_counts': 'recorded_coupon_usage_counts', '_new_order_email_sent': 'new_order_email_sent', '_order_stock_reduced': 'order_stock_reduced', '_cogs_total_value': 'cogs_total_value' }
	mut var_props_to_update := this.get_props_to_update(var_order_mutated.dup(), var_meta_key_to_props.dup())
	{
		mut iter_1 := var_props_to_update.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_prop := item_1.val
			mut var_meta_key := item_1.key
			if rt.is_true(rt.identical(rt.new_string('cogs_total_value'), var_prop)) {
				if rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled())))) {
					continue
				}
				mut var_value := rt.call_method(var_order_mutated, 'get_cogs_total_value', [rt.new_string('edit')])
				if this.handle_cogs_value_update(var_order_mutated.dup(), var_value.dup(), var_id.dup(), var_meta_key.dup(), var_updated_props.dup(), var_prop.dup()) {
					continue
				}
			} else {
				var_value = rt.call_method(var_order_mutated, "get_${var_prop.to_string()}", [rt.new_string('edit')])
			}
			var_value = if rt.is_true(rt.new_bool(var_value.dup().is_string())) { rt.call_function('wp_slash', [var_value.dup()]) } else { var_value }
			mut switch_val_1 := var_prop
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_paid'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('date_completed'))) {
				var_value = if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_null()))))) { rt.call_method(var_value, 'getTimestamp', []rt.PhpVal{}) } else { rt.new_string('') }
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download_permissions_granted'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('recorded_sales'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('recorded_coupon_usage_counts'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('order_stock_reduced'))) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_null())) || rt.is_true(rt.identical(rt.new_string(''), var_value)))) {
					break
				}
				var_value = if rt.is_true(rt.new_bool(var_value.dup().is_bool())) { rt.call_function('wc_bool_to_string', [var_value.dup()]) } else { var_value }
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('new_order_email_sent'))) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_null())) || rt.is_true(rt.identical(rt.new_string(''), var_value)))) {
					break
				}
				var_value = if rt.is_true(rt.new_bool(var_value.dup().is_bool())) { rt.call_function('wc_bool_to_string', [var_value.dup()]) } else { var_value }
				var_value = rt.new_string(if rt.is_true(rt.identical(rt.new_string('yes'), var_value)) { rt.new_string('true') } else { rt.new_string('false') })
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value.dup().is_bool())) && rt.is_true(rt.call_function('in_array', [var_prop.dup(), rt.call_function('array_values', [this.internal_data_store_key_getters]), rt.new_bool(true)])))) {
				var_value = rt.call_function('wc_bool_to_string', [var_value.dup()])
			}
			mut var_updated := this.update_or_delete_post_meta(var_order_mutated.dup(), var_meta_key.dup(), var_value.dup())
			if rt.is_true(var_updated) {
				var_updated_props << var_prop.dup()
			}
		}
	}
	mut var_address_props := { 'billing': { '_billing_first_name': rt.new_string('billing_first_name'), '_billing_last_name': rt.new_string('billing_last_name'), '_billing_company': rt.new_string('billing_company'), '_billing_address_1': rt.new_string('billing_address_1'), '_billing_address_2': rt.new_string('billing_address_2'), '_billing_city': rt.new_string('billing_city'), '_billing_state': rt.new_string('billing_state'), '_billing_postcode': rt.new_string('billing_postcode'), '_billing_country': rt.new_string('billing_country'), '_billing_email': rt.new_string('billing_email'), '_billing_phone': rt.new_string('billing_phone') }, 'shipping': { '_shipping_first_name': rt.new_string('shipping_first_name'), '_shipping_last_name': rt.new_string('shipping_last_name'), '_shipping_company': rt.new_string('shipping_company'), '_shipping_address_1': rt.new_string('shipping_address_1'), '_shipping_address_2': rt.new_string('shipping_address_2'), '_shipping_city': rt.new_string('shipping_city'), '_shipping_state': rt.new_string('shipping_state'), '_shipping_postcode': rt.new_string('shipping_postcode'), '_shipping_country': rt.new_string('shipping_country'), '_shipping_phone': rt.new_string('shipping_phone') } }
	for var_props_key, var_props in var_address_props {
		var_props_to_update = this.get_props_to_update(var_order_mutated.dup(), var_props.dup())
		{
			mut iter_1 := var_props_to_update.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_prop := item_1.val
				mut var_meta_key := item_1.key
				mut var_value := rt.call_method(var_order_mutated, "get_${var_prop.to_string()}", [rt.new_string('edit')])
				var_value = if rt.is_true(rt.new_bool(var_value.dup().is_string())) { rt.call_function('wp_slash', [var_value.dup()]) } else { var_value }
				mut var_updated := this.update_or_delete_post_meta(var_order_mutated.dup(), var_meta_key.dup(), var_value.dup())
				if rt.is_true(var_updated) {
					var_updated_props << var_prop.dup()
					var_updated_props << rt.new_string(props_key).dup()
				}
			}
		}
	}
	this.Class_Abstract_WC_Order_Data_Store_CPT.update_post_meta(var_order_mutated.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_string('billing'), var_updated_props.dup(), rt.new_bool(true)])) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('metadata_exists', [rt.new_string('post'), var_id.dup(), rt.new_string('_billing_address_index')]))))))) {
		rt.call_function('update_post_meta', [var_id.dup(), rt.new_string('_billing_address_index'), rt.call_function('implode', [rt.new_string(' '), rt.call_method(var_order_mutated, 'get_address', [rt.new_string('billing')])])])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_string('shipping'), var_updated_props.dup(), rt.new_bool(true)])) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('metadata_exists', [rt.new_string('post'), var_id.dup(), rt.new_string('_shipping_address_index')]))))))) {
		rt.call_function('update_post_meta', [var_id.dup(), rt.new_string('_shipping_address_index'), rt.call_function('implode', [rt.new_string(' '), rt.call_method(var_order_mutated, 'get_address', [rt.new_string('shipping')])])])
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('date_paid'), var_updated_props.dup(), rt.new_bool(true)])) {
		mut var_value := rt.call_method(var_order_mutated, 'get_date_paid', [rt.new_string('edit')])
		rt.call_function('update_post_meta', [var_id.dup(), rt.new_string('_paid_date'), if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_null()))))) { rt.call_method(var_value, 'date', [rt.new_string('Y-m-d H:i:s')]) } else { rt.new_string('') }])
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('date_completed'), var_updated_props.dup(), rt.new_bool(true)])) {
		var_value = rt.call_method(var_order_mutated, 'get_date_completed', [rt.new_string('edit')])
		rt.call_function('update_post_meta', [var_id.dup(), rt.new_string('_completed_date'), if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_null()))))) { rt.call_method(var_value, 'date', [rt.new_string('Y-m-d H:i:s')]) } else { rt.new_string('') }])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_string('customer_id'), var_updated_props.dup(), rt.new_bool(true)])) || rt.is_true(rt.call_function('in_array', [rt.new_string('billing_email'), var_updated_props.dup(), rt.new_bool(true)])))) {
		mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('customer-download'))
		rt.call_method(var_data_store, 'update_user_by_order_id', [var_id.dup(), rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{}), rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{})])
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('customer_id'), var_updated_props.dup(), rt.new_bool(true)])) {
		rt.call_function('wc_update_user_last_active', [rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{})])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_order_object_updated_props'), var_order_mutated.dup(), var_updated_props.dup()])
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_post_excerpt(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	return rt.call_method(var_order_mutated, 'get_customer_note', []rt.PhpVal{})
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_order_key(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.call_method(var_order_mutated, 'get_order_key', []rt.PhpVal{})
	}
	return this.Class_Abstract_WC_Order_Data_Store_CPT.get_order_key(var_order_mutated.dup())
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_total_refunded(var_order rt.PhpVal) f64 {
	mut var_wpdb := rt.new_null()
	mut var_order_mutated := var_order
	// unsupported statement: Stmt_Global
	mut var_total := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT SUM( postmeta.meta_value )\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS postmeta\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS posts ON ( posts.post_type = \'shop_order_refund\' AND posts.post_parent = %d )\n\t\t\t\tWHERE postmeta.meta_key = \'_refund_amount\'\n\t\t\t\tAND postmeta.post_id = posts.ID')), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])])
	return var_total.dup().to_f64()
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_order_id_by_order_key(var_order_key rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_order_key) {
		return 0
	}
	return (rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT post_id FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('postmeta WHERE meta_key = \'_order_key\' AND meta_value = %s')), var_order_key.dup()])])).to_i64()
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_order_count(var_status rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_status_mutated := var_status
	// unsupported statement: Stmt_Global
	return rt.call_function('absint', [rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT COUNT( * ) FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type = \'shop_order\' AND post_status = %s')), var_status_mutated.dup()])])])
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_orders(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Order_Data_Store_CPT::get_orders'), rt.new_string('3.1.0'), rt.new_string('Use wc_get_orders instead.')])
	return rt.call_function('wc_get_orders', [var_args_mutated.dup()])
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_orders_generate_customer_meta_query(var_values rt.PhpVal, relation string) rt.PhpVal {
	mut var_values_mutated := var_values
	mut var_meta_query := rt.create_array([rt.ArrayItem{ key: 'relation', val: relation.to_upper() }, rt.ArrayItem{ key: 'customer_emails', val: rt.create_array([rt.ArrayItem{ key: 'key', val: '_billing_email' }, rt.ArrayItem{ key: 'value', val: []rt.PhpVal{} }, rt.ArrayItem{ key: 'compare', val: 'IN' }]) }, rt.ArrayItem{ key: 'customer_ids', val: rt.create_array([rt.ArrayItem{ key: 'key', val: '_customer_user' }, rt.ArrayItem{ key: 'value', val: []rt.PhpVal{} }, rt.ArrayItem{ key: 'compare', val: 'IN' }]) }])
	{
		mut iter_1 := var_values_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
				mut var_query_part := this.get_orders_generate_customer_meta_query(var_value.dup(), 'and')
				if rt.is_true(rt.call_function('is_wp_error', [var_query_part.dup()])) {
					return var_query_part.dup()
				}
				var_meta_query.array_push(var_query_part.dup())
			} else if rt.is_true(rt.call_function('is_email', [var_value.dup()])) {
				var_meta_query.array_get_mut('customer_emails').array_get_mut('value').array_push(rt.call_function('sanitize_email', [var_value.dup()]))
			} else if rt.is_true(rt.new_bool(var_value.dup().is_long() || var_value.dup().is_double())) {
				var_meta_query.array_get_mut('customer_ids').array_get_mut('value').array_push(rt.call_function('absint', [var_value.dup()]).to_string())
			} else {
				return create_wp_error(rt.new_string('woocommerce_query_invalid'), rt.call_function('__', [rt.new_string('Invalid customer query.'), rt.new_string('woocommerce')]), var_values_mutated.dup())
			}
		}
	}
	if !rt.is_true(var_meta_query.array_get('customer_emails').array_get('value')) {
		var_meta_query.array_unset(rt.new_string('customer_emails'))
		var_meta_query.array_unset(rt.new_string('relation'))
	}
	if !rt.is_true(var_meta_query.array_get('customer_ids').array_get('value')) {
		var_meta_query.array_unset(rt.new_string('customer_ids'))
		var_meta_query.array_unset(rt.new_string('relation'))
	}
	return var_meta_query.dup()
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_unpaid_orders(var_date rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
}

fn (mut this Class_WC_Order_Data_Store_CPT) search_orders(var_term rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_download_permissions_granted(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_download_permissions_granted(var_order rt.PhpVal, var_set rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_recorded_sales(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_recorded_sales(var_order rt.PhpVal, var_set rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_recorded_coupon_usage_counts(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_recorded_coupon_usage_counts(var_order rt.PhpVal, var_set rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_email_sent(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_new_order_email_sent(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_email_sent(var_order rt.PhpVal, var_set rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_new_order_email_sent(var_order rt.PhpVal, var_set rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_coupon_held_keys(var_order rt.PhpVal, var_coupon_id rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_coupon_held_keys_for_users(var_order rt.PhpVal, var_coupon_id rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_coupon_held_keys(var_order rt.PhpVal, var_held_keys rt.PhpVal, var_held_keys_for_user rt.PhpVal)  {
	mut var_order_mutated := var_order
	mut var_held_keys_mutated := var_held_keys
	mut var_held_keys_for_user_mutated := var_held_keys_for_user
}

fn (mut this Class_WC_Order_Data_Store_CPT) release_held_coupons(var_order rt.PhpVal, save bool)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_stock_reduced(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_order_stock_reduced(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_stock_reduced(var_order rt.PhpVal, var_set rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) set_order_stock_reduced(var_order rt.PhpVal, var_set rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_order_type(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) get_wp_query_args(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_WC_Order_Data_Store_CPT) query(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_WC_Order_Data_Store_CPT) compile_orders(var_order_ids rt.PhpVal, var_query_vars rt.PhpVal, var_query rt.PhpVal) rt.PhpVal {
	mut var_order_ids_mutated := var_order_ids
	mut var_query_vars_mutated := var_query_vars
	mut var_query_mutated := var_query
}

fn (mut this Class_WC_Order_Data_Store_CPT) prime_caches_for_orders(var_order_ids rt.PhpVal, var_query_vars rt.PhpVal)  {
	mut var_order_ids_mutated := var_order_ids
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_WC_Order_Data_Store_CPT) prime_raw_meta_cache_for_orders(var_order_ids rt.PhpVal, var_query_vars rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_order_ids_mutated := var_order_ids
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_WC_Order_Data_Store_CPT) untrash_order(mut var_order Class_WC_Order) bool {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) generate_total_query(mut var_total_params Class_array) rt.PhpVal {
}

fn (mut this Class_WC_Order_Data_Store_CPT) update_order_meta_from_object(var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Order_Data_Store_CPT) read_cogs_data(var_order rt.PhpVal, var_post_meta rt.PhpVal)  {
	mut var_order_mutated := var_order
	mut var_post_meta_mutated := var_post_meta
}

fn (mut this Class_WC_Order_Data_Store_CPT) handle_cogs_value_update(var_order rt.PhpVal, var_value rt.PhpVal, var_order_id rt.PhpVal, var_meta_key rt.PhpVal, var_updated_props rt.PhpVal, var_prop rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_value_mutated := var_value
	mut var_order_id_mutated := var_order_id
	mut var_updated_props_mutated := var_updated_props
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

fn create_wc_order_data_store_cpt() &Class_WC_Order_Data_Store_CPT {
	mut obj := &Class_WC_Order_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
		internal_meta_keys: rt.new_array()
		internal_data_store_key_getters: rt.new_array()
	}
	return obj
}

fn create_abstract_wc_order_data_store_cpt() &Class_Abstract_WC_Order_Data_Store_CPT {
	mut obj := &Class_Abstract_WC_Order_Data_Store_CPT{
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

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.untrash_order(mut dispatch_arg_0))
		}
		'generate_total_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
			return rt.new_bool(this.handle_cogs_value_update(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5))
		}
		else { return none }
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
		'internal_meta_keys' { this.internal_meta_keys = val; return true }
		'internal_data_store_key_getters' { this.internal_data_store_key_getters = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_data_stores_class_wc_order_data_store_cpt_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
