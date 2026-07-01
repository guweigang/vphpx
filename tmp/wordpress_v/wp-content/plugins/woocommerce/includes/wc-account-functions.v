import rt

fn wc_lostpassword_url(default_url string) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))))) {
		return default_url
	}
	if rt.is_true(rt.call_function('did_action', [rt.new_string('login_form_login')])) {
		return default_url
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.get_superglobal('_GET').array_isset(rt.new_string('redirect_to')))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return default_url
	}
	mut var_wc_account_page_url := rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])
	mut var_wc_account_page_exists := (rt.greater(rt.call_function('wc_get_page_id', [rt.new_string('myaccount')]), rt.new_int(0))).to_bool()
	mut var_lost_password_endpoint := rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_lost_password_endpoint')])
	if var_wc_account_page_exists && !(!rt.is_true(var_lost_password_endpoint)) {
		return (rt.call_function('wc_get_endpoint_url', [var_lost_password_endpoint.dup(), rt.new_string(''), var_wc_account_page_url.dup()])).str()
	} else {
		return default_url
	}
	return ''
}

fn wc_customer_edit_account_url() rt.PhpVal {
	mut var_edit_account_url := rt.call_function('wc_get_endpoint_url', [rt.new_string('edit-account'), rt.new_string(''), rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_edit_account_url'), var_edit_account_url.dup()])
}

fn wc_edit_address_i18n(var_id rt.PhpVal, flip bool) rt.PhpVal {
	mut var_slugs := rt.call_function('apply_filters', [rt.new_string('woocommerce_edit_address_slugs'), rt.create_array([rt.ArrayItem{ key: 'billing', val: rt.call_function('sanitize_title', [rt.call_function('_x', [rt.new_string('billing'), rt.new_string('edit-address-slug'), rt.new_string('woocommerce')])]) }, rt.ArrayItem{ key: 'shipping', val: rt.call_function('sanitize_title', [rt.call_function('_x', [rt.new_string('shipping'), rt.new_string('edit-address-slug'), rt.new_string('woocommerce')])]) }])])
	if var_flip {
		var_slugs = rt.call_function('array_flip', [var_slugs.dup()])
	}
	if !(var_slugs.array_isset(var_id)) {
		return var_id.dup()
	}
	return var_slugs.array_get(var_id)
}

fn wc_get_account_menu_items() rt.PhpVal {
	mut var_endpoints := { 'orders': rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_orders_endpoint'), rt.new_string('orders')]), 'downloads': rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_downloads_endpoint'), rt.new_string('downloads')]), 'edit-address': rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_edit_address_endpoint'), rt.new_string('edit-address')]), 'payment-methods': rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_payment_methods_endpoint'), rt.new_string('payment-methods')]), 'edit-account': rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_edit_account_endpoint'), rt.new_string('edit-account')]), 'customer-logout': rt.call_function('get_option', [rt.new_string('woocommerce_logout_endpoint'), rt.new_string('customer-logout')]) }
	mut var_items := rt.create_array([rt.ArrayItem{ key: 'dashboard', val: rt.call_function('__', [rt.new_string('Dashboard'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'orders', val: rt.call_function('__', [rt.new_string('Orders'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'downloads', val: rt.call_function('__', [rt.new_string('Downloads'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'edit-address', val: rt.call_function('_n', [rt.new_string('Address'), rt.new_string('Addresses'), if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_ship_to_billing_address_only', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('wc_shipping_enabled', []rt.PhpVal{})))) { rt.new_int(2) } else { rt.new_int(1) }, rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'payment-methods', val: rt.call_function('__', [rt.new_string('Payment methods'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'edit-account', val: rt.call_function('__', [rt.new_string('Account details'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'customer-logout', val: rt.call_function('__', [rt.new_string('Log out'), rt.new_string('woocommerce')]) }])
	for var_endpoint_id, var_endpoint in var_endpoints {
		if !rt.is_true(var_endpoint) {
			var_items.array_unset(rt.new_string(endpoint_id))
		}
	}
	if var_items.array_isset(rt.new_string('payment-methods')) {
		mut var_support_payment_methods := false
		{
			mut iter_1 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'), 'get_available_payment_gateways', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_gateway := item_1.val
				if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_gateway, 'supports', [Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.add_payment_method()])) || rt.is_true(rt.call_method(var_gateway, 'supports', [Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.tokenization()])))) {
					var_support_payment_methods = true
					break
				}
			}
		}
		if !(var_support_payment_methods) {
			var_items.array_unset(rt.new_string('payment-methods'))
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_account_menu_items'), var_items.dup(), var_endpoints.dup()])
}

fn wc_is_current_account_menu_item(var_endpoint rt.PhpVal) rt.PhpVal {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_current := rt.new_bool(rt.get_property(var_wp, 'query_vars').array_isset(var_endpoint))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('dashboard'), var_endpoint)) && rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('page')) || !rt.is_true(rt.get_property(var_wp, 'query_vars')))) {
		var_current = rt.new_bool(rt.new_bool(true))
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('orders'), var_endpoint)) && rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('view-order')))) {
		var_current = rt.new_bool(rt.new_bool(true))
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('payment-methods'), var_endpoint)) && rt.get_property(var_wp, 'query_vars').array_isset(rt.new_string('add-payment-method')))) {
		var_current = rt.new_bool(rt.new_bool(true))
	}
	return var_current.dup()
}

fn wc_get_account_menu_item_classes(var_endpoint rt.PhpVal) rt.PhpVal {
	mut var_classes := rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce-MyAccount-navigation-link' }, rt.ArrayItem{ key: none, val: 'woocommerce-MyAccount-navigation-link--' + (var_endpoint).str() }])
	if rt.is_true(wc_is_current_account_menu_item(var_endpoint.dup())) {
		var_classes.array_push('is-active')
	}
	var_classes = rt.call_function('apply_filters', [rt.new_string('woocommerce_account_menu_item_classes'), var_classes.dup(), var_endpoint.dup()])
	return rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_map', [rt.new_string('sanitize_html_class'), var_classes.dup()])])
}

fn wc_get_account_endpoint_url(var_endpoint rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('dashboard'), var_endpoint)) {
		return rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])
	}
	mut var_url := rt.call_function('wc_get_endpoint_url', [var_endpoint.dup(), rt.new_string(''), rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])])
	if rt.is_true(rt.identical(rt.new_string('customer-logout'), var_endpoint)) {
		return rt.call_function('wp_nonce_url', [var_url.dup(), rt.new_string('customer-logout')])
	}
	return var_url.dup()
}

fn wc_get_account_orders_columns() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_account_orders_columns'), rt.create_array([rt.ArrayItem{ key: 'order-number', val: rt.call_function('__', [rt.new_string('Order'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'order-date', val: rt.call_function('__', [rt.new_string('Date'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'order-status', val: rt.call_function('__', [rt.new_string('Status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'order-total', val: rt.call_function('__', [rt.new_string('Total'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'order-actions', val: rt.call_function('__', [rt.new_string('Actions'), rt.new_string('woocommerce')]) }])])
}

fn wc_get_account_downloads_columns() rt.PhpVal {
	mut var_columns := rt.call_function('apply_filters', [rt.new_string('woocommerce_account_downloads_columns'), rt.create_array([rt.ArrayItem{ key: 'download-product', val: rt.call_function('__', [rt.new_string('Product'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'download-remaining', val: rt.call_function('__', [rt.new_string('Downloads remaining'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'download-expires', val: rt.call_function('__', [rt.new_string('Expires'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'download-file', val: rt.call_function('__', [rt.new_string('Download'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'download-actions', val: '&nbsp;' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_account_download_actions')]))))) {
		var_columns.array_unset(rt.new_string('download-actions'))
	}
	return var_columns.dup()
}

fn wc_get_account_payment_methods_columns() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_account_payment_methods_columns'), rt.create_array([rt.ArrayItem{ key: 'method', val: rt.call_function('__', [rt.new_string('Method'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'expires', val: rt.call_function('__', [rt.new_string('Expires'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'actions', val: '&nbsp;' }])])
}

fn wc_get_account_payment_methods_types() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_payment_methods_types'), rt.create_array([rt.ArrayItem{ key: 'cc', val: rt.call_function('__', [rt.new_string('Credit card'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'echeck', val: rt.call_function('__', [rt.new_string('eCheck'), rt.new_string('woocommerce')]) }])])
}

fn wc_get_account_orders_actions(var_order rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_order.dup().is_object()))))) {
		mut var_order_id := rt.call_function('absint', [var_order.dup()])
		var_order = rt.call_function('wc_get_order', [var_order_id.dup()])
	}
	mut var_actions := { 'pay': { 'url': rt.call_method(var_order, 'get_checkout_payment_url', []rt.PhpVal{}), 'name': rt.call_function('__', [rt.new_string('Pay'), rt.new_string('woocommerce')]), 'aria-label': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Pay for order %s'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})]) }, 'view': { 'url': rt.call_method(var_order, 'get_view_order_url', []rt.PhpVal{}), 'name': rt.call_function('__', [rt.new_string('View'), rt.new_string('woocommerce')]), 'aria-label': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('View order %s'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})]) }, 'cancel': { 'url': rt.call_method(var_order, 'get_cancel_order_url', [rt.call_function('wc_get_page_permalink', [rt.new_string('myaccount')])]), 'name': rt.call_function('__', [rt.new_string('Cancel'), rt.new_string('woocommerce')]), 'aria-label': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Cancel order %s'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})]) } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'needs_payment', []rt.PhpVal{}))))) {
		var_actions.delete('pay')
	}
	mut var_statuses_for_cancel := rt.call_function('apply_filters', [rt.new_string('woocommerce_valid_order_statuses_for_cancel'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.failed() }]), var_order.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_method(var_order, 'get_status', []rt.PhpVal{}), var_statuses_for_cancel.dup(), rt.new_bool(true)]))))) {
		var_actions.delete('cancel')
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_my_account_my_orders_actions'), var_actions.dup(), var_order.dup()])
}

fn wc_get_account_formatted_address(address_type string, customer_id i64) rt.PhpVal {
	mut var_getter := "get_${var_address_type}"
	mut var_address := rt.new_array()
	if 0 == customer_id {
		customer_id = (rt.call_function('get_current_user_id', []rt.PhpVal{})).to_i64()
	}
	mut var_customer := create_wc_customer(rt.new_int(customer_id).dup())
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_customer }, rt.ArrayItem{ key: none, val: var_getter }])])) {
		var_address = rt.call_method(var_customer, var_getter, []rt.PhpVal{})
		var_address.array_unset(rt.new_string('email'))
		var_address.array_unset(rt.new_string('tel'))
	}
	return rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_formatted_address', [rt.call_function('apply_filters', [rt.new_string('woocommerce_my_account_my_address_formatted_address'), var_address.dup(), var_customer.get_id(), rt.new_string(address_type)])])
}

fn wc_get_account_saved_payment_methods_list(var_list rt.PhpVal, var_customer_id rt.PhpVal) rt.PhpVal {
	mut var_payment_tokens := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Payment_Tokens{}; return temp.get_customer_tokens(arg_0) }(var_customer_id.dup())
	{
		mut iter_1 := var_payment_tokens.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_payment_token := item_1.val
			mut var_delete_url := rt.call_function('wc_get_endpoint_url', [rt.new_string('delete-payment-method'), rt.call_method(var_payment_token, 'get_id', []rt.PhpVal{})])
			var_delete_url = rt.call_function('wp_nonce_url', [var_delete_url.dup(), 'delete-payment-method-' + (rt.call_method(var_payment_token, 'get_id', []rt.PhpVal{})).str()])
			mut var_set_default_url := rt.call_function('wc_get_endpoint_url', [rt.new_string('set-default-payment-method'), rt.call_method(var_payment_token, 'get_id', []rt.PhpVal{})])
			var_set_default_url = rt.call_function('wp_nonce_url', [var_set_default_url.dup(), 'set-default-payment-method-' + (rt.call_method(var_payment_token, 'get_id', []rt.PhpVal{})).str()])
			mut var_type := rt.call_method(var_payment_token, 'get_type', []rt.PhpVal{}).to_string().to_lower()
			var_list.array_get_mut(var_type).array_push(rt.create_array([rt.ArrayItem{ key: 'method', val: rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.call_method(var_payment_token, 'get_gateway_id', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'expires', val: rt.call_function('esc_html__', [rt.new_string('N/A'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'is_default', val: rt.call_method(var_payment_token, 'is_default', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'actions', val: rt.create_array([rt.ArrayItem{ key: 'delete', val: rt.create_array([rt.ArrayItem{ key: 'url', val: var_delete_url }, rt.ArrayItem{ key: 'name', val: rt.call_function('esc_html__', [rt.new_string('Delete'), rt.new_string('woocommerce')]) }]) }]) }]))
			mut var_key := rt.call_function('key', [rt.call_function('array_slice', [var_list.array_get(var_type), // unsupported expression: Expr_UnaryMinus, rt.new_int(1), rt.new_bool(true)])])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_payment_token, 'is_default', []rt.PhpVal{}))))) {
				var_list.array_get_mut(var_type).array_get_mut(var_key).array_get_mut('actions').array_set('default', rt.create_array([rt.ArrayItem{ key: 'url', val: var_set_default_url }, rt.ArrayItem{ key: 'name', val: rt.call_function('esc_html__', [rt.new_string('Make default'), rt.new_string('woocommerce')]) }]))
			}
			var_list.array_get_mut(var_type).array_set(var_key, rt.call_function('apply_filters', [rt.new_string('woocommerce_payment_methods_list_item'), var_list.array_get(var_type).array_get(var_key), var_payment_token.dup()]))
		}
	}
	return var_list.dup()
}

fn wc_get_account_saved_payment_methods_list_item_cc(var_item rt.PhpVal, var_payment_token rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_item.dup()
	}
	mut var_card_type := rt.call_method(var_payment_token, 'get_card_type', []rt.PhpVal{})
	var_item.array_get_mut('method').array_set('last4', rt.call_method(var_payment_token, 'get_last4', []rt.PhpVal{}))
	var_item.array_get_mut('method').array_set('brand', if !(!rt.is_true(var_card_type)) { rt.call_function('ucwords', [rt.call_function('str_replace', [, , .dup()])]) } else { rt.call_function('esc_html__', [rt.new_string('Credit card'), rt.new_string('woocommerce')]) })
	var_item['expires'] = ().str() +  + (rt.call_function('substr', [, ])).str()
	return var_item.dup()
}

fn wc_get_account_saved_payment_methods_list_item_echeck(var_item rt.PhpVal, var_payment_token rt.PhpVal) rt.PhpVal {
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

struct Class_WC_Payment_Tokens {
	rt.PhpObjectBase
}

fn create_wc_customer() &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_payment_tokens() &Class_WC_Payment_Tokens {
	mut obj := &Class_WC_Payment_Tokens{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Payment_Tokens) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Payment_Tokens) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Tokens) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_wc_account_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('add_filter', [rt.new_string('lostpassword_url'), rt.new_string('wc_lostpassword_url'), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_saved_payment_methods_list'), rt.new_string('wc_get_account_saved_payment_methods_list'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [, , , ])
}
