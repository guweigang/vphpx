import rt



pub fn init_wp_content_plugins_woocommerce_templates_single_product_product_attributes_php() {
	mut var_product_attributes := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_attributes)))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Product Details'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_product_attributes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_product_attribute := item_1.val
			mut var_product_attribute_key := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_product_attribute_key.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [var_product_attribute.array_get('label')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [var_product_attribute.array_get('value')]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
}
