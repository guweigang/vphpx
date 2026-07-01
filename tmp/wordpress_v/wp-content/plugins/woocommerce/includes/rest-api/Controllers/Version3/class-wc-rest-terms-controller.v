import rt

struct Class_WC_REST_Terms_Controller {
	rt.PhpObjectBase
pub mut:
		rest_base rt.PhpVal = rt.new_string('')
		taxonomy rt.PhpVal = rt.new_string('')
		taxonomies_by_id rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_REST_Terms_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this), 'namespace'), '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()), rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Name for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: true }]) }])]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this), 'namespace'), '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Required to be true, as resource does not support trashing.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this), 'namespace'), '/' + (this.rest_base).str() + '/batch', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
}

fn (mut this Class_WC_REST_Terms_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_permissions := this.check_permissions(var_request.dup(), 'read')
	if rt.is_true(rt.call_function('is_wp_error', [var_permissions.dup()])) {
		return (var_permissions).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permissions)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Terms_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_permissions := this.check_permissions(var_request.dup(), 'create')
	if rt.is_true(rt.call_function('is_wp_error', [var_permissions.dup()])) {
		return (var_permissions).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permissions)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Terms_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_permissions := this.check_permissions(var_request.dup(), 'read')
	if rt.is_true(rt.call_function('is_wp_error', [var_permissions.dup()])) {
		return (var_permissions).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permissions)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Terms_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_permissions := this.check_permissions(var_request.dup(), 'edit')
	if rt.is_true(rt.call_function('is_wp_error', [var_permissions.dup()])) {
		return (var_permissions).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permissions)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Terms_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_permissions := this.check_permissions(var_request.dup(), 'delete')
	if rt.is_true(rt.call_function('is_wp_error', [var_permissions.dup()])) {
		return (var_permissions).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permissions)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Terms_Controller) batch_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_permissions := this.check_permissions(var_request.dup(), 'batch')
	if rt.is_true(rt.call_function('is_wp_error', [var_permissions.dup()])) {
		return (var_permissions).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permissions)))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_batch'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to batch manipulate this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Terms_Controller) check_permissions(var_request rt.PhpVal, context string) rt.PhpVal {
	mut var_taxonomy := this.get_taxonomy(var_request.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomy)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy.dup()]))))))) {
		return create_wp_error(rt.new_string('woocommerce_rest_taxonomy_invalid'), rt.call_function('__', [rt.new_string('Taxonomy does not exist.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_id := rt.new_int(rt.new_int(var_request.array_get('id').to_i64()))
	if rt.is_true(var_id) {
		mut var_term := rt.call_function('get_term', [var_id.dup(), var_taxonomy.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])) || rt.is_true(rt.new_bool(!(rt.is_true(var_term)))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return create_wp_error(rt.new_string('woocommerce_rest_term_invalid'), rt.call_function('__', [rt.new_string('Resource does not exist.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
		}
		return rt.call_function('wc_rest_check_product_term_permissions', [var_taxonomy.dup(), rt.new_string(context), rt.get_property(var_term, 'term_id')])
	}
	return rt.call_function('wc_rest_check_product_term_permissions', [var_taxonomy.dup(), rt.new_string(context)])
}

fn (mut this Class_WC_REST_Terms_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_taxonomy := this.get_taxonomy(var_request.dup())
	mut var_prepared_args := rt.create_array([rt.ArrayItem{ key: 'exclude', val: var_request.array_get('exclude') }, rt.ArrayItem{ key: 'include', val: var_request.array_get('include') }, rt.ArrayItem{ key: 'order', val: var_request.array_get('order') }, rt.ArrayItem{ key: 'orderby', val: var_request.array_get('orderby') }, rt.ArrayItem{ key: 'product', val: var_request.array_get('product') }, rt.ArrayItem{ key: 'hide_empty', val: var_request.array_get('hide_empty') }, rt.ArrayItem{ key: 'number', val: var_request.array_get('per_page') }, rt.ArrayItem{ key: 'search', val: var_request.array_get('search') }, rt.ArrayItem{ key: 'slug', val: var_request.array_get('slug') }])
	if !(!rt.is_true(var_request.array_get('offset'))) {
		var_prepared_args.array_set('offset', var_request.array_get('offset'))
	} else {
		var_prepared_args.array_set('offset', rt.mul(rt.sub(var_request.array_get('page'), rt.new_int(1)), var_prepared_args.array_get('number')))
	}
	mut var_taxonomy_obj := rt.call_function('get_taxonomy', [var_taxonomy.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_taxonomy_obj, 'hierarchical')) && var_request.array_isset(rt.new_string('parent')))) {
		if rt.is_true(rt.identical(rt.new_int(0), var_request.array_get('parent'))) {
			var_prepared_args.array_set('parent', 0)
		} else {
			if rt.is_true(var_request.array_get('parent')) {
				var_prepared_args.array_set('parent', var_request.array_get('parent'))
			}
		}
	}
	var_prepared_args = rt.call_function('apply_filters', [rt.new_string("woocommerce_rest_${var_taxonomy.to_string()}_query"), var_prepared_args.dup(), var_request.dup()])
	if !(!rt.is_true(var_prepared_args.array_get('product'))) {
		mut var_query_result := this.get_terms_for_product(var_prepared_args.dup(), var_request.dup())
		mut var_total_terms := rt.new_int(rt.get_property(rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this), 'total_terms'))
	} else {
		var_query_result = rt.call_function('get_terms', [var_taxonomy.dup(), var_prepared_args.dup()])
		mut var_count_args := var_prepared_args.dup()
		var_count_args.array_unset(rt.new_string('number'))
		var_count_args.array_unset(rt.new_string('offset'))
		var_total_terms = rt.call_function('wp_count_terms', [var_taxonomy.dup(), var_count_args.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(var_prepared_args.array_get('offset')) && rt.is_true(rt.greater_equal(var_prepared_args.array_get('offset'), var_total_terms)))) {
			var_query_result = rt.new_array()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_total_terms)))) {
			var_total_terms = rt.new_int(rt.new_int(0))
		}
	}
	mut var_response := rt.new_array()
	{
		mut iter_1 := var_query_result.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			mut var_data := this.prepare_item_for_response(var_term.dup(), var_request.dup())
			var_response.array_push(this.prepare_response_for_collection(var_data.dup()))
		}
	}
	var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	mut var_per_page := // unsupported expression: Expr_Cast_Int
	mut var_page := rt.call_function('ceil', [rt.add(rt.div(// unsupported expression: Expr_Cast_Int, var_per_page), rt.new_int(1))])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), // unsupported expression: Expr_Cast_Int])
	mut var_max_pages := rt.call_function('ceil', [rt.div(var_total_terms, var_per_page)])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), // unsupported expression: Expr_Cast_Int])
	mut var_base := rt.call_function('str_replace', [rt.new_string('(?P<attribute_id>[\\d]+)'), if !(var_request.array_get('attribute_id')).is_null() { var_request.array_get('attribute_id') } else { rt.new_string('') }, this.rest_base])
	var_base = rt.call_function('add_query_arg', [rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}), rt.call_function('rest_url', ['/' + (rt.get_property(rt.new_object('WC_REST_Terms_Controller', ['WC_REST_Controller'], &this), 'namespace')).str() + '/' + (var_base).str()])])
	if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_page, rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
			var_prev_page = var_max_pages.dup()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_prev_page.dup(), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'), var_prev_link.dup()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_page)) {
		mut var_next_page := rt.add(var_page, rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_next_page.dup(), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'), var_next_link.dup()])
	}
	return var_response.dup()
}

fn (mut this Class_WC_REST_Terms_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_taxonomy := this.get_taxonomy(var_request.dup())
	mut var_name := var_request.array_get('name')
	mut var_args := rt.new_array()
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get('properties').array_get('description'))) && var_request.array_isset(rt.new_string('description')) {
		var_args['description'] = var_request.array_get('description')
	}
	if var_request.array_isset(rt.new_string('slug')) {
		var_args['slug'] = var_request.array_get('slug')
	}
	if var_request.array_isset(rt.new_string('parent')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [var_taxonomy.dup()]))))) {
			return create_wp_error(rt.new_string('woocommerce_rest_taxonomy_not_hierarchical'), rt.call_function('__', [rt.new_string('Can not set resource parent, taxonomy is not hierarchical.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		var_args['parent'] = var_request.array_get('parent')
	}
	mut var_term := rt.call_function('wp_insert_term', [var_name.dup(), var_taxonomy.dup(), var_args.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])) {
		mut var_error_data := { 'status': rt.new_int(400) }
		mut var_term_id := rt.call_method(var_term, 'get_error_data', [rt.new_string('term_exists')])
		if rt.is_true(var_term_id) {
			var_error_data['resource_id'] = var_term_id.dup()
		}
		return create_wp_error(rt.call_method(var_term, 'get_error_code', []rt.PhpVal{}), rt.call_method(var_term, 'get_error_message', []rt.PhpVal{}), var_error_data.dup())
	}
	var_term = rt.call_function('get_term', [var_term.array_get('term_id'), var_taxonomy.dup()])
	this.update_additional_fields_for_object(var_term.dup(), var_request.dup())
	mut var_meta_fields := rt.new_bool(this.update_term_meta_fields(var_term.dup(), var_request.dup()))
	if rt.is_true(rt.call_function('is_wp_error', [var_meta_fields.dup()])) {
		rt.call_function('wp_delete_term', [rt.get_property(var_term, 'term_id'), var_taxonomy.dup()])
		return var_meta_fields.dup()
	}
	rt.call_function('do_action', [rt.new_string("woocommerce_rest_insert_${var_taxonomy.to_string()}"), var_term.dup(), var_request.dup(), rt.new_bool(true)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_term.dup(), var_request.dup())
	var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	mut var_base := rt.new_string( + ().str())
	if !(!rt.is_true(.array_get())) {
		
	}
	
}

fn (mut this Class_WC_REST_Terms_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Terms_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Terms_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Terms_Controller) prepare_links(var_term rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_term_mutated := var_term
}

fn (mut this Class_WC_REST_Terms_Controller) update_term_meta_fields(var_term rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_term_mutated := var_term
}

fn (mut this Class_WC_REST_Terms_Controller) get_terms_for_product(var_prepared_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_args_mutated := var_prepared_args
}

fn (mut this Class_WC_REST_Terms_Controller) compare_terms(var_left rt.PhpVal, var_right rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Terms_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WC_REST_Terms_Controller) get_taxonomy(var_request rt.PhpVal) rt.PhpVal {
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_terms_controller() &Class_WC_REST_Terms_Controller {
	mut obj := &Class_WC_REST_Terms_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base: rt.new_string('')
		taxonomy: rt.new_string('')
		taxonomies_by_id: rt.new_array()
	}
	return obj
}

fn create_wc_rest_controller() &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
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
		else { return none }
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
		'rest_base' { this.rest_base = val; return true }
		'taxonomy' { this.taxonomy = val; return true }
		'taxonomies_by_id' { this.taxonomies_by_id = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_terms_controller_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
