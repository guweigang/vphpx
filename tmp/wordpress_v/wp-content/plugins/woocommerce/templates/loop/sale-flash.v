import rt

pub fn init_wp_content_plugins_woocommerce_templates_loop_sale_flash_php() {
	mut var_post := rt.new_null()
	mut var_product := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_method(var_product, 'is_on_sale', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_sale_flash'),
			'<span class="onsale">' +
				(rt.call_function('esc_html__', [rt.new_string('Sale!'), rt.new_string('woocommerce')])).str() +
				'</span>',
			var_post.dup(),
			var_product.dup(),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_Nop
}
