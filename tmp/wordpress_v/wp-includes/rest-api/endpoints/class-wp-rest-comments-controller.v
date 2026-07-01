import rt

struct Class_WP_REST_Comments_Controller {
	rt.PhpObjectBase
pub mut:
		meta rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Comments_Controller) construct()  {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('comments'))
	this.meta = create_wp_rest_comment_meta_fields()
}

fn (mut this Class_WP_REST_Comments_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this), 'rest_base') + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the comment.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }, rt.ArrayItem{ key: 'password', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The password for the parent post of the comment (if the post is password protected).')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass Trash and force deletion.')]) }]) }, rt.ArrayItem{ key: 'password', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The password for the parent post of the comment (if the post is password protected).')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Comments_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_is_note := rt.identical(rt.new_string('note'), var_request.array_get('type'))
	mut var_is_edit_context := rt.identical(rt.new_string('edit'), var_request.array_get('context'))
	mut var_protected_params := ['author', 'author_exclude', 'author_email', 'type', 'status']
	mut var_forbidden_params := []rt.PhpVal{}
	if !(!rt.is_true(var_request.array_get('post'))) {
		{
			mut iter_1 := rt.cast_array(var_request.array_get('post')).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_post_id := item_1.val
				mut var_post := rt.call_function('get_post', [var_post_id.dup()])
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_post_id)) && rt.is_true(var_post))) && !(this.check_read_post_permission(var_post.dup(), var_request.dup())))) {
					return (create_wp_error(rt.new_string('rest_cannot_read_post'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to read the post for this comment.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
				} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), var_post_id)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')]))))))) {
					return (create_wp_error(rt.new_string('rest_cannot_read'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to read comments without a post.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
				}
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_post) && rt.is_true(var_is_note))) && !(this.check_post_type_supports_notes(rt.get_property(var_post, 'post_type'))))) {
					if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post, 'ID')])) {
						return (create_wp_error(rt.new_string('rest_comment_not_supported_post_type'), rt.call_function('__', [rt.new_string('Sorry, this post type does not support notes.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))).to_bool()
					}
					for var_param in var_protected_params {
						if rt.is_true(rt.identical(rt.new_string('status'), rt.new_string(param))) {
							if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
								var_forbidden_params << rt.new_string(param).dup()
							}
						} else if rt.is_true(rt.identical(rt.new_string('type'), rt.new_string(param))) {
							if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
								var_forbidden_params << rt.new_string(param).dup()
							}
						} else if !(!rt.is_true(var_request.array_get(param))) {
							var_forbidden_params << rt.new_string(param).dup()
						}
					}
					return (create_wp_error(rt.new_string('rest_forbidden_param'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Query parameter not permitted: %s')]), rt.call_function('implode', [rt.new_string(', '), var_forbidden_params.dup()])]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_is_edit_context) && rt.is_true(var_is_note))) && !(!rt.is_true(var_request.array_get('post'))))) {
		{
			mut iter_1 := rt.cast_array(var_request.array_get('post')).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_post_id := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id.dup()]))))) {
					return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit comments.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
				}
			}
		}
	} else if rt.is_true(rt.new_bool(rt.is_true(var_is_edit_context) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')]))))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit comments.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')]))))) {
		for var_param in var_protected_params {
			if rt.is_true(rt.identical(rt.new_string('status'), rt.new_string(param))) {
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_forbidden_params << rt.new_string(param).dup()
				}
			} else if rt.is_true(rt.identical(rt.new_string('type'), rt.new_string(param))) {
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_forbidden_params << rt.new_string(param).dup()
				}
			} else if !(!rt.is_true(var_request.array_get(param))) {
				var_forbidden_params << rt.new_string(param).dup()
			}
		}
		if !(!rt.is_true(var_forbidden_params)) {
			return (create_wp_error(rt.new_string('rest_forbidden_param'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Query parameter not permitted: %s')]), rt.call_function('implode', [rt.new_string(', '), var_forbidden_params.dup()])]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
		}
	}
	return true
}

fn (mut this Class_WP_REST_Comments_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_registered := this.get_collection_params()
	mut var_parameter_mappings := { 'author': 'author__in', 'author_email': 'author_email', 'author_exclude': 'author__not_in', 'exclude': 'comment__not_in', 'include': 'comment__in', 'offset': 'offset', 'order': 'order', 'parent': 'parent__in', 'parent_exclude': 'parent__not_in', 'per_page': 'number', 'post': 'post__in', 'search': 'search', 'status': 'status', 'type': 'type' }
	mut var_prepared_args := []rt.PhpVal{}
	for var_api_param, var_wp_param in var_parameter_mappings {
		if var_registered.array_isset(rt.new_string(api_param)) && var_request.array_isset(rt.new_string(api_param)) {
			var_prepared_args.array_set(wp_param, var_request.array_get(api_param))
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'author_email' }, rt.ArrayItem{ key: none, val: 'search' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_param := item_1.val
			if !(var_prepared_args.array_isset(var_param)) {
				var_prepared_args.array_set(var_param, '')
			}
		}
	}
	if var_registered.array_isset(rt.new_string('orderby')) {
		var_prepared_args.array_set('orderby', this.normalize_query_param(var_request.array_get('orderby')))
	}
	var_prepared_args.array_set('no_found_rows', false)
	var_prepared_args.array_set('update_comment_post_cache', true)
	var_prepared_args.array_set('date_query', []rt.PhpVal{})
	if var_registered.array_isset(rt.new_string('before')) && var_request.array_isset(rt.new_string('before')) {
		var_prepared_args.array_get_mut('date_query').array_get_mut(0).array_set('before', var_request.array_get('before'))
	}
	if var_registered.array_isset(rt.new_string('after')) && var_request.array_isset(rt.new_string('after')) {
		var_prepared_args.array_get_mut('date_query').array_get_mut(0).array_set('after', var_request.array_get('after'))
	}
	if var_registered.array_isset(rt.new_string('page')) && !rt.is_true(var_request.array_get('offset')) {
		var_prepared_args.array_set('offset', rt.mul(var_prepared_args.array_get('number'), rt.sub(rt.call_function('absint', [var_request.array_get('page')]), rt.new_int(1))))
	}
	mut var_is_head_request := rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])
	if rt.is_true(var_is_head_request) {
		var_prepared_args.array_set('fields', 'ids')
		var_prepared_args.array_set('update_comment_meta_cache', false)
	}
	var_prepared_args = rt.call_function('apply_filters', [rt.new_string('rest_comment_query'), var_prepared_args.dup(), var_request.dup()])
	mut var_query := create_wp_comment_query()
	mut var_query_result := var_query.query(var_prepared_args.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_head_request)))) {
		mut var_comments := []rt.PhpVal{}
		{
			mut iter_1 := var_query_result.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_comment := item_1.val
				if !(this.check_read_permission(var_comment.dup(), var_request.dup())) {
					continue
				}
				mut var_data := this.prepare_item_for_response(var_comment.dup(), var_request.dup())
				var_comments << this.prepare_response_for_collection(var_data.dup())
			}
		}
	}
	mut var_total_comments := // unsupported expression: Expr_Cast_Int
	mut var_max_pages := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.less(var_total_comments, rt.new_int(1))) {
		var_prepared_args.array_unset(rt.new_string('number'))
		var_prepared_args.array_unset(rt.new_string('offset'))
		var_query = create_wp_comment_query()
		var_prepared_args.array_set('count', true)
		var_prepared_args.array_set('orderby', 'none')
		var_prepared_args.array_set('update_comment_meta_cache', false)
		var_total_comments = var_query.query(var_prepared_args.dup())
		var_max_pages = // unsupported expression: Expr_Cast_Int
	}
	mut var_response := if rt.is_true(var_is_head_request) { create_wp_rest_response([]rt.PhpVal{}) } else { rt.call_function('rest_ensure_response', [var_comments.dup()]) }
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), // unsupported expression: Expr_Cast_String])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), // unsupported expression: Expr_Cast_String])
	mut var_base := rt.call_function('add_query_arg', [rt.call_function('urlencode_deep', [rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})]), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s'), rt.get_property(rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this), 'rest_base')])])])
	if rt.is_true(rt.greater(var_request.array_get('page'), rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_request.array_get('page'), rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
			var_prev_page = var_max_pages.dup()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_prev_page.dup(), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'), var_prev_link.dup()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_request.array_get('page'))) {
		mut var_next_page := rt.add(var_request.array_get('page'), rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_next_page.dup(), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'), var_next_link.dup()])
	}
	return var_response.dup()
}

fn (mut this Class_WP_REST_Comments_Controller) get_comment(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	mut var_error := create_wp_error(rt.new_string('rest_comment_invalid_id'), rt.call_function('__', [rt.new_string('Invalid comment ID.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	if rt.is_true(rt.less_equal(// unsupported expression: Expr_Cast_Int, rt.new_int(0))) {
		return mut var_error
	}
	var_id_mutated = // unsupported expression: Expr_Cast_Int
	mut var_comment := rt.call_function('get_comment', [var_id_mutated.dup()])
	if !rt.is_true(var_comment) {
		return mut var_error
	}
	if !(!rt.is_true(rt.get_property(var_comment, 'comment_post_ID'))) {
		mut var_post := rt.call_function('get_post', [// unsupported expression: Expr_Cast_Int])
		if !rt.is_true(var_post) {
			return mut rt.cast_object_ptr[Class_WP_Error](create_wp_error(rt.new_string('rest_post_invalid_id'), rt.call_function('__', [rt.new_string('Invalid post ID.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
		}
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_comment)
}

fn (mut this Class_WP_REST_Comments_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_comment := this.get_comment(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_comment.dup()])) {
		return (var_comment).to_bool()
	}
	mut var_edit_cap := if rt.is_true(rt.identical(rt.new_string('note'), rt.get_property(var_comment, 'comment_type'))) { rt.create_array([rt.ArrayItem{ key: none, val: 'edit_comment' }, rt.ArrayItem{ key: none, val: rt.get_property(var_comment, 'comment_ID') }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: 'moderate_comments' }]) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_request.array_get('context'))) && rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get('context'))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_edit_cap.dup()]))))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit comments.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	mut var_post := rt.call_function('get_post', [rt.get_property(var_comment, 'comment_post_ID')])
	if !(this.check_read_permission(var_comment.dup(), var_request.dup())) {
		return (create_wp_error(rt.new_string('rest_cannot_read'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to read this comment.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_post) && !(this.check_read_post_permission(var_post.dup(), var_request.dup())))) {
		return (create_wp_error(rt.new_string('rest_cannot_read_post'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to read the post for this comment.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Comments_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_comment := this.get_comment(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_comment.dup()])) {
		return var_comment.dup()
	}
	mut var_data := this.prepare_item_for_response(var_comment.dup(), var_request.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	return var_response.dup()
}

fn (mut this Class_WP_REST_Comments_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_is_note := rt.new_bool(rt.new_bool(!(!rt.is_true(.array_get())) && rt.is_true(rt.identical(, ))))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true()))) && rt.is_true(var_is_note))) {
		return (create_wp_error(, , )).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		if rt.is_true() {
		}
		
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	
}

fn (mut this Class_WP_REST_Comments_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Comments_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
}

fn (mut this Class_WP_REST_Comments_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Comments_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
}

fn (mut this Class_WP_REST_Comments_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Comments_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Comments_Controller) prepare_links(var_comment rt.PhpVal) rt.PhpVal {
	mut var_comment_mutated := var_comment
}

fn (mut this Class_WP_REST_Comments_Controller) normalize_query_param(var_query_param rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Comments_Controller) prepare_status_response(var_comment_approved rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Comments_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Comments_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WP_REST_Comments_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WP_REST_Comments_Controller) handle_status_param(var_new_status rt.PhpVal, var_comment_id rt.PhpVal) bool {
	mut var_comment_id_mutated := var_comment_id
}

fn (mut this Class_WP_REST_Comments_Controller) check_read_post_permission(var_post rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_REST_Comments_Controller) check_read_permission(var_comment rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_comment_mutated := var_comment
}

fn (mut this Class_WP_REST_Comments_Controller) check_edit_permission(var_comment rt.PhpVal) bool {
	mut var_comment_mutated := var_comment
}

fn (mut this Class_WP_REST_Comments_Controller) check_comment_author_email(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Comments_Controller) check_is_comment_content_allowed(var_prepared_comment rt.PhpVal) bool {
	mut var_prepared_comment_mutated := var_prepared_comment
}

fn (mut this Class_WP_REST_Comments_Controller) check_post_type_supports_notes(var_post_type rt.PhpVal) bool {
	mut var_post_type_mutated := var_post_type
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Comment_Meta_Fields {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Comment_Query {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_comments_controller() &Class_WP_REST_Comments_Controller {
	mut obj := &Class_WP_REST_Comments_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		meta: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_rest_controller() &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_comment_meta_fields() &Class_WP_REST_Comment_Meta_Fields {
	mut obj := &Class_WP_REST_Comment_Meta_Fields{
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

fn create_wp_comment_query() &Class_WP_Comment_Query {
	mut obj := &Class_WP_Comment_Query{
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

fn (mut this Class_WP_REST_Comments_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_comment(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
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
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_item_permissions_check(dispatch_arg_0))
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
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
		'normalize_query_param' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.normalize_query_param(dispatch_arg_0)
		}
		'prepare_status_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_status_response(dispatch_arg_0)
		}
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'handle_status_param' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.handle_status_param(dispatch_arg_0, dispatch_arg_1))
		}
		'check_read_post_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.check_read_post_permission(dispatch_arg_0, dispatch_arg_1))
		}
		'check_read_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.check_read_permission(dispatch_arg_0, dispatch_arg_1))
		}
		'check_edit_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_edit_permission(dispatch_arg_0))
		}
		'check_comment_author_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.check_comment_author_email(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'check_is_comment_content_allowed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_is_comment_content_allowed(dispatch_arg_0))
		}
		'check_post_type_supports_notes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_post_type_supports_notes(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Comments_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'meta' { return this.meta }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Comments_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'meta' { this.meta = val; return true }
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


fn (mut this Class_WP_REST_Comment_Meta_Fields) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Comment_Meta_Fields) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Comment_Meta_Fields) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Comment_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Comment_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Comment_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_comments_controller_php() {
}
