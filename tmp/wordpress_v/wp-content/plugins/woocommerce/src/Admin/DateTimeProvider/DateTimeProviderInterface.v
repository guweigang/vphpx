import rt

interface DateTimeProviderInterface {
		get_now() rt.PhpVal
}



pub fn init_wp_content_plugins_woocommerce_src_admin_datetimeprovider_datetimeproviderinterface_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
