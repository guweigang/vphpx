import rt



pub fn init_wp_content_plugins_woocommerce_src_admin_overrides_ordertraits_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
