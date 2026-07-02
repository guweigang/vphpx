import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_use_label := rt.new_null()
	mut var_catalog_orderby_options := rt.new_null()
	mut var_orderby := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	mut var_id_suffix := rt.call_function('wp_unique_id', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_use_label) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_id_suffix.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Sort by'),
			rt.new_string('woocommerce')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_use_label) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_id_suffix.clone()]))
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Shop order'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_catalog_orderby_options.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_name := item_1.val
		mut var_id := item_1.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_id.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_orderby.clone(), var_id.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wc_query_string_form_fields', [rt.new_null(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'orderby' },
			rt.ArrayItem{ key: none, val: 'submit' }, rt.ArrayItem{ key: none, val: 'paged' },
			rt.ArrayItem{ key: none, val: 'product-page' }])])
	// unsupported statement: Stmt_InlineHTML
}
