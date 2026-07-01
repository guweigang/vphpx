import rt

pub fn init_wp_content_plugins_woocommerce_templates_single_product_review_rating_php() {
	mut var_comment := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	// unsupported statement: Stmt_Global
	mut var_rating := rt.call_function('get_comment_meta', [
		rt.get_property(var_comment, 'comment_ID'),
		rt.new_string('rating'),
		rt.new_bool(true),
	]).to_i64()
	if rt.is_true(rt.new_bool(var_rating != 0
		&& rt.is_true(rt.call_function('wc_review_ratings_enabled', []rt.PhpVal{}))))
	{
		rt.echo_val(rt.call_function('wc_get_rating_html', [rt.new_int(var_rating).dup()]))
		// unsupported statement: Stmt_Nop
	}
}
