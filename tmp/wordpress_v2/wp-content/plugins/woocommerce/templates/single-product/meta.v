import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_product := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_product_meta_start')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_product, 'get_sku', []rt.PhpVal{}))
		|| rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('SKU:'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		mut var_sku := rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
		rt.echo_val(if rt.is_true(var_sku) { var_sku } else { rt.call_function('esc_html__', [
				rt.new_string('N/A'),
				rt.new_string('woocommerce'),
			]) })
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_get_product_category_list', [
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		rt.new_string(', '),
		rt.new_string('<span class="posted_in">' +
			(rt.call_function('_n', [rt.new_string('Category:'), rt.new_string('Categories:'), rt.new_int(rt.call_method(var_product, 'get_category_ids', []rt.PhpVal{}).array_count()), rt.new_string('woocommerce')])).str() +
			' '),
		rt.new_string('</span>'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_get_product_tag_list', [
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		rt.new_string(', '),
		rt.new_string('<span class="tagged_as">' +
			(rt.call_function('_n', [rt.new_string('Tag:'), rt.new_string('Tags:'), rt.new_int(rt.call_method(var_product, 'get_tag_ids', []rt.PhpVal{}).array_count()), rt.new_string('woocommerce')])).str() +
			' '),
		rt.new_string('</span>'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_product_meta_end')])
	// unsupported statement: Stmt_InlineHTML
}
