import rt



pub fn init_wp_content_plugins_woocommerce_includes_walkers_class_product_cat_list_walker_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/class-wc-product-cat-list-walker.php', '3')
}
