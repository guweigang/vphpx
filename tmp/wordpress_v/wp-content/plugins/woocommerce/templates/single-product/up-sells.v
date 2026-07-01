import rt

pub fn init_wp_content_plugins_woocommerce_templates_single_product_up_sells_php() {
	mut var_upsells := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(var_upsells) {
		// unsupported statement: Stmt_InlineHTML
		mut var_heading := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_product_upsells_products_heading'),
			rt.call_function('__', [rt.new_string('You may also like&hellip;'),
				rt.new_string('woocommerce')]),
		])
		if rt.is_true(var_heading) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_heading.dup()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('woocommerce_product_loop_start', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_upsells.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_upsell := item_1.val
				// unsupported statement: Stmt_InlineHTML
				mut var_post_object := rt.call_function('get_post', [
					rt.call_method(var_upsell, 'get_id', []rt.PhpVal{}),
				])
				rt.call_function('setup_postdata', [
					var_GLOBALS.array_set('post', var_post_object.dup()),
				])
				rt.call_function('wc_get_template_part', [rt.new_string('content'),
					rt.new_string('product')])
				// unsupported statement: Stmt_InlineHTML
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('woocommerce_product_loop_end', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('wp_reset_postdata', []rt.PhpVal{})
}
