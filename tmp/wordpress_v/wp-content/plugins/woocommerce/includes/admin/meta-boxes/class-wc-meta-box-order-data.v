import rt

struct Class_WC_Meta_Box_Order_Data {
	rt.PhpObjectBase
pub mut:
		billing_fields rt.PhpVal = rt.new_array()
		shipping_fields rt.PhpVal = rt.new_array()
}

fn Class_WC_Meta_Box_Order_Data.get_billing_fields(order bool, context string) rt.PhpVal {
	mut order_mutated := order
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_billing_fields'), rt.create_array([rt.ArrayItem{ key: 'first_name', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('First name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'last_name', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Last name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'company', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Company'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'address_1', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Address line 1'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'address_2', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Address line 2'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'city', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('City'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'postcode', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Postcode / ZIP'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'country', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Country / Region'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }, rt.ArrayItem{ key: 'class', val: 'js_field-country select short' }, rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'options', val: rt.add(rt.create_array([rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('Select a country / region&hellip;'), rt.new_string('woocommerce')]) }]), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{})) }]) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('State / County'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'class', val: 'js_field-state select short' }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'email', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Email address'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'phone', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Phone'), rt.new_string('woocommerce')]) }]) }]), rt.new_bool(order_mutated).dup(), rt.new_string(context)])
}

fn Class_WC_Meta_Box_Order_Data.get_shipping_fields(order bool, context string) rt.PhpVal {
	mut order_mutated := order
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_shipping_fields'), rt.create_array([rt.ArrayItem{ key: 'first_name', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('First name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'last_name', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Last name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'company', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Company'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'address_1', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Address line 1'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'address_2', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Address line 2'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'city', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('City'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'postcode', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Postcode / ZIP'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'country', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Country / Region'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show', val: false }, rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'class', val: 'js_field-country select short' }, rt.ArrayItem{ key: 'options', val: rt.add(rt.create_array([rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('Select a country / region&hellip;'), rt.new_string('woocommerce')]) }]), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_countries', []rt.PhpVal{})) }]) }, rt.ArrayItem{ key: 'state', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('State / County'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'class', val: 'js_field-state select short' }, rt.ArrayItem{ key: 'show', val: false }]) }, rt.ArrayItem{ key: 'phone', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Phone'), rt.new_string('woocommerce')]) }]) }]), rt.new_bool(order_mutated).dup(), rt.new_string(context)])
}

fn Class_WC_Meta_Box_Order_Data.init_address_fields()  {
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_WC_Meta_Box_Order_Data.output(var_post rt.PhpVal)  {
	mut var_theorder := rt.new_null()
	// unsupported statement: Stmt_Global
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.init_theorder_object(arg_0) }(var_post.dup())
	mut var_order := var_theorder
	if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})) {
		mut var_payment_gateways := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways'), 'payment_gateways', []rt.PhpVal{})
	} else {
		var_payment_gateways = rt.new_array()
	}
	mut var_payment_method := rt.call_method(var_order, 'get_payment_method', []rt.PhpVal{})
	mut var_order_type_object := rt.call_function('get_post_type_object', [rt.call_method(var_order, 'get_type', []rt.PhpVal{})])
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce_save_data'), rt.new_string('woocommerce_meta_nonce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if !rt.is_true(rt.call_method(var_order, 'get_title', []rt.PhpVal{})) { rt.call_function('__', [rt.new_string('Order'), rt.new_string('woocommerce')]) } else { rt.call_method(var_order, 'get_title', []rt.PhpVal{}) }]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_method(var_order, 'get_status', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('%1$s #%2$s details'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.get_property(rt.get_property(var_order_type_object, 'labels'), 'singular_name')]), rt.call_function('esc_html', [rt.call_method(var_order, 'get_order_number', []rt.PhpVal{})])])
	// unsupported statement: Stmt_InlineHTML
	mut var_meta_list := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(var_payment_method) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_payment_method_string := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Payment via %s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [if var_payment_gateways.array_isset(var_payment_method) { rt.call_method(var_payment_gateways.array_get(var_payment_method), 'get_title', []rt.PhpVal{}) } else { var_payment_method }])])
		mut var_transaction_id := rt.call_method(var_order, 'get_transaction_id', []rt.PhpVal{})
		if rt.is_true(var_transaction_id) {
			mut var_to_add := rt.new_null()
			if var_payment_gateways.array_isset(var_payment_method) {
				mut var_url := rt.call_method(var_payment_gateways.array_get(var_payment_method), 'get_transaction_url', [var_order.dup()])
				if rt.is_true(var_url) {
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
			var_to_add = if !(var_to_add).is_null() { var_to_add } else { ' (' + (rt.call_function('esc_html', [var_transaction_id.dup()])).str() + ')' }
			// unsupported expression: Expr_AssignOp_Concat
		}
		var_meta_list << var_payment_method_string.dup()
	}
	if rt.is_true(rt.call_method(var_order, 'get_date_paid', []rt.PhpVal{})) {
		var_meta_list << rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Paid on %1$s @ %2$s'), rt.new_string('woocommerce')]), rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_paid', []rt.PhpVal{})]), rt.call_function('wc_format_datetime', [rt.call_method(var_order, 'get_date_paid', []rt.PhpVal{}), rt.call_function('get_option', [rt.new_string('time_format')])])])
	}
	mut var_ip_address := rt.call_method(var_order, 'get_customer_ip_address', []rt.PhpVal{})
	if rt.is_true(var_ip_address) {
		var_meta_list << rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Customer IP: %s'), rt.new_string('woocommerce')]), '<span class="woocommerce-Order-customerIP">' + (rt.call_function('esc_html', [var_ip_address.dup()])).str() + '</span>'])
	}
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('implode', [rt.new_string('. '), var_meta_list.dup()])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_data_header_right'), var_order.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_data_after_payment_info'), var_order.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('General'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_order_date_created_localised := if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}).is_null()))))) { rt.call_method(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}), 'getOffsetTimestamp', []rt.PhpVal{}) } else { rt.new_string('') }
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Date created:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('date_i18n', [rt.new_string('Y-m-d'), var_order_date_created_localised.dup()])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('apply_filters', [rt.new_string('woocommerce_date_input_html_pattern'), rt.new_string('[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])')])]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('h'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('date_i18n', [rt.new_string('H'), var_order_date_created_localised.dup()])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('m'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('date_i18n', [rt.new_string('i'), var_order_date_created_localised.dup()])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('date_i18n', [rt.new_string('s'), var_order_date_created_localised.dup()])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Status:'), rt.new_string('woocommerce')])
	if rt.is_true(rt.call_method(var_order, 'needs_payment', []rt.PhpVal{})) {
		rt.call_function('printf', [rt.new_string('<a href="%s">%s</a>'), rt.call_function('esc_url', [rt.call_method(var_order, 'get_checkout_payment_url', []rt.PhpVal{})]), rt.call_function('esc_html__', [rt.new_string('Customer payment page &rarr;'), rt.new_string('woocommerce')])])
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_statuses := rt.call_function('wc_get_order_statuses', []rt.PhpVal{})
	{
		mut iter_1 := var_statuses.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_status_name := item_1.val
			mut var_status := item_1.key
			print('<option value="' + (rt.call_function('esc_attr', [var_status.dup()])).str() + '" ' + (rt.call_function('selected', [var_status.dup(), 'wc-' + (rt.call_method(var_order, 'get_status', [rt.new_string('edit')])).str(), rt.new_bool(false)])).str() + '>' + (rt.call_function('esc_html', [var_status_name.dup()])).str() + '</option>')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Customer:'), rt.new_string('woocommerce')])
	if rt.is_true(rt.call_method(var_order, 'get_user_id', [rt.new_string('edit')])) {
		mut var_args := { 'post_status': rt.new_string('all'), 'post_type': rt.new_string('shop_order'), '_customer_user': rt.call_method(var_order, 'get_user_id', [rt.new_string('edit')]) }
		rt.call_function('printf', [rt.new_string('<a href="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('add_query_arg', [var_args.dup(), rt.call_function('admin_url', [rt.new_string('edit.php')])])]), ' ' + (rt.call_function('esc_html__', [rt.new_string('View other orders &rarr;'), rt.new_string('woocommerce')])).str()])
		rt.call_function('printf', [rt.new_string('<a href="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.new_string('user_id'), rt.call_method(var_order, 'get_user_id', [rt.new_string('edit')]), rt.call_function('admin_url', [rt.new_string('user-edit.php')])])]), ' ' + (rt.call_function('esc_html__', [rt.new_string('Profile &rarr;'), rt.new_string('woocommerce')])).str()])
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_user_string := rt.new_string(rt.new_string(''))
	mut var_user_id := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_method(var_order, 'get_user_id', []rt.PhpVal{})) {
		var_user_id = rt.call_function('absint', [rt.call_method(var_order, 'get_user_id', []rt.PhpVal{})])
		mut var_user := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.get_user_in_current_site(arg_0) }(var_user_id.dup())
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_user.dup()]))))) {
			mut var_customer := create_wc_customer(var_user_id.dup())
			var_user_string = rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%1$s (#%2$s &ndash; %3$s)'), rt.new_string('woocommerce')]), (var_customer.get_first_name()).str() + ' ' + (var_customer.get_last_name()).str(), var_customer.get_id(), var_customer.get_email()])
		} else {
			var_user_string = rt.call_function('esc_html__', [rt.new_string('(Not available)'), rt.new_string('woocommerce')])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Guest'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_user_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('htmlspecialchars', [rt.call_function('wp_kses_post', [rt.call_function('current', [rt.call_function('apply_filters', [rt.new_string('woocommerce_json_search_found_customers'), rt.create_array([rt.ArrayItem{ key: none, val: var_user_string }])])])])])]))
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_order_data_after_order_details'), var_order.dup()])
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Billing'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	
}

fn Class_WC_Meta_Box_Order_Data.save(var_order_id rt.PhpVal)  {
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

fn create_wc_meta_box_order_data() &Class_WC_Meta_Box_Order_Data {
	mut obj := &Class_WC_Meta_Box_Order_Data{
		PhpObjectBase: rt.PhpObjectBase{}
		billing_fields: rt.new_array()
		shipping_fields: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users() &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
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
		else { return none }
	}
}

fn (this &Class_WC_Meta_Box_Order_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'billing_fields' { return this.billing_fields }
		'shipping_fields' { return this.shipping_fields }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Meta_Box_Order_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'billing_fields' { this.billing_fields = val; return true }
		'shipping_fields' { this.shipping_fields = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_admin_meta_boxes_class_wc_meta_box_order_data_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
