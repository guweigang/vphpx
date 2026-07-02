import rt

struct Class_WC_REST_Terms_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base        rt.PhpVal = rt.new_string('')
	taxonomy         rt.PhpVal = rt.new_string('')
	taxonomies_by_id rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_REST_Terms_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WC_REST_Terms_Controller', [
			'WC_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [
					this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()),
					rt.create_array([
						rt.ArrayItem{ key: 'name', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Name for the resource.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'required', val: true },
						]) },
					]),
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WC_REST_Terms_Controller', [
			'WC_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'force', val: rt.create_array([
						rt.ArrayItem{ key: 'default', val: false },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Required to be true, as resource does not support trashing.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WC_REST_Terms_Controller', [
			'WC_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str() + '/batch'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'batch_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_batch_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WC_REST_Terms_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_permissions := this.check_permissions(var_request.clone(), 'read')
	if rt.is_true(rt.call_function('is_wp_error', [var_permissions.clone()])) {
		return var_permissions.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permissions)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot list resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Terms_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_permissions := this.check_permissions(var_request.clone(), 'create')
	if rt.is_true(rt.call_function('is_wp_error', [var_permissions.clone()])) {
		return var_permissions.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permissions)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to create resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Terms_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_permissions := this.check_permissions(var_request.clone(), 'read')
	if rt.is_true(rt.call_function('is_wp_error', [var_permissions.clone()])) {
		return var_permissions.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permissions)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot view this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Terms_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_permissions := this.check_permissions(var_request.clone(), 'edit')
	if rt.is_true(rt.call_function('is_wp_error', [var_permissions.clone()])) {
		return var_permissions.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permissions)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Terms_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_permissions := this.check_permissions(var_request.clone(), 'delete')
	if rt.is_true(rt.call_function('is_wp_error', [var_permissions.clone()])) {
		return var_permissions.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permissions)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Terms_Controller) batch_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_permissions := this.check_permissions(var_request.clone(), 'batch')
	if rt.is_true(rt.call_function('is_wp_error', [var_permissions.clone()])) {
		return var_permissions.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permissions)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_batch'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to batch manipulate this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Terms_Controller) check_permissions(var_request rt.PhpVal, context string) rt.PhpVal {
	mut var_taxonomy := this.get_taxonomy(var_request.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy.clone()]))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_taxonomy_invalid'), rt.call_function('__', [
			rt.new_string('Taxonomy does not exist.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_id := rt.new_int(var_request.array_get(rt.new_string('id')).to_i64())
	if rt.is_true(var_id) {
		mut var_term := rt.call_function('get_term', [var_id.clone(),
			var_taxonomy.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_term))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_term, 'taxonomy'), var_taxonomy)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_term_invalid'), rt.call_function('__', [
				rt.new_string('Resource does not exist.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
		}
		return rt.call_function('wc_rest_check_product_term_permissions', [
			var_taxonomy.clone(), rt.new_string(context), rt.get_property(var_term, 'term_id')])
	}
	return rt.call_function('wc_rest_check_product_term_permissions', [
		var_taxonomy.clone(), rt.new_string(context)])
}

fn (mut this Class_WC_REST_Terms_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_taxonomy := this.get_taxonomy(var_request.clone())
	mut var_prepared_args := rt.create_array([
		rt.ArrayItem{ key: 'exclude', val: var_request.array_get(rt.new_string('exclude')) },
		rt.ArrayItem{ key: 'include', val: var_request.array_get(rt.new_string('include')) },
		rt.ArrayItem{ key: 'order', val: var_request.array_get(rt.new_string('order')) },
		rt.ArrayItem{ key: 'orderby', val: var_request.array_get(rt.new_string('orderby')) },
		rt.ArrayItem{ key: 'product', val: var_request.array_get(rt.new_string('product')) },
		rt.ArrayItem{ key: 'hide_empty', val: var_request.array_get(rt.new_string('hide_empty')) },
		rt.ArrayItem{ key: 'number', val: var_request.array_get(rt.new_string('per_page')) },
		rt.ArrayItem{ key: 'search', val: var_request.array_get(rt.new_string('search')) },
		rt.ArrayItem{ key: 'slug', val: var_request.array_get(rt.new_string('slug')) },
	])
	if !(!rt.is_true(var_request.array_get(rt.new_string('offset')))) {
		var_prepared_args.array_set('offset', var_request.array_get(rt.new_string('offset')))
	} else {
		var_prepared_args.array_set('offset', rt.mul(rt.sub(var_request.array_get(rt.new_string('page')),
			rt.new_int(1)), var_prepared_args.array_get(rt.new_string('number'))))
	}
	mut var_taxonomy_obj := rt.call_function('get_taxonomy', [
		var_taxonomy.clone()])
	if rt.is_true(rt.get_property(var_taxonomy_obj, 'hierarchical'))
		&& var_request.array_isset(rt.new_string('parent')) {
		if rt.is_true(rt.identical(rt.new_int(0), var_request.array_get(rt.new_string('parent')))) {
			var_prepared_args.array_set('parent', 0)
		} else {
			if rt.is_true(var_request.array_get(rt.new_string('parent'))) {
				var_prepared_args.array_set('parent',
					var_request.array_get(rt.new_string('parent')))
			}
		}
	}
	var_prepared_args = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_${var_taxonomy.to_string()}_query'),
		var_prepared_args.clone(),
		var_request.clone(),
	])
	if !(!rt.is_true(var_prepared_args.array_get(rt.new_string('product')))) {
		mut var_query_result := this.get_terms_for_product(var_prepared_args.clone(),
			var_request.clone())
		mut var_total_terms := rt.new_int(rt.get_property(rt.new_object('WC_REST_Terms_Controller', [
			'WC_REST_Controller',
		], &this), 'total_terms'))
	} else {
		var_query_result = rt.call_function('get_terms', [var_taxonomy.clone(),
			var_prepared_args.clone()])
		mut var_count_args := var_prepared_args.clone()
		var_count_args.array_unset(rt.new_string('number'))
		var_count_args.array_unset(rt.new_string('offset'))
		var_total_terms = rt.call_function('wp_count_terms', [
			var_taxonomy.clone(), var_count_args.clone()])
		if rt.is_true(var_prepared_args.array_get(rt.new_string('offset')))
			&& rt.is_true(rt.greater_equal(var_prepared_args.array_get(rt.new_string('offset')), var_total_terms)) {
			var_query_result = rt.new_array()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_total_terms)))) {
			var_total_terms = rt.new_int(0)
		}
	}
	mut var_response := rt.new_array()
	mut iter_1 := var_query_result.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_term := item_1.val
		mut var_data := this.prepare_item_for_response(var_term.clone(), var_request.clone())
		var_response.array_push(this.prepare_response_for_collection(var_data.clone()))
	}
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	mut var_per_page := rt.new_int((var_prepared_args.array_get(rt.new_string('number'))).to_i64())
	mut var_page := rt.call_function('ceil', [
		rt.add(rt.div(rt.new_int((var_prepared_args.array_get(rt.new_string('offset'))).to_i64()),
			var_per_page), rt.new_int(1)),
	])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int(var_total_terms.to_i64())])
	mut var_max_pages := rt.call_function('ceil', [rt.div(var_total_terms, var_per_page)])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int(var_max_pages.to_i64())])
	mut var_base := rt.call_function('str_replace', [
		rt.new_string('(?P<attribute_id>[\\d]+)'),
		if !(var_request.array_get(rt.new_string('attribute_id'))).is_null() {
			var_request.array_get(rt.new_string('attribute_id'))
		} else {
			rt.new_string('')
		},
		this.rest_base,
	])
	var_base = rt.call_function('add_query_arg', [
		rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}),
		rt.call_function('rest_url', [
			rt.new_string('/' +
				(rt.get_property(rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this), 'namespace')).str() +
				'/' + var_base.str()),
		]),
	])
	if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_page, rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
			var_prev_page = var_max_pages.clone()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_prev_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'),
			var_prev_link.clone()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_page)) {
		mut var_next_page := rt.add(var_page, rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_next_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'),
			var_next_link.clone()])
	}
	return var_response.clone()
}

fn (mut this Class_WC_REST_Terms_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_taxonomy := this.get_taxonomy(var_request.clone())
	mut var_name := var_request.array_get(rt.new_string('name'))
	mut var_args := rt.new_array()
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('description'))))
		&& var_request.array_isset(rt.new_string('description')) {
		var_args['description'] = var_request.array_get(rt.new_string('description'))
	}
	if var_request.array_isset(rt.new_string('slug')) {
		var_args['slug'] = var_request.array_get(rt.new_string('slug'))
	}
	if var_request.array_isset(rt.new_string('parent')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
			var_taxonomy.clone(),
		])))))
		{
			return create_wp_error(rt.new_string('woocommerce_rest_taxonomy_not_hierarchical'), rt.call_function('__', [
				rt.new_string('Can not set resource parent, taxonomy is not hierarchical.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		var_args['parent'] = var_request.array_get(rt.new_string('parent'))
	}
	mut var_term := rt.call_function('wp_insert_term', [var_name.clone(),
		var_taxonomy.clone(), rt.create_array_from_native_map(var_args)])
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		mut var_error_data := {
			'status': rt.new_int(400)
		}
		mut var_term_id := rt.call_method(var_term, 'get_error_data', [
			rt.new_string('term_exists'),
		])
		if rt.is_true(var_term_id) {
			var_error_data['resource_id'] = var_term_id.clone()
		}
		return create_wp_error(rt.call_method(var_term, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_term,
			'get_error_message', []rt.PhpVal{}), var_error_data.clone())
	}
	var_term = rt.call_function('get_term', [var_term.array_get(rt.new_string('term_id')),
		var_taxonomy.clone()])
	this.update_additional_fields_for_object(var_term.clone(), var_request.clone())
	mut var_meta_fields := rt.new_bool(this.update_term_meta_fields(var_term.clone(),
		var_request.clone()))
	if rt.is_true(rt.call_function('is_wp_error', [var_meta_fields.clone()])) {
		rt.call_function('wp_delete_term', [rt.get_property(var_term, 'term_id'),
			var_taxonomy.clone()])
		return var_meta_fields.clone()
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_rest_insert_${var_taxonomy.to_string()}'),
		var_term.clone(),
		var_request.clone(),
		rt.new_bool(true),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_term.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	mut var_base := rt.new_string('/' +
		(rt.get_property(rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this), 'namespace')).str() +
		'/' + (this.rest_base).str())
	if !(!rt.is_true(var_request.array_get(rt.new_string('attribute_id')))) {
		var_base = rt.call_function('str_replace', [
			rt.new_string('(?P<attribute_id>[\\d]+)'),
			rt.new_int((var_request.array_get(rt.new_string('attribute_id'))).to_i64()),
			var_base.clone(),
		])
	}
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.new_string(var_base.str() + '/' + (rt.get_property(var_term, 'term_id')).str()),
		])])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Terms_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_taxonomy := this.get_taxonomy(var_request.clone())
	mut var_term := rt.call_function('get_term', [
		rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()),
		var_taxonomy.clone(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return var_term.clone()
	}
	mut var_response := this.prepare_item_for_response(var_term.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WC_REST_Terms_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_taxonomy := this.get_taxonomy(var_request.clone())
	mut var_term := rt.call_function('get_term', [
		rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()),
		var_taxonomy.clone(),
	])
	mut var_schema := this.get_item_schema()
	mut var_prepared_args := rt.new_array()
	if var_request.array_isset(rt.new_string('name')) {
		var_prepared_args.array_set('name', var_request.array_get(rt.new_string('name')))
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('description'))))
		&& var_request.array_isset(rt.new_string('description')) {
		var_prepared_args.array_set('description',
			var_request.array_get(rt.new_string('description')))
	}
	if var_request.array_isset(rt.new_string('slug')) {
		var_prepared_args.array_set('slug', var_request.array_get(rt.new_string('slug')))
	}
	if var_request.array_isset(rt.new_string('parent')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
			var_taxonomy.clone(),
		])))))
		{
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_taxonomy_not_hierarchical'), rt.call_function('__', [
				rt.new_string('Can not set resource parent, taxonomy is not hierarchical.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
		var_prepared_args.array_set('parent', var_request.array_get(rt.new_string('parent')))
	}
	if !(!rt.is_true(var_prepared_args)) {
		mut var_update := rt.call_function('wp_update_term', [
			rt.get_property(var_term, 'term_id'),
			rt.get_property(var_term, 'taxonomy'),
			var_prepared_args.clone(),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_update.clone()])) {
			return var_update.clone()
		}
	}
	var_term = rt.call_function('get_term', [
		rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()),
		var_taxonomy.clone(),
	])
	this.update_additional_fields_for_object(var_term.clone(), var_request.clone())
	mut var_meta_fields := rt.new_bool(this.update_term_meta_fields(var_term.clone(),
		var_request.clone()))
	if rt.is_true(rt.call_function('is_wp_error', [var_meta_fields.clone()])) {
		return var_meta_fields.clone()
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_rest_insert_${var_taxonomy.to_string()}'),
		var_term.clone(),
		var_request.clone(),
		rt.new_bool(false),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_term.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WC_REST_Terms_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_taxonomy := this.get_taxonomy(var_request.clone())
	mut var_force := rt.new_bool(if var_request.array_isset(rt.new_string('force')) {
		(var_request.array_get(rt.new_string('force'))).to_bool()
	} else {
		false
	})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_force)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_trash_not_supported'), rt.call_function('__', [
			rt.new_string('Resource does not support trashing.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }]))
	}
	mut var_term := rt.call_function('get_term', [
		rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()),
		var_taxonomy.clone(),
	])
	mut var_default_category_id := rt.call_function('absint', [
		rt.call_function('get_option', [rt.new_string('default_product_cat'),
			rt.new_int(0)]),
	])
	if rt.is_true(rt.identical(var_default_category_id,
		rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())))
	{
		return create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('Default product category cannot be deleted.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_term.clone(), var_request.clone())
	mut var_retval := rt.call_function('wp_delete_term', [
		rt.get_property(var_term, 'term_id'),
		rt.get_property(var_term, 'taxonomy'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_retval)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('The resource cannot be deleted.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_AssignDefaultCategory.class(),
	]), 'schedule_action', []rt.PhpVal{})
	rt.call_function('do_action', [
		rt.new_string('woocommerce_rest_delete_${var_taxonomy.to_string()}'),
		var_term.clone(),
		var_response.clone(),
		var_request.clone(),
	])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Terms_Controller) prepare_links(var_term rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_term_mutated := var_term
	mut var_base := rt.new_string('/' +
		(rt.get_property(rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this), 'namespace')).str() +
		'/' + (this.rest_base).str())
	if !(!rt.is_true(var_request.array_get(rt.new_string('attribute_id')))) {
		var_base = rt.call_function('str_replace', [
			rt.new_string('(?P<attribute_id>[\\d]+)'),
			rt.new_int((var_request.array_get(rt.new_string('attribute_id'))).to_i64()),
			var_base.clone(),
		])
	}
	mut var_links := {
		'self':       {
			'href': rt.call_function('rest_url', [
				rt.new_string((rt.call_function('trailingslashit', [var_base.clone()])).str() +
					(rt.get_property(var_term_mutated, 'term_id')).str()),
			])
		}
		'collection': {
			'href': rt.call_function('rest_url', [var_base.clone()])
		}
	}
	if rt.is_true(rt.get_property(var_term_mutated, 'parent')) {
		mut var_parent_term := rt.call_function('get_term', [
			rt.new_int((rt.get_property(var_term_mutated, 'parent')).to_i64()),
			rt.get_property(var_term_mutated, 'taxonomy'),
		])
		if rt.is_true(var_parent_term) {
			var_links['up'] = rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
					rt.new_string((rt.call_function('trailingslashit', [var_base.clone()])).str() +
						(rt.get_property(var_parent_term, 'term_id')).str()),
				]) },
			])
		}
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_Terms_Controller) update_term_meta_fields(var_term rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_term_mutated := var_term
	return true
}

fn (mut this Class_WC_REST_Terms_Controller) get_terms_for_product(var_prepared_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_args_mutated := var_prepared_args
	mut var_taxonomy := this.get_taxonomy(var_request.clone())
	mut var_query_result := rt.call_function('get_the_terms', [
		var_prepared_args_mutated.array_get(rt.new_string('product')),
		var_taxonomy.clone(),
	])
	if !rt.is_true(var_query_result) {
		this.dispatch_set_prop('total_terms', rt.new_int(0))
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_prepared_args_mutated.array_get(rt.new_string('orderby')),
		rt.create_array([rt.ArrayItem{ key: none, val: 'name' },
			rt.ArrayItem{ key: none, val: 'none' }, rt.ArrayItem{ key: none, val: 'include' }]),
		rt.new_bool(true),
	])))))
	{
		mut switch_val_1 := var_prepared_args_mutated.array_get(rt.new_string('orderby'))
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('id'))) {
			this.dispatch_set_prop('sort_column', rt.new_string('term_id'))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('slug')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('term_group')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('description')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('count'))) {
			this.dispatch_set_prop('sort_column',
				var_prepared_args_mutated.array_get(rt.new_string('orderby')))
		}
		rt.call_function('usort', [var_query_result.clone(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'compare_terms' },
			])])
	}
	if rt.is_true(rt.new_bool(var_prepared_args_mutated.array_get(rt.new_string('order')).to_string().to_lower() != 'asc')) {
		var_query_result = rt.call_function('array_reverse', [
			var_query_result.clone()])
	}
	this.dispatch_set_prop('total_terms', rt.new_int(var_query_result.clone().array_count()))
	var_query_result = rt.call_function('array_slice', [var_query_result.clone(),
		var_prepared_args_mutated.array_get(rt.new_string('offset')),
		var_prepared_args_mutated.array_get(rt.new_string('number'))])
	return var_query_result.clone()
}

fn (mut this Class_WC_REST_Terms_Controller) compare_terms(var_left rt.PhpVal, var_right rt.PhpVal) rt.PhpVal {
	mut var_col := rt.get_property(rt.new_object('WC_REST_Terms_Controller', [
		'WC_REST_Controller',
	], &this), 'sort_column')
	mut var_left_val := rt.get_property(var_left,
		'{"nodeType":"Expr_Variable","line":688,"name":"col"}')
	mut var_right_val := rt.get_property(var_right,
		'{"nodeType":"Expr_Variable","line":689,"name":"col"}')
	if var_left_val.clone().is_long() && var_right_val.clone().is_long() {
		return rt.sub(var_left_val, var_right_val)
	}
	return rt.call_function('strcmp', [var_left_val.clone(), var_right_val.clone()])
}

fn (mut this Class_WC_REST_Terms_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_Controller.get_collection_params()
	var_params.array_get_mut('context').array_set('default', 'view')
	var_params.array_set('exclude', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Ensure result set excludes specific IDs.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
	]))
	var_params.array_set('include', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to specific ids.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
	]))
	var_params.array_set('offset', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Offset the result set by a specific number of items. Applies to hierarchical taxonomies only.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('order', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Order sort attribute ascending or descending.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'default', val: 'asc' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'asc' },
			rt.ArrayItem{ key: none, val: 'desc' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('orderby', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Sort collection by resource attribute.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'default', val: 'name' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'include' },
			rt.ArrayItem{ key: none, val: 'name' },
			rt.ArrayItem{ key: none, val: 'slug' },
			rt.ArrayItem{ key: none, val: 'term_group' },
			rt.ArrayItem{ key: none, val: 'description' },
			rt.ArrayItem{ key: none, val: 'count' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('hide_empty', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Whether to hide resources not assigned to any products.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'boolean' },
		rt.ArrayItem{ key: 'default', val: false },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('parent', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to resources assigned to a specific parent. Applies to hierarchical taxonomies only.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('product', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to resources assigned to a specific product.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: rt.new_null() },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('slug', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to resources with a specific slug.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'string' },
			rt.ArrayItem{ key: none, val: 'array' },
		]) },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
}

fn (mut this Class_WC_REST_Terms_Controller) get_taxonomy(var_request rt.PhpVal) rt.PhpVal {
	mut var_attribute_id := var_request.array_get(rt.new_string('attribute_id'))
	if !rt.is_true(var_attribute_id) {
		return this.taxonomy
	}
	if this.taxonomies_by_id.array_isset(var_attribute_id) {
		return this.taxonomies_by_id.array_get(var_attribute_id)
	}
	mut var_taxonomy := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [
		rt.new_string('wc_attribute_taxonomy_name_by_id'),
		rt.new_int((var_request.array_get(rt.new_string('attribute_id'))).to_i64()),
	])
	if !(!rt.is_true(var_taxonomy)) {
		this.taxonomy = var_taxonomy.clone()
		this.taxonomies_by_id.array_set(var_attribute_id, var_taxonomy.clone())
	}
	return var_taxonomy.clone()
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_terms_controller(_args ...rt.PhpVal) &Class_WC_REST_Terms_Controller {
	mut obj := &Class_WC_REST_Terms_Controller{
		PhpObjectBase:    rt.PhpObjectBase{}
		rest_base:        rt.new_string('')
		taxonomy:         rt.new_string('')
		taxonomies_by_id: rt.new_array()
	}
	return obj
}

fn create_wc_rest_controller(_args ...rt.PhpVal) &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
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

fn (mut this Class_WC_REST_Terms_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.create_item_permissions_check(dispatch_arg_0))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_item_permissions_check(dispatch_arg_0))
		}
		'batch_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.batch_items_permissions_check(dispatch_arg_0))
		}
		'check_permissions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.check_permissions(dispatch_arg_0, dispatch_arg_1)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0, dispatch_arg_1)
		}
		'update_term_meta_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_term_meta_fields(dispatch_arg_0, dispatch_arg_1))
		}
		'get_terms_for_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_terms_for_product(dispatch_arg_0, dispatch_arg_1)
		}
		'compare_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.compare_terms(dispatch_arg_0, dispatch_arg_1)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_taxonomy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_taxonomy(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Terms_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'taxonomy' { return this.taxonomy }
		'taxonomies_by_id' { return this.taxonomies_by_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Terms_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' {
			this.rest_base = val
			return true
		}
		'taxonomy' {
			this.taxonomy = val
			return true
		}
		'taxonomies_by_id' {
			this.taxonomies_by_id = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
