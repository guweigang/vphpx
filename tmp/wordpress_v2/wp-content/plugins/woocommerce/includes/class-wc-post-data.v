import rt

struct Class_WC_Post_Data {
	rt.PhpObjectBase
}

fn init_static_wc_post_data() {
	rt.init_static_prop('WC_Post_Data', 'editing_term', rt.new_null())
}

fn Class_WC_Post_Data.init() {
	rt.call_function('add_action', [rt.new_string('clean_post_cache'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'invalidate_products_last_modified' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('clean_post_cache'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'invalidate_db_block_templates_cache' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('post_type_link'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'variation_post_link' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('shutdown'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'do_deferred_product_sync' }]),
		rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('set_object_terms'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'force_default_term' }]),
		rt.new_int(10), rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('set_object_terms'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_product_query_transients' }])])
	rt.call_function('add_action', [rt.new_string('set_object_terms'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'recount_terms_for_product_visibility_change' }]),
		rt.new_int(10), rt.new_int(6)])
	rt.call_function('add_action', [rt.new_string('deleted_term_relationships'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_product_query_transients' }])])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_product_set_stock_status'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_product_query_transients' }]),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_product_set_visibility'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_product_query_transients' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_product_type_changed'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'product_type_changed' }]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('edit_term'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'edit_term' }]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('edited_term'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'edited_term' }]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('update_order_item_metadata'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'update_order_item_metadata' }]),
		rt.new_int(10), rt.new_int(5)])
	rt.call_function('add_filter', [rt.new_string('update_post_metadata'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'update_post_metadata' }]),
		rt.new_int(10), rt.new_int(5)])
	rt.call_function('add_filter', [rt.new_string('wp_insert_post_data'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'wp_insert_post_data' }])])
	rt.call_function('add_filter', [rt.new_string('oembed_response_data'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'filter_oembed_response_data' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('wp_untrash_post_status'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'wp_untrash_post_status' }]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('transition_post_status'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'transition_post_status' }]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('delete_post'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_post_data' }])])
	rt.call_function('add_action', [rt.new_string('wp_trash_post'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'trash_post' }])])
	rt.call_function('add_action', [rt.new_string('untrashed_post'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'untrash_post' }])])
	rt.call_function('add_action', [rt.new_string('before_delete_post'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'before_delete_order' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_delete_order'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'before_delete_order' }])])
	rt.call_function('add_action', [rt.new_string('updated_post_meta'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'flush_object_meta_cache' }]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('added_post_meta'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'flush_object_meta_cache' }]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('deleted_post_meta'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'flush_object_meta_cache' }]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('updated_order_item_meta'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'flush_object_meta_cache' }]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('woocommerce_attribute_updated'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'handle_global_attribute_updated' }]),
		rt.new_int(50), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_attribute_deleted'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'handle_global_attribute_updated' }]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('edited_term'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'handle_attribute_term_updated' }]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('delete_term'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'handle_attribute_term_deleted' }]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_product_attributes_updated'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'on_product_attributes_updated' }]),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_action', [
		rt.new_string('wc_regenerate_product_variation_summaries'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'regenerate_product_variation_summaries' }]),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_action', [
		rt.new_string('wc_regenerate_attribute_variation_summaries'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'regenerate_attribute_variation_summaries' }]),
		rt.new_int(10),
		rt.new_int(1),
	])
	rt.call_function('add_action', [
		rt.new_string('wc_regenerate_term_variation_summaries'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'regenerate_term_variation_summaries' }]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn Class_WC_Post_Data.variation_post_link(var_permalink rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	if !(rt.get_property(var_post, 'ID')).is_null()
		&& !(rt.get_property(var_post, 'post_type')).is_null()
		&& rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(var_post, 'post_type'))) {
		mut var_variation := rt.call_function('wc_get_product', [
			rt.get_property(var_post, 'ID'),
		])
		if rt.is_true(var_variation)
			&& rt.is_true(rt.call_method(var_variation, 'get_parent_id', []rt.PhpVal{})) {
			return rt.call_method(var_variation, 'get_permalink', []rt.PhpVal{})
		}
	}
	return var_permalink.clone()
}

fn Class_WC_Post_Data.do_deferred_product_sync() {
	mut var_wc_deferred_product_sync := rt.get_superglobal('wc_deferred_product_sync')
	if !(!rt.is_true(var_wc_deferred_product_sync)) {
		var_wc_deferred_product_sync = rt.call_function('wp_parse_id_list', [
			var_wc_deferred_product_sync.clone()])
		rt.call_function('array_walk', [var_wc_deferred_product_sync.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'deferred_product_sync' }])])
	}
}

fn Class_WC_Post_Data.deferred_product_sync(var_product_id rt.PhpVal) {
	mut var_product := rt.call_function('wc_get_product', [var_product_id.clone()])
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_product },
			rt.ArrayItem{ key: none, val: 'sync' }]),
	]))
	{
		rt.call_method(var_product, 'sync', [var_product.clone()])
	}
}

fn Class_WC_Post_Data.transition_post_status(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal) {
	mut var_new_status_mutated := var_new_status
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), var_new_status_mutated))
		|| rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), var_old_status))
		&& rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'product'
	}, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)])) {
		Class_WC_Post_Data.delete_product_query_transients()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), var_new_status_mutated))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), var_old_status))))
		&& rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'product'
	}, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)])) {
		rt.call_function('do_action', [rt.new_string('woocommerce_product_published'),
			rt.get_property(var_post, 'ID')])
	}
}

fn Class_WC_Post_Data.delete_product_query_transients() {
	mut iife_temp_0 := Class_WC_Cache_Helper{}
	mut iife_result_0 := iife_temp_0.get_transient_version(rt.new_string('product_query'),
		rt.new_bool(true))
}

fn Class_WC_Post_Data.invalidate_products_last_modified(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))
		&& rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'product'
	}, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)])) {
		rt.call_function('wp_cache_delete', [rt.new_string('last_modified'),
			rt.new_string('wc_products')])
	}
}

fn Class_WC_Post_Data.invalidate_db_block_templates_cache(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))
		&& rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'wp_template_part'
	}, rt.ArrayItem{ key: none, val: 'wp_template' }]), rt.new_bool(true)])) {
		rt.call_function('wp_cache_delete', [
			rt.new_string((rt.get_property(var_post, 'post_type')).str() + '-ids'),
			rt.new_string('woocommerce_blocks'),
		])
	}
}

fn Class_WC_Post_Data.product_type_changed(var_product rt.PhpVal, var_from rt.PhpVal, var_to rt.PhpVal) {
	mut var_product_mutated := var_product
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_delete_variations_on_product_type_change'),
		rt.new_bool(
			rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variable(), var_from))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variable(), var_to))))),
		var_product_mutated.clone(),
		var_from.clone(),
		var_to.clone(),
	]))
	{
		mut iife_temp_1 := Class_WC_Data_Store{}
		mut iife_result_1 := iife_temp_1.load(rt.new_string('product-variable'))
		mut var_data_store := iife_result_1
		rt.call_method(var_data_store, 'delete_variations', [
			rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}),
			rt.new_bool(true),
		])
	}
}

fn Class_WC_Post_Data.edit_term(var_term_id rt.PhpVal, var_tt_id rt.PhpVal, var_taxonomy rt.PhpVal) {
	mut var_taxonomy_mutated := var_taxonomy
	if rt.is_true(rt.identical(rt.call_function('strpos', [var_taxonomy_mutated.clone(),
		rt.new_string('pa_')]), rt.new_int(0)))
	{
		rt.set_static_prop('WC_Post_Data', 'editing_term', rt.call_function('get_term_by', [
			rt.new_string('id'),
			var_term_id.clone(),
			var_taxonomy_mutated.clone(),
		]))
	} else {
		rt.set_static_prop('WC_Post_Data', 'editing_term', rt.new_null())
	}
}

fn Class_WC_Post_Data.edited_term(var_term_id rt.PhpVal, var_tt_id rt.PhpVal, var_taxonomy rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_taxonomy_mutated := var_taxonomy
	if !(rt.get_static_prop('WC_Post_Data', 'editing_term').is_null())
		&& rt.is_true(rt.identical(rt.call_function('strpos', [var_taxonomy_mutated.clone(), rt.new_string('pa_')]), rt.new_int(0))) {
		mut var_edited_term := rt.call_function('get_term_by', [
			rt.new_string('id'), var_term_id.clone(), var_taxonomy_mutated.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_edited_term, 'slug'), rt.get_property(rt.get_static_prop('WC_Post_Data',
			'editing_term'), 'slug')))))
		{
			rt.call_method(var_wpdb, 'query', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb,
						'postmeta')),
						rt.new_string(' SET meta_value = %s WHERE meta_key = %s AND meta_value = %s;')),
					rt.get_property(var_edited_term, 'slug'),
					rt.new_string('attribute_' +
						(rt.call_function('sanitize_title', [var_taxonomy_mutated.clone()])).str()),
					rt.get_property(rt.get_static_prop('WC_Post_Data', 'editing_term'), 'slug'),
				]),
			])
			rt.call_method(var_wpdb, 'query', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb,
						'postmeta')),
						rt.new_string(" SET meta_value = REPLACE( meta_value, %s, %s ) WHERE meta_key = '_default_attributes'")),
					rt.new_string(
						(rt.call_function('serialize', [rt.get_property(rt.get_static_prop('WC_Post_Data', 'editing_term'), 'taxonomy')])).str() +(rt.call_function('serialize', [rt.get_property(rt.get_static_prop('WC_Post_Data', 'editing_term'), 'slug')])).str()),
					rt.new_string(
						(rt.call_function('serialize', [rt.get_property(var_edited_term, 'taxonomy')])).str() +(rt.call_function('serialize', [rt.get_property(var_edited_term, 'slug')])).str()),
				]),
			])
		}
	} else {
		rt.set_static_prop('WC_Post_Data', 'editing_term', rt.new_null())
	}
}

fn Class_WC_Post_Data.update_order_item_metadata(var_check rt.PhpVal, var_object_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, var_prev_value rt.PhpVal) bool {
	mut var_meta_key_mutated := var_meta_key
	mut var_meta_value_mutated := var_meta_value
	if !(!rt.is_true(var_meta_value_mutated)) && var_meta_value_mutated.clone().is_double() {
		var_meta_value_mutated = rt.call_function('wc_float_to_string', [
			var_meta_value_mutated.clone()])
		rt.call_function('update_metadata', [rt.new_string('order_item'),
			var_object_id.clone(), var_meta_key_mutated.clone(),
			var_meta_value_mutated.clone(), var_prev_value.clone()])
		return true
	}
	return var_check.to_bool()
}

fn Class_WC_Post_Data.update_post_metadata(var_check rt.PhpVal, var_object_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, var_prev_value rt.PhpVal) bool {
	mut var_meta_key_mutated := var_meta_key
	mut var_meta_value_mutated := var_meta_value
	if rt.is_true(rt.call_function('in_array', [
		rt.call_function('get_post_type', [var_object_id.clone()]),
		rt.create_array([rt.ArrayItem{ key: none, val: 'product' },
			rt.ArrayItem{ key: none, val: 'product_variation' }]),
		rt.new_bool(true),
	]))
	{
		rt.call_function('wp_cache_delete', [
			rt.new_string('product-' + var_object_id.str()),
			rt.new_string('products'),
		])
	}
	if !(!rt.is_true(var_meta_value_mutated)) && var_meta_value_mutated.clone().is_double()
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('registered_meta_key_exists', [rt.new_string('post'), var_meta_key_mutated.clone()])))))
		&& rt.is_true(rt.call_function('in_array', [rt.call_function('get_post_type', [var_object_id.clone()]), rt.call_function('array_merge', [rt.call_function('wc_get_order_types', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{
		key: none
		val: 'shop_coupon'
	}, rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }])]), rt.new_bool(true)])) {
		var_meta_value_mutated = rt.call_function('wc_float_to_string', [
			var_meta_value_mutated.clone()])
		rt.call_function('update_metadata', [rt.new_string('post'),
			var_object_id.clone(), var_meta_key_mutated.clone(),
			var_meta_value_mutated.clone(), var_prev_value.clone()])
		return true
	}
	return var_check.to_bool()
}

fn Class_WC_Post_Data.wp_insert_post_data(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if rt.is_true(rt.identical(rt.new_string('shop_order'), var_data_mutated.array_get(rt.new_string('post_type'))))
		&& var_data_mutated.array_isset(rt.new_string('post_date')) {
		mut var_order_title := rt.new_string('Order')
		if rt.is_true(var_data_mutated.array_get(rt.new_string('post_date'))) {
			var_order_title = rt.concat(var_order_title,
				rt.new_string(' &ndash; ' +(rt.call_function('date_i18n', [rt.new_string('F j, Y @ h:i A'), rt.call_function('strtotime', [var_data_mutated.array_get(rt.new_string('post_date'))])])).str()))
		}
		var_data_mutated.array_set('post_title', var_order_title.clone())
	} else if
		rt.is_true(rt.identical(rt.new_string('product'), var_data_mutated.array_get(rt.new_string('post_type'))))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('product-type')) {
		mut var_product_type := rt.call_function('wc_clean', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('product-type'))]),
		])
		mut switch_val_1 := var_product_type
		if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Enums_ProductType.grouped()))
			|| rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Enums_ProductType.variable())) {
			var_data_mutated.array_set('post_parent', 0)
		}
	} else if
		rt.is_true(rt.identical(rt.new_string('product'), var_data_mutated.array_get(rt.new_string('post_type'))))
		&& rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.auto_draft(), var_data_mutated.array_get(rt.new_string('post_status')))) {
		var_data_mutated.array_set('post_title', 'AUTO-DRAFT')
	} else if rt.is_true(rt.identical(rt.new_string('shop_coupon'),
		var_data_mutated.array_get(rt.new_string('post_type'))))
	{
		var_data_mutated.array_set('post_title', rt.call_function('wp_filter_kses', [
			var_data_mutated.array_get(rt.new_string('post_title')),
		]))
	}
	return var_data_mutated.clone()
}

fn Class_WC_Post_Data.filter_oembed_response_data(var_data rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'shop_order' },
			rt.ArrayItem{ key: none, val: 'shop_coupon' }]),
		rt.new_bool(true)]))
	{
		return rt.new_array()
	}
	return var_data_mutated.clone()
}

fn Class_WC_Post_Data.delete_post_data(var_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_post_type := Class_WC_Post_Data.get_post_type(var_id.clone())
	mut switch_val_2 := var_post_type
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('product'))) {
		mut iife_temp_2 := Class_WC_Data_Store{}
		mut iife_result_2 := iife_temp_2.load(rt.new_string('product-variable'))
		mut var_data_store := iife_result_2
		rt.call_method(var_data_store, 'delete_variations', [
			var_id.clone(), rt.new_bool(true)])
		rt.call_method(var_data_store, 'delete_from_lookup_table', [
			var_id.clone(), rt.new_string('wc_product_meta_lookup')])
		rt.call_method(rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class(),
		]), 'on_product_deleted', [var_id.clone()])
		mut var_parent_id := rt.call_function('wp_get_post_parent_id', [
			var_id.clone()])
		if rt.is_true(var_parent_id) {
			rt.call_function('wc_delete_product_transients', [
				var_parent_id.clone()])
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('product_variation'))) {
		mut iife_temp_3 := Class_WC_Data_Store{}
		mut iife_result_3 := iife_temp_3.load(rt.new_string('product'))
		var_data_store = iife_result_3
		rt.call_method(var_data_store, 'delete_from_lookup_table', [
			var_id.clone(), rt.new_string('wc_product_meta_lookup')])
		rt.call_function('wc_delete_product_transients', [
			rt.call_function('wp_get_post_parent_id', [var_id.clone()]),
		])
		rt.call_method(rt.call_method(var_container, 'get', [
			Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class(),
		]), 'on_product_deleted', [var_id.clone()])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('shop_order')))
		|| rt.is_true(rt.equal(switch_val_2, Class_Automattic_WooCommerce_Internal_DataStores_Orders_DataSynchronizer.placeholder_order_post_type())) {
		mut var_refunds := rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
					'posts')),
					rt.new_string(" WHERE post_type = 'shop_order_refund' AND post_parent = %d")),
				var_id.clone(),
			]),
		])
		if !(var_refunds.clone().is_null()) {
			mut iter_1 := var_refunds.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_refund := item_1.val
				rt.call_function('wp_delete_post', [rt.get_property(var_refund, 'ID'),
					rt.new_bool(true)])
			}
		}
	}
}

fn Class_WC_Post_Data.delete_post(var_id rt.PhpVal) {
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()]), 'call_function', [rt.new_string('current_user_can'), rt.new_string('delete_posts')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		return
	}
	Class_WC_Post_Data.delete_post_data(var_id.clone())
}

fn Class_WC_Post_Data.trash_post(var_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		return
	}
	mut var_post_type := Class_WC_Post_Data.get_post_type(var_id.clone())
	if rt.is_true(rt.call_function('in_array', [var_post_type.clone(),
		rt.call_function('wc_get_order_types', [rt.new_string('order-count')]),
		rt.new_bool(true)]))
	{
		mut var_refunds := rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
					'posts')),
					rt.new_string(" WHERE post_type = 'shop_order_refund' AND post_parent = %d")),
				var_id.clone(),
			]),
		])
		mut iter_2 := var_refunds.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_refund := item_2.val
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'),
				rt.create_array([
					rt.ArrayItem{
						key: 'post_status'
						val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash()
					},
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'ID', val: rt.get_property(var_refund, 'ID') },
				])])
		}
		rt.call_function('wc_delete_shop_order_transients', [
			var_id.clone()])
	} else if rt.is_true(rt.identical(rt.new_string('product'), var_post_type)) {
		mut iife_temp_4 := Class_WC_Data_Store{}
		mut iife_result_4 := iife_temp_4.load(rt.new_string('product-variable'))
		mut var_data_store := iife_result_4
		rt.call_method(var_data_store, 'delete_variations', [
			var_id.clone(), rt.new_bool(false)])
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class(),
		]), 'on_product_deleted', [var_id.clone()])
	} else if rt.is_true(rt.identical(rt.new_string('product_variation'), var_post_type)) {
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class(),
		]), 'on_product_deleted', [var_id.clone()])
	}
}

fn Class_WC_Post_Data.untrash_post(var_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		return
	}
	mut var_post_type := Class_WC_Post_Data.get_post_type(var_id.clone())
	if rt.is_true(rt.call_function('in_array', [var_post_type.clone(),
		rt.call_function('wc_get_order_types', [rt.new_string('order-count')]),
		rt.new_bool(true)]))
	{
		mut var_refunds := rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb,
					'posts')),
					rt.new_string(" WHERE post_type = 'shop_order_refund' AND post_parent = %d")),
				var_id.clone(),
			]),
		])
		mut iter_3 := var_refunds.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_refund := item_3.val
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'),
				rt.create_array([
					rt.ArrayItem{
						key: 'post_status'
						val: Class_Automattic_WooCommerce_Enums_OrderInternalStatus.completed()
					},
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'ID', val: rt.get_property(var_refund, 'ID') },
				])])
		}
		rt.call_function('wc_delete_shop_order_transients', [
			var_id.clone()])
	} else if rt.is_true(rt.identical(rt.new_string('product'), var_post_type)) {
		mut iife_temp_5 := Class_WC_Data_Store{}
		mut iife_result_5 := iife_temp_5.load(rt.new_string('product-variable'))
		mut var_data_store := iife_result_5
		rt.call_method(var_data_store, 'untrash_variations', [
			var_id.clone()])
		rt.call_function('wc_product_force_unique_sku', [var_id.clone()])
		Class_WC_Post_Data.clear_global_unique_id_if_necessary(var_id.clone())
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class(),
		]), 'on_product_changed', [var_id.clone()])
	} else if rt.is_true(rt.identical(rt.new_string('product_variation'), var_post_type)) {
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class(),
		]), 'on_product_changed', [var_id.clone()])
	}
}

fn Class_WC_Post_Data.clear_global_unique_id_if_necessary(var_id rt.PhpVal) {
	mut var_product := rt.call_function('wc_get_product', [var_id.clone()])
	if rt.is_true(var_product)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_product_has_global_unique_id', [var_id.clone(), rt.call_method(var_product, 'get_global_unique_id', []rt.PhpVal{})]))))) {
		rt.call_method(var_product, 'set_global_unique_id', [
			rt.new_string('')])
		rt.call_method(var_product, 'save', []rt.PhpVal{})
	}
}

fn Class_WC_Post_Data.get_post_type(var_id rt.PhpVal) rt.PhpVal {
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()]), 'call_function', [
		rt.new_string('get_post_type'),
		var_id.clone(),
	])
}

fn Class_WC_Post_Data.before_delete_order(var_order_id rt.PhpVal) {
	mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_6 := iife_temp_6.is_order(var_order_id.clone(), rt.call_function('wc_get_order_types',
		[]rt.PhpVal{}))
	if rt.is_true(iife_result_6) {
		mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
		mut var_customer_id := if rt.call_function('is_callable', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_order },
				rt.ArrayItem{ key: none, val: 'get_customer_id' }]),
		])
		{ rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{}) } else { rt.new_int(0) }
		if rt.is_true(rt.greater(var_customer_id, rt.new_int(0)))
			&& rt.is_true(rt.identical(rt.new_string('shop_order'), rt.call_method(var_order, 'get_type', []rt.PhpVal{}))) {
			mut var_customer := create_wc_customer(var_customer_id.clone())
			mut var_order_count := var_customer.get_order_count()
			rt.post_dec(var_order_count)
			if rt.is_true(rt.identical(rt.new_int(0), var_order_count)) {
				var_customer.set_is_paying_customer(rt.new_bool(false))
				var_customer.save()
			}
			rt.call_function('delete_user_meta', [var_customer_id.clone(),
				rt.new_string('_order_count')])
			rt.call_function('delete_user_meta', [var_customer_id.clone(),
				rt.new_string('_last_order')])
		}
		Class_WC_Post_Data.delete_order_items(var_order_id.clone())
		Class_WC_Post_Data.delete_order_downloadable_permissions(var_order_id.clone())
	}
}

fn Class_WC_Post_Data.delete_order_items(var_postid rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_7 := iife_temp_7.is_order(var_postid.clone(), rt.call_function('wc_get_order_types',
		[]rt.PhpVal{}))
	if rt.is_true(iife_result_7) {
		rt.call_function('do_action', [rt.new_string('woocommerce_delete_order_items'),
			var_postid.clone()])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tDELETE '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_order_items, ')), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_order_itemmeta\n\t\t\t\tFROM ')), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_order_items\n\t\t\t\tJOIN ')), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_order_itemmeta ON ')), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_order_items.order_item_id = ')), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string('woocommerce_order_itemmeta.order_item_id\n\t\t\t\tWHERE ')), rt.get_property(var_wpdb,
				'prefix')), rt.new_string("woocommerce_order_items.order_id = '")), var_postid),
				rt.new_string("';\n\t\t\t\t")),
		])
		rt.call_function('do_action', [rt.new_string('woocommerce_deleted_order_items'),
			var_postid.clone()])
	}
}

fn Class_WC_Post_Data.delete_order_downloadable_permissions(var_postid rt.PhpVal) {
	mut iife_temp_8 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_8 := iife_temp_8.is_order(var_postid.clone(), rt.call_function('wc_get_order_types',
		[]rt.PhpVal{}))
	if rt.is_true(iife_result_8) {
		rt.call_function('do_action', [
			rt.new_string('woocommerce_delete_order_downloadable_permissions'),
			var_postid.clone(),
		])
		mut iife_temp_9 := Class_WC_Data_Store{}
		mut iife_result_9 := iife_temp_9.load(rt.new_string('customer-download'))
		mut var_data_store := iife_result_9
		rt.call_method(var_data_store, 'delete_by_order_id', [
			var_postid.clone()])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_deleted_order_downloadable_permissions'),
			var_postid.clone(),
		])
	}
}

fn Class_WC_Post_Data.flush_object_meta_cache(var_meta_id rt.PhpVal, var_object_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal) {
	mut var_meta_key_mutated := var_meta_key
	mut var_meta_value_mutated := var_meta_value
	mut iife_temp_10 := Class_WC_Cache_Helper{}
	mut iife_result_10 := iife_temp_10.invalidate_cache_group(rt.new_string('object_' +
		var_object_id.str()))
}

fn Class_WC_Post_Data.force_default_term(var_object_id rt.PhpVal, var_terms rt.PhpVal, var_tt_ids rt.PhpVal, var_taxonomy rt.PhpVal, var_append rt.PhpVal) {
	mut var_tt_ids_mutated := var_tt_ids
	mut var_taxonomy_mutated := var_taxonomy
	if rt.is_true(rt.new_bool(!(rt.is_true(var_append))))
		&& rt.is_true(rt.identical(rt.new_string('product_cat'), var_taxonomy_mutated))
		&& !rt.is_true(var_tt_ids_mutated)
		&& rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [var_object_id.clone()]))) {
		mut var_default_term := rt.call_function('absint', [
			rt.call_function('get_option', [rt.new_string('default_product_cat'),
				rt.new_int(0)]),
		])
		var_tt_ids_mutated = rt.call_function('array_map', [rt.new_string('absint'),
			var_tt_ids_mutated.clone()])
		if rt.is_true(var_default_term)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_default_term.clone(), var_tt_ids_mutated.clone(), rt.new_bool(true)]))))) {
			rt.call_function('wp_set_post_terms', [var_object_id.clone(),
				rt.create_array([rt.ArrayItem{ key: none, val: var_default_term }]),
				rt.new_string('product_cat'), rt.new_bool(true)])
		}
	}
}

fn Class_WC_Post_Data.recount_terms_for_product_visibility_change(var_object_id rt.PhpVal, var_terms rt.PhpVal, var_tt_ids rt.PhpVal, var_taxonomy rt.PhpVal, var_append rt.PhpVal, var_old_tt_ids rt.PhpVal) {
	mut var_tt_ids_mutated := var_tt_ids
	mut var_taxonomy_mutated := var_taxonomy
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product_visibility'),
		var_taxonomy_mutated))))
	{
		return
	}
	if rt.is_true(var_append) {
		mut var_modified_tt_ids := var_tt_ids_mutated.clone()
	} else {
		var_modified_tt_ids = rt.call_function('array_merge', [
			rt.call_function('array_diff', [var_tt_ids_mutated.clone(),
				var_old_tt_ids.clone()]),
			rt.call_function('array_diff', [var_old_tt_ids.clone(),
				var_tt_ids_mutated.clone()]),
		])
	}
	if !rt.is_true(var_modified_tt_ids) {
		return
	}
	mut var_visibility_tt_ids := rt.call_function('wc_get_product_visibility_term_ids',
		[]rt.PhpVal{})
	mut var_tt_ids_modifying_term_counts := rt.new_array()
	if !(!rt.is_true(var_visibility_tt_ids.array_get(rt.new_string('exclude-from-catalog')))) {
		var_tt_ids_modifying_term_counts << var_visibility_tt_ids.array_get(rt.new_string('exclude-from-catalog'))
	}
	if !(!rt.is_true(var_visibility_tt_ids.array_get(rt.new_string('outofstock'))))
		&& rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))) {
		var_tt_ids_modifying_term_counts << var_visibility_tt_ids.array_get(rt.new_string('outofstock'))
	}
	if !(!rt.is_true(rt.call_function('array_intersect', [var_modified_tt_ids.clone(),
		rt.create_array_from_list(var_tt_ids_modifying_term_counts)]))) {
		rt.call_function('_wc_recount_terms_by_product', [var_object_id.clone()])
	}
}

fn Class_WC_Post_Data.wp_untrash_post_status(var_new_status rt.PhpVal, var_post_id rt.PhpVal, var_previous_status rt.PhpVal) rt.PhpVal {
	mut var_new_status_mutated := var_new_status
	mut var_post_types := ['shop_order', 'shop_coupon', 'product', 'product_variation']
	if rt.is_true(rt.call_function('in_array', [
		rt.call_function('get_post_type', [var_post_id.clone()]),
		rt.create_array_from_list(var_post_types),
		rt.new_bool(true),
	]))
	{
		var_new_status_mutated = var_previous_status
	}
	return var_new_status_mutated.clone()
}

fn Class_WC_Post_Data.sync_product_stock_status(var_meta_id rt.PhpVal, var_object_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal) {
	mut var_meta_key_mutated := var_meta_key
	mut var_meta_value_mutated := var_meta_value
}

fn Class_WC_Post_Data.process_product_file_download_paths(var_product_id rt.PhpVal, var_variation_id rt.PhpVal, var_downloads rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3')])
}

fn Class_WC_Post_Data.set_object_terms(var_object_id rt.PhpVal, var_terms rt.PhpVal, var_tt_ids rt.PhpVal, var_taxonomy rt.PhpVal, var_append rt.PhpVal, var_old_tt_ids rt.PhpVal) {
	mut var_tt_ids_mutated := var_tt_ids
	mut var_taxonomy_mutated := var_taxonomy
	if rt.is_true(rt.call_function('in_array', [
		rt.call_function('get_post_type', [var_object_id.clone()]),
		rt.create_array([rt.ArrayItem{ key: none, val: 'product' },
			rt.ArrayItem{ key: none, val: 'product_variation' }]),
		rt.new_bool(true),
	]))
	{
		Class_WC_Post_Data.delete_product_query_transients()
	}
}

fn Class_WC_Post_Data.regenerate_variation_summaries(var_variation_ids rt.PhpVal) {
	mut var_variation_ids_mutated := var_variation_ids
	if !rt.is_true(var_variation_ids_mutated) {
		return
	}
	var_variation_ids_mutated = rt.call_function('array_unique', [
		rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('intval'),
				var_variation_ids_mutated.clone()]),
		]),
	])
	mut iter_4 := var_variation_ids_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_variation_id := item_4.val
		Class_WC_Post_Data.regenerate_variation_attribute_summary(var_variation_id.clone())
	}
}

fn Class_WC_Post_Data.regenerate_variation_attribute_summary(var_variation_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_product := rt.call_function('wc_get_product', [var_variation_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_type', [rt.new_string('variation')]))))) {
		return
	}
	mut iife_temp_11 := Class_WC_Data_Store{}
	mut iife_result_11 := iife_temp_11.load(rt.new_string('product-variation'))
	mut var_data_store := iife_result_11
	if rt.is_true(rt.call_method(var_data_store, 'has_callable', [
		rt.new_string('get_attribute_summary'),
	]))
	{
		mut var_new_summary := rt.call_method(var_data_store, 'get_attribute_summary', [
			var_product.clone(),
		])
		mut var_current_excerpt := rt.call_function('get_post_field', [
			rt.new_string('post_excerpt'),
			var_variation_id.clone(),
		])
		if rt.is_true(rt.identical(var_new_summary, var_current_excerpt)) {
			return
		}
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'),
			rt.create_array([rt.ArrayItem{ key: 'post_excerpt', val: var_new_summary }]),
			rt.create_array([rt.ArrayItem{ key: 'ID', val: var_variation_id }])])
		rt.call_function('clean_post_cache', [var_variation_id.clone()])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_updated_product_attribute_summary'),
			var_variation_id.clone(),
		])
	}
}

fn Class_WC_Post_Data.get_variation_summaries_sync_threshold() rt.PhpVal {
	return rt.call_function('absint', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_regenerate_variation_summaries_sync_threshold'),
			rt.new_int(50),
		]),
	])
}

fn Class_WC_Post_Data.handle_global_attribute_updated(var_attribute_id rt.PhpVal, var_attribute rt.PhpVal, var_old_slug rt.PhpVal) {
	mut var_old_slug_mutated := var_old_slug
	if rt.is_true(rt.identical(rt.call_function('strpos', [var_old_slug_mutated.clone(),
		rt.new_string('pa_')]), rt.new_int(0)))
	{
		var_old_slug_mutated = rt.call_function('substr', [var_old_slug_mutated.clone(),
			rt.new_int(3)])
	}
	mut var_taxonomy := rt.new_string('pa_' + var_old_slug_mutated.str())
	mut var_threshold := Class_WC_Post_Data.get_variation_summaries_sync_threshold()
	mut var_args := {
		'post_type':      rt.new_string('product_variation')
		'post_status':    rt.new_string('any')
		'posts_per_page': var_threshold + 1
		'fields':         rt.new_string('ids')
		'meta_query':     map[string]rt.PhpVal{}
	}
	mut var_variation_ids := rt.call_function('get_posts', [
		rt.create_array_from_native_map(var_args),
	])
	if !rt.is_true(var_variation_ids) {
		return
	}
	if rt.is_true(rt.less_equal(rt.new_int(var_variation_ids.clone().array_count()), var_threshold)) {
		closure_13_fn := fn [var_variation_ids] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			Class_WC_Post_Data.regenerate_variation_summaries(var_variation_ids.clone())
			return rt.new_null()
		}
		rt.call_function('add_action', [rt.new_string('shutdown'),
			rt.new_closure(closure_13_fn)])
	} else {
		mut var_new_slug := if !(!rt.is_true(var_attribute.array_get(rt.new_string('attribute_name')))) {
			var_attribute.array_get(rt.new_string('attribute_name'))
		} else {
			var_old_slug_mutated
		}
		mut var_new_taxonomy := rt.new_string('pa_' + var_new_slug.str())
		Class_WC_Post_Data.schedule_variation_summary_regeneration('wc_regenerate_attribute_variation_summaries', rt.create_array([
			rt.ArrayItem{ key: none, val: var_new_taxonomy },
		]), rt.new_string('Taxonomy: ' + var_taxonomy.str() + ', Attribute ID: ' +
			var_attribute_id.str()))
	}
}

fn Class_WC_Post_Data.regenerate_attribute_variation_summaries(var_taxonomy rt.PhpVal) {
	mut var_taxonomy_mutated := var_taxonomy
	mut var_variation_ids := rt.call_function('get_posts', [
		rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product_variation' },
			rt.ArrayItem{ key: 'numberposts', val: -1 }, rt.ArrayItem{ key: 'fields', val: 'ids' },
			rt.ArrayItem{ key: 'meta_query', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'key', val: 'attribute_' + var_taxonomy_mutated.str() },
					rt.ArrayItem{ key: 'compare', val: 'EXISTS' },
				]) },
			]) }]),
	])
	Class_WC_Post_Data.regenerate_variation_summaries(var_variation_ids.clone())
}

fn Class_WC_Post_Data.on_product_attributes_updated(var_product rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_product_mutated := var_product
	if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [
		rt.new_string('variable'),
	]))
	{
		mut var_threshold := Class_WC_Post_Data.get_variation_summaries_sync_threshold()
		mut var_variation_ids := rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT DISTINCT ID\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb,
					'posts')),
					rt.new_string('\n\t\t\t\t\tWHERE post_parent = %d\n\t\t\t\t\tAND post_type = %s\n\t\t\t\t\tLIMIT %d\n\t\t\t\t\t')),
				rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}),
				rt.new_string('product_variation'),
				rt.add(var_threshold, rt.new_int(1)),
			]),
		])
		if !rt.is_true(var_variation_ids) {
			return
		}
		if rt.is_true(rt.less_equal(rt.new_int(var_variation_ids.clone().array_count()),
			var_threshold))
		{
			var_variation_ids = rt.call_method(var_product_mutated, 'get_children', []rt.PhpVal{})
			Class_WC_Post_Data.regenerate_variation_summaries(var_variation_ids.clone())
		} else {
			Class_WC_Post_Data.schedule_variation_summary_regeneration('wc_regenerate_product_variation_summaries', rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_method(var_product_mutated, 'get_id',
					[]rt.PhpVal{}) },
			]), rt.new_string('Product ID: ' +
				(rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})).str()))
		}
	}
}

fn Class_WC_Post_Data.regenerate_product_variation_summaries(var_product_id rt.PhpVal) {
	mut var_product := rt.call_function('wc_get_product', [var_product_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_type', [rt.new_string('variable')]))))) {
		return
	}
	mut var_variation_ids := rt.call_method(var_product, 'get_children', []rt.PhpVal{})
	Class_WC_Post_Data.regenerate_variation_summaries(var_variation_ids.clone())
}

fn Class_WC_Post_Data.handle_attribute_term_updated(var_term_id rt.PhpVal, var_tt_id rt.PhpVal, var_taxonomy rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_taxonomy_mutated := var_taxonomy
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		var_taxonomy_mutated.clone(),
		rt.new_string('pa_'),
	]), rt.new_int(0)))))
	{
		return
	}
	mut var_new_term := rt.call_function('get_term', [var_term_id.clone(),
		var_taxonomy_mutated.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_new_term.clone()]))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_new_term)))) {
		return
	}
	mut var_meta_key := rt.new_string('attribute_' + var_taxonomy_mutated.str())
	mut var_threshold := Class_WC_Post_Data.get_variation_summaries_sync_threshold()
	mut var_variation_ids := rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT pm.post_id\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'postmeta')), rt.new_string(' pm\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
				'posts')),
				rt.new_string(" p ON pm.post_id = p.ID\n\t\t\t\tWHERE pm.meta_key = %s\n\t\t\t\tAND pm.meta_value = %s\n\t\t\t\tAND p.post_type = 'product_variation'\n\t\t\t\tLIMIT %d\n\t\t\t\t")),
			var_meta_key.clone(),
			rt.get_property(var_new_term, 'slug'),
			rt.add(var_threshold, rt.new_int(1)),
		]),
	])
	if !rt.is_true(var_variation_ids) {
		return
	}
	if rt.is_true(rt.less_equal(rt.new_int(var_variation_ids.clone().array_count()), var_threshold)) {
		Class_WC_Post_Data.regenerate_variation_summaries(var_variation_ids.clone())
	} else {
		Class_WC_Post_Data.schedule_variation_summary_regeneration('wc_regenerate_term_variation_summaries', rt.create_array([
			rt.ArrayItem{ key: none, val: var_taxonomy_mutated },
			rt.ArrayItem{ key: none, val: rt.get_property(var_new_term, 'slug') },
		]), rt.new_string('Taxonomy: ' + var_taxonomy_mutated.str() + ', Term ID: ' +
			var_term_id.str()))
	}
}

fn Class_WC_Post_Data.handle_attribute_term_deleted(var_term_id rt.PhpVal, var_tt_id rt.PhpVal, var_taxonomy rt.PhpVal, var_deleted_term rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_taxonomy_mutated := var_taxonomy
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		var_taxonomy_mutated.clone(),
		rt.new_string('pa_'),
	]), rt.new_int(0)))))
	{
		return
	}
	mut var_meta_key := rt.new_string('attribute_' + var_taxonomy_mutated.str())
	mut var_threshold := Class_WC_Post_Data.get_variation_summaries_sync_threshold()
	mut var_variation_ids := rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT pm.post_id\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'postmeta')), rt.new_string(' pm\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
				'posts')),
				rt.new_string(" p ON pm.post_id = p.ID\n\t\t\t\tWHERE pm.meta_key = %s\n\t\t\t\tAND pm.meta_value = %s\n\t\t\t\tAND p.post_type = 'product_variation'\n\t\t\t\tLIMIT %d\n\t\t\t\t")),
			var_meta_key.clone(),
			rt.get_property(var_deleted_term, 'slug'),
			rt.add(var_threshold, rt.new_int(1)),
		]),
	])
	if !rt.is_true(var_variation_ids) {
		return
	}
	if rt.is_true(rt.less_equal(rt.new_int(var_variation_ids.clone().array_count()), var_threshold)) {
		Class_WC_Post_Data.regenerate_variation_summaries(var_variation_ids.clone())
	} else {
		Class_WC_Post_Data.schedule_variation_summary_regeneration('wc_regenerate_term_variation_summaries', rt.create_array([
			rt.ArrayItem{ key: none, val: var_taxonomy_mutated },
			rt.ArrayItem{ key: none, val: rt.get_property(var_deleted_term, 'slug') },
		]), rt.new_string('Taxonomy: ' + var_taxonomy_mutated.str() + ', Term ID: ' +
			var_term_id.str()))
	}
}

fn Class_WC_Post_Data.schedule_variation_summary_regeneration(var_action_name rt.PhpVal, var_args rt.PhpVal, var_warning_message rt.PhpVal, group string) {
	mut var_args_mutated := var_args
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('as_schedule_single_action'),
	]))
	{
		mut var_when := rt.call_function('as_next_scheduled_action', [
			var_action_name.clone(), var_args_mutated.clone(),
			rt.new_string(group)])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_when)))) {
			rt.call_function('as_schedule_single_action', [
				rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(1)),
				var_action_name.clone(),
				var_args_mutated.clone(),
				rt.new_string(group),
			])
		}
	} else {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
			rt.new_string(
				'Action Scheduler unavailable for product variation summary regeneration. ' +
				var_warning_message.str()),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'woocommerce-variations' },
			]),
		])
	}
}

fn Class_WC_Post_Data.regenerate_term_variation_summaries(var_taxonomy rt.PhpVal, var_term_slug rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_taxonomy_mutated := var_taxonomy
	mut var_variation_ids := rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT pm.post_id FROM '), rt.get_property(var_wpdb,
				'postmeta')), rt.new_string(' pm\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
				'posts')),
				rt.new_string(' p ON pm.post_id = p.ID\n\t\t\t\tWHERE pm.meta_key = %s\n\t\t\t\tAND pm.meta_value = %s\n\t\t\t\tAND p.post_type = %s')),
			rt.new_string('attribute_' + var_taxonomy_mutated.str()),
			var_term_slug.clone(),
			rt.new_string('product_variation'),
		]),
	])
	Class_WC_Post_Data.regenerate_variation_summaries(var_variation_ids.clone())
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

fn create_wc_post_data(_args ...rt.PhpVal) &Class_WC_Post_Data {
	mut obj := &Class_WC_Post_Data{
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

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
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

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Post_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Post_Data.init()
			return rt.new_null()
		}
		'variation_post_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Post_Data.variation_post_link(dispatch_arg_0, dispatch_arg_1)
		}
		'do_deferred_product_sync' {
			Class_WC_Post_Data.do_deferred_product_sync()
			return rt.new_null()
		}
		'deferred_product_sync' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Post_Data.deferred_product_sync(dispatch_arg_0)
			return rt.new_null()
		}
		'transition_post_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WC_Post_Data.transition_post_status(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
			return rt.new_null()
		}
		'delete_product_query_transients' {
			Class_WC_Post_Data.delete_product_query_transients()
			return rt.new_null()
		}
		'invalidate_products_last_modified' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Post_Data.invalidate_products_last_modified(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'invalidate_db_block_templates_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Post_Data.invalidate_db_block_templates_cache(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'product_type_changed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WC_Post_Data.product_type_changed(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'edit_term' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WC_Post_Data.edit_term(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'edited_term' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WC_Post_Data.edited_term(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'update_order_item_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Post_Data.update_order_item_metadata(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'update_post_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Post_Data.update_post_metadata(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'wp_insert_post_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Post_Data.wp_insert_post_data(dispatch_arg_0)
		}
		'filter_oembed_response_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Post_Data.filter_oembed_response_data(dispatch_arg_0, dispatch_arg_1)
		}
		'delete_post_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Post_Data.delete_post_data(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Post_Data.delete_post(dispatch_arg_0)
			return rt.new_null()
		}
		'trash_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Post_Data.trash_post(dispatch_arg_0)
			return rt.new_null()
		}
		'untrash_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Post_Data.untrash_post(dispatch_arg_0)
			return rt.new_null()
		}
		'clear_global_unique_id_if_necessary' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Post_Data.clear_global_unique_id_if_necessary(dispatch_arg_0)
			return rt.new_null()
		}
		'get_post_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Post_Data.get_post_type(dispatch_arg_0)
		}
		'before_delete_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Post_Data.before_delete_order(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_order_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Post_Data.delete_order_items(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_order_downloadable_permissions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Post_Data.delete_order_downloadable_permissions(dispatch_arg_0)
			return rt.new_null()
		}
		'flush_object_meta_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			Class_WC_Post_Data.flush_object_meta_cache(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'force_default_term' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			Class_WC_Post_Data.force_default_term(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'recount_terms_for_product_visibility_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			Class_WC_Post_Data.recount_terms_for_product_visibility_change(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		'wp_untrash_post_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_Post_Data.wp_untrash_post_status(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'sync_product_stock_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			Class_WC_Post_Data.sync_product_stock_status(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'process_product_file_download_paths' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WC_Post_Data.process_product_file_download_paths(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
			return rt.new_null()
		}
		'set_object_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			Class_WC_Post_Data.set_object_terms(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		'regenerate_variation_summaries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Post_Data.regenerate_variation_summaries(dispatch_arg_0)
			return rt.new_null()
		}
		'regenerate_variation_attribute_summary' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Post_Data.regenerate_variation_attribute_summary(dispatch_arg_0)
			return rt.new_null()
		}
		'get_variation_summaries_sync_threshold' {
			return Class_WC_Post_Data.get_variation_summaries_sync_threshold()
		}
		'handle_global_attribute_updated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WC_Post_Data.handle_global_attribute_updated(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
			return rt.new_null()
		}
		'regenerate_attribute_variation_summaries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Post_Data.regenerate_attribute_variation_summaries(dispatch_arg_0)
			return rt.new_null()
		}
		'on_product_attributes_updated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Post_Data.on_product_attributes_updated(dispatch_arg_0)
			return rt.new_null()
		}
		'regenerate_product_variation_summaries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Post_Data.regenerate_product_variation_summaries(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_attribute_term_updated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WC_Post_Data.handle_attribute_term_updated(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
			return rt.new_null()
		}
		'handle_attribute_term_deleted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			Class_WC_Post_Data.handle_attribute_term_deleted(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'schedule_variation_summary_regeneration' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			Class_WC_Post_Data.schedule_variation_summary_regeneration(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'regenerate_term_variation_summaries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Post_Data.regenerate_term_variation_summaries(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Post_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Post_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	Class_WC_Post_Data.init()
}
