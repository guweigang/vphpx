import rt

interface DataStoreInterface {
	get_data(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_src_admin_api_reports_datastoreinterface_php() {
	mut var_args := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
