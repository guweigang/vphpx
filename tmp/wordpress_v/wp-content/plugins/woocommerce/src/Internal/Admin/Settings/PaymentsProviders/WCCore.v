import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WCCore {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WCCore) get_icon(mut var_payment_gateway Class_WC_Payment_Gateway) string {
	mut switch_val_1 := rt.get_property(var_payment_gateway, 'id')
	if rt.is_true(rt.equal(switch_val_1, Class_WC_Gateway_BACS.id())) {
		return (rt.call_function('plugins_url', [rt.new_string('assets/images/payment_methods/bacs.svg'), rt.get_constant('WC_PLUGIN_FILE')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, Class_WC_Gateway_Cheque.id())) {
		return (rt.call_function('plugins_url', [rt.new_string('assets/images/payment_methods/cheque.svg'), rt.get_constant('WC_PLUGIN_FILE')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, Class_WC_Gateway_COD.id())) {
		return (rt.call_function('plugins_url', [rt.new_string('assets/images/payment_methods/cod.svg'), rt.get_constant('WC_PLUGIN_FILE')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, Class_WC_Gateway_Paypal.id())) {
		return (rt.call_function('plugins_url', [rt.new_string('assets/images/payment_methods/72x72/paypal.png'), rt.get_constant('WC_PLUGIN_FILE')])).str()
	}
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.get_icon(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WCCore) is_account_connected(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	mut switch_val_2 := rt.get_property(var_payment_gateway, 'id')
	if rt.is_true(rt.equal(switch_val_2, Class_WC_Gateway_BACS.id())) {
		return rt.is_true(rt.call_function('property_exists', [var_payment_gateway, rt.new_string('account_details')])) && !(!rt.is_true(rt.get_property(var_payment_gateway, 'account_details')))
	} else if rt.is_true(rt.equal(switch_val_2, Class_WC_Gateway_Cheque.id())) || rt.is_true(rt.equal(switch_val_2, Class_WC_Gateway_COD.id())) {
		return true
	} else if rt.is_true(rt.equal(switch_val_2, Class_WC_Gateway_Paypal.id())) {
		return rt.is_true(rt.call_function('property_exists', [var_payment_gateway, rt.new_string('email')])) && rt.is_true(rt.call_function('is_email', [rt.get_property(var_payment_gateway, 'email')]))
	}
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_account_connected(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WCCore) is_in_test_mode_onboarding(mut var_payment_gateway Class_WC_Payment_Gateway) bool {
	mut switch_val_3 := rt.get_property(var_payment_gateway, 'id')
	if rt.is_true(rt.equal(switch_val_3, Class_WC_Gateway_BACS.id())) || rt.is_true(rt.equal(switch_val_3, Class_WC_Gateway_Cheque.id())) || rt.is_true(rt.equal(switch_val_3, Class_WC_Gateway_COD.id())) {
		return false
	} else if rt.is_true(rt.equal(switch_val_3, Class_WC_Gateway_Paypal.id())) {
		return (this.is_in_test_mode(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))).to_bool()
	}
	return (this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.is_in_test_mode_onboarding(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WCCore) get_plugin_details(mut var_payment_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	mut var_plugin_details := this.Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway.get_plugin_details(rt.new_object('WC_Payment_Gateway', []string{}, var_payment_gateway))
	var_plugin_details.array_set('file', '')
	return var_plugin_details.dup()
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_wccore() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WCCore {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WCCore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_paymentsproviders_paymentgateway() &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WCCore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_icon' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_icon(mut dispatch_arg_0))
		}
		'is_account_connected' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_account_connected(mut dispatch_arg_0))
		}
		'is_in_test_mode_onboarding' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_in_test_mode_onboarding(mut dispatch_arg_0))
		}
		'get_plugin_details' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_plugin_details(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WCCore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_WCCore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_PaymentsProviders_PaymentGateway) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_settings_paymentsproviders_wccore_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
