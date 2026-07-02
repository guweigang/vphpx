import rt

struct Class_Automattic_WooCommerce_Api_Attributes_Unroll {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_api_attributes_unroll(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Api_Attributes_Unroll {
	mut obj := &Class_Automattic_WooCommerce_Api_Attributes_Unroll{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_Attributes_Unroll) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_Attributes_Unroll) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Api_Attributes_Unroll) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
