import rt

struct Class_WC_Product_Data_Store_CPT {
	rt.PhpObjectBase
pub mut:
	internal_meta_keys   rt.PhpVal = rt.new_array()
	must_exist_meta_keys rt.PhpVal = rt.new_array()
	extra_data_saved     rt.PhpVal = rt.new_bool(false)
	updated_props        rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Product_Data_Store_CPT) obtain_lock_on_sku_for_concurrent_requests(var_product rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_product_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	mut var_sku := rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
	mut var_query := rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INSERT INTO '), rt.get_property(var_wpdb,
			'wc_product_meta_lookup')),
			rt.new_string(' (product_id, sku)\n\t\t\tSELECT %d, %s FROM ')), rt.get_property(var_wpdb,
			'options')), rt.new_string('\n\t\t\tWHERE NOT EXISTS (\n\t\t\t\tSELECT * FROM ')), rt.get_property(var_wpdb,
			'wc_product_meta_lookup')), rt.new_string(' WHERE sku = %s LIMIT 1\n\t\t\t) LIMIT 1;')),
		var_product_id.clone(),
		var_sku.clone(),
		var_sku.clone(),
	])
	mut var_locked := rt.call_function('apply_filters', [
		rt.new_string('wc_product_pre_lock_on_sku'),
		rt.new_null(),
		var_product.clone(),
	])
	if !(var_locked.clone().is_null()) {
		return rt.is_true(var_locked.clone())
	}
	mut var_attempts := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_attempts, rt.new_int(3)))) { break
		 }
		if rt.is_true(rt.greater(var_attempts, rt.new_int(1))) {
			rt.call_function('usleep', [rt.new_int(10000)])
		}
		mut var_result := rt.call_method(var_wpdb, 'query', [
			var_query.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_result)))) {
			break
		}
		rt.post_inc(var_attempts)
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_result)) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
			rt.call_function('sprintf', [
				rt.new_string('Failed to obtain SKU lock for product: ID "%d" with SKU "%s" after %d attempts.'),
				var_product_id.clone(),
				var_sku.clone(),
				var_attempts.clone(),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'error', val: rt.get_property(var_wpdb, 'last_error') },
			]),
		])
	}
	return var_result.to_bool()
}

fn (mut this Class_WC_Product_Data_Store_CPT) create(var_product rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'get_date_created', [
		rt.new_string('edit'),
	])))))
	{
		rt.call_method(var_product, 'set_date_created', [
			rt.call_function('time', []rt.PhpVal{}),
		])
	}
	mut var_id := rt.call_function('wp_insert_post', [
		rt.call_function('apply_filters', [rt.new_string('woocommerce_new_product_data'),
			rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' },
				rt.ArrayItem{
					key: 'post_status'
					val: if rt.is_true(rt.call_method(var_product, 'get_status', []rt.PhpVal{})) {
						rt.call_method(var_product, 'get_status', []rt.PhpVal{})
					} else {
						Class_Automattic_WooCommerce_Enums_ProductStatus.publish()
					}
				}, rt.ArrayItem{ key: 'post_author', val: rt.call_function('get_current_user_id',
					[]rt.PhpVal{}) }, rt.ArrayItem{
					key: 'post_title'
					val: if rt.is_true(rt.call_method(var_product, 'get_name', []rt.PhpVal{})) { rt.call_method(var_product, 'get_name', []rt.PhpVal{}) } else { rt.call_function('__', [
							rt.new_string('Product'),
							rt.new_string('woocommerce'),
						]) }
				}, rt.ArrayItem{ key: 'post_content', val: rt.call_method(var_product,
					'get_description', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'post_excerpt', val: rt.call_method(var_product,
					'get_short_description', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'post_parent', val: rt.call_method(var_product, 'get_parent_id',
					[]rt.PhpVal{}) }, rt.ArrayItem{
					key: 'comment_status'
					val: if rt.is_true(rt.call_method(var_product, 'get_reviews_allowed',
						[]rt.PhpVal{}))
					{
						'open'
					} else {
						'closed'
					}
				}, rt.ArrayItem{ key: 'ping_status', val: 'closed' },
				rt.ArrayItem{ key: 'menu_order', val: rt.call_method(var_product, 'get_menu_order',
					[]rt.PhpVal{}) }, rt.ArrayItem{ key: 'post_password', val: rt.call_method(var_product,
					'get_post_password', [
					rt.new_string('edit'),
				]) }, rt.ArrayItem{ key: 'post_date', val: rt.call_function('gmdate', [
					rt.new_string('Y-m-d H:i:s'),
					rt.call_method(rt.call_method(var_product, 'get_date_created', [
						rt.new_string('edit'),
					]), 'getOffsetTimestamp', []rt.PhpVal{}),
				]) }, rt.ArrayItem{ key: 'post_date_gmt', val: rt.call_function('gmdate', [
					rt.new_string('Y-m-d H:i:s'),
					rt.call_method(rt.call_method(var_product, 'get_date_created', [
						rt.new_string('edit'),
					]), 'getTimestamp', []rt.PhpVal{}),
				]) }, rt.ArrayItem{ key: 'post_name', val: rt.call_method(var_product, 'get_slug', [
					rt.new_string('edit'),
				]) }])]),
		rt.new_bool(true),
	])
	if rt.is_true(var_id)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_id.clone()]))))) {
		rt.call_method(var_product, 'set_id', [var_id.clone()])
		mut var_sku := rt.call_method(var_product, 'get_sku', []rt.PhpVal{})
		if !(!rt.is_true(var_sku))
			&& rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{}))
			&& !(this.obtain_lock_on_sku_for_concurrent_requests(var_product.clone())) {
			rt.call_method(var_product, 'delete', [rt.new_bool(true)])
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The product with SKU (%1$s) you are trying to insert is already present in the lookup table'),
						rt.new_string('woocommerce'),
					]),
					var_sku.clone(),
				]),
			]))))
		}
		mut var_post_object := rt.call_function('get_post', [
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		])
		rt.call_method(var_product, 'set_status', [
			rt.get_property(var_post_object, 'post_status'),
		])
		this.update_post_meta(var_product.clone(), true)
		this.update_terms(var_product.clone(), true)
		this.update_visibility(var_product.clone(), true)
		this.update_attributes(var_product.clone(), true)
		this.update_version_and_type(var_product.clone())
		this.handle_updated_props(var_product.clone())
		this.clear_caches(var_product.clone())
		rt.call_method(var_product, 'save_meta_data', []rt.PhpVal{})
		rt.call_method(var_product, 'apply_changes', []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('woocommerce_new_product'),
			var_id.clone(), var_product.clone()])
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) read(var_product rt.PhpVal) {
	rt.call_method(var_product, 'set_defaults', []rt.PhpVal{})
	mut var_post_object := rt.call_function('get_post', [
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'get_id', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_post_object))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_post_object, 'post_type'))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Invalid product.'),
			rt.new_string('woocommerce'),
		]))))
	}
	rt.call_method(var_product, 'set_props', [
		rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.get_property(var_post_object, 'post_title') },
			rt.ArrayItem{ key: 'slug', val: rt.get_property(var_post_object, 'post_name') },
			rt.ArrayItem{ key: 'date_created', val: this.string_to_timestamp(rt.get_property(var_post_object,
				'post_date_gmt')) },
			rt.ArrayItem{ key: 'date_modified', val: this.string_to_timestamp(rt.get_property(var_post_object,
				'post_modified_gmt')) },
			rt.ArrayItem{ key: 'status', val: rt.get_property(var_post_object, 'post_status') },
			rt.ArrayItem{ key: 'description', val: rt.get_property(var_post_object, 'post_content') },
			rt.ArrayItem{ key: 'short_description', val: rt.get_property(var_post_object,
				'post_excerpt') },
			rt.ArrayItem{ key: 'parent_id', val: rt.get_property(var_post_object, 'post_parent') },
			rt.ArrayItem{ key: 'menu_order', val: rt.get_property(var_post_object, 'menu_order') },
			rt.ArrayItem{ key: 'post_password', val: rt.get_property(var_post_object,
				'post_password') },
			rt.ArrayItem{ key: 'reviews_allowed', val: rt.identical(rt.new_string('open'), rt.get_property(var_post_object,
				'comment_status')) },
		]),
	])
	this.read_attributes(var_product.clone())
	this.read_downloads(var_product.clone())
	this.read_visibility(var_product.clone())
	this.read_product_data(var_product.clone())
	this.read_extra_data(var_product.clone())
	rt.call_method(var_product, 'set_object_read', [rt.new_bool(true)])
	rt.call_function('do_action', [rt.new_string('woocommerce_product_read'),
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		var_product.clone()])
}

fn (mut this Class_WC_Product_Data_Store_CPT) update(var_product rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	rt.call_method(var_product, 'save_meta_data', []rt.PhpVal{})
	mut var_changes := rt.call_method(var_product, 'get_changes', []rt.PhpVal{})
	if rt.is_true(rt.call_function('array_intersect', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'description' },
			rt.ArrayItem{ key: none, val: 'short_description' },
			rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'parent_id' },
			rt.ArrayItem{ key: none, val: 'reviews_allowed' },
			rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'menu_order' },
			rt.ArrayItem{ key: none, val: 'date_created' }, rt.ArrayItem{
				key: none
				val: 'date_modified'
			}, rt.ArrayItem{ key: none, val: 'slug' }, rt.ArrayItem{ key: none, val: 'post_password' }]),
		rt.func_array_keys(var_changes.clone()),
	]))
	{
		mut var_post_data := {
			'post_content':   rt.call_method(var_product, 'get_description', [
				rt.new_string('edit'),
			])
			'post_excerpt':   rt.call_method(var_product, 'get_short_description', [
				rt.new_string('edit'),
			])
			'post_title':     rt.call_method(var_product, 'get_name', [
				rt.new_string('edit'),
			])
			'post_parent':    rt.call_method(var_product, 'get_parent_id', [
				rt.new_string('edit'),
			])
			'comment_status': if rt.is_true(rt.call_method(var_product, 'get_reviews_allowed', [
				rt.new_string('edit'),
			]))
			{ 'open' } else { 'closed' }
			'post_status':    if rt.is_true(rt.call_method(var_product, 'get_status', [
				rt.new_string('edit'),
			]))
			{
				rt.call_method(var_product, 'get_status', [rt.new_string('edit')])
			} else {
				Class_Automattic_WooCommerce_Enums_ProductStatus.publish()
			}
			'menu_order':     rt.call_method(var_product, 'get_menu_order', [
				rt.new_string('edit'),
			])
			'post_password':  rt.call_method(var_product, 'get_post_password', [
				rt.new_string('edit'),
			])
			'post_name':      rt.call_method(var_product, 'get_slug', [
				rt.new_string('edit'),
			])
			'post_type':      rt.new_string('product')
		}
		if rt.is_true(rt.call_method(var_product, 'get_date_created', [
			rt.new_string('edit'),
		]))
		{
			var_post_data['post_date'] = rt.call_function('gmdate', [
				rt.new_string('Y-m-d H:i:s'),
				rt.call_method(rt.call_method(var_product, 'get_date_created', [
					rt.new_string('edit'),
				]), 'getOffsetTimestamp', []rt.PhpVal{}),
			])
			var_post_data['post_date_gmt'] = rt.call_function('gmdate', [
				rt.new_string('Y-m-d H:i:s'),
				rt.call_method(rt.call_method(var_product, 'get_date_created', [
					rt.new_string('edit'),
				]), 'getTimestamp', []rt.PhpVal{}),
			])
		}
		if var_changes.array_isset(rt.new_string('date_modified'))
			&& rt.is_true(rt.call_method(var_product, 'get_date_modified', [rt.new_string('edit')])) {
			var_post_data['post_modified'] = rt.call_function('gmdate', [
				rt.new_string('Y-m-d H:i:s'),
				rt.call_method(rt.call_method(var_product, 'get_date_modified', [
					rt.new_string('edit'),
				]), 'getOffsetTimestamp', []rt.PhpVal{}),
			])
			var_post_data['post_modified_gmt'] = rt.call_function('gmdate', [
				rt.new_string('Y-m-d H:i:s'),
				rt.call_method(rt.call_method(var_product, 'get_date_modified', [
					rt.new_string('edit'),
				]), 'getTimestamp', []rt.PhpVal{}),
			])
		} else {
			var_post_data['post_modified'] = rt.call_function('current_time', [
				rt.new_string('mysql'),
			])
			var_post_data['post_modified_gmt'] = rt.call_function('current_time', [
				rt.new_string('mysql'),
				rt.new_int(1),
			])
		}
		if rt.is_true(rt.call_function('doing_action', [rt.new_string('save_post')])) {
			rt.call_method(var_GLOBALS.array_get(rt.new_string('wpdb')), 'update', [
				rt.get_property(var_GLOBALS.array_get(rt.new_string('wpdb')), 'posts'),
				rt.create_array_from_native_map(var_post_data),
				rt.create_array([
					rt.ArrayItem{ key: 'ID', val: rt.call_method(var_product, 'get_id',
						[]rt.PhpVal{}) },
				]),
			])
			rt.call_function('clean_post_cache', [
				rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
			])
		} else {
			rt.call_function('wp_update_post', [
				rt.call_function('array_merge', [
					rt.create_array([
						rt.ArrayItem{ key: 'ID', val: rt.call_method(var_product, 'get_id',
							[]rt.PhpVal{}) },
					]),
					rt.create_array_from_native_map(var_post_data),
				]),
			])
		}
		rt.call_method(var_product, 'read_meta_data', [rt.new_bool(true)])
	} else {
		rt.call_method(var_GLOBALS.array_get(rt.new_string('wpdb')), 'update', [
			rt.get_property(var_GLOBALS.array_get(rt.new_string('wpdb')), 'posts'),
			rt.create_array([
				rt.ArrayItem{ key: 'post_modified', val: rt.call_function('current_time', [
					rt.new_string('mysql'),
				]) },
				rt.ArrayItem{ key: 'post_modified_gmt', val: rt.call_function('current_time', [
					rt.new_string('mysql'),
					rt.new_int(1),
				]) },
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'ID', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) },
			]),
		])
		rt.call_function('clean_post_cache', [
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		])
	}
	this.update_post_meta(var_product.clone(), false)
	this.update_terms(var_product.clone(), false)
	this.update_visibility(var_product.clone(), false)
	this.update_attributes(var_product.clone(), false)
	this.update_version_and_type(var_product.clone())
	this.handle_updated_props(var_product.clone())
	this.clear_caches(var_product.clone())
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster.class(),
	]), 'maybe_schedule_adjust_download_permissions', [var_product.clone()])
	rt.call_method(var_product, 'apply_changes', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_update_product'),
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		var_product.clone()])
}

fn (mut this Class_WC_Product_Data_Store_CPT) delete(var_product rt.PhpVal, var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	mut var_post_type := rt.new_string((if rt.is_true(rt.call_method(var_product, 'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.variation(),
	]))
	{ 'product_variation' } else { 'product' }).str())
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'force_delete', val: false }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		return
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('force_delete'))) {
		rt.call_function('do_action', [
			rt.new_string('woocommerce_before_delete_' + var_post_type.str()),
			var_id.clone(),
		])
		rt.call_function('wp_delete_post', [var_id.clone()])
		rt.call_method(var_product, 'set_id', [rt.new_int(0)])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_delete_' + var_post_type.str()),
			var_id.clone(),
		])
	} else {
		rt.call_function('wp_trash_post', [var_id.clone()])
		rt.call_method(var_product, 'set_status', [
			Class_Automattic_WooCommerce_Enums_ProductStatus.trash(),
		])
		rt.call_function('do_action', [
			rt.new_string('woocommerce_trash_' + var_post_type.str()),
			var_id.clone(),
		])
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) read_product_data(var_product rt.PhpVal) {
	mut var_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	mut var_post_meta_values := rt.call_function('get_post_meta', [
		var_id.clone()])
	mut var_meta_key_to_props := {
		'_sku':                   rt.new_string('sku')
		'_global_unique_id':      rt.new_string('global_unique_id')
		'_regular_price':         rt.new_string('regular_price')
		'_sale_price':            rt.new_string('sale_price')
		'_price':                 rt.new_string('price')
		'_sale_price_dates_from': rt.new_string('date_on_sale_from')
		'_sale_price_dates_to':   rt.new_string('date_on_sale_to')
		'total_sales':            rt.new_string('total_sales')
		'_tax_status':            rt.new_string('tax_status')
		'_tax_class':             rt.new_string('tax_class')
		'_manage_stock':          rt.new_string('manage_stock')
		'_backorders':            rt.new_string('backorders')
		'_low_stock_amount':      rt.new_string('low_stock_amount')
		'_sold_individually':     rt.new_string('sold_individually')
		'_weight':                rt.new_string('weight')
		'_length':                rt.new_string('length')
		'_width':                 rt.new_string('width')
		'_height':                rt.new_string('height')
		'_upsell_ids':            rt.new_string('upsell_ids')
		'_crosssell_ids':         rt.new_string('cross_sell_ids')
		'_purchase_note':         rt.new_string('purchase_note')
		'_default_attributes':    rt.new_string('default_attributes')
		'_virtual':               rt.new_string('virtual')
		'_downloadable':          rt.new_string('downloadable')
		'_download_limit':        rt.new_string('download_limit')
		'_download_expiry':       rt.new_string('download_expiry')
		'_thumbnail_id':          rt.new_string('image_id')
		'_stock':                 rt.new_string('stock_quantity')
		'_stock_status':          rt.new_string('stock_status')
		'_wc_average_rating':     rt.new_string('average_rating')
		'_wc_rating_count':       rt.new_string('rating_counts')
		'_wc_review_count':       rt.new_string('review_count')
		'_product_image_gallery': rt.new_string('gallery_image_ids')
	}
	mut var_set_props := rt.new_array()
	for var_meta_key, var_prop in var_meta_key_to_props {
		mut var_meta_value := if !(var_post_meta_values.array_get(rt.new_string(meta_key)).array_get(rt.new_int(0))).is_null() {
			var_post_meta_values.array_get(rt.new_string(meta_key)).array_get(rt.new_int(0))
		} else {
			rt.new_null()
		}
		var_set_props.array_set(var_prop, rt.call_function('maybe_unserialize', [
			var_meta_value.clone(),
		]))
	}
	var_set_props.array_set('category_ids', this.get_term_ids(var_product.clone(),
		rt.new_string('product_cat')))
	var_set_props.array_set('tag_ids', this.get_term_ids(var_product.clone(),
		rt.new_string('product_tag')))
	var_set_props.array_set('brand_ids', this.get_term_ids(var_product.clone(),
		rt.new_string('product_brand')))
	var_set_props.array_set('shipping_class_id', rt.call_function('current', [
		this.get_term_ids(var_product.clone(), rt.new_string('product_shipping_class')),
	]))
	var_set_props.array_set('gallery_image_ids', rt.call_function('array_filter', [
		rt.call_function('explode', [rt.new_string(','), if !(var_set_props.array_get(rt.new_string('gallery_image_ids'))).is_null() {
			var_set_props.array_get(rt.new_string('gallery_image_ids'))
		} else {
			rt.new_string('')
		}]),
	]))
	rt.call_method(var_product, 'set_props', [var_set_props.clone()])
	if this.cogs_feature_is_enabled() {
		this.load_cogs_data(var_product.clone())
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) load_cogs_data(var_product rt.PhpVal) {
	mut var_cogs_value := rt.call_function('get_post_meta', [
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		rt.new_string('_cogs_total_value'),
		rt.new_bool(true),
	])
	var_cogs_value = if rt.is_true(rt.identical(rt.new_string(''), var_cogs_value)) {
		rt.new_null()
	} else {
		rt.new_float(var_cogs_value.to_f64())
	}
	var_cogs_value = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_load_product_cogs_value'),
		var_cogs_value.clone(),
		var_product.clone(),
	])
	rt.call_method(var_product, 'set_props', [
		rt.create_array([rt.ArrayItem{ key: 'cogs_value', val: var_cogs_value }]),
	])
}

fn (mut this Class_WC_Product_Data_Store_CPT) read_stock_quantity(var_product rt.PhpVal, var_new_stock rt.PhpVal) {
	mut var_new_stock_mutated := var_new_stock
	mut var_object_read := rt.call_method(var_product, 'get_object_read', []rt.PhpVal{})
	rt.call_method(var_product, 'set_object_read', [rt.new_bool(false)])
	rt.call_method(var_product, 'set_stock_quantity', [if var_new_stock_mutated.clone().is_null() { rt.call_function('get_post_meta', [
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
			rt.new_string('_stock'),
			rt.new_bool(true),
		]) } else { var_new_stock_mutated }])
	rt.call_method(var_product, 'set_object_read', [var_object_read.clone()])
}

fn (mut this Class_WC_Product_Data_Store_CPT) read_extra_data(var_product rt.PhpVal) {
	mut iter_1 := rt.call_method(var_product, 'get_extra_data_keys', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		mut var_function := rt.new_string('set_' + var_key.str())
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_product },
				rt.ArrayItem{ key: none, val: var_function }]),
		]))
		{
			rt.call_method(var_product, var_function, [
				rt.call_function('get_post_meta', [
					rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
					rt.new_string('_' + var_key.str()),
					rt.new_bool(true),
				]),
			])
		}
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) read_visibility(var_product rt.PhpVal) {
	mut var_terms := rt.call_function('get_the_terms', [
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		rt.new_string('product_visibility'),
	])
	mut var_term_names := if var_terms.clone().is_array() { rt.call_function('wp_list_pluck', [
			var_terms.clone(),
			rt.new_string('name'),
		]) } else { rt.new_array() }
	mut var_featured := rt.call_function('in_array', [rt.new_string('featured'),
		var_term_names.clone(), rt.new_bool(true)])
	mut var_exclude_search := rt.call_function('in_array', [
		rt.new_string('exclude-from-search'),
		var_term_names.clone(),
		rt.new_bool(true),
	])
	mut var_exclude_catalog := rt.call_function('in_array', [
		rt.new_string('exclude-from-catalog'),
		var_term_names.clone(),
		rt.new_bool(true),
	])
	if rt.is_true(var_exclude_search) && rt.is_true(var_exclude_catalog) {
		mut var_catalog_visibility := Class_Automattic_WooCommerce_Enums_CatalogVisibility.hidden()
	} else if rt.is_true(var_exclude_search) {
		var_catalog_visibility = Class_Automattic_WooCommerce_Enums_CatalogVisibility.catalog()
	} else if rt.is_true(var_exclude_catalog) {
		var_catalog_visibility = Class_Automattic_WooCommerce_Enums_CatalogVisibility.search()
	} else {
		var_catalog_visibility = Class_Automattic_WooCommerce_Enums_CatalogVisibility.visible()
	}
	rt.call_method(var_product, 'set_props', [
		rt.create_array([rt.ArrayItem{ key: 'featured', val: var_featured },
			rt.ArrayItem{ key: 'catalog_visibility', val: var_catalog_visibility }]),
	])
}

fn (mut this Class_WC_Product_Data_Store_CPT) read_attributes(var_product rt.PhpVal) {
	mut var_product_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	mut var_meta_attributes := rt.call_function('get_post_meta', [
		var_product_id.clone(), rt.new_string('_product_attributes'),
		rt.new_bool(true)])
	if !(!rt.is_true(var_meta_attributes)) && var_meta_attributes.clone().is_array() {
		mut var_attributes := rt.new_array()
		mut iter_2 := var_meta_attributes.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_meta_attribute_value := item_2.val
			mut var_meta_attribute_key := item_2.key
			mut var_meta_value := rt.call_function('array_merge', [
				rt.create_array([rt.ArrayItem{ key: 'name', val: '' },
					rt.ArrayItem{ key: 'value', val: '' }, rt.ArrayItem{ key: 'position', val: 0 },
					rt.ArrayItem{ key: 'is_visible', val: 0 },
					rt.ArrayItem{ key: 'is_variation', val: 0 },
					rt.ArrayItem{ key: 'is_taxonomy', val: 0 }]),
				rt.cast_array(var_meta_attribute_value),
			])
			if !(!rt.is_true(var_meta_value.array_get(rt.new_string('is_taxonomy')))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
					var_meta_value.array_get(rt.new_string('name')),
				])))))
				{
					continue
				}
				mut var_id := rt.call_function('wc_attribute_taxonomy_id_by_name', [
					var_meta_value.array_get(rt.new_string('name')),
				])
				mut var_options := rt.call_function('wc_get_object_terms', [
					var_product_id.clone(), var_meta_value.array_get(rt.new_string('name')),
					rt.new_string('term_id')])
			} else {
				var_id = rt.new_int(0)
				var_options = rt.call_function('wc_get_text_attributes', [
					var_meta_value.array_get(rt.new_string('value')),
				])
			}
			mut var_attribute := create_wc_product_attribute()
			var_attribute.set_id(var_id.clone())
			var_attribute.set_name(var_meta_value.array_get(rt.new_string('name')))
			var_attribute.set_options(var_options.clone())
			var_attribute.set_position(var_meta_value.array_get(rt.new_string('position')))
			var_attribute.set_visible(var_meta_value.array_get(rt.new_string('is_visible')))
			var_attribute.set_variation(var_meta_value.array_get(rt.new_string('is_variation')))
			var_attributes.array_push(rt.call_function('apply_filters', [
				rt.new_string('woocommerce_product_read_attribute'),
				var_attribute,
				var_meta_value.clone(),
				var_product.clone(),
			]))
		}
		rt.call_method(var_product, 'set_attributes', [var_attributes.clone()])
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) read_downloads(var_product rt.PhpVal) {
	mut var_meta_values := rt.call_function('array_filter', [
		rt.cast_array(rt.call_function('get_post_meta', [
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
			rt.new_string('_downloadable_files'),
			rt.new_bool(true),
		])),
	])
	if rt.is_true(var_meta_values) {
		mut var_downloads := rt.new_array()
		mut iter_3 := var_meta_values.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_meta_value := item_3.val
			mut var_key := item_3.key
			if !(var_meta_value.array_isset(rt.new_string('name'))
				&& var_meta_value.array_isset(rt.new_string('file'))) {
				continue
			}
			mut var_download := create_wc_product_download()
			var_download.set_id(var_key.clone())
			var_download.set_name(if rt.is_true(var_meta_value.array_get(rt.new_string('name'))) { var_meta_value.array_get(rt.new_string('name')) } else { rt.call_function('wc_get_filename_from_url', [
					var_meta_value.array_get(rt.new_string('file')),
				]) })
			var_download.set_file(rt.call_function('apply_filters', [
				rt.new_string('woocommerce_file_download_path'),
				var_meta_value.array_get(rt.new_string('file')),
				var_product.clone(),
				var_key.clone(),
			]))
			var_downloads.array_push(rt.call_function('apply_filters', [
				rt.new_string('woocommerce_product_read_download'),
				var_download,
				var_meta_value.clone(),
				var_product.clone(),
			]))
		}
		rt.call_method(var_product, 'set_downloads', [var_downloads.clone()])
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_post_meta(var_product rt.PhpVal, force bool) {
	mut var_meta_key_to_props := {
		'_sku':                   rt.new_string('sku')
		'_global_unique_id':      rt.new_string('global_unique_id')
		'_regular_price':         rt.new_string('regular_price')
		'_sale_price':            rt.new_string('sale_price')
		'_sale_price_dates_from': rt.new_string('date_on_sale_from')
		'_sale_price_dates_to':   rt.new_string('date_on_sale_to')
		'total_sales':            rt.new_string('total_sales')
		'_tax_status':            rt.new_string('tax_status')
		'_tax_class':             rt.new_string('tax_class')
		'_manage_stock':          rt.new_string('manage_stock')
		'_backorders':            rt.new_string('backorders')
		'_low_stock_amount':      rt.new_string('low_stock_amount')
		'_sold_individually':     rt.new_string('sold_individually')
		'_weight':                rt.new_string('weight')
		'_length':                rt.new_string('length')
		'_width':                 rt.new_string('width')
		'_height':                rt.new_string('height')
		'_upsell_ids':            rt.new_string('upsell_ids')
		'_crosssell_ids':         rt.new_string('cross_sell_ids')
		'_purchase_note':         rt.new_string('purchase_note')
		'_default_attributes':    rt.new_string('default_attributes')
		'_virtual':               rt.new_string('virtual')
		'_downloadable':          rt.new_string('downloadable')
		'_product_image_gallery': rt.new_string('gallery_image_ids')
		'_download_limit':        rt.new_string('download_limit')
		'_download_expiry':       rt.new_string('download_expiry')
		'_thumbnail_id':          rt.new_string('image_id')
		'_stock':                 rt.new_string('stock_quantity')
		'_stock_status':          rt.new_string('stock_status')
		'_wc_average_rating':     rt.new_string('average_rating')
		'_wc_rating_count':       rt.new_string('rating_counts')
		'_wc_review_count':       rt.new_string('review_count')
	}
	mut var_extra_data_keys := rt.call_method(var_product, 'get_extra_data_keys', []rt.PhpVal{})
	mut iter_4 := var_extra_data_keys.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_key := item_4.val
		var_meta_key_to_props['_' + var_key.str()] = var_key.clone()
	}
	mut var_props_to_update := if var_force {
		var_meta_key_to_props
	} else {
		this.get_props_to_update(var_product.clone(), var_meta_key_to_props.clone())
	}
	mut iter_5 := var_props_to_update.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_prop := item_5.val
		mut var_meta_key := item_5.key
		mut var_value := rt.call_method(var_product, 'get_${var_prop.to_string()}', [
			rt.new_string('edit'),
		])
		var_value = if var_value.clone().is_string() { rt.call_function('wp_slash', [
				var_value.clone(),
			]) } else { var_value }
		mut switch_val_1 := var_prop
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('virtual')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('downloadable')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('manage_stock')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('sold_individually'))) {
			var_value = rt.call_function('wc_bool_to_string', [
				var_value.clone()])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('gallery_image_ids'))) {
			var_value = rt.call_function('implode', [rt.new_string(','),
				var_value.clone()])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_on_sale_from')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('date_on_sale_to'))) {
			var_value = if rt.is_true(var_value) {
				rt.call_method(var_value, 'getTimestamp', []rt.PhpVal{})
			} else {
				rt.new_string('')
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('stock_quantity'))) {
			if rt.is_true(rt.call_method(var_product, 'is_type', [
				Class_Automattic_WooCommerce_Enums_ProductType.variation(),
			]))
			{
				rt.call_function('do_action', [
					rt.new_string('woocommerce_variation_before_set_stock'),
					var_product.clone(),
				])
			} else {
				rt.call_function('do_action', [
					rt.new_string('woocommerce_product_before_set_stock'),
					var_product.clone(),
				])
			}
		}
		mut var_updated := this.update_or_delete_post_meta(var_product.clone(),
			var_meta_key.clone(), var_value.clone())
		if rt.is_true(var_updated) {
			this.updated_props.array_push(var_prop.clone())
		}
	}
	if this.cogs_feature_is_enabled() {
		mut var_cogs_value := rt.call_method(var_product, 'get_cogs_value', []rt.PhpVal{})
		var_cogs_value = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_save_product_cogs_value'),
			var_cogs_value.clone(),
			var_product.clone(),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cogs_value)))) {
			mut var_updated := this.update_or_delete_post_meta(var_product.clone(),
				rt.new_string('_cogs_total_value'), if var_cogs_value.clone().is_null() {
				rt.new_string('')
			} else {
				var_cogs_value
			})
			if rt.is_true(var_updated) {
				this.updated_props.array_push('cogs_value')
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.extra_data_saved)))) {
		mut iter_6 := var_extra_data_keys.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_key := item_6.val
			mut var_meta_key := rt.new_string('_' + var_key.str())
			mut var_function := rt.new_string('get_' + var_key.str())
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_props_to_update.clone().array_isset(var_meta_key.clone())))))) {
				continue
			}
			if rt.is_true(rt.call_function('is_callable', [
				rt.create_array([rt.ArrayItem{ key: none, val: var_product },
					rt.ArrayItem{ key: none, val: var_function }]),
			]))
			{
				mut var_value := rt.call_method(var_product, var_function, [
					rt.new_string('edit'),
				])
				var_value = if var_value.clone().is_string() { rt.call_function('wp_slash', [
						var_value.clone(),
					]) } else { var_value }
				var_updated = this.update_or_delete_post_meta(var_product.clone(),
					var_meta_key.clone(), var_value.clone())
				if rt.is_true(var_updated) {
					this.updated_props.array_push(var_key.clone())
				}
			}
		}
	}
	if this.update_downloads(var_product.clone(), force) {
		this.updated_props.array_push('downloads')
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) handle_updated_props(var_product rt.PhpVal) {
	mut var_price_is_synced := rt.call_method(var_product, 'is_type', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.variable() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.grouped() },
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_price_is_synced)))) {
		if rt.is_true(rt.call_function('in_array', [rt.new_string('regular_price'), this.updated_props, rt.new_bool(true)]))
			|| rt.is_true(rt.call_function('in_array', [rt.new_string('sale_price'), this.updated_props, rt.new_bool(true)])) {
			if rt.is_true(rt.greater_equal(rt.call_method(var_product, 'get_sale_price', [
				rt.new_string('edit'),
			]), rt.call_method(var_product, 'get_regular_price', [
				rt.new_string('edit')])))
			{
				rt.call_function('update_post_meta', [
					rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
					rt.new_string('_sale_price'),
					rt.new_string(''),
				])
				rt.call_method(var_product, 'set_sale_price', [
					rt.new_string('')])
			}
		}
		mut var_product_price_props := ['date_on_sale_from', 'date_on_sale_to', 'regular_price',
			'sale_price', 'product_type']
		if rt.call_function('array_intersect', [
			rt.create_array_from_list(var_product_price_props),
			this.updated_props,
		]).array_count() > 0 {
			if rt.is_true(rt.call_method(var_product, 'is_on_sale', [
				rt.new_string('edit'),
			]))
			{
				rt.call_function('update_post_meta', [
					rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
					rt.new_string('_price'),
					rt.call_method(var_product, 'get_sale_price', [
						rt.new_string('edit')]),
				])
				rt.call_method(var_product, 'set_price', [
					rt.call_method(var_product, 'get_sale_price', [
						rt.new_string('edit')]),
				])
			} else {
				rt.call_function('update_post_meta', [
					rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
					rt.new_string('_price'),
					rt.call_method(var_product, 'get_regular_price', [
						rt.new_string('edit'),
					]),
				])
				rt.call_method(var_product, 'set_price', [
					rt.call_method(var_product, 'get_regular_price', [
						rt.new_string('edit'),
					]),
				])
			}
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('stock_quantity'), this.updated_props,
		rt.new_bool(true)]))
	{
		if rt.is_true(rt.call_method(var_product, 'is_type', [
			Class_Automattic_WooCommerce_Enums_ProductType.variation(),
		]))
		{
			rt.call_function('do_action', [
				rt.new_string('woocommerce_variation_set_stock'),
				var_product.clone(),
			])
		} else {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_product_set_stock'),
				var_product.clone(),
			])
		}
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('stock_status'), this.updated_props,
		rt.new_bool(true)]))
	{
		if rt.is_true(rt.call_method(var_product, 'is_type', [
			Class_Automattic_WooCommerce_Enums_ProductType.variation(),
		]))
		{
			rt.call_function('do_action', [
				rt.new_string('woocommerce_variation_set_stock_status'),
				rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
				rt.call_method(var_product, 'get_stock_status', []rt.PhpVal{}),
				var_product.clone(),
			])
		} else {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_product_set_stock_status'),
				rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
				rt.call_method(var_product, 'get_stock_status', []rt.PhpVal{}),
				var_product.clone(),
			])
		}
	}
	mut var_props_in_lookup_table := ['sku', 'global_unique_id', 'regular_price', 'sale_price',
		'date_on_sale_from', 'date_on_sale_to', 'total_sales', 'average_rating', 'stock_quantity',
		'stock_status', 'manage_stock', 'downloadable', 'virtual', 'tax_status', 'tax_class']
	if this.cogs_feature_is_enabled() {
		var_props_in_lookup_table << 'cogs_value'
	}
	if rt.is_true(rt.call_function('array_intersect', [this.updated_props,
		rt.create_array_from_list(var_props_in_lookup_table)]))
	{
		this.update_lookup_table(rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
			rt.new_string('wc_product_meta_lookup'))
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_product_object_updated_props'),
		var_product.clone(),
		this.updated_props,
	])
	this.updated_props = rt.new_array()
}

fn (mut this Class_WC_Product_Data_Store_CPT) refresh_product_lookup_table(product_id i64) {
	mut product_id_mutated := product_id
	this.update_lookup_table(rt.new_int(product_id_mutated),
		rt.new_string('wc_product_meta_lookup'))
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_terms(var_product rt.PhpVal, force bool) {
	mut var_changes := rt.call_method(var_product, 'get_changes', []rt.PhpVal{})
	if var_force
		|| rt.is_true(rt.new_bool(var_changes.clone().array_isset(rt.new_string('category_ids')))) {
		mut var_categories := rt.call_method(var_product, 'get_category_ids', [
			rt.new_string('edit'),
		])
		if !rt.is_true(var_categories)
			&& rt.is_true(rt.call_function('get_option', [rt.new_string('default_product_cat'), rt.new_int(0)])) {
			var_categories = rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('get_option', [
					rt.new_string('default_product_cat'),
					rt.new_int(0),
				]) },
			])
		}
		rt.call_function('wp_set_post_terms', [
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
			var_categories.clone(),
			rt.new_string('product_cat'),
			rt.new_bool(false),
		])
	}
	if var_force
		|| rt.is_true(rt.new_bool(var_changes.clone().array_isset(rt.new_string('tag_ids')))) {
		rt.call_function('wp_set_post_terms', [
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
			rt.call_method(var_product, 'get_tag_ids', [rt.new_string('edit')]),
			rt.new_string('product_tag'),
			rt.new_bool(false),
		])
	}
	if var_force
		|| rt.is_true(rt.new_bool(var_changes.clone().array_isset(rt.new_string('brand_ids')))) {
		rt.call_function('wp_set_post_terms', [
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
			rt.call_method(var_product, 'get_brand_ids', [rt.new_string('edit')]),
			rt.new_string('product_brand'),
			rt.new_bool(false),
		])
	}
	if var_force
		|| rt.is_true(rt.new_bool(var_changes.clone().array_isset(rt.new_string('shipping_class_id')))) {
		rt.call_function('wp_set_post_terms', [
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_method(var_product, 'get_shipping_class_id', [
					rt.new_string('edit'),
				]) },
			]),
			rt.new_string('product_shipping_class'),
			rt.new_bool(false),
		])
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_visibility(var_product rt.PhpVal, force bool) {
	mut var_changes := rt.call_method(var_product, 'get_changes', []rt.PhpVal{})
	if var_force
		|| rt.is_true(rt.call_function('array_intersect', [rt.create_array([rt.ArrayItem{
		key: none
		val: 'featured'
	}, rt.ArrayItem{ key: none, val: 'stock_status' }, rt.ArrayItem{
		key: none
		val: 'average_rating'
	}, rt.ArrayItem{ key: none, val: 'catalog_visibility' }]), rt.func_array_keys(var_changes.clone())])) {
		mut var_terms := rt.new_array()
		if rt.is_true(rt.call_method(var_product, 'get_featured', []rt.PhpVal{})) {
			var_terms.array_push('featured')
		}
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock(), rt.call_method(var_product,
			'get_stock_status', []rt.PhpVal{})))
		{
			var_terms.array_push(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock())
		}
		mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
		mut iife_result_0 := iife_temp_0.round(rt.call_method(var_product, 'get_average_rating',
			[]rt.PhpVal{}), rt.new_int(0))
		mut var_rating := rt.call_function('min', [rt.new_int(5), iife_result_0])
		if rt.is_true(rt.greater(var_rating, rt.new_int(0))) {
			var_terms.array_push('rated-' + var_rating.str())
		}
		mut switch_val_2 := rt.call_method(var_product, 'get_catalog_visibility', []rt.PhpVal{})
		if rt.is_true(rt.equal(switch_val_2,
			Class_Automattic_WooCommerce_Enums_CatalogVisibility.hidden()))
		{
			var_terms.array_push('exclude-from-search')
			var_terms.array_push('exclude-from-catalog')
		} else if rt.is_true(rt.equal(switch_val_2,
			Class_Automattic_WooCommerce_Enums_CatalogVisibility.catalog()))
		{
			var_terms.array_push('exclude-from-search')
		} else if rt.is_true(rt.equal(switch_val_2,
			Class_Automattic_WooCommerce_Enums_CatalogVisibility.search()))
		{
			var_terms.array_push('exclude-from-catalog')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			rt.call_function('wp_set_post_terms', [
				rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
				var_terms.clone(),
				rt.new_string('product_visibility'),
				rt.new_bool(false),
			]),
		])))))
		{
			rt.call_function('do_action', [
				rt.new_string('woocommerce_product_set_visibility'),
				rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
				rt.call_method(var_product, 'get_catalog_visibility', []rt.PhpVal{}),
			])
		}
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_attributes(var_product rt.PhpVal, force bool) {
	mut var_changes := rt.call_method(var_product, 'get_changes', []rt.PhpVal{})
	if var_force
		|| rt.is_true(rt.new_bool(var_changes.clone().array_isset(rt.new_string('attributes')))) {
		mut var_attributes := rt.call_method(var_product, 'get_attributes', []rt.PhpVal{})
		mut var_meta_values := rt.new_array()
		if rt.is_true(var_attributes) {
			mut iter_7 := var_attributes.iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_attribute := item_7.val
				mut var_attribute_key := item_7.key
				mut var_value := rt.new_string('')
				if rt.is_true(rt.new_bool(var_attribute.clone().is_null())) {
					if rt.is_true(rt.call_function('taxonomy_exists', [
						var_attribute_key.clone()]))
					{
						rt.call_function('wp_set_object_terms', [
							rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
							rt.new_array(),
							var_attribute_key.clone(),
						])
					} else if rt.is_true(rt.call_function('taxonomy_exists', [
						rt.call_function('urldecode', [var_attribute_key.clone()]),
					]))
					{
						rt.call_function('wp_set_object_terms', [
							rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
							rt.new_array(),
							rt.call_function('urldecode', [var_attribute_key.clone()]),
						])
					}
					continue
				} else if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{})) {
					rt.call_function('wp_set_object_terms', [
						rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
						rt.call_function('wp_list_pluck', [
							rt.cast_array(rt.call_method(var_attribute, 'get_terms', []rt.PhpVal{})),
							rt.new_string('term_id'),
						]),
						rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}),
					])
				} else {
					var_value = rt.call_function('wc_implode_text_attributes', [
						rt.call_method(var_attribute, 'get_options', []rt.PhpVal{}),
					])
				}
				var_meta_values.array_set(var_attribute_key, rt.call_function('array_merge', [
					rt.call_method(var_attribute, 'get_all_extra_data', []rt.PhpVal{}),
					rt.create_array([
						rt.ArrayItem{ key: 'name', val: rt.call_method(var_attribute, 'get_name',
							[]rt.PhpVal{}) },
						rt.ArrayItem{ key: 'value', val: var_value },
						rt.ArrayItem{ key: 'position', val: rt.call_method(var_attribute,
							'get_position', []rt.PhpVal{}) },
						rt.ArrayItem{
							key: 'is_visible'
							val: if rt.is_true(rt.call_method(var_attribute, 'get_visible',
								[]rt.PhpVal{}))
							{
								1
							} else {
								0
							}
						},
						rt.ArrayItem{
							key: 'is_variation'
							val: if rt.is_true(rt.call_method(var_attribute, 'get_variation',
								[]rt.PhpVal{}))
							{
								1
							} else {
								0
							}
						},
						rt.ArrayItem{
							key: 'is_taxonomy'
							val: if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy',
								[]rt.PhpVal{}))
							{
								1
							} else {
								0
							}
						},
					]),
				]))
			}
		}
		this.update_or_delete_post_meta(var_product.clone(), rt.new_string('_product_attributes'), rt.call_function('wp_slash', [
			var_meta_values.clone(),
		]))
		rt.call_function('do_action', [
			rt.new_string('woocommerce_product_attributes_updated'),
			var_product.clone(),
			rt.new_bool(force),
		])
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_downloads(var_product rt.PhpVal, force bool) bool {
	mut var_changes := rt.call_method(var_product, 'get_changes', []rt.PhpVal{})
	if var_force
		|| rt.is_true(rt.new_bool(var_changes.clone().array_isset(rt.new_string('downloads')))) {
		mut var_downloads := rt.call_method(var_product, 'get_downloads', []rt.PhpVal{})
		mut var_meta_values := rt.new_array()
		if rt.is_true(var_downloads) {
			mut iter_8 := var_downloads.iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_download := item_8.val
				mut var_key := item_8.key
				var_meta_values.array_set(var_key, rt.call_method(var_download, 'get_data',
					[]rt.PhpVal{}))
			}
		}
		if rt.is_true(rt.call_method(var_product, 'is_type', [
			Class_Automattic_WooCommerce_Enums_ProductType.variation(),
		]))
		{
			rt.call_function('do_action', [
				rt.new_string('woocommerce_process_product_file_download_paths'),
				rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{}),
				rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
				var_downloads.clone(),
			])
		} else {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_process_product_file_download_paths'),
				rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
				rt.new_int(0),
				var_downloads.clone(),
			])
		}
		return (this.update_or_delete_post_meta(var_product.clone(),
			rt.new_string('_downloadable_files'), rt.call_function('wp_slash', [
			var_meta_values.clone(),
		]))).to_bool()
	}
	return false
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_version_and_type(var_product rt.PhpVal) {
	mut iife_temp_1 := Class_WC_Product_Factory{}
	mut iife_result_1 := iife_temp_1.get_product_type(rt.call_method(var_product, 'get_id',
		[]rt.PhpVal{}))
	mut var_old_type := iife_result_1
	mut var_new_type := rt.call_method(var_product, 'get_type', []rt.PhpVal{})
	rt.call_function('wp_set_object_terms', [
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		var_new_type.clone(),
		rt.new_string('product_type'),
	])
	mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_2 := iife_temp_2.get_constant(rt.new_string('WC_VERSION'))
	rt.call_function('update_post_meta', [
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		rt.new_string('_product_version'),
		iife_result_2,
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_old_type, var_new_type)))) {
		this.updated_props.array_push('product_type')
		rt.call_function('do_action', [rt.new_string('woocommerce_product_type_changed'),
			var_product.clone(), var_old_type.clone(), var_new_type.clone()])
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) clear_caches(var_product rt.PhpVal) {
	rt.call_function('wc_delete_product_transients', [
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
	])
	if rt.is_true(rt.call_method(var_product, 'get_parent_id', [
		rt.new_string('edit')]))
	{
		rt.call_function('wc_delete_product_transients', [
			rt.call_method(var_product, 'get_parent_id', [rt.new_string('edit')]),
		])
		mut iife_temp_3 := Class_WC_Cache_Helper{}
		mut iife_result_3 := iife_temp_3.invalidate_cache_group(rt.new_string('product_' +
			(rt.call_method(var_product, 'get_parent_id', [rt.new_string('edit')])).str()))
	}
	mut iife_temp_4 := Class_WC_Cache_Helper{}
	mut iife_result_4 := iife_temp_4.invalidate_attribute_count(rt.func_array_keys(rt.call_method(var_product,
		'get_attributes', []rt.PhpVal{})))
	mut iife_temp_5 := Class_WC_Cache_Helper{}
	mut iife_result_5 := iife_temp_5.invalidate_cache_group(rt.new_string('product_' +
		(rt.call_method(var_product, 'get_id', []rt.PhpVal{})).str()))
	mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_6 := iife_temp_6.feature_is_enabled(rt.new_string('product_instance_caching'))
	if rt.is_true(iife_result_6) {
		mut var_product_cache := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
			'get', [Class_Automattic_WooCommerce_Internal_Caches_ProductCache.class()])
		rt.call_method(var_product_cache, 'remove', [
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		])
		mut var_parent_id := rt.call_method(var_product, 'get_parent_id', [
			rt.new_string('edit'),
		])
		if rt.is_true(var_parent_id) {
			rt.call_method(var_product_cache, 'remove', [var_parent_id.clone()])
		}
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_on_sale_products() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_exclude_term_ids := rt.new_array()
	mut var_outofstock_join := rt.new_string('')
	mut var_outofstock_where := rt.new_string('')
	mut var_non_published_where := rt.new_string('')
	mut var_product_visibility_term_ids := rt.call_function('wc_get_product_visibility_term_ids',
		[]rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')])))
		&& rt.is_true(var_product_visibility_term_ids.array_get(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock())) {
		var_exclude_term_ids << var_product_visibility_term_ids.array_get(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock())
	}
	if rt.is_true(rt.new_int(var_exclude_term_ids.len)) {
		var_outofstock_join = rt.new_string((
			rt.concat(rt.concat(rt.new_string(' LEFT JOIN ( SELECT object_id FROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' WHERE term_taxonomy_id IN ( ')) +
			(rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), rt.create_array_from_list(var_exclude_term_ids)])])).str() +
			' ) ) AS exclude_join ON exclude_join.object_id = id').str())
		var_outofstock_where = rt.new_string(' AND exclude_join.object_id IS NULL')
	}
	return rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT posts.ID as id, posts.post_parent as parent_id\n\t\t\tFROM '), rt.get_property(var_wpdb,
			'posts')), rt.new_string(' AS posts\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
			'wc_product_meta_lookup')),
			rt.new_string(' AS lookup ON posts.ID = lookup.product_id\n\t\t\t')),
			var_outofstock_join),
			rt.new_string("\n\t\t\tWHERE posts.post_type IN ( 'product', 'product_variation' )\n\t\t\tAND posts.post_status = 'publish'\n\t\t\tAND lookup.onsale = 1\n\t\t\t")),
			var_outofstock_where),
			rt.new_string('\n\t\t\tAND posts.post_parent NOT IN (\n\t\t\t\tSELECT ID FROM `')), rt.get_property(var_wpdb,
			'posts')),
			rt.new_string("` as posts\n\t\t\t\tWHERE posts.post_type = 'product'\n\t\t\t\tAND posts.post_parent = 0\n\t\t\t\tAND posts.post_status != 'publish'\n\t\t\t)\n\t\t\tGROUP BY posts.ID\n\t\t\t")),
	])
	return rt.new_null()
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_featured_product_ids() rt.PhpVal {
	mut var_product_visibility_term_ids := rt.call_function('wc_get_product_visibility_term_ids',
		[]rt.PhpVal{})
	return rt.call_function('get_posts', [
		rt.create_array([
			rt.ArrayItem{ key: 'post_type', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'product' },
				rt.ArrayItem{ key: none, val: 'product_variation' },
			]) },
			rt.ArrayItem{ key: 'posts_per_page', val: -1 },
			rt.ArrayItem{ key: 'post_status', val: 'publish' },
			rt.ArrayItem{ key: 'tax_query', val: rt.create_array([
				rt.ArrayItem{ key: 'relation', val: 'AND' },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
					rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' },
					rt.ArrayItem{ key: 'terms', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: var_product_visibility_term_ids.array_get(rt.new_string('featured'))
						},
					]) },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
					rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' },
					rt.ArrayItem{ key: 'terms', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: var_product_visibility_term_ids.array_get(rt.new_string('exclude-from-catalog'))
						},
					]) },
					rt.ArrayItem{ key: 'operator', val: 'NOT IN' },
				]) },
			]) },
			rt.ArrayItem{ key: 'fields', val: 'id=>parent' },
		]),
	])
}

fn (mut this Class_WC_Product_Data_Store_CPT) is_existing_sku(var_product_id rt.PhpVal, var_sku rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_product_id_mutated := var_product_id
	mut var_sku_mutated := var_sku
	return (rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT posts.ID\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(' as posts\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
				'wc_product_meta_lookup')),
				rt.new_string(" AS lookup ON posts.ID = lookup.product_id\n\t\t\t\tWHERE\n\t\t\t\tposts.post_type IN ( 'product', 'product_variation' )\n\t\t\t\tAND posts.post_status != 'trash'\n\t\t\t\tAND lookup.sku = %s\n\t\t\t\tAND lookup.product_id <> %d\n\t\t\t\tLIMIT 1\n\t\t\t\t")),
			rt.call_function('wp_slash', [var_sku_mutated.clone()]),
			var_product_id_mutated.clone(),
		]),
	])).to_bool()
}

fn (mut this Class_WC_Product_Data_Store_CPT) is_existing_global_unique_id(var_product_id rt.PhpVal, var_global_unique_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_product_id_mutated := var_product_id
	return (rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT posts.ID\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(' as posts\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
				'wc_product_meta_lookup')),
				rt.new_string(" AS lookup ON posts.ID = lookup.product_id\n\t\t\t\tWHERE\n\t\t\t\tposts.post_type IN ( 'product', 'product_variation' )\n\t\t\t\tAND posts.post_status != 'trash'\n\t\t\t\tAND lookup.global_unique_id = %s\n\t\t\t\tAND lookup.product_id <> %d\n\t\t\t\tLIMIT 1\n\t\t\t\t")),
			rt.call_function('wp_slash', [var_global_unique_id.clone()]),
			var_product_id_mutated.clone(),
		]),
	])).to_bool()
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_product_id_by_sku(var_sku rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_sku_mutated := var_sku
	mut var_id := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT posts.ID\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(' as posts\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
				'wc_product_meta_lookup')),
				rt.new_string(" AS lookup ON posts.ID = lookup.product_id\n\t\t\t\tWHERE\n\t\t\t\tposts.post_type IN ( 'product', 'product_variation' )\n\t\t\t\tAND posts.post_status != 'trash'\n\t\t\t\tAND lookup.sku = %s\n\t\t\t\tLIMIT 1\n\t\t\t\t")),
			var_sku_mutated.clone(),
		]),
	])
	return rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_product_id_by_sku'),
		var_id.clone(),
		var_sku_mutated.clone(),
	])).to_i64())
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_product_id_by_global_unique_id(var_global_unique_id rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_id := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT posts.ID\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(' as posts\n\t\t\t\tINNER JOIN ')), rt.get_property(var_wpdb,
				'wc_product_meta_lookup')),
				rt.new_string(" AS lookup ON posts.ID = lookup.product_id\n\t\t\t\tWHERE\n\t\t\t\tposts.post_type IN ( 'product', 'product_variation' )\n\t\t\t\tAND posts.post_status != 'trash'\n\t\t\t\tAND lookup.global_unique_id = %s\n\t\t\t\tLIMIT 1\n\t\t\t\t")),
			var_global_unique_id.clone(),
		]),
	])
	return rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_product_id_by_global_unique_id'),
		var_id.clone(),
		var_global_unique_id.clone(),
	])).to_i64())
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_starting_sales() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT postmeta.post_id FROM '), rt.get_property(var_wpdb,
				'postmeta')), rt.new_string(' as postmeta\n\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string(' as postmeta_2 ON postmeta.post_id = postmeta_2.post_id\n\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string(" as postmeta_3 ON postmeta.post_id = postmeta_3.post_id\n\t\t\t\tWHERE postmeta.meta_key = '_sale_price_dates_from'\n\t\t\t\t\tAND postmeta_2.meta_key = '_price'\n\t\t\t\t\tAND postmeta_3.meta_key = '_sale_price'\n\t\t\t\t\tAND postmeta.meta_value > 0\n\t\t\t\t\tAND postmeta.meta_value < %s\n\t\t\t\t\tAND postmeta_2.meta_value != postmeta_3.meta_value")),
			rt.call_function('time', []rt.PhpVal{}),
		]),
	])
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_ending_sales() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT postmeta.post_id FROM '), rt.get_property(var_wpdb,
				'postmeta')), rt.new_string(' as postmeta\n\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string(' as postmeta_2 ON postmeta.post_id = postmeta_2.post_id\n\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
				'postmeta')),
				rt.new_string(" as postmeta_3 ON postmeta.post_id = postmeta_3.post_id\n\t\t\t\tWHERE postmeta.meta_key = '_sale_price_dates_to'\n\t\t\t\t\tAND postmeta_2.meta_key = '_price'\n\t\t\t\t\tAND postmeta_3.meta_key = '_regular_price'\n\t\t\t\t\tAND postmeta.meta_value > 0\n\t\t\t\t\tAND postmeta.meta_value < %s\n\t\t\t\t\tAND postmeta_2.meta_value != postmeta_3.meta_value")),
			rt.call_function('time', []rt.PhpVal{}),
		]),
	])
}

fn (mut this Class_WC_Product_Data_Store_CPT) find_matching_product_variation(var_product rt.PhpVal, var_match_attributes rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_method(var_product,
		'get_type', []rt.PhpVal{})))
	{
		return 0
	}
	mut var_meta_attribute_names := rt.new_array()
	mut iter_9 := rt.call_method(var_product, 'get_attributes', []rt.PhpVal{}).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_attribute := item_9.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_attribute, 'get_variation',
			[]rt.PhpVal{})))))
		{
			continue
		}
		var_meta_attribute_names << 'attribute_' +(rt.call_function('sanitize_title', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])).str()
	}
	mut var_query := rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT postmeta.post_id, postmeta.meta_key, postmeta.meta_value, posts.menu_order FROM '), rt.get_property(var_wpdb,
			'postmeta')), rt.new_string(' as postmeta\n\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
			'posts')),
			rt.new_string(' as posts ON postmeta.post_id=posts.ID\n\t\t\tWHERE postmeta.post_id IN (\n\t\t\t\tSELECT ID FROM ')), rt.get_property(var_wpdb,
			'posts')), rt.new_string('\n\t\t\t\tWHERE ')), rt.get_property(var_wpdb, 'posts')),
			rt.new_string('.post_parent = %d\n\t\t\t\tAND ')), rt.get_property(var_wpdb, 'posts')),
			rt.new_string(".post_status = 'publish'\n\t\t\t\tAND ")), rt.get_property(var_wpdb,
			'posts')), rt.new_string(".post_type = 'product_variation'\n\t\t\t)\n\t\t\t")),
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
	])
	var_query = rt.concat(var_query, rt.new_string(
		" AND postmeta.meta_key IN ( '" + (rt.call_function('implode', [rt.new_string("','"), rt.call_function('array_map', [rt.new_string('esc_sql'), rt.create_array_from_list(var_meta_attribute_names)])])).str() +
		"' )"))
	var_query = rt.concat(var_query,
		rt.new_string(' ORDER BY posts.menu_order ASC, postmeta.post_id ASC;'))
	mut var_attributes := rt.call_method(var_wpdb, 'get_results', [
		var_query.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attributes)))) {
		return 0
	}
	mut var_sorted_meta := rt.new_array()
	mut iter_10 := var_attributes.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_m := item_10.val
		var_sorted_meta.array_get_mut(rt.get_property(var_m, 'post_id')).array_set(rt.get_property(var_m,
			'meta_key'), rt.get_property(var_m, 'meta_value'))
	}
	mut iter_11 := var_sorted_meta.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_variation := item_11.val
		mut var_variation_id := item_11.key
		mut var_match := rt.new_bool(true)
		mut iter_12 := var_variation.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_attribute_value := item_12.val
			mut var_attribute_key := item_12.key
			mut var_match_any_value := rt.identical(rt.new_string(''), var_attribute_value)
			if rt.is_true(rt.new_bool(!(rt.is_true(var_match_any_value))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_match_attributes.clone().array_isset(var_attribute_key.clone())))))) {
				var_match = rt.new_bool(false)
			}
			if rt.is_true(rt.new_bool(var_match_attributes.clone().array_isset(var_attribute_key.clone()))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(var_match_any_value))))
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_match_attributes.array_get(var_attribute_key), var_attribute_value)))) {
					var_match = rt.new_bool(false)
				}
			}
		}
		if rt.is_true(rt.identical(rt.new_bool(true), var_match)) {
			return var_variation_id.to_i64()
		}
	}
	if rt.is_true(rt.call_function('version_compare', [
		rt.call_function('get_post_meta', [
			rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
			rt.new_string('_product_version'),
			rt.new_bool(true),
		]),
		rt.new_string('2.4.0'),
		rt.new_string('<'),
	]))
	{
		return if rt.is_true(rt.identical(rt.call_function('array_map', [
			rt.new_string('sanitize_title'),
			var_match_attributes.clone(),
		]), var_match_attributes))
		{ 0 } else { this.find_matching_product_variation(var_product.clone(), rt.call_function('array_map', [
				rt.new_string('sanitize_title'),
				var_match_attributes.clone(),
			])) }
	}
	return 0
}

fn (mut this Class_WC_Product_Data_Store_CPT) create_all_product_variations(var_product rt.PhpVal, var_limit rt.PhpVal, var_default_values rt.PhpVal, var_metadata rt.PhpVal) rt.PhpVal {
	mut var_count := rt.new_int(0)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return var_count.clone()
	}
	mut var_attributes := rt.call_function('wc_list_pluck', [
		rt.call_function('array_filter', [
			rt.call_method(var_product, 'get_attributes', []rt.PhpVal{}),
			rt.new_string('wc_attributes_array_filter_variation'),
		]),
		rt.new_string('get_slugs'),
	])
	if !rt.is_true(var_attributes) {
		return var_count.clone()
	}
	mut var_existing_attributes := rt.new_array()
	mut var_child_ids := rt.call_method(var_product, 'get_children', []rt.PhpVal{})
	if !(!rt.is_true(var_child_ids)) {
		rt.call_function('_prime_post_caches', [var_child_ids.clone()])
		mut iter_13 := var_child_ids.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_child_id := item_13.val
			mut var_child := rt.call_function('wc_get_product', [
				var_child_id.clone()])
			if rt.is_true(var_child) {
				var_existing_attributes << rt.call_method(var_child, 'get_attributes',
					[]rt.PhpVal{})
			}
		}
	}
	mut var_possible_attributes := rt.call_function('array_reverse', [
		rt.call_function('wc_array_cartesian', [var_attributes.clone()]),
	])
	mut var_product_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	mut iter_14 := var_possible_attributes.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_possible_attribute := item_14.val
		if rt.is_true(rt.call_function('in_array', [var_possible_attribute.clone(),
			rt.create_array_from_list(var_existing_attributes)]))
		{
			continue
		}
		mut var_variation := rt.call_function('wc_get_product_object', [
			Class_Automattic_WooCommerce_Enums_ProductType.variation(),
		])
		rt.call_method(var_variation, 'set_props', [var_default_values.clone()])
		mut iter_15 := var_metadata.iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_meta := item_15.val
			rt.call_method(var_variation, 'add_meta_data', [
				var_meta.array_get(rt.new_string('key')),
				var_meta.array_get(rt.new_string('value')),
			])
		}
		rt.call_method(var_variation, 'set_parent_id', [var_product_id.clone()])
		rt.call_method(var_variation, 'set_attributes', [var_possible_attribute.clone()])
		mut var_variation_id := rt.call_method(var_variation, 'save', []rt.PhpVal{})
		rt.call_function('do_action', [rt.new_string('product_variation_linked'),
			var_variation_id.clone()])
		rt.pre_inc(var_count)
		if rt.is_true(rt.greater(var_limit, rt.new_int(0)))
			&& rt.is_true(rt.greater_equal(var_count, var_limit)) {
			break
		}
	}
	return var_count.clone()
}

fn (mut this Class_WC_Product_Data_Store_CPT) sort_all_product_variations(var_parent_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_parent_id_mutated := var_parent_id
	mut var_ids := rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT ID FROM '),
				rt.get_property(var_wpdb, 'posts')),
				rt.new_string(" WHERE post_type = 'product_variation' AND post_parent = %d AND post_status in ( 'publish', 'private' ) ORDER BY menu_order ASC, ID ASC")),
			var_parent_id_mutated.clone(),
		]),
	])
	mut var_index := rt.new_int(1)
	mut iter_16 := var_ids.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_id := item_16.val
		rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'),
			rt.create_array([
				rt.ArrayItem{ key: 'menu_order', val: rt.post_inc(var_index) },
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'ID', val: rt.call_function('absint', [
					var_id.clone()]) },
			])])
	}
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_related_products(var_cats_array rt.PhpVal, var_tags_array rt.PhpVal, var_exclude_ids rt.PhpVal, var_limit rt.PhpVal, var_product_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_product_id_mutated := var_product_id
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'categories', val: var_cats_array },
		rt.ArrayItem{ key: 'tags', val: var_tags_array },
		rt.ArrayItem{ key: 'exclude_ids', val: var_exclude_ids },
		rt.ArrayItem{ key: 'limit', val: rt.add(var_limit, rt.new_int(10)) },
	])
	mut var_related_product_query := rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_related_posts_query'),
		this.get_related_products_query(var_cats_array.clone(), var_tags_array.clone(),
			var_exclude_ids.clone(), rt.add(var_limit, rt.new_int(10))),
		var_product_id_mutated.clone(),
		var_args.clone(),
	]))
	return rt.call_method(var_wpdb, 'get_col', [
		rt.call_function('implode', [rt.new_string(' '), var_related_product_query.clone()]),
	])
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_related_products_query(var_cats_array rt.PhpVal, var_tags_array rt.PhpVal, var_exclude_ids rt.PhpVal, var_limit rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_include_term_ids := rt.call_function('array_merge', [
		var_cats_array.clone(), var_tags_array.clone()])
	mut var_exclude_term_ids := rt.new_array()
	mut var_product_visibility_term_ids := rt.call_function('wc_get_product_visibility_term_ids',
		[]rt.PhpVal{})
	if rt.is_true(var_product_visibility_term_ids.array_get(rt.new_string('exclude-from-catalog'))) {
		var_exclude_term_ids << var_product_visibility_term_ids.array_get(rt.new_string('exclude-from-catalog'))
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')])))
		&& rt.is_true(var_product_visibility_term_ids.array_get(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock())) {
		var_exclude_term_ids << var_product_visibility_term_ids.array_get(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock())
	}
	mut var_query := rt.create_array([
		rt.ArrayItem{ key: 'fields', val: rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT DISTINCT ID FROM '), rt.get_property(var_wpdb,
			'posts')), rt.new_string(' p\n\t\t\t')) },
		rt.ArrayItem{ key: 'join', val: '' },
		rt.ArrayItem{
			key: 'where'
			val: "\n\t\t\t\tWHERE 1=1\n\t\t\t\tAND p.post_status = 'publish'\n\t\t\t\tAND p.post_type = 'product'\n\n\t\t\t"
		},
		rt.ArrayItem{ key: 'limits', val: '\n\t\t\t\tLIMIT ' +
			(rt.call_function('absint', [var_limit.clone()])).str() + '\n\t\t\t' },
	])
	if rt.is_true(rt.new_int(var_exclude_term_ids.len)) {
		var_query.array_get(rt.new_string('join')) = rt.concat(var_query.array_get(rt.new_string('join')), rt.new_string(
			rt.concat(rt.concat(rt.new_string(' LEFT JOIN ( SELECT object_id FROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' WHERE term_taxonomy_id IN ( ')) +
			(rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), rt.create_array_from_list(var_exclude_term_ids)])])).str() +
			' ) ) AS exclude_join ON exclude_join.object_id = p.ID'))
		var_query.array_get(rt.new_string('where')) = rt.concat(var_query.array_get(rt.new_string('where')),
			rt.new_string(' AND exclude_join.object_id IS NULL'))
	}
	if rt.is_true(rt.new_int(var_include_term_ids.clone().array_count())) {
		var_query.array_get(rt.new_string('join')) = rt.concat(var_query.array_get(rt.new_string('join')), rt.new_string(
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' INNER JOIN ( SELECT object_id FROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' INNER JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' using( term_taxonomy_id ) WHERE term_id IN ( ')) +
			(rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), var_include_term_ids.clone()])])).str() +
			' ) ) AS include_join ON include_join.object_id = p.ID'))
	}
	if rt.is_true(rt.new_int(var_exclude_ids.clone().array_count())) {
		var_query.array_get(rt.new_string('where')) = rt.concat(var_query.array_get(rt.new_string('where')), rt.new_string(
			' AND p.ID NOT IN ( ' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), var_exclude_ids.clone()])])).str() +
			' )'))
	}
	return var_query.clone()
}

fn (mut this Class_WC_Product_Data_Store_CPT) set_product_stock(var_product_id_with_stock rt.PhpVal, var_stock_quantity rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_sql := rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')),
			rt.new_string(" SET meta_value = %s WHERE post_id = %d AND meta_key='_stock'")),
		rt.call_function('number_format', [rt.new_float(var_stock_quantity.to_f64()),
			rt.get_constant('WC_ROUNDING_PRECISION'), rt.new_string('.'),
			rt.new_string('')]),
		var_product_id_with_stock.clone(),
	])
	var_sql = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_update_product_stock_query'),
		var_sql.clone(),
		var_product_id_with_stock.clone(),
		var_stock_quantity.clone(),
		rt.new_string('set'),
	])
	rt.call_method(var_wpdb, 'query', [var_sql.clone()])
	rt.call_function('wp_cache_delete', [var_product_id_with_stock.clone(),
		rt.new_string('post_meta')])
	this.update_lookup_table(var_product_id_with_stock.clone(),
		rt.new_string('wc_product_meta_lookup'))
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_product_stock(var_product_id_with_stock rt.PhpVal, var_stock_quantity rt.PhpVal, operation string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	rt.call_function('add_post_meta', [var_product_id_with_stock.clone(),
		rt.new_string('_stock'), rt.new_int(0), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_string('set'), rt.new_string(operation))) {
		mut var_new_stock := rt.call_function('wc_stock_amount', [
			var_stock_quantity.clone()])
		mut var_sql := rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')),
				rt.new_string(" SET meta_value = %s WHERE post_id = %d AND meta_key='_stock'")),
			rt.call_function('number_format', [rt.new_float(var_new_stock.to_f64()),
				rt.get_constant('WC_ROUNDING_PRECISION'), rt.new_string('.'),
				rt.new_string('')]),
			var_product_id_with_stock.clone(),
		])
	} else {
		mut var_current_stock := rt.call_function('wc_stock_amount', [
			rt.call_method(var_wpdb, 'get_var', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('SELECT meta_value FROM '), rt.get_property(var_wpdb,
						'postmeta')), rt.new_string(" WHERE post_id = %d AND meta_key='_stock';")),
					var_product_id_with_stock.clone(),
				]),
			]),
		])
		mut switch_val_3 := rt.new_string(operation)
		if rt.is_true(rt.equal(switch_val_3, rt.new_string('increase'))) {
			var_new_stock = rt.add(var_current_stock, rt.call_function('wc_stock_amount', [
				var_stock_quantity.clone(),
			]))
			mut var_multiplier := rt.new_int(1)
		} else {
			var_new_stock = rt.sub(var_current_stock, rt.call_function('wc_stock_amount', [
				var_stock_quantity.clone(),
			]))
			var_multiplier = rt.new_int(-1)
		}
		var_sql = rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')),
				rt.new_string(" SET meta_value = meta_value %+f WHERE post_id = %d AND meta_key='_stock'")),
			rt.mul(rt.call_function('wc_stock_amount', [var_stock_quantity.clone()]),
				var_multiplier),
			var_product_id_with_stock.clone(),
		])
	}
	var_sql = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_update_product_stock_query'),
		var_sql.clone(),
		var_product_id_with_stock.clone(),
		var_new_stock.clone(),
		rt.new_string(operation),
	])
	rt.call_method(var_wpdb, 'query', [var_sql.clone()])
	rt.call_function('wp_cache_delete', [var_product_id_with_stock.clone(),
		rt.new_string('post_meta')])
	this.update_lookup_table(var_product_id_with_stock.clone(),
		rt.new_string('wc_product_meta_lookup'))
	rt.call_function('do_action', [rt.new_string('woocommerce_updated_product_stock'),
		var_product_id_with_stock.clone()])
	return var_new_stock.clone()
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_product_sales(var_product_id rt.PhpVal, var_quantity rt.PhpVal, operation string) {
	mut var_wpdb := rt.new_null()
	mut var_product_id_mutated := var_product_id
	rt.call_function('add_post_meta', [var_product_id_mutated.clone(),
		rt.new_string('total_sales'), rt.new_int(0), rt.new_bool(true)])
	mut switch_val_4 := rt.new_string(operation)
	if rt.is_true(rt.equal(switch_val_4, rt.new_string('increase'))) {
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')),
					rt.new_string(" SET meta_value = meta_value + %f WHERE post_id = %d AND meta_key='total_sales'")),
				var_quantity.clone(),
				var_product_id_mutated.clone(),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('decrease'))) {
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')),
					rt.new_string(" SET meta_value = meta_value - %f WHERE post_id = %d AND meta_key='total_sales'")),
				var_quantity.clone(),
				var_product_id_mutated.clone(),
			]),
		])
	} else {
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'postmeta')),
					rt.new_string(" SET meta_value = %s WHERE post_id = %d AND meta_key='total_sales'")),
				rt.call_function('number_format', [rt.new_float(var_quantity.to_f64()),
					rt.get_constant('WC_ROUNDING_PRECISION'),
					rt.new_string('.'), rt.new_string('')]),
				var_product_id_mutated.clone(),
			]),
		])
	}
	rt.call_function('wp_cache_delete', [var_product_id_mutated.clone(),
		rt.new_string('post_meta')])
	this.update_lookup_table(var_product_id_mutated.clone(),
		rt.new_string('wc_product_meta_lookup'))
	rt.call_function('do_action', [rt.new_string('woocommerce_updated_product_sales'),
		var_product_id_mutated.clone()])
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_average_rating(var_product rt.PhpVal) {
	rt.call_function('update_post_meta', [
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		rt.new_string('_wc_average_rating'),
		rt.call_method(var_product, 'get_average_rating', [rt.new_string('edit')]),
	])
	mut iife_temp_7 := Class_WC_Product_Data_Store_CPT{}
	iife_temp_7.update_visibility(var_product.to_bool(), rt.new_bool(true))
	rt.new_null()
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_review_count(var_product rt.PhpVal) {
	rt.call_function('update_post_meta', [
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		rt.new_string('_wc_review_count'),
		rt.call_method(var_product, 'get_review_count', [rt.new_string('edit')]),
	])
}

fn (mut this Class_WC_Product_Data_Store_CPT) update_rating_counts(var_product rt.PhpVal) {
	rt.call_function('update_post_meta', [
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		rt.new_string('_wc_rating_count'),
		rt.call_method(var_product, 'get_rating_counts', [rt.new_string('edit')]),
	])
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_shipping_class_id_by_slug(var_slug rt.PhpVal) bool {
	mut var_shipping_class_term := rt.call_function('get_term_by', [
		rt.new_string('slug'),
		var_slug.clone(),
		rt.new_string('product_shipping_class'),
	])
	if rt.is_true(var_shipping_class_term) {
		return (rt.get_property(var_shipping_class_term, 'term_id')).to_bool()
	} else {
		return false
	}
	return false
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_products(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_query := create_wc_product_query(var_args_mutated.clone())
	return rt.call_method(var_query, 'get_products', []rt.PhpVal{})
}

fn (mut this Class_WC_Product_Data_Store_CPT) search_products(var_term rt.PhpVal, type string, include_variations bool, all_statuses bool, var_limit rt.PhpVal, var_include rt.PhpVal, var_exclude rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_custom_results := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_pre_search_products'),
		rt.new_bool(false),
		var_term.clone(),
		rt.new_string(type),
		rt.new_bool(include_variations),
		rt.new_bool(all_statuses),
		var_limit.clone(),
	])
	if rt.is_true(rt.new_bool(var_custom_results.clone().is_array())) {
		return var_custom_results.clone()
	}
	mut var_post_types := if var_include_variations { rt.create_array([
			rt.ArrayItem{ key: none, val: 'product' },
			rt.ArrayItem{ key: none, val: 'product_variation' },
		]) } else { rt.create_array([rt.ArrayItem{ key: none, val: 'product' }]) }
	mut var_join_query := rt.new_string('')
	mut var_type_where := rt.new_string('')
	mut var_status_where := rt.new_string('')
	mut var_limit_query := rt.new_string('')
	if var_include_variations {
		var_join_query = rt.new_string((rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb,
			'wc_product_meta_lookup')),
			rt.new_string(" parent_wc_product_meta_lookup\n\t\t\t ON posts.post_type = 'product_variation' AND parent_wc_product_meta_lookup.product_id = posts.post_parent "))).str())
	}
	mut var_post_statuses := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_search_products_post_statuses'),
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('edit_private_products'),
		]))
		{ rt.create_array([
				rt.ArrayItem{ key: none, val: 'private' },
				rt.ArrayItem{ key: none, val: 'publish' },
			]) } else { rt.create_array([
				rt.ArrayItem{ key: none, val: 'publish' },
			]) },
	])
	if rt.is_true(rt.call_function('stristr', [var_term.clone(),
		rt.new_string(' or ')]))
	{
		mut var_term_groups := rt.call_function('preg_split', [
			rt.new_string('/\\s+or\\s+/i'),
			var_term.clone(),
		])
	} else {
		var_term_groups = rt.create_array([rt.ArrayItem{ key: none, val: var_term }])
	}
	mut var_search_where := rt.new_string('')
	mut var_search_queries := rt.new_array()
	mut iter_17 := var_term_groups.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_term_group := item_17.val
		if rt.is_true(rt.call_function('preg_match_all', [
			rt.new_string('/".*?("|$)|((?<=[\\t ",+])|^)[^\\t ",+]+/'),
			var_term_group.clone(),
			rt.create_array_from_list(var_matches),
		]))
		{
			mut var_search_terms :=
				this.get_valid_search_terms(var_matches.array_get(rt.new_int(0)))
			mut var_count := rt.new_int(var_search_terms.clone().array_count())
			if rt.is_true(rt.less(rt.new_int(9), var_count))
				|| rt.is_true(rt.identical(rt.new_int(0), var_count)) {
				var_search_terms = rt.create_array([
					rt.ArrayItem{ key: none, val: var_term_group },
				])
			}
		} else {
			var_search_terms = rt.create_array([
				rt.ArrayItem{ key: none, val: var_term_group },
			])
		}
		mut var_term_group_query := rt.new_array()
		mut iter_18 := var_search_terms.iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_search_term := item_18.val
			mut var_like := rt.new_string('%' +
				(rt.call_method(var_wpdb, 'esc_like', [var_search_term.clone()])).str() + '%')
			mut var_term_query := rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('( posts.post_title LIKE %s ) OR ( posts.post_excerpt LIKE %s ) OR ( posts.post_content LIKE %s ) OR ( wc_product_meta_lookup.sku LIKE %s ) OR ( wc_product_meta_lookup.global_unique_id LIKE %s )'),
				rt.call_function('array_fill', [rt.new_int(0),
					rt.new_int(5), var_like.clone()]),
			])
			if var_include_variations {
				var_term_query = rt.concat(var_term_query, rt.call_method(var_wpdb, 'prepare', [
					rt.new_string(" OR ( wc_product_meta_lookup.sku = '' AND parent_wc_product_meta_lookup.sku LIKE %s )"),
					var_like.clone(),
				]))
				var_term_query = rt.concat(var_term_query, rt.call_method(var_wpdb, 'prepare', [
					rt.new_string(" OR ( wc_product_meta_lookup.global_unique_id = '' AND parent_wc_product_meta_lookup.global_unique_id LIKE %s )"),
					var_like.clone(),
				]))
			}
			var_term_group_query << '( ${var_term_query.to_string()} )'
		}
		if rt.is_true(var_term_group_query) {
			var_search_queries << rt.call_function('implode', [
				rt.new_string(' AND '), rt.create_array_from_list(var_term_group_query)])
		}
	}
	if !(!rt.is_true(var_search_queries)) {
		var_search_where = rt.new_string(
			' AND (' + (rt.call_function('implode', [rt.new_string(') OR ('), rt.create_array_from_list(var_search_queries)])).str() +
			') ')
	}
	if !(!rt.is_true(var_include)) && var_include.clone().is_array() {
		var_search_where = rt.concat(var_search_where, rt.new_string(' AND posts.ID IN(' +
			(rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), var_include.clone()])])).str() +
			') '))
	}
	if !(!rt.is_true(var_exclude)) && var_exclude.clone().is_array() {
		var_search_where = rt.concat(var_search_where, rt.new_string(' AND posts.ID NOT IN(' +
			(rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), var_exclude.clone()])])).str() +
			') '))
	}
	if rt.is_true(rt.identical(rt.new_string('virtual'), rt.new_string(type))) {
		var_type_where = rt.new_string(' AND ( wc_product_meta_lookup.virtual = 1 ) ')
	} else if rt.is_true(rt.identical(rt.new_string('downloadable'), rt.new_string(type))) {
		var_type_where = rt.new_string(' AND ( wc_product_meta_lookup.downloadable = 1 ) ')
	}
	if !var_all_statuses {
		var_status_where = rt.new_string(
			" AND posts.post_status IN ('" + (rt.call_function('implode', [rt.new_string("','"), var_post_statuses.clone()])).str() +
			"') ")
	}
	if rt.is_true(var_limit) {
		var_limit_query = rt.call_method(var_wpdb, 'prepare', [
			rt.new_string(' LIMIT %d '),
			var_limit.clone(),
		])
	}
	mut var_search_results := rt.call_method(var_wpdb, 'get_results', [
		rt.new_string((
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT posts.ID as product_id, posts.post_parent as parent_id FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' posts\n\t\t\t LEFT JOIN ')), rt.get_property(var_wpdb, 'wc_product_meta_lookup')), rt.new_string(' wc_product_meta_lookup ON posts.ID = wc_product_meta_lookup.product_id\n\t\t\t ')), var_join_query), rt.new_string("\n\t\t\tWHERE posts.post_type IN ('")) + (rt.call_function('implode', [rt.new_string("','"), var_post_types.clone()])).str() +
			"')\n\t\t\t${var_search_where.to_string()}\n\t\t\t${var_status_where.to_string()}\n\t\t\t${var_type_where.to_string()}\n\t\t\tORDER BY posts.post_parent ASC, posts.post_title ASC\n\t\t\t${var_limit_query.to_string()}\n\t\t\t").str()),
	])
	mut var_product_ids := rt.call_function('wp_parse_id_list', [
		rt.call_function('array_merge', [
			rt.call_function('wp_list_pluck', [var_search_results.clone(),
				rt.new_string('product_id')]),
			rt.call_function('wp_list_pluck', [var_search_results.clone(),
				rt.new_string('parent_id')]),
		]),
	])
	if rt.is_true(rt.new_bool(var_term.clone().is_long() || var_term.clone().is_double())) {
		mut var_post_id := rt.call_function('absint', [var_term.clone()])
		mut var_post_type := rt.call_function('get_post_type', [
			var_post_id.clone()])
		if rt.is_true(rt.identical(rt.new_string('product_variation'), var_post_type))
			&& var_include_variations {
			var_product_ids.array_push(var_post_id.clone())
		} else if rt.is_true(rt.identical(rt.new_string('product'), var_post_type)) {
			var_product_ids.array_push(var_post_id.clone())
		}
		var_product_ids.array_push(rt.call_function('wp_get_post_parent_id', [
			var_post_id.clone()]))
	}
	return rt.call_function('wp_parse_id_list', [var_product_ids.clone()])
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_product_type(var_product_id rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
	mut iife_temp_8 := Class_WC_Cache_Helper{}
	mut iife_result_8 := iife_temp_8.get_cache_prefix(rt.new_string('product_' +
		var_product_id_mutated.str()))
	mut var_cache_key :=
		rt.new_string(iife_result_8.str() + '_type_' + var_product_id_mutated.str())
	mut var_product_type := rt.call_function('wp_cache_get', [
		var_cache_key.clone(), rt.new_string('products')])
	if rt.is_true(var_product_type) {
		return var_product_type.clone()
	}
	mut var_post_type := rt.call_function('get_post_type', [var_product_id_mutated.clone()])
	if rt.is_true(rt.identical(rt.new_string('product_variation'), var_post_type)) {
		var_product_type = Class_Automattic_WooCommerce_Enums_ProductType.variation()
	} else if rt.is_true(rt.identical(rt.new_string('product'), var_post_type)) {
		mut var_terms := rt.call_function('get_the_terms', [var_product_id_mutated.clone(),
			rt.new_string('product_type')])
		var_product_type = if !(!rt.is_true(var_terms)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()]))))) { rt.call_function('sanitize_title', [
				rt.get_property(rt.call_function('current', [
					var_terms.clone()]), 'name'),
			]) } else { Class_Automattic_WooCommerce_Enums_ProductType.simple() }
	} else {
		var_product_type = rt.new_bool(false)
	}
	rt.call_function('wp_cache_set', [var_cache_key.clone(), var_product_type.clone(),
		rt.new_string('products')])
	return var_product_type.clone()
}

fn (mut this Class_WC_Product_Data_Store_CPT) reviews_allowed_query_where(var_where rt.PhpVal, var_wp_query rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.get_property(var_wp_query, 'query_vars').array_isset(rt.new_string('reviews_allowed'))
		&& rt.get_property(var_wp_query, 'query_vars').array_get(rt.new_string('reviews_allowed')).is_bool() {
		if rt.is_true(rt.get_property(var_wp_query, 'query_vars').array_get(rt.new_string('reviews_allowed'))) {
			var_where = rt.concat(var_where, rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(".comment_status = 'open'")))
		} else {
			var_where = rt.concat(var_where, rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb,
				'posts')), rt.new_string(".comment_status = 'closed'")))
		}
	}
	return var_where.clone()
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_wp_query_args(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
	mut var_key_mapping := {
		'status':         'post_status'
		'page':           'paged'
		'include':        'post__in'
		'stock_quantity': 'stock'
		'average_rating': 'wc_average_rating'
		'review_count':   'wc_review_count'
	}
	for var_query_key, var_db_key in var_key_mapping {
		if var_query_vars_mutated.array_isset(rt.new_string(query_key)) {
			var_query_vars_mutated.array_set(db_key,
				var_query_vars_mutated.array_get(rt.new_string(query_key)))
			var_query_vars_mutated.array_unset(rt.new_string(query_key))
		}
	}
	mut var_boolean_queries := ['virtual', 'downloadable', 'sold_individually', 'manage_stock']
	for var_boolean_query in var_boolean_queries {
		if var_query_vars_mutated.array_isset(rt.new_string(boolean_query))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars_mutated.array_get(rt.new_string(boolean_query)))))) {
			var_query_vars_mutated.array_set(boolean_query, if rt.is_true(var_query_vars_mutated.array_get(rt.new_string(boolean_query))) {
				'yes'
			} else {
				'no'
			})
		}
	}
	mut var_manual_queries := rt.create_array([rt.ArrayItem{ key: 'sku', val: '' },
		rt.ArrayItem{ key: 'featured', val: '' }, rt.ArrayItem{ key: 'visibility', val: '' }])
	mut iter_19 := var_manual_queries.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_manual_query := item_19.val
		mut var_key := item_19.key
		if var_query_vars_mutated.array_isset(var_key) {
			var_manual_queries.array_set(var_key, var_query_vars_mutated.array_get(var_key))
			var_query_vars_mutated.array_unset(var_key)
		}
	}
	mut var_wp_query_args :=
		this.Class_WC_Data_Store_WP.get_wp_query_args(var_query_vars_mutated.clone())
	if !(var_wp_query_args.array_isset(rt.new_string('date_query'))) {
		var_wp_query_args.array_set('date_query', rt.new_array())
	}
	if !(var_wp_query_args.array_isset(rt.new_string('meta_query'))) {
		var_wp_query_args.array_set('meta_query', rt.new_array())
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(),
		var_query_vars_mutated.array_get(rt.new_string('type'))))
	{
		var_wp_query_args.array_set('post_type', 'product_variation')
	} else if var_query_vars_mutated.array_get(rt.new_string('type')).is_array()
		&& rt.is_true(rt.call_function('in_array', [Class_Automattic_WooCommerce_Enums_ProductType.variation(), var_query_vars_mutated.array_get(rt.new_string('type')), rt.new_bool(true)])) {
		var_wp_query_args.array_set('post_type', rt.create_array([
			rt.ArrayItem{ key: none, val: 'product_variation' },
			rt.ArrayItem{ key: none, val: 'product' },
		]))
		var_wp_query_args.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'relation', val: 'OR' },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'product_type' },
				rt.ArrayItem{ key: 'field', val: 'slug' },
				rt.ArrayItem{
					key: 'terms'
					val: var_query_vars_mutated.array_get(rt.new_string('type'))
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'product_type' },
				rt.ArrayItem{ key: 'field', val: 'id' },
				rt.ArrayItem{ key: 'operator', val: 'NOT EXISTS' },
			]) },
		]))
	} else {
		var_wp_query_args.array_set('post_type', 'product')
		var_wp_query_args.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_type' },
			rt.ArrayItem{ key: 'field', val: 'slug' },
			rt.ArrayItem{ key: 'terms', val: var_query_vars_mutated.array_get(rt.new_string('type')) },
		]))
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('category')))) {
		var_wp_query_args.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_cat' },
			rt.ArrayItem{ key: 'field', val: 'slug' },
			rt.ArrayItem{
				key: 'terms'
				val: var_query_vars_mutated.array_get(rt.new_string('category'))
			},
		]))
	} else if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('product_category_id')))) {
		var_wp_query_args.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_cat' },
			rt.ArrayItem{ key: 'field', val: 'term_id' },
			rt.ArrayItem{
				key: 'terms'
				val: var_query_vars_mutated.array_get(rt.new_string('product_category_id'))
			},
		]))
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('tag')))) {
		var_wp_query_args.array_unset(rt.new_string('tag'))
		var_wp_query_args.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_tag' },
			rt.ArrayItem{ key: 'field', val: 'slug' },
			rt.ArrayItem{ key: 'terms', val: var_query_vars_mutated.array_get(rt.new_string('tag')) },
		]))
	} else if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('product_tag_id')))) {
		var_wp_query_args.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_tag' },
			rt.ArrayItem{ key: 'field', val: 'term_id' },
			rt.ArrayItem{
				key: 'terms'
				val: var_query_vars_mutated.array_get(rt.new_string('product_tag_id'))
			},
		]))
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('shipping_class')))) {
		var_wp_query_args.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_shipping_class' },
			rt.ArrayItem{ key: 'field', val: 'slug' },
			rt.ArrayItem{
				key: 'terms'
				val: var_query_vars_mutated.array_get(rt.new_string('shipping_class'))
			},
		]))
	}
	if var_query_vars_mutated.array_isset(rt.new_string('total_sales'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars_mutated.array_get(rt.new_string('total_sales')))))) {
		var_wp_query_args.array_get_mut('meta_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'key', val: 'total_sales' },
			rt.ArrayItem{ key: 'value', val: rt.call_function('absint', [
				var_query_vars_mutated.array_get(rt.new_string('total_sales')),
			]) },
			rt.ArrayItem{ key: 'compare', val: '=' },
		]))
	}
	if rt.is_true(var_manual_queries.array_get(rt.new_string('sku'))) {
		if rt.is_true(rt.identical(rt.new_string('*'),
			var_manual_queries.array_get(rt.new_string('sku'))))
		{
			var_wp_query_args.array_get_mut('meta_query').array_push(rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'key', val: '_sku' },
					rt.ArrayItem{ key: 'compare', val: 'EXISTS' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'key', val: '_sku' },
					rt.ArrayItem{ key: 'value', val: '' },
					rt.ArrayItem{ key: 'compare', val: '!=' },
				]) },
			]))
		} else {
			var_wp_query_args.array_get_mut('meta_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'key', val: '_sku' },
				rt.ArrayItem{ key: 'value', val: var_manual_queries.array_get(rt.new_string('sku')) },
				rt.ArrayItem{ key: 'compare', val: 'LIKE' },
			]))
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		var_manual_queries.array_get(rt.new_string('featured'))))))
	{
		mut var_product_visibility_term_ids := rt.call_function('wc_get_product_visibility_term_ids',
			[]rt.PhpVal{})
		if rt.is_true(var_manual_queries.array_get(rt.new_string('featured'))) {
			var_wp_query_args.array_get_mut('tax_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
				rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' },
				rt.ArrayItem{ key: 'terms', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: var_product_visibility_term_ids.array_get(rt.new_string('featured'))
					},
				]) },
			]))
			var_wp_query_args.array_get_mut('tax_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
				rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' },
				rt.ArrayItem{ key: 'terms', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: var_product_visibility_term_ids.array_get(rt.new_string('exclude-from-catalog'))
					},
				]) },
				rt.ArrayItem{ key: 'operator', val: 'NOT IN' },
			]))
		} else {
			var_wp_query_args.array_get_mut('tax_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
				rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' },
				rt.ArrayItem{ key: 'terms', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: var_product_visibility_term_ids.array_get(rt.new_string('featured'))
					},
				]) },
				rt.ArrayItem{ key: 'operator', val: 'NOT IN' },
			]))
		}
	}
	if rt.is_true(var_manual_queries.array_get(rt.new_string('visibility'))) {
		mut switch_val_5 := var_manual_queries.array_get(rt.new_string('visibility'))
		if rt.is_true(rt.equal(switch_val_5,
			Class_Automattic_WooCommerce_Enums_CatalogVisibility.search()))
		{
			var_wp_query_args.array_get_mut('tax_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
				rt.ArrayItem{ key: 'field', val: 'slug' },
				rt.ArrayItem{ key: 'terms', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'exclude-from-search' },
				]) },
				rt.ArrayItem{ key: 'operator', val: 'NOT IN' },
			]))
		} else if rt.is_true(rt.equal(switch_val_5,
			Class_Automattic_WooCommerce_Enums_CatalogVisibility.catalog()))
		{
			var_wp_query_args.array_get_mut('tax_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
				rt.ArrayItem{ key: 'field', val: 'slug' },
				rt.ArrayItem{ key: 'terms', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'exclude-from-catalog' },
				]) },
				rt.ArrayItem{ key: 'operator', val: 'NOT IN' },
			]))
		} else if rt.is_true(rt.equal(switch_val_5,
			Class_Automattic_WooCommerce_Enums_CatalogVisibility.visible()))
		{
			var_wp_query_args.array_get_mut('tax_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
				rt.ArrayItem{ key: 'field', val: 'slug' },
				rt.ArrayItem{ key: 'terms', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'exclude-from-catalog' },
					rt.ArrayItem{ key: none, val: 'exclude-from-search' },
				]) },
				rt.ArrayItem{ key: 'operator', val: 'NOT IN' },
			]))
		} else if rt.is_true(rt.equal(switch_val_5,
			Class_Automattic_WooCommerce_Enums_CatalogVisibility.hidden()))
		{
			var_wp_query_args.array_get_mut('tax_query').array_push(rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
				rt.ArrayItem{ key: 'field', val: 'slug' },
				rt.ArrayItem{ key: 'terms', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'exclude-from-catalog' },
					rt.ArrayItem{ key: none, val: 'exclude-from-search' },
				]) },
				rt.ArrayItem{ key: 'operator', val: 'AND' },
			]))
		}
	}
	mut var_date_queries := {
		'date_created':      'post_date'
		'date_modified':     'post_modified'
		'date_on_sale_from': '_sale_price_dates_from'
		'date_on_sale_to':   '_sale_price_dates_to'
	}
	for var_query_var_key, var_db_key in var_date_queries {
		if var_query_vars_mutated.array_isset(rt.new_string(query_var_key))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars_mutated.array_get(rt.new_string(query_var_key)))))) {
			mut var_existing_queries := rt.call_function('wp_list_pluck', [
				var_wp_query_args.array_get(rt.new_string('meta_query')),
				rt.new_string('key'),
				rt.new_bool(true),
			])
			mut iter_20 := var_existing_queries.iterator()
			for {
				item_20 := iter_20.next() or { break }
				mut var_query_contents := item_20.val
				mut var_query_index := item_20.key
				var_wp_query_args.array_get(rt.new_string('meta_query')).array_unset(var_query_index)
			}
			var_wp_query_args = this.parse_date_for_wp_query(var_query_vars_mutated.array_get(rt.new_string(query_var_key)),
				rt.new_string(db_key), var_wp_query_args.clone())
		}
	}
	if !(var_query_vars_mutated.array_isset(rt.new_string('paginate')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars_mutated.array_get(rt.new_string('paginate')))))) {
		var_wp_query_args.array_set('no_found_rows', true)
	}
	if var_query_vars_mutated.array_isset(rt.new_string('reviews_allowed'))
		&& var_query_vars_mutated.array_get(rt.new_string('reviews_allowed')).is_bool() {
		rt.call_function('add_filter', [rt.new_string('posts_where'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_Data_Store_CPT', [
					'WC_Data_Store_WP',
					'WC_Object_Data_Store_Interface',
					'WC_Product_Data_Store_Interface',
				], &this) },
				rt.ArrayItem{ key: none, val: 'reviews_allowed_query_where' },
			]),
			rt.new_int(10), rt.new_int(2)])
	}
	if var_query_vars_mutated.array_isset(rt.new_string('orderby'))
		&& rt.is_true(rt.identical(rt.new_string('include'), var_query_vars_mutated.array_get(rt.new_string('orderby')))) {
		var_wp_query_args.array_set('orderby', 'post__in')
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_data_store_cpt_get_products_query'),
		var_wp_query_args.clone(),
		var_query_vars_mutated.clone(),
		rt.new_object('WC_Product_Data_Store_CPT', ['WC_Data_Store_WP',
			'WC_Object_Data_Store_Interface', 'WC_Product_Data_Store_Interface'], &this),
	])
}

fn (mut this Class_WC_Product_Data_Store_CPT) query(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
	mut var_args := this.get_wp_query_args(var_query_vars_mutated.clone())
	if !(!rt.is_true(var_args.array_get(rt.new_string('errors')))) {
		mut var_query := rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'posts', val: rt.new_array() },
			rt.ArrayItem{ key: 'found_posts', val: 0 },
			rt.ArrayItem{ key: 'max_num_pages', val: 0 },
		]))
	} else {
		var_query = create_wp_query(var_args.clone())
	}
	if var_query_vars_mutated.array_isset(rt.new_string('return'))
		&& rt.is_true(rt.identical(rt.new_string('objects'), var_query_vars_mutated.array_get(rt.new_string('return'))))
		&& !(!rt.is_true(rt.get_property(var_query, 'posts'))) {
		rt.call_function('update_post_caches', [rt.get_property(var_query, 'posts'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'product' },
				rt.ArrayItem{ key: none, val: 'product_variation' }])])
	}
	mut var_products := if var_query_vars_mutated.array_isset(rt.new_string('return')) && rt.is_true(rt.identical(rt.new_string('ids'), var_query_vars_mutated.array_get(rt.new_string('return')))) { rt.get_property(var_query, 'posts') } else { rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('wc_get_product'),
				rt.get_property(var_query, 'posts')]),
		]) }
	if var_query_vars_mutated.array_isset(rt.new_string('paginate'))
		&& rt.is_true(var_query_vars_mutated.array_get(rt.new_string('paginate'))) {
		return mut rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'products', val: var_products },
			rt.ArrayItem{ key: 'total', val: rt.get_property(var_query, 'found_posts') },
			rt.ArrayItem{ key: 'max_num_pages', val: rt.get_property(var_query, 'max_num_pages') },
		]))
	}
	return mut rt.cast_object_ptr[Class_stdClass](var_products)
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_data_for_lookup_table(var_id rt.PhpVal, var_table rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	if rt.is_true(rt.identical(rt.new_string('wc_product_meta_lookup'), var_table)) {
		mut var_price_meta := rt.cast_array(rt.call_function('get_post_meta', [
			var_id_mutated.clone(),
			rt.new_string('_price'),
			rt.new_bool(false),
		]))
		mut var_manage_stock := rt.call_function('get_post_meta', [
			var_id_mutated.clone(), rt.new_string('_manage_stock'),
			rt.new_bool(true)])
		mut var_stock := if rt.is_true(rt.identical(rt.new_string('yes'), var_manage_stock)) { rt.call_function('wc_stock_amount', [
				rt.call_function('get_post_meta', [var_id_mutated.clone(),
					rt.new_string('_stock'), rt.new_bool(true)]),
			]) } else { rt.new_null() }
		mut var_price := rt.call_function('wc_format_decimal', [
			rt.call_function('get_post_meta', [var_id_mutated.clone(),
				rt.new_string('_price'), rt.new_bool(true)]),
		])
		mut var_sale_price := rt.call_function('wc_format_decimal', [
			rt.call_function('get_post_meta', [var_id_mutated.clone(),
				rt.new_string('_sale_price'), rt.new_bool(true)]),
		])
		mut var_product_data := {
			'product_id':     rt.call_function('absint', [var_id_mutated.clone()])
			'sku':            rt.call_function('get_post_meta', [
				var_id_mutated.clone(), rt.new_string('_sku'),
				rt.new_bool(true)])
			'virtual':        if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_post_meta', [
				var_id_mutated.clone(),
				rt.new_string('_virtual'),
				rt.new_bool(true),
			])))
			{ 1 } else { 0 }
			'downloadable':   if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_post_meta', [
				var_id_mutated.clone(),
				rt.new_string('_downloadable'),
				rt.new_bool(true),
			])))
			{ 1 } else { 0 }
			'min_price':      rt.call_function('reset', [var_price_meta.clone()])
			'max_price':      rt.call_function('end', [var_price_meta.clone()])
			'onsale':         if rt.is_true(var_sale_price)
				&& rt.is_true(rt.identical(var_price, var_sale_price)) {
				1
			} else {
				0
			}
			'stock_quantity': var_stock
			'stock_status':   rt.call_function('get_post_meta', [
				var_id_mutated.clone(), rt.new_string('_stock_status'),
				rt.new_bool(true)])
			'rating_count':   rt.call_function('array_sum', [
				rt.call_function('array_map', [rt.new_string('intval'),
					rt.cast_array(rt.call_function('get_post_meta', [
						var_id_mutated.clone(), rt.new_string('_wc_rating_count'),
						rt.new_bool(true)]))]),
			])
			'average_rating': rt.call_function('get_post_meta', [
				var_id_mutated.clone(), rt.new_string('_wc_average_rating'),
				rt.new_bool(true)])
			'total_sales':    rt.call_function('get_post_meta', [
				var_id_mutated.clone(), rt.new_string('total_sales'),
				rt.new_bool(true)])
			'tax_status':     rt.call_function('get_post_meta', [
				var_id_mutated.clone(), rt.new_string('_tax_status'),
				rt.new_bool(true)])
			'tax_class':      rt.call_function('get_post_meta', [
				var_id_mutated.clone(), rt.new_string('_tax_class'),
				rt.new_bool(true)])
		}
		if this.use_cogs_lookup_column() {
			mut var_cogs_value := rt.call_function('get_post_meta', [
				var_id_mutated.clone(), rt.new_string('_cogs_total_value'),
				rt.new_bool(true)])
			var_product_data['cogs_total_value'] = if rt.is_true(rt.identical(rt.new_string(''),
				var_cogs_value))
			{
				rt.new_null()
			} else {
				rt.new_float(var_cogs_value.to_f64())
			}
		}
		if rt.is_true(rt.greater_equal(rt.call_function('get_option', [
			rt.new_string('woocommerce_schema_version'),
			rt.new_int(0),
		]), rt.new_int(920)))
		{
			var_product_data['global_unique_id'] = rt.call_function('get_post_meta', [
				var_id_mutated.clone(),
				rt.new_string('_global_unique_id'),
				rt.new_bool(true),
			])
		}
		return var_product_data.clone()
	}
	return rt.new_array()
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_primary_key_for_lookup_table(var_table rt.PhpVal) string {
	if rt.is_true(rt.identical(rt.new_string('wc_product_meta_lookup'), var_table)) {
		return 'product_id'
	}
	return ''
}

fn (mut this Class_WC_Product_Data_Store_CPT) get_query_for_stock(var_product_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_product_id_mutated := var_product_id
	return rt.call_method(var_wpdb, 'prepare', [
		rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT COALESCE( MAX( meta_value ), 0 ) FROM '), rt.get_property(var_wpdb,
			'postmeta')),
			rt.new_string(" as meta_table\n\t\t\tWHERE meta_table.meta_key = '_stock'\n\t\t\tAND meta_table.post_id = %d\n\t\t\t")),
		var_product_id_mutated.clone(),
	])
}

fn (mut this Class_WC_Product_Data_Store_CPT) cogs_feature_is_enabled() bool {
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class(),
	]), 'feature_is_enabled', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WC_Product_Data_Store_CPT) use_cogs_lookup_column() bool {
	mut var_cogs_controller := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class(),
	])
	return rt.is_true(rt.call_method(var_cogs_controller, 'feature_is_enabled', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(var_cogs_controller, 'product_meta_lookup_table_cogs_value_columns_exist', []rt.PhpVal{}))
}

struct Class_WC_Data_Store_WP {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WC_Product_Attribute {
	rt.PhpObjectBase
}

struct Class_WC_Product_Download {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WC_Product_Factory {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_WC_Product_Query {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wc_product_data_store_cpt(_args ...rt.PhpVal) &Class_WC_Product_Data_Store_CPT {
	mut obj := &Class_WC_Product_Data_Store_CPT{
		PhpObjectBase:        rt.PhpObjectBase{}
		internal_meta_keys:   rt.new_array()
		must_exist_meta_keys: rt.new_array()
		extra_data_saved:     rt.new_bool(false)
		updated_props:        rt.new_array()
	}
	return obj
}

fn create_wc_data_store_wp(_args ...rt.PhpVal) &Class_WC_Data_Store_WP {
	mut obj := &Class_WC_Data_Store_WP{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_product_attribute(_args ...rt.PhpVal) &Class_WC_Product_Attribute {
	mut obj := &Class_WC_Product_Attribute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_download(_args ...rt.PhpVal) &Class_WC_Product_Download {
	mut obj := &Class_WC_Product_Download{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_factory(_args ...rt.PhpVal) &Class_WC_Product_Factory {
	mut obj := &Class_WC_Product_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
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

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_query(_args ...rt.PhpVal) &Class_WC_Product_Query {
	mut obj := &Class_WC_Product_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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
			return rt.new_bool(this.is_existing_sku(dispatch_arg_0, dispatch_arg_1))
		}
		'is_existing_global_unique_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.is_existing_global_unique_id(dispatch_arg_0, dispatch_arg_1))
		}
		'get_product_id_by_sku' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get_product_id_by_sku(dispatch_arg_0))
		}
		'get_product_id_by_global_unique_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get_product_id_by_global_unique_id(dispatch_arg_0))
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
			return this.create_all_product_variations(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
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
			return this.get_related_products(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
		}
		'get_related_products_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.get_related_products_query(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
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
			return this.search_products(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
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
		else {
			return none
		}
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
		'internal_meta_keys' {
			this.internal_meta_keys = val
			return true
		}
		'must_exist_meta_keys' {
			this.must_exist_meta_keys = val
			return true
		}
		'extra_data_saved' {
			this.extra_data_saved = val
			return true
		}
		'updated_props' {
			this.updated_props = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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
		else {
			return none
		}
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
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Product_Attribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Attribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Attribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Product_Download) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Download) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Download) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Product_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Product_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
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
