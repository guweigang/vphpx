import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_helper_url := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Looking for the WooCommerce Helper?'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('We\'ve made things simpler and easier to manage moving forward. From now on you can manage all your WooCommerce purchases directly from the Extensions menu within the WooCommerce plugin itself. <a href="%s">View and manage</a> your extensions now.'),
			rt.new_string('woocommerce'),
		]),
		rt.call_function('esc_url', [
			var_helper_url.clone(),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
}
