import rt

struct Class_Automattic_WooCommerce_Blocks_AI_Connection {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_ai_connection() &Class_Automattic_WooCommerce_Blocks_AI_Connection {
	mut obj := &Class_Automattic_WooCommerce_Blocks_AI_Connection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AI_Connection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_AI_Connection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_AI_Connection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_ai_connection_php() {
}
