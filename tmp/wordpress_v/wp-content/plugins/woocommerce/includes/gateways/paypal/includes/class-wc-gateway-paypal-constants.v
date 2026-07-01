import rt

pub fn Class_WC_Gateway_Paypal_Constants.wpcom_proxy_request_timeout() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.wpcom_proxy_request_timeout()
}

pub fn Class_WC_Gateway_Paypal_Constants.status_completed() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_completed()
}

pub fn Class_WC_Gateway_Paypal_Constants.status_approved() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_approved()
}

pub fn Class_WC_Gateway_Paypal_Constants.status_captured() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_captured()
}

pub fn Class_WC_Gateway_Paypal_Constants.status_authorized() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_authorized()
}

pub fn Class_WC_Gateway_Paypal_Constants.status_payer_action_required() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.status_payer_action_required()
}

pub fn Class_WC_Gateway_Paypal_Constants.voided() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.voided()
}

pub fn Class_WC_Gateway_Paypal_Constants.intent_capture() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.intent_capture()
}

pub fn Class_WC_Gateway_Paypal_Constants.intent_authorize() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.intent_authorize()
}

pub fn Class_WC_Gateway_Paypal_Constants.payment_action_capture() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_action_capture()
}

pub fn Class_WC_Gateway_Paypal_Constants.payment_action_authorize() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_action_authorize()
}

pub fn Class_WC_Gateway_Paypal_Constants.shipping_no_shipping() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.shipping_no_shipping()
}

pub fn Class_WC_Gateway_Paypal_Constants.shipping_get_from_file() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.shipping_get_from_file()
}

pub fn Class_WC_Gateway_Paypal_Constants.shipping_set_provided_address() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.shipping_set_provided_address()
}

pub fn Class_WC_Gateway_Paypal_Constants.user_action_pay_now() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.user_action_pay_now()
}

pub fn Class_WC_Gateway_Paypal_Constants.paypal_order_item_name_max_length() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_order_item_name_max_length()
}

pub fn Class_WC_Gateway_Paypal_Constants.paypal_invoice_id_max_length() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_invoice_id_max_length()
}

pub fn Class_WC_Gateway_Paypal_Constants.paypal_address_line_max_length() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_address_line_max_length()
}

pub fn Class_WC_Gateway_Paypal_Constants.paypal_country_code_length() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_country_code_length()
}

pub fn Class_WC_Gateway_Paypal_Constants.paypal_state_max_length() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_state_max_length()
}

pub fn Class_WC_Gateway_Paypal_Constants.paypal_city_max_length() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_city_max_length()
}

pub fn Class_WC_Gateway_Paypal_Constants.paypal_postal_code_max_length() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_postal_code_max_length()
}

pub fn Class_WC_Gateway_Paypal_Constants.paypal_locale_max_length() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.paypal_locale_max_length()
}

pub fn Class_WC_Gateway_Paypal_Constants.payment_source_paypal() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_source_paypal()
}

pub fn Class_WC_Gateway_Paypal_Constants.payment_source_venmo() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_source_venmo()
}

pub fn Class_WC_Gateway_Paypal_Constants.payment_source_paylater() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.payment_source_paylater()
}

pub fn Class_WC_Gateway_Paypal_Constants.supported_payment_sources() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.supported_payment_sources()
}

pub fn Class_WC_Gateway_Paypal_Constants.fields_to_redact() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.fields_to_redact()
}

pub fn Class_WC_Gateway_Paypal_Constants.supported_currencies() rt.PhpVal {
	return Class_Automattic_WooCommerce_Gateways_PayPal_Constants.supported_currencies()
}

struct Class_WC_Gateway_Paypal_Constants {
	rt.PhpObjectBase
}

fn create_wc_gateway_paypal_constants() &Class_WC_Gateway_Paypal_Constants {
	mut obj := &Class_WC_Gateway_Paypal_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Gateway_Paypal_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Gateway_Paypal_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_gateways_paypal_includes_class_wc_gateway_paypal_constants_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
