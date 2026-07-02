import rt

struct Class_WP_REST_Revisions_Controller {
	rt.PhpObjectBase
pub mut:
	parent_post_type  rt.PhpVal = rt.new_null()
	meta              rt.PhpVal = rt.new_null()
	parent_controller rt.PhpVal = rt.new_null()
	parent_base       rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Revisions_Controller) construct(var_parent_post_type rt.PhpVal) {
	this.parent_post_type = var_parent_post_type.clone()
	mut var_post_type_object := rt.call_function('get_post_type_object', [
		var_parent_post_type.clone()])
	mut var_parent_controller := rt.call_method(var_post_type_object, 'get_rest_controller',
		[]rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parent_controller)))) {
		var_parent_controller = create_wp_rest_posts_controller(var_parent_post_type.clone())
	}
	this.parent_controller = var_parent_controller.clone()
	this.dispatch_set_prop('rest_base', rt.new_string('revisions'))
	this.parent_base = if !(!rt.is_true(rt.get_property(var_post_type_object, 'rest_base'))) {
		rt.get_property(var_post_type_object, 'rest_base')
	} else {
		rt.get_property(var_post_type_object, 'name')
	}
	this.dispatch_set_prop('namespace', if !(!rt.is_true(rt.get_property(var_post_type_object,
		'rest_namespace'))) {
		rt.get_property(var_post_type_object, 'rest_namespace')
	} else {
		rt.new_string('wp/v2')
	})
	this.meta = create_wp_rest_post_meta_fields(var_parent_post_type.clone())
}

fn (mut this Class_WP_REST_Revisions_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Revisions_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +(this.parent_base).str() + '/(?P<parent>[\\d]+)/' +
			rt.get_property(rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this), 'rest_base')),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'parent', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The ID for the parent of the revision.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Revisions_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			(this.parent_base).str() + '/(?P<parent>[\\d]+)/' + rt.get_property(rt.new_object('WP_REST_Revisions_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'parent', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The ID for the parent of the revision.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the revision.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', [
						'WP_REST_Controller',
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
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'force', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'default', val: false },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Required to be true, as revisions do not support trashing.'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Revisions_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Revisions_Controller) get_parent(var_parent_post_id rt.PhpVal) rt.PhpVal {
	mut var_error := create_wp_error(rt.new_string('rest_post_invalid_parent'), rt.call_function('__', [
		rt.new_string('Invalid post parent ID.'),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	if rt.new_int(var_parent_post_id.to_i64()) <= 0 {
		return mut var_error
	}
	mut var_parent_post := rt.call_function('get_post', [
		rt.new_int(var_parent_post_id.to_i64()),
	])
	if !rt.is_true(var_parent_post) || !rt.is_true(rt.get_property(var_parent_post, 'ID'))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.parent_post_type, rt.get_property(var_parent_post, 'post_type'))))) {
		return mut var_error
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_parent_post)
}

fn (mut this Class_WP_REST_Revisions_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_parent := this.get_parent(var_request.array_get(rt.new_string('parent')))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent.clone()])) {
		return var_parent.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		rt.get_property(var_parent, 'ID'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_read'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to view revisions of this post.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Revisions_Controller) get_revision(var_id rt.PhpVal) rt.PhpVal {
	mut var_error := create_wp_error(rt.new_string('rest_post_invalid_id'), rt.call_function('__', [
		rt.new_string('Invalid revision ID.'),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	if rt.new_int(var_id.to_i64()) <= 0 {
		return mut var_error
	}
	mut var_revision := rt.call_function('get_post', [rt.new_int(var_id.to_i64())])
	if !rt.is_true(var_revision) || !rt.is_true(rt.get_property(var_revision, 'ID'))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('revision'), rt.get_property(var_revision, 'post_type'))))) {
		return mut var_error
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_revision)
}

fn (mut this Class_WP_REST_Revisions_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_parent := this.get_parent(var_request.array_get(rt.new_string('parent')))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent.clone()])) {
		return var_parent.clone()
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('orderby'))))
		&& rt.is_true(rt.identical(rt.new_string('relevance'), var_request.array_get(rt.new_string('orderby'))))
		&& !rt.is_true(var_request.array_get(rt.new_string('search'))) {
		return create_wp_error(rt.new_string('rest_no_search_term_defined'), rt.call_function('__', [
			rt.new_string('You need to define a search term to order by relevance.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('orderby'))))
		&& rt.is_true(rt.identical(rt.new_string('include'), var_request.array_get(rt.new_string('orderby'))))
		&& !rt.is_true(var_request.array_get(rt.new_string('include'))) {
		return create_wp_error(rt.new_string('rest_orderby_include_missing_include'), rt.call_function('__', [
			rt.new_string('You need to define an include parameter to order by include.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_is_head_request := rt.call_method(var_request, 'is_method', [
		rt.new_string('HEAD'),
	])
	if rt.is_true(rt.call_function('wp_revisions_enabled', [var_parent.clone()])) {
		mut var_registered := this.get_collection_params()
		mut var_args := rt.create_array([
			rt.ArrayItem{ key: 'post_parent', val: rt.get_property(var_parent, 'ID') },
			rt.ArrayItem{ key: 'post_type', val: 'revision' },
			rt.ArrayItem{ key: 'post_status', val: 'inherit' },
			rt.ArrayItem{ key: 'posts_per_page', val: -1 },
			rt.ArrayItem{ key: 'orderby', val: 'date ID' },
			rt.ArrayItem{ key: 'order', val: 'DESC' },
			rt.ArrayItem{ key: 'suppress_filters', val: true },
		])
		mut var_parameter_mappings := {
			'exclude':  'post__not_in'
			'include':  'post__in'
			'offset':   'offset'
			'order':    'order'
			'orderby':  'orderby'
			'page':     'paged'
			'per_page': 'posts_per_page'
			'search':   's'
		}
		for var_api_param, var_wp_param in var_parameter_mappings {
			if var_registered.array_isset(rt.new_string(api_param))
				&& var_request.array_isset(rt.new_string(api_param)) {
				var_args.array_set(wp_param, var_request.array_get(rt.new_string(api_param)))
			}
		}
		if var_args.array_isset(rt.new_string('orderby'))
			&& rt.is_true(rt.identical(rt.new_string('date'), var_args.array_get(rt.new_string('orderby')))) {
			var_args.array_set('orderby', 'date ID')
		}
		if rt.is_true(var_is_head_request) {
			var_args.array_set('fields', 'ids')
			var_args.array_set('update_post_term_cache', false)
			var_args.array_set('update_post_meta_cache', false)
		}
		var_args = rt.call_function('apply_filters', [
			rt.new_string('rest_revision_query'),
			var_args.clone(),
			var_request.clone(),
		])
		if !(var_args.clone().is_array()) {
			var_args = rt.new_array()
		}
		mut var_query_args := this.prepare_items_query(var_args.clone(), var_request.clone())
		mut var_revisions_query := create_wp_query()
		mut var_revisions := var_revisions_query.query(var_query_args.clone())
		mut var_offset := rt.new_int(if var_query_args.array_isset(rt.new_string('offset')) {
			rt.new_int((var_query_args.array_get(rt.new_string('offset'))).to_i64())
		} else {
			0
		})
		mut var_page := rt.new_int(if var_query_args.array_isset(rt.new_string('paged')) {
			rt.new_int((var_query_args.array_get(rt.new_string('paged'))).to_i64())
		} else {
			0
		})
		mut var_total_revisions := rt.get_property(var_revisions_query, 'found_posts')
		if rt.is_true(rt.less(var_total_revisions, rt.new_int(1))) {
			var_query_args.array_unset(rt.new_string('paged'))
			var_query_args.array_unset(rt.new_string('offset'))
			mut var_count_query := create_wp_query()
			var_query_args.array_set('fields', 'ids')
			var_query_args.array_set('posts_per_page', 1)
			var_query_args.array_set('update_post_meta_cache', false)
			var_query_args.array_set('update_post_term_cache', false)
			var_count_query.query(var_query_args.clone())
			var_total_revisions = rt.get_property(var_count_query, 'found_posts')
		}
		if rt.is_true(rt.greater(rt.get_property(var_revisions_query, 'query_vars').array_get(rt.new_string('posts_per_page')),
			rt.new_int(0)))
		{
			mut var_max_pages := rt.new_int((rt.call_function('ceil', [
				rt.div(var_total_revisions, rt.new_int((rt.get_property(var_revisions_query,
					'query_vars').array_get(rt.new_string('posts_per_page'))).to_i64())),
			])).to_i64())
		} else {
			var_max_pages = rt.new_int(if rt.is_true(rt.greater(var_total_revisions, rt.new_int(0))) {
				1
			} else {
				0
			})
		}
		if rt.is_true(rt.greater(var_total_revisions, rt.new_int(0))) {
			if rt.is_true(rt.greater_equal(var_offset, var_total_revisions)) {
				return create_wp_error(rt.new_string('rest_revision_invalid_offset_number'), rt.call_function('__', [
					rt.new_string('The offset number requested is larger than or equal to the number of available revisions.'),
				]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_offset))))
				&& rt.is_true(rt.greater(var_page, var_max_pages)) {
				return create_wp_error(rt.new_string('rest_revision_invalid_page_number'), rt.call_function('__', [
					rt.new_string('The page number requested is larger than the number of pages available.'),
				]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
			}
		}
	} else {
		var_revisions = rt.new_array()
		var_total_revisions = rt.new_int(0)
		var_max_pages = rt.new_int(0)
		var_page = rt.new_int((var_request.array_get(rt.new_string('page'))).to_i64())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_head_request)))) {
		mut var_response := rt.new_array()
		mut iter_1 := var_revisions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_revision := item_1.val
			mut var_data := this.prepare_item_for_response(var_revision.clone(),
				var_request.clone())
			var_response.array_push(this.prepare_response_for_collection(var_data.clone()))
		}
		var_response = rt.call_function('rest_ensure_response', [
			var_response.clone()])
	} else {
		var_response = create_wp_rest_response(rt.new_array())
	}
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int(var_total_revisions.to_i64())])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int(var_max_pages.to_i64())])
	mut var_request_params := rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})
	mut var_base_path := rt.call_function('rest_url', [
		rt.call_function('sprintf', [rt.new_string('%s/%s/%d/%s'),
			rt.get_property(rt.new_object('WP_REST_Revisions_Controller', [
				'WP_REST_Controller',
			], &this), 'namespace'),
			this.parent_base, var_request.array_get(rt.new_string('parent')),
			rt.get_property(rt.new_object('WP_REST_Revisions_Controller', [
				'WP_REST_Controller',
			], &this), 'rest_base')]),
	])
	mut var_base := rt.call_function('add_query_arg', [
		rt.call_function('urlencode_deep', [var_request_params.clone()]),
		var_base_path.clone(),
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

fn (mut this Class_WP_REST_Revisions_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.get_items_permissions_check(var_request.clone()))
}

fn (mut this Class_WP_REST_Revisions_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_parent := this.get_parent(var_request.array_get(rt.new_string('parent')))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent.clone()])) {
		return var_parent.clone()
	}
	mut var_revision := this.get_revision(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_revision.clone()])) {
		return var_revision.clone()
	}
	if rt.is_true(rt.new_bool(rt.new_int((rt.get_property(var_parent, 'ID')).to_i64()) != rt.new_int((rt.get_property(var_revision,
		'post_parent')).to_i64())))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_revision_parent_id_mismatch'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The revision does not belong to the specified parent with id of "%d"'),
			]),
			rt.get_property(var_parent, 'ID'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_response := this.prepare_item_for_response(var_revision.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WP_REST_Revisions_Controller) delete_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_parent := this.get_parent(var_request.array_get(rt.new_string('parent')))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent.clone()])) {
		return var_parent.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_post'),
		rt.get_property(var_parent, 'ID'),
	])))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete revisions of this post.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		])))
	}
	mut var_revision := this.get_revision(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_revision.clone()])) {
		return var_revision.clone()
	}
	mut var_response := rt.new_bool(this.get_items_permissions_check(var_request.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_response))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return var_response.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_post'),
		rt.get_property(var_revision, 'ID'),
	])))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete this revision.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		])))
	}
	return rt.new_bool(true)
}

fn (mut this Class_WP_REST_Revisions_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_revision := this.get_revision(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_revision.clone()])) {
		return var_revision.clone()
	}
	mut var_force := rt.new_bool(if var_request.array_isset(rt.new_string('force')) {
		(var_request.array_get(rt.new_string('force'))).to_bool()
	} else {
		false
	})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_force)))) {
		return create_wp_error(rt.new_string('rest_trash_not_supported'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string("Revisions do not support trashing. Set '%s' to delete."),
			]),
			rt.new_string('force=true'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }]))
	}
	mut var_previous := this.prepare_item_for_response(var_revision.clone(), var_request.clone())
	mut var_result := rt.call_function('wp_delete_post', [
		var_request.array_get(rt.new_string('id')),
		rt.new_bool(true),
	])
	rt.call_function('do_action', [rt.new_string('rest_delete_revision'),
		var_result.clone(), var_request.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('The post cannot be deleted.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	mut var_response := create_wp_rest_response()
	rt.call_method(var_response, 'set_data', [
		rt.create_array([rt.ArrayItem{ key: 'deleted', val: true },
			rt.ArrayItem{ key: 'previous', val: rt.call_method(var_previous, 'get_data',
				[]rt.PhpVal{}) }]),
	])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Revisions_Controller) prepare_items_query(var_prepared_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_args_mutated := var_prepared_args
	mut var_query_args := rt.new_array()
	if !(var_prepared_args_mutated.clone().is_array()) {
		var_prepared_args_mutated = rt.new_array()
	}
	mut iter_2 := var_prepared_args_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_key := item_2.key
		var_query_args.array_set(var_key, rt.call_function('apply_filters', [
			rt.new_string('rest_query_var-${var_key.to_string()}'),
			var_value.clone(),
		]))
	}
	if var_query_args.array_isset(rt.new_string('orderby'))
		&& var_request.array_isset(rt.new_string('orderby')) {
		mut var_orderby_mappings := rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'ID' },
			rt.ArrayItem{ key: 'include', val: 'post__in' },
			rt.ArrayItem{ key: 'slug', val: 'post_name' },
			rt.ArrayItem{ key: 'include_slugs', val: 'post_name__in' },
		])
		if var_orderby_mappings.array_isset(var_request.array_get(rt.new_string('orderby'))) {
			var_query_args.array_set('orderby',
				var_orderby_mappings.array_get(var_request.array_get(rt.new_string('orderby'))))
		}
	}
	return var_query_args.clone()
}

fn (mut this Class_WP_REST_Revisions_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_post := var_item
	var_GLOBALS.array_set('post', var_post.clone())
	rt.call_function('setup_postdata', [var_post.clone()])
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.call_function('apply_filters', [rt.new_string('rest_prepare_revision'),
			create_wp_rest_response(rt.new_array()), var_post.clone(),
			var_request.clone()])
	}
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('in_array', [rt.new_string('author'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('author',
			rt.new_int((rt.get_property(var_post, 'post_author')).to_i64()))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('date'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('date', this.prepare_date_response(rt.get_property(var_post,
			'post_date_gmt'), rt.get_property(var_post, 'post_date')))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('date_gmt'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('date_gmt', this.prepare_date_response(rt.get_property(var_post,
			'post_date_gmt'), rt.new_null()))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('id'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('id', rt.get_property(var_post, 'ID'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('modified'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('modified', this.prepare_date_response(rt.get_property(var_post,
			'post_modified_gmt'), rt.get_property(var_post, 'post_modified')))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('modified_gmt'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('modified_gmt', this.prepare_date_response(rt.get_property(var_post,
			'post_modified_gmt'), rt.new_null()))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('parent'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('parent',
			rt.new_int((rt.get_property(var_post, 'post_parent')).to_i64()))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('slug'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('slug', rt.get_property(var_post, 'post_name'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('guid'), var_fields.clone()]))
	{
		var_data.array_set('guid', rt.new_array())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('guid.rendered'),
		var_fields.clone(),
	]))
	{
		var_data.array_get_mut('guid').array_set('rendered', rt.call_function('apply_filters', [
			rt.new_string('get_the_guid'),
			rt.get_property(var_post, 'guid'),
			rt.get_property(var_post, 'ID'),
		]))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('guid.raw'), var_fields.clone()]))
	{
		var_data.array_get_mut('guid').array_set('raw', rt.get_property(var_post, 'guid'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('title'), var_fields.clone()]))
	{
		var_data.array_set('title', rt.new_array())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('title.raw'), var_fields.clone()]))
	{
		var_data.array_get_mut('title').array_set('raw', rt.get_property(var_post, 'post_title'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('title.rendered'),
		var_fields.clone(),
	]))
	{
		var_data.array_get_mut('title').array_set('rendered', rt.call_function('get_the_title', [
			rt.get_property(var_post, 'ID'),
		]))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('content'), var_fields.clone()]))
	{
		var_data.array_set('content', rt.new_array())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('content.raw'),
		var_fields.clone(),
	]))
	{
		var_data.array_get_mut('content').array_set('raw',
			rt.get_property(var_post, 'post_content'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('content.rendered'),
		var_fields.clone(),
	]))
	{
		var_data.array_get_mut('content').array_set('rendered', rt.call_function('apply_filters', [
			rt.new_string('the_content'),
			rt.get_property(var_post, 'post_content'),
		]))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('excerpt'), var_fields.clone()]))
	{
		var_data.array_set('excerpt', rt.new_array())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('excerpt.raw'),
		var_fields.clone(),
	]))
	{
		var_data.array_get_mut('excerpt').array_set('raw',
			rt.get_property(var_post, 'post_excerpt'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('excerpt.rendered'),
		var_fields.clone(),
	]))
	{
		var_data.array_get_mut('excerpt').array_set('rendered', this.prepare_excerpt_response(rt.get_property(var_post,
			'post_excerpt'), var_post.clone()))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('meta'), var_fields.clone()]))
	{
		var_data.array_set('meta', rt.call_method(this.meta, 'get_value', [
			rt.get_property(var_post, 'ID'),
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
	if !(!rt.is_true(var_data.array_get(rt.new_string('parent')))) {
		rt.call_method(var_response, 'add_link', [rt.new_string('parent'),
			rt.call_function('rest_url', [
				rt.call_function('rest_get_route_for_post', [
					var_data.array_get(rt.new_string('parent')),
				]),
			])])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_revision'),
		var_response.clone(), var_post.clone(), var_request.clone()])
}

fn (mut this Class_WP_REST_Revisions_Controller) prepare_date_response(var_date_gmt rt.PhpVal, var_date rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), var_date_gmt)) {
		return rt.new_null()
	}
	if !var_date.is_null() {
		return rt.call_function('mysql_to_rfc3339', [var_date.clone()])
	}
	return rt.call_function('mysql_to_rfc3339', [var_date_gmt.clone()])
}

fn (mut this Class_WP_REST_Revisions_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Revisions_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Revisions_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.concat(this.parent_post_type, rt.new_string('-revision'))
		'type':       rt.new_string('object')
		'properties': {
			'author':       {
				'description': rt.call_function('__', [
					rt.new_string('The ID for the author of the revision.'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
			}
			'date':         {
				'description': rt.call_function('__', [
					rt.new_string("The date the revision was published, in the site's timezone."),
				])
				'type':        rt.new_string('string')
				'format':      rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
			}
			'date_gmt':     {
				'description': rt.call_function('__', [
					rt.new_string('The date the revision was published, as GMT.'),
				])
				'type':        rt.new_string('string')
				'format':      rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
			}
			'guid':         {
				'description': rt.call_function('__', [
					rt.new_string('GUID for the revision, as it exists in the database.'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'id':           {
				'description': rt.call_function('__', [
					rt.new_string('Unique identifier for the revision.'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
			}
			'modified':     {
				'description': rt.call_function('__', [
					rt.new_string("The date the revision was last modified, in the site's timezone."),
				])
				'type':        rt.new_string('string')
				'format':      rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
			}
			'modified_gmt': {
				'description': rt.call_function('__', [
					rt.new_string('The date the revision was last modified, as GMT.'),
				])
				'type':        rt.new_string('string')
				'format':      rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
			}
			'parent':       {
				'description': rt.call_function('__', [
					rt.new_string('The ID for the parent of the revision.'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
			}
			'slug':         {
				'description': rt.call_function('__', [
					rt.new_string('An alphanumeric identifier for the revision unique to its type.'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
		}
	}
	mut var_parent_schema := rt.call_method(this.parent_controller, 'get_item_schema',
		[]rt.PhpVal{})
	if !(!rt.is_true(var_parent_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('title')))) {
		var_schema.array_get_mut('properties').array_set('title',
			var_parent_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('title')))
	}
	if !(!rt.is_true(var_parent_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('content')))) {
		var_schema.array_get_mut('properties').array_set('content',
			var_parent_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('content')))
	}
	if !(!rt.is_true(var_parent_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('excerpt')))) {
		var_schema.array_get_mut('properties').array_set('excerpt',
			var_parent_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('excerpt')))
	}
	if !(!rt.is_true(var_parent_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('guid')))) {
		var_schema.array_get_mut('properties').array_set('guid',
			var_parent_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('guid')))
	}
	var_schema.array_get_mut('properties').array_set('meta', rt.call_method(this.meta,
		'get_field_schema', []rt.PhpVal{}))
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Revisions_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Revisions_Controller) get_collection_params() rt.PhpVal {
	mut var_query_params := this.Class_WP_REST_Controller.get_collection_params()
	var_query_params.array_get_mut('context').array_set('default', 'view')
	var_query_params.array_get(rt.new_string('per_page')).array_unset(rt.new_string('default'))
	var_query_params.array_set('exclude', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Ensure result set excludes specific IDs.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
	]))
	var_query_params.array_set('include', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to specific IDs.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
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
			rt.new_string('Sort collection by object attribute.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'date' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'date' },
			rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'include' },
			rt.ArrayItem{ key: none, val: 'relevance' },
			rt.ArrayItem{ key: none, val: 'slug' },
			rt.ArrayItem{ key: none, val: 'include_slugs' },
			rt.ArrayItem{ key: none, val: 'title' },
		]) },
	]))
	return var_query_params.clone()
}

fn (mut this Class_WP_REST_Revisions_Controller) prepare_excerpt_response(var_excerpt rt.PhpVal, var_post rt.PhpVal) string {
	mut var_excerpt_mutated := var_excerpt
	mut var_post_mutated := var_post
	var_excerpt_mutated = rt.call_function('apply_filters', [
		rt.new_string('the_excerpt'),
		var_excerpt_mutated.clone(),
		var_post_mutated.clone(),
	])
	if !rt.is_true(var_excerpt_mutated) {
		return ''
	}
	return var_excerpt_mutated.str()
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
		PhpObjectBase:     rt.PhpObjectBase{}
		parent_post_type:  rt.new_null()
		meta:              rt.new_null()
		parent_controller: rt.new_null()
		parent_base:       rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_rest_controller(_args ...rt.PhpVal) &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
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

fn create_wp_rest_post_meta_fields(_args ...rt.PhpVal) &Class_WP_REST_Post_Meta_Fields {
	mut obj := &Class_WP_REST_Post_Meta_Fields{
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

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
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
		else {
			return none
		}
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
		'parent_post_type' {
			this.parent_post_type = val
			return true
		}
		'meta' {
			this.meta = val
			return true
		}
		'parent_controller' {
			this.parent_controller = val
			return true
		}
		'parent_base' {
			this.parent_base = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}
