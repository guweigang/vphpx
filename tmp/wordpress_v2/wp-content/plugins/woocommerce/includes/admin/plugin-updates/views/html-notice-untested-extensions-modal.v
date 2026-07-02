import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_new_version := rt.new_null()
	mut var_plugins := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	mut var_untested_plugins_msg := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('The following active plugin(s) have not declared compatibility with WooCommerce %s yet and should be updated and examined further before you proceed:'),
			rt.new_string('woocommerce'),
		]),
		var_new_version.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string("Are you sure you're ready?"),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_untested_plugins_msg.clone()]))
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
	rt.call_function('esc_html_e', [
		rt.new_string('We strongly recommend creating a backup of your site before updating.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Learn more'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Cancel'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Update now'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
