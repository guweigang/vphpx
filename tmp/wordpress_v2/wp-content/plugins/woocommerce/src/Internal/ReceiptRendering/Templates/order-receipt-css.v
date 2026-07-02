import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_data := map[string]rt.PhpVal{}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data['constants'].array_get(rt.new_string('font_size')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data['constants'].array_get(rt.new_string('margin')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data['constants'].array_get(rt.new_string('title_font_size')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.div(var_data['constants'].array_get(rt.new_string('margin')), rt.new_int(2)))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.div(var_data['constants'].array_get(rt.new_string('margin')), rt.new_int(2)))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data['constants'].array_get(rt.new_string('footer_font_size')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data['constants'].array_get(rt.new_string('margin')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data['constants'].array_get(rt.new_string('margin')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_data['constants'].array_get(rt.new_string('line_height')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.div(var_data['constants'].array_get(rt.new_string('margin')), rt.new_int(2)))
	// unsupported statement: Stmt_InlineHTML
	if var_data.array_isset(rt.new_string('payment_info')) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_data['constants'].array_get(rt.new_string('icon_width')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_data['constants'].array_get(rt.new_string('icon_height')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_data['payment_info'].array_get(rt.new_string('card_icon')))
		// unsupported statement: Stmt_InlineHTML
	}
}
