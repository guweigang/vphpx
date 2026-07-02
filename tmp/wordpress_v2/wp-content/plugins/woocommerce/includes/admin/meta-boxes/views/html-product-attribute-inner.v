import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_attribute := rt.new_null()
	mut var_i := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Name'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{})) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('wc_attribute_label', [
				rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('e.g. length or weight'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_attribute, 'get_position', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Value(s)'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_attribute, 'get_taxonomy_object', []rt.PhpVal{})) {
		mut var_attribute_taxonomy := rt.call_method(var_attribute, 'get_taxonomy_object',
			[]rt.PhpVal{})
		mut var_attribute_types := rt.call_function('wc_get_attribute_types', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_attribute_types.clone().array_isset(rt.get_property(var_attribute_taxonomy,
			'attribute_type')))))))
		{
			rt.set_property(var_attribute_taxonomy, 'attribute_type', rt.new_string('select'))
		}
		if rt.is_true(rt.identical(rt.new_string('select'), rt.get_property(var_attribute_taxonomy,
			'attribute_type')))
		{
			mut var_attribute_orderby := if !(!rt.is_true(rt.get_property(var_attribute_taxonomy,
				'attribute_orderby'))) {
				rt.get_property(var_attribute_taxonomy, 'attribute_orderby')
			} else {
				rt.new_string('name')
			}
			mut var_term_limit := rt.call_function('absint', [
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_admin_terms_metabox_datalimit'),
					rt.new_int(50),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_term_limit.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Select values'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_attribute_orderby.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.call_method(var_attribute, 'get_taxonomy', []rt.PhpVal{}),
			]))
			// unsupported statement: Stmt_InlineHTML
			mut var_selected_terms := rt.call_method(var_attribute, 'get_terms', []rt.PhpVal{})
			if rt.is_true(var_selected_terms) {
				mut iter_1 := var_selected_terms.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_selected_term := item_1.val
					print('<option value="' +
						(rt.call_function('esc_attr', [rt.get_property(var_selected_term, 'term_id')])).str() +
						'" selected="selected">' +
						(rt.call_function('esc_html', [rt.call_function('apply_filters', [rt.new_string('woocommerce_product_attribute_term_name'), rt.get_property(var_selected_term, 'name'), var_selected_term.clone()])])).str() +
						'</option>')
				}
			}
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Select all'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Select none'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Create value'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
		}
		rt.call_function('do_action', [rt.new_string('woocommerce_product_option_terms'),
			var_attribute_taxonomy.clone(), var_i.clone(), var_attribute.clone()])
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_textarea', [
			rt.call_function('wc_implode_text_attributes', [
				rt.call_method(var_attribute, 'get_options', []rt.PhpVal{}),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [
		rt.call_method(var_attribute, 'get_visible', []rt.PhpVal{}),
		rt.new_bool(true),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Visible on the product page'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [
		rt.call_method(var_attribute, 'get_variation', []rt.PhpVal{}),
		rt.new_bool(true),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Used for variations'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [
		rt.new_string('woocommerce_after_product_attribute_settings'),
		var_attribute.clone(),
		var_i.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
}
