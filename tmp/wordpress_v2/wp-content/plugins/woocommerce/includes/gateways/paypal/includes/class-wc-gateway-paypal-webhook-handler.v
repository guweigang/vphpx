import rt

struct Class_WC_Gateway_Paypal_Webhook_Handler {
	rt.PhpObjectBase
pub mut:
	webhook_handler rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Gateway_Paypal_Webhook_Handler) construct() {
	this.webhook_handler = create_automattic_woocommerce_gateways_paypal_webhookhandler()
}

fn (mut this Class_WC_Gateway_Paypal_Webhook_Handler) process_webhook(mut var_request Class_WP_REST_Request) {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('10.5.0'),
		rt.new_string(
			(Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler.class()).str() + '::process_webhook()')])
	rt.call_method(this.webhook_handler, 'process_webhook', [var_request])
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler {
	rt.PhpObjectBase
}

fn create_wc_gateway_paypal_webhook_handler() &Class_WC_Gateway_Paypal_Webhook_Handler {
	mut obj := &Class_WC_Gateway_Paypal_Webhook_Handler{
		PhpObjectBase:   rt.PhpObjectBase{}
		webhook_handler: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_gateways_paypal_webhookhandler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler {
	mut obj := &Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Gateway_Paypal_Webhook_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'process_webhook' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.process_webhook(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Gateway_Paypal_Webhook_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'webhook_handler' { return this.webhook_handler }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Gateway_Paypal_Webhook_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'webhook_handler' {
			this.webhook_handler = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_WebhookHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
		rt.new_string('WC_Gateway_Paypal_Helper'),
	])))))
	{
		rt.include_file(@DIR + '/class-wc-gateway-paypal-helper.php', '4')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Gateway_Paypal_Request'),
	])))))
	{
		rt.include_file(@DIR + '/class-wc-gateway-paypal-request.php', '4')
	}
}
