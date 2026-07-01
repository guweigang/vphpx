import rt

pub fn init_wp_content_plugins_woocommerce_templates_brands_shortcodes_single_brand_php() {
	mut var_term := rt.new_null()
	mut var_thumbnail := rt.new_null()
	mut var_class := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	// unsupported statement: Stmt_Declare
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_term_link', [var_term.dup(), rt.new_string('product_brand')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_thumbnail.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_term, 'name')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_class.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_width.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_height.dup()]))
	// unsupported statement: Stmt_InlineHTML
}
