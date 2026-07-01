import rt

struct Class_WC_Privacy_Exporters {
	rt.PhpObjectBase
}

fn Class_WC_Privacy_Exporters.customer_data_exporter(var_email_address rt.PhpVal) rt.PhpVal {
	mut var_user := rt.call_function('get_user_by', [rt.new_string('email'), var_email_address.dup()])
	mut var_data_to_export := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) {
		mut var_customer_personal_data := Class_WC_Privacy_Exporters.get_customer_personal_data(var_user.dup())
		if !(!rt.is_true(var_customer_personal_data)) {
			var_data_to_export << rt.create_array([rt.ArrayItem{ key: 'group_id', val: 'woocommerce_customer' }, rt.ArrayItem{ key: 'group_label', val: rt.call_function('__', [rt.new_string('Customer Data'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'group_description', val: rt.call_function('__', [rt.new_string('User&#8217;s WooCommerce customer data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'item_id', val: 'user' }, rt.ArrayItem{ key: 'data', val: var_customer_personal_data }])
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'data', val: var_data_to_export }, rt.ArrayItem{ key: 'done', val: true }])
}

fn Class_WC_Privacy_Exporters.order_data_exporter(var_email_address rt.PhpVal, var_page rt.PhpVal) rt.PhpVal {
	mut var_page_mutated := var_page
	mut var_done := rt.new_bool(rt.new_bool(true))
	var_page_mutated = // unsupported expression: Expr_Cast_Int
	mut var_user := rt.call_function('get_user_by', [rt.new_string('email'), var_email_address.dup()])
	mut var_data_to_export := []rt.PhpVal{}
	mut var_order_query := { 'limit': rt.new_int(10), 'page': var_page_mutated, 'customer': map[string]rt.PhpVal{} }
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) {
		var_order_query.array_get_mut('customer').array_push(// unsupported expression: Expr_Cast_Int)
	}
	mut var_orders := rt.call_function('wc_get_orders', [var_order_query.dup()])
	if 0 < var_orders.dup().array_count() {
		{
			mut iter_1 := var_orders.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_order := item_1.val
				var_data_to_export << rt.create_array([rt.ArrayItem{ key: 'group_id', val: 'woocommerce_orders' }, rt.ArrayItem{ key: 'group_label', val: rt.call_function('__', [rt.new_string('Orders'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'group_description', val: rt.call_function('__', [rt.new_string('User&#8217;s WooCommerce orders data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'item_id', val: 'order-' + (rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str() }, rt.ArrayItem{ key: 'data', val: Class_WC_Privacy_Exporters.get_order_personal_data(var_order.dup()) }])
			}
		}
		var_done = rt.new_bool(rt.new_bool(10 > var_orders.dup().array_count()))
	}
	return rt.create_array([rt.ArrayItem{ key: 'data', val: var_data_to_export }, rt.ArrayItem{ key: 'done', val: var_done }])
}

fn Class_WC_Privacy_Exporters.download_data_exporter(var_email_address rt.PhpVal, var_page rt.PhpVal) rt.PhpVal {
	mut var_page_mutated := var_page
	mut var_done := rt.new_bool(rt.new_bool(true))
	var_page_mutated = // unsupported expression: Expr_Cast_Int
	mut var_user := rt.call_function('get_user_by', [rt.new_string('email'), var_email_address.dup()])
	mut var_data_to_export := []rt.PhpVal{}
	mut var_downloads_query := { 'limit': rt.new_int(10), 'page': var_page_mutated }
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User'))) {
		var_downloads_query['user_id'] = // unsupported expression: Expr_Cast_Int
	} else {
		var_downloads_query['user_email'] = var_email_address.dup()
	}
	mut var_customer_download_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('customer-download'))
	mut var_customer_download_log_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('customer-download-log'))
	mut var_downloads := rt.call_method(var_customer_download_data_store, 'get_downloads', [var_downloads_query.dup()])
	if 0 < var_downloads.dup().array_count() {
		{
			mut iter_1 := var_downloads.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_download := item_1.val
				var_data_to_export << rt.create_array([rt.ArrayItem{ key: 'group_id', val: 'woocommerce_downloads' }, rt.ArrayItem{ key: 'group_label', val: rt.call_function('__', [rt.new_string('Purchased Downloads'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'group_description', val: rt.call_function('__', [rt.new_string('User&#8217;s WooCommerce purchased downloads data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'item_id', val: 'download-' + (rt.call_method(var_download, 'get_id', []rt.PhpVal{})).str() }, rt.ArrayItem{ key: 'data', val: Class_WC_Privacy_Exporters.get_download_personal_data(var_download.dup()) }])
				mut var_download_logs := rt.call_method(var_customer_download_log_data_store, 'get_download_logs_for_permission', [rt.call_method(var_download, 'get_id', []rt.PhpVal{})])
				{
					mut iter_2 := var_download_logs.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_download_log := item_2.val
						var_data_to_export << rt.create_array([rt.ArrayItem{ key: 'group_id', val: 'woocommerce_download_logs' }, rt.ArrayItem{ key: 'group_label', val: rt.call_function('__', [rt.new_string('Access to Purchased Downloads'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'group_description', val: rt.call_function('__', [rt.new_string('User&#8217;s WooCommerce access to purchased downloads data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'item_id', val: 'download-log-' + (rt.call_method(var_download_log, 'get_id', []rt.PhpVal{})).str() }, rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Download ID'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_download_log, 'get_permission_id', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Timestamp'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_download_log, 'get_timestamp', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('IP Address'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_download_log, 'get_user_ip_address', []rt.PhpVal{}) }]) }]) }])
					}
				}
			}
		}
		var_done = rt.new_bool(rt.new_bool(10 > var_downloads.dup().array_count()))
	}
	return rt.create_array([rt.ArrayItem{ key: 'data', val: var_data_to_export }, rt.ArrayItem{ key: 'done', val: var_done }])
}

fn Class_WC_Privacy_Exporters.get_customer_personal_data(var_user rt.PhpVal) rt.PhpVal {
	mut var_user_mutated := var_user
	mut var_personal_data := []rt.PhpVal{}
	mut var_customer := create_wc_customer(rt.get_property(var_user_mutated, 'ID'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_customer)))) {
		return []rt.PhpVal{}
	}
	mut var_props_to_export := rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_export_customer_personal_data_props'), rt.create_array([rt.ArrayItem{ key: 'billing_first_name', val: rt.call_function('__', [rt.new_string('Billing First Name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_last_name', val: rt.call_function('__', [rt.new_string('Billing Last Name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_company', val: rt.call_function('__', [rt.new_string('Billing Company'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_address_1', val: rt.call_function('__', [rt.new_string('Billing Address 1'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_address_2', val: rt.call_function('__', [rt.new_string('Billing Address 2'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_city', val: rt.call_function('__', [rt.new_string('Billing City'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_postcode', val: rt.call_function('__', [rt.new_string('Billing Postal/Zip Code'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_state', val: rt.call_function('__', [rt.new_string('Billing State'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_country', val: rt.call_function('__', [rt.new_string('Billing Country / Region'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_phone', val: rt.call_function('__', [rt.new_string('Billing Phone Number'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_email', val: rt.call_function('__', [rt.new_string('Email Address'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_first_name', val: rt.call_function('__', [rt.new_string('Shipping First Name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_last_name', val: rt.call_function('__', [rt.new_string('Shipping Last Name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_company', val: rt.call_function('__', [rt.new_string('Shipping Company'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_address_1', val: rt.call_function('__', [rt.new_string('Shipping Address 1'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_address_2', val: rt.call_function('__', [rt.new_string('Shipping Address 2'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_city', val: rt.call_function('__', [rt.new_string('Shipping City'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_postcode', val: rt.call_function('__', [rt.new_string('Shipping Postal/Zip Code'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_state', val: rt.call_function('__', [rt.new_string('Shipping State'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_country', val: rt.call_function('__', [rt.new_string('Shipping Country / Region'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_phone', val: rt.call_function('__', [rt.new_string('Shipping Phone Number'), rt.new_string('woocommerce')]) }]), var_customer])
	{
		mut iter_1 := var_props_to_export.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_description := item_1.val
			mut var_prop := item_1.key
			mut var_value := rt.new_string(rt.new_string(''))
			if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_customer }, rt.ArrayItem{ key: none, val: 'get_' + (var_prop).str() }])])) {
				var_value = rt.call_method(var_customer, "get_${var_prop.to_string()}", [rt.new_string('edit')])
			}
			var_value = rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_export_customer_personal_data_prop_value'), var_value.dup(), var_prop.dup(), var_customer])
			if rt.is_true(var_value) {
				var_personal_data.array_push(rt.create_array([rt.ArrayItem{ key: 'name', val: var_description }, rt.ArrayItem{ key: 'value', val: var_value }]))
			}
		}
	}
	var_personal_data = rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_export_customer_personal_data'), var_personal_data.dup(), var_customer])
	return var_personal_data.dup()
}

fn Class_WC_Privacy_Exporters.get_order_personal_data(var_order rt.PhpVal) rt.PhpVal {
	mut var_personal_data := []rt.PhpVal{}
	mut var_props_to_export := rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_export_order_personal_data_props'), rt.create_array([rt.ArrayItem{ key: 'order_number', val: rt.call_function('__', [rt.new_string('Order Number'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('__', [rt.new_string('Order Date'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'total', val: rt.call_function('__', [rt.new_string('Order Total'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'items', val: rt.call_function('__', [rt.new_string('Items Purchased'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'customer_ip_address', val: rt.call_function('__', [rt.new_string('IP Address'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'customer_user_agent', val: rt.call_function('__', [rt.new_string('Browser User Agent'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'formatted_billing_address', val: rt.call_function('__', [rt.new_string('Billing Address'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'formatted_shipping_address', val: rt.call_function('__', [rt.new_string('Shipping Address'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_phone', val: rt.call_function('__', [rt.new_string('Phone Number'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'billing_email', val: rt.call_function('__', [rt.new_string('Email Address'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'shipping_phone', val: rt.call_function('__', [rt.new_string('Shipping Phone Number'), rt.new_string('woocommerce')]) }]), var_order.dup()])
	{
		mut iter_1 := var_props_to_export.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_name := item_1.val
			mut var_prop := item_1.key
			mut var_value := rt.new_string(rt.new_string(''))
			mut switch_val_1 := var_prop
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('items'))) {
				mut var_item_names := []rt.PhpVal{}
				{
					mut iter_2 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_item := item_2.val
						var_item_names.array_push((rt.call_method(var_item, 'get_name', []rt.PhpVal{})).str() + ' x ' + (rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})).str())
					}
				}
				var_value = rt.call_function('implode', [rt.new_string(', '), var_item_names.dup()])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_created'))) {
				var_value = rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}), (rt.call_function('get_option', [rt.new_string('date_format')])).str() + ', ' + (rt.call_function('get_option', [rt.new_string('time_format')])).str()])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('formatted_billing_address'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('formatted_shipping_address'))) {
				var_value = rt.call_function('preg_replace', [rt.new_string('#<br\\s*/?>#i'), rt.new_string(', '), rt.call_method(var_order, "get_${var_prop.to_string()}", []rt.PhpVal{})])
			} else {
				if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_order }, rt.ArrayItem{ key: none, val: 'get_' + (var_prop).str() }])])) {
					var_value = rt.call_method(var_order, "get_${var_prop.to_string()}", []rt.PhpVal{})
				}
			}
			var_value = rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_export_order_personal_data_prop'), var_value.dup(), var_prop.dup(), var_order.dup()])
			if rt.is_true(var_value) {
				var_personal_data.array_push(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'value', val: var_value }]))
			}
		}
	}
	mut var_meta_to_export := rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_export_order_personal_data_meta'), rt.create_array([rt.ArrayItem{ key: 'Payer first name', val: rt.call_function('__', [rt.new_string('Payer first name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'Payer last name', val: rt.call_function('__', [rt.new_string('Payer last name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'Payer PayPal address', val: rt.call_function('__', [rt.new_string('Payer PayPal address'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'Transaction ID', val: rt.call_function('__', [rt.new_string('Transaction ID'), rt.new_string('woocommerce')]) }])])
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_meta_to_export)) && rt.is_true(rt.new_bool(var_meta_to_export.dup().is_array())))) {
		{
			mut iter_1 := var_meta_to_export.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_name := item_1.val
				mut var_meta_key := item_1.key
				mut var_value := rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_export_order_personal_data_meta_value'), rt.call_method(var_order, 'get_meta', [var_meta_key.dup()]), var_meta_key.dup(), var_order.dup()])
				if rt.is_true(var_value) {
					var_personal_data.array_push(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'value', val: var_value }]))
				}
			}
		}
	}
	var_personal_data = rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_export_order_personal_data'), var_personal_data.dup(), var_order.dup()])
	return var_personal_data.dup()
}

fn Class_WC_Privacy_Exporters.get_download_personal_data(var_download rt.PhpVal) rt.PhpVal {
	mut var_personal_data := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Download ID'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_download, 'get_id', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Order ID'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_download, 'get_order_id', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Product'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('get_the_title', [rt.call_method(var_download, 'get_product_id', []rt.PhpVal{})]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('User email'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_download, 'get_user_email', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Downloads remaining'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_download, 'get_downloads_remaining', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Download count'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_download, 'get_download_count', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Access granted'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('gmdate', [rt.new_string('Y-m-d'), rt.call_method(rt.call_method(var_download, 'get_access_granted', [rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Access expires'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_method(var_download, 'get_access_expires', [rt.new_string('edit')]).is_null()))))) { rt.call_function('gmdate', [rt.new_string('Y-m-d'), rt.call_method(rt.call_method(var_download, 'get_access_expires', [rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})]) } else { rt.new_null() } }]) }])
	var_personal_data = rt.call_function('apply_filters', [rt.new_string('woocommerce_privacy_export_download_personal_data'), var_personal_data.dup(), var_download.dup()])
	return var_personal_data.dup()
}

fn Class_WC_Privacy_Exporters.customer_tokens_exporter(var_email_address rt.PhpVal, var_page rt.PhpVal) rt.PhpVal {
	mut var_page_mutated := var_page
	mut var_user := rt.call_function('get_user_by', [rt.new_string('email'), var_email_address.dup()])
	mut var_data_to_export := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User')))))) {
		return rt.create_array([rt.ArrayItem{ key: 'data', val: var_data_to_export }, rt.ArrayItem{ key: 'done', val: true }])
	}
	mut var_tokens := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Payment_Tokens{}; return temp.get_tokens(arg_0) }(rt.create_array([rt.ArrayItem{ key: 'user_id', val: rt.get_property(var_user, 'ID') }, rt.ArrayItem{ key: 'limit', val: 10 }, rt.ArrayItem{ key: 'page', val: var_page_mutated }]))
	if 0 < var_tokens.dup().array_count() {
		{
			mut iter_1 := var_tokens.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_token := item_1.val
				var_data_to_export << rt.create_array([rt.ArrayItem{ key: 'group_id', val: 'woocommerce_tokens' }, rt.ArrayItem{ key: 'group_label', val: rt.call_function('__', [rt.new_string('Payment Tokens'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'group_description', val: rt.call_function('__', [rt.new_string('User&#8217;s WooCommerce payment tokens data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'item_id', val: 'token-' + (rt.call_method(var_token, 'get_id', []rt.PhpVal{})).str() }, rt.ArrayItem{ key: 'data', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Token'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_token, 'get_display_name', []rt.PhpVal{}) }]) }]) }])
			}
		}
		mut var_done := rt.new_bool(rt.new_bool(10 > var_tokens.dup().array_count()))
	} else {
		var_done = rt.new_bool(rt.new_bool(true))
	}
	return rt.create_array([rt.ArrayItem{ key: 'data', val: var_data_to_export }, rt.ArrayItem{ key: 'done', val: var_done }])
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

struct Class_WC_Payment_Tokens {
	rt.PhpObjectBase
}

fn create_wc_privacy_exporters() &Class_WC_Privacy_Exporters {
	mut obj := &Class_WC_Privacy_Exporters{
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

fn (mut this Class_WC_Privacy_Exporters) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'customer_data_exporter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Privacy_Exporters.customer_data_exporter(dispatch_arg_0)
		}
		'order_data_exporter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Privacy_Exporters.order_data_exporter(dispatch_arg_0, dispatch_arg_1)
		}
		'download_data_exporter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Privacy_Exporters.download_data_exporter(dispatch_arg_0, dispatch_arg_1)
		}
		'get_customer_personal_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Privacy_Exporters.get_customer_personal_data(dispatch_arg_0)
		}
		'get_order_personal_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Privacy_Exporters.get_order_personal_data(dispatch_arg_0)
		}
		'get_download_personal_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Privacy_Exporters.get_download_personal_data(dispatch_arg_0)
		}
		'customer_tokens_exporter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Privacy_Exporters.customer_tokens_exporter(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_Privacy_Exporters) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Privacy_Exporters) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_privacy_exporters_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
