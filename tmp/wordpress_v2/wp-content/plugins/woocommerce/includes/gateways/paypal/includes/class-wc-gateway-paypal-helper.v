import rt

struct Class_WC_Gateway_Paypal_Helper {
	rt.PhpObjectBase
}

fn Class_WC_Gateway_Paypal_Helper.is_paypal_gateway_available() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('10.5.0'), rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Helper::is_paypal_gateway_available()')])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_0 := iife_temp_0.is_paypal_gateway_available()
	return iife_result_0
}

fn Class_WC_Gateway_Paypal_Helper.is_orders_v2_migration_eligible() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('10.5.0'), rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Helper::is_orders_v2_migration_eligible()')])
	mut iife_temp_1 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_1 := iife_temp_1.is_orders_v2_migration_eligible()
	return iife_result_1
}

fn Class_WC_Gateway_Paypal_Helper.get_wc_order_from_paypal_custom_id(var_custom_id rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('10.5.0'), rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Helper::get_wc_order_from_paypal_custom_id()')])
	if !(var_custom_id.clone().is_string()) || rt.is_true(rt.identical(rt.new_string(''), var_custom_id)) {
		return rt.new_null()
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_2 := iife_temp_2.get_wc_order_from_paypal_custom_id(rt.new_string((var_custom_id).str()))
	return iife_result_2
}

fn Class_WC_Gateway_Paypal_Helper.redact_data(var_data rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('10.5.0'), rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Helper::redact_data()')])
	mut iife_temp_3 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_3 := iife_temp_3.redact_data(var_data.clone())
	return iife_result_3
}

fn Class_WC_Gateway_Paypal_Helper.mask_email(var_email rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('10.5.0'), rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Helper::mask_email()')])
	mut iife_temp_4 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
	mut iife_result_4 := iife_temp_4.mask_email(rt.new_string((var_email).str()))
	return iife_result_4
}

fn Class_WC_Gateway_Paypal_Helper.update_addresses_in_order(mut var_order Class_?WC_Order, mut var_paypal_order_details Class_array) {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('10.5.0'), rt.new_string('Automattic\\WooCommerce\\Gateways\\PayPal\\Helper::update_addresses_in_order()')])
mut iife_temp_5 := Class_Automattic_WooCommerce_Gateways_PayPal_Helper{}
mut iife_result_5 := iife_temp_5.update_addresses_in_order(rt.new_object('?WC_Order', []string{}, var_order), rt.new_object('array', []string{}, var_paypal_order_details))
}

struct Class_Automattic_WooCommerce_Gateways_PayPal_Helper {
	rt.PhpObjectBase
}

fn create_wc_gateway_paypal_helper(_args ...rt.PhpVal) &Class_WC_Gateway_Paypal_Helper {
	mut obj := &Class_WC_Gateway_Paypal_Helper{
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

fn (mut this Class_WC_Gateway_Paypal_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'is_paypal_gateway_available' {
			return Class_WC_Gateway_Paypal_Helper.is_paypal_gateway_available()
		}
		'is_orders_v2_migration_eligible' {
			return Class_WC_Gateway_Paypal_Helper.is_orders_v2_migration_eligible()
		}
		'get_wc_order_from_paypal_custom_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Gateway_Paypal_Helper.get_wc_order_from_paypal_custom_id(dispatch_arg_0)
		}
		'redact_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Gateway_Paypal_Helper.redact_data(dispatch_arg_0)
		}
		'mask_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Gateway_Paypal_Helper.mask_email(dispatch_arg_0)
		}
		'update_addresses_in_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_WC_Gateway_Paypal_Helper.update_addresses_in_order(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Gateway_Paypal_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Gateway_Paypal_Constants')]))))) {
		rt.include_file(@DIR + '/class-wc-gateway-paypal-constants.php', '4')
	}
}
