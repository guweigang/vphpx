import rt

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType.invalid_request() string {
	return 'invalid_request'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType.request_not_idempotent() string {
	return 'request_not_idempotent'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType.processing_error() string {
	return 'processing_error'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType.service_unavailable() string {
	return 'service_unavailable'
}

struct Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_agentic_enums_specs_errortype() &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType {
	mut obj := &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_ErrorType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_agentic_enums_specs_errortype_php() {
	// unsupported statement: Stmt_Declare
}
