import rt

pub fn init_wp_content_plugins_woocommerce_templates_single_product_rating_php() {
	mut var_product := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_review_ratings_enabled',
		[]rt.PhpVal{})))))
	{
		return rt.new_null()
	}
	mut var_rating_count := rt.call_method(var_product, 'get_rating_count', []rt.PhpVal{})
	mut var_review_count := rt.call_method(var_product, 'get_review_count', []rt.PhpVal{})
	mut var_average := rt.call_method(var_product, 'get_average_rating', []rt.PhpVal{})
	if rt.is_true(rt.greater(var_rating_count, rt.new_int(0))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_get_rating_html', [var_average.dup(),
			var_rating_count.dup()]))
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('comments_open', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('_n', [rt.new_string('%s customer review'),
					rt.new_string('%s customer reviews'), var_review_count.dup(),
					rt.new_string('woocommerce')]),
				'<span class="count">' +
					(rt.call_function('esc_html', [var_review_count.dup()])).str() + '</span>',
			])
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
}
