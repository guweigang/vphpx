import rt
import crypto.md5

fn wc_update_200_file_paths() {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_existing_file_paths := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT meta_value, meta_id, post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_file_path\' AND meta_value != \'\';'))])
	if rt.is_true(var_existing_file_paths) {
		{
			mut iter_1 := var_existing_file_paths.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_existing_file_path := item_1.val
				mut var_old_file_path := rt.get_property(var_existing_file_path, 'meta_value').to_string().trim_space()
				if !(var_old_file_path == '') {
					mut var_file_paths := rt.call_function('serialize', [rt.create_array([rt.ArrayItem{ key: md5.hexhash(var_old_file_path), val: var_old_file_path }])])
					rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' SET meta_key = \'_file_paths\', meta_value = %s WHERE meta_id = %d')), var_file_paths.dup(), rt.get_property(var_existing_file_path, 'meta_id')])])
					rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_downloadable_product_permissions SET download_id = %s WHERE product_id = %d')), rt.new_string(md5.hexhash(var_old_file_path)), rt.get_property(var_existing_file_path, 'post_id')])])
				}
			}
		}
	}
}

fn wc_update_200_permalinks() {
	mut var_permalinks := rt.call_function('get_option', [rt.new_string('woocommerce_permalinks')])
	mut var_shop_page_id := rt.call_function('wc_get_page_id', [rt.new_string('shop')])
	if rt.is_true(rt.new_bool(!rt.is_true(var_permalinks) && rt.is_true(rt.greater(var_shop_page_id, rt.new_int(0))))) {
		mut var_base_slug := if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_shop_page_id, rt.new_int(0))) && rt.is_true(rt.call_function('get_post', [var_shop_page_id.dup()])))) { rt.call_function('get_page_uri', [var_shop_page_id.dup()]) } else { rt.new_string('shop') }
		mut var_category_base := if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prepend_shop_page_to_urls')]))) { rt.call_function('trailingslashit', [var_base_slug.dup()]) } else { rt.new_string('') }
		mut var_category_slug := if rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_product_category_slug')])) { rt.call_function('get_option', [rt.new_string('woocommerce_product_category_slug')]) } else { rt.call_function('_x', [rt.new_string('product-category'), rt.new_string('slug'), rt.new_string('woocommerce')]) }
		mut var_tag_slug := if rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_product_tag_slug')])) { rt.call_function('get_option', [rt.new_string('woocommerce_product_tag_slug')]) } else { rt.call_function('_x', [rt.new_string('product-tag'), rt.new_string('slug'), rt.new_string('woocommerce')]) }
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prepend_shop_page_to_products')]))) {
			mut var_product_base := rt.call_function('trailingslashit', [var_base_slug.dup()])
		} else {
			mut var_product_slug := rt.call_function('get_option', [rt.new_string('woocommerce_product_slug')])
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && !(!rt.is_true(var_product_slug)))) {
				var_product_base = rt.call_function('trailingslashit', [var_product_slug.dup()])
			} else {
				var_product_base = rt.call_function('trailingslashit', [rt.call_function('_x', [rt.new_string('product'), rt.new_string('slug'), rt.new_string('woocommerce')])])
			}
		}
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prepend_category_to_products')]))) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		var_permalinks = rt.create_array([rt.ArrayItem{ key: 'product_base', val: rt.call_function('untrailingslashit', [var_product_base.dup()]) }, rt.ArrayItem{ key: 'category_base', val: rt.call_function('untrailingslashit', [rt.concat(var_category_base, var_category_slug)]) }, rt.ArrayItem{ key: 'attribute_base', val: rt.call_function('untrailingslashit', [var_category_base.dup()]) }, rt.ArrayItem{ key: 'tag_base', val: rt.call_function('untrailingslashit', [rt.concat(var_category_base, var_tag_slug)]) }])
		rt.call_function('update_option', [rt.new_string('woocommerce_permalinks'), var_permalinks.dup()])
	}
}

fn wc_update_200_subcat_display() {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_shop_show_subcategories')]))) {
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_products_when_showing_subcategories')]))) {
			rt.call_function('update_option', [rt.new_string('woocommerce_shop_page_display'), rt.new_string('subcategories')])
		} else {
			rt.call_function('update_option', [rt.new_string('woocommerce_shop_page_display'), rt.new_string('both')])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_show_subcategories')]))) {
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_products_when_showing_subcategories')]))) {
			rt.call_function('update_option', [rt.new_string('woocommerce_category_archive_display'), rt.new_string('subcategories')])
		} else {
			rt.call_function('update_option', [rt.new_string('woocommerce_category_archive_display'), rt.new_string('both')])
		}
	}
}

fn wc_update_200_taxrates() {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_loop := 0
	mut var_tax_rates := rt.call_function('get_option', [rt.new_string('woocommerce_tax_rates')])
	if rt.is_true(var_tax_rates) {
		{
			mut iter_1 := var_tax_rates.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tax_rate := item_1.val
				{
					mut iter_2 := var_tax_rate.array_get('countries').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_states := item_2.val
						mut var_country := item_2.key
						var_states = rt.call_function('array_reverse', [var_states.dup()])
						{
							mut iter_3 := var_states.iterator()
							for {
								item_3 := iter_3.next() or { break }
								mut var_state := item_3.val
								if rt.is_true(rt.identical(rt.new_string('*'), var_state)) {
									var_state = rt.new_string(rt.new_string(''))
								}
								rt.call_method(var_wpdb, 'insert', [(rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_tax_rates', rt.create_array([rt.ArrayItem{ key: 'tax_rate_country', val: var_country }, rt.ArrayItem{ key: 'tax_rate_state', val: var_state }, rt.ArrayItem{ key: 'tax_rate', val: var_tax_rate.array_get('rate') }, rt.ArrayItem{ key: 'tax_rate_name', val: var_tax_rate.array_get('label') }, rt.ArrayItem{ key: 'tax_rate_priority', val: 1 }, rt.ArrayItem{ key: 'tax_rate_compound', val: if rt.is_true(rt.identical(rt.new_string('yes'), var_tax_rate.array_get('compound'))) { 1 } else { 0 } }, rt.ArrayItem{ key: 'tax_rate_shipping', val: if rt.is_true(rt.identical(rt.new_string('yes'), var_tax_rate.array_get('shipping'))) { 1 } else { 0 } }, rt.ArrayItem{ key: 'tax_rate_order', val: var_loop }, rt.ArrayItem{ key: 'tax_rate_class', val: var_tax_rate.array_get('class') }])])
								var_loop += 1
							}
						}
					}
				}
			}
		}
	}
	mut var_local_tax_rates := rt.call_function('get_option', [rt.new_string('woocommerce_local_tax_rates')])
	if rt.is_true(var_local_tax_rates) {
		{
			mut iter_1 := var_local_tax_rates.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tax_rate := item_1.val
				mut var_location_type := if rt.is_true(rt.identical(rt.new_string('postcode'), var_tax_rate.array_get('location_type'))) { 'postcode' } else { 'city' }
				if rt.is_true(rt.identical(rt.new_string('*'), var_tax_rate.array_get('state'))) {
					var_tax_rate.array_set('state', '')
				}
				rt.call_method(var_wpdb, 'insert', [(rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_tax_rates', rt.create_array([rt.ArrayItem{ key: 'tax_rate_country', val: var_tax_rate.array_get('country') }, rt.ArrayItem{ key: 'tax_rate_state', val: var_tax_rate.array_get('state') }, rt.ArrayItem{ key: 'tax_rate', val: var_tax_rate.array_get('rate') }, rt.ArrayItem{ key: 'tax_rate_name', val: var_tax_rate.array_get('label') }, rt.ArrayItem{ key: 'tax_rate_priority', val: 2 }, rt.ArrayItem{ key: 'tax_rate_compound', val: if rt.is_true(rt.identical(rt.new_string('yes'), var_tax_rate.array_get('compound'))) { 1 } else { 0 } }, rt.ArrayItem{ key: 'tax_rate_shipping', val: if rt.is_true(rt.identical(rt.new_string('yes'), var_tax_rate.array_get('shipping'))) { 1 } else { 0 } }, rt.ArrayItem{ key: 'tax_rate_order', val: var_loop }, rt.ArrayItem{ key: 'tax_rate_class', val: var_tax_rate.array_get('class') }])])
				mut var_tax_rate_id := rt.get_property(var_wpdb, 'insert_id')
				if rt.is_true(var_tax_rate.array_get('locations')) {
					{
						mut iter_2 := var_tax_rate.array_get('locations').iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_location := item_2.val
							rt.call_method(var_wpdb, 'insert', [(rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_tax_rate_locations', rt.create_array([rt.ArrayItem{ key: 'location_code', val: var_location }, rt.ArrayItem{ key: 'tax_rate_id', val: var_tax_rate_id }, rt.ArrayItem{ key: 'location_type', val: var_location_type }])])
						}
					}
				}
				var_loop += 1
			}
		}
	}
	rt.call_function('update_option', [rt.new_string('woocommerce_tax_rates_backup'), var_tax_rates.dup()])
	rt.call_function('update_option', [rt.new_string('woocommerce_local_tax_rates_backup'), var_local_tax_rates.dup()])
	rt.call_function('delete_option', [rt.new_string('woocommerce_tax_rates')])
	rt.call_function('delete_option', [rt.new_string('woocommerce_local_tax_rates')])
}

fn wc_update_200_line_items() {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_order_item_rows := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT meta_value, post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_order_items\''))])
	{
		mut iter_1 := var_order_item_rows.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_order_item_row := item_1.val
			mut var_order_items := rt.cast_array(rt.call_function('maybe_unserialize', [rt.get_property(var_order_item_row, 'meta_value')]))
			{
				mut iter_2 := var_order_items.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_order_item := item_2.val
					if !(var_order_item.array_isset(rt.new_string('line_total'))) && var_order_item.array_isset(rt.new_string('taxrate')) && var_order_item.array_isset(rt.new_string('cost')) {
						var_order_item.array_set('line_tax', rt.call_function('number_format', [rt.mul(rt.mul(var_order_item.array_get('cost'), var_order_item.array_get('qty')), rt.div(var_order_item.array_get('taxrate'), rt.new_int(100))), rt.new_int(2), rt.new_string('.'), rt.new_string('')]))
						var_order_item.array_set('line_total', rt.mul(var_order_item.array_get('cost'), var_order_item.array_get('qty')))
						var_order_item.array_set('line_subtotal_tax', var_order_item.array_get('line_tax'))
						var_order_item.array_set('line_subtotal', var_order_item.array_get('line_total'))
					}
					var_order_item.array_set('line_tax', if var_order_item.array_isset(rt.new_string('line_tax')) { var_order_item.array_get('line_tax') } else { rt.new_int(0) })
					var_order_item.array_set('line_total', if var_order_item.array_isset(rt.new_string('line_total')) { var_order_item.array_get('line_total') } else { rt.new_int(0) })
					var_order_item.array_set('line_subtotal_tax', if var_order_item.array_isset(rt.new_string('line_subtotal_tax')) { var_order_item.array_get('line_subtotal_tax') } else { rt.new_int(0) })
					var_order_item.array_set('line_subtotal', if var_order_item.array_isset(rt.new_string('line_subtotal')) { var_order_item.array_get('line_subtotal') } else { rt.new_int(0) })
					mut var_item_id := rt.call_function('wc_add_order_item', [rt.get_property(var_order_item_row, 'post_id'), rt.create_array([rt.ArrayItem{ key: 'order_item_name', val: var_order_item.array_get('name') }, rt.ArrayItem{ key: 'order_item_type', val: 'line_item' }])])
					if rt.is_true(var_item_id) {
						rt.call_function('wc_add_order_item_meta', [var_item_id.dup(), rt.new_string('_qty'), rt.call_function('absint', [var_order_item.array_get('qty')])])
						rt.call_function('wc_add_order_item_meta', [var_item_id.dup(), rt.new_string('_tax_class'), var_order_item.array_get('tax_class')])
						rt.call_function('wc_add_order_item_meta', [var_item_id.dup(), rt.new_string('_product_id'), var_order_item.array_get('id')])
						rt.call_function('wc_add_order_item_meta', [var_item_id.dup(), rt.new_string('_variation_id'), var_order_item.array_get('variation_id')])
						rt.call_function('wc_add_order_item_meta', [var_item_id.dup(), rt.new_string('_line_subtotal'), rt.call_function('wc_format_decimal', [var_order_item.array_get('line_subtotal')])])
						rt.call_function('wc_add_order_item_meta', [var_item_id.dup(), rt.new_string('_line_subtotal_tax'), rt.call_function('wc_format_decimal', [var_order_item.array_get('line_subtotal_tax')])])
						rt.call_function('wc_add_order_item_meta', [var_item_id.dup(), rt.new_string('_line_total'), rt.call_function('wc_format_decimal', [.array_get()])])
						rt.call_function('wc_add_order_item_meta', [var_item_id.dup(), rt.new_string('_line_tax'), rt.call_function('wc_format_decimal', [])])
						mut var_meta_rows := 
						if !(!rt.is_true()) {
						}
						if  >  {
						}
						
					}
					 = rt.new_null()
					 = rt.new_null()
					 = rt.new_null()
				}
			}
		}
	}
}



pub fn init_wp_content_plugins_woocommerce_includes_wc_update_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
