import rt

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.missing() string {
	return 'missing'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.invalid() string {
	return 'invalid'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.out_of_stock() string {
	return 'out_of_stock'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.payment_declined() string {
	return 'payment_declined'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.requires_sign_in() string {
	return 'requires_sign_in'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode.requires_3ds() string {
	return 'requires_3ds'
}

struct Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_agentic_enums_specs_errorcode() &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode {
	mut obj := &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorCode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_agentic_enums_specs_errorcode_php() {
	// unsupported statement: Stmt_Declare
}
