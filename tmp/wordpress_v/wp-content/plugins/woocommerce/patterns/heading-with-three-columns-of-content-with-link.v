import rt

pub fn init_wp_content_plugins_woocommerce_patterns_heading_with_three_columns_of_content_with_link_php() {
	// unsupported statement: Stmt_Declare
	mut var_header := rt.call_function('__', [rt.new_string('Our services'),
		rt.new_string('woocommerce')])
	mut var_product_title := rt.call_function('__', [rt.new_string('Create anything'),
		rt.new_string('woocommerce')])
	mut var_description := rt.call_function('__', [
		rt.new_string("Navigating life's intricate fabric, choices unfold paths to the extraordinary, demanding creativity, curiosity, and courage for a truly fulfilling journey."),
		rt.new_string('woocommerce'),
	])
	mut var_button_link := rt.call_function('__', [rt.new_string('Get started'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_header.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_product_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_description.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_button_link.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_product_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_description.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_button_link.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_product_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_description.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_button_link.dup()]))
	// unsupported statement: Stmt_InlineHTML
}
