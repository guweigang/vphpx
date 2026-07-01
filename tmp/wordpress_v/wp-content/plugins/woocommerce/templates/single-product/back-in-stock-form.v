import rt

pub fn init_wp_content_plugins_woocommerce_templates_single_product_back_in_stock_form_php() {
	mut var_is_visible := rt.new_null()
	mut var_product_id := rt.new_null()
	mut var_show_email_field := rt.new_null()
	mut var_button_class := rt.new_null()
	mut var_show_checkbox := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_is_visible) { '' } else { ' hidden' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_product_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_product_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('__', [
			rt.new_string('Want to be notified when this product is back in stock?'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_product_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_show_email_field) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('absint', [var_product_id.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html_x', [
			rt.new_string('Email address to be notified when this product is back in stock'),
			rt.new_string('back in stock form'),
			rt.new_string('woocommerce'),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Enter your e-mail'),
			rt.new_string('back in stock form'), rt.new_string('woocommerce')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('absint', [var_product_id.dup()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_button_class.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('__', [rt.new_string('Notify me'), rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_show_checkbox) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('absint', [var_product_id.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('absint', [var_product_id.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('wc_replace_policy_page_link_placeholders', [
				rt.call_function('wc_get_privacy_policy_text', [
					rt.new_string('registration'),
				]),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('wc_bis_signup'),
		rt.new_string('wc_bis_nonce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [var_product_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
}
