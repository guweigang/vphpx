import rt

struct Class_WP_REST_Revisions_Controller {
	rt.PhpObjectBase
pub mut:
		parent_post_type rt.PhpVal = rt.new_null()
		meta rt.PhpVal = rt.new_null()
		parent_controller rt.PhpVal = rt.new_null()
		parent_base rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Revisions_Controller) construct(var_parent_post_type rt.PhpVal)  {
	this.parent_post_type = var_parent_post_type.dup()
	mut var_post_type_object := rt.call_function('get_post_type_object', [var_parent_post_type.dup()])
	mut var_parent_controller := rt.call_method(var_post_type_object, 'get_rest_controller', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parent_controller)))) {
		var_parent_controller = create_wp_rest_posts_controller(var_parent_post_type.dup())
	}
	this.parent_controller = var_parent_controller.dup()
	this.dispatch_set_prop('rest_base', rt.new_string('revisions'))
	this.parent_base = if !(!rt.is_true(rt.get_property(var_post_type_object, 'rest_base'))) { rt.get_property(var_post_type_object, 'rest_base') } else { rt.get_property(var_post_type_object, 'name') }
	this.dispatch_set_prop('namespace', if !(!rt.is_true(rt.get_property(var_post_type_object, 'rest_namespace'))) { rt.get_property(var_post_type_object, 'rest_namespace') } else { rt.new_string('wp/v2') })
	this.meta = create_wp_rest_post_meta_fields(var_parent_post_type.dup())
}

fn (mut this Class_WP_REST_Revisions_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + (this.parent_base).str() + '/(?P<parent>[\\d]+)/' + rt.get_property(rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID for the parent of the revision.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + (this.parent_base).str() + '/(?P<parent>[\\d]+)/' + rt.get_property(rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this), 'rest_base') + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID for the parent of the revision.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the revision.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Required to be true, as revisions do not support trashing.')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Revisions_Controller) get_parent(var_parent_post_id rt.PhpVal) rt.PhpVal {
	mut var_error := create_wp_error(rt.new_string('rest_post_invalid_parent'), rt.call_function('__', [rt.new_string('Invalid post parent ID.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	if rt.is_true(rt.less_equal(// unsupported expression: Expr_Cast_Int, rt.new_int(0))) {
		return mut var_error
	}
	mut var_parent_post := rt.call_function('get_post', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(!rt.is_true(var_parent_post) || !rt.is_true(rt.get_property(var_parent_post, 'ID')) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return mut var_error
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_parent_post)
}

fn (mut this Class_WP_REST_Revisions_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_parent := this.get_parent(var_request.array_get('parent'))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent.dup()])) {
		return (var_parent).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_parent, 'ID')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_read'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to view revisions of this post.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Revisions_Controller) get_revision(var_id rt.PhpVal) rt.PhpVal {
	mut var_error := create_wp_error(rt.new_string('rest_post_invalid_id'), rt.call_function('__', [rt.new_string('Invalid revision ID.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	if rt.is_true(rt.less_equal(// unsupported expression: Expr_Cast_Int, rt.new_int(0))) {
		return mut var_error
	}
	mut var_revision := rt.call_function('get_post', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(!rt.is_true(var_revision) || !rt.is_true(rt.get_property(var_revision, 'ID')) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return mut var_error
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_revision)
}

fn (mut this Class_WP_REST_Revisions_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_parent := this.get_parent(var_request.array_get('parent'))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent.dup()])) {
		return var_parent.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_request.array_get('orderby'))) && rt.is_true(rt.identical(rt.new_string('relevance'), var_request.array_get('orderby'))))) && !rt.is_true(var_request.array_get('search')))) {
		return create_wp_error(rt.new_string('rest_no_search_term_defined'), rt.call_function('__', [rt.new_string('You need to define a search term to order by relevance.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_request.array_get('orderby'))) && rt.is_true(rt.identical(rt.new_string('include'), var_request.array_get('orderby'))))) && !rt.is_true(var_request.array_get('include')))) {
		return create_wp_error(rt.new_string('rest_orderby_include_missing_include'), rt.call_function('__', [rt.new_string('You need to define an include parameter to order by include.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_is_head_request := rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])
	if rt.is_true(rt.call_function('wp_revisions_enabled', [var_parent.dup()])) {
		mut var_registered := this.get_collection_params()
		mut var_args := rt.create_array([rt.ArrayItem{ key: 'post_parent', val: rt.get_property(var_parent, 'ID') }, rt.ArrayItem{ key: 'post_type', val: 'revision' }, rt.ArrayItem{ key: 'post_status', val: 'inherit' }, rt.ArrayItem{ key: 'posts_per_page', val: // unsupported expression: Expr_UnaryMinus }, rt.ArrayItem{ key: 'orderby', val: 'date ID' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'suppress_filters', val: true }])
		mut var_parameter_mappings := { 'exclude': 'post__not_in', 'include': 'post__in', 'offset': 'offset', 'order': 'order', 'orderby': 'orderby', 'page': 'paged', 'per_page': 'posts_per_page', 'search': 's' }
		for var_api_param, var_wp_param in var_parameter_mappings {
			if var_registered.array_isset(rt.new_string(api_param)) && var_request.array_isset(rt.new_string(api_param)) {
				var_args.array_set(wp_param, var_request.array_get(api_param))
			}
		}
		if rt.is_true(rt.new_bool(var_args.array_isset(rt.new_string('orderby')) && rt.is_true(rt.identical(rt.new_string('date'), var_args.array_get('orderby'))))) {
			var_args.array_set('orderby', 'date ID')
		}
		if rt.is_true(var_is_head_request) {
			var_args.array_set('fields', 'ids')
			var_args.array_set('update_post_term_cache', false)
			var_args.array_set('update_post_meta_cache', false)
		}
		var_args = rt.call_function('apply_filters', [rt.new_string('rest_revision_query'), var_args.dup(), var_request.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.dup().is_array()))))) {
			var_args = rt.new_array()
		}
		mut var_query_args := this.prepare_items_query(var_args.dup(), var_request.dup())
		mut var_revisions_query := create_wp_query()
		mut var_revisions := var_revisions_query.query(var_query_args.dup())
		mut var_offset := if var_query_args.array_isset(rt.new_string('offset')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
		mut var_page := if var_query_args.array_isset(rt.new_string('paged')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
		mut var_total_revisions := rt.get_property(var_revisions_query, 'found_posts')
		if rt.is_true(rt.less(var_total_revisions, rt.new_int(1))) {
			var_query_args.array_unset(rt.new_string('paged'))
			var_query_args.array_unset(rt.new_string('offset'))
			mut var_count_query := create_wp_query()
			var_query_args.array_set('fields', 'ids')
			var_query_args.array_set('posts_per_page', 1)
			var_query_args.array_set('update_post_meta_cache', false)
			var_query_args.array_set('update_post_term_cache', false)
			var_count_query.query(var_query_args.dup())
			var_total_revisions = rt.get_property(var_count_query, 'found_posts')
		}
		if rt.is_true(rt.greater(rt.get_property(var_revisions_query, 'query_vars').array_get('posts_per_page'), rt.new_int(0))) {
			mut var_max_pages := // unsupported expression: Expr_Cast_Int
		} else {
			var_max_pages = rt.new_int(if rt.is_true(rt.greater(var_total_revisions, rt.new_int(0))) { rt.new_int(1) } else { rt.new_int(0) })
		}
		if rt.is_true(rt.greater(var_total_revisions, rt.new_int(0))) {
			if rt.is_true(rt.greater_equal(var_offset, var_total_revisions)) {
				return create_wp_error(rt.new_string('rest_revision_invalid_offset_number'), rt.call_function('__', [rt.new_string('The offset number requested is larger than or equal to the number of available revisions.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
			} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_offset)))) && rt.is_true(rt.greater(var_page, var_max_pages)))) {
				return create_wp_error(rt.new_string('rest_revision_invalid_page_number'), rt.call_function('__', [rt.new_string('The page number requested is larger than the number of pages available.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
			}
		}
	} else {
		var_revisions = rt.new_array()
		var_total_revisions = rt.new_int(rt.new_int(0))
		var_max_pages = rt.new_int(rt.new_int(0))
		var_page = // unsupported expression: Expr_Cast_Int
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_head_request)))) {
		mut var_response := rt.new_array()
		{
			mut iter_1 := var_revisions.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_revision := item_1.val
				mut var_data := this.prepare_item_for_response(var_revision.dup(), var_request.dup())
				var_response.array_push(this.prepare_response_for_collection(var_data.dup()))
			}
		}
		var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	} else {
		var_response = create_wp_rest_response(rt.new_array())
	}
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), // unsupported expression: Expr_Cast_Int])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), // unsupported expression: Expr_Cast_Int])
	mut var_request_params := rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})
	mut var_base_path := rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s/%d/%s'), rt.get_property(rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this), 'namespace'), this.parent_base, var_request.array_get('parent'), rt.get_property(rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this), 'rest_base')])])
	mut var_base := rt.call_function('add_query_arg', [rt.call_function('urlencode_deep', [var_request_params.dup()]), var_base_path.dup()])
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

fn (mut this Class_WP_REST_Revisions_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.get_items_permissions_check(var_request.dup()))
}

fn (mut this Class_WP_REST_Revisions_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_parent := this.get_parent(var_request.array_get('parent'))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent.dup()])) {
		return var_parent.dup()
	}
	mut var_revision := this.get_revision(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_revision.dup()])) {
		return var_revision.dup()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_wp_error(rt.new_string('rest_revision_parent_id_mismatch'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The revision does not belong to the specified parent with id of "%d"')]), rt.get_property(var_parent, 'ID')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_response := this.prepare_item_for_response(var_revision.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_WP_REST_Revisions_Controller) delete_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_parent := this.get_parent(var_request.array_get('parent'))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent.dup()])) {
		return var_parent.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post'), rt.get_property(var_parent, 'ID')]))))) {
		return create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete revisions of this post.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))
	}
	mut var_revision := this.get_revision(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_revision.dup()])) {
		return var_revision.dup()
	}
	mut var_response := rt.new_bool(this.get_items_permissions_check(var_request.dup()))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true()))) || rt.is_true(rt.call_function('is_wp_error', [.dup()])))) {
		return var_response.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		return 
	}
	return rt.new_bool()
}

fn (mut this Class_WP_REST_Revisions_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Revisions_Controller) prepare_items_query(var_prepared_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_args_mutated := var_prepared_args
}

fn (mut this Class_WP_REST_Revisions_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
}

fn (mut this Class_WP_REST_Revisions_Controller) prepare_date_response(var_date_gmt rt.PhpVal, var_date rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Revisions_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WP_REST_Revisions_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WP_REST_Revisions_Controller) prepare_excerpt_response(var_excerpt rt.PhpVal, var_post rt.PhpVal) string {
	mut var_excerpt_mutated := var_excerpt
	mut var_post_mutated := var_post
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Posts_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Post_Meta_Fields {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_revisions_controller(arg_0 rt.PhpVal) &Class_WP_REST_Revisions_Controller {
	mut obj := &Class_WP_REST_Revisions_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		parent_post_type: rt.new_null()
		meta: rt.new_null()
		parent_controller: rt.new_null()
		parent_base: rt.new_null()
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

fn create_wp_rest_posts_controller() &Class_WP_REST_Posts_Controller {
	mut obj := &Class_WP_REST_Posts_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_post_meta_fields() &Class_WP_REST_Post_Meta_Fields {
	mut obj := &Class_WP_REST_Post_Meta_Fields{
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

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
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

fn (mut this Class_WP_REST_Revisions_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_parent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_parent(dispatch_arg_0)
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_revision' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_revision(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item_permissions_check(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'prepare_items_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_items_query(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_date_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_date_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'prepare_excerpt_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.prepare_excerpt_response(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Revisions_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'parent_post_type' { return this.parent_post_type }
		'meta' { return this.meta }
		'parent_controller' { return this.parent_controller }
		'parent_base' { return this.parent_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Revisions_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'parent_post_type' { this.parent_post_type = val; return true }
		'meta' { this.meta = val; return true }
		'parent_controller' { this.parent_controller = val; return true }
		'parent_base' { this.parent_base = val; return true }
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


fn (mut this Class_WP_REST_Posts_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Posts_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Posts_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Post_Meta_Fields) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Post_Meta_Fields) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Post_Meta_Fields) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_revisions_controller_php() {
}
