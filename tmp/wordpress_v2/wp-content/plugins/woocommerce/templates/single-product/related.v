import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_related_products := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(var_related_products) {
		if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wp_increase_content_media_count'),
		]))
		{
			mut var_content_media_count := rt.call_function('wp_increase_content_media_count', [
				rt.new_int(0),
			])
			if rt.is_true(rt.less(var_content_media_count, rt.call_function('wp_omit_loading_attr_threshold',
				[]rt.PhpVal{})))
			{
				rt.call_function('wp_increase_content_media_count', [
					rt.sub(rt.call_function('wp_omit_loading_attr_threshold', []rt.PhpVal{}),
						var_content_media_count),
				])
			}
		}
		// unsupported statement: Stmt_InlineHTML
		mut var_heading := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_product_related_products_heading'),
			rt.call_function('__', [rt.new_string('Related products'),
				rt.new_string('woocommerce')]),
		])
		if rt.is_true(var_heading) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_heading.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('woocommerce_product_loop_start', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		mut iter_1 := var_related_products.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_related_product := item_1.val
			// unsupported statement: Stmt_InlineHTML
			mut var_post_object := rt.call_function('get_post', [
				rt.call_method(var_related_product, 'get_id', []rt.PhpVal{}),
			])
			rt.call_function('setup_postdata', [
				var_GLOBALS.array_set('post', var_post_object.clone()),
			])
			rt.call_function('wc_get_template_part', [rt.new_string('content'),
				rt.new_string('product')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('woocommerce_product_loop_end', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
	}
	rt.call_function('wp_reset_postdata', []rt.PhpVal{})
}
