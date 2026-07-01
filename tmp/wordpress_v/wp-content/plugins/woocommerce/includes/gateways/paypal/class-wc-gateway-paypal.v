import rt

pub fn Class_WC_Gateway_Paypal.id() string {
	return 'paypal'
}
struct Class_WC_Gateway_Paypal {
	rt.PhpObjectBase
pub mut:
		log_enabled rt.PhpVal = rt.new_null()
		log rt.PhpVal = rt.new_bool(false)
		testmode bool
		debug bool
		intent string
		email rt.PhpVal = rt.new_null()
		receiver_email rt.PhpVal = rt.new_null()
		identity_token rt.PhpVal = rt.new_null()
		jetpack_connection_manager rt.PhpVal = rt.new_null()
		transact_onboarding_complete bool
		instance rt.PhpVal = rt.new_null()
}

fn Class_WC_Gateway_Paypal.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_WC_Gateway_Paypal.set_instance(var_instance rt.PhpVal)  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn (mut this Class_WC_Gateway_Paypal) construct()  {
	this.dispatch_set_prop('id', Class_WC_Gateway_Paypal.id())
	this.dispatch_set_prop('has_fields', rt.new_bool(false))
	this.dispatch_set_prop('order_button_text', rt.call_function('__', [rt.new_string('Proceed to PayPal'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('method_title', rt.call_function('__', [rt.new_string('PayPal Standard'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('method_description', rt.call_function('__', [rt.new_string('PayPal Standard redirects customers to PayPal to enter their payment information.'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('supports', rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.products() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.refunds() }]))
	this.init_form_fields()
	this.init_settings()
	this.dispatch_set_prop('title', this.get_option(rt.new_string('title')))
	this.dispatch_set_prop('description', this.get_option(rt.new_string('description')))
	this.testmode = rt.identical(rt.new_string('yes'), this.get_option(rt.new_string('testmode'), rt.new_string('no')))
	this.intent = if rt.is_true(rt.identical(rt.new_string('sale'), this.get_option(rt.new_string('paymentaction'), rt.new_string('sale')))) { 'capture' } else { 'authorize' }
	this.debug = rt.identical(rt.new_string('yes'), this.get_option(rt.new_string('debug'), rt.new_string('no')))
	this.email = this.get_option(rt.new_string('email'))
	this.receiver_email = this.get_option(rt.new_string('receiver_email'), this.email)
	this.identity_token = this.get_option(rt.new_string('identity_token'))
	this.transact_onboarding_complete = rt.identical(rt.new_string('yes'), this.get_option(rt.new_string('transact_onboarding_complete'), rt.new_string('no')))
	// unsupported assign target: Expr_StaticPropertyFetch
	if rt.is_true(this.testmode) {
		// unsupported expression: Expr_AssignOp_Concat
		this.dispatch_set_prop('description', rt.new_string(rt.get_property(rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this), 'description').to_string().trim_space()))
	}
	rt.call_function('add_action', ['woocommerce_update_options_payment_gateways_' + (rt.get_property(rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this), 'id')).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'process_admin_options' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_processing'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'capture_payment' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_completed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'capture_payment' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'admin_scripts' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_valid_for_use())))) {
		this.dispatch_set_prop('enabled', rt.new_string('no'))
	} else {
		rt.include_file(@DIR + '/includes/class-wc-gateway-paypal-ipn-handler.php', '2')
		create_wc_gateway_paypal_ipn_handler(this.testmode, this.receiver_email)
		if rt.is_true(this.identity_token) {
			rt.include_file(@DIR + '/includes/class-wc-gateway-paypal-pdt-handler.php', '2')
			mut var_pdt_handler := create_wc_gateway_paypal_pdt_handler(this.testmode, this.identity_token)
			var_pdt_handler.set_receiver_email(this.receiver_email)
		}
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this), 'enabled'))) {
		rt.call_function('add_filter', [rt.new_string('woocommerce_thankyou_order_received_text'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'order_received_text' }]), rt.new_int(10), rt.new_int(2)])
		rt.call_function('add_filter', [rt.new_string('woocommerce_my_account_my_orders_actions'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'hide_action_buttons' }]), rt.new_int(10), rt.new_int(2)])
		rt.call_function('add_filter', [rt.new_string('woocommerce_settings_api_form_fields_paypal'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'maybe_remove_fields' }]), rt.new_int(15)])
		rt.call_function('add_action', [rt.new_string('woocommerce_updated'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'maybe_onboard_with_transact' }])])
		if this.should_use_orders_v2() {
			rt.call_function('add_action', [rt.new_string('woocommerce_before_thankyou'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'update_addresses_in_order' }]), rt.new_int(10)])
			rt.call_function('add_action', [rt.new_string('woocommerce_paypal_standard_order_created_response'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'manage_account_restriction_status' }]), rt.new_int(10), rt.new_int(3)])
			mut var_buttons := create_automattic_woocommerce_gateways_paypal_buttons(rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this).dup())
			if rt.is_true(rt.new_bool(rt.is_true(var_buttons.is_enabled()) && !(this.needs_setup()))) {
				rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'enqueue_scripts' }])])
				rt.call_function('add_filter', [rt.new_string('wp_script_attributes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'add_paypal_sdk_attributes' }])])
				rt.call_function('add_action', [rt.new_string('woocommerce_checkout_before_customer_details'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'render_buttons_container' }])])
				rt.call_function('add_action', [rt.new_string('woocommerce_after_cart_totals'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'render_buttons_container' }])])
				rt.call_function('add_action', [rt.new_string('woocommerce_after_add_to_cart_form'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'render_buttons_container' }])])
			}
		}
	}
}

fn (mut this Class_WC_Gateway_Paypal) update_addresses_in_order(var_order_id rt.PhpVal)  {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	if !(this.should_use_orders_v2()) {
		return rt.new_null()
	}
	mut var_paypal_order_id := rt.call_method(var_order, 'get_meta', [Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_order_id()])
	if !rt.is_true(var_paypal_order_id) {
		return rt.new_null()
	}
	mut var_addresses_update_attempted := rt.call_method(var_order, 'meta_exists', [Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_addresses_updated()])
	if rt.is_true(var_addresses_update_attempted) {
		return rt.new_null()
	}
	mut var_paypal_request := create_automattic_woocommerce_gateways_paypal_request(rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this).dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_paypal_order_details := rt.call_method(var_paypal_request, 'get_paypal_order_details', [var_paypal_order_id.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}; return temp.update_addresses_in_order(arg_0, arg_1) }(var_order.dup(), var_paypal_order_details.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		Class_WC_Gateway_Paypal.log('Error updating addresses for order #' + (var_order_id).str() + ': ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), rt.new_string('error'))
		rt.call_method(var_order, 'update_meta_data', [Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_addresses_updated(), rt.new_string('no')])
		rt.call_method(var_order, 'save', []rt.PhpVal{})
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn (mut this Class_WC_Gateway_Paypal) maybe_onboard_with_transact()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))))) {
		return rt.new_null()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	mut var_use_orders_v2 := rt.call_function('apply_filters', [rt.new_string('woocommerce_paypal_use_orders_v2'), fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}; return temp.is_orders_v2_migration_eligible() }()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_use_orders_v2)))) {
		return rt.new_null()
	}
	mut var_transact_account_manager := create_automattic_woocommerce_gateways_paypal_transactaccountmanager(rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this).dup())
	var_transact_account_manager.do_onboarding()
}

fn (mut this Class_WC_Gateway_Paypal) is_available() bool {
	if this.should_use_orders_v2() && this.needs_setup() {
		return false
	}
	return (this.Class_WC_Payment_Gateway.is_available()).to_bool()
}

fn (mut this Class_WC_Gateway_Paypal) needs_setup() bool {
	return !rt.is_true(this.email) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [this.email])))))
}

fn Class_WC_Gateway_Paypal.log(var_message rt.PhpVal, level string)  {
	if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_null())) {
		mut var_settings := rt.call_function('get_option', [rt.new_string('woocommerce_paypal_settings')])
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
			// unsupported assign target: Expr_StaticPropertyFetch
		}
		rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'log', [rt.new_string(level), var_message.dup(), rt.create_array([rt.ArrayItem{ key: 'source', val: Class_WC_Gateway_Paypal.id() }])])
	}
}

fn (mut this Class_WC_Gateway_Paypal) process_admin_options() rt.PhpVal {
	mut var_saved := this.Class_WC_Payment_Gateway.process_admin_options()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
			// unsupported assign target: Expr_StaticPropertyFetch
		}
		if rt.is_true(rt.new_bool(rt.instance_of(// unsupported expression: Expr_StaticPropertyFetch, 'WC_Logger'))) {
			rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'clear', [Class_WC_Gateway_Paypal.id()])
		}
	}
	if rt.is_true(var_saved) {
		this.maybe_onboard_with_transact()
	}
	return var_saved.dup()
}

fn (mut this Class_WC_Gateway_Paypal) get_icon() rt.PhpVal {
	mut var_icon := this.get_paypal_icon_image()
	mut var_icon_html := rt.new_string('<img src="' + (rt.call_function('esc_attr', [.dup()])).str() + '" alt="' + (rt.call_function('esc_attr__', [rt.new_string('PayPal acceptance mark'), rt.new_string('woocommerce')])).str() + '" />')
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_gateway_icon'), var_icon_html.dup(), rt.get_property(rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this), 'id')])
}

fn (mut this Class_WC_Gateway_Paypal) get_icon_url(var_country rt.PhpVal) string {
	mut var_url := rt.new_string('https://www.paypal.com/' + var_country.dup().to_string().to_lower())
	mut var_home_counties := ['BE', 'CZ', 'DK', 'HU', 'IT', 'JP', 'NL', 'NO', 'ES', 'SE', 'TR', 'IN']
	mut var_countries := [, , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , ]
	if rt.is_true(rt.call_function('in_array', [.dup(), .dup(), ])) {
		return 
	} else if rt.is_true() {
	} else {
	}
	return ''
}

fn (mut this Class_WC_Gateway_Paypal) get_paypal_icon_image() rt.PhpVal {
	
}

fn (mut this Class_WC_Gateway_Paypal) get_icon_image(var_country rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Gateway_Paypal) is_valid_for_use() rt.PhpVal {
}

fn (mut this Class_WC_Gateway_Paypal) admin_options()  {
}

fn (mut this Class_WC_Gateway_Paypal) init_form_fields()  {
}

fn (mut this Class_WC_Gateway_Paypal) maybe_remove_fields(var_form_fields rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Gateway_Paypal) get_transaction_url(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Gateway_Paypal) process_payment(var_order_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Gateway_Paypal) can_refund_order(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Gateway_Paypal) init_api()  {
}

fn (mut this Class_WC_Gateway_Paypal) process_refund(var_order_id rt.PhpVal, var_amount rt.PhpVal, reason string) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WC_Gateway_Paypal) capture_payment(var_order_id rt.PhpVal)  {
}

fn (mut this Class_WC_Gateway_Paypal) admin_scripts()  {
}

fn (mut this Class_WC_Gateway_Paypal) enqueue_scripts()  {
}

fn (mut this Class_WC_Gateway_Paypal) add_paypal_sdk_attributes(var_attrs rt.PhpVal) rt.PhpVal {
	mut var_attrs_mutated := var_attrs
}

fn (mut this Class_WC_Gateway_Paypal) render_buttons_container()  {
}

fn (mut this Class_WC_Gateway_Paypal) order_received_text(var_text rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Gateway_Paypal) hide_action_buttons(var_actions rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
}

fn (mut this Class_WC_Gateway_Paypal) should_load() rt.PhpVal {
}

fn (mut this Class_WC_Gateway_Paypal) has_paypal_orders() bool {
}

fn (mut this Class_WC_Gateway_Paypal) should_use_orders_v2() bool {
}

fn (mut this Class_WC_Gateway_Paypal) get_jetpack_connection_manager() rt.PhpVal {
}

fn (mut this Class_WC_Gateway_Paypal) is_transact_onboarding_complete() bool {
}

fn (mut this Class_WC_Gateway_Paypal) set_transact_onboarding_complete()  {
}

fn (mut this Class_WC_Gateway_Paypal) manage_account_restriction_status(var_http_code rt.PhpVal, var_response_data rt.PhpVal, var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
}

struct Class_WC_Payment_Gateway {
	rt.PhpObjectBase
}

struct Class_WC_Gateway_Paypal_IPN_Handler {
	rt.PhpObjectBase
}

struct Class_WC_Gateway_Paypal_PDT_Handler {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Buttons {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager {
	rt.PhpObjectBase
}

fn create_wc_gateway_paypal() &Class_WC_Gateway_Paypal {
	mut obj := &Class_WC_Gateway_Paypal{
		PhpObjectBase: rt.PhpObjectBase{}
		log_enabled: rt.new_null()
		log: rt.new_bool(false)
		testmode: false
		debug: false
		intent: ''
		email: rt.new_null()
		receiver_email: rt.new_null()
		identity_token: rt.new_null()
		jetpack_connection_manager: rt.new_null()
		transact_onboarding_complete: false
		instance: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_payment_gateway() &Class_WC_Payment_Gateway {
	mut obj := &Class_WC_Payment_Gateway{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_gateway_paypal_ipn_handler() &Class_WC_Gateway_Paypal_IPN_Handler {
	mut obj := &Class_WC_Gateway_Paypal_IPN_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_gateway_paypal_pdt_handler() &Class_WC_Gateway_Paypal_PDT_Handler {
	mut obj := &Class_WC_Gateway_Paypal_PDT_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_buttons() &Class_Automattic_WooCommerce_Gateways_PayPal_Buttons {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Buttons{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_request() &Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_helper() &Class_Automattic_WooCommerce_Gateways_PayPal_Helper {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_transactaccountmanager() &Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Gateway_Paypal) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_WC_Gateway_Paypal.get_instance()
		}
		'set_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Gateway_Paypal.set_instance(dispatch_arg_0)
			return rt.new_null()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'update_addresses_in_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_addresses_in_order(dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_onboard_with_transact' {
			this.maybe_onboard_with_transact()
			return rt.new_null()
		}
		'is_available' {
			return rt.new_bool(this.is_available())
		}
		'needs_setup' {
			return rt.new_bool(this.needs_setup())
		}
		'log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			Class_WC_Gateway_Paypal.log(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'process_admin_options' {
			return this.process_admin_options()
		}
		'get_icon' {
			return this.get_icon()
		}
		'get_icon_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_icon_url(dispatch_arg_0))
		}
		'get_paypal_icon_image' {
			return this.get_paypal_icon_image()
		}
		'get_icon_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_icon_image(dispatch_arg_0)
		}
		'is_valid_for_use' {
			return this.is_valid_for_use()
		}
		'admin_options' {
			this.admin_options()
			return rt.new_null()
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'maybe_remove_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.maybe_remove_fields(dispatch_arg_0)
		}
		'get_transaction_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_transaction_url(dispatch_arg_0)
		}
		'process_payment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.process_payment(dispatch_arg_0)
		}
		'can_refund_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.can_refund_order(dispatch_arg_0))
		}
		'init_api' {
			this.init_api()
			return rt.new_null()
		}
		'process_refund' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.process_refund(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'capture_payment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.capture_payment(dispatch_arg_0)
			return rt.new_null()
		}
		'admin_scripts' {
			this.admin_scripts()
			return rt.new_null()
		}
		'enqueue_scripts' {
			this.enqueue_scripts()
			return rt.new_null()
		}
		'add_paypal_sdk_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_paypal_sdk_attributes(dispatch_arg_0)
		}
		'render_buttons_container' {
			this.render_buttons_container()
			return rt.new_null()
		}
		'order_received_text' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.order_received_text(dispatch_arg_0, dispatch_arg_1)
		}
		'hide_action_buttons' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.hide_action_buttons(dispatch_arg_0, dispatch_arg_1)
		}
		'should_load' {
			return this.should_load()
		}
		'has_paypal_orders' {
			return rt.new_bool(this.has_paypal_orders())
		}
		'should_use_orders_v2' {
			return rt.new_bool(this.should_use_orders_v2())
		}
		'get_jetpack_connection_manager' {
			return this.get_jetpack_connection_manager()
		}
		'is_transact_onboarding_complete' {
			return rt.new_bool(this.is_transact_onboarding_complete())
		}
		'set_transact_onboarding_complete' {
			this.set_transact_onboarding_complete()
			return rt.new_null()
		}
		'manage_account_restriction_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.manage_account_restriction_status(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Gateway_Paypal) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'log_enabled' { return this.log_enabled }
		'log' { return this.log }
		'testmode' { return rt.new_bool(this.testmode) }
		'debug' { return rt.new_bool(this.debug) }
		'intent' { return rt.new_string(this.intent) }
		'email' { return this.email }
		'receiver_email' { return this.receiver_email }
		'identity_token' { return this.identity_token }
		'jetpack_connection_manager' { return this.jetpack_connection_manager }
		'transact_onboarding_complete' { return rt.new_bool(this.transact_onboarding_complete) }
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Gateway_Paypal) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'log_enabled' { this.log_enabled = val; return true }
		'log' { this.log = val; return true }
		'testmode' { this.testmode = (val).to_bool(); return true }
		'debug' { this.debug = (val).to_bool(); return true }
		'intent' { this.intent = (val).str(); return true }
		'email' { this.email = val; return true }
		'receiver_email' { this.receiver_email = val; return true }
		'identity_token' { this.identity_token = val; return true }
		'jetpack_connection_manager' { this.jetpack_connection_manager = val; return true }
		'transact_onboarding_complete' { this.transact_onboarding_complete = (val).to_bool(); return true }
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Payment_Gateway) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Payment_Gateway) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Gateway) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Gateway_Paypal_IPN_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal_IPN_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Gateway_Paypal_PDT_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Gateway_Paypal_PDT_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal_PDT_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_gateways_paypal_class_wc_gateway_paypal_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Gateway_Paypal_Constants')]))))) {
		rt.include_file(@DIR + '/includes/class-wc-gateway-paypal-constants.php', '4')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Gateway_Paypal_Helper')]))))) {
		rt.include_file(@DIR + '/includes/class-wc-gateway-paypal-helper.php', '4')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Gateway_Paypal_Notices')]))))) {
		rt.include_file(@DIR + '/includes/class-wc-gateway-paypal-notices.php', '4')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Gateway_Paypal_Buttons')]))))) {
		rt.include_file(@DIR + '/class-wc-gateway-paypal-buttons.php', '4')
	}
}
