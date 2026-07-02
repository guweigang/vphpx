import rt

struct Class_Automattic_WooCommerce_Blocks_AIContent_ContentProcessor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_aicontent_contentprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_AIContent_ContentProcessor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_AIContent_ContentProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AIContent_ContentProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_AIContent_ContentProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AIContent_ContentProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
