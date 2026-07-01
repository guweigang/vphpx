import rt

pub fn init_wp_content_plugins_woocommerce_includes_admin_importers_mappings_mappings_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/default.php',
		'3')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/generic.php',
		'3')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/shopify.php',
		'3')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/wordpress.php',
		'3')
}
