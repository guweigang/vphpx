import rt



pub fn init_wp_content_plugins_woocommerce_templates_global_quantity_input_php() {
	mut var_args := rt.new_null()
	mut var_input_id := rt.new_null()
	mut var_type := rt.new_null()
	mut var_readonly := rt.new_null()
	mut var_classes := rt.new_null()
	mut var_input_name := rt.new_null()
	mut var_input_value := rt.new_null()
	mut var_min_value := rt.new_null()
	mut var_max_value := rt.new_null()
	mut var_step := rt.new_null()
	mut var_placeholder := rt.new_null()
	mut var_inputmode := rt.new_null()
	mut var_autocomplete := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	mut var_label := if !(!rt.is_true(var_args.array_get('product_name'))) { rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%s quantity'), rt.new_string('woocommerce')]), rt.call_function('wp_strip_all_tags', [var_args.array_get('product_name')])]) } else { rt.call_function('esc_html__', [rt.new_string('Quantity'), rt.new_string('woocommerce')]) }
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_before_quantity_input_field')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_input_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_label.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_type.dup()]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_readonly) { 'readonly="readonly"' } else { '' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_input_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('join', [rt.new_string(' '), rt.cast_array(var_classes)])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_input_name.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_input_value.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Product quantity'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('in_array', [var_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'text' }, rt.ArrayItem{ key: none, val: 'search' }, rt.ArrayItem{ key: none, val: 'tel' }, rt.ArrayItem{ key: none, val: 'url' }, rt.ArrayItem{ key: none, val: 'email' }, rt.ArrayItem{ key: none, val: 'password' }]), rt.new_bool(true)])) {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_min_value.dup()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.less(rt.new_int(0), var_max_value)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_max_value.dup()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(var_readonly)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_step.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_placeholder.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_inputmode.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [if !(var_autocomplete).is_null() { var_autocomplete } else { rt.new_string('on') }]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_after_quantity_input_field')])
	// unsupported statement: Stmt_InlineHTML
}
