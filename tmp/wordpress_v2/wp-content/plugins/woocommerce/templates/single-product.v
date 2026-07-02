import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	rt.call_function('get_header', [rt.new_string('shop')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_main_content')])
	// unsupported statement: Stmt_InlineHTML
	for rt.is_true(rt.call_function('have_posts', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('the_post', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wc_get_template_part', [rt.new_string('content'),
			rt.new_string('single-product')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_main_content')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_sidebar')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('get_footer', [rt.new_string('shop')])
}
