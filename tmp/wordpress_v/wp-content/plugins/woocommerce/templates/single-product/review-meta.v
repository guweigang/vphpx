import rt



pub fn init_wp_content_plugins_woocommerce_templates_single_product_review_meta_php() {
	mut var_comment := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Global
	mut var_verified := rt.call_function('wc_review_is_from_verified_owner', [rt.get_property(var_comment, 'comment_ID')])
	if rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_comment, 'comment_approved'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Your review is awaiting approval'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('comment_author', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_review_rating_verification_label')]))) && rt.is_true(var_verified))) {
			print('<em class="woocommerce-review__verified verified">(' + (rt.call_function('esc_attr__', [rt.new_string('verified owner'), rt.new_string('woocommerce')])).str() + ')</em> ')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.call_function('get_comment_date', [rt.new_string('c')])]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.call_function('get_comment_date', [rt.call_function('wc_date_format', []rt.PhpVal{})])]))
		// unsupported statement: Stmt_InlineHTML
	}
}
