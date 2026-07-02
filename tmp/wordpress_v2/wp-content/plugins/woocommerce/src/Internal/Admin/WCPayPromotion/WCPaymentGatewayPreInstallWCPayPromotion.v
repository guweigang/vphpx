import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion.gateway_id() string {
	return 'pre_install_woocommerce_payments_promotion'
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion) construct() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init{}
	mut iife_result_0 := iife_temp_0.get_wc_pay_promotion_spec()
	mut var_wc_pay_spec := iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wc_pay_spec)))) {
		return
	}
	this.dispatch_set_prop('id',
		Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_static.gateway_id())
	this.dispatch_set_prop('method_title', rt.get_property(var_wc_pay_spec, 'title'))
	if rt.is_true(rt.call_function('property_exists', [var_wc_pay_spec.clone(),
		rt.new_string('sub_title')]))
	{
		this.dispatch_set_prop('title', rt.call_function('sprintf', [
			rt.new_string('<span class="gateway-subtitle" >%s</span>'),
			rt.get_property(var_wc_pay_spec, 'sub_title'),
		]))
	}
	this.dispatch_set_prop('method_description', rt.get_property(var_wc_pay_spec, 'content'))
	this.dispatch_set_prop('has_fields', rt.new_bool(false))
	if rt.is_true(rt.call_function('property_exists', [var_wc_pay_spec.clone(),
		rt.new_string('supports')]))
	{
		this.dispatch_set_prop('supports', rt.get_property(var_wc_pay_spec, 'supports'))
	} else {
		this.dispatch_set_prop('supports', rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.products()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.refunds()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscriptions()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.multiple_subscriptions()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_cancellation()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_reactivation()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_suspension()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_amount_changes()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_date_changes()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_payment_method_change_admin()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_payment_method_change_customer()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_payment_method_change()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.tokenization()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.add_payment_method()
			},
		]))
	}
	this.dispatch_set_prop('enabled', rt.new_bool(false))
	this.init_form_fields()
	this.init_settings()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion) init_form_fields() {
	this.dispatch_set_prop('form_fields', rt.create_array([
		rt.ArrayItem{ key: 'is_dismissed', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Dismiss'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Dismiss the gateway'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: 'no' },
		]) },
	]))
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion.is_dismissed() bool {
	mut var_settings := rt.call_function('get_option', [
		rt.new_string('woocommerce_' +
			(Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion.gateway_id()).str() + '_settings'),
		rt.new_array(),
	])
	return var_settings.array_isset(rt.new_string('is_dismissed'))
		&& rt.is_true(rt.identical(rt.new_string('yes'), var_settings.array_get(rt.new_string('is_dismissed'))))
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WC_Payment_Gateway {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_wcpaymentgatewaypreinstallwcpaypromotion() &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_wc_payment_gateway(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WC_Payment_Gateway {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WC_Payment_Gateway{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_init(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'is_dismissed' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion.is_dismissed())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WCPaymentGatewayPreInstallWCPayPromotion) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WC_Payment_Gateway) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WC_Payment_Gateway) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_WC_Payment_Gateway) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
