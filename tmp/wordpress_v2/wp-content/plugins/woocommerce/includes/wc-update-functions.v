import rt
import crypto.md5

fn wc_update_200_file_paths() {
	mut var_wpdb := rt.new_null()
	mut var_existing_file_paths := rt.new_null()
	mut var_existing_file_path := rt.new_null()
	mut var_old_file_path := ''
	mut var_file_paths := rt.new_null()
	var_existing_file_paths = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT meta_value, meta_id, post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_file_path\' AND meta_value != \'\';'))])
	if rt.is_true(var_existing_file_paths) {
		mut iter_1 := var_existing_file_paths.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_existing_file_path_shadow := item_1.val
			var_old_file_path = rt.get_property(var_existing_file_path_shadow, 'meta_value').to_string().trim_space()
			if !(var_old_file_path == '') {
				var_file_paths = rt.call_function('serialize', [rt.create_array([rt.ArrayItem{ key: md5.hexhash(var_old_file_path), val: var_old_file_path }])])
				rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' SET meta_key = \'_file_paths\', meta_value = %s WHERE meta_id = %d')), var_file_paths.clone(), rt.get_property(var_existing_file_path_shadow, 'meta_id')])])
				rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_downloadable_product_permissions SET download_id = %s WHERE product_id = %d')), rt.new_string(md5.hexhash(var_old_file_path)), rt.get_property(var_existing_file_path_shadow, 'post_id')])])
			}
		}
	}
}

fn wc_update_200_permalinks() {
	mut var_permalinks := rt.new_null()
	mut var_shop_page_id := rt.new_null()
	mut var_base_slug := rt.new_null()
	mut var_category_base := rt.new_null()
	mut var_category_slug := rt.new_null()
	mut var_tag_slug := rt.new_null()
	mut var_product_base := rt.new_null()
	mut var_product_slug := rt.new_null()
	var_permalinks = rt.call_function('get_option', [rt.new_string('woocommerce_permalinks')])
	var_shop_page_id = rt.call_function('wc_get_page_id', [rt.new_string('shop')])
	if !rt.is_true(var_permalinks) && rt.is_true(rt.greater(var_shop_page_id, rt.new_int(0))) {
		var_base_slug = if rt.is_true(rt.greater(var_shop_page_id, rt.new_int(0))) && rt.is_true(rt.call_function('get_post', [var_shop_page_id.clone()])) { rt.call_function('get_page_uri', [var_shop_page_id.clone()]) } else { rt.new_string('shop') }
		var_category_base = if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prepend_shop_page_to_urls')]))) { rt.call_function('trailingslashit', [var_base_slug.clone()]) } else { rt.new_string('') }
		var_category_slug = if rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_product_category_slug')])) { rt.call_function('get_option', [rt.new_string('woocommerce_product_category_slug')]) } else { rt.call_function('_x', [rt.new_string('product-category'), rt.new_string('slug'), rt.new_string('woocommerce')]) }
		var_tag_slug = if rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_product_tag_slug')])) { rt.call_function('get_option', [rt.new_string('woocommerce_product_tag_slug')]) } else { rt.call_function('_x', [rt.new_string('product-tag'), rt.new_string('slug'), rt.new_string('woocommerce')]) }
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prepend_shop_page_to_products')]))) {
		var_product_base = rt.call_function('trailingslashit', [var_base_slug.clone()])
		} else {
			var_product_slug = rt.call_function('get_option', [rt.new_string('woocommerce_product_slug')])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_product_slug)))) && !(!rt.is_true(var_product_slug)) {
			var_product_base = rt.call_function('trailingslashit', [var_product_slug.clone()])
			} else {
			var_product_base = rt.call_function('trailingslashit', [rt.call_function('_x', [rt.new_string('product'), rt.new_string('slug'), rt.new_string('woocommerce')])])
			}
		}
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prepend_category_to_products')]))) {
			var_product_base = rt.concat(var_product_base, rt.call_function('trailingslashit', [rt.new_string('%product_cat%')]))
		}
		var_permalinks = rt.create_array([rt.ArrayItem{ key: 'product_base', val: rt.call_function('untrailingslashit', [var_product_base.clone()]) }, rt.ArrayItem{ key: 'category_base', val: rt.call_function('untrailingslashit', [rt.new_string((var_category_base).str() + (var_category_slug).str())]) }, rt.ArrayItem{ key: 'attribute_base', val: rt.call_function('untrailingslashit', [var_category_base.clone()]) }, rt.ArrayItem{ key: 'tag_base', val: rt.call_function('untrailingslashit', [rt.new_string((var_category_base).str() + (var_tag_slug).str())]) }])
		rt.call_function('update_option', [rt.new_string('woocommerce_permalinks'), var_permalinks.clone()])
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
	mut var_loop := i64(0)
	mut var_tax_rates := rt.new_null()
	mut var_tax_rate := map[string]rt.PhpVal{}
	mut var_states := rt.new_null()
	mut var_country := rt.new_null()
	mut var_state := ''
	mut var_local_tax_rates := rt.new_null()
	mut var_location_type := ''
	mut var_tax_rate_id := rt.new_null()
	mut var_location := rt.new_null()
	var_loop = 0
	var_tax_rates = rt.call_function('get_option', [rt.new_string('woocommerce_tax_rates')])
	if rt.is_true(var_tax_rates) {
		mut iter_2 := var_tax_rates.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_tax_rate_shadow := item_2.val
			mut iter_3 := rt.new_string((var_tax_rate_shadow['countries']).str()).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_states_shadow := item_3.val
				mut var_country_shadow := item_3.key
				var_states_shadow = rt.call_function('array_reverse', [var_states_shadow.clone()])
				mut iter_4 := var_states_shadow.iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_state_shadow := item_4.val
					if rt.is_true(rt.identical(rt.new_string('*'), var_state_shadow)) {
					var_state_shadow = rt.new_string('')
					}
					rt.call_method(var_wpdb, 'insert', [rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_tax_rates'), rt.create_array([rt.ArrayItem{ key: 'tax_rate_country', val: var_country_shadow }, rt.ArrayItem{ key: 'tax_rate_state', val: var_state_shadow }, rt.ArrayItem{ key: 'tax_rate', val: var_tax_rate_shadow['rate'] }, rt.ArrayItem{ key: 'tax_rate_name', val: var_tax_rate_shadow['label'] }, rt.ArrayItem{ key: 'tax_rate_priority', val: 1 }, rt.ArrayItem{ key: 'tax_rate_compound', val: if rt.is_true(rt.identical(rt.new_string('yes'), rt.new_string((var_tax_rate_shadow['compound']).str()))) { 1 } else { 0 } }, rt.ArrayItem{ key: 'tax_rate_shipping', val: if rt.is_true(rt.identical(rt.new_string('yes'), rt.new_string((var_tax_rate_shadow['shipping']).str()))) { 1 } else { 0 } }, rt.ArrayItem{ key: 'tax_rate_order', val: var_loop }, rt.ArrayItem{ key: 'tax_rate_class', val: var_tax_rate_shadow['class'] }])])
					var_loop += 1
				}
			}
		}
	}
	var_local_tax_rates = rt.call_function('get_option', [rt.new_string('woocommerce_local_tax_rates')])
	if rt.is_true(var_local_tax_rates) {
		mut iter_5 := var_local_tax_rates.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_tax_rate_shadow := item_5.val
			var_location_type = if rt.is_true(rt.identical(rt.new_string('postcode'), rt.new_string((var_tax_rate_shadow['location_type']).str()))) { 'postcode' } else { 'city' }
			if rt.is_true(rt.identical(rt.new_string('*'), rt.new_string((var_tax_rate_shadow['state']).str()))) {
				var_tax_rate_shadow['state'] = ''
			}
			rt.call_method(var_wpdb, 'insert', [rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_tax_rates'), rt.create_array([rt.ArrayItem{ key: 'tax_rate_country', val: var_tax_rate_shadow['country'] }, rt.ArrayItem{ key: 'tax_rate_state', val: var_tax_rate_shadow['state'] }, rt.ArrayItem{ key: 'tax_rate', val: var_tax_rate_shadow['rate'] }, rt.ArrayItem{ key: 'tax_rate_name', val: var_tax_rate_shadow['label'] }, rt.ArrayItem{ key: 'tax_rate_priority', val: 2 }, rt.ArrayItem{ key: 'tax_rate_compound', val: if rt.is_true(rt.identical(rt.new_string('yes'), rt.new_string((var_tax_rate_shadow['compound']).str()))) { 1 } else { 0 } }, rt.ArrayItem{ key: 'tax_rate_shipping', val: if rt.is_true(rt.identical(rt.new_string('yes'), rt.new_string((var_tax_rate_shadow['shipping']).str()))) { 1 } else { 0 } }, rt.ArrayItem{ key: 'tax_rate_order', val: var_loop }, rt.ArrayItem{ key: 'tax_rate_class', val: var_tax_rate_shadow['class'] }])])
			var_tax_rate_id = rt.get_property(var_wpdb, 'insert_id')
			if rt.is_true(rt.new_string((var_tax_rate_shadow['locations']).str())) {
				mut iter_6 := rt.new_string((var_tax_rate_shadow['locations']).str()).iterator()
				for {
					item_6 := iter_6.next() or { break }
					mut var_location_shadow := item_6.val
					rt.call_method(var_wpdb, 'insert', [rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_tax_rate_locations'), rt.create_array([rt.ArrayItem{ key: 'location_code', val: var_location_shadow }, rt.ArrayItem{ key: 'tax_rate_id', val: var_tax_rate_id }, rt.ArrayItem{ key: 'location_type', val: var_location_type }])])
				}
			}
			var_loop += 1
		}
	}
	rt.call_function('update_option', [rt.new_string('woocommerce_tax_rates_backup'), var_tax_rates.clone()])
	rt.call_function('update_option', [rt.new_string('woocommerce_local_tax_rates_backup'), var_local_tax_rates.clone()])
	rt.call_function('delete_option', [rt.new_string('woocommerce_tax_rates')])
	rt.call_function('delete_option', [rt.new_string('woocommerce_local_tax_rates')])
}

fn wc_update_200_line_items() {
	mut var_wpdb := rt.new_null()
	mut var_order_item_rows := rt.new_null()
	mut var_order_item_row := rt.new_null()
	mut var_order_items := rt.new_null()
	mut var_order_item := map[string]rt.PhpVal{}
	mut var_item_id := rt.new_null()
	mut var_meta_rows := []rt.PhpVal{}
	mut var_meta := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	mut var_order_tax_rows := rt.new_null()
	mut var_order_tax_row := rt.new_null()
	mut var_order_taxes := rt.new_null()
	mut var_order_tax := map[string]rt.PhpVal{}
	var_order_item_rows = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT meta_value, post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_order_items\''))])
	mut iter_7 := var_order_item_rows.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_order_item_row_shadow := item_7.val
		var_order_items = rt.cast_array(rt.call_function('maybe_unserialize', [rt.get_property(var_order_item_row_shadow, 'meta_value')]))
		mut iter_8 := var_order_items.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_order_item_shadow := item_8.val
			if !(var_order_item_shadow.array_isset(rt.new_string('line_total'))) && var_order_item_shadow.array_isset(rt.new_string('taxrate')) && var_order_item_shadow.array_isset(rt.new_string('cost')) {
				var_order_item_shadow['line_tax'] = rt.call_function('number_format', [rt.mul(rt.mul(var_order_item_shadow['cost'], var_order_item_shadow['qty']), rt.div(var_order_item_shadow['taxrate'], rt.new_int(100))), rt.new_int(2), rt.new_string('.'), rt.new_string('')])
				var_order_item_shadow['line_total'] = rt.mul(var_order_item_shadow['cost'], var_order_item_shadow['qty'])
				var_order_item_shadow['line_subtotal_tax'] = var_order_item_shadow['line_tax']
				var_order_item_shadow['line_subtotal'] = var_order_item_shadow['line_total']
			}
			var_order_item_shadow['line_tax'] = if var_order_item_shadow.array_isset(rt.new_string('line_tax')) { var_order_item_shadow['line_tax'] } else { rt.new_int(0) }
			var_order_item_shadow['line_total'] = if var_order_item_shadow.array_isset(rt.new_string('line_total')) { var_order_item_shadow['line_total'] } else { rt.new_int(0) }
			var_order_item_shadow['line_subtotal_tax'] = if var_order_item_shadow.array_isset(rt.new_string('line_subtotal_tax')) { var_order_item_shadow['line_subtotal_tax'] } else { rt.new_int(0) }
			var_order_item_shadow['line_subtotal'] = if var_order_item_shadow.array_isset(rt.new_string('line_subtotal')) { var_order_item_shadow['line_subtotal'] } else { rt.new_int(0) }
			var_item_id = rt.call_function('wc_add_order_item', [rt.get_property(var_order_item_row_shadow, 'post_id'), rt.create_array([rt.ArrayItem{ key: 'order_item_name', val: var_order_item_shadow['name'] }, rt.ArrayItem{ key: 'order_item_type', val: 'line_item' }])])
			if rt.is_true(var_item_id) {
				rt.call_function('wc_add_order_item_meta', [var_item_id.clone(), rt.new_string('_qty'), rt.call_function('absint', [var_order_item_shadow['qty']])])
				rt.call_function('wc_add_order_item_meta', [var_item_id.clone(), rt.new_string('_tax_class'), var_order_item_shadow['tax_class']])
				rt.call_function('wc_add_order_item_meta', [var_item_id.clone(), rt.new_string('_product_id'), var_order_item_shadow['id']])
				rt.call_function('wc_add_order_item_meta', [var_item_id.clone(), rt.new_string('_variation_id'), var_order_item_shadow['variation_id']])
				rt.call_function('wc_add_order_item_meta', [var_item_id.clone(), rt.new_string('_line_subtotal'), rt.call_function('wc_format_decimal', [var_order_item_shadow['line_subtotal']])])
				rt.call_function('wc_add_order_item_meta', [var_item_id.clone(), rt.new_string('_line_subtotal_tax'), rt.call_function('wc_format_decimal', [var_order_item_shadow['line_subtotal_tax']])])
				rt.call_function('wc_add_order_item_meta', [var_item_id.clone(), rt.new_string('_line_total'), rt.call_function('wc_format_decimal', [var_order_item_shadow['line_total']])])
				rt.call_function('wc_add_order_item_meta', [var_item_id.clone(), rt.new_string('_line_tax'), rt.call_function('wc_format_decimal', [var_order_item_shadow['line_tax']])])
				var_meta_rows = []rt.PhpVal{}
				if !(!rt.is_true(var_order_item_shadow['item_meta'])) {
					mut iter_9 := var_order_item_shadow['item_meta'].iterator()
					for {
						item_9 := iter_9.next() or { break }
						mut var_meta_shadow := item_9.val
						mut var_key_shadow := item_9.key
						if var_meta_shadow.clone().is_array() && var_meta_shadow.array_isset(rt.new_string('meta_name')) {
							var_meta_rows << '(' + (var_item_id).str() + ',"' + (rt.call_function('esc_sql', [var_meta_shadow['meta_name']])).str() + '","' + (rt.call_function('esc_sql', [var_meta_shadow['meta_value']])).str() + '")'
						} else {
							var_meta_rows << '(' + (var_item_id).str() + ',"' + (rt.call_function('esc_sql', [var_key_shadow.clone()])).str() + '","' + (rt.call_function('esc_sql', [var_meta_shadow.clone()])).str() + '")'
						}
					}
				}
				if var_meta_rows.len > 0 {
					rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.new_string((rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_itemmeta ( order_item_id, meta_key, meta_value )\n\t\t\t\t\t\t\tVALUES ')) + (rt.call_function('implode', [rt.new_string(','), rt.create_array_from_list(var_meta_rows)])).str() + ';').str()), rt.get_property(var_order_item_row_shadow, 'post_id')])])
				}
				rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\t\t\t\t\tSET meta_key = \'_order_items_old\'\n\t\t\t\t\t\tWHERE meta_key = \'_order_items\'\n\t\t\t\t\t\tAND post_id = %d')), rt.get_property(var_order_item_row_shadow, 'post_id')])])
			}
			var_meta_rows = rt.new_null()
			var_item_id = rt.new_null()
			var_order_item_shadow = rt.new_null()
		}
	}
	var_order_tax_rows = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT meta_value, post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\tWHERE meta_key = \'_order_taxes\''))])
	mut iter_10 := var_order_tax_rows.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_order_tax_row_shadow := item_10.val
		var_order_taxes = rt.cast_array(rt.call_function('maybe_unserialize', [rt.get_property(var_order_tax_row_shadow, 'meta_value')]))
		if !(!rt.is_true(var_order_taxes)) {
			mut iter_11 := var_order_taxes.iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_order_tax_shadow := item_11.val
				if !(var_order_tax_shadow.array_isset(rt.new_string('label'))) || !(var_order_tax_shadow.array_isset(rt.new_string('cart_tax'))) || !(var_order_tax_shadow.array_isset(rt.new_string('shipping_tax'))) {
					continue
				}
				var_item_id = rt.call_function('wc_add_order_item', [rt.get_property(var_order_tax_row_shadow, 'post_id'), rt.create_array([rt.ArrayItem{ key: 'order_item_name', val: var_order_tax_shadow['label'] }, rt.ArrayItem{ key: 'order_item_type', val: 'tax' }])])
				if rt.is_true(var_item_id) {
					rt.call_function('wc_add_order_item_meta', [var_item_id.clone(), rt.new_string('compound'), rt.call_function('absint', [if var_order_tax_shadow.array_isset(rt.new_string('compound')) { var_order_tax_shadow['compound'] } else { rt.new_int(0) }])])
					rt.call_function('wc_add_order_item_meta', [var_item_id.clone(), rt.new_string('tax_amount'), rt.call_function('wc_clean', [var_order_tax_shadow['cart_tax']])])
					rt.call_function('wc_add_order_item_meta', [var_item_id.clone(), rt.new_string('shipping_tax_amount'), rt.call_function('wc_clean', [var_order_tax_shadow['shipping_tax']])])
				}
				rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\t\t\t\t\tSET meta_key = \'_order_taxes_old\'\n\t\t\t\t\t\tWHERE meta_key = \'_order_taxes\'\n\t\t\t\t\t\tAND post_id = %d')), rt.get_property(var_order_tax_row_shadow, 'post_id')])])
			}
		}
	}
}

fn wc_update_200_images() {
	mut var_value := rt.new_null()
	mut var_old_settings := rt.new_null()
	mut iter_12 := rt.create_array([rt.ArrayItem{ key: none, val: 'catalog' }, rt.ArrayItem{ key: none, val: 'single' }, rt.ArrayItem{ key: none, val: 'thumbnail' }]).iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_value_shadow := item_12.val
		var_old_settings = rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: 'width', val: rt.call_function('get_option', [rt.new_string('woocommerce_' + (var_value_shadow).str() + '_image_width')]) }, rt.ArrayItem{ key: 'height', val: rt.call_function('get_option', [rt.new_string('woocommerce_' + (var_value_shadow).str() + '_image_height')]) }, rt.ArrayItem{ key: 'crop', val: rt.call_function('get_option', [rt.new_string('woocommerce_' + (var_value_shadow).str() + '_image_crop')]) }])])
		if !(!rt.is_true(var_old_settings)) && rt.is_true(rt.call_function('update_option', [rt.new_string('shop_' + (var_value_shadow).str() + '_image_size'), var_old_settings.clone()])) {
			rt.call_function('delete_option', [rt.new_string('woocommerce_' + (var_value_shadow).str() + '_image_width')])
			rt.call_function('delete_option', [rt.new_string('woocommerce_' + (var_value_shadow).str() + '_image_height')])
			rt.call_function('delete_option', [rt.new_string('woocommerce_' + (var_value_shadow).str() + '_image_crop')])
		}
	}
}

fn wc_update_200_db_version() {
mut iife_temp_0 := Class_WC_Install{}
mut iife_result_0 := iife_temp_0.update_db_version(rt.new_string('2.0.0'))
}

fn wc_update_209_brazillian_state() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'postmeta'), rt.create_array([rt.ArrayItem{ key: 'meta_value', val: 'BA' }]), rt.create_array([rt.ArrayItem{ key: 'meta_key', val: '_billing_state' }, rt.ArrayItem{ key: 'meta_value', val: 'BH' }])])
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'postmeta'), rt.create_array([rt.ArrayItem{ key: 'meta_value', val: 'BA' }]), rt.create_array([rt.ArrayItem{ key: 'meta_key', val: '_shipping_state' }, rt.ArrayItem{ key: 'meta_value', val: 'BH' }])])
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'usermeta'), rt.create_array([rt.ArrayItem{ key: 'meta_value', val: 'BA' }]), rt.create_array([rt.ArrayItem{ key: 'meta_key', val: 'billing_state' }, rt.ArrayItem{ key: 'meta_value', val: 'BH' }])])
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'usermeta'), rt.create_array([rt.ArrayItem{ key: 'meta_value', val: 'BA' }]), rt.create_array([rt.ArrayItem{ key: 'meta_key', val: 'shipping_state' }, rt.ArrayItem{ key: 'meta_value', val: 'BH' }])])
}

fn wc_update_209_db_version() {
mut iife_temp_1 := Class_WC_Install{}
mut iife_result_1 := iife_temp_1.update_db_version(rt.new_string('2.0.9'))
}

fn wc_update_210_remove_pages() {
	rt.call_function('wp_trash_post', [rt.call_function('get_option', [rt.new_string('woocommerce_pay_page_id')])])
	rt.call_function('wp_trash_post', [rt.call_function('get_option', [rt.new_string('woocommerce_thanks_page_id')])])
	rt.call_function('wp_trash_post', [rt.call_function('get_option', [rt.new_string('woocommerce_view_order_page_id')])])
	rt.call_function('wp_trash_post', [rt.call_function('get_option', [rt.new_string('woocommerce_change_password_page_id')])])
	rt.call_function('wp_trash_post', [rt.call_function('get_option', [rt.new_string('woocommerce_edit_address_page_id')])])
	rt.call_function('wp_trash_post', [rt.call_function('get_option', [rt.new_string('woocommerce_lost_password_page_id')])])
}

fn wc_update_210_file_paths() {
	mut var_wpdb := rt.new_null()
	mut var_existing_file_paths := rt.new_null()
	mut var_existing_file_path := rt.new_null()
	mut var_needs_update := false
	mut var_new_value := rt.new_null()
	mut var_value := rt.new_null()
	mut var_file := rt.new_null()
	mut var_key := rt.new_null()
	var_existing_file_paths = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT meta_value, meta_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_file_paths\' AND meta_value != \'\';'))])
	if rt.is_true(var_existing_file_paths) {
		mut iter_13 := var_existing_file_paths.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_existing_file_path_shadow := item_13.val
			var_needs_update = false
			var_new_value = []rt.PhpVal{}
			var_value = rt.call_function('maybe_unserialize', [rt.new_string(rt.get_property(var_existing_file_path_shadow, 'meta_value').to_string().trim_space())])
			if rt.is_true(var_value) {
				mut iter_14 := var_value.iterator()
				for {
					item_14 := iter_14.next() or { break }
					mut var_file_shadow := item_14.val
					mut var_key_shadow := item_14.key
					if !(var_file_shadow.clone().is_array()) {
						var_needs_update = true
						var_new_value.array_set(var_key_shadow, rt.create_array([rt.ArrayItem{ key: 'file', val: var_file_shadow }, rt.ArrayItem{ key: 'name', val: rt.call_function('wc_get_filename_from_url', [var_file_shadow.clone()]) }]))
					} else {
						var_new_value.array_set(var_key_shadow, var_file_shadow.clone())
					}
				}
				if var_needs_update {
					var_new_value = rt.call_function('serialize', [var_new_value.clone()])
					rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' SET meta_key = %s, meta_value = %s WHERE meta_id = %d')), rt.new_string('_downloadable_files'), var_new_value.clone(), rt.get_property(var_existing_file_path_shadow, 'meta_id')])])
				}
			}
		}
	}
}

fn wc_update_210_db_version() {
mut iife_temp_2 := Class_WC_Install{}
mut iife_result_2 := iife_temp_2.update_db_version(rt.new_string('2.1.0'))
}

fn wc_update_220_shipping() {
	mut var_woocommerce_ship_to_destination := ''
	var_woocommerce_ship_to_destination = 'shipping'
	if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_ship_to_billing_address_only')]), rt.new_string('yes'))) {
	var_woocommerce_ship_to_destination = 'billing_only'
	} else if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_ship_to_billing')]), rt.new_string('yes'))) {
	var_woocommerce_ship_to_destination = 'billing'
	}
	rt.call_function('add_option', [rt.new_string('woocommerce_ship_to_destination'), rt.new_string((var_woocommerce_ship_to_destination).str()).clone(), rt.new_string(''), rt.new_string('no')])
}

fn wc_update_220_order_status() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' AS rel ON posts.ID = rel.object_id\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' AS tax USING( term_taxonomy_id )\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'terms')), rt.new_string(' AS term USING( term_id )\n\t\tSET posts.post_status = \'wc-pending\'\n\t\tWHERE posts.post_type = \'shop_order\'\n\t\tAND posts.post_status = \'publish\'\n\t\tAND tax.taxonomy = \'shop_order_status\'\n\t\tAND\tterm.slug LIKE \'pending%\';'))])
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' AS rel ON posts.ID = rel.object_id\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' AS tax USING( term_taxonomy_id )\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'terms')), rt.new_string(' AS term USING( term_id )\n\t\tSET posts.post_status = \'wc-processing\'\n\t\tWHERE posts.post_type = \'shop_order\'\n\t\tAND posts.post_status = \'publish\'\n\t\tAND tax.taxonomy = \'shop_order_status\'\n\t\tAND\tterm.slug LIKE \'processing%\';'))])
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' AS rel ON posts.ID = rel.object_id\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' AS tax USING( term_taxonomy_id )\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'terms')), rt.new_string(' AS term USING( term_id )\n\t\tSET posts.post_status = \'wc-on-hold\'\n\t\tWHERE posts.post_type = \'shop_order\'\n\t\tAND posts.post_status = \'publish\'\n\t\tAND tax.taxonomy = \'shop_order_status\'\n\t\tAND\tterm.slug LIKE \'on-hold%\';'))])
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' AS rel ON posts.ID = rel.object_id\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' AS tax USING( term_taxonomy_id )\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'terms')), rt.new_string(' AS term USING( term_id )\n\t\tSET posts.post_status = \'wc-completed\'\n\t\tWHERE posts.post_type = \'shop_order\'\n\t\tAND posts.post_status = \'publish\'\n\t\tAND tax.taxonomy = \'shop_order_status\'\n\t\tAND\tterm.slug LIKE \'completed%\';'))])
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' AS rel ON posts.ID = rel.object_id\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' AS tax USING( term_taxonomy_id )\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'terms')), rt.new_string(' AS term USING( term_id )\n\t\tSET posts.post_status = \'wc-cancelled\'\n\t\tWHERE posts.post_type = \'shop_order\'\n\t\tAND posts.post_status = \'publish\'\n\t\tAND tax.taxonomy = \'shop_order_status\'\n\t\tAND\tterm.slug LIKE \'cancelled%\';'))])
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' AS rel ON posts.ID = rel.object_id\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' AS tax USING( term_taxonomy_id )\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'terms')), rt.new_string(' AS term USING( term_id )\n\t\tSET posts.post_status = \'wc-refunded\'\n\t\tWHERE posts.post_type = \'shop_order\'\n\t\tAND posts.post_status = \'publish\'\n\t\tAND tax.taxonomy = \'shop_order_status\'\n\t\tAND\tterm.slug LIKE \'refunded%\';'))])
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' AS rel ON posts.ID = rel.object_id\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' AS tax USING( term_taxonomy_id )\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'terms')), rt.new_string(' AS term USING( term_id )\n\t\tSET posts.post_status = \'wc-failed\'\n\t\tWHERE posts.post_type = \'shop_order\'\n\t\tAND posts.post_status = \'publish\'\n\t\tAND tax.taxonomy = \'shop_order_status\'\n\t\tAND\tterm.slug LIKE \'failed%\';'))])
}

fn wc_update_220_variations() {
	mut var_wpdb := rt.new_null()
	mut var_update_variations := rt.new_null()
	mut var_variation := rt.new_null()
	mut var_parent_backorders := rt.new_null()
	var_update_variations = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT posts.ID AS variation_id, posts.post_parent AS variation_parent FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\tLEFT OUTER JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS postmeta ON posts.ID = postmeta.post_id AND postmeta.meta_key = \'_stock\'\n\t\tLEFT OUTER JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' as postmeta2 ON posts.ID = postmeta2.post_id AND postmeta2.meta_key = \'_manage_stock\'\n\t\tWHERE posts.post_type = \'product_variation\'\n\t\tAND postmeta.meta_value IS NOT NULL\n\t\tAND postmeta.meta_value != \'\'\n\t\tAND postmeta2.meta_value IS NULL'))])
	mut iter_15 := var_update_variations.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_variation_shadow := item_15.val
		var_parent_backorders = rt.call_function('get_post_meta', [rt.get_property(var_variation_shadow, 'variation_parent'), rt.new_string('_backorders'), rt.new_bool(true)])
		rt.call_function('add_post_meta', [rt.get_property(var_variation_shadow, 'variation_id'), rt.new_string('_manage_stock'), rt.new_string('yes'), rt.new_bool(true)])
		rt.call_function('add_post_meta', [rt.get_property(var_variation_shadow, 'variation_id'), rt.new_string('_backorders'), if rt.is_true(var_parent_backorders) { var_parent_backorders } else { rt.new_string('no') }, rt.new_bool(true)])
	}
}

fn wc_update_220_attributes() {
	mut var_wpdb := rt.new_null()
	mut var_attribute_taxonomies := rt.new_null()
	mut var_attribute_taxonomy := rt.new_null()
	mut var_sanitized_attribute_name := rt.new_null()
	var_attribute_taxonomies = rt.call_method(var_wpdb, 'get_results', [rt.new_string('SELECT attribute_name, attribute_id FROM ' + (rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_attribute_taxonomies')])
	mut iter_16 := var_attribute_taxonomies.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_attribute_taxonomy_shadow := item_16.val
		var_sanitized_attribute_name = rt.call_function('wc_sanitize_taxonomy_name', [rt.get_property(var_attribute_taxonomy_shadow, 'attribute_name')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_sanitized_attribute_name, rt.get_property(var_attribute_taxonomy_shadow, 'attribute_name'))))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT 1=1 FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_attribute_taxonomies WHERE attribute_name = %s;')), var_sanitized_attribute_name.clone()])]))))) {
				rt.call_method(var_wpdb, 'update', [rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_attribute_taxonomies')), rt.create_array([rt.ArrayItem{ key: 'attribute_name', val: var_sanitized_attribute_name }]), rt.create_array([rt.ArrayItem{ key: 'attribute_id', val: rt.get_property(var_attribute_taxonomy_shadow, 'attribute_id') }])])
				rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'term_taxonomy'), rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.call_function('wc_attribute_taxonomy_name', [var_sanitized_attribute_name.clone()]) }]), rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'pa_' + (rt.get_property(var_attribute_taxonomy_shadow, 'attribute_name')).str() }])])
			}
		}
	}
	rt.call_function('delete_transient', [rt.new_string('wc_attribute_taxonomies')])
mut iife_temp_3 := Class_WC_Cache_Helper{}
mut iife_result_3 := iife_temp_3.invalidate_cache_group(rt.new_string('woocommerce-attributes'))
}

fn wc_update_220_db_version() {
mut iife_temp_4 := Class_WC_Install{}
mut iife_result_4 := iife_temp_4.update_db_version(rt.new_string('2.2.0'))
}

fn wc_update_230_options() {
	rt.call_function('delete_metadata', [rt.new_string('user'), rt.new_int(0), rt.new_string('_money_spent'), rt.new_string(''), rt.new_bool(true)])
	rt.call_function('delete_metadata', [rt.new_string('user'), rt.new_int(0), rt.new_string('_order_count'), rt.new_string(''), rt.new_bool(true)])
	rt.call_function('delete_metadata', [rt.new_string('user'), rt.new_int(0), rt.new_string('_last_order'), rt.new_string(''), rt.new_bool(true)])
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.no_default(), rt.call_function('get_option', [rt.new_string('woocommerce_default_customer_address'), rt.new_bool(false)]))) && rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{})) {
		rt.call_function('update_option', [rt.new_string('woocommerce_default_customer_address'), Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.base()])
	}
}

fn wc_update_230_db_version() {
mut iife_temp_5 := Class_WC_Install{}
mut iife_result_5 := iife_temp_5.update_db_version(rt.new_string('2.3.0'))
}

fn wc_update_240_options() {
	rt.call_function('update_option', [rt.new_string('woocommerce_calc_discounts_sequentially'), rt.new_string('yes')])
}

fn wc_update_240_shipping_methods() {
	mut var_shipping_methods := map[string]rt.PhpVal{}
	mut var_shipping_method := rt.new_null()
	mut var_flat_rate_option_key := rt.new_null()
	mut var_shipping_classes := rt.new_null()
	mut var_has_classes := false
	mut var_cost_key := ''
	mut var_min_fee := rt.new_null()
	mut var_math_cost_strings := rt.new_null()
	mut var_fee := rt.new_null()
	mut var_shipping_class := rt.new_null()
	mut var_rate_key := rt.new_null()
	mut var_flat_rates := rt.new_null()
	mut var_rate := map[string]rt.PhpVal{}
	mut var_math_cost_string := rt.new_null()
	mut var_key := rt.new_null()
	mut var_last_key := rt.new_null()
	mut var_option_id := rt.new_null()
	var_shipping_methods = { 'woocommerce_flat_rates': create_wc_shipping_legacy_flat_rate(), 'woocommerce_international_delivery_flat_rates': create_wc_shipping_legacy_international_delivery() }
	for var_flat_rate_option_key_shadow, var_shipping_method_shadow in var_shipping_methods {
		if rt.is_true(rt.call_function('version_compare', [rt.call_method(var_shipping_method_shadow, 'get_option', [rt.new_string('version'), rt.new_int(0)]), rt.new_string('2.4.0'), rt.new_string('<')])) {
			var_shipping_classes = rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'get_shipping_classes', []rt.PhpVal{})
			var_has_classes = rt.new_bool(var_shipping_classes.clone().array_count() > 0)
			var_cost_key = if var_has_classes { 'no_class_cost' } else { 'cost' }
			var_min_fee = rt.call_method(var_shipping_method_shadow, 'get_option', [rt.new_string('minimum_fee')])
			var_math_cost_strings = rt.create_array([rt.ArrayItem{ key: 'cost', val: []rt.PhpVal{} }, rt.ArrayItem{ key: 'no_class_cost', val: []rt.PhpVal{} }])
			var_math_cost_strings.array_get_mut(var_cost_key).array_push(rt.call_method(var_shipping_method_shadow, 'get_option', [rt.new_string('cost')]))
			var_fee = rt.call_method(var_shipping_method_shadow, 'get_option', [rt.new_string('fee')])
			if rt.is_true(var_fee) {
				var_math_cost_strings.array_get_mut(var_cost_key).array_push(if rt.is_true(rt.call_function('strstr', [var_fee.clone(), rt.new_string('%')])) { '[fee percent="' + (rt.call_function('str_replace', [rt.new_string('%'), rt.new_string(''), var_fee.clone()])).str() + '" min="' + (rt.call_function('esc_attr', [var_min_fee.clone()])).str() + '"]' } else { var_fee })
			}
			mut iter_17 := var_shipping_classes.iterator()
			for {
				item_17 := iter_17.next() or { break }
				mut var_shipping_class_shadow := item_17.val
				var_rate_key = rt.new_string('class_cost_' + (rt.get_property(var_shipping_class_shadow, 'slug')).str())
				var_math_cost_strings.array_set(var_rate_key, var_math_cost_strings.array_get(rt.new_string('no_class_cost')))
			}
			var_flat_rates = rt.call_function('array_filter', [rt.cast_array(rt.call_function('get_option', [rt.new_string((var_flat_rate_option_key_shadow).str()).clone(), []rt.PhpVal{}]))])
			if rt.is_true(var_flat_rates) {
				mut iter_18 := var_flat_rates.iterator()
				for {
					item_18 := iter_18.next() or { break }
					mut var_rate_shadow := item_18.val
					mut var_shipping_class_shadow := item_18.key
					var_rate_key = rt.new_string('class_cost_' + (var_shipping_class_shadow).str())
					if rt.is_true(var_rate_shadow['cost']) || rt.is_true(var_rate_shadow['fee']) {
						var_math_cost_strings.array_get_mut(var_rate_key).array_push(var_rate_shadow['cost'])
						var_math_cost_strings.array_get_mut(var_rate_key).array_push(if rt.is_true(rt.call_function('strstr', [var_rate_shadow['fee'], rt.new_string('%')])) { '[fee percent="' + (rt.call_function('str_replace', [rt.new_string('%'), rt.new_string(''), var_rate_shadow['fee']])).str() + '" min="' + (rt.call_function('esc_attr', [var_min_fee.clone()])).str() + '"]' } else { var_rate_shadow['fee'] })
					}
				}
			}
			if rt.is_true(rt.identical(rt.new_string('item'), rt.get_property(var_shipping_method_shadow, 'type'))) {
				mut iter_19 := var_math_cost_strings.iterator()
				for {
					item_19 := iter_19.next() or { break }
					mut var_math_cost_string_shadow := item_19.val
					mut var_key_shadow := item_19.key
					var_math_cost_strings.array_set(var_key_shadow, rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), var_math_cost_strings.array_get(var_key_shadow)])]))
					if !(!rt.is_true(var_math_cost_strings.array_get(var_key_shadow))) {
						var_last_key = rt.call_function('max', [rt.new_int(0), rt.new_int(var_math_cost_strings.array_get(var_key_shadow).array_count() - 1)])
						var_math_cost_strings.array_get_mut(var_key_shadow).array_set(0, '( ' + (var_math_cost_strings.array_get(var_key_shadow).array_get(rt.new_int(0))).str())
						var_math_cost_strings.array_get(var_key_shadow).array_get(var_last_key) = rt.concat(var_math_cost_strings.array_get(var_key_shadow).array_get(var_last_key), rt.new_string(' ) * [qty]'))
					}
				}
			}
			var_math_cost_strings.array_get_mut('cost').array_push(rt.call_method(var_shipping_method_shadow, 'get_option', [rt.new_string('cost_per_order')]))
			mut iter_20 := var_math_cost_strings.iterator()
			for {
				item_20 := iter_20.next() or { break }
				mut var_math_cost_string_shadow := item_20.val
				mut var_option_id_shadow := item_20.key
				rt.get_property(var_shipping_method_shadow, 'settings').array_set(var_option_id_shadow, rt.call_function('implode', [rt.new_string(' + '), rt.call_function('array_filter', [var_math_cost_string_shadow.clone()])]))
			}
			rt.get_property(var_shipping_method_shadow, 'settings').array_set('version', '2.4.0')
			rt.get_property(var_shipping_method_shadow, 'settings').array_set('type', if rt.is_true(rt.identical(rt.new_string('item'), rt.get_property(var_shipping_method_shadow, 'settings').array_get(rt.new_string('type')))) { rt.new_string('class') } else { rt.get_property(var_shipping_method_shadow, 'settings').array_get(rt.new_string('type')) })
			rt.call_function('update_option', [rt.new_string((rt.get_property(var_shipping_method_shadow, 'plugin_id')).str() + (rt.get_property(var_shipping_method_shadow, 'id')).str() + '_settings'), rt.get_property(var_shipping_method_shadow, 'settings')])
		}
	}
}

fn wc_update_240_api_keys() {
	mut var_wpdb := rt.new_null()
	mut var_api_users := rt.new_null()
	mut var_apps_keys := []rt.PhpVal{}
	mut var__user := rt.new_null()
	mut var_user := rt.new_null()
	mut var_app := rt.new_null()
	mut var_user_id := i64(0)
	var_api_users = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT user_id FROM '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string(' WHERE meta_key = \'woocommerce_api_consumer_key\''))])
	var_apps_keys = []rt.PhpVal{}
	mut iter_21 := var_api_users.iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var__user_shadow := item_21.val
		var_user = rt.call_function('get_userdata', [rt.get_property(var__user_shadow, 'user_id')])
		var_apps_keys << rt.create_array([rt.ArrayItem{ key: 'user_id', val: rt.get_property(var_user, 'ID') }, rt.ArrayItem{ key: 'permissions', val: rt.get_property(var_user, 'woocommerce_api_key_permissions') }, rt.ArrayItem{ key: 'consumer_key', val: rt.call_function('wc_api_hash', [rt.get_property(var_user, 'woocommerce_api_consumer_key')]) }, rt.ArrayItem{ key: 'consumer_secret', val: rt.get_property(var_user, 'woocommerce_api_consumer_secret') }, rt.ArrayItem{ key: 'truncated_key', val: rt.call_function('substr', [rt.get_property(var_user, 'woocommerce_api_consumer_secret'), rt.new_int(-7)]) }])
	}
	if !(!rt.is_true(var_apps_keys)) {
		for var_app_shadow in var_apps_keys {
			rt.call_method(var_wpdb, 'insert', [rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_api_keys'), var_app_shadow.clone(), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }])])
		}
		mut iter_22 := var_api_users.iterator()
		for {
			item_22 := iter_22.next() or { break }
			mut var__user_shadow := item_22.val
			var_user_id = rt.get_property(var__user_shadow, 'user_id').to_i64()
			rt.call_function('delete_user_meta', [rt.new_int(var_user_id).clone(), rt.new_string('woocommerce_api_consumer_key')])
			rt.call_function('delete_user_meta', [rt.new_int(var_user_id).clone(), rt.new_string('woocommerce_api_consumer_secret')])
			rt.call_function('delete_user_meta', [rt.new_int(var_user_id).clone(), rt.new_string('woocommerce_api_key_permissions')])
		}
	}
}

fn wc_update_240_webhooks() {
	mut var_order_update_webhooks := rt.new_null()
	mut var_order_update_webhook := rt.new_null()
	mut var_webhook := rt.new_null()
	var_order_update_webhooks = rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'posts_per_page', val: -1 }, rt.ArrayItem{ key: 'post_type', val: 'shop_webhook' }, rt.ArrayItem{ key: 'meta_key', val: '_topic' }, rt.ArrayItem{ key: 'meta_value', val: 'order.updated' }])])
	mut iter_23 := var_order_update_webhooks.iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_order_update_webhook_shadow := item_23.val
		var_webhook = create_wc_webhook(rt.get_property(var_order_update_webhook_shadow, 'ID'))
		var_webhook.set_topic(rt.new_string('order.updated'))
	}
}

fn wc_update_240_refunds() {
	mut var_wpdb := rt.new_null()
	mut var_refunded_orders := rt.new_null()
	mut var_refunded_order := rt.new_null()
	mut var_order_total := rt.new_null()
	mut var_refunded_total := rt.new_null()
	var_refunded_orders = rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'posts_per_page', val: -1 }, rt.ArrayItem{ key: 'post_type', val: 'shop_order' }, rt.ArrayItem{ key: 'post_status', val: rt.create_array([rt.ArrayItem{ key: none, val: 'wc-refunded' }]) }])])
	rt.call_function('remove_all_actions', [rt.new_string('woocommerce_order_status_refunded_notification')])
	rt.call_function('remove_all_actions', [rt.new_string('woocommerce_order_partially_refunded_notification')])
	rt.call_function('remove_action', [rt.new_string('woocommerce_order_status_refunded'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Emails' }, rt.ArrayItem{ key: none, val: 'send_transactional_email' }])])
	rt.call_function('remove_action', [rt.new_string('woocommerce_order_partially_refunded'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Emails' }, rt.ArrayItem{ key: none, val: 'send_transactional_email' }])])
	mut iter_24 := var_refunded_orders.iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_refunded_order_shadow := item_24.val
		var_order_total = rt.call_function('get_post_meta', [rt.get_property(var_refunded_order_shadow, 'ID'), rt.new_string('_order_total'), rt.new_bool(true)])
		var_refunded_total = rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT SUM( postmeta.meta_value )\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS postmeta\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS posts ON ( posts.post_type = \'shop_order_refund\' AND posts.post_parent = %d )\n\t\t\t\tWHERE postmeta.meta_key = \'_refund_amount\'\n\t\t\t\tAND postmeta.post_id = posts.ID')), rt.get_property(var_refunded_order_shadow, 'ID')])])
		if rt.is_true(rt.greater(var_order_total, var_refunded_total)) {
			rt.call_function('wc_create_refund', [rt.create_array([rt.ArrayItem{ key: 'amount', val: rt.sub(var_order_total, var_refunded_total) }, rt.ArrayItem{ key: 'reason', val: rt.call_function('__', [rt.new_string('Order fully refunded'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'order_id', val: rt.get_property(var_refunded_order_shadow, 'ID') }, rt.ArrayItem{ key: 'line_items', val: []rt.PhpVal{} }, rt.ArrayItem{ key: 'date', val: rt.get_property(var_refunded_order_shadow, 'post_modified') }])])
		}
	}
	rt.call_function('wc_delete_shop_order_transients', []rt.PhpVal{})
}

fn wc_update_240_db_version() {
mut iife_temp_6 := Class_WC_Install{}
mut iife_result_6 := iife_temp_6.update_db_version(rt.new_string('2.4.0'))
}

fn wc_update_241_variations() {
	mut var_wpdb := rt.new_null()
	mut var_update_variations := rt.new_null()
	mut var_variation := rt.new_null()
	mut var_parent_stock_status := rt.new_null()
	var_update_variations = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT posts.ID AS variation_id, posts.post_parent AS variation_parent\n\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts\n\t\tLEFT OUTER JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS postmeta ON posts.ID = postmeta.post_id AND postmeta.meta_key = \'_stock_status\'\n\t\tWHERE posts.post_type = \'product_variation\'\n\t\tAND postmeta.meta_value IS NULL'))])
	mut iter_25 := var_update_variations.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_variation_shadow := item_25.val
		var_parent_stock_status = rt.call_function('get_post_meta', [rt.get_property(var_variation_shadow, 'variation_parent'), rt.new_string('_stock_status'), rt.new_bool(true)])
		rt.call_function('add_post_meta', [rt.get_property(var_variation_shadow, 'variation_id'), rt.new_string('_stock_status'), if rt.is_true(var_parent_stock_status) { var_parent_stock_status } else { Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock() }, rt.new_bool(true)])
		rt.call_function('delete_transient', [rt.new_string('wc_product_children_' + (rt.get_property(var_variation_shadow, 'variation_parent')).str())])
	}
mut iife_temp_7 := Class_WC_Cache_Helper{}
mut iife_result_7 := iife_temp_7.get_transient_version(rt.new_string('product'), rt.new_bool(true))
}

fn wc_update_241_db_version() {
mut iife_temp_8 := Class_WC_Install{}
mut iife_result_8 := iife_temp_8.update_db_version(rt.new_string('2.4.1'))
}

fn wc_update_250_currency() {
	mut var_wpdb := rt.new_null()
	mut var_current_currency := rt.new_null()
	var_current_currency = rt.call_function('get_option', [rt.new_string('woocommerce_currency')])
	if rt.is_true(rt.identical(rt.new_string('KIP'), var_current_currency)) {
		rt.call_function('update_option', [rt.new_string('woocommerce_currency'), rt.new_string('LAK')])
	}
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'postmeta'), rt.create_array([rt.ArrayItem{ key: 'meta_value', val: 'LAK' }]), rt.create_array([rt.ArrayItem{ key: 'meta_key', val: '_order_currency' }, rt.ArrayItem{ key: 'meta_value', val: 'KIP' }])])
}

fn wc_update_250_db_version() {
mut iife_temp_9 := Class_WC_Install{}
mut iife_result_9 := iife_temp_9.update_db_version(rt.new_string('2.5.0'))
}

fn wc_update_260_options() {
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_calc_shipping')]))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_ship_to_countries'), rt.new_string('disabled')])
	}
mut iife_temp_10 := Class_WC_Admin_Notices{}
mut iife_result_10 := iife_temp_10.add_notice(rt.new_string('legacy_shipping'))
}

fn wc_update_260_termmeta() {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.greater_equal(rt.call_function('get_option', [rt.new_string('db_version')]), rt.new_int(34370))) && rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SHOW TABLES LIKE \''), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_termmeta\';'))])) {
		if rt.is_true(rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb, 'termmeta')), rt.new_string(' ( term_id, meta_key, meta_value ) SELECT woocommerce_term_id, meta_key, meta_value FROM ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_termmeta;'))])) {
			rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('DROP TABLE IF EXISTS '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_termmeta'))])
			rt.call_function('wp_cache_flush', []rt.PhpVal{})
		}
	}
}

fn wc_update_260_zones() {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SHOW COLUMNS FROM `'), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zones` LIKE \'zone_enabled\';'))])) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zones CHANGE `zone_type` `zone_type` VARCHAR(40) NOT NULL DEFAULT \'\';'))])
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zones CHANGE `zone_enabled` `zone_enabled` INT(1) NOT NULL DEFAULT 1;'))])
	}
}

fn wc_update_260_zone_methods() {
	mut var_wpdb := rt.new_null()
	mut var_old_methods := rt.new_null()
	mut var_max_new_id := rt.new_null()
	mut var_max_old_id := rt.new_null()
	mut var_changes := rt.new_null()
	mut var_old_method := rt.new_null()
	mut var_new_instance_id := rt.new_null()
	mut var_older_settings_key := rt.new_null()
	mut var_old_settings_key := rt.new_null()
	if rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SHOW TABLES LIKE \''), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zone_shipping_methods\';'))])) {
		var_old_methods = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT zone_id, shipping_method_type, shipping_method_order, shipping_method_id FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zone_shipping_methods;'))])
		if rt.is_true(var_old_methods) {
			var_max_new_id = rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SELECT MAX(instance_id) FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zone_methods'))])
			var_max_old_id = rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SELECT MAX(shipping_method_id) FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zone_shipping_methods'))])
			rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zone_methods AUTO_INCREMENT = %d;')), rt.add(rt.call_function('max', [var_max_new_id.clone(), var_max_old_id.clone()]), rt.new_int(1))])])
			var_changes = []rt.PhpVal{}
			mut iter_26 := var_old_methods.iterator()
			for {
				item_26 := iter_26.next() or { break }
				mut var_old_method_shadow := item_26.val
				rt.call_method(var_wpdb, 'insert', [rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_shipping_zone_methods'), rt.create_array([rt.ArrayItem{ key: 'zone_id', val: rt.get_property(var_old_method_shadow, 'zone_id') }, rt.ArrayItem{ key: 'method_id', val: rt.get_property(var_old_method_shadow, 'shipping_method_type') }, rt.ArrayItem{ key: 'method_order', val: rt.get_property(var_old_method_shadow, 'shipping_method_order') }])])
				var_new_instance_id = rt.get_property(var_wpdb, 'insert_id')
				var_older_settings_key = rt.new_string('woocommerce_' + (rt.get_property(var_old_method_shadow, 'shipping_method_type')).str() + '-' + (rt.get_property(var_old_method_shadow, 'shipping_method_id')).str() + '_settings')
				var_old_settings_key = rt.new_string('woocommerce_' + (rt.get_property(var_old_method_shadow, 'shipping_method_type')).str() + '_' + (rt.get_property(var_old_method_shadow, 'shipping_method_id')).str() + '_settings')
				rt.call_function('add_option', [rt.new_string('woocommerce_' + (rt.get_property(var_old_method_shadow, 'shipping_method_type')).str() + '_' + (var_new_instance_id).str() + '_settings'), rt.call_function('get_option', [var_old_settings_key.clone(), rt.call_function('get_option', [var_older_settings_key.clone()])])])
				if rt.is_true(rt.identical(rt.new_string('table_rate'), rt.get_property(var_old_method_shadow, 'shipping_method_type'))) {
					rt.call_function('add_option', [rt.new_string('woocommerce_table_rate_default_priority_' + (var_new_instance_id).str()), rt.call_function('get_option', [rt.new_string('woocommerce_table_rate_default_priority_' + (rt.get_property(var_old_method_shadow, 'shipping_method_id')).str())])])
					rt.call_function('add_option', [rt.new_string('woocommerce_table_rate_priorities_' + (var_new_instance_id).str()), rt.call_function('get_option', [rt.new_string('woocommerce_table_rate_priorities_' + (rt.get_property(var_old_method_shadow, 'shipping_method_id')).str())])])
					rt.call_method(var_wpdb, 'update', [rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_shipping_table_rates'), rt.create_array([rt.ArrayItem{ key: 'shipping_method_id', val: var_new_instance_id }]), rt.create_array([rt.ArrayItem{ key: 'shipping_method_id', val: rt.get_property(var_old_method_shadow, 'shipping_method_id') }])])
				} else if rt.is_true(rt.identical(rt.new_string('flat_rate_boxes'), rt.get_property(var_old_method_shadow, 'shipping_method_type'))) {
					rt.call_method(var_wpdb, 'update', [rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_shipping_flat_rate_boxes'), rt.create_array([rt.ArrayItem{ key: 'shipping_method_id', val: var_new_instance_id }]), rt.create_array([rt.ArrayItem{ key: 'shipping_method_id', val: rt.get_property(var_old_method_shadow, 'shipping_method_id') }])])
				}
				var_changes.array_set(rt.get_property(var_old_method_shadow, 'shipping_method_id'), var_new_instance_id.clone())
			}
			rt.call_function('update_option', [rt.new_string('woocommerce_updated_instance_ids'), var_changes.clone()])
			rt.call_function('do_action', [rt.new_string('woocommerce_updated_instance_ids'), var_changes.clone()])
		}
	}
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zone_locations SET location_code = REPLACE( location_code, \'-\', \'...\' );'))])
}

fn wc_update_260_refunds() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_itemmeta as item_meta\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_order_items as items ON item_meta.order_item_id = items.order_item_id\n\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts ON items.order_id = posts.ID\n\t\tSET item_meta.meta_value = item_meta.meta_value * -1\n\t\tWHERE item_meta.meta_value > 0 AND item_meta.meta_key = \'_qty\' AND posts.post_type = \'shop_order_refund\''))])
}

fn wc_update_260_db_version() {
mut iife_temp_11 := Class_WC_Install{}
mut iife_result_11 := iife_temp_11.update_db_version(rt.new_string('2.6.0'))
}

fn wc_update_300_webhooks() {
	mut var_product_update_webhooks := rt.new_null()
	mut var_product_update_webhook := rt.new_null()
	mut var_webhook := rt.new_null()
	var_product_update_webhooks = rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'posts_per_page', val: -1 }, rt.ArrayItem{ key: 'post_type', val: 'shop_webhook' }, rt.ArrayItem{ key: 'meta_key', val: '_topic' }, rt.ArrayItem{ key: 'meta_value', val: 'product.updated' }])])
	mut iter_27 := var_product_update_webhooks.iterator()
	for {
		item_27 := iter_27.next() or { break }
		mut var_product_update_webhook_shadow := item_27.val
		var_webhook = create_wc_webhook(rt.get_property(var_product_update_webhook_shadow, 'ID'))
		var_webhook.set_topic(rt.new_string('product.updated'))
	}
}

fn wc_update_300_comment_type_index() {
	mut var_wpdb := rt.new_null()
	mut var_index_exists := rt.new_null()
	var_index_exists = rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.new_string('SHOW INDEX FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE column_name = \'comment_type\' and key_name = \'woo_idx_comment_type\''))])
	if rt.is_true(rt.new_bool(var_index_exists.clone().is_null())) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' ADD INDEX woo_idx_comment_type (comment_type)'))])
	}
}

fn wc_update_300_grouped_products() {
	mut var_wpdb := rt.new_null()
	mut var_parents := rt.new_null()
	mut var_parent_id := rt.new_null()
	mut var_parent := rt.new_null()
	mut var_children_ids := rt.new_null()
	var_parents = rt.call_method(var_wpdb, 'get_col', [rt.concat(rt.concat(rt.new_string('SELECT DISTINCT( post_parent ) FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_parent > 0 AND post_type = \'product\';'))])
	mut iter_28 := var_parents.iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_parent_id_shadow := item_28.val
		var_parent = rt.call_function('wc_get_product', [var_parent_id_shadow.clone()])
		if rt.is_true(var_parent) && rt.is_true(rt.call_method(var_parent, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.grouped()])) {
			var_children_ids = rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'post_parent', val: var_parent_id_shadow }, rt.ArrayItem{ key: 'posts_per_page', val: -1 }, rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'fields', val: 'ids' }])])
			rt.call_function('update_post_meta', [var_parent_id_shadow.clone(), rt.new_string('_children'), var_children_ids.clone()])
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'), rt.create_array([rt.ArrayItem{ key: 'post_parent', val: 0 }]), rt.create_array([rt.ArrayItem{ key: 'post_parent', val: var_parent_id_shadow }])])
		}
	}
}

fn wc_update_300_settings() {
	mut var_woocommerce_shipping_tax_class := rt.new_null()
	var_woocommerce_shipping_tax_class = rt.call_function('get_option', [rt.new_string('woocommerce_shipping_tax_class')])
	if rt.is_true(rt.identical(rt.new_string(''), var_woocommerce_shipping_tax_class)) {
		rt.call_function('update_option', [rt.new_string('woocommerce_shipping_tax_class'), rt.new_string('inherit')])
	} else if rt.is_true(rt.identical(rt.new_string('standard'), var_woocommerce_shipping_tax_class)) {
		rt.call_function('update_option', [rt.new_string('woocommerce_shipping_tax_class'), rt.new_string('')])
	}
}

fn wc_update_300_product_visibility() {
	mut var_wpdb := rt.new_null()
	mut var_featured_term := rt.new_null()
	mut var_exclude_search_term := rt.new_null()
	mut var_exclude_catalog_term := rt.new_null()
	mut var_outofstock_term := rt.new_null()
	mut var_rating_term := rt.new_null()
	mut iife_temp_12 := Class_WC_Install{}
	mut iife_result_12 := iife_temp_12.create_terms()
	var_featured_term = rt.call_function('get_term_by', [rt.new_string('name'), rt.new_string('featured'), rt.new_string('product_visibility')])
	if rt.is_true(var_featured_term) {
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT IGNORE INTO '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' SELECT post_id, %d, 0 FROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_featured\' AND meta_value = \'yes\';')), rt.get_property(var_featured_term, 'term_taxonomy_id')])])
	}
	var_exclude_search_term = rt.call_function('get_term_by', [rt.new_string('name'), rt.new_string('exclude-from-search'), rt.new_string('product_visibility')])
	if rt.is_true(var_exclude_search_term) {
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT IGNORE INTO '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' SELECT post_id, %d, 0 FROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_visibility\' AND meta_value IN (\'hidden\', \'catalog\');')), rt.get_property(var_exclude_search_term, 'term_taxonomy_id')])])
	}
	var_exclude_catalog_term = rt.call_function('get_term_by', [rt.new_string('name'), rt.new_string('exclude-from-catalog'), rt.new_string('product_visibility')])
	if rt.is_true(var_exclude_catalog_term) {
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT IGNORE INTO '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' SELECT post_id, %d, 0 FROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_visibility\' AND meta_value IN (\'hidden\', \'search\');')), rt.get_property(var_exclude_catalog_term, 'term_taxonomy_id')])])
	}
	var_outofstock_term = rt.call_function('get_term_by', [rt.new_string('name'), Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock(), rt.new_string('product_visibility')])
	if rt.is_true(var_outofstock_term) {
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT IGNORE INTO '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' SELECT post_id, %d, 0 FROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_stock_status\' AND meta_value = \'outofstock\';')), rt.get_property(var_outofstock_term, 'term_taxonomy_id')])])
	}
	var_rating_term = rt.call_function('get_term_by', [rt.new_string('name'), rt.new_string('rated-1'), rt.new_string('product_visibility')])
	if rt.is_true(var_rating_term) {
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT IGNORE INTO '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' SELECT post_id, %d, 0 FROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_wc_average_rating\' AND ROUND( meta_value ) = 1;')), rt.get_property(var_rating_term, 'term_taxonomy_id')])])
	}
	var_rating_term = rt.call_function('get_term_by', [rt.new_string('name'), rt.new_string('rated-2'), rt.new_string('product_visibility')])
	if rt.is_true(var_rating_term) {
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT IGNORE INTO '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' SELECT post_id, %d, 0 FROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_wc_average_rating\' AND ROUND( meta_value ) = 2;')), rt.get_property(var_rating_term, 'term_taxonomy_id')])])
	}
	var_rating_term = rt.call_function('get_term_by', [rt.new_string('name'), rt.new_string('rated-3'), rt.new_string('product_visibility')])
	if rt.is_true(var_rating_term) {
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT IGNORE INTO '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' SELECT post_id, %d, 0 FROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_wc_average_rating\' AND ROUND( meta_value ) = 3;')), rt.get_property(var_rating_term, 'term_taxonomy_id')])])
	}
	var_rating_term = rt.call_function('get_term_by', [rt.new_string('name'), rt.new_string('rated-4'), rt.new_string('product_visibility')])
	if rt.is_true(var_rating_term) {
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT IGNORE INTO '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' SELECT post_id, %d, 0 FROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_wc_average_rating\' AND ROUND( meta_value ) = 4;')), rt.get_property(var_rating_term, 'term_taxonomy_id')])])
	}
	var_rating_term = rt.call_function('get_term_by', [rt.new_string('name'), rt.new_string('rated-5'), rt.new_string('product_visibility')])
	if rt.is_true(var_rating_term) {
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT IGNORE INTO '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' SELECT post_id, %d, 0 FROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_wc_average_rating\' AND ROUND( meta_value ) = 5;')), rt.get_property(var_rating_term, 'term_taxonomy_id')])])
	}
}

fn wc_update_300_db_version() {
mut iife_temp_13 := Class_WC_Install{}
mut iife_result_13 := iife_temp_13.update_db_version(rt.new_string('3.0.0'))
}

fn wc_update_310_downloadable_products() {
	mut var_wpdb := rt.new_null()
	mut var_index_exists := rt.new_null()
	var_index_exists = rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.new_string('SHOW INDEX FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_downloadable_product_permissions WHERE column_name = \'order_id\' and key_name = \'order_id\''))])
	if rt.is_true(rt.new_bool(var_index_exists.clone().is_null())) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_downloadable_product_permissions ADD INDEX order_id (order_id)'))])
	}
}

fn wc_update_310_old_comments() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' comments LEFT JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' as posts ON comments.comment_post_ID = posts.ID SET comment_type = \'order_note\' WHERE posts.post_type = \'shop_order\' AND comment_type = \'\';'))])
}

fn wc_update_310_db_version() {
mut iife_temp_14 := Class_WC_Install{}
mut iife_result_14 := iife_temp_14.update_db_version(rt.new_string('3.1.0'))
}

fn wc_update_312_shop_manager_capabilities() {
	mut var_role := rt.new_null()
	var_role = rt.call_function('get_role', [rt.new_string('shop_manager')])
	rt.call_method(var_role, 'remove_cap', [rt.new_string('unfiltered_html')])
}

fn wc_update_312_db_version() {
mut iife_temp_15 := Class_WC_Install{}
mut iife_result_15 := iife_temp_15.update_db_version(rt.new_string('3.1.2'))
}

fn wc_update_320_mexican_states() {
	mut var_wpdb := rt.new_null()
	mut var_mx_states := map[string]rt.PhpVal{}
	mut var_new := rt.new_null()
	mut var_old := rt.new_null()
	var_mx_states = { 'Distrito Federal': 'CMX', 'Jalisco': 'JAL', 'Nuevo Leon': 'NLE', 'Aguascalientes': 'AGS', 'Baja California': 'BCN', 'Baja California Sur': 'BCS', 'Campeche': 'CAM', 'Chiapas': 'CHP', 'Chihuahua': 'CHH', 'Coahuila': 'COA', 'Colima': 'COL', 'Durango': 'DGO', 'Guanajuato': 'GTO', 'Guerrero': 'GRO', 'Hidalgo': 'HGO', 'Estado de Mexico': 'MEX', 'Michoacan': 'MIC', 'Morelos': 'MOR', 'Nayarit': 'NAY', 'Oaxaca': 'OAX', 'Puebla': 'PUE', 'Queretaro': 'QRO', 'Quintana Roo': 'ROO', 'San Luis Potosi': 'SLP', 'Sinaloa': 'SIN', 'Sonora': 'SON', 'Tabasco': 'TAB', 'Tamaulipas': 'TMP', 'Tlaxcala': 'TLA', 'Veracruz': 'VER', 'Yucatan': 'YUC', 'Zacatecas': 'ZAC' }
	for var_old_shadow, var_new_shadow in var_mx_states {
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\t\t\tSET meta_value = %s\n\t\t\t\tWHERE meta_key IN ( \'_billing_state\', \'_shipping_state\' )\n\t\t\t\tAND meta_value = %s')), rt.new_string((var_new_shadow).str()).clone(), rt.new_string((var_old_shadow).str()).clone()])])
		rt.call_method(var_wpdb, 'update', [rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_shipping_zone_locations')), rt.create_array([rt.ArrayItem{ key: 'location_code', val: 'MX:' + (rt.new_string((var_new_shadow).str())).str() }]), rt.create_array([rt.ArrayItem{ key: 'location_code', val: 'MX:' + (rt.new_string((var_old_shadow).str())).str() }])])
		rt.call_method(var_wpdb, 'update', [rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_tax_rates')), rt.create_array([rt.ArrayItem{ key: 'tax_rate_state', val: rt.new_string((var_new_shadow).str()).clone().to_string().to_upper() }]), rt.create_array([rt.ArrayItem{ key: 'tax_rate_state', val: rt.new_string((var_old_shadow).str()).clone().to_string().to_upper() }])])
	}
}

fn wc_update_320_db_version() {
mut iife_temp_16 := Class_WC_Install{}
mut iife_result_16 := iife_temp_16.update_db_version(rt.new_string('3.2.0'))
}

fn wc_update_330_image_options() {
	mut var_old_thumbnail_size := rt.new_null()
	mut var_old_single_size := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	mut var_hard_crop := false
	mut var_ratio := rt.new_null()
	mut var_fraction := rt.new_null()
	var_old_thumbnail_size = rt.call_function('get_option', [rt.new_string('shop_catalog_image_size'), []rt.PhpVal{}])
	var_old_single_size = rt.call_function('get_option', [rt.new_string('shop_single_image_size'), []rt.PhpVal{}])
	if !(!rt.is_true(var_old_thumbnail_size.array_get(rt.new_string('width')))) {
		var_width = rt.call_function('absint', [var_old_thumbnail_size.array_get(rt.new_string('width'))])
		var_height = rt.call_function('absint', [var_old_thumbnail_size.array_get(rt.new_string('height'))])
		var_hard_crop = !(!rt.is_true(var_old_thumbnail_size.array_get(rt.new_string('crop'))))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_width)))) {
		var_width = rt.new_int(300)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_height)))) {
		var_height = var_width.clone()
		}
		rt.call_function('update_option', [rt.new_string('woocommerce_thumbnail_image_width'), var_width.clone()])
		if !(var_hard_crop) {
			rt.call_function('update_option', [rt.new_string('woocommerce_thumbnail_cropping'), rt.new_string('uncropped')])
		} else if rt.is_true(rt.identical(var_width, var_height)) {
			rt.call_function('update_option', [rt.new_string('woocommerce_thumbnail_cropping'), rt.new_string('1:1')])
		} else {
			var_ratio = rt.div(var_width, var_height)
			var_fraction = rt.call_function('wc_decimal_to_fraction', [var_ratio.clone()])
			if rt.is_true(var_fraction) {
				rt.call_function('update_option', [rt.new_string('woocommerce_thumbnail_cropping'), rt.new_string('custom')])
				rt.call_function('update_option', [rt.new_string('woocommerce_thumbnail_cropping_custom_width'), var_fraction.array_get(rt.new_int(0))])
				rt.call_function('update_option', [rt.new_string('woocommerce_thumbnail_cropping_custom_height'), var_fraction.array_get(rt.new_int(1))])
			}
		}
	}
	if !(!rt.is_true(var_old_single_size.array_get(rt.new_string('width')))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_single_image_width'), rt.call_function('absint', [var_old_single_size.array_get(rt.new_string('width'))])])
	}
}

fn wc_update_330_webhooks() {
	mut var_statuses := map[string]rt.PhpVal{}
	mut var_posts := rt.new_null()
	mut var_post := rt.new_null()
	mut var_webhook := rt.new_null()
	rt.call_function('register_post_type', [rt.new_string('shop_webhook')])
	var_statuses = { 'publish': 'active', 'draft': 'paused', 'pending': 'disabled' }
	var_posts = rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'posts_per_page', val: -1 }, rt.ArrayItem{ key: 'post_type', val: 'shop_webhook' }, rt.ArrayItem{ key: 'post_status', val: 'any' }])])
	mut iter_29 := var_posts.iterator()
	for {
		item_29 := iter_29.next() or { break }
		mut var_post_shadow := item_29.val
		var_webhook = create_wc_webhook()
		var_webhook.set_name(rt.get_property(var_post_shadow, 'post_title'))
		var_webhook.set_status(rt.new_string((if var_statuses.array_isset(rt.get_property(var_post_shadow, 'post_status')) { var_statuses[rt.get_property(var_post_shadow, 'post_status')] } else { 'disabled' }).str()))
		var_webhook.set_delivery_url(rt.call_function('get_post_meta', [rt.get_property(var_post_shadow, 'ID'), rt.new_string('_delivery_url'), rt.new_bool(true)]))
		var_webhook.set_secret(rt.call_function('get_post_meta', [rt.get_property(var_post_shadow, 'ID'), rt.new_string('_secret'), rt.new_bool(true)]))
		var_webhook.set_topic(rt.call_function('get_post_meta', [rt.get_property(var_post_shadow, 'ID'), rt.new_string('_topic'), rt.new_bool(true)]))
		var_webhook.set_api_version(rt.call_function('get_post_meta', [rt.get_property(var_post_shadow, 'ID'), rt.new_string('_api_version'), rt.new_bool(true)]))
		var_webhook.set_user_id(rt.get_property(var_post_shadow, 'post_author'))
		var_webhook.set_pending_delivery(rt.new_bool(false))
		var_webhook.save()
		rt.call_function('wp_delete_post', [rt.get_property(var_post_shadow, 'ID'), rt.new_bool(true)])
	}
	rt.call_function('unregister_post_type', [rt.new_string('shop_webhook')])
}

fn wc_update_330_set_default_product_cat() {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_AssignDefaultCategory.class()]), 'maybe_assign_default_product_cat', []rt.PhpVal{})
}

fn wc_update_330_product_stock_status() {
	mut var_wpdb := rt.new_null()
	mut var_min_stock_amount := rt.new_null()
	mut var_post_ids := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_manage_stock')]))))) {
		return
	}
	var_min_stock_amount = rt.new_int((rt.call_function('get_option', [rt.new_string('woocommerce_notify_no_stock_amount'), rt.new_int(0)])).to_i64())
	var_post_ids = rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT t1.post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' t1\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' t2\n\t\t\t\tON t1.post_id = t2.post_id\n\t\t\t\tAND t1.meta_key = \'_manage_stock\' AND t1.meta_value = \'yes\'\n\t\t\t\tAND t2.meta_key = \'_stock\' AND t2.meta_value <= %d\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' t3\n\t\t\t\tON t2.post_id = t3.post_id\n\t\t\t\tAND t3.meta_key = \'_backorders\' AND ( t3.meta_value = \'yes\' OR t3.meta_value = \'notify\' )')), var_min_stock_amount.clone()])])
	if !rt.is_true(var_post_ids) {
		return
	}
	var_post_ids = rt.call_function('array_map', [rt.new_string('absint'), var_post_ids.clone()])
	rt.call_method(var_wpdb, 'query', [rt.new_string((rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\tSET meta_value = \'onbackorder\'\n\t\tWHERE meta_key = \'_stock_status\' AND post_id IN ( ')) + (rt.call_function('implode', [rt.new_string(','), var_post_ids.clone()])).str() + ' )').str())])
}

fn wc_update_330_clear_transients() {
	rt.call_function('delete_transient', [rt.new_string('wc_addons_sections')])
	rt.call_function('delete_transient', [rt.new_string('wc_addons_featured')])
}

fn wc_update_330_set_paypal_sandbox_credentials() {
	mut var_paypal_settings := rt.new_null()
	mut var_credential := rt.new_null()
	var_paypal_settings = rt.call_function('get_option', [rt.new_string('woocommerce_paypal_settings')])
	if var_paypal_settings.array_isset(rt.new_string('testmode')) && rt.is_true(rt.identical(rt.new_string('yes'), var_paypal_settings.array_get(rt.new_string('testmode')))) {
		mut iter_30 := rt.create_array([rt.ArrayItem{ key: none, val: 'api_username' }, rt.ArrayItem{ key: none, val: 'api_password' }, rt.ArrayItem{ key: none, val: 'api_signature' }]).iterator()
		for {
			item_30 := iter_30.next() or { break }
			mut var_credential_shadow := item_30.val
			if !(!rt.is_true(var_paypal_settings.array_get(var_credential_shadow))) {
				var_paypal_settings.array_set('sandbox_' + (var_credential_shadow).str(), var_paypal_settings.array_get(var_credential_shadow))
			}
		}
		rt.call_function('update_option', [rt.new_string('woocommerce_paypal_settings'), var_paypal_settings.clone()])
	}
}

fn wc_update_330_db_version() {
mut iife_temp_17 := Class_WC_Install{}
mut iife_result_17 := iife_temp_17.update_db_version(rt.new_string('3.3.0'))
}

fn wc_update_340_states() {
	mut var_country_states := rt.new_null()
	var_country_states = rt.create_array([rt.ArrayItem{ key: 'IE', val: rt.create_array([rt.ArrayItem{ key: 'CK', val: 'CO' }, rt.ArrayItem{ key: 'DN', val: 'D' }, rt.ArrayItem{ key: 'GY', val: 'G' }, rt.ArrayItem{ key: 'TY', val: 'TA' }]) }, rt.ArrayItem{ key: 'BD', val: rt.create_array([rt.ArrayItem{ key: 'BAG', val: 'BD-05' }, rt.ArrayItem{ key: 'BAN', val: 'BD-01' }, rt.ArrayItem{ key: 'BAR', val: 'BD-02' }, rt.ArrayItem{ key: 'BARI', val: 'BD-06' }, rt.ArrayItem{ key: 'BHO', val: 'BD-07' }, rt.ArrayItem{ key: 'BOG', val: 'BD-03' }, rt.ArrayItem{ key: 'BRA', val: 'BD-04' }, rt.ArrayItem{ key: 'CHA', val: 'BD-09' }, rt.ArrayItem{ key: 'CHI', val: 'BD-10' }, rt.ArrayItem{ key: 'CHU', val: 'BD-12' }, rt.ArrayItem{ key: 'COX', val: 'BD-11' }, rt.ArrayItem{ key: 'COM', val: 'BD-08' }, rt.ArrayItem{ key: 'DHA', val: 'BD-13' }, rt.ArrayItem{ key: 'DIN', val: 'BD-14' }, rt.ArrayItem{ key: 'FAR', val: 'BD-15' }, rt.ArrayItem{ key: 'FEN', val: 'BD-16' }, rt.ArrayItem{ key: 'GAI', val: 'BD-19' }, rt.ArrayItem{ key: 'GAZI', val: 'BD-18' }, rt.ArrayItem{ key: 'GOP', val: 'BD-17' }, rt.ArrayItem{ key: 'HAB', val: 'BD-20' }, rt.ArrayItem{ key: 'JAM', val: 'BD-21' }, rt.ArrayItem{ key: 'JES', val: 'BD-22' }, rt.ArrayItem{ key: 'JHA', val: 'BD-25' }, rt.ArrayItem{ key: 'JHE', val: 'BD-23' }, rt.ArrayItem{ key: 'JOY', val: 'BD-24' }, rt.ArrayItem{ key: 'KHA', val: 'BD-29' }, rt.ArrayItem{ key: 'KHU', val: 'BD-27' }, rt.ArrayItem{ key: 'KIS', val: 'BD-26' }, rt.ArrayItem{ key: 'KUR', val: 'BD-28' }, rt.ArrayItem{ key: 'KUS', val: 'BD-30' }, rt.ArrayItem{ key: 'LAK', val: 'BD-31' }, rt.ArrayItem{ key: 'LAL', val: 'BD-32' }, rt.ArrayItem{ key: 'MAD', val: 'BD-36' }, rt.ArrayItem{ key: 'MAG', val: 'BD-37' }, rt.ArrayItem{ key: 'MAN', val: 'BD-33' }, rt.ArrayItem{ key: 'MEH', val: 'BD-39' }, rt.ArrayItem{ key: 'MOU', val: 'BD-38' }, rt.ArrayItem{ key: 'MUN', val: 'BD-35' }, rt.ArrayItem{ key: 'MYM', val: 'BD-34' }, rt.ArrayItem{ key: 'NAO', val: 'BD-48' }, rt.ArrayItem{ key: 'NAR', val: 'BD-43' }, rt.ArrayItem{ key: 'NARG', val: 'BD-40' }, rt.ArrayItem{ key: 'NARD', val: 'BD-42' }, rt.ArrayItem{ key: 'NAT', val: 'BD-44' }, rt.ArrayItem{ key: 'NAW', val: 'BD-45' }, rt.ArrayItem{ key: 'NET', val: 'BD-41' }, rt.ArrayItem{ key: 'NIL', val: 'BD-46' }, rt.ArrayItem{ key: 'NOA', val: 'BD-47' }, rt.ArrayItem{ key: 'PAB', val: 'BD-49' }, rt.ArrayItem{ key: 'PAN', val: 'BD-52' }, rt.ArrayItem{ key: 'PAT', val: 'BD-51' }, rt.ArrayItem{ key: 'PIR', val: 'BD-50' }, rt.ArrayItem{ key: 'RAJB', val: 'BD-53' }, rt.ArrayItem{ key: 'RAJ', val: 'BD-54' }, rt.ArrayItem{ key: 'RAN', val: 'BD-56' }, rt.ArrayItem{ key: 'RANP', val: 'BD-55' }, rt.ArrayItem{ key: 'SAT', val: 'BD-58' }, rt.ArrayItem{ key: 'SHA', val: 'BD-57' }, rt.ArrayItem{ key: 'SIR', val: 'BD-59' }, rt.ArrayItem{ key: 'SUN', val: 'BD-61' }, rt.ArrayItem{ key: 'SYL', val: 'BD-60' }, rt.ArrayItem{ key: 'TAN', val: 'BD-63' }, rt.ArrayItem{ key: 'THA', val: 'BD-64' }]) }])
	rt.call_function('update_option', [rt.new_string('woocommerce_update_340_states'), var_country_states.clone()])
}

fn wc_update_340_state() bool {
	mut var_wpdb := rt.new_null()
	mut var_country_states := rt.new_null()
	mut var_states := rt.new_null()
	mut var_country := rt.new_null()
	mut var_new := rt.new_null()
	mut var_old := rt.new_null()
	var_country_states = rt.call_function('array_filter', [rt.cast_array(rt.call_function('get_option', [rt.new_string('woocommerce_update_340_states'), []rt.PhpVal{}]))])
	if !rt.is_true(var_country_states) {
		return false
	}
	mut iter_31 := var_country_states.iterator()
	for {
		item_31 := iter_31.next() or { break }
		mut var_states_shadow := item_31.val
		mut var_country_shadow := item_31.key
		mut iter_32 := var_states_shadow.iterator()
		for {
			item_32 := iter_32.next() or { break }
			mut var_new_shadow := item_32.val
			mut var_old_shadow := item_32.key
			rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\t\t\t\tSET meta_value = %s\n\t\t\t\t\tWHERE meta_key IN ( \'_billing_state\', \'_shipping_state\' )\n\t\t\t\t\tAND meta_value = %s')), var_new_shadow.clone(), var_old_shadow.clone()])])
			rt.call_method(var_wpdb, 'update', [rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_shipping_zone_locations')), rt.create_array([rt.ArrayItem{ key: 'location_code', val: (var_country_shadow).str() + ':' + (var_new_shadow).str() }]), rt.create_array([rt.ArrayItem{ key: 'location_code', val: (var_country_shadow).str() + ':' + (var_old_shadow).str() }])])
			rt.call_method(var_wpdb, 'update', [rt.concat(rt.get_property(var_wpdb, 'prefix'), rt.new_string('woocommerce_tax_rates')), rt.create_array([rt.ArrayItem{ key: 'tax_rate_state', val: var_new_shadow.clone().to_string().to_upper() }]), rt.create_array([rt.ArrayItem{ key: 'tax_rate_state', val: var_old_shadow.clone().to_string().to_upper() }])])
			var_country_states.array_get(var_country_shadow).array_unset(var_old_shadow)
			if !rt.is_true(var_country_states.array_get(var_country_shadow)) {
				var_country_states.array_unset(var_country_shadow)
			}
			break
		}
	}
	if !(!rt.is_true(var_country_states)) {
		return (rt.call_function('update_option', [rt.new_string('woocommerce_update_340_states'), var_country_states.clone()])).to_bool()
	}
	rt.call_function('delete_option', [rt.new_string('woocommerce_update_340_states')])
	return false
}

fn wc_update_340_last_active() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tINSERT INTO '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string(' (user_id, meta_key, meta_value)\n\t\t\tSELECT DISTINCT users.ID, \'wc_last_active\', %s\n\t\t\tFROM ')), rt.get_property(var_wpdb, 'users')), rt.new_string(' as users\n\t\t\tLEFT OUTER JOIN ')), rt.get_property(var_wpdb, 'usermeta')), rt.new_string(' AS usermeta ON users.ID = usermeta.user_id AND usermeta.meta_key = \'wc_last_active\'\n\t\t\tWHERE usermeta.meta_value IS NULL\n\t\t\t')), rt.new_string((rt.call_function('strtotime', [rt.call_function('date', [rt.new_string('Y-m-d'), rt.call_function('current_time', [rt.new_string('timestamp'), rt.new_bool(true)])])])).str())])])
}

fn wc_update_340_db_version() {
mut iife_temp_18 := Class_WC_Install{}
mut iife_result_18 := iife_temp_18.update_db_version(rt.new_string('3.4.0'))
}

fn wc_update_343_cleanup_foreign_keys() {
	mut var_wpdb := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_create_table_sql := rt.new_null()
	mut var_foreign_key_name := rt.new_null()
	var_create_table_sql = rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SHOW CREATE TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_download_log')), rt.new_int(1)])
	if !(!rt.is_true(var_create_table_sql)) {
		if rt.is_true(rt.call_function('preg_match_all', [rt.new_string('/CONSTRAINT `([^`]*wc_download_log_ib[^`]*)` FOREIGN KEY/'), var_create_table_sql.clone(), rt.create_array_from_list(var_matches)])) && !(!rt.is_true(var_matches[1])) {
			mut iter_33 := var_matches[1].iterator()
			for {
				item_33 := iter_33.next() or { break }
				mut var_foreign_key_name_shadow := item_33.val
				rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_download_log DROP FOREIGN KEY `')), var_foreign_key_name_shadow), rt.new_string('`'))])
			}
		}
	}
}

fn wc_update_343_db_version() {
mut iife_temp_19 := Class_WC_Install{}
mut iife_result_19 := iife_temp_19.update_db_version(rt.new_string('3.4.3'))
}

fn wc_update_344_recreate_roles() {
mut iife_temp_20 := Class_WC_Install{}
mut iife_result_20 := iife_temp_20.remove_roles()
mut iife_temp_21 := Class_WC_Install{}
mut iife_result_21 := iife_temp_21.create_roles()
}

fn wc_update_344_db_version() {
mut iife_temp_22 := Class_WC_Install{}
mut iife_result_22 := iife_temp_22.update_db_version(rt.new_string('3.4.4'))
}

fn wc_update_350_reviews_comment_type() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('comments JOIN ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('posts ON ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('posts.ID = ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('comments.comment_post_ID AND ( ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('posts.post_type = \'product\' OR ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('posts.post_type = \'product_variation\' ) SET ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('comments.comment_type = \'review\' WHERE ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('comments.comment_type = \'\''))])
}

fn wc_update_350_db_version() {
mut iife_temp_23 := Class_WC_Install{}
mut iife_result_23 := iife_temp_23.update_db_version(rt.new_string('3.5.0'))
}

fn wc_update_352_drop_download_log_fk() {
	mut var_wpdb := rt.new_null()
	mut var_create_table_sql := rt.new_null()
	var_create_table_sql = rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SHOW CREATE TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_download_log')), rt.new_int(1)])
	if !(!rt.is_true(var_create_table_sql)) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_create_table_sql.clone(), rt.new_string('CONSTRAINT `fk_wc_download_log_permission_id` FOREIGN KEY')]), rt.new_bool(false))))) {
			rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_download_log DROP FOREIGN KEY fk_wc_download_log_permission_id'))])
		}
	}
}

fn wc_update_354_modify_shop_manager_caps() {
	mut var_wp_roles := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_Roles')]))))) {
		return
	}
	if !(!(var_wp_roles).is_null()) {
	var_wp_roles = create_wp_roles()
	}
	var_wp_roles.remove_cap(rt.new_string('shop_manager'), rt.new_string('edit_users'))
}

fn wc_update_354_db_version() {
mut iife_temp_24 := Class_WC_Install{}
mut iife_result_24 := iife_temp_24.update_db_version(rt.new_string('3.5.4'))
}

fn wc_update_360_product_lookup_tables() {
	rt.call_function('wc_update_product_lookup_tables', []rt.PhpVal{})
}

fn wc_update_360_term_meta() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'termmeta')), rt.new_string(' SET meta_key = \'order\' WHERE meta_key LIKE \'order_pa_%\';'))])
}

fn wc_update_360_downloadable_product_permissions_index() {
	mut var_wpdb := rt.new_null()
	mut var_index_exists := rt.new_null()
	var_index_exists = rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.new_string('SHOW INDEX FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_downloadable_product_permissions WHERE key_name = \'user_order_remaining_expires\''))])
	if rt.is_true(rt.new_bool(var_index_exists.clone().is_null())) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_downloadable_product_permissions ADD INDEX user_order_remaining_expires (user_id,order_id,downloads_remaining,access_expires)'))])
	}
}

fn wc_update_360_db_version() {
mut iife_temp_25 := Class_WC_Install{}
mut iife_result_25 := iife_temp_25.update_db_version(rt.new_string('3.6.0'))
}

fn wc_update_370_tax_rate_classes() {
	mut var_wpdb := rt.new_null()
	mut var_classes := rt.new_null()
	mut var_class := rt.new_null()
	var_classes = rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string('\n'), rt.call_function('get_option', [rt.new_string('woocommerce_tax_classes')])])])
	if rt.is_true(var_classes) {
		mut iter_34 := var_classes.iterator()
		for {
			item_34 := iter_34.next() or { break }
			mut var_class_shadow := item_34.val
			if !rt.is_true(var_class_shadow) {
				continue
			}
		mut iife_temp_26 := Class_WC_Tax{}
		mut iife_result_26 := iife_temp_26.create_tax_class(var_class_shadow.clone())
		}
	}
	rt.call_function('delete_option', [rt.new_string('woocommerce_tax_classes')])
}

fn wc_update_370_mro_std_currency() {
	mut var_wpdb := rt.new_null()
	mut var_current_currency := rt.new_null()
	var_current_currency = rt.call_function('get_option', [rt.new_string('woocommerce_currency')])
	if rt.is_true(rt.identical(rt.new_string('MRO'), var_current_currency)) {
		rt.call_function('update_option', [rt.new_string('woocommerce_currency'), rt.new_string('MRU')])
	}
	if rt.is_true(rt.identical(rt.new_string('STD'), var_current_currency)) {
		rt.call_function('update_option', [rt.new_string('woocommerce_currency'), rt.new_string('STN')])
	}
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'postmeta'), rt.create_array([rt.ArrayItem{ key: 'meta_value', val: 'MRU' }]), rt.create_array([rt.ArrayItem{ key: 'meta_key', val: '_order_currency' }, rt.ArrayItem{ key: 'meta_value', val: 'MRO' }])])
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'postmeta'), rt.create_array([rt.ArrayItem{ key: 'meta_value', val: 'STN' }]), rt.create_array([rt.ArrayItem{ key: 'meta_key', val: '_order_currency' }, rt.ArrayItem{ key: 'meta_value', val: 'STD' }])])
}

fn wc_update_370_db_version() {
mut iife_temp_27 := Class_WC_Install{}
mut iife_result_27 := iife_temp_27.update_db_version(rt.new_string('3.7.0'))
}

fn wc_update_390_move_maxmind_database() {
	mut var_old_path := rt.new_null()
	mut var_prefix := rt.new_null()
	mut var_uploads_dir := rt.new_null()
	mut var_new_path := rt.new_null()
	var_old_path = rt.call_function('apply_filters', [rt.new_string('woocommerce_geolocation_local_database_path'), rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/uploads/GeoLite2-Country.mmdb'), rt.new_int(2)])
	var_prefix = rt.call_function('wp_generate_password', [rt.new_int(32), rt.new_bool(false)])
	rt.call_function('update_option', [rt.new_string('woocommerce_maxmind_geolocation_settings'), rt.create_array([rt.ArrayItem{ key: 'database_prefix', val: var_prefix }])])
	var_uploads_dir = rt.call_function('wp_upload_dir', []rt.PhpVal{})
	var_new_path = rt.new_string((rt.call_function('trailingslashit', [var_uploads_dir.array_get(rt.new_string('basedir'))])).str() + 'woocommerce_uploads/' + (var_prefix).str() + '-GeoLite2-Country.mmdb')
	var_new_path = rt.call_function('apply_filters', [rt.new_string('woocommerce_geolocation_local_database_path'), var_new_path.clone(), rt.new_int(2)])
	var_new_path = rt.call_function('apply_filters', [rt.new_string('woocommerce_maxmind_geolocation_database_path'), var_new_path.clone()])
	rt.call_function('rename', [var_old_path.clone(), var_new_path.clone()])
}

fn wc_update_390_change_geolocation_database_update_cron() {
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_geoip_updater')])
	rt.call_function('wp_schedule_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.new_int(15))), rt.new_string('fifteendays'), rt.new_string('woocommerce_geoip_updater')])
}

fn wc_update_390_db_version() {
mut iife_temp_28 := Class_WC_Install{}
mut iife_result_28 := iife_temp_28.update_db_version(rt.new_string('3.9.0'))
}

fn wc_update_400_increase_size_of_column() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_product_meta_lookup MODIFY COLUMN `min_price` decimal(19,4) NULL default NULL'))])
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_product_meta_lookup MODIFY COLUMN `max_price` decimal(19,4) NULL default NULL'))])
}

fn wc_update_400_reset_action_scheduler_migration_status() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ActionScheduler_DataController')])) && rt.is_true(rt.call_function('method_exists', [rt.new_string('ActionScheduler_DataController'), rt.new_string('mark_migration_incomplete')])) {
	mut iife_temp_29 := Class_ActionScheduler_DataController{}
	mut iife_result_29 := iife_temp_29.mark_migration_incomplete()
	}
}

fn wc_update_400_db_version() {
mut iife_temp_30 := Class_WC_Install{}
mut iife_result_30 := iife_temp_30.update_db_version(rt.new_string('4.0.0'))
}

fn wc_update_440_insert_attribute_terms_for_variable_products() bool {
	return false
}

fn wc_update_440_db_version() {
mut iife_temp_31 := Class_WC_Install{}
mut iife_result_31 := iife_temp_31.update_db_version(rt.new_string('4.4.0'))
}

fn wc_update_450_db_version() {
mut iife_temp_32 := Class_WC_Install{}
mut iife_result_32 := iife_temp_32.update_db_version(rt.new_string('4.5.0'))
}

fn wc_update_450_sanitize_coupons_code() bool {
	mut var_wpdb := rt.new_null()
	mut var_coupon_id := i64(0)
	mut var_last_coupon_id := rt.new_null()
	mut var_coupons := rt.new_null()
	mut var_data := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	mut var_code := ''
	var_coupon_id = 0
	var_last_coupon_id = rt.call_function('get_option', [rt.new_string('woocommerce_update_450_last_coupon_id'), rt.new_string('0')])
	var_coupons = rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID, post_title FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE ID > %d AND post_type = \'shop_coupon\' LIMIT 10')), var_last_coupon_id.clone()]), rt.get_constant('ARRAY_A')])
	if !rt.is_true(var_coupons) {
		rt.call_function('delete_option', [rt.new_string('woocommerce_update_450_last_coupon_id')])
		return false
	}
	mut iter_35 := var_coupons.iterator()
	for {
		item_35 := iter_35.next() or { break }
		mut var_data_shadow := item_35.val
		mut var_key_shadow := item_35.key
		var_coupon_id = var_data_shadow['ID'].to_i64()
		var_code = rt.call_function('wp_filter_kses', [var_data_shadow['post_title']]).to_string().trim_space()
		if !(var_code == '') && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_data_shadow['post_title'], rt.new_string((var_code).str()))))) {
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'), rt.create_array([rt.ArrayItem{ key: 'post_title', val: var_code }]), rt.create_array([rt.ArrayItem{ key: 'ID', val: var_coupon_id }]), rt.create_array([rt.ArrayItem{ key: none, val: '%s' }]), rt.create_array([rt.ArrayItem{ key: none, val: '%d' }])])
			rt.call_function('clean_post_cache', [rt.new_int(var_coupon_id).clone()])
			mut iife_temp_33 := Class_WC_Cache_Helper{}
			mut iife_result_33 := iife_temp_33.get_cache_prefix(rt.new_string('coupons'))
			mut iife_temp_34 := Class_WC_Cache_Helper{}
			mut iife_result_34 := iife_temp_34.get_cache_prefix(rt.new_string('coupons'))
			rt.call_function('wp_cache_delete', [rt.new_string((iife_result_33).str() + 'coupon_id_from_code_' + (var_data_shadow['post_title']).str()), rt.new_string('coupons')])
		}
	}
	if var_coupon_id != 0 {
		return (rt.call_function('update_option', [rt.new_string('woocommerce_update_450_last_coupon_id'), rt.new_int(var_coupon_id).clone()])).to_bool()
	}
	rt.call_function('delete_option', [rt.new_string('woocommerce_update_450_last_coupon_id')])
	return false
}

fn wc_update_500_fix_product_review_count() bool {
	mut var_wpdb := rt.new_null()
	mut var_product_id := i64(0)
	mut var_last_product_id := rt.new_null()
	mut var_products_data := rt.new_null()
	mut var_product_ids_to_check := rt.new_null()
	mut var_actual_review_counts := rt.new_null()
	mut var_product_data := map[string]rt.PhpVal{}
	mut var_current_review_count := i64(0)
	var_product_id = 0
	var_last_product_id = rt.call_function('get_option', [rt.new_string('woocommerce_update_500_last_product_id'), rt.new_string('0')])
	var_products_data = rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT post_id, meta_value\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\t\t\tJOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\t\t\tON ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.post_id = ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID\n\t\t\t\tWHERE\n\t\t\t\t\tpost_type = \'product\'\n\t\t\t\t\tAND post_status = \'publish\'\n\t\t\t\t\tAND post_id > %d\n\t\t\t\t\tAND meta_key = \'_wc_review_count\'\n\t\t\t\tORDER BY post_id ASC\n\t\t\t\tLIMIT 10\n\t\t\t')), var_last_product_id.clone()]), rt.get_constant('ARRAY_A')])
	if !rt.is_true(var_products_data) {
		rt.call_function('delete_option', [rt.new_string('woocommerce_update_500_last_product_id')])
		return false
	}
	var_product_ids_to_check = rt.call_function('array_column', [var_products_data.clone(), rt.new_string('post_id')])
	mut iife_temp_35 := Class_WC_Comments{}
	mut iife_result_35 := iife_temp_35.get_review_counts_for_product_ids(var_product_ids_to_check.clone())
	var_actual_review_counts = iife_result_35
	mut iter_36 := var_products_data.iterator()
	for {
		item_36 := iter_36.next() or { break }
		mut var_product_data_shadow := item_36.val
		var_product_id = var_product_data_shadow['post_id'].to_i64()
		var_current_review_count = var_product_data_shadow['meta_value'].to_i64()
		if rt.is_true(rt.new_bool(var_actual_review_counts.array_get(rt.new_int(var_product_id)).to_i64() != var_current_review_count)) {
		mut iife_temp_36 := Class_WC_Comments{}
		mut iife_result_36 := iife_temp_36.clear_transients(rt.new_int(var_product_id))
		}
	}
	if var_product_id != 0 {
		return (rt.call_function('update_option', [rt.new_string('woocommerce_update_500_last_product_id'), rt.new_int(var_product_id).clone()])).to_bool()
	}
	rt.call_function('delete_option', [rt.new_string('woocommerce_update_500_last_product_id')])
	return false
}

fn wc_update_500_db_version() {
mut iife_temp_37 := Class_WC_Install{}
mut iife_result_37 := iife_temp_37.update_db_version(rt.new_string('5.0.0'))
}

fn wc_update_560_create_refund_returns_page() rt.PhpVal {
fn filter_created_pages(var_pages rt.PhpVal) rt.PhpVal {
	mut var_page_to_create := []rt.PhpVal{}
	var_page_to_create = ['refund_returns']
	return rt.call_function('array_intersect_key', [var_pages.clone(), rt.call_function('array_flip', [rt.create_array_from_list(var_page_to_create)])])
}

fn wc_update_560_db_version() {
mut iife_temp_39 := Class_WC_Install{}
mut iife_result_39 := iife_temp_39.update_db_version(rt.new_string('5.6.0'))
}

fn wc_update_600_migrate_rate_limit_options() {
	mut var_wpdb := rt.new_null()
	mut var_rate_limits := rt.new_null()
	mut var_prefix_length := i64(0)
	mut var_rate_limit := map[string]rt.PhpVal{}
	mut var_new_delay := rt.new_null()
	mut var_action_id := rt.new_null()
	var_rate_limits = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT option_name, option_value\n\t\t\tFROM '), rt.get_property(var_wpdb, 'options')), rt.new_string('\n\t\t\tWHERE option_name LIKE \'woocommerce_rate_limit_add_payment_method_%\'\n\t\t')), rt.get_constant('ARRAY_A')])
	var_prefix_length = 'woocommerce_rate_limit_'.len
	mut iter_37 := var_rate_limits.iterator()
	for {
		item_37 := iter_37.next() or { break }
		mut var_rate_limit_shadow := item_37.val
		var_new_delay = rt.sub(rt.new_int((var_rate_limit_shadow['option_value']).to_i64()), rt.call_function('time', []rt.PhpVal{}))
		if rt.is_true(rt.less(rt.new_int(0), var_new_delay)) {
		var_action_id = rt.call_function('substr', [var_rate_limit_shadow['option_name'], rt.new_int(var_prefix_length).clone()])
		mut iife_temp_40 := Class_WC_Rate_Limiter{}
		mut iife_result_40 := iife_temp_40.set_rate_limit(var_action_id.clone(), var_new_delay.clone())
		}
		rt.call_function('delete_option', [var_rate_limit_shadow['option_name']])
	}
}

fn wc_update_600_db_version() {
mut iife_temp_41 := Class_WC_Install{}
mut iife_result_41 := iife_temp_41.update_db_version(rt.new_string('6.0.0'))
}

fn wc_update_630_create_product_attributes_lookup_table() bool {
	mut var_data_store := rt.new_null()
	mut var_data_regenerator := rt.new_null()
	var_data_store = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class()])
	var_data_regenerator = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator.class()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_data_store, 'check_lookup_table_exists', []rt.PhpVal{}))))) || (rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_data_store, 'lookup_table_has_data', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_data_store, 'regeneration_is_in_progress', []rt.PhpVal{})))))) {
		rt.call_method(var_data_regenerator, 'initiate_regeneration', []rt.PhpVal{})
	}
	return false
}

fn wc_update_630_db_version() {
mut iife_temp_42 := Class_WC_Install{}
mut iife_result_42 := iife_temp_42.update_db_version(rt.new_string('6.3.0'))
}

fn wc_update_640_add_primary_key_to_product_attributes_lookup_table() bool {
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator.class()]), 'create_table_primary_index', []rt.PhpVal{})
	return false
}

fn wc_update_640_db_version() {
mut iife_temp_43 := Class_WC_Install{}
mut iife_result_43 := iife_temp_43.update_db_version(rt.new_string('6.4.0'))
}

fn wc_update_650_approved_download_directories() {
	mut var_directory_sync := rt.new_null()
	var_directory_sync = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.class()])
	rt.call_method(var_directory_sync, 'init_hooks', []rt.PhpVal{})
	rt.call_method(var_directory_sync, 'init_feature', [rt.new_bool(true), rt.new_bool(false)])
}

fn wc_update_651_approved_download_directories() {
	mut var_wpdb := rt.new_null()
	mut var_download_directories := rt.new_null()
	mut var_directory_sync := rt.new_null()
	mut var_is_populated := rt.new_null()
	var_download_directories = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.class()])
	var_directory_sync = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.class()])
	var_is_populated = rt.new_bool((rt.call_method(var_wpdb, 'get_var', [rt.new_string('SELECT 1 FROM ' + (rt.call_method(var_download_directories, 'get_table', []rt.PhpVal{})).str() + ' LIMIT 1')])).to_bool())
	if rt.is_true(var_is_populated) || rt.is_true(rt.call_method(var_directory_sync, 'in_progress', []rt.PhpVal{})) {
		return
	}
	rt.call_method(var_directory_sync, 'init_hooks', []rt.PhpVal{})
	rt.call_method(var_directory_sync, 'init_feature', [rt.new_bool(true), rt.new_bool(false)])
}

fn wc_update_670_purge_comments_count_cache() {
	if !(rt.call_function('is_callable', [rt.new_string('WC_Comments::delete_comments_count_cache')])) {
		return
	}
mut iife_temp_44 := Class_WC_Comments{}
mut iife_result_44 := iife_temp_44.delete_comments_count_cache()
}

fn wc_update_700_remove_download_log_fk() {
	mut var_wpdb := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_create_table_sql := rt.new_null()
	mut var_foreign_key_name := rt.new_null()
	var_create_table_sql = rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SHOW CREATE TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_download_log')), rt.new_int(1)])
	if !(!rt.is_true(var_create_table_sql)) {
		if rt.is_true(rt.call_function('preg_match_all', [rt.new_string('/CONSTRAINT `([^`]*)` FOREIGN KEY/'), var_create_table_sql.clone(), rt.create_array_from_list(var_matches)])) && !(!rt.is_true(var_matches[1])) {
			mut iter_38 := var_matches[1].iterator()
			for {
				item_38 := iter_38.next() or { break }
				mut var_foreign_key_name_shadow := item_38.val
				rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_download_log DROP FOREIGN KEY `')), var_foreign_key_name_shadow), rt.new_string('`'))])
			}
		}
	}
}

fn wc_update_700_remove_recommended_marketing_plugins_transient() {
	rt.call_function('delete_transient', [rt.new_string('wc_marketing_recommended_plugins')])
}

fn wc_update_721_adjust_new_zealand_states() rt.PhpVal {
	mut iife_temp_45 := Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{}
	mut iife_result_45 := iife_temp_45.migrate_country_states(rt.new_string('NZ'), rt.create_array([rt.ArrayItem{ key: 'NL', val: 'NTL' }, rt.ArrayItem{ key: 'AK', val: 'AUK' }, rt.ArrayItem{ key: 'WA', val: 'WKO' }, rt.ArrayItem{ key: 'BP', val: 'BOP' }, rt.ArrayItem{ key: 'TK', val: 'TKI' }, rt.ArrayItem{ key: 'GI', val: 'GIS' }, rt.ArrayItem{ key: 'HB', val: 'HKB' }, rt.ArrayItem{ key: 'MW', val: 'MWT' }, rt.ArrayItem{ key: 'WE', val: 'WGN' }, rt.ArrayItem{ key: 'NS', val: 'NSN' }, rt.ArrayItem{ key: 'MB', val: 'MBH' }, rt.ArrayItem{ key: 'TM', val: 'TAS' }, rt.ArrayItem{ key: 'WC', val: 'WTC' }, rt.ArrayItem{ key: 'CT', val: 'CAN' }, rt.ArrayItem{ key: 'OT', val: 'OTA' }, rt.ArrayItem{ key: 'SL', val: 'STL' }]))
	return iife_result_45
}

fn wc_update_721_adjust_ukraine_states() rt.PhpVal {
	mut iife_temp_46 := Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{}
	mut iife_result_46 := iife_temp_46.migrate_country_states(rt.new_string('UA'), rt.create_array([rt.ArrayItem{ key: 'VN', val: 'UA05' }, rt.ArrayItem{ key: 'LH', val: 'UA09' }, rt.ArrayItem{ key: 'VL', val: 'UA07' }, rt.ArrayItem{ key: 'DP', val: 'UA12' }, rt.ArrayItem{ key: 'DT', val: 'UA14' }, rt.ArrayItem{ key: 'ZT', val: 'UA18' }, rt.ArrayItem{ key: 'ZK', val: 'UA21' }, rt.ArrayItem{ key: 'ZP', val: 'UA23' }, rt.ArrayItem{ key: 'IF', val: 'UA26' }, rt.ArrayItem{ key: 'KV', val: 'UA32' }, rt.ArrayItem{ key: 'KH', val: 'UA35' }, rt.ArrayItem{ key: 'LV', val: 'UA46' }, rt.ArrayItem{ key: 'MY', val: 'UA48' }, rt.ArrayItem{ key: 'OD', val: 'UA51' }, rt.ArrayItem{ key: 'PL', val: 'UA53' }, rt.ArrayItem{ key: 'RV', val: 'UA56' }, rt.ArrayItem{ key: 'SM', val: 'UA59' }, rt.ArrayItem{ key: 'TP', val: 'UA61' }, rt.ArrayItem{ key: 'KK', val: 'UA63' }, rt.ArrayItem{ key: 'KS', val: 'UA65' }, rt.ArrayItem{ key: 'KM', val: 'UA68' }, rt.ArrayItem{ key: 'CK', val: 'UA71' }, rt.ArrayItem{ key: 'CH', val: 'UA74' }, rt.ArrayItem{ key: 'CV', val: 'UA77' }]))
	return iife_result_46
}

fn wc_update_722_adjust_new_zealand_states() rt.PhpVal {
	return wc_update_721_adjust_new_zealand_states()
}

fn wc_update_722_adjust_ukraine_states() rt.PhpVal {
	return wc_update_721_adjust_ukraine_states()
}

fn wc_update_750_add_columns_to_order_stats_table() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats AS order_stats\n\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS postmeta\n\t\t\tON postmeta.post_id = order_stats.order_id\n\t\t\tand postmeta.meta_key = \'_date_paid\'\n\t\tSET order_stats.date_paid = IFNULL(FROM_UNIXTIME(postmeta.meta_value), \'0000-00-00 00:00:00\');'))])
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats AS order_stats\n\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS postmeta\n\t\t\tON postmeta.post_id = order_stats.order_id\n\t\t\tand postmeta.meta_key = \'_date_completed\'\n\t\tSET order_stats.date_completed = IFNULL(FROM_UNIXTIME(postmeta.meta_value), \'0000-00-00 00:00:00\');'))])
}

fn wc_update_750_disable_new_product_management_experience() {
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_new_product_management_enabled')]))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_new_product_management_enabled'), rt.new_string('no')])
	}
}

fn wc_update_770_remove_multichannel_marketing_feature_options() {
	rt.call_function('delete_option', [rt.new_string('woocommerce_multichannel_marketing_enabled')])
	rt.call_function('delete_option', [rt.new_string('woocommerce_marketing_overview_welcome_hidden')])
}

fn wc_update_790_blockified_product_grid_block() {
	rt.call_function('update_option', [Class_Automattic_WooCommerce_Blocks_Options.wc_block_use_blockified_product_grid_block_as_template(), rt.call_function('wc_bool_to_string', [rt.new_bool(false)])])
}

fn wc_update_810_migrate_transactional_metadata_for_hpos() bool {
	mut var_wpdb := rt.new_null()
	mut var_data_synchronizer := rt.new_null()
	mut var_orders_table := rt.new_null()
	mut var_orders_meta_table := rt.new_null()
	mut var_select_query := ''
	mut var_query := ''
	mut var_has_pending := rt.new_null()
	var_data_synchronizer = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.class()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_data_synchronizer, 'get_table_exists', []rt.PhpVal{}))))) {
		return false
	}
	mut iife_temp_47 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
	mut iife_result_47 := iife_temp_47.get_orders_table_name()
	var_orders_table = iife_result_47
	mut iife_temp_48 := Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{}
	mut iife_result_48 := iife_temp_48.get_meta_table_name()
	var_orders_meta_table = iife_result_48
	var_select_query = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\nSELECT post_id, \'_payment_tokens\', '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.meta_value\nFROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\nJOIN ')), var_orders_table), rt.new_string(' ON ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.post_id = ')), var_orders_table), rt.new_string('.id\nLEFT JOIN ')), var_orders_meta_table), rt.new_string(' ON ')), var_orders_meta_table), rt.new_string('.order_id = ')), var_orders_table), rt.new_string('.id AND ')), var_orders_meta_table), rt.new_string('.meta_key = \'_payment_tokens\'\nWHERE\n\t')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.meta_key = \'_payment_tokens\'\n\tAND ')), var_orders_meta_table), rt.new_string('.order_id IS NULL\n\t'))
	var_query = "\nINSERT INTO ${var_orders_meta_table.to_string()} (order_id, meta_key, meta_value)\n${var_select_query}\nLIMIT 250\n"
	rt.call_method(var_wpdb, 'query', [rt.new_string((var_query).str()).clone()])
	var_has_pending = rt.call_method(var_wpdb, 'query', [rt.new_string("${var_select_query} LIMIT 1;")])
	return !(!rt.is_true(var_has_pending))
}

fn wc_update_830_rename_checkout_template() {
	mut var_template := rt.new_null()
	var_template = rt.call_function('get_block_template', [rt.new_string((Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.plugin_slug()).str() + '//checkout'), rt.new_string('wp_template')])
	if rt.is_true(var_template) && !(!rt.is_true(rt.get_property(var_template, 'wp_id'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_POST_REVISIONS')]))))) {
			rt.call_function('define', [rt.new_string('WP_POST_REVISIONS'), rt.new_bool(false)])
		}
		rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_template, 'wp_id') }, rt.ArrayItem{ key: 'post_name', val: 'page-checkout' }])])
	}
}

fn wc_update_830_rename_cart_template() {
	mut var_template := rt.new_null()
	var_template = rt.call_function('get_block_template', [rt.new_string((Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.plugin_slug()).str() + '//cart'), rt.new_string('wp_template')])
	if rt.is_true(var_template) && !(!rt.is_true(rt.get_property(var_template, 'wp_id'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_POST_REVISIONS')]))))) {
			rt.call_function('define', [rt.new_string('WP_POST_REVISIONS'), rt.new_bool(false)])
		}
		rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_template, 'wp_id') }, rt.ArrayItem{ key: 'post_name', val: 'page-cart' }])])
	}
}

fn wc_update_860_remove_recommended_marketing_plugins_transient() {
	rt.call_function('delete_transient', [rt.new_string('wc_marketing_recommended_plugins')])
}

fn wc_update_870_prevent_listing_of_transient_files_directory() {
	mut var_wp_filesystem := rt.new_null()
	mut var_default_transient_files_dir := rt.new_null()
	var_default_transient_files_dir = rt.new_string((rt.call_function('untrailingslashit', [rt.call_function('wp_upload_dir', []rt.PhpVal{}).array_get(rt.new_string('basedir'))])).str() + '/woocommerce_transient_files')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_default_transient_files_dir.clone()]))))) {
		return
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	rt.call_function('WP_Filesystem', []rt.PhpVal{})
	rt.call_method(var_wp_filesystem, 'put_contents', [rt.new_string((var_default_transient_files_dir).str() + '/.htaccess'), rt.new_string('deny from all')])
	rt.call_method(var_wp_filesystem, 'put_contents', [rt.new_string((var_default_transient_files_dir).str() + '/index.html'), rt.new_string('')])
}

fn wc_update_890_update_connect_to_woocommerce_note() {
	mut var_note := rt.new_null()
	mut iife_temp_49 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_49 := iife_temp_49.get_note_by_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.connection_note_name())
	var_note = iife_result_49
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_note.clone(), rt.new_string('Automattic\\WooCommerce\\Admin\\Notes\\Note')]))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.call_method(var_note, 'get_title', []rt.PhpVal{}), rt.new_string('Woo.com')]))))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_note, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_snoozed())))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_note, 'get_status', []rt.PhpVal{}), Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned())))) {
		return
	}
mut iife_temp_50 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
mut iife_result_50 := iife_temp_50.delete_notes_with_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.connection_note_name())
}

fn wc_update_890_update_paypal_standard_load_eligibility() {
	mut var_paypal := rt.new_null()
	mut iife_temp_51 := Class_WC_Gateway_Paypal{}
	mut iife_result_51 := iife_temp_51.get_instance()
	var_paypal = if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Gateway_Paypal')])) { iife_result_51 } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_paypal)))) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_paypal, 'enabled'))) || rt.is_true(rt.identical(rt.new_string('yes'), rt.call_method(var_paypal, 'get_option', [rt.new_string('_should_load')]))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_paypal, 'get_option', [rt.new_string('api_username')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_paypal, 'has_paypal_orders', []rt.PhpVal{}))))) {
		rt.call_method(var_paypal, 'update_option', [rt.new_string('_should_load'), rt.call_function('wc_bool_to_string', [rt.new_bool(false)])])
	}
}

fn wc_update_891_create_plugin_autoinstall_history_option() {
	mut var_autoinstalled_plugins_history_info := rt.new_null()
	mut var_autoinstalled_plugins_info := rt.new_null()
	var_autoinstalled_plugins_history_info = rt.call_function('get_site_option', [rt.new_string('woocommerce_history_of_autoinstalled_plugins')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_autoinstalled_plugins_history_info)) {
		var_autoinstalled_plugins_info = rt.call_function('get_site_option', [rt.new_string('woocommerce_autoinstalled_plugins')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_autoinstalled_plugins_info)))) {
			rt.call_function('update_site_option', [rt.new_string('woocommerce_history_of_autoinstalled_plugins'), var_autoinstalled_plugins_info.clone()])
		}
	}
}

fn wc_update_910_add_launch_your_store_tour_option() {
	rt.call_function('add_option', [rt.new_string('woocommerce_show_lys_tour'), rt.new_string('yes')])
}

fn wc_update_920_add_wc_hooked_blocks_version_option() {
	mut var_option_name := ''
	mut var_option_value := rt.new_null()
	mut var_theme_include_list := rt.new_null()
	mut var_active_theme_name := rt.new_null()
	mut var_should_set_hooked_blocks_version := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('block-template-parts')]))))) {
		return
	}
	var_option_name = 'woocommerce_hooked_blocks_version'
	var_option_value = rt.call_function('get_option', [rt.new_string((var_option_name).str()).clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_option_value)))) {
		return
	}
	var_theme_include_list = rt.call_function('apply_filters', [rt.new_string('woocommerce_hooked_blocks_theme_include_list'), rt.create_array([rt.ArrayItem{ key: none, val: 'Twenty Twenty-Four' }, rt.ArrayItem{ key: none, val: 'Twenty Twenty-Three' }, rt.ArrayItem{ key: none, val: 'Twenty Twenty-Two' }, rt.ArrayItem{ key: none, val: 'Tsubaki' }, rt.ArrayItem{ key: none, val: 'Zaino' }, rt.ArrayItem{ key: none, val: 'Thriving Artist' }, rt.ArrayItem{ key: none, val: 'Amulet' }, rt.ArrayItem{ key: none, val: 'Tazza' }])])
	var_active_theme_name = rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}), 'get', [rt.new_string('Name')])
	var_should_set_hooked_blocks_version = rt.call_function('in_array', [var_active_theme_name.clone(), var_theme_include_list.clone(), rt.new_bool(true)])
	if rt.is_true(var_should_set_hooked_blocks_version) {
		rt.call_function('add_option', [rt.new_string((var_option_name).str()).clone(), rt.new_string('8.4.0')])
	} else {
		rt.call_function('add_option', [rt.new_string((var_option_name).str()).clone(), rt.new_string('no')])
	}
}

fn wc_update_910_remove_obsolete_user_meta() {
	mut var_wpdb := rt.new_null()
	mut var_deletions := rt.new_null()
	mut var_logger := rt.new_null()
	var_deletions = rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('\n\t\tDELETE FROM '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string('\n\t\tWHERE meta_key IN (\n\t\t\t\'_last_order\',\n\t\t\t\'_order_count\',\n\t\t\t\'_money_spent\'\n\t\t)\n\t'))])
	var_logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_null(), var_logger)) {
		return
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_deletions)) {
		rt.call_method(var_logger, 'notice', [rt.new_string('During the update to 9.1.0, WooCommerce attempted to remove user meta with the keys "_last_order", "_order_count" and "_money_spent" but was unable to do so.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
	} else {
		rt.call_method(var_logger, 'info', [rt.call_function('sprintf', [rt.new_string((if rt.is_true(rt.identical(rt.new_int(1), var_deletions)) { 'During the update to 9.1.0, WooCommerce removed %d user meta row associated with the meta keys "_last_order", "_order_count" or "_money_spent".' } else { 'During the update to 9.1.0, WooCommerce removed %d user meta rows associated with the meta keys "_last_order", "_order_count" or "_money_spent".' }).str()), rt.call_function('number_format_i18n', [var_deletions.clone()])]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
	}
}

fn wc_update_930_add_woocommerce_coming_soon_option() {
	rt.call_function('add_option', [rt.new_string('woocommerce_coming_soon'), rt.new_string('no')])
}

fn wc_update_930_migrate_user_meta_for_launch_your_store_tour() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string('\n\t\t\tSET meta_key = %s\n\t\t\tWHERE meta_key = %s')), rt.new_string('woocommerce_admin_launch_your_store_tour_hidden'), rt.new_string('woocommerce_launch_your_store_tour_hidden')])])
	rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string('\n\t\t\tSET meta_key = %s\n\t\t\tWHERE meta_key = %s')), rt.new_string('woocommerce_admin_coming_soon_banner_dismissed'), rt.new_string('woocommerce_coming_soon_banner_dismissed')])])
}

fn wc_update_940_add_phone_to_order_address_fts_index() {
	mut var_fts_already_exists := false
	mut var_hpos_controller := rt.new_null()
	mut var_result := rt.new_null()
	var_fts_already_exists = (rt.identical(rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.hpos_fts_address_index_created_option()]), rt.new_string('yes'))).to_bool()
	if !(var_fts_already_exists) {
		return
	}
	var_hpos_controller = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class()])
	var_result = rt.call_method(var_hpos_controller, 'recreate_order_address_fts_index', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result.array_get(rt.new_string('status')))))) {
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Settings ')])) {
		mut iife_temp_52 := Class_WC_Admin_Settings{}
		mut iife_result_52 := iife_temp_52.add_error(var_result.array_get(rt.new_string('message')))
		}
	}
}

fn wc_update_940_remove_help_panel_highlight_shown() {
	mut var_wpdb := rt.new_null()
	mut var_meta_key := ''
	mut var_deletions := rt.new_null()
	mut var_logger := rt.new_null()
	var_meta_key = 'woocommerce_admin_help_panel_highlight_shown'
	var_deletions = rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string(' WHERE meta_key = %s')), rt.new_string((var_meta_key).str()).clone()])])
	var_logger = rt.call_function('wc_get_logger', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_null(), var_logger)) {
		return
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_deletions)) {
		rt.call_method(var_logger, 'notice', [rt.new_string('During the update to 9.4.0, WooCommerce attempted to remove user meta with the key "woocommerce_admin_help_panel_highlight_shown", but was unable to do so.'), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
	} else {
		rt.call_method(var_logger, 'info', [rt.call_function('sprintf', [rt.new_string((if rt.is_true(rt.identical(rt.new_int(1), var_deletions)) { 'During the update to 9.4.0, WooCommerce removed %d user meta row associated with the meta key "woocommerce_admin_help_panel_highlight_shown".' } else { 'During the update to 9.4.0, WooCommerce removed %d user meta rows associated with the meta key "woocommerce_admin_help_panel_highlight_shown".' }).str()), rt.call_function('number_format_i18n', [var_deletions.clone()])]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-updater' }])])
	}
}

fn wc_update_1000_multisite_visibility_setting() {
	mut var_existing_site_option := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return
	}
	var_existing_site_option = rt.call_function('get_site_option', [rt.new_string('woocommerce_network_wide_customers'), rt.new_string('')])
	if var_existing_site_option.clone().is_string() && var_existing_site_option.clone().to_string().len > 0 {
		return
	}
	rt.call_function('update_site_option', [rt.new_string('woocommerce_network_wide_customers'), rt.new_string('yes')])
}

fn wc_update_950_tracking_option_autoload() {
	mut var_options := map[string]rt.PhpVal{}
	var_options = { 'woocommerce_allow_tracking': 'yes' }
	rt.call_function('wp_set_option_autoload_values', [rt.create_array_from_native_map(var_options)])
}

fn wc_update_961_migrate_default_email_base_color() {
	mut var_color := rt.new_null()
	var_color = rt.call_function('get_option', [rt.new_string('woocommerce_email_base_color')])
	if rt.is_true(rt.identical(rt.new_string('#7f54b3'), var_color)) {
		rt.call_function('update_option', [rt.new_string('woocommerce_email_base_color'), rt.new_string('#720eec')])
	}
}

fn wc_update_1020_add_old_refunded_order_items_to_product_lookup_table() {
	mut var_wpdb := rt.new_null()
	mut var_refunded_orders := rt.new_null()
	mut var_refunded_order := rt.new_null()
	mut var_order := rt.new_null()
	var_refunded_orders = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT order_stats.order_id, order_stats.num_items_sold\n\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_order_stats AS order_stats\n\t\tWHERE order_stats.total_sales < 0 # Refunded orders\n\t\t\tAND order_stats.total_sales != order_stats.shipping_total # Exclude refunded orders that only include a shipping refund\n\t\t\tAND order_stats.total_sales != order_stats.tax_total # Exclude refunded orders that only include a tax refund'))])
	if rt.is_true(var_refunded_orders) {
		rt.call_function('update_option', [rt.new_string('woocommerce_analytics_uses_old_full_refund_data'), rt.new_string('yes')])
		mut iter_39 := var_refunded_orders.iterator()
		for {
			item_39 := iter_39.next() or { break }
			mut var_refunded_order_shadow := item_39.val
			if rt.get_property(var_refunded_order_shadow, 'num_items_sold').to_i64() == 0 {
				var_order = rt.call_function('wc_get_order', [rt.get_property(var_refunded_order_shadow, 'order_id')])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
					continue
				}
				if !rt.is_true(rt.call_method(var_order, 'get_items', []rt.PhpVal{})) {
					rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'info', [rt.call_function('sprintf', [rt.new_string('Setting refund type to full for order_id: %s'), rt.get_property(var_refunded_order_shadow, 'order_id')])])
					rt.call_method(var_order, 'update_meta_data', [rt.new_string('_refund_type'), rt.new_string('full')])
					rt.call_method(var_order, 'save_meta_data', []rt.PhpVal{})
				}
			}
		}
	}
}

fn wc_update_980_remove_order_attribution_install_banner_dismissed_option() {
	rt.call_function('delete_option', [rt.new_string('woocommerce_order_attribution_install_banner_dismissed')])
}

fn wc_update_985_enable_new_payments_settings_page_feature() {
	rt.call_function('update_option', [rt.new_string('woocommerce_feature_reactify-classic-payments-settings_enabled'), rt.new_string('yes')])
}

fn wc_update_990_remove_wc_count_comments_transient() {
	rt.call_function('delete_transient', [rt.new_string('wc_count_comments')])
}

fn wc_update_990_remove_email_notes() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'delete', [rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_admin_notes'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'email' }]), rt.create_array([rt.ArrayItem{ key: none, val: '%s' }])])
}

fn wc_update_1000_remove_patterns_toolkit_transient() {
	rt.call_function('delete_transient', [rt.new_string('ptk_patterns')])
}

fn wc_update_1030_add_comments_date_type_index() {
	mut var_wpdb := rt.new_null()
	mut var_date_type_index_exists := rt.new_null()
	var_date_type_index_exists = rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.new_string('SHOW INDEX FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE key_name = \'woo_idx_comment_date_type\''))])
	if rt.is_true(rt.new_bool(var_date_type_index_exists.clone().is_null())) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' ADD INDEX woo_idx_comment_date_type (comment_date_gmt, comment_type, comment_approved, comment_post_ID)'))])
	}
}

fn wc_update_1040_cleanup_legacy_ptk_patterns_fetching() {
	rt.call_function('delete_option', [rt.new_string('last_fetch_patterns_request')])
	rt.call_function('as_unschedule_all_actions', [rt.new_string('fetch_patterns')])
}

fn wc_update_1050_migrate_brand_permalink_setting() {
	mut var_shop_page_id := rt.new_null()
	mut var_shop_slug := rt.new_null()
	mut var_slug := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prepend_shop_page_to_urls')]))))) {
		return
	}
	var_shop_page_id = rt.call_function('wc_get_page_id', [rt.new_string('shop')])
	var_shop_slug = if rt.is_true(rt.greater(var_shop_page_id, rt.new_int(0))) && rt.is_true(rt.call_function('get_post', [var_shop_page_id.clone()])) { rt.call_function('get_page_uri', [var_shop_page_id.clone()]) } else { rt.new_string('shop') }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_shop_slug)))) {
		return
	}
	var_slug = rt.new_string((rt.call_function('trailingslashit', [var_shop_slug.clone()])).str() + (rt.call_function('__', [rt.new_string('brand'), rt.new_string('woocommerce')])).str())
	rt.call_function('update_option', [rt.new_string('woocommerce_brand_permalink'), var_slug.clone()])
}

fn wc_update_1050_enable_autoload_options() {
	mut var_wpdb := rt.new_null()
	mut var_autoload_options := []rt.PhpVal{}
	mut var_feature_options := map[string]rt.PhpVal{}
	mut var_features_controller := rt.new_null()
	mut var_option := rt.new_null()
	mut var_key := rt.new_null()
	mut var_placeholders := rt.new_null()
	var_autoload_options = [rt.new_string('woocommerce_myaccount_page_id'), rt.new_string('woocommerce_cart_page_id'), rt.new_string('woocommerce_checkout_page_id'), rt.new_string('woocommerce_terms_page_id'), rt.new_string('woocommerce_show_marketplace_suggestions'), rt.new_string('woocommerce_enable_delayed_account_creation'), rt.new_string('wc_feature_woocommerce_brands_enabled'), rt.new_string('wc_connect_taxes_enabled'), rt.new_string('woocommerce_logs_logging_enabled'), rt.new_string('woocommerce_email_improvements_existing_store_enabled'), rt.new_string('woocommerce_custom_orders_table_data_sync_enabled')]
	var_feature_options = { 'fulfillments': 'woocommerce_feature_fulfillments_enabled', 'push_notifications': 'woocommerce_feature_push_notifications_enabled', 'agentic_checkout': 'woocommerce_feature_agentic_checkout_enabled', 'cart_checkout_blocks': 'woocommerce_feature_cart_checkout_blocks_enabled' }
	var_features_controller = rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Features_FeaturesController.class()])
	for var_key_shadow, var_option_shadow in var_feature_options {
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_option', [rt.new_string((var_option_shadow).str()).clone(), rt.new_bool(false)]))) {
			rt.call_function('add_option', [rt.new_string((var_option_shadow).str()).clone(), rt.call_function('wc_bool_to_string', [rt.call_method(var_features_controller, 'feature_is_enabled', [rt.new_string((var_key_shadow).str()).clone()])]), rt.new_string(''), rt.new_bool(true)])
		} else {
			var_autoload_options << rt.new_string((var_option_shadow).str()).clone()
		}
	}
	var_placeholders = rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_autoload_options.len), rt.new_string('%s')])])
	rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'options')), rt.new_string(' SET autoload = \'on\' WHERE option_name IN (')), var_placeholders), rt.new_string(')')), rt.create_array_from_list(var_autoload_options)])])
}

fn wc_update_1050_remove_deprecated_marketplace_option() {
	rt.call_function('delete_option', [rt.new_string('woocommerce_feature_marketplace_enabled')])
}

fn wc_update_1060_add_woo_idx_comment_approved_type_index() {
	mut var_wpdb := rt.new_null()
	mut var_comment_approved_type_index_exists := rt.new_null()
	var_comment_approved_type_index_exists = rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.new_string('SHOW INDEX FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE key_name = \'woo_idx_comment_approved_type\''))])
	if rt.is_true(rt.identical(rt.new_null(), var_comment_approved_type_index_exists)) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' ADD INDEX woo_idx_comment_approved_type (comment_approved, comment_type, comment_post_ID)'))])
	}
}

fn wc_update_1070_disable_hpos_sync_on_read() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_custom_orders_table_enabled')]))))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_custom_orders_table_data_sync_enabled')]))))) {
		return
	}
mut iife_temp_53 := Class_WC_Admin_Notices{}
mut iife_result_53 := iife_temp_53.add_notice(rt.new_string('hpos_sync_on_read_disabled'))
}

fn wc_update_1080_migrate_analytics_import_option() {
	mut var_legacy_option := ''
	mut var_new_option := ''
	mut var_legacy_value := rt.new_null()
	mut var_new_value := ''
	var_legacy_option = 'woocommerce_analytics_immediate_import'
	var_new_option = 'woocommerce_analytics_scheduled_import'
	var_legacy_value = rt.call_function('get_option', [rt.new_string((var_legacy_option).str()).clone(), rt.new_bool(false)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_legacy_value)) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_option', [rt.new_string((var_new_option).str()).clone(), rt.new_bool(false)]))))) {
		rt.call_function('delete_option', [rt.new_string((var_legacy_option).str()).clone()])
		return
	}
	var_new_value = if rt.is_true(rt.identical(rt.new_string('no'), var_legacy_value)) { 'yes' } else { 'no' }
	if rt.is_true(rt.call_function('add_option', [rt.new_string((var_new_option).str()).clone(), rt.new_string((var_new_value).str()).clone()])) {
		rt.call_function('delete_option', [rt.new_string((var_legacy_option).str()).clone()])
	}
}

fn wc_update_10802_restore_orders_meta_key_value_index() {
	mut var_wpdb := rt.new_null()
	mut var_table_name := rt.new_null()
	mut var_index_name := ''
	mut var_columns := rt.new_null()
	mut var_already_correct := false
	var_table_name = rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'wc_orders_meta')
	var_index_name = 'meta_key_value'
	var_columns = rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('SHOW INDEX FROM ' + (var_table_name).str() + ' WHERE Key_name = %s'), rt.new_string((var_index_name).str()).clone()])])
	var_already_correct = var_columns.clone().is_array() && 2 == var_columns.clone().array_count() && rt.is_true(rt.identical(rt.new_string('meta_key'), rt.get_property(var_columns.array_get(rt.new_int(0)), 'Column_name'))) && 50 == rt.new_int((rt.get_property(var_columns.array_get(rt.new_int(0)), 'Sub_part')).to_i64()) && rt.is_true(rt.identical(rt.new_string('meta_value'), rt.get_property(var_columns.array_get(rt.new_int(1)), 'Column_name'))) && 20 == rt.new_int((rt.get_property(var_columns.array_get(rt.new_int(1)), 'Sub_part')).to_i64())
	if var_already_correct {
		return
	}
	if !rt.is_true(var_columns) {
		rt.call_method(var_wpdb, 'query', [rt.new_string("ALTER TABLE ${var_table_name.to_string()} ADD INDEX ${var_index_name} (meta_key(50), meta_value(20))")])
	} else {
		rt.call_method(var_wpdb, 'query', [rt.new_string("ALTER TABLE ${var_table_name.to_string()} DROP INDEX ${var_index_name}, ADD INDEX ${var_index_name} (meta_key(50), meta_value(20))")])
	}
}

fn wc_update_1080_backfill_email_template_sync_meta() bool {
	mut iife_temp_54 := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill{}
	mut iife_result_54 := iife_temp_54.run()
	return (iife_result_54).to_bool()
}

struct Class_WC_Install {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Legacy_Flat_Rate {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Legacy_International_Delivery {
	rt.PhpObjectBase
}

struct Class_WC_Webhook {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Notices {
	rt.PhpObjectBase
}

struct Class_WP_Roles {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_DataController {
	rt.PhpObjectBase
}

struct Class_WC_Comments {
	rt.PhpObjectBase
}

struct Class_WC_Rate_Limiter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

struct Class_WC_Gateway_Paypal {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill {
	rt.PhpObjectBase
}

fn create_wc_install(_args ...rt.PhpVal) &Class_WC_Install {
	mut obj := &Class_WC_Install{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_legacy_flat_rate(_args ...rt.PhpVal) &Class_WC_Shipping_Legacy_Flat_Rate {
	mut obj := &Class_WC_Shipping_Legacy_Flat_Rate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_legacy_international_delivery(_args ...rt.PhpVal) &Class_WC_Shipping_Legacy_International_Delivery {
	mut obj := &Class_WC_Shipping_Legacy_International_Delivery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_webhook(_args ...rt.PhpVal) &Class_WC_Webhook {
	mut obj := &Class_WC_Webhook{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_notices(_args ...rt.PhpVal) &Class_WC_Admin_Notices {
	mut obj := &Class_WC_Admin_Notices{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_roles(_args ...rt.PhpVal) &Class_WP_Roles {
	mut obj := &Class_WP_Roles{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_datacontroller(_args ...rt.PhpVal) &Class_ActionScheduler_DataController {
	mut obj := &Class_ActionScheduler_DataController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_comments(_args ...rt.PhpVal) &Class_WC_Comments {
	mut obj := &Class_WC_Comments{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rate_limiter(_args ...rt.PhpVal) &Class_WC_Rate_Limiter {
	mut obj := &Class_WC_Rate_Limiter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_database_migrations_migrationhelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper {
	mut obj := &Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_datastores_orders_orderstabledatastore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_gateway_paypal(_args ...rt.PhpVal) &Class_WC_Gateway_Paypal {
	mut obj := &Class_WC_Gateway_Paypal{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_settings(_args ...rt.PhpVal) &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wcemailtemplatesyncbackfill(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Install) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Install) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Install) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Legacy_Flat_Rate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Shipping_Legacy_International_Delivery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Legacy_International_Delivery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Legacy_International_Delivery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Webhook) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Webhook) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Webhook) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_Notices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Notices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Notices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Roles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Roles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Roles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_DataController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_DataController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_DataController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Comments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Comments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Comments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Rate_Limiter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Rate_Limiter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Rate_Limiter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Database_Migrations_MigrationHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_DataStores_Orders_OrdersTableDataStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Gateway_Paypal) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Gateway_Paypal) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Gateway_Paypal) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncBackfill) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	rt.call_function('add_filter', [rt.new_string('woocommerce_create_pages'), rt.new_string('filter_created_pages')])
	mut iife_temp_38 := Class_WC_Install{}
	mut iife_result_38 := iife_temp_38.create_pages()
	rt.call_function('remove_filter', [rt.new_string('woocommerce_create_pages'), rt.new_string('filter_created_pages')])
	return rt.new_null()
}

}
