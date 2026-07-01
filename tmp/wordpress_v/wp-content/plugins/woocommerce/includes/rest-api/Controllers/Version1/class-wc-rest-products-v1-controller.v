import rt

struct Class_WC_REST_Products_V1_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v1')
		rest_base rt.PhpVal = rt.new_string('products')
		post_type rt.PhpVal = rt.new_string('product')
}

fn (mut this Class_WC_REST_Products_V1_Controller) construct()  {
	rt.call_function('add_filter', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_query')), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'query_args' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.concat(rt.new_string('woocommerce_rest_insert_'), this.post_type), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'clear_transients' }])])
}

fn (mut this Class_WC_REST_Products_V1_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass trash and force deletion.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/batch', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
}

fn (mut this Class_WC_REST_Products_V1_Controller) get_post_types() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }])
}

fn (mut this Class_WC_REST_Products_V1_Controller) query_args(var_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_request_mutated := var_request
	var_args_mutated.array_set('post_status', var_request_mutated.array_get('status'))
	mut var_tax_query := []rt.PhpVal{}
	mut var_taxonomies := { 'product_cat': 'category', 'product_tag': 'tag', 'product_shipping_class': 'shipping_class' }
	for var_taxonomy, var_key in var_taxonomies {
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_request_mutated.array_get(key))) && rt.is_true(rt.new_bool(var_request_mutated.array_get(key).is_array())))) {
			var_request_mutated.array_set(key, rt.call_function('array_filter', [var_request_mutated.array_get(key)]))
		}
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
		var_args_mutated.array_set('tax_query', var_tax_query.dup())
	}
	if !(!rt.is_true(var_request_mutated.array_get('sku'))) {
		mut var_skus := rt.call_function('explode', [rt.new_string(','), var_request_mutated.array_get('sku')])
		if 1 < var_skus.dup().array_count() {
			var_skus.array_push(var_request_mutated.array_get('sku'))
		}
		var_args_mutated.array_set('meta_query', this.add_meta_query(var_args_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'key', val: '_sku' }, rt.ArrayItem{ key: 'value', val: var_skus }, rt.ArrayItem{ key: 'compare', val: 'IN' }])))
	}
	if rt.is_true(rt.new_bool(var_request_mutated.array_get('filter').is_array())) {
		var_args_mutated = rt.call_function('array_merge', [var_args_mutated.dup(), var_request_mutated.array_get('filter')])
		var_args_mutated.array_unset(rt.new_string('filter'))
	}
	if !(!rt.is_true(var_request_mutated.array_get('sku'))) {
		var_args_mutated.array_set('post_type', rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'product_variation' }]))
	} else {
		var_args_mutated.array_set('post_type', this.post_type)
	}
	return var_args_mutated.dup()
}

fn (mut this Class_WC_REST_Products_V1_Controller) get_downloads(var_product rt.PhpVal) rt.PhpVal {
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

fn (mut this Class_WC_REST_Products_V1_Controller) get_taxonomy_terms(var_product rt.PhpVal, taxonomy string) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_terms := []rt.PhpVal{}
	{
		mut iter_1 := rt.call_function('wc_get_object_terms', [rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}), 'product_' + taxonomy]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			var_terms << rt.create_array([rt.ArrayItem{ key: 'id', val: rt.get_property(var_term, 'term_id') }, rt.ArrayItem{ key: 'name', val: rt.get_property(var_term, 'name') }, rt.ArrayItem{ key: 'slug', val: rt.get_property(var_term, 'slug') }])
		}
	}
	return var_terms.dup()
}

fn (mut this Class_WC_REST_Products_V1_Controller) get_images(var_product rt.PhpVal) rt.PhpVal {
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
			var_images << rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment_post, 'post_date_gmt')]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_attachment_post, 'post_modified_gmt')]) }, rt.ArrayItem{ key: 'src', val: rt.call_function('current', [var_attachment.dup()]) }, rt.ArrayItem{ key: 'name', val: rt.call_function('get_the_title', [var_attachment_id.dup()]) }, rt.ArrayItem{ key: 'alt', val: rt.call_function('get_post_meta', [var_attachment_id.dup(), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'position', val: // unsupported expression: Expr_Cast_Int }])
		}
	}
	if !rt.is_true(var_images) {
		var_images << rt.create_array([rt.ArrayItem{ key: 'id', val: 0 }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('current_time', [rt.new_string('mysql')])]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_function('current_time', [rt.new_string('mysql')])]) }, rt.ArrayItem{ key: 'src', val: rt.call_function('wc_placeholder_img_src', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Placeholder'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'alt', val: rt.call_function('__', [rt.new_string('Placeholder'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'position', val: 0 }])
	}
	return var_images.dup()
}

fn (mut this Class_WC_REST_Products_V1_Controller) get_attribute_taxonomy_label(var_name rt.PhpVal) rt.PhpVal {
	mut var_name_mutated := var_name
	mut var_tax := rt.call_function('get_taxonomy', [var_name_mutated.dup()])
	mut var_labels := rt.call_function('get_taxonomy_labels', [var_tax.dup()])
	return rt.get_property(var_labels, 'singular_name')
}

fn (mut this Class_WC_REST_Products_V1_Controller) get_default_attributes(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_default := []rt.PhpVal{}
	if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) {
		{
			mut iter_1 := rt.call_function('array_filter', [rt.cast_array(rt.call_method(var_product_mutated, 'get_default_attributes', []rt.PhpVal{})), rt.new_string('strlen')]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_key.dup(), rt.new_string('pa_')]))) {
					var_default << rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_function('wc_attribute_taxonomy_id_by_name', [var_key.dup()]) }, rt.ArrayItem{ key: 'name', val: this.get_attribute_taxonomy_label(var_key.dup()) }, rt.ArrayItem{ key: 'option', val: var_value }])
				} else {
					var_default << rt.create_array([rt.ArrayItem{ key: 'id', val: 0 }, rt.ArrayItem{ key: 'name', val: rt.call_function('wc_attribute_taxonomy_slug', [var_key.dup()]) }, rt.ArrayItem{ key: 'option', val: var_value }])
				}
			}
		}
	}
	return var_default.dup()
}

fn (mut this Class_WC_REST_Products_V1_Controller) get_attribute_options(var_product_id rt.PhpVal, var_attribute rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
	if rt.is_true(rt.new_bool(var_attribute.array_isset(rt.new_string('is_taxonomy')) && rt.is_true(var_attribute.array_get('is_taxonomy')))) {
		return rt.call_function('wc_get_product_terms', [var_product_id_mutated.dup(), var_attribute.array_get('name'), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'names' }])])
	} else if var_attribute.array_isset(rt.new_string('value')) {
		return rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string('|'), var_attribute.array_get('value')])])
	}
	return []rt.PhpVal{}
}

fn (mut this Class_WC_REST_Products_V1_Controller) get_attributes(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_attributes := []rt.PhpVal{}
	if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) {
		{
			mut iter_1 := rt.call_method(var_product_mutated, 'get_variation_attributes', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute := item_1.val
				mut var_attribute_name := item_1.key
				mut var_name := rt.call_function('str_replace', [rt.new_string('attribute_'), rt.new_string(''), var_attribute_name.dup()])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute)))) {
					continue
				}
				if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_attribute_name.dup(), rt.new_string('attribute_pa_')]))) {
					mut var_option_term := rt.call_function('get_term_by', [rt.new_string('slug'), var_attribute.dup(), var_name.dup()])
					var_attributes.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_function('wc_attribute_taxonomy_id_by_name', [var_name.dup()]) }, rt.ArrayItem{ key: 'name', val: this.get_attribute_taxonomy_label(var_name.dup()) }, rt.ArrayItem{ key: 'option', val: if rt.is_true(rt.new_bool(rt.is_true(var_option_term) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_option_term.dup()]))))))) { rt.get_property(var_option_term, 'name') } else { var_attribute } }]))
				} else {
					var_attributes.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 0 }, rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'option', val: var_attribute }]))
				}
			}
		}
	} else {
		{
			mut iter_1 := rt.call_method(var_product_mutated, 'get_attributes', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute := item_1.val
				if rt.is_true(var_attribute.array_get('is_taxonomy')) {
					var_attributes.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_function('wc_attribute_taxonomy_id_by_name', [var_attribute.array_get('name')]) }, rt.ArrayItem{ key: 'name', val: this.get_attribute_taxonomy_label(var_attribute.array_get('name')) }, rt.ArrayItem{ key: 'position', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'visible', val: // unsupported expression: Expr_Cast_Bool }, rt.ArrayItem{ key: 'variation', val: // unsupported expression: Expr_Cast_Bool }, rt.ArrayItem{ key: 'options', val: this.get_attribute_options(rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}), var_attribute.dup()) }]))
				} else {
					var_attributes.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: 0 }, rt.ArrayItem{ key: 'name', val: var_attribute.array_get('name') }, rt.ArrayItem{ key: 'position', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'visible', val: // unsupported expression: Expr_Cast_Bool }, rt.ArrayItem{ key: 'variation', val: // unsupported expression: Expr_Cast_Bool }, rt.ArrayItem{ key: 'options', val: this.get_attribute_options(rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}), var_attribute.dup()) }]))
				}
			}
		}
	}
	return var_attributes.dup()
}

fn (mut this Class_WC_REST_Products_V1_Controller) get_product_menu_order(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	return rt.call_method(var_product_mutated, 'get_menu_order', []rt.PhpVal{})
}

fn (mut this Class_WC_REST_Products_V1_Controller) get_product_data(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'name', val: rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'slug', val: rt.call_method(var_product_mutated, 'get_slug', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'permalink', val: rt.call_method(var_product_mutated, 'get_permalink', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_product_mutated, 'get_date_created', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_product_mutated, 'get_date_modified', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'type', val: rt.call_method(var_product_mutated, 'get_type', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'status', val: rt.call_method(var_product_mutated, 'get_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'featured', val: rt.call_method(var_product_mutated, 'is_featured', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'catalog_visibility', val: rt.call_method(var_product_mutated, 'get_catalog_visibility', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'description', val: rt.call_function('wpautop', [rt.call_function('do_shortcode', [rt.call_method(var_product_mutated, 'get_description', []rt.PhpVal{})])]) }, rt.ArrayItem{ key: 'short_description', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_short_description'), rt.call_method(var_product_mutated, 'get_short_description', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'sku', val: rt.call_method(var_product_mutated, 'get_sku', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'price', val: rt.call_method(var_product_mutated, 'get_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'regular_price', val: rt.call_method(var_product_mutated, 'get_regular_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'sale_price', val: if rt.is_true(rt.call_method(var_product_mutated, 'get_sale_price', []rt.PhpVal{})) { rt.call_method(var_product_mutated, 'get_sale_price', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'date_on_sale_from', val: if rt.is_true(rt.call_method(var_product_mutated, 'get_date_on_sale_from', []rt.PhpVal{})) { rt.call_function('date', [rt.new_string('Y-m-d'), rt.call_method(rt.call_method(var_product_mutated, 'get_date_on_sale_from', []rt.PhpVal{}), 'getTimestamp', []rt.PhpVal{})]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'date_on_sale_to', val: if rt.is_true(rt.call_method(var_product_mutated, 'get_date_on_sale_to', []rt.PhpVal{})) { rt.call_function('date', [rt.new_string('Y-m-d'), rt.call_method(rt.call_method(var_product_mutated, 'get_date_on_sale_to', []rt.PhpVal{}), 'getTimestamp', []rt.PhpVal{})]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'price_html', val: rt.call_method(var_product_mutated, 'get_price_html', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'on_sale', val: rt.call_method(var_product_mutated, 'is_on_sale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'purchasable', val: rt.call_method(var_product_mutated, 'is_purchasable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'total_sales', val: rt.call_method(var_product_mutated, 'get_total_sales', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'virtual', val: rt.call_method(var_product_mutated, 'is_virtual', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'downloadable', val: rt.call_method(var_product_mutated, 'is_downloadable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'downloads', val: this.get_downloads(var_product_mutated.dup()) }, rt.ArrayItem{ key: 'download_limit', val: rt.call_method(var_product_mutated, 'get_download_limit', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'download_expiry', val: rt.call_method(var_product_mutated, 'get_download_expiry', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'download_type', val: 'standard' }, rt.ArrayItem{ key: 'external_url', val: if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.external()])) { rt.call_method(var_product_mutated, 'get_product_url', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'button_text', val: if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.external()])) { rt.call_method(var_product_mutated, 'get_button_text', []rt.PhpVal{}) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'tax_status', val: rt.call_method(var_product_mutated, 'get_tax_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'tax_class', val: rt.call_method(var_product_mutated, 'get_tax_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'manage_stock', val: rt.call_method(var_product_mutated, 'managing_stock', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'stock_quantity', val: rt.call_method(var_product_mutated, 'get_stock_quantity', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'in_stock', val: rt.call_method(var_product_mutated, 'is_in_stock', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backorders', val: rt.call_method(var_product_mutated, 'get_backorders', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backorders_allowed', val: rt.call_method(var_product_mutated, 'backorders_allowed', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backordered', val: rt.call_method(var_product_mutated, 'is_on_backorder', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'sold_individually', val: rt.call_method(var_product_mutated, 'is_sold_individually', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'weight', val: rt.call_method(var_product_mutated, 'get_weight', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'dimensions', val: rt.create_array([rt.ArrayItem{ key: 'length', val: rt.call_method(var_product_mutated, 'get_length', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'width', val: rt.call_method(var_product_mutated, 'get_width', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'height', val: rt.call_method(var_product_mutated, 'get_height', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'shipping_required', val: rt.call_method(var_product_mutated, 'needs_shipping', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_taxable', val: rt.call_method(var_product_mutated, 'is_shipping_taxable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_class', val: rt.call_method(var_product_mutated, 'get_shipping_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_class_id', val: rt.call_method(var_product_mutated, 'get_shipping_class_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'reviews_allowed', val: rt.call_method(var_product_mutated, 'get_reviews_allowed', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'average_rating', val: rt.call_function('wc_format_decimal', [rt.call_method(var_product_mutated, 'get_average_rating', []rt.PhpVal{}), rt.new_int(2)]) }, rt.ArrayItem{ key: 'rating_count', val: rt.call_method(var_product_mutated, 'get_rating_count', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'related_ids', val: rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('array_values', [rt.call_function('wc_get_related_products', [rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})])])]) }, rt.ArrayItem{ key: 'upsell_ids', val: rt.call_function('array_map', [rt.new_string('absint'), rt.call_method(var_product_mutated, 'get_upsell_ids', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'cross_sell_ids', val: rt.call_function('array_map', [rt.new_string('absint'), rt.call_method(var_product_mutated, 'get_cross_sell_ids', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'parent_id', val: rt.call_method(var_product_mutated, 'get_parent_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'purchase_note', val: rt.call_function('wpautop', [rt.call_function('do_shortcode', [rt.call_function('wp_kses_post', [rt.call_method(var_product_mutated, 'get_purchase_note', []rt.PhpVal{})])])]) }, rt.ArrayItem{ key: 'categories', val: this.get_taxonomy_terms(var_product_mutated.dup(), '') }, rt.ArrayItem{ key: 'tags', val: this.get_taxonomy_terms(var_product_mutated.dup(), 'tag') }, rt.ArrayItem{ key: 'images', val: this.get_images(var_product_mutated.dup()) }, rt.ArrayItem{ key: 'attributes', val: this.get_attributes(var_product_mutated.dup()) }, rt.ArrayItem{ key: 'default_attributes', val: this.get_default_attributes(var_product_mutated.dup()) }, rt.ArrayItem{ key: 'variations', val: []rt.PhpVal{} }, rt.ArrayItem{ key: 'grouped_products', val: []rt.PhpVal{} }, rt.ArrayItem{ key: 'menu_order', val: rt.call_method(var_product_mutated, 'get_menu_order', []rt.PhpVal{}) }])
	return var_data.dup()
}

fn (mut this Class_WC_REST_Products_V1_Controller) get_variation_data(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_variations := []rt.PhpVal{}
	{
		mut iter_1 := rt.call_method(var_product_mutated, 'get_children', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_child_id := item_1.val
			mut var_variation := rt.call_function('wc_get_product', [var_child_id.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_variation)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_variation, 'exists', []rt.PhpVal{}))))))) {
				continue
			}
			var_variations << rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_variation, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_variation, 'get_date_created', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'date_modified', val: rt.call_function('wc_rest_prepare_date_response', [rt.call_method(var_variation, 'get_date_modified', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'permalink', val: rt.call_method(var_variation, 'get_permalink', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'sku', val: rt.call_method(var_variation, 'get_sku', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'price', val: rt.call_method(var_variation, 'get_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'regular_price', val: rt.call_method(var_variation, 'get_regular_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'sale_price', val: rt.call_method(var_variation, 'get_sale_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'date_on_sale_from', val: if rt.is_true(rt.call_method(var_variation, 'get_date_on_sale_from', []rt.PhpVal{})) { rt.call_function('date', [rt.new_string('Y-m-d'), rt.call_method(rt.call_method(var_variation, 'get_date_on_sale_from', []rt.PhpVal{}), 'getTimestamp', []rt.PhpVal{})]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'date_on_sale_to', val: if rt.is_true(rt.call_method(var_variation, 'get_date_on_sale_to', []rt.PhpVal{})) { rt.call_function('date', [rt.new_string('Y-m-d'), rt.call_method(rt.call_method(var_variation, 'get_date_on_sale_to', []rt.PhpVal{}), 'getTimestamp', []rt.PhpVal{})]) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'on_sale', val: rt.call_method(var_variation, 'is_on_sale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'purchasable', val: rt.call_method(var_variation, 'is_purchasable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'visible', val: rt.call_method(var_variation, 'is_visible', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'virtual', val: rt.call_method(var_variation, 'is_virtual', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'downloadable', val: rt.call_method(var_variation, 'is_downloadable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'downloads', val: this.get_downloads(var_variation.dup()) }, rt.ArrayItem{ key: 'download_limit', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { // unsupported expression: Expr_Cast_Int } else { // unsupported expression: Expr_UnaryMinus } }, rt.ArrayItem{ key: 'download_expiry', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { // unsupported expression: Expr_Cast_Int } else { // unsupported expression: Expr_UnaryMinus } }, rt.ArrayItem{ key: 'tax_status', val: rt.call_method(var_variation, 'get_tax_status', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'tax_class', val: rt.call_method(var_variation, 'get_tax_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'manage_stock', val: rt.call_method(var_variation, 'managing_stock', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'stock_quantity', val: rt.call_method(var_variation, 'get_stock_quantity', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'in_stock', val: rt.call_method(var_variation, 'is_in_stock', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backorders', val: rt.call_method(var_variation, 'get_backorders', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backorders_allowed', val: rt.call_method(var_variation, 'backorders_allowed', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'backordered', val: rt.call_method(var_variation, 'is_on_backorder', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'weight', val: rt.call_method(var_variation, 'get_weight', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'dimensions', val: rt.create_array([rt.ArrayItem{ key: 'length', val: rt.call_method(var_variation, 'get_length', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'width', val: rt.call_method(var_variation, 'get_width', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'height', val: rt.call_method(var_variation, 'get_height', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'shipping_class', val: rt.call_method(var_variation, 'get_shipping_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'shipping_class_id', val: rt.call_method(var_variation, 'get_shipping_class_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'image', val: this.get_images(var_variation.dup()) }, rt.ArrayItem{ key: 'attributes', val: this.get_attributes(var_variation.dup()) }])
		}
	}
	return var_variations.dup()
}

fn (mut this Class_WC_REST_Products_V1_Controller) prepare_item_for_response(var_post rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_request_mutated := var_request
	mut var_product := rt.call_function('wc_get_product', [var_post_mutated.dup()])
	mut var_data := this.get_product_data(var_product.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) && rt.is_true(rt.call_method(var_product, 'has_child', []rt.PhpVal{})))) {
		var_data.array_set('variations', this.get_variation_data(var_product.dup()))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.grouped()])) && rt.is_true(rt.call_method(var_product, 'has_child', []rt.PhpVal{})))) {
		var_data.array_set('grouped_products', rt.call_method(var_product, 'get_children', []rt.PhpVal{}))
	}
	mut var_context := if !(!rt.is_true(var_request_mutated.array_get('context'))) { var_request_mutated.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request_mutated.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_product.dup(), var_request_mutated.dup())])
	return rt.call_function('apply_filters', [rt.concat(rt.new_string('woocommerce_rest_prepare_'), this.post_type), var_response.dup(), var_post_mutated.dup(), var_request_mutated.dup()])
}

fn (mut this Class_WC_REST_Products_V1_Controller) prepare_links(var_product rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_request_mutated := var_request
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [, , , ])]) }, 'collection': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [, , ])]) } }
	if rt.is_true(rt.call_method(var_product_mutated, 'get_parent_id', []rt.PhpVal{})) {
		var_links['up'] = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [, , ])]) }])
	}
	return var_links.dup()
}

fn (mut this Class_WC_REST_Products_V1_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_id := if var_request_mutated.array_isset(rt.new_string('id')) { rt.call_function('absint', []) } else { rt.new_int(0) }
	if var_request_mutated.array_isset(rt.new_string('type')) {
		mut var_classname := 
		if rt.is_true() {
		}
		
	} else if .array_isset() {
	} else {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	if .array_isset() {
	}
	return 
}

fn (mut this Class_WC_REST_Products_V1_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.new_null()
}

fn (mut this Class_WC_REST_Products_V1_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.new_null()
}

fn (mut this Class_WC_REST_Products_V1_Controller) save_product(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Products_V1_Controller) save_product_images(var_product_id rt.PhpVal, var_images rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
	mut var_images_mutated := var_images
}

fn (mut this Class_WC_REST_Products_V1_Controller) set_product_images(var_product rt.PhpVal, var_images rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_images_mutated := var_images
}

fn (mut this Class_WC_REST_Products_V1_Controller) save_product_shipping_data(var_product rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_data_mutated := var_data
}

fn (mut this Class_WC_REST_Products_V1_Controller) save_downloadable_files(var_product rt.PhpVal, var_downloads rt.PhpVal, deprecated i64) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_downloads_mutated := var_downloads
}

fn (mut this Class_WC_REST_Products_V1_Controller) save_taxonomy_terms(var_product rt.PhpVal, var_terms rt.PhpVal, taxonomy string) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_terms_mutated := var_terms
}

fn (mut this Class_WC_REST_Products_V1_Controller) save_default_attributes(var_product rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Products_V1_Controller) save_product_meta(var_product rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_product_mutated := var_product
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Products_V1_Controller) set_product_meta(var_product rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Products_V1_Controller) save_variations_data(var_product rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_product_mutated := var_product
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Products_V1_Controller) add_post_meta_fields(var_post rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Products_V1_Controller) update_post_meta_fields(var_post rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_post_mutated := var_post
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Products_V1_Controller) clear_transients(var_post rt.PhpVal)  {
	mut var_post_mutated := var_post
}

fn (mut this Class_WC_REST_Products_V1_Controller) delete_post(var_id rt.PhpVal)  {
	mut var_id_mutated := var_id
}

fn (mut this Class_WC_REST_Products_V1_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Products_V1_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WC_REST_Products_V1_Controller) get_collection_params() rt.PhpVal {
}

struct Class_WC_REST_Posts_Controller {
	rt.PhpObjectBase
}

fn create_wc_rest_products_v1_controller() &Class_WC_REST_Products_V1_Controller {
	mut obj := &Class_WC_REST_Products_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v1')
		rest_base: rt.new_string('products')
		post_type: rt.new_string('product')
	}
	obj.construct()
	return obj
}

fn create_wc_rest_posts_controller() &Class_WC_REST_Posts_Controller {
	mut obj := &Class_WC_REST_Posts_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Products_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_post_types' {
			return this.get_post_types()
		}
		'query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.query_args(dispatch_arg_0, dispatch_arg_1)
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
		'get_product_menu_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_menu_order(dispatch_arg_0)
		}
		'get_product_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_data(dispatch_arg_0)
		}
		'get_variation_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_variation_data(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'save_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.save_product(dispatch_arg_0)
		}
		'save_product_images' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.save_product_images(dispatch_arg_0, dispatch_arg_1)
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
		'save_product_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.save_product_meta(dispatch_arg_0, dispatch_arg_1))
		}
		'set_product_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.set_product_meta(dispatch_arg_0, dispatch_arg_1)
		}
		'save_variations_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.save_variations_data(dispatch_arg_0, dispatch_arg_1))
		}
		'add_post_meta_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_post_meta_fields(dispatch_arg_0, dispatch_arg_1)
		}
		'update_post_meta_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_post_meta_fields(dispatch_arg_0, dispatch_arg_1))
		}
		'clear_transients' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.clear_transients(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_post(dispatch_arg_0)
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

fn (this &Class_WC_REST_Products_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Products_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'post_type' { this.post_type = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Posts_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Posts_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Posts_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WC_REST_Products_V1_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_rest_products_v1_controller()
		return rt.new_object('WC_REST_Products_V1_Controller', ['WC_REST_Posts_Controller'], obj)
	})
	rt.register_class_factory('WC_REST_Posts_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_rest_posts_controller()
		return rt.new_object('WC_REST_Posts_Controller', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version1_class_wc_rest_products_v1_controller_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
