import rt



pub fn init_wp_content_plugins_woocommerce_templates_single_product_add_to_cart_variable_php() {
	mut var_product := rt.new_null()
	mut var_attributes := rt.new_null()
	mut var_available_variations := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Global
	mut var_attribute_keys := rt.func_array_keys(var_attributes.dup())
	mut var_variations_json := rt.call_function('wp_json_encode', [var_available_variations.dup()])
	mut var_variations_attr := if rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_esc_json')])) { rt.call_function('wc_esc_json', [var_variations_json.dup()]) } else { rt.call_function('_wp_specialchars', [var_variations_json.dup(), rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8'), rt.new_bool(true)]) }
	rt.call_function('do_action', [rt.new_string('woocommerce_before_add_to_cart_form')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('apply_filters', [rt.new_string('woocommerce_add_to_cart_form_action'), rt.call_method(var_product, 'get_permalink', []rt.PhpVal{})])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('absint', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_variations_attr)
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_variations_form')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!rt.is_true(var_available_variations) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.call_function('apply_filters', [rt.new_string('woocommerce_out_of_stock_message'), rt.call_function('__', [rt.new_string('This product is currently out of stock and unavailable.'), rt.new_string('woocommerce')])])]))
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := var_attributes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_options := item_1.val
				mut var_attribute_name := item_1.key
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [rt.call_function('sanitize_title', [var_attribute_name.dup()])]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wc_attribute_label', [var_attribute_name.dup()]))
				// unsupported statement: Stmt_Nop
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('wc_dropdown_variation_attribute_options', [rt.create_array([rt.ArrayItem{ key: 'options', val: var_options }, rt.ArrayItem{ key: 'attribute', val: var_attribute_name }, rt.ArrayItem{ key: 'product', val: var_product }])])
				rt.echo_val(if rt.is_true(rt.identical(rt.call_function('end', [var_attribute_keys.dup()]), var_attribute_name)) { rt.call_function('wp_kses_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_reset_variations_link'), '<a class="reset_variations" href="#" aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('Clear options'), rt.new_string('woocommerce')])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Clear'), rt.new_string('woocommerce')])).str() + '</a>'])]) } else { rt.new_string('') })
				// unsupported statement: Stmt_InlineHTML
			}
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_after_variations_table')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('woocommerce_before_single_variation')])
		rt.call_function('do_action', [rt.new_string('woocommerce_single_variation')])
		rt.call_function('do_action', [rt.new_string('woocommerce_after_single_variation')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_variations_form')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_add_to_cart_form')])
}
