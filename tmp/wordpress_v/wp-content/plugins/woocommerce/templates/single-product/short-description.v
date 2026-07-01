import rt

pub fn init_wp_content_plugins_woocommerce_templates_single_product_short_description_php() {
	mut var_post := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	// unsupported statement: Stmt_Global
	mut var_short_description := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_short_description'),
		rt.get_property(var_post, 'post_excerpt'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_short_description)))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_short_description)
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
}
