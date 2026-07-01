import rt

pub fn init_wp_content_plugins_woocommerce_templates_loop_add_to_cart_php() {
	mut var_product := rt.new_null()
	mut var_args := map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_Global
	mut var_aria_describedby := if var_args.array_isset(rt.new_string('aria-describedby_text')) { rt.call_function('sprintf', [
			rt.new_string('aria-describedby="woocommerce_loop_add_to_cart_link_describedby_%s"'),
			rt.call_function('esc_attr', [
				rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
			]),
		]) } else { rt.new_string('') }
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_loop_add_to_cart_link'),
		rt.call_function('sprintf', [
			rt.new_string('<a href="%s" %s data-quantity="%s" class="%s" %s>%s</a>'),
			rt.call_function('esc_url', [
				rt.call_method(var_product, 'add_to_cart_url', []rt.PhpVal{}),
			]),
			var_aria_describedby.dup(),
			rt.call_function('esc_attr', [
				if var_args.array_isset(rt.new_string('quantity')) {
					var_args.array_get('quantity')
				} else {
					rt.new_int(1)
				},
			]),
			rt.call_function('esc_attr', [
				if var_args.array_isset(rt.new_string('class')) {
					var_args.array_get('class')
				} else {
					rt.new_string('button')
				},
			]),
			if var_args.array_isset(rt.new_string('attributes')) { rt.call_function('wc_implode_html_attributes', [
					var_args.array_get('attributes'),
				]) } else { rt.new_string('') },
			rt.call_function('esc_html', [
				rt.call_method(var_product, 'add_to_cart_text', []rt.PhpVal{}),
			]),
		]),
		var_product.dup(),
		var_args.dup(),
	]))
	if var_args.array_isset(rt.new_string('aria-describedby_text')) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_args.array_get('aria-describedby_text')]))
		// unsupported statement: Stmt_InlineHTML
	}
}
