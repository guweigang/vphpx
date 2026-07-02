import rt

fn wc_get_orders(var_args rt.PhpVal) rt.PhpVal {
	mut var_map_legacy := map[string]rt.PhpVal{}
	mut var_to := rt.new_null()
	mut var_from := rt.new_null()
	mut var_date_before := rt.new_null()
	mut var_date_after := rt.new_null()
	mut var_datetime := rt.new_null()
	mut var_query := rt.new_null()
	var_map_legacy = { 'numberposts': 'limit', 'post_type': 'type', 'post_status': 'status', 'post_parent': 'parent', 'author': 'customer', 'email': 'billing_email', 'posts_per_page': 'limit', 'paged': 'page' }
	for var_from_shadow, var_to_shadow in var_map_legacy {
		if var_args.array_isset(rt.new_string((var_from_shadow).str())) {
			var_args.array_set(rt.new_string((var_to_shadow).str()), var_args.array_get(rt.new_string((var_from_shadow).str())))
		}
	}
	var_date_before = rt.new_bool(false)
	var_date_after = rt.new_bool(false)
	if !(!rt.is_true(var_args.array_get(rt.new_string('date_before')))) {
	var_datetime = rt.call_function('wc_string_to_datetime', [var_args.array_get(rt.new_string('date_before'))])
	var_date_before = if rt.is_true(rt.call_function('strpos', [var_args.array_get(rt.new_string('date_before')), rt.new_string(':')])) { rt.call_method(var_datetime, 'getOffsetTimestamp', []rt.PhpVal{}) } else { rt.call_method(var_datetime, 'date', [rt.new_string('Y-m-d')]) }
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('date_after')))) {
	var_datetime = rt.call_function('wc_string_to_datetime', [var_args.array_get(rt.new_string('date_after'))])
	var_date_after = if rt.is_true(rt.call_function('strpos', [var_args.array_get(rt.new_string('date_after')), rt.new_string(':')])) { rt.call_method(var_datetime, 'getOffsetTimestamp', []rt.PhpVal{}) } else { rt.call_method(var_datetime, 'date', [rt.new_string('Y-m-d')]) }
	}
	if rt.is_true(var_date_before) && rt.is_true(var_date_after) {
		var_args.array_set('date_created', (var_date_after).str() + '...' + (var_date_before).str())
	} else if rt.is_true(var_date_before) {
		var_args.array_set('date_created', '<' + (var_date_before).str())
	} else if rt.is_true(var_date_after) {
		var_args.array_set('date_created', '>' + (var_date_after).str())
	}
	var_query = create_wc_order_query(var_args.clone())
	return var_query.get_orders()
}

fn wc_get_order(the_order bool) bool {
	mut var_the_order := the_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_after_register_post_type')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.new_string('wc_get_order should not be called before post types are registered (woocommerce_after_register_post_type action)'), rt.new_string('2.5')])
		return false
	}
	return (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'order_factory'), 'get_order', [rt.new_bool(the_order)])).to_bool()
}

fn wc_get_order_statuses() rt.PhpVal {
	mut var_order_statuses := rt.new_null()
	var_order_statuses = rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.pending(), val: rt.call_function('_x', [rt.new_string('Pending payment'), rt.new_string('Order status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.processing(), val: rt.call_function('_x', [rt.new_string('Processing'), rt.new_string('Order status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.on_hold(), val: rt.call_function('_x', [rt.new_string('On hold'), rt.new_string('Order status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.completed(), val: rt.call_function('_x', [rt.new_string('Completed'), rt.new_string('Order status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.cancelled(), val: rt.call_function('_x', [rt.new_string('Cancelled'), rt.new_string('Order status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.refunded(), val: rt.call_function('_x', [rt.new_string('Refunded'), rt.new_string('Order status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.failed(), val: rt.call_function('_x', [rt.new_string('Failed'), rt.new_string('Order status'), rt.new_string('woocommerce')]) }])
	return rt.call_function('apply_filters', [rt.new_string('wc_order_statuses'), var_order_statuses.clone()])
}

fn wc_is_order_status(var_maybe_status rt.PhpVal) rt.PhpVal {
	mut var_order_statuses := rt.new_null()
	var_order_statuses = wc_get_order_statuses()
	return rt.new_bool(var_order_statuses.array_isset(var_maybe_status))
}

fn wc_get_is_paid_statuses() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_is_paid_statuses'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }])])
}

fn wc_get_is_pending_statuses() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_is_pending_statuses'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.pending() }])])
}

fn wc_get_order_status_name(var_status rt.PhpVal) rt.PhpVal {
	mut var_special_statuses := rt.new_null()
	mut var_statuses := rt.new_null()
	mut var_unprefixed := rt.new_null()
	var_special_statuses = rt.create_array([rt.ArrayItem{ key: 'wc-' + (Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft()).str(), val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft() }, rt.ArrayItem{ key: 'wc-' + (Class_Automattic_WooCommerce_Enums_OrderStatus.trash()).str(), val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash() }])
	var_statuses = rt.call_function('array_merge', [var_special_statuses.clone(), wc_get_order_statuses()])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_0 := iife_temp_0.remove_status_prefix(rt.new_string((var_status).str()))
	var_unprefixed = iife_result_0
	if !(var_status.clone().is_string()) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('An invalid order status slug was supplied.'), rt.new_string('woocommerce')]), rt.new_string('9.6')])
	}
	return if !(var_statuses.array_get(rt.new_string('wc-' + (var_unprefixed).str()))).is_null() { var_statuses.array_get(rt.new_string('wc-' + (var_unprefixed).str())) } else { var_unprefixed }
}

fn wc_generate_order_key(key string) string {
	mut var_key := key
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string((var_key).str()))) {
	var_key = (rt.call_function('wp_generate_password', [rt.new_int(13), rt.new_bool(false)])).str()
	}
	return 'wc_' + (rt.call_function('apply_filters', [rt.new_string('woocommerce_generate_order_key'), rt.new_string('order_' + var_key)])).str()
}

fn wc_get_order_id_by_order_key(var_order_key rt.PhpVal) rt.PhpVal {
	mut var_data_store := rt.new_null()
	mut iife_temp_1 := Class_WC_Data_Store{}
	mut iife_result_1 := iife_temp_1.load(rt.new_string('order'))
	var_data_store = iife_result_1
	return rt.call_method(var_data_store, 'get_order_id_by_order_key', [var_order_key.clone()])
}

fn wc_get_order_types(for string) rt.PhpVal {
	mut var_for := for
	mut var_wc_order_types := rt.new_null()
	mut var_order_types := rt.new_null()
	mut var_args := rt.new_null()
	mut var_type := rt.new_null()
	if !(var_wc_order_types.clone().is_array()) {
	var_wc_order_types = rt.new_array()
	}
	var_order_types = rt.new_array()
	mut switch_val_1 := rt.new_string(for)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('order-count'))) {
		mut iter_1 := var_wc_order_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_args_shadow := item_1.val
			mut var_type_shadow := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(var_args_shadow.array_get(rt.new_string('exclude_from_order_count')))))) {
				var_order_types.array_push(var_type_shadow.clone())
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('order-meta-boxes'))) {
		mut iter_2 := var_wc_order_types.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_args_shadow := item_2.val
			mut var_type_shadow := item_2.key
			if rt.is_true(var_args_shadow.array_get(rt.new_string('add_order_meta_boxes'))) {
				var_order_types.array_push(var_type_shadow.clone())
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('view-orders'))) {
		mut iter_3 := var_wc_order_types.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_args_shadow := item_3.val
			mut var_type_shadow := item_3.key
			if rt.is_true(rt.new_bool(!(rt.is_true(var_args_shadow.array_get(rt.new_string('exclude_from_order_views')))))) {
				var_order_types.array_push(var_type_shadow.clone())
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('reports'))) {
		mut iter_4 := var_wc_order_types.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_args_shadow := item_4.val
			mut var_type_shadow := item_4.key
			if rt.is_true(rt.new_bool(!(rt.is_true(var_args_shadow.array_get(rt.new_string('exclude_from_order_reports')))))) {
				var_order_types.array_push(var_type_shadow.clone())
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('sales-reports'))) {
		mut iter_5 := var_wc_order_types.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_args_shadow := item_5.val
			mut var_type_shadow := item_5.key
			if rt.is_true(rt.new_bool(!(rt.is_true(var_args_shadow.array_get(rt.new_string('exclude_from_order_sales_reports')))))) {
				var_order_types.array_push(var_type_shadow.clone())
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('order-webhooks'))) {
		mut iter_6 := var_wc_order_types.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_args_shadow := item_6.val
			mut var_type_shadow := item_6.key
			if rt.is_true(rt.new_bool(!(rt.is_true(var_args_shadow.array_get(rt.new_string('exclude_from_order_webhooks')))))) {
				var_order_types.array_push(var_type_shadow.clone())
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cot-migration'))) {
		mut iter_7 := var_wc_order_types.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_args_shadow := item_7.val
			mut var_type_shadow := item_7.key
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.placeholder_order_post_type(), var_type_shadow)))) {
				var_order_types.array_push(var_type_shadow.clone())
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('admin-menu'))) {
	var_order_types = rt.call_function('array_intersect', [rt.func_array_keys(var_wc_order_types.clone()), rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_ui', val: true }, rt.ArrayItem{ key: 'show_in_menu', val: 'woocommerce' }])])])
	} else {
	var_order_types = rt.func_array_keys(var_wc_order_types.clone())
	}
	return rt.call_function('apply_filters', [rt.new_string('wc_order_types'), var_order_types.clone(), rt.new_string(for)])
}

fn wc_get_order_type(var_type rt.PhpVal) bool {
	mut var_wc_order_types := rt.new_null()
	if var_wc_order_types.array_isset(var_type) {
		return (var_wc_order_types.array_get(var_type)).to_bool()
	}
	return false
}

fn wc_register_order_type(var_type rt.PhpVal, var_args_arg rt.PhpVal) bool {
	mut var_args := var_args_arg
	mut var_wc_order_types := rt.new_null()
	mut var_order_type_args := map[string]rt.PhpVal{}
	if rt.is_true(rt.call_function('post_type_exists', [var_type.clone()])) {
		return false
	}
	if !(var_wc_order_types.clone().is_array()) {
	var_wc_order_types = rt.new_array()
	}
	if rt.is_true(rt.call_function('is_wp_error', [rt.call_function('register_post_type', [var_type.clone(), var_args.clone()])])) {
		return false
	}
	var_order_type_args = { 'add_order_meta_boxes': rt.new_bool(true), 'exclude_from_order_count': rt.new_bool(false), 'exclude_from_order_views': rt.new_bool(false), 'exclude_from_order_webhooks': rt.new_bool(false), 'exclude_from_order_reports': rt.new_bool(false), 'exclude_from_order_sales_reports': rt.new_bool(false), 'class_name': rt.new_string('WC_Order') }
	var_args = rt.call_function('array_intersect_key', [var_args.clone(), rt.create_array_from_native_map(var_order_type_args)])
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_order_type_args)])
	var_wc_order_types.array_set(var_type, var_args.clone())
	return true
}

fn wc_processing_order_count() rt.PhpVal {
	return rt.new_int(wc_orders_count(Class_Automattic_WooCommerce_Enums_OrderStatus.processing()))
}

fn wc_orders_count(var_status_arg rt.PhpVal, type string) i64 {
	mut var_type := type
	mut var_status := var_status_arg
	mut var_count := i64(0)
	mut var_legacy_statuses := []rt.PhpVal{}
	mut var_valid_types := rt.new_null()
	mut var_types_for_count := rt.new_null()
	mut var_order_count_cache := rt.new_null()
	mut var_cache := rt.new_null()
	mut var_count_for_type := rt.new_null()
	mut var_e := rt.new_null()
	var_count = 0
	var_legacy_statuses = [Class_Automattic_WooCommerce_Enums_OrderStatus.draft(), Class_Automattic_WooCommerce_Enums_OrderStatus.trash()]
	var_status = if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status.clone(), rt.create_array_from_list(var_legacy_statuses), rt.new_bool(true)]))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_status.clone(), rt.new_string('wc-')]))))) { 'wc-' + (var_status).str() } else { var_status }
	var_valid_types = wc_get_order_types('order-count')
	var_type = var_type.trim_space()
	var_types_for_count = if var_type.len > 0 && var_type != '0' { rt.create_array([rt.ArrayItem{ key: none, val: var_type }]) } else { var_valid_types }
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_order_count_cache = create_automattic_woocommerce_caches_ordercountcache()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut iter_8 := var_types_for_count.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_type_shadow := item_8.val
		var_cache = var_order_count_cache.get(rt.new_string((var_type_shadow).str()), rt.create_array([rt.ArrayItem{ key: none, val: var_status }]))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if var_cache.array_isset(var_status) {
			var_count = var_count + (var_cache.array_get(var_status)).to_i64()
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		} else {
			mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
			mut iife_result_2 := iife_temp_2.get_count_for_type(rt.new_string((var_type_shadow).str()))
			var_count_for_type = iife_result_2
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			var_count = var_count + (var_count_for_type.array_get(var_status)).to_i64()
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return var_count
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		var_e = var_e_1.clone()
		return 0
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return 0
}

fn wc_downloadable_file_permission(var_download_id rt.PhpVal, var_product_arg rt.PhpVal, var_order rt.PhpVal, qty i64, var_item rt.PhpVal) rt.PhpVal {
	mut var_qty := qty
	mut var_product := var_product_arg
	mut var_download := rt.new_null()
	mut var_expiry := rt.new_null()
	mut var_from_date := rt.new_null()
	if rt.is_true(rt.new_bool(var_product.clone().is_long() || var_product.clone().is_double())) {
	var_product = rt.call_function('wc_get_product', [var_product.clone()])
	}
	var_download = create_wc_customer_download()
	rt.call_method(var_download, 'set_download_id', [var_download_id.clone()])
	rt.call_method(var_download, 'set_product_id', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
	rt.call_method(var_download, 'set_user_id', [rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{})])
	rt.call_method(var_download, 'set_order_id', [rt.call_method(var_order, 'get_id', []rt.PhpVal{})])
	rt.call_method(var_download, 'set_user_email', [rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})])
	rt.call_method(var_download, 'set_order_key', [rt.call_method(var_order, 'get_order_key', []rt.PhpVal{})])
	rt.call_method(var_download, 'set_downloads_remaining', [if rt.is_true(rt.greater(rt.new_int(0), rt.call_method(var_product, 'get_download_limit', []rt.PhpVal{}))) { rt.new_string('') } else { rt.mul(rt.call_method(var_product, 'get_download_limit', []rt.PhpVal{}), rt.new_int(qty)) }])
	rt.call_method(var_download, 'set_access_granted', [rt.call_function('time', []rt.PhpVal{})])
	rt.call_method(var_download, 'set_download_count', [rt.new_int(0)])
	var_expiry = rt.call_method(var_product, 'get_download_expiry', []rt.PhpVal{})
	if rt.is_true(rt.greater(var_expiry, rt.new_int(0))) {
		var_from_date = if rt.is_true(rt.call_method(var_order, 'get_date_completed', []rt.PhpVal{})) { rt.call_method(rt.call_method(var_order, 'get_date_completed', []rt.PhpVal{}), 'format', [rt.new_string('Y-m-d')]) } else { rt.call_function('current_time', [rt.new_string('mysql'), rt.new_bool(true)]) }
		rt.call_method(var_download, 'set_access_expires', [rt.call_function('strtotime', [rt.new_string((var_from_date).str() + ' + ' + (var_expiry).str() + ' DAY')])])
	}
	var_download = rt.call_function('apply_filters', [rt.new_string('woocommerce_downloadable_file_permission'), var_download.clone(), var_product.clone(), var_order.clone(), rt.new_int(qty), var_item.clone()])
	return rt.call_method(var_download, 'save', []rt.PhpVal{})
}

fn wc_downloadable_product_permissions(var_order_id rt.PhpVal, force bool) {
	mut var_force := force
	mut var_order := false
	mut var_line_items := rt.new_null()
	mut var_item := rt.new_null()
	mut var_product := rt.new_null()
	mut var_downloads := rt.new_null()
	mut var_download_id := rt.new_null()
	var_order = wc_get_order(var_order_id.clone())
	if !(var_order) || (rt.is_true(rt.call_method(rt.call_method(rt.new_bool(var_order), 'get_data_store', []rt.PhpVal{}), 'get_download_permissions_granted', [rt.new_bool(var_order).clone()])) && !(var_force)) {
		return
	}
	if rt.is_true(rt.call_method(rt.new_bool(var_order), 'has_status', [Class_Automattic_WooCommerce_Enums_OrderStatus.processing()])) && rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_downloads_grant_access_after_payment')]))) {
		return
	}
	var_line_items = rt.call_method(rt.new_bool(var_order), 'get_items', []rt.PhpVal{})
	if var_line_items.clone().array_count() > 0 {
		mut iter_9 := var_line_items.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_item_shadow := item_9.val
			var_product = rt.call_method(var_item_shadow, 'get_product', []rt.PhpVal{})
			if rt.is_true(var_product) && rt.is_true(rt.call_method(var_product, 'exists', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{})) {
				var_downloads = rt.call_method(var_product, 'get_downloads', []rt.PhpVal{})
				mut iter_10 := rt.func_array_keys(var_downloads.clone()).iterator()
				for {
					item_10 := iter_10.next() or { break }
					mut var_download_id_shadow := item_10.val
					wc_downloadable_file_permission(var_download_id_shadow.clone(), var_product.clone(), rt.new_bool(var_order).clone(), rt.call_method(var_item_shadow, 'get_quantity', []rt.PhpVal{}), var_item_shadow.clone())
				}
			}
		}
	}
	rt.call_method(rt.call_method(rt.new_bool(var_order), 'get_data_store', []rt.PhpVal{}), 'set_download_permissions_granted', [rt.new_bool(var_order).clone(), rt.new_bool(true)])
	rt.call_function('do_action', [rt.new_string('woocommerce_grant_product_download_permissions'), var_order_id.clone()])
}

fn wc_delete_shop_order_transients(order i64) {
	mut var_order := order
	mut var_order_id := rt.new_null()
	mut var_customer_id := rt.new_null()
	mut var_metas_to_purge := rt.new_null()
	mut var_meta := rt.new_null()
	if var_order != 0 && rt.new_int(var_order).is_long() || rt.new_int(var_order).is_double() {
	var_order = wc_get_order(var_order)
	}
	var_order_id = rt.new_int(0)
	if var_order != 0 && rt.is_true(rt.call_function('is_a', [rt.new_int(var_order), rt.new_string('WC_Order')])) {
		var_order_id = rt.call_method(rt.new_int(var_order), 'get_id', []rt.PhpVal{})
		var_customer_id = rt.call_method(rt.new_int(var_order), 'get_customer_id', []rt.PhpVal{})
		if rt.is_true(var_customer_id) {
			mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
			mut iife_result_3 := iife_temp_3.get_site_user_meta(var_customer_id.clone(), rt.new_string('wc_order_count'))
			mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
			mut iife_result_4 := iife_temp_4.get_site_user_meta(var_customer_id.clone(), rt.new_string('wc_order_count'))
			mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
			mut iife_result_5 := iife_temp_5.get_site_user_meta(var_customer_id.clone(), rt.new_string('wc_last_order'))
			mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
			mut iife_result_6 := iife_temp_6.get_site_user_meta(var_customer_id.clone(), rt.new_string('wc_last_order'))
			mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
			mut iife_result_7 := iife_temp_7.get_site_user_meta(var_customer_id.clone(), rt.new_string('wc_money_spent'))
			mut iife_temp_8 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
			mut iife_result_8 := iife_temp_8.get_site_user_meta(var_customer_id.clone(), rt.new_string('wc_money_spent'))
			var_metas_to_purge = rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: if iife_result_3.is_long() || iife_result_3.is_double() { 'wc_order_count' } else { '' } }, rt.ArrayItem{ key: none, val: if iife_result_5.is_long() || iife_result_5.is_double() { 'wc_last_order' } else { '' } }, rt.ArrayItem{ key: none, val: if iife_result_7.is_long() || iife_result_7.is_double() { 'wc_money_spent' } else { '' } }])])
			if !(!rt.is_true(var_metas_to_purge)) {
				mut iter_11 := var_metas_to_purge.iterator()
				for {
					item_11 := iter_11.next() or { break }
					mut var_meta_shadow := item_11.val
				mut iife_temp_9 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
				mut iife_result_9 := iife_temp_9.delete_site_user_meta(var_customer_id.clone(), var_meta_shadow.clone())
				}
			}
		}
	}
	mut iife_temp_10 := Class_WC_Cache_Helper{}
	mut iife_result_10 := iife_temp_10.get_transient_version(rt.new_string('orders'), rt.new_bool(true))
	mut iife_temp_11 := Class_WC_Cache_Helper{}
	mut iife_result_11 := iife_temp_11.invalidate_cache_group(rt.new_string('orders'))
	rt.call_function('do_action', [rt.new_string('woocommerce_delete_shop_order_transients'), var_order_id.clone()])
}

fn wc_ship_to_billing_address_only() rt.PhpVal {
	return rt.identical(rt.new_string('billing_only'), rt.call_function('get_option', [rt.new_string('woocommerce_ship_to_destination')]))
}

fn wc_create_refund(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_default_args := map[string]rt.PhpVal{}
	mut var_order := false
	mut var_remaining_refund_amount := rt.new_null()
	mut var_remaining_refund_items := rt.new_null()
	mut var_refund_item_count := i64(0)
	mut var_refund := rt.new_null()
	mut var_refunded_order_and_products := rt.new_null()
	mut var_items := rt.new_null()
	mut var_item := rt.new_null()
	mut var_item_id := rt.new_null()
	mut var_qty := rt.new_null()
	mut var_refund_total := rt.new_null()
	mut var_refund_tax := rt.new_null()
	mut var_class := rt.new_null()
	mut var_refunded_item := rt.new_null()
	mut var_result := rt.new_null()
	mut var_download_data_store := rt.new_null()
	mut var_refunded_order_and_product := rt.new_null()
	mut var_downloads := rt.new_null()
	mut var_download := rt.new_null()
	mut var_parent_status := rt.new_null()
	mut var_e := rt.new_null()
	var_default_args = { 'amount': rt.new_int(0), 'reason': rt.new_null(), 'order_id': rt.new_int(0), 'refund_id': rt.new_int(0), 'line_items': rt.new_array(), 'refund_payment': rt.new_bool(false), 'restock_items': rt.new_bool(false) }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_default_args)])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_order = wc_get_order(var_args.array_get(rt.new_string('order_id')))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if !(var_order) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_remaining_refund_amount = rt.call_method(rt.new_bool(var_order), 'get_remaining_refund_amount', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_remaining_refund_items = rt.call_method(rt.new_bool(var_order), 'get_remaining_refund_items', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_refund_item_count = 0
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_refund = create_wc_order_refund(var_args.array_get(rt.new_string('refund_id')))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_refunded_order_and_products = rt.new_array()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.greater(rt.new_int(0), var_args.array_get(rt.new_string('amount')))) || rt.is_true(rt.greater(var_args.array_get(rt.new_string('amount')), var_remaining_refund_amount)) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid refund amount.'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_refund.set_currency(rt.call_method(rt.new_bool(var_order), 'get_currency', []rt.PhpVal{}))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_refund.set_amount(var_args.array_get(rt.new_string('amount')))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_refund.set_parent_id(rt.call_function('absint', [var_args.array_get(rt.new_string('order_id'))]))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_refund.set_refunded_by(if rt.is_true(rt.call_function('get_current_user_id', []rt.PhpVal{})) { rt.call_function('get_current_user_id', []rt.PhpVal{}) } else { rt.new_int(1) })
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_refund.set_prices_include_tax(rt.call_method(rt.new_bool(var_order), 'get_prices_include_tax', []rt.PhpVal{}))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if !(var_args.array_get(rt.new_string('reason')).is_null()) {
		var_refund.set_reason(var_args.array_get(rt.new_string('reason')))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if var_args.array_get(rt.new_string('line_items')).is_array() && var_args.array_get(rt.new_string('line_items')).array_count() > 0 {
		var_items = rt.call_method(rt.new_bool(var_order), 'get_items', [rt.create_array([rt.ArrayItem{ key: none, val: 'line_item' }, rt.ArrayItem{ key: none, val: 'fee' }, rt.ArrayItem{ key: none, val: 'shipping' }])])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		mut iter_12 := var_items.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_item_shadow := item_12.val
			mut var_item_id_shadow := item_12.key
			if !(var_args.array_get(rt.new_string('line_items')).array_isset(var_item_id_shadow)) {
				continue
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			var_qty = if var_args.array_get(rt.new_string('line_items')).array_get(var_item_id_shadow).array_isset(rt.new_string('qty')) { var_args.array_get(rt.new_string('line_items')).array_get(var_item_id_shadow).array_get(rt.new_string('qty')) } else { rt.new_int(0) }
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			var_refund_total = var_args.array_get(rt.new_string('line_items')).array_get(var_item_id_shadow).array_get(rt.new_string('refund_total'))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			var_refund_tax = if var_args.array_get(rt.new_string('line_items')).array_get(var_item_id_shadow).array_isset(rt.new_string('refund_tax')) { rt.call_function('array_filter', [rt.cast_array(var_args.array_get(rt.new_string('line_items')).array_get(var_item_id_shadow).array_get(rt.new_string('refund_tax')))]) } else { rt.new_array() }
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			if !rt.is_true(var_qty) && !rt.is_true(var_refund_total) && !rt.is_true(var_args.array_get(rt.new_string('line_items')).array_get(var_item_id_shadow).array_get(rt.new_string('refund_tax'))) {
				continue
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			if rt.is_true(rt.call_method(var_item_shadow, 'is_type', [rt.new_string('line_item')])) {
				var_refunded_order_and_products.array_set(var_item_id_shadow, rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.call_method(rt.new_bool(var_order), 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'product_id', val: rt.call_method(var_item_shadow, 'get_product_id', []rt.PhpVal{}) }]))
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			var_class = rt.call_function('get_class', [var_item_shadow.clone()])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			var_refunded_item = rt.create_object_dynamically(var_class, [var_item_shadow.clone()])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			rt.call_method(var_refunded_item, 'set_id', [rt.new_int(0)])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			rt.call_method(var_refunded_item, 'add_meta_data', [rt.new_string('_refunded_item_id'), var_item_id_shadow.clone(), rt.new_bool(true)])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			rt.call_method(var_refunded_item, 'set_total', [rt.call_function('wc_format_refund_total', [var_refund_total.clone()])])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			rt.call_method(var_refunded_item, 'set_taxes', [rt.create_array([rt.ArrayItem{ key: 'total', val: rt.call_function('array_map', [rt.new_string('wc_format_refund_total'), var_refund_tax.clone()]) }, rt.ArrayItem{ key: 'subtotal', val: rt.call_function('array_map', [rt.new_string('wc_format_refund_total'), var_refund_tax.clone()]) }])])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_refunded_item }, rt.ArrayItem{ key: none, val: 'set_subtotal' }])])) {
				rt.call_method(var_refunded_item, 'set_subtotal', [rt.call_function('wc_format_refund_total', [var_refund_total.clone()])])
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_refunded_item }, rt.ArrayItem{ key: none, val: 'set_quantity' }])])) {
				rt.call_method(var_refunded_item, 'set_quantity', [rt.mul(var_qty, -1)])
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			var_refund.add_item(var_refunded_item.clone())
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			var_refund_item_count = var_refund_item_count + (var_qty).to_i64()
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_refund.update_taxes()
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_refund.calculate_totals(rt.new_bool(false))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_refund.set_total(rt.mul(var_args.array_get(rt.new_string('amount')), -1))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if var_args.array_isset(rt.new_string('date_created')) {
		var_refund.set_date_created(var_args.array_get(rt.new_string('date_created')))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_function('do_action', [rt.new_string('woocommerce_create_refund'), var_refund, var_args.clone()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(var_refund.save()) {
		if rt.is_true(var_args.array_get(rt.new_string('refund_payment'))) {
			var_result = rt.new_bool(wc_refund_payment(rt.new_bool(var_order).clone(), var_refund.get_amount(), var_refund.get_reason()))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				var_refund.delete()
				if rt.has_exception() { unsafe { goto catch_label_2 } }
				return mut rt.cast_object_ptr[Class_WC_Order_Refund](var_result)
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			var_refund.set_refunded_payment(rt.new_bool(true))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			var_refund.save()
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(var_args.array_get(rt.new_string('restock_items'))) {
			wc_restock_refunded_items(rt.new_bool(var_order).clone(), var_args.array_get(rt.new_string('line_items')))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if !(!rt.is_true(var_refunded_order_and_products)) {
			mut iife_temp_12 := Class_WC_Data_Store{}
			mut iife_result_12 := iife_temp_12.load(rt.new_string('customer-download'))
			var_download_data_store = iife_result_12
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			mut iter_13 := var_refunded_order_and_products.iterator()
			for {
				item_13 := iter_13.next() or { break }
				mut var_refunded_order_and_product_shadow := item_13.val
				var_downloads = rt.call_method(var_download_data_store, 'get_downloads', [var_refunded_order_and_product_shadow.clone()])
				if rt.has_exception() { unsafe { goto catch_label_2 } }
				if !(!rt.is_true(var_downloads)) {
					mut iter_14 := var_downloads.iterator()
					for {
						item_14 := iter_14.next() or { break }
						mut var_download_shadow := item_14.val
						rt.call_method(var_download_data_store, 'delete_by_id', [rt.call_method(var_download_shadow, 'get_id', []rt.PhpVal{})])
						if rt.has_exception() { unsafe { goto catch_label_2 } }
					}
					if rt.has_exception() { unsafe { goto catch_label_2 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true((rt.call_function('apply_filters', [rt.new_string('woocommerce_order_is_partially_refunded'), rt.new_bool(rt.is_true(rt.greater(rt.sub(var_remaining_refund_amount, var_args.array_get(rt.new_string('amount'))), rt.new_int(0))) || !(!rt.is_true(var_args.array_get(rt.new_string('line_items')))) && rt.is_true(rt.call_method(rt.new_bool(var_order), 'has_free_item', []rt.PhpVal{})) && rt.is_true(rt.greater(rt.sub(var_remaining_refund_items, rt.new_int(var_refund_item_count)), rt.new_int(0)))), rt.call_method(rt.new_bool(var_order), 'get_id', []rt.PhpVal{}), var_refund.get_id()])).to_bool()) {
			rt.call_function('do_action', [rt.new_string('woocommerce_order_partially_refunded'), rt.call_method(rt.new_bool(var_order), 'get_id', []rt.PhpVal{}), var_refund.get_id()])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		} else {
			rt.call_function('do_action', [rt.new_string('woocommerce_order_fully_refunded'), rt.call_method(rt.new_bool(var_order), 'get_id', []rt.PhpVal{}), var_refund.get_id()])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			var_parent_status = rt.call_function('apply_filters', [rt.new_string('woocommerce_order_fully_refunded_status'), Class_Automattic_WooCommerce_Enums_OrderStatus.refunded(), rt.call_method(rt.new_bool(var_order), 'get_id', []rt.PhpVal{}), var_refund.get_id()])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			if rt.is_true(var_parent_status) {
				rt.call_method(rt.new_bool(var_order), 'update_status', [var_parent_status.clone()])
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_method(rt.new_bool(var_order), 'set_date_modified', [rt.call_function('time', []rt.PhpVal{})])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class()]), 'feature_is_enabled', []rt.PhpVal{})) && rt.is_true(rt.call_method(rt.new_bool(var_order), 'has_cogs', []rt.PhpVal{})) {
		rt.call_method(rt.new_bool(var_order), 'calculate_cogs_total_value', []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_method(rt.new_bool(var_order), 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_function('do_action', [rt.new_string('woocommerce_refund_created'), var_refund.get_id(), var_args.clone()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_function('do_action', [rt.new_string('woocommerce_order_refunded'), rt.call_method(rt.new_bool(var_order), 'get_id', []rt.PhpVal{}), var_refund.get_id()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		var_e = var_e_2.clone()
		if !(var_refund).is_null() && rt.is_true(rt.call_function('is_a', [var_refund, rt.new_string('WC_Order_Refund')])) {
			var_refund.delete(rt.new_bool(true))
		}
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return mut var_refund
}

fn wc_refund_payment(var_order rt.PhpVal, var_amount rt.PhpVal, reason string) bool {
	mut var_reason := reason
	mut var_gateway_controller := rt.new_null()
	mut var_all_gateways := rt.new_null()
	mut var_payment_method := rt.new_null()
	mut var_gateway := rt.new_null()
	mut var_result := rt.new_null()
	mut var_e := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_order.clone(), rt.new_string('WC_Order')]))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid order.'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut iife_temp_13 := Class_WC_Payment_Gateways{}
	mut iife_result_13 := iife_temp_13.instance()
	var_gateway_controller = iife_result_13
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	var_all_gateways = rt.call_method(var_gateway_controller, 'payment_gateways', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	var_payment_method = rt.call_method(var_order, 'get_payment_method', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	var_gateway = if var_all_gateways.array_isset(var_payment_method) { var_all_gateways.array_get(var_payment_method) } else { rt.new_bool(false) }
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_gateway)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('The payment gateway for this order does not exist.'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_gateway, 'supports', [Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.refunds()]))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('The payment gateway for this order does not support automatic refunds.'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	var_result = rt.call_method(var_gateway, 'process_refund', [rt.call_method(var_order, 'get_id', []rt.PhpVal{}), var_amount.clone(), rt.new_string(reason)])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('An error occurred while attempting to create the refund using the payment gateway API.'), rt.new_string('woocommerce')]))))
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	return true
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		var_e = var_e_3.clone()
		return (create_wp_error(rt.new_string('error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))).to_bool()
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return false
}

fn wc_restock_refunded_items(var_order rt.PhpVal, var_refunded_line_items rt.PhpVal) {
	mut var_line_items := rt.new_null()
	mut var_item := rt.new_null()
	mut var_item_id := rt.new_null()
	mut var_product := rt.new_null()
	mut var_item_stock_reduced := rt.new_null()
	mut var_restock_refunded_items := rt.new_null()
	mut var_qty_to_refund := rt.new_null()
	mut var_old_stock := rt.new_null()
	mut var_new_stock := rt.new_null()
	mut var_restock_note := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_can_restock_refunded_items'), rt.new_bool(true), var_order.clone(), var_refunded_line_items.clone()]))))) {
		return
	}
	var_line_items = rt.call_method(var_order, 'get_items', []rt.PhpVal{})
	mut iter_15 := var_line_items.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_item_shadow := item_15.val
		mut var_item_id_shadow := item_15.key
		if !(var_refunded_line_items.array_isset(var_item_id_shadow) && var_refunded_line_items.array_get(var_item_id_shadow).array_isset(rt.new_string('qty'))) {
			continue
		}
		var_product = rt.call_method(var_item_shadow, 'get_product', []rt.PhpVal{})
		var_item_stock_reduced = rt.call_method(var_item_shadow, 'get_meta', [rt.new_string('_reduced_stock'), rt.new_bool(true)])
		var_restock_refunded_items = rt.new_int((rt.call_method(var_item_shadow, 'get_meta', [rt.new_string('_restock_refunded_items'), rt.new_bool(true)])).to_i64())
		var_qty_to_refund = var_refunded_line_items.array_get(var_item_id_shadow).array_get(rt.new_string('qty'))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_item_stock_reduced)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_qty_to_refund)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'managing_stock', []rt.PhpVal{}))))) {
			continue
		}
		var_old_stock = rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{})
		var_new_stock = rt.call_function('wc_update_product_stock', [var_product.clone(), var_qty_to_refund.clone(), rt.new_string('increase')])
		var_item_stock_reduced = rt.sub(var_item_stock_reduced, var_qty_to_refund)
		rt.call_method(var_item_shadow, 'update_meta_data', [rt.new_string('_reduced_stock'), var_item_stock_reduced.clone()])
		rt.call_method(var_item_shadow, 'update_meta_data', [rt.new_string('_restock_refunded_items'), rt.add(var_qty_to_refund, var_restock_refunded_items)])
		var_restock_note = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Item #%1$s stock increased from %2$s to %3$s.'), rt.new_string('woocommerce')]), rt.call_method(var_product, 'get_id', []rt.PhpVal{}), var_old_stock.clone(), var_new_stock.clone()])
		var_restock_note = rt.call_function('apply_filters', [rt.new_string('woocommerce_refund_restock_note'), var_restock_note.clone(), var_old_stock.clone(), var_new_stock.clone(), var_order.clone(), var_product.clone()])
		rt.call_method(var_order, 'add_order_note', [var_restock_note.clone(), rt.new_bool(false), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.product_stock() }])])
		rt.call_method(var_item_shadow, 'save', []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('woocommerce_restock_refunded_item'), rt.call_method(var_product, 'get_id', []rt.PhpVal{}), var_old_stock.clone(), var_new_stock.clone(), var_order.clone(), var_product.clone()])
	}
}

fn wc_get_tax_class_by_tax_id(var_tax_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT tax_rate_class FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_tax_rates WHERE tax_rate_id = %d')), var_tax_id.clone()])])
}

fn wc_get_payment_gateway_by_order(var_order_arg rt.PhpVal) rt.PhpVal {
	mut var_order := var_order_arg
	mut var_payment_gateways := rt.new_null()
	mut var_order_id := rt.new_null()
	if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})) {
	var_payment_gateways = rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{}), 'payment_gateways', []rt.PhpVal{})
	} else {
	var_payment_gateways = rt.new_array()
	}
	if !(rt.new_bool(var_order).clone().is_object()) {
	var_order_id = rt.call_function('absint', [rt.new_bool(var_order).clone()])
	var_order = wc_get_order(var_order_id.clone())
	}
	return if rt.is_true(rt.call_function('is_a', [rt.new_bool(var_order).clone(), rt.new_string('WC_Order')])) && var_payment_gateways.array_isset(rt.call_method(rt.new_bool(var_order), 'get_payment_method', []rt.PhpVal{})) { var_payment_gateways.array_get(rt.call_method(rt.new_bool(var_order), 'get_payment_method', []rt.PhpVal{})) } else { rt.new_bool(false) }
}

fn wc_order_fully_refunded(var_order_id rt.PhpVal) {
	mut var_order := false
	mut var_max_refund := rt.new_null()
	var_order = wc_get_order(var_order_id.clone())
	var_max_refund = rt.call_function('wc_format_decimal', [rt.sub(rt.call_method(rt.new_bool(var_order), 'get_total', []rt.PhpVal{}), rt.call_method(rt.new_bool(var_order), 'get_total_refunded', []rt.PhpVal{}))])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_max_refund)))) {
		return
	}
	rt.call_function('wc_switch_to_site_locale', []rt.PhpVal{})
	wc_create_refund(rt.create_array([rt.ArrayItem{ key: 'amount', val: var_max_refund }, rt.ArrayItem{ key: 'reason', val: rt.call_function('__', [rt.new_string('Order fully refunded.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'order_id', val: var_order_id }, rt.ArrayItem{ key: 'line_items', val: rt.new_array() }]))
	rt.call_function('wc_restore_locale', []rt.PhpVal{})
	rt.call_method(rt.new_bool(var_order), 'add_order_note', [rt.call_function('__', [rt.new_string('Order status set to refunded. To return funds to the customer you will need to issue a refund through your payment gateway.'), rt.new_string('woocommerce')]), rt.new_bool(false), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'note_group', val: Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup.order_update() }])])
}

fn wc_order_search(var_term rt.PhpVal) rt.PhpVal {
	mut var_data_store := rt.new_null()
	mut iife_temp_14 := Class_WC_Data_Store{}
	mut iife_result_14 := iife_temp_14.load(rt.new_string('order'))
	var_data_store = iife_result_14
	return rt.call_method(var_data_store, 'search_orders', [rt.call_function('str_replace', [rt.new_string('Order #'), rt.new_string(''), rt.call_function('wc_clean', [var_term.clone()])])])
}

fn wc_update_total_sales_counts(var_order_id rt.PhpVal) {
	mut var_order := false
	mut var_recorded_sales := rt.new_null()
	mut var_reflected_order := rt.new_null()
	mut var_operation := ''
	mut var_line_items := rt.new_null()
	mut var_data_store := rt.new_null()
	mut var_item := rt.new_null()
	mut var_product_id := rt.new_null()
	var_order = wc_get_order(var_order_id.clone())
	if !(var_order) {
		return
	}
	var_recorded_sales = rt.call_method(rt.call_method(rt.new_bool(var_order), 'get_data_store', []rt.PhpVal{}), 'get_recorded_sales', [rt.new_bool(var_order).clone()])
	var_reflected_order = rt.call_function('in_array', [rt.call_method(rt.new_bool(var_order), 'get_status', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.cancelled() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash() }]), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_reflected_order)))) && rt.is_true(rt.identical(rt.new_string('woocommerce_before_delete_order'), rt.call_function('current_action', []rt.PhpVal{}))) {
	var_reflected_order = rt.new_bool(true)
	}
	if rt.is_true(rt.is_true(var_recorded_sales) != rt.is_true(var_reflected_order)) {
		return
	}
	var_operation = if rt.is_true(var_recorded_sales) && rt.is_true(var_reflected_order) { 'decrease' } else { 'increase' }
	var_line_items = rt.call_method(rt.new_bool(var_order), 'get_items', []rt.PhpVal{})
	if var_line_items.clone().array_count() > 0 {
		mut iife_temp_15 := Class_WC_Data_Store{}
		mut iife_result_15 := iife_temp_15.load(rt.new_string('product'))
		var_data_store = iife_result_15
		mut iter_16 := var_line_items.iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_item_shadow := item_16.val
			var_product_id = rt.call_method(var_item_shadow, 'get_product_id', []rt.PhpVal{})
			if rt.is_true(var_product_id) {
				rt.call_method(var_data_store, 'update_product_sales', [var_product_id.clone(), rt.call_function('absint', [rt.call_method(var_item_shadow, 'get_quantity', []rt.PhpVal{})]), rt.new_string((var_operation).str()).clone()])
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_string('decrease'), rt.new_string((var_operation).str()))) {
		rt.call_method(rt.call_method(rt.new_bool(var_order), 'get_data_store', []rt.PhpVal{}), 'set_recorded_sales', [rt.new_bool(var_order).clone(), rt.new_bool(false)])
	} else {
		rt.call_method(rt.call_method(rt.new_bool(var_order), 'get_data_store', []rt.PhpVal{}), 'set_recorded_sales', [rt.new_bool(var_order).clone(), rt.new_bool(true)])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_recorded_sales'), var_order_id.clone()])
}

fn wc_update_coupon_usage_counts(var_order_id rt.PhpVal) {
	mut var_order := false
	mut var_has_recorded := rt.new_null()
	mut var_invalid_statuses := rt.new_null()
	mut var_action := ''
	mut var_code := rt.new_null()
	mut var_coupon := rt.new_null()
	mut var_used_by := rt.new_null()
	var_order = wc_get_order(var_order_id.clone())
	if !(var_order) {
		return
	}
	var_has_recorded = rt.call_method(rt.call_method(rt.new_bool(var_order), 'get_data_store', []rt.PhpVal{}), 'get_recorded_coupon_usage_counts', [rt.new_bool(var_order).clone()])
	var_invalid_statuses = rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.cancelled() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.failed() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash() }])
	var_invalid_statuses = rt.call_function('apply_filters', [rt.new_string('woocommerce_update_coupon_usage_invalid_statuses'), var_invalid_statuses.clone()])
	if rt.is_true(rt.call_method(rt.new_bool(var_order), 'has_status', [var_invalid_statuses.clone()])) && rt.is_true(var_has_recorded) {
		var_action = 'reduce'
		rt.call_method(rt.call_method(rt.new_bool(var_order), 'get_data_store', []rt.PhpVal{}), 'set_recorded_coupon_usage_counts', [rt.new_bool(var_order).clone(), rt.new_bool(false)])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.new_bool(var_order), 'has_status', [var_invalid_statuses.clone()]))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_recorded)))) {
		var_action = 'increase'
		rt.call_method(rt.call_method(rt.new_bool(var_order), 'get_data_store', []rt.PhpVal{}), 'set_recorded_coupon_usage_counts', [rt.new_bool(var_order).clone(), rt.new_bool(true)])
	} else if rt.is_true(rt.call_method(rt.new_bool(var_order), 'has_status', [var_invalid_statuses.clone()])) {
		rt.call_function('wc_release_coupons_for_order', [rt.new_bool(var_order).clone()])
		return
	} else {
		return
	}
	if rt.call_method(rt.new_bool(var_order), 'get_coupon_codes', []rt.PhpVal{}).array_count() > 0 {
		mut iter_17 := rt.call_method(rt.new_bool(var_order), 'get_coupon_codes', []rt.PhpVal{}).iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_code_shadow := item_17.val
			mut iife_temp_16 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
			mut iife_result_16 := iife_temp_16.is_null_or_whitespace(var_code_shadow.clone())
			if rt.is_true(iife_result_16) {
				continue
			}
			var_coupon = create_wc_coupon(var_code_shadow.clone())
			var_used_by = rt.call_method(rt.new_bool(var_order), 'get_user_id', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(!(rt.is_true(var_used_by)))) {
			var_used_by = rt.call_method(rt.new_bool(var_order), 'get_billing_email', []rt.PhpVal{})
			}
			mut switch_val_2 := rt.new_string((var_action).str())
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('reduce'))) {
				var_coupon.decrease_usage_count(var_used_by.clone())
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('increase'))) {
				var_coupon.increase_usage_count(var_used_by.clone(), rt.new_bool(var_order))
			}
		}
		rt.call_function('wc_release_coupons_for_order', [rt.new_bool(var_order).clone()])
	}
}

fn wc_cancel_unpaid_orders() {
	mut var_held_duration := rt.new_null()
	mut var_cancel_unpaid_interval := rt.new_null()
	mut var_data_store := rt.new_null()
	mut var_unpaid_orders := rt.new_null()
	mut var_unpaid_order := rt.new_null()
	mut var_order := false
	var_held_duration = rt.call_function('get_option', [rt.new_string('woocommerce_hold_stock_minutes'), rt.new_string('60')])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('as_unschedule_all_actions')])) {
		rt.call_function('as_unschedule_all_actions', [rt.new_string('woocommerce_cancel_unpaid_orders')])
	}
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_cancel_unpaid_orders')])
	if rt.is_true(rt.less(var_held_duration, rt.new_int(1))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_manage_stock')]))))) {
		return
	}
	var_cancel_unpaid_interval = rt.call_function('apply_filters', [rt.new_string('woocommerce_cancel_unpaid_orders_interval_minutes'), rt.call_function('absint', [var_held_duration.clone()])])
	if rt.is_true(rt.less(var_cancel_unpaid_interval, rt.new_int(1))) {
		return
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('as_schedule_single_action')])) {
		rt.call_function('as_schedule_single_action', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.call_function('absint', [var_cancel_unpaid_interval.clone()]), rt.new_int(60))), rt.new_string('woocommerce_cancel_unpaid_orders'), rt.new_array(), rt.new_string('woocommerce'), rt.new_bool(false)])
	} else {
		rt.call_function('wp_schedule_single_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.call_function('absint', [var_cancel_unpaid_interval.clone()]), rt.new_int(60))), rt.new_string('woocommerce_cancel_unpaid_orders')])
	}
	mut iife_temp_17 := Class_WC_Data_Store{}
	mut iife_result_17 := iife_temp_17.load(rt.new_string('order'))
	var_data_store = iife_result_17
	var_unpaid_orders = rt.call_method(var_data_store, 'get_unpaid_orders', [rt.call_function('strtotime', [rt.new_string('-' + (rt.call_function('absint', [var_held_duration.clone()])).str() + ' MINUTES'), rt.call_function('current_time', [rt.new_string('timestamp')])])])
	if rt.is_true(var_unpaid_orders) {
		mut iter_18 := var_unpaid_orders.iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_unpaid_order_shadow := item_18.val
			var_order = wc_get_order(var_unpaid_order_shadow.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_bool(var_order), 'WC_Order')))))) {
				continue
			}
			if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_cancel_unpaid_order'), rt.call_function('in_array', [rt.call_method(rt.new_bool(var_order), 'get_created_via', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: 'checkout' }, rt.ArrayItem{ key: none, val: 'store-api' }]), rt.new_bool(true)]), rt.new_bool(var_order).clone()])) {
				rt.call_method(rt.new_bool(var_order), 'update_status', [Class_Automattic_WooCommerce_Enums_OrderStatus.cancelled(), rt.call_function('__', [rt.new_string('Unpaid order cancelled - time limit reached.'), rt.new_string('woocommerce')])])
			}
		}
	}
}

fn wc_sanitize_order_id(var_order_id rt.PhpVal) i64 {
	return rt.new_int((rt.call_function('filter_var', [var_order_id.clone(), rt.get_constant('FILTER_SANITIZE_NUMBER_INT')])).to_i64())
}

fn wc_get_order_note(var_data_arg rt.PhpVal) rt.PhpVal {
	mut var_data := var_data_arg
	if rt.is_true(rt.new_bool(var_data.clone().is_long() || var_data.clone().is_double())) {
	var_data = rt.call_function('get_comment', [var_data.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_data.clone(), rt.new_string('WP_Comment')]))))) {
		return rt.new_null()
	}
	return rt.new_object('stdClass', []string{}, rt.array_to_object(rt.call_function('apply_filters', [rt.new_string('woocommerce_get_order_note'), rt.create_array([rt.ArrayItem{ key: 'id', val: rt.new_int((rt.get_property(var_data, 'comment_ID')).to_i64()) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_string_to_datetime', [rt.get_property(var_data, 'comment_date')]) }, rt.ArrayItem{ key: 'content', val: rt.get_property(var_data, 'comment_content') }, rt.ArrayItem{ key: 'customer_note', val: (rt.call_function('get_comment_meta', [rt.get_property(var_data, 'comment_ID'), rt.new_string('is_customer_note'), rt.new_bool(true)])).to_bool() }, rt.ArrayItem{ key: 'added_by', val: if rt.is_true(rt.identical(rt.call_function('__', [rt.new_string('WooCommerce'), rt.new_string('woocommerce')]), rt.get_property(var_data, 'comment_author'))) { rt.new_string('system') } else { rt.get_property(var_data, 'comment_author') } }, rt.ArrayItem{ key: 'order_id', val: rt.call_function('absint', [rt.get_property(var_data, 'comment_post_ID')]) }]), var_data.clone()])))
}

fn wc_get_order_notes(var_args rt.PhpVal) rt.PhpVal {
	mut var_key_mapping := map[string]rt.PhpVal{}
	mut var_db_key := rt.new_null()
	mut var_query_key := rt.new_null()
	mut var_orderby_mapping := map[string]rt.PhpVal{}
	mut var_notes := rt.new_null()
	var_key_mapping = { 'limit': 'number', 'order_id': 'post_id', 'order__in': 'post__in', 'order__not_in': 'post__not_in' }
	for var_query_key_shadow, var_db_key_shadow in var_key_mapping {
		if var_args.array_isset(rt.new_string((var_query_key_shadow).str())) {
			var_args.array_set(rt.new_string((var_db_key_shadow).str()), var_args.array_get(rt.new_string((var_query_key_shadow).str())))
			var_args.array_unset(rt.new_string((var_query_key_shadow).str()))
		}
	}
	var_orderby_mapping = { 'date_created': 'comment_date', 'date_created_gmt': 'comment_date_gmt', 'id': 'comment_ID' }
	var_args.array_set('orderby', if !(!rt.is_true(var_args.array_get(rt.new_string('orderby')))) && rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('orderby')), rt.create_array([rt.ArrayItem{ key: none, val: 'date_created' }, rt.ArrayItem{ key: none, val: 'date_created_gmt' }, rt.ArrayItem{ key: none, val: 'id' }]), rt.new_bool(true)])) { var_orderby_mapping[var_args.array_get(rt.new_string('orderby'))] } else { 'comment_ID' })
	if var_args.array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.new_string('customer'), var_args.array_get(rt.new_string('type')))) {
		var_args.array_set('meta_query', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: 'is_customer_note' }, rt.ArrayItem{ key: 'value', val: 1 }, rt.ArrayItem{ key: 'compare', val: '=' }]) }]))
	} else if var_args.array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.new_string('internal'), var_args.array_get(rt.new_string('type')))) {
		var_args.array_set('meta_query', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: 'is_customer_note' }, rt.ArrayItem{ key: 'compare', val: 'NOT EXISTS' }]) }]))
	}
	var_args.array_set('type', 'order_note')
	var_args.array_set('status', 'approve')
	var_args.array_unset(rt.new_string('count'))
	var_args.array_unset(rt.new_string('fields'))
	rt.call_function('remove_filter', [rt.new_string('comments_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Comments' }, rt.ArrayItem{ key: none, val: 'exclude_order_comments' }]), rt.new_int(10), rt.new_int(1)])
	var_notes = rt.call_function('get_comments', [var_args.clone()])
	rt.call_function('add_filter', [rt.new_string('comments_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Comments' }, rt.ArrayItem{ key: none, val: 'exclude_order_comments' }]), rt.new_int(10), rt.new_int(1)])
	return rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('wc_get_order_note'), var_notes.clone()])])
}

fn wc_create_order_note(var_order_id rt.PhpVal, var_note rt.PhpVal, is_customer_note bool, added_by_user bool) rt.PhpVal {
	mut var_is_customer_note := is_customer_note
	mut var_added_by_user := added_by_user
	mut var_order := false
	var_order = wc_get_order(var_order_id.clone())
	if !(var_order) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_order_id'), rt.call_function('__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	return rt.call_method(rt.new_bool(var_order), 'add_order_note', [var_note.clone(), rt.new_int(i64(is_customer_note)), rt.new_bool(added_by_user)])
}

fn wc_delete_order_note(var_note_id rt.PhpVal) bool {
	mut var_note := rt.new_null()
	var_note = wc_get_order_note(var_note_id.clone())
	if rt.is_true(var_note) && rt.is_true(rt.call_function('wp_delete_comment', [var_note_id.clone(), rt.new_bool(true)])) {
		rt.call_function('do_action', [rt.new_string('woocommerce_order_note_deleted'), var_note_id.clone(), var_note.clone()])
		return true
	}
	return false
}

fn wc_wptexturize_order_note(var_content rt.PhpVal) rt.PhpVal {
	mut var_urls := []rt.PhpVal{}
	mut var_url_pattern := ''
	mut var_unique_urls := rt.new_null()
	mut var_placeholders := rt.new_null()
	mut var_placeholder_content := rt.new_null()
	mut var_url := rt.new_null()
	mut var_index := rt.new_null()
	mut var_placeholder := rt.new_null()
	mut var_texturized_content := rt.new_null()
	var_url_pattern = '/\\b(?:https?):\\/\\/[^\\s<>"{}|\\^`\\[\\]]+/i'
	rt.call_function('preg_match_all', [rt.new_string((var_url_pattern).str()).clone(), var_content.clone(), rt.create_array_from_list(var_urls)])
	if !rt.is_true(var_urls[0]) {
		return rt.call_function('wptexturize', [var_content.clone()])
	}
	var_unique_urls = rt.call_function('array_unique', [var_urls[0]])
	var_placeholders = rt.new_array()
	var_placeholder_content = var_content
	mut iter_19 := var_unique_urls.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_url_shadow := item_19.val
		mut var_index_shadow := item_19.key
		var_placeholder = rt.call_function('sprintf', [rt.new_string('___WC_URL_PLACEHOLDER_%d___'), var_index_shadow.clone()])
		var_placeholders.array_set(var_placeholder, var_url_shadow.clone())
	var_placeholder_content = rt.call_function('str_replace', [var_url_shadow.clone(), var_placeholder.clone(), var_placeholder_content.clone()])
	}
	var_texturized_content = rt.call_function('wptexturize', [var_placeholder_content.clone()])
	return rt.call_function('str_replace', [rt.func_array_keys(var_placeholders.clone()), rt.call_function('array_values', [var_placeholders.clone()]), var_texturized_content.clone()])
}

struct Class_WC_Order_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Caches_OrderCountCache {
	rt.PhpObjectBase
}

struct Class_WC_Customer_Download {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WC_Order_Refund {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Payment_Gateways {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_WC_Coupon {
	rt.PhpObjectBase
}

fn create_wc_order_query(_args ...rt.PhpVal) &Class_WC_Order_Query {
	mut obj := &Class_WC_Order_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
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

fn create_automattic_woocommerce_caches_ordercountcache(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Caches_OrderCountCache {
	mut obj := &Class_Automattic_WooCommerce_Caches_OrderCountCache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer_download(_args ...rt.PhpVal) &Class_WC_Customer_Download {
	mut obj := &Class_WC_Customer_Download{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
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

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_order_refund(_args ...rt.PhpVal) &Class_WC_Order_Refund {
	mut obj := &Class_WC_Order_Refund{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_payment_gateways(_args ...rt.PhpVal) &Class_WC_Payment_Gateways {
	mut obj := &Class_WC_Payment_Gateways{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_coupon(_args ...rt.PhpVal) &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Caches_OrderCountCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Caches_OrderCountCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Customer_Download) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer_Download) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer_Download) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Order_Refund) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Refund) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Refund) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Payment_Gateways) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Payment_Gateways) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Gateways) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WC_Order_Query', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_order_query()
		return rt.new_object('WC_Order_Query', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_OrderUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_orderutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_OrderUtil', []string{}, obj)
	})
	rt.register_class_factory('WC_Data_Store', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_data_store()
		return rt.new_object('WC_Data_Store', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Caches_OrderCountCache', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_caches_ordercountcache()
		return rt.new_object('Automattic_WooCommerce_Caches_OrderCountCache', []string{}, obj)
	})
	rt.register_class_factory('WC_Customer_Download', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_customer_download()
		return rt.new_object('WC_Customer_Download', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Utilities_Users', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_utilities_users()
		return rt.new_object('Automattic_WooCommerce_Internal_Utilities_Users', []string{}, obj)
	})
	rt.register_class_factory('WC_Cache_Helper', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_cache_helper()
		return rt.new_object('WC_Cache_Helper', []string{}, obj)
	})
	rt.register_class_factory('Exception', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_exception(c_arg_0)
		return rt.new_object('Exception', []string{}, obj)
	})
	rt.register_class_factory('WC_Order_Refund', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_order_refund()
		return rt.new_object('WC_Order_Refund', []string{}, obj)
	})
	rt.register_class_factory('WP_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
	rt.register_class_factory('WC_Payment_Gateways', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_payment_gateways()
		return rt.new_object('WC_Payment_Gateways', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_StringUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_stringutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_StringUtil', []string{}, obj)
	})
	rt.register_class_factory('WC_Coupon', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_coupon()
		return rt.new_object('WC_Coupon', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_completed'), rt.new_string('wc_downloadable_product_permissions')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_processing'), rt.new_string('wc_downloadable_product_permissions')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_refunded'), rt.new_string('wc_order_fully_refunded')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_completed'), rt.new_string('wc_update_total_sales_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_processing'), rt.new_string('wc_update_total_sales_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_on-hold'), rt.new_string('wc_update_total_sales_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_completed_to_cancelled'), rt.new_string('wc_update_total_sales_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_processing_to_cancelled'), rt.new_string('wc_update_total_sales_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_on-hold_to_cancelled'), rt.new_string('wc_update_total_sales_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_trash_order'), rt.new_string('wc_update_total_sales_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_untrash_order'), rt.new_string('wc_update_total_sales_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_delete_order'), rt.new_string('wc_update_total_sales_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_pending'), rt.new_string('wc_update_coupon_usage_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_completed'), rt.new_string('wc_update_coupon_usage_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_processing'), rt.new_string('wc_update_coupon_usage_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_on-hold'), rt.new_string('wc_update_coupon_usage_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_cancelled'), rt.new_string('wc_update_coupon_usage_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_failed'), rt.new_string('wc_update_coupon_usage_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_trash_order'), rt.new_string('wc_update_coupon_usage_counts')])
	rt.call_function('add_action', [rt.new_string('woocommerce_cancel_unpaid_orders'), rt.new_string('wc_cancel_unpaid_orders')])
	rt.call_function('add_filter', [rt.new_string('woocommerce_shortcode_order_tracking_order_id'), rt.new_string('wc_sanitize_order_id')])
}
