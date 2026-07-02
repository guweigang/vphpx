import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_post := rt.new_null()
	mut var_product_object := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_version := rt.call_function('get_bloginfo', [rt.new_string('version')])
	if rt.is_true(var_version) {
		mut var_version_parts := rt.call_function('explode', [
			rt.new_string('-'), var_version.clone()])
		var_version = if var_version_parts.clone().array_count() > 1 {
			var_version_parts.array_get(rt.new_int(0))
		} else {
			var_version
		}
	}
	mut var_width := if rt.is_true(var_version)
		&& rt.is_true(rt.call_function('version_compare', [var_version.clone(), rt.new_string('7.0'), rt.new_string('>=')])) {
		'width: 55%;'
	} else {
		'width: 50%;'
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Grouped products'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_width.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Search for a product&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	print(rt.get_property(var_post, 'ID').to_i64().str())
	// unsupported statement: Stmt_InlineHTML
	mut var_product_ids := if rt.is_true(rt.call_method(var_product_object, 'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.grouped(),
	]))
	{
		rt.call_method(var_product_object, 'get_children', [rt.new_string('edit')])
	} else {
		rt.new_array()
	}
	if !(!rt.is_true(var_product_ids)) {
		rt.call_function('_prime_post_caches', [var_product_ids.clone()])
	}
	mut iter_1 := var_product_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_product_id := item_1.val
		mut var_product := rt.call_function('wc_get_product', [
			var_product_id.clone()])
		if rt.is_true(rt.new_bool(var_product.clone().is_object())) {
			print('<option value="' +
				(rt.call_function('esc_attr', [var_product_id.clone()])).str() + '"' +
				(rt.call_function('selected', [rt.new_bool(true), rt.new_bool(true), rt.new_bool(false)])).str() +
				'>' +
				(rt.call_function('esc_html', [rt.call_function('wp_strip_all_tags', [rt.call_method(var_product, 'get_formatted_name', []rt.PhpVal{})])])).str() +
				'</option>')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('This lets you choose which products are part of this group.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Upsells'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_width.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Search for a product&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	print(rt.get_property(var_post, 'ID').to_i64().str())
	// unsupported statement: Stmt_InlineHTML
	var_product_ids = rt.call_method(var_product_object, 'get_upsell_ids', [
		rt.new_string('edit'),
	])
	if !(!rt.is_true(var_product_ids)) {
		rt.call_function('_prime_post_caches', [var_product_ids.clone()])
	}
	mut iter_2 := var_product_ids.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_product_id := item_2.val
		mut var_product := rt.call_function('wc_get_product', [
			var_product_id.clone()])
		if rt.is_true(rt.new_bool(var_product.clone().is_object())) {
			print('<option value="' +
				(rt.call_function('esc_attr', [var_product_id.clone()])).str() + '"' +
				(rt.call_function('selected', [rt.new_bool(true), rt.new_bool(true), rt.new_bool(false)])).str() +
				'>' +
				(rt.call_function('esc_html', [rt.call_function('wp_strip_all_tags', [rt.call_method(var_product, 'get_formatted_name', []rt.PhpVal{})])])).str() +
				'</option>')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('Upsells are products which you recommend instead of the currently viewed product, for example, products that are more profitable or better quality or more expensive.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Cross-sells'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_width.str()).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Search for a product&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	print(rt.get_property(var_post, 'ID').to_i64().str())
	// unsupported statement: Stmt_InlineHTML
	var_product_ids = rt.call_method(var_product_object, 'get_cross_sell_ids', [
		rt.new_string('edit'),
	])
	if !(!rt.is_true(var_product_ids)) {
		rt.call_function('_prime_post_caches', [var_product_ids.clone()])
	}
	mut iter_3 := var_product_ids.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_product_id := item_3.val
		mut var_product := rt.call_function('wc_get_product', [
			var_product_id.clone()])
		if rt.is_true(rt.new_bool(var_product.clone().is_object())) {
			print('<option value="' +
				(rt.call_function('esc_attr', [var_product_id.clone()])).str() + '"' +
				(rt.call_function('selected', [rt.new_bool(true), rt.new_bool(true), rt.new_bool(false)])).str() +
				'>' +
				(rt.call_function('esc_html', [rt.call_function('wp_strip_all_tags', [rt.call_method(var_product, 'get_formatted_name', []rt.PhpVal{})])])).str() +
				'</option>')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('Cross-sells are products which you promote in the cart, based on the current product.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_product_options_related')])
	// unsupported statement: Stmt_InlineHTML
}
