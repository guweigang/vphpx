import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_product := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_price_html := rt.call_method(var_product, 'get_price_html', []rt.PhpVal{})
	if rt.is_true(var_price_html) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_price_html)
		// unsupported statement: Stmt_InlineHTML
	}
}
