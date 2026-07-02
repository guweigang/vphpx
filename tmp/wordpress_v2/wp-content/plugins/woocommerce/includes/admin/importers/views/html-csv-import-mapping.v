import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_headers := rt.new_null()
	mut var_mapped_items := rt.new_null()
	mut var_sample := rt.new_null()
	mut var_args := map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_method(rt.new_object('', []string{}, &this), 'get_next_step_link', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Map CSV fields to products'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Select fields from your CSV file to map against products fields, or to ignore during import.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Column name'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Map to field'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_headers.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_name := item_1.val
		mut var_index := item_1.key
		// unsupported statement: Stmt_InlineHTML
		mut var_mapped_value := var_mapped_items.array_get(var_index)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_sample.array_get(var_index))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Sample:'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_sample.array_get(var_index)]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_index.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_index.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Do not import'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 := rt.call_method(rt.new_object('', []string{}, &this), 'get_mapping_options', [
			var_mapped_value.clone(),
		]).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_value := item_2.val
			mut var_key := item_2.key
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					var_value.array_get(rt.new_string('name')),
				]))
				// unsupported statement: Stmt_InlineHTML
				mut iter_3 := var_value.array_get(rt.new_string('options')).iterator()
				for {
					item_3 := iter_3.next() or { break }
					mut var_sub_value := item_3.val
					mut var_sub_key := item_3.key
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						var_sub_key.clone()]))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('selected', [var_mapped_value.clone(),
						var_sub_key.clone()])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [
						var_sub_value.clone()]))
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('selected', [var_mapped_value.clone(),
					var_key.clone()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_value.clone()]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Run the importer'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Run the importer'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(rt.new_object('', []string{}, &this), 'file'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(rt.new_object('', []string{}, &this), 'delimiter'),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(rt.new_int((rt.get_property(rt.new_object('', []string{}, &this), 'update_existing')).to_i64()).str())
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_args['character_encoding']) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_args['character_encoding']]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce-csv-importer')])
	// unsupported statement: Stmt_InlineHTML
}
