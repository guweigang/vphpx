import rt

struct Class_Automattic_WooCommerce_Admin_API_AI_Patterns {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_ai_patterns(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_AI_Patterns {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_AI_Patterns{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AI_Patterns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_AI_Patterns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AI_Patterns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
