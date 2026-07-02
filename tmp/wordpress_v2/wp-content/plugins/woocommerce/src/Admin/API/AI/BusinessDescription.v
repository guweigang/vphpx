import rt

struct Class_Automattic_WooCommerce_Admin_API_AI_BusinessDescription {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_ai_businessdescription(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_AI_BusinessDescription {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_AI_BusinessDescription{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AI_BusinessDescription) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_AI_BusinessDescription) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_AI_BusinessDescription) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
