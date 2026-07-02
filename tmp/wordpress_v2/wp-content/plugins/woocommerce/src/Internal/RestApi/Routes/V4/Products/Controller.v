import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller.sensitive_fields() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'cost_of_goods_sold' }, rt.ArrayItem{ key: none, val: 'downloads' }, rt.ArrayItem{ key: none, val: 'download_limit' }, rt.ArrayItem{ key: none, val: 'download_expiry' }, rt.ArrayItem{ key: none, val: 'meta_data' }, rt.ArrayItem{ key: none, val: 'purchase_note' }])
}
struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v4')
		search_sku_arg_value rt.PhpVal = rt.new_string('')
		search_name_or_sku_tokens rt.PhpVal = rt.new_null()
		search_fields_tokens rt.PhpVal = rt.new_null()
		suggested_products_ids rt.PhpVal = rt.new_array()
		exclude_status rt.PhpVal = rt.new_array()
		processed_attachment_ids_for_request rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) register_routes() {
	this.Class_WC_REST_Products_V2_Controller.register_routes()
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'rest_base')).str() + '/suggested-products'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_suggested_products' }]), rt.create_array([rt.ArrayItem{ key: 'endpoint_id', val: 'get_suggested_products' }, rt.ArrayItem{ key: 'relevant_version_strings', val: rt.create_array([rt.ArrayItem{ key: none, val: 'list_products' }]) }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_suggested_products_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'rest_base')).str() + '/(?P<id>[\\d]+)/duplicate'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'duplicate_product' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_object := this.get_object(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
	if rt.is_true(var_object) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_object, 'post_type'))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(var_object, 'post_type'))))) {
			return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
		}
		mut var_object_id := rt.call_method(var_object, 'get_id', []rt.PhpVal{})
		mut var_post_type_object := rt.call_function('get_post_type_object', [rt.get_property(var_object, 'post_type')])
		mut var_permission := rt.new_bool(false)
		if rt.is_true(rt.new_bool(rt.instance_of(var_post_type_object, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_WP_Post_Type'))) {
			var_permission = rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'read_private_posts'), var_object_id.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_permission)))) && rt.is_true(rt.identical(rt.new_string('publish'), rt.call_method(var_object, 'get_status', []rt.PhpVal{}))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_password_required', [var_object_id.clone()]))))) {
			var_permission = rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) && rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'read'), var_object_id.clone()])))
			}
		}
		var_permission = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_check_permissions'), var_permission.clone(), rt.new_string('read'), var_object_id.clone(), rt.get_property(var_object, 'post_type')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_permission)))) {
			return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) duplicate_product(var_request rt.PhpVal) rt.PhpVal {
	mut var_product_id := rt.call_method(var_request, 'get_param', [rt.new_string('id')])
	mut var_product := rt.call_function('wc_get_product', [var_product_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_product_invalid_id'), rt.call_function('__', [rt.new_string('Invalid product ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_updated_product := this.prepare_object_for_database(var_request.clone(), false)
	mut var_duplicated_product := rt.call_method(create_wc_admin_duplicate_product(), 'product_duplicate', [var_updated_product.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_duplicated_product.clone()])) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_product_duplicate_error'), rt.call_method(var_duplicated_product, 'get_error_message', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_response_data := rt.call_method(var_duplicated_product, 'get_data', []rt.PhpVal{})
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(var_response_data.clone(), rt.new_int(200)))
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) get_images(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_images := rt.new_array()
	mut var_attachment_ids := rt.new_array()
	if rt.is_true(rt.call_method(var_product_mutated, 'get_image_id', []rt.PhpVal{})) {
		var_attachment_ids.array_push(rt.call_method(var_product_mutated, 'get_image_id', []rt.PhpVal{}))
	}
	var_attachment_ids = rt.call_function('array_merge', [var_attachment_ids.clone(), rt.call_method(var_product_mutated, 'get_gallery_image_ids', []rt.PhpVal{})])
	mut iter_1 := var_attachment_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_attachment_id := item_1.val
		mut var_attachment_post := rt.call_function('get_post', [var_attachment_id.clone()])
		if rt.is_true(rt.new_bool(var_attachment_post.clone().is_null())) {
			continue
		}
		mut var_attachment := rt.call_function('wp_get_attachment_image_src', [var_attachment_id.clone(), rt.new_string('full')])
		if !(var_attachment.clone().is_array()) {
			continue
		}
		mut var_thumbnail := rt.call_function('wp_get_attachment_image_src', [var_attachment_id.clone(), rt.new_string('woocommerce_thumbnail')])
		var_images.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.new_int((var_attachment_id).to_i64()) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment_post, 'post_date'), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('strtotime', [rt.get_property(var_attachment_post, 'post_date_gmt')])]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment_post, 'post_modified'), rt.new_bool(false)]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('strtotime', [rt.get_property(var_attachment_post, 'post_modified_gmt')])]) }, rt.ArrayItem{ key: 'src', val: rt.call_function('current', [var_attachment.clone()]) }, rt.ArrayItem{ key: 'name', val: rt.call_function('get_the_title', [var_attachment_id.clone()]) }, rt.ArrayItem{ key: 'alt', val: rt.call_function('get_post_meta', [var_attachment_id.clone(), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'srcset', val: (rt.call_function('wp_get_attachment_image_srcset', [var_attachment_id.clone(), rt.new_string('full')])).str() }, rt.ArrayItem{ key: 'sizes', val: (rt.call_function('wp_get_attachment_image_sizes', [var_attachment_id.clone(), rt.new_string('full')])).str() }, rt.ArrayItem{ key: 'thumbnail', val: rt.call_function('current', [var_thumbnail.clone()]) }]))
	}
	return var_images.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) prepare_objects_query(var_request rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_WC_REST_CRUD_Controller{}
	mut iife_result_0 := iife_temp_0.prepare_objects_query(var_request.clone())
	mut var_args := iife_result_0
	var_args.array_set('post_status', var_request.array_get(rt.new_string('status')))
	if !(!rt.is_true(var_request.array_get(rt.new_string('include_status')))) {
		var_args.array_set('post_status', var_request.array_get(rt.new_string('include_status')))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('exclude_status')))) {
		this.exclude_status = var_request.array_get(rt.new_string('exclude_status'))
	} else {
		this.exclude_status = rt.new_array()
	}
	if var_request.array_isset(rt.new_string('downloadable')) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_downloadable' }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_bool_to_string', [var_request.array_get(rt.new_string('downloadable'))]) }])))
	}
	if var_request.array_isset(rt.new_string('virtual')) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_virtual' }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_bool_to_string', [var_request.array_get(rt.new_string('virtual'))]) }])))
	}
	mut var_tax_query := rt.new_array()
	mut var_taxonomies := rt.create_array([rt.ArrayItem{ key: 'product_cat', val: 'category' }, rt.ArrayItem{ key: 'product_tag', val: 'tag' }, rt.ArrayItem{ key: 'product_shipping_class', val: 'shipping_class' }])
	mut iter_2 := var_taxonomies.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_key := item_2.val
		mut var_taxonomy := item_2.key
		if !(!rt.is_true(var_request.array_get(var_key))) {
			var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'terms', val: var_request.array_get(var_key) }]))
		}
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('exclude_category')))) {
		var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_cat' }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'terms', val: var_request.array_get(rt.new_string('exclude_category')) }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }]))
	}
	mut var_terms := rt.new_array()
	if !(!rt.is_true(var_request.array_get(rt.new_string('include_types')))) {
	var_terms = var_request.array_get(rt.new_string('include_types'))
	} else if !(!rt.is_true(var_request.array_get(rt.new_string('type')))) {
		var_terms.array_push(var_request.array_get(rt.new_string('type')))
	}
	if !(!rt.is_true(var_terms)) {
		var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_type' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'terms', val: var_terms }]))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('exclude_types')))) {
		var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_type' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'terms', val: var_request.array_get(rt.new_string('exclude_types')) }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }]))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('attribute')))) && !(!rt.is_true(var_request.array_get(rt.new_string('attribute_term')))) {
		if rt.is_true(rt.call_function('in_array', [var_request.array_get(rt.new_string('attribute')), rt.call_function('wc_get_attribute_taxonomy_names', []rt.PhpVal{}), rt.new_bool(true)])) {
			var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_request.array_get(rt.new_string('attribute')) }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'terms', val: var_request.array_get(rt.new_string('attribute_term')) }]))
		}
	}
	if !(!rt.is_true(var_tax_query)) {
		if !(!rt.is_true(var_args.array_get(rt.new_string('tax_query')))) {
			var_args.array_set('tax_query', rt.call_function('array_merge', [var_tax_query.clone(), var_args.array_get(rt.new_string('tax_query'))]))
		} else {
			var_args.array_set('tax_query', var_tax_query.clone())
		}
	}
	if rt.is_true(rt.new_bool(var_request.array_get(rt.new_string('featured')).is_bool())) {
		var_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'terms', val: 'featured' }, rt.ArrayItem{ key: 'operator', val: if rt.is_true(rt.identical(rt.new_bool(true), var_request.array_get(rt.new_string('featured')))) { 'IN' } else { 'NOT IN' } }]))
	}
	mut var_search_fields := if !(var_request.array_get(rt.new_string('search_fields'))).is_null() { var_request.array_get(rt.new_string('search_fields')) } else { rt.new_array() }
	mut var_search_arg := rt.new_string(if !(var_request.array_get(rt.new_string('search'))).is_null() { var_request.array_get(rt.new_string('search')) } else { rt.new_string('') }.to_string().trim_space())
	if rt.is_true(var_search_fields) && rt.is_true(var_search_arg) {
		mut var_tokens := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(' '), var_search_arg.clone()])])])
		this.search_fields_tokens = rt.create_array([rt.ArrayItem{ key: 'fields', val: var_search_fields }, rt.ArrayItem{ key: 'tokens', val: var_tokens }])
		var_request.array_unset(rt.new_string('search'))
		var_request.array_unset(rt.new_string('search_sku'))
		var_request.array_unset(rt.new_string('sku'))
		var_request.array_unset(rt.new_string('search_name_or_sku'))
		var_args.array_unset(rt.new_string('s'))
	}
	mut var_search_name_or_sku_arg := if !(var_request.array_get(rt.new_string('search_name_or_sku'))).is_null() { var_request.array_get(rt.new_string('search_name_or_sku')) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_search_name_or_sku_arg)))) {
		var_tokens = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(' '), var_search_name_or_sku_arg.clone()])])])
		this.search_name_or_sku_tokens = var_tokens.clone()
		var_request.array_unset(rt.new_string('search'))
		var_args.array_unset(rt.new_string('s'))
		var_request.array_unset(rt.new_string('search_sku'))
		var_request.array_unset(rt.new_string('sku'))
	} else if rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{})) {
		if !(!rt.is_true(var_request.array_get(rt.new_string('search_sku')))) {
			this.search_sku_arg_value = var_request.array_get(rt.new_string('search_sku'))
			var_request.array_unset(rt.new_string('sku'))
		}
		if !(!rt.is_true(var_request.array_get(rt.new_string('sku')))) {
			mut var_skus := rt.call_function('explode', [rt.new_string(','), var_request.array_get(rt.new_string('sku'))])
			if 1 < var_skus.clone().array_count() {
				var_skus.array_push(var_request.array_get(rt.new_string('sku')))
			}
			var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_sku' }, rt.ArrayItem{ key: 'value', val: var_skus }, rt.ArrayItem{ key: 'compare', val: 'IN' }])))
		}
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
	if !(!rt.is_true(var_request.array_get(rt.new_string('stock_status')))) {
		var_args.array_set('meta_query', this.add_meta_query(var_args.clone(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_stock_status' }, rt.ArrayItem{ key: 'value', val: var_request.array_get(rt.new_string('stock_status')) }])))
	}
	if rt.is_true(rt.new_bool(var_request.array_get(rt.new_string('on_sale')).is_bool())) {
		mut var_on_sale_key := rt.new_string((if rt.is_true(var_request.array_get(rt.new_string('on_sale'))) { 'post__in' } else { 'post__not_in' }).str())
		mut var_on_sale_ids := rt.call_function('wc_get_product_ids_on_sale', []rt.PhpVal{})
		var_on_sale_ids = if !rt.is_true(var_on_sale_ids) { rt.create_array([rt.ArrayItem{ key: none, val: 0 }]) } else { var_on_sale_ids }
		var_args.array_get(var_on_sale_key) = rt.add(var_args.array_get(var_on_sale_key), var_on_sale_ids)
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('sku')))) || !(!rt.is_true(var_request.array_get(rt.new_string('search_sku')))) || rt.is_true(this.search_name_or_sku_tokens) || rt.is_true(this.search_fields_tokens) {
		var_args.array_set('post_type', rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]))
	} else {
		var_args.array_set('post_type', rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'post_type'))
	}
	mut var_ordering_args := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_catalog_ordering_args', [var_args.array_get(rt.new_string('orderby')), var_args.array_get(rt.new_string('order'))])
	var_args.array_set('orderby', var_ordering_args.array_get(rt.new_string('orderby')))
	var_args.array_set('order', var_ordering_args.array_get(rt.new_string('order')))
	if rt.is_true(var_ordering_args.array_get(rt.new_string('meta_key'))) {
		var_args.array_set('meta_key', var_ordering_args.array_get(rt.new_string('meta_key')))
	}
	if !(!rt.is_true(this.suggested_products_ids)) {
		var_args.array_set('post__in', this.suggested_products_ids)
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('global_unique_id')))) {
		var_args.array_set('post_type', rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]))
	}
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) get_objects(var_query_args rt.PhpVal) rt.PhpVal {
	mut var_add_search_criteria := rt.new_bool(rt.is_true(this.search_sku_arg_value) || rt.is_true(this.search_name_or_sku_tokens) || rt.is_true(this.search_fields_tokens))
	if rt.is_true(var_add_search_criteria) {
		rt.call_function('add_filter', [rt.new_string('posts_join'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'add_search_criteria_to_wp_query_join' }])])
		rt.call_function('add_filter', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'add_search_criteria_to_wp_query_where' }])])
	}
	if !(!rt.is_true(this.exclude_status)) {
		rt.call_function('add_filter', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'exclude_product_statuses' }])])
	}
	mut var_result := this.Class_WC_REST_Products_V2_Controller.get_objects(var_query_args.clone())
	if rt.is_true(var_add_search_criteria) {
		rt.call_function('remove_filter', [rt.new_string('posts_join'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'add_search_criteria_to_wp_query_join' }])])
		rt.call_function('remove_filter', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'add_search_criteria_to_wp_query_where' }])])
		this.search_sku_arg_value = rt.new_string('')
		this.search_name_or_sku_tokens = rt.new_null()
		this.search_fields_tokens = rt.new_null()
	}
	if !(!rt.is_true(this.exclude_status)) {
		rt.call_function('remove_filter', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'exclude_product_statuses' }])])
		this.exclude_status = rt.new_array()
	}
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) add_search_criteria_to_wp_query_join(var_join rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.call_function('strstr', [var_join.clone(), rt.new_string('wc_product_meta_lookup')])) {
		return var_join.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.search_fields_tokens)))) && rt.is_true(rt.new_bool(!(rt.is_true(this.search_sku_arg_value)))) && !(rt.is_true(this.search_name_or_sku_tokens) && rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{}))) {
		return var_join.clone()
	}
	var_join = rt.concat(var_join, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb, 'wc_product_meta_lookup')), rt.new_string(' wc_product_meta_lookup\n\t\t\t\t\t\tON ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID = wc_product_meta_lookup.product_id ')))
	return var_join.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) add_search_criteria_to_wp_query_where(var_where rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.is_true(this.search_fields_tokens) {
		var_where = rt.concat(var_where, this.build_dynamic_search_clauses(this.search_fields_tokens.array_get(rt.new_string('tokens')), this.search_fields_tokens.array_get(rt.new_string('fields'))))
	} else if rt.is_true(this.search_name_or_sku_tokens) {
		mut var_searchable_fields := if rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{})) { rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'sku' }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: 'name' }]) }
		var_where = rt.concat(var_where, this.build_dynamic_search_clauses(this.search_name_or_sku_tokens, var_searchable_fields.clone()))
	} else if !(!rt.is_true(this.search_sku_arg_value)) {
		mut var_like_search := rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [this.search_sku_arg_value])).str() + '%')
		var_where = rt.concat(var_where, rt.new_string(' AND ' + (rt.call_method(var_wpdb, 'prepare', [rt.new_string('(wc_product_meta_lookup.sku LIKE %s)'), var_like_search.clone()])).str()))
	}
	return var_where.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) build_dynamic_search_clauses(var_tokens rt.PhpVal, var_fields rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_tokens_mutated := var_tokens
	mut var_fields_mutated := var_fields
	if !rt.is_true(var_fields_mutated) || !rt.is_true(var_tokens_mutated) {
		return ''
	}
	mut var_column_map := rt.create_array([rt.ArrayItem{ key: 'name', val: rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_title')) }, rt.ArrayItem{ key: 'sku', val: 'wc_product_meta_lookup.sku' }, rt.ArrayItem{ key: 'global_unique_id', val: 'wc_product_meta_lookup.global_unique_id' }, rt.ArrayItem{ key: 'description', val: rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_content')) }, rt.ArrayItem{ key: 'short_description', val: rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_excerpt')) }])
	mut var_field_clauses := rt.new_array()
	mut iter_3 := var_tokens_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_token := item_3.val
		mut var_like_search := rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [var_token.clone()])).str() + '%')
		mut var_field_token_clauses := rt.new_array()
		mut iter_4 := var_fields_mutated.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_field := item_4.val
			if !(var_column_map.array_isset(var_field)) {
				continue
			}
			mut var_db_column := var_column_map.array_get(var_field)
			var_field_token_clauses.array_push(rt.call_method(var_wpdb, 'prepare', [rt.new_string("(${var_db_column.to_string()} LIKE %s)"), var_like_search.clone()]))
		}
		if rt.is_true(var_field_token_clauses) {
			var_field_clauses.array_push('(' + (rt.call_function('implode', [rt.new_string(' OR '), var_field_token_clauses.clone()])).str() + ')')
		}
	}
	return if rt.is_true(var_field_clauses) { ' AND (' + (rt.call_function('implode', [rt.new_string(' AND '), var_field_clauses.clone()])).str() + ')' } else { '' }
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) exclude_product_statuses(var_where rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	if !(!rt.is_true(this.exclude_status)) && this.exclude_status.is_array() {
		mut var_not_in := rt.new_array()
		mut iter_5 := this.exclude_status.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_status_to_exclude := item_5.val
			var_not_in.array_push(rt.call_method(var_wpdb, 'prepare', [rt.new_string('%s'), var_status_to_exclude.clone()]))
		}
		var_not_in = rt.call_function('join', [rt.new_string(', '), var_not_in.clone()])
		return (var_where).str() + rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_status NOT IN ( ')), var_not_in), rt.new_string(' )'))
	}
	return (var_where).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) set_product_images(var_product rt.PhpVal, var_images rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_images_mutated := var_images
	var_images_mutated = if var_images_mutated.clone().is_array() { rt.call_function('array_filter', [var_images_mutated.clone()]) } else { rt.new_array() }
	if !(!rt.is_true(var_images_mutated)) {
		mut var_gallery := rt.new_array()
		mut iter_6 := var_images_mutated.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_image := item_6.val
			mut var_index := item_6.key
			mut var_attachment_id := if var_image.array_isset(rt.new_string('id')) { rt.call_function('absint', [var_image.array_get(rt.new_string('id'))]) } else { rt.new_int(0) }
			mut var_is_new_upload := rt.new_bool(false)
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
			var_is_new_upload = rt.new_bool(true)
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_attachment_is_image', [var_attachment_id.clone()]))))) {
				rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_product_invalid_image_id'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('#%s is an invalid image ID.'), rt.new_string('woocommerce')]), var_attachment_id.clone()]), rt.new_int(400))))
			}
			if rt.is_true(var_is_new_upload) && rt.is_true(rt.greater(var_attachment_id, rt.new_int(0))) {
				this.processed_attachment_ids_for_request.array_push(var_attachment_id.clone())
			}
			mut var_featured_image := rt.call_method(var_product_mutated, 'get_image_id', []rt.PhpVal{})
			if rt.is_true(rt.identical(rt.new_int(0), var_index)) {
				rt.call_method(var_product_mutated, 'set_image_id', [var_attachment_id.clone()])
				rt.call_function('wc_product_attach_featured_image', [var_attachment_id.clone(), var_product_mutated.clone(), rt.new_bool(false)])
			} else {
				var_gallery.array_push(var_attachment_id.clone())
			}
			if !(!rt.is_true(var_image.array_get(rt.new_string('alt')))) {
				rt.call_function('update_post_meta', [var_attachment_id.clone(), rt.new_string('_wp_attachment_image_alt'), rt.call_function('wc_clean', [var_image.array_get(rt.new_string('alt'))])])
			}
			if !(!rt.is_true(var_image.array_get(rt.new_string('name')))) {
				rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_attachment_id }, rt.ArrayItem{ key: 'post_title', val: var_image.array_get(rt.new_string('name')) }])])
			}
		}
		rt.call_method(var_product_mutated, 'set_gallery_image_ids', [var_gallery.clone()])
	} else {
		rt.call_method(var_product_mutated, 'set_image_id', [rt.new_string('')])
		rt.call_method(var_product_mutated, 'set_gallery_image_ids', [rt.new_array()])
	}
	return var_product_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) prepare_object_for_database(var_request rt.PhpVal, creating bool) rt.PhpVal {
	mut var_id := if var_request.array_isset(rt.new_string('id')) { rt.call_function('absint', [var_request.array_get(rt.new_string('id'))]) } else { rt.new_int(0) }
	if var_request.array_isset(rt.new_string('type')) {
		mut iife_temp_1 := Class_WC_Product_Factory{}
		mut iife_result_1 := iife_temp_1.get_classname_from_product_type(var_request.array_get(rt.new_string('type')))
		mut var_classname := iife_result_1
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [var_classname.clone()]))))) {
		var_classname = rt.new_string('WC_Product_Simple')
		}
	mut var_product := rt.create_object_dynamically(var_classname, [var_id.clone()])
	} else if var_request.array_isset(rt.new_string('id')) {
	var_product = rt.call_function('wc_get_product', [var_id.clone()])
	} else {
	var_product = create_wc_product_simple()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_method(var_product, 'get_type', []rt.PhpVal{}))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_invalid_'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'post_type')), rt.new_string('_id')), rt.call_function('__', [rt.new_string('To manipulate product variations you should use the /products/&lt;product_id&gt;/variations/&lt;id&gt; endpoint.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	if var_request.array_isset(rt.new_string('name')) {
		rt.call_method(var_product, 'set_name', [rt.call_function('wp_filter_post_kses', [var_request.array_get(rt.new_string('name'))])])
	}
	if var_request.array_isset(rt.new_string('description')) {
		rt.call_method(var_product, 'set_description', [rt.call_function('wp_filter_post_kses', [var_request.array_get(rt.new_string('description'))])])
	}
	if var_request.array_isset(rt.new_string('short_description')) {
		rt.call_method(var_product, 'set_short_description', [rt.call_function('wp_filter_post_kses', [var_request.array_get(rt.new_string('short_description'))])])
	}
	if var_request.array_isset(rt.new_string('status')) {
		rt.call_method(var_product, 'set_status', [if rt.is_true(rt.call_function('get_post_status_object', [var_request.array_get(rt.new_string('status'))])) { var_request.array_get(rt.new_string('status')) } else { Class_Automattic_WooCommerce_Enums_ProductStatus.draft() }])
	}
	if var_request.array_isset(rt.new_string('slug')) {
		rt.call_method(var_product, 'set_slug', [var_request.array_get(rt.new_string('slug'))])
	}
	if var_request.array_isset(rt.new_string('menu_order')) {
		rt.call_method(var_product, 'set_menu_order', [var_request.array_get(rt.new_string('menu_order'))])
	}
	if var_request.array_isset(rt.new_string('reviews_allowed')) {
		rt.call_method(var_product, 'set_reviews_allowed', [var_request.array_get(rt.new_string('reviews_allowed'))])
	}
	if var_request.array_isset(rt.new_string('post_password')) {
		rt.call_method(var_product, 'set_post_password', [var_request.array_get(rt.new_string('post_password'))])
	}
	if var_request.array_isset(rt.new_string('virtual')) {
		rt.call_method(var_product, 'set_virtual', [var_request.array_get(rt.new_string('virtual'))])
	}
	if var_request.array_isset(rt.new_string('tax_status')) {
		rt.call_method(var_product, 'set_tax_status', [var_request.array_get(rt.new_string('tax_status'))])
	}
	if var_request.array_isset(rt.new_string('tax_class')) {
		rt.call_method(var_product, 'set_tax_class', [var_request.array_get(rt.new_string('tax_class'))])
	}
	if var_request.array_isset(rt.new_string('catalog_visibility')) {
		rt.call_method(var_product, 'set_catalog_visibility', [var_request.array_get(rt.new_string('catalog_visibility'))])
	}
	if var_request.array_isset(rt.new_string('purchase_note')) {
		rt.call_method(var_product, 'set_purchase_note', [rt.call_function('wp_kses_post', [rt.call_function('wp_unslash', [var_request.array_get(rt.new_string('purchase_note'))])])])
	}
	if var_request.array_isset(rt.new_string('featured')) {
		rt.call_method(var_product, 'set_featured', [var_request.array_get(rt.new_string('featured'))])
	}
	var_product = this.save_product_shipping_data(var_product.clone(), var_request.clone())
	if var_request.array_isset(rt.new_string('sku')) {
		rt.call_method(var_product, 'set_sku', [rt.call_function('wc_clean', [var_request.array_get(rt.new_string('sku'))])])
	}
	if var_request.array_isset(rt.new_string('global_unique_id')) {
		rt.call_method(var_product, 'set_global_unique_id', [rt.call_function('wc_clean', [var_request.array_get(rt.new_string('global_unique_id'))])])
	}
	if var_request.array_isset(rt.new_string('attributes')) {
		mut var_attributes := rt.new_array()
		mut iter_7 := var_request.array_get(rt.new_string('attributes')).iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_attribute := item_7.val
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
				var_values = rt.new_array()
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
		if var_request.array_isset(rt.new_string('regular_price')) {
			rt.call_method(var_product, 'set_regular_price', [var_request.array_get(rt.new_string('regular_price'))])
		}
		if var_request.array_isset(rt.new_string('sale_price')) {
			rt.call_method(var_product, 'set_sale_price', [var_request.array_get(rt.new_string('sale_price'))])
		}
		if var_request.array_isset(rt.new_string('date_on_sale_from')) {
			rt.call_method(var_product, 'set_date_on_sale_from', [var_request.array_get(rt.new_string('date_on_sale_from'))])
		}
		if var_request.array_isset(rt.new_string('date_on_sale_from_gmt')) {
			rt.call_method(var_product, 'set_date_on_sale_from', [if rt.is_true(var_request.array_get(rt.new_string('date_on_sale_from_gmt'))) { rt.call_function('strtotime', [var_request.array_get(rt.new_string('date_on_sale_from_gmt'))]) } else { rt.new_null() }])
		}
		if var_request.array_isset(rt.new_string('date_on_sale_to')) {
			rt.call_method(var_product, 'set_date_on_sale_to', [var_request.array_get(rt.new_string('date_on_sale_to'))])
		}
		if var_request.array_isset(rt.new_string('date_on_sale_to_gmt')) {
			rt.call_method(var_product, 'set_date_on_sale_to', [if rt.is_true(var_request.array_get(rt.new_string('date_on_sale_to_gmt'))) { rt.call_function('strtotime', [var_request.array_get(rt.new_string('date_on_sale_to_gmt'))]) } else { rt.new_null() }])
		}
	}
	if var_request.array_isset(rt.new_string('parent_id')) {
		rt.call_method(var_product, 'set_parent_id', [var_request.array_get(rt.new_string('parent_id'))])
	}
	if var_request.array_isset(rt.new_string('sold_individually')) {
		rt.call_method(var_product, 'set_sold_individually', [var_request.array_get(rt.new_string('sold_individually'))])
	}
	if var_request.array_isset(rt.new_string('stock_status')) {
	mut var_stock_status := var_request.array_get(rt.new_string('stock_status'))
	} else {
	var_stock_status = rt.call_method(var_product, 'get_stock_status', []rt.PhpVal{})
	}
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_manage_stock')]))) {
		if var_request.array_isset(rt.new_string('manage_stock')) {
			rt.call_method(var_product, 'set_manage_stock', [var_request.array_get(rt.new_string('manage_stock'))])
		}
		if var_request.array_isset(rt.new_string('backorders')) {
			rt.call_method(var_product, 'set_backorders', [var_request.array_get(rt.new_string('backorders'))])
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
			if var_request.array_isset(rt.new_string('stock_quantity')) {
				rt.call_method(var_product, 'set_stock_quantity', [rt.call_function('wc_stock_amount', [var_request.array_get(rt.new_string('stock_quantity'))])])
			} else if var_request.array_isset(rt.new_string('inventory_delta')) {
				mut var_stock_quantity := rt.call_function('wc_stock_amount', [rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{})])
				var_stock_quantity = rt.add(var_stock_quantity, rt.call_function('wc_stock_amount', [var_request.array_get(rt.new_string('inventory_delta'))]))
				rt.call_method(var_product, 'set_stock_quantity', [rt.call_function('wc_stock_amount', [var_stock_quantity.clone()])])
			}
			if rt.is_true(rt.new_bool(rt.call_method(var_request, 'get_params', []rt.PhpVal{}).array_isset(rt.new_string('low_stock_amount')))) {
				if rt.is_true(rt.identical(rt.new_null(), var_request.array_get(rt.new_string('low_stock_amount')))) {
					rt.call_method(var_product, 'set_low_stock_amount', [rt.new_string('')])
				} else {
					rt.call_method(var_product, 'set_low_stock_amount', [rt.call_function('wc_stock_amount', [var_request.array_get(rt.new_string('low_stock_amount'))])])
				}
			}
		} else {
			rt.call_method(var_product, 'set_manage_stock', [rt.new_string('no')])
			rt.call_method(var_product, 'set_stock_quantity', [rt.new_string('')])
			rt.call_method(var_product, 'set_stock_status', [var_stock_status.clone()])
			rt.call_method(var_product, 'set_low_stock_amount', [rt.new_string('')])
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()]))))) {
		rt.call_method(var_product, 'set_stock_status', [var_stock_status.clone()])
	}
	if var_request.array_isset(rt.new_string('upsell_ids')) {
		mut var_upsells := rt.new_array()
		mut var_ids := var_request.array_get(rt.new_string('upsell_ids'))
		if !(!rt.is_true(var_ids)) {
			mut iter_8 := var_ids.iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_id_shadow := item_8.val
				if rt.is_true(var_id_shadow) && rt.is_true(rt.greater(var_id_shadow, rt.new_int(0))) {
					var_upsells.array_push(var_id_shadow.clone())
				}
			}
		}
		rt.call_method(var_product, 'set_upsell_ids', [var_upsells.clone()])
	}
	if var_request.array_isset(rt.new_string('cross_sell_ids')) {
		mut var_crosssells := rt.new_array()
		var_ids = var_request.array_get(rt.new_string('cross_sell_ids'))
		if !(!rt.is_true(var_ids)) {
			mut iter_9 := var_ids.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_id_shadow := item_9.val
				if rt.is_true(var_id_shadow) && rt.is_true(rt.greater(var_id_shadow, rt.new_int(0))) {
					var_crosssells.array_push(var_id_shadow.clone())
				}
			}
		}
		rt.call_method(var_product, 'set_cross_sell_ids', [var_crosssells.clone()])
	}
	if var_request.array_isset(rt.new_string('categories')) && var_request.array_get(rt.new_string('categories')).is_array() {
	var_product = this.save_taxonomy_terms(var_product.clone(), var_request.array_get(rt.new_string('categories')))
	}
	if var_request.array_isset(rt.new_string('tags')) && var_request.array_get(rt.new_string('tags')).is_array() {
		mut var_new_tags := rt.new_array()
		mut iter_10 := var_request.array_get(rt.new_string('tags')).iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_tag := item_10.val
			if !(var_tag.array_isset(rt.new_string('name'))) {
				var_new_tags.array_push(var_tag.clone())
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('term_exists', [var_tag.array_get(rt.new_string('name')), rt.new_string('product_tag')]))))) {
				mut var_term := rt.call_function('wp_insert_term', [var_tag.array_get(rt.new_string('name')), rt.new_string('product_tag')])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
					var_new_tags.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: var_term.array_get(rt.new_string('term_id')) }]))
					continue
				}
			} else {
				var_new_tags.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.get_property(rt.call_function('get_term_by', [rt.new_string('name'), var_tag.array_get(rt.new_string('name')), rt.new_string('product_tag')]), 'term_id') }]))
			}
		}
	var_product = this.save_taxonomy_terms(var_product.clone(), var_new_tags.clone(), rt.new_string('tag'))
	}
	if var_request.array_isset(rt.new_string('downloadable')) {
		rt.call_method(var_product, 'set_downloadable', [var_request.array_get(rt.new_string('downloadable'))])
	}
	if rt.is_true(rt.call_method(var_product, 'get_downloadable', []rt.PhpVal{})) {
		if var_request.array_isset(rt.new_string('downloads')) && var_request.array_get(rt.new_string('downloads')).is_array() {
		var_product = this.save_downloadable_files(var_product.clone(), var_request.array_get(rt.new_string('downloads')))
		}
		if var_request.array_isset(rt.new_string('download_limit')) {
			rt.call_method(var_product, 'set_download_limit', [var_request.array_get(rt.new_string('download_limit'))])
		}
		if var_request.array_isset(rt.new_string('download_expiry')) {
			rt.call_method(var_product, 'set_download_expiry', [var_request.array_get(rt.new_string('download_expiry'))])
		}
	}
	if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.external()])) {
		if var_request.array_isset(rt.new_string('external_url')) {
			rt.call_method(var_product, 'set_product_url', [var_request.array_get(rt.new_string('external_url'))])
		}
		if var_request.array_isset(rt.new_string('button_text')) {
			rt.call_method(var_product, 'set_button_text', [var_request.array_get(rt.new_string('button_text'))])
		}
	}
	if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) {
	var_product = this.save_default_attributes(var_product.clone(), var_request.clone())
	}
	if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.grouped()])) && var_request.array_isset(rt.new_string('grouped_products')) {
		rt.call_method(var_product, 'set_children', [var_request.array_get(rt.new_string('grouped_products'))])
	}
	if var_request.array_isset(rt.new_string('images')) {
	var_product = this.set_product_images(var_product.clone(), var_request.array_get(rt.new_string('images')))
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_MetaDataUtil{}
	mut iife_result_2 := iife_temp_2.update(var_request.array_get(rt.new_string('meta_data')), var_product.clone())
	if !(!rt.is_true(var_request.array_get(rt.new_string('date_created')))) {
		mut var_date := rt.call_function('rest_parse_date', [var_request.array_get(rt.new_string('date_created'))])
		if rt.is_true(var_date) {
			rt.call_method(var_product, 'set_date_created', [var_date.clone()])
		}
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('date_created_gmt')))) {
		var_date = rt.call_function('rest_parse_date', [var_request.array_get(rt.new_string('date_created_gmt')), rt.new_bool(true)])
		if rt.is_true(var_date) {
			rt.call_method(var_product, 'set_date_created', [var_date.clone()])
		}
	}
	if rt.is_true(this.cogs_is_enabled()) {
		this.set_cogs_info_in_product_object(var_request.clone(), var_product.clone())
	}
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_pre_insert_'), rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'post_type')), rt.new_string('_object')), var_product.clone(), var_request.clone(), rt.new_bool(creating)])
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) get_item_schema() rt.PhpVal {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_3 := iife_temp_3.get_weight_unit_label(rt.call_function('get_option', [rt.new_string('woocommerce_weight_unit'), rt.new_string('kg')]))
	mut var_weight_unit_label := iife_result_3
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_4 := iife_temp_4.get_dimensions_unit_label(rt.call_function('get_option', [rt.new_string('woocommerce_dimension_unit'), rt.new_string('cm')]))
	mut var_dimension_unit_label := iife_result_4
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'post_type') }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product slug.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'permalink', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product URL.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_created', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the product was created, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the product was created, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_modified', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the product was last modified, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the product was last modified, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: Class_Automattic_WooCommerce_Enums_ProductType.simple() }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('wc_get_product_types', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product status (post status).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: Class_Automattic_WooCommerce_Enums_ProductStatus.publish() }, rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [rt.func_array_keys(rt.call_function('get_post_statuses', []rt.PhpVal{})), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.future() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.auto_draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.trash() }])]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'featured', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Featured product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'catalog_visibility', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Catalog visibility.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: Class_Automattic_WooCommerce_Enums_CatalogVisibility.visible() }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_CatalogVisibility.visible() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_CatalogVisibility.catalog() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_CatalogVisibility.search() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_CatalogVisibility.hidden() }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product description.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'short_description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product short description.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'sku', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stock Keeping Unit.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'global_unique_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('GTIN, UPC, EAN or ISBN.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'price', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Current product price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'regular_price', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product regular price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'sale_price', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product sale price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_on_sale_from', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Start date of sale price, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_on_sale_from_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Start date of sale price, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_on_sale_to', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('End date of sale price, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_on_sale_to_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('End date of sale price, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'price_html', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Price formatted in HTML.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'on_sale', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shows if the product is on sale.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'purchasable', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shows if the product can be bought.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'total_sales', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Amount of sales.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'virtual', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If the product is virtual.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'downloadable', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If the product is downloadable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'downloads', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of downloadable files.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('File ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('File name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'file', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('File URL.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'download_limit', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of times downloadable files can be downloaded after purchase.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: -1 }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'download_expiry', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of days until access to downloadable files expires.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: -1 }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'external_url', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product external URL. Only for external products.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'button_text', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product external button text. Only for external products.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'tax_status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.shipping() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.none() }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'tax_class', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tax class.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'manage_stock', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stock management at product level.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'stock_quantity', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stock quantity.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: if rt.is_true(rt.call_function('wc_is_stock_amount_integer', []rt.PhpVal{})) { 'integer' } else { 'number' } }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'stock_status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Controls the stock status of the product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock() }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'backorders', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If managing stock, this controls if backorders are allowed.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: 'no' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'no' }, rt.ArrayItem{ key: none, val: 'notify' }, rt.ArrayItem{ key: none, val: 'yes' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'backorders_allowed', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shows if backorders are allowed.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'backordered', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shows if the product is on backordered.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'low_stock_amount', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Low Stock amount for the product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'integer' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'sold_individually', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Allow one item to be bought in a single order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'weight', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product weight (%s).'), rt.new_string('woocommerce')]), var_weight_unit_label.clone()]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'dimensions', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product dimensions.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'length', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product length (%s).'), rt.new_string('woocommerce')]), var_dimension_unit_label.clone()]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'width', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product width (%s).'), rt.new_string('woocommerce')]), var_dimension_unit_label.clone()]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'height', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product height (%s).'), rt.new_string('woocommerce')]), var_dimension_unit_label.clone()]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'shipping_required', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shows if the product need to be shipped.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'shipping_taxable', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shows whether or not the product shipping is taxable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'shipping_class', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping class slug.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'shipping_class_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shipping class ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'reviews_allowed', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Allow reviews.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'post_password', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Post password.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'average_rating', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Reviews average rating.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'rating_count', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Amount of reviews that the product have.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'related_ids', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of related products IDs.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'upsell_ids', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of up-sell products IDs.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'cross_sell_ids', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of cross-sell products IDs.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'parent_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product parent ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'purchase_note', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Optional note to send the customer after purchase.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'categories', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of categories.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Category ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Category name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Category slug.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }, rt.ArrayItem{ key: 'brands', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of brands.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Brand ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Brand name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Brand slug.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }, rt.ArrayItem{ key: 'tags', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of tags.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tag ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tag name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tag slug.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }, rt.ArrayItem{ key: 'images', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of images.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Image ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'date_created', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the image was created, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the image was created, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_modified', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the image was last modified, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the image was last modified, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'src', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Image URL.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Image name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'alt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Image alternative text.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'has_options', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shows if the product needs to be configured before it can be bought.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of attributes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Attribute ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Attribute name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'position', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Attribute position.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'visible', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Define if the attribute is visible on the "Additional information" tab in the product\'s page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'variation', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Define if the attribute can be used as variation.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of available term names of the attribute.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'default_attributes', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Defaults variation attributes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Attribute ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Attribute name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'option', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Selected attribute term name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'variations', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of variations IDs.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'grouped_products', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of grouped products ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'menu_order', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Menu order, used to custom sort products.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'meta_data', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta data.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'key', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta key.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Meta value.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'mixed' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }]) }]) }]) }])
	mut var_post_type_obj := rt.call_function('get_post_type_object', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'post_type')])
	if rt.is_true(rt.call_function('is_post_type_viewable', [var_post_type_obj.clone()])) && rt.is_true(rt.get_property(var_post_type_obj, 'public')) {
		var_schema.array_get_mut('properties').array_set('permalink_template', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Permalink template for the product.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]))
		var_schema.array_get_mut('properties').array_set('generated_slug', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Slug automatically generated from the product name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]))
	}
	if rt.is_true(this.cogs_is_enabled()) {
	var_schema = this.add_cogs_related_product_schema(var_schema.clone(), rt.new_bool(false))
	}
	var_schema.array_get_mut('properties').array_set('min_price', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product minimum price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]))
	var_schema.array_get_mut('properties').array_set('max_price', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product maximum price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]))
	var_schema.array_get_mut('properties').array_set('add_to_cart', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Add to cart details.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'url', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Add to cart URL.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Add to cart description.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'text', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Add to cart text.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'single_text', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Add to cart single text.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }, rt.ArrayItem{ key: 'readonly', val: true }]))
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_Products_V2_Controller.get_collection_params()
	var_params.array_get_mut('orderby').array_set('enum', rt.call_function('array_merge', [var_params.array_get(rt.new_string('orderby')).array_get(rt.new_string('enum')), rt.create_array([rt.ArrayItem{ key: none, val: 'price' }, rt.ArrayItem{ key: none, val: 'popularity' }, rt.ArrayItem{ key: none, val: 'rating' }])]))
	var_params.array_unset(rt.new_string('in_stock'))
	var_params.array_set('stock_status', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products with specified stock status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('search_sku', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit results to those with a SKU that partial matches a string. This argument takes precedence over \'sku\'.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('search_name_or_sku', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit results to those with a name or SKU that partial matches a string. This argument takes precedence over \'search\', \'sku\' and \'search_sku\'.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	mut var_search_fields_enum := rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'global_unique_id' }, rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'short_description' }])
	if rt.is_true(rt.call_function('wc_product_sku_enabled', []rt.PhpVal{})) {
		var_search_fields_enum.array_push('sku')
	}
	var_params.array_set('search_fields', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit search to specific fields when used with search parameter. Available fields: name, sku, global_unique_id, description, short_description. This argument takes precedence over all other search parameters.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: var_search_fields_enum }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_slug_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('include_status', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products with any of the statuses.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'any' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.future() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.trash() }]), rt.func_array_keys(rt.call_function('get_post_statuses', []rt.PhpVal{}))]) }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('exclude_status', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Exclude products with any of the statuses from result set.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.future() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.trash() }]), rt.func_array_keys(rt.call_function('get_post_statuses', []rt.PhpVal{}))]) }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('include_types', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to products with any of the types.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('wc_get_product_types', []rt.PhpVal{})) }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('exclude_types', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Exclude products with any of the types from result set.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('wc_get_product_types', []rt.PhpVal{})) }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('exclude_category', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Exclude products that belong to specific product category IDs.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('downloadable', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to downloadable products.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'rest_sanitize_boolean' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('virtual', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to virtual products.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'rest_sanitize_boolean' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) get_suggested_products_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_Products_V2_Controller.get_collection_params()
	var_params.array_set('categories', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to specific product categorie ids.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('tags', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to specific product tag ids.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }]))
	var_params.array_set('limit', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to specific amount of suggested products.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 5 }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) get_downloads(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_downloads := rt.new_array()
	mut var_context := if !(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'request')).is_null() && rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'request').array_isset(rt.new_string('context')) { rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'request').array_get(rt.new_string('context')) } else { rt.new_string('view') }
	if rt.is_true(rt.call_method(var_product_mutated, 'is_downloadable', []rt.PhpVal{})) || rt.is_true(rt.identical(rt.new_string('edit'), var_context)) {
		mut iter_11 := rt.call_method(var_product_mutated, 'get_downloads', []rt.PhpVal{}).iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_file := item_11.val
			mut var_file_id := item_11.key
			var_downloads.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: var_file_id }, rt.ArrayItem{ key: 'name', val: var_file.array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'file', val: var_file.array_get(rt.new_string('file')) }]))
		}
	}
	return var_downloads.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) get_product_data(var_product rt.PhpVal, context string) rt.PhpVal {
	mut var_product_mutated := var_product
	mut context_mutated := context
	mut var_data := this.Class_WC_REST_Products_V2_Controller.get_product_data(rt.call_function('func_get_args', []rt.PhpVal{}))
	if !(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'request')).is_null() {
		mut var_fields := this.get_fields_for_response(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'request'))
		if rt.is_true(rt.call_function('in_array', [rt.new_string('stock_status'), var_fields.clone(), rt.new_bool(true)])) {
			var_data.array_set('stock_status', rt.call_method(var_product_mutated, 'get_stock_status', [rt.new_string(context_mutated).clone()]))
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_string('has_options'), var_fields.clone(), rt.new_bool(true)])) {
			var_data.array_set('has_options', rt.call_method(var_product_mutated, 'has_options', [rt.new_string(context_mutated).clone()]))
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_string('post_password'), var_fields.clone(), rt.new_bool(true)])) {
			var_data.array_set('post_password', rt.call_method(var_product_mutated, 'get_post_password', [rt.new_string(context_mutated).clone()]))
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_string('global_unique_id'), var_fields.clone(), rt.new_bool(true)])) {
			var_data.array_set('global_unique_id', rt.call_method(var_product_mutated, 'get_global_unique_id', [rt.new_string(context_mutated).clone()]))
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_string('min_price'), var_fields.clone(), rt.new_bool(true)])) {
			var_data.array_set('min_price', if rt.is_true(rt.call_function('method_exists', [var_product_mutated.clone(), rt.new_string('get_min_price')])) { rt.call_method(var_product_mutated, 'get_min_price', []rt.PhpVal{}) } else { rt.new_string('') })
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_string('max_price'), var_fields.clone(), rt.new_bool(true)])) {
			var_data.array_set('max_price', if rt.is_true(rt.call_function('method_exists', [var_product_mutated.clone(), rt.new_string('get_max_price')])) { rt.call_method(var_product_mutated, 'get_max_price', []rt.PhpVal{}) } else { rt.new_string('') })
		}
		mut var_post_type_obj := rt.call_function('get_post_type_object', [rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], &this), 'post_type')])
		if rt.is_true(rt.call_function('is_post_type_viewable', [var_post_type_obj.clone()])) && rt.is_true(rt.get_property(var_post_type_obj, 'public')) {
			mut var_permalink_template_requested := rt.call_function('in_array', [rt.new_string('permalink_template'), var_fields.clone(), rt.new_bool(true)])
			mut var_generated_slug_requested := rt.call_function('in_array', [rt.new_string('generated_slug'), var_fields.clone(), rt.new_bool(true)])
			if rt.is_true(var_permalink_template_requested) || rt.is_true(var_generated_slug_requested) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_sample_permalink')]))))) {
					rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/post.php', '4')
				}
				mut var_sample_permalink := rt.call_function('get_sample_permalink', [rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}), rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{}), rt.new_string('')])
				if rt.is_true(var_permalink_template_requested) {
					var_data.array_set('permalink_template', var_sample_permalink.array_get(rt.new_int(0)))
				}
				if rt.is_true(var_generated_slug_requested) {
					var_data.array_set('generated_slug', var_sample_permalink.array_get(rt.new_int(1)))
				}
			}
		}
	}
	return var_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) get_suggested_products(var_request rt.PhpVal) rt.PhpVal {
	mut var_categories := rt.call_method(var_request, 'get_param', [rt.new_string('categories')])
	mut var_tags := rt.call_method(var_request, 'get_param', [rt.new_string('tags')])
	mut var_exclude_ids := rt.call_method(var_request, 'get_param', [rt.new_string('exclude')])
	mut var_limit := if rt.is_true(rt.call_method(var_request, 'get_param', [rt.new_string('limit')])) { rt.call_method(var_request, 'get_param', [rt.new_string('limit')]) } else { rt.new_int(5) }
	mut iife_temp_5 := Class_WC_Data_Store{}
	mut iife_result_5 := iife_temp_5.load(rt.new_string('product'))
	mut var_data_store := iife_result_5
	this.suggested_products_ids = rt.call_method(var_data_store, 'get_related_products', [var_categories.clone(), var_tags.clone(), var_exclude_ids.clone(), var_limit.clone(), rt.new_null()])
	if !rt.is_true(this.suggested_products_ids) {
		return rt.new_array()
	}
	this.suggested_products_ids = rt.call_function('array_slice', [this.suggested_products_ids, rt.new_int(0), var_limit.clone()])
	return this.Class_WC_REST_Products_V2_Controller.get_items(var_request.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) prepare_object_for_response_core(var_object_data rt.PhpVal, var_request rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	mut var_data := this.Class_WC_REST_Products_V2_Controller.prepare_object_for_response_core(var_object_data.clone(), var_request.clone(), var_context_mutated.clone())
	if rt.is_true(this.cogs_is_enabled()) {
		this.add_cogs_info_to_returned_product_data(var_data.clone(), var_object_data.clone())
	}
	var_data.array_set('add_to_cart', rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_method(var_object_data, 'add_to_cart_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'description', val: rt.call_method(var_object_data, 'add_to_cart_description', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'text', val: rt.call_method(var_object_data, 'add_to_cart_text', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'single_text', val: rt.call_method(var_object_data, 'single_add_to_cart_text', []rt.PhpVal{}) }]))
	mut var_post_type_object := rt.call_function('get_post_type_object', [rt.new_string('product')])
	if rt.is_true(rt.new_bool(rt.instance_of(var_post_type_object, 'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_WP_Post_Type'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'read_private_posts')]))))) {
		mut iter_12 := Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller.sensitive_fields().iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_field := item_12.val
			var_data.array_unset(var_field)
		}
	}
	return var_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	this.processed_attachment_ids_for_request = rt.new_array()
	mut var_response := this.Class_WC_REST_Products_V2_Controller.create_item(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		if !(!rt.is_true(this.processed_attachment_ids_for_request)) {
			mut iter_13 := this.processed_attachment_ids_for_request.iterator()
			for {
				item_13 := iter_13.next() or { break }
				mut var_attachment_id := item_13.val
				rt.call_function('wp_delete_attachment', [rt.new_int((var_attachment_id).to_i64()), rt.new_bool(true)])
			}
		}
	}
	this.processed_attachment_ids_for_request = rt.new_array()
	return var_response.clone()
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

struct Class_WC_REST_Exception {
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

struct Class_Automattic_WooCommerce_Utilities_I18nUtil {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_products_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v4')
		search_sku_arg_value: rt.new_string('')
		search_name_or_sku_tokens: rt.new_null()
		search_fields_tokens: rt.new_null()
		suggested_products_ids: rt.new_array()
		exclude_status: rt.new_array()
		processed_attachment_ids_for_request: rt.new_array()
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

fn create_wc_admin_duplicate_product(_args ...rt.PhpVal) &Class_WC_Admin_Duplicate_Product {
	mut obj := &Class_WC_Admin_Duplicate_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
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

fn create_wc_rest_exception(_args ...rt.PhpVal) &Class_WC_REST_Exception {
	mut obj := &Class_WC_REST_Exception{
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

fn create_automattic_woocommerce_utilities_i18nutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_I18nUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_I18nUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
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

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_REST_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_restapi_routes_v4_products_controller()
		return rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Products_Controller', ['WC_REST_Products_V2_Controller'], obj)
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
	rt.register_class_factory('WC_REST_Exception', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_rest_exception()
		return rt.new_object('WC_REST_Exception', []string{}, obj)
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
	rt.register_class_factory('Automattic_WooCommerce_Utilities_I18nUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_i18nutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_I18nUtil', []string{}, obj)
	})
	rt.register_class_factory('WC_Data_Store', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_data_store()
		return rt.new_object('WC_Data_Store', []string{}, obj)
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
