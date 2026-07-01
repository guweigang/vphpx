import rt

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus.not_ready_for_payment() string {
	return 'not_ready_for_payment'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus.ready_for_payment() string {
	return 'ready_for_payment'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus.completed() string {
	return 'completed'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus.canceled() string {
	return 'canceled'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus.in_progress() string {
	return 'in_progress'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus.allowed_statuses_for_update() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus.not_ready_for_payment()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus.ready_for_payment()
		},
	])
}

struct Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_agentic_enums_specs_checkoutsessionstatus() &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus {
	mut obj := &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_CheckoutSessionStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_agentic_enums_specs_checkoutsessionstatus_php() {
	// unsupported statement: Stmt_Declare
}
