import rt

fn woocommerce_legacy_reports_init() {
	rt.include_file(@DIR + '/class-wc-admin-reports.php', '4')
	mut iife_temp_0 := Class_WC_Admin_Reports{}
	mut iife_result_0 := iife_temp_0.register_hook_handlers()
}

struct Class_WC_Admin_Reports {
	rt.PhpObjectBase
}

fn create_wc_admin_reports(_args ...rt.PhpVal) &Class_WC_Admin_Reports {
	mut obj := &Class_WC_Admin_Reports{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Reports) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Reports) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Reports) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('woocommerce_legacy_reports_init'),
	])))))
	{
		rt.call_function('add_action', [rt.new_string('woocommerce_init'),
			rt.new_string('woocommerce_legacy_reports_init')])
	}
}
