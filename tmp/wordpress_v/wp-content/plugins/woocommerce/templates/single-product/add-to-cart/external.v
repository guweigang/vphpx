import rt



pub fn init_wp_content_plugins_woocommerce_templates_single_product_add_to_cart_external_php() {
	mut var_product_url := rt.new_null()
	mut var_button_text := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.call_function('do_action', [rt.new_string('woocommerce_before_add_to_cart_form')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_product_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_add_to_cart_button')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { rt.new_string('') }]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_button_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_query_string_form_fields', [var_product_url.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_add_to_cart_button')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_add_to_cart_form')])
}
