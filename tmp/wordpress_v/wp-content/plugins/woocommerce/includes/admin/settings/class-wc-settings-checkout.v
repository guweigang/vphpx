import rt



pub fn init_wp_content_plugins_woocommerce_includes_admin_settings_class_wc_settings_checkout_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	return rt.include_file(@DIR + '/class-wc-settings-payment-gateways.php', '1')
}
