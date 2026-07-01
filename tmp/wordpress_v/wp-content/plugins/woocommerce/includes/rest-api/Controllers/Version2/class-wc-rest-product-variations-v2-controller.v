import rt

struct Class_WC_REST_Product_Variations_V2_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v2')
		rest_base rt.PhpVal = rt.new_string('products/(?P<product_id>[\\d]+)/variations')
		post_type rt.PhpVal = rt.new_string('product_variation')
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) get_default_response_entity_type() string {
	return 'product_variation'
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) get_hooks_relevant_to_caching(mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_rest_prepare_product_variation_object' }, rt.ArrayItem{ key: none, val: 'woocommerce_product_type_query' }, rt.ArrayItem{ key: none, val: 'woocommerce_product_class' }, rt.ArrayItem{ key: none, val: 'woocommerce_short_description' }, rt.ArrayItem{ key: none, val: 'woocommerce_rest_product_variation_object_query' }])
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) get_version_strings_relevant_to_caching(mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) rt.PhpVal {
	mut var_request_mutated := var_request
	if rt.is_true(rt.identical(rt.new_string('get_variations'), var_endpoint_id)) {
		mut var_product_id := rt.call_method(var_request_mutated, 'get_param', [rt.new_string('product_id')])
		if rt.is_true(var_product_id) {
			return rt.create_array([rt.ArrayItem{ key: none, val: "list_product_variations_${var_product_id.to_string()}" }])
		}
	}
	return rt.new_array()
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the variable product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]), rt.create_array([rt.ArrayItem{ key: 'endpoint_id', val: 'get_variations' }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the variable product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the variation.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]), rt.create_array([rt.ArrayItem{ key: 'endpoint_id', val: 'get_variation' }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass trash and force deletion.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/batch', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the variable product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) get_object(var_id rt.PhpVal) rt.PhpVal {
	mut var_object := rt.call_function('wc_get_product', [var_id.dup()])
	return if rt.is_true(rt.new_bool(rt.is_true(var_object) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) { var_object } else { rt.new_null() }
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) check_variation_parent(variation_id i64, parent_id i64) bool {
	mut var_variation := this.get_object(rt.new_int(variation_id))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_variation)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	mut var_parent := rt.call_function('wc_get_product', [rt.call_method(var_variation, 'get_parent_id', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parent)))) {
		return false
	}
	return true
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if !(this.check_variation_parent((// unsupported expression: Expr_Cast_Int).to_i64(), (// unsupported expression: Expr_Cast_Int).to_i64())) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('Invalid ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	return this.Class_WC_REST_Products_V2_Controller.get_item_permissions_check(var_request_mutated.dup())
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if !(this.check_variation_parent((// unsupported expression: Expr_Cast_Int).to_i64(), (// unsupported expression: Expr_Cast_Int).to_i64())) {
		return (create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('Invalid ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))).to_bool()
	}
	mut var_object := this.get_object(// unsupported expression: Expr_Cast_Int)
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_object) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('edit'), rt.call_method(var_object, 'get_id', []rt.PhpVal{})]))))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) delete_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if !(this.check_variation_parent((// unsupported expression: Expr_Cast_Int).to_i64(), (// unsupported expression: Expr_Cast_Int).to_i64())) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('Invalid ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	return this.Class_WC_REST_Products_V2_Controller.delete_item_permissions_check(var_request_mutated.dup())
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) prepare_object_for_response(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_request_mutated := var_request
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_object_mutated, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_created', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_created', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_modified', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_modified', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('wc_format_content', [rt.call_method(var_object_mutated, 'get_description', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'permalink', val: rt.call_method(var_object_mutated, 'get_permalink', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'sku', val: rt.call_method(var_object_mutated, 'get_sku', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'price', val: rt.call_method(var_object_mutated, 'get_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'regular_price', val: rt.call_method(var_object_mutated, 'get_regular_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'sale_price', val: rt.call_method(var_object_mutated, 'get_sale_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_on_sale_from', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_on_sale_from', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_on_sale_from_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_on_sale_from', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_on_sale_to', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_on_sale_to', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_on_sale_to_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_on_sale_to', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'on_sale', val: rt.call_method(var_object_mutated, 'is_on_sale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'visible', val: rt.call_method(var_object_mutated, 'is_visible', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'purchasable', val: rt.call_method(var_object_mutated, 'is_purchasable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'virtual', val: rt.call_method(var_object_mutated, 'is_virtual', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'downloadable', val: rt.call_method(var_object_mutated, 'is_downloadable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'downloads', val: this.get_downloads(var_object_mutated.dup()) }, rt.ArrayItem{ key: 'download_limit', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { // unsupported expression: Expr_Cast_Int } else { // unsupported expression: Expr_UnaryMinus } }, rt.ArrayItem{ key: 'download_expiry', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { // unsupported expression: Expr_Cast_Int } else { // unsupported expression: Expr_UnaryMinus } }, rt.ArrayItem{ key: 'tax_status', val: rt.call_method(var_object_mutated, 'get_tax_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'tax_class', val: rt.call_method(var_object_mutated, 'get_tax_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'manage_stock', val: rt.call_method(var_object_mutated, 'managing_stock', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'stock_quantity', val: rt.call_method(var_object_mutated, 'get_stock_quantity', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'in_stock', val: rt.call_method(var_object_mutated, 'is_in_stock', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backorders', val: rt.call_method(var_object_mutated, 'get_backorders', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backorders_allowed', val: rt.call_method(var_object_mutated, 'backorders_allowed', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backordered', val: rt.call_method(var_object_mutated, 'is_on_backorder', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'weight', val: rt.call_method(var_object_mutated, 'get_weight', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'dimensions', val: rt.create_array([rt.ArrayItem{ key: 'length', val: rt.call_method(var_object_mutated, 'get_length', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'width', val: rt.call_method(var_object_mutated, 'get_width', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'height', val: rt.call_method(var_object_mutated, 'get_height', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'shipping_class', val: rt.call_method(var_object_mutated, 'get_shipping_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_class_id', val: rt.call_method(var_object_mutated, 'get_shipping_class_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'image', val: rt.call_function('current', [this.get_images(var_object_mutated.dup())]) }, rt.ArrayItem{ key: 'attributes', val: this.get_attributes(var_object_mutated.dup()) }, rt.ArrayItem{ key: 'menu_order', val: rt.call_method(var_object_mutated, 'get_menu_order', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'meta_data', val: rt.call_method(var_object_mutated, 'get_meta_data', []rt.PhpVal{}) }])
	mut var_context := if !(!rt.is_true(var_request_mutated.array_get('context'))) { var_request_mutated.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request_mutated.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_object_mutated.dup(), var_request_mutated.dup())])
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_prepare_'), this.post_type), rt.new_string('_object')), var_response.dup(), var_object_mutated.dup(), var_request_mutated.dup()])
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_args := this.Class_WC_REST_Products_V2_Controller.prepare_objects_query(var_request_mutated.dup())
	var_args.array_set('post_parent', var_request_mutated.array_get('product_id'))
	return var_args.dup()
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_request_mutated := var_request
	if var_request_mutated.array_isset(rt.new_string('id')) {
		mut var_variation := rt.call_function('wc_get_product', [rt.call_function('absint', [var_request_mutated.array_get('id')])])
	} else {
		var_variation = create_wc_product_variation()
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_variation, 'get_parent_id', []rt.PhpVal{}))) {
		rt.call_method(var_variation, 'set_parent_id', [rt.call_function('absint', [var_request_mutated.array_get('product_id')])])
	}
	if var_request_mutated.array_isset(rt.new_string('visible')) {
		rt.call_method(var_variation, 'set_status', [if rt.is_true(rt.identical(rt.new_bool(false), var_request_mutated.array_get('visible'))) { Class_Automattic_WooCommerce_Enums_ProductStatus.private() } else { Class_Automattic_WooCommerce_Enums_ProductStatus.publish() }])
	}
	if var_request_mutated.array_isset(rt.new_string('sku')) {
		rt.call_method(var_variation, 'set_sku', [rt.call_function('wc_clean', [var_request_mutated.array_get('sku')])])
	}
	if var_request_mutated.array_isset(rt.new_string('image')) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_request_mutated.array_get('image').is_array())) && !(!rt.is_true(var_request_mutated.array_get('image'))))) {
			mut var_image := var_request_mutated.array_get('image')
			if rt.is_true(rt.new_bool(var_image.dup().is_array())) {
				var_image.array_set('position', 0)
			}
			var_variation = this.set_product_images(var_variation.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_image }]))
		} else {
			rt.call_method(var_variation, 'set_image_id', [rt.new_string('')])
		}
	}
	if var_request_mutated.array_isset(rt.new_string('virtual')) {
		rt.call_method(var_variation, 'set_virtual', [var_request_mutated.array_get('virtual')])
	}
	if var_request_mutated.array_isset(rt.new_string('downloadable')) {
		rt.call_method(var_variation, 'set_downloadable', [var_request_mutated.array_get('downloadable')])
	}
	if rt.is_true(rt.call_method(var_variation, 'get_downloadable', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(var_request_mutated.array_isset(rt.new_string('downloads')) && rt.is_true(rt.new_bool(var_request_mutated.array_get('downloads').is_array())))) {
			var_variation = this.save_downloadable_files(var_variation.dup(), var_request_mutated.array_get('downloads'))
		}
		if var_request_mutated.array_isset(rt.new_string('download_limit')) {
			rt.call_method(var_variation, 'set_download_limit', [var_request_mutated.array_get('download_limit')])
		}
		if var_request_mutated.array_isset(rt.new_string('download_expiry')) {
			rt.call_method(var_variation, 'set_download_expiry', [var_request_mutated.array_get('download_expiry')])
		}
	}
	var_variation = this.save_product_shipping_data(var_variation.dup(), var_request_mutated.dup())
	if var_request_mutated.array_isset(rt.new_string('manage_stock')) {
		if rt.is_true(rt.identical(rt.new_string('parent'), var_request_mutated.array_get('manage_stock'))) {
			rt.call_method(var_variation, 'set_manage_stock', [rt.new_bool(false)])
			// unsupported statement: Stmt_Nop
		} else {
			rt.call_method(var_variation, 'set_manage_stock', [rt.call_function('wc_string_to_bool', [var_request_mutated.array_get('manage_stock')])])
		}
	}
	if var_request_mutated.array_isset(rt.new_string('in_stock')) {
		rt.call_method(var_variation, 'set_stock_status', [if rt.is_true(rt.identical(rt.new_bool(true), var_request_mutated.array_get('in_stock'))) { Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock() } else { Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock() }])
	}
	if var_request_mutated.array_isset(rt.new_string('backorders')) {
		rt.call_method(var_variation, 'set_backorders', [var_request_mutated.array_get('backorders')])
	}
	if rt.is_true(rt.call_method(var_variation, 'get_manage_stock', []rt.PhpVal{})) {
		if var_request_mutated.array_isset(rt.new_string('stock_quantity')) {
			rt.call_method(var_variation, 'set_stock_quantity', [var_request_mutated.array_get('stock_quantity')])
		} else if var_request_mutated.array_isset(rt.new_string('inventory_delta')) {
			mut var_stock_quantity := rt.call_function('wc_stock_amount', [rt.call_method(var_variation, 'get_stock_quantity', []rt.PhpVal{})])
			// unsupported expression: Expr_AssignOp_Plus
			rt.call_method(var_variation, 'set_stock_quantity', [var_stock_quantity.dup()])
		}
	} else {
		rt.call_method(var_variation, 'set_backorders', [rt.new_string('no')])
		rt.call_method(var_variation, 'set_stock_quantity', [rt.new_string('')])
	}
	if var_request_mutated.array_isset(rt.new_string('regular_price')) {
		rt.call_method(var_variation, 'set_regular_price', [var_request_mutated.array_get('regular_price')])
	}
	if var_request_mutated.array_isset(rt.new_string('sale_price')) {
		rt.call_method(var_variation, 'set_sale_price', [var_request_mutated.array_get('sale_price')])
	}
	if var_request_mutated.array_isset(rt.new_string('date_on_sale_from')) {
		rt.call_method(var_variation, 'set_date_on_sale_from', [var_request_mutated.array_get('date_on_sale_from')])
	}
	if var_request_mutated.array_isset(rt.new_string('date_on_sale_from_gmt')) {
		rt.call_method(var_variation, 'set_date_on_sale_from', [if rt.is_true(var_request_mutated.array_get('date_on_sale_from_gmt')) { rt.call_function('strtotime', [var_request_mutated.array_get('date_on_sale_from_gmt')]) } else { rt.new_null() }])
	}
	if var_request_mutated.array_isset(rt.new_string('date_on_sale_to')) {
		rt.call_method(var_variation, 'set_date_on_sale_to', [var_request_mutated.array_get('date_on_sale_to')])
	}
	if var_request_mutated.array_isset(rt.new_string('date_on_sale_to_gmt')) {
		rt.call_method(var_variation, 'set_date_on_sale_to', [if rt.is_true(var_request_mutated.array_get('date_on_sale_to_gmt')) { rt.call_function('strtotime', [var_request_mutated.array_get('date_on_sale_to_gmt')]) } else { rt.new_null() }])
	}
	if var_request_mutated.array_isset(rt.new_string('tax_class')) {
		rt.call_method(var_variation, 'set_tax_class', [var_request_mutated.array_get('tax_class')])
	}
	if var_request_mutated.array_isset(rt.new_string('description')) {
		rt.call_method(var_variation, 'set_description', [rt.call_function('wp_kses_post', [var_request_mutated.array_get('description')])])
	}
	if var_request_mutated.array_isset(rt.new_string('attributes')) {
		mut var_attributes := rt.new_array()
		mut var_parent := rt.call_function('wc_get_product', [rt.call_method(var_variation, 'get_parent_id', []rt.PhpVal{})])
		mut var_parent_attributes := rt.call_method(var_parent, 'get_attributes', []rt.PhpVal{})
		{
			mut iter_1 := var_request_mutated.array_get('attributes').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute := item_1.val
				mut var_attribute_id := rt.new_int(rt.new_int(0))
				mut var_attribute_name := rt.new_string(rt.new_string(''))
				if !(!rt.is_true(var_attribute.array_get('id'))) {
					var_attribute_id = rt.call_function('absint', [var_attribute.array_get('id')])
					mut var_raw_attribute_name := rt.call_function('wc_attribute_taxonomy_name_by_id', [var_attribute_id.dup()])
				} else if !(!rt.is_true(var_attribute.array_get('name'))) {
					var_raw_attribute_name = rt.call_function('sanitize_title', [var_attribute.array_get('name')])
				}
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_id)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_raw_attribute_name)))))) {
					continue
				}
				var_attribute_name = rt.call_function('sanitize_title', [var_raw_attribute_name.dup()])
				if rt.is_true(rt.new_bool(!(var_parent_attributes.array_isset(var_attribute_name)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'get_variation', []rt.PhpVal{}))))))) {
					continue
				}
				mut var_attribute_key := rt.call_function('sanitize_title', [rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'get_name', []rt.PhpVal{})])
				mut var_attribute_value := if var_attribute.array_isset(rt.new_string('option')) { rt.call_function('wc_clean', [rt.call_function('rawurldecode', [rt.call_function('stripslashes', [var_attribute.array_get('option')])])]) } else { rt.new_string('') }
				if rt.is_true(rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'is_taxonomy', []rt.PhpVal{})) {
					mut var_term := rt.call_function('get_term_by', [rt.new_string('name'), var_attribute_value.dup(), var_raw_attribute_name.dup()])
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
	if rt.is_true(var_request_mutated.array_get('menu_order')) {
		rt.call_method(var_variation, 'set_menu_order', [var_request_mutated.array_get('menu_order')])
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}; return temp.update(arg_0, arg_1) }(var_request_mutated.array_get('meta_data'), var_variation.dup())
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_pre_insert_'), this.post_type), rt.new_string('_object')), var_variation.dup(), var_request_mutated.dup(), rt.new_bool(creating)])
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) clear_transients(var_object rt.PhpVal)  {
	mut var_object_mutated := var_object
	rt.call_function('wc_delete_product_transients', [rt.call_method(var_object_mutated, 'get_parent_id', []rt.PhpVal{})])
	rt.call_function('wp_cache_delete', [ + ().str(), rt.new_string('products')])
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_force := 
	
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) batch_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) prepare_links(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) get_item_schema() rt.PhpVal {
}

struct Class_WC_REST_Products_V2_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Product_Variation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	rt.PhpObjectBase
}

fn create_wc_rest_product_variations_v2_controller() &Class_WC_REST_Product_Variations_V2_Controller {
	mut obj := &Class_WC_REST_Product_Variations_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v2')
		rest_base: rt.new_string('products/(?P<product_id>[\\d]+)/variations')
		post_type: rt.new_string('product_variation')
	}
	return obj
}

fn create_wc_rest_products_v2_controller() &Class_WC_REST_Products_V2_Controller {
	mut obj := &Class_WC_REST_Products_V2_Controller{
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

fn create_wc_product_variation() &Class_WC_Product_Variation {
	mut obj := &Class_WC_Product_Variation{
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

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_default_response_entity_type' {
			return rt.new_string(this.get_default_response_entity_type())
		}
		'get_hooks_relevant_to_caching' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_hooks_relevant_to_caching(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_version_strings_relevant_to_caching' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_version_strings_relevant_to_caching(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_object(dispatch_arg_0)
		}
		'check_variation_parent' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.check_variation_parent(dispatch_arg_0, dispatch_arg_1))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item_permissions_check(dispatch_arg_0)
		}
		'prepare_object_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_object_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'prepare_object_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.prepare_object_for_database(dispatch_arg_0, dispatch_arg_1)
		}
		'clear_transients' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.clear_transients(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'batch_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.batch_items(dispatch_arg_0)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Product_Variations_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'post_type' { this.post_type = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Products_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Products_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Products_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Product_Variation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Variation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Variation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version2_class_wc_rest_product_variations_v2_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
