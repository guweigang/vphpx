import rt

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_FulfillmentType.shipping() string {
	return 'shipping'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_FulfillmentType.digital() string {
	return 'digital'
}

struct Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_FulfillmentType {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_agentic_enums_specs_fulfillmenttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_FulfillmentType {
	mut obj := &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_FulfillmentType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_FulfillmentType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_FulfillmentType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_FulfillmentType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
