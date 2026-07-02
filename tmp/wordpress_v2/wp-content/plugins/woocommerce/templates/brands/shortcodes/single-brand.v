import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_term := rt.new_null()
	mut var_thumbnail := rt.new_null()
	mut var_class := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('get_term_link', [var_term.clone(), rt.new_string('product_brand')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_thumbnail.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_term, 'name')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_class.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_width.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_height.clone()]))
	// unsupported statement: Stmt_InlineHTML
}
