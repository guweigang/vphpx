import rt

struct Class_WP_REST_Comments_Controller {
	rt.PhpObjectBase
pub mut:
	meta rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Comments_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('comments'))
	this.meta = create_wp_rest_comment_meta_fields()
}

fn (mut this Class_WP_REST_Comments_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this), 'rest_base')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the comment.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
					rt.ArrayItem{ key: 'password', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The password for the parent post of the comment (if the post is password protected).'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
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
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'force', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'default', val: false },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Whether to bypass Trash and force deletion.'),
						]) },
					]) },
					rt.ArrayItem{ key: 'password', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The password for the parent post of the comment (if the post is password protected).'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Comments_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_is_note := rt.identical(rt.new_string('note'),
		var_request.array_get(rt.new_string('type')))
	mut var_is_edit_context := rt.identical(rt.new_string('edit'),
		var_request.array_get(rt.new_string('context')))
	mut var_protected_params := ['author', 'author_exclude', 'author_email', 'type', 'status']
	mut var_forbidden_params := []rt.PhpVal{}
	if !(!rt.is_true(var_request.array_get(rt.new_string('post')))) {
		mut iter_1 := rt.cast_array(var_request.array_get(rt.new_string('post'))).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post_id := item_1.val
			mut var_post := rt.call_function('get_post', [var_post_id.clone()])
			if !(!rt.is_true(var_post_id)) && rt.is_true(var_post)
				&& !(this.check_read_post_permission(var_post.clone(), var_request.clone())) {
				return (create_wp_error(rt.new_string('rest_cannot_read_post'), rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to read the post for this comment.'),
				]), rt.create_array([
					rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
						[]rt.PhpVal{}) },
				]))).to_bool()
			} else if rt.is_true(rt.identical(rt.new_int(0), var_post_id))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')]))))) {
				return (create_wp_error(rt.new_string('rest_cannot_read'), rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to read comments without a post.'),
				]), rt.create_array([
					rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
						[]rt.PhpVal{}) },
				]))).to_bool()
			}
			if rt.is_true(var_post) && rt.is_true(var_is_note)
				&& !(this.check_post_type_supports_notes(rt.get_property(var_post, 'post_type'))) {
				if rt.is_true(rt.call_function('current_user_can', [
					rt.new_string('edit_post'),
					rt.get_property(var_post, 'ID'),
				]))
				{
					return (create_wp_error(rt.new_string('rest_comment_not_supported_post_type'), rt.call_function('__', [
						rt.new_string('Sorry, this post type does not support notes.'),
					]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))).to_bool()
				}
				for var_param in var_protected_params {
					if rt.is_true(rt.identical(rt.new_string('status'), rt.new_string(param))) {
						if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('approve'),
							var_request.array_get(rt.new_string(param))))))
						{
							var_forbidden_params << rt.new_string(param)
						}
					} else if rt.is_true(rt.identical(rt.new_string('type'), rt.new_string(param))) {
						if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('comment'),
							var_request.array_get(rt.new_string(param))))))
						{
							var_forbidden_params << rt.new_string(param)
						}
					} else if !(!rt.is_true(var_request.array_get(rt.new_string(param)))) {
						var_forbidden_params << rt.new_string(param)
					}
				}
				return (create_wp_error(rt.new_string('rest_forbidden_param'), rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Query parameter not permitted: %s'),
					]),
					rt.call_function('implode', [
						rt.new_string(', '),
						rt.create_array_from_list(var_forbidden_params),
					]),
				]), rt.create_array([
					rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
						[]rt.PhpVal{}) },
				]))).to_bool()
			}
		}
	}
	if rt.is_true(var_is_edit_context) && rt.is_true(var_is_note)
		&& !(!rt.is_true(var_request.array_get(rt.new_string('post')))) {
		mut iter_2 := rt.cast_array(var_request.array_get(rt.new_string('post'))).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_post_id := item_2.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('edit_post'),
				var_post_id.clone(),
			])))))
			{
				return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to edit comments.'),
				]), rt.create_array([
					rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
						[]rt.PhpVal{}) },
				]))).to_bool()
			}
		}
	} else if rt.is_true(var_is_edit_context)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')]))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit comments.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		for var_param in var_protected_params {
			if rt.is_true(rt.identical(rt.new_string('status'), rt.new_string(param))) {
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('approve'),
					var_request.array_get(rt.new_string(param))))))
				{
					var_forbidden_params << rt.new_string(param)
				}
			} else if rt.is_true(rt.identical(rt.new_string('type'), rt.new_string(param))) {
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('comment'),
					var_request.array_get(rt.new_string(param))))))
				{
					var_forbidden_params << rt.new_string(param)
				}
			} else if !(!rt.is_true(var_request.array_get(rt.new_string(param)))) {
				var_forbidden_params << rt.new_string(param)
			}
		}
		if !(!rt.is_true(var_forbidden_params)) {
			return (create_wp_error(rt.new_string('rest_forbidden_param'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Query parameter not permitted: %s'),
				]),
				rt.call_function('implode', [
					rt.new_string(', '),
					rt.create_array_from_list(var_forbidden_params),
				]),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
					[]rt.PhpVal{}) },
			]))).to_bool()
		}
	}
	return true
}

fn (mut this Class_WP_REST_Comments_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_registered := this.get_collection_params()
	mut var_parameter_mappings := {
		'author':         'author__in'
		'author_email':   'author_email'
		'author_exclude': 'author__not_in'
		'exclude':        'comment__not_in'
		'include':        'comment__in'
		'offset':         'offset'
		'order':          'order'
		'parent':         'parent__in'
		'parent_exclude': 'parent__not_in'
		'per_page':       'number'
		'post':           'post__in'
		'search':         'search'
		'status':         'status'
		'type':           'type'
	}
	mut var_prepared_args := []rt.PhpVal{}
	for var_api_param, var_wp_param in var_parameter_mappings {
		if var_registered.array_isset(rt.new_string(api_param))
			&& var_request.array_isset(rt.new_string(api_param)) {
			var_prepared_args.array_set(wp_param, var_request.array_get(rt.new_string(api_param)))
		}
	}
	mut iter_3 := rt.create_array([rt.ArrayItem{ key: none, val: 'author_email' },
		rt.ArrayItem{ key: none, val: 'search' }]).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_param := item_3.val
		if !(var_prepared_args.array_isset(var_param)) {
			var_prepared_args.array_set(var_param, '')
		}
	}
	if var_registered.array_isset(rt.new_string('orderby')) {
		var_prepared_args.array_set('orderby',
			this.normalize_query_param(var_request.array_get(rt.new_string('orderby'))))
	}
	var_prepared_args.array_set('no_found_rows', false)
	var_prepared_args.array_set('update_comment_post_cache', true)
	var_prepared_args.array_set('date_query', []rt.PhpVal{})
	if var_registered.array_isset(rt.new_string('before'))
		&& var_request.array_isset(rt.new_string('before')) {
		var_prepared_args.array_get_mut('date_query').array_get_mut(0).array_set('before',
			var_request.array_get(rt.new_string('before')))
	}
	if var_registered.array_isset(rt.new_string('after'))
		&& var_request.array_isset(rt.new_string('after')) {
		var_prepared_args.array_get_mut('date_query').array_get_mut(0).array_set('after',
			var_request.array_get(rt.new_string('after')))
	}
	if var_registered.array_isset(rt.new_string('page'))
		&& !rt.is_true(var_request.array_get(rt.new_string('offset'))) {
		var_prepared_args.array_set('offset', rt.mul(var_prepared_args.array_get(rt.new_string('number')), rt.sub(rt.call_function('absint', [
			var_request.array_get(rt.new_string('page')),
		]), rt.new_int(1))))
	}
	mut var_is_head_request := rt.call_method(var_request, 'is_method', [
		rt.new_string('HEAD'),
	])
	if rt.is_true(var_is_head_request) {
		var_prepared_args.array_set('fields', 'ids')
		var_prepared_args.array_set('update_comment_meta_cache', false)
	}
	var_prepared_args = rt.call_function('apply_filters', [
		rt.new_string('rest_comment_query'),
		var_prepared_args.clone(),
		var_request.clone(),
	])
	mut var_query := create_wp_comment_query()
	mut var_query_result := var_query.query(var_prepared_args.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_head_request)))) {
		mut var_comments := []rt.PhpVal{}
		mut iter_4 := var_query_result.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_comment := item_4.val
			if !(this.check_read_permission(var_comment.clone(), var_request.clone())) {
				continue
			}
			mut var_data := this.prepare_item_for_response(var_comment.clone(), var_request.clone())
			var_comments << this.prepare_response_for_collection(var_data.clone())
		}
	}
	mut var_total_comments := rt.new_int((rt.get_property(var_query, 'found_comments')).to_i64())
	mut var_max_pages := rt.new_int((rt.get_property(var_query, 'max_num_pages')).to_i64())
	if rt.is_true(rt.less(var_total_comments, rt.new_int(1))) {
		var_prepared_args.array_unset(rt.new_string('number'))
		var_prepared_args.array_unset(rt.new_string('offset'))
		var_query = create_wp_comment_query()
		var_prepared_args.array_set('count', true)
		var_prepared_args.array_set('orderby', 'none')
		var_prepared_args.array_set('update_comment_meta_cache', false)
		var_total_comments = var_query.query(var_prepared_args.clone())
		var_max_pages = rt.new_int((rt.call_function('ceil', [
			rt.div(var_total_comments, var_request.array_get(rt.new_string('per_page'))),
		])).to_i64())
	}
	mut var_response := if rt.is_true(var_is_head_request) { create_wp_rest_response([]rt.PhpVal{}) } else { rt.call_function('rest_ensure_response', [
			rt.create_array_from_list(var_comments),
		]) }
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_string(var_total_comments.str())])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_string(var_max_pages.str())])
	mut var_base := rt.call_function('add_query_arg', [
		rt.call_function('urlencode_deep', [
			rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}),
		]),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('%s/%s'),
				rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
					'WP_REST_Controller',
				], &this), 'namespace'),
				rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
					'WP_REST_Controller',
				], &this), 'rest_base')]),
		]),
	])
	if rt.is_true(rt.greater(var_request.array_get(rt.new_string('page')), rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_request.array_get(rt.new_string('page')), rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
			var_prev_page = var_max_pages.clone()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_prev_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'),
			var_prev_link.clone()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_request.array_get(rt.new_string('page')))) {
		mut var_next_page := rt.add(var_request.array_get(rt.new_string('page')), rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_next_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'),
			var_next_link.clone()])
	}
	return var_response.clone()
}

fn (mut this Class_WP_REST_Comments_Controller) get_comment(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	mut var_error := create_wp_error(rt.new_string('rest_comment_invalid_id'), rt.call_function('__', [
		rt.new_string('Invalid comment ID.'),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	if rt.new_int(var_id_mutated.to_i64()) <= 0 {
		return mut var_error
	}
	var_id_mutated = rt.new_int(var_id_mutated.to_i64())
	mut var_comment := rt.call_function('get_comment', [var_id_mutated.clone()])
	if !rt.is_true(var_comment) {
		return mut var_error
	}
	if !(!rt.is_true(rt.get_property(var_comment, 'comment_post_ID'))) {
		mut var_post := rt.call_function('get_post', [
			rt.new_int((rt.get_property(var_comment, 'comment_post_ID')).to_i64()),
		])
		if !rt.is_true(var_post) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_post_invalid_id'), rt.call_function('__', [
				rt.new_string('Invalid post ID.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
		}
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_comment)
}

fn (mut this Class_WP_REST_Comments_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_comment := this.get_comment(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_comment.clone()])) {
		return var_comment.to_bool()
	}
	mut var_edit_cap := if rt.is_true(rt.identical(rt.new_string('note'), rt.get_property(var_comment, 'comment_type'))) { rt.create_array([
			rt.ArrayItem{ key: none, val: 'edit_comment' },
			rt.ArrayItem{ key: none, val: rt.get_property(var_comment, 'comment_ID') },
		]) } else { rt.create_array([rt.ArrayItem{ key: none, val: 'moderate_comments' }]) }
	if !(!rt.is_true(var_request.array_get(rt.new_string('context'))))
		&& rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get(rt.new_string('context'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_edit_cap.clone()]))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit comments.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	mut var_post := rt.call_function('get_post', [
		rt.get_property(var_comment, 'comment_post_ID'),
	])
	if !(this.check_read_permission(var_comment.clone(), var_request.clone())) {
		return (create_wp_error(rt.new_string('rest_cannot_read'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to read this comment.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	if rt.is_true(var_post)
		&& !(this.check_read_post_permission(var_post.clone(), var_request.clone())) {
		return (create_wp_error(rt.new_string('rest_cannot_read_post'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to read the post for this comment.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Comments_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_comment := this.get_comment(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_comment.clone()])) {
		return var_comment.clone()
	}
	mut var_data := this.prepare_item_for_response(var_comment.clone(), var_request.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Comments_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_is_note := rt.new_bool(!(!rt.is_true(var_request.array_get(rt.new_string('type'))))
		&& rt.is_true(rt.identical(rt.new_string('note'), var_request.array_get(rt.new_string('type')))))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))
		&& rt.is_true(var_is_note) {
		return (create_wp_error(rt.new_string('rest_comment_login_required'), rt.call_function('__', [
			rt.new_string('Sorry, you must be logged in to comment.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		if rt.is_true(rt.call_function('get_option', [
			rt.new_string('comment_registration'),
		]))
		{
			return (create_wp_error(rt.new_string('rest_comment_login_required'), rt.call_function('__', [
				rt.new_string('Sorry, you must be logged in to comment.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))).to_bool()
		}
		mut var_allow_anonymous := rt.call_function('apply_filters', [
			rt.new_string('rest_allow_anonymous_comments'),
			rt.new_bool(false),
			var_request.clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_allow_anonymous)))) {
			return (create_wp_error(rt.new_string('rest_comment_login_required'), rt.call_function('__', [
				rt.new_string('Sorry, you must be logged in to comment.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))).to_bool()
		}
	}
	if var_request.array_isset(rt.new_string('author'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), var_request.array_get(rt.new_string('author'))))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')]))))) {
		return (create_wp_error(rt.new_string('rest_comment_invalid_author'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string("Sorry, you are not allowed to edit '%s' for comments."),
			]),
			rt.new_string('author'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	if var_request.array_isset(rt.new_string('author_ip'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')]))))) {
		if !rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR')))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_request.array_get(rt.new_string('author_ip')), rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR')))))) {
			return (create_wp_error(rt.new_string('rest_comment_invalid_author_ip'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string("Sorry, you are not allowed to edit '%s' for comments."),
				]),
				rt.new_string('author_ip'),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
					[]rt.PhpVal{}) },
			]))).to_bool()
		}
	}
	if rt.is_true(var_is_note) && !(!rt.is_true(var_request.array_get(rt.new_string('post'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.new_int((var_request.array_get(rt.new_string('post'))).to_i64())]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_create_note'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to create notes for this post.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	mut var_edit_cap := if rt.is_true(var_is_note) { rt.create_array([
			rt.ArrayItem{ key: none, val: 'edit_post' },
			rt.ArrayItem{
				key: none
				val: rt.new_int((var_request.array_get(rt.new_string('post'))).to_i64())
			},
		]) } else { rt.create_array([rt.ArrayItem{ key: none, val: 'moderate_comments' }]) }
	if var_request.array_isset(rt.new_string('status'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_edit_cap.clone()]))))) {
		return (create_wp_error(rt.new_string('rest_comment_invalid_status'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string("Sorry, you are not allowed to edit '%s' for comments."),
			]),
			rt.new_string('status'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	if !rt.is_true(var_request.array_get(rt.new_string('post'))) {
		return (create_wp_error(rt.new_string('rest_comment_invalid_post_id'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to create this comment without a post.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))).to_bool()
	}
	mut var_post := rt.call_function('get_post', [
		rt.new_int((var_request.array_get(rt.new_string('post'))).to_i64()),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return (create_wp_error(rt.new_string('rest_comment_invalid_post_id'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to create this comment without a post.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))).to_bool()
	}
	if rt.is_true(var_is_note)
		&& !(this.check_post_type_supports_notes(rt.get_property(var_post, 'post_type'))) {
		return (create_wp_error(rt.new_string('rest_comment_not_supported_post_type'), rt.call_function('__', [
			rt.new_string('Sorry, this post type does not support notes.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('draft'), rt.get_property(var_post, 'post_status')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_note)))) {
		return (create_wp_error(rt.new_string('rest_comment_draft_post'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to create a comment on this post.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post, 'post_status'))) {
		return (create_wp_error(rt.new_string('rest_comment_trash_post'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to create a comment on this post.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))).to_bool()
	}
	if !(this.check_read_post_permission(var_post.clone(), var_request.clone())) {
		return (create_wp_error(rt.new_string('rest_cannot_read_post'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to read the post for this comment.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('comments_open', [rt.get_property(var_post, 'ID')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_note)))) {
		return (create_wp_error(rt.new_string('rest_comment_closed'), rt.call_function('__', [
			rt.new_string('Sorry, comments are closed for this item.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Comments_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get(rt.new_string('id')))) {
		return create_wp_error(rt.new_string('rest_comment_exists'), rt.call_function('__', [
			rt.new_string('Cannot create existing comment.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('type'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_request.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'comment'
	}, rt.ArrayItem{ key: none, val: 'note' }]), rt.new_bool(true)]))))) {
		return create_wp_error(rt.new_string('rest_invalid_comment_type'), rt.call_function('__', [
			rt.new_string('Cannot create a comment with that type.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_prepared_comment := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_comment.clone()])) {
		return var_prepared_comment.clone()
	}
	var_prepared_comment.array_set('comment_type', var_request.array_get(rt.new_string('type')))
	if !(var_prepared_comment.array_isset(rt.new_string('comment_content'))) {
		var_prepared_comment.array_set('comment_content', '')
	}
	if var_request.array_get(rt.new_string('meta')).array_isset(rt.new_string('_wp_note_status')) {
		var_prepared_comment.array_get_mut('meta').array_set('_wp_note_status',
			var_request.array_get(rt.new_string('meta')).array_get(rt.new_string('_wp_note_status')))
	}
	if !(this.check_is_comment_content_allowed(var_prepared_comment.clone())) {
		return create_wp_error(rt.new_string('rest_comment_content_invalid'), rt.call_function('__', [
			rt.new_string('Invalid comment content.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if !(var_prepared_comment.array_isset(rt.new_string('comment_date_gmt'))) {
		var_prepared_comment.array_set('comment_date_gmt', rt.call_function('current_time', [
			rt.new_string('mysql'),
			rt.new_bool(true),
		]))
	}
	mut var_missing_author := rt.new_bool(
		!rt.is_true(var_prepared_comment.array_get(rt.new_string('user_id')))
		&& !rt.is_true(var_prepared_comment.array_get(rt.new_string('comment_author')))
		&& !rt.is_true(var_prepared_comment.array_get(rt.new_string('comment_author_email')))
		&& !rt.is_true(var_prepared_comment.array_get(rt.new_string('comment_author_url'))))
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
		&& rt.is_true(var_missing_author) {
		mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
		var_prepared_comment.array_set('user_id', rt.get_property(var_user, 'ID'))
		var_prepared_comment.array_set('comment_author', rt.get_property(var_user, 'display_name'))
		var_prepared_comment.array_set('comment_author_email', rt.get_property(var_user,
			'user_email'))
		var_prepared_comment.array_set('comment_author_url', rt.get_property(var_user, 'user_url'))
	}
	if rt.is_true(rt.call_function('get_option', [rt.new_string('require_name_email')])) {
		if !rt.is_true(var_prepared_comment.array_get(rt.new_string('comment_author')))
			|| !rt.is_true(var_prepared_comment.array_get(rt.new_string('comment_author_email'))) {
			return create_wp_error(rt.new_string('rest_comment_author_data_required'), rt.call_function('__', [
				rt.new_string('Creating a comment requires valid author name and email values.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
	}
	if !(var_prepared_comment.array_isset(rt.new_string('comment_author_email'))) {
		var_prepared_comment.array_set('comment_author_email', '')
	}
	if !(var_prepared_comment.array_isset(rt.new_string('comment_author_url'))) {
		var_prepared_comment.array_set('comment_author_url', '')
	}
	if !(var_prepared_comment.array_isset(rt.new_string('comment_agent'))) {
		var_prepared_comment.array_set('comment_agent', '')
	}
	mut var_check_comment_lengths := rt.call_function('wp_check_comment_data_max_lengths', [
		var_prepared_comment.clone(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_check_comment_lengths.clone()])) {
		mut var_error_code := rt.call_method(var_check_comment_lengths, 'get_error_code',
			[]rt.PhpVal{})
		return create_wp_error(var_error_code.clone(), rt.call_function('__', [
			rt.new_string('Comment field exceeds maximum length allowed.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	var_prepared_comment.array_set('comment_approved', if rt.is_true(rt.identical(rt.new_string('note'), var_prepared_comment.array_get(rt.new_string('comment_type')))) { rt.new_string('1') } else { rt.call_function('wp_allow_comment', [
			var_prepared_comment.clone(),
			rt.new_bool(true),
		]) })
	if rt.is_true(rt.call_function('is_wp_error', [
		var_prepared_comment.array_get(rt.new_string('comment_approved')),
	]))
	{
		var_error_code = rt.call_method(var_prepared_comment.array_get(rt.new_string('comment_approved')),
			'get_error_code', []rt.PhpVal{})
		mut var_error_message := rt.call_method(var_prepared_comment.array_get(rt.new_string('comment_approved')),
			'get_error_message', []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.new_string('comment_duplicate'), var_error_code)) {
			return create_wp_error(var_error_code.clone(), var_error_message.clone(), rt.create_array([
				rt.ArrayItem{ key: 'status', val: 409 },
			]))
		}
		if rt.is_true(rt.identical(rt.new_string('comment_flood'), var_error_code)) {
			return create_wp_error(var_error_code.clone(), var_error_message.clone(), rt.create_array([
				rt.ArrayItem{ key: 'status', val: 400 },
			]))
		}
		return var_prepared_comment.array_get(rt.new_string('comment_approved'))
	}
	var_prepared_comment = rt.call_function('apply_filters', [
		rt.new_string('rest_pre_insert_comment'),
		var_prepared_comment.clone(),
		var_request.clone(),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_comment.clone()])) {
		return var_prepared_comment.clone()
	}
	mut var_comment_id := rt.call_function('wp_insert_comment', [
		rt.call_function('wp_filter_comment', [
			rt.call_function('wp_slash', [rt.cast_array(var_prepared_comment)]),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment_id)))) {
		return create_wp_error(rt.new_string('rest_comment_failed_create'), rt.call_function('__', [
			rt.new_string('Creating comment failed.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	if var_request.array_isset(rt.new_string('status')) {
		this.handle_status_param(var_request.array_get(rt.new_string('status')),
			var_comment_id.clone())
	}
	mut var_comment := rt.call_function('get_comment', [var_comment_id.clone()])
	rt.call_function('do_action', [rt.new_string('rest_insert_comment'),
		var_comment.clone(), var_request.clone(), rt.new_bool(true)])
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('meta'))))
		&& var_request.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(this.meta, 'update_value', [
			var_request.array_get(rt.new_string('meta')),
			var_comment_id.clone(),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.clone()])) {
			return var_meta_update.clone()
		}
	}
	mut var_fields_update := this.update_additional_fields_for_object(var_comment.clone(),
		var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	mut var_context := rt.new_string((if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('moderate_comments'),
	]))
	{ 'edit' } else { 'view' }).str())
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		var_context.clone()])
	rt.call_function('do_action', [rt.new_string('rest_after_insert_comment'),
		var_comment.clone(), var_request.clone(), rt.new_bool(true)])
	mut var_response := this.prepare_item_for_response(var_comment.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('%s/%s/%d'),
				rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
					'WP_REST_Controller',
				], &this), 'namespace'),
				rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
					'WP_REST_Controller',
				], &this), 'rest_base'),
				var_comment_id.clone()]),
		])])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Comments_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_comment := this.get_comment(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_comment.clone()])) {
		return var_comment.to_bool()
	}
	if !(this.check_edit_permission(var_comment.clone())) {
		return (create_wp_error(rt.new_string('rest_cannot_edit'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this comment.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Comments_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_comment := this.get_comment(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_comment.clone()])) {
		return var_comment.clone()
	}
	mut var_id := rt.get_property(var_comment, 'comment_ID')
	if var_request.array_isset(rt.new_string('type'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_comment_type', [var_id.clone()]), var_request.array_get(rt.new_string('type')))))) {
		return create_wp_error(rt.new_string('rest_comment_invalid_type'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to change the comment type.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_prepared_args := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_args.clone()])) {
		return var_prepared_args.clone()
	}
	if !(!rt.is_true(var_prepared_args.array_get(rt.new_string('comment_post_ID')))) {
		mut var_post := rt.call_function('get_post', [
			var_prepared_args.array_get(rt.new_string('comment_post_ID')),
		])
		if !rt.is_true(var_post) {
			return create_wp_error(rt.new_string('rest_comment_invalid_post_id'), rt.call_function('__', [
				rt.new_string('Invalid post ID.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))
		}
	}
	if !rt.is_true(var_prepared_args) && var_request.array_isset(rt.new_string('status')) {
		mut var_change := rt.new_bool(this.handle_status_param(var_request.array_get(rt.new_string('status')),
			var_id.clone()))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_change)))) {
			return create_wp_error(rt.new_string('rest_comment_failed_edit'), rt.call_function('__', [
				rt.new_string('Updating comment status failed.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
		}
	} else if !(!rt.is_true(var_prepared_args)) {
		if rt.is_true(rt.call_function('is_wp_error', [var_prepared_args.clone()])) {
			return var_prepared_args.clone()
		}
		if !(this.check_is_comment_content_allowed(var_prepared_args.clone())) {
			return create_wp_error(rt.new_string('rest_comment_content_invalid'), rt.call_function('__', [
				rt.new_string('Invalid comment content.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		var_prepared_args.array_set('comment_ID', var_id.clone())
		mut var_check_comment_lengths := rt.call_function('wp_check_comment_data_max_lengths', [
			var_prepared_args.clone(),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_check_comment_lengths.clone()])) {
			mut var_error_code := rt.call_method(var_check_comment_lengths, 'get_error_code',
				[]rt.PhpVal{})
			return create_wp_error(var_error_code.clone(), rt.call_function('__', [
				rt.new_string('Comment field exceeds maximum length allowed.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
		}
		mut var_updated := rt.call_function('wp_update_comment', [
			rt.call_function('wp_slash', [rt.cast_array(var_prepared_args)]),
			rt.new_bool(true),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_updated.clone()])) {
			return create_wp_error(rt.new_string('rest_comment_failed_edit'), rt.call_function('__', [
				rt.new_string('Updating comment failed.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
		}
		if var_request.array_isset(rt.new_string('status')) {
			this.handle_status_param(var_request.array_get(rt.new_string('status')), var_id.clone())
		}
	}
	var_comment = rt.call_function('get_comment', [var_id.clone()])
	rt.call_function('do_action', [rt.new_string('rest_insert_comment'),
		var_comment.clone(), var_request.clone(), rt.new_bool(false)])
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('meta'))))
		&& var_request.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(this.meta, 'update_value', [
			var_request.array_get(rt.new_string('meta')),
			var_id.clone(),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.clone()])) {
			return var_meta_update.clone()
		}
	}
	mut var_fields_update := this.update_additional_fields_for_object(var_comment.clone(),
		var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	rt.call_function('do_action', [rt.new_string('rest_after_insert_comment'),
		var_comment.clone(), var_request.clone(), rt.new_bool(false)])
	mut var_response := this.prepare_item_for_response(var_comment.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WP_REST_Comments_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_comment := this.get_comment(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_comment.clone()])) {
		return var_comment.to_bool()
	}
	if !(this.check_edit_permission(var_comment.clone())) {
		return (create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete this comment.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Comments_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_comment := this.get_comment(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_comment.clone()])) {
		return var_comment.clone()
	}
	mut var_force := rt.new_bool(if var_request.array_isset(rt.new_string('force')) {
		(var_request.array_get(rt.new_string('force'))).to_bool()
	} else {
		false
	})
	mut var_supports_trash := rt.call_function('apply_filters', [
		rt.new_string('rest_comment_trashable'),
		rt.greater(rt.get_constant('EMPTY_TRASH_DAYS'), rt.new_int(0)),
		var_comment.clone(),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	if rt.is_true(var_force) {
		mut var_previous := this.prepare_item_for_response(var_comment.clone(), var_request.clone())
		mut var_result := rt.call_function('wp_delete_comment', [
			rt.get_property(var_comment, 'comment_ID'),
			rt.new_bool(true),
		])
		mut var_response := create_wp_rest_response()
		rt.call_method(var_response, 'set_data', [
			rt.create_array([rt.ArrayItem{ key: 'deleted', val: true },
				rt.ArrayItem{ key: 'previous', val: rt.call_method(var_previous, 'get_data',
					[]rt.PhpVal{}) }]),
		])
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_supports_trash)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_trash_not_supported'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string("The comment does not support trashing. Set '%s' to delete."),
				]),
				rt.new_string('force=true'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
		}
		if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_comment,
			'comment_approved')))
		{
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_already_trashed'), rt.call_function('__', [
				rt.new_string('The comment has already been trashed.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 410 }])))
		}
		var_result = rt.call_function('wp_trash_comment', [
			rt.get_property(var_comment, 'comment_ID'),
		])
		var_comment = rt.call_function('get_comment', [
			rt.get_property(var_comment, 'comment_ID'),
		])
		var_response = this.prepare_item_for_response(var_comment.clone(), var_request.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('The comment cannot be deleted.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	rt.call_function('do_action', [rt.new_string('rest_delete_comment'),
		var_comment.clone(), var_response.clone(), var_request.clone()])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Comments_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_comment := var_item
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.call_function('apply_filters', [rt.new_string('rest_prepare_comment'),
			create_wp_rest_response([]rt.PhpVal{}), var_comment.clone(),
			var_request.clone()])
	}
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_data := []rt.PhpVal{}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('id'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('id', rt.new_int((rt.get_property(var_comment, 'comment_ID')).to_i64()))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('post'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('post',
			rt.new_int((rt.get_property(var_comment, 'comment_post_ID')).to_i64()))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('parent'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('parent',
			rt.new_int((rt.get_property(var_comment, 'comment_parent')).to_i64()))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('author'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('author', rt.new_int((rt.get_property(var_comment, 'user_id')).to_i64()))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('author_name'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('author_name', rt.get_property(var_comment, 'comment_author'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('author_email'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('author_email', rt.get_property(var_comment, 'comment_author_email'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('author_url'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('author_url', rt.get_property(var_comment, 'comment_author_url'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('author_ip'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('author_ip', rt.get_property(var_comment, 'comment_author_IP'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('author_user_agent'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('author_user_agent', rt.get_property(var_comment, 'comment_agent'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('date'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('date', rt.call_function('mysql_to_rfc3339', [
			rt.get_property(var_comment, 'comment_date'),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('date_gmt'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('date_gmt', rt.call_function('mysql_to_rfc3339', [
			rt.get_property(var_comment, 'comment_date_gmt'),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('content'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('content', rt.create_array([
			rt.ArrayItem{ key: 'rendered', val: rt.call_function('apply_filters', [
				rt.new_string('comment_text'),
				rt.get_property(var_comment, 'comment_content'),
				var_comment.clone(),
				[]rt.PhpVal{},
			]) },
			rt.ArrayItem{ key: 'raw', val: rt.get_property(var_comment, 'comment_content') },
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('link'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('link', rt.call_function('get_comment_link', [
			var_comment.clone()]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('status'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('status', this.prepare_status_response(rt.get_property(var_comment,
			'comment_approved')))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('type'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('type', rt.call_function('get_comment_type', [
			rt.get_property(var_comment, 'comment_ID'),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('author_avatar_urls'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('author_avatar_urls', rt.call_function('rest_get_avatar_urls', [
			var_comment.clone(),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('meta'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('meta', rt.call_method(this.meta, 'get_value', [
			rt.get_property(var_comment, 'comment_ID'),
			var_request.clone(),
		]))
	}
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.clone()]))
		|| rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.clone()])) {
		rt.call_method(var_response, 'add_links', [this.prepare_links(var_comment.clone())])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_comment'),
		var_response.clone(), var_comment.clone(), var_request.clone()])
}

fn (mut this Class_WP_REST_Comments_Controller) prepare_links(var_comment rt.PhpVal) rt.PhpVal {
	mut var_comment_mutated := var_comment
	mut var_links := {
		'self':       {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s/%d'),
					rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base'),
					rt.get_property(var_comment_mutated, 'comment_ID')]),
			])
		}
		'collection': {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base')]),
			])
		}
	}
	if rt.is_true(rt.new_bool(0 != rt.new_int((rt.get_property(var_comment_mutated, 'user_id')).to_i64()))) {
		var_links['author'] = rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.new_string('wp/v2/users/' +
					(rt.get_property(var_comment_mutated, 'user_id')).str()),
			]) },
			rt.ArrayItem{ key: 'embeddable', val: true },
		])
	}
	if rt.is_true(rt.new_bool(0 != rt.new_int((rt.get_property(var_comment_mutated,
		'comment_post_ID')).to_i64())))
	{
		mut var_post := rt.call_function('get_post', [
			rt.get_property(var_comment_mutated, 'comment_post_ID'),
		])
		mut var_post_route := rt.call_function('rest_get_route_for_post', [
			var_post.clone()])
		if !(!rt.is_true(rt.get_property(var_post, 'ID'))) && rt.is_true(var_post_route) {
			var_links['up'] = rt.create_array([
				rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
					var_post_route.clone()]) },
				rt.ArrayItem{ key: 'embeddable', val: true },
				rt.ArrayItem{ key: 'post_type', val: rt.get_property(var_post, 'post_type') },
			])
		}
	}
	if rt.is_true(rt.new_bool(0 != rt.new_int((rt.get_property(var_comment_mutated,
		'comment_parent')).to_i64())))
	{
		var_links['in-reply-to'] = rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s/%d'),
					rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base'),
					rt.get_property(var_comment_mutated, 'comment_parent')]),
			]) },
			rt.ArrayItem{ key: 'embeddable', val: true },
		])
	}
	mut var_comment_children := rt.call_method(var_comment_mutated, 'get_children', [
		rt.create_array([rt.ArrayItem{ key: 'count', val: true },
			rt.ArrayItem{ key: 'orderby', val: 'none' }, rt.ArrayItem{ key: 'type', val: 'all' }]),
	])
	if !(!rt.is_true(var_comment_children)) {
		mut var_args := {
			'parent': rt.get_property(var_comment_mutated, 'comment_ID')
		}
		mut var_rest_url := rt.call_function('add_query_arg', [
			rt.create_array_from_native_map(var_args),
			rt.call_function('rest_url', [
				rt.new_string((
					rt.get_property(rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this), 'namespace') +
					'/' +
					rt.get_property(rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this), 'rest_base')).str()),
			]),
		])
		var_links['children'] = rt.create_array([
			rt.ArrayItem{ key: 'href', val: var_rest_url },
			rt.ArrayItem{ key: 'embeddable', val: true },
		])
	}
	if var_links.array_isset(rt.new_string('children'))
		&& rt.is_true(rt.identical(rt.new_string('note'), rt.get_property(var_comment_mutated, 'comment_type'))) {
		var_args = {
			'parent': rt.get_property(var_comment_mutated, 'comment_ID')
			'type':   rt.get_property(var_comment_mutated, 'comment_type')
			'status': rt.new_string('all')
		}
		var_rest_url = rt.call_function('add_query_arg', [
			rt.create_array_from_native_map(var_args),
			rt.call_function('rest_url', [
				rt.new_string((
					rt.get_property(rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this), 'namespace') +
					'/' +
					rt.get_property(rt.new_object('WP_REST_Comments_Controller', ['WP_REST_Controller'], &this), 'rest_base')).str()),
			]),
		])
		var_links['children'] = rt.create_array([
			rt.ArrayItem{ key: 'href', val: var_rest_url },
			rt.ArrayItem{ key: 'embeddable', val: true },
		])
	}
	return var_links.clone()
}

fn (mut this Class_WP_REST_Comments_Controller) normalize_query_param(var_query_param rt.PhpVal) rt.PhpVal {
	mut var_prefix := rt.new_string('comment_')
	mut switch_val_1 := var_query_param
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('id'))) {
		mut var_normalized := rt.new_string(var_prefix.str() + 'ID')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('post'))) {
		var_normalized = rt.new_string(var_prefix.str() + 'post_ID')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('parent'))) {
		var_normalized = rt.new_string(var_prefix.str() + 'parent')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('include'))) {
		var_normalized = rt.new_string('comment__in')
	} else {
		var_normalized = rt.new_string(var_prefix.str() + var_query_param.str())
	}
	return var_normalized.clone()
}

fn (mut this Class_WP_REST_Comments_Controller) prepare_status_response(var_comment_approved rt.PhpVal) rt.PhpVal {
	mut switch_val_2 := var_comment_approved
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('hold')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('0'))) {
		mut var_status := rt.new_string('hold')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('approve')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('1'))) {
		var_status = rt.new_string('approved')
	} else {
		var_status = var_comment_approved
	}
	return var_status.clone()
}

fn (mut this Class_WP_REST_Comments_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_comment := []rt.PhpVal{}
	if var_request.array_isset(rt.new_string('content'))
		&& var_request.array_get(rt.new_string('content')).is_string() {
		var_prepared_comment.array_set('comment_content',
			var_request.array_get(rt.new_string('content')).to_string().trim_space())
	} else if var_request.array_get(rt.new_string('content')).array_isset(rt.new_string('raw'))
		&& var_request.array_get(rt.new_string('content')).array_get(rt.new_string('raw')).is_string() {
		var_prepared_comment.array_set('comment_content',
			var_request.array_get(rt.new_string('content')).array_get(rt.new_string('raw')).to_string().trim_space())
	}
	if var_request.array_isset(rt.new_string('post')) {
		var_prepared_comment.array_set('comment_post_ID',
			rt.new_int((var_request.array_get(rt.new_string('post'))).to_i64()))
	}
	if var_request.array_isset(rt.new_string('parent')) {
		var_prepared_comment.array_set('comment_parent',
			var_request.array_get(rt.new_string('parent')))
	}
	if var_request.array_isset(rt.new_string('author')) {
		mut var_user := create_wp_user(var_request.array_get(rt.new_string('author')))
		if rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{})) {
			var_prepared_comment.array_set('user_id', rt.get_property(var_user, 'ID'))
			var_prepared_comment.array_set('comment_author', rt.get_property(var_user,
				'display_name'))
			var_prepared_comment.array_set('comment_author_email', rt.get_property(var_user,
				'user_email'))
			var_prepared_comment.array_set('comment_author_url', rt.get_property(var_user,
				'user_url'))
		} else {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_comment_author_invalid'), rt.call_function('__', [
				rt.new_string('Invalid comment author ID.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
	}
	if var_request.array_isset(rt.new_string('author_name')) {
		var_prepared_comment.array_set('comment_author',
			var_request.array_get(rt.new_string('author_name')))
	}
	if var_request.array_isset(rt.new_string('author_email')) {
		var_prepared_comment.array_set('comment_author_email',
			var_request.array_get(rt.new_string('author_email')))
	}
	if var_request.array_isset(rt.new_string('author_url')) {
		var_prepared_comment.array_set('comment_author_url',
			var_request.array_get(rt.new_string('author_url')))
	}
	if var_request.array_isset(rt.new_string('author_ip'))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')])) {
		var_prepared_comment.array_set('comment_author_IP',
			var_request.array_get(rt.new_string('author_ip')))
	} else if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR'))))
		&& rt.is_true(rt.call_function('rest_is_ip_address', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR'))])) {
		var_prepared_comment.array_set('comment_author_IP',
			rt.get_superglobal('_SERVER').array_get(rt.new_string('REMOTE_ADDR')))
	} else {
		var_prepared_comment.array_set('comment_author_IP', '127.0.0.1')
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('author_user_agent')))) {
		var_prepared_comment.array_set('comment_agent',
			var_request.array_get(rt.new_string('author_user_agent')))
	} else if rt.is_true(rt.call_method(var_request, 'get_header', [
		rt.new_string('user_agent'),
	]))
	{
		var_prepared_comment.array_set('comment_agent', rt.call_method(var_request, 'get_header', [
			rt.new_string('user_agent'),
		]))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('date')))) {
		mut var_date_data := rt.call_function('rest_get_date_with_gmt', [
			var_request.array_get(rt.new_string('date')),
		])
		if !(!rt.is_true(var_date_data)) {
			mut list_tmp_1 := var_date_data
			var_prepared_comment.array_get_mut('comment_date') = list_tmp_1.array_get(0)
			var_prepared_comment.array_get_mut('comment_date_gmt') = list_tmp_1.array_get(1)
		}
	} else if !(!rt.is_true(var_request.array_get(rt.new_string('date_gmt')))) {
		var_date_data = rt.call_function('rest_get_date_with_gmt', [
			var_request.array_get(rt.new_string('date_gmt')),
			rt.new_bool(true),
		])
		if !(!rt.is_true(var_date_data)) {
			mut list_tmp_2 := var_date_data
			var_prepared_comment.array_get_mut('comment_date') = list_tmp_2.array_get(0)
			var_prepared_comment.array_get_mut('comment_date_gmt') = list_tmp_2.array_get(1)
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_preprocess_comment'),
		var_prepared_comment.clone(), var_request.clone()])
}

fn (mut this Class_WP_REST_Comments_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'comment' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Unique identifier for the comment.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'author', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The ID of the user object, if author was a user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'author_email', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Email address for the comment author.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'email' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Comments_Controller', [
							'WP_REST_Controller',
						], &this) },
						rt.ArrayItem{ key: none, val: 'check_comment_author_email' },
					]) },
					rt.ArrayItem{ key: 'validate_callback', val: rt.new_null() },
				]) },
			]) },
			rt.ArrayItem{ key: 'author_ip', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('IP address for the comment author.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'ip' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'author_name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Display name for the comment author.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
				]) },
			]) },
			rt.ArrayItem{ key: 'author_url', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('URL for the comment author.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'uri' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'author_user_agent', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('User agent for the comment author.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
				]) },
			]) },
			rt.ArrayItem{ key: 'content', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The content for the comment.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_null() },
					rt.ArrayItem{ key: 'validate_callback', val: rt.new_null() },
				]) },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'raw', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Content for the comment, as it exists in the database.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'rendered', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('HTML content for the comment, transformed for display.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
							rt.ArrayItem{ key: none, val: 'embed' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'date', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string("The date the comment was published, in the site's timezone."),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'date_gmt', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The date the comment was published, as GMT.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'link', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('URL to the comment.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'uri' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The ID for the parent of the comment.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'default', val: 0 },
			]) },
			rt.ArrayItem{ key: 'post', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The ID of the associated post object.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'default', val: 0 },
			]) },
			rt.ArrayItem{ key: 'status', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('State of the comment.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
				]) },
			]) },
			rt.ArrayItem{ key: 'type', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Type of the comment.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'default', val: 'comment' },
			]) },
		]) },
	])
	if rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')])) {
		mut var_avatar_properties := []rt.PhpVal{}
		mut var_avatar_sizes := rt.call_function('rest_get_avatar_sizes', []rt.PhpVal{})
		mut iter_5 := var_avatar_sizes.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_size := item_5.val
			var_avatar_properties.array_set(var_size, rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Avatar URL with image size of %d pixels.'),
					]),
					var_size.clone(),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'uri' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]))
		}
		var_schema.array_get_mut('properties').array_set('author_avatar_urls', rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Avatar URLs for the comment author.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
				rt.ArrayItem{ key: none, val: 'embed' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'properties', val: var_avatar_properties },
		]))
	}
	var_schema.array_get_mut('properties').array_set('meta', rt.call_method(this.meta,
		'get_field_schema', []rt.PhpVal{}))
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Comments_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Comments_Controller) get_collection_params() rt.PhpVal {
	mut var_query_params := this.Class_WP_REST_Controller.get_collection_params()
	var_query_params.array_get_mut('context').array_set('default', 'view')
	var_query_params.array_set('after', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to comments published after a given ISO8601 compliant date.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
	]))
	var_query_params.array_set('author', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to comments assigned to specific user IDs. Requires authorization.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_query_params.array_set('author_exclude', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Ensure result set excludes comments assigned to specific user IDs. Requires authorization.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_query_params.array_set('author_email', rt.create_array([
		rt.ArrayItem{ key: 'default', val: rt.new_null() },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to that from a specific author email. Requires authorization.'),
		]) },
		rt.ArrayItem{ key: 'format', val: 'email' },
		rt.ArrayItem{ key: 'type', val: 'string' },
	]))
	var_query_params.array_set('before', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to comments published before a given ISO8601 compliant date.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
	]))
	var_query_params.array_set('exclude', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Ensure result set excludes specific IDs.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: []rt.PhpVal{} },
	]))
	var_query_params.array_set('include', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to specific IDs.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: []rt.PhpVal{} },
	]))
	var_query_params.array_set('offset', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Offset the result set by a specific number of items.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
	]))
	var_query_params.array_set('order', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Order sort attribute ascending or descending.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'desc' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'asc' },
			rt.ArrayItem{ key: none, val: 'desc' },
		]) },
	]))
	var_query_params.array_set('orderby', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Sort collection by comment attribute.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'date_gmt' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'date' },
			rt.ArrayItem{ key: none, val: 'date_gmt' },
			rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'include' },
			rt.ArrayItem{ key: none, val: 'post' },
			rt.ArrayItem{ key: none, val: 'parent' },
			rt.ArrayItem{ key: none, val: 'type' },
		]) },
	]))
	var_query_params.array_set('parent', rt.create_array([
		rt.ArrayItem{ key: 'default', val: []rt.PhpVal{} },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to comments of specific parent IDs.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_query_params.array_set('parent_exclude', rt.create_array([
		rt.ArrayItem{ key: 'default', val: []rt.PhpVal{} },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Ensure result set excludes specific parent IDs.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_query_params.array_set('post', rt.create_array([
		rt.ArrayItem{ key: 'default', val: []rt.PhpVal{} },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to comments assigned to specific post IDs.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
	]))
	var_query_params.array_set('status', rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'approve' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to comments assigned a specific status. Requires authorization.'),
		]) },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_query_params.array_set('type', rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'comment' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to comments assigned a specific type. Requires authorization.'),
		]) },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_query_params.array_set('password', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The password for the post if it is password protected.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
	]))
	return rt.call_function('apply_filters', [
		rt.new_string('rest_comment_collection_params'),
		var_query_params.clone(),
	])
}

fn (mut this Class_WP_REST_Comments_Controller) handle_status_param(var_new_status rt.PhpVal, var_comment_id rt.PhpVal) bool {
	mut var_comment_id_mutated := var_comment_id
	mut var_old_status := rt.call_function('wp_get_comment_status', [
		var_comment_id_mutated.clone()])
	if rt.is_true(rt.identical(var_new_status, var_old_status)) {
		return false
	}
	mut switch_val_3 := var_new_status
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('approved')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('approve')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('1'))) {
		mut var_changed := rt.call_function('wp_set_comment_status', [
			var_comment_id_mutated.clone(), rt.new_string('approve')])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('hold')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('0'))) {
		var_changed = rt.call_function('wp_set_comment_status', [
			var_comment_id_mutated.clone(), rt.new_string('hold')])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('spam'))) {
		var_changed = rt.call_function('wp_spam_comment', [var_comment_id_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('unspam'))) {
		var_changed = rt.call_function('wp_unspam_comment', [
			var_comment_id_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('trash'))) {
		var_changed = rt.call_function('wp_trash_comment', [var_comment_id_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('untrash'))) {
		var_changed = rt.call_function('wp_untrash_comment', [
			var_comment_id_mutated.clone()])
	} else {
		var_changed = rt.new_bool(false)
	}
	return var_changed.to_bool()
}

fn (mut this Class_WP_REST_Comments_Controller) check_read_post_permission(var_post rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_post_mutated := var_post
	mut var_post_type := rt.call_function('get_post_type_object', [
		rt.get_property(var_post_mutated, 'post_type'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) {
		return false
	}
	mut var_posts_controller := rt.call_method(var_post_type, 'get_rest_controller', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_posts_controller,
		'WP_REST_Posts_Controller'))))))
	{
		var_posts_controller = create_wp_rest_posts_controller(rt.get_property(var_post_mutated,
			'post_type'))
	}
	mut var_has_password_filter := rt.new_bool(false)
	mut var_requested_post := rt.new_bool(
		!(!rt.is_true(var_request.array_get(rt.new_string('post'))))
		&& !(var_request.array_get(rt.new_string('post')).is_array())
		|| 1 == var_request.array_get(rt.new_string('post')).array_count())
	mut var_requested_comment :=
		rt.new_bool(!(!rt.is_true(var_request.array_get(rt.new_string('id')))))
	if rt.is_true(var_requested_post) || rt.is_true(var_requested_comment)
		&& rt.is_true(rt.call_method(var_posts_controller, 'can_access_password_content', [var_post_mutated.clone(), var_request.clone()])) {
		rt.call_function('add_filter', [rt.new_string('post_password_required'),
			rt.new_string('__return_false')])
		var_has_password_filter = rt.new_bool(true)
	}
	if rt.is_true(rt.call_function('post_password_required', [
		var_post_mutated.clone()]))
	{
		mut var_result := rt.call_function('current_user_can', [
			rt.new_string('edit_post'),
			rt.get_property(var_post_mutated, 'ID'),
		])
	} else {
		var_result = rt.call_method(var_posts_controller, 'check_read_permission', [
			var_post_mutated.clone(),
		])
	}
	if rt.is_true(var_has_password_filter) {
		rt.call_function('remove_filter', [rt.new_string('post_password_required'),
			rt.new_string('__return_false')])
	}
	return var_result.to_bool()
}

fn (mut this Class_WP_REST_Comments_Controller) check_read_permission(var_comment rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_comment_mutated := var_comment
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('note'), rt.get_property(var_comment_mutated, 'comment_type')))))
		&& !(!rt.is_true(rt.get_property(var_comment_mutated, 'comment_post_ID'))) {
		mut var_post := rt.call_function('get_post', [
			rt.get_property(var_comment_mutated, 'comment_post_ID'),
		])
		if rt.is_true(var_post) {
			if this.check_read_post_permission(var_post.clone(), var_request.clone())
				&& 1 == rt.new_int((rt.get_property(var_comment_mutated, 'comment_approved')).to_i64()) {
				return true
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_int(0),
		rt.call_function('get_current_user_id', []rt.PhpVal{})))
	{
		return false
	}
	if !rt.is_true(rt.get_property(var_comment_mutated, 'comment_post_ID'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')]))))) {
		return false
	}
	if !(!rt.is_true(rt.get_property(var_comment_mutated, 'user_id')))
		&& rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_int((rt.get_property(var_comment_mutated, 'user_id')).to_i64()))) {
		return true
	}
	return (rt.call_function('current_user_can', [rt.new_string('edit_comment'),
		rt.get_property(var_comment_mutated, 'comment_ID')])).to_bool()
}

fn (mut this Class_WP_REST_Comments_Controller) check_edit_permission(var_comment rt.PhpVal) bool {
	mut var_comment_mutated := var_comment
	if 0 == rt.new_int((rt.call_function('get_current_user_id', []rt.PhpVal{})).to_i64()) {
		return false
	}
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('moderate_comments'),
	]))
	{
		return true
	}
	return (rt.call_function('current_user_can', [rt.new_string('edit_comment'),
		rt.get_property(var_comment_mutated, 'comment_ID')])).to_bool()
}

fn (mut this Class_WP_REST_Comments_Controller) check_comment_author_email(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	mut var_email := rt.new_string(var_value.str())
	if !rt.is_true(var_email) {
		return var_email.clone()
	}
	mut var_check_email := rt.call_function('rest_validate_request_arg', [
		var_email.clone(), var_request.clone(), var_param.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_check_email.clone()])) {
		return var_check_email.clone()
	}
	return var_email.clone()
}

fn (mut this Class_WP_REST_Comments_Controller) check_is_comment_content_allowed(var_prepared_comment rt.PhpVal) bool {
	mut var_prepared_comment_mutated := var_prepared_comment
	if !(var_prepared_comment_mutated.array_isset(rt.new_string('comment_content'))) {
		return true
	}
	mut var_check := rt.call_function('wp_parse_args', [var_prepared_comment_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'comment_post_ID', val: 0 },
			rt.ArrayItem{ key: 'comment_author', val: rt.new_null() },
			rt.ArrayItem{ key: 'comment_author_email', val: rt.new_null() },
			rt.ArrayItem{ key: 'comment_author_url', val: rt.new_null() },
			rt.ArrayItem{ key: 'comment_parent', val: 0 }, rt.ArrayItem{ key: 'user_id', val: 0 }])])
	mut var_allow_empty := rt.call_function('apply_filters', [
		rt.new_string('allow_empty_comment'),
		rt.new_bool(false),
		var_check.clone(),
	])
	if rt.is_true(var_allow_empty) {
		return true
	}
	if var_check.array_isset(rt.new_string('comment_type'))
		&& rt.is_true(rt.identical(rt.new_string('note'), var_check.array_get(rt.new_string('comment_type'))))
		&& var_check.array_get(rt.new_string('meta')).array_isset(rt.new_string('_wp_note_status'))
		&& rt.is_true(rt.call_function('in_array', [var_check.array_get(rt.new_string('meta')).array_get(rt.new_string('_wp_note_status')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'resolved'
	}, rt.ArrayItem{ key: none, val: 'reopen' }]), rt.new_bool(true)])) {
		return true
	}
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		var_check.array_get(rt.new_string('comment_content')))))
}

fn (mut this Class_WP_REST_Comments_Controller) check_post_type_supports_notes(var_post_type rt.PhpVal) bool {
	mut var_post_type_mutated := var_post_type
	mut var_supports := rt.call_function('get_all_post_type_supports', [
		var_post_type_mutated.clone()])
	if !(var_supports.array_isset(rt.new_string('editor'))) {
		return false
	}
	if !(var_supports.array_get(rt.new_string('editor')).is_array()) {
		return false
	}
	mut iter_6 := var_supports.array_get(rt.new_string('editor')).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_item := item_6.val
		if !(!rt.is_true(var_item.array_get(rt.new_string('notes')))) {
			return true
		}
	}
	return false
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

struct Class_WP_User {
	rt.PhpObjectBase
}

struct Class_WP_REST_Posts_Controller {
	rt.PhpObjectBase
}

fn create_wp_rest_comments_controller() &Class_WP_REST_Comments_Controller {
	mut obj := &Class_WP_REST_Comments_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		meta:          rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_rest_controller(_args ...rt.PhpVal) &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_comment_meta_fields(_args ...rt.PhpVal) &Class_WP_REST_Comment_Meta_Fields {
	mut obj := &Class_WP_REST_Comment_Meta_Fields{
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

fn create_wp_comment_query(_args ...rt.PhpVal) &Class_WP_Comment_Query {
	mut obj := &Class_WP_Comment_Query{
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

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_posts_controller(_args ...rt.PhpVal) &Class_WP_REST_Posts_Controller {
	mut obj := &Class_WP_REST_Posts_Controller{
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
		else {
			return none
		}
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
		'meta' {
			this.meta = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
