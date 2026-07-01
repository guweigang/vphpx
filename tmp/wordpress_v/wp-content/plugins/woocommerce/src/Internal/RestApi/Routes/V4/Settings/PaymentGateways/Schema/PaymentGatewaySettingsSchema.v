import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_PaymentGatewaySettingsSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_AbstractPaymentGatewaySettingsSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_paymentgateways_schema_paymentgatewaysettingsschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_PaymentGatewaySettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_PaymentGatewaySettingsSchema{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_PaymentGatewaySettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_PaymentGatewaySettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_PaymentGateways_Schema_PaymentGatewaySettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_settings_paymentgateways_schema_paymentgatewaysettingsschema_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
