import rt



pub fn init_wp_content_plugins_woocommerce_templates_checkout_terms_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_checkout_show_terms'), rt.new_bool(true)])) && rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_terms_and_conditions_checkbox_enabled')])))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_checkout_before_terms_and_conditions')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_checkout_terms_and_conditions')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('wc_terms_and_conditions_checkbox_enabled', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [rt.call_function('apply_filters', [rt.new_string('woocommerce_terms_is_checked_default'), rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('terms')))]), rt.new_bool(true)])
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('wc_terms_and_conditions_checkbox_text', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('required'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_checkout_after_terms_and_conditions')])
	}
}
