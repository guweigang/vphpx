import rt

struct Class_Automattic_WooCommerce_Blocks_AI_Configuration {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_ai_configuration() &Class_Automattic_WooCommerce_Blocks_AI_Configuration {
	mut obj := &Class_Automattic_WooCommerce_Blocks_AI_Configuration{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AI_Configuration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_AI_Configuration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AI_Configuration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_ai_configuration_php() {
}
