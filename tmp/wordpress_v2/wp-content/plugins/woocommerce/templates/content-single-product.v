import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_product := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.call_function('do_action', [rt.new_string('woocommerce_before_single_product')])
	if rt.is_true(rt.call_function('post_password_required', []rt.PhpVal{})) {
		rt.echo_val(rt.call_function('get_the_password_form', []rt.PhpVal{}))
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('the_ID', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_product_class', [rt.new_string(''), var_product.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_before_single_product_summary'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_single_product_summary')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_after_single_product_summary'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_single_product')])
}
