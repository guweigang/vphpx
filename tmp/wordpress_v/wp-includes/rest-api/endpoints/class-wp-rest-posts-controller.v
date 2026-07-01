import rt

struct Class_WP_REST_Posts_Controller {
	rt.PhpObjectBase
pub mut:
		post_type rt.PhpVal = rt.new_null()
		meta rt.PhpVal = rt.new_null()
		password_check_passed rt.PhpVal = rt.new_array()
		allow_batch rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_REST_Posts_Controller) construct(var_post_type rt.PhpVal)  {
	mut var_post_type_mutated := var_post_type
	this.post_type = var_post_type_mutated.dup()
	mut var_obj := rt.call_function('get_post_type_object', [var_post_type_mutated.dup()])
	this.dispatch_set_prop('rest_base', if !(!rt.is_true(rt.get_property(var_obj, 'rest_base'))) { rt.get_property(var_obj, 'rest_base') } else { rt.get_property(var_obj, 'name') })
	this.dispatch_set_prop('namespace', if !(!rt.is_true(rt.get_property(var_obj, 'rest_namespace'))) { rt.get_property(var_obj, 'rest_namespace') } else { rt.new_string('wp/v2') })
	this.meta = create_wp_rest_post_meta_fields(this.post_type)
}

fn (mut this Class_WP_REST_Posts_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'rest_base')).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	mut var_schema := this.get_item_schema()
	mut var_get_item_args := { 'context': this.get_context_param({ 'default': rt.new_string('view') }) }
	if var_schema.array_get('properties').array_isset(rt.new_string('excerpt')) {
		var_get_item_args['excerpt_length'] = rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Override the default excerpt length.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }])
	}
	if var_schema.array_get('properties').array_isset(rt.new_string('password')) {
		var_get_item_args['password'] = rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The password for the post if it is password protected.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }])
	}
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'rest_base')).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the post.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: var_get_item_args }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass Trash and force deletion.')]) }]) }]) }]) }, rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Posts_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_post_type := rt.call_function('get_post_type_object', [this.post_type])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get('context'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts')]))))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit posts in this post type.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Posts_Controller) check_password_required(var_required rt.PhpVal, var_post rt.PhpVal) bool {
	mut var_post_mutated := var_post
	if rt.is_true(rt.new_bool(!(rt.is_true(var_required)))) {
		return (var_required).to_bool()
	}
	var_post_mutated = rt.call_function('get_post', [var_post_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_mutated)))) {
		return (var_required).to_bool()
	}
	if !(!rt.is_true(this.password_check_passed.array_get(rt.get_property(var_post_mutated, 'ID')))) {
		return false
	}
	return !(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post_mutated, 'ID')])))
}

fn (mut this Class_WP_REST_Posts_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_request.array_get('orderby'))) && rt.is_true(rt.identical(rt.new_string('relevance'), var_request.array_get('orderby'))))) && !rt.is_true(var_request.array_get('search')))) {
		return create_wp_error(rt.new_string('rest_no_search_term_defined'), rt.call_function('__', [rt.new_string('You need to define a search term to order by relevance.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_request.array_get('orderby'))) && rt.is_true(rt.identical(rt.new_string('include'), var_request.array_get('orderby'))))) && !rt.is_true(var_request.array_get('include')))) {
		return create_wp_error(rt.new_string('rest_orderby_include_missing_include'), rt.call_function('__', [rt.new_string('You need to define an include parameter to order by include.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_registered := this.get_collection_params()
	mut var_args := rt.new_array()
	mut var_parameter_mappings := { 'author': 'author__in', 'author_exclude': 'author__not_in', 'exclude': 'post__not_in', 'include': 'post__in', 'ignore_sticky': 'ignore_sticky_posts', 'menu_order': 'menu_order', 'offset': 'offset', 'order': 'order', 'orderby': 'orderby', 'page': 'paged', 'parent': 'post_parent__in', 'parent_exclude': 'post_parent__not_in', 'search': 's', 'search_columns': 'search_columns', 'slug': 'post_name__in', 'status': 'post_status' }
	for var_api_param, var_wp_param in var_parameter_mappings {
		if var_registered.array_isset(rt.new_string(api_param)) && var_request.array_isset(rt.new_string(api_param)) {
			var_args.array_set(wp_param, var_request.array_get(api_param))
		}
	}
	var_args.array_set('date_query', rt.new_array())
	if var_registered.array_isset(rt.new_string('before')) && var_request.array_isset(rt.new_string('before')) {
		var_args.array_get_mut('date_query').array_push(rt.create_array([rt.ArrayItem{ key: 'before', val: var_request.array_get('before') }, rt.ArrayItem{ key: 'column', val: 'post_date' }]))
	}
	if var_registered.array_isset(rt.new_string('modified_before')) && var_request.array_isset(rt.new_string('modified_before')) {
		var_args.array_get_mut('date_query').array_push(rt.create_array([rt.ArrayItem{ key: 'before', val: var_request.array_get('modified_before') }, rt.ArrayItem{ key: 'column', val: 'post_modified' }]))
	}
	if var_registered.array_isset(rt.new_string('after')) && var_request.array_isset(rt.new_string('after')) {
		var_args.array_get_mut('date_query').array_push(rt.create_array([rt.ArrayItem{ key: 'after', val: var_request.array_get('after') }, rt.ArrayItem{ key: 'column', val: 'post_date' }]))
	}
	if var_registered.array_isset(rt.new_string('modified_after')) && var_request.array_isset(rt.new_string('modified_after')) {
		var_args.array_get_mut('date_query').array_push(rt.create_array([rt.ArrayItem{ key: 'after', val: var_request.array_get('modified_after') }, rt.ArrayItem{ key: 'column', val: 'post_modified' }]))
	}
	if var_registered.array_isset(rt.new_string('per_page')) {
		var_args.array_set('posts_per_page', var_request.array_get('per_page'))
	}
	if var_registered.array_isset(rt.new_string('sticky')) && var_request.array_isset(rt.new_string('sticky')) {
		mut var_sticky_posts := rt.call_function('get_option', [rt.new_string('sticky_posts'), rt.new_array()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_sticky_posts.dup().is_array()))))) {
			var_sticky_posts = rt.new_array()
		}
		if rt.is_true(var_request.array_get('sticky')) {
			var_args.array_set('post__in', if rt.is_true(var_args.array_get('post__in')) { rt.call_function('array_intersect', [var_sticky_posts.dup(), var_args.array_get('post__in')]) } else { var_sticky_posts })
			if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get('post__in'))))) {
				var_args.array_set('post__in', rt.create_array([rt.ArrayItem{ key: none, val: 0 }]))
			}
		} else if rt.is_true(var_sticky_posts) {
			var_args.array_set('post__not_in', rt.call_function('array_merge', [var_args.array_get('post__not_in'), var_sticky_posts.dup()]))
		}
	}
	if !(!rt.is_true(var_args.array_get('post__in'))) {
		var_args.array_unset(rt.new_string('ignore_sticky_posts'))
	}
	if rt.is_true(rt.new_bool(var_registered.array_isset(rt.new_string('search_semantics')) && var_request.array_isset(rt.new_string('search_semantics')) && rt.is_true(rt.identical(rt.new_string('exact'), var_request.array_get('search_semantics'))))) {
		var_args.array_set('exact', true)
	}
	var_args = this.prepare_tax_query(mut rt.cast_object_ptr[Class_array](var_args), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	if var_registered.array_isset(rt.new_string('format')) && var_request.array_isset(rt.new_string('format')) {
		mut var_formats := var_request.array_get('format')
		mut var_formats_query := rt.create_array([rt.ArrayItem{ key: 'relation', val: 'OR' }])
		if rt.is_true(rt.call_function('in_array', [rt.new_string('standard'), var_formats.dup(), rt.new_bool(true)])) {
			var_formats_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'post_format' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'operator', val: 'NOT EXISTS' }]))
			var_formats.array_unset(rt.call_function('array_search', [rt.new_string('standard'), var_formats.dup(), rt.new_bool(true)]))
		}
		if !(!rt.is_true(var_formats)) {
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_format := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string("post-format-${var_format.to_string()}")
	}
	mut var_format := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string("post-format-${var_format.to_string()}")
	}
			mut var_terms := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_formats.dup()])
			var_formats_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'post_format' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'terms', val: var_terms }, rt.ArrayItem{ key: 'operator', val: 'IN' }]))
		}
		if var_args.array_isset(rt.new_string('tax_query')) {
			var_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }, rt.ArrayItem{ key: none, val: var_formats_query }]))
		} else {
			var_args.array_set('tax_query', var_formats_query.dup())
		}
	}
	var_args.array_set('post_type', this.post_type)
	mut var_is_head_request := rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])
	if rt.is_true(var_is_head_request) {
		var_args.array_set('fields', 'ids')
		var_args.array_set('update_post_term_cache', false)
		var_args.array_set('update_post_meta_cache', false)
	}
	var_args = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('rest_'), this.post_type), rt.new_string('_query')), var_args.dup(), var_request.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.dup().is_array()))))) {
		var_args = rt.new_array()
	}
	mut var_query_args := this.prepare_items_query(var_args.dup(), var_request.dup())
	mut var_posts_query := create_wp_query()
	mut var_query_result := var_posts_query.query(var_query_args.dup())
	if rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get('context'))) {
		rt.call_function('add_filter', [rt.new_string('post_password_required'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_password_required' }]), rt.new_int(10), rt.new_int(2)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_head_request)))) {
		mut var_posts := rt.new_array()
		rt.call_function('update_post_author_caches', [var_query_result.dup()])
		rt.call_function('update_post_parent_caches', [var_query_result.dup()])
		if rt.is_true(rt.call_function('post_type_supports', [this.post_type, rt.new_string('thumbnail')])) {
			rt.call_function('update_post_thumbnail_cache', [var_posts_query])
		}
		{
			mut iter_1 := var_query_result.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_post := item_1.val
				if rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get('context'))) {
					mut var_permission := rt.new_bool(this.check_update_permission(var_post.dup()))
				} else {
					var_permission = rt.new_bool(this.check_read_permission(var_post.dup()))
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(var_permission)))) {
					continue
				}
				mut var_data := this.prepare_item_for_response(var_post.dup(), var_request.dup())
				var_posts << this.prepare_response_for_collection(var_data.dup())
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get('context'))) {
		rt.call_function('remove_filter', [rt.new_string('post_password_required'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_password_required' }])])
	}
	mut var_page := // unsupported expression: Expr_Cast_Int
	mut var_total_posts := rt.get_property(var_posts_query, 'found_posts')
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_total_posts, rt.new_int(1))) && rt.is_true(rt.greater(var_page, rt.new_int(1))))) {
		var_query_args.array_unset(rt.new_string('paged'))
		mut var_count_query := create_wp_query()
		var_query_args.array_set('fields', 'ids')
		var_query_args.array_set('posts_per_page', 1)
		var_query_args.array_set('update_post_meta_cache', false)
		var_query_args.array_set('update_post_term_cache', false)
		var_count_query.query(var_query_args.dup())
		var_total_posts = rt.get_property(var_count_query, 'found_posts')
	}
	mut var_max_pages := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_page, var_max_pages)) && rt.is_true(rt.greater(var_total_posts, rt.new_int(0))))) {
		return create_wp_error(rt.new_string('rest_post_invalid_page_number'), rt.call_function('__', [rt.new_string('The page number requested is larger than the number of pages available.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_response := if rt.is_true(var_is_head_request) { create_wp_rest_response(rt.new_array()) } else { rt.call_function('rest_ensure_response', [var_posts.dup()]) }
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), // unsupported expression: Expr_Cast_Int])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), // unsupported expression: Expr_Cast_Int])
	mut var_request_params := rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})
	mut var_collection_url := rt.call_function('rest_url', [rt.call_function('rest_get_route_for_post_type_items', [this.post_type])])
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
		mut var_next_link := rt.call_function('add_query_arg', [, .dup(), .dup()])
		rt.call_method(, 'link_header', [, .dup()])
	}
	return var_response.dup()
}

fn (mut this Class_WP_REST_Posts_Controller) get_post(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	
}

fn (mut this Class_WP_REST_Posts_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
}

fn (mut this Class_WP_REST_Posts_Controller) can_access_password_content(var_post rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_REST_Posts_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Posts_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
}

fn (mut this Class_WP_REST_Posts_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Posts_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
}

fn (mut this Class_WP_REST_Posts_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Posts_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
}

fn (mut this Class_WP_REST_Posts_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Posts_Controller) prepare_items_query(var_prepared_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_args_mutated := var_prepared_args
}

fn (mut this Class_WP_REST_Posts_Controller) prepare_date_response(var_date_gmt rt.PhpVal, var_date rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Posts_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Posts_Controller) check_status(var_status rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) bool {
	mut var_status_mutated := var_status
}

fn (mut this Class_WP_REST_Posts_Controller) handle_status_param(var_post_status rt.PhpVal, var_post_type rt.PhpVal) rt.PhpVal {
	mut var_post_status_mutated := var_post_status
	mut var_post_type_mutated := var_post_type
}

fn (mut this Class_WP_REST_Posts_Controller) handle_featured_media(var_featured_media rt.PhpVal, var_post_id rt.PhpVal) bool {
	mut var_featured_media_mutated := var_featured_media
	mut var_post_id_mutated := var_post_id
	return false
}

fn (mut this Class_WP_REST_Posts_Controller) check_template(var_template rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_template_mutated := var_template
}

fn (mut this Class_WP_REST_Posts_Controller) handle_template(var_template rt.PhpVal, var_post_id rt.PhpVal, validate bool)  {
	mut var_template_mutated := var_template
	mut var_post_id_mutated := var_post_id
}

fn (mut this Class_WP_REST_Posts_Controller) handle_terms(var_post_id rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_id_mutated := var_post_id
}

fn (mut this Class_WP_REST_Posts_Controller) check_assign_terms_permission(var_request rt.PhpVal) bool {
}

fn (mut this Class_WP_REST_Posts_Controller) check_is_post_type_allowed(var_post_type rt.PhpVal) bool {
	mut var_post_type_mutated := var_post_type
}

fn (mut this Class_WP_REST_Posts_Controller) check_read_permission(var_post rt.PhpVal) bool {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_REST_Posts_Controller) check_update_permission(var_post rt.PhpVal) bool {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_REST_Posts_Controller) check_create_permission(var_post rt.PhpVal) bool {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_REST_Posts_Controller) check_delete_permission(var_post rt.PhpVal) bool {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_REST_Posts_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
}

fn (mut this Class_WP_REST_Posts_Controller) protected_title_format() string {
}

fn (mut this Class_WP_REST_Posts_Controller) prepare_links(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_REST_Posts_Controller) get_available_actions(var_post rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_REST_Posts_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WP_REST_Posts_Controller) get_schema_links() rt.PhpVal {
}

fn (mut this Class_WP_REST_Posts_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WP_REST_Posts_Controller) sanitize_post_statuses(var_statuses rt.PhpVal, var_request rt.PhpVal, var_parameter rt.PhpVal) rt.PhpVal {
	mut var_statuses_mutated := var_statuses
}

fn (mut this Class_WP_REST_Posts_Controller) prepare_tax_query(mut var_args Class_array, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_REST_Posts_Controller) prepare_taxonomy_limit_schema(mut var_query_params Class_array) rt.PhpVal {
	mut var_query_params_mutated := var_query_params
}

struct Class_WP_REST_Controller {
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

fn create_wp_rest_posts_controller(arg_0 rt.PhpVal) &Class_WP_REST_Posts_Controller {
	mut obj := &Class_WP_REST_Posts_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		post_type: rt.new_null()
		meta: rt.new_null()
		password_check_passed: rt.new_array()
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

fn (mut this Class_WP_REST_Posts_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'check_password_required' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.check_password_required(dispatch_arg_0, dispatch_arg_1))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_post(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'can_access_password_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.can_access_password_content(dispatch_arg_0, dispatch_arg_1))
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
		'prepare_items_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_items_query(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_date_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_date_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
		}
		'check_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.check_status(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'handle_status_param' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.handle_status_param(dispatch_arg_0, dispatch_arg_1)
		}
		'handle_featured_media' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.handle_featured_media(dispatch_arg_0, dispatch_arg_1))
		}
		'check_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.check_template(dispatch_arg_0, dispatch_arg_1))
		}
		'handle_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.handle_template(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'handle_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.handle_terms(dispatch_arg_0, dispatch_arg_1)
		}
		'check_assign_terms_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_assign_terms_permission(dispatch_arg_0))
		}
		'check_is_post_type_allowed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_is_post_type_allowed(dispatch_arg_0))
		}
		'check_read_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_read_permission(dispatch_arg_0))
		}
		'check_update_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_update_permission(dispatch_arg_0))
		}
		'check_create_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_create_permission(dispatch_arg_0))
		}
		'check_delete_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_delete_permission(dispatch_arg_0))
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'protected_title_format' {
			return rt.new_string(this.protected_title_format())
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_available_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_available_actions(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_schema_links' {
			return this.get_schema_links()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'sanitize_post_statuses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.sanitize_post_statuses(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prepare_tax_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.prepare_tax_query(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'prepare_taxonomy_limit_schema' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.prepare_taxonomy_limit_schema(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Posts_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'post_type' { return this.post_type }
		'meta' { return this.meta }
		'password_check_passed' { return this.password_check_passed }
		'allow_batch' { return this.allow_batch }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Posts_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'post_type' { this.post_type = val; return true }
		'meta' { this.meta = val; return true }
		'password_check_passed' { this.password_check_passed = val; return true }
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_posts_controller_php() {
}
