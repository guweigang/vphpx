import rt

pub fn init_wp_content_plugins_woocommerce_includes_traits_trait_wc_item_totals_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
