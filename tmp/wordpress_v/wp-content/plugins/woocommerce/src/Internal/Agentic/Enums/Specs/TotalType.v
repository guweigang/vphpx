import rt

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType.items_base_amount() string {
	return 'items_base_amount'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType.items_discount() string {
	return 'items_discount'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType.subtotal() string {
	return 'subtotal'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType.discount() string {
	return 'discount'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType.fulfillment() string {
	return 'fulfillment'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType.tax() string {
	return 'tax'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType.fee() string {
	return 'fee'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType.total() string {
	return 'total'
}

struct Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_agentic_enums_specs_totaltype() &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType {
	mut obj := &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_TotalType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_agentic_enums_specs_totaltype_php() {
	// unsupported statement: Stmt_Declare
}
