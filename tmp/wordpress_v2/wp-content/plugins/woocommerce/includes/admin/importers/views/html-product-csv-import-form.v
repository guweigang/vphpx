import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_upload_dir := map[string]rt.PhpVal{}
	mut var_bytes := rt.new_null()
	mut var_size := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Import products from a CSV file'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('This tool allows you to import (or merge) product data to your store from a CSV or TXT file.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Choose a CSV file from your computer:'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_upload_dir['error'])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Before you can upload your import file, you will need to fix the following error:'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_upload_dir['error']]))
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_bytes.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('esc_html__', [rt.new_string('Maximum size: %s'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_html', [var_size.clone()]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Update existing products'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Existing products that match by ID or SKU will be updated. Products that do not exist will be skipped.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Alternatively, enter the path to a CSV file on your server:'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	print((rt.call_function('esc_html', [rt.get_constant('ABSPATH')])).str() + ' ')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('CSV Delimiter'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Use previous column mapping preferences?'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Character encoding of the file'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Autodetect'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_encodings := rt.call_function('mb_list_encodings', []rt.PhpVal{})
	rt.call_function('sort', [var_encodings.clone(), rt.get_constant('SORT_NATURAL')])
	mut iter_1 := var_encodings.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_encoding := item_1.val
		print('<option>' + (rt.call_function('esc_html', [var_encoding.clone()])).str() +
			'</option>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Hide advanced options'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Show advanced options'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Show advanced options'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Continue'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Continue'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce-csv-importer')])
	// unsupported statement: Stmt_InlineHTML
}
