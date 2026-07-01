import rt

pub fn init_wp_content_plugins_woocommerce_templates_notices_success_php() {
	mut var_notices := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_notices)))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_notices.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_notice := item_1.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wc_get_notice_data_attr', [
				var_notice.dup()]))
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wc_kses_notice', [var_notice.array_get('notice')]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
}
