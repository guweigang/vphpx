import rt

struct Class_WC_Product_Variation_Data_Store_CPT {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) exclude_internal_meta_keys(var_meta rt.PhpVal) bool {
	mut var_internal_meta_keys := rt.get_property(rt.new_object('WC_Product_Variation_Data_Store_CPT', ['WC_Product_Data_Store_CPT', 'WC_Object_Data_Store_Interface'], &this), 'internal_meta_keys')
	var_internal_meta_keys.array_push('_cogs_value_is_additive')
	return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_meta, 'meta_key'), var_internal_meta_keys.dup(), rt.new_bool(true)]))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) read(var_product rt.PhpVal)  {
	mut var_GLOBALS := rt.new_null()
	rt.call_method(var_product, 'set_defaults', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'get_id', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	mut var_post_object := rt.call_function('get_post', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_object)))) {
		return rt.new_null()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('WC_Data_Exception', []string{}, create_wc_data_exception(rt.new_string('variation_invalid_id'), rt.call_function('__', [rt.new_string('Invalid product type: passed ID does not correspond to a product variation.'), rt.new_string('woocommerce')]))))
	}
	rt.call_method(var_product, 'set_props', [rt.create_array([rt.ArrayItem{ key: 'name', val: rt.get_property(var_post_object, 'post_title') }, rt.ArrayItem{ key: 'slug', val: rt.get_property(var_post_object, 'post_name') }, rt.ArrayItem{ key: 'date_created', val: this.string_to_timestamp(rt.get_property(var_post_object, 'post_date_gmt')) }, rt.ArrayItem{ key: 'date_modified', val: this.string_to_timestamp(rt.get_property(var_post_object, 'post_modified_gmt')) }, rt.ArrayItem{ key: 'status', val: rt.get_property(var_post_object, 'post_status') }, rt.ArrayItem{ key: 'menu_order', val: rt.get_property(var_post_object, 'menu_order') }, rt.ArrayItem{ key: 'reviews_allowed', val: rt.identical(rt.new_string('open'), rt.get_property(var_post_object, 'comment_status')) }, rt.ArrayItem{ key: 'parent_id', val: rt.get_property(var_post_object, 'post_parent') }, rt.ArrayItem{ key: 'attribute_summary', val: rt.get_property(var_post_object, 'post_excerpt') }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product, 'get_parent_id', [rt.new_string('edit')])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_method(var_product, 'set_parent_id', [rt.new_int(0)])
	}
	this.read_downloads(var_product.dup())
	this.read_product_data(var_product.dup())
	this.read_extra_data(var_product.dup())
	rt.call_method(var_product, 'set_attributes', [rt.call_function('wc_get_product_variation_attributes', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})])])
	mut var_updates := rt.new_array()
	mut var_new_title := this.generate_product_title(var_product.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(var_product, 'set_name', [var_new_title.dup()])
		var_updates = rt.call_function('array_merge', [var_updates.dup(), rt.create_array([rt.ArrayItem{ key: 'post_title', val: var_new_title }])])
	}
	if !(!rt.is_true(var_updates)) {
		rt.call_method(var_GLOBALS.array_get('wpdb'), 'update', [rt.get_property(var_GLOBALS.array_get('wpdb'), 'posts'), var_updates.dup(), rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) }])])
		rt.call_function('clean_post_cache', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
	}
	rt.call_method(var_product, 'set_object_read', [rt.new_bool(true)])
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) create(var_product rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'get_date_created', []rt.PhpVal{}))))) {
		rt.call_method(var_product, 'set_date_created', [rt.call_function('time', []rt.PhpVal{})])
	}
	mut var_new_title := this.generate_product_title(var_product.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(var_product, 'set_name', [var_new_title.dup()])
	}
	mut var_attribute_summary := this.generate_attribute_summary(var_product.dup())
	rt.call_method(var_product, 'set_attribute_summary', [var_attribute_summary.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product, 'get_parent_id', [rt.new_string('edit')])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_method(var_product, 'set_parent_id', [rt.new_int(0)])
	}
	mut var_id := rt.call_function('wp_insert_post', [rt.call_function('apply_filters', [rt.new_string('woocommerce_new_product_variation_data'), rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product_variation' }, rt.ArrayItem{ key: 'post_status', val: if rt.is_true(rt.call_method(var_product, 'get_status', []rt.PhpVal{})) { rt.call_method(var_product, 'get_status', []rt.PhpVal{}) } else { Class_Automattic_WooCommerce_Enums_ProductStatus.publish() } }, rt.ArrayItem{ key: 'post_author', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'post_title', val: rt.call_method(var_product, 'get_name', [rt.new_string('edit')]) }, rt.ArrayItem{ key: 'post_excerpt', val: rt.call_method(var_product, 'get_attribute_summary', [rt.new_string('edit')]) }, rt.ArrayItem{ key: 'post_content', val: '' }, rt.ArrayItem{ key: 'post_parent', val: rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'comment_status', val: 'closed' }, rt.ArrayItem{ key: 'ping_status', val: 'closed' }, rt.ArrayItem{ key: 'menu_order', val: rt.call_method(var_product, 'get_menu_order', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'post_date', val: rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_product, 'get_date_created', [rt.new_string('edit')]), 'getOffsetTimestamp', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'post_date_gmt', val: rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_product, 'get_date_created', [rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'post_name', val: rt.call_method(var_product, 'get_slug', [rt.new_string('edit')]) }])]), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(var_id) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_id.dup()]))))))) {
		rt.call_method(var_product, 'set_id', [var_id.dup()])
		this.update_post_meta(var_product.dup(), true)
		this.update_terms(var_product.dup(), true)
		this.update_visibility(var_product.dup(), true)
		this.update_attributes(var_product.dup(), true)
		this.handle_updated_props(var_product.dup())
		rt.call_method(var_product, 'save_meta_data', []rt.PhpVal{})
		rt.call_method(var_product, 'apply_changes', []rt.PhpVal{})
		this.update_version_and_type(var_product.dup())
		this.update_guid(var_product.dup())
		this.clear_caches(var_product.dup())
		rt.call_function('do_action', [rt.new_string('woocommerce_new_product_variation'), var_id.dup(), var_product.dup()])
	}
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) update(var_product rt.PhpVal)  {
	mut var_GLOBALS := rt.new_null()
	rt.call_method(var_product, 'save_meta_data', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'get_date_created', []rt.PhpVal{}))))) {
		rt.call_method(var_product, 'set_date_created', [rt.call_function('time', []rt.PhpVal{})])
	}
	mut var_new_title := this.generate_product_title(var_product.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(var_product, 'set_name', [var_new_title.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product, 'get_parent_id', [rt.new_string('edit')])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_method(var_product, 'set_parent_id', [rt.new_int(0)])
	}
	mut var_changes := rt.call_method(var_product, 'get_changes', []rt.PhpVal{})
	mut var_new_attribute_summary := this.generate_attribute_summary(var_product.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(var_product, 'set_attribute_summary', [var_new_attribute_summary.dup()])
		if !(var_changes.array_isset(rt.new_string('attributes'))) {
			var_changes.array_set('attributes', true)
		}
	}
	if rt.is_true(rt.call_function('array_intersect', [rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'parent_id' }, rt.ArrayItem{ key: none, val: 'status' }, rt.ArrayItem{ key: none, val: 'menu_order' }, rt.ArrayItem{ key: none, val: 'date_created' }, rt.ArrayItem{ key: none, val: 'date_modified' }, rt.ArrayItem{ key: none, val: 'attributes' }]), rt.func_array_keys(var_changes.dup())])) {
		mut var_post_data := { 'post_title': rt.call_method(var_product, 'get_name', [rt.new_string('edit')]), 'post_excerpt': rt.call_method(var_product, 'get_attribute_summary', [rt.new_string('edit')]), 'post_parent': rt.call_method(var_product, 'get_parent_id', [rt.new_string('edit')]), 'comment_status': rt.new_string('closed'), 'post_status': if rt.is_true(rt.call_method(var_product, 'get_status', [rt.new_string('edit')])) { rt.call_method(var_product, 'get_status', [rt.new_string('edit')]) } else { Class_Automattic_WooCommerce_Enums_ProductStatus.publish() }, 'menu_order': rt.call_method(var_product, 'get_menu_order', [rt.new_string('edit')]), 'post_date': rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_product, 'get_date_created', [rt.new_string('edit')]), 'getOffsetTimestamp', []rt.PhpVal{})]), 'post_date_gmt': rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_product, 'get_date_created', [rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})]), 'post_modified': if var_changes.array_isset(rt.new_string('date_modified')) { rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_product, 'get_date_modified', [rt.new_string('edit')]), 'getOffsetTimestamp', []rt.PhpVal{})]) } else { rt.call_function('current_time', [rt.new_string('mysql')]) }, 'post_modified_gmt': if var_changes.array_isset(rt.new_string('date_modified')) { rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.call_method(rt.call_method(var_product, 'get_date_modified', [rt.new_string('edit')]), 'getTimestamp', []rt.PhpVal{})]) } else { rt.call_function('current_time', [rt.new_string('mysql'), rt.new_int(1)]) }, 'post_type': rt.new_string('product_variation'), 'post_name': rt.call_method(var_product, 'get_slug', [rt.new_string('edit')]) }
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
	this.update_visibility(var_product.dup(), true)
	this.update_attributes(var_product.dup(), false)
	this.handle_updated_props(var_product.dup())
	rt.call_method(var_product, 'apply_changes', []rt.PhpVal{})
	this.update_version_and_type(var_product.dup())
	this.clear_caches(var_product.dup())
	rt.call_function('do_action', [rt.new_string('woocommerce_update_product_variation'), rt.call_method(var_product, 'get_id', []rt.PhpVal{}), var_product.dup()])
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) generate_product_title(var_product rt.PhpVal) rt.PhpVal {
	mut var_attributes := rt.cast_array(rt.call_method(var_product, 'get_attributes', []rt.PhpVal{}))
	mut var_should_include_attributes := rt.new_bool(rt.new_bool(var_attributes.dup().array_count() < 3))
	if rt.is_true(rt.new_bool(rt.is_true(var_should_include_attributes) && 1 < var_attributes.dup().array_count())) {
		{
			mut iter_1 := var_attributes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_name := item_1.key
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_should_include_attributes = rt.new_bool(rt.new_bool(false))
					break
				}
			}
		}
	}
	var_should_include_attributes = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_variation_title_include_attributes'), var_should_include_attributes.dup(), var_product.dup()])
	mut var_separator := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_variation_title_attributes_separator'), rt.new_string(' - '), var_product.dup()])
	mut var_title_base := rt.call_function('get_post_field', [rt.new_string('post_title'), rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})])
	mut var_title_suffix := if rt.is_true(var_should_include_attributes) { rt.call_function('wc_get_formatted_variation', [var_product.dup(), rt.new_bool(true), rt.new_bool(false)]) } else { rt.new_string('') }
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_variation_title'), if rt.is_true(var_title_suffix) { (var_title_base).str() + (var_separator).str() + (var_title_suffix).str() } else { var_title_base }, var_product.dup(), var_title_base.dup(), var_title_suffix.dup()])
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) generate_attribute_summary(var_product rt.PhpVal) rt.PhpVal {
	return rt.call_function('wc_get_formatted_variation', [var_product.dup(), rt.new_bool(true), rt.new_bool(true)])
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) get_attribute_summary(var_product rt.PhpVal) rt.PhpVal {
	return this.generate_attribute_summary(var_product.dup())
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) update_version_and_type(var_product rt.PhpVal)  {
	rt.call_function('wp_set_object_terms', [rt.call_method(var_product, 'get_id', []rt.PhpVal{}), rt.new_string(''), rt.new_string('product_type')])
	rt.call_function('update_post_meta', [rt.call_method(var_product, 'get_id', []rt.PhpVal{}), rt.new_string('_product_version'), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION'))])
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) read_product_data(var_product rt.PhpVal)  {
	mut var_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	mut var_post_meta_values := rt.call_function('get_post_meta', [var_id.dup()])
	mut var_meta_key_to_props := { '_variation_description': 'description', '_regular_price': 'regular_price', '_sale_price': 'sale_price', '_sale_price_dates_from': 'date_on_sale_from', '_sale_price_dates_to': 'date_on_sale_to', '_manage_stock': 'manage_stock', '_stock_status': 'stock_status', '_virtual': 'virtual', '_product_image_gallery': 'gallery_image_ids', '_download_limit': 'download_limit', '_download_expiry': 'download_expiry', '_downloadable': 'downloadable', '_sku': 'sku', '_global_unique_id': 'global_unique_id', '_stock': 'stock_quantity', '_weight': 'weight', '_length': 'length', '_width': 'width', '_height': 'height', '_low_stock_amount': 'low_stock_amount', '_backorders': 'backorders', '_cogs_total_value': 'cogs_total_value', '_cogs_value_is_additive': 'cogs_value_is_additive', '_tax_class': 'tax_class' }
	mut var_variation_data := rt.new_array()
	for var_meta_key, var_prop in var_meta_key_to_props {
		mut var_meta_value := if !(var_post_meta_values.array_get(meta_key).array_get(0)).is_null() { var_post_meta_values.array_get(meta_key).array_get(0) } else { rt.new_string('') }
		var_variation_data.array_set(prop, rt.call_function('maybe_unserialize', [var_meta_value.dup()]))
		// unsupported statement: Stmt_Nop
	}
	var_variation_data.array_set('gallery_image_ids', rt.call_function('array_filter', [rt.call_function('explode', [rt.new_string(','), if !(.array_get()).is_null() { .array_get() } else { rt.new_string('') }])]))
	var_variation_data.array_set('shipping_class_id', rt.call_function('current', [this.get_term_ids(var_id.dup(), rt.new_string('product_shipping_class'))]))
	var_variation_data.array_set('image_id', rt.call_function('get_post_thumbnail_id', [var_id.dup()]))
	var_variation_data.array_set('tax_class', if rt.is_true() {  } else {  })
	rt.call_method(, 'set_props', [.dup()])
	if rt.is_true() {
	}
	if rt.is_true() {
	} else {
	}
	
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) load_cogs_data(var_product rt.PhpVal)  {
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) update_terms(var_product rt.PhpVal, force bool)  {
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) update_visibility(var_product rt.PhpVal, force bool)  {
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) update_attributes(var_product rt.PhpVal, force bool)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) update_post_meta(var_product rt.PhpVal, force bool)  {
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) update_guid(var_product rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

struct Class_WC_Product_Data_Store_CPT {
	rt.PhpObjectBase
}

struct Class_WC_Data_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_product_variation_data_store_cpt() &Class_WC_Product_Variation_Data_Store_CPT {
	mut obj := &Class_WC_Product_Variation_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_data_store_cpt() &Class_WC_Product_Data_Store_CPT {
	mut obj := &Class_WC_Product_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_exception() &Class_WC_Data_Exception {
	mut obj := &Class_WC_Data_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'exclude_internal_meta_keys' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.exclude_internal_meta_keys(dispatch_arg_0))
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update(dispatch_arg_0)
			return rt.new_null()
		}
		'generate_product_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.generate_product_title(dispatch_arg_0)
		}
		'generate_attribute_summary' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.generate_attribute_summary(dispatch_arg_0)
		}
		'get_attribute_summary' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_attribute_summary(dispatch_arg_0)
		}
		'update_version_and_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_version_and_type(dispatch_arg_0)
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
		'update_post_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.update_post_meta(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_guid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_guid(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Product_Variation_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Variation_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Product_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Data_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_data_stores_class_wc_product_variation_data_store_cpt_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
