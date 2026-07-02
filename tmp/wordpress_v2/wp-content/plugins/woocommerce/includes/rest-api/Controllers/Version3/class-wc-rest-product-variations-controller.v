import rt

struct Class_WC_REST_Product_Variations_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
		exclude_status rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_REST_Product_Variations_Controller) register_routes() {
	this.Class_WC_REST_Product_Variations_V2_Controller.register_routes()
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (rt.get_property(rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this), 'rest_base')).str() + '/generate'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the variable product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'delete', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Deletes unused variations.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }]) }, rt.ArrayItem{ key: 'default_values', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Default values for generated variations.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'generate' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_Product_Variations_Controller) get_downloads(var_product rt.PhpVal, context string) rt.PhpVal {
	mut var_product_mutated := var_product
	mut context_mutated := context
	mut var_downloads := []rt.PhpVal{}
	if rt.is_true(rt.call_method(var_product_mutated, 'is_downloadable', []rt.PhpVal{})) || rt.is_true(rt.identical(rt.new_string('edit'), rt.new_string(context_mutated))) {
		mut iter_1 := rt.call_method(var_product_mutated, 'get_downloads', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_file := item_1.val
			mut var_file_id := item_1.key
			var_downloads << rt.create_array([rt.ArrayItem{ key: 'id', val: var_file_id }, rt.ArrayItem{ key: 'name', val: var_file.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'file', val: var_file.array_get(rt.new_string('file')) }])
		}
	}
	return var_downloads.clone()
}

fn (mut this Class_WC_REST_Product_Variations_Controller) prepare_object_for_response(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) { var_request.array_get(rt.new_string('context')) } else { rt.new_string('view') }
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_object, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'type', val: rt.call_method(var_object, 'get_type', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_created', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_created', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_modified', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_modified', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('wc_format_content', [rt.call_method(var_object, 'get_description', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'permalink', val: rt.call_method(var_object, 'get_permalink', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'sku', val: rt.call_method(var_object, 'get_sku', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'global_unique_id', val: rt.call_method(var_object, 'get_global_unique_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'price', val: rt.call_method(var_object, 'get_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'regular_price', val: rt.call_method(var_object, 'get_regular_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'sale_price', val: rt.call_method(var_object, 'get_sale_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_on_sale_from', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_on_sale_from', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_on_sale_from_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_on_sale_from', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_on_sale_to', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_on_sale_to', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_on_sale_to_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_on_sale_to', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'on_sale', val: rt.call_method(var_object, 'is_on_sale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: rt.call_method(var_object, 'get_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'purchasable', val: rt.call_method(var_object, 'is_purchasable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'virtual', val: rt.call_method(var_object, 'is_virtual', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'downloadable', val: rt.call_method(var_object, 'is_downloadable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'downloads', val: this.get_downloads(var_object.clone(), (var_context).str()) }, rt.ArrayItem{ key: 'download_limit', val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_object, 'get_download_limit', []rt.PhpVal{}))))) { rt.new_int((rt.call_method(var_object, 'get_download_limit', []rt.PhpVal{})).to_i64()) } else { -1 } }, rt.ArrayItem{ key: 'download_expiry', val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_object, 'get_download_expiry', []rt.PhpVal{}))))) { rt.new_int((rt.call_method(var_object, 'get_download_expiry', []rt.PhpVal{})).to_i64()) } else { -1 } }, rt.ArrayItem{ key: 'tax_status', val: rt.call_method(var_object, 'get_tax_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'tax_class', val: rt.call_method(var_object, 'get_tax_class', [var_context.clone()]) }, rt.ArrayItem{ key: 'manage_stock', val: rt.call_method(var_object, 'managing_stock', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'stock_quantity', val: rt.call_method(var_object, 'get_stock_quantity', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'stock_status', val: rt.call_method(var_object, 'get_stock_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backorders', val: rt.call_method(var_object, 'get_backorders', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backorders_allowed', val: rt.call_method(var_object, 'backorders_allowed', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backordered', val: rt.call_method(var_object, 'is_on_backorder', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'low_stock_amount', val: if rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_object, 'get_low_stock_amount', []rt.PhpVal{}))) { rt.new_null() } else { rt.call_method(var_object, 'get_low_stock_amount', []rt.PhpVal{}) } }, rt.ArrayItem{ key: 'weight', val: rt.call_method(var_object, 'get_weight', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'dimensions', val: rt.create_array([rt.ArrayItem{ key: 'length', val: rt.call_method(var_object, 'get_length', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'width', val: rt.call_method(var_object, 'get_width', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'height', val: rt.call_method(var_object, 'get_height', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'shipping_class', val: rt.call_method(var_object, 'get_shipping_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_class_id', val: rt.call_method(var_object, 'get_shipping_class_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'image', val: this.get_image(var_object.clone(), (var_context).str()) }, rt.ArrayItem{ key: 'attributes', val: this.get_attributes(var_object.clone()) }, rt.ArrayItem{ key: 'menu_order', val: rt.call_method(var_object, 'get_menu_order', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'meta_data', val: rt.call_method(var_object, 'get_meta_data', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'name', val: rt.call_function('wc_get_formatted_variation', [var_object.clone(), rt.new_bool(true), rt.new_bool(false), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'parent_id', val: rt.call_method(var_object, 'get_parent_id', []rt.PhpVal{}) }])
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	if rt.is_true(this.cogs_is_enabled()) {
		this.add_cogs_info_to_returned_product_data(var_data.clone(), var_object.clone())
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_data.clone()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_object.clone(), var_request.clone())])
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_prepare_'), rt.get_property(rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this), 'post_type')), rt.new_string('_object')), var_response.clone(), var_object.clone(), var_request.clone()])
}

fn (mut this Class_WC_REST_Product_Variations_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	if var_request.array_isset(rt.new_string('id')) {
	mut var_variation := rt.call_function('wc_get_product', [rt.call_function('absint', [var_request.array_get(rt.new_string('id'))])])
	} else {
	var_variation = create_wc_product_variation()
	}
	rt.call_method(var_variation, 'set_parent_id', [rt.call_function('absint', [var_request.array_get(rt.new_string('product_id'))])])
	if var_request.array_isset(rt.new_string('status')) {
		rt.call_method(var_variation, 'set_status', [if rt.is_true(rt.call_function('get_post_status_object', [var_request.array_get(rt.new_string('status'))])) { var_request.array_get(rt.new_string('status')) } else { Class_Automattic_WooCommerce_Enums_ProductStatus.draft() }])
	}
	if var_request.array_isset(rt.new_string('sku')) {
		rt.call_method(var_variation, 'set_sku', [rt.call_function('wc_clean', [var_request.array_get(rt.new_string('sku'))])])
	}
	if var_request.array_isset(rt.new_string('global_unique_id')) {
		rt.call_method(var_variation, 'set_global_unique_id', [rt.call_function('wc_clean', [var_request.array_get(rt.new_string('global_unique_id'))])])
	}
	if var_request.array_isset(rt.new_string('image')) {
		if rt.is_true(rt.new_bool(var_request.array_get(rt.new_string('image')).is_array())) {
		var_variation = this.set_variation_image(var_variation.clone(), var_request.array_get(rt.new_string('image')))
		} else {
			rt.call_method(var_variation, 'set_image_id', [rt.new_string('')])
		}
	}
	if var_request.array_isset(rt.new_string('virtual')) {
		rt.call_method(var_variation, 'set_virtual', [var_request.array_get(rt.new_string('virtual'))])
	}
	if var_request.array_isset(rt.new_string('downloadable')) {
		rt.call_method(var_variation, 'set_downloadable', [var_request.array_get(rt.new_string('downloadable'))])
	}
	if rt.is_true(rt.call_method(var_variation, 'get_downloadable', []rt.PhpVal{})) {
		if var_request.array_isset(rt.new_string('downloads')) && var_request.array_get(rt.new_string('downloads')).is_array() {
		var_variation = this.save_downloadable_files(var_variation.clone(), var_request.array_get(rt.new_string('downloads')))
		}
		if var_request.array_isset(rt.new_string('download_limit')) {
			rt.call_method(var_variation, 'set_download_limit', [var_request.array_get(rt.new_string('download_limit'))])
		}
		if var_request.array_isset(rt.new_string('download_expiry')) {
			rt.call_method(var_variation, 'set_download_expiry', [var_request.array_get(rt.new_string('download_expiry'))])
		}
	}
	var_variation = this.save_product_shipping_data(var_variation.clone(), var_request.clone())
	if var_request.array_isset(rt.new_string('manage_stock')) {
		rt.call_method(var_variation, 'set_manage_stock', [var_request.array_get(rt.new_string('manage_stock'))])
	}
	if var_request.array_isset(rt.new_string('stock_status')) {
		rt.call_method(var_variation, 'set_stock_status', [var_request.array_get(rt.new_string('stock_status'))])
	}
	if var_request.array_isset(rt.new_string('backorders')) {
		rt.call_method(var_variation, 'set_backorders', [var_request.array_get(rt.new_string('backorders'))])
	}
	if rt.is_true(rt.call_method(var_variation, 'get_manage_stock', []rt.PhpVal{})) {
		if var_request.array_isset(rt.new_string('stock_quantity')) {
			rt.call_method(var_variation, 'set_stock_quantity', [var_request.array_get(rt.new_string('stock_quantity'))])
		} else if var_request.array_isset(rt.new_string('inventory_delta')) {
			mut var_stock_quantity := rt.call_function('wc_stock_amount', [rt.call_method(var_variation, 'get_stock_quantity', []rt.PhpVal{})])
			var_stock_quantity = rt.add(var_stock_quantity, rt.call_function('wc_stock_amount', [var_request.array_get(rt.new_string('inventory_delta'))]))
			rt.call_method(var_variation, 'set_stock_quantity', [var_stock_quantity.clone()])
		}
		if rt.is_true(rt.new_bool(rt.call_method(var_request, 'get_params', []rt.PhpVal{}).array_isset(rt.new_string('low_stock_amount')))) {
			if rt.is_true(rt.identical(rt.new_null(), var_request.array_get(rt.new_string('low_stock_amount')))) {
				rt.call_method(var_variation, 'set_low_stock_amount', [rt.new_string('')])
			} else {
				rt.call_method(var_variation, 'set_low_stock_amount', [rt.call_function('wc_stock_amount', [var_request.array_get(rt.new_string('low_stock_amount'))])])
			}
		}
	} else {
		rt.call_method(var_variation, 'set_backorders', [rt.new_string('no')])
		rt.call_method(var_variation, 'set_stock_quantity', [rt.new_string('')])
		rt.call_method(var_variation, 'set_low_stock_amount', [rt.new_string('')])
	}
	if var_request.array_isset(rt.new_string('regular_price')) {
		rt.call_method(var_variation, 'set_regular_price', [var_request.array_get(rt.new_string('regular_price'))])
	}
	if var_request.array_isset(rt.new_string('sale_price')) {
		rt.call_method(var_variation, 'set_sale_price', [var_request.array_get(rt.new_string('sale_price'))])
	}
	if var_request.array_isset(rt.new_string('date_on_sale_from')) {
		rt.call_method(var_variation, 'set_date_on_sale_from', [var_request.array_get(rt.new_string('date_on_sale_from'))])
	}
	if var_request.array_isset(rt.new_string('date_on_sale_from_gmt')) {
		rt.call_method(var_variation, 'set_date_on_sale_from', [if rt.is_true(var_request.array_get(rt.new_string('date_on_sale_from_gmt'))) { rt.call_function('strtotime', [var_request.array_get(rt.new_string('date_on_sale_from_gmt'))]) } else { rt.new_null() }])
	}
	if var_request.array_isset(rt.new_string('date_on_sale_to')) {
		rt.call_method(var_variation, 'set_date_on_sale_to', [var_request.array_get(rt.new_string('date_on_sale_to'))])
	}
	if var_request.array_isset(rt.new_string('date_on_sale_to_gmt')) {
		rt.call_method(var_variation, 'set_date_on_sale_to', [if rt.is_true(var_request.array_get(rt.new_string('date_on_sale_to_gmt'))) { rt.call_function('strtotime', [var_request.array_get(rt.new_string('date_on_sale_to_gmt'))]) } else { rt.new_null() }])
	}
	if var_request.array_isset(rt.new_string('tax_class')) {
		rt.call_method(var_variation, 'set_tax_class', [var_request.array_get(rt.new_string('tax_class'))])
	}
	if var_request.array_isset(rt.new_string('description')) {
		rt.call_method(var_variation, 'set_description', [rt.call_function('wp_kses_post', [var_request.array_get(rt.new_string('description'))])])
	}
	if var_request.array_isset(rt.new_string('attributes')) {
		mut var_attributes := []rt.PhpVal{}
		mut var_parent := rt.call_function('wc_get_product', [rt.call_method(var_variation, 'get_parent_id', []rt.PhpVal{})])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_parent)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this), 'post_type')), rt.new_string('_invalid_parent')), rt.call_function('__', [rt.new_string('Cannot set attributes due to invalid parent product.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
		}
		mut var_parent_attributes := rt.call_method(var_parent, 'get_attributes', []rt.PhpVal{})
		mut iter_2 := var_request.array_get(rt.new_string('attributes')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_attribute := item_2.val
			mut var_attribute_id := rt.new_int(0)
			mut var_attribute_name := rt.new_string('')
			if !(!rt.is_true(var_attribute.array_get(rt.new_string('id')))) {
			var_attribute_id = rt.call_function('absint', [var_attribute.array_get(rt.new_string('id'))])
			var_attribute_name = rt.call_function('sanitize_title', [rt.call_function('wc_attribute_taxonomy_name_by_id', [var_attribute_id.clone()])])
			} else if !(!rt.is_true(var_attribute.array_get(rt.new_string('name')))) {
			var_attribute_name = rt.call_function('sanitize_title', [var_attribute.array_get(rt.new_string('name'))])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_id)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_name)))) {
				continue
			}
			if !(var_parent_attributes.array_isset(var_attribute_name)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'get_variation', []rt.PhpVal{}))))) {
				continue
			}
			mut var_attribute_key := rt.call_function('sanitize_title', [rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'get_name', []rt.PhpVal{})])
			mut var_attribute_value := if var_attribute.array_isset(rt.new_string('option')) { rt.call_function('wc_clean', [rt.call_function('rawurldecode', [rt.call_function('stripslashes', [var_attribute.array_get(rt.new_string('option'))])])]) } else { rt.new_string('') }
			if rt.is_true(rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'is_taxonomy', []rt.PhpVal{})) {
				mut var_term := rt.call_function('get_term_by', [rt.new_string('name'), var_attribute_value.clone(), var_attribute_name.clone()])
				if rt.is_true(var_term) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
				var_attribute_value = rt.get_property(var_term, 'slug')
				} else {
				var_attribute_value = rt.call_function('sanitize_title', [var_attribute_value.clone()])
				}
			}
			var_attributes.array_set(var_attribute_key, var_attribute_value.clone())
		}
		rt.call_method(var_variation, 'set_attributes', [var_attributes.clone()])
	}
	if rt.is_true(var_request.array_get(rt.new_string('menu_order'))) {
		rt.call_method(var_variation, 'set_menu_order', [var_request.array_get(rt.new_string('menu_order'))])
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
	mut iife_result_0 := iife_temp_0.update(var_request.array_get(rt.new_string('meta_data')), var_variation.clone())
	if rt.is_true(this.cogs_is_enabled()) {
		this.set_cogs_info_in_product_object(var_request.clone(), var_variation.clone())
	}
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_pre_insert_'), rt.get_property(rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this), 'post_type')), rt.new_string('_object')), var_variation.clone(), var_request.clone(), rt.new_bool(creating)])
}

fn (mut this Class_WC_REST_Product_Variations_Controller) get_image(var_variation rt.PhpVal, context string) rt.PhpVal {
	mut var_image := map[string]rt.PhpVal{}
	mut var_variation_mutated := var_variation
	mut context_mutated := context
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_variation_mutated, 'get_image_id', [rt.new_string(context_mutated).clone()]))))) {
		return rt.new_null()
	}
	mut var_attachment_id := rt.call_method(var_variation_mutated, 'get_image_id', []rt.PhpVal{})
	mut var_attachment_post := rt.call_function('get_post', [var_attachment_id.clone()])
	if rt.is_true(rt.new_bool(var_attachment_post.clone().is_null())) {
		return rt.new_null()
	}
	mut var_attachment := rt.call_function('wp_get_attachment_image_src', [var_attachment_id.clone(), rt.new_string('full')])
	if !(var_attachment.clone().is_array()) {
		return rt.new_null()
	}
	if !(!(var_image).is_null()) {
		return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.new_int((var_attachment_id).to_i64()) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment_post, 'post_date'), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('strtotime', [rt.get_property(var_attachment_post, 'post_date_gmt')])]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment_post, 'post_modified'), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('strtotime', [rt.get_property(var_attachment_post, 'post_modified_gmt')])]) }, rt.ArrayItem{ key: 'src', val: rt.call_function('current', [var_attachment.clone()]) }, rt.ArrayItem{ key: 'name', val: rt.call_function('get_the_title', [var_attachment_id.clone()]) }, rt.ArrayItem{ key: 'alt', val: rt.call_function('get_post_meta', [var_attachment_id.clone(), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)]) }])
	}
	return rt.new_null()
}

fn (mut this Class_WC_REST_Product_Variations_Controller) set_variation_image(var_variation rt.PhpVal, var_image rt.PhpVal) rt.PhpVal {
	mut var_variation_mutated := var_variation
	mut var_attachment_id := if var_image.array_isset(rt.new_string('id')) { rt.call_function('absint', [var_image.array_get(rt.new_string('id'))]) } else { rt.new_int(0) }
	if rt.is_true(rt.identical(rt.new_int(0), var_attachment_id)) {
		if var_image.array_isset(rt.new_string('src')) {
			mut var_upload := rt.call_function('wc_rest_upload_image_from_url', [rt.call_function('esc_url_raw', [var_image.array_get(rt.new_string('src'))])])
			if rt.is_true(rt.call_function('is_wp_error', [var_upload.clone()])) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_suppress_image_upload_error'), rt.new_bool(false), var_upload.clone(), rt.call_method(var_variation_mutated, 'get_id', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: var_image }])]))))) {
					rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_variation_image_upload_error'), rt.call_method(var_upload, 'get_error_message', []rt.PhpVal{}), rt.new_int(400))))
				}
			}
		var_attachment_id = rt.call_function('wc_rest_set_uploaded_image_as_attachment', [var_upload.clone(), rt.call_method(var_variation_mutated, 'get_id', []rt.PhpVal{})])
		} else {
			rt.call_method(var_variation_mutated, 'set_image_id', [rt.new_string('')])
			return var_variation_mutated.clone()
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_attachment_is_image', [var_attachment_id.clone()]))))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_variation_invalid_image_id'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('#%s is an invalid image ID.'), rt.new_string('woocommerce')]), var_attachment_id.clone()]), rt.new_int(400))))
	}
	rt.call_method(var_variation_mutated, 'set_image_id', [var_attachment_id.clone()])
	if !(!rt.is_true(var_image.array_get(rt.new_string('alt')))) {
		rt.call_function('update_post_meta', [var_attachment_id.clone(), rt.new_string('_wp_attachment_image_alt'), rt.call_function('wc_clean', [var_image.array_get(rt.new_string('alt'))])])
	}
	if !(!rt.is_true(var_image.array_get(rt.new_string('name')))) {
		rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_attachment_id }, rt.ArrayItem{ key: 'post_title', val: var_image.array_get(rt.new_string('name')) }])])
	}
	return var_variation_mutated.clone()
}

fn (mut this Class_WC_REST_Product_Variations_Controller) get_item_schema() rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_1 := iife_temp_1.get_weight_unit_label(rt.call_function('get_option', [rt.new_string('woocommerce_weight_unit'), rt.new_string('kg')]))
	mut var_weight_unit_label := iife_result_1
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_2 := iife_temp_2.get_dimensions_unit_label(rt.call_function('get_option', [rt.new_string('woocommerce_dimension_unit'), rt.new_string('cm')]))
	mut var_dimension_unit_label := iife_result_2
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: rt.get_property(rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this), 'post_type') }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_created', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the variation was created, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_modified', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the variation was last modified, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Variation description.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'permalink', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Variation URL.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'sku', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stock Keeping Unit.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'global_unique_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('GTIN, UPC, EAN or ISBN.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'price', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Current variation price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'regular_price', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Variation regular price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'sale_price', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Variation sale price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_on_sale_from', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Start date of sale price, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_on_sale_from_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Start date of sale price, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_on_sale_to', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('End date of sale price, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_on_sale_to_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('End date of sale price, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'on_sale', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shows if the variation is on sale.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Variation status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: 'publish' }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('get_post_statuses', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'purchasable', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shows if the variation can be bought.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'virtual', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If the variation is virtual.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'downloadable', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If the variation is downloadable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'downloads', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of downloadable files.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('File ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('File name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'file', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('File URL.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'download_limit', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of times downloadable files can be downloaded after purchase.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: -1 }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'download_expiry', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of days until access to downloadable files expires.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: -1 }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'tax_status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.shipping() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.none() }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'tax_class', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax class.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'manage_stock', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stock management at variation level.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'boolean' }, rt.ArrayItem{ key: none, val: 'string' }]) }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'stock_quantity', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stock quantity.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'stock_status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Controls the stock status of the product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock() }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'backorders', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If managing stock, this controls if backorders are allowed.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: 'no' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'no' }, rt.ArrayItem{ key: none, val: 'notify' }, rt.ArrayItem{ key: none, val: 'yes' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'backorders_allowed', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shows if backorders are allowed.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'backordered', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shows if the variation is on backordered.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'low_stock_amount', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Low Stock amount for the variation.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'integer' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'weight', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Variation weight (%s).'), rt.new_string('woocommerce')]), var_weight_unit_label.clone()]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'dimensions', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Variation dimensions.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'length', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Variation length (%s).'), rt.new_string('woocommerce')]), var_dimension_unit_label.clone()]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'width', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Variation width (%s).'), rt.new_string('woocommerce')]), var_dimension_unit_label.clone()]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'height', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Variation height (%s).'), rt.new_string('woocommerce')]), var_dimension_unit_label.clone()]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'shipping_class', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping class slug.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'shipping_class_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping class ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'image', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Variation image data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Image ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_created', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the image was created, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the image was created, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_modified', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the image was last modified, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the image was last modified, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'src', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Image URL.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Image name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'alt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Image alternative text.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of attributes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Attribute ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Attribute name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'option', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Selected attribute term name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'menu_order', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Menu order, used to custom sort products.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'meta_data', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'parent_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product parent ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
	if rt.is_true(this.cogs_is_enabled()) {
	var_schema = this.add_cogs_related_product_schema(var_schema.clone(), rt.new_bool(true))
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Product_Variations_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_WC_REST_CRUD_Controller{}
	mut iife_result_3 := iife_temp_3.prepare_objects_query(var_request.clone())
	mut var_args := iife_result_3
	var_args.array_set('post_status', var_request.array_get(rt.new_string('status')))
	if !(!rt.is_true(var_request.array_get(rt.new_string('include_status')))) {
		var_args.array_set('post_status', var_request.array_get(rt.new_string('include_status')))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('exclude_status')))) {
		this.exclude_status = var_request.array_get(rt.new_string('exclude_status'))
	} else {
		this.exclude_status = []rt.PhpVal{}
	}
	if var_request.array_isset(rt.new_string('downloadable')) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_downloadable' }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_bool_to_string', [var_request.array_get(rt.new_string('downloadable'))]) }])))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('local_attributes')))) && var_request.array_get(rt.new_string('local_attributes')).is_array() {
		rt.call_function('wc_deprecated_argument', [rt.new_string('local_attributes'), rt.new_string('8.1'), rt.new_string('Use "attributes" instead.')])
		mut iter_3 := var_request.array_get(rt.new_string('local_attributes')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_attribute := item_3.val
			if !(var_attribute.array_isset(rt.new_string('attribute'))) || !(var_attribute.array_isset(rt.new_string('term'))) {
				continue
			}
			var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: 'attribute_' + (var_attribute.array_get(rt.new_string('attribute'))).str() }, rt.ArrayItem{ key: 'value', val: var_attribute.array_get(rt.new_string('term')) }])))
		}
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('attributes')))) && var_request.array_get(rt.new_string('attributes')).is_array() {
		mut iter_4 := var_request.array_get(rt.new_string('attributes')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_attribute := item_4.val
			if var_attribute.array_isset(rt.new_string('attribute')) {
				if var_attribute.array_isset(rt.new_string('term')) {
					var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: 'attribute_' + (var_attribute.array_get(rt.new_string('attribute'))).str() }, rt.ArrayItem{ key: 'value', val: var_attribute.array_get(rt.new_string('term')) }])))
				} else if !(!rt.is_true(var_attribute.array_get(rt.new_string('terms')))) && var_attribute.array_get(rt.new_string('terms')).is_array() {
					var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: 'attribute_' + (var_attribute.array_get(rt.new_string('attribute'))).str() }, rt.ArrayItem{ key: 'compare', val: 'IN' }, rt.ArrayItem{ key: 'value', val: var_attribute.array_get(rt.new_string('terms')) }])))
				}
			}
		}
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('sku')))) {
		mut var_skus := rt.call_function('explode', [rt.new_string(','), var_request.array_get(rt.new_string('sku'))])
		if 1 < var_skus.clone().array_count() {
			var_skus.array_push(var_request.array_get(rt.new_string('sku')))
		}
		var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_sku' }, rt.ArrayItem{ key: 'value', val: var_skus }, rt.ArrayItem{ key: 'compare', val: 'IN' }])))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('global_unique_id')))) {
		mut var_global_unique_ids := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_request.array_get(rt.new_string('global_unique_id'))])])
		var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_global_unique_id' }, rt.ArrayItem{ key: 'value', val: var_global_unique_ids }, rt.ArrayItem{ key: 'compare', val: 'IN' }])))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('tax_class')))) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_tax_class' }, rt.ArrayItem{ key: 'value', val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('standard'), var_request.array_get(rt.new_string('tax_class')))))) { var_request.array_get(rt.new_string('tax_class')) } else { rt.new_string('') } }])))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('min_price')))) || !(!rt.is_true(var_request.array_get(rt.new_string('max_price')))) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.call_function('wc_get_min_max_price_meta_query', [var_request.clone()])))
	}
	if rt.is_true(rt.new_bool(var_request.array_get(rt.new_string('has_price')).is_bool())) {
		if rt.is_true(var_request.array_get(rt.new_string('has_price'))) {
			var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: '_price' }, rt.ArrayItem{ key: 'compare', val: 'EXISTS' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: '_price' }, rt.ArrayItem{ key: 'compare', val: '!=' }, rt.ArrayItem{ key: 'value', val: rt.new_null() }]) }])))
		} else {
			var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'relation', val: 'OR' }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: '_price' }, rt.ArrayItem{ key: 'compare', val: 'NOT EXISTS' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: '_price' }, rt.ArrayItem{ key: 'compare', val: '=' }, rt.ArrayItem{ key: 'value', val: rt.new_null() }]) }])))
		}
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('stock_status')))) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_stock_status' }, rt.ArrayItem{ key: 'value', val: var_request.array_get(rt.new_string('stock_status')) }])))
	}
	if rt.is_true(rt.new_bool(var_request.array_get(rt.new_string('on_sale')).is_bool())) {
		mut var_on_sale_key := rt.new_string((if rt.is_true(var_request.array_get(rt.new_string('on_sale'))) { 'post__in' } else { 'post__not_in' }).str())
		mut var_on_sale_ids := rt.call_function('wc_get_product_ids_on_sale', []rt.PhpVal{})
		var_on_sale_ids = if !rt.is_true(var_on_sale_ids) { rt.create_array([rt.ArrayItem{ key: none, val: 0 }]) } else { var_on_sale_ids }
		var_args.array_get(var_on_sale_key) = rt.add(var_args.array_get(var_on_sale_key), var_on_sale_ids)
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('sku')))) || !(!rt.is_true(var_request.array_get(rt.new_string('global_unique_id')))) {
		var_args.array_set('post_type', rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]))
	} else {
		var_args.array_set('post_type', rt.get_property(rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this), 'post_type'))
	}
	if var_request.array_isset(rt.new_string('virtual')) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_virtual' }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_bool_to_string', [var_request.array_get(rt.new_string('virtual'))]) }])))
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_request.array_get(rt.new_string('pos_products_only')))) {
		var_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'pos_product_visibility' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'terms', val: 'pos-hidden' }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }]))
	}
	var_args.array_set('post_parent', var_request.array_get(rt.new_string('product_id')))
	return var_args.clone()
}

fn (mut this Class_WC_REST_Product_Variations_Controller) get_objects(var_query_args rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(this.exclude_status)) {
		rt.call_function('add_filter', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'exclude_product_variation_statuses' }])])
	}
	mut var_result := this.Class_WC_REST_Product_Variations_V2_Controller.get_objects(var_query_args.clone())
	if !(!rt.is_true(this.exclude_status)) {
		rt.call_function('remove_filter', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'exclude_product_variation_statuses' }])])
		this.exclude_status = []rt.PhpVal{}
	}
	return var_result.clone()
}

fn (mut this Class_WC_REST_Product_Variations_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_Product_Variations_V2_Controller.get_collection_params()
	var_params.array_unset(rt.new_string('in_stock'))
	var_params.array_unset(rt.new_string('type'))
	var_params.array_unset(rt.new_string('featured'))
	var_params.array_unset(rt.new_string('category'))
	var_params.array_unset(rt.new_string('tag'))
	var_params.array_unset(rt.new_string('shipping_class'))
	var_params.array_unset(rt.new_string('attribute'))
	var_params.array_unset(rt.new_string('attribute_term'))
	var_params.array_set('stock_status', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products with specified stock status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('has_price', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products with or without price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_string_to_bool' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('attributes', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products with specified attributes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'attribute', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Attribute slug.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'term', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Attribute term.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'terms', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Attribute terms.'), rt.new_string('woocommerce')]) }]) }]) }]) }]))
	var_params.array_set('virtual', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to virtual product variations.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'rest_sanitize_boolean' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('downloadable', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to downloadable product variations.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'rest_sanitize_boolean' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('include_status', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to product variations with any of the statuses.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'any' }, rt.ArrayItem{ key: none, val: 'future' }, rt.ArrayItem{ key: none, val: 'trash' }]), rt.func_array_keys(rt.call_function('get_post_statuses', []rt.PhpVal{}))]) }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('exclude_status', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Exclude product variations with any of the statuses from result set.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'future' }, rt.ArrayItem{ key: none, val: 'trash' }]), rt.func_array_keys(rt.call_function('get_post_statuses', []rt.PhpVal{}))]) }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('pos_products_only', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to variations visible in Point of Sale.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_string_to_bool' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	return var_params.clone()
}

fn (mut this Class_WC_REST_Product_Variations_Controller) delete_unmatched_product_variations(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_deleted_count := rt.new_int(0)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_mutated)))) {
		return var_deleted_count.clone()
	}
	mut var_attributes := rt.call_function('wc_list_pluck', [rt.call_function('array_filter', [rt.call_method(var_product_mutated, 'get_attributes', []rt.PhpVal{}), rt.new_string('wc_attributes_array_filter_variation')]), rt.new_string('get_slugs')])
	mut var_existing_variations := rt.call_function('array_map', [rt.new_string('wc_get_product'), rt.call_method(var_product_mutated, 'get_children', []rt.PhpVal{})])
	mut var_possible_attribute_combinations := rt.call_function('array_reverse', [rt.call_function('wc_array_cartesian', [var_attributes.clone()])])
	mut iter_5 := var_existing_variations.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_existing_variation := item_5.val
		mut var_matching_attribute_key := rt.call_function('array_search', [rt.call_method(var_existing_variation, 'get_attributes', []rt.PhpVal{}), var_possible_attribute_combinations.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_matching_attribute_key)))) {
			var_possible_attribute_combinations.array_unset(var_matching_attribute_key)
			continue
		}
		rt.call_method(var_existing_variation, 'delete', [rt.new_bool(true)])
		rt.post_inc(var_deleted_count)
	}
	return var_deleted_count.clone()
}

fn (mut this Class_WC_REST_Product_Variations_Controller) generate(var_request rt.PhpVal) rt.PhpVal {
	mut var_product_id := rt.new_int((var_request.array_get(rt.new_string('product_id'))).to_i64())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [var_product_id.clone()]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_product_invalid_id'), rt.call_function('__', [rt.new_string('Invalid product ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	rt.call_function('wc_maybe_define_constant', [rt.new_string('WC_MAX_LINKED_VARIATIONS'), rt.new_int(99)])
	rt.call_function('wc_set_time_limit', [rt.new_int(0)])
	mut var_response := []rt.PhpVal{}
	mut var_product := rt.call_function('wc_get_product', [var_product_id.clone()])
	mut var_default_values := if var_request.array_isset(rt.new_string('default_values')) { var_request.array_get(rt.new_string('default_values')) } else { []rt.PhpVal{} }
	mut var_meta_data := if var_request.array_isset(rt.new_string('meta_data')) { var_request.array_get(rt.new_string('meta_data')) } else { []rt.PhpVal{} }
	mut var_data_store := rt.call_method(var_product, 'get_data_store', []rt.PhpVal{})
	mut iife_temp_4 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_4 := iife_temp_4.get_constant(rt.new_string('WC_MAX_LINKED_VARIATIONS'))
	var_response.array_set('count', rt.call_method(var_data_store, 'create_all_product_variations', [var_product.clone(), iife_result_4, var_default_values.clone(), var_meta_data.clone()]))
	if var_request.array_isset(rt.new_string('delete')) && rt.is_true(var_request.array_get(rt.new_string('delete'))) {
		mut var_deleted_count := this.delete_unmatched_product_variations(var_product.clone())
		var_response.array_set('deleted_count', var_deleted_count.clone())
	}
	rt.call_method(var_data_store, 'sort_all_product_variations', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WC_REST_Product_Variations_Controller) exclude_product_variation_statuses(var_where rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	if !(!rt.is_true(this.exclude_status)) && this.exclude_status.is_array() {
		mut var_not_in := []rt.PhpVal{}
		mut iter_6 := this.exclude_status.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_status_to_exclude := item_6.val
			var_not_in.array_push(rt.call_method(var_wpdb, 'prepare', [rt.new_string('%s'), var_status_to_exclude.clone()]))
		}
		var_not_in = rt.call_function('join', [rt.new_string(', '), var_not_in.clone()])
		return (var_where).str() + rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_status NOT IN ( ')), var_not_in), rt.new_string(' )'))
	}
	return (var_where).str()
}

struct Class_WC_REST_Product_Variations_V2_Controller {
	rt.PhpObjectBase
}

struct Class_WC_Product_Variation {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	rt.PhpObjectBase
}

struct Class_WC_REST_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_I18nUtil {
	rt.PhpObjectBase
}

struct Class_WC_REST_CRUD_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_rest_product_variations_controller(_args ...rt.PhpVal) &Class_WC_REST_Product_Variations_Controller {
	mut obj := &Class_WC_REST_Product_Variations_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
		exclude_status: rt.new_array()
	}
	return obj
}

fn create_wc_rest_product_variations_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Product_Variations_V2_Controller {
	mut obj := &Class_WC_REST_Product_Variations_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_variation(_args ...rt.PhpVal) &Class_WC_Product_Variation {
	mut obj := &Class_WC_Product_Variation{
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

fn create_automattic_woocommerce_utilities_metadatautil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_MetaDataUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_exception(_args ...rt.PhpVal) &Class_WC_REST_Exception {
	mut obj := &Class_WC_REST_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_i18nutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_I18nUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_I18nUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_crud_controller(_args ...rt.PhpVal) &Class_WC_REST_CRUD_Controller {
	mut obj := &Class_WC_REST_CRUD_Controller{
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

fn (mut this Class_WC_REST_Product_Variations_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_downloads' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_downloads(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_object_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_object_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_object_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.prepare_object_for_database(dispatch_arg_0, dispatch_arg_1)
		}
		'get_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_image(dispatch_arg_0, dispatch_arg_1)
		}
		'set_variation_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.set_variation_image(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'get_objects' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_objects(dispatch_arg_0)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'delete_unmatched_product_variations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_unmatched_product_variations(dispatch_arg_0)
		}
		'generate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.generate(dispatch_arg_0)
		}
		'exclude_product_variation_statuses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.exclude_product_variation_statuses(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Product_Variations_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'exclude_status' { return this.exclude_status }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Product_Variations_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'exclude_status' { this.exclude_status = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Product_Variations_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Product_Variations_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Product_Variation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Variation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Variation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_MetaDataUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_REST_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_REST_CRUD_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_CRUD_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_CRUD_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
