import rt

struct Class_Automattic_WooCommerce_Blocks_AIContent_UpdatePatterns {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_aicontent_updatepatterns(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_AIContent_UpdatePatterns {
	mut obj := &Class_Automattic_WooCommerce_Blocks_AIContent_UpdatePatterns{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AIContent_UpdatePatterns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_AIContent_UpdatePatterns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AIContent_UpdatePatterns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
