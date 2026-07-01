import rt

struct Class_WC_Gateway_Paypal_Request {
	rt.PhpObjectBase
pub mut:
		line_items rt.PhpVal = rt.new_array()
		gateway rt.PhpVal = rt.new_null()
		notify_url rt.PhpVal = rt.new_null()
		endpoint string
		request rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Gateway_Paypal_Request) construct(var_gateway rt.PhpVal)  {
	this.gateway = var_gateway.dup()
	this.notify_url = rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'api_request_url', [rt.new_string('WC_Gateway_Paypal')])
	this.request = create_automattic_woocommerce_gateways_paypal_request(var_gateway.dup())
}

fn (mut this Class_WC_Gateway_Paypal_Request) get_request_url(var_order rt.PhpVal, sandbox bool) string {
	this.endpoint = if var_sandbox { 'https://www.sandbox.paypal.com/cgi-bin/webscr?test_ipn=1&' } else { 'https://www.paypal.com/cgi-bin/webscr?' }
	mut var_paypal_args := this.get_paypal_args(var_order.dup())
	var_paypal_args.array_set('bn', 'WooThemes_Cart')
	mut var_mask := { 'first_name': '***', 'last_name': '***', 'address1': '***', 'address2': '***', 'city': '***', 'state': '***', 'zip': '***', 'country': '***', 'email': '***@***', 'night_phone_a': '***', 'night_phone_b': '***', 'night_phone_c': '***' }
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('PayPal Request Args for order ' + (rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})).str() + ': ' + (rt.call_function('wc_print_r', [rt.call_function('array_merge', [var_paypal_args.dup(), rt.call_function('array_intersect_key', [var_mask.dup(), var_paypal_args.dup()])]), rt.new_bool(true)])).str()))
	return this.endpoint + (rt.call_function('http_build_query', [var_paypal_args.dup(), rt.new_string(''), rt.new_string('&')])).str()
}

fn (mut this Class_WC_Gateway_Paypal_Request) create_paypal_order(var_order rt.PhpVal, var_payment_source rt.PhpVal, var_js_sdk_params rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('10.5.0'), rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Request::create_paypal_order()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.request)))) {
		this.request = create_automattic_woocommerce_gateways_paypal_request(this.gateway)
	}
	return rt.call_method(this.request, 'create_paypal_order', [var_order.dup(), var_payment_source.dup(), var_js_sdk_params.dup()])
}

fn (mut this Class_WC_Gateway_Paypal_Request) get_paypal_order_details(var_paypal_order_id rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('10.5.0'), rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Request::get_paypal_order_details()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.request)))) {
		this.request = create_automattic_woocommerce_gateways_paypal_request(this.gateway)
	}
	return rt.call_method(this.request, 'get_paypal_order_details', [var_paypal_order_id.dup()])
}

fn (mut this Class_WC_Gateway_Paypal_Request) authorize_or_capture_payment(var_order rt.PhpVal, var_action_url rt.PhpVal, var_action rt.PhpVal)  {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('10.5.0'), rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Request::authorize_or_capture_payment()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.request)))) {
		this.request = create_automattic_woocommerce_gateways_paypal_request(this.gateway)
	}
	rt.call_method(this.request, 'authorize_or_capture_payment', [var_order.dup(), var_action_url.dup(), var_action.dup()])
}

fn (mut this Class_WC_Gateway_Paypal_Request) capture_authorized_payment(var_order rt.PhpVal)  {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('10.5.0'), rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Request::capture_authorized_payment()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.request)))) {
		this.request = create_automattic_woocommerce_gateways_paypal_request(this.gateway)
	}
	rt.call_method(this.request, 'capture_authorized_payment', [var_order.dup()])
}

fn (mut this Class_WC_Gateway_Paypal_Request) get_paypal_order_purchase_unit_amount(var_order rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('10.5.0'), rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Request::get_paypal_order_purchase_unit_amount()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.request)))) {
		this.request = create_automattic_woocommerce_gateways_paypal_request(this.gateway)
	}
	return rt.call_method(this.request, 'get_paypal_order_purchase_unit_amount', [var_order.dup()])
}

fn (mut this Class_WC_Gateway_Paypal_Request) fetch_paypal_client_id() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('10.5.0'), rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Request::fetch_paypal_client_id()')])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.request)))) {
		this.request = create_automattic_woocommerce_gateways_paypal_request(this.gateway)
	}
	return rt.call_method(this.request, 'fetch_paypal_client_id', []rt.PhpVal{})
}

fn (mut this Class_WC_Gateway_Paypal_Request) limit_length(var_string rt.PhpVal, limit i64) rt.PhpVal {
	mut var_string_mutated := var_string
	mut var_str_limit := rt.new_int(limit - 3)
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_strimwidth')])) {
		if rt.is_true(rt.greater(rt.call_function('mb_strlen', [var_string_mutated.dup()]), rt.new_int(limit))) {
			var_string_mutated = rt.new_string((rt.call_function('mb_strimwidth', [var_string_mutated.dup(), rt.new_int(0), var_str_limit.dup()])).str() + '...')
		}
	} else if var_string_mutated.dup().to_string().len > limit {
		var_string_mutated = rt.new_string((rt.call_function('substr', [var_string_mutated.dup(), rt.new_int(0), var_str_limit.dup()])).str() + '...')
	}
	return var_string_mutated.dup()
}

fn (mut this Class_WC_Gateway_Paypal_Request) get_transaction_args(var_order rt.PhpVal) rt.PhpVal {
	return rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'cmd', val: '_cart' }, rt.ArrayItem{ key: 'business', val: rt.call_method(this.gateway, 'get_option', [rt.new_string('email')]) }, rt.ArrayItem{ key: 'no_note', val: 1 }, rt.ArrayItem{ key: 'currency_code', val: rt.call_function('get_woocommerce_currency', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'charset', val: 'utf-8' }, rt.ArrayItem{ key: 'rm', val: if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) { 2 } else { 1 } }, rt.ArrayItem{ key: 'upload', val: 1 }, rt.ArrayItem{ key: 'return', val: rt.call_function('esc_url_raw', [rt.call_function('add_query_arg', [rt.new_string('utm_nooverride'), rt.new_string('1'), rt.call_method(this.gateway, 'get_return_url', [var_order.dup()])])]) }, rt.ArrayItem{ key: 'cancel_return', val: rt.call_function('esc_url_raw', [rt.call_method(var_order, 'get_cancel_order_url_raw', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'image_url', val: rt.call_function('esc_url_raw', [rt.call_method(this.gateway, 'get_option', [rt.new_string('image_url')])]) }, rt.ArrayItem{ key: 'paymentaction', val: rt.call_method(this.gateway, 'get_option', [rt.new_string('paymentaction')]) }, rt.ArrayItem{ key: 'invoice', val: this.limit_length(rt.new_string((rt.call_method(this.gateway, 'get_option', [rt.new_string('invoice_prefix')])).str() + (rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})).str()), (Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_invoice_id_max_length()).to_i64()) }, rt.ArrayItem{ key: 'custom', val: rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'order_key', val: rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}) }])]) }, rt.ArrayItem{ key: 'notify_url', val: this.limit_length(this.notify_url, 255) }, rt.ArrayItem{ key: 'first_name', val: this.limit_length(rt.call_method(var_order, 'get_billing_first_name', []rt.PhpVal{}), 32) }, rt.ArrayItem{ key: 'last_name', val: this.limit_length(rt.call_method(var_order, 'get_billing_last_name', []rt.PhpVal{}), 64) }, rt.ArrayItem{ key: 'address1', val: this.limit_length(rt.call_method(var_order, 'get_billing_address_1', []rt.PhpVal{}), 100) }, rt.ArrayItem{ key: 'address2', val: this.limit_length(rt.call_method(var_order, 'get_billing_address_2', []rt.PhpVal{}), 100) }, rt.ArrayItem{ key: 'city', val: this.limit_length(rt.call_method(var_order, 'get_billing_city', []rt.PhpVal{}), 40) }, rt.ArrayItem{ key: 'state', val: this.get_paypal_state(rt.call_method(var_order, 'get_billing_country', []rt.PhpVal{}), rt.call_method(var_order, 'get_billing_state', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'zip', val: this.limit_length(rt.call_function('wc_format_postcode', [rt.call_method(var_order, 'get_billing_postcode', []rt.PhpVal{}), rt.call_method(var_order, 'get_billing_country', []rt.PhpVal{})]), 32) }, rt.ArrayItem{ key: 'country', val: this.limit_length(rt.call_method(var_order, 'get_billing_country', []rt.PhpVal{}), 2) }, rt.ArrayItem{ key: 'email', val: this.limit_length(rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{}), 0) }]), this.get_phone_number_args(var_order.dup()), this.get_shipping_args(var_order.dup())])
}

fn (mut this Class_WC_Gateway_Paypal_Request) fix_request_length(var_order rt.PhpVal, var_paypal_args rt.PhpVal) rt.PhpVal {
	mut var_paypal_args_mutated := var_paypal_args
	mut var_max_paypal_length := rt.new_int(rt.new_int(2083))
	mut var_query_candidate := rt.call_function('http_build_query', [var_paypal_args_mutated.dup(), rt.new_string(''), rt.new_string('&')])
	if rt.is_true(rt.less_equal(rt.new_int(this.endpoint + (var_query_candidate).str().len), var_max_paypal_length)) {
		return var_paypal_args_mutated.dup()
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_paypal_args'), rt.call_function('array_merge', [this.get_transaction_args(var_order.dup()), this.get_line_item_args(var_order.dup(), true)]), var_order.dup()])
}

fn (mut this Class_WC_Gateway_Paypal_Request) get_paypal_args(var_order rt.PhpVal) rt.PhpVal {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Gateway_Paypal{}; return temp.log(arg_0) }(rt.new_string('Generating payment form for order ' + (rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})).str() + '. Notify URL: ' + (this.notify_url).str()))
	mut var_force_one_line_item := rt.call_function('apply_filters', [rt.new_string('woocommerce_paypal_force_one_line_item'), rt.new_bool(false), var_order.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) && rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{})))) || !(this.line_items_valid(var_order.dup())))) {
		var_force_one_line_item = rt.new_bool(rt.new_bool(true))
	}
	mut var_paypal_args := rt.call_function('apply_filters', [rt.new_string('woocommerce_paypal_args'), rt.call_function('array_merge', [this.get_transaction_args(var_order.dup()), this.get_line_item_args(var_order.dup(), (var_force_one_line_item).to_bool())]), var_order.dup()])
	return this.fix_request_length(var_order.dup(), var_paypal_args.dup())
}

fn (mut this Class_WC_Gateway_Paypal_Request) get_phone_number_args(var_order rt.PhpVal) rt.PhpVal {
	mut var_phone_number := rt.call_function('wc_sanitize_phone_number', [rt.call_method(var_order, 'get_billing_phone', []rt.PhpVal{})])
	if rt.is_true(rt.call_function('in_array', [rt.call_method(var_order, 'get_billing_country', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: 'US' }, rt.ArrayItem{ key: none, val: 'CA' }]), rt.new_bool(true)])) {
		var_phone_number = rt.new_string(rt.new_string(var_phone_number.dup().to_string().trim_left(' \t\n\r')))
		mut var_phone_args := { 'night_phone_a': rt.call_function('substr', [var_phone_number.dup(), rt.new_int(0), rt.new_int(3)]), 'night_phone_b': rt.call_function('substr', [var_phone_number.dup(), rt.new_int(3), rt.new_int(3)]), 'night_phone_c': rt.call_function('substr', [var_phone_number.dup(), rt.new_int(6), rt.new_int(4)]) }
	} else {
		mut var_calling_code := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_country_calling_code', [rt.call_method(var_order, 'get_billing_country', []rt.PhpVal{})])
		var_calling_code = if rt.is_true(rt.new_bool(var_calling_code.dup().is_array())) { var_calling_code.array_get(0) } else { var_calling_code }
		if rt.is_true(var_calling_code) {
			var_phone_number = rt.call_function('str_replace', [var_calling_code.dup(), rt.new_string(''), rt.call_function('preg_replace', [rt.new_string('/^0/'), rt.new_string(''), rt.call_method(var_order, 'get_billing_phone', []rt.PhpVal{})])])
		}
		var_phone_args = { 'night_phone_a': var_calling_code, 'night_phone_b': var_phone_number }
	}
	return var_phone_args.dup()
}

fn (mut this Class_WC_Gateway_Paypal_Request) get_shipping_args(var_order rt.PhpVal) rt.PhpVal {
	mut var_shipping_args := map[string]rt.PhpVal{}
	if rt.is_true(rt.call_method(var_order, 'needs_shipping_address', []rt.PhpVal{})) {
		var_shipping_args['address_override'] = if rt.is_true(rt.identical(rt.call_method(this.gateway, 'get_option', [rt.new_string('address_override')]), rt.new_string('yes'))) { rt.new_int(1) } else { rt.new_int(0) }
		var_shipping_args['no_shipping'] = rt.new_int(0)
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_method(this.gateway, 'get_option', [rt.new_string('send_shipping')]))) {
			var_shipping_args['first_name'] = this.limit_length(rt.call_method(var_order, 'get_shipping_first_name', []rt.PhpVal{}), 32)
			var_shipping_args['last_name'] = this.limit_length(rt.call_method(var_order, 'get_shipping_last_name', []rt.PhpVal{}), 64)
			var_shipping_args['address1'] = this.limit_length(rt.call_method(var_order, 'get_shipping_address_1', []rt.PhpVal{}), 100)
			var_shipping_args['address2'] = this.limit_length(rt.call_method(var_order, 'get_shipping_address_2', []rt.PhpVal{}), 100)
			var_shipping_args['city'] = this.limit_length(rt.call_method(var_order, 'get_shipping_city', []rt.PhpVal{}), 40)
			var_shipping_args['state'] = this.get_paypal_state(rt.call_method(var_order, 'get_shipping_country', []rt.PhpVal{}), rt.call_method(var_order, 'get_shipping_state', []rt.PhpVal{}))
			var_shipping_args['country'] = this.limit_length(rt.call_method(var_order, 'get_shipping_country', []rt.PhpVal{}), 2)
			var_shipping_args['zip'] = this.limit_length(rt.call_function('wc_format_postcode', [rt.call_method(var_order, 'get_shipping_postcode', []rt.PhpVal{}), rt.call_method(var_order, 'get_shipping_country', []rt.PhpVal{})]), 32)
		}
	} else {
		var_shipping_args['no_shipping'] = rt.new_int(1)
	}
	return var_shipping_args.dup()
}

fn (mut this Class_WC_Gateway_Paypal_Request) get_shipping_cost_line_item(var_order rt.PhpVal, var_force_one_line_item rt.PhpVal) rt.PhpVal {
	mut var_force_one_line_item_mutated := var_force_one_line_item
	mut var_line_item_args := map[string]rt.PhpVal{}
	mut var_shipping_total := rt.call_method(var_order, 'get_shipping_total', []rt.PhpVal{})
	if rt.is_true(var_force_one_line_item_mutated) {
		// unsupported expression: Expr_AssignOp_Plus
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.greater(rt.call_method(var_order, 'get_shipping_total', []rt.PhpVal{}), rt.new_int(0))) && rt.is_true(rt.less(rt.call_method(var_order, 'get_shipping_total', []rt.PhpVal{}), rt.new_float(999.99))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_line_item_args.array_set('shipping_1', this.number_format(var_shipping_total.dup(), var_order.dup()))
	} else if rt.is_true(rt.greater(rt.call_method(var_order, 'get_shipping_total', []rt.PhpVal{}), rt.new_int(0))) {
		this.add_line_item(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Shipping via %s'), rt.new_string('woocommerce')]), rt.call_method(var_order, 'get_shipping_method', []rt.PhpVal{})]), 1, (this.number_format(var_shipping_total.dup(), var_order.dup())).to_f64(), '')
	}
	return var_line_item_args.dup()
}

fn (mut this Class_WC_Gateway_Paypal_Request) get_line_item_args_single_item(var_order rt.PhpVal) rt.PhpVal {
	this.delete_line_items()
	mut var_all_items_name := this.get_order_item_names(var_order.dup())
	this.add_line_item(if rt.is_true(var_all_items_name) { var_all_items_name } else { rt.call_function('__', [rt.new_string('Order'), rt.new_string('woocommerce')]) }, 1, (this.number_format(rt.sub(rt.call_method(var_order, 'get_total', []rt.PhpVal{}), this.round(rt.add(rt.call_method(var_order, 'get_shipping_total', []rt.PhpVal{}), rt.call_method(var_order, 'get_shipping_tax', []rt.PhpVal{})), var_order.dup())), var_order.dup())).to_f64(), (rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})).str())
	mut var_line_item_args := this.get_shipping_cost_line_item(var_order.dup(), rt.new_bool(true))
	return rt.call_function('array_merge', [var_line_item_args.dup(), this.get_line_items()])
}

fn (mut this Class_WC_Gateway_Paypal_Request) get_line_item_args(var_order rt.PhpVal, force_one_line_item bool) rt.PhpVal {
	mut force_one_line_item_mutated := force_one_line_item
	mut var_line_item_args := map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(force_one_line_item_mutated)) {
		var_line_item_args = this.get_line_item_args_single_item(var_order.dup())
	} else {
		this.prepare_line_items(var_order.dup())
		var_line_item_args.array_set('tax_cart', this.number_format(rt.call_method(var_order, 'get_total_tax', []rt.PhpVal{}), var_order.dup()))
		if rt.is_true(rt.greater(rt.call_method(var_order, 'get_total_discount', []rt.PhpVal{}), rt.new_int(0))) {
			var_line_item_args.array_set('discount_amount_cart', this.number_format(this.round(rt.call_method(var_order, 'get_total_discount', []rt.PhpVal{}), var_order.dup()), var_order.dup()))
		}
		var_line_item_args = rt.call_function('array_merge', [var_line_item_args.dup(), this.get_shipping_cost_line_item(var_order.dup(), rt.new_bool(false))])
		var_line_item_args = rt.call_function('array_merge', [var_line_item_args.dup(), this.get_line_items()])
	}
	return var_line_item_args.dup()
}

fn (mut this Class_WC_Gateway_Paypal_Request) get_order_item_names(var_order rt.PhpVal) rt.PhpVal {
	mut var_item_names := map[string]rt.PhpVal{}
	{
		mut iter_1 := rt.call_method(var_order, 'get_items', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_item_name := rt.call_method(var_item, 'get_name', []rt.PhpVal{})
			mut var_item_meta := rt.call_function('wp_strip_all_tags', [rt.call_function('wc_display_item_meta', [var_item.dup(), rt.create_array([rt.ArrayItem{ key: 'before', val: '' }, rt.ArrayItem{ key: 'separator', val: ', ' }, rt.ArrayItem{ key: 'after', val: '' }, rt.ArrayItem{ key: 'echo', val: false }, rt.ArrayItem{ key: 'autop', val: false }])])])
			if rt.is_true(var_item_meta) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			var_item_names << (var_item_name).str() + ' x ' + (rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})).str()
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_paypal_get_order_item_names'), rt.call_function('implode', [rt.new_string(', '), var_item_names.dup()]), var_order.dup()])
}

fn (mut this Class_WC_Gateway_Paypal_Request) get_order_item_name(var_order rt.PhpVal, var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_item_name := rt.call_method(var_item_mutated, 'get_name', []rt.PhpVal{})
	mut var_item_meta := rt.call_function('wp_strip_all_tags', [rt.call_function('wc_display_item_meta', [var_item_mutated.dup(), rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }])])])
	if rt.is_true(var_item_meta) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_paypal_get_order_item_name'), var_item_name.dup(), var_order.dup(), var_item_mutated.dup()])
}

fn (mut this Class_WC_Gateway_Paypal_Request) get_line_items() rt.PhpVal {
	return this.line_items
}

fn (mut this Class_WC_Gateway_Paypal_Request) delete_line_items()  {
	
}

fn (mut this Class_WC_Gateway_Paypal_Request) line_items_valid(var_order rt.PhpVal) bool {
}

fn (mut this Class_WC_Gateway_Paypal_Request) prepare_line_items(var_order rt.PhpVal)  {
}

fn (mut this Class_WC_Gateway_Paypal_Request) add_line_item(var_item_name rt.PhpVal, quantity i64, amount f64, item_number string)  {
	mut var_item_name_mutated := var_item_name
}

fn (mut this Class_WC_Gateway_Paypal_Request) get_paypal_state(var_cc rt.PhpVal, var_state rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Gateway_Paypal_Request) currency_has_decimals(var_currency rt.PhpVal) bool {
}

fn (mut this Class_WC_Gateway_Paypal_Request) round(var_price rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Gateway_Paypal_Request) number_format(var_price rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	rt.PhpObjectBase
}

struct Class_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

fn create_wc_gateway_paypal_request(arg_0 rt.PhpVal) &Class_WC_Gateway_Paypal_Request {
	mut obj := &Class_WC_Gateway_Paypal_Request{
		PhpObjectBase: rt.PhpObjectBase{}
		line_items: rt.new_array()
		gateway: rt.new_null()
		notify_url: rt.new_null()
		endpoint: ''
		request: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_request() &Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_gateway_paypal() &Class_WC_Gateway_Paypal {
	mut obj := &Class_WC_Gateway_Paypal{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Gateway_Paypal_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_request_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.get_request_url(dispatch_arg_0, dispatch_arg_1))
		}
		'create_paypal_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.create_paypal_order(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_paypal_order_details' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_paypal_order_details(dispatch_arg_0)
		}
		'authorize_or_capture_payment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.authorize_or_capture_payment(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'capture_authorized_payment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.capture_authorized_payment(dispatch_arg_0)
			return rt.new_null()
		}
		'get_paypal_order_purchase_unit_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_paypal_order_purchase_unit_amount(dispatch_arg_0)
		}
		'fetch_paypal_client_id' {
			return this.fetch_paypal_client_id()
		}
		'limit_length' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.limit_length(dispatch_arg_0, dispatch_arg_1)
		}
		'get_transaction_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_transaction_args(dispatch_arg_0)
		}
		'fix_request_length' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.fix_request_length(dispatch_arg_0, dispatch_arg_1)
		}
		'get_paypal_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_paypal_args(dispatch_arg_0)
		}
		'get_phone_number_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_phone_number_args(dispatch_arg_0)
		}
		'get_shipping_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_shipping_args(dispatch_arg_0)
		}
		'get_shipping_cost_line_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_shipping_cost_line_item(dispatch_arg_0, dispatch_arg_1)
		}
		'get_line_item_args_single_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_line_item_args_single_item(dispatch_arg_0)
		}
		'get_line_item_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_line_item_args(dispatch_arg_0, dispatch_arg_1)
		}
		'get_order_item_names' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_item_names(dispatch_arg_0)
		}
		'get_order_item_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_order_item_name(dispatch_arg_0, dispatch_arg_1)
		}
		'get_line_items' {
			return this.get_line_items()
		}
		'delete_line_items' {
			this.delete_line_items()
			return rt.new_null()
		}
		'line_items_valid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.line_items_valid(dispatch_arg_0))
		}
		'prepare_line_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.prepare_line_items(dispatch_arg_0)
			return rt.new_null()
		}
		'add_line_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_f64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.add_line_item(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'get_paypal_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_paypal_state(dispatch_arg_0, dispatch_arg_1)
		}
		'currency_has_decimals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.currency_has_decimals(dispatch_arg_0))
		}
		'round' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.round(dispatch_arg_0, dispatch_arg_1)
		}
		'number_format' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.number_format(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_Gateway_Paypal_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'line_items' { return this.line_items }
		'gateway' { return this.gateway }
		'notify_url' { return this.notify_url }
		'endpoint' { return rt.new_string(this.endpoint) }
		'request' { return this.request }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Gateway_Paypal_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'line_items' { this.line_items = val; return true }
		'gateway' { this.gateway = val; return true }
		'notify_url' { this.notify_url = val; return true }
		'endpoint' { this.endpoint = (val).str(); return true }
		'request' { this.request = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Gateway_Paypal) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Gateway_Paypal) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_gateways_paypal_includes_class_wc_gateway_paypal_request_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
