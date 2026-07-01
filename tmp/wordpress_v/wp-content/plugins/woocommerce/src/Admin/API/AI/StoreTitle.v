import rt

struct Class_Automattic_WooCommerce_Admin_API_AI_StoreTitle {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_ai_storetitle() &Class_Automattic_WooCommerce_Admin_API_AI_StoreTitle {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_AI_StoreTitle{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AI_StoreTitle) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_AI_StoreTitle) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AI_StoreTitle) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_ai_storetitle_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
