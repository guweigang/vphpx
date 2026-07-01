import rt

pub fn init_wp_content_plugins_woocommerce_templates_checkout_payment_method_php() {
	mut var_gateway := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_gateway, 'id')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_gateway, 'id')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_gateway, 'id')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [rt.get_property(var_gateway, 'chosen'),
		rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(var_gateway, 'order_button_text'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_gateway, 'id')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_method(var_gateway, 'get_title', []rt.PhpVal{}))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_method(var_gateway, 'get_icon', []rt.PhpVal{}))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_gateway, 'has_fields', []rt.PhpVal{}))
		|| rt.is_true(rt.call_method(var_gateway, 'get_description', []rt.PhpVal{}))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_gateway, 'id')]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_gateway, 'chosen'))))) {
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_method(var_gateway, 'payment_fields', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
