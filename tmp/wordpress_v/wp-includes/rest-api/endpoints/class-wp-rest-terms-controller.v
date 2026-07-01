import rt

struct Class_WP_REST_Terms_Controller {
	rt.PhpObjectBase
pub mut:
		taxonomy rt.PhpVal = rt.new_null()
		meta rt.PhpVal = rt.new_null()
		sort_column rt.PhpVal = rt.new_null()
		total_terms rt.PhpVal = rt.new_null()
		allow_batch rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_REST_Terms_Controller) construct(var_taxonomy rt.PhpVal)  {
	mut var_taxonomy_mutated := var_taxonomy
	this.taxonomy = var_taxonomy_mutated.dup()
	mut var_tax_obj := rt.call_function('get_taxonomy', [var_taxonomy_mutated.dup()])
	this.dispatch_set_prop('rest_base', if !(!rt.is_true(rt.get_property(var_tax_obj, 'rest_base'))) { rt.get_property(var_tax_obj, 'rest_base') } else { rt.get_property(var_tax_obj, 'name') })
	this.dispatch_set_prop('namespace', if !(!rt.is_true(rt.get_property(var_tax_obj, 'rest_namespace'))) { rt.get_property(var_tax_obj, 'rest_namespace') } else { rt.new_string('wp/v2') })
	this.meta = create_wp_rest_term_meta_fields(var_taxonomy_mutated.dup())
}

fn (mut this Class_WP_REST_Terms_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this), 'rest_base')).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this), 'rest_base')).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the term.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Required to be true, as terms do not support trashing.')]) }]) }]) }]) }, rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Terms_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Terms_Controller) check_read_terms_permission_for_post(var_post rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_post_mutated := var_post
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_object_in_taxonomy', [rt.get_property(var_post_mutated, 'post_type'), this.taxonomy]))))) {
		return false
	}
	if rt.is_true(rt.call_function('is_post_publicly_viewable', [var_post_mutated.dup()])) {
		return true
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_post_mutated, 'ID')])) {
		return true
	}
	return false
}

fn (mut this Class_WP_REST_Terms_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_tax_obj := rt.call_function('get_taxonomy', [this.taxonomy])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_tax_obj)))) || !(this.check_is_taxonomy_allowed(this.taxonomy)))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get('context'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_tax_obj, 'cap'), 'edit_terms')]))))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit terms in this taxonomy.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if !(!rt.is_true(var_request.array_get('post'))) {
		mut var_post := rt.call_function('get_post', [var_request.array_get('post')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
			return (create_wp_error(rt.new_string('rest_post_invalid_id'), rt.call_function('__', [rt.new_string('Invalid post ID.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
		if !(this.check_read_terms_permission_for_post(var_post.dup(), var_request.dup())) {
			return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to view terms for this post.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
		}
	}
	return true
}

fn (mut this Class_WP_REST_Terms_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_registered := this.get_collection_params()
	mut var_parameter_mappings := { 'exclude': 'exclude', 'include': 'include', 'order': 'order', 'orderby': 'orderby', 'post': 'post', 'hide_empty': 'hide_empty', 'per_page': 'number', 'search': 'search', 'slug': 'slug' }
	mut var_prepared_args := rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: this.taxonomy }])
	for var_api_param, var_wp_param in var_parameter_mappings {
		if var_registered.array_isset(rt.new_string(api_param)) && var_request.array_isset(rt.new_string(api_param)) {
			var_prepared_args.array_set(wp_param, var_request.array_get(api_param))
		}
	}
	if var_prepared_args.array_isset(rt.new_string('orderby')) && var_request.array_isset(rt.new_string('orderby')) {
		mut var_orderby_mappings := rt.create_array([rt.ArrayItem{ key: 'include_slugs', val: 'slug__in' }])
		if var_orderby_mappings.array_isset(var_request.array_get('orderby')) {
			var_prepared_args.array_set('orderby', var_orderby_mappings.array_get(var_request.array_get('orderby')))
		}
	}
	if var_registered.array_isset(rt.new_string('offset')) && !(!rt.is_true(var_request.array_get('offset'))) {
		var_prepared_args.array_set('offset', var_request.array_get('offset'))
	} else {
		var_prepared_args.array_set('offset', rt.mul(rt.sub(var_request.array_get('page'), rt.new_int(1)), var_prepared_args.array_get('number')))
	}
	mut var_taxonomy_obj := rt.call_function('get_taxonomy', [this.taxonomy])
	if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_taxonomy_obj, 'hierarchical')) && var_registered.array_isset(rt.new_string('parent')) && var_request.array_isset(rt.new_string('parent')))) {
		if rt.is_true(rt.identical(rt.new_int(0), var_request.array_get('parent'))) {
			var_prepared_args.array_set('parent', 0)
		} else {
			if rt.is_true(var_request.array_get('parent')) {
				var_prepared_args.array_set('parent', var_request.array_get('parent'))
			}
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_prepared_args.array_get('post')) && !(rt.get_property(var_taxonomy_obj, 'args')).is_null() && rt.is_true(rt.new_bool(rt.get_property(var_taxonomy_obj, 'args').is_array())))) {
		var_prepared_args = rt.call_function('array_merge', [var_prepared_args.dup(), rt.get_property(var_taxonomy_obj, 'args')])
	}
	mut var_is_head_request := rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])
	if rt.is_true(var_is_head_request) {
		var_prepared_args.array_set('fields', 'ids')
		var_prepared_args.array_set('update_term_meta_cache', false)
	}
	var_prepared_args = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('rest_'), this.taxonomy), rt.new_string('_query')), var_prepared_args.dup(), var_request.dup()])
	if !(!rt.is_true(var_prepared_args.array_get('post'))) {
		mut var_query_result := rt.call_function('wp_get_object_terms', [var_prepared_args.array_get('post'), this.taxonomy, var_prepared_args.dup()])
		var_prepared_args.array_set('object_ids', var_prepared_args.array_get('post'))
	} else {
		var_query_result = rt.call_function('get_terms', [var_prepared_args.dup()])
	}
	mut var_count_args := var_prepared_args.dup()
	var_count_args.array_unset(rt.new_string('number'))
	var_count_args.array_unset(rt.new_string('offset'))
	mut var_total_terms := rt.call_function('wp_count_terms', [var_count_args.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_total_terms)))) {
		var_total_terms = rt.new_int(rt.new_int(0))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_head_request)))) {
		mut var_response := rt.new_array()
		{
			mut iter_1 := var_query_result.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_term := item_1.val
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get('context'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_term'), rt.get_property(var_term, 'term_id')]))))))) {
					continue
				}
				mut var_data := this.prepare_item_for_response(var_term.dup(), var_request.dup())
				var_response.array_push(this.prepare_response_for_collection(var_data.dup()))
			}
		}
	}
	var_response = if rt.is_true(var_is_head_request) { create_wp_rest_response(rt.new_array()) } else { rt.call_function('rest_ensure_response', [var_response.dup()]) }
	mut var_per_page := // unsupported expression: Expr_Cast_Int
	mut var_page := // unsupported expression: Expr_Cast_Int
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), // unsupported expression: Expr_Cast_Int])
	mut var_max_pages := // unsupported expression: Expr_Cast_Int
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), var_max_pages.dup()])
	mut var_request_params := rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})
	mut var_collection_url := rt.call_function('rest_url', [rt.call_function('rest_get_route_for_taxonomy_items', [this.taxonomy])])
	mut var_base := rt.call_function('add_query_arg', [rt.call_function('urlencode_deep', [var_request_params.dup()]), var_collection_url.dup()])
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

fn (mut this Class_WP_REST_Terms_Controller) get_term(var_id rt.PhpVal) rt.PhpVal {
	mut var_error := create_wp_error(rt.new_string('rest_term_invalid'), rt.call_function('__', [rt.new_string('Term does not exist.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	if !(this.check_is_taxonomy_allowed(this.taxonomy)) {
		return rt.new_object('WP_Error', []string{}, var_error)
	}
	if rt.is_true(rt.less_equal(// unsupported expression: Expr_Cast_Int, rt.new_int(0))) {
		return rt.new_object('WP_Error', []string{}, var_error)
	}
	mut var_term := rt.call_function('get_term', [// unsupported expression: Expr_Cast_Int, this.taxonomy])
	if rt.is_true(rt.new_bool(!rt.is_true(var_term) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_object('WP_Error', []string{}, var_error)
	}
	return var_term.dup()
}

fn (mut this Class_WP_REST_Terms_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_term := this.get_term(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])) {
		return var_term.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get('context'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_term'), rt.get_property(var_term, 'term_id')]))))))) {
		return create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this term.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))
	}
	return rt.new_bool(true)
}

fn (mut this Class_WP_REST_Terms_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_term := this.get_term(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])) {
		return var_term.dup()
	}
	mut var_response := this.prepare_item_for_response(var_term.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_WP_REST_Terms_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	if !(this.check_is_taxonomy_allowed(this.taxonomy)) {
		return false
	}
	mut var_taxonomy_obj := rt.call_function('get_taxonomy', [this.taxonomy])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [this.taxonomy])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_taxonomy_obj, 'cap'), 'edit_terms')]))))))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [this.taxonomy]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_taxonomy_obj, 'cap'), 'assign_terms')]))))))))) {
		return (create_wp_error(rt.new_string('rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create terms in this taxonomy.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Terms_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if var_request.array_isset(rt.new_string('parent')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_taxonomy_hierarchical', [this.taxonomy]))))) {
			return create_wp_error(rt.new_string('rest_taxonomy_not_hierarchical'), rt.call_function('__', [rt.new_string('Cannot set parent term, taxonomy is not hierarchical.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		mut var_parent := rt.call_function('get_term', [// unsupported expression: Expr_Cast_Int, this.taxonomy])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_parent)))) {
			return create_wp_error(rt.new_string('rest_term_invalid'), rt.call_function('__', [rt.new_string('Parent term does not exist.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
	}
	mut var_prepared_term := this.prepare_item_for_database(var_request.dup())
	mut var_term := rt.call_function('wp_insert_term', [rt.call_function('wp_slash', [rt.get_property(var_prepared_term, 'name')]), this.taxonomy, rt.call_function('wp_slash', [rt.cast_array(var_prepared_term)])])
	if rt.is_true(rt.call_function('is_wp_error', [var_term.dup()])) {
		mut var_term_id := rt.call_method(var_term, 'get_error_data', [rt.new_string('term_exists')])
		if rt.is_true(var_term_id) {
			mut var_existing_term := rt.call_function('get_term', [var_term_id.dup(), this.taxonomy])
			rt.call_method(var_term, 'add_data', [rt.get_property(var_existing_term, 'term_id'), rt.new_string('term_exists')])
			rt.call_method(var_term, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }, rt.ArrayItem{ key: 'term_id', val: var_term_id }])])
		}
		return var_term.dup()
	}
	var_term = rt.call_function('get_term', [var_term.array_get('term_id'), this.taxonomy])
	rt.call_function('do_action', [rt.concat(rt.new_string('rest_insert_'), this.taxonomy), var_term.dup(), var_request.dup(), rt.new_bool(true)])
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get('properties').array_get('meta'))) && var_request.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(, 'update_value', [, ])
		if rt.is_true(rt.call_function('is_wp_error', [.dup()])) {
			return .dup()
		}
	}
	mut var_fields_update := 
	if rt.is_true() {
	}
	
}

fn (mut this Class_WP_REST_Terms_Controller) update_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Terms_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Terms_Controller) delete_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Terms_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Terms_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Terms_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Terms_Controller) prepare_links(var_term rt.PhpVal) rt.PhpVal {
	mut var_term_mutated := var_term
}

fn (mut this Class_WP_REST_Terms_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WP_REST_Terms_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WP_REST_Terms_Controller) check_is_taxonomy_allowed(var_taxonomy rt.PhpVal) bool {
	mut var_taxonomy_mutated := var_taxonomy
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Term_Meta_Fields {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_terms_controller(arg_0 rt.PhpVal) &Class_WP_REST_Terms_Controller {
	mut obj := &Class_WP_REST_Terms_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		taxonomy: rt.new_null()
		meta: rt.new_null()
		sort_column: rt.new_null()
		total_terms: rt.new_null()
		allow_batch: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_rest_controller() &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_term_meta_fields() &Class_WP_REST_Term_Meta_Fields {
	mut obj := &Class_WP_REST_Term_Meta_Fields{
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

fn create_wp_rest_response() &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Terms_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'check_read_terms_permission_for_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.check_read_terms_permission_for_post(dispatch_arg_0, dispatch_arg_1))
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_term' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_term(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.create_item_permissions_check(dispatch_arg_0))
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item_permissions_check(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item_permissions_check(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'check_is_taxonomy_allowed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_is_taxonomy_allowed(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Terms_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'taxonomy' { return this.taxonomy }
		'meta' { return this.meta }
		'sort_column' { return this.sort_column }
		'total_terms' { return this.total_terms }
		'allow_batch' { return this.allow_batch }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Terms_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'taxonomy' { this.taxonomy = val; return true }
		'meta' { this.meta = val; return true }
		'sort_column' { this.sort_column = val; return true }
		'total_terms' { this.total_terms = val; return true }
		'allow_batch' { this.allow_batch = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Term_Meta_Fields) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Term_Meta_Fields) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Term_Meta_Fields) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_terms_controller_php() {
}
