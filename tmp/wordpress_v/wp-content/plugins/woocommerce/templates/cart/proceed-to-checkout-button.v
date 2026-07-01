import rt

pub fn init_wp_content_plugins_woocommerce_templates_cart_proceed_to_checkout_button_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('wc_get_checkout_url', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [
		rt.new_string('button'),
	]))
	{
		' ' +(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str()
	} else {
		rt.new_string('')
	}]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Proceed to checkout'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
