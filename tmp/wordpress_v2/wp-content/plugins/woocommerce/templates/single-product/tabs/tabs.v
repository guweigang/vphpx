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
	mut var_product_tabs := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_tabs'),
		rt.new_array(),
	])
	if !(!rt.is_true(var_product_tabs)) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := var_product_tabs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_product_tab := item_1.val
			mut var_key := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_product_' + var_key.str() + '_tab_title'),
					var_product_tab.array_get(rt.new_string('title')),
					var_key.clone(),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 := var_product_tabs.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_product_tab := item_2.val
			mut var_key := item_2.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			if var_product_tab.array_isset(rt.new_string('callback')) {
				rt.call_function('call_user_func', [
					var_product_tab.array_get(rt.new_string('callback')),
					var_key.clone(),
					var_product_tab.clone(),
				])
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_product_after_tabs')])
		// unsupported statement: Stmt_InlineHTML
	}
}
