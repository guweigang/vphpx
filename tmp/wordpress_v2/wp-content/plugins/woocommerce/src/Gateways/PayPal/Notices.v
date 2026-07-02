import rt

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Notices.paypal_migration_notice() string {
	return 'paypal_migration_completed'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Notices.paypal_account_restricted_notice() string {
	return 'paypal_account_restricted'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Notices.paypal_unsupported_currency_notice() string {
	return 'paypal_unsupported_currency'
}

pub fn Class_Automattic_WooCommerce_Gateways_PayPal_Notices.paypal_account_restriction_issues() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_issue_payee_account_locked_or_closed()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_issue_payee_account_restricted()
		},
	])
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Notices {
	rt.PhpObjectBase
pub mut:
	gateway rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) construct() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
	mut iife_result_0 := iife_temp_0.get_instance()
	this.gateway = iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(this.gateway)))) {
		return
	}
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.call_function('add_action', [rt.new_string('admin_notices'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Gateways_PayPal_Notices',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'add_paypal_notices' },
			])])
		rt.call_function('add_action', [rt.new_string('admin_head'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Gateways_PayPal_Notices',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'add_paypal_notices_on_payments_settings_page' },
			])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) add_paypal_notices() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))))) {
		return
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_1 := iife_temp_1.is_paypal_gateway_available()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.gateway, 'should_use_orders_v2', []rt.PhpVal{}))))) {
		return
	}
	this.add_paypal_migration_notice()
	this.add_paypal_account_restricted_notice()
	this.add_paypal_unsupported_currency_notice()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) add_paypal_notices_on_payments_settings_page() {
	mut var_current_tab := rt.new_null()
	mut var_current_section := rt.new_null()
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_screen_id := if rt.is_true(var_screen) {
		rt.get_property(var_screen, 'id')
	} else {
		rt.new_string('')
	}
	mut var_is_payments_settings_page := rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-settings'), var_screen_id))
		&& rt.is_true(rt.identical(rt.new_string('checkout'), var_current_tab))
		&& !rt.is_true(var_current_section))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_payments_settings_page)))) {
		return
	}
	this.add_paypal_notices()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) add_paypal_migration_notice() {
	if this.is_notice_dismissed((Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Notices.paypal_migration_notice()).str()) {
		return
	}
	mut var_doc_url :=
		rt.new_string('https://woocommerce.com/document/woocommerce-paypal-payments/paypal-payments-upgrade-guide/')
	mut var_dismiss_url :=
		rt.new_string(this.get_dismiss_url((Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Notices.paypal_migration_notice()).str()))
	mut var_message := rt.call_function('sprintf', [
		rt.call_function('esc_html__', [
			rt.new_string('WooCommerce has upgraded your PayPal integration from PayPal Standard to PayPal Payments (PPCP), for a more reliable and modern checkout experience. If you do not prefer the upgraded integration in WooCommerce, we recommend switching to %1$sPayPal Payments%2$s extension.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('<a href="' + (rt.call_function('esc_url', [var_doc_url.clone()])).str() +
			'" target="_blank" rel="noopener noreferrer">'),
		rt.new_string('</a>'),
	])
	mut var_notice_html := rt.new_string('<div class="notice notice-warning is-dismissible">' +
		'<a class="woocommerce-message-close notice-dismiss" style="text-decoration: none;" href="' +
		(rt.call_function('esc_url', [var_dismiss_url.clone()])).str() + '" aria-label="' +
		(rt.call_function('esc_attr__', [rt.new_string('Dismiss this notice'), rt.new_string('woocommerce')])).str() +
		'"></a>' + '<p>' + var_message.str() + '</p>' + '</div>')
	rt.echo_val(rt.call_function('wp_kses_post', [var_notice_html.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) add_paypal_account_restricted_notice() {
	if !(this.has_account_restriction_flag()) {
		return
	}
	if this.is_notice_dismissed((Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Notices.paypal_account_restricted_notice()).str()) {
		return
	}
	mut var_support_url := rt.new_string('https://www.paypal.com/smarthelp/contact-us')
	mut var_dismiss_url :=
		rt.new_string(this.get_dismiss_url((Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Notices.paypal_account_restricted_notice()).str()))
	mut var_message := rt.call_function('sprintf', [
		rt.call_function('esc_html__', [
			rt.new_string('Your PayPal account has been restricted by PayPal. This may prevent customers from completing payments. Please %1$scontact PayPal support%2$s to resolve this issue and restore full functionality to your account.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('<a href="' + (rt.call_function('esc_url', [var_support_url.clone()])).str() +
			'" target="_blank" rel="noopener noreferrer">'),
		rt.new_string('</a>'),
	])
	mut var_notice_html := rt.new_string('<div class="notice notice-error is-dismissible">' +
		'<a class="woocommerce-message-close notice-dismiss" style="text-decoration: none;" href="' +
		(rt.call_function('esc_url', [var_dismiss_url.clone()])).str() + '" aria-label="' +
		(rt.call_function('esc_attr__', [rt.new_string('Dismiss this notice'), rt.new_string('woocommerce')])).str() +
		'"></a>' + '<p><strong>' +
		(rt.call_function('esc_html__', [rt.new_string('PayPal Account Restricted'), rt.new_string('woocommerce')])).str() +
		'</strong></p>' + '<p>' + var_message.str() + '</p>' + '</div>')
	rt.echo_val(rt.call_function('wp_kses_post', [var_notice_html.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) add_paypal_unsupported_currency_notice() {
	mut var_currency := rt.call_function('get_woocommerce_currency', []rt.PhpVal{})
	if rt.is_true(rt.call_method(this.gateway, 'is_valid_for_use', []rt.PhpVal{})) {
		return
	}
	if this.is_notice_dismissed((Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Notices.paypal_unsupported_currency_notice()).str()) {
		return
	}
	mut var_dismiss_url :=
		rt.new_string(this.get_dismiss_url((Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Notices.paypal_unsupported_currency_notice()).str()))
	mut var_message := rt.call_function('sprintf', [
		rt.call_function('esc_html__', [
			rt.new_string('PayPal Standard does not support your store currency (%s).'),
			rt.new_string('woocommerce'),
		]),
		var_currency.clone(),
	])
	mut var_notice_html := rt.new_string('<div class="notice notice-error is-dismissible">' +
		'<a class="woocommerce-message-close notice-dismiss" style="text-decoration: none;" href="' +
		(rt.call_function('esc_url', [var_dismiss_url.clone()])).str() + '" aria-label="' +
		(rt.call_function('esc_attr__', [rt.new_string('Dismiss this notice'), rt.new_string('woocommerce')])).str() +
		'"></a>' + '<p>' + var_message.str() + '</p>' + '</div>')
	rt.echo_val(rt.call_function('wp_kses_post', [var_notice_html.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) get_dismiss_url(notice_name string) string {
	return (rt.call_function('wp_nonce_url', [
		rt.call_function('add_query_arg', [rt.new_string('wc-hide-notice'),
			rt.new_string(notice_name)]),
		rt.new_string('woocommerce_hide_notices_nonce'),
		rt.new_string('_wc_notice_nonce'),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) is_notice_dismissed(notice_name string) bool {
	return (rt.call_function('get_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('dismissed_' + notice_name + '_notice'),
		rt.new_bool(true),
	])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) has_account_restriction_flag() bool {
	return (rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_paypal_account_restricted_status'),
		rt.new_string('no'),
	]))).to_bool()
}

fn Class_Automattic_WooCommerce_Gateways_PayPal_Notices.set_account_restriction_flag() {
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [
		rt.new_string('woocommerce_paypal_account_restricted_status'),
		rt.new_string('no'),
	])))
	{
		rt.call_function('update_option', [
			rt.new_string('woocommerce_paypal_account_restricted_status'),
			rt.new_string('yes'),
			rt.new_bool(false),
		])
	}
}

fn Class_Automattic_WooCommerce_Gateways_PayPal_Notices.clear_account_restriction_flag() {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_paypal_account_restricted_status'),
		rt.new_string('no'),
	])))
	{
		rt.call_function('update_option', [
			rt.new_string('woocommerce_paypal_account_restricted_status'),
			rt.new_string('no'),
		])
	}
}

fn Class_Automattic_WooCommerce_Gateways_PayPal_Notices.manage_account_restriction_flag_for_notice(var_http_code rt.PhpVal, mut var_response_data Class_Automattic_WooCommerce_Gateways_PayPal_array, mut var_order Class_WC_Order) {
	if rt.is_true(rt.call_function('in_array', [rt.new_int(var_http_code.to_i64()),
		rt.create_array([rt.ArrayItem{ key: none, val: 200 },
			rt.ArrayItem{ key: none, val: 201 }]),
		rt.new_bool(true)]))
	{
		Class_Automattic_WooCommerce_Gateways_PayPal_Notices.clear_account_restriction_flag()
		return
	}
	if !rt.is_true(var_response_data) {
		return
	}
	if 422 == rt.new_int(var_http_code.to_i64()) {
		mut var_issue := if var_response_data.array_get(rt.new_string('details')).array_get(rt.new_int(0)).array_isset(rt.new_string('issue')) {
			var_response_data.array_get(rt.new_string('details')).array_get(rt.new_int(0)).array_get(rt.new_string('issue'))
		} else {
			rt.new_string('')
		}
		if rt.is_true(rt.call_function('in_array', [var_issue.clone(),
			Class_Automattic_WooCommerce_Gateways_PayPal_Automattic_WooCommerce_Gateways_PayPal_Notices.paypal_account_restriction_issues(),
			rt.new_bool(true)]))
		{
			mut iife_temp_2 := Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{}
			mut iife_result_2 := iife_temp_2.log(rt.new_string(
				'PayPal account restriction flag set due to issues when handling the order: ' +
				(var_order.get_id()).str()))
			Class_Automattic_WooCommerce_Gateways_PayPal_Notices.set_account_restriction_flag()
		}
	}
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_gateways_paypal_notices() &Class_Automattic_WooCommerce_Gateways_PayPal_Notices {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_Notices{
		PhpObjectBase: rt.PhpObjectBase{}
		gateway:       rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_wc_gateway_paypal(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal{
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

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_paypal_notices' {
			this.add_paypal_notices()
			return rt.new_null()
		}
		'add_paypal_notices_on_payments_settings_page' {
			this.add_paypal_notices_on_payments_settings_page()
			return rt.new_null()
		}
		'add_paypal_migration_notice' {
			this.add_paypal_migration_notice()
			return rt.new_null()
		}
		'add_paypal_account_restricted_notice' {
			this.add_paypal_account_restricted_notice()
			return rt.new_null()
		}
		'add_paypal_unsupported_currency_notice' {
			this.add_paypal_unsupported_currency_notice()
			return rt.new_null()
		}
		'get_dismiss_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_dismiss_url(dispatch_arg_0))
		}
		'is_notice_dismissed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_notice_dismissed(dispatch_arg_0))
		}
		'has_account_restriction_flag' {
			return rt.new_bool(this.has_account_restriction_flag())
		}
		'set_account_restriction_flag' {
			Class_Automattic_WooCommerce_Gateways_PayPal_Notices.set_account_restriction_flag()
			return rt.new_null()
		}
		'clear_account_restriction_flag' {
			Class_Automattic_WooCommerce_Gateways_PayPal_Notices.clear_account_restriction_flag()
			return rt.new_null()
		}
		'manage_account_restriction_flag_for_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Gateways_PayPal_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WC_Order](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			Class_Automattic_WooCommerce_Gateways_PayPal_Notices.manage_account_restriction_flag_for_notice(dispatch_arg_0, mut
				dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Notices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'gateway' { return this.gateway }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Notices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'gateway' {
			this.gateway = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WC_Gateway_Paypal) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
