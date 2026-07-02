import rt

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_LinkType.terms_of_use() string {
	return 'terms_of_use'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_LinkType.privacy_policy() string {
	return 'privacy_policy'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_LinkType.seller_shop_policies() string {
	return 'seller_shop_policies'
}

struct Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_LinkType {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_agentic_enums_specs_linktype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_LinkType {
	mut obj := &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_LinkType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_LinkType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_LinkType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_LinkType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
