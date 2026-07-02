import rt

fn main() {
	defer {
		rt.shutdown()
	}

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
	rt.echo_val(rt.call_function('esc_html', [var_header.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_product_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_button_link.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_product_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_button_link.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_product_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_description.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_button_link.clone()]))
	// unsupported statement: Stmt_InlineHTML
}
