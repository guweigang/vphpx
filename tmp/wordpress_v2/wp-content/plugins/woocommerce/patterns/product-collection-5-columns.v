import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_products_title := rt.call_function('__', [
		rt.new_string('Our latest and greatest'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_products_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
}
