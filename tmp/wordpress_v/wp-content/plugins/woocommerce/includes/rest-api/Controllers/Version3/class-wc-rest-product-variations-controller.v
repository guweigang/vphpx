import rt

struct Class_WC_REST_Product_Variations_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
		exclude_status rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_REST_Product_Variations_Controller) register_routes()  {
	this.Class_WC_REST_Product_Variations_V2_Controller.register_routes()
	rt.call_function('register_rest_route', [this.namespace, '/' + (rt.get_property(rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this), 'rest_base')).str() + '/generate', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the variable product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'delete', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Deletes unused variations.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }]) }, rt.ArrayItem{ key: 'default_values', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Default values for generated variations.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'generate' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_Product_Variations_Controller) get_downloads(var_product rt.PhpVal, context string) rt.PhpVal {
	mut var_product_mutated := var_product
	mut context_mutated := context
	mut var_downloads := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product_mutated, 'is_downloadable', []rt.PhpVal{})) || rt.is_true(rt.identical(rt.new_string('edit'), rt.new_string(context_mutated))))) {
		{
			mut iter_1 := rt.call_method(var_product_mutated, 'get_downloads', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_file := item_1.val
				mut var_file_id := item_1.key
				var_downloads << rt.create_array([rt.ArrayItem{ key: 'id', val: var_file_id }, rt.ArrayItem{ key: 'name', val: var_file.array_get('name') }, rt.ArrayItem{ key: 'file', val: var_file.array_get('file') }])
			}
		}
	}
	return var_downloads.dup()
}

fn (mut this Class_WC_REST_Product_Variations_Controller) prepare_object_for_response(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_object, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'type', val: rt.call_method(var_object, 'get_type', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_created', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_created', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_modified', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_modified', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('wc_format_content', [rt.call_method(var_object, 'get_description', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'permalink', val: rt.call_method(var_object, 'get_permalink', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'sku', val: rt.call_method(var_object, 'get_sku', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'global_unique_id', val: rt.call_method(var_object, 'get_global_unique_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'price', val: rt.call_method(var_object, 'get_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'regular_price', val: rt.call_method(var_object, 'get_regular_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'sale_price', val: rt.call_method(var_object, 'get_sale_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_on_sale_from', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_on_sale_from', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_on_sale_from_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_on_sale_from', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_on_sale_to', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_on_sale_to', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_on_sale_to_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object, 'get_date_on_sale_to', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'on_sale', val: rt.call_method(var_object, 'is_on_sale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: rt.call_method(var_object, 'get_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'purchasable', val: rt.call_method(var_object, 'is_purchasable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'virtual', val: rt.call_method(var_object, 'is_virtual', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'downloadable', val: rt.call_method(var_object, 'is_downloadable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'downloads', val: this.get_downloads(var_object.dup(), (var_context).str()) }, rt.ArrayItem{ key: 'download_limit', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { // unsupported expression: Expr_Cast_Int } else { // unsupported expression: Expr_UnaryMinus } }, rt.ArrayItem{ key: 'download_expiry', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { // unsupported expression: Expr_Cast_Int } else { // unsupported expression: Expr_UnaryMinus } }, rt.ArrayItem{ key: 'tax_status', val: rt.call_method(var_object, 'get_tax_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'tax_class', val: rt.call_method(var_object, 'get_tax_class', [var_context.dup()]) }, rt.ArrayItem{ key: 'manage_stock', val: rt.call_method(var_object, 'managing_stock', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'stock_quantity', val: rt.call_method(var_object, 'get_stock_quantity', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'stock_status', val: rt.call_method(var_object, 'get_stock_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backorders', val: rt.call_method(var_object, 'get_backorders', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backorders_allowed', val: rt.call_method(var_object, 'backorders_allowed', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backordered', val: rt.call_method(var_object, 'is_on_backorder', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'low_stock_amount', val: if rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_object, 'get_low_stock_amount', []rt.PhpVal{}))) { rt.new_null() } else { rt.call_method(var_object, 'get_low_stock_amount', []rt.PhpVal{}) } }, rt.ArrayItem{ key: 'weight', val: rt.call_method(var_object, 'get_weight', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'dimensions', val: rt.create_array([rt.ArrayItem{ key: 'length', val: rt.call_method(var_object, 'get_length', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'width', val: rt.call_method(var_object, 'get_width', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'height', val: rt.call_method(var_object, 'get_height', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'shipping_class', val: rt.call_method(var_object, 'get_shipping_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_class_id', val: rt.call_method(var_object, 'get_shipping_class_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'image', val: this.get_image(var_object.dup(), (var_context).str()) }, rt.ArrayItem{ key: 'attributes', val: this.get_attributes(var_object.dup()) }, rt.ArrayItem{ key: 'menu_order', val: rt.call_method(var_object, 'get_menu_order', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'meta_data', val: rt.call_method(var_object, 'get_meta_data', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'name', val: rt.call_function('wc_get_formatted_variation', [var_object.dup(), rt.new_bool(true), rt.new_bool(false), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'parent_id', val: rt.call_method(var_object, 'get_parent_id', []rt.PhpVal{}) }])
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	if rt.is_true(this.cogs_is_enabled()) {
		this.add_cogs_info_to_returned_product_data(var_data.dup(), var_object.dup())
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_object.dup(), var_request.dup())])
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_prepare_'), rt.get_property(rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this), 'post_type')), rt.new_string('_object')), var_response.dup(), var_object.dup(), var_request.dup()])
}

fn (mut this Class_WC_REST_Product_Variations_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	if var_request.array_isset(rt.new_string('id')) {
		mut var_variation := rt.call_function('wc_get_product', [rt.call_function('absint', [var_request.array_get('id')])])
	} else {
		var_variation = create_wc_product_variation()
	}
	rt.call_method(var_variation, 'set_parent_id', [rt.call_function('absint', [var_request.array_get('product_id')])])
	if var_request.array_isset(rt.new_string('status')) {
		rt.call_method(var_variation, 'set_status', [if rt.is_true(rt.call_function('get_post_status_object', [var_request.array_get('status')])) { var_request.array_get('status') } else { Class_Automattic_WooCommerce_Enums_ProductStatus.draft() }])
	}
	if var_request.array_isset(rt.new_string('sku')) {
		rt.call_method(var_variation, 'set_sku', [rt.call_function('wc_clean', [var_request.array_get('sku')])])
	}
	if var_request.array_isset(rt.new_string('global_unique_id')) {
		rt.call_method(var_variation, 'set_global_unique_id', [rt.call_function('wc_clean', [var_request.array_get('global_unique_id')])])
	}
	if var_request.array_isset(rt.new_string('image')) {
		if rt.is_true(rt.new_bool(var_request.array_get('image').is_array())) {
			var_variation = this.set_variation_image(var_variation.dup(), var_request.array_get('image'))
		} else {
			rt.call_method(var_variation, 'set_image_id', [rt.new_string('')])
		}
	}
	if var_request.array_isset(rt.new_string('virtual')) {
		rt.call_method(var_variation, 'set_virtual', [var_request.array_get('virtual')])
	}
	if var_request.array_isset(rt.new_string('downloadable')) {
		rt.call_method(var_variation, 'set_downloadable', [var_request.array_get('downloadable')])
	}
	if rt.is_true(rt.call_method(var_variation, 'get_downloadable', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(var_request.array_isset(rt.new_string('downloads')) && rt.is_true(rt.new_bool(var_request.array_get('downloads').is_array())))) {
			var_variation = this.save_downloadable_files(var_variation.dup(), var_request.array_get('downloads'))
		}
		if var_request.array_isset(rt.new_string('download_limit')) {
			rt.call_method(var_variation, 'set_download_limit', [var_request.array_get('download_limit')])
		}
		if var_request.array_isset(rt.new_string('download_expiry')) {
			rt.call_method(var_variation, 'set_download_expiry', [var_request.array_get('download_expiry')])
		}
	}
	var_variation = this.save_product_shipping_data(var_variation.dup(), var_request.dup())
	if var_request.array_isset(rt.new_string('manage_stock')) {
		rt.call_method(var_variation, 'set_manage_stock', [var_request.array_get('manage_stock')])
	}
	if var_request.array_isset(rt.new_string('stock_status')) {
		rt.call_method(var_variation, 'set_stock_status', [var_request.array_get('stock_status')])
	}
	if var_request.array_isset(rt.new_string('backorders')) {
		rt.call_method(var_variation, 'set_backorders', [var_request.array_get('backorders')])
	}
	if rt.is_true(rt.call_method(var_variation, 'get_manage_stock', []rt.PhpVal{})) {
		if var_request.array_isset(rt.new_string('stock_quantity')) {
			rt.call_method(var_variation, 'set_stock_quantity', [var_request.array_get('stock_quantity')])
		} else if var_request.array_isset(rt.new_string('inventory_delta')) {
			mut var_stock_quantity := rt.call_function('wc_stock_amount', [rt.call_method(var_variation, 'get_stock_quantity', []rt.PhpVal{})])
			// unsupported expression: Expr_AssignOp_Plus
			rt.call_method(var_variation, 'set_stock_quantity', [var_stock_quantity.dup()])
		}
		if rt.is_true(rt.new_bool(rt.call_method(var_request, 'get_params', []rt.PhpVal{}).array_isset(rt.new_string('low_stock_amount')))) {
			if rt.is_true(rt.identical(rt.new_null(), var_request.array_get('low_stock_amount'))) {
				rt.call_method(var_variation, 'set_low_stock_amount', [rt.new_string('')])
			} else {
				rt.call_method(var_variation, 'set_low_stock_amount', [rt.call_function('wc_stock_amount', [var_request.array_get('low_stock_amount')])])
			}
		}
	} else {
		rt.call_method(var_variation, 'set_backorders', [rt.new_string('no')])
		rt.call_method(var_variation, 'set_stock_quantity', [rt.new_string('')])
		rt.call_method(var_variation, 'set_low_stock_amount', [rt.new_string('')])
	}
	if var_request.array_isset(rt.new_string('regular_price')) {
		rt.call_method(var_variation, 'set_regular_price', [var_request.array_get('regular_price')])
	}
	if var_request.array_isset(rt.new_string('sale_price')) {
		rt.call_method(var_variation, 'set_sale_price', [var_request.array_get('sale_price')])
	}
	if var_request.array_isset(rt.new_string('date_on_sale_from')) {
		rt.call_method(var_variation, 'set_date_on_sale_from', [var_request.array_get('date_on_sale_from')])
	}
	if var_request.array_isset(rt.new_string('date_on_sale_from_gmt')) {
		rt.call_method(var_variation, 'set_date_on_sale_from', [if rt.is_true(var_request.array_get('date_on_sale_from_gmt')) { rt.call_function('strtotime', [var_request.array_get('date_on_sale_from_gmt')]) } else { rt.new_null() }])
	}
	if var_request.array_isset(rt.new_string('date_on_sale_to')) {
		rt.call_method(var_variation, 'set_date_on_sale_to', [var_request.array_get('date_on_sale_to')])
	}
	if var_request.array_isset(rt.new_string('date_on_sale_to_gmt')) {
		rt.call_method(var_variation, 'set_date_on_sale_to', [if rt.is_true(var_request.array_get('date_on_sale_to_gmt')) { rt.call_function('strtotime', [var_request.array_get('date_on_sale_to_gmt')]) } else { rt.new_null() }])
	}
	if var_request.array_isset(rt.new_string('tax_class')) {
		rt.call_method(var_variation, 'set_tax_class', [var_request.array_get('tax_class')])
	}
	if var_request.array_isset(rt.new_string('description')) {
		rt.call_method(var_variation, 'set_description', [rt.call_function('wp_kses_post', [var_request.array_get('description')])])
	}
	if var_request.array_isset(rt.new_string('attributes')) {
		mut var_attributes := []rt.PhpVal{}
		mut var_parent := rt.call_function('wc_get_product', [rt.call_method(var_variation, 'get_parent_id', []rt.PhpVal{})])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_parent)))) {
			return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this), 'post_type')), rt.new_string('_invalid_parent')), rt.call_function('__', [rt.new_string('Cannot set attributes due to invalid parent product.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
		}
		mut var_parent_attributes := rt.call_method(var_parent, 'get_attributes', []rt.PhpVal{})
		{
			mut iter_1 := var_request.array_get('attributes').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute := item_1.val
				mut var_attribute_id := rt.new_int(rt.new_int(0))
				mut var_attribute_name := rt.new_string(rt.new_string(''))
				if !(!rt.is_true(var_attribute.array_get('id'))) {
					var_attribute_id = rt.call_function('absint', [var_attribute.array_get('id')])
					var_attribute_name = rt.call_function('sanitize_title', [rt.call_function('wc_attribute_taxonomy_name_by_id', [var_attribute_id.dup()])])
				} else if !(!rt.is_true(var_attribute.array_get('name'))) {
					var_attribute_name = rt.call_function('sanitize_title', [var_attribute.array_get('name')])
				}
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_id)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_name)))))) {
					continue
				}
				if rt.is_true(rt.new_bool(!(var_parent_attributes.array_isset(var_attribute_name)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'get_variation', []rt.PhpVal{}))))))) {
					continue
				}
				mut var_attribute_key := rt.call_function('sanitize_title', [rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'get_name', []rt.PhpVal{})])
				mut var_attribute_value := if var_attribute.array_isset(rt.new_string('option')) { rt.call_function('wc_clean', [rt.call_function('rawurldecode', [rt.call_function('stripslashes', [var_attribute.array_get('option')])])]) } else { rt.new_string('') }
				if rt.is_true(rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'is_taxonomy', []rt.PhpVal{})) {
					mut var_term := rt.call_function('get_term_by', [rt.new_string('name'), var_attribute_value.dup(), var_attribute_name.dup()])
					if rt.is_true(rt.new_bool(rt.is_true(var_term) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.dup()]))))))) {
						var_attribute_value = rt.get_property(var_term, 'slug')
					} else {
						var_attribute_value = rt.call_function('sanitize_title', [var_attribute_value.dup()])
					}
				}
				var_attributes.array_set(var_attribute_key, var_attribute_value.dup())
			}
		}
		rt.call_method(var_variation, 'set_attributes', [var_attributes.dup()])
	}
	if rt.is_true(var_request.array_get('menu_order')) {
		rt.call_method(var_variation, 'set_menu_order', [var_request.array_get('menu_order')])
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}; return temp.update(arg_0, arg_1) }(var_request.array_get('meta_data'), var_variation.dup())
	if rt.is_true(this.cogs_is_enabled()) {
		this.set_cogs_info_in_product_object(var_request.dup(), var_variation.dup())
	}
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_pre_insert_'), rt.get_property(rt.new_object('WC_REST_Product_Variations_Controller', ['WC_REST_Product_Variations_V2_Controller'], &this), 'post_type')), rt.new_string('_object')), var_variation.dup(), var_request.dup(), rt.new_bool(creating)])
}

fn (mut this Class_WC_REST_Product_Variations_Controller) get_image(var_variation rt.PhpVal, context string) rt.PhpVal {
	mut var_image := map[string]rt.PhpVal{}
	mut var_variation_mutated := var_variation
	mut context_mutated := context
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_variation_mutated, 'get_image_id', [rt.new_string(context_mutated).dup()]))))) {
		return rt.new_null()
	}
	mut var_attachment_id := rt.call_method(var_variation_mutated, 'get_image_id', []rt.PhpVal{})
	mut var_attachment_post := rt.call_function('get_post', [var_attachment_id.dup()])
	if rt.is_true(rt.new_bool(var_attachment_post.dup().is_null())) {
		return rt.new_null()
	}
	mut var_attachment := rt.call_function('wp_get_attachment_image_src', [var_attachment_id.dup(), rt.new_string('full')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_attachment.dup().is_array()))))) {
		return rt.new_null()
	}
	if !(!(var_image).is_null()) {
		return rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment_post, 'post_date'), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('strtotime', [rt.get_property(var_attachment_post, 'post_date_gmt')])]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment_post, 'post_modified'), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('strtotime', [rt.get_property(var_attachment_post, 'post_modified_gmt')])]) }, rt.ArrayItem{ key: 'src', val: rt.call_function('current', [var_attachment.dup()]) }, rt.ArrayItem{ key: 'name', val: rt.call_function('get_the_title', [var_attachment_id.dup()]) }, rt.ArrayItem{ key: 'alt', val: rt.call_function('get_post_meta', [var_attachment_id.dup(), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)]) }])
	}
	return rt.new_null()
}

fn (mut this Class_WC_REST_Product_Variations_Controller) set_variation_image(var_variation rt.PhpVal, var_image rt.PhpVal) rt.PhpVal {
	mut var_variation_mutated := var_variation
	mut var_attachment_id := if var_image.array_isset(rt.new_string('id')) { rt.call_function('absint', [var_image.array_get('id')]) } else { rt.new_int(0) }
	if rt.is_true(rt.identical(rt.new_int(0), var_attachment_id)) {
		if var_image.array_isset(rt.new_string('src')) {
			mut var_upload := rt.call_function('wc_rest_upload_image_from_url', [rt.call_function('esc_url_raw', [var_image.array_get('src')])])
			if rt.is_true(rt.call_function('is_wp_error', [var_upload.dup()])) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_suppress_image_upload_error'), rt.new_bool(false), var_upload.dup(), rt.call_method(var_variation_mutated, 'get_id', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: var_image }])]))))) {
					rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_variation_image_upload_error'), rt.call_method(var_upload, 'get_error_message', []rt.PhpVal{}), rt.new_int(400))))
				}
			}
			var_attachment_id = rt.call_function('wc_rest_set_uploaded_image_as_attachment', [var_upload.dup(), rt.call_method(var_variation_mutated, 'get_id', []rt.PhpVal{})])
		} else {
			rt.call_method(var_variation_mutated, 'set_image_id', [rt.new_string('')])
			return var_variation_mutated.dup()
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_attachment_is_image', [var_attachment_id.dup()]))))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_variation_invalid_image_id'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('#%s is an invalid image ID.'), rt.new_string('woocommerce')]), var_attachment_id.dup()]), rt.new_int(400))))
	}
	rt.call_method(var_variation_mutated, 'set_image_id', [var_attachment_id.dup()])
	if !(!rt.is_true(var_image.array_get('alt'))) {
		rt.call_function('update_post_meta', [var_attachment_id.dup(), rt.new_string('_wp_attachment_image_alt'), rt.call_function('wc_clean', [.array_get()])])
	}
	if !(!rt.is_true(var_image.array_get('name'))) {
		rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }])])
	}
	return var_variation_mutated.dup()
}

fn (mut this Class_WC_REST_Product_Variations_Controller) get_item_schema() rt.PhpVal {
	mut var_weight_unit_label := 
	
}

fn (mut this Class_WC_REST_Product_Variations_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Product_Variations_Controller) get_objects(var_query_args rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Product_Variations_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WC_REST_Product_Variations_Controller) delete_unmatched_product_variations(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
}

fn (mut this Class_WC_REST_Product_Variations_Controller) generate(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Product_Variations_Controller) exclude_product_variation_statuses(var_where rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
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

fn create_wc_rest_product_variations_controller() &Class_WC_REST_Product_Variations_Controller {
	mut obj := &Class_WC_REST_Product_Variations_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
		exclude_status: rt.new_array()
	}
	return obj
}

fn create_wc_rest_product_variations_v2_controller() &Class_WC_REST_Product_Variations_V2_Controller {
	mut obj := &Class_WC_REST_Product_Variations_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_variation() &Class_WC_Product_Variation {
	mut obj := &Class_WC_Product_Variation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_metadatautil() &Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_MetaDataUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_exception() &Class_WC_REST_Exception {
	mut obj := &Class_WC_REST_Exception{
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




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_product_variations_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
