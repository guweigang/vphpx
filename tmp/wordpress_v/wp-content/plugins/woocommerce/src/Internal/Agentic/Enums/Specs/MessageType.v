import rt

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageType.info() string {
	return 'info'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageType.warning() string {
	return 'warning'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageType.error() string {
	return 'error'
}

struct Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageType {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_agentic_enums_specs_messagetype() &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageType {
	mut obj := &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_MessageType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_agentic_enums_specs_messagetype_php() {
	// unsupported statement: Stmt_Declare
}
