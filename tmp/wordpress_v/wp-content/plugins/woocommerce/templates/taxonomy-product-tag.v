import rt

pub fn init_wp_content_plugins_woocommerce_templates_taxonomy_product_tag_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	rt.call_function('wc_get_template', [rt.new_string('archive-product.php')])
}
