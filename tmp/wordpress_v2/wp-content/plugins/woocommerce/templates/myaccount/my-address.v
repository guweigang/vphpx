import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_customer_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_ship_to_billing_address_only', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('wc_shipping_enabled', []rt.PhpVal{})) {
		mut var_get_addresses := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_my_account_get_addresses'),
			rt.create_array([
				rt.ArrayItem{ key: 'billing', val: rt.call_function('__', [
					rt.new_string('Billing address'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'shipping', val: rt.call_function('__', [
					rt.new_string('Shipping address'),
					rt.new_string('woocommerce'),
				]) },
			]),
			var_customer_id.clone(),
		])
	} else {
		var_get_addresses = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_my_account_get_addresses'),
			rt.create_array([
				rt.ArrayItem{ key: 'billing', val: rt.call_function('__', [
					rt.new_string('Billing address'),
					rt.new_string('woocommerce'),
				]) },
			]),
			var_customer_id.clone(),
		])
	}
	mut var_oldcol := rt.new_int(1)
	mut var_col := rt.new_int(1)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_my_account_my_address_description'),
		rt.call_function('esc_html__', [
			rt.new_string('The following addresses will be used on the checkout page by default.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_ship_to_billing_address_only', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('wc_shipping_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_get_addresses.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_address_title := item_1.val
		mut var_name := item_1.key
		// unsupported statement: Stmt_InlineHTML
		mut var_address := rt.call_function('wc_get_account_formatted_address', [
			var_name.clone(),
		])
		var_col = rt.mul(var_col, -1)
		var_oldcol = rt.mul(var_oldcol, -1)
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.less(var_col, rt.new_int(0))) { 1 } else { 2 }.str())
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.less(var_oldcol, rt.new_int(0))) { 1 } else { 2 }.str())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_address_title.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('wc_get_endpoint_url', [rt.new_string('edit-address'),
				var_name.clone()]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [if rt.is_true(var_address) { rt.call_function('esc_html__', [
				rt.new_string('Edit %s'),
				rt.new_string('woocommerce'),
			]) } else { rt.call_function('esc_html__', [
				rt.new_string('Add %s'),
				rt.new_string('woocommerce'),
			]) }, rt.call_function('esc_html', [
			var_address_title.clone(),
		])])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(if rt.is_true(var_address) { rt.call_function('wp_kses_post', [
				var_address.clone(),
			]) } else { rt.call_function('esc_html_e', [
				rt.new_string('You have not set up this type of address yet.'),
				rt.new_string('woocommerce'),
			]) })
		rt.call_function('do_action', [
			rt.new_string('woocommerce_my_account_after_my_address'),
			var_name.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_ship_to_billing_address_only', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('wc_shipping_enabled', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
	}
}
