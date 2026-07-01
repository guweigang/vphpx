import rt



pub fn init_wp_content_plugins_woocommerce_templates_myaccount_form_edit_address_php() {
	mut var_load_address := rt.new_null()
	mut var_address := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	mut var_page_title := if rt.is_true(rt.identical(rt.new_string('billing'), var_load_address)) { rt.call_function('esc_html__', [rt.new_string('Billing address'), rt.new_string('woocommerce')]) } else { rt.call_function('esc_html__', [rt.new_string('Shipping address'), rt.new_string('woocommerce')]) }
	rt.call_function('do_action', [rt.new_string('woocommerce_before_edit_account_address_form')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(var_load_address)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wc_get_template', [rt.new_string('myaccount/my-address.php')])
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_my_account_edit_address_title'), var_page_title.dup(), var_load_address.dup()]))
		// unsupported statement: Stmt_InlineHTML
		// unsupported statement: Stmt_Nop
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string("woocommerce_before_edit_address_form_${var_load_address.to_string()}")])
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_address.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_field := item_1.val
				mut var_key := item_1.key
				rt.call_function('woocommerce_form_field', [var_key.dup(), var_field.dup(), rt.call_function('wc_get_post_data_by_key', [var_key.dup(), var_field.array_get('value')])])
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string("woocommerce_after_edit_address_form_${var_load_address.to_string()}")])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { rt.new_string('') }]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Save address'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Save address'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('wp_nonce_field', [rt.new_string('woocommerce-edit_address'), rt.new_string('woocommerce-edit-address-nonce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_edit_account_address_form')])
}
