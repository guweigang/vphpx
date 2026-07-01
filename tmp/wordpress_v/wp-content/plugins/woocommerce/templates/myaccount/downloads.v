import rt



pub fn init_wp_content_plugins_woocommerce_templates_myaccount_downloads_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	mut var_downloads := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'get_downloadable_products', []rt.PhpVal{})
	mut var_has_downloads := // unsupported expression: Expr_Cast_Bool
	rt.call_function('do_action', [rt.new_string('woocommerce_before_account_downloads'), var_has_downloads.dup()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_has_downloads) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_before_available_downloads')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_available_downloads'), var_downloads.dup()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_after_available_downloads')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		mut var_wp_button_class := rt.new_string(if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { rt.new_string('') })
		rt.call_function('wc_print_notice', [(rt.call_function('esc_html__', [rt.new_string('No downloads available yet.'), rt.new_string('woocommerce')])).str() + ' <a class="button wc-forward' + (rt.call_function('esc_attr', [var_wp_button_class.dup()])).str() + '" href="' + (rt.call_function('esc_url', [rt.call_function('apply_filters', [rt.new_string('woocommerce_return_to_shop_redirect'), rt.call_function('wc_get_page_permalink', [rt.new_string('shop')])])])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Browse products'), rt.new_string('woocommerce')])).str() + '</a>', rt.new_string('notice')])
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_account_downloads'), var_has_downloads.dup()])
}
