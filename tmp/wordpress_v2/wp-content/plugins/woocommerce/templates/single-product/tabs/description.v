import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_post := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_heading := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_description_heading'),
		rt.call_function('__', [rt.new_string('Description'),
			rt.new_string('woocommerce')]),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_heading) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_heading.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('the_content', []rt.PhpVal{})
}
