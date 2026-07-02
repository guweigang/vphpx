import rt

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_PaymentMethod.card() string {
	return 'card'
}

struct Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_PaymentMethod {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_agentic_enums_specs_paymentmethod(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_PaymentMethod {
	mut obj := &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_PaymentMethod{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_PaymentMethod) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_PaymentMethod) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_PaymentMethod) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
