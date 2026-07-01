import rt

pub fn init_wp_content_plugins_woocommerce_templates_single_product_title_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	rt.call_function('the_title', [
		rt.new_string('<h1 class="product_title entry-title">'),
		rt.new_string('</h1>'),
	])
}
