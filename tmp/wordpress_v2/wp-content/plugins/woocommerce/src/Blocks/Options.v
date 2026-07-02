import rt

pub fn Class_Automattic_WooCommerce_Blocks_Options.wc_block_version() string {
	return 'wc_blocks_version'
}

pub fn Class_Automattic_WooCommerce_Blocks_Options.wc_block_use_blockified_product_grid_block_as_template() string {
	return 'wc_blocks_use_blockified_product_grid_block_as_template'
}

struct Class_Automattic_WooCommerce_Blocks_Options {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_options(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Options {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
