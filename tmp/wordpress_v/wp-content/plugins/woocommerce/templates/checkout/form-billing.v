import rt



pub fn init_wp_content_plugins_woocommerce_templates_checkout_form_billing_php() {
	mut var_checkout := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wc_ship_to_billing_address_only', []rt.PhpVal{})) && rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'needs_shipping', []rt.PhpVal{})))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Billing &amp; Shipping'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Billing details'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_checkout_billing_form'), var_checkout.dup()])
	// unsupported statement: Stmt_InlineHTML
	mut var_fields := rt.call_method(var_checkout, 'get_checkout_fields', [rt.new_string('billing')])
	{
		mut iter_1 := var_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_key := item_1.key
			rt.call_function('woocommerce_form_field', [var_key.dup(), var_field.dup(), rt.call_method(var_checkout, 'get_value', [var_key.dup()])])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_checkout_billing_form'), var_checkout.dup()])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) && rt.is_true(rt.call_method(var_checkout, 'is_registration_enabled', []rt.PhpVal{})))) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_checkout, 'is_registration_required', []rt.PhpVal{}))))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), rt.call_method(var_checkout, 'get_value', [rt.new_string('createaccount')]))) || rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('apply_filters', [rt.new_string('woocommerce_create_account_default_checked'), rt.new_bool(false)])))), rt.new_bool(true)])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Create an account?'), rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_before_checkout_registration_form'), var_checkout.dup()])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_method(var_checkout, 'get_checkout_fields', [rt.new_string('account')])) {
			// unsupported statement: Stmt_InlineHTML
			{
				mut iter_1 := rt.call_method(var_checkout, 'get_checkout_fields', [rt.new_string('account')]).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_field := item_1.val
					mut var_key := item_1.key
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('woocommerce_form_field', [var_key.dup(), var_field.dup(), rt.call_method(var_checkout, 'get_value', [var_key.dup()])])
					// unsupported statement: Stmt_InlineHTML
				}
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_after_checkout_registration_form'), var_checkout.dup()])
		// unsupported statement: Stmt_InlineHTML
	}
}
