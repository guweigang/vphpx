import rt

struct Class_WC_Product_Data_Store_CPT {
	rt.PhpObjectBase
pub mut:
		internal_meta_keys rt.PhpVal = rt.new_array()
		must_exist_meta_keys rt.PhpVal = rt.new_array()
		extra_data_saved rt.PhpVal = rt.new_bool(false)
		updated_props rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Product_Data_Store_CPT) obtain_lock_on_sku_for_concurrent_requests(var_product rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_product_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	mut var_sku := rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
	mut var_query := rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb, 'wc_product_meta_lookup')), rt.new_string(' (product_id, sku)\n\t\t\tSELECT %d, %s FROM ')), rt.get_property(var_wpdb, 'options')), rt.new_string('\n\t\t\tWHERE NOT EXISTS (\n\t\t\t\tSELECT * FROM ')), rt.get_property(var_wpdb, 'wc_product_meta_lookup')), rt.new_string(' WHERE sku = %s LIMIT 1\n\t\t\t) LIMIT 1;')), var_product_id.dup(), var_sku.dup(), var_sku.dup()])
	mut var_locked := rt.call_function('apply_filters', [rt.new_string('wc_product_pre_lock_on_sku'), rt.new_null(), var_product.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_locked.dup().is_null()))))) {
		return rt.is_true(var_locked.dup())
	}
	{
		mut var_attempts := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_attempts, rt.new_int(3)))) { break }
			if rt.is_true(rt.greater(var_attempts, rt.new_int(1))) {
				rt.call_function('usleep', [rt.new_int(10000)])
			}
			mut var_result := rt.call_method(var_wpdb, 'query', [var_query.dup()])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				break
			}
			rt.post_inc(var_attempts)
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.call_function('sprintf', [rt.new_string('Failed to obtain SKU lock for product: ID "%d" with SKU "%s" after %d attempts.'), var_product_id.dup(), var_sku.dup(), var_attempts.dup()]), rt.create_array([rt.ArrayItem{ key: 'error', val: rt.get_property(var_wpdb, 'last_error') }])])
	}
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_WC_Product_Data_Store_CPT) create(var_product rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'get_date_created', [rt.new_string('edit')]))))) {
		rt.call_method(var_product, 'set_date_created', [rt.call_function('time', []rt.PhpVal{})])
	}
	mut var_id := rt.call_function('wp_insert_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_new_product_data'), rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'post_status', val: if rt.is_true(rt.call_method(var_product, 'get_status', []rt.PhpVal{})) { rt.call_method(var_product, 'get_status', []rt.PhpVal{}) } else { Class_Automattic_WooCommerce_Enums_ProductStatus.publish() } }, rt.ArrayItem{ key: 'post_author', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'post_title', val: if rt.is_true(rt.call_method(var_product, 'get_name', []rt.PhpVal{})) { rt.call_method(var_product, 'get_name', []rt.PhpVal{}) } else { rt.call_function('__', [rt.new_string('Product'), rt.new_string('woocommerce')]) } }, rt.ArrayItem{ key: 'post_content', val: rt.call_method(var_product, 'get_description', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'post_excerpt', val: rt.call_method(var_product, 'get_short_description', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'post_parent', val: rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'comment_status', val: if rt.is_true(rt.call_method(var_product, 'get_reviews_allowed', []rt.PhpVal{})) { 'open' } else { 'closed' } }, rt.ArrayItem{ key: 'ping_status', val: 'closed' }, rt.ArrayItem{ key: 'menu_order', val: rt.call_method(var_product, 'get_menu_order', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'post_password', val: rt.call_method(var_product, 'get_post_password', [rt.new_string('edit')]) }, rt.ArrayItem{ key: 'post_date', val: rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_product, 'get_date_created', [rt.new_string('edit')]), 'getOffsetTimestamp', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'post_date_gmt', val: rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_product, 'get_date_created', [rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'post_name', val: rt.call_method(var_product, 'get_slug', [rt.new_string('edit')]) }])]), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(var_id) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_id.dup()]))))))) {
		rt.call_method(var_product, 'set_id', [var_id.dup()])
		mut var_sku := rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_sku)) && rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})))) && !(this.obtain_lock_on_sku_for_concurrent_requests(var_product.dup())))) {
			rt.call_method(var_product, 'delete', [rt.new_bool(true)])
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The product with SKU (%1$s) you are trying to insert is already present in the lookup table'), rt.new_string('woocommerce')]), var_sku.dup()])]))))
		}
		mut var_post_object := rt.call_function('get_post', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
		rt.call_method(var_product, 'set_status', [rt.get_property(var_post_object, 'post_status')])
		this.update_post_meta(var_product.dup(), true)
		this.update_terms(var_product.dup(), true)
		this.update_visibility(var_product.dup(), true)
		this.update_attributes(var_product.dup(), true)
		this.update_version_and_type(var_product.dup())
		this.handle_updated_props(var_product.dup())
		this.clear_caches(var_product.dup())
		rt.call_method(var_product, 'save_meta_data', []rt.PhpVal{})
		rt.call_method(var_product, 'apply_changes', []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('woocommerce_new_product'), var_id.dup(), var_product.dup()])
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) read(var_product rt.PhpVal)  {
	rt.call_method(var_product, 'set_defaults', []rt.PhpVal{})
	mut var_post_object := rt.call_function('get_post', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'get_id', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_post_object)))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid product.'), rt.new_string('woocommerce')]))))
	}
	rt.call_method(var_product, 'set_props', [rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_post_object, 'post_title') }, rt.ArrayItem{ key: 'slug', val: rt.get_property(var_post_object, 'post_name') }, rt.ArrayItem{ key: 'date_created', val: this.string_to_timestamp(rt.get_property(var_post_object, 'post_date_gmt')) }, rt.ArrayItem{ key: 'date_modified', val: this.string_to_timestamp(rt.get_property(var_post_object, 'post_modified_gmt')) }, rt.ArrayItem{ key: 'status', val: rt.get_property(var_post_object, 'post_status') }, rt.ArrayItem{ key: 'description', val: rt.get_property(var_post_object, 'post_content') }, rt.ArrayItem{ key: 'short_description', val: rt.get_property(var_post_object, 'post_excerpt') }, rt.ArrayItem{ key: 'parent_id', val: rt.get_property(var_post_object, 'post_parent') }, rt.ArrayItem{ key: 'menu_order', val: rt.get_property(var_post_object, 'menu_order') }, rt.ArrayItem{ key: 'post_password', val: rt.get_property(var_post_object, 'post_password') }, rt.ArrayItem{ key: 'reviews_allowed', val: rt.identical(rt.new_string('open'), rt.get_property(var_post_object, 'comment_status')) }])])
	this.read_attributes(var_product.dup())
	this.read_downloads(var_product.dup())
	this.read_visibility(var_product.dup())
	this.read_product_data(var_product.dup())
	this.read_extra_data(var_product.dup())
	rt.call_method(var_product, 'set_object_read', [rt.new_bool(true)])
	rt.call_function('do_action', [rt.new_string('woocommerce_product_read'), rt.call_method(var_product, 'get_id', []rt.PhpVal{}), var_product.dup()])
}

fn (mut this Class_WC_Product_Data_Store_CPT) update(var_product rt.PhpVal)  {
	mut var_GLOBALS := rt.new_null()
	rt.call_method(var_product, 'save_meta_data', []rt.PhpVal{})
	mut var_changes := rt.call_method(var_product, 'get_changes', []rt.PhpVal{})
	if rt.is_true(rt.call_function('array_intersect', [rt.create_array([rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'short_description' }, rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'parent_id' }, rt.ArrayItem{ key: none, val: 'reviews_allowed' }, rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'menu_order' }, rt.ArrayItem{ key: none, val: 'date_created' }, rt.ArrayItem{ key: none, val: 'date_modified' }, rt.ArrayItem{ key: none, val: 'slug' }, rt.ArrayItem{ key: none, val: 'post_password' }]), rt.func_array_keys(var_changes.dup())])) {
		mut var_post_data := { 'post_content': rt.call_method(var_product, 'get_description', [rt.new_string('edit')]), 'post_excerpt': rt.call_method(var_product, 'get_short_description', [rt.new_string('edit')]), 'post_title': rt.call_method(var_product, 'get_name', [rt.new_string('edit')]), 'post_parent': rt.call_method(var_product, 'get_parent_id', [rt.new_string('edit')]), 'comment_status': if rt.is_true(rt.call_method(var_product, 'get_reviews_allowed', [rt.new_string('edit')])) { rt.new_string('open') } else { rt.new_string('closed') }, 'post_status': if rt.is_true(rt.call_method(var_product, 'get_status', [rt.new_string('edit')])) { rt.call_method(var_product, 'get_status', [rt.new_string('edit')]) } else { Class_Automattic_WooCommerce_Enums_ProductStatus.publish() }, 'menu_order': rt.call_method(var_product, 'get_menu_order', [rt.new_string('edit')]), 'post_password': rt.call_method(var_product, 'get_post_password', [rt.new_string('edit')]), 'post_name': rt.call_method(var_product, 'get_slug', [rt.new_string('edit')]), 'post_type': rt.new_string('product') }
		if rt.is_true(rt.call_method(var_product, 'get_date_created', [rt.new_string('edit')])) {
			var_post_data['post_date'] = rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_product, 'get_date_created', [rt.new_string('edit')]), 'getOffsetTimestamp', []rt.PhpVal{})])
			var_post_data['post_date_gmt'] = rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_product, 'get_date_created', [rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})])
		}
		if rt.is_true(rt.new_bool(var_changes.array_isset(rt.new_string('date_modified')) && rt.is_true(rt.call_method(var_product, 'get_date_modified', [rt.new_string('edit')])))) {
			var_post_data['post_modified'] = rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_product, 'get_date_modified', [rt.new_string('edit')]), 'getOffsetTimestamp', []rt.PhpVal{})])
			var_post_data['post_modified_gmt'] = rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_product, 'get_date_modified', [rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})])
		} else {
			var_post_data['post_modified'] = rt.call_function('current_time', [rt.new_string('mysql')])
			var_post_data['post_modified_gmt'] = rt.call_function('current_time', [rt.new_string('mysql'), rt.new_int(1)])
		}
		if rt.is_true(rt.call_function('doing_action', [rt.new_string('save_post')])) {
			rt.call_method(var_GLOBALS.array_get('wpdb'), 'update', [rt.get_property(var_GLOBALS.array_get('wpdb'), 'posts'), var_post_data.dup(), rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) }])])
			rt.call_function('clean_post_cache', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
		} else {
			rt.call_function('wp_update_post', [rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) }]), var_post_data.dup()])])
		}
		rt.call_method(var_product, 'read_meta_data', [rt.new_bool(true)])
		// unsupported statement: Stmt_Nop
	} else {
		rt.call_method(var_GLOBALS.array_get('wpdb'), 'update', [rt.get_property(var_GLOBALS.array_get('wpdb'), 'posts'), rt.create_array([rt.ArrayItem{ key: 'post_modified', val: rt.call_function('current_time', [rt.new_string('mysql')]) }, rt.ArrayItem{ key: 'post_modified_gmt', val: rt.call_function('current_time', [rt.new_string('mysql'), rt.new_int(1)]) }]), rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) }])])
		rt.call_function('clean_post_cache', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
	}
	this.update_post_meta(var_product.dup(), false)
	this.update_terms(var_product.dup(), false)
	this.update_visibility(var_product.dup(), false)
	this.update_attributes(var_product.dup(), false)
	this.update_version_and_type(var_product.dup())
	this.handle_updated_props(var_product.dup())
	this.clear_caches(var_product.dup())
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster.class()]), 'maybe_schedule_adjust_download_permissions', [var_product.dup()])
	rt.call_method(var_product, 'apply_changes', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_update_product'), rt.call_method(var_product, 'get_id', []rt.PhpVal{}), var_product.dup()])
}

fn (mut this Class_WC_Product_Data_Store_CPT) delete(var_product rt.PhpVal, var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	mut var_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	mut var_post_type := rt.new_string(if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) { rt.new_string('product_variation') } else { rt.new_string('product') })
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'force_delete', val: false }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		return rt.new_null()
	}
	if rt.is_true(var_args_mutated.array_get('force_delete')) {
		rt.call_function('do_action', ['woocommerce_before_delete_' + (var_post_type).str(), var_id.dup()])
		rt.call_function('wp_delete_post', [var_id.dup()])
		rt.call_method(var_product, 'set_id', [rt.new_int(0)])
		rt.call_function('do_action', ['woocommerce_delete_' + (var_post_type).str(), var_id.dup()])
	} else {
		rt.call_function('wp_trash_post', [var_id.dup()])
		rt.call_method(var_product, 'set_status', [Class_Automattic_WooCommerce_Enums_ProductStatus.trash()])
		rt.call_function('do_action', ['woocommerce_trash_' + (var_post_type).str(), var_id.dup()])
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) read_product_data(var_product rt.PhpVal)  {
	mut var_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	mut var_post_meta_values := rt.call_function('get_post_meta', [var_id.dup()])
	mut var_meta_key_to_props := { '_sku': rt.new_string('sku'), '_global_unique_id': rt.new_string('global_unique_id'), '_regular_price': rt.new_string('regular_price'), '_sale_price': rt.new_string('sale_price'), '_price': rt.new_string('price'), '_sale_price_dates_from': rt.new_string('date_on_sale_from'), '_sale_price_dates_to': rt.new_string('date_on_sale_to'), 'total_sales': rt.new_string('total_sales'), '_tax_status': rt.new_string('tax_status'), '_tax_class': rt.new_string('tax_class'), '_manage_stock': rt.new_string('manage_stock'), '_backorders': rt.new_string('backorders'), '_low_stock_amount': rt.new_string('low_stock_amount'), '_sold_individually': rt.new_string('sold_individually'), '_weight': rt.new_string('weight'), '_length': rt.new_string('length'), '_width': rt.new_string('width'), '_height': rt.new_string('height'), '_upsell_ids': rt.new_string('upsell_ids'), '_crosssell_ids': rt.new_string('cross_sell_ids'), '_purchase_note': rt.new_string('purchase_note'), '_default_attributes': rt.new_string('default_attributes'), '_virtual': rt.new_string('virtual'), '_downloadable': rt.new_string('downloadable'), '_download_limit': rt.new_string('download_limit'), '_download_expiry': rt.new_string('download_expiry'), '_thumbnail_id': rt.new_string('image_id'), '_stock': rt.new_string('stock_quantity'), '_stock_status': rt.new_string('stock_status'), '_wc_average_rating': rt.new_string('average_rating'), '_wc_rating_count': rt.new_string('rating_counts'), '_wc_review_count': rt.new_string('review_count'), '_product_image_gallery': rt.new_string('gallery_image_ids') }
	mut var_set_props := rt.new_array()
	for var_meta_key, var_prop in var_meta_key_to_props {
		mut var_meta_value := if !(var_post_meta_values.array_get(meta_key).array_get(0)).is_null() { var_post_meta_values.array_get(meta_key).array_get(0) } else { rt.new_null() }
		var_set_props.array_set(var_prop, rt.call_function('maybe_unserialize', [var_meta_value.dup()]))
		// unsupported statement: Stmt_Nop
	}
	var_set_props.array_set('category_ids', this.get_term_ids(.dup(), rt.new_string()))
	.array_set(, )
	
}

fn (mut this Class_WC_Product_Data_Store_CPT) load_cogs_data(var_product rt.PhpVal)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) read_stock_quantity(var_product rt.PhpVal, var_new_stock rt.PhpVal)  {
	mut var_new_stock_mutated := var_new_stock
}

fn (mut this Class_WC_Product_Data_Store_CPT) read_extra_data(var_product rt.PhpVal)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) read_visibility(var_product rt.PhpVal)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) read_attributes(var_product rt.PhpVal)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) read_downloads(var_product rt.PhpVal)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_post_meta(var_product rt.PhpVal, force bool)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) handle_updated_props(var_product rt.PhpVal)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) refresh_product_lookup_table(product_id i64)  {
	mut product_id_mutated := product_id
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_terms(var_product rt.PhpVal, force bool)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_visibility(var_product rt.PhpVal, force bool)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_attributes(var_product rt.PhpVal, force bool)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_downloads(var_product rt.PhpVal, force bool) bool {
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_version_and_type(var_product rt.PhpVal)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) clear_caches(var_product rt.PhpVal)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_on_sale_products() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.new_null()
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_featured_product_ids() rt.PhpVal {
}

fn (mut this Class_WC_Product_Data_Store_CPT) is_existing_sku(var_product_id rt.PhpVal, var_sku rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_product_id_mutated := var_product_id
	mut var_sku_mutated := var_sku
}

fn (mut this Class_WC_Product_Data_Store_CPT) is_existing_global_unique_id(var_product_id rt.PhpVal, var_global_unique_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_product_id_mutated := var_product_id
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_product_id_by_sku(var_sku rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_sku_mutated := var_sku
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_product_id_by_global_unique_id(var_global_unique_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_starting_sales() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_ending_sales() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Data_Store_CPT) find_matching_product_variation(var_product rt.PhpVal, var_match_attributes rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Data_Store_CPT) create_all_product_variations(var_product rt.PhpVal, var_limit rt.PhpVal, var_default_values rt.PhpVal, var_metadata rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Product_Data_Store_CPT) sort_all_product_variations(var_parent_id rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_parent_id_mutated := var_parent_id
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_related_products(var_cats_array rt.PhpVal, var_tags_array rt.PhpVal, var_exclude_ids rt.PhpVal, var_limit rt.PhpVal, var_product_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_product_id_mutated := var_product_id
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_related_products_query(var_cats_array rt.PhpVal, var_tags_array rt.PhpVal, var_exclude_ids rt.PhpVal, var_limit rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Data_Store_CPT) set_product_stock(var_product_id_with_stock rt.PhpVal, var_stock_quantity rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_product_stock(var_product_id_with_stock rt.PhpVal, var_stock_quantity rt.PhpVal, operation string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_product_sales(var_product_id rt.PhpVal, var_quantity rt.PhpVal, operation string)  {
	mut var_wpdb := rt.new_null()
	mut var_product_id_mutated := var_product_id
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_average_rating(var_product rt.PhpVal)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_review_count(var_product rt.PhpVal)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_rating_counts(var_product rt.PhpVal)  {
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_shipping_class_id_by_slug(var_slug rt.PhpVal) bool {
	return false
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_products(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WC_Product_Data_Store_CPT) search_products(var_term rt.PhpVal, type string, include_variations bool, all_statuses bool, var_limit rt.PhpVal, var_include rt.PhpVal, var_exclude rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_matches := []rt.PhpVal{}
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_product_type(var_product_id rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
}

fn (mut this Class_WC_Product_Data_Store_CPT) reviews_allowed_query_where(var_where rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_wp_query_args(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_WC_Product_Data_Store_CPT) query(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_data_for_lookup_table(var_id rt.PhpVal, var_table rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_primary_key_for_lookup_table(var_table rt.PhpVal) string {
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_query_for_stock(var_product_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_product_id_mutated := var_product_id
}

fn (mut this Class_WC_Product_Data_Store_CPT) cogs_feature_is_enabled() bool {
}

fn (mut this Class_WC_Product_Data_Store_CPT) use_cogs_lookup_column() bool {
}

struct Class_WC_Data_Store_WP {
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

fn create_wc_product_data_store_cpt() &Class_WC_Product_Data_Store_CPT {
	mut obj := &Class_WC_Product_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
		internal_meta_keys: rt.new_array()
		must_exist_meta_keys: rt.new_array()
		extra_data_saved: rt.new_bool(false)
		updated_props: rt.new_array()
	}
	return obj
}

fn create_wc_data_store_wp() &Class_WC_Data_Store_WP {
	mut obj := &Class_WC_Data_Store_WP{
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

fn (mut this Class_WC_Product_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'obtain_lock_on_sku_for_concurrent_requests' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.obtain_lock_on_sku_for_concurrent_requests(dispatch_arg_0))
		}
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create(dispatch_arg_0)
			return rt.new_null()
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update(dispatch_arg_0)
			return rt.new_null()
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'read_product_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read_product_data(dispatch_arg_0)
			return rt.new_null()
		}
		'load_cogs_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.load_cogs_data(dispatch_arg_0)
			return rt.new_null()
		}
		'read_stock_quantity' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.read_stock_quantity(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'read_extra_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read_extra_data(dispatch_arg_0)
			return rt.new_null()
		}
		'read_visibility' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read_visibility(dispatch_arg_0)
			return rt.new_null()
		}
		'read_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read_attributes(dispatch_arg_0)
			return rt.new_null()
		}
		'read_downloads' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read_downloads(dispatch_arg_0)
			return rt.new_null()
		}
		'update_post_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.update_post_meta(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'handle_updated_props' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_updated_props(dispatch_arg_0)
			return rt.new_null()
		}
		'refresh_product_lookup_table' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.refresh_product_lookup_table(dispatch_arg_0)
			return rt.new_null()
		}
		'update_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.update_terms(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_visibility' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.update_visibility(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.update_attributes(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_downloads' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.update_downloads(dispatch_arg_0, dispatch_arg_1))
		}
		'update_version_and_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_version_and_type(dispatch_arg_0)
			return rt.new_null()
		}
		'clear_caches' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.clear_caches(dispatch_arg_0)
			return rt.new_null()
		}
		'get_on_sale_products' {
			return this.get_on_sale_products()
		}
		'get_featured_product_ids' {
			return this.get_featured_product_ids()
		}
		'is_existing_sku' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.is_existing_sku(dispatch_arg_0, dispatch_arg_1)
		}
		'is_existing_global_unique_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.is_existing_global_unique_id(dispatch_arg_0, dispatch_arg_1)
		}
		'get_product_id_by_sku' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_id_by_sku(dispatch_arg_0)
		}
		'get_product_id_by_global_unique_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_id_by_global_unique_id(dispatch_arg_0)
		}
		'get_starting_sales' {
			return this.get_starting_sales()
		}
		'get_ending_sales' {
			return this.get_ending_sales()
		}
		'find_matching_product_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.find_matching_product_variation(dispatch_arg_0, dispatch_arg_1))
		}
		'create_all_product_variations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.create_all_product_variations(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'sort_all_product_variations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.sort_all_product_variations(dispatch_arg_0)
			return rt.new_null()
		}
		'get_related_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.get_related_products(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'get_related_products_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_related_products_query(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'set_product_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_product_stock(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_product_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.update_product_stock(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'update_product_sales' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.update_product_sales(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'update_average_rating' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_average_rating(dispatch_arg_0)
			return rt.new_null()
		}
		'update_review_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_review_count(dispatch_arg_0)
			return rt.new_null()
		}
		'update_rating_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_rating_counts(dispatch_arg_0)
			return rt.new_null()
		}
		'get_shipping_class_id_by_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_shipping_class_id_by_slug(dispatch_arg_0))
		}
		'get_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_products(dispatch_arg_0)
		}
		'search_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			return this.search_products(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
		}
		'get_product_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_type(dispatch_arg_0)
		}
		'reviews_allowed_query_where' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.reviews_allowed_query_where(dispatch_arg_0, dispatch_arg_1)
		}
		'get_wp_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_wp_query_args(dispatch_arg_0)
		}
		'query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.query(dispatch_arg_0)
		}
		'get_data_for_lookup_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_data_for_lookup_table(dispatch_arg_0, dispatch_arg_1)
		}
		'get_primary_key_for_lookup_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_primary_key_for_lookup_table(dispatch_arg_0))
		}
		'get_query_for_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_query_for_stock(dispatch_arg_0)
		}
		'cogs_feature_is_enabled' {
			return rt.new_bool(this.cogs_feature_is_enabled())
		}
		'use_cogs_lookup_column' {
			return rt.new_bool(this.use_cogs_lookup_column())
		}
		else { return none }
	}
}

fn (this &Class_WC_Product_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'internal_meta_keys' { return this.internal_meta_keys }
		'must_exist_meta_keys' { return this.must_exist_meta_keys }
		'extra_data_saved' { return this.extra_data_saved }
		'updated_props' { return this.updated_props }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'internal_meta_keys' { this.internal_meta_keys = val; return true }
		'must_exist_meta_keys' { this.must_exist_meta_keys = val; return true }
		'extra_data_saved' { this.extra_data_saved = val; return true }
		'updated_props' { this.updated_props = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Data_Store_WP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store_WP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store_WP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_data_stores_class_wc_product_data_store_cpt_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
