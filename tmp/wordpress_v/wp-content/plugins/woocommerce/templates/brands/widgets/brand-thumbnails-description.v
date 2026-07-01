import rt

pub fn init_wp_content_plugins_woocommerce_templates_brands_widgets_brand_thumbnails_description_php() {
	mut var_brands := rt.new_null()
	mut var_columns := rt.new_null()
	// unsupported statement: Stmt_Declare
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_brands.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_brand := item_1.val
			mut var_index := item_1.key
			mut var_thumbnail := rt.call_function('wc_get_brand_thumbnail_url', [
				rt.get_property(var_brand, 'term_id'),
				rt.call_function('apply_filters', [
					rt.new_string('woocommerce_brand_thumbnail_size'),
					rt.new_string('shop_catalog'),
				]),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_thumbnail)))) {
				var_thumbnail = rt.call_function('wc_placeholder_img_src', []rt.PhpVal{})
			}
			mut var_class := ''
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), var_index))
				|| rt.is_true(rt.identical(rt.new_int(0), rt.mod_(var_index, var_columns)))))
			{
				var_class = 'first'
			} else if rt.is_true(rt.identical(rt.new_int(0), rt.mod_(rt.add(var_index,
				rt.new_int(1)), var_columns)))
			{
				var_class = 'last'
			}
			mut var_width := rt.div(rt.call_function('floor', [
				rt.mul(rt.div(rt.sub(rt.new_int(100), rt.mul(rt.sub(var_columns, rt.new_int(1)),
					rt.new_int(2))), var_columns), rt.new_int(100)),
			]), rt.new_int(100))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_class).dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_width.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.call_function('get_term_link', [rt.get_property(var_brand, 'slug'),
					rt.new_string('product_brand')]),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_brand, 'name')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [var_thumbnail.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_brand, 'name')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				rt.get_property(var_brand, 'term_id'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				rt.call_function('wpautop', [
					rt.call_function('wptexturize', [
						rt.get_property(var_brand, 'description'),
					]),
				]),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
}
