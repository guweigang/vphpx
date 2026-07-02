import rt

struct Class_WC_Meta_Box_Order_Data {
	rt.PhpObjectBase
}

fn init_static_wc_meta_box_order_data() {
	rt.init_static_prop('WC_Meta_Box_Order_Data', 'billing_fields', rt.new_array())
	rt.init_static_prop('WC_Meta_Box_Order_Data', 'shipping_fields', rt.new_array())
}

fn Class_WC_Meta_Box_Order_Data.get_billing_fields(order bool, context string) rt.PhpVal {
	mut order_mutated := order
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_billing_fields'),
		rt.create_array([
			rt.ArrayItem{ key: 'first_name', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('First name'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'last_name', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Last name'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'company', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Company'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'address_1', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Address line 1'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'address_2', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Address line 2'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'city', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('City'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'postcode', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Postcode / ZIP'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'country', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Country / Region'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
				rt.ArrayItem{ key: 'class', val: 'js_field-country select short' },
				rt.ArrayItem{ key: 'type', val: 'select' },
				rt.ArrayItem{ key: 'options', val: rt.add(rt.create_array([
					rt.ArrayItem{ key: '', val: rt.call_function('__', [
						rt.new_string('Select a country / region&hellip;'),
						rt.new_string('woocommerce'),
					]) },
				]), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
					'countries'), 'get_countries', []rt.PhpVal{})) },
			]) },
			rt.ArrayItem{ key: 'state', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('State / County'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'class', val: 'js_field-state select short' },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'email', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Email address'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'phone', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Phone'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]),
		rt.new_bool(order_mutated).clone(),
		rt.new_string(context),
	])
}

fn Class_WC_Meta_Box_Order_Data.get_shipping_fields(order bool, context string) rt.PhpVal {
	mut order_mutated := order
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_shipping_fields'),
		rt.create_array([
			rt.ArrayItem{ key: 'first_name', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('First name'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'last_name', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Last name'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'company', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Company'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'address_1', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Address line 1'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'address_2', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Address line 2'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'city', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('City'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'postcode', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Postcode / ZIP'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'country', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Country / Region'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'show', val: false },
				rt.ArrayItem{ key: 'type', val: 'select' },
				rt.ArrayItem{ key: 'class', val: 'js_field-country select short' },
				rt.ArrayItem{ key: 'options', val: rt.add(rt.create_array([
					rt.ArrayItem{ key: '', val: rt.call_function('__', [
						rt.new_string('Select a country / region&hellip;'),
						rt.new_string('woocommerce'),
					]) },
				]), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
					'countries'), 'get_countries', []rt.PhpVal{})) },
			]) },
			rt.ArrayItem{ key: 'state', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('State / County'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'class', val: 'js_field-state select short' },
				rt.ArrayItem{ key: 'show', val: false },
			]) },
			rt.ArrayItem{ key: 'phone', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Phone'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]),
		rt.new_bool(order_mutated).clone(),
		rt.new_string(context),
	])
}

fn Class_WC_Meta_Box_Order_Data.init_address_fields() {
	rt.set_static_prop('WC_Meta_Box_Order_Data', 'billing_fields',
		Class_WC_Meta_Box_Order_Data.get_billing_fields())
	rt.set_static_prop('WC_Meta_Box_Order_Data', 'shipping_fields',
		Class_WC_Meta_Box_Order_Data.get_shipping_fields())
}

fn Class_WC_Meta_Box_Order_Data.output(var_post rt.PhpVal) {
	mut var_theorder := rt.new_null()
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_0 := iife_temp_0.init_theorder_object(var_post.clone())
	mut var_order := var_theorder
	if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways',
		[]rt.PhpVal{}))
	{
		mut var_payment_gateways := rt.call_method(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'payment_gateways'), 'payment_gateways', []rt.PhpVal{})
	} else {
		var_payment_gateways = rt.new_array()
	}
	mut var_payment_method := rt.call_method(var_order, 'get_payment_method', []rt.PhpVal{})
	mut var_order_type_object := rt.call_function('get_post_type_object', [
		rt.call_method(var_order, 'get_type', []rt.PhpVal{}),
	])
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce_save_data'),
		rt.new_string('woocommerce_meta_nonce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if !rt.is_true(rt.call_method(var_order, 'get_title', []rt.PhpVal{})) { rt.call_function('__', [
			rt.new_string('Order'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_method(var_order, 'get_title', []rt.PhpVal{}) }]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_order, 'get_status', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html__', [rt.new_string('%1$s #%2$s details'),
			rt.new_string('woocommerce')]),
		rt.call_function('esc_html', [
			rt.get_property(rt.get_property(var_order_type_object, 'labels'), 'singular_name'),
		]),
		rt.call_function('esc_html', [
			rt.call_method(var_order, 'get_order_number', []rt.PhpVal{}),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_meta_list := rt.new_array()
	if rt.is_true(var_payment_method)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('other'), var_payment_method)))) {
		mut var_payment_method_string := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Payment via %s'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_html', [if var_payment_gateways.array_isset(var_payment_method) {
				rt.call_method(var_payment_gateways.array_get(var_payment_method), 'get_title',
					[]rt.PhpVal{})
			} else {
				var_payment_method
			}]),
		])
		mut var_transaction_id := rt.call_method(var_order, 'get_transaction_id', []rt.PhpVal{})
		if rt.is_true(var_transaction_id) {
			mut var_to_add := rt.new_null()
			if var_payment_gateways.array_isset(var_payment_method) {
				mut var_url := rt.call_method(var_payment_gateways.array_get(var_payment_method),
					'get_transaction_url', [var_order.clone()])
				if rt.is_true(var_url) {
					var_to_add = rt.concat(var_to_add, rt.new_string(
						' (<a href="' + (rt.call_function('esc_url', [var_url.clone()])).str() +
						'" target="_blank">' +
						(rt.call_function('esc_html', [var_transaction_id.clone()])).str() + '</a>)'))
				}
			}
			var_to_add = if !var_to_add.is_null() {
				var_to_add
			} else {
				' (' + (rt.call_function('esc_html', [var_transaction_id.clone()])).str() + ')'
			}
			var_payment_method_string = rt.concat(var_payment_method_string, var_to_add)
		}
		var_meta_list << var_payment_method_string.clone()
	}
	if rt.is_true(rt.call_method(var_order, 'get_date_paid', []rt.PhpVal{})) {
		var_meta_list << rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Paid on %1$s @ %2$s'),
				rt.new_string('woocommerce')]),
			rt.call_function('wc_format_datetime', [
				rt.call_method(var_order, 'get_date_paid', []rt.PhpVal{}),
			]),
			rt.call_function('wc_format_datetime', [
				rt.call_method(var_order, 'get_date_paid', []rt.PhpVal{}),
				rt.call_function('get_option', [rt.new_string('time_format')]),
			]),
		])
	}
	mut var_ip_address := rt.call_method(var_order, 'get_customer_ip_address', []rt.PhpVal{})
	if rt.is_true(var_ip_address) {
		var_meta_list << rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Customer IP: %s'),
				rt.new_string('woocommerce')]),
			rt.new_string('<span class="woocommerce-Order-customerIP">' +
				(rt.call_function('esc_html', [var_ip_address.clone()])).str() + '</span>'),
		])
	}
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('implode', [rt.new_string('. '), rt.create_array_from_list(var_meta_list)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_order_data_header_right'),
		var_order.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_order_data_after_payment_info'),
		var_order.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('General'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_order_date_created_localised := if !(rt.call_method(var_order, 'get_date_created',
		[]rt.PhpVal{}).is_null()) {
		rt.call_method(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}),
			'getOffsetTimestamp', []rt.PhpVal{})
	} else {
		rt.new_string('')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Date created:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('date_i18n', [rt.new_string('Y-m-d'),
			var_order_date_created_localised.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_date_input_html_pattern'),
			rt.new_string('[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('h'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('date_i18n',
			[rt.new_string('H'), var_order_date_created_localised.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('m'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('date_i18n',
			[rt.new_string('i'), var_order_date_created_localised.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('date_i18n',
			[rt.new_string('s'), var_order_date_created_localised.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Status:'),
		rt.new_string('woocommerce')])
	if rt.is_true(rt.call_method(var_order, 'needs_payment', []rt.PhpVal{})) {
		rt.call_function('printf', [rt.new_string('<a href="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_method(var_order, 'get_checkout_payment_url', []rt.PhpVal{}),
			]),
			rt.call_function('esc_html__', [
				rt.new_string('Customer payment page &rarr;'),
				rt.new_string('woocommerce'),
			])])
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_statuses := rt.call_function('wc_get_order_statuses', []rt.PhpVal{})
	mut iter_1 := var_statuses.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_status_name := item_1.val
		mut var_status := item_1.key
		print('<option value="' + (rt.call_function('esc_attr', [var_status.clone()])).str() +
			'" ' +
			(rt.call_function('selected', [var_status.clone(), rt.new_string('wc-' + (rt.call_method(var_order, 'get_status', [rt.new_string('edit')])).str()), rt.new_bool(false)])).str() +
			'>' + (rt.call_function('esc_html', [var_status_name.clone()])).str() + '</option>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Customer:'),
		rt.new_string('woocommerce')])
	if rt.is_true(rt.call_method(var_order, 'get_user_id', [rt.new_string('edit')])) {
		mut var_args := {
			'post_status':    rt.new_string('all')
			'post_type':      rt.new_string('shop_order')
			'_customer_user': rt.call_method(var_order, 'get_user_id', [
				rt.new_string('edit'),
			])
		}
		rt.call_function('printf', [rt.new_string('<a href="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [
					rt.create_array_from_native_map(var_args),
					rt.call_function('admin_url', [rt.new_string('edit.php')]),
				]),
			]),
			rt.new_string(' ' +(rt.call_function('esc_html__', [rt.new_string('View other orders &rarr;'), rt.new_string('woocommerce')])).str())])
		rt.call_function('printf', [rt.new_string('<a href="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [rt.new_string('user_id'),
					rt.call_method(var_order, 'get_user_id', [
						rt.new_string('edit')]),
					rt.call_function('admin_url', [rt.new_string('user-edit.php')])]),
			]),
			rt.new_string(' ' +(rt.call_function('esc_html__', [rt.new_string('Profile &rarr;'), rt.new_string('woocommerce')])).str())])
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_user_string := rt.new_string('')
	mut var_user_id := rt.new_string('')
	if rt.is_true(rt.call_method(var_order, 'get_user_id', []rt.PhpVal{})) {
		var_user_id = rt.call_function('absint', [
			rt.call_method(var_order, 'get_user_id', []rt.PhpVal{}),
		])
		mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_1 := iife_temp_1.get_user_in_current_site(var_user_id.clone())
		mut var_user := iife_result_1
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			var_user.clone(),
		])))))
		{
			mut var_customer := create_wc_customer(var_user_id.clone())
			var_user_string = rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('%1$s (#%2$s &ndash; %3$s)'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string((var_customer.get_first_name()).str() + ' ' +
					(var_customer.get_last_name()).str()),
				var_customer.get_id(),
				var_customer.get_email(),
			])
		} else {
			var_user_string = rt.call_function('esc_html__', [
				rt.new_string('(Not available)'),
				rt.new_string('woocommerce'),
			])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Guest'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_user_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('htmlspecialchars', [
			rt.call_function('wp_kses_post', [
				rt.call_function('current', [
					rt.call_function('apply_filters', [
						rt.new_string('woocommerce_json_search_found_customers'),
						rt.create_array([rt.ArrayItem{ key: none, val: var_user_string }]),
					]),
				]),
			]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_order_data_after_order_details'),
		var_order.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Billing'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Edit'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Load billing address'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_2 := iife_temp_2.get_user_in_current_site(rt.call_method(var_order,
		'get_user_id', []rt.PhpVal{}))
	var_user = iife_result_2
	mut var_details_not_available_message := rt.call_function('__', [
		rt.new_string('Details are not available for this customer as this user does not exist in the current site.'),
		rt.new_string('woocommerce'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order, 'get_user_id', []rt.PhpVal{}), rt.new_int(0)))))
		&& rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		print('<p>' +
			(rt.call_function('esc_html', [var_details_not_available_message.clone()])).str() +
			'</p>')
	} else {
		if rt.is_true(rt.call_method(var_order, 'get_formatted_billing_address', []rt.PhpVal{})) {
			print('<p>' +
				(rt.call_function('wp_kses', [rt.call_method(var_order, 'get_formatted_billing_address', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{
				key: 'br'
				val: rt.new_array()
			}])])).str() +
				'</p>')
		} else {
			print('<p class="none_set"><strong>' +
				(rt.call_function('esc_html__', [rt.new_string('Address:'), rt.new_string('woocommerce')])).str() +
				'</strong> ' +
				(rt.call_function('esc_html__', [rt.new_string('No billing address set.'), rt.new_string('woocommerce')])).str() +
				'</p>')
		}
		mut var_billing_fields := Class_WC_Meta_Box_Order_Data.get_billing_fields(var_order.to_bool(),
			'view')
		mut iter_2 := var_billing_fields.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_field := item_2.val
			mut var_key := item_2.key
			if var_field.array_isset(rt.new_string('show'))
				&& rt.is_true(rt.identical(rt.new_bool(false), var_field.array_get(rt.new_string('show')))) {
				continue
			}
			mut var_field_name := rt.new_string('billing_' + var_key.str())
			if var_field.array_isset(rt.new_string('value')) {
				mut var_field_value := var_field.array_get(rt.new_string('value'))
			} else if rt.is_true(rt.call_function('is_callable', [
				rt.create_array([rt.ArrayItem{ key: none, val: var_order },
					rt.ArrayItem{ key: none, val: 'get_' + var_field_name.str() }]),
			]))
			{
				var_field_value = rt.call_method(var_order, 'get_${var_field_name.to_string()}', [
					rt.new_string('edit'),
				])
			} else {
				var_field_value = rt.call_method(var_order, 'get_meta', [
					rt.new_string('_' + var_field_name.str()),
				])
			}
			if rt.is_true(rt.identical(rt.new_string('billing_phone'), var_field_name)) {
				var_field_value = rt.call_function('wc_make_phone_clickable', [
					var_field_value.clone(),
				])
			} else if rt.is_true(rt.identical(rt.new_string('billing_email'), var_field_name)) {
				var_field_value = rt.new_string('<a href="' +
					(rt.call_function('esc_url', [rt.new_string('mailto:' + var_field_value.str())])).str() +
					'">' + var_field_value.str() + '</a>')
			} else {
				var_field_value = rt.call_function('make_clickable', [
					rt.call_function('esc_html', [var_field_value.clone()]),
				])
			}
			if rt.is_true(var_field_value)
				|| rt.is_true(rt.identical(rt.new_string('0'), var_field_value)) {
				print('<p><strong>' +
					(rt.call_function('esc_html', [var_field.array_get(rt.new_string('label'))])).str() +
					':</strong> ' +
					(rt.call_function('wp_kses_post', [var_field_value.clone()])).str() + '</p>')
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	var_billing_fields = Class_WC_Meta_Box_Order_Data.get_billing_fields(var_order.to_bool(),
		'edit')
	mut iter_3 := var_billing_fields.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_field := item_3.val
		mut var_key := item_3.key
		if !(var_field.array_isset(rt.new_string('type'))) {
			var_field.array_set('type', 'text')
		}
		if !(var_field.array_isset(rt.new_string('id'))) {
			var_field.array_set('id', '_billing_' + var_key.str())
		}
		mut var_field_name := rt.new_string('billing_' + var_key.str())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order, 'get_user_id', []rt.PhpVal{}), rt.new_int(0)))))
			&& rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
			var_field.array_set('value', '')
		} else if !(var_field.array_isset(rt.new_string('value'))) {
			if rt.is_true(rt.call_function('is_callable', [
				rt.create_array([rt.ArrayItem{ key: none, val: var_order },
					rt.ArrayItem{ key: none, val: 'get_' + var_field_name.str() }]),
			]))
			{
				var_field.array_set('value', rt.call_method(var_order,
					'get_${var_field_name.to_string()}', [rt.new_string('edit')]))
			} else {
				var_field.array_set('value', rt.call_method(var_order, 'get_meta', [
					rt.new_string('_' + var_field_name.str()),
				]))
			}
		}
		mut switch_val_1 := var_field.array_get(rt.new_string('type'))
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('select'))) {
			rt.call_function('woocommerce_wp_select', [var_field.clone(),
				var_order.clone()])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('checkbox'))) {
			rt.call_function('woocommerce_wp_checkbox', [var_field.clone(),
				var_order.clone()])
		} else {
			rt.call_function('woocommerce_wp_text_input', [var_field.clone(),
				var_order.clone()])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Payment method:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('N/A'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_found_method := rt.new_bool(false)
	mut iter_4 := var_payment_gateways.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_gateway := item_4.val
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_gateway, 'enabled'))) {
			print('<option value="' +
				(rt.call_function('esc_attr', [rt.get_property(var_gateway, 'id')])).str() + '" ' +
				(rt.call_function('selected', [var_payment_method.clone(), rt.get_property(var_gateway, 'id'), rt.new_bool(false)])).str() +
				'>' +
				(rt.call_function('esc_html', [rt.call_method(var_gateway, 'get_title', []rt.PhpVal{})])).str() +
				'</option>')
			if rt.is_true(rt.identical(var_payment_method, rt.get_property(var_gateway, 'id'))) {
				var_found_method = rt.new_bool(true)
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_found_method))))
		&& !(!rt.is_true(var_payment_method)) {
		print('<option value="' +
			(rt.call_function('esc_attr', [var_payment_method.clone()])).str() +
			'" selected="selected">' +
			(rt.call_function('esc_html__', [rt.new_string('Other'), rt.new_string('woocommerce')])).str() +
			'</option>')
	} else {
		print('<option value="other">' +
			(rt.call_function('esc_html__', [rt.new_string('Other'), rt.new_string('woocommerce')])).str() +
			'</option>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('woocommerce_wp_text_input', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: '_transaction_id' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Transaction ID'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'value', val: rt.call_method(var_order, 'get_transaction_id', [
				rt.new_string('edit'),
			]) }]),
		var_order.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_order_data_after_billing_address'),
		var_order.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Shipping'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Edit'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Load shipping address'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Copy billing address'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order, 'get_user_id', []rt.PhpVal{}), rt.new_int(0)))))
		&& rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		print('<p>' +
			(rt.call_function('esc_html', [var_details_not_available_message.clone()])).str() +
			'</p>')
	} else {
		if rt.is_true(rt.call_method(var_order, 'get_formatted_shipping_address', []rt.PhpVal{})) {
			print('<p>' +
				(rt.call_function('wp_kses', [rt.call_method(var_order, 'get_formatted_shipping_address', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{
				key: 'br'
				val: rt.new_array()
			}])])).str() +
				'</p>')
		} else {
			print('<p class="none_set"><strong>' +
				(rt.call_function('esc_html__', [rt.new_string('Address:'), rt.new_string('woocommerce')])).str() +
				'</strong> ' +
				(rt.call_function('esc_html__', [rt.new_string('No shipping address set.'), rt.new_string('woocommerce')])).str() +
				'</p>')
		}
		mut var_shipping_fields := Class_WC_Meta_Box_Order_Data.get_shipping_fields(var_order.to_bool(),
			'view')
		if !(!rt.is_true(var_shipping_fields)) {
			mut iter_5 := var_shipping_fields.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_field := item_5.val
				mut var_key := item_5.key
				if var_field.array_isset(rt.new_string('show'))
					&& rt.is_true(rt.identical(rt.new_bool(false), var_field.array_get(rt.new_string('show')))) {
					continue
				}
				mut var_field_name := rt.new_string('shipping_' + var_key.str())
				if var_field.array_isset(rt.new_string('value')) {
					mut var_field_value := var_field.array_get(rt.new_string('value'))
				} else if rt.is_true(rt.call_function('is_callable', [
					rt.create_array([rt.ArrayItem{ key: none, val: var_order },
						rt.ArrayItem{ key: none, val: 'get_' + var_field_name.str() }]),
				]))
				{
					var_field_value = rt.call_method(var_order,
						'get_${var_field_name.to_string()}', [
						rt.new_string('edit')])
				} else {
					var_field_value = rt.call_method(var_order, 'get_meta', [
						rt.new_string('_' + var_field_name.str()),
					])
				}
				if rt.is_true(rt.identical(rt.new_string('shipping_phone'), var_field_name)) {
					var_field_value = rt.call_function('wc_make_phone_clickable', [
						var_field_value.clone(),
					])
				}
				if rt.is_true(var_field_value)
					|| rt.is_true(rt.identical(rt.new_string('0'), var_field_value)) {
					print('<p><strong>' +
						(rt.call_function('esc_html', [var_field.array_get(rt.new_string('label'))])).str() +
						':</strong> ' +
						(rt.call_function('wp_kses_post', [var_field_value.clone()])).str() + '</p>')
				}
			}
		}
		if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_enable_order_notes_field'), rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_enable_order_comments'), rt.new_string('yes')]))]))
			&& rt.is_true(rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})) {
			print('<p class="order_note"><strong>' +
				(rt.call_function('esc_html', [rt.call_function('__', [rt.new_string('Customer provided note:'), rt.new_string('woocommerce')])])).str() +
				'</strong> ' +
				(rt.call_function('wp_kses', [rt.call_function('nl2br', [rt.call_function('esc_html', [rt.call_function('wc_wptexturize_order_note', [rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{})])])]), rt.create_array([rt.ArrayItem{
				key: 'br'
				val: rt.new_array()
			}])])).str() +
				'</p>')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	var_shipping_fields = Class_WC_Meta_Box_Order_Data.get_shipping_fields(var_order.to_bool(),
		'edit')
	if !(!rt.is_true(var_shipping_fields)) {
		mut iter_6 := var_shipping_fields.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_field := item_6.val
			mut var_key := item_6.key
			if !(var_field.array_isset(rt.new_string('type'))) {
				var_field.array_set('type', 'text')
			}
			if !(var_field.array_isset(rt.new_string('id'))) {
				var_field.array_set('id', '_shipping_' + var_key.str())
			}
			mut var_field_name := rt.new_string('shipping_' + var_key.str())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order, 'get_user_id', []rt.PhpVal{}), rt.new_int(0)))))
				&& rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
				var_field.array_set('value', '')
			} else if !(var_field.array_isset(rt.new_string('value'))) {
				if rt.is_true(rt.call_function('is_callable', [
					rt.create_array([rt.ArrayItem{ key: none, val: var_order },
						rt.ArrayItem{ key: none, val: 'get_' + var_field_name.str() }]),
				]))
				{
					var_field.array_set('value', rt.call_method(var_order,
						'get_${var_field_name.to_string()}', [
						rt.new_string('edit')]))
				} else {
					var_field.array_set('value', rt.call_method(var_order, 'get_meta', [
						rt.new_string('_' + var_field_name.str()),
					]))
				}
			}
			mut switch_val_2 := var_field.array_get(rt.new_string('type'))
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('select'))) {
				rt.call_function('woocommerce_wp_select', [var_field.clone(),
					var_order.clone()])
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('checkbox'))) {
				rt.call_function('woocommerce_wp_checkbox', [
					var_field.clone(), var_order.clone()])
			} else {
				rt.call_function('woocommerce_wp_text_input', [
					var_field.clone(), var_order.clone()])
			}
		}
	}
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_enable_order_notes_field'),
		rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_enable_order_comments'),
			rt.new_string('yes'),
		])),
	]))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Customer provided note'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Customer notes about the order'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses', [
			rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{}),
			rt.create_array([rt.ArrayItem{ key: 'br', val: rt.new_array() }]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_admin_order_data_after_shipping_address'),
		var_order.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WC_Meta_Box_Order_Data.save(var_order_id rt.PhpVal) {
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('order_status'))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Order status is missing.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
	}
	if !(rt.get_superglobal('_POST').array_isset(rt.new_string('_payment_method'))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Payment method is missing.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
	}
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{})
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	mut var_props := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}))))) {
		var_props['order_key'] = rt.call_function('wc_generate_order_key', []rt.PhpVal{})
	}
	mut var_customer_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('customer_user')) { rt.call_function('absint', [
			rt.get_superglobal('_POST').array_get(rt.new_string('customer_user')),
		]) } else { rt.new_int(0) }
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_3 := iife_temp_3.get_user_in_current_site(var_customer_id.clone())
	mut var_selected_customer := iife_result_3
	mut var_is_valid_guest_or_new_customer := rt.new_bool(
		rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_customer_id, rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{})))))
		&& rt.is_true(rt.identical(rt.new_int(0), var_customer_id))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_selected_customer.clone()]))))))
	if rt.is_true(var_is_valid_guest_or_new_customer) {
		var_props['customer_id'] = var_customer_id.clone()
	}
	mut var_billing_fields := Class_WC_Meta_Box_Order_Data.get_billing_fields(var_order.to_bool(),
		'edit')
	mut var_save_metadata_for_guest_user_or_a_valid_user := rt.new_bool(
		rt.is_true(rt.identical(rt.new_int(0), var_customer_id))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_selected_customer.clone()]))))))
	if !(!rt.is_true(var_billing_fields))
		&& rt.is_true(var_save_metadata_for_guest_user_or_a_valid_user) {
		mut iter_7 := var_billing_fields.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_field := item_7.val
			mut var_key := item_7.key
			if !(var_field.array_isset(rt.new_string('id'))) {
				var_field.array_set('id', '_billing_' + var_key.str())
			}
			if !(rt.get_superglobal('_POST').array_isset(var_field.array_get(rt.new_string('id')))) {
				continue
			}
			mut var_value := rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(var_field.array_get(rt.new_string('id'))),
				]),
			])
			if var_field.array_isset(rt.new_string('update_callback')) {
				rt.call_function('call_user_func', [
					var_field.array_get(rt.new_string('update_callback')),
					var_field.array_get(rt.new_string('id')),
					var_value.clone(),
					var_order.clone(),
				])
			} else if rt.is_true(rt.call_function('is_callable', [
				rt.create_array([rt.ArrayItem{ key: none, val: var_order },
					rt.ArrayItem{ key: none, val: 'set_billing_' + var_key.str() }]),
			]))
			{
				var_props['billing_' + var_key.str()] = var_value.clone()
			} else {
				rt.call_method(var_order, 'update_meta_data', [
					var_field.array_get(rt.new_string('id')),
					var_value.clone(),
				])
			}
		}
	}
	mut var_shipping_fields := Class_WC_Meta_Box_Order_Data.get_shipping_fields(var_order.to_bool(),
		'edit')
	if !(!rt.is_true(var_shipping_fields))
		&& rt.is_true(var_save_metadata_for_guest_user_or_a_valid_user) {
		mut iter_8 := var_shipping_fields.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_field := item_8.val
			mut var_key := item_8.key
			if !(var_field.array_isset(rt.new_string('id'))) {
				var_field.array_set('id', '_shipping_' + var_key.str())
			}
			if !(rt.get_superglobal('_POST').array_isset(var_field.array_get(rt.new_string('id')))) {
				continue
			}
			mut var_value := if rt.get_superglobal('_POST').array_isset(var_field.array_get(rt.new_string('id'))) { rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_POST').array_get(var_field.array_get(rt.new_string('id'))),
					]),
				]) } else { rt.new_string('') }
			if var_field.array_isset(rt.new_string('update_callback')) {
				rt.call_function('call_user_func', [
					var_field.array_get(rt.new_string('update_callback')),
					var_field.array_get(rt.new_string('id')),
					var_value.clone(),
					var_order.clone(),
				])
			} else if rt.is_true(rt.call_function('is_callable', [
				rt.create_array([rt.ArrayItem{ key: none, val: var_order },
					rt.ArrayItem{ key: none, val: 'set_shipping_' + var_key.str() }]),
			]))
			{
				var_props['shipping_' + var_key.str()] = var_value.clone()
			} else {
				rt.call_method(var_order, 'update_meta_data', [
					var_field.array_get(rt.new_string('id')),
					var_value.clone(),
				])
			}
		}
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('_transaction_id')) {
		var_props['transaction_id'] = rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('_transaction_id')),
			]),
		])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order,
		'get_payment_method', []rt.PhpVal{}), rt.call_function('wc_clean', [
		rt.call_function('wp_unslash',
			[rt.get_superglobal('_POST').array_get(rt.new_string('_payment_method'))]),
	])))))
	{
		mut var_methods := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'payment_gateways'), 'payment_gateways', []rt.PhpVal{})
		mut var_payment_method := rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('_payment_method')),
			]),
		])
		mut var_payment_method_title := var_payment_method.clone()
		if !var_methods.is_null() && var_methods.array_isset(var_payment_method) {
			var_payment_method_title = rt.call_method(var_methods.array_get(var_payment_method),
				'get_title', []rt.PhpVal{})
		}
		if rt.is_true(rt.identical(rt.new_string('other'), var_payment_method)) {
			var_payment_method_title = rt.call_function('esc_html__', [
				rt.new_string('Other'),
				rt.new_string('woocommerce'),
			])
		}
		var_props['payment_method'] = var_payment_method.clone()
		var_props['payment_method_title'] = var_payment_method_title.clone()
	}
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('order_date'))) {
		mut var_date := rt.call_function('time', []rt.PhpVal{})
	} else {
		if !(rt.get_superglobal('_POST').array_isset(rt.new_string('order_date_hour')))
			|| !(rt.get_superglobal('_POST').array_isset(rt.new_string('order_date_minute')))
			|| !(rt.get_superglobal('_POST').array_isset(rt.new_string('order_date_second'))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
				rt.new_string('Order date, hour, minute and/or second are missing.'),
				rt.new_string('woocommerce'),
			]), rt.new_int(400))))
		}
		var_date = rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
			rt.call_function('strtotime', [
				rt.new_string(
					(rt.get_superglobal('_POST').array_get(rt.new_string('order_date'))).str() + ' ' + rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('order_date_hour'))).to_i64()).str() +
					':' +
					rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('order_date_minute'))).to_i64()).str() +
					':' +
					rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('order_date_second'))).to_i64()).str()),
			])])
	}
	var_props['date_created'] = var_date.clone()
	if rt.get_superglobal('_POST').array_isset(rt.new_string('original_post_status'))
		&& rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft(), rt.get_superglobal('_POST').array_get(rt.new_string('original_post_status')))) {
		var_props['created_via'] = rt.new_string('admin')
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('customer_note')) {
		var_props['customer_note'] = rt.call_function('sanitize_textarea_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('customer_note'))]),
		])
	}
	rt.call_method(var_order, 'set_props', [rt.create_array_from_native_map(var_props)])
	rt.call_method(var_order, 'set_status', [
		rt.call_function('wc_clean', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('order_status'))]),
		]),
		rt.new_string(''),
		rt.new_bool(true),
	])
	rt.call_method(var_order, 'save', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
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

fn create_wc_meta_box_order_data(_args ...rt.PhpVal) &Class_WC_Meta_Box_Order_Data {
	mut obj := &Class_WC_Meta_Box_Order_Data{
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

fn create_automattic_woocommerce_internal_utilities_users(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
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

fn (mut this Class_WC_Meta_Box_Order_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_billing_fields' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WC_Meta_Box_Order_Data.get_billing_fields(dispatch_arg_0, dispatch_arg_1)
		}
		'get_shipping_fields' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WC_Meta_Box_Order_Data.get_shipping_fields(dispatch_arg_0, dispatch_arg_1)
		}
		'init_address_fields' {
			Class_WC_Meta_Box_Order_Data.init_address_fields()
			return rt.new_null()
		}
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Meta_Box_Order_Data.output(dispatch_arg_0)
			return rt.new_null()
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Meta_Box_Order_Data.save(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Meta_Box_Order_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Box_Order_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
