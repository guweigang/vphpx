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
	rt.call_function('do_action', [
		rt.new_string('woocommerce_before_account_navigation'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Account pages'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := rt.call_function('wc_get_account_menu_items', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_label := item_1.val
		mut var_endpoint := item_1.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_get_account_menu_item_classes', [
			var_endpoint.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('wc_get_account_endpoint_url', [
				var_endpoint.clone()]),
		]))
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.call_function('wc_is_current_account_menu_item', [
			var_endpoint.clone(),
		]))
		{ 'aria-current="page"' } else { '' })
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_label.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_account_navigation')])
}
