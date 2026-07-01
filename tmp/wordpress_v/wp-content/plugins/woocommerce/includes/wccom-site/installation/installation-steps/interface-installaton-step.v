import rt

interface WC_WCCOM_Site_Installation_Step {
		construct( rt.PhpVal) rt.PhpVal
		run() rt.PhpVal
}



pub fn init_wp_content_plugins_woocommerce_includes_wccom_site_installation_installation_steps_interface_installaton_step_php() {
	mut var_state := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
