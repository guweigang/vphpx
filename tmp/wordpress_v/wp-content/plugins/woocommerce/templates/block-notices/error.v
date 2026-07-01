import rt

pub fn init_wp_content_plugins_woocommerce_templates_block_notices_error_php() {
	mut var_notices := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_notices)))) {
		return rt.new_null()
	}
	mut var_multiple := rt.new_bool(var_notices.len > 1)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if var_multiple { rt.new_string('') } else { rt.call_function('wc_get_notice_data_attr', [
			var_notices.array_get(0),
		]) })
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	if var_multiple {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('The following problems were found:'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		for var_notice in var_notices {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wc_get_notice_data_attr', [
				var_notice.dup()]))
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wc_kses_notice', [var_notice.array_get('notice')]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		rt.echo_val(rt.call_function('wc_kses_notice',
			[var_notices.array_get(0).array_get('notice')]))
	}
	// unsupported statement: Stmt_InlineHTML
}
