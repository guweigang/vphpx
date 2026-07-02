import rt

struct Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_settings_pointofsaledefaultsettings(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_email := rt.new_null()
	mut var_order := rt.new_null()
	mut var_set_password_url := rt.new_null()
	mut var_reset_key := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_user_login := rt.new_null()
	mut var_sent_to_admin := rt.new_null()
	mut var_plain_text := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.identical(rt.new_string('customer_invoice'), rt.get_property(var_email, 'id'))) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_method(var_order, 'needs_payment', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.call_method(var_order, 'has_status', [
				Class_Automattic_WooCommerce_Enums_OrderStatus.failed(),
			]))
			{
				rt.call_function('printf', [
					rt.call_function('wp_kses', [
						rt.call_function('__', [
							rt.new_string('Sorry, your order on %1$s was unsuccessful. Your order details are below, with a link to try your payment again: %2$s'),
							rt.new_string('woocommerce'),
						]),
						rt.create_array([
							rt.ArrayItem{ key: 'a', val: rt.create_array([
								rt.ArrayItem{ key: 'href', val: rt.new_array() },
							]) },
						]),
					]),
					rt.call_function('esc_html', [
						rt.call_function('get_bloginfo', [
							rt.new_string('name'),
							rt.new_string('display'),
						]),
					]),
					rt.new_string('<a href="' +
						(rt.call_function('esc_url', [rt.call_method(var_order, 'get_checkout_payment_url', []rt.PhpVal{})])).str() +
						'">' +
						(rt.call_function('esc_html__', [rt.new_string('Pay for this order'), rt.new_string('woocommerce')])).str() +
						'</a>'),
				])
			} else {
				rt.call_function('printf', [
					rt.call_function('wp_kses', [
						rt.call_function('__', [
							rt.new_string('An order has been created for you on %1$s. Your order details are below, with a link to make payment when you’re ready: %2$s'),
							rt.new_string('woocommerce'),
						]),
						rt.create_array([
							rt.ArrayItem{ key: 'a', val: rt.create_array([
								rt.ArrayItem{ key: 'href', val: rt.new_array() },
							]) },
						]),
					]),
					rt.call_function('esc_html', [
						rt.call_function('get_bloginfo', [
							rt.new_string('name'),
							rt.new_string('display'),
						]),
					]),
					rt.new_string('<a href="' +
						(rt.call_function('esc_url', [rt.call_method(var_order, 'get_checkout_payment_url', []rt.PhpVal{})])).str() +
						'">' +
						(rt.call_function('esc_html__', [rt.new_string('Pay for this order'), rt.new_string('woocommerce')])).str() +
						'</a>'),
				])
			}
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('esc_html__', [
					rt.new_string('Here are the details of your order placed on %s:'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.call_function('wc_format_datetime', [
						rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}),
					]),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
		}
	}
	if rt.is_true(rt.identical(rt.new_string('customer_new_account'), rt.get_property(var_email,
		'id')))
	{
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_set_password_url) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_set_password_url.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('esc_html__', [rt.new_string('Set your new password.'),
					rt.new_string('woocommerce')]),
			])
			// unsupported statement: Stmt_InlineHTML
		}
	}
	if rt.is_true(rt.identical(rt.new_string('customer_reset_password'), rt.get_property(var_email, 'id')))
		&& !var_reset_key.is_null() && !var_user_id.is_null() {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'key', val: var_reset_key },
					rt.ArrayItem{ key: 'id', val: var_user_id },
					rt.ArrayItem{ key: 'login', val: rt.call_function('rawurlencode', [
						var_user_login.clone(),
					]) }]),
				rt.call_function('wc_get_endpoint_url', [rt.new_string('lost-password'),
					rt.new_string(''),
					rt.call_function('wc_get_page_permalink', [
						rt.new_string('myaccount'),
					])]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Reset your password'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_email_general_block_content'),
		var_sent_to_admin.clone(),
		var_plain_text.clone(),
		var_email.clone(),
	])
	mut var_emails_without_order_details := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_emails_general_block_content_emails_without_order_details'),
		rt.new_array(),
	])
	mut var_accounts_related_emails := ['customer_reset_password', 'customer_new_account']
	var_emails_without_order_details = rt.call_function('array_merge', [if !var_emails_without_order_details.is_null() {
		var_emails_without_order_details
	} else {
		rt.new_array()
	}, rt.create_array_from_list(var_accounts_related_emails)])
	if !var_order.is_null()
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_email, 'id'), var_emails_without_order_details.clone(), rt.new_bool(true)]))))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_email_order_details'),
			var_order.clone(), var_sent_to_admin.clone(), var_plain_text.clone(),
			var_email.clone()])
		rt.call_function('do_action', [rt.new_string('woocommerce_email_order_meta'),
			var_order.clone(), var_sent_to_admin.clone(), var_plain_text.clone(),
			var_email.clone()])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_email_customer_details'),
			var_order.clone(),
			var_sent_to_admin.clone(),
			var_plain_text.clone(),
			var_email.clone(),
		])
	}
	if rt.is_true(rt.identical(rt.new_string('customer_pos_completed_order'), rt.get_property(var_email, 'id')))
		|| rt.is_true(rt.identical(rt.new_string('customer_pos_refunded_order'), rt.get_property(var_email, 'id'))) {
		mut iife_temp_0 :=
			Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
		mut iife_result_0 := iife_temp_0.get_default_store_email()
		mut iife_temp_1 :=
			Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
		mut iife_result_1 := iife_temp_1.get_default_store_address()
		if !(!rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_pos_store_email'), iife_result_0])))
			|| !(!rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_pos_store_phone')])))
			|| !(!rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_pos_store_address'), iife_result_1]))) {
			// unsupported statement: Stmt_InlineHTML
			mut iife_temp_2 :=
				Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
			mut iife_result_2 := iife_temp_2.get_default_store_name()
			if !(!rt.is_true(rt.call_function('get_option', [
				rt.new_string('woocommerce_pos_store_name'),
				iife_result_2,
			]))) {
				// unsupported statement: Stmt_InlineHTML
				mut iife_temp_3 :=
					Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
				mut iife_result_3 := iife_temp_3.get_default_store_name()
				mut iife_temp_4 :=
					Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
				mut iife_result_4 := iife_temp_4.get_default_store_name()
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('get_option', [
						rt.new_string('woocommerce_pos_store_name'),
						iife_result_3,
					]),
				]))
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html__', [
					rt.new_string('Store Information'),
					rt.new_string('woocommerce'),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			mut iife_temp_5 :=
				Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
			mut iife_result_5 := iife_temp_5.get_default_store_email()
			if !(!rt.is_true(rt.call_function('get_option', [
				rt.new_string('woocommerce_pos_store_email'),
				iife_result_5,
			]))) {
				// unsupported statement: Stmt_InlineHTML
				mut iife_temp_6 :=
					Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
				mut iife_result_6 := iife_temp_6.get_default_store_email()
				mut iife_temp_7 :=
					Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
				mut iife_result_7 := iife_temp_7.get_default_store_email()
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('get_option', [
						rt.new_string('woocommerce_pos_store_email'),
						iife_result_6,
					]),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			if !(!rt.is_true(rt.call_function('get_option', [
				rt.new_string('woocommerce_pos_store_phone'),
			]))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('get_option', [
						rt.new_string('woocommerce_pos_store_phone'),
					]),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			mut iife_temp_8 :=
				Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
			mut iife_result_8 := iife_temp_8.get_default_store_address()
			if !(!rt.is_true(rt.call_function('get_option', [
				rt.new_string('woocommerce_pos_store_address'),
				iife_result_8,
			]))) {
				// unsupported statement: Stmt_InlineHTML
				mut iife_temp_9 :=
					Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
				mut iife_result_9 := iife_temp_9.get_default_store_address()
				mut iife_temp_10 :=
					Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
				mut iife_result_10 := iife_temp_10.get_default_store_address()
				rt.echo_val(rt.call_function('esc_html', [
					rt.call_function('get_option', [
						rt.new_string('woocommerce_pos_store_address'),
						iife_result_9,
					]),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		if !(!rt.is_true(rt.call_function('get_option', [
			rt.new_string('woocommerce_pos_refund_returns_policy'),
		]))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html__', [
				rt.new_string('Refund & Returns Policy'),
				rt.new_string('woocommerce'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				rt.call_function('get_option', [
					rt.new_string('woocommerce_pos_refund_returns_policy'),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
}
