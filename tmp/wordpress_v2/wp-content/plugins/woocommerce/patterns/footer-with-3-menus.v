import rt

fn main() {
	defer {
		rt.shutdown()
	}

	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Search'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Search'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Search'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('sprintf', [
		rt.call_function('esc_html__', [rt.new_string('Powered by %1$s with %2$s'),
			rt.new_string('woocommerce')]),
		rt.new_string('<a href="https://wordpress.org" target="_blank" rel="noreferrer nofollow">WordPress</a>'),
		rt.new_string('<a href="https://woocommerce.com" target="_blank" rel="noreferrer nofollow">WooCommerce</a>'),
	]))
	// unsupported statement: Stmt_InlineHTML
}
