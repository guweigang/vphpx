import rt

struct Class_Automattic_WooCommerce_Blocks_Images_Pexels {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_images_pexels(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Images_Pexels {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Images_Pexels{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Images_Pexels) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Images_Pexels) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Images_Pexels) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
