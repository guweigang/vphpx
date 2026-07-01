import rt

struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController.init()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_rest_prepare_payment_gateway'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'extend_response' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'possibly_do_connection_return_action' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_admin_payment_gateway_connection_return'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'handle_successfull_connection' }])])
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController.extend_response(var_response rt.PhpVal, var_gateway rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	var_data.array_set('needs_setup', rt.call_method(var_gateway, 'needs_setup', []rt.PhpVal{}))
	var_data.array_set('post_install_scripts', Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController.get_post_install_scripts(var_gateway.dup()))
	var_data.array_set('settings_url', if rt.is_true(rt.call_function('method_exists', [var_gateway.dup(), rt.new_string('get_settings_url')])) { rt.call_method(var_gateway, 'get_settings_url', []rt.PhpVal{}) } else { rt.call_function('admin_url', ['admin.php?page=wc-settings&tab=checkout&section=' + rt.get_property(var_gateway, 'id').to_string().to_lower()]) })
	mut var_return_url := rt.call_function('wc_admin_url', ['&task=payments&connection-return=' + rt.get_property(var_gateway, 'id').to_string().to_lower() + '&_wpnonce=' + (rt.call_function('wp_create_nonce', [rt.new_string('connection-return')])).str()])
	var_data.array_set('connection_url', if rt.is_true(rt.call_function('method_exists', [var_gateway.dup(), rt.new_string('get_connection_url')])) { rt.call_method(var_gateway, 'get_connection_url', [var_return_url.dup()]) } else { rt.new_null() })
	var_data.array_set('setup_help_text', if rt.is_true(rt.call_function('method_exists', [var_gateway.dup(), rt.new_string('get_setup_help_text')])) { rt.call_method(var_gateway, 'get_setup_help_text', []rt.PhpVal{}) } else { rt.new_null() })
	var_data.array_set('required_settings_keys', if rt.is_true(rt.call_function('method_exists', [var_gateway.dup(), rt.new_string('get_required_settings_keys')])) { rt.call_method(var_gateway, 'get_required_settings_keys', []rt.PhpVal{}) } else { rt.new_array() })
	rt.call_method(var_response, 'set_data', [var_data.dup()])
	return var_response.dup()
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController.get_post_install_scripts(var_gateway rt.PhpVal) rt.PhpVal {
	mut var_scripts := rt.new_array()
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	mut var_handles := if rt.is_true(rt.call_function('method_exists', [var_gateway.dup(), rt.new_string('get_post_install_script_handles')])) { rt.call_method(var_gateway, 'get_post_install_script_handles', []rt.PhpVal{}) } else { rt.new_array() }
	{
		mut iter_1 := var_handles.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_handle := item_1.val
			if rt.get_property(var_wp_scripts, 'registered').array_isset(var_handle) {
				var_scripts.array_push(rt.get_property(var_wp_scripts, 'registered').array_get(var_handle))
			}
		}
	}
	return var_scripts.dup()
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController.possibly_do_connection_return_action()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.get_superglobal('_GET').array_isset(rt.new_string('page'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || !(rt.get_superglobal('_GET').array_isset(rt.new_string('task'))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || !(rt.get_superglobal('_GET').array_isset(rt.new_string('connection-return'))))) || !(rt.get_superglobal('_GET').array_isset(rt.new_string('_wpnonce'))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('_wpnonce')])]), rt.new_string('connection-return')]))))))) {
		return rt.new_null()
	}
	mut var_gateway_id := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('connection-return')])])
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_payment_gateway_connection_return'), var_gateway_id.dup()])
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController.handle_successfull_connection(var_gateway_id rt.PhpVal)  {
	mut var_gateway_id_mutated := var_gateway_id
	if rt.is_true(rt.new_bool(!(rt.get_superglobal('_GET').array_isset(rt.new_string('success'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_payment_gateways := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	mut var_payment_gateway := if var_payment_gateways.array_isset(var_gateway_id_mutated) { var_payment_gateways.array_get(var_gateway_id_mutated) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_payment_gateway)))) {
		return rt.new_null()
	}
	rt.call_method(var_payment_gateway, 'update_option', [rt.new_string('enabled'), rt.new_string('yes')])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_TransientNotices{}; return temp.add(arg_0) }(rt.create_array([rt.ArrayItem{ key: 'user_id', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'id', val: 'payment-gateway-connection-return-' + (rt.call_function('str_replace', [rt.new_string(','), rt.new_string('-'), var_gateway_id_mutated.dup()])).str() }, rt.ArrayItem{ key: 'status', val: 'success' }, rt.ArrayItem{ key: 'content', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s connected successfully'), rt.new_string('woocommerce')]), rt.get_property(var_payment_gateway, 'method_title')]) }]))
	rt.call_function('wc_admin_record_tracks_event', [rt.new_string('tasklist_payment_connect_method'), rt.create_array([rt.ArrayItem{ key: 'payment_method', val: var_gateway_id_mutated }])])
	rt.call_function('wp_safe_redirect', [rt.call_function('wc_admin_url', []rt.PhpVal{})])
}

struct Class_Automattic_WooCommerce_Admin_Features_TransientNotices {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_paymentgatewayscontroller() &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_transientnotices() &Class_Automattic_WooCommerce_Admin_Features_TransientNotices {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_TransientNotices{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController.init()
			return rt.new_null()
		}
		'extend_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController.extend_response(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_post_install_scripts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController.get_post_install_scripts(dispatch_arg_0)
		}
		'possibly_do_connection_return_action' {
			Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController.possibly_do_connection_return_action()
			return rt.new_null()
		}
		'handle_successfull_connection' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController.handle_successfull_connection(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_PaymentGatewaysController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_TransientNotices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_TransientNotices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_TransientNotices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_paymentgatewaysuggestions_paymentgatewayscontroller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
