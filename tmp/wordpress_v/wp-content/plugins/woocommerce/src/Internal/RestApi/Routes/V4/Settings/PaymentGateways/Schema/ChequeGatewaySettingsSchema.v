import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_ChequeGatewaySettingsSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_ChequeGatewaySettingsSchema) get_custom_groups_for_gateway(mut var_gateway Class_WC_Payment_Gateway) rt.PhpVal {
	mut var_core_field_overrides := rt.create_array([rt.ArrayItem{ key: 'enabled', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Enable/Disable'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Enable check payments at checkout'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Checkout label'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Shown to customers on the payment methods list at checkout.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Checkout instructions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Shown below the checkout label.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Order'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Determines the display order of payment gateways during checkout.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'instructions', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Instructions shown after checkout'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('Shown on the order confirmation page and in order emails.'), rt.new_string('woocommerce')]) }]) }])
	mut var_fields := this.build_fields_from_form_fields(rt.new_object('WC_Payment_Gateway', []string{}, var_gateway), var_core_field_overrides.dup())
	mut var_group := rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Check payment settings'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Manage how check payments appear at checkout and in order emails.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'order', val: 1 }, rt.ArrayItem{ key: 'fields', val: var_fields }])
	return rt.create_array([rt.ArrayItem{ key: 'settings', val: var_group }])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_chequegatewaysettingsschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_ChequeGatewaySettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_ChequeGatewaySettingsSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_abstractpaymentgatewaysettingsschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_ChequeGatewaySettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_custom_groups_for_gateway' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Payment_Gateway](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_custom_groups_for_gateway(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_ChequeGatewaySettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_ChequeGatewaySettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_settings_paymentgateways_schema_chequegatewaysettingsschema_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
