import rt

struct Class_WC_REST_Products_V2_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v2')
		rest_base rt.PhpVal = rt.new_string('products')
		post_type rt.PhpVal = rt.new_string('product')
		hierarchical rt.PhpVal = rt.new_bool(true)
}

fn (mut this Class_WC_REST_Products_V2_Controller) construct() {
	rt.call_function('add_action', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_insert_'), this.post_type), rt.new_string('_object')), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'clear_transients' }])])
	this.initialize_rest_api_cache()
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_default_response_entity_type() string {
	return 'product'
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_hooks_relevant_to_caching(mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_rest_prepare_product_object' }, rt.ArrayItem{ key: none, val: 'woocommerce_product_type_query' }, rt.ArrayItem{ key: none, val: 'woocommerce_product_class' }, rt.ArrayItem{ key: none, val: 'woocommerce_short_description' }, rt.ArrayItem{ key: none, val: 'woocommerce_rest_product_object_query' }])
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_data_for_etag(mut var_data Class_array, mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_request_mutated := var_request
	return this.remove_related_ids_from_response_data(mut var_data_mutated)
}

fn (mut this Class_WC_REST_Products_V2_Controller) remove_related_ids_from_response_data(mut var_data Class_array) rt.PhpVal {
	mut var_data_mutated := var_data
	if var_data_mutated.array_isset(rt.new_string('related_ids')) {
		var_data_mutated.array_unset(rt.new_string('related_ids'))
	}
	mut iter_1 := var_data_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		mut var_key := item_1.key
		if var_item.clone().is_array() && var_item.array_isset(rt.new_string('related_ids')) {
			var_data_mutated.array_get(var_key).array_unset(rt.new_string('related_ids'))
		}
	}
	return rt.new_object('array', []string{}, var_data_mutated)
}

fn (mut this Class_WC_REST_Products_V2_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str()), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]), rt.create_array([rt.ArrayItem{ key: 'endpoint_id', val: 'get_products' }, rt.ArrayItem{ key: 'relevant_version_strings', val: rt.create_array([rt.ArrayItem{ key: none, val: 'list_products' }]) }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]), rt.create_array([rt.ArrayItem{ key: 'endpoint_id', val: 'get_product' }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass trash and force deletion.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/batch'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)/related'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_related_products' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }]) }])])
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_object(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	return rt.call_function('wc_get_product', [var_id_mutated.clone()])
}

fn (mut this Class_WC_REST_Products_V2_Controller) batch_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_already_deferred := rt.call_function('wp_defer_term_counting', []rt.PhpVal{})
	rt.call_function('wp_defer_term_counting', [rt.new_bool(true)])
	return this.Class_WC_REST_CRUD_Controller.batch_items(var_request_mutated.clone())
	unsafe { goto finally_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()

finally_label_1:
	rt.call_function('wp_defer_term_counting', [var_already_deferred.clone()])
	if rt.has_exception() { return rt.new_null() }

end_label_1:
	return rt.new_null()
}

fn (mut this Class_WC_REST_Products_V2_Controller) prepare_object_for_response(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_request_mutated := var_request
	mut var_context := if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('context')))) { var_request_mutated.array_get(rt.new_string('context')) } else { rt.new_string('view') }
	this.dispatch_set_prop('request', var_request_mutated.clone())
	mut var_data := this.prepare_object_for_response_core(var_object_mutated.clone(), var_request_mutated.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.clone()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_object_mutated.clone(), var_request_mutated.clone())])
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_prepare_'), this.post_type), rt.new_string('_object')), var_response.clone(), var_object_mutated.clone(), var_request_mutated.clone()])
}

fn (mut this Class_WC_REST_Products_V2_Controller) prepare_object_for_response_core(var_object_data rt.PhpVal, var_request rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_context_mutated := var_context
	mut var_data := this.get_product_data(var_object_data.clone(), (var_context_mutated).str(), var_request_mutated.clone())
	if rt.is_true(rt.call_method(var_object_data, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) && rt.is_true(rt.call_method(var_object_data, 'has_child', []rt.PhpVal{})) {
		var_data.array_set('variations', rt.call_method(var_object_data, 'get_children', []rt.PhpVal{}))
	}
	if rt.is_true(rt.call_method(var_object_data, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.grouped()])) && rt.is_true(rt.call_method(var_object_data, 'has_child', []rt.PhpVal{})) {
		var_data.array_set('grouped_products', rt.call_method(var_object_data, 'get_children', []rt.PhpVal{}))
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request_mutated.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context_mutated.clone())
	return var_data.clone()
}

fn (mut this Class_WC_REST_Products_V2_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_args := this.Class_WC_REST_CRUD_Controller.prepare_objects_query(var_request_mutated.clone())
	var_args.array_set('post_status', var_request_mutated.array_get(rt.new_string('status')))
	mut var_tax_query := []rt.PhpVal{}
	mut var_taxonomies := { 'product_cat': 'category', 'product_tag': 'tag', 'product_shipping_class': 'shipping_class' }
	for var_taxonomy, var_key in var_taxonomies {
		if !(!rt.is_true(var_request_mutated.array_get(rt.new_string(key)))) {
			var_tax_query << rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: taxonomy }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'terms', val: var_request_mutated.array_get(rt.new_string(key)) }])
		}
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('type')))) {
		var_tax_query << rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_type' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'terms', val: var_request_mutated.array_get(rt.new_string('type')) }])
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('attribute')))) && !(!rt.is_true(var_request_mutated.array_get(rt.new_string('attribute_term')))) {
		if rt.is_true(rt.call_function('in_array', [var_request_mutated.array_get(rt.new_string('attribute')), rt.call_function('wc_get_attribute_taxonomy_names', []rt.PhpVal{}), rt.new_bool(true)])) {
			var_tax_query << rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_request_mutated.array_get(rt.new_string('attribute')) }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'terms', val: var_request_mutated.array_get(rt.new_string('attribute_term')) }])
		}
	}
	if !(!rt.is_true(var_tax_query)) {
		var_args.array_set('tax_query', var_tax_query.clone())
	}
	if rt.is_true(rt.new_bool(var_request_mutated.array_get(rt.new_string('featured')).is_bool())) {
		var_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'terms', val: 'featured' }, rt.ArrayItem{ key: 'operator', val: if rt.is_true(rt.identical(rt.new_bool(true), var_request_mutated.array_get(rt.new_string('featured')))) { 'IN' } else { 'NOT IN' } }]))
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('sku')))) {
		mut var_skus := rt.call_function('explode', [rt.new_string(','), var_request_mutated.array_get(rt.new_string('sku'))])
		if 1 < var_skus.clone().array_count() {
			var_skus.array_push(var_request_mutated.array_get(rt.new_string('sku')))
		}
		var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_sku' }, rt.ArrayItem{ key: 'value', val: var_skus }, rt.ArrayItem{ key: 'compare', val: 'IN' }])))
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('tax_class')))) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_tax_class' }, rt.ArrayItem{ key: 'value', val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('standard'), var_request_mutated.array_get(rt.new_string('tax_class')))))) { var_request_mutated.array_get(rt.new_string('tax_class')) } else { rt.new_string('') } }])))
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('min_price')))) || !(!rt.is_true(var_request_mutated.array_get(rt.new_string('max_price')))) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.call_function('wc_get_min_max_price_meta_query', [var_request_mutated.clone()])))
	}
	if rt.is_true(rt.new_bool(var_request_mutated.array_get(rt.new_string('in_stock')).is_bool())) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_stock_status' }, rt.ArrayItem{ key: 'value', val: if rt.is_true(rt.identical(rt.new_bool(true), var_request_mutated.array_get(rt.new_string('in_stock')))) { Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock() } else { Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock() } }])))
	}
	if rt.is_true(rt.new_bool(var_request_mutated.array_get(rt.new_string('on_sale')).is_bool())) {
		mut var_on_sale_key := rt.new_string((if rt.is_true(var_request_mutated.array_get(rt.new_string('on_sale'))) { 'post__in' } else { 'post__not_in' }).str())
		mut var_on_sale_ids := rt.call_function('wc_get_product_ids_on_sale', []rt.PhpVal{})
		var_on_sale_ids = if !rt.is_true(var_on_sale_ids) { rt.create_array([rt.ArrayItem{ key: none, val: 0 }]) } else { var_on_sale_ids }
		var_args.array_get(var_on_sale_key) = rt.add(var_args.array_get(var_on_sale_key), var_on_sale_ids)
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('sku')))) {
		var_args.array_set('post_type', rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]))
	} else {
		var_args.array_set('post_type', this.post_type)
	}
	return var_args.clone()
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_downloads(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_downloads := []rt.PhpVal{}
	if rt.is_true(rt.call_method(var_product_mutated, 'is_downloadable', []rt.PhpVal{})) {
		mut iter_2 := rt.call_method(var_product_mutated, 'get_downloads', []rt.PhpVal{}).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_file := item_2.val
			mut var_file_id := item_2.key
			var_downloads << rt.create_array([rt.ArrayItem{ key: 'id', val: var_file_id }, rt.ArrayItem{ key: 'name', val: var_file.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'file', val: var_file.array_get(rt.new_string('file')) }])
		}
	}
	return var_downloads.clone()
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_taxonomy_terms(var_product rt.PhpVal, taxonomy string) rt.PhpVal {
	mut var_product_mutated := var_product
	mut taxonomy_mutated := taxonomy
	mut var_terms := []rt.PhpVal{}
	mut iter_3 := rt.call_function('wc_get_object_terms', [rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}), rt.new_string('product_' + taxonomy_mutated)]).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_term := item_3.val
		var_terms << rt.create_array([rt.ArrayItem{ key: 'id', val: rt.get_property(var_term, 'term_id') }, rt.ArrayItem{ key: 'name', val: rt.get_property(var_term, 'name') }, rt.ArrayItem{ key: 'slug', val: rt.get_property(var_term, 'slug') }])
	}
	return var_terms.clone()
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_images(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_images := []rt.PhpVal{}
	mut var_attachment_ids := []rt.PhpVal{}
	if rt.is_true(rt.call_method(var_product_mutated, 'get_image_id', []rt.PhpVal{})) {
		var_attachment_ids.array_push(rt.call_method(var_product_mutated, 'get_image_id', []rt.PhpVal{}))
	}
	var_attachment_ids = rt.call_function('array_merge', [var_attachment_ids.clone(), rt.call_method(var_product_mutated, 'get_gallery_image_ids', []rt.PhpVal{})])
	if !(!rt.is_true(var_attachment_ids)) {
		rt.call_function('_prime_post_caches', [var_attachment_ids.clone()])
	}
	mut iter_4 := var_attachment_ids.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_attachment_id := item_4.val
		mut var_position := item_4.key
		mut var_attachment_post := rt.call_function('get_post', [var_attachment_id.clone()])
		if rt.is_true(rt.new_bool(var_attachment_post.clone().is_null())) {
			continue
		}
		mut var_attachment := rt.call_function('wp_get_attachment_image_src', [var_attachment_id.clone(), rt.new_string('full')])
		if !(var_attachment.clone().is_array()) {
			continue
		}
		var_images.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.new_int((var_attachment_id).to_i64()) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment_post, 'post_date'), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('strtotime', [rt.get_property(var_attachment_post, 'post_date_gmt')])]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment_post, 'post_modified'), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('strtotime', [rt.get_property(var_attachment_post, 'post_modified_gmt')])]) }, rt.ArrayItem{ key: 'src', val: rt.call_function('current', [var_attachment.clone()]) }, rt.ArrayItem{ key: 'name', val: rt.call_function('get_the_title', [var_attachment_id.clone()]) }, rt.ArrayItem{ key: 'alt', val: rt.call_function('get_post_meta', [var_attachment_id.clone(), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'position', val: rt.new_int((var_position).to_i64()) }]))
	}
	if !rt.is_true(var_images) {
		var_images.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 0 }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('current_time', [rt.new_string('mysql')]), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('time', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('current_time', [rt.new_string('mysql')]), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('time', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'src', val: rt.call_function('wc_placeholder_img_src', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Placeholder'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'alt', val: rt.call_function('__', [rt.new_string('Placeholder'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'position', val: 0 }]))
	}
	return var_images.clone()
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_attribute_taxonomy_label(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
	mut var_tax := rt.call_function('get_taxonomy', [var_name_mutated.clone()])
	mut var_labels := rt.call_function('get_taxonomy_labels', [var_tax.clone()])
	return rt.get_property(var_labels, 'singular_name')
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_attribute_taxonomy_name(var_slug rt.PhpVal, var_product rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
	mut var_product_mutated := var_product
	var_slug_mutated = rt.call_function('wc_attribute_taxonomy_slug', [var_slug_mutated.clone()])
	mut var_attributes := rt.call_function('array_combine', [rt.call_function('array_map', [rt.new_string('wc_sanitize_taxonomy_name'), rt.func_array_keys(rt.call_method(var_product_mutated, 'get_attributes', []rt.PhpVal{}))]), rt.call_function('array_values', [rt.call_method(var_product_mutated, 'get_attributes', []rt.PhpVal{})])])
	mut var_attribute := rt.new_bool(false)
	if var_attributes.array_isset(rt.call_function('wc_attribute_taxonomy_name', [var_slug_mutated.clone()])) {
	var_attribute = var_attributes.array_get(rt.call_function('wc_attribute_taxonomy_name', [var_slug_mutated.clone()]))
	} else if var_attributes.array_isset(var_slug_mutated) {
	var_attribute = var_attributes.array_get(var_slug_mutated)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute)))) {
		return var_slug_mutated.clone()
	}
	if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{})) {
		mut var_taxonomy := rt.call_method(var_attribute, 'get_taxonomy_object', []rt.PhpVal{})
		return rt.get_property(var_taxonomy, 'attribute_label')
	}
	return rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_default_attributes(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_default := []rt.PhpVal{}
	if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) {
		mut iter_5 := rt.call_function('array_filter', [rt.cast_array(rt.call_method(var_product_mutated, 'get_default_attributes', []rt.PhpVal{})), rt.new_string('strlen')]).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_value := item_5.val
			mut var_key := item_5.key
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_key.clone(), rt.new_string('pa_')]))) {
				var_default << rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_function('wc_attribute_taxonomy_id_by_name', [var_key.clone()]) }, rt.ArrayItem{ key: 'name', val: this.get_attribute_taxonomy_name(var_key.clone(), var_product_mutated.clone()) }, rt.ArrayItem{ key: 'option', val: var_value }])
			} else {
				var_default << rt.create_array([rt.ArrayItem{ key: 'id', val: 0 }, rt.ArrayItem{ key: 'name', val: this.get_attribute_taxonomy_name(var_key.clone(), var_product_mutated.clone()) }, rt.ArrayItem{ key: 'option', val: var_value }])
			}
		}
	}
	return var_default.clone()
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_attribute_options(var_product_id rt.PhpVal, var_attribute rt.PhpVal) rt.PhpVal {
	mut var_attribute_mutated := var_attribute
	if var_attribute_mutated.array_isset(rt.new_string('is_taxonomy')) && rt.is_true(var_attribute_mutated.array_get(rt.new_string('is_taxonomy'))) {
		return rt.call_function('wc_get_product_terms', [var_product_id.clone(), var_attribute_mutated.array_get(rt.new_string('name')), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'names' }])])
	} else if var_attribute_mutated.array_isset(rt.new_string('value')) {
		return rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string('|'), var_attribute_mutated.array_get(rt.new_string('value'))])])
	}
	return []rt.PhpVal{}
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_attributes(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_attributes := []rt.PhpVal{}
	if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) {
		mut var__product := rt.call_function('wc_get_product', [rt.call_method(var_product_mutated, 'get_parent_id', []rt.PhpVal{})])
		mut iter_6 := rt.call_method(var_product_mutated, 'get_variation_attributes', []rt.PhpVal{}).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_attribute := item_6.val
			mut var_attribute_name := item_6.key
			mut var_name := rt.call_function('str_replace', [rt.new_string('attribute_'), rt.new_string(''), var_attribute_name.clone()])
			if !rt.is_true(var_attribute) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0'), var_attribute)))) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_attribute_name.clone(), rt.new_string('attribute_pa_')]))) {
				mut var_option_term := rt.call_function('get_term_by', [rt.new_string('slug'), var_attribute.clone(), var_name.clone()])
				var_attributes.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_function('wc_attribute_taxonomy_id_by_name', [var_name.clone()]) }, rt.ArrayItem{ key: 'name', val: this.get_attribute_taxonomy_name(var_name.clone(), var__product.clone()) }, rt.ArrayItem{ key: 'slug', val: rt.call_function('rawurldecode', [var_name.clone()]) }, rt.ArrayItem{ key: 'option', val: if rt.is_true(var_option_term) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_option_term.clone()]))))) { rt.call_function('rawurldecode', [rt.get_property(var_option_term, 'name')]) } else { rt.call_function('rawurldecode', [var_attribute.clone()]) } }]))
			} else {
				var_attributes.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 0 }, rt.ArrayItem{ key: 'name', val: this.get_attribute_taxonomy_name(var_name.clone(), var__product.clone()) }, rt.ArrayItem{ key: 'slug', val: var_name }, rt.ArrayItem{ key: 'option', val: var_attribute }]))
			}
		}
	} else {
		mut iter_7 := rt.call_method(var_product_mutated, 'get_attributes', []rt.PhpVal{}).iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_attribute := item_7.val
			var_attributes.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: if rt.is_true(var_attribute.array_get(rt.new_string('is_taxonomy'))) { rt.call_function('wc_attribute_taxonomy_id_by_name', [var_attribute.array_get(rt.new_string('name'))]) } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'name', val: this.get_attribute_taxonomy_name(var_attribute.array_get(rt.new_string('name')), var_product_mutated.clone()) }, rt.ArrayItem{ key: 'slug', val: var_attribute.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'position', val: rt.new_int((var_attribute.array_get(rt.new_string('position'))).to_i64()) }, rt.ArrayItem{ key: 'visible', val: (var_attribute.array_get(rt.new_string('is_visible'))).to_bool() }, rt.ArrayItem{ key: 'variation', val: (var_attribute.array_get(rt.new_string('is_variation'))).to_bool() }, rt.ArrayItem{ key: 'options', val: this.get_attribute_options(rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}), var_attribute.clone()) }]))
		}
	}
	return var_attributes.clone()
}

fn (mut this Class_WC_REST_Products_V2_Controller) api_get_price_html(var_product rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_context_mutated := var_context
	return rt.call_method(var_product_mutated, 'get_price_html', []rt.PhpVal{})
}

fn (mut this Class_WC_REST_Products_V2_Controller) api_get_related_ids(var_product rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_context_mutated := var_context
	return rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('array_values', [rt.call_function('wc_get_related_products', [rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})])])])
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_related_products(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_product := this.get_object(rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_product, 'get_id', []rt.PhpVal{}))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_product_invalid_id'), rt.call_function('__', [rt.new_string('Invalid product ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_related_ids := this.api_get_related_ids(var_product.clone(), rt.new_string('view'))
	return rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'related_ids', val: var_related_ids }])])
}

fn (mut this Class_WC_REST_Products_V2_Controller) api_get_meta_data(var_product rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_context_mutated := var_context
	mut var_meta_data := rt.call_method(var_product_mutated, 'get_meta_data', []rt.PhpVal{})
	if !(!(rt.get_property(rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this), 'request')).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this), 'request'), 'WP_REST_Request')))))) {
		return var_meta_data.clone()
	}
	return this.get_meta_data_for_response(rt.get_property(rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this), 'request'), var_meta_data.clone())
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_product_data(var_product rt.PhpVal, context string) rt.PhpVal {
	mut var_product_mutated := var_product
	mut context_mutated := context
	mut var_request := if rt.is_true(rt.greater_equal(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(3))) { rt.call_function('func_get_arg', [rt.new_int(2)]) } else { create_wp_rest_request(rt.new_string(''), rt.new_string(''), rt.create_array([rt.ArrayItem{ key: 'context', val: context_mutated }])) }
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_base_data := []rt.PhpVal{}
	mut iter_8 := var_fields.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_field := item_8.val
		mut switch_val_1 := var_field
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('id'))) {
			var_base_data.array_set('id', rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('name'))) {
			var_base_data.array_set('name', rt.call_method(var_product_mutated, 'get_name', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('slug'))) {
			var_base_data.array_set('slug', rt.call_method(var_product_mutated, 'get_slug', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('permalink'))) {
			var_base_data.array_set('permalink', rt.call_method(var_product_mutated, 'get_permalink', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_created'))) {
			var_base_data.array_set('date_created', rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_product_mutated, 'get_date_created', [rt.new_string(context_mutated).clone()]), rt.new_bool(false)]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_created_gmt'))) {
			var_base_data.array_set('date_created_gmt', rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_product_mutated, 'get_date_created', [rt.new_string(context_mutated).clone()])]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_modified'))) {
			var_base_data.array_set('date_modified', rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_product_mutated, 'get_date_modified', [rt.new_string(context_mutated).clone()]), rt.new_bool(false)]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_modified_gmt'))) {
			var_base_data.array_set('date_modified_gmt', rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_product_mutated, 'get_date_modified', [rt.new_string(context_mutated).clone()])]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('type'))) {
			var_base_data.array_set('type', rt.call_method(var_product_mutated, 'get_type', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('status'))) {
			var_base_data.array_set('status', rt.call_method(var_product_mutated, 'get_status', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('featured'))) {
			var_base_data.array_set('featured', rt.call_method(var_product_mutated, 'is_featured', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('catalog_visibility'))) {
			var_base_data.array_set('catalog_visibility', rt.call_method(var_product_mutated, 'get_catalog_visibility', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('description'))) {
			var_base_data.array_set('description', if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context_mutated))) { rt.call_function('wpautop', [rt.call_function('do_shortcode', [rt.call_method(var_product_mutated, 'get_description', []rt.PhpVal{})])]) } else { rt.call_method(var_product_mutated, 'get_description', [rt.new_string(context_mutated).clone()]) })
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('short_description'))) {
			var_base_data.array_set('short_description', if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context_mutated))) { rt.call_function('apply_filters', [rt.new_string('woocommerce_short_description'), rt.call_method(var_product_mutated, 'get_short_description', []rt.PhpVal{})]) } else { rt.call_method(var_product_mutated, 'get_short_description', [rt.new_string(context_mutated).clone()]) })
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('sku'))) {
			var_base_data.array_set('sku', rt.call_method(var_product_mutated, 'get_sku', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('price'))) {
			var_base_data.array_set('price', rt.call_method(var_product_mutated, 'get_price', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('regular_price'))) {
			var_base_data.array_set('regular_price', rt.call_method(var_product_mutated, 'get_regular_price', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('sale_price'))) {
			var_base_data.array_set('sale_price', if rt.is_true(rt.call_method(var_product_mutated, 'get_sale_price', [rt.new_string(context_mutated).clone()])) { rt.call_method(var_product_mutated, 'get_sale_price', [rt.new_string(context_mutated).clone()]) } else { rt.new_string('') })
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_on_sale_from'))) {
			var_base_data.array_set('date_on_sale_from', rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_product_mutated, 'get_date_on_sale_from', [rt.new_string(context_mutated).clone()]), rt.new_bool(false)]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_on_sale_from_gmt'))) {
			var_base_data.array_set('date_on_sale_from_gmt', rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_product_mutated, 'get_date_on_sale_from', [rt.new_string(context_mutated).clone()])]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_on_sale_to'))) {
			var_base_data.array_set('date_on_sale_to', rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_product_mutated, 'get_date_on_sale_to', [rt.new_string(context_mutated).clone()]), rt.new_bool(false)]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date_on_sale_to_gmt'))) {
			var_base_data.array_set('date_on_sale_to_gmt', rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_product_mutated, 'get_date_on_sale_to', [rt.new_string(context_mutated).clone()])]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('on_sale'))) {
			var_base_data.array_set('on_sale', rt.call_method(var_product_mutated, 'is_on_sale', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('purchasable'))) {
			var_base_data.array_set('purchasable', rt.call_method(var_product_mutated, 'is_purchasable', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('total_sales'))) {
			var_base_data.array_set('total_sales', rt.call_method(var_product_mutated, 'get_total_sales', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('virtual'))) {
			var_base_data.array_set('virtual', rt.call_method(var_product_mutated, 'is_virtual', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('downloadable'))) {
			var_base_data.array_set('downloadable', rt.call_method(var_product_mutated, 'is_downloadable', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('downloads'))) {
			var_base_data.array_set('downloads', this.get_downloads(var_product_mutated.clone()))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download_limit'))) {
			var_base_data.array_set('download_limit', rt.call_method(var_product_mutated, 'get_download_limit', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download_expiry'))) {
			var_base_data.array_set('download_expiry', rt.call_method(var_product_mutated, 'get_download_expiry', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('external_url'))) {
			var_base_data.array_set('external_url', if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.external()])) { rt.call_method(var_product_mutated, 'get_product_url', [rt.new_string(context_mutated).clone()]) } else { rt.new_string('') })
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('button_text'))) {
			var_base_data.array_set('button_text', if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.external()])) { rt.call_method(var_product_mutated, 'get_button_text', [rt.new_string(context_mutated).clone()]) } else { rt.new_string('') })
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_status'))) {
			var_base_data.array_set('tax_status', rt.call_method(var_product_mutated, 'get_tax_status', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_class'))) {
			var_base_data.array_set('tax_class', rt.call_method(var_product_mutated, 'get_tax_class', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('manage_stock'))) {
			var_base_data.array_set('manage_stock', rt.call_method(var_product_mutated, 'managing_stock', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('stock_quantity'))) {
			var_base_data.array_set('stock_quantity', rt.call_method(var_product_mutated, 'get_stock_quantity', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('in_stock'))) {
			var_base_data.array_set('in_stock', rt.call_method(var_product_mutated, 'is_in_stock', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('backorders'))) {
			var_base_data.array_set('backorders', rt.call_method(var_product_mutated, 'get_backorders', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('backorders_allowed'))) {
			var_base_data.array_set('backorders_allowed', rt.call_method(var_product_mutated, 'backorders_allowed', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('backordered'))) {
			var_base_data.array_set('backordered', rt.call_method(var_product_mutated, 'is_on_backorder', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('low_stock_amount'))) {
			var_base_data.array_set('low_stock_amount', if rt.is_true(rt.identical(rt.new_string(''), rt.call_method(var_product_mutated, 'get_low_stock_amount', []rt.PhpVal{}))) { rt.new_null() } else { rt.call_method(var_product_mutated, 'get_low_stock_amount', []rt.PhpVal{}) })
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('sold_individually'))) {
			var_base_data.array_set('sold_individually', rt.call_method(var_product_mutated, 'is_sold_individually', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('weight'))) {
			var_base_data.array_set('weight', rt.call_method(var_product_mutated, 'get_weight', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('dimensions'))) {
			var_base_data.array_set('dimensions', rt.create_array([rt.ArrayItem{ key: 'length', val: rt.call_method(var_product_mutated, 'get_length', [rt.new_string(context_mutated).clone()]) }, rt.ArrayItem{ key: 'width', val: rt.call_method(var_product_mutated, 'get_width', [rt.new_string(context_mutated).clone()]) }, rt.ArrayItem{ key: 'height', val: rt.call_method(var_product_mutated, 'get_height', [rt.new_string(context_mutated).clone()]) }]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_required'))) {
			var_base_data.array_set('shipping_required', rt.call_method(var_product_mutated, 'needs_shipping', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_taxable'))) {
			var_base_data.array_set('shipping_taxable', rt.call_method(var_product_mutated, 'is_shipping_taxable', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_class'))) {
			var_base_data.array_set('shipping_class', rt.call_method(var_product_mutated, 'get_shipping_class', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('shipping_class_id'))) {
			var_base_data.array_set('shipping_class_id', rt.call_method(var_product_mutated, 'get_shipping_class_id', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('reviews_allowed'))) {
			var_base_data.array_set('reviews_allowed', rt.call_method(var_product_mutated, 'get_reviews_allowed', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('average_rating'))) {
			var_base_data.array_set('average_rating', if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context_mutated))) { rt.call_function('wc_format_decimal', [rt.call_method(var_product_mutated, 'get_average_rating', []rt.PhpVal{}), rt.new_int(2)]) } else { rt.call_method(var_product_mutated, 'get_average_rating', [rt.new_string(context_mutated).clone()]) })
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('rating_count'))) {
			var_base_data.array_set('rating_count', rt.call_method(var_product_mutated, 'get_rating_count', []rt.PhpVal{}))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('upsell_ids'))) {
			var_base_data.array_set('upsell_ids', rt.call_function('array_map', [rt.new_string('absint'), rt.call_method(var_product_mutated, 'get_upsell_ids', [rt.new_string(context_mutated).clone()])]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cross_sell_ids'))) {
			var_base_data.array_set('cross_sell_ids', rt.call_function('array_map', [rt.new_string('absint'), rt.call_method(var_product_mutated, 'get_cross_sell_ids', [rt.new_string(context_mutated).clone()])]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('parent_id'))) {
			var_base_data.array_set('parent_id', rt.call_method(var_product_mutated, 'get_parent_id', [rt.new_string(context_mutated).clone()]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('purchase_note'))) {
			var_base_data.array_set('purchase_note', if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context_mutated))) { rt.call_function('wpautop', [rt.call_function('do_shortcode', [rt.call_function('wp_kses_post', [rt.call_method(var_product_mutated, 'get_purchase_note', []rt.PhpVal{})])])]) } else { rt.call_method(var_product_mutated, 'get_purchase_note', [rt.new_string(context_mutated).clone()]) })
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('categories'))) {
			var_base_data.array_set('categories', this.get_taxonomy_terms(var_product_mutated.clone(), ''))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('brands'))) {
			var_base_data.array_set('brands', this.get_taxonomy_terms(var_product_mutated.clone(), 'brand'))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tags'))) {
			var_base_data.array_set('tags', this.get_taxonomy_terms(var_product_mutated.clone(), 'tag'))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('images'))) {
			var_base_data.array_set('images', this.get_images(var_product_mutated.clone()))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('attributes'))) {
			var_base_data.array_set('attributes', this.get_attributes(var_product_mutated.clone()))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('default_attributes'))) {
			var_base_data.array_set('default_attributes', this.get_default_attributes(var_product_mutated.clone()))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('variations'))) {
			var_base_data.array_set('variations', []rt.PhpVal{})
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('grouped_products'))) {
			var_base_data.array_set('grouped_products', []rt.PhpVal{})
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('menu_order'))) {
			var_base_data.array_set('menu_order', rt.call_method(var_product_mutated, 'get_menu_order', [rt.new_string(context_mutated).clone()]))
		}
	}
	mut var_data := rt.call_function('array_merge', [var_base_data.clone(), this.fetch_fields_using_getters(var_product_mutated.clone(), rt.new_string(context_mutated), var_fields.clone())])
	return var_data.clone()
}

fn (mut this Class_WC_REST_Products_V2_Controller) prepare_links(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_request_mutated := var_request
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base, rt.call_method(var_object_mutated, 'get_id', []rt.PhpVal{})])]) }, 'collection': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base])]) } }
	if rt.is_true(rt.call_method(var_object_mutated, 'get_parent_id', []rt.PhpVal{})) {
		var_links['up'] = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/products/%d'), this.namespace, rt.call_method(var_object_mutated, 'get_parent_id', []rt.PhpVal{})])]) }])
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_Products_V2_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_id := if var_request_mutated.array_isset(rt.new_string('id')) { rt.call_function('absint', [var_request_mutated.array_get(rt.new_string('id'))]) } else { rt.new_int(0) }
	if var_request_mutated.array_isset(rt.new_string('type')) {
		mut iife_temp_0 := Class_WC_Product_Factory{}
		mut iife_result_0 := iife_temp_0.get_classname_from_product_type(var_request_mutated.array_get(rt.new_string('type')))
		mut var_classname := iife_result_0
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [var_classname.clone()]))))) {
		var_classname = rt.new_string('WC_Product_Simple')
		}
	mut var_product := rt.create_object_dynamically(var_classname, [var_id.clone()])
	} else if var_request_mutated.array_isset(rt.new_string('id')) {
	var_product = rt.call_function('wc_get_product', [var_id.clone()])
	} else {
	var_product = create_wc_product_simple()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_method(var_product, 'get_type', []rt.PhpVal{}))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_invalid_'), this.post_type), rt.new_string('_id')), rt.call_function('__', [rt.new_string('To manipulate product variations you should use the /products/&lt;product_id&gt;/variations/&lt;id&gt; endpoint.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	if var_request_mutated.array_isset(rt.new_string('name')) {
		rt.call_method(var_product, 'set_name', [rt.call_function('wp_filter_post_kses', [var_request_mutated.array_get(rt.new_string('name'))])])
	}
	if var_request_mutated.array_isset(rt.new_string('description')) {
		rt.call_method(var_product, 'set_description', [rt.call_function('wp_filter_post_kses', [var_request_mutated.array_get(rt.new_string('description'))])])
	}
	if var_request_mutated.array_isset(rt.new_string('short_description')) {
		rt.call_method(var_product, 'set_short_description', [rt.call_function('wp_filter_post_kses', [var_request_mutated.array_get(rt.new_string('short_description'))])])
	}
	if var_request_mutated.array_isset(rt.new_string('status')) {
		rt.call_method(var_product, 'set_status', [if rt.is_true(rt.call_function('get_post_status_object', [var_request_mutated.array_get(rt.new_string('status'))])) { var_request_mutated.array_get(rt.new_string('status')) } else { Class_Automattic_WooCommerce_Enums_ProductStatus.draft() }])
	}
	if var_request_mutated.array_isset(rt.new_string('slug')) {
		rt.call_method(var_product, 'set_slug', [var_request_mutated.array_get(rt.new_string('slug'))])
	}
	if var_request_mutated.array_isset(rt.new_string('menu_order')) {
		rt.call_method(var_product, 'set_menu_order', [var_request_mutated.array_get(rt.new_string('menu_order'))])
	}
	if var_request_mutated.array_isset(rt.new_string('reviews_allowed')) {
		rt.call_method(var_product, 'set_reviews_allowed', [var_request_mutated.array_get(rt.new_string('reviews_allowed'))])
	}
	if var_request_mutated.array_isset(rt.new_string('virtual')) {
		rt.call_method(var_product, 'set_virtual', [var_request_mutated.array_get(rt.new_string('virtual'))])
	}
	if var_request_mutated.array_isset(rt.new_string('tax_status')) {
		rt.call_method(var_product, 'set_tax_status', [var_request_mutated.array_get(rt.new_string('tax_status'))])
	}
	if var_request_mutated.array_isset(rt.new_string('tax_class')) {
		rt.call_method(var_product, 'set_tax_class', [var_request_mutated.array_get(rt.new_string('tax_class'))])
	}
	if var_request_mutated.array_isset(rt.new_string('catalog_visibility')) {
		rt.call_method(var_product, 'set_catalog_visibility', [var_request_mutated.array_get(rt.new_string('catalog_visibility'))])
	}
	if var_request_mutated.array_isset(rt.new_string('purchase_note')) {
		rt.call_method(var_product, 'set_purchase_note', [rt.call_function('wp_kses_post', [rt.call_function('wp_unslash', [var_request_mutated.array_get(rt.new_string('purchase_note'))])])])
	}
	if var_request_mutated.array_isset(rt.new_string('featured')) {
		rt.call_method(var_product, 'set_featured', [var_request_mutated.array_get(rt.new_string('featured'))])
	}
	var_product = this.save_product_shipping_data(var_product.clone(), var_request_mutated.clone())
	if var_request_mutated.array_isset(rt.new_string('sku')) {
		rt.call_method(var_product, 'set_sku', [rt.call_function('wc_clean', [var_request_mutated.array_get(rt.new_string('sku'))])])
	}
	if var_request_mutated.array_isset(rt.new_string('attributes')) {
		mut var_attributes := []rt.PhpVal{}
		mut iter_9 := var_request_mutated.array_get(rt.new_string('attributes')).iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_attribute := item_9.val
			mut var_attribute_id := rt.new_int(0)
			mut var_attribute_name := rt.new_string('')
			if !(!rt.is_true(var_attribute.array_get(rt.new_string('id')))) {
			var_attribute_id = rt.call_function('absint', [var_attribute.array_get(rt.new_string('id'))])
			var_attribute_name = rt.call_function('wc_attribute_taxonomy_name_by_id', [var_attribute_id.clone()])
			} else if !(!rt.is_true(var_attribute.array_get(rt.new_string('name')))) {
			var_attribute_name = rt.call_function('wc_clean', [var_attribute.array_get(rt.new_string('name'))])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_id)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_name)))) {
				continue
			}
			if rt.is_true(var_attribute_id) {
				if var_attribute.array_isset(rt.new_string('options')) {
					mut var_options := var_attribute.array_get(rt.new_string('options'))
					if !(var_attribute.array_get(rt.new_string('options')).is_array()) {
					var_options = rt.call_function('explode', [rt.get_constant('WC_DELIMITER'), var_options.clone()])
					}
				mut var_values := rt.call_function('array_map', [rt.new_string('wc_sanitize_term_text_based'), var_options.clone()])
				var_values = rt.call_function('array_filter', [var_values.clone(), rt.new_string('strlen')])
				} else {
				var_values = []rt.PhpVal{}
				}
				if !(!rt.is_true(var_values)) {
					mut var_attribute_object := create_wc_product_attribute()
					var_attribute_object.set_id(var_attribute_id.clone())
					var_attribute_object.set_name(var_attribute_name.clone())
					var_attribute_object.set_options(var_values.clone())
					var_attribute_object.set_position(rt.new_string((if var_attribute.array_isset(rt.new_string('position')) { (rt.call_function('absint', [var_attribute.array_get(rt.new_string('position'))])).str() } else { '0' }).str()))
					var_attribute_object.set_visible(rt.new_int(if var_attribute.array_isset(rt.new_string('visible')) && rt.is_true(var_attribute.array_get(rt.new_string('visible'))) { 1 } else { 0 }))
					var_attribute_object.set_variation(rt.new_int(if var_attribute.array_isset(rt.new_string('variation')) && rt.is_true(var_attribute.array_get(rt.new_string('variation'))) { 1 } else { 0 }))
					var_attributes.array_push(var_attribute_object)
				}
			} else if var_attribute.array_isset(rt.new_string('options')) {
				if rt.is_true(rt.new_bool(var_attribute.array_get(rt.new_string('options')).is_array())) {
				var_values = var_attribute.array_get(rt.new_string('options'))
				} else {
				var_values = rt.call_function('explode', [rt.get_constant('WC_DELIMITER'), var_attribute.array_get(rt.new_string('options'))])
				}
				var_attribute_object = create_wc_product_attribute()
				var_attribute_object.set_name(var_attribute_name.clone())
				var_attribute_object.set_options(var_values.clone())
				var_attribute_object.set_position(rt.new_string((if var_attribute.array_isset(rt.new_string('position')) { (rt.call_function('absint', [var_attribute.array_get(rt.new_string('position'))])).str() } else { '0' }).str()))
				var_attribute_object.set_visible(rt.new_int(if var_attribute.array_isset(rt.new_string('visible')) && rt.is_true(var_attribute.array_get(rt.new_string('visible'))) { 1 } else { 0 }))
				var_attribute_object.set_variation(rt.new_int(if var_attribute.array_isset(rt.new_string('variation')) && rt.is_true(var_attribute.array_get(rt.new_string('variation'))) { 1 } else { 0 }))
				var_attributes.array_push(var_attribute_object)
			}
		}
		rt.call_method(var_product, 'set_attributes', [var_attributes.clone()])
	}
	if rt.is_true(rt.call_function('in_array', [rt.call_method(var_product, 'get_type', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.variable() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductType.grouped() }]), rt.new_bool(true)])) {
		rt.call_method(var_product, 'set_regular_price', [rt.new_string('')])
		rt.call_method(var_product, 'set_sale_price', [rt.new_string('')])
		rt.call_method(var_product, 'set_date_on_sale_to', [rt.new_string('')])
		rt.call_method(var_product, 'set_date_on_sale_from', [rt.new_string('')])
		rt.call_method(var_product, 'set_price', [rt.new_string('')])
	} else {
		if var_request_mutated.array_isset(rt.new_string('regular_price')) {
			rt.call_method(var_product, 'set_regular_price', [var_request_mutated.array_get(rt.new_string('regular_price'))])
		}
		if var_request_mutated.array_isset(rt.new_string('sale_price')) {
			rt.call_method(var_product, 'set_sale_price', [var_request_mutated.array_get(rt.new_string('sale_price'))])
		}
		if var_request_mutated.array_isset(rt.new_string('date_on_sale_from')) {
			rt.call_method(var_product, 'set_date_on_sale_from', [var_request_mutated.array_get(rt.new_string('date_on_sale_from'))])
		}
		if var_request_mutated.array_isset(rt.new_string('date_on_sale_from_gmt')) {
			rt.call_method(var_product, 'set_date_on_sale_from', [if rt.is_true(var_request_mutated.array_get(rt.new_string('date_on_sale_from_gmt'))) { rt.call_function('strtotime', [var_request_mutated.array_get(rt.new_string('date_on_sale_from_gmt'))]) } else { rt.new_null() }])
		}
		if var_request_mutated.array_isset(rt.new_string('date_on_sale_to')) {
			rt.call_method(var_product, 'set_date_on_sale_to', [var_request_mutated.array_get(rt.new_string('date_on_sale_to'))])
		}
		if var_request_mutated.array_isset(rt.new_string('date_on_sale_to_gmt')) {
			rt.call_method(var_product, 'set_date_on_sale_to', [if rt.is_true(var_request_mutated.array_get(rt.new_string('date_on_sale_to_gmt'))) { rt.call_function('strtotime', [var_request_mutated.array_get(rt.new_string('date_on_sale_to_gmt'))]) } else { rt.new_null() }])
		}
	}
	if var_request_mutated.array_isset(rt.new_string('parent_id')) {
		rt.call_method(var_product, 'set_parent_id', [var_request_mutated.array_get(rt.new_string('parent_id'))])
	}
	if var_request_mutated.array_isset(rt.new_string('sold_individually')) {
		rt.call_method(var_product, 'set_sold_individually', [var_request_mutated.array_get(rt.new_string('sold_individually'))])
	}
	if var_request_mutated.array_isset(rt.new_string('in_stock')) {
	mut var_stock_status := if rt.is_true(rt.identical(rt.new_bool(true), var_request_mutated.array_get(rt.new_string('in_stock')))) { Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock() } else { Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock() }
	} else {
	var_stock_status = rt.call_method(var_product, 'get_stock_status', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_manage_stock')]))) {
		if var_request_mutated.array_isset(rt.new_string('manage_stock')) {
			rt.call_method(var_product, 'set_manage_stock', [var_request_mutated.array_get(rt.new_string('manage_stock'))])
		}
		if var_request_mutated.array_isset(rt.new_string('backorders')) {
			rt.call_method(var_product, 'set_backorders', [var_request_mutated.array_get(rt.new_string('backorders'))])
		}
		if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.grouped()])) {
			rt.call_method(var_product, 'set_manage_stock', [rt.new_string('no')])
			rt.call_method(var_product, 'set_backorders', [rt.new_string('no')])
			rt.call_method(var_product, 'set_stock_quantity', [rt.new_string('')])
			rt.call_method(var_product, 'set_stock_status', [var_stock_status.clone()])
		} else if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.external()])) {
			rt.call_method(var_product, 'set_manage_stock', [rt.new_string('no')])
			rt.call_method(var_product, 'set_backorders', [rt.new_string('no')])
			rt.call_method(var_product, 'set_stock_quantity', [rt.new_string('')])
			rt.call_method(var_product, 'set_stock_status', [Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock()])
		} else if rt.is_true(rt.call_method(var_product, 'get_manage_stock', []rt.PhpVal{})) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()]))))) {
				rt.call_method(var_product, 'set_stock_status', [var_stock_status.clone()])
			}
			if var_request_mutated.array_isset(rt.new_string('stock_quantity')) {
				rt.call_method(var_product, 'set_stock_quantity', [rt.call_function('wc_stock_amount', [var_request_mutated.array_get(rt.new_string('stock_quantity'))])])
			} else if var_request_mutated.array_isset(rt.new_string('inventory_delta')) {
				mut var_stock_quantity := rt.call_function('wc_stock_amount', [rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{})])
				var_stock_quantity = rt.add(var_stock_quantity, rt.call_function('wc_stock_amount', [var_request_mutated.array_get(rt.new_string('inventory_delta'))]))
				rt.call_method(var_product, 'set_stock_quantity', [rt.call_function('wc_stock_amount', [var_stock_quantity.clone()])])
			}
		} else {
			rt.call_method(var_product, 'set_manage_stock', [rt.new_string('no')])
			rt.call_method(var_product, 'set_stock_quantity', [rt.new_string('')])
			rt.call_method(var_product, 'set_stock_status', [var_stock_status.clone()])
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()]))))) {
		rt.call_method(var_product, 'set_stock_status', [var_stock_status.clone()])
	}
	if var_request_mutated.array_isset(rt.new_string('upsell_ids')) {
		mut var_upsells := []rt.PhpVal{}
		mut var_ids := var_request_mutated.array_get(rt.new_string('upsell_ids'))
		if !(!rt.is_true(var_ids)) {
			mut iter_10 := var_ids.iterator()
			for {
				item_10 := iter_10.next() or { break }
				mut var_id_shadow := item_10.val
				if rt.is_true(var_id_shadow) && rt.is_true(rt.greater(var_id_shadow, rt.new_int(0))) {
					var_upsells << var_id_shadow.clone()
				}
			}
		}
		rt.call_method(var_product, 'set_upsell_ids', [rt.create_array_from_list(var_upsells)])
	}
	if var_request_mutated.array_isset(rt.new_string('cross_sell_ids')) {
		mut var_crosssells := []rt.PhpVal{}
		var_ids = var_request_mutated.array_get(rt.new_string('cross_sell_ids'))
		if !(!rt.is_true(var_ids)) {
			mut iter_11 := var_ids.iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_id_shadow := item_11.val
				if rt.is_true(var_id_shadow) && rt.is_true(rt.greater(var_id_shadow, rt.new_int(0))) {
					var_crosssells << var_id_shadow.clone()
				}
			}
		}
		rt.call_method(var_product, 'set_cross_sell_ids', [rt.create_array_from_list(var_crosssells)])
	}
	if var_request_mutated.array_isset(rt.new_string('categories')) && var_request_mutated.array_get(rt.new_string('categories')).is_array() {
	var_product = this.save_taxonomy_terms(var_product.clone(), var_request_mutated.array_get(rt.new_string('categories')), '')
	}
	if var_request_mutated.array_isset(rt.new_string('tags')) && var_request_mutated.array_get(rt.new_string('tags')).is_array() {
	var_product = this.save_taxonomy_terms(var_product.clone(), var_request_mutated.array_get(rt.new_string('tags')), 'tag')
	}
	if var_request_mutated.array_isset(rt.new_string('downloadable')) {
		rt.call_method(var_product, 'set_downloadable', [var_request_mutated.array_get(rt.new_string('downloadable'))])
	}
	if rt.is_true(rt.call_method(var_product, 'get_downloadable', []rt.PhpVal{})) {
		if var_request_mutated.array_isset(rt.new_string('downloads')) && var_request_mutated.array_get(rt.new_string('downloads')).is_array() {
		var_product = this.save_downloadable_files(var_product.clone(), var_request_mutated.array_get(rt.new_string('downloads')), 0)
		}
		if var_request_mutated.array_isset(rt.new_string('download_limit')) {
			rt.call_method(var_product, 'set_download_limit', [var_request_mutated.array_get(rt.new_string('download_limit'))])
		}
		if var_request_mutated.array_isset(rt.new_string('download_expiry')) {
			rt.call_method(var_product, 'set_download_expiry', [var_request_mutated.array_get(rt.new_string('download_expiry'))])
		}
	}
	if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.external()])) {
		if var_request_mutated.array_isset(rt.new_string('external_url')) {
			rt.call_method(var_product, 'set_product_url', [var_request_mutated.array_get(rt.new_string('external_url'))])
		}
		if var_request_mutated.array_isset(rt.new_string('button_text')) {
			rt.call_method(var_product, 'set_button_text', [var_request_mutated.array_get(rt.new_string('button_text'))])
		}
	}
	if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) {
	var_product = this.save_default_attributes(var_product.clone(), var_request_mutated.clone())
	}
	if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.grouped()])) && var_request_mutated.array_isset(rt.new_string('grouped_products')) {
		rt.call_method(var_product, 'set_children', [var_request_mutated.array_get(rt.new_string('grouped_products'))])
	}
	if var_request_mutated.array_isset(rt.new_string('images')) {
	var_product = this.set_product_images(var_product.clone(), var_request_mutated.array_get(rt.new_string('images')))
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
	mut iife_result_1 := iife_temp_1.update(var_request_mutated.array_get(rt.new_string('meta_data')), var_product.clone())
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_pre_insert_'), this.post_type), rt.new_string('_object')), var_product.clone(), var_request_mutated.clone(), rt.new_bool(creating)])
}

fn (mut this Class_WC_REST_Products_V2_Controller) set_product_images(var_product rt.PhpVal, var_images rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_images_mutated := var_images
	var_images_mutated = if var_images_mutated.clone().is_array() { rt.call_function('array_filter', [var_images_mutated.clone()]) } else { []rt.PhpVal{} }
	if !(!rt.is_true(var_images_mutated)) {
		mut var_gallery_positions := []rt.PhpVal{}
		mut iter_12 := var_images_mutated.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_image := item_12.val
			mut var_index := item_12.key
			mut var_attachment_id := if var_image.array_isset(rt.new_string('id')) { rt.call_function('absint', [var_image.array_get(rt.new_string('id'))]) } else { rt.new_int(0) }
			if rt.is_true(rt.identical(rt.new_int(0), var_attachment_id)) && var_image.array_isset(rt.new_string('src')) {
				mut var_upload := rt.call_function('wc_rest_upload_image_from_url', [rt.call_function('esc_url_raw', [var_image.array_get(rt.new_string('src'))])])
				if rt.is_true(rt.call_function('is_wp_error', [var_upload.clone()])) {
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_suppress_image_upload_error'), rt.new_bool(false), var_upload.clone(), rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}), var_images_mutated.clone()]))))) {
						rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_product_image_upload_error'), rt.call_method(var_upload, 'get_error_message', []rt.PhpVal{}), rt.new_int(400))))
					} else {
						continue
					}
				}
			var_attachment_id = rt.call_function('wc_rest_set_uploaded_image_as_attachment', [var_upload.clone(), rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_attachment_is_image', [var_attachment_id.clone()]))))) {
				rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_product_invalid_image_id'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('#%s is an invalid image ID.'), rt.new_string('woocommerce')]), var_attachment_id.clone()]), rt.new_int(400))))
			}
			var_gallery_positions.array_set(var_attachment_id, rt.call_function('absint', [if var_image.array_isset(rt.new_string('position')) { var_image.array_get(rt.new_string('position')) } else { var_index }]))
			if !(!rt.is_true(var_image.array_get(rt.new_string('alt')))) {
				rt.call_function('update_post_meta', [var_attachment_id.clone(), rt.new_string('_wp_attachment_image_alt'), rt.call_function('wc_clean', [var_image.array_get(rt.new_string('alt'))])])
			}
			if !(!rt.is_true(var_image.array_get(rt.new_string('name')))) {
				rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_attachment_id }, rt.ArrayItem{ key: 'post_title', val: var_image.array_get(rt.new_string('name')) }])])
			}
			if !(!rt.is_true(var_image.array_get(rt.new_string('src')))) {
				rt.call_function('update_post_meta', [var_attachment_id.clone(), rt.new_string('_wc_attachment_source'), rt.call_function('esc_url_raw', [var_image.array_get(rt.new_string('src'))])])
			}
		}
		rt.call_function('asort', [var_gallery_positions.clone()])
		mut var_gallery := rt.func_array_keys(var_gallery_positions.clone())
		mut var_image_id := rt.call_function('array_shift', [var_gallery.clone()])
		rt.call_method(var_product_mutated, 'set_image_id', [var_image_id.clone()])
		rt.call_method(var_product_mutated, 'set_gallery_image_ids', [var_gallery.clone()])
	} else {
		rt.call_method(var_product_mutated, 'set_image_id', [rt.new_string('')])
		rt.call_method(var_product_mutated, 'set_gallery_image_ids', [[]rt.PhpVal{}])
	}
	return var_product_mutated.clone()
}

fn (mut this Class_WC_REST_Products_V2_Controller) save_product_shipping_data(var_product rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_data_mutated := var_data
	if var_data_mutated.array_isset(rt.new_string('virtual')) && rt.is_true(rt.identical(rt.new_bool(true), var_data_mutated.array_get(rt.new_string('virtual')))) {
		rt.call_method(var_product_mutated, 'set_weight', [rt.new_string('')])
		rt.call_method(var_product_mutated, 'set_height', [rt.new_string('')])
		rt.call_method(var_product_mutated, 'set_length', [rt.new_string('')])
		rt.call_method(var_product_mutated, 'set_width', [rt.new_string('')])
	} else {
		if var_data_mutated.array_isset(rt.new_string('weight')) {
			rt.call_method(var_product_mutated, 'set_weight', [var_data_mutated.array_get(rt.new_string('weight'))])
		}
		if var_data_mutated.array_get(rt.new_string('dimensions')).array_isset(rt.new_string('height')) {
			rt.call_method(var_product_mutated, 'set_height', [var_data_mutated.array_get(rt.new_string('dimensions')).array_get(rt.new_string('height'))])
		}
		if var_data_mutated.array_get(rt.new_string('dimensions')).array_isset(rt.new_string('width')) {
			rt.call_method(var_product_mutated, 'set_width', [var_data_mutated.array_get(rt.new_string('dimensions')).array_get(rt.new_string('width'))])
		}
		if var_data_mutated.array_get(rt.new_string('dimensions')).array_isset(rt.new_string('length')) {
			rt.call_method(var_product_mutated, 'set_length', [var_data_mutated.array_get(rt.new_string('dimensions')).array_get(rt.new_string('length'))])
		}
	}
	if var_data_mutated.array_isset(rt.new_string('shipping_class')) {
		mut var_data_store := rt.call_method(var_product_mutated, 'get_data_store', []rt.PhpVal{})
		mut var_shipping_class_id := rt.call_method(var_data_store, 'get_shipping_class_id_by_slug', [rt.call_function('wc_clean', [var_data_mutated.array_get(rt.new_string('shipping_class'))])])
		rt.call_method(var_product_mutated, 'set_shipping_class_id', [var_shipping_class_id.clone()])
	}
	return var_product_mutated.clone()
}

fn (mut this Class_WC_REST_Products_V2_Controller) save_downloadable_files(var_product rt.PhpVal, var_downloads rt.PhpVal, deprecated i64) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_downloads_mutated := var_downloads
	if var_deprecated != 0 {
		rt.call_function('wc_deprecated_argument', [rt.new_string('variation_id'), rt.new_string('3.0'), rt.new_string('save_downloadable_files() not requires a variation_id anymore.')])
	}
	mut var_files := []rt.PhpVal{}
	mut iter_13 := var_downloads_mutated.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_file := item_13.val
		mut var_key := item_13.key
		if !rt.is_true(var_file.array_get(rt.new_string('file'))) {
			continue
		}
		mut var_download := create_wc_product_download()
		var_download.set_id(if !(!rt.is_true(var_file.array_get(rt.new_string('id')))) { var_file.array_get(rt.new_string('id')) } else { rt.call_function('wp_generate_uuid4', []rt.PhpVal{}) })
		var_download.set_name(if rt.is_true(var_file.array_get(rt.new_string('name'))) { var_file.array_get(rt.new_string('name')) } else { rt.call_function('wc_get_filename_from_url', [var_file.array_get(rt.new_string('file'))]) })
		var_download.set_file(rt.call_function('apply_filters', [rt.new_string('woocommerce_file_download_path'), var_file.array_get(rt.new_string('file')), var_product_mutated.clone(), var_key.clone()]))
		var_files << var_download
	}
	rt.call_method(var_product_mutated, 'set_downloads', [rt.create_array_from_list(var_files)])
	return var_product_mutated.clone()
}

fn (mut this Class_WC_REST_Products_V2_Controller) save_taxonomy_terms(var_product rt.PhpVal, var_terms rt.PhpVal, taxonomy string) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_terms_mutated := var_terms
	mut taxonomy_mutated := taxonomy
	mut var_term_ids := rt.call_function('wp_list_pluck', [var_terms_mutated.clone(), rt.new_string('id')])
	if rt.is_true(rt.identical(rt.new_string('cat'), rt.new_string(taxonomy_mutated))) {
		rt.call_method(var_product_mutated, 'set_category_ids', [var_term_ids.clone()])
	} else if rt.is_true(rt.identical(rt.new_string('tag'), rt.new_string(taxonomy_mutated))) {
		rt.call_method(var_product_mutated, 'set_tag_ids', [var_term_ids.clone()])
	}
	return var_product_mutated.clone()
}

fn (mut this Class_WC_REST_Products_V2_Controller) save_default_attributes(var_product rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_request_mutated := var_request
	if var_request_mutated.array_isset(rt.new_string('default_attributes')) && var_request_mutated.array_get(rt.new_string('default_attributes')).is_array() {
		mut var_attributes := rt.call_method(var_product_mutated, 'get_attributes', []rt.PhpVal{})
		mut var_default_attributes := []rt.PhpVal{}
		mut iter_14 := var_request_mutated.array_get(rt.new_string('default_attributes')).iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_attribute := item_14.val
			mut var_attribute_id := rt.new_int(0)
			mut var_attribute_name := rt.new_string('')
			if !(!rt.is_true(var_attribute.array_get(rt.new_string('id')))) {
			var_attribute_id = rt.call_function('absint', [var_attribute.array_get(rt.new_string('id'))])
			var_attribute_name = rt.call_function('wc_attribute_taxonomy_name_by_id', [var_attribute_id.clone()])
			} else if !(!rt.is_true(var_attribute.array_get(rt.new_string('name')))) {
			var_attribute_name = rt.call_function('sanitize_title', [var_attribute.array_get(rt.new_string('name'))])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_id)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_name)))) {
				continue
			}
			if var_attributes.array_isset(var_attribute_name) {
				mut var__attribute := var_attributes.array_get(var_attribute_name)
				if rt.is_true(var__attribute.array_get(rt.new_string('is_variation'))) {
					mut var_value := if var_attribute.array_isset(rt.new_string('option')) { rt.call_function('wc_clean', [rt.call_function('rawurldecode', [rt.call_function('stripslashes', [var_attribute.array_get(rt.new_string('option'))])])]) } else { rt.new_string('') }
					if !(!rt.is_true(var__attribute.array_get(rt.new_string('is_taxonomy')))) {
						mut var_term := rt.call_function('get_term_by', [rt.new_string('name'), var_value.clone(), var_attribute_name.clone()])
						if rt.is_true(var_term) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
						var_value = rt.get_property(var_term, 'slug')
						} else {
						var_value = rt.call_function('sanitize_title', [var_value.clone()])
						}
					}
					if rt.is_true(var_value) {
						var_default_attributes.array_set(var_attribute_name, var_value.clone())
					}
				}
			}
		}
		rt.call_method(var_product_mutated, 'set_default_attributes', [var_default_attributes.clone()])
	}
	return var_product_mutated.clone()
}

fn (mut this Class_WC_REST_Products_V2_Controller) clear_transients(var_object rt.PhpVal) {
	mut var_object_mutated := var_object
	rt.call_function('wc_delete_product_transients', [rt.call_method(var_object_mutated, 'get_id', []rt.PhpVal{})])
	rt.call_function('wp_cache_delete', [rt.new_string('product-' + (rt.call_method(var_object_mutated, 'get_id', []rt.PhpVal{})).str()), rt.new_string('products')])
}

fn (mut this Class_WC_REST_Products_V2_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_id := rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64())
	mut var_force := rt.new_bool((var_request_mutated.array_get(rt.new_string('force'))).to_bool())
	mut var_object := this.get_object(rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64()))
	mut var_result := rt.new_bool(false)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('Invalid ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_method(var_object, 'get_type', []rt.PhpVal{}))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_invalid_'), this.post_type), rt.new_string('_id')), rt.call_function('__', [rt.new_string('To manipulate product variations you should use the /products/&lt;product_id&gt;/variations/&lt;id&gt; endpoint.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_supports_trash := rt.new_bool(rt.is_true(rt.greater(rt.get_constant('EMPTY_TRASH_DAYS'), rt.new_int(0))) && rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_object }, rt.ArrayItem{ key: none, val: 'get_status' }])]))
	var_supports_trash = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_object_trashable')), var_supports_trash.clone(), var_object.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('delete'), rt.call_method(var_object, 'get_id', []rt.PhpVal{})]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.new_string('woocommerce_rest_user_cannot_delete_'), this.post_type), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete %s.'), rt.new_string('woocommerce')]), this.post_type]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))
	}
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_object_for_response(var_object.clone(), var_request_mutated.clone())
	if rt.is_true(var_force) {
		if rt.is_true(rt.call_method(var_object, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) {
			mut iter_15 := rt.call_method(var_object, 'get_children', []rt.PhpVal{}).iterator()
			for {
				item_15 := iter_15.next() or { break }
				mut var_child_id := item_15.val
				mut var_child := rt.call_function('wc_get_product', [var_child_id.clone()])
				if !(!rt.is_true(var_child)) {
					rt.call_method(var_child, 'delete', [rt.new_bool(true)])
				}
			}
		} else {
			mut iter_16 := rt.call_method(var_object, 'get_children', []rt.PhpVal{}).iterator()
			for {
				item_16 := iter_16.next() or { break }
				mut var_child_id := item_16.val
				mut var_child := rt.call_function('wc_get_product', [var_child_id.clone()])
				if !(!rt.is_true(var_child)) {
					rt.call_method(var_child, 'set_parent_id', [rt.new_int(0)])
					rt.call_method(var_child, 'save', []rt.PhpVal{})
				}
			}
		}
		rt.call_method(var_object, 'delete', [rt.new_bool(true)])
	var_result = rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_supports_trash)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_trash_not_supported'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s does not support trashing.'), rt.new_string('woocommerce')]), this.post_type]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
		}
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_object }, rt.ArrayItem{ key: none, val: 'get_status' }])])) {
			if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.trash(), rt.call_method(var_object, 'get_status', []rt.PhpVal{}))) {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_already_trashed'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s has already been deleted.'), rt.new_string('woocommerce')]), this.post_type]), rt.create_array([rt.ArrayItem{ key: 'status', val: 410 }])))
			}
			rt.call_method(var_object, 'delete', []rt.PhpVal{})
		var_result = rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.trash(), rt.call_method(var_object, 'get_status', []rt.PhpVal{}))
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

fn (mut this Class_WC_REST_Products_V2_Controller) get_item_schema() rt.PhpVal {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_2 := iife_temp_2.get_weight_unit_label(rt.call_function('get_option', [rt.new_string('woocommerce_weight_unit'), rt.new_string('kg')]))
	mut var_weight_unit_label := iife_result_2
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_3 := iife_temp_3.get_dimensions_unit_label(rt.call_function('get_option', [rt.new_string('woocommerce_dimension_unit'), rt.new_string('cm')]))
	mut var_dimension_unit_label := iife_result_3
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': this.post_type, 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'name': { 'description': rt.call_function('__', [rt.new_string('Product name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'slug': { 'description': rt.call_function('__', [rt.new_string('Product slug.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'permalink': { 'description': rt.call_function('__', [rt.new_string('Product URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'format': rt.new_string('uri'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_created': { 'description': rt.call_function('__', [rt.new_string('The date the product was created, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_created_gmt': { 'description': rt.call_function('__', [rt.new_string('The date the product was created, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_modified': { 'description': rt.call_function('__', [rt.new_string('The date the product was last modified, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_modified_gmt': { 'description': rt.call_function('__', [rt.new_string('The date the product was last modified, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'type': { 'description': rt.call_function('__', [rt.new_string('Product type.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'default': Class_Automattic_WooCommerce_Enums_ProductType.simple(), 'enum': rt.func_array_keys(rt.call_function('wc_get_product_types', []rt.PhpVal{})), 'context': map[string]rt.PhpVal{} }, 'status': { 'description': rt.call_function('__', [rt.new_string('Product status (post status).'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'default': rt.new_string('publish'), 'enum': rt.call_function('array_merge', [rt.func_array_keys(rt.call_function('get_post_statuses', []rt.PhpVal{})), map[string]rt.PhpVal{}]), 'context': map[string]rt.PhpVal{} }, 'featured': { 'description': rt.call_function('__', [rt.new_string('Featured product.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(false), 'context': map[string]rt.PhpVal{} }, 'catalog_visibility': { 'description': rt.call_function('__', [rt.new_string('Catalog visibility.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'default': Class_Automattic_WooCommerce_Enums_CatalogVisibility.visible(), 'enum': map[string]rt.PhpVal{}, 'context': map[string]rt.PhpVal{} }, 'description': { 'description': rt.call_function('__', [rt.new_string('Product description.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'short_description': { 'description': rt.call_function('__', [rt.new_string('Product short description.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'sku': { 'description': rt.call_function('__', [rt.new_string('Unique identifier.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'price': { 'description': rt.call_function('__', [rt.new_string('Current product price.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'regular_price': { 'description': rt.call_function('__', [rt.new_string('Product regular price.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'sale_price': { 'description': rt.call_function('__', [rt.new_string('Product sale price.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'date_on_sale_from': { 'description': rt.call_function('__', [rt.new_string('Start date of sale price, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{} }, 'date_on_sale_from_gmt': { 'description': rt.call_function('__', [rt.new_string('Start date of sale price, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{} }, 'date_on_sale_to': { 'description': rt.call_function('__', [rt.new_string('End date of sale price, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{} }, 'date_on_sale_to_gmt': { 'description': rt.call_function('__', [rt.new_string('End date of sale price, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{} }, 'price_html': { 'description': rt.call_function('__', [rt.new_string('Price formatted in HTML.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'on_sale': { 'description': rt.call_function('__', [rt.new_string('Shows if the product is on sale.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'purchasable': { 'description': rt.call_function('__', [rt.new_string('Shows if the product can be bought.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'total_sales': { 'description': rt.call_function('__', [rt.new_string('Amount of sales.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'virtual': { 'description': rt.call_function('__', [rt.new_string('If the product is virtual.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(false), 'context': map[string]rt.PhpVal{} }, 'downloadable': { 'description': rt.call_function('__', [rt.new_string('If the product is downloadable.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(false), 'context': map[string]rt.PhpVal{} }, 'downloads': { 'description': rt.call_function('__', [rt.new_string('List of downloadable files.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('File ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'name': { 'description': rt.call_function('__', [rt.new_string('File name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'file': { 'description': rt.call_function('__', [rt.new_string('File URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} } } } }, 'download_limit': { 'description': rt.call_function('__', [rt.new_string('Number of times downloadable files can be downloaded after purchase.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'default': -1, 'context': map[string]rt.PhpVal{} }, 'download_expiry': { 'description': rt.call_function('__', [rt.new_string('Number of days until access to downloadable files expires.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'default': -1, 'context': map[string]rt.PhpVal{} }, 'external_url': { 'description': rt.call_function('__', [rt.new_string('Product external URL. Only for external products.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'format': rt.new_string('uri'), 'context': map[string]rt.PhpVal{} }, 'button_text': { 'description': rt.call_function('__', [rt.new_string('Product external button text. Only for external products.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'tax_status': { 'description': rt.call_function('__', [rt.new_string('Tax status.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'default': Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), 'enum': map[string]rt.PhpVal{}, 'context': map[string]rt.PhpVal{} }, 'tax_class': { 'description': rt.call_function('__', [rt.new_string('Tax class.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'manage_stock': { 'description': rt.call_function('__', [rt.new_string('Stock management at product level.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(false), 'context': map[string]rt.PhpVal{} }, 'stock_quantity': { 'description': rt.call_function('__', [rt.new_string('Stock quantity.'), rt.new_string('woocommerce')]), 'type': if rt.is_true(rt.call_function('wc_is_stock_amount_integer', []rt.PhpVal{})) { 'integer' } else { 'number' }, 'context': map[string]rt.PhpVal{} }, 'in_stock': { 'description': rt.call_function('__', [rt.new_string('Controls whether or not the product is listed as "in stock" or "out of stock" on the frontend.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(true), 'context': map[string]rt.PhpVal{} }, 'backorders': { 'description': rt.call_function('__', [rt.new_string('If managing stock, this controls if backorders are allowed.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'default': rt.new_string('no'), 'enum': map[string]rt.PhpVal{}, 'context': map[string]rt.PhpVal{} }, 'backorders_allowed': { 'description': rt.call_function('__', [rt.new_string('Shows if backorders are allowed.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'backordered': { 'description': rt.call_function('__', [rt.new_string('Shows if the product is on backordered.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'sold_individually': { 'description': rt.call_function('__', [rt.new_string('Allow one item to be bought in a single order.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(false), 'context': map[string]rt.PhpVal{} }, 'weight': { 'description': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product weight (%s).'), rt.new_string('woocommerce')]), var_weight_unit_label.clone()]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'dimensions': { 'description': rt.call_function('__', [rt.new_string('Product dimensions.'), rt.new_string('woocommerce')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'properties': { 'length': { 'description': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product length (%s).'), rt.new_string('woocommerce')]), var_dimension_unit_label.clone()]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'width': { 'description': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product width (%s).'), rt.new_string('woocommerce')]), var_dimension_unit_label.clone()]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'height': { 'description': rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product height (%s).'), rt.new_string('woocommerce')]), var_dimension_unit_label.clone()]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} } } }, 'shipping_required': { 'description': rt.call_function('__', [rt.new_string('Shows if the product need to be shipped.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'shipping_taxable': { 'description': rt.call_function('__', [rt.new_string('Shows whether or not the product shipping is taxable.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'shipping_class': { 'description': rt.call_function('__', [rt.new_string('Shipping class slug.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'shipping_class_id': { 'description': rt.call_function('__', [rt.new_string('Shipping class ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'reviews_allowed': { 'description': rt.call_function('__', [rt.new_string('Allow reviews.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(true), 'context': map[string]rt.PhpVal{} }, 'average_rating': { 'description': rt.call_function('__', [rt.new_string('Reviews average rating.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'rating_count': { 'description': rt.call_function('__', [rt.new_string('Amount of reviews that the product have.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'related_ids': { 'description': rt.call_function('__', [rt.new_string('List of related products IDs.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'items': { 'type': rt.new_string('integer') }, 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'upsell_ids': { 'description': rt.call_function('__', [rt.new_string('List of up-sell products IDs.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'items': { 'type': rt.new_string('integer') }, 'context': map[string]rt.PhpVal{} }, 'cross_sell_ids': { 'description': rt.call_function('__', [rt.new_string('List of cross-sell products IDs.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'items': { 'type': rt.new_string('integer') }, 'context': map[string]rt.PhpVal{} }, 'parent_id': { 'description': rt.call_function('__', [rt.new_string('Product parent ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'purchase_note': { 'description': rt.call_function('__', [rt.new_string('Optional note to send the customer after purchase.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'categories': { 'description': rt.call_function('__', [rt.new_string('List of categories.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Category ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'name': { 'description': rt.call_function('__', [rt.new_string('Category name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'slug': { 'description': rt.call_function('__', [rt.new_string('Category slug.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } } }, 'tags': { 'description': rt.call_function('__', [rt.new_string('List of tags.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Tag ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'name': { 'description': rt.call_function('__', [rt.new_string('Tag name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'slug': { 'description': rt.call_function('__', [rt.new_string('Tag slug.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } } }, 'images': { 'description': rt.call_function('__', [rt.new_string('List of images.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Image ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'date_created': { 'description': rt.call_function('__', [rt.new_string('The date the image was created, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_created_gmt': { 'description': rt.call_function('__', [rt.new_string('The date the image was created, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_modified': { 'description': rt.call_function('__', [rt.new_string('The date the image was last modified, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_modified_gmt': { 'description': rt.call_function('__', [rt.new_string('The date the image was last modified, as GMT.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'src': { 'description': rt.call_function('__', [rt.new_string('Image URL.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'format': rt.new_string('uri'), 'context': map[string]rt.PhpVal{} }, 'name': { 'description': rt.call_function('__', [rt.new_string('Image name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'alt': { 'description': rt.call_function('__', [rt.new_string('Image alternative text.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'position': { 'description': rt.call_function('__', [rt.new_string('Image position. 0 means that the image is featured.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} } } } }, 'attributes': { 'description': rt.call_function('__', [rt.new_string('List of attributes.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Attribute ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'name': { 'description': rt.call_function('__', [rt.new_string('Attribute name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'position': { 'description': rt.call_function('__', [rt.new_string('Attribute position.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'visible': { 'description': rt.call_function('__', [rt.new_string('Define if the attribute is visible on the "Additional information" tab in the product\'s page.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(false), 'context': map[string]rt.PhpVal{} }, 'variation': { 'description': rt.call_function('__', [rt.new_string('Define if the attribute can be used as variation.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(false), 'context': map[string]rt.PhpVal{} }, 'options': { 'description': rt.call_function('__', [rt.new_string('List of available term names of the attribute.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('string') } } } } }, 'default_attributes': { 'description': rt.call_function('__', [rt.new_string('Defaults variation attributes.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Attribute ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'name': { 'description': rt.call_function('__', [rt.new_string('Attribute name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'option': { 'description': rt.call_function('__', [rt.new_string('Selected attribute term name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} } } } }, 'variations': { 'description': rt.call_function('__', [rt.new_string('List of variations IDs.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('integer') }, 'readonly': rt.new_bool(true) }, 'grouped_products': { 'description': rt.call_function('__', [rt.new_string('List of grouped products ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'items': { 'type': rt.new_string('integer') }, 'context': map[string]rt.PhpVal{} }, 'menu_order': { 'description': rt.call_function('__', [rt.new_string('Menu order, used to custom sort products.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'meta_data': { 'description': rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]), 'type': rt.new_string('array'), 'context': map[string]rt.PhpVal{}, 'items': { 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'key': { 'description': rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'value': { 'description': rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]), 'type': rt.new_string('mixed'), 'context': map[string]rt.PhpVal{} } } } } } }
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_CRUD_Controller.get_collection_params()
	var_params.array_get_mut('orderby').array_set('enum', rt.call_function('array_merge', [var_params.array_get(rt.new_string('orderby')).array_get(rt.new_string('enum')), rt.create_array([rt.ArrayItem{ key: none, val: 'menu_order' }])]))
	var_params.array_set('slug', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products with a specific slug.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('status', rt.create_array([rt.ArrayItem{ key: 'default', val: 'any' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products assigned a specific status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'any' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.future() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.trash() }]), rt.func_array_keys(rt.call_function('get_post_statuses', []rt.PhpVal{}))]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('type', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products assigned a specific type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('wc_get_product_types', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('sku', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products with specific SKU(s). Use commas to separate.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('featured', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to featured products.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_string_to_bool' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('category', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products assigned a specific category ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('tag', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products assigned a specific tag ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('shipping_class', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products assigned a specific shipping class ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('attribute', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products with a specific attribute. Use the taxonomy name/attribute slug.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('attribute_term', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products with a specific attribute term ID (required an assigned attribute).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	if rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{})) {
		mut iife_temp_4 := Class_WC_Tax{}
		mut iife_result_4 := iife_temp_4.get_tax_class_slugs()
		var_params.array_set('tax_class', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products with a specific tax class.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'standard' }]), iife_result_4]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	}
	var_params.array_set('in_stock', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products in stock or out of stock.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_string_to_bool' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('on_sale', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products on sale.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_string_to_bool' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('min_price', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products based on a minimum price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('max_price', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products based on a maximum price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('include_meta', rt.create_array([rt.ArrayItem{ key: 'default', val: []rt.PhpVal{} }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit meta_data to specific keys.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' }]))
	var_params.array_set('exclude_meta', rt.create_array([rt.ArrayItem{ key: 'default', val: []rt.PhpVal{} }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Ensure meta_data excludes specific keys.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' }]))
	return var_params.clone()
}

struct Class_WC_REST_CRUD_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

struct Class_WC_Product_Factory {
	rt.PhpObjectBase
}

struct Class_WC_Product_Simple {
	rt.PhpObjectBase
}

struct Class_WC_Product_Attribute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_MetaDataUtil {
	rt.PhpObjectBase
}

struct Class_WC_REST_Exception {
	rt.PhpObjectBase
}

struct Class_WC_Product_Download {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_I18nUtil {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_wc_rest_products_v2_controller() &Class_WC_REST_Products_V2_Controller {
	mut obj := &Class_WC_REST_Products_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v2')
		rest_base: rt.new_string('products')
		post_type: rt.new_string('product')
		hierarchical: rt.new_bool(true)
	}
	obj.construct()
	return obj
}

fn create_wc_rest_crud_controller(_args ...rt.PhpVal) &Class_WC_REST_CRUD_Controller {
	mut obj := &Class_WC_REST_CRUD_Controller{
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

fn create_wp_rest_request(_args ...rt.PhpVal) &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
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

fn create_wc_product_simple(_args ...rt.PhpVal) &Class_WC_Product_Simple {
	mut obj := &Class_WC_Product_Simple{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_attribute(_args ...rt.PhpVal) &Class_WC_Product_Attribute {
	mut obj := &Class_WC_Product_Attribute{
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

fn create_wc_product_download(_args ...rt.PhpVal) &Class_WC_Product_Download {
	mut obj := &Class_WC_Product_Download{
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

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Products_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_default_response_entity_type' {
			return rt.new_string(this.get_default_response_entity_type())
		}
		'get_hooks_relevant_to_caching' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_hooks_relevant_to_caching(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_data_for_etag' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_data_for_etag(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'remove_related_ids_from_response_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.remove_related_ids_from_response_data(mut dispatch_arg_0)
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_object(dispatch_arg_0)
		}
		'batch_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.batch_items(dispatch_arg_0)
		}
		'prepare_object_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_object_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_object_for_response_core' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_object_for_response_core(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'get_downloads' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_downloads(dispatch_arg_0)
		}
		'get_taxonomy_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_taxonomy_terms(dispatch_arg_0, dispatch_arg_1)
		}
		'get_images' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_images(dispatch_arg_0)
		}
		'get_attribute_taxonomy_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_attribute_taxonomy_label(dispatch_arg_0)
		}
		'get_attribute_taxonomy_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_attribute_taxonomy_name(dispatch_arg_0, dispatch_arg_1)
		}
		'get_default_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_default_attributes(dispatch_arg_0)
		}
		'get_attribute_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_attribute_options(dispatch_arg_0, dispatch_arg_1)
		}
		'get_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_attributes(dispatch_arg_0)
		}
		'api_get_price_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.api_get_price_html(dispatch_arg_0, dispatch_arg_1)
		}
		'api_get_related_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.api_get_related_ids(dispatch_arg_0, dispatch_arg_1)
		}
		'get_related_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_related_products(dispatch_arg_0)
		}
		'api_get_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.api_get_meta_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_product_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_product_data(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_object_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.prepare_object_for_database(dispatch_arg_0, dispatch_arg_1)
		}
		'set_product_images' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.set_product_images(dispatch_arg_0, dispatch_arg_1)
		}
		'save_product_shipping_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.save_product_shipping_data(dispatch_arg_0, dispatch_arg_1)
		}
		'save_downloadable_files' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.save_downloadable_files(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'save_taxonomy_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.save_taxonomy_terms(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'save_default_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.save_default_attributes(dispatch_arg_0, dispatch_arg_1)
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
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Products_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		'hierarchical' { return this.hierarchical }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Products_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'post_type' { this.post_type = val; return true }
		'hierarchical' { this.hierarchical = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Product_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Product_Simple) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Simple) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Simple) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_WC_Product_Download) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Download) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Download) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WC_REST_Products_V2_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_rest_products_v2_controller()
		return rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], obj)
	})
	rt.register_class_factory('WC_REST_CRUD_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_rest_crud_controller()
		return rt.new_object('WC_REST_CRUD_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Request', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_request()
		return rt.new_object('WP_REST_Request', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Factory', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_factory()
		return rt.new_object('WC_Product_Factory', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Simple', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_simple()
		return rt.new_object('WC_Product_Simple', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Attribute', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_attribute()
		return rt.new_object('WC_Product_Attribute', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_MetaDataUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_metadatautil()
		return rt.new_object('Automattic_WooCommerce_Utilities_MetaDataUtil', []string{}, obj)
	})
	rt.register_class_factory('WC_REST_Exception', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_rest_exception()
		return rt.new_object('WC_REST_Exception', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Download', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_download()
		return rt.new_object('WC_Product_Download', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_I18nUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_i18nutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_I18nUtil', []string{}, obj)
	})
	rt.register_class_factory('WC_Tax', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_tax()
		return rt.new_object('WC_Tax', []string{}, obj)
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
}
