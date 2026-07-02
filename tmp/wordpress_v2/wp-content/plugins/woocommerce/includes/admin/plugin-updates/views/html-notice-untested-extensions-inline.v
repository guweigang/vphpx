import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_upgrade_type := rt.new_null()
	mut var_message := rt.new_null()
	mut var_plugins := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_upgrade_type.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_message.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Plugin'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Tested up to WooCommerce version'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_plugins.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_plugin := item_1.val
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_plugin.array_get(rt.new_string('Name'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			var_plugin.array_get(rt.new_string('WC tested up to')),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
