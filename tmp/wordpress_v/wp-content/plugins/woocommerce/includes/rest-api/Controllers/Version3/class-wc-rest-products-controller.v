import rt

struct Class_WC_REST_Products_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v3')
		search_sku_arg_value rt.PhpVal = rt.new_string('')
		search_name_or_sku_tokens rt.PhpVal = rt.new_null()
		search_fields_tokens rt.PhpVal = rt.new_null()
		suggested_products_ids rt.PhpVal = rt.new_array()
		exclude_status rt.PhpVal = rt.new_array()
		processed_attachment_ids_for_request rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_REST_Products_Controller) register_routes()  {
	this.Class_WC_REST_Products_V2_Controller.register_routes()
	rt.call_function('register_rest_route', [this.namespace, '/' + (rt.get_property(rt.new_object('WC_REST_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'rest_base')).str() + '/suggested-products', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_suggested_products' }]), rt.create_array([rt.ArrayItem{ key: 'endpoint_id', val: 'get_suggested_products' }, rt.ArrayItem{ key: 'relevant_version_strings', val: rt.create_array([rt.ArrayItem{ key: none, val: 'list_products' }]) }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_suggested_products_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (rt.get_property(rt.new_object('WC_REST_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'rest_base')).str() + '/(?P<id>[\\d]+)/duplicate', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'duplicate_product' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_Products_Controller) duplicate_product(var_request rt.PhpVal) rt.PhpVal {
	mut var_product_id := rt.call_method(var_request, 'get_param', [rt.new_string('id')])
	mut var_product := rt.call_function('wc_get_product', [var_product_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_product_invalid_id'), rt.call_function('__', [rt.new_string('Invalid product ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_updated_product := this.prepare_object_for_database(var_request.dup(), false)
	mut var_duplicated_product := rt.call_method(create_wc_admin_duplicate_product(), 'product_duplicate', [var_updated_product.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_duplicated_product.dup()])) {
		return create_wp_error(rt.new_string('woocommerce_rest_product_duplicate_error'), rt.call_method(var_duplicated_product, 'get_error_message', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_response_data := rt.call_method(var_duplicated_product, 'get_data', []rt.PhpVal{})
	return create_wp_rest_response(var_response_data.dup(), rt.new_int(200))
}

fn (mut this Class_WC_REST_Products_Controller) get_images(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_images := rt.new_array()
	mut var_attachment_ids := rt.new_array()
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
			mut var_attachment_post := rt.call_function('get_post', [var_attachment_id.dup()])
			if rt.is_true(rt.new_bool(var_attachment_post.dup().is_null())) {
				continue
			}
			mut var_attachment := rt.call_function('wp_get_attachment_image_src', [var_attachment_id.dup(), rt.new_string('full')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_attachment.dup().is_array()))))) {
				continue
			}
			mut var_thumbnail := rt.call_function('wp_get_attachment_image_src', [var_attachment_id.dup(), rt.new_string('woocommerce_thumbnail')])
			var_images.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment_post, 'post_date'), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('strtotime', [rt.get_property(var_attachment_post, 'post_date_gmt')])]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment_post, 'post_modified'), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('strtotime', [rt.get_property(var_attachment_post, 'post_modified_gmt')])]) }, rt.ArrayItem{ key: 'src', val: rt.call_function('current', [var_attachment.dup()]) }, rt.ArrayItem{ key: 'name', val: rt.call_function('get_the_title', [var_attachment_id.dup()]) }, rt.ArrayItem{ key: 'alt', val: rt.call_function('get_post_meta', [var_attachment_id.dup(), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'srcset', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'sizes', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'thumbnail', val: rt.call_function('current', [var_thumbnail.dup()]) }]))
		}
	}
	return var_images.dup()
}

fn (mut this Class_WC_REST_Products_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_REST_CRUD_Controller{}; return temp.prepare_objects_query(arg_0) }(var_request.dup())
	var_args.array_set('post_status', var_request.array_get('status'))
	if !(!rt.is_true(var_request.array_get('include_status'))) {
		var_args.array_set('post_status', var_request.array_get('include_status'))
	}
	if !(!rt.is_true(var_request.array_get('exclude_status'))) {
		this.exclude_status = var_request.array_get('exclude_status')
	} else {
		this.exclude_status = rt.new_array()
	}
	if var_request.array_isset(rt.new_string('downloadable')) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_downloadable' }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_bool_to_string', [var_request.array_get('downloadable')]) }])))
	}
	if var_request.array_isset(rt.new_string('virtual')) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_virtual' }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_bool_to_string', [var_request.array_get('virtual')]) }])))
	}
	mut var_tax_query := rt.new_array()
	mut var_taxonomies := { 'product_cat': 'category', 'product_tag': 'tag', 'product_shipping_class': 'shipping_class' }
	for var_taxonomy, var_key in var_taxonomies {
		if !(!rt.is_true(var_request.array_get(key))) {
			var_tax_query << rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: taxonomy }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'terms', val: var_request.array_get(key) }])
		}
	}
	mut var_terms := rt.new_array()
	if !(!rt.is_true(var_request.array_get('include_types'))) {
		var_terms = var_request.array_get('include_types')
	} else if !(!rt.is_true(var_request.array_get('type'))) {
		var_terms.array_push(var_request.array_get('type'))
	}
	if !(!rt.is_true(var_terms)) {
		var_tax_query << rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_type' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'terms', val: var_terms }])
	}
	if !(!rt.is_true(var_request.array_get('exclude_types'))) {
		var_tax_query << rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_type' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'terms', val: var_request.array_get('exclude_types') }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }])
	}
	if !(!rt.is_true(var_request.array_get('attribute'))) && !(!rt.is_true(var_request.array_get('attribute_term'))) {
		if rt.is_true(rt.call_function('in_array', [var_request.array_get('attribute'), rt.call_function('wc_get_attribute_taxonomy_names', []rt.PhpVal{}), rt.new_bool(true)])) {
			var_tax_query << rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_request.array_get('attribute') }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'terms', val: var_request.array_get('attribute_term') }])
		}
	}
	if !(!rt.is_true(var_tax_query)) {
		if !(!rt.is_true(var_args.array_get('tax_query'))) {
			var_args.array_set('tax_query', rt.call_function('array_merge', [var_tax_query.dup(), var_args.array_get('tax_query')]))
			// unsupported statement: Stmt_Nop
		} else {
			var_args.array_set('tax_query', var_tax_query.dup())
			// unsupported statement: Stmt_Nop
		}
	}
	if rt.is_true(rt.new_bool(var_request.array_get('featured').is_bool())) {
		var_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'terms', val: 'featured' }, rt.ArrayItem{ key: 'operator', val: if rt.is_true(rt.identical(rt.new_bool(true), var_request.array_get('featured'))) { 'IN' } else { 'NOT IN' } }]))
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_request.array_get('pos_products_only'))) {
		var_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'pos_product_visibility' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'terms', val: 'pos-hidden' }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }]))
	}
	mut var_search_fields := if !(var_request.array_get('search_fields')).is_null() { var_request.array_get('search_fields') } else { rt.new_array() }
	mut var_search_arg := rt.new_string(rt.new_string(if !(var_request.array_get('search')).is_null() { var_request.array_get('search') } else { rt.new_string('') }.to_string().trim_space()))
	if rt.is_true(rt.new_bool(rt.is_true(var_search_fields) && rt.is_true(var_search_arg))) {
		mut var_tokens := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(' '), var_search_arg.dup()])])])
		this.search_fields_tokens = rt.create_array([rt.ArrayItem{ key: 'fields', val: var_search_fields }, rt.ArrayItem{ key: 'tokens', val: var_tokens }])
		var_request.array_unset(rt.new_string('search'))
		var_request.array_unset(rt.new_string('search_sku'))
		var_request.array_unset(rt.new_string('sku'))
		var_request.array_unset(rt.new_string('search_name_or_sku'))
		var_args.array_unset(rt.new_string('s'))
	}
	mut var_search_name_or_sku_arg := if !(var_request.array_get('search_name_or_sku')).is_null() { var_request.array_get('search_name_or_sku') } else { rt.new_string('') }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_tokens = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(' '), var_search_name_or_sku_arg.dup()])])])
		this.search_name_or_sku_tokens = var_tokens.dup()
		var_request.array_unset(rt.new_string('search'))
		var_args.array_unset(rt.new_string('s'))
		var_request.array_unset(rt.new_string('search_sku'))
		var_request.array_unset(rt.new_string('sku'))
	} else if rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{})) {
		if !(!rt.is_true(var_request.array_get('search_sku'))) {
			this.search_sku_arg_value = var_request.array_get('search_sku')
			var_request.array_unset(rt.new_string('sku'))
		}
		if !(!rt.is_true(var_request.array_get('sku'))) {
			mut var_skus := rt.call_function('explode', [rt.new_string(','), var_request.array_get('sku')])
			if 1 < var_skus.dup().array_count() {
				var_skus.array_push(var_request.array_get('sku'))
			}
			var_args.array_set('meta_query', this.add_meta_query(var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_sku' }, rt.ArrayItem{ key: 'value', val: var_skus }, rt.ArrayItem{ key: 'compare', val: 'IN' }])))
		}
	}
	if !(!rt.is_true(var_request.array_get('global_unique_id'))) {
		mut var_global_unique_ids := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_request.array_get('global_unique_id')])])
		var_args.array_set('meta_query', this.add_meta_query(var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_global_unique_id' }, rt.ArrayItem{ key: 'value', val: var_global_unique_ids }, rt.ArrayItem{ key: 'compare', val: 'IN' }])))
	}
	if !(!rt.is_true(var_request.array_get('tax_class'))) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_tax_class' }, rt.ArrayItem{ key: 'value', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_request.array_get('tax_class') } else { rt.new_string('') } }])))
	}
	if !(!rt.is_true(var_request.array_get('min_price'))) || !(!rt.is_true(var_request.array_get('max_price'))) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.dup(), rt.call_function('wc_get_min_max_price_meta_query', [var_request.dup()])))
		// unsupported statement: Stmt_Nop
	}
	if !(!rt.is_true(var_request.array_get('stock_status'))) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_stock_status' }, rt.ArrayItem{ key: 'value', val: var_request.array_get('stock_status') }])))
	}
	if rt.is_true(rt.new_bool(var_request.array_get('on_sale').is_bool())) {
		mut var_on_sale_key := rt.new_string(if rt.is_true(var_request.array_get('on_sale')) { rt.new_string('post__in') } else { rt.new_string('post__not_in') })
		mut var_on_sale_ids := rt.call_function('wc_get_product_ids_on_sale', []rt.PhpVal{})
		var_on_sale_ids = if !rt.is_true(var_on_sale_ids) { rt.create_array([rt.ArrayItem{ key: none, val: 0 }]) } else { var_on_sale_ids }
		// unsupported expression: Expr_AssignOp_Plus
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_request.array_get('sku'))) || !(!rt.is_true(var_request.array_get('search_sku'))) || rt.is_true(this.search_name_or_sku_tokens))) || rt.is_true(this.search_fields_tokens))) {
		var_args.array_set('post_type', rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]))
	} else {
		var_args.array_set('post_type', rt.get_property(rt.new_object('WC_REST_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'post_type'))
	}
	mut var_ordering_args := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_catalog_ordering_args', [var_args.array_get('orderby'), var_args.array_get('order')])
	var_args.array_set('orderby', var_ordering_args.array_get('orderby'))
	var_args.array_set('order', var_ordering_args.array_get('order'))
	if rt.is_true(var_ordering_args.array_get('meta_key')) {
		var_args.array_set('meta_key', var_ordering_args.array_get('meta_key'))
		// unsupported statement: Stmt_Nop
	}
	if !(!rt.is_true(this.suggested_products_ids)) {
		var_args.array_set('post__in', this.suggested_products_ids)
	}
	if !(!rt.is_true(var_request.array_get('global_unique_id'))) {
		var_args.array_set('post_type', rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]))
	}
	return var_args.dup()
}

fn (mut this Class_WC_REST_Products_Controller) get_objects(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_add_search_criteria := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.search_sku_arg_value) || rt.is_true(this.search_name_or_sku_tokens))) || rt.is_true(this.search_fields_tokens)))
	if rt.is_true(var_add_search_criteria) {
		rt.call_function('add_filter', [rt.new_string('posts_join'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'add_search_criteria_to_wp_query_join' }])])
		rt.call_function('add_filter', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val:  }, rt.ArrayItem{ key: none, val:  }])])
	}
	if !(!rt.is_true(this.exclude_status)) {
		rt.call_function('add_filter', [, ])
	}
	mut var_result := 
	if rt.is_true() {
	}
	if !(!rt.is_true()) {
	}
	return .dup()
}

fn (mut this Class_WC_REST_Products_Controller) add_search_criteria_to_wp_query_join(var_join rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_REST_Products_Controller) add_search_criteria_to_wp_query_where(var_where rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_REST_Products_Controller) build_dynamic_search_clauses(var_tokens rt.PhpVal, var_fields rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_tokens_mutated := var_tokens
	mut var_fields_mutated := var_fields
}

fn (mut this Class_WC_REST_Products_Controller) exclude_product_statuses(var_where rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_REST_Products_Controller) set_product_images(var_product rt.PhpVal, var_images rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_images_mutated := var_images
}

fn (mut this Class_WC_REST_Products_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
}

fn (mut this Class_WC_REST_Products_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WC_REST_Products_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WC_REST_Products_Controller) get_suggested_products_collection_params() rt.PhpVal {
}

fn (mut this Class_WC_REST_Products_Controller) get_downloads(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
}

fn (mut this Class_WC_REST_Products_Controller) get_product_data(var_product rt.PhpVal, context string) rt.PhpVal {
	mut var_product_mutated := var_product
	mut context_mutated := context
}

fn (mut this Class_WC_REST_Products_Controller) get_suggested_products(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Products_Controller) prepare_object_for_response_core(var_object_data rt.PhpVal, var_request rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
}

fn (mut this Class_WC_REST_Products_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
}

struct Class_WC_REST_Products_V2_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Duplicate_Product {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_WC_REST_CRUD_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_products_controller() &Class_WC_REST_Products_Controller {
	mut obj := &Class_WC_REST_Products_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v3')
		search_sku_arg_value: rt.new_string('')
		search_name_or_sku_tokens: rt.new_null()
		search_fields_tokens: rt.new_null()
		suggested_products_ids: rt.new_array()
		exclude_status: rt.new_array()
		processed_attachment_ids_for_request: rt.new_array()
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

fn create_wc_admin_duplicate_product() &Class_WC_Admin_Duplicate_Product {
	mut obj := &Class_WC_Admin_Duplicate_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response() &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_rest_crud_controller() &Class_WC_REST_CRUD_Controller {
	mut obj := &Class_WC_REST_CRUD_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Products_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'duplicate_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.duplicate_product(dispatch_arg_0)
		}
		'get_images' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_images(dispatch_arg_0)
		}
		'prepare_objects_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_objects_query(dispatch_arg_0)
		}
		'get_objects' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_objects(dispatch_arg_0)
		}
		'add_search_criteria_to_wp_query_join' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_search_criteria_to_wp_query_join(dispatch_arg_0)
		}
		'add_search_criteria_to_wp_query_where' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_search_criteria_to_wp_query_where(dispatch_arg_0)
		}
		'build_dynamic_search_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.build_dynamic_search_clauses(dispatch_arg_0, dispatch_arg_1))
		}
		'exclude_product_statuses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.exclude_product_statuses(dispatch_arg_0))
		}
		'set_product_images' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.set_product_images(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_object_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.prepare_object_for_database(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_suggested_products_collection_params' {
			return this.get_suggested_products_collection_params()
		}
		'get_downloads' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_downloads(dispatch_arg_0)
		}
		'get_product_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_product_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_suggested_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_suggested_products(dispatch_arg_0)
		}
		'prepare_object_for_response_core' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.prepare_object_for_response_core(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Products_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'search_sku_arg_value' { return this.search_sku_arg_value }
		'search_name_or_sku_tokens' { return this.search_name_or_sku_tokens }
		'search_fields_tokens' { return this.search_fields_tokens }
		'suggested_products_ids' { return this.suggested_products_ids }
		'exclude_status' { return this.exclude_status }
		'processed_attachment_ids_for_request' { return this.processed_attachment_ids_for_request }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Products_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'search_sku_arg_value' { this.search_sku_arg_value = val; return true }
		'search_name_or_sku_tokens' { this.search_name_or_sku_tokens = val; return true }
		'search_fields_tokens' { this.search_fields_tokens = val; return true }
		'suggested_products_ids' { this.suggested_products_ids = val; return true }
		'exclude_status' { this.exclude_status = val; return true }
		'processed_attachment_ids_for_request' { this.processed_attachment_ids_for_request = val; return true }
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


fn (mut this Class_WC_Admin_Duplicate_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Duplicate_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Duplicate_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
	rt.register_class_factory('WC_REST_Products_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_rest_products_controller()
		return rt.new_object('WC_REST_Products_Controller', ['WC_REST_Products_V2_Controller'], obj)
	})
	rt.register_class_factory('WC_REST_Products_V2_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_rest_products_v2_controller()
		return rt.new_object('WC_REST_Products_V2_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
	rt.register_class_factory('WC_Admin_Duplicate_Product', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_admin_duplicate_product()
		return rt.new_object('WC_Admin_Duplicate_Product', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Response', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_response()
		return rt.new_object('WP_REST_Response', []string{}, obj)
	})
	rt.register_class_factory('WC_REST_CRUD_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_rest_crud_controller()
		return rt.new_object('WC_REST_CRUD_Controller', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_products_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
