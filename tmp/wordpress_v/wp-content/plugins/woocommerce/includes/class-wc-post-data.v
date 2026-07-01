import rt

struct Class_WC_Post_Data {
	rt.PhpObjectBase
pub mut:
		editing_term rt.PhpVal = rt.new_null()
}

fn Class_WC_Post_Data.init()  {
	rt.call_function('add_action', [rt.new_string('clean_post_cache'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'invalidate_products_last_modified' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('clean_post_cache'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'invalidate_db_block_templates_cache' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('post_type_link'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'variation_post_link' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('shutdown'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'do_deferred_product_sync' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('set_object_terms'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'force_default_term' }]), rt.new_int(10), rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('set_object_terms'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_product_query_transients' }])])
	rt.call_function('add_action', [rt.new_string('set_object_terms'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'recount_terms_for_product_visibility_change' }]), rt.new_int(10), rt.new_int(6)])
	rt.call_function('add_action', [rt.new_string('deleted_term_relationships'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_product_query_transients' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_product_set_stock_status'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_product_query_transients' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_product_set_visibility'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_product_query_transients' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_product_type_changed'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'product_type_changed' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('edit_term'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'edit_term' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('edited_term'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'edited_term' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('update_order_item_metadata'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'update_order_item_metadata' }]), rt.new_int(10), rt.new_int(5)])
	rt.call_function('add_filter', [rt.new_string('update_post_metadata'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'update_post_metadata' }]), rt.new_int(10), rt.new_int(5)])
	rt.call_function('add_filter', [rt.new_string('wp_insert_post_data'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'wp_insert_post_data' }])])
	rt.call_function('add_filter', [rt.new_string('oembed_response_data'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'filter_oembed_response_data' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('wp_untrash_post_status'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'wp_untrash_post_status' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('transition_post_status'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'transition_post_status' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('delete_post'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_post_data' }])])
	rt.call_function('add_action', [rt.new_string('wp_trash_post'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'trash_post' }])])
	rt.call_function('add_action', [rt.new_string('untrashed_post'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'untrash_post' }])])
	rt.call_function('add_action', [rt.new_string('before_delete_post'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'before_delete_order' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_delete_order'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'before_delete_order' }])])
	rt.call_function('add_action', [rt.new_string('updated_post_meta'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'flush_object_meta_cache' }]), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('added_post_meta'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'flush_object_meta_cache' }]), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('deleted_post_meta'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'flush_object_meta_cache' }]), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('updated_order_item_meta'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'flush_object_meta_cache' }]), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('woocommerce_attribute_updated'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'handle_global_attribute_updated' }]), rt.new_int(50), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_attribute_deleted'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'handle_global_attribute_updated' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('edited_term'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'handle_attribute_term_updated' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('delete_term'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'handle_attribute_term_deleted' }]), rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('woocommerce_product_attributes_updated'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'on_product_attributes_updated' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wc_regenerate_product_variation_summaries'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'regenerate_product_variation_summaries' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wc_regenerate_attribute_variation_summaries'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'regenerate_attribute_variation_summaries' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wc_regenerate_term_variation_summaries'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'regenerate_term_variation_summaries' }]), rt.new_int(10), rt.new_int(2)])
}

fn Class_WC_Post_Data.variation_post_link(var_permalink rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.get_property(var_post, 'ID')).is_null() && !(rt.get_property(var_post, 'post_type')).is_null() && rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(var_post, 'post_type'))))) {
		mut var_variation := rt.call_function('wc_get_product', [rt.get_property(var_post, 'ID')])
		if rt.is_true(rt.new_bool(rt.is_true(var_variation) && rt.is_true(rt.call_method(var_variation, 'get_parent_id', []rt.PhpVal{})))) {
			return rt.call_method(var_variation, 'get_permalink', []rt.PhpVal{})
		}
	}
	return var_permalink.dup()
}

fn Class_WC_Post_Data.do_deferred_product_sync()  {
	// unsupported statement: Stmt_Global
	if !(!rt.is_true(var_wc_deferred_product_sync)) {
		mut var_wc_deferred_product_sync := rt.call_function('wp_parse_id_list', [var_wc_deferred_product_sync.dup()])
		rt.call_function('array_walk', [var_wc_deferred_product_sync.dup(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'deferred_product_sync' }])])
	}
}

fn Class_WC_Post_Data.deferred_product_sync(var_product_id rt.PhpVal)  {
	mut var_product := rt.call_function('wc_get_product', [var_product_id.dup()])
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_product }, rt.ArrayItem{ key: none, val: 'sync' }])])) {
		rt.call_method(var_product, 'sync', [var_product.dup()])
	}
}

fn Class_WC_Post_Data.transition_post_status(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal)  {
	mut var_new_status_mutated := var_new_status
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), var_new_status_mutated)) || rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), var_old_status)))) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)])))) {
		Class_WC_Post_Data.delete_product_query_transients()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), var_new_status_mutated)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)])))) {
		rt.call_function('do_action', [rt.new_string('woocommerce_product_published'), rt.get_property(var_post, 'ID')])
	}
}

fn Class_WC_Post_Data.delete_product_query_transients()  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_transient_version(arg_0, arg_1) }(rt.new_string('product_query'), rt.new_bool(true))
}

fn Class_WC_Post_Data.invalidate_products_last_modified(var_post_id rt.PhpVal, var_post rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post'))) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)])))) {
		rt.call_function('wp_cache_delete', [rt.new_string('last_modified'), rt.new_string('wc_products')])
	}
}

fn Class_WC_Post_Data.invalidate_db_block_templates_cache(var_post_id rt.PhpVal, var_post rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post'))) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'wp_template_part' }, rt.ArrayItem{ key: none, val: 'wp_template' }]), rt.new_bool(true)])))) {
		rt.call_function('wp_cache_delete', [(rt.get_property(var_post, 'post_type')).str() + '-ids', rt.new_string('woocommerce_blocks')])
	}
}

fn Class_WC_Post_Data.product_type_changed(var_product rt.PhpVal, var_from rt.PhpVal, var_to rt.PhpVal)  {
	mut var_product_mutated := var_product
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_delete_variations_on_product_type_change'), rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variable(), var_from)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)), var_product_mutated.dup(), var_from.dup(), var_to.dup()])) {
		mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('product-variable'))
		rt.call_method(var_data_store, 'delete_variations', [rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}), rt.new_bool(true)])
	}
}

fn Class_WC_Post_Data.edit_term(var_term_id rt.PhpVal, var_tt_id rt.PhpVal, var_taxonomy rt.PhpVal)  {
	mut var_taxonomy_mutated := var_taxonomy
	if rt.is_true(rt.identical(rt.call_function('strpos', [var_taxonomy_mutated.dup(), rt.new_string('pa_')]), rt.new_int(0))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	} else {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
}

fn Class_WC_Post_Data.edited_term(var_term_id rt.PhpVal, var_tt_id rt.PhpVal, var_taxonomy rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_taxonomy_mutated := var_taxonomy
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_null()))))) && rt.is_true(rt.identical(rt.call_function('strpos', [var_taxonomy_mutated.dup(), rt.new_string('pa_')]), rt.new_int(0))))) {
		mut var_edited_term := rt.call_function('get_term_by', [rt.new_string('id'), var_term_id.dup(), var_taxonomy_mutated.dup()])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			// unsupported statement: Stmt_Global
			rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' SET meta_value = %s WHERE meta_key = %s AND meta_value = %s;')), rt.get_property(var_edited_term, 'slug'), 'attribute_' + (rt.call_function('sanitize_title', [var_taxonomy_mutated.dup()])).str(), rt.get_property(// unsupported expression: Expr_StaticPropertyFetch, 'slug')])])
			rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' SET meta_value = REPLACE( meta_value, %s, %s ) WHERE meta_key = \'_default_attributes\'')), rt.concat(rt.call_function('serialize', [rt.get_property(// unsupported expression: Expr_StaticPropertyFetch, 'taxonomy')]), rt.call_function('serialize', [rt.get_property(// unsupported expression: Expr_StaticPropertyFetch, 'slug')])), rt.concat(rt.call_function('serialize', [rt.get_property(var_edited_term, 'taxonomy')]), rt.call_function('serialize', [rt.get_property(var_edited_term, 'slug')]))])])
		}
	} else {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
}

fn Class_WC_Post_Data.update_order_item_metadata(var_check rt.PhpVal, var_object_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, var_prev_value rt.PhpVal) bool {
	mut var_meta_key_mutated := var_meta_key
	mut var_meta_value_mutated := var_meta_value
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_meta_value_mutated)) && rt.is_true(rt.new_bool(var_meta_value_mutated.dup().is_double())))) {
		var_meta_value_mutated = rt.call_function('wc_float_to_string', [var_meta_value_mutated.dup()])
		rt.call_function('update_metadata', [rt.new_string('order_item'), var_object_id.dup(), var_meta_key_mutated.dup(), var_meta_value_mutated.dup(), var_prev_value.dup()])
		return true
	}
	return (var_check).to_bool()
}

fn Class_WC_Post_Data.update_post_metadata(var_check rt.PhpVal, var_object_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal, var_prev_value rt.PhpVal) bool {
	mut var_meta_key_mutated := var_meta_key
	mut var_meta_value_mutated := var_meta_value
	if rt.is_true(rt.call_function('in_array', [rt.call_function('get_post_type', [var_object_id.dup()]), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]), rt.new_bool(true)])) {
		rt.call_function('wp_cache_delete', ['product-' + (var_object_id).str(), rt.new_string('products')])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_meta_value_mutated)) && rt.is_true(rt.new_bool(var_meta_value_mutated.dup().is_double())))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('registered_meta_key_exists', [rt.new_string('post'), var_meta_key_mutated.dup()]))))))) && rt.is_true(rt.call_function('in_array', [rt.call_function('get_post_type', [var_object_id.dup()]), rt.call_function('array_merge', [rt.call_function('wc_get_order_types', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: 'shop_coupon' }, rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }])]), rt.new_bool(true)])))) {
		var_meta_value_mutated = rt.call_function('wc_float_to_string', [var_meta_value_mutated.dup()])
		rt.call_function('update_metadata', [rt.new_string('post'), var_object_id.dup(), var_meta_key_mutated.dup(), var_meta_value_mutated.dup(), var_prev_value.dup()])
		return true
	}
	return (var_check).to_bool()
}

fn Class_WC_Post_Data.wp_insert_post_data(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('shop_order'), var_data_mutated.array_get('post_type'))) && var_data_mutated.array_isset(rt.new_string('post_date')))) {
		mut var_order_title := rt.new_string(rt.new_string('Order'))
		if rt.is_true(var_data_mutated.array_get('post_date')) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		var_data_mutated.array_set('post_title', var_order_title.dup())
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('product'), var_data_mutated.array_get('post_type'))) && rt.get_superglobal('_POST').array_isset(rt.new_string('product-type')))) {
		mut var_product_type := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('product-type')])])
		mut switch_val_1 := var_product_type
		if rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Enums_ProductType.grouped())) || rt.is_true(rt.equal(switch_val_1, Class_Automattic_WooCommerce_Enums_ProductType.variable())) {
			var_data_mutated.array_set('post_parent', 0)
		}
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('product'), var_data_mutated.array_get('post_type'))) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.auto_draft(), var_data_mutated.array_get('post_status'))))) {
		var_data_mutated.array_set('post_title', 'AUTO-DRAFT')
	} else if rt.is_true(rt.identical(rt.new_string('shop_coupon'), var_data_mutated.array_get('post_type'))) {
		var_data_mutated.array_set('post_title', rt.call_function('wp_filter_kses', [var_data_mutated.array_get('post_title')]))
	}
	return var_data_mutated.dup()
}

fn Class_WC_Post_Data.filter_oembed_response_data(var_data rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'shop_order' }, rt.ArrayItem{ key: none, val: 'shop_coupon' }]), rt.new_bool(true)])) {
		return rt.new_array()
	}
	return var_data_mutated.dup()
}

fn Class_WC_Post_Data.delete_post_data(var_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_container := rt.call_function('wc_get_container', []rt.PhpVal{})
	mut var_post_type := Class_WC_Post_Data.get_post_type(var_id.dup())
	mut switch_val_2 := var_post_type
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('product'))) {
		mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('product-variable'))
		rt.call_method(var_data_store, 'delete_variations', [var_id.dup(), rt.new_bool(true)])
		rt.call_method(var_data_store, 'delete_from_lookup_table', [var_id.dup(), rt.new_string('wc_product_meta_lookup')])
		rt.call_method(rt.call_method(var_container, 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore.class()]), 'on_product_deleted', [var_id.dup()])
		mut var_parent_id := rt.call_function('wp_get_post_parent_id', [var_id.dup()])
		if rt.is_true(var_parent_id) {
			rt.call_function('wc_delete_product_transients', [var_parent_id.dup()])
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('product_variation'))) {
		var_data_store = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string())
		rt.call_method(, 'delete_from_lookup_table', [.dup(), ])
		
	} else if rt.is_true(rt.equal(switch_val_2, )) || rt.is_true(rt.equal(switch_val_2, )) {
	}
}

fn Class_WC_Post_Data.delete_post(var_id rt.PhpVal)  {
}

fn Class_WC_Post_Data.trash_post(var_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Post_Data.untrash_post(var_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Post_Data.clear_global_unique_id_if_necessary(var_id rt.PhpVal)  {
}

fn Class_WC_Post_Data.get_post_type(var_id rt.PhpVal) rt.PhpVal {
}

fn Class_WC_Post_Data.before_delete_order(var_order_id rt.PhpVal)  {
}

fn Class_WC_Post_Data.delete_order_items(var_postid rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Post_Data.delete_order_downloadable_permissions(var_postid rt.PhpVal)  {
}

fn Class_WC_Post_Data.flush_object_meta_cache(var_meta_id rt.PhpVal, var_object_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal)  {
	mut var_meta_key_mutated := var_meta_key
	mut var_meta_value_mutated := var_meta_value
}

fn Class_WC_Post_Data.force_default_term(var_object_id rt.PhpVal, var_terms rt.PhpVal, var_tt_ids rt.PhpVal, var_taxonomy rt.PhpVal, var_append rt.PhpVal)  {
	mut var_tt_ids_mutated := var_tt_ids
	mut var_taxonomy_mutated := var_taxonomy
}

fn Class_WC_Post_Data.recount_terms_for_product_visibility_change(var_object_id rt.PhpVal, var_terms rt.PhpVal, var_tt_ids rt.PhpVal, var_taxonomy rt.PhpVal, var_append rt.PhpVal, var_old_tt_ids rt.PhpVal)  {
	mut var_tt_ids_mutated := var_tt_ids
	mut var_taxonomy_mutated := var_taxonomy
}

fn Class_WC_Post_Data.wp_untrash_post_status(var_new_status rt.PhpVal, var_post_id rt.PhpVal, var_previous_status rt.PhpVal) rt.PhpVal {
	mut var_new_status_mutated := var_new_status
}

fn Class_WC_Post_Data.sync_product_stock_status(var_meta_id rt.PhpVal, var_object_id rt.PhpVal, var_meta_key rt.PhpVal, var_meta_value rt.PhpVal)  {
	mut var_meta_key_mutated := var_meta_key
	mut var_meta_value_mutated := var_meta_value
}

fn Class_WC_Post_Data.process_product_file_download_paths(var_product_id rt.PhpVal, var_variation_id rt.PhpVal, var_downloads rt.PhpVal)  {
}

fn Class_WC_Post_Data.set_object_terms(var_object_id rt.PhpVal, var_terms rt.PhpVal, var_tt_ids rt.PhpVal, var_taxonomy rt.PhpVal, var_append rt.PhpVal, var_old_tt_ids rt.PhpVal)  {
	mut var_tt_ids_mutated := var_tt_ids
	mut var_taxonomy_mutated := var_taxonomy
}

fn Class_WC_Post_Data.regenerate_variation_summaries(var_variation_ids rt.PhpVal)  {
	mut var_variation_ids_mutated := var_variation_ids
}

fn Class_WC_Post_Data.regenerate_variation_attribute_summary(var_variation_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Post_Data.get_variation_summaries_sync_threshold() rt.PhpVal {
}

fn Class_WC_Post_Data.handle_global_attribute_updated(var_attribute_id rt.PhpVal, var_attribute rt.PhpVal, var_old_slug rt.PhpVal)  {
	mut var_old_slug_mutated := var_old_slug
}

fn Class_WC_Post_Data.regenerate_attribute_variation_summaries(var_taxonomy rt.PhpVal)  {
	mut var_taxonomy_mutated := var_taxonomy
}

fn Class_WC_Post_Data.on_product_attributes_updated(var_product rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_product_mutated := var_product
}

fn Class_WC_Post_Data.regenerate_product_variation_summaries(var_product_id rt.PhpVal)  {
}

fn Class_WC_Post_Data.handle_attribute_term_updated(var_term_id rt.PhpVal, var_tt_id rt.PhpVal, var_taxonomy rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_taxonomy_mutated := var_taxonomy
}

fn Class_WC_Post_Data.handle_attribute_term_deleted(var_term_id rt.PhpVal, var_tt_id rt.PhpVal, var_taxonomy rt.PhpVal, var_deleted_term rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_taxonomy_mutated := var_taxonomy
}

fn Class_WC_Post_Data.schedule_variation_summary_regeneration(var_action_name rt.PhpVal, var_args rt.PhpVal, var_warning_message rt.PhpVal, group string)  {
	mut var_args_mutated := var_args
}

fn Class_WC_Post_Data.regenerate_term_variation_summaries(var_taxonomy rt.PhpVal, var_term_slug rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_taxonomy_mutated := var_taxonomy
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_post_data() &Class_WC_Post_Data {
	mut obj := &Class_WC_Post_Data{
		PhpObjectBase: rt.PhpObjectBase{}
		editing_term: rt.new_null()
	}
	return obj
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
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
			Class_WC_Post_Data.transition_post_status(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
			return rt.new_bool(Class_WC_Post_Data.update_order_item_metadata(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'update_post_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Post_Data.update_post_metadata(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
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
			Class_WC_Post_Data.flush_object_meta_cache(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'force_default_term' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			Class_WC_Post_Data.force_default_term(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'recount_terms_for_product_visibility_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			Class_WC_Post_Data.recount_terms_for_product_visibility_change(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		'wp_untrash_post_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_Post_Data.wp_untrash_post_status(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'sync_product_stock_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			Class_WC_Post_Data.sync_product_stock_status(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'process_product_file_download_paths' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WC_Post_Data.process_product_file_download_paths(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'set_object_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			Class_WC_Post_Data.set_object_terms(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
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
			Class_WC_Post_Data.handle_global_attribute_updated(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
			Class_WC_Post_Data.handle_attribute_term_updated(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'handle_attribute_term_deleted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			Class_WC_Post_Data.handle_attribute_term_deleted(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'schedule_variation_summary_regeneration' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			Class_WC_Post_Data.schedule_variation_summary_regeneration(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'regenerate_term_variation_summaries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Post_Data.regenerate_term_variation_summaries(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Post_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'editing_term' { return this.editing_term }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Post_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'editing_term' { this.editing_term = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_post_data_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
