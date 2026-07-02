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

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str()), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the variable product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]), rt.create_array([rt.ArrayItem{ key: 'endpoint_id', val: 'get_variations' }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the variable product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the variation.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]), rt.create_array([rt.ArrayItem{ key: 'endpoint_id', val: 'get_variation' }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass trash and force deletion.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/batch'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the variable product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Variations_V2_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) get_object(var_id rt.PhpVal) rt.PhpVal {
	mut var_object := rt.call_function('wc_get_product', [var_id.clone()])
	return if rt.is_true(var_object) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_parent_id', []rt.PhpVal{}))))) { var_object } else { rt.new_null() }
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) check_variation_parent(variation_id i64, parent_id i64) bool {
	mut var_variation := this.get_object(rt.new_int(variation_id))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_variation)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(parent_id), rt.call_method(var_variation, 'get_parent_id', []rt.PhpVal{}))))) {
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
	if !(this.check_variation_parent(rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64()), rt.new_int((var_request_mutated.array_get(rt.new_string('product_id'))).to_i64()))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('Invalid ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return this.Class_WC_REST_Products_V2_Controller.get_item_permissions_check(var_request_mutated.clone())
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if !(this.check_variation_parent(rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64()), rt.new_int((var_request_mutated.array_get(rt.new_string('product_id'))).to_i64()))) {
		return (create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('Invalid ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))).to_bool()
	}
	mut var_object := this.get_object(rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64()))
	if rt.is_true(var_object) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('edit'), rt.call_method(var_object, 'get_id', []rt.PhpVal{})]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) delete_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if !(this.check_variation_parent(rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64()), rt.new_int((var_request_mutated.array_get(rt.new_string('product_id'))).to_i64()))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('Invalid ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return this.Class_WC_REST_Products_V2_Controller.delete_item_permissions_check(var_request_mutated.clone())
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) prepare_object_for_response(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_request_mutated := var_request
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_object_mutated, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_created', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_created', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_modified', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_modified', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('wc_format_content', [rt.call_method(var_object_mutated, 'get_description', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'permalink', val: rt.call_method(var_object_mutated, 'get_permalink', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'sku', val: rt.call_method(var_object_mutated, 'get_sku', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'price', val: rt.call_method(var_object_mutated, 'get_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'regular_price', val: rt.call_method(var_object_mutated, 'get_regular_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'sale_price', val: rt.call_method(var_object_mutated, 'get_sale_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_on_sale_from', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_on_sale_from', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_on_sale_from_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_on_sale_from', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_on_sale_to', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_on_sale_to', []rt.PhpVal{}), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_on_sale_to_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_object_mutated, 'get_date_on_sale_to', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'on_sale', val: rt.call_method(var_object_mutated, 'is_on_sale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'visible', val: rt.call_method(var_object_mutated, 'is_visible', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'purchasable', val: rt.call_method(var_object_mutated, 'is_purchasable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'virtual', val: rt.call_method(var_object_mutated, 'is_virtual', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'downloadable', val: rt.call_method(var_object_mutated, 'is_downloadable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'downloads', val: this.get_downloads(var_object_mutated.clone()) }, rt.ArrayItem{ key: 'download_limit', val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_object_mutated, 'get_download_limit', []rt.PhpVal{}))))) { rt.new_int((rt.call_method(var_object_mutated, 'get_download_limit', []rt.PhpVal{})).to_i64()) } else { -1 } }, rt.ArrayItem{ key: 'download_expiry', val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_object_mutated, 'get_download_expiry', []rt.PhpVal{}))))) { rt.new_int((rt.call_method(var_object_mutated, 'get_download_expiry', []rt.PhpVal{})).to_i64()) } else { -1 } }, rt.ArrayItem{ key: 'tax_status', val: rt.call_method(var_object_mutated, 'get_tax_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'tax_class', val: rt.call_method(var_object_mutated, 'get_tax_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'manage_stock', val: rt.call_method(var_object_mutated, 'managing_stock', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'stock_quantity', val: rt.call_method(var_object_mutated, 'get_stock_quantity', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'in_stock', val: rt.call_method(var_object_mutated, 'is_in_stock', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backorders', val: rt.call_method(var_object_mutated, 'get_backorders', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backorders_allowed', val: rt.call_method(var_object_mutated, 'backorders_allowed', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backordered', val: rt.call_method(var_object_mutated, 'is_on_backorder', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'weight', val: rt.call_method(var_object_mutated, 'get_weight', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'dimensions', val: rt.create_array([rt.ArrayItem{ key: 'length', val: rt.call_method(var_object_mutated, 'get_length', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'width', val: rt.call_method(var_object_mutated, 'get_width', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'height', val: rt.call_method(var_object_mutated, 'get_height', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'shipping_class', val: rt.call_method(var_object_mutated, 'get_shipping_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_class_id', val: rt.call_method(var_object_mutated, 'get_shipping_class_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'image', val: rt.call_function('current', [this.get_images(var_object_mutated.clone())]) }, rt.ArrayItem{ key: 'attributes', val: this.get_attributes(var_object_mutated.clone()) }, rt.ArrayItem{ key: 'menu_order', val: rt.call_method(var_object_mutated, 'get_menu_order', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'meta_data', val: rt.call_method(var_object_mutated, 'get_meta_data', []rt.PhpVal{}) }])
	mut var_context := if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('context')))) { var_request_mutated.array_get(rt.new_string('context')) } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request_mutated.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.clone()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_object_mutated.clone(), var_request_mutated.clone())])
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_prepare_'), this.post_type), rt.new_string('_object')), var_response.clone(), var_object_mutated.clone(), var_request_mutated.clone()])
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_args := this.Class_WC_REST_Products_V2_Controller.prepare_objects_query(var_request_mutated.clone())
	var_args.array_set('post_parent', var_request_mutated.array_get(rt.new_string('product_id')))
	return var_args.clone()
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_request_mutated := var_request
	if var_request_mutated.array_isset(rt.new_string('id')) {
	mut var_variation := rt.call_function('wc_get_product', [rt.call_function('absint', [var_request_mutated.array_get(rt.new_string('id'))])])
	} else {
	var_variation = create_wc_product_variation()
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_variation, 'get_parent_id', []rt.PhpVal{}))) {
		rt.call_method(var_variation, 'set_parent_id', [rt.call_function('absint', [var_request_mutated.array_get(rt.new_string('product_id'))])])
	}
	if var_request_mutated.array_isset(rt.new_string('visible')) {
		rt.call_method(var_variation, 'set_status', [if rt.is_true(rt.identical(rt.new_bool(false), var_request_mutated.array_get(rt.new_string('visible')))) { Class_Automattic_WooCommerce_Enums_ProductStatus.private() } else { Class_Automattic_WooCommerce_Enums_ProductStatus.publish() }])
	}
	if var_request_mutated.array_isset(rt.new_string('sku')) {
		rt.call_method(var_variation, 'set_sku', [rt.call_function('wc_clean', [var_request_mutated.array_get(rt.new_string('sku'))])])
	}
	if var_request_mutated.array_isset(rt.new_string('image')) {
		if var_request_mutated.array_get(rt.new_string('image')).is_array() && !(!rt.is_true(var_request_mutated.array_get(rt.new_string('image')))) {
			mut var_image := var_request_mutated.array_get(rt.new_string('image'))
			if rt.is_true(rt.new_bool(var_image.clone().is_array())) {
				var_image.array_set('position', 0)
			}
		var_variation = this.set_product_images(var_variation.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_image }]))
		} else {
			rt.call_method(var_variation, 'set_image_id', [rt.new_string('')])
		}
	}
	if var_request_mutated.array_isset(rt.new_string('virtual')) {
		rt.call_method(var_variation, 'set_virtual', [var_request_mutated.array_get(rt.new_string('virtual'))])
	}
	if var_request_mutated.array_isset(rt.new_string('downloadable')) {
		rt.call_method(var_variation, 'set_downloadable', [var_request_mutated.array_get(rt.new_string('downloadable'))])
	}
	if rt.is_true(rt.call_method(var_variation, 'get_downloadable', []rt.PhpVal{})) {
		if var_request_mutated.array_isset(rt.new_string('downloads')) && var_request_mutated.array_get(rt.new_string('downloads')).is_array() {
		var_variation = this.save_downloadable_files(var_variation.clone(), var_request_mutated.array_get(rt.new_string('downloads')))
		}
		if var_request_mutated.array_isset(rt.new_string('download_limit')) {
			rt.call_method(var_variation, 'set_download_limit', [var_request_mutated.array_get(rt.new_string('download_limit'))])
		}
		if var_request_mutated.array_isset(rt.new_string('download_expiry')) {
			rt.call_method(var_variation, 'set_download_expiry', [var_request_mutated.array_get(rt.new_string('download_expiry'))])
		}
	}
	var_variation = this.save_product_shipping_data(var_variation.clone(), var_request_mutated.clone())
	if var_request_mutated.array_isset(rt.new_string('manage_stock')) {
		if rt.is_true(rt.identical(rt.new_string('parent'), var_request_mutated.array_get(rt.new_string('manage_stock')))) {
			rt.call_method(var_variation, 'set_manage_stock', [rt.new_bool(false)])
		} else {
			rt.call_method(var_variation, 'set_manage_stock', [rt.call_function('wc_string_to_bool', [var_request_mutated.array_get(rt.new_string('manage_stock'))])])
		}
	}
	if var_request_mutated.array_isset(rt.new_string('in_stock')) {
		rt.call_method(var_variation, 'set_stock_status', [if rt.is_true(rt.identical(rt.new_bool(true), var_request_mutated.array_get(rt.new_string('in_stock')))) { Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock() } else { Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock() }])
	}
	if var_request_mutated.array_isset(rt.new_string('backorders')) {
		rt.call_method(var_variation, 'set_backorders', [var_request_mutated.array_get(rt.new_string('backorders'))])
	}
	if rt.is_true(rt.call_method(var_variation, 'get_manage_stock', []rt.PhpVal{})) {
		if var_request_mutated.array_isset(rt.new_string('stock_quantity')) {
			rt.call_method(var_variation, 'set_stock_quantity', [var_request_mutated.array_get(rt.new_string('stock_quantity'))])
		} else if var_request_mutated.array_isset(rt.new_string('inventory_delta')) {
			mut var_stock_quantity := rt.call_function('wc_stock_amount', [rt.call_method(var_variation, 'get_stock_quantity', []rt.PhpVal{})])
			var_stock_quantity = rt.add(var_stock_quantity, rt.call_function('wc_stock_amount', [var_request_mutated.array_get(rt.new_string('inventory_delta'))]))
			rt.call_method(var_variation, 'set_stock_quantity', [var_stock_quantity.clone()])
		}
	} else {
		rt.call_method(var_variation, 'set_backorders', [rt.new_string('no')])
		rt.call_method(var_variation, 'set_stock_quantity', [rt.new_string('')])
	}
	if var_request_mutated.array_isset(rt.new_string('regular_price')) {
		rt.call_method(var_variation, 'set_regular_price', [var_request_mutated.array_get(rt.new_string('regular_price'))])
	}
	if var_request_mutated.array_isset(rt.new_string('sale_price')) {
		rt.call_method(var_variation, 'set_sale_price', [var_request_mutated.array_get(rt.new_string('sale_price'))])
	}
	if var_request_mutated.array_isset(rt.new_string('date_on_sale_from')) {
		rt.call_method(var_variation, 'set_date_on_sale_from', [var_request_mutated.array_get(rt.new_string('date_on_sale_from'))])
	}
	if var_request_mutated.array_isset(rt.new_string('date_on_sale_from_gmt')) {
		rt.call_method(var_variation, 'set_date_on_sale_from', [if rt.is_true(var_request_mutated.array_get(rt.new_string('date_on_sale_from_gmt'))) { rt.call_function('strtotime', [var_request_mutated.array_get(rt.new_string('date_on_sale_from_gmt'))]) } else { rt.new_null() }])
	}
	if var_request_mutated.array_isset(rt.new_string('date_on_sale_to')) {
		rt.call_method(var_variation, 'set_date_on_sale_to', [var_request_mutated.array_get(rt.new_string('date_on_sale_to'))])
	}
	if var_request_mutated.array_isset(rt.new_string('date_on_sale_to_gmt')) {
		rt.call_method(var_variation, 'set_date_on_sale_to', [if rt.is_true(var_request_mutated.array_get(rt.new_string('date_on_sale_to_gmt'))) { rt.call_function('strtotime', [var_request_mutated.array_get(rt.new_string('date_on_sale_to_gmt'))]) } else { rt.new_null() }])
	}
	if var_request_mutated.array_isset(rt.new_string('tax_class')) {
		rt.call_method(var_variation, 'set_tax_class', [var_request_mutated.array_get(rt.new_string('tax_class'))])
	}
	if var_request_mutated.array_isset(rt.new_string('description')) {
		rt.call_method(var_variation, 'set_description', [rt.call_function('wp_kses_post', [var_request_mutated.array_get(rt.new_string('description'))])])
	}
	if var_request_mutated.array_isset(rt.new_string('attributes')) {
		mut var_attributes := rt.new_array()
		mut var_parent := rt.call_function('wc_get_product', [rt.call_method(var_variation, 'get_parent_id', []rt.PhpVal{})])
		mut var_parent_attributes := rt.call_method(var_parent, 'get_attributes', []rt.PhpVal{})
		mut iter_1 := var_request_mutated.array_get(rt.new_string('attributes')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attribute := item_1.val
			mut var_attribute_id := rt.new_int(0)
			mut var_attribute_name := rt.new_string('')
			if !(!rt.is_true(var_attribute.array_get(rt.new_string('id')))) {
			var_attribute_id = rt.call_function('absint', [var_attribute.array_get(rt.new_string('id'))])
			mut var_raw_attribute_name := rt.call_function('wc_attribute_taxonomy_name_by_id', [var_attribute_id.clone()])
			} else if !(!rt.is_true(var_attribute.array_get(rt.new_string('name')))) {
			var_raw_attribute_name = rt.call_function('sanitize_title', [var_attribute.array_get(rt.new_string('name'))])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_id)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_raw_attribute_name)))) {
				continue
			}
			var_attribute_name = rt.call_function('sanitize_title', [var_raw_attribute_name.clone()])
			if !(var_parent_attributes.array_isset(var_attribute_name)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'get_variation', []rt.PhpVal{}))))) {
				continue
			}
			mut var_attribute_key := rt.call_function('sanitize_title', [rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'get_name', []rt.PhpVal{})])
			mut var_attribute_value := if var_attribute.array_isset(rt.new_string('option')) { rt.call_function('wc_clean', [rt.call_function('rawurldecode', [rt.call_function('stripslashes', [var_attribute.array_get(rt.new_string('option'))])])]) } else { rt.new_string('') }
			if rt.is_true(rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'is_taxonomy', []rt.PhpVal{})) {
				mut var_term := rt.call_function('get_term_by', [rt.new_string('name'), var_attribute_value.clone(), var_raw_attribute_name.clone()])
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
	if rt.is_true(var_request_mutated.array_get(rt.new_string('menu_order'))) {
		rt.call_method(var_variation, 'set_menu_order', [var_request_mutated.array_get(rt.new_string('menu_order'))])
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
	mut iife_result_0 := iife_temp_0.update(var_request_mutated.array_get(rt.new_string('meta_data')), var_variation.clone())
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_pre_insert_'), this.post_type), rt.new_string('_object')), var_variation.clone(), var_request_mutated.clone(), rt.new_bool(creating)])
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) clear_transients(var_object rt.PhpVal) {
	mut var_object_mutated := var_object
	rt.call_function('wc_delete_product_transients', [rt.call_method(var_object_mutated, 'get_parent_id', []rt.PhpVal{})])
	rt.call_function('wp_cache_delete', [rt.new_string('product-' + (rt.call_method(var_object_mutated, 'get_parent_id', []rt.PhpVal{})).str()), rt.new_string('products')])
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_force := rt.new_bool((var_request_mutated.array_get(rt.new_string('force'))).to_bool())
	mut var_object := this.get_object(rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64()))
	mut var_result := rt.new_bool(false)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('Invalid ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_supports_trash := rt.new_bool(rt.is_true(rt.greater(rt.get_constant('EMPTY_TRASH_DAYS'), rt.new_int(0))) && rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_object }, rt.ArrayItem{ key: none, val: 'get_status' }])]))
	var_supports_trash = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_object_trashable')), var_supports_trash.clone(), var_object.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('delete'), rt.call_method(var_object, 'get_id', []rt.PhpVal{})]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.new_string('woocommerce_rest_user_cannot_delete_'), this.post_type), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete %s.'), rt.new_string('woocommerce')]), this.post_type]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))
	}
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_object_for_response(var_object.clone(), var_request_mutated.clone())
	if rt.is_true(var_force) {
		rt.call_method(var_object, 'delete', [rt.new_bool(true)])
	var_result = rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_supports_trash)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_trash_not_supported'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s does not support trashing.'), rt.new_string('woocommerce')]), this.post_type]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
		}
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_object }, rt.ArrayItem{ key: none, val: 'get_status' }])])) {
			if rt.is_true(rt.identical(rt.new_string('trash'), rt.call_method(var_object, 'get_status', []rt.PhpVal{}))) {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_already_trashed'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s has already been deleted.'), rt.new_string('woocommerce')]), this.post_type]), rt.create_array([rt.ArrayItem{ key: 'status', val: 410 }])))
			}
			rt.call_method(var_object, 'delete', []rt.PhpVal{})
		var_result = rt.identical(rt.new_string('trash'), rt.call_method(var_object, 'get_status', []rt.PhpVal{}))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s cannot be deleted.'), rt.new_string('woocommerce')]), this.post_type]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_parent_id', []rt.PhpVal{}))))) {
		rt.call_function('wc_delete_product_transients', [rt.call_method(var_object, 'get_parent_id', []rt.PhpVal{})])
	}
	rt.call_function('do_action', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_delete_'), this.post_type), rt.new_string('_object')), var_object.clone(), var_response.clone(), var_request_mutated.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) batch_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_items := rt.call_function('array_filter', [rt.call_method(var_request_mutated, 'get_params', []rt.PhpVal{})])
	mut var_params := rt.call_method(var_request_mutated, 'get_url_params', []rt.PhpVal{})
	mut var_query := rt.call_method(var_request_mutated, 'get_query_params', []rt.PhpVal{})
	mut var_product_id := var_params.array_get(rt.new_string('product_id'))
	mut var_body_params := rt.new_array()
	mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'update' }, rt.ArrayItem{ key: none, val: 'create' }, rt.ArrayItem{ key: none, val: 'delete' }]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_batch_type := item_2.val
		if !(!rt.is_true(var_items.array_get(var_batch_type))) {
			mut var_injected_items := rt.new_array()
			mut iter_3 := var_items.array_get(var_batch_type).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_item := item_3.val
				mut var_injected_item := if var_item.clone().is_array() { rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_product_id }]), var_item.clone()]) } else { var_item }
				if rt.is_true(rt.identical(rt.new_string('delete'), var_batch_type)) && var_item.clone().is_long() {
				var_injected_item = rt.create_array([rt.ArrayItem{ key: 'id', val: var_item }, rt.ArrayItem{ key: 'product_id', val: var_product_id }])
				}
				var_injected_items << var_injected_item.clone()
			}
			var_body_params.array_set(var_batch_type, var_injected_items.clone())
		}
	}
	var_request_mutated = create_wp_rest_request(rt.call_method(var_request_mutated, 'get_method', []rt.PhpVal{}))
	rt.call_method(var_request_mutated, 'set_body_params', [var_body_params.clone()])
	rt.call_method(var_request_mutated, 'set_query_params', [var_query.clone()])
	return this.Class_WC_REST_Products_V2_Controller.batch_items(var_request_mutated.clone())
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) prepare_links(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_request_mutated := var_request
	mut var_product_id := rt.new_int((var_request_mutated.array_get(rt.new_string('product_id'))).to_i64())
	mut var_base := rt.call_function('str_replace', [rt.new_string('(?P<product_id>[\\d]+)'), var_product_id.clone(), this.rest_base])
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, var_base.clone(), rt.call_method(var_object_mutated, 'get_id', []rt.PhpVal{})])]) }, 'collection': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, var_base.clone()])]) }, 'up': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/products/%d'), this.namespace, var_product_id.clone()])]) } }
	return var_links.clone()
}

fn (mut this Class_WC_REST_Product_Variations_V2_Controller) get_item_schema() rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_1 := iife_temp_1.get_weight_unit_label(rt.call_function('get_option', [rt.new_string('woocommerce_weight_unit'), rt.new_string('kg')]))
	mut var_weight_unit_label := iife_result_1
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_2 := iife_temp_2.get_dimensions_unit_label(rt.call_function('get_option', [rt.new_string('woocommerce_dimension_unit'), rt.new_string('cm')]))
	mut var_dimension_unit_label := iife_result_2
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': this.post_type, 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_created': { 'description': rt.call_function('__', [rt.new_string('The date the variation was created, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_modified': { 'description': rt.call_function('__', [rt.new_string('The date the variation was last modified, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'description': { 'description': rt.call_function('__', [rt.new_string('Variation description.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'permalink': { 'description': rt.call_function('__', [rt.new_string('Variation URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'format': rt.new_string('uri'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'sku': { 'description': rt.call_function('__', [rt.new_string('Unique identifier.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'price': { 'description': rt.call_function('__', [rt.new_string('Current variation price.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'regular_price': { 'description': rt.call_function('__', [rt.new_string('Variation regular price.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'sale_price': { 'description': rt.call_function('__', [rt.new_string('Variation sale price.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'date_on_sale_from': { 'description': rt.call_function('__', [rt.new_string('Start date of sale price, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{} }, 'date_on_sale_from_gmt': { 'description': rt.call_function('__', [rt.new_string('Start date of sale price, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{} }, 'date_on_sale_to': { 'description': rt.call_function('__', [rt.new_string('End date of sale price, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{} }, 'date_on_sale_to_gmt': { 'description': rt.call_function('__', [rt.new_string('End date of sale price, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{} }, 'on_sale': { 'description': rt.call_function('__', [rt.new_string('Shows if the variation is on sale.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'visible': { 'description': rt.call_function('__', [rt.new_string('Define if the variation is visible on the product\'s page.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(true), 'context': map[string]rt.PhpVal{} }, 'purchasable': { 'description': rt.call_function('__', [rt.new_string('Shows if the variation can be bought.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'virtual': { 'description': rt.call_function('__', [rt.new_string('If the variation is virtual.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(false), 'context': map[string]rt.PhpVal{} }, 'downloadable': { 'description': rt.call_function('__', [rt.new_string('If the variation is downloadable.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(false), 'context': map[string]rt.PhpVal{} }, 'downloads': { 'description': rt.call_function('__', [rt.new_string('List of downloadable files.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('File ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'name': { 'description': rt.call_function('__', [rt.new_string('File name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'file': { 'description': rt.call_function('__', [rt.new_string('File URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} } } } }, 'download_limit': { 'description': rt.call_function('__', [rt.new_string('Number of times downloadable files can be downloaded after purchase.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'default': -1, 'context': map[string]rt.PhpVal{} }, 'download_expiry': { 'description': rt.call_function('__', [rt.new_string('Number of days until access to downloadable files expires.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'default': -1, 'context': map[string]rt.PhpVal{} }, 'tax_status': { 'description': rt.call_function('__', [rt.new_string('Tax status.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'default': Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), 'enum': map[string]rt.PhpVal{}, 'context': map[string]rt.PhpVal{} }, 'tax_class': { 'description': rt.call_function('__', [rt.new_string('Tax class.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'manage_stock': { 'description': rt.call_function('__', [rt.new_string('Stock management at variation level.'), rt.new_string('woocommerce')]), 'type': rt.new_string('mixed'), 'default': rt.new_bool(false), 'context': map[string]rt.PhpVal{} }, 'stock_quantity': { 'description': rt.call_function('__', [rt.new_string('Stock quantity.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'in_stock': { 'description': rt.call_function('__', [rt.new_string('Controls whether or not the variation is listed as "in stock" or "out of stock" on the frontend.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(true), 'context': map[string]rt.PhpVal{} }, 'backorders': { 'description': rt.call_function('__', [rt.new_string('If managing stock, this controls if backorders are allowed.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'default': rt.new_string('no'), 'enum': map[string]rt.PhpVal{}, 'context': map[string]rt.PhpVal{} }, 'backorders_allowed': { 'description': rt.call_function('__', [rt.new_string('Shows if backorders are allowed.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'backordered': { 'description': rt.call_function('__', [rt.new_string('Shows if the variation is on backordered.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'weight': { 'description': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Variation weight (%s).'), rt.new_string('woocommerce')]), var_weight_unit_label.clone()]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'dimensions': { 'description': rt.call_function('__', [rt.new_string('Variation dimensions.'), rt.new_string('woocommerce')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'properties': { 'length': { 'description': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Variation length (%s).'), rt.new_string('woocommerce')]), var_dimension_unit_label.clone()]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'width': { 'description': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Variation width (%s).'), rt.new_string('woocommerce')]), var_dimension_unit_label.clone()]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'height': { 'description': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Variation height (%s).'), rt.new_string('woocommerce')]), var_dimension_unit_label.clone()]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} } } }, 'shipping_class': { 'description': rt.call_function('__', [rt.new_string('Shipping class slug.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'shipping_class_id': { 'description': rt.call_function('__', [rt.new_string('Shipping class ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'image': { 'description': rt.call_function('__', [rt.new_string('Variation image data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Image ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'date_created': { 'description': rt.call_function('__', [rt.new_string('The date the image was created, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_created_gmt': { 'description': rt.call_function('__', [rt.new_string('The date the image was created, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_modified': { 'description': rt.call_function('__', [rt.new_string('The date the image was last modified, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_modified_gmt': { 'description': rt.call_function('__', [rt.new_string('The date the image was last modified, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'src': { 'description': rt.call_function('__', [rt.new_string('Image URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'format': rt.new_string('uri'), 'context': map[string]rt.PhpVal{} }, 'name': { 'description': rt.call_function('__', [rt.new_string('Image name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'alt': { 'description': rt.call_function('__', [rt.new_string('Image alternative text.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'position': { 'description': rt.call_function('__', [rt.new_string('Image position. 0 means that the image is featured.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} } } }, 'attributes': { 'description': rt.call_function('__', [rt.new_string('List of attributes.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Attribute ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'name': { 'description': rt.call_function('__', [rt.new_string('Attribute name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'option': { 'description': rt.call_function('__', [rt.new_string('Selected attribute term name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} } } } }, 'menu_order': { 'description': rt.call_function('__', [rt.new_string('Menu order, used to custom sort products.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'meta_data': { 'description': rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'key': { 'description': rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'value': { 'description': rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]), 'type': rt.new_string('mixed'), 'context': map[string]rt.PhpVal{} } } } } } }
	return this.add_additional_fields_schema(var_schema.clone())
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

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_I18nUtil {
	rt.PhpObjectBase
}

fn create_wc_rest_product_variations_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Product_Variations_V2_Controller {
	mut obj := &Class_WC_REST_Product_Variations_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v2')
		rest_base: rt.new_string('products/(?P<product_id>[\\d]+)/variations')
		post_type: rt.new_string('product_variation')
	}
	return obj
}

fn create_wc_rest_products_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Products_V2_Controller {
	mut obj := &Class_WC_REST_Products_V2_Controller{
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

fn create_wc_product_variation(_args ...rt.PhpVal) &Class_WC_Product_Variation {
	mut obj := &Class_WC_Product_Variation{
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

fn create_wp_rest_request(_args ...rt.PhpVal) &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
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


fn (mut this Class_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
