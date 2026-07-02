import rt

struct Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal {
	rt.PhpObjectBase
pub mut:
	name      rt.PhpVal = rt.new_null()
	asset_api rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal) construct(mut var_asset_api Class_Automattic_WooCommerce_Blocks_Assets_Api) {
	this.asset_api = var_asset_api
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal) initialize() {
	this.dispatch_set_prop('settings', rt.call_function('get_option', [
		rt.new_string('woocommerce_paypal_settings'),
		rt.new_array(),
	]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal) is_active() rt.PhpVal {
	return rt.call_function('filter_var', [
		this.get_setting(rt.new_string('enabled'), rt.new_bool(false)),
		rt.get_constant('FILTER_VALIDATE_BOOLEAN'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal) get_payment_method_script_handles() rt.PhpVal {
	rt.call_method(this.asset_api, 'register_script', [
		rt.new_string('wc-payment-method-paypal'),
		rt.new_string('assets/client/blocks/wc-payment-method-paypal.js'),
	])
	return rt.create_array([rt.ArrayItem{ key: none, val: 'wc-payment-method-paypal' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal) get_payment_method_data() rt.PhpVal {
	mut iife_temp_0 := Class_WC_Gateway_Paypal{}
	mut iife_result_0 := iife_temp_0.get_instance()
	mut var_gateway := iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_gateway, 'is_available',
		[]rt.PhpVal{})))))
	{
		return rt.new_array()
	}
	mut var_buttons := create_automattic_woocommerce_gateways_paypal_buttons(var_gateway.clone())
	mut var_options := var_buttons.get_options()
	return rt.create_array([
		rt.ArrayItem{ key: 'title', val: this.get_setting(rt.new_string('title')) },
		rt.ArrayItem{ key: 'description', val: this.get_description() },
		rt.ArrayItem{ key: 'supports', val: this.get_supported_features() },
		rt.ArrayItem{ key: 'isButtonsEnabled', val: var_buttons.is_enabled() },
		rt.ArrayItem{ key: 'isProductPage', val: rt.call_function('is_product', []rt.PhpVal{}) },
		rt.ArrayItem{
			key: 'appSwitchRequestOrigin'
			val: var_buttons.get_current_page_for_app_switch()
		},
		rt.ArrayItem{ key: 'buttonsOptions', val: var_options },
		rt.ArrayItem{ key: 'wc_store_api_nonce', val: rt.call_function('wp_create_nonce', [
			rt.new_string('wc_store_api'),
		]) },
		rt.ArrayItem{ key: 'create_order_nonce', val: rt.call_function('wp_create_nonce', [
			rt.new_string('wc_gateway_paypal_standard_create_order'),
		]) },
		rt.ArrayItem{ key: 'cancel_payment_nonce', val: rt.call_function('wp_create_nonce', [
			rt.new_string('wc_gateway_paypal_standard_cancel_payment'),
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal) get_description() string {
	mut iife_temp_1 := Class_WC_Gateway_Paypal{}
	mut iife_result_1 := iife_temp_1.get_instance()
	mut var_gateway := iife_result_1
	mut var_testmode := rt.get_property(var_gateway, 'testmode')
	mut var_description := if !(this.get_setting(rt.new_string('description'))).is_null() {
		this.get_setting(rt.new_string('description'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(var_testmode) {
		var_description = rt.concat(var_description,
			rt.new_string('<br>' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Sandbox mode enabled</strong>. Only sandbox test accounts can be used. See the <a href="%s">PayPal Sandbox Testing Guide</a> for more details.'), rt.new_string('woocommerce')]), rt.new_string('https://developer.paypal.com/tools/sandbox/')])).str()))
	}
	return var_description.clone().to_string().trim_space()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal) get_supported_features() rt.PhpVal {
	mut iife_temp_2 := Class_WC_Gateway_Paypal{}
	mut iife_result_2 := iife_temp_2.get_instance()
	mut var_gateway := iife_result_2
	mut var_features := rt.call_function('array_filter', [
		rt.get_property(var_gateway, 'supports'),
		rt.create_array([rt.ArrayItem{ key: none, val: var_gateway },
			rt.ArrayItem{ key: none, val: 'supports' }]),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('__experimental_woocommerce_blocks_payment_gateway_features_list'),
		var_features.clone(),
		this.get_name(),
	])
}

struct Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType {
	rt.PhpObjectBase
}

struct Class_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Buttons {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_payments_integrations_paypal(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal{
		PhpObjectBase: rt.PhpObjectBase{}
		name:          rt.new_null()
		asset_api:     rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blocks_payments_integrations_abstractpaymentmethodtype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_gateway_paypal(_args ...rt.PhpVal) &Class_WC_Gateway_Paypal {
	mut obj := &Class_WC_Gateway_Paypal{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_Api](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'is_active' {
			return this.is_active()
		}
		'get_payment_method_script_handles' {
			return this.get_payment_method_script_handles()
		}
		'get_payment_method_data' {
			return this.get_payment_method_data()
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'get_supported_features' {
			return this.get_supported_features()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'asset_api' { return this.asset_api }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_PayPal) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'asset_api' {
			this.asset_api = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Payments_Integrations_AbstractPaymentMethodType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Gateways_PayPal_Buttons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
