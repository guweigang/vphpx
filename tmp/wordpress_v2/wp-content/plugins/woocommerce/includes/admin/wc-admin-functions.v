import rt

fn wc_get_screen_ids() rt.PhpVal {
	mut var_wc_screen_id := ''
	mut var_screen_ids := []rt.PhpVal{}
	mut var_type := rt.new_null()
	mut var_attributes := rt.new_null()
	mut var_attribute := rt.new_null()
	var_wc_screen_id = 'woocommerce'
	var_screen_ids = ['toplevel_page_' + var_wc_screen_id, var_wc_screen_id + '_page_wc-orders',
		var_wc_screen_id + '_page_wc-reports', var_wc_screen_id + '_page_wc-shipping',
		
			var_wc_screen_id + '_page_wc-settings', var_wc_screen_id + '_page_wc-status',
		
			var_wc_screen_id + '_page_wc-addons', rt.new_string('toplevel_page_wc-reports'),
		rt.new_string('product_page_product_attributes'), rt.new_string('product_page_product_exporter'),
		rt.new_string('product_page_product_importer'), rt.new_string('product_page_product-reviews'),
		rt.new_string('edit-product'), rt.new_string('product'),
		rt.new_string('edit-shop_coupon'), rt.new_string('shop_coupon'),
		rt.new_string('edit-product_cat'), rt.new_string('edit-product_tag'),
		rt.new_string('edit-product-brand'), rt.new_string('profile'),
		rt.new_string('user-edit')]
	mut iter_1 := rt.call_function('wc_get_order_types', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_type_shadow := item_1.val
		var_screen_ids << var_type_shadow.clone()
		var_screen_ids << 'edit-' + var_type_shadow.str()
		var_screen_ids << wc_get_page_screen_id(var_type_shadow.clone())
	}
	var_attributes = rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	if rt.is_true(var_attributes) {
		mut iter_2 := var_attributes.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_attribute_shadow := item_2.val
			var_screen_ids << 'edit-' +(rt.call_function('wc_attribute_taxonomy_name', [rt.get_property(var_attribute_shadow, 'attribute_name')])).str()
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_screen_ids'),
		rt.create_array_from_list(var_screen_ids)])
	return rt.new_null()
}

fn wc_get_page_screen_id(var_for_arg rt.PhpVal) rt.PhpVal {
	mut var_for := var_for_arg
	mut var_screen_id := rt.new_null()
	var_screen_id = rt.new_string('')
	var_for = rt.call_function('str_replace', [rt.new_string('-'),
		rt.new_string('_'), var_for.clone()])
	if rt.is_true(rt.call_function('in_array', [var_for.clone(),
		rt.call_function('wc_get_order_types', [rt.new_string('admin-menu')]),
		rt.new_bool(true)]))
	{
		mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
		mut iife_result_0 := iife_temp_0.custom_orders_table_usage_is_enabled()
		if rt.is_true(iife_result_0) {
			mut iife_temp_1 := Class_WC_Admin_Menus{}
			mut iife_result_1 := iife_temp_1.can_view_woocommerce_menu_item()
			var_screen_id = rt.new_string((
				if rt.is_true(iife_result_1) { 'woocommerce_page_wc-orders' } else { 'admin_page_wc-orders' } +
				if rt.is_true(rt.identical(rt.new_string('shop_order'), var_for)) { '' } else { '--' +
				var_for.str() }).str())
		} else {
			var_screen_id = var_for.clone()
		}
	}
	return var_screen_id.clone()
}

fn wc_create_page(var_slug rt.PhpVal, option string, page_title string, page_content string, post_parent i64, post_status string) rt.PhpVal {
	mut var_option := option
	mut var_page_title := page_title
	mut var_page_content := page_content
	mut var_post_parent := post_parent
	mut var_post_status := post_status
	mut var_wpdb := rt.new_null()
	mut var_option_value := rt.new_null()
	mut var_page_object := rt.new_null()
	mut var_shortcode := rt.new_null()
	mut var_valid_page_found := rt.new_null()
	mut var_trashed_page_found := rt.new_null()
	mut var_page_id := rt.new_null()
	mut var_page_data := map[string]rt.PhpVal{}
	var_option_value = rt.call_function('get_option', [rt.new_string(option)])
	if rt.is_true(rt.greater(var_option_value, rt.new_int(0))) {
		var_page_object = rt.call_function('get_post', [var_option_value.clone()])
		if rt.is_true(var_page_object)
			&& rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_page_object, 'post_type')))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_page_object, 'post_status'), rt.create_array([rt.ArrayItem{
			key: none
			val: 'pending'
		}, rt.ArrayItem{ key: none, val: 'trash' }, rt.ArrayItem{ key: none, val: 'future' }, rt.ArrayItem{
			key: none
			val: 'auto-draft'
		}]), rt.new_bool(true)]))))) {
			return rt.get_property(var_page_object, 'ID')
		}
	}
	if page_content.len > 0 {
		var_shortcode = rt.call_function('str_replace', [
			rt.create_array([rt.ArrayItem{ key: none, val: '<!-- wp:shortcode -->' },
				rt.ArrayItem{ key: none, val: '<!-- /wp:shortcode -->' }]),
			rt.new_string(''),
			rt.new_string(page_content),
		])
		var_valid_page_found = rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
					'posts')),
					rt.new_string(" WHERE post_type='page' AND post_status NOT IN ( 'pending', 'trash', 'future', 'auto-draft' ) AND post_content LIKE %s LIMIT 1;")),
				rt.new_string('%${var_shortcode.to_string()}%'),
			]),
		])
	} else {
		var_valid_page_found = rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
					'posts')),
					rt.new_string(" WHERE post_type='page' AND post_status NOT IN ( 'pending', 'trash', 'future', 'auto-draft' )  AND post_name = %s LIMIT 1;")),
				var_slug.clone(),
			]),
		])
	}
	var_valid_page_found = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_create_page_id'),
		var_valid_page_found.clone(),
		var_slug.clone(),
		rt.new_string(page_content),
	])
	if rt.is_true(var_valid_page_found) {
		if var_option.len > 0 && var_option != '0' {
			rt.call_function('update_option', [rt.new_string(option),
				var_valid_page_found.clone()])
		}
		return var_valid_page_found.clone()
	}
	if page_content.len > 0 {
		var_trashed_page_found = rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
					'posts')),
					rt.new_string(" WHERE post_type='page' AND post_status = 'trash' AND post_content LIKE %s LIMIT 1;")),
				rt.new_string('%${var_page_content}%'),
			]),
		])
	} else {
		var_trashed_page_found = rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
					'posts')),
					rt.new_string(" WHERE post_type='page' AND post_status = 'trash' AND post_name = %s LIMIT 1;")),
				var_slug.clone(),
			]),
		])
	}
	if rt.is_true(var_trashed_page_found) {
		var_page_id = var_trashed_page_found.clone()
		var_page_data = {
			'ID':          var_page_id
			'post_status': rt.new_string(post_status)
		}
		rt.call_function('wp_update_post', [
			rt.create_array_from_native_map(var_page_data),
		])
	} else {
		var_page_data = {
			'post_status':    rt.new_string(post_status)
			'post_type':      rt.new_string('page')
			'post_author':    rt.new_int(1)
			'post_name':      var_slug
			'post_title':     rt.new_string(page_title)
			'post_content':   rt.new_string(page_content)
			'post_parent':    rt.new_int(post_parent)
			'comment_status': rt.new_string('closed')
		}
		var_page_id = rt.call_function('wp_insert_post', [
			rt.create_array_from_native_map(var_page_data),
		])
		rt.call_function('do_action', [rt.new_string('woocommerce_page_created'),
			var_page_id.clone(), rt.create_array_from_native_map(var_page_data)])
	}
	if var_option.len > 0 && var_option != '0' {
		rt.call_function('update_option', [rt.new_string(option),
			var_page_id.clone()])
	}
	return var_page_id.clone()
}

fn woocommerce_admin_fields(var_options rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_Settings'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(@DIR + '/class-wc-admin-settings.php', '1')
	}
	mut iife_temp_2 := Class_WC_Admin_Settings{}
	mut iife_result_2 := iife_temp_2.output_fields(var_options.clone())
}

fn woocommerce_update_options(var_options rt.PhpVal, var_data rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_Settings'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(@DIR + '/class-wc-admin-settings.php', '1')
	}
	mut iife_temp_3 := Class_WC_Admin_Settings{}
	mut iife_result_3 := iife_temp_3.save_fields(var_options.clone(), var_data.clone())
}

fn woocommerce_settings_get_option(var_option_name rt.PhpVal, default string) rt.PhpVal {
	mut var_default := default
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_Settings'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(@DIR + '/class-wc-admin-settings.php', '1')
	}
	mut iife_temp_4 := Class_WC_Admin_Settings{}
	mut iife_result_4 := iife_temp_4.get_option(var_option_name.clone(), rt.new_string(default))
	return iife_result_4
}

fn wc_maybe_adjust_line_item_product_stock(var_item rt.PhpVal, item_quantity i64) rt.PhpVal {
	mut var_item_quantity := item_quantity
	mut var_product := rt.new_null()
	mut var_already_reduced_stock := rt.new_null()
	mut var_restock_refunded_items := rt.new_null()
	mut var_diff := rt.new_null()
	mut var_new_stock := rt.new_null()
	mut var_order_data_store := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('line_item'), rt.call_method(var_item,
		'get_type', []rt.PhpVal{})))))
	{
		return rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_prevent_adjust_line_item_product_stock'),
		rt.new_bool(false),
		var_item.clone(),
		rt.new_int(var_item_quantity),
	]))
	{
		return rt.new_bool(false)
	}
	var_product = rt.call_method(var_item, 'get_product', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'managing_stock', []rt.PhpVal{}))))) {
		return rt.new_bool(false)
	}
	var_item_quantity = (rt.call_function('wc_stock_amount', [if var_item_quantity >= 0 {
		rt.new_int(var_item_quantity)
	} else {
		rt.call_method(var_item, 'get_quantity', []rt.PhpVal{})
	}])).to_i64()
	var_already_reduced_stock = rt.call_function('wc_stock_amount', [
		rt.call_method(var_item, 'get_meta', [rt.new_string('_reduced_stock'),
			rt.new_bool(true)]),
	])
	var_restock_refunded_items = rt.call_function('wc_stock_amount', [
		rt.call_method(var_item, 'get_meta', [rt.new_string('_restock_refunded_items'),
			rt.new_bool(true)]),
	])
	var_diff = rt.sub(rt.sub(rt.new_int(var_item_quantity), var_restock_refunded_items),
		var_already_reduced_stock)
	if 0 == var_item_quantity {
		var_diff = rt.mul(var_already_reduced_stock, -1)
	}
	if rt.is_true(rt.less(var_diff, rt.new_int(0))) {
		var_new_stock = rt.call_function('wc_update_product_stock', [
			var_product.clone(), rt.mul(var_diff, -1), rt.new_string('increase')])
	} else if rt.is_true(rt.greater(var_diff, rt.new_int(0))) {
		var_new_stock = rt.call_function('wc_update_product_stock', [
			var_product.clone(), var_diff.clone(), rt.new_string('decrease')])
	} else {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_new_stock.clone()])) {
		return var_new_stock.clone()
	}
	rt.call_method(var_item, 'update_meta_data', [rt.new_string('_reduced_stock'),
		rt.sub(rt.new_int(var_item_quantity), var_restock_refunded_items)])
	rt.call_method(var_item, 'save', []rt.PhpVal{})
	if var_item_quantity > 0 {
		mut iife_temp_5 := Class_WC_Data_Store{}
		mut iife_result_5 := iife_temp_5.load(rt.new_string('order'))
		var_order_data_store = iife_result_5
		if rt.is_true(rt.call_method(var_item, 'get_order_id', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_data_store, 'get_stock_reduced', [rt.call_method(var_item, 'get_order_id', []rt.PhpVal{})]))))) {
			rt.call_method(var_order_data_store, 'set_stock_reduced', [
				rt.call_method(var_item, 'get_order_id', []rt.PhpVal{}),
				rt.new_bool(true),
			])
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'from', val: rt.add(var_new_stock, var_diff) },
		rt.ArrayItem{ key: 'to', val: var_new_stock },
	])
}

fn wc_save_order_items(var_order_id rt.PhpVal, var_items rt.PhpVal) {
	mut var_qty_change_order_notes := []rt.PhpVal{}
	mut var_order := rt.new_null()
	mut var_data_keys := map[string]rt.PhpVal{}
	mut var_item_id := rt.new_null()
	mut var_item := rt.new_null()
	mut var_item_data := rt.new_null()
	mut var_default := rt.new_null()
	mut var_key := rt.new_null()
	mut var_changed_stock := rt.new_null()
	mut var_meta_key := rt.new_null()
	mut var_meta_id := rt.new_null()
	mut var_meta_value := rt.new_null()
	rt.call_function('do_action', [rt.new_string('woocommerce_before_save_order_items'),
		var_order_id.clone(), rt.create_array_from_native_map(var_items)])
	var_qty_change_order_notes = []rt.PhpVal{}
	var_order = rt.call_function('wc_get_order', [var_order_id.clone()])
	if var_items.array_isset(rt.new_string('order_item_id')) {
		var_data_keys = {
			'line_tax':             []rt.PhpVal{}
			'line_subtotal_tax':    []rt.PhpVal{}
			'order_item_name':      rt.new_null()
			'order_item_qty':       rt.new_null()
			'order_item_tax_class': rt.new_null()
			'line_total':           rt.new_null()
			'line_subtotal':        rt.new_null()
		}
		mut iter_3 := var_items.array_get(rt.new_string('order_item_id')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_item_id_shadow := item_3.val
			mut iife_temp_6 := Class_WC_Order_Factory{}
			mut iife_result_6 := iife_temp_6.get_order_item(rt.call_function('absint', [
				var_item_id_shadow.clone(),
			]))
			var_item = iife_result_6
			if rt.is_true(rt.new_bool(!(rt.is_true(var_item)))) {
				continue
			}
			var_item_data = []rt.PhpVal{}
			for var_key_shadow, var_default_shadow in var_data_keys {
				var_item_data.array_set(rt.new_string(var_key_shadow.str()), if var_items.array_get(rt.new_string(var_key_shadow.str())).array_isset(var_item_id_shadow) { rt.call_function('wc_check_invalid_utf8', [
						rt.call_function('wp_unslash', [var_items.array_get(rt.new_string(var_key_shadow.str())).array_get(var_item_id_shadow)]),
					]) } else { var_default_shadow })
			}
			if rt.is_true(rt.identical(rt.new_string('0'),
				var_item_data.array_get(rt.new_string('order_item_qty'))))
			{
				var_changed_stock = wc_maybe_adjust_line_item_product_stock(var_item.clone(), 0)
				if rt.is_true(var_changed_stock)
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_changed_stock.clone()]))))) {
					var_qty_change_order_notes <<
						(rt.call_method(var_item, 'get_name', []rt.PhpVal{})).str() + ' &ndash; ' +
						(var_changed_stock.array_get(rt.new_string('from'))).str() + '&rarr;' +
						(var_changed_stock.array_get(rt.new_string('to'))).str()
				}
				rt.call_method(var_item, 'delete', []rt.PhpVal{})
				continue
			}
			rt.call_method(var_item, 'set_props', [
				rt.create_array([
					rt.ArrayItem{
						key: 'name'
						val: var_item_data.array_get(rt.new_string('order_item_name'))
					},
					rt.ArrayItem{
						key: 'quantity'
						val: var_item_data.array_get(rt.new_string('order_item_qty'))
					},
					rt.ArrayItem{
						key: 'tax_class'
						val: var_item_data.array_get(rt.new_string('order_item_tax_class'))
					},
					rt.ArrayItem{
						key: 'total'
						val: var_item_data.array_get(rt.new_string('line_total'))
					},
					rt.ArrayItem{
						key: 'subtotal'
						val: var_item_data.array_get(rt.new_string('line_subtotal'))
					},
					rt.ArrayItem{ key: 'taxes', val: rt.create_array([
						rt.ArrayItem{
							key: 'total'
							val: var_item_data.array_get(rt.new_string('line_tax'))
						},
						rt.ArrayItem{
							key: 'subtotal'
							val: var_item_data.array_get(rt.new_string('line_subtotal_tax'))
						},
					]) },
				]),
			])
			if rt.is_true(rt.identical(rt.new_string('fee'), rt.call_method(var_item, 'get_type',
				[]rt.PhpVal{})))
			{
				rt.call_method(var_item, 'set_amount', [
					var_item_data.array_get(rt.new_string('line_total')),
				])
			}
			if var_items.array_get(rt.new_string('meta_key')).array_isset(var_item_id_shadow)
				&& var_items.array_get(rt.new_string('meta_value')).array_isset(var_item_id_shadow) {
				mut iter_4 :=
					var_items.array_get(rt.new_string('meta_key')).array_get(var_item_id_shadow).iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_meta_key_shadow := item_4.val
					mut var_meta_id_shadow := item_4.key
					var_meta_key_shadow = rt.call_function('substr', [
						rt.call_function('wp_unslash', [var_meta_key_shadow.clone()]),
						rt.new_int(0),
						rt.new_int(255),
					])
					var_meta_value = if var_items.array_get(rt.new_string('meta_value')).array_get(var_item_id_shadow).array_isset(var_meta_id_shadow) { rt.call_function('wp_unslash', [
							var_items.array_get(rt.new_string('meta_value')).array_get(var_item_id_shadow).array_get(var_meta_id_shadow),
						]) } else { rt.new_string('') }
					if rt.is_true(rt.identical(rt.new_string(''), var_meta_key_shadow))
						&& rt.is_true(rt.identical(rt.new_string(''), var_meta_value)) {
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [
							var_meta_id_shadow.clone(),
							rt.new_string('new-'),
						])))))
						{
							rt.call_method(var_item, 'delete_meta_data_by_mid', [
								var_meta_id_shadow.clone(),
							])
						}
					} else if rt.is_true(rt.call_function('strstr', [
						var_meta_id_shadow.clone(), rt.new_string('new-')]))
					{
						rt.call_method(var_item, 'add_meta_data', [
							var_meta_key_shadow.clone(), var_meta_value.clone(),
							rt.new_bool(false)])
					} else {
						rt.call_method(var_item, 'update_meta_data', [
							var_meta_key_shadow.clone(), var_meta_value.clone(),
							var_meta_id_shadow.clone()])
					}
				}
			}
			rt.call_function('do_action', [
				rt.new_string('woocommerce_before_save_order_item'),
				var_item.clone(),
			])
			rt.call_method(var_item, 'save', []rt.PhpVal{})
			if rt.is_true(rt.call_function('in_array', [
				rt.call_method(var_order, 'get_status', []rt.PhpVal{}),
				rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
					},
					rt.ArrayItem{
						key: none
						val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed()
					},
					rt.ArrayItem{
						key: none
						val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold()
					},
				]),
				rt.new_bool(true),
			]))
			{
				var_changed_stock = wc_maybe_adjust_line_item_product_stock(var_item.clone(), 0)
				if rt.is_true(var_changed_stock)
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_changed_stock.clone()]))))) {
					var_qty_change_order_notes <<
						(rt.call_method(var_item, 'get_name', []rt.PhpVal{})).str() +
						' (' + (var_changed_stock.array_get(rt.new_string('from'))).str() + '&rarr;' + (var_changed_stock.array_get(rt.new_string('to'))).str() + ')'
				}
			}
		}
	}
	if var_items.array_isset(rt.new_string('shipping_method_id')) {
		var_data_keys = {
			'shipping_method':       rt.new_null()
			'shipping_method_title': rt.new_null()
			'shipping_cost':         rt.new_int(0)
			'shipping_taxes':        []rt.PhpVal{}
		}
		mut iter_5 := var_items.array_get(rt.new_string('shipping_method_id')).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_item_id_shadow := item_5.val
			mut iife_temp_7 := Class_WC_Order_Factory{}
			mut iife_result_7 := iife_temp_7.get_order_item(rt.call_function('absint', [
				var_item_id_shadow.clone(),
			]))
			var_item = iife_result_7
			if rt.is_true(rt.new_bool(!(rt.is_true(var_item)))) {
				continue
			}
			var_item_data = []rt.PhpVal{}
			for var_key_shadow, var_default_shadow in var_data_keys {
				var_item_data.array_set(rt.new_string(var_key_shadow.str()), if var_items.array_get(rt.new_string(var_key_shadow.str())).array_isset(var_item_id_shadow) { rt.call_function('wc_clean', [
						rt.call_function('wp_unslash', [var_items.array_get(rt.new_string(var_key_shadow.str())).array_get(var_item_id_shadow)]),
					]) } else { var_default_shadow })
			}
			rt.call_method(var_item, 'set_props', [
				rt.create_array([
					rt.ArrayItem{
						key: 'method_id'
						val: var_item_data.array_get(rt.new_string('shipping_method'))
					},
					rt.ArrayItem{
						key: 'method_title'
						val: var_item_data.array_get(rt.new_string('shipping_method_title'))
					},
					rt.ArrayItem{
						key: 'total'
						val: var_item_data.array_get(rt.new_string('shipping_cost'))
					},
					rt.ArrayItem{ key: 'taxes', val: rt.create_array([
						rt.ArrayItem{
							key: 'total'
							val: var_item_data.array_get(rt.new_string('shipping_taxes'))
						},
					]) },
				]),
			])
			if var_items.array_get(rt.new_string('meta_key')).array_isset(var_item_id_shadow)
				&& var_items.array_get(rt.new_string('meta_value')).array_isset(var_item_id_shadow) {
				mut iter_6 :=
					var_items.array_get(rt.new_string('meta_key')).array_get(var_item_id_shadow).iterator()
				for {
					item_6 := iter_6.next() or { break }
					mut var_meta_key_shadow := item_6.val
					mut var_meta_id_shadow := item_6.key
					var_meta_value = if var_items.array_get(rt.new_string('meta_value')).array_get(var_item_id_shadow).array_isset(var_meta_id_shadow) { rt.call_function('wp_unslash', [
							var_items.array_get(rt.new_string('meta_value')).array_get(var_item_id_shadow).array_get(var_meta_id_shadow),
						]) } else { rt.new_string('') }
					if rt.is_true(rt.identical(rt.new_string(''), var_meta_key_shadow))
						&& rt.is_true(rt.identical(rt.new_string(''), var_meta_value)) {
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [
							var_meta_id_shadow.clone(),
							rt.new_string('new-'),
						])))))
						{
							rt.call_method(var_item, 'delete_meta_data_by_mid', [
								var_meta_id_shadow.clone(),
							])
						}
					} else if rt.is_true(rt.call_function('strstr', [
						var_meta_id_shadow.clone(), rt.new_string('new-')]))
					{
						rt.call_method(var_item, 'add_meta_data', [
							var_meta_key_shadow.clone(), var_meta_value.clone(),
							rt.new_bool(false)])
					} else {
						rt.call_method(var_item, 'update_meta_data', [
							var_meta_key_shadow.clone(), var_meta_value.clone(),
							var_meta_id_shadow.clone()])
					}
				}
			}
			rt.call_method(var_item, 'save', []rt.PhpVal{})
		}
	}
	var_order = rt.call_function('wc_get_order', [var_order_id.clone()])
	if !(!rt.is_true(var_qty_change_order_notes)) {
		rt.call_method(var_order, 'add_order_note', [
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Adjusted stock: %s'),
					rt.new_string('woocommerce')]),
				rt.call_function('implode', [rt.new_string(', '),
					rt.create_array_from_list(var_qty_change_order_notes)]),
			]),
			rt.new_bool(false),
			rt.new_bool(true),
			rt.create_array([
				rt.ArrayItem{
					key: 'note_group'
					val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.product_stock()
				},
			]),
		])
	}
	rt.call_method(var_order, 'update_taxes', []rt.PhpVal{})
	rt.call_method(var_order, 'calculate_totals', [rt.new_bool(false)])
	rt.call_function('do_action', [rt.new_string('woocommerce_saved_order_items'),
		var_order_id.clone(), rt.create_array_from_native_map(var_items)])
}

fn wc_render_action_buttons(var_actions rt.PhpVal) string {
	mut var_actions_html := ''
	mut var_action := map[string]rt.PhpVal{}
	var_actions_html = ''
	mut iter_7 := var_actions.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_action_shadow := item_7.val
		if var_action_shadow.array_isset(rt.new_string('group')) {
			var_actions_html = var_actions_html + '<div class="wc-action-button-group"><label>' +
				(var_action_shadow['group']).str() + '</label> <span class="wc-action-button-group__items">' + wc_render_action_buttons(var_action_shadow['actions']) +
				'</span></div>'
		} else if var_action_shadow.array_isset(rt.new_string('action'))
			&& var_action_shadow.array_isset(rt.new_string('url'))
			&& var_action_shadow.array_isset(rt.new_string('name')) {
			var_actions_html = var_actions_html +(rt.call_function('sprintf', [rt.new_string('<a class="button wc-action-button wc-action-button-%1$s %1$s" href="%2$s" aria-label="%3$s" title="%3$s">%4$s</a>'), rt.call_function('esc_attr', [var_action_shadow['action']]), rt.call_function('esc_url', [var_action_shadow['url']]), rt.call_function('esc_attr', [if var_action_shadow.array_isset(rt.new_string('title')) { var_action_shadow['title'] } else { var_action_shadow['name'] }]), rt.call_function('esc_html', [var_action_shadow['name']])])).str()
		}
	}
	return var_actions_html
}

fn wc_render_invalid_variation_notice(var_product_object rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_variation_ids := rt.new_null()
	mut var_variation_count := i64(0)
	mut var_valid_variation_count := rt.new_null()
	mut var_invalid_variation_count := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_show_invalid_variations_notice'),
		rt.new_bool(true),
		var_product_object.clone(),
	])))))
	{
		return
	}
	var_variation_ids = if rt.is_true(var_product_object) {
		rt.call_method(var_product_object, 'get_children', []rt.PhpVal{})
	} else {
		[]rt.PhpVal{}
	}
	if !rt.is_true(var_variation_ids) {
		return
	}
	var_variation_count = var_variation_ids.clone().array_count()
	var_valid_variation_count = rt.call_method(var_wpdb, 'get_var', [
		rt.new_string((
			rt.concat(rt.concat(rt.new_string('\n\t\tSELECT count(post_id) FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\tWHERE post_id in (')) + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), var_variation_ids.clone()])])).str() +
			")\n\t\tAND ( meta_key='_subscription_sign_up_fee' OR meta_key='_price' )\n\t\tAND meta_value >= 0\n\t\tAND meta_value != ''\n\t\t").str()),
	])
	var_invalid_variation_count = rt.sub(rt.new_int(var_variation_count), var_valid_variation_count)
	if rt.is_true(rt.less(rt.new_int(0), var_invalid_variation_count)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%d variation does not have a price.'), rt.new_string('%d variations do not have prices.'), var_invalid_variation_count.clone(), rt.new_string('woocommerce')]), var_invalid_variation_count.clone()])).str() +
				'&nbsp;' +(rt.call_function('__', [rt.new_string('Variations (and their attributes) that do not have prices will not be shown in your store.'), rt.new_string('woocommerce')])).str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Add price'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
}

fn wc_get_current_admin_url() string {
	mut var_uri := rt.new_null()
	var_uri = if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) { rt.call_function('esc_url_raw', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]),
		]) } else { rt.new_string('') }
	var_uri = rt.call_function('preg_replace', [rt.new_string('|^.*/wp-admin/|i'),
		rt.new_string(''), var_uri.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_uri)))) {
		return ''
	}
	return (rt.call_function('remove_query_arg', [
		rt.create_array([rt.ArrayItem{ key: none, val: '_wpnonce' },
			rt.ArrayItem{ key: none, val: '_wc_notice_nonce' },
			rt.ArrayItem{ key: none, val: 'wc_db_update' }, rt.ArrayItem{
				key: none
				val: 'wc_db_update_nonce'
			}, rt.ArrayItem{ key: none, val: 'wc-hide-notice' }]),
		rt.call_function('admin_url', [var_uri.clone()]),
	])).str()
}

fn wc_get_default_product_type_options() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'virtual', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '_virtual' },
			rt.ArrayItem{ key: 'wrapper_class', val: 'show_if_simple' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Virtual'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Virtual products are intangible and are not shipped.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: 'no' },
		]) },
		rt.ArrayItem{ key: 'downloadable', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '_downloadable' },
			rt.ArrayItem{ key: 'wrapper_class', val: 'show_if_simple' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Downloadable'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Downloadable products give access to a file upon purchase.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: 'no' },
		]) },
	])
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Menus {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Order_Factory {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_menus(_args ...rt.PhpVal) &Class_WC_Admin_Menus {
	mut obj := &Class_WC_Admin_Menus{
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

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_factory(_args ...rt.PhpVal) &Class_WC_Order_Factory {
	mut obj := &Class_WC_Order_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Admin_Menus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Menus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Menus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
