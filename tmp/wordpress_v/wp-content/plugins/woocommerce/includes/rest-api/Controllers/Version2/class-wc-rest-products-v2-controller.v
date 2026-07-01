import rt

struct Class_WC_REST_Products_V2_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v2')
		rest_base rt.PhpVal = rt.new_string('products')
		post_type rt.PhpVal = rt.new_string('product')
		hierarchical rt.PhpVal = rt.new_bool(true)
}

fn (mut this Class_WC_REST_Products_V2_Controller) construct()  {
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
	{
		mut iter_1 := var_data_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_item.dup().is_array())) && var_item.array_isset(rt.new_string('related_ids')))) {
				var_data_mutated.array_get(var_key).array_unset(rt.new_string('related_ids'))
			}
		}
	}
	return rt.new_object('array', []string{}, var_data_mutated)
}

fn (mut this Class_WC_REST_Products_V2_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]), rt.create_array([rt.ArrayItem{ key: 'endpoint_id', val: 'get_products' }, rt.ArrayItem{ key: 'relevant_version_strings', val: rt.create_array([rt.ArrayItem{ key: none, val: 'list_products' }]) }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]), rt.create_array([rt.ArrayItem{ key: 'endpoint_id', val: 'get_product' }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass trash and force deletion.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/batch', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)/related', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_related_products' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }]) }])])
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_object(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	return rt.call_function('wc_get_product', [var_id_mutated.dup()])
}

fn (mut this Class_WC_REST_Products_V2_Controller) batch_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_already_deferred := rt.call_function('wp_defer_term_counting', []rt.PhpVal{})
	rt.call_function('wp_defer_term_counting', [rt.new_bool(true)])
	return this.Class_WC_REST_CRUD_Controller.batch_items(var_request_mutated.dup())
	unsafe { goto finally_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()

finally_label_1:
	rt.call_function('wp_defer_term_counting', [var_already_deferred.dup()])
	if rt.has_exception() { return rt.new_null() }

end_label_1:
	return rt.new_null()
}

fn (mut this Class_WC_REST_Products_V2_Controller) prepare_object_for_response(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_request_mutated := var_request
	mut var_context := if !(!rt.is_true(var_request_mutated.array_get('context'))) { var_request_mutated.array_get('context') } else { rt.new_string('view') }
	this.dispatch_set_prop('request', var_request_mutated.dup())
	mut var_data := this.prepare_object_for_response_core(var_object_mutated.dup(), var_request_mutated.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_object_mutated.dup(), var_request_mutated.dup())])
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_prepare_'), this.post_type), rt.new_string('_object')), var_response.dup(), var_object_mutated.dup(), var_request_mutated.dup()])
}

fn (mut this Class_WC_REST_Products_V2_Controller) prepare_object_for_response_core(var_object_data rt.PhpVal, var_request rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_context_mutated := var_context
	mut var_data := this.get_product_data(var_object_data.dup(), (var_context_mutated).str(), var_request_mutated.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_object_data, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) && rt.is_true(rt.call_method(var_object_data, 'has_child', []rt.PhpVal{})))) {
		var_data.array_set('variations', rt.call_method(var_object_data, 'get_children', []rt.PhpVal{}))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_object_data, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.grouped()])) && rt.is_true(rt.call_method(var_object_data, 'has_child', []rt.PhpVal{})))) {
		var_data.array_set('grouped_products', rt.call_method(var_object_data, 'get_children', []rt.PhpVal{}))
	}
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request_mutated.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context_mutated.dup())
	return var_data.dup()
}

fn (mut this Class_WC_REST_Products_V2_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_args := this.Class_WC_REST_CRUD_Controller.prepare_objects_query(var_request_mutated.dup())
	var_args.array_set('post_status', var_request_mutated.array_get('status'))
	mut var_tax_query := []rt.PhpVal{}
	mut var_taxonomies := { 'product_cat': 'category', 'product_tag': 'tag', 'product_shipping_class': 'shipping_class' }
	for var_taxonomy, var_key in var_taxonomies {
		if !(!rt.is_true(var_request_mutated.array_get(key))) {
			var_tax_query << rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: taxonomy }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'terms', val: var_request_mutated.array_get(key) }])
		}
	}
	if !(!rt.is_true(var_request_mutated.array_get('type'))) {
		var_tax_query << rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_type' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'terms', val: var_request_mutated.array_get('type') }])
	}
	if !(!rt.is_true(var_request_mutated.array_get('attribute'))) && !(!rt.is_true(var_request_mutated.array_get('attribute_term'))) {
		if rt.is_true(rt.call_function('in_array', [var_request_mutated.array_get('attribute'), rt.call_function('wc_get_attribute_taxonomy_names', []rt.PhpVal{}), rt.new_bool(true)])) {
			var_tax_query << rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_request_mutated.array_get('attribute') }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'terms', val: var_request_mutated.array_get('attribute_term') }])
		}
	}
	if !(!rt.is_true(var_tax_query)) {
		var_args.array_set('tax_query', var_tax_query.dup())
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(var_request_mutated.array_get('featured').is_bool())) {
		var_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'terms', val: 'featured' }, rt.ArrayItem{ key: 'operator', val: if rt.is_true(rt.identical(rt.new_bool(true), var_request_mutated.array_get('featured'))) { 'IN' } else { 'NOT IN' } }]))
	}
	if !(!rt.is_true(var_request_mutated.array_get('sku'))) {
		mut var_skus := rt.call_function('explode', [rt.new_string(','), var_request_mutated.array_get('sku')])
		if 1 < var_skus.dup().array_count() {
			var_skus.array_push(var_request_mutated.array_get('sku'))
		}
		var_args.array_set('meta_query', this.add_meta_query(var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_sku' }, rt.ArrayItem{ key: 'value', val: var_skus }, rt.ArrayItem{ key: 'compare', val: 'IN' }])))
	}
	if !(!rt.is_true(var_request_mutated.array_get('tax_class'))) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_tax_class' }, rt.ArrayItem{ key: 'value', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_request_mutated.array_get('tax_class') } else { rt.new_string('') } }])))
	}
	if !(!rt.is_true(var_request_mutated.array_get('min_price'))) || !(!rt.is_true(var_request_mutated.array_get('max_price'))) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.dup(), rt.call_function('wc_get_min_max_price_meta_query', [var_request_mutated.dup()])))
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(var_request_mutated.array_get('in_stock').is_bool())) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_stock_status' }, rt.ArrayItem{ key: 'value', val: if rt.is_true(rt.identical(rt.new_bool(true), var_request_mutated.array_get('in_stock'))) { Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock() } else { Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock() } }])))
	}
	if rt.is_true(rt.new_bool(var_request_mutated.array_get('on_sale').is_bool())) {
		mut var_on_sale_key := rt.new_string(if rt.is_true(var_request_mutated.array_get('on_sale')) { rt.new_string('post__in') } else { rt.new_string('post__not_in') })
		mut var_on_sale_ids := rt.call_function('wc_get_product_ids_on_sale', []rt.PhpVal{})
		var_on_sale_ids = if !rt.is_true(var_on_sale_ids) { rt.create_array([rt.ArrayItem{ key: none, val: 0 }]) } else { var_on_sale_ids }
		// unsupported expression: Expr_AssignOp_Plus
	}
	if !(!rt.is_true(var_request_mutated.array_get('sku'))) {
		var_args.array_set('post_type', rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]))
	} else {
		var_args.array_set('post_type', this.post_type)
	}
	return var_args.dup()
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_downloads(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_downloads := []rt.PhpVal{}
	if rt.is_true(rt.call_method(var_product_mutated, 'is_downloadable', []rt.PhpVal{})) {
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

fn (mut this Class_WC_REST_Products_V2_Controller) get_taxonomy_terms(var_product rt.PhpVal, taxonomy string) rt.PhpVal {
	mut var_product_mutated := var_product
	mut taxonomy_mutated := taxonomy
	mut var_terms := []rt.PhpVal{}
	{
		mut iter_1 := rt.call_function('wc_get_object_terms', [rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}), 'product_' + taxonomy_mutated]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			var_terms << rt.create_array([rt.ArrayItem{ key: 'id', val: rt.get_property(var_term, 'term_id') }, rt.ArrayItem{ key: 'name', val: rt.get_property(var_term, 'name') }, rt.ArrayItem{ key: 'slug', val: rt.get_property(var_term, 'slug') }])
		}
	}
	return var_terms.dup()
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_images(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_images := []rt.PhpVal{}
	mut var_attachment_ids := []rt.PhpVal{}
	if rt.is_true(rt.call_method(var_product_mutated, 'get_image_id', []rt.PhpVal{})) {
		var_attachment_ids.array_push(rt.call_method(var_product_mutated, 'get_image_id', []rt.PhpVal{}))
	}
	var_attachment_ids = rt.call_function('array_merge', [var_attachment_ids.dup(), rt.call_method(var_product_mutated, 'get_gallery_image_ids', []rt.PhpVal{})])
	if !(!rt.is_true(var_attachment_ids)) {
		rt.call_function('_prime_post_caches', [var_attachment_ids.dup()])
	}
	{
		mut iter_1 := var_attachment_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attachment_id := item_1.val
			mut var_position := item_1.key
			mut var_attachment_post := rt.call_function('get_post', [var_attachment_id.dup()])
			if rt.is_true(rt.new_bool(var_attachment_post.dup().is_null())) {
				continue
			}
			mut var_attachment := rt.call_function('wp_get_attachment_image_src', [var_attachment_id.dup(), rt.new_string('full')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_attachment.dup().is_array()))))) {
				continue
			}
			var_images.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment_post, 'post_date'), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('strtotime', [rt.get_property(var_attachment_post, 'post_date_gmt')])]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment_post, 'post_modified'), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('strtotime', [rt.get_property(var_attachment_post, 'post_modified_gmt')])]) }, rt.ArrayItem{ key: 'src', val: rt.call_function('current', [var_attachment.dup()]) }, rt.ArrayItem{ key: 'name', val: rt.call_function('get_the_title', [var_attachment_id.dup()]) }, rt.ArrayItem{ key: 'alt', val: rt.call_function('get_post_meta', [var_attachment_id.dup(), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'position', val: // unsupported expression: Expr_Cast_Int }]))
		}
	}
	if !rt.is_true(var_images) {
		var_images.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 0 }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('current_time', [rt.new_string('mysql')]), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('time', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('current_time', [rt.new_string('mysql')]), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('time', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'src', val: rt.call_function('wc_placeholder_img_src', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Placeholder'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'alt', val: rt.call_function('__', [rt.new_string('Placeholder'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'position', val: 0 }]))
	}
	return var_images.dup()
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_attribute_taxonomy_label(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
	mut var_tax := rt.call_function('get_taxonomy', [var_name_mutated.dup()])
	mut var_labels := rt.call_function('get_taxonomy_labels', [var_tax.dup()])
	return rt.get_property(var_labels, 'singular_name')
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_attribute_taxonomy_name(var_slug rt.PhpVal, var_product rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
	mut var_product_mutated := var_product
	var_slug_mutated = rt.call_function('wc_attribute_taxonomy_slug', [var_slug_mutated.dup()])
	mut var_attributes := rt.call_function('array_combine', [rt.call_function('array_map', [rt.new_string('wc_sanitize_taxonomy_name'), rt.func_array_keys(rt.call_method(var_product_mutated, 'get_attributes', []rt.PhpVal{}))]), rt.call_function('array_values', [rt.call_method(var_product_mutated, 'get_attributes', []rt.PhpVal{})])])
	mut var_attribute := rt.new_bool(rt.new_bool(false))
	if var_attributes.array_isset(rt.call_function('wc_attribute_taxonomy_name', [var_slug_mutated.dup()])) {
		var_attribute = var_attributes.array_get(rt.call_function('wc_attribute_taxonomy_name', [var_slug_mutated.dup()]))
	} else if var_attributes.array_isset(var_slug_mutated) {
		var_attribute = var_attributes.array_get(var_slug_mutated)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute)))) {
		return var_slug_mutated.dup()
	}
	if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{})) {
		mut var_taxonomy := rt.call_method(, 'get_taxonomy_object', []rt.PhpVal{})
		return rt.get_property(, 'attribute_label')
	}
	return rt.call_method(, 'get_name', []rt.PhpVal{})
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_default_attributes(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_attribute_options(var_product_id rt.PhpVal, var_attribute rt.PhpVal) rt.PhpVal {
	mut var_attribute_mutated := var_attribute
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_attributes(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
}

fn (mut this Class_WC_REST_Products_V2_Controller) api_get_price_html(var_product rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_context_mutated := var_context
}

fn (mut this Class_WC_REST_Products_V2_Controller) api_get_related_ids(var_product rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_context_mutated := var_context
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_related_products(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Products_V2_Controller) api_get_meta_data(var_product rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_context_mutated := var_context
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_product_data(var_product rt.PhpVal, context string) rt.PhpVal {
	mut var_product_mutated := var_product
	mut context_mutated := context
}

fn (mut this Class_WC_REST_Products_V2_Controller) prepare_links(var_object rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_object_mutated := var_object
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Products_V2_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Products_V2_Controller) set_product_images(var_product rt.PhpVal, var_images rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_images_mutated := var_images
}

fn (mut this Class_WC_REST_Products_V2_Controller) save_product_shipping_data(var_product rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_data_mutated := var_data
}

fn (mut this Class_WC_REST_Products_V2_Controller) save_downloadable_files(var_product rt.PhpVal, var_downloads rt.PhpVal, deprecated i64) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_downloads_mutated := var_downloads
}

fn (mut this Class_WC_REST_Products_V2_Controller) save_taxonomy_terms(var_product rt.PhpVal, var_terms rt.PhpVal, taxonomy string) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_terms_mutated := var_terms
	mut taxonomy_mutated := taxonomy
}

fn (mut this Class_WC_REST_Products_V2_Controller) save_default_attributes(var_product rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Products_V2_Controller) clear_transients(var_object rt.PhpVal)  {
	mut var_object_mutated := var_object
}

fn (mut this Class_WC_REST_Products_V2_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WC_REST_Products_V2_Controller) get_collection_params() rt.PhpVal {
}

struct Class_WC_REST_CRUD_Controller {
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

fn create_wc_rest_crud_controller() &Class_WC_REST_CRUD_Controller {
	mut obj := &Class_WC_REST_CRUD_Controller{
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


fn init_registry() {
	rt.register_class_factory('WC_REST_Products_V2_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_rest_products_v2_controller()
		return rt.new_object('WC_REST_Products_V2_Controller', ['WC_REST_CRUD_Controller'], obj)
	})
	rt.register_class_factory('WC_REST_CRUD_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_rest_crud_controller()
		return rt.new_object('WC_REST_CRUD_Controller', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version2_class_wc_rest_products_v2_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
