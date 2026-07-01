import rt

struct Class_Automattic_WooCommerce_Admin_API_AI_Middleware {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_ai_middleware() &Class_Automattic_WooCommerce_Admin_API_AI_Middleware {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_AI_Middleware{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AI_Middleware) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_AI_Middleware) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AI_Middleware) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_admin_api_ai_middleware_php() {
	// unsupported statement: Stmt_Declare
}
