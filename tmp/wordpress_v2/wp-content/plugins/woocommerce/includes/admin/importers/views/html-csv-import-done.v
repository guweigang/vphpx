import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_imported := rt.new_null()
	mut var_updated := rt.new_null()
	mut var_imported_variations := rt.new_null()
	mut var_skipped := rt.new_null()
	mut var_failed := rt.new_null()
	mut var_file_name := rt.new_null()
	mut var_errors := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_results := []rt.PhpVal{}
	if rt.is_true(rt.less(rt.new_int(0), var_imported)) {
		var_results << rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s product imported'),
				rt.new_string('%s products imported'), var_imported.clone(),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('number_format_i18n', [var_imported.clone()])).str() + '</strong>'),
		])
	}
	if rt.is_true(rt.less(rt.new_int(0), var_updated)) {
		var_results << rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s product updated'),
				rt.new_string('%s products updated'), var_updated.clone(),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('number_format_i18n', [var_updated.clone()])).str() + '</strong>'),
		])
	}
	if rt.is_true(rt.less(rt.new_int(0), var_imported_variations)) {
		var_results << rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s variations imported'),
				rt.new_string('%s variations imported'), var_imported_variations.clone(),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('number_format_i18n', [var_imported_variations.clone()])).str() +
				'</strong>'),
		])
	}
	if rt.is_true(rt.less(rt.new_int(0), var_skipped)) {
		var_results << rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s product was skipped'),
				rt.new_string('%s products were skipped'), var_skipped.clone(),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('number_format_i18n', [var_skipped.clone()])).str() + '</strong>'),
		])
	}
	if rt.is_true(rt.less(rt.new_int(0), var_failed)) {
		var_results << rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('Failed to import %s product'),
				rt.new_string('Failed to import %s products'),
				var_failed.clone(), rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('number_format_i18n', [var_failed.clone()])).str() + '</strong>'),
		])
	}
	if rt.is_true(rt.less(rt.new_int(0), var_failed))
		|| rt.is_true(rt.less(rt.new_int(0), var_skipped)) {
		var_results << '<a href="#" class="woocommerce-importer-done-view-errors">' +
			(rt.call_function('__', [rt.new_string('View import log'), rt.new_string('woocommerce')])).str() +
			'</a>'
	}
	if !(!rt.is_true(var_file_name)) {
		var_results << rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('File uploaded: %s'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' + var_file_name.str() + '</strong>'),
		])
	}
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.new_string(
			(rt.call_function('__', [rt.new_string('Import complete!'), rt.new_string('woocommerce')])).str() +
			' ' +(rt.call_function('implode', [rt.new_string('. '), rt.create_array_from_list(var_results)])).str()),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Product'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Reason for failure'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if var_errors.clone().is_array() && rt.is_true(rt.new_int(var_errors.clone().array_count())) {
		mut iter_1 := var_errors.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_error := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
				var_error.clone(),
			])))))
			{
				continue
			}
			mut var_error_data := rt.call_method(var_error, 'get_error_data', []rt.PhpVal{})
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html',
				[var_error_data.array_get(rt.new_string('row'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				rt.call_method(var_error, 'get_error_message', []rt.PhpVal{}),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('edit.php?post_type=product')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('View products'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
