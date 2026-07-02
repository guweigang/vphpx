import rt

pub fn Class_WC_Gateway_Paypal.id() string {
	return 'paypal'
}

struct Class_WC_Gateway_Paypal {
	rt.PhpObjectBase
pub mut:
	testmode                     bool
	debug                        bool
	intent                       string
	email                        rt.PhpVal = rt.new_null()
	receiver_email               rt.PhpVal = rt.new_null()
	identity_token               rt.PhpVal = rt.new_null()
	jetpack_connection_manager   rt.PhpVal = rt.new_null()
	transact_onboarding_complete bool
}

fn init_static_wc_gateway_paypal() {
	rt.init_static_prop('WC_Gateway_Paypal', 'log_enabled', rt.new_null())
	rt.init_static_prop('WC_Gateway_Paypal', 'log', rt.new_bool(false))
	rt.init_static_prop('WC_Gateway_Paypal', 'instance', rt.new_null())
}

fn Class_WC_Gateway_Paypal.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('WC_Gateway_Paypal', 'instance'))) {
		rt.set_static_prop('WC_Gateway_Paypal', 'instance', rt.new_object('WC_Gateway_Paypal', [
			'WC_Payment_Gateway',
		], create_wc_gateway_paypal()))
	}
	return rt.get_static_prop('WC_Gateway_Paypal', 'instance')
}

fn Class_WC_Gateway_Paypal.set_instance(var_instance rt.PhpVal) {
	rt.set_static_prop('WC_Gateway_Paypal', 'instance', var_instance.clone())
}

fn (mut this Class_WC_Gateway_Paypal) construct() {
	this.dispatch_set_prop('id', Class_WC_Gateway_Paypal.id())
	this.dispatch_set_prop('has_fields', rt.new_bool(false))
	this.dispatch_set_prop('order_button_text', rt.call_function('__', [
		rt.new_string('Proceed to PayPal'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('method_title', rt.call_function('__', [
		rt.new_string('PayPal Standard'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('method_description', rt.call_function('__', [
		rt.new_string('PayPal Standard redirects customers to PayPal to enter their payment information.'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('supports', rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.products()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.refunds()
		},
	]))
	this.init_form_fields()
	this.init_settings()
	this.dispatch_set_prop('title', this.get_option(rt.new_string('title')))
	this.dispatch_set_prop('description', this.get_option(rt.new_string('description')))
	this.testmode = rt.identical(rt.new_string('yes'), this.get_option(rt.new_string('testmode'),
		rt.new_string('no')))
	this.intent = if rt.is_true(rt.identical(rt.new_string('sale'), this.get_option(rt.new_string('paymentaction'),
		rt.new_string('sale'))))
	{
		'capture'
	} else {
		'authorize'
	}
	this.debug = rt.identical(rt.new_string('yes'), this.get_option(rt.new_string('debug'),
		rt.new_string('no')))
	this.email = this.get_option(rt.new_string('email'))
	this.receiver_email = this.get_option(rt.new_string('receiver_email'), this.email)
	this.identity_token = this.get_option(rt.new_string('identity_token'))
	this.transact_onboarding_complete = rt.identical(rt.new_string('yes'), this.get_option(rt.new_string('transact_onboarding_complete'),
		rt.new_string('no')))
	rt.set_static_prop('WC_Gateway_Paypal', 'log_enabled', this.debug)
	if this.testmode {
		rt.get_property(rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this),
			'description') = rt.concat(rt.get_property(rt.new_object('WC_Gateway_Paypal', [
			'WC_Payment_Gateway',
		], &this), 'description'),
			rt.new_string('<br>' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Sandbox mode enabled</strong>. Only sandbox test accounts can be used. See the <a href="%1$s">PayPal Sandbox Testing Guide</a> for more details. <a href="%2$s" target="_blank">What is PayPal?</a>'), rt.new_string('woocommerce')]), rt.new_string('https://developer.paypal.com/tools/sandbox/'), rt.call_function('esc_url', [rt.new_string('https://www.paypal.com/digital-wallet/how-paypal-works')])])).str()))
		this.dispatch_set_prop('description', rt.new_string(rt.get_property(rt.new_object('WC_Gateway_Paypal', [
			'WC_Payment_Gateway',
		], &this), 'description').to_string().trim_space()))
	}
	rt.call_function('add_action', [
		rt.new_string('woocommerce_update_options_payment_gateways_' +(rt.get_property(rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this), 'id')).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
				'WC_Payment_Gateway',
			], &this) },
			rt.ArrayItem{ key: none, val: 'process_admin_options' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_processing'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
				'WC_Payment_Gateway',
			], &this) },
			rt.ArrayItem{ key: none, val: 'capture_payment' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_completed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
				'WC_Payment_Gateway',
			], &this) },
			rt.ArrayItem{ key: none, val: 'capture_payment' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
				'WC_Payment_Gateway',
			], &this) },
			rt.ArrayItem{ key: none, val: 'admin_scripts' },
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_valid_for_use())))) {
		this.dispatch_set_prop('enabled', rt.new_string('no'))
	} else {
		rt.include_file(@DIR + '/includes/class-wc-gateway-paypal-ipn-handler.php', '2')
		create_wc_gateway_paypal_ipn_handler(this.testmode, this.receiver_email)
		if rt.is_true(this.identity_token) {
			rt.include_file(@DIR + '/includes/class-wc-gateway-paypal-pdt-handler.php', '2')
			mut var_pdt_handler := create_wc_gateway_paypal_pdt_handler(this.testmode,
				this.identity_token)
			var_pdt_handler.set_receiver_email(this.receiver_email)
		}
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(rt.new_object('WC_Gateway_Paypal', [
		'WC_Payment_Gateway',
	], &this), 'enabled')))
	{
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_thankyou_order_received_text'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
					'WC_Payment_Gateway',
				], &this) },
				rt.ArrayItem{ key: none, val: 'order_received_text' },
			]),
			rt.new_int(10),
			rt.new_int(2),
		])
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_my_account_my_orders_actions'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
					'WC_Payment_Gateway',
				], &this) },
				rt.ArrayItem{ key: none, val: 'hide_action_buttons' },
			]),
			rt.new_int(10),
			rt.new_int(2),
		])
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_settings_api_form_fields_paypal'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
					'WC_Payment_Gateway',
				], &this) },
				rt.ArrayItem{ key: none, val: 'maybe_remove_fields' },
			]),
			rt.new_int(15),
		])
		rt.call_function('add_action', [rt.new_string('woocommerce_updated'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
					'WC_Payment_Gateway',
				], &this) },
				rt.ArrayItem{ key: none, val: 'maybe_onboard_with_transact' },
			])])
		if this.should_use_orders_v2() {
			rt.call_function('add_action', [rt.new_string('woocommerce_before_thankyou'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
						'WC_Payment_Gateway',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_addresses_in_order' },
				]),
				rt.new_int(10)])
			rt.call_function('add_action', [
				rt.new_string('woocommerce_paypal_standard_order_created_response'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
						'WC_Payment_Gateway',
					], &this) },
					rt.ArrayItem{ key: none, val: 'manage_account_restriction_status' },
				]),
				rt.new_int(10),
				rt.new_int(3),
			])
			mut var_buttons := create_automattic_woocommerce_gateways_paypal_buttons(rt.new_object('WC_Gateway_Paypal', [
				'WC_Payment_Gateway',
			], &this))
			if rt.is_true(var_buttons.is_enabled()) && !(this.needs_setup()) {
				rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
					rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
							'WC_Payment_Gateway',
						], &this) },
						rt.ArrayItem{ key: none, val: 'enqueue_scripts' },
					])])
				rt.call_function('add_filter', [rt.new_string('wp_script_attributes'),
					rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
							'WC_Payment_Gateway',
						], &this) },
						rt.ArrayItem{ key: none, val: 'add_paypal_sdk_attributes' },
					])])
				rt.call_function('add_action', [
					rt.new_string('woocommerce_checkout_before_customer_details'),
					rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
							'WC_Payment_Gateway',
						], &this) },
						rt.ArrayItem{ key: none, val: 'render_buttons_container' },
					]),
				])
				rt.call_function('add_action', [
					rt.new_string('woocommerce_after_cart_totals'),
					rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
							'WC_Payment_Gateway',
						], &this) },
						rt.ArrayItem{ key: none, val: 'render_buttons_container' },
					]),
				])
				rt.call_function('add_action', [
					rt.new_string('woocommerce_after_add_to_cart_form'),
					rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Paypal', [
							'WC_Payment_Gateway',
						], &this) },
						rt.ArrayItem{ key: none, val: 'render_buttons_container' },
					]),
				])
			}
		}
	}
}

fn (mut this Class_WC_Gateway_Paypal) update_addresses_in_order(var_order_id rt.PhpVal) {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order, 'get_payment_method', []rt.PhpVal{}), rt.get_property(rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this), 'id'))))) {
		return
	}
	if !(this.should_use_orders_v2()) {
		return
	}
	mut var_paypal_order_id := rt.call_method(var_order, 'get_meta', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_order_id(),
	])
	if !rt.is_true(var_paypal_order_id) {
		return
	}
	mut var_addresses_update_attempted := rt.call_method(var_order, 'meta_exists', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_addresses_updated(),
	])
	if rt.is_true(var_addresses_update_attempted) {
		return
	}
	mut var_paypal_request := create_automattic_woocommerce_gateways_paypal_request(rt.new_object('WC_Gateway_Paypal', [
		'WC_Payment_Gateway',
	], &this))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_paypal_order_details := rt.call_method(var_paypal_request, 'get_paypal_order_details', [
		var_paypal_order_id.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_0 := iife_temp_0.update_addresses_in_order(var_order.clone(),
		var_paypal_order_details.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		Class_WC_Gateway_Paypal.log('Error updating addresses for order #' + var_order_id.str() +
			': ' + (rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(),
			rt.new_string('error'))
		rt.call_method(var_order, 'update_meta_data', [
			Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_addresses_updated(),
			rt.new_string('no'),
		])
		rt.call_method(var_order, 'save', []rt.PhpVal{})
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
}

fn (mut this Class_WC_Gateway_Paypal) maybe_onboard_with_transact() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		return
	}
	if rt.is_true(rt.new_bool('yes' != rt.get_property(rt.new_object('WC_Gateway_Paypal', [
		'WC_Payment_Gateway',
	], &this), 'enabled')))
	{
		return
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_1 := iife_temp_1.is_orders_v2_migration_eligible()
	mut var_use_orders_v2 := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_paypal_use_orders_v2'),
		iife_result_1,
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_use_orders_v2)))) {
		return
	}
	mut var_transact_account_manager := create_automattic_woocommerce_gateways_paypal_transactaccountmanager(rt.new_object('WC_Gateway_Paypal', [
		'WC_Payment_Gateway',
	], &this))
	var_transact_account_manager.do_onboarding()
}

fn (mut this Class_WC_Gateway_Paypal) is_available() bool {
	if this.should_use_orders_v2() && this.needs_setup() {
		return false
	}
	return (this.Class_WC_Payment_Gateway.is_available()).to_bool()
}

fn (mut this Class_WC_Gateway_Paypal) needs_setup() bool {
	return !rt.is_true(this.email)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [this.email])))))
}

fn Class_WC_Gateway_Paypal.log(var_message rt.PhpVal, level string) {
	if rt.is_true(rt.new_bool(rt.get_static_prop('WC_Gateway_Paypal', 'log_enabled').is_null())) {
		mut var_settings := rt.call_function('get_option', [
			rt.new_string('woocommerce_paypal_settings'),
		])
		rt.set_static_prop('WC_Gateway_Paypal', 'log_enabled', rt.identical(rt.new_string('yes'), if !(var_settings.array_get(rt.new_string('debug'))).is_null() {
			var_settings.array_get(rt.new_string('debug'))
		} else {
			rt.new_string('no')
		}))
	}
	if rt.is_true(rt.get_static_prop('WC_Gateway_Paypal', 'log_enabled')) {
		if !rt.is_true(rt.get_static_prop('WC_Gateway_Paypal', 'log')) {
			rt.set_static_prop('WC_Gateway_Paypal', 'log', rt.call_function('wc_get_logger',
				[]rt.PhpVal{}))
		}
		rt.call_method(rt.get_static_prop('WC_Gateway_Paypal', 'log'), 'log', [
			rt.new_string(level),
			var_message.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: Class_WC_Gateway_Paypal.id() },
			]),
		])
	}
}

fn (mut this Class_WC_Gateway_Paypal) process_admin_options() rt.PhpVal {
	mut var_saved := this.Class_WC_Payment_Gateway.process_admin_options()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), this.get_option(rt.new_string('debug'),
		rt.new_string('no'))))))
	{
		if !rt.is_true(rt.get_static_prop('WC_Gateway_Paypal', 'log')) {
			rt.set_static_prop('WC_Gateway_Paypal', 'log', rt.call_function('wc_get_logger',
				[]rt.PhpVal{}))
		}
		if rt.is_true(rt.new_bool(rt.instance_of(rt.get_static_prop('WC_Gateway_Paypal', 'log'),
			'WC_Logger')))
		{
			rt.call_method(rt.get_static_prop('WC_Gateway_Paypal', 'log'), 'clear', [
				rt.new_string(Class_WC_Gateway_Paypal.id()),
			])
		}
	}
	if rt.is_true(var_saved) {
		this.maybe_onboard_with_transact()
	}
	return var_saved.clone()
}

fn (mut this Class_WC_Gateway_Paypal) get_icon() rt.PhpVal {
	mut var_icon := this.get_paypal_icon_image()
	mut var_icon_html := rt.new_string('<img src="' +
		(rt.call_function('esc_attr', [var_icon.clone()])).str() + '" alt="' +
		(rt.call_function('esc_attr__', [rt.new_string('PayPal acceptance mark'), rt.new_string('woocommerce')])).str() +
		'" />')
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_gateway_icon'),
		var_icon_html.clone(),
		rt.get_property(rt.new_object('WC_Gateway_Paypal', [
			'WC_Payment_Gateway',
		], &this), 'id')])
}

fn (mut this Class_WC_Gateway_Paypal) get_icon_url(var_country rt.PhpVal) string {
	mut var_url := rt.new_string('https://www.paypal.com/' +
		var_country.clone().to_string().to_lower())
	mut var_home_counties := ['BE', 'CZ', 'DK', 'HU', 'IT', 'JP', 'NL', 'NO', 'ES', 'SE', 'TR',
		'IN']
	mut var_countries := ['DZ', 'AU', 'BH', 'BQ', 'BW', 'CA', 'CN', 'CW', 'FI', 'FR', 'DE', 'GR',
		'HK', 'ID', 'JO', 'KE', 'KW', 'LU', 'MY', 'MA', 'OM', 'PH', 'PL', 'PT', 'QA', 'IE', 'RU',
		'BL', 'SX', 'MF', 'SA', 'SG', 'SK', 'KR', 'SS', 'TW', 'TH', 'AE', 'GB', 'US', 'VN']
	if rt.is_true(rt.call_function('in_array', [var_country.clone(),
		rt.create_array_from_list(var_home_counties), rt.new_bool(true)]))
	{
		return var_url.str() + '/webapps/mpp/home'
	} else if rt.is_true(rt.call_function('in_array', [var_country.clone(),
		rt.create_array_from_list(var_countries), rt.new_bool(true)]))
	{
		return var_url.str() + '/webapps/mpp/paypal-popup'
	} else {
		return var_url.str() + '/cgi-bin/webscr?cmd=xpt/Marketing/general/WIPaypal-outside'
	}
	return ''
}

fn (mut this Class_WC_Gateway_Paypal) get_paypal_icon_image() rt.PhpVal {
	mut iife_temp_2 := Class_WC_HTTPS{}
	mut iife_result_2 := iife_temp_2.force_https_url(rt.new_string(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
		'/assets/images/paypal.png'))
	mut var_icon := iife_result_2
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_paypal_icon'),
		var_icon.clone()])
}

fn (mut this Class_WC_Gateway_Paypal) get_icon_image(var_country rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.6.0'), rt.new_string('get_paypal_icon_image()')])
	mut switch_val_1 := var_country
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('US')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('NZ')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('CZ')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('HU')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('MY'))) {
		mut var_icon :=
			rt.new_string('https://www.paypalobjects.com/webstatic/mktg/logo/AM_mc_vs_dc_ae.jpg')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('TR'))) {
		var_icon =
			rt.new_string('https://www.paypalobjects.com/webstatic/mktg/logo-center/logo_paypal_odeme_secenekleri.jpg')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('GB'))) {
		var_icon =
			rt.new_string('https://www.paypalobjects.com/webstatic/mktg/Logo/AM_mc_vs_ms_ae_UK.png')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('MX'))) {
		var_icon = rt.create_array([
			rt.ArrayItem{
				key: none
				val: 'https://www.paypal.com/es_XC/Marketing/i/banner/paypal_visa_mastercard_amex.png'
			},
			rt.ArrayItem{
				key: none
				val: 'https://www.paypal.com/es_XC/Marketing/i/banner/paypal_debit_card_275x60.gif'
			},
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('FR'))) {
		var_icon =
			rt.new_string('https://www.paypalobjects.com/webstatic/mktg/logo-center/logo_paypal_moyens_paiement_fr.jpg')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('AU'))) {
		var_icon =
			rt.new_string('https://www.paypalobjects.com/webstatic/en_AU/mktg/logo/Solutions-graphics-1-184x80.jpg')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('DK'))) {
		var_icon =
			rt.new_string('https://www.paypalobjects.com/webstatic/mktg/logo-center/logo_PayPal_betalingsmuligheder_dk.jpg')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('RU'))) {
		var_icon =
			rt.new_string('https://www.paypalobjects.com/webstatic/ru_RU/mktg/business/pages/logo-center/AM_mc_vs_dc_ae.jpg')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('NO'))) {
		var_icon =
			rt.new_string('https://www.paypalobjects.com/webstatic/mktg/logo-center/banner_pl_just_pp_319x110.jpg')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('CA'))) {
		var_icon =
			rt.new_string('https://www.paypalobjects.com/webstatic/en_CA/mktg/logo-image/AM_mc_vs_dc_ae.jpg')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('HK'))) {
		var_icon =
			rt.new_string('https://www.paypalobjects.com/webstatic/en_HK/mktg/logo/AM_mc_vs_dc_ae.jpg')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('SG'))) {
		var_icon =
			rt.new_string('https://www.paypalobjects.com/webstatic/en_SG/mktg/Logos/AM_mc_vs_dc_ae.jpg')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('TW'))) {
		var_icon =
			rt.new_string('https://www.paypalobjects.com/webstatic/en_TW/mktg/logos/AM_mc_vs_dc_ae.jpg')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('TH'))) {
		var_icon =
			rt.new_string('https://www.paypalobjects.com/webstatic/en_TH/mktg/Logos/AM_mc_vs_dc_ae.jpg')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('JP'))) {
		var_icon =
			rt.new_string('https://www.paypal.com/ja_JP/JP/i/bnr/horizontal_solution_4_jcb.gif')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('IN'))) {
		var_icon =
			rt.new_string('https://www.paypalobjects.com/webstatic/mktg/logo/AM_mc_vs_dc_ae.jpg')
	} else {
		mut iife_temp_3 := Class_WC_HTTPS{}
		mut iife_result_3 := iife_temp_3.force_https_url(rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/includes/gateways/paypal/assets/images/paypal.png'))
		var_icon = iife_result_3
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_paypal_icon'),
		var_icon.clone()])
}

fn (mut this Class_WC_Gateway_Paypal) is_valid_for_use() rt.PhpVal {
	if this.should_use_orders_v2() {
		mut var_valid_currencies :=
			Class_Automattic_WooCommerce_Gateways_PayPal_Constants.supported_currencies()
	} else {
		var_valid_currencies = rt.create_array([rt.ArrayItem{ key: none, val: 'AUD' },
			rt.ArrayItem{ key: none, val: 'BRL' }, rt.ArrayItem{ key: none, val: 'CAD' },
			rt.ArrayItem{ key: none, val: 'MXN' }, rt.ArrayItem{ key: none, val: 'NZD' },
			rt.ArrayItem{ key: none, val: 'HKD' }, rt.ArrayItem{ key: none, val: 'SGD' },
			rt.ArrayItem{ key: none, val: 'USD' }, rt.ArrayItem{ key: none, val: 'EUR' },
			rt.ArrayItem{ key: none, val: 'JPY' }, rt.ArrayItem{ key: none, val: 'TRY' },
			rt.ArrayItem{ key: none, val: 'NOK' }, rt.ArrayItem{ key: none, val: 'CZK' },
			rt.ArrayItem{ key: none, val: 'DKK' }, rt.ArrayItem{ key: none, val: 'HUF' },
			rt.ArrayItem{ key: none, val: 'ILS' }, rt.ArrayItem{ key: none, val: 'MYR' },
			rt.ArrayItem{ key: none, val: 'PHP' }, rt.ArrayItem{ key: none, val: 'PLN' },
			rt.ArrayItem{ key: none, val: 'SEK' }, rt.ArrayItem{ key: none, val: 'CHF' },
			rt.ArrayItem{ key: none, val: 'TWD' }, rt.ArrayItem{ key: none, val: 'THB' },
			rt.ArrayItem{ key: none, val: 'GBP' }, rt.ArrayItem{ key: none, val: 'RMB' },
			rt.ArrayItem{ key: none, val: 'RUB' }, rt.ArrayItem{ key: none, val: 'INR' }])
	}
	return rt.call_function('in_array', [
		rt.call_function('get_woocommerce_currency', []rt.PhpVal{}),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_paypal_supported_currencies'),
			var_valid_currencies.clone(),
		]),
		rt.new_bool(true),
	])
}

fn (mut this Class_WC_Gateway_Paypal) admin_options() {
	if rt.is_true(this.is_valid_for_use()) {
		this.Class_WC_Payment_Gateway.admin_options()
	} else if !(this.should_use_orders_v2()) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Gateway disabled'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('PayPal Standard does not support your store currency.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WC_Gateway_Paypal) init_form_fields() {
	this.dispatch_set_prop('form_fields', rt.include_file(@DIR + '/includes/settings-paypal.php',
		'1'))
}

fn (mut this Class_WC_Gateway_Paypal) maybe_remove_fields(var_form_fields rt.PhpVal) rt.PhpVal {
	if this.should_use_orders_v2() {
		mut iter_1 := var_form_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_key := item_1.key
			if var_field.array_isset(rt.new_string('is_legacy'))
				&& rt.is_true(var_field.array_get(rt.new_string('is_legacy'))) {
				var_form_fields.array_unset(var_key)
			}
		}
	}
	if !(this.should_use_orders_v2()) {
		var_form_fields.array_unset(rt.new_string('paypal_buttons'))
	}
	return var_form_fields.clone()
}

fn (mut this Class_WC_Gateway_Paypal) get_transaction_url(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	if this.testmode {
		this.dispatch_set_prop('view_transaction_url',
			rt.new_string('https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_view-a-trans&id=%s'))
	} else {
		this.dispatch_set_prop('view_transaction_url',
			rt.new_string('https://www.paypal.com/cgi-bin/webscr?cmd=_view-a-trans&id=%s'))
	}
	return this.Class_WC_Payment_Gateway.get_transaction_url(var_order_mutated.clone())
}

fn (mut this Class_WC_Gateway_Paypal) process_payment(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return rt.new_array()
	}
	if this.should_use_orders_v2() {
		mut var_paypal_request := create_automattic_woocommerce_gateways_paypal_request(rt.new_object('WC_Gateway_Paypal', [
			'WC_Payment_Gateway',
		], &this))
		mut var_paypal_order := rt.call_method(var_paypal_request, 'create_paypal_order', [
			var_order.clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_paypal_order))))
			|| !rt.is_true(var_paypal_order.array_get(rt.new_string('id')))
			|| !rt.is_true(var_paypal_order.array_get(rt.new_string('redirect_url'))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html__', [
				rt.new_string('We are unable to process your PayPal payment at this time. Please try again or use a different payment method.'),
				rt.new_string('woocommerce'),
			]))))
		}
		mut var_redirect_url := var_paypal_order.array_get(rt.new_string('redirect_url'))
	} else {
		rt.include_file(@DIR + '/includes/class-wc-gateway-paypal-request.php', '2')
		var_paypal_request = create_wc_gateway_paypal_request(rt.new_object('WC_Gateway_Paypal', [
			'WC_Payment_Gateway',
		], &this))
		var_redirect_url = rt.call_method(var_paypal_request, 'get_request_url', [
			var_order.clone(),
			rt.new_bool(this.testmode),
		])
	}
	return rt.create_array([rt.ArrayItem{ key: 'result', val: 'success' },
		rt.ArrayItem{ key: 'redirect', val: var_redirect_url }])
}

fn (mut this Class_WC_Gateway_Paypal) can_refund_order(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut var_has_api_creds := rt.new_bool(false)
	if this.testmode {
		var_has_api_creds = rt.new_bool(
			rt.is_true(this.get_option(rt.new_string('sandbox_api_username')))
			&& rt.is_true(this.get_option(rt.new_string('sandbox_api_password')))
			&& rt.is_true(this.get_option(rt.new_string('sandbox_api_signature'))))
	} else {
		var_has_api_creds = rt.new_bool(rt.is_true(this.get_option(rt.new_string('api_username')))
			&& rt.is_true(this.get_option(rt.new_string('api_password')))
			&& rt.is_true(this.get_option(rt.new_string('api_signature'))))
	}
	return rt.is_true(var_order_mutated)
		&& rt.is_true(rt.call_method(var_order_mutated, 'get_transaction_id', []rt.PhpVal{}))
		&& rt.is_true(var_has_api_creds)
}

fn (mut this Class_WC_Gateway_Paypal) init_api() {
	rt.include_file(@DIR + '/includes/class-wc-gateway-paypal-api-handler.php', '2')
	rt.set_static_prop('WC_Gateway_Paypal_API_Handler', 'api_username', if this.testmode {
		this.get_option(rt.new_string('sandbox_api_username'))
	} else {
		this.get_option(rt.new_string('api_username'))
	})
	rt.set_static_prop('WC_Gateway_Paypal_API_Handler', 'api_password', if this.testmode {
		this.get_option(rt.new_string('sandbox_api_password'))
	} else {
		this.get_option(rt.new_string('api_password'))
	})
	rt.set_static_prop('WC_Gateway_Paypal_API_Handler', 'api_signature', if this.testmode {
		this.get_option(rt.new_string('sandbox_api_signature'))
	} else {
		this.get_option(rt.new_string('api_signature'))
	})
	rt.set_static_prop('WC_Gateway_Paypal_API_Handler', 'sandbox', this.testmode)
}

fn (mut this Class_WC_Gateway_Paypal) process_refund(var_order_id rt.PhpVal, var_amount rt.PhpVal, reason string) bool {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if !(this.can_refund_order(var_order.clone())) {
		return (create_wp_error(rt.new_string('error'), rt.call_function('__', [
			rt.new_string('Refund failed.'),
			rt.new_string('woocommerce'),
		]))).to_bool()
	}
	this.init_api()
	mut iife_temp_4 := Class_WC_Gateway_Paypal_API_Handler{}
	mut iife_result_4 := iife_temp_4.refund_transaction(var_order.clone(), var_amount.clone(),
		rt.new_string(reason))
	mut var_result := iife_result_4
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		Class_WC_Gateway_Paypal.log('Refund Failed: ' +
			(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{})).str(),
			rt.new_string('error'))
		return (create_wp_error(rt.new_string('error'), rt.call_method(var_result,
			'get_error_message', []rt.PhpVal{}))).to_bool()
	}
	Class_WC_Gateway_Paypal.log('Refund Result: ' +
		(rt.call_function('wc_print_r', [var_result.clone(), rt.new_bool(true)])).str())
	mut switch_val_2 := rt.new_string(rt.get_property(var_result, 'ACK').to_string().to_lower())
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('success')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('successwithwarning'))) {
		rt.call_method(var_order, 'add_order_note', [
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Refunded %1$s - Refund ID: %2$s'),
					rt.new_string('woocommerce')]),
				rt.get_property(var_result, 'GROSSREFUNDAMT'),
				rt.get_property(var_result, 'REFUNDTRANSACTIONID'),
			]),
		])
		return true
	}
	return (if !(rt.get_property(var_result, 'L_LONGMESSAGE0')).is_null() {
		create_wp_error(rt.new_string('error'), rt.get_property(var_result, 'L_LONGMESSAGE0'))
	} else {
		rt.new_bool(false)
	}).to_bool()
	return false
}

fn (mut this Class_WC_Gateway_Paypal) capture_payment(var_order_id rt.PhpVal) {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WC_Gateway_Paypal.id(), rt.call_method(var_order,
		'get_payment_method', []rt.PhpVal{})))))
	{
		return
	}
	mut var_is_authorized_via_legacy_api := rt.identical(rt.new_string('pending'), rt.call_method(var_order,
		'get_meta', [
		Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
		rt.new_bool(true),
	]))
	if this.should_use_orders_v2()
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_authorized_via_legacy_api)))) {
		mut var_paypal_request := create_automattic_woocommerce_gateways_paypal_request(rt.new_object('WC_Gateway_Paypal', [
			'WC_Payment_Gateway',
		], &this))
		rt.call_method(var_paypal_request, 'capture_authorized_payment', [
			var_order.clone()])
		return
	}
	if rt.is_true(rt.identical(rt.new_string('pending'), rt.call_method(var_order, 'get_meta', [Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(), rt.new_bool(true)])))
		&& rt.is_true(rt.call_method(var_order, 'get_transaction_id', []rt.PhpVal{})) {
		this.init_api()
		mut iife_temp_5 := Class_WC_Gateway_Paypal_API_Handler{}
		mut iife_result_5 := iife_temp_5.do_capture(var_order.clone())
		mut var_result := iife_result_5
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			Class_WC_Gateway_Paypal.log('Capture Failed: ' +
				(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{})).str(),
				rt.new_string('error'))
			rt.call_method(var_order, 'add_order_note', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Payment could not be captured: %s'),
						rt.new_string('woocommerce'),
					]),
					rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}),
				]),
			])
			return
		}
		Class_WC_Gateway_Paypal.log('Capture Result: ' +
			(rt.call_function('wc_print_r', [var_result.clone(), rt.new_bool(true)])).str())
		if !(!rt.is_true(rt.get_property(var_result, 'PAYMENTSTATUS'))) {
			mut switch_val_3 := rt.get_property(var_result, 'PAYMENTSTATUS')
			if rt.is_true(rt.equal(switch_val_3, rt.new_string('Completed'))) {
				rt.call_method(var_order, 'add_order_note', [
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Payment of %1$s was captured - Auth ID: %2$s, Transaction ID: %3$s'),
							rt.new_string('woocommerce'),
						]),
						rt.get_property(var_result, 'AMT'),
						rt.get_property(var_result, 'AUTHORIZATIONID'),
						rt.get_property(var_result, 'TRANSACTIONID'),
					]),
				])
				rt.call_method(var_order, 'update_meta_data', [
					Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_meta_status(),
					rt.get_property(var_result, 'PAYMENTSTATUS'),
				])
				rt.call_method(var_order, 'set_transaction_id', [
					rt.get_property(var_result, 'TRANSACTIONID'),
				])
				rt.call_method(var_order, 'save', []rt.PhpVal{})
			} else {
				rt.call_method(var_order, 'add_order_note', [
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Payment could not be captured - Auth ID: %1$s, Status: %2$s'),
							rt.new_string('woocommerce'),
						]),
						rt.get_property(var_result, 'AUTHORIZATIONID'),
						rt.get_property(var_result, 'PAYMENTSTATUS'),
					]),
				])
			}
		}
	}
}

fn (mut this Class_WC_Gateway_Paypal) admin_scripts() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_screen_id := if rt.is_true(var_screen) {
		rt.get_property(var_screen, 'id')
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'),
		var_screen_id))))
	{
		return
	}
	mut iife_temp_6 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_6 := iife_temp_6.is_true(rt.new_string('SCRIPT_DEBUG'))
	mut var_suffix := rt.new_string((if rt.is_true(iife_result_6) { '' } else { '.min' }).str())
	mut iife_temp_7 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_7 := iife_temp_7.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_7
	rt.call_function('wp_enqueue_script', [rt.new_string('woocommerce_paypal_admin'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/includes/gateways/paypal/assets/js/paypal-admin' + var_suffix.str() + '.js'),
		rt.new_array(), var_version.clone(), rt.new_bool(true)])
}

fn (mut this Class_WC_Gateway_Paypal) enqueue_scripts() {
	if rt.is_true(rt.identical(rt.new_string('no'), rt.get_property(rt.new_object('WC_Gateway_Paypal', [
		'WC_Payment_Gateway',
	], &this), 'enabled')))
	{
		return
	}
	mut iife_temp_8 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_8 := iife_temp_8.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_8
	mut var_is_page_supported := rt.new_bool(
		rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_cart', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_product', []rt.PhpVal{})))
	mut var_buttons := create_automattic_woocommerce_gateways_paypal_buttons(rt.new_object('WC_Gateway_Paypal', [
		'WC_Payment_Gateway',
	], &this))
	mut var_options := var_buttons.get_common_options()
	if !rt.is_true(var_options.array_get(rt.new_string('client-id')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_is_page_supported)))) {
		return
	}
	mut var_sdk_host := rt.new_string((if this.testmode {
		'https://www.sandbox.paypal.com/sdk/js'
	} else {
		'https://www.paypal.com/sdk/js'
	}).str())
	rt.call_function('wp_register_script', [rt.new_string('paypal-standard-sdk'),
		rt.call_function('add_query_arg', [var_options.clone(),
			var_sdk_host.clone()]),
		rt.new_array(), rt.new_null(), rt.new_bool(false)])
	rt.call_function('wp_enqueue_script', [rt.new_string('paypal-standard-sdk')])
	rt.call_function('wp_register_script', [rt.new_string('wc-paypal-frontend'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/client/legacy/js/gateways/paypal.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'wp-api-fetch' }]),
		var_version.clone(), rt.new_bool(true)])
	rt.call_function('wp_localize_script', [rt.new_string('wc-paypal-frontend'),
		rt.new_string('paypal_standard'),
		rt.create_array([
			rt.ArrayItem{ key: 'gateway_id', val: rt.get_property(rt.new_object('WC_Gateway_Paypal', [
				'WC_Payment_Gateway',
			], &this), 'id') },
			rt.ArrayItem{ key: 'is_product_page', val: rt.call_function('is_product', []rt.PhpVal{}) },
			rt.ArrayItem{
				key: 'app_switch_request_origin'
				val: var_buttons.get_current_page_for_app_switch()
			},
			rt.ArrayItem{ key: 'wc_store_api_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('wc_store_api'),
			]) },
			rt.ArrayItem{ key: 'create_order_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('wc_gateway_paypal_standard_create_order'),
			]) },
			rt.ArrayItem{ key: 'cancel_payment_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('wc_gateway_paypal_standard_cancel_payment'),
			]) },
			rt.ArrayItem{ key: 'generic_error_message', val: rt.call_function('__', [
				rt.new_string('An unknown error occurred'),
				rt.new_string('woocommerce'),
			]) },
		])])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-paypal-frontend')])
}

fn (mut this Class_WC_Gateway_Paypal) add_paypal_sdk_attributes(var_attrs rt.PhpVal) rt.PhpVal {
	mut var_attrs_mutated := var_attrs
	if rt.is_true(rt.identical(rt.new_string('paypal-standard-sdk-js'),
		var_attrs_mutated.array_get(rt.new_string('id'))))
	{
		mut var_buttons := create_automattic_woocommerce_gateways_paypal_buttons(rt.new_object('WC_Gateway_Paypal', [
			'WC_Payment_Gateway',
		], &this))
		mut var_page_type := var_buttons.get_page_type()
		var_attrs_mutated.array_set('data-page-type', var_page_type.clone())
		var_attrs_mutated.array_set('data-partner-attribution-id', 'Woo_Cart_CoreUpgrade')
	}
	return var_attrs_mutated.clone()
}

fn (mut this Class_WC_Gateway_Paypal) render_buttons_container() {
	print('<div id="paypal-standard-container"></div>')
}

fn (mut this Class_WC_Gateway_Paypal) order_received_text(var_text rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	if rt.is_true(var_order_mutated)
		&& rt.is_true(rt.identical(rt.get_property(rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this), 'id'), rt.call_method(var_order_mutated, 'get_payment_method', []rt.PhpVal{}))) {
		return rt.call_function('esc_html__', [
			rt.new_string('Thank you for your payment. Your transaction has been completed, and a receipt for your purchase has been emailed to you. Log into your PayPal account to view transaction details.'),
			rt.new_string('woocommerce'),
		])
	}
	return var_text.clone()
}

fn (mut this Class_WC_Gateway_Paypal) hide_action_buttons(var_actions rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	if this.should_use_orders_v2()
		&& rt.is_true(rt.identical(rt.get_property(rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this), 'id'), rt.call_method(var_order_mutated, 'get_payment_method', []rt.PhpVal{}))) {
		var_actions.array_unset(rt.new_string('pay'))
		var_actions.array_unset(rt.new_string('cancel'))
	}
	return var_actions.clone()
}

fn (mut this Class_WC_Gateway_Paypal) should_load() rt.PhpVal {
	mut var_option_key := rt.new_string('_should_load')
	mut var_should_load := this.get_option(var_option_key.clone())
	if rt.is_true(rt.identical(rt.new_string(''), var_should_load)) {
		var_should_load = rt.new_bool(
			rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this), 'enabled')))
			|| this.has_paypal_orders())
		this.update_option(var_option_key.clone(), rt.call_function('wc_bool_to_string', [
			var_should_load.clone(),
		]))
	} else {
		var_should_load = rt.new_bool(
			rt.is_true(rt.call_function('wc_string_to_bool', [rt.get_property(rt.new_object('WC_Gateway_Paypal', ['WC_Payment_Gateway'], &this), 'enabled')]))
			|| rt.is_true(rt.call_function('wc_string_to_bool', [var_should_load.clone()])))
	}
	return var_should_load.clone()
}

fn (mut this Class_WC_Gateway_Paypal) has_paypal_orders() bool {
	mut var_paypal_orders := rt.call_function('wc_get_orders', [
		rt.create_array([rt.ArrayItem{ key: 'limit', val: 1 },
			rt.ArrayItem{ key: 'return', val: 'ids' }, rt.ArrayItem{
				key: 'payment_method'
				val: Class_WC_Gateway_Paypal.id()
			}]),
	])
	return if rt.call_function('is_countable', [var_paypal_orders.clone()]) {
		rt.new_bool(1 == var_paypal_orders.clone().array_count())
	} else {
		false
	}
}

fn (mut this Class_WC_Gateway_Paypal) should_use_orders_v2() bool {
	mut iife_temp_9 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_9 := iife_temp_9.is_orders_v2_migration_eligible()
	mut var_use_orders_v2 := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_paypal_use_orders_v2'),
		iife_result_9,
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_use_orders_v2)))) {
		return false
	}
	if !(this.is_transact_onboarding_complete()) {
		return false
	}
	mut var_jetpack_connection_manager := this.get_jetpack_connection_manager()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_jetpack_connection_manager))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_jetpack_connection_manager, 'is_connected', []rt.PhpVal{}))))) {
		return false
	}
	mut var_transact_account_manager := create_automattic_woocommerce_gateways_paypal_transactaccountmanager(rt.new_object('WC_Gateway_Paypal', [
		'WC_Payment_Gateway',
	], &this))
	mut var_merchant_account_data :=
		var_transact_account_manager.get_transact_account_data(rt.new_string('merchant'))
	if !rt.is_true(var_merchant_account_data) {
		return false
	}
	mut var_provider_account_data :=
		var_transact_account_manager.get_transact_account_data(rt.new_string('provider'))
	if !rt.is_true(var_provider_account_data) {
		return false
	}
	return true
}

fn (mut this Class_WC_Gateway_Paypal) get_jetpack_connection_manager() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.jetpack_connection_manager)))) {
		this.jetpack_connection_manager =
			create_automattic_jetpack_connection_manager(rt.new_string('woocommerce'))
	}
	return this.jetpack_connection_manager
}

fn (mut this Class_WC_Gateway_Paypal) is_transact_onboarding_complete() bool {
	return this.transact_onboarding_complete
}

fn (mut this Class_WC_Gateway_Paypal) set_transact_onboarding_complete() {
	if this.transact_onboarding_complete {
		return
	}
	this.update_option(rt.new_string('transact_onboarding_complete'), rt.new_string('yes'))
	this.transact_onboarding_complete = true
}

fn (mut this Class_WC_Gateway_Paypal) manage_account_restriction_status(var_http_code rt.PhpVal, var_response_data rt.PhpVal, var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_paypal_account_restriction_notices_enabled'),
		rt.new_bool(true),
	])))))
	{
		return
	}
	mut iife_temp_10 := Class_Automattic_WooCommerce_Gateways_PayPal_Notices{}
	mut iife_result_10 := iife_temp_10.manage_account_restriction_flag_for_notice(var_http_code.clone(),
		var_response_data.clone(), var_order_mutated.clone())
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

struct Class_WC_HTTPS {
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

struct Class_WC_Gateway_Paypal_Request {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Gateway_Paypal_API_Handler {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Connection_Manager {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Notices {
	rt.PhpObjectBase
}

fn create_wc_gateway_paypal() &Class_WC_Gateway_Paypal {
	mut obj := &Class_WC_Gateway_Paypal{
		PhpObjectBase:                rt.PhpObjectBase{}
		testmode:                     false
		debug:                        false
		intent:                       ''
		email:                        rt.new_null()
		receiver_email:               rt.new_null()
		identity_token:               rt.new_null()
		jetpack_connection_manager:   rt.new_null()
		transact_onboarding_complete: false
	}
	obj.construct()
	return obj
}

fn create_wc_payment_gateway(_args ...rt.PhpVal) &Class_WC_Payment_Gateway {
	mut obj := &Class_WC_Payment_Gateway{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_gateway_paypal_ipn_handler(_args ...rt.PhpVal) &Class_WC_Gateway_Paypal_IPN_Handler {
	mut obj := &Class_WC_Gateway_Paypal_IPN_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_gateway_paypal_pdt_handler(_args ...rt.PhpVal) &Class_WC_Gateway_Paypal_PDT_Handler {
	mut obj := &Class_WC_Gateway_Paypal_PDT_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_buttons(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_Buttons {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Buttons{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_request(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_Request {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_Helper {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_transactaccountmanager(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_TransactAccountManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_https(_args ...rt.PhpVal) &Class_WC_HTTPS {
	mut obj := &Class_WC_HTTPS{
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

fn create_wc_gateway_paypal_request(_args ...rt.PhpVal) &Class_WC_Gateway_Paypal_Request {
	mut obj := &Class_WC_Gateway_Paypal_Request{
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

fn create_wc_gateway_paypal_api_handler(_args ...rt.PhpVal) &Class_WC_Gateway_Paypal_API_Handler {
	mut obj := &Class_WC_Gateway_Paypal_API_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_connection_manager(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Connection_Manager {
	mut obj := &Class_Automattic_Jetpack_Connection_Manager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_notices(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_Notices {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Notices{
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
			return rt.new_bool(this.process_refund(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
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
		else {
			return none
		}
	}
}

fn (this &Class_WC_Gateway_Paypal) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'testmode' { return rt.new_bool(this.testmode) }
		'debug' { return rt.new_bool(this.debug) }
		'intent' { return rt.new_string(this.intent) }
		'email' { return this.email }
		'receiver_email' { return this.receiver_email }
		'identity_token' { return this.identity_token }
		'jetpack_connection_manager' { return this.jetpack_connection_manager }
		'transact_onboarding_complete' { return rt.new_bool(this.transact_onboarding_complete) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Gateway_Paypal) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'testmode' {
			this.testmode = val.to_bool()
			return true
		}
		'debug' {
			this.debug = val.to_bool()
			return true
		}
		'intent' {
			this.intent = val.str()
			return true
		}
		'email' {
			this.email = val
			return true
		}
		'receiver_email' {
			this.receiver_email = val
			return true
		}
		'identity_token' {
			this.identity_token = val
			return true
		}
		'jetpack_connection_manager' {
			this.jetpack_connection_manager = val
			return true
		}
		'transact_onboarding_complete' {
			this.transact_onboarding_complete = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WC_HTTPS) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_HTTPS) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_HTTPS) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Gateway_Paypal_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Gateway_Paypal_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Gateway_Paypal_API_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Gateway_Paypal_API_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal_API_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Connection_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Notices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Gateway_Paypal_Constants'),
	])))))
	{
		rt.include_file(@DIR + '/includes/class-wc-gateway-paypal-constants.php', '4')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Gateway_Paypal_Helper'),
	])))))
	{
		rt.include_file(@DIR + '/includes/class-wc-gateway-paypal-helper.php', '4')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Gateway_Paypal_Notices'),
	])))))
	{
		rt.include_file(@DIR + '/includes/class-wc-gateway-paypal-notices.php', '4')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Gateway_Paypal_Buttons'),
	])))))
	{
		rt.include_file(@DIR + '/class-wc-gateway-paypal-buttons.php', '4')
	}
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
			|| (rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AJAX')]))
			&& rt.is_true(rt.get_constant('DOING_AJAX'))) {
			return rt.new_null()
		}
		rt.include_file(@DIR + '/includes/class-wc-gateway-paypal-notices.php', '2')
		create_automattic_woocommerce_gateways_paypal_notices()
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('init'), rt.new_closure(closure_12_fn)])
}
