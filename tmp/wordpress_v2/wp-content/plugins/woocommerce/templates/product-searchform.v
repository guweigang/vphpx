import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_index := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('home_url', [rt.new_string('/')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !var_index.is_null() { rt.call_function('absint', [
			var_index.clone()]) } else { rt.new_int(0) })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Search for:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !var_index.is_null() { rt.call_function('absint', [
			var_index.clone()]) } else { rt.new_int(0) })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr__', [rt.new_string('Search products&hellip;'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_search_query', []rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Search'),
		rt.new_string('submit button'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('wc_wp_theme_get_element_class_name', [
			rt.new_string('button')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Search'),
		rt.new_string('submit button'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
}
