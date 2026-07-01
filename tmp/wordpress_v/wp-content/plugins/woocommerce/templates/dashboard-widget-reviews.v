import rt



pub fn init_wp_content_plugins_woocommerce_templates_dashboard_widget_reviews_php() {
	mut var_comment := rt.new_null()
	mut var_product := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_avatar', [rt.get_property(var_comment, 'comment_author_email'), rt.new_string('32')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_get_rating_html', [// unsupported expression: Expr_Cast_Int]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('get_comment_link', [rt.get_property(var_comment, 'comment_ID')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_method(var_product, 'get_name', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('reviewed by %s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_function('get_comment_author', [rt.get_property(var_comment, 'comment_ID')])])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_data', [rt.get_property(var_comment, 'comment_content')]))
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
}
