import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_index := rt.new_null()
	mut var_product_brands := rt.new_null()
	mut var_show_empty := rt.new_null()
	mut var_show_top_links := rt.new_null()
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_index.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_i := item_1.val
		if var_product_brands.array_isset(var_i) {
			print('<li><a href="#brands-' + (rt.call_function('esc_attr', [var_i.clone()])).str() +
				'">' + (rt.call_function('esc_html', [var_i.clone()])).str() + '</a></li>')
		} else if rt.is_true(var_show_empty) {
			print('<li><span>' + (rt.call_function('esc_html', [var_i.clone()])).str() +
				'</span></li>')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_2 := var_index.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_i := item_2.val
		if var_product_brands.array_isset(var_i) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_i.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_i.clone()]))
			// unsupported statement: Stmt_InlineHTML
			mut iter_3 := var_product_brands.array_get(var_i).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_brand := item_3.val
				rt.call_function('printf', [
					rt.new_string('<li><a href="%s">%s</a></li>'),
					rt.call_function('esc_url', [
						rt.call_function('get_term_link', [
							rt.get_property(var_brand, 'slug'),
							rt.new_string('product_brand'),
						]),
					]),
					rt.call_function('esc_html', [
						rt.get_property(var_brand, 'name'),
					]),
				])
			}
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(var_show_top_links) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('&uarr; Top'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
}
