import rt



pub fn init_wp_content_plugins_woocommerce_templates_single_product_add_to_cart_simple_php() {
	mut var_product := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_purchasable', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	rt.echo_val(rt.call_function('wc_get_stock_html', [var_product.dup()]))
	if rt.is_true(rt.call_method(var_product, 'is_in_stock', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_before_add_to_cart_form')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.call_function('apply_filters', [rt.new_string('woocommerce_add_to_cart_form_action'), rt.call_method(var_product, 'get_permalink', []rt.PhpVal{})])]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_before_add_to_cart_button')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_before_add_to_cart_quantity')])
		rt.call_function('woocommerce_quantity_input', [rt.create_array([rt.ArrayItem{ key: 'min_value', val: rt.call_method(var_product, 'get_min_purchase_quantity', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'max_value', val: rt.call_method(var_product, 'get_max_purchase_quantity', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'input_value', val: if rt.get_superglobal('_POST').array_isset(rt.new_string('quantity')) { rt.call_function('wc_stock_amount', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('quantity')])]) } else { rt.call_method(var_product, 'get_min_purchase_quantity', []rt.PhpVal{}) } }])])
		rt.call_function('do_action', [rt.new_string('woocommerce_after_add_to_cart_quantity')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])) { ' ' + (rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str() } else { rt.new_string('') }]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.call_method(var_product, 'single_add_to_cart_text', []rt.PhpVal{})]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_after_add_to_cart_button')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_after_add_to_cart_form')])
		// unsupported statement: Stmt_InlineHTML
	}
}
