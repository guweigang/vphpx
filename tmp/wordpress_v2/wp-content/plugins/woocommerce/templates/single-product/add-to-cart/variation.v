import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Sorry, this product is unavailable. Please choose a different combination.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
}
