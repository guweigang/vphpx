import rt

pub fn init_wp_content_plugins_woocommerce_templates_single_product_tabs_tabs_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	mut var_product_tabs := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_tabs'),
		rt.new_array(),
	])
	if !(!rt.is_true(var_product_tabs)) {
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_product_tabs.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_product_tab := item_1.val
				mut var_key := item_1.key
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [
					rt.call_function('apply_filters', [
						'woocommerce_product_' + var_key.str() + '_tab_title',
						var_product_tab.array_get('title'),
						var_key.dup(),
					]),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
		}
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_product_tabs.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_product_tab := item_1.val
				mut var_key := item_1.key
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.dup()]))
				// unsupported statement: Stmt_InlineHTML
				if var_product_tab.array_isset(rt.new_string('callback')) {
					rt.call_function('call_user_func', [var_product_tab.array_get('callback'),
						var_key.dup(), var_product_tab.dup()])
				}
				// unsupported statement: Stmt_InlineHTML
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_product_after_tabs')])
		// unsupported statement: Stmt_InlineHTML
	}
}
