import rt

struct Class_WP_REST_Posts_Controller {
	rt.PhpObjectBase
pub mut:
		post_type rt.PhpVal = rt.new_null()
		meta rt.PhpVal = rt.new_null()
		password_check_passed rt.PhpVal = rt.new_array()
		allow_batch rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_REST_Posts_Controller) construct(var_post_type rt.PhpVal) {
	mut var_post_type_mutated := var_post_type
	this.post_type = var_post_type_mutated.clone()
	mut var_obj := rt.call_function('get_post_type_object', [var_post_type_mutated.clone()])
	this.dispatch_set_prop('rest_base', if !(!rt.is_true(rt.get_property(var_obj, 'rest_base'))) { rt.get_property(var_obj, 'rest_base') } else { rt.get_property(var_obj, 'name') })
	this.dispatch_set_prop('namespace', if !(!rt.is_true(rt.get_property(var_obj, 'rest_namespace'))) { rt.get_property(var_obj, 'rest_namespace') } else { rt.new_string('wp/v2') })
	this.meta = create_wp_rest_post_meta_fields(this.post_type)
}

fn (mut this Class_WP_REST_Posts_Controller) register_routes() {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.new_string('/' + (rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'rest_base')).str()), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	mut var_schema := this.get_item_schema()
	mut var_get_item_args := { 'context': this.get_context_param({ 'default': rt.new_string('view') }) }
	if var_schema.array_get(rt.new_string('properties')).array_isset(rt.new_string('excerpt')) {
		var_get_item_args['excerpt_length'] = rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Override the default excerpt length.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }])
	}
	if var_schema.array_get(rt.new_string('properties')).array_isset(rt.new_string('password')) {
		var_get_item_args['password'] = rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The password for the post if it is password protected.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }])
	}
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.new_string('/' + (rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'rest_base')).str() + '/(?P<id>[\\d]+)'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the post.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: var_get_item_args }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to bypass Trash and force deletion.')]) }]) }]) }]) }, rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Posts_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_post_type := rt.call_function('get_post_type_object', [this.post_type])
	if rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get(rt.new_string('context')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts')]))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit posts in this post type.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Posts_Controller) check_password_required(var_required rt.PhpVal, var_post rt.PhpVal) bool {
	mut var_post_mutated := var_post
	if rt.is_true(rt.new_bool(!(rt.is_true(var_required)))) {
		return (var_required).to_bool()
	}
	var_post_mutated = rt.call_function('get_post', [var_post_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_mutated)))) {
		return (var_required).to_bool()
	}
	if !(!rt.is_true(this.password_check_passed.array_get(rt.get_property(var_post_mutated, 'ID')))) {
		return false
	}
	return !(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post_mutated, 'ID')])))
}

fn (mut this Class_WP_REST_Posts_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get(rt.new_string('orderby')))) && rt.is_true(rt.identical(rt.new_string('relevance'), var_request.array_get(rt.new_string('orderby')))) && !rt.is_true(var_request.array_get(rt.new_string('search'))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_no_search_term_defined'), rt.call_function('__', [rt.new_string('You need to define a search term to order by relevance.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('orderby')))) && rt.is_true(rt.identical(rt.new_string('include'), var_request.array_get(rt.new_string('orderby')))) && !rt.is_true(var_request.array_get(rt.new_string('include'))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_orderby_include_missing_include'), rt.call_function('__', [rt.new_string('You need to define an include parameter to order by include.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_registered := this.get_collection_params()
	mut var_args := rt.new_array()
	mut var_parameter_mappings := { 'author': 'author__in', 'author_exclude': 'author__not_in', 'exclude': 'post__not_in', 'include': 'post__in', 'ignore_sticky': 'ignore_sticky_posts', 'menu_order': 'menu_order', 'offset': 'offset', 'order': 'order', 'orderby': 'orderby', 'page': 'paged', 'parent': 'post_parent__in', 'parent_exclude': 'post_parent__not_in', 'search': 's', 'search_columns': 'search_columns', 'slug': 'post_name__in', 'status': 'post_status' }
	for var_api_param, var_wp_param in var_parameter_mappings {
		if var_registered.array_isset(rt.new_string(api_param)) && var_request.array_isset(rt.new_string(api_param)) {
			var_args.array_set(wp_param, var_request.array_get(rt.new_string(api_param)))
		}
	}
	var_args.array_set('date_query', rt.new_array())
	if var_registered.array_isset(rt.new_string('before')) && var_request.array_isset(rt.new_string('before')) {
		var_args.array_get_mut('date_query').array_push(rt.create_array([rt.ArrayItem{ key: 'before', val: var_request.array_get(rt.new_string('before')) }, rt.ArrayItem{ key: 'column', val: 'post_date' }]))
	}
	if var_registered.array_isset(rt.new_string('modified_before')) && var_request.array_isset(rt.new_string('modified_before')) {
		var_args.array_get_mut('date_query').array_push(rt.create_array([rt.ArrayItem{ key: 'before', val: var_request.array_get(rt.new_string('modified_before')) }, rt.ArrayItem{ key: 'column', val: 'post_modified' }]))
	}
	if var_registered.array_isset(rt.new_string('after')) && var_request.array_isset(rt.new_string('after')) {
		var_args.array_get_mut('date_query').array_push(rt.create_array([rt.ArrayItem{ key: 'after', val: var_request.array_get(rt.new_string('after')) }, rt.ArrayItem{ key: 'column', val: 'post_date' }]))
	}
	if var_registered.array_isset(rt.new_string('modified_after')) && var_request.array_isset(rt.new_string('modified_after')) {
		var_args.array_get_mut('date_query').array_push(rt.create_array([rt.ArrayItem{ key: 'after', val: var_request.array_get(rt.new_string('modified_after')) }, rt.ArrayItem{ key: 'column', val: 'post_modified' }]))
	}
	if var_registered.array_isset(rt.new_string('per_page')) {
		var_args.array_set('posts_per_page', var_request.array_get(rt.new_string('per_page')))
	}
	if var_registered.array_isset(rt.new_string('sticky')) && var_request.array_isset(rt.new_string('sticky')) {
		mut var_sticky_posts := rt.call_function('get_option', [rt.new_string('sticky_posts'), rt.new_array()])
		if !(var_sticky_posts.clone().is_array()) {
		var_sticky_posts = rt.new_array()
		}
		if rt.is_true(var_request.array_get(rt.new_string('sticky'))) {
			var_args.array_set('post__in', if rt.is_true(var_args.array_get(rt.new_string('post__in'))) { rt.call_function('array_intersect', [var_sticky_posts.clone(), var_args.array_get(rt.new_string('post__in'))]) } else { var_sticky_posts })
			if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get(rt.new_string('post__in')))))) {
				var_args.array_set('post__in', rt.create_array([rt.ArrayItem{ key: none, val: 0 }]))
			}
		} else if rt.is_true(var_sticky_posts) {
			var_args.array_set('post__not_in', rt.call_function('array_merge', [var_args.array_get(rt.new_string('post__not_in')), var_sticky_posts.clone()]))
		}
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('post__in')))) {
		var_args.array_unset(rt.new_string('ignore_sticky_posts'))
	}
	if var_registered.array_isset(rt.new_string('search_semantics')) && var_request.array_isset(rt.new_string('search_semantics')) && rt.is_true(rt.identical(rt.new_string('exact'), var_request.array_get(rt.new_string('search_semantics')))) {
		var_args.array_set('exact', true)
	}
	var_args = this.prepare_tax_query(mut rt.cast_object_ptr[Class_array](var_args), mut rt.cast_object_ptr[Class_WP_REST_Request](var_request))
	if var_registered.array_isset(rt.new_string('format')) && var_request.array_isset(rt.new_string('format')) {
		mut var_formats := var_request.array_get(rt.new_string('format'))
		mut var_formats_query := rt.create_array([rt.ArrayItem{ key: 'relation', val: 'OR' }])
		if rt.is_true(rt.call_function('in_array', [rt.new_string('standard'), var_formats.clone(), rt.new_bool(true)])) {
			var_formats_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'post_format' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'operator', val: 'NOT EXISTS' }]))
			var_formats.array_unset(rt.call_function('array_search', [rt.new_string('standard'), var_formats.clone(), rt.new_bool(true)]))
		}
		if !(!rt.is_true(var_formats)) {
			closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_format := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_string("post-format-${var_format.to_string()}")
				}
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_format := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_string("post-format-${var_format.to_string()}")
				}
			mut var_terms := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_formats.clone()])
			var_formats_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'post_format' }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'terms', val: var_terms }, rt.ArrayItem{ key: 'operator', val: 'IN' }]))
		}
		if var_args.array_isset(rt.new_string('tax_query')) {
			var_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'relation', val: 'AND' }, rt.ArrayItem{ key: none, val: var_formats_query }]))
		} else {
			var_args.array_set('tax_query', var_formats_query.clone())
		}
	}
	var_args.array_set('post_type', this.post_type)
	mut var_is_head_request := rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])
	if rt.is_true(var_is_head_request) {
		var_args.array_set('fields', 'ids')
		var_args.array_set('update_post_term_cache', false)
		var_args.array_set('update_post_meta_cache', false)
	}
	var_args = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('rest_'), this.post_type), rt.new_string('_query')), var_args.clone(), var_request.clone()])
	if !(var_args.clone().is_array()) {
	var_args = rt.new_array()
	}
	mut var_query_args := this.prepare_items_query(var_args.clone(), var_request.clone())
	mut var_posts_query := create_wp_query()
	mut var_query_result := var_posts_query.query(var_query_args.clone())
	if rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get(rt.new_string('context')))) {
		rt.call_function('add_filter', [rt.new_string('post_password_required'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_password_required' }]), rt.new_int(10), rt.new_int(2)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_head_request)))) {
		mut var_posts := rt.new_array()
		rt.call_function('update_post_author_caches', [var_query_result.clone()])
		rt.call_function('update_post_parent_caches', [var_query_result.clone()])
		if rt.is_true(rt.call_function('post_type_supports', [this.post_type, rt.new_string('thumbnail')])) {
			rt.call_function('update_post_thumbnail_cache', [var_posts_query])
		}
		mut iter_1 := var_query_result.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post := item_1.val
			if rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get(rt.new_string('context')))) {
			mut var_permission := rt.new_bool(this.check_update_permission(var_post.clone()))
			} else {
			var_permission = rt.new_bool(this.check_read_permission(var_post.clone()))
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_permission)))) {
				continue
			}
			mut var_data := this.prepare_item_for_response(var_post.clone(), var_request.clone())
			var_posts << this.prepare_response_for_collection(var_data.clone())
		}
	}
	if rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get(rt.new_string('context')))) {
		rt.call_function('remove_filter', [rt.new_string('post_password_required'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_password_required' }])])
	}
	mut var_page := rt.new_int((if !(var_query_args.array_get(rt.new_string('paged'))).is_null() { var_query_args.array_get(rt.new_string('paged')) } else { rt.new_int(0) }).to_i64())
	mut var_total_posts := rt.get_property(var_posts_query, 'found_posts')
	if rt.is_true(rt.less(var_total_posts, rt.new_int(1))) && rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		var_query_args.array_unset(rt.new_string('paged'))
		mut var_count_query := create_wp_query()
		var_query_args.array_set('fields', 'ids')
		var_query_args.array_set('posts_per_page', 1)
		var_query_args.array_set('update_post_meta_cache', false)
		var_query_args.array_set('update_post_term_cache', false)
		var_count_query.query(var_query_args.clone())
	var_total_posts = rt.get_property(var_count_query, 'found_posts')
	}
	mut var_max_pages := rt.new_int((rt.call_function('ceil', [rt.div(var_total_posts, rt.new_int((rt.get_property(var_posts_query, 'query_vars').array_get(rt.new_string('posts_per_page'))).to_i64()))])).to_i64())
	if rt.is_true(rt.greater(var_page, var_max_pages)) && rt.is_true(rt.greater(var_total_posts, rt.new_int(0))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_post_invalid_page_number'), rt.call_function('__', [rt.new_string('The page number requested is larger than the number of pages available.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_response := if rt.is_true(var_is_head_request) { create_wp_rest_response(rt.new_array()) } else { rt.call_function('rest_ensure_response', [rt.create_array_from_list(var_posts)]) }
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), rt.new_int((var_total_posts).to_i64())])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), rt.new_int((var_max_pages).to_i64())])
	mut var_request_params := rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})
	mut var_collection_url := rt.call_function('rest_url', [rt.call_function('rest_get_route_for_post_type_items', [this.post_type])])
	mut var_base := rt.call_function('add_query_arg', [rt.call_function('urlencode_deep', [var_request_params.clone()]), var_collection_url.clone()])
	if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_page, rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
		var_prev_page = var_max_pages.clone()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_prev_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'), var_prev_link.clone()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_page)) {
		mut var_next_page := rt.add(var_page, rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_next_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'), var_next_link.clone()])
	}
	return var_response.clone()
}

fn (mut this Class_WP_REST_Posts_Controller) get_post(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	mut var_error := create_wp_error(rt.new_string('rest_post_invalid_id'), rt.call_function('__', [rt.new_string('Invalid post ID.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	if rt.new_int((var_id_mutated).to_i64()) <= 0 {
		return mut var_error
	}
	mut var_post := rt.call_function('get_post', [rt.new_int((var_id_mutated).to_i64())])
	if !rt.is_true(var_post) || !rt.is_true(rt.get_property(var_post, 'ID')) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.post_type, rt.get_property(var_post, 'post_type'))))) {
		return mut var_error
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_post)
}

fn (mut this Class_WP_REST_Posts_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := this.get_post(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return (var_post).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get(rt.new_string('context')))) && rt.is_true(var_post) && !(this.check_update_permission(var_post.clone())) {
		return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this post.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(var_post) && !(!rt.is_true(rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}).array_get(rt.new_string('password')))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [rt.get_property(var_post, 'post_password'), rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}).array_get(rt.new_string('password'))]))))) {
			return (create_wp_error(rt.new_string('rest_post_incorrect_password'), rt.call_function('__', [rt.new_string('Incorrect post password.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))).to_bool()
		}
	}
	if rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get(rt.new_string('context')))) {
		rt.call_function('add_filter', [rt.new_string('post_password_required'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_password_required' }]), rt.new_int(10), rt.new_int(2)])
	}
	if rt.is_true(var_post) {
		return this.check_read_permission(var_post.clone())
	}
	return true
}

fn (mut this Class_WP_REST_Posts_Controller) can_access_password_content(var_post rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_post_mutated := var_post
	if !rt.is_true(rt.get_property(var_post_mutated, 'post_password')) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get(rt.new_string('context')))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post_mutated, 'ID')])) {
		return true
	}
	if !rt.is_true(var_request.array_get(rt.new_string('password'))) {
		return false
	}
	return (rt.call_function('hash_equals', [rt.get_property(var_post_mutated, 'post_password'), var_request.array_get(rt.new_string('password'))])).to_bool()
}

fn (mut this Class_WP_REST_Posts_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_post := this.get_post(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return var_post.clone()
	}
	mut var_data := this.prepare_item_for_response(var_post.clone(), var_request.clone())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.clone()])
	if rt.is_true(rt.call_function('is_post_type_viewable', [rt.call_function('get_post_type_object', [rt.get_property(var_post, 'post_type')])])) {
		rt.call_method(var_response, 'link_header', [rt.new_string('alternate'), rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')]), rt.create_array([rt.ArrayItem{ key: 'type', val: 'text/html' }])])
	}
	return var_response.clone()
}

fn (mut this Class_WP_REST_Posts_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	if !(!rt.is_true(var_request.array_get(rt.new_string('id')))) {
		return (create_wp_error(rt.new_string('rest_post_exists'), rt.call_function('__', [rt.new_string('Cannot create existing post.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	mut var_post_type := rt.call_function('get_post_type_object', [this.post_type])
	if !(!rt.is_true(var_request.array_get(rt.new_string('author')))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), var_request.array_get(rt.new_string('author')))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_others_posts')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_edit_others'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create posts as this user.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('sticky')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_others_posts')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'publish_posts')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_assign_sticky'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to make posts sticky.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'create_posts')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create posts as this user.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if !(this.check_assign_terms_permission(var_request.clone())) {
		return (create_wp_error(rt.new_string('rest_cannot_assign_term'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to assign the provided terms.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Posts_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get(rt.new_string('id')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_post_exists'), rt.call_function('__', [rt.new_string('Cannot create existing post.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_prepared_post := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_prepared_post.clone()])) {
		return var_prepared_post.clone()
	}
	rt.set_property(var_prepared_post, 'post_type', this.post_type)
	if !(!rt.is_true(rt.get_property(var_prepared_post, 'post_name'))) && !(!rt.is_true(rt.get_property(var_prepared_post, 'post_status'))) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_prepared_post, 'post_status'), rt.create_array([rt.ArrayItem{ key: none, val: 'draft' }, rt.ArrayItem{ key: none, val: 'pending' }]), rt.new_bool(true)])) {
		rt.set_property(var_prepared_post, 'post_name', rt.call_function('wp_unique_post_slug', [rt.get_property(var_prepared_post, 'post_name'), rt.get_property(var_prepared_post, 'id'), rt.new_string('publish'), rt.get_property(var_prepared_post, 'post_type'), rt.get_property(var_prepared_post, 'post_parent')]))
	}
	mut var_post_id := rt.call_function('wp_insert_post', [rt.call_function('wp_slash', [rt.cast_array(var_prepared_post)]), rt.new_bool(true), rt.new_bool(false)])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()])) {
		if rt.is_true(rt.identical(rt.new_string('db_insert_error'), rt.call_method(var_post_id, 'get_error_code', []rt.PhpVal{}))) {
			rt.call_method(var_post_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])])
		} else {
			rt.call_method(var_post_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])])
		}
		return var_post_id.clone()
	}
	mut var_post := rt.call_function('get_post', [var_post_id.clone()])
	rt.call_function('do_action', [rt.concat(rt.new_string('rest_insert_'), this.post_type), var_post.clone(), var_request.clone(), rt.new_bool(true)])
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('sticky')))) {
		if !(!rt.is_true(var_request.array_get(rt.new_string('sticky')))) {
			rt.call_function('stick_post', [var_post_id.clone()])
		} else {
			rt.call_function('unstick_post', [var_post_id.clone()])
		}
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('featured_media')))) && var_request.array_isset(rt.new_string('featured_media')) {
		this.handle_featured_media(var_request.array_get(rt.new_string('featured_media')), var_post_id.clone())
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('format')))) && !(!rt.is_true(var_request.array_get(rt.new_string('format')))) {
		rt.call_function('set_post_format', [var_post.clone(), var_request.array_get(rt.new_string('format'))])
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('template')))) && var_request.array_isset(rt.new_string('template')) {
		this.handle_template(var_request.array_get(rt.new_string('template')), var_post_id.clone(), true)
	}
	mut var_terms_update := this.handle_terms(var_post_id.clone(), var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_terms_update.clone()])) {
		return var_terms_update.clone()
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('meta')))) && var_request.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(this.meta, 'update_value', [var_request.array_get(rt.new_string('meta')), var_post_id.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.clone()])) {
			return var_meta_update.clone()
		}
	}
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	mut var_fields_update := this.update_additional_fields_for_object(var_post.clone(), var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	rt.call_function('do_action', [rt.concat(rt.new_string('rest_after_insert_'), this.post_type), var_post.clone(), var_request.clone(), rt.new_bool(true)])
	rt.call_function('wp_after_insert_post', [var_post.clone(), rt.new_bool(false), rt.new_null()])
	mut var_response := this.prepare_item_for_response(var_post.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('rest_get_route_for_post', [var_post.clone()])])])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Posts_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := this.get_post(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return (var_post).to_bool()
	}
	mut var_post_type := rt.call_function('get_post_type_object', [this.post_type])
	if rt.is_true(var_post) && !(this.check_update_permission(var_post.clone())) {
		return (create_wp_error(rt.new_string('rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this post.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('author')))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), var_request.array_get(rt.new_string('author')))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_others_posts')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_edit_others'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to update posts as this user.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('sticky')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_others_posts')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'publish_posts')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_assign_sticky'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to make posts sticky.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if !(this.check_assign_terms_permission(var_request.clone())) {
		return (create_wp_error(rt.new_string('rest_cannot_assign_term'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to assign the provided terms.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Posts_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_valid_check := this.get_post(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_valid_check.clone()])) {
		return var_valid_check.clone()
	}
	mut var_post_before := rt.call_function('get_post', [var_request.array_get(rt.new_string('id'))])
	mut var_post := this.prepare_item_for_database(var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return var_post.clone()
	}
	if !(!rt.is_true(rt.get_property(var_post, 'post_status'))) {
	mut var_post_status := rt.get_property(var_post, 'post_status')
	} else {
	var_post_status = rt.get_property(var_post_before, 'post_status')
	}
	if !(!rt.is_true(rt.get_property(var_post, 'post_name'))) && rt.is_true(rt.call_function('in_array', [var_post_status.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'draft' }, rt.ArrayItem{ key: none, val: 'pending' }]), rt.new_bool(true)])) {
		mut var_post_parent := if !(!rt.is_true(rt.get_property(var_post, 'post_parent'))) { rt.get_property(var_post, 'post_parent') } else { rt.new_int(0) }
		rt.set_property(var_post, 'post_name', rt.call_function('wp_unique_post_slug', [rt.get_property(var_post, 'post_name'), rt.get_property(var_post, 'ID'), rt.new_string('publish'), rt.get_property(var_post, 'post_type'), var_post_parent.clone()]))
	}
	mut var_post_id := rt.call_function('wp_update_post', [rt.call_function('wp_slash', [rt.cast_array(var_post)]), rt.new_bool(true), rt.new_bool(false)])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()])) {
		if rt.is_true(rt.identical(rt.new_string('db_update_error'), rt.call_method(var_post_id, 'get_error_code', []rt.PhpVal{}))) {
			rt.call_method(var_post_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])])
		} else {
			rt.call_method(var_post_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])])
		}
		return var_post_id.clone()
	}
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	rt.call_function('do_action', [rt.concat(rt.new_string('rest_insert_'), this.post_type), var_post.clone(), var_request.clone(), rt.new_bool(false)])
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('format')))) && !(!rt.is_true(var_request.array_get(rt.new_string('format')))) {
		rt.call_function('set_post_format', [var_post.clone(), var_request.array_get(rt.new_string('format'))])
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('featured_media')))) && var_request.array_isset(rt.new_string('featured_media')) {
		this.handle_featured_media(var_request.array_get(rt.new_string('featured_media')), var_post_id.clone())
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('sticky')))) && var_request.array_isset(rt.new_string('sticky')) {
		if !(!rt.is_true(var_request.array_get(rt.new_string('sticky')))) {
			rt.call_function('stick_post', [var_post_id.clone()])
		} else {
			rt.call_function('unstick_post', [var_post_id.clone()])
		}
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('template')))) && var_request.array_isset(rt.new_string('template')) {
		this.handle_template(var_request.array_get(rt.new_string('template')), rt.get_property(var_post, 'ID'), false)
	}
	mut var_terms_update := this.handle_terms(rt.get_property(var_post, 'ID'), var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_terms_update.clone()])) {
		return var_terms_update.clone()
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('meta')))) && var_request.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(this.meta, 'update_value', [var_request.array_get(rt.new_string('meta')), rt.get_property(var_post, 'ID')])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.clone()])) {
			return var_meta_update.clone()
		}
	}
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	mut var_fields_update := this.update_additional_fields_for_object(var_post.clone(), var_request.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	if rt.is_true(rt.identical(rt.new_string('attachment'), this.post_type)) {
		mut var_response := this.prepare_item_for_response(var_post.clone(), var_request.clone())
		return rt.call_function('rest_ensure_response', [var_response.clone()])
	}
	rt.call_function('do_action', [rt.concat(rt.new_string('rest_after_insert_'), this.post_type), var_post.clone(), var_request.clone(), rt.new_bool(false)])
	rt.call_function('wp_after_insert_post', [var_post.clone(), rt.new_bool(true), var_post_before.clone()])
	var_response = this.prepare_item_for_response(var_post.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WP_REST_Posts_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := this.get_post(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return (var_post).to_bool()
	}
	if rt.is_true(var_post) && !(this.check_delete_permission(var_post.clone())) {
		return (create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this post.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Posts_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_post := this.get_post(var_request.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.clone()])) {
		return var_post.clone()
	}
	mut var_id := rt.get_property(var_post, 'ID')
	mut var_force := rt.new_bool((var_request.array_get(rt.new_string('force'))).to_bool())
	mut var_supports_trash := rt.greater(rt.get_constant('EMPTY_TRASH_DAYS'), rt.new_int(0))
	if rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_post, 'post_type'))) {
	var_supports_trash = rt.new_bool(rt.is_true(var_supports_trash) && rt.is_true(rt.get_constant('MEDIA_TRASH')))
	}
	var_supports_trash = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('rest_'), this.post_type), rt.new_string('_trashable')), var_supports_trash.clone(), var_post.clone()])
	if !(this.check_delete_permission(var_post.clone())) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_user_cannot_delete_post'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this post.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	if rt.is_true(var_force) {
		mut var_previous := this.prepare_item_for_response(var_post.clone(), var_request.clone())
		mut var_result := rt.call_function('wp_delete_post', [var_id.clone(), rt.new_bool(true)])
		mut var_response := create_wp_rest_response()
		rt.call_method(var_response, 'set_data', [rt.create_array([rt.ArrayItem{ key: 'deleted', val: true }, rt.ArrayItem{ key: 'previous', val: rt.call_method(var_previous, 'get_data', []rt.PhpVal{}) }])])
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_supports_trash)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_trash_not_supported'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The post does not support trashing. Set \'%s\' to delete.')]), rt.new_string('force=true')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
		}
		if rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post, 'post_status'))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_already_trashed'), rt.call_function('__', [rt.new_string('The post has already been deleted.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 410 }])))
		}
	var_result = rt.call_function('wp_trash_post', [var_id.clone()])
	var_post = rt.call_function('get_post', [var_id.clone()])
	var_response = this.prepare_item_for_response(var_post.clone(), var_request.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [rt.new_string('The post cannot be deleted.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	rt.call_function('do_action', [rt.concat(rt.new_string('rest_delete_'), this.post_type), var_post.clone(), var_response.clone(), var_request.clone()])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Posts_Controller) prepare_items_query(var_prepared_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
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
		var_query_args.array_set(var_key, rt.call_function('apply_filters', [rt.new_string("rest_query_var-${var_key.to_string()}"), var_value.clone()]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post'), this.post_type)))) || !(var_query_args.array_isset(rt.new_string('ignore_sticky_posts'))) {
		var_query_args.array_set('ignore_sticky_posts', true)
	}
	if var_query_args.array_isset(rt.new_string('orderby')) && var_request.array_isset(rt.new_string('orderby')) {
		mut var_orderby_mappings := rt.create_array([rt.ArrayItem{ key: 'id', val: 'ID' }, rt.ArrayItem{ key: 'include', val: 'post__in' }, rt.ArrayItem{ key: 'slug', val: 'post_name' }, rt.ArrayItem{ key: 'include_slugs', val: 'post_name__in' }])
		if var_orderby_mappings.array_isset(var_request.array_get(rt.new_string('orderby'))) {
			var_query_args.array_set('orderby', var_orderby_mappings.array_get(var_request.array_get(rt.new_string('orderby'))))
		}
	}
	return var_query_args.clone()
}

fn (mut this Class_WP_REST_Posts_Controller) prepare_date_response(var_date_gmt rt.PhpVal, var_date rt.PhpVal) rt.PhpVal {
	if !(var_date).is_null() {
		return rt.call_function('mysql_to_rfc3339', [var_date.clone()])
	}
	if rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), var_date_gmt)) {
		return rt.new_null()
	}
	return rt.call_function('mysql_to_rfc3339', [var_date_gmt.clone()])
}

fn (mut this Class_WP_REST_Posts_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_post := create_stdclass()
	mut var_current_status := rt.new_string('')
	if var_request.array_isset(rt.new_string('id')) {
		mut var_existing_post := this.get_post(var_request.array_get(rt.new_string('id')))
		if rt.is_true(rt.call_function('is_wp_error', [var_existing_post.clone()])) {
			return var_existing_post.clone()
		}
		rt.set_property(var_prepared_post, 'ID', rt.get_property(var_existing_post, 'ID'))
	var_current_status = rt.get_property(var_existing_post, 'post_status')
	}
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('title')))) && var_request.array_isset(rt.new_string('title')) {
		if rt.is_true(rt.new_bool(var_request.array_get(rt.new_string('title')).is_string())) {
			rt.set_property(var_prepared_post, 'post_title', var_request.array_get(rt.new_string('title')))
		} else if !(!rt.is_true(var_request.array_get(rt.new_string('title')).array_get(rt.new_string('raw')))) {
			rt.set_property(var_prepared_post, 'post_title', var_request.array_get(rt.new_string('title')).array_get(rt.new_string('raw')))
		}
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('content')))) && var_request.array_isset(rt.new_string('content')) {
		if rt.is_true(rt.new_bool(var_request.array_get(rt.new_string('content')).is_string())) {
			rt.set_property(var_prepared_post, 'post_content', var_request.array_get(rt.new_string('content')))
		} else if var_request.array_get(rt.new_string('content')).array_isset(rt.new_string('raw')) {
			rt.set_property(var_prepared_post, 'post_content', var_request.array_get(rt.new_string('content')).array_get(rt.new_string('raw')))
		}
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('excerpt')))) && var_request.array_isset(rt.new_string('excerpt')) {
		if rt.is_true(rt.new_bool(var_request.array_get(rt.new_string('excerpt')).is_string())) {
			rt.set_property(var_prepared_post, 'post_excerpt', var_request.array_get(rt.new_string('excerpt')))
		} else if var_request.array_get(rt.new_string('excerpt')).array_isset(rt.new_string('raw')) {
			rt.set_property(var_prepared_post, 'post_excerpt', var_request.array_get(rt.new_string('excerpt')).array_get(rt.new_string('raw')))
		}
	}
	if !rt.is_true(var_request.array_get(rt.new_string('id'))) {
		rt.set_property(var_prepared_post, 'post_type', this.post_type)
	} else {
		rt.set_property(var_prepared_post, 'post_type', rt.call_function('get_post_type', [var_request.array_get(rt.new_string('id'))]))
	}
	mut var_post_type := rt.call_function('get_post_type_object', [rt.get_property(var_prepared_post, 'post_type')])
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('status')))) && var_request.array_isset(rt.new_string('status')) && rt.is_true(rt.new_bool(!(rt.is_true(var_current_status)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_status, var_request.array_get(rt.new_string('status')))))) {
		mut var_status := this.handle_status_param(var_request.array_get(rt.new_string('status')), var_post_type.clone())
		if rt.is_true(rt.call_function('is_wp_error', [var_status.clone()])) {
			return var_status.clone()
		}
		rt.set_property(var_prepared_post, 'post_status', var_status.clone())
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('date')))) && !(!rt.is_true(var_request.array_get(rt.new_string('date')))) {
		mut var_current_date := if !(rt.get_property(var_prepared_post, 'ID')).is_null() { rt.get_property(rt.call_function('get_post', [rt.get_property(var_prepared_post, 'ID')]), 'post_date') } else { rt.new_bool(false) }
		mut var_date_data := rt.call_function('rest_get_date_with_gmt', [var_request.array_get(rt.new_string('date'))])
		if !(!rt.is_true(var_date_data)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_date, var_date_data.array_get(rt.new_int(0)))))) {
			mut list_tmp_1 := var_date_data
			rt.set_property(var_prepared_post, 'edit_date', rt.new_bool(true))
		}
	} else if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('date_gmt')))) && !(!rt.is_true(var_request.array_get(rt.new_string('date_gmt')))) {
		var_current_date = if !(rt.get_property(var_prepared_post, 'ID')).is_null() { rt.get_property(rt.call_function('get_post', [rt.get_property(var_prepared_post, 'ID')]), 'post_date_gmt') } else { rt.new_bool(false) }
		var_date_data = rt.call_function('rest_get_date_with_gmt', [var_request.array_get(rt.new_string('date_gmt')), rt.new_bool(true)])
		if !(!rt.is_true(var_date_data)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_date, var_date_data.array_get(rt.new_int(1)))))) {
			mut list_tmp_2 := var_date_data
			rt.set_property(var_prepared_post, 'edit_date', rt.new_bool(true))
		}
	}
	if (!(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('date_gmt')))) && rt.is_true(rt.call_method(var_request, 'has_param', [rt.new_string('date_gmt')])) && rt.is_true(rt.identical(rt.new_null(), var_request.array_get(rt.new_string('date_gmt'))))) || (!(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('date')))) && rt.is_true(rt.call_method(var_request, 'has_param', [rt.new_string('date')])) && rt.is_true(rt.identical(rt.new_null(), var_request.array_get(rt.new_string('date'))))) {
		rt.set_property(var_prepared_post, 'post_date_gmt', rt.new_null())
		rt.set_property(var_prepared_post, 'post_date', rt.new_null())
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('slug')))) && var_request.array_isset(rt.new_string('slug')) {
		rt.set_property(var_prepared_post, 'post_name', var_request.array_get(rt.new_string('slug')))
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('author')))) && !(!rt.is_true(var_request.array_get(rt.new_string('author')))) {
		mut var_post_author := rt.new_int((var_request.array_get(rt.new_string('author'))).to_i64())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), var_post_author)))) {
			mut var_user_obj := rt.call_function('get_userdata', [var_post_author.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_user_obj)))) {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_author'), rt.call_function('__', [rt.new_string('Invalid author ID.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
			}
		}
		rt.set_property(var_prepared_post, 'post_author', var_post_author.clone())
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('password')))) && var_request.array_isset(rt.new_string('password')) {
		rt.set_property(var_prepared_post, 'post_password', var_request.array_get(rt.new_string('password')))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_request.array_get(rt.new_string('password')))))) {
			if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('sticky')))) && !(!rt.is_true(var_request.array_get(rt.new_string('sticky')))) {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_field'), rt.call_function('__', [rt.new_string('A post can not be sticky and have a password.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
			}
			if !(!rt.is_true(rt.get_property(var_prepared_post, 'ID'))) && rt.is_true(rt.call_function('is_sticky', [rt.get_property(var_prepared_post, 'ID')])) {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_field'), rt.call_function('__', [rt.new_string('A sticky post can not be password protected.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
			}
		}
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('sticky')))) && !(!rt.is_true(var_request.array_get(rt.new_string('sticky')))) {
		if !(!rt.is_true(rt.get_property(var_prepared_post, 'ID'))) && rt.is_true(rt.call_function('post_password_required', [rt.get_property(var_prepared_post, 'ID')])) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_field'), rt.call_function('__', [rt.new_string('A password protected post can not be set to sticky.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('parent')))) && var_request.array_isset(rt.new_string('parent')) {
		if 0 == rt.new_int((var_request.array_get(rt.new_string('parent'))).to_i64()) {
			rt.set_property(var_prepared_post, 'post_parent', rt.new_int(0))
		} else {
			mut var_parent := rt.call_function('get_post', [rt.new_int((var_request.array_get(rt.new_string('parent'))).to_i64())])
			if !rt.is_true(var_parent) {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_post_invalid_id'), rt.call_function('__', [rt.new_string('Invalid post parent ID.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
			}
			rt.set_property(var_prepared_post, 'post_parent', rt.new_int((rt.get_property(var_parent, 'ID')).to_i64()))
		}
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('menu_order')))) && var_request.array_isset(rt.new_string('menu_order')) {
		rt.set_property(var_prepared_post, 'menu_order', rt.new_int((var_request.array_get(rt.new_string('menu_order'))).to_i64()))
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('comment_status')))) && !(!rt.is_true(var_request.array_get(rt.new_string('comment_status')))) {
		rt.set_property(var_prepared_post, 'comment_status', var_request.array_get(rt.new_string('comment_status')))
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('ping_status')))) && !(!rt.is_true(var_request.array_get(rt.new_string('ping_status')))) {
		rt.set_property(var_prepared_post, 'ping_status', var_request.array_get(rt.new_string('ping_status')))
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('template')))) {
		rt.set_property(var_prepared_post, 'page_template', rt.new_null())
	}
	mut var_content_like_post_types := rt.create_array([rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'wp_block' }, rt.ArrayItem{ key: none, val: 'wp_navigation' }])
	var_content_like_post_types = rt.call_function('apply_filters', [rt.new_string('rest_block_hooks_post_types'), var_content_like_post_types.clone(), this.post_type, var_prepared_post.clone()])
	if rt.is_true(rt.call_function('in_array', [this.post_type, var_content_like_post_types.clone(), rt.new_bool(true)])) {
	var_prepared_post = rt.call_function('update_ignored_hooked_blocks_postmeta', [var_prepared_post.clone()])
	}
	return rt.call_function('apply_filters', [rt.concat(rt.new_string('rest_pre_insert_'), this.post_type), var_prepared_post.clone(), var_request.clone()])
}

fn (mut this Class_WP_REST_Posts_Controller) check_status(var_status rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) bool {
	mut var_status_mutated := var_status
	if rt.is_true(var_request.array_get(rt.new_string('id'))) {
		mut var_post := this.get_post(var_request.array_get(rt.new_string('id')))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_post.clone()]))))) && rt.is_true(rt.identical(rt.get_property(var_post, 'post_status'), var_status_mutated)) {
			return true
		}
	}
	mut var_args := rt.call_method(var_request, 'get_attributes', []rt.PhpVal{}).array_get(rt.new_string('args')).array_get(var_param)
	return (rt.call_function('rest_validate_value_from_schema', [var_status_mutated.clone(), var_args.clone(), var_param.clone()])).to_bool()
}

fn (mut this Class_WP_REST_Posts_Controller) handle_status_param(var_post_status rt.PhpVal, var_post_type rt.PhpVal) rt.PhpVal {
	mut var_post_status_mutated := var_post_status
	mut var_post_type_mutated := var_post_type
	mut switch_val_1 := var_post_status_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('draft'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('pending'))) {
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('private'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_mutated, 'cap'), 'publish_posts')]))))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_cannot_publish'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create private posts in this post type.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('publish'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('future'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_mutated, 'cap'), 'publish_posts')]))))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_cannot_publish'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to publish posts in this post type.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))
		}
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post_status_object', [var_post_status_mutated.clone()]))))) {
		var_post_status_mutated = rt.new_string('draft')
		}
	}
	return var_post_status_mutated.clone()
}

fn (mut this Class_WP_REST_Posts_Controller) handle_featured_media(var_featured_media rt.PhpVal, var_post_id rt.PhpVal) bool {
	mut var_featured_media_mutated := var_featured_media
	mut var_post_id_mutated := var_post_id
	var_featured_media_mutated = rt.new_int((var_featured_media_mutated).to_i64())
	if rt.is_true(var_featured_media_mutated) {
		mut var_result := rt.call_function('set_post_thumbnail', [var_post_id_mutated.clone(), var_featured_media_mutated.clone()])
		if rt.is_true(var_result) {
			return true
		} else {
			return (create_wp_error(rt.new_string('rest_invalid_featured_media'), rt.call_function('__', [rt.new_string('Invalid featured media ID.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	} else {
		return (rt.call_function('delete_post_thumbnail', [var_post_id_mutated.clone()])).to_bool()
	}
	return false
}

fn (mut this Class_WP_REST_Posts_Controller) check_template(var_template rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_template_mutated := var_template
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template_mutated)))) {
		return true
	}
	if rt.is_true(var_request.array_get(rt.new_string('id'))) {
	mut var_post := rt.call_function('get_post', [var_request.array_get(rt.new_string('id'))])
	mut var_current_template := rt.call_function('get_page_template_slug', [var_request.array_get(rt.new_string('id'))])
	} else {
	var_post = rt.new_null()
	var_current_template = rt.new_string('')
	}
	if rt.is_true(rt.identical(var_template_mutated, var_current_template)) {
		return true
	}
	mut var_allowed_templates := rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}), 'get_page_templates', [var_post.clone(), this.post_type])
	if var_allowed_templates.array_isset(var_template_mutated) {
		return true
	}
	return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is not one of %2$s.')]), rt.new_string('template'), rt.call_function('implode', [rt.new_string(', '), rt.func_array_keys(var_allowed_templates.clone())])]))).to_bool()
}

fn (mut this Class_WP_REST_Posts_Controller) handle_template(var_template rt.PhpVal, var_post_id rt.PhpVal, validate bool) {
	mut var_template_mutated := var_template
	mut var_post_id_mutated := var_post_id
	if var_validate && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}), 'get_page_templates', [rt.call_function('get_post', [var_post_id_mutated.clone()])]).array_isset(var_template_mutated.clone())))))) {
	var_template_mutated = rt.new_string('')
	}
	rt.call_function('update_post_meta', [var_post_id_mutated.clone(), rt.new_string('_wp_page_template'), var_template_mutated.clone()])
}

fn (mut this Class_WP_REST_Posts_Controller) handle_terms(var_post_id rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_id_mutated := var_post_id
	mut var_taxonomies := rt.call_function('wp_list_filter', [rt.call_function('get_object_taxonomies', [this.post_type, rt.new_string('objects')]), rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }])])
	mut iter_3 := var_taxonomies.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_taxonomy := item_3.val
		mut var_base := if !(!rt.is_true(rt.get_property(var_taxonomy, 'rest_base'))) { rt.get_property(var_taxonomy, 'rest_base') } else { rt.get_property(var_taxonomy, 'name') }
		if !(var_request.array_isset(var_base)) {
			continue
		}
		mut var_result := rt.call_function('wp_set_object_terms', [var_post_id_mutated.clone(), var_request.array_get(var_base), rt.get_property(var_taxonomy, 'name')])
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			return var_result.clone()
		}
	}
	return rt.new_null()
}

fn (mut this Class_WP_REST_Posts_Controller) check_assign_terms_permission(var_request rt.PhpVal) bool {
	mut var_taxonomies := rt.call_function('wp_list_filter', [rt.call_function('get_object_taxonomies', [this.post_type, rt.new_string('objects')]), rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }])])
	mut iter_4 := var_taxonomies.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_taxonomy := item_4.val
		mut var_base := if !(!rt.is_true(rt.get_property(var_taxonomy, 'rest_base'))) { rt.get_property(var_taxonomy, 'rest_base') } else { rt.get_property(var_taxonomy, 'name') }
		if !(var_request.array_isset(var_base)) {
			continue
		}
		mut iter_5 := rt.cast_array(var_request.array_get(var_base)).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_term_id := item_5.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_term', [var_term_id.clone(), rt.get_property(var_taxonomy, 'name')]))))) {
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('assign_term'), rt.new_int((var_term_id).to_i64())]))))) {
				return false
			}
		}
	}
	return true
}

fn (mut this Class_WP_REST_Posts_Controller) check_is_post_type_allowed(var_post_type rt.PhpVal) bool {
	mut var_post_type_mutated := var_post_type
	if !(var_post_type_mutated.clone().is_object()) {
	var_post_type_mutated = rt.call_function('get_post_type_object', [var_post_type_mutated.clone()])
	}
	if !(!rt.is_true(var_post_type_mutated)) && !(!rt.is_true(rt.get_property(var_post_type_mutated, 'show_in_rest'))) {
		return true
	}
	return false
}

fn (mut this Class_WP_REST_Posts_Controller) check_read_permission(var_post rt.PhpVal) bool {
	mut var_post_mutated := var_post
	mut var_post_type := rt.call_function('get_post_type_object', [rt.get_property(var_post_mutated, 'post_type')])
	if !(this.check_is_post_type_allowed(var_post_type.clone())) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post_mutated, 'post_status'))) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_post_mutated, 'ID')])) {
		return true
	}
	mut var_post_status_obj := rt.call_function('get_post_status_object', [rt.get_property(var_post_mutated, 'post_status')])
	if rt.is_true(var_post_status_obj) && rt.is_true(rt.get_property(var_post_status_obj, 'public')) {
		return true
	}
	if rt.is_true(rt.identical(rt.new_string('inherit'), rt.get_property(var_post_mutated, 'post_status'))) && rt.is_true(rt.greater(rt.get_property(var_post_mutated, 'post_parent'), rt.new_int(0))) {
		mut var_parent := rt.call_function('get_post', [rt.get_property(var_post_mutated, 'post_parent')])
		if rt.is_true(var_parent) {
			return this.check_read_permission(var_parent.clone())
		}
	}
	if rt.is_true(rt.identical(rt.new_string('inherit'), rt.get_property(var_post_mutated, 'post_status'))) {
		return true
	}
	return false
}

fn (mut this Class_WP_REST_Posts_Controller) check_update_permission(var_post rt.PhpVal) bool {
	mut var_post_mutated := var_post
	mut var_post_type := rt.call_function('get_post_type_object', [rt.get_property(var_post_mutated, 'post_type')])
	if !(this.check_is_post_type_allowed(var_post_type.clone())) {
		return false
	}
	return (rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post_mutated, 'ID')])).to_bool()
}

fn (mut this Class_WP_REST_Posts_Controller) check_create_permission(var_post rt.PhpVal) bool {
	mut var_post_mutated := var_post
	mut var_post_type := rt.call_function('get_post_type_object', [rt.get_property(var_post_mutated, 'post_type')])
	if !(this.check_is_post_type_allowed(var_post_type.clone())) {
		return false
	}
	return (rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'create_posts')])).to_bool()
}

fn (mut this Class_WP_REST_Posts_Controller) check_delete_permission(var_post rt.PhpVal) bool {
	mut var_post_mutated := var_post
	mut var_post_type := rt.call_function('get_post_type_object', [rt.get_property(var_post_mutated, 'post_type')])
	if !(this.check_is_post_type_allowed(var_post_type.clone())) {
		return false
	}
	return (rt.call_function('current_user_can', [rt.new_string('delete_post'), rt.get_property(var_post_mutated, 'ID')])).to_bool()
}

fn (mut this Class_WP_REST_Posts_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_post := var_item
	var_GLOBALS.array_set('post', var_post.clone())
	rt.call_function('setup_postdata', [var_post.clone()])
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.call_function('apply_filters', [rt.concat(rt.new_string('rest_prepare_'), this.post_type), create_wp_rest_response(rt.new_array()), var_post.clone(), var_request.clone()])
	}
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('id'), var_fields.clone()])) {
		var_data.array_set('id', rt.get_property(var_post, 'ID'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('date'), var_fields.clone()])) {
		var_data.array_set('date', this.prepare_date_response(rt.get_property(var_post, 'post_date_gmt'), rt.get_property(var_post, 'post_date')))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('date_gmt'), var_fields.clone()])) {
		if rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), rt.get_property(var_post, 'post_date_gmt'))) {
		mut var_post_date_gmt := rt.call_function('get_gmt_from_date', [rt.get_property(var_post, 'post_date')])
		} else {
		var_post_date_gmt = rt.get_property(var_post, 'post_date_gmt')
		}
		var_data.array_set('date_gmt', this.prepare_date_response(var_post_date_gmt.clone(), rt.new_null()))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('guid'), var_fields.clone()])) {
		var_data.array_set('guid', rt.create_array([rt.ArrayItem{ key: 'rendered', val: rt.call_function('apply_filters', [rt.new_string('get_the_guid'), rt.get_property(var_post, 'guid'), rt.get_property(var_post, 'ID')]) }, rt.ArrayItem{ key: 'raw', val: rt.get_property(var_post, 'guid') }]))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('modified'), var_fields.clone()])) {
		var_data.array_set('modified', this.prepare_date_response(rt.get_property(var_post, 'post_modified_gmt'), rt.get_property(var_post, 'post_modified')))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('modified_gmt'), var_fields.clone()])) {
		if rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), rt.get_property(var_post, 'post_modified_gmt'))) {
		mut var_post_modified_gmt := rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), rt.sub(rt.call_function('strtotime', [rt.get_property(var_post, 'post_modified')]), i64(rt.new_float((rt.call_function('get_option', [rt.new_string('gmt_offset')])).to_f64()) * rt.get_constant('HOUR_IN_SECONDS')))])
		} else {
		var_post_modified_gmt = rt.get_property(var_post, 'post_modified_gmt')
		}
		var_data.array_set('modified_gmt', this.prepare_date_response(var_post_modified_gmt.clone(), rt.new_null()))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('password'), var_fields.clone()])) {
		var_data.array_set('password', rt.get_property(var_post, 'post_password'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('slug'), var_fields.clone()])) {
		var_data.array_set('slug', rt.get_property(var_post, 'post_name'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('status'), var_fields.clone()])) {
		var_data.array_set('status', rt.get_property(var_post, 'post_status'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('type'), var_fields.clone()])) {
		var_data.array_set('type', rt.get_property(var_post, 'post_type'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('link'), var_fields.clone()])) {
		var_data.array_set('link', rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')]))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('title'), var_fields.clone()])) {
		var_data.array_set('title', rt.new_array())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('title.raw'), var_fields.clone()])) {
		var_data.array_get_mut('title').array_set('raw', rt.get_property(var_post, 'post_title'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('title.rendered'), var_fields.clone()])) {
		rt.call_function('add_filter', [rt.new_string('protected_title_format'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'protected_title_format' }])])
		rt.call_function('add_filter', [rt.new_string('private_title_format'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'protected_title_format' }])])
		var_data.array_get_mut('title').array_set('rendered', rt.call_function('get_the_title', [rt.get_property(var_post, 'ID')]))
		rt.call_function('remove_filter', [rt.new_string('protected_title_format'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'protected_title_format' }])])
		rt.call_function('remove_filter', [rt.new_string('private_title_format'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'protected_title_format' }])])
	}
	mut var_has_password_filter := rt.new_bool(false)
	if this.can_access_password_content(var_post.clone(), var_request.clone()) {
		this.password_check_passed.array_set(rt.get_property(var_post, 'ID'), true)
		rt.call_function('add_filter', [rt.new_string('post_password_required'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_password_required' }]), rt.new_int(10), rt.new_int(2)])
	var_has_password_filter = rt.new_bool(true)
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('content'), var_fields.clone()])) {
		var_data.array_set('content', rt.new_array())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('content.raw'), var_fields.clone()])) {
		var_data.array_get_mut('content').array_set('raw', rt.get_property(var_post, 'post_content'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('content.rendered'), var_fields.clone()])) {
		var_data.array_get_mut('content').array_set('rendered', if rt.is_true(rt.call_function('post_password_required', [var_post.clone()])) { rt.new_string('') } else { rt.call_function('apply_filters', [rt.new_string('the_content'), rt.get_property(var_post, 'post_content')]) })
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('content.protected'), var_fields.clone()])) {
		var_data.array_get_mut('content').array_set('protected', (rt.get_property(var_post, 'post_password')).to_bool())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('content.block_version'), var_fields.clone()])) {
		var_data.array_get_mut('content').array_set('block_version', rt.call_function('block_version', [rt.get_property(var_post, 'post_content')]))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('excerpt'), var_fields.clone()])) {
		if var_request.array_isset(rt.new_string('excerpt_length')) {
			mut var_excerpt_length := var_request.array_get(rt.new_string('excerpt_length'))
			closure_3_fn := fn [var_excerpt_length] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				return var_excerpt_length.clone()
				}
			mut var_override_excerpt_length := rt.new_closure(closure_3_fn)
			rt.call_function('add_filter', [rt.new_string('excerpt_length'), var_override_excerpt_length.clone(), rt.get_constant('PHP_INT_MAX')])
		}
		mut var_excerpt := rt.call_function('apply_filters', [rt.new_string('get_the_excerpt'), rt.get_property(var_post, 'post_excerpt'), var_post.clone()])
		var_excerpt = rt.call_function('apply_filters', [rt.new_string('the_excerpt'), var_excerpt.clone()])
		var_data.array_set('excerpt', rt.create_array([rt.ArrayItem{ key: 'raw', val: rt.get_property(var_post, 'post_excerpt') }, rt.ArrayItem{ key: 'rendered', val: if rt.is_true(rt.call_function('post_password_required', [var_post.clone()])) { rt.new_string('') } else { var_excerpt } }, rt.ArrayItem{ key: 'protected', val: (rt.get_property(var_post, 'post_password')).to_bool() }]))
		if !(var_override_excerpt_length).is_null() {
			rt.call_function('remove_filter', [rt.new_string('excerpt_length'), var_override_excerpt_length.clone(), rt.get_constant('PHP_INT_MAX')])
		}
	}
	if rt.is_true(var_has_password_filter) {
		rt.call_function('remove_filter', [rt.new_string('post_password_required'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_password_required' }])])
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('author'), var_fields.clone()])) {
		var_data.array_set('author', rt.new_int((rt.get_property(var_post, 'post_author')).to_i64()))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('featured_media'), var_fields.clone()])) {
		var_data.array_set('featured_media', rt.new_int((rt.call_function('get_post_thumbnail_id', [rt.get_property(var_post, 'ID')])).to_i64()))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('parent'), var_fields.clone()])) {
		var_data.array_set('parent', rt.new_int((rt.get_property(var_post, 'post_parent')).to_i64()))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('menu_order'), var_fields.clone()])) {
		var_data.array_set('menu_order', rt.new_int((rt.get_property(var_post, 'menu_order')).to_i64()))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('comment_status'), var_fields.clone()])) {
		var_data.array_set('comment_status', rt.get_property(var_post, 'comment_status'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('ping_status'), var_fields.clone()])) {
		var_data.array_set('ping_status', rt.get_property(var_post, 'ping_status'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('sticky'), var_fields.clone()])) {
		var_data.array_set('sticky', rt.call_function('is_sticky', [rt.get_property(var_post, 'ID')]))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('template'), var_fields.clone()])) {
		mut var_template := rt.call_function('get_page_template_slug', [rt.get_property(var_post, 'ID')])
		if rt.is_true(var_template) {
			var_data.array_set('template', var_template.clone())
		} else {
			var_data.array_set('template', '')
		}
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('format'), var_fields.clone()])) {
		var_data.array_set('format', rt.call_function('get_post_format', [rt.get_property(var_post, 'ID')]))
		if !rt.is_true(var_data.array_get(rt.new_string('format'))) {
			var_data.array_set('format', 'standard')
		}
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('meta'), var_fields.clone()])) {
		var_data.array_set('meta', rt.call_method(this.meta, 'get_value', [rt.get_property(var_post, 'ID'), var_request.clone()]))
	}
	mut var_taxonomies := rt.call_function('wp_list_filter', [rt.call_function('get_object_taxonomies', [this.post_type, rt.new_string('objects')]), rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }])])
	mut iter_6 := var_taxonomies.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_taxonomy := item_6.val
		mut var_base := if !(!rt.is_true(rt.get_property(var_taxonomy, 'rest_base'))) { rt.get_property(var_taxonomy, 'rest_base') } else { rt.get_property(var_taxonomy, 'name') }
		if rt.is_true(rt.call_function('rest_is_field_included', [var_base.clone(), var_fields.clone()])) {
			mut var_terms := rt.call_function('get_the_terms', [var_post.clone(), rt.get_property(var_taxonomy, 'name')])
			var_data.array_set(var_base, if rt.is_true(var_terms) { rt.call_function('array_values', [rt.call_function('wp_list_pluck', [var_terms.clone(), rt.new_string('term_id')])]) } else { rt.new_array() })
		}
	}
	mut var_post_type_obj := rt.call_function('get_post_type_object', [rt.get_property(var_post, 'post_type')])
	if rt.is_true(rt.call_function('is_post_type_viewable', [var_post_type_obj.clone()])) && rt.is_true(rt.get_property(var_post_type_obj, 'public')) {
		mut var_permalink_template_requested := rt.call_function('rest_is_field_included', [rt.new_string('permalink_template'), var_fields.clone()])
		mut var_generated_slug_requested := rt.call_function('rest_is_field_included', [rt.new_string('generated_slug'), var_fields.clone()])
		if rt.is_true(var_permalink_template_requested) || rt.is_true(var_generated_slug_requested) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_sample_permalink')]))))) {
				rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/post.php', '4')
			}
			mut var_sample_permalink := rt.call_function('get_sample_permalink', [rt.get_property(var_post, 'ID'), rt.get_property(var_post, 'post_title'), rt.new_string('')])
			if rt.is_true(var_permalink_template_requested) {
				var_data.array_set('permalink_template', var_sample_permalink.array_get(rt.new_int(0)))
			}
			if rt.is_true(var_generated_slug_requested) {
				var_data.array_set('generated_slug', var_sample_permalink.array_get(rt.new_int(1)))
			}
		}
		if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('class_list'), var_fields.clone()])) {
			var_data.array_set('class_list', rt.call_function('get_post_class', [rt.new_array(), rt.get_property(var_post, 'ID')]))
		}
	}
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) { var_request.array_get(rt.new_string('context')) } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.clone()])
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.clone()])) || rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.clone()])) {
		mut var_links := this.prepare_links(var_post.clone())
		rt.call_method(var_response, 'add_links', [var_links.clone()])
		if !(!rt.is_true(var_links.array_get(rt.new_string('self')).array_get(rt.new_string('href')))) {
			mut var_actions := this.get_available_actions(var_post.clone(), var_request.clone())
			mut var_self := var_links.array_get(rt.new_string('self')).array_get(rt.new_string('href'))
			mut iter_7 := var_actions.iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_rel := item_7.val
				rt.call_method(var_response, 'add_link', [var_rel.clone(), var_self.clone()])
			}
		}
	}
	mut var_content_like_post_types := rt.create_array([rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'wp_block' }, rt.ArrayItem{ key: none, val: 'wp_navigation' }])
	var_content_like_post_types = rt.call_function('apply_filters', [rt.new_string('rest_block_hooks_post_types'), var_content_like_post_types.clone(), this.post_type, var_post.clone()])
	if rt.is_true(rt.call_function('in_array', [this.post_type, var_content_like_post_types.clone(), rt.new_bool(true)])) {
	var_response = rt.call_function('insert_hooked_blocks_into_rest_response', [var_response.clone(), var_post.clone()])
	}
	return rt.call_function('apply_filters', [rt.concat(rt.new_string('rest_prepare_'), this.post_type), var_response.clone(), var_post.clone(), var_request.clone()])
}

fn (mut this Class_WP_REST_Posts_Controller) protected_title_format() string {
	return '%s'
}

fn (mut this Class_WP_REST_Posts_Controller) prepare_links(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_links := rt.create_array([rt.ArrayItem{ key: 'self', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('rest_get_route_for_post', [rt.get_property(var_post_mutated, 'ID')])]) }]) }, rt.ArrayItem{ key: 'collection', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('rest_get_route_for_post_type_items', [this.post_type])]) }]) }, rt.ArrayItem{ key: 'about', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string('wp/v2/types/' + (this.post_type).str())]) }]) }])
	if rt.is_true(rt.call_function('in_array', [rt.get_property(var_post_mutated, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'page' }]), rt.new_bool(true)])) || rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_post_mutated, 'post_type'), rt.new_string('author')])) && !(!rt.is_true(rt.get_property(var_post_mutated, 'post_author'))) {
		var_links.array_set('author', rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string('wp/v2/users/' + (rt.get_property(var_post_mutated, 'post_author')).str())]) }, rt.ArrayItem{ key: 'embeddable', val: true }]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.get_property(var_post_mutated, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'page' }]), rt.new_bool(true)])) || rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_post_mutated, 'post_type'), rt.new_string('comments')])) {
		mut var_replies_url := rt.call_function('rest_url', [rt.new_string('wp/v2/comments')])
		var_replies_url = rt.call_function('add_query_arg', [rt.new_string('post'), rt.get_property(var_post_mutated, 'ID'), var_replies_url.clone()])
		var_links.array_set('replies', rt.create_array([rt.ArrayItem{ key: 'href', val: var_replies_url }, rt.ArrayItem{ key: 'embeddable', val: true }]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.get_property(var_post_mutated, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'page' }]), rt.new_bool(true)])) || rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_post_mutated, 'post_type'), rt.new_string('revisions')])) {
		mut var_revisions := rt.call_function('wp_get_latest_revision_id_and_total_count', [rt.get_property(var_post_mutated, 'ID')])
		mut var_revisions_count := if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_revisions.clone()]))))) { var_revisions.array_get(rt.new_string('count')) } else { rt.new_int(0) }
		mut var_revisions_base := rt.call_function('sprintf', [rt.new_string('/%s/%s/%d/revisions'), rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.get_property(var_post_mutated, 'ID')])
		var_links.array_set('version-history', rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [var_revisions_base.clone()]) }, rt.ArrayItem{ key: 'count', val: var_revisions_count }]))
		if rt.is_true(rt.greater(var_revisions_count, rt.new_int(0))) {
			var_links.array_set('predecessor-version', rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string((var_revisions_base).str() + '/' + (var_revisions.array_get(rt.new_string('latest_id'))).str())]) }, rt.ArrayItem{ key: 'id', val: var_revisions.array_get(rt.new_string('latest_id')) }]))
		}
	}
	mut var_post_type_obj := rt.call_function('get_post_type_object', [rt.get_property(var_post_mutated, 'post_type')])
	if rt.is_true(rt.get_property(var_post_type_obj, 'hierarchical')) && !(!rt.is_true(rt.get_property(var_post_mutated, 'post_parent'))) {
		var_links.array_set('up', rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('rest_get_route_for_post', [rt.get_property(var_post_mutated, 'post_parent')])]) }, rt.ArrayItem{ key: 'embeddable', val: true }]))
	}
	mut var_featured_media := rt.call_function('get_post_thumbnail_id', [rt.get_property(var_post_mutated, 'ID')])
	if rt.is_true(var_featured_media) && rt.is_true(rt.identical(rt.new_string('publish'), rt.call_function('get_post_status', [var_featured_media.clone()]))) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), var_featured_media.clone()])) {
		mut var_image_url := rt.call_function('rest_url', [rt.call_function('rest_get_route_for_post', [var_featured_media.clone()])])
		var_links.array_set('https://api.w.org/featuredmedia', rt.create_array([rt.ArrayItem{ key: 'href', val: var_image_url }, rt.ArrayItem{ key: 'embeddable', val: true }]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_post_mutated, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'attachment' }, rt.ArrayItem{ key: none, val: 'nav_menu_item' }, rt.ArrayItem{ key: none, val: 'revision' }]), rt.new_bool(true)]))))) {
		mut var_attachments_url := rt.call_function('rest_url', [rt.call_function('rest_get_route_for_post_type_items', [rt.new_string('attachment')])])
		var_attachments_url = rt.call_function('add_query_arg', [rt.new_string('parent'), rt.get_property(var_post_mutated, 'ID'), var_attachments_url.clone()])
		var_links.array_set('https://api.w.org/attachment', rt.create_array([rt.ArrayItem{ key: 'href', val: var_attachments_url }]))
	}
	mut var_taxonomies := rt.call_function('get_object_taxonomies', [rt.get_property(var_post_mutated, 'post_type')])
	if !(!rt.is_true(var_taxonomies)) {
		var_links.array_set('https://api.w.org/term', rt.new_array())
		mut iter_8 := var_taxonomies.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_tax := item_8.val
			mut var_taxonomy_route := rt.call_function('rest_get_route_for_taxonomy_items', [var_tax.clone()])
			if !rt.is_true(var_taxonomy_route) {
				continue
			}
			mut var_terms_url := rt.call_function('add_query_arg', [rt.new_string('post'), rt.get_property(var_post_mutated, 'ID'), rt.call_function('rest_url', [var_taxonomy_route.clone()])])
			var_links.array_get_mut('https://api.w.org/term').array_push(rt.create_array([rt.ArrayItem{ key: 'href', val: var_terms_url }, rt.ArrayItem{ key: 'taxonomy', val: var_tax }, rt.ArrayItem{ key: 'embeddable', val: true }]))
		}
	}
	return var_links.clone()
}

fn (mut this Class_WP_REST_Posts_Controller) get_available_actions(var_post rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get(rt.new_string('context')))))) {
		return rt.new_array()
	}
	mut var_rels := rt.new_array()
	mut var_post_type := rt.call_function('get_post_type_object', [rt.get_property(var_post_mutated, 'post_type')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attachment'), this.post_type)))) && rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'publish_posts')])) {
		var_rels << 'https://api.w.org/action-publish'
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('unfiltered_html')])) {
		var_rels << 'https://api.w.org/action-unfiltered-html'
	}
	if rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_post_type, 'name'))) {
		if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_others_posts')])) && rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'publish_posts')])) {
			var_rels << 'https://api.w.org/action-sticky'
		}
	}
	if rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_post_type, 'name'), rt.new_string('author')])) {
		if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_others_posts')])) {
			var_rels << 'https://api.w.org/action-assign-author'
		}
	}
	mut var_taxonomies := rt.call_function('wp_list_filter', [rt.call_function('get_object_taxonomies', [this.post_type, rt.new_string('objects')]), rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }])])
	mut iter_9 := var_taxonomies.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_tax := item_9.val
		mut var_tax_base := if !(!rt.is_true(rt.get_property(var_tax, 'rest_base'))) { rt.get_property(var_tax, 'rest_base') } else { rt.get_property(var_tax, 'name') }
		mut var_create_cap := if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [rt.get_property(var_tax, 'name')])) { rt.get_property(rt.get_property(var_tax, 'cap'), 'edit_terms') } else { rt.get_property(rt.get_property(var_tax, 'cap'), 'assign_terms') }
		if rt.is_true(rt.call_function('current_user_can', [var_create_cap.clone()])) {
			var_rels << 'https://api.w.org/action-create-' + (var_tax_base).str()
		}
		if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_tax, 'cap'), 'assign_terms')])) {
			var_rels << 'https://api.w.org/action-assign-' + (var_tax_base).str()
		}
	}
	return var_rels.clone()
}

fn (mut this Class_WP_REST_Posts_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'schema')) {
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'schema'))
	}
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: this.post_type }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'date', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the post was published, in the site\'s timezone.')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'format', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }]) }, rt.ArrayItem{ key: 'date_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the post was published, as GMT.')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'format', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'guid', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The globally unique identifier for the post.')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'raw', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('GUID for the post, as it exists in the database.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'rendered', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('GUID for the post, transformed for display.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }, rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the post.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'link', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('URL to the post.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'modified', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the post was last modified, in the site\'s timezone.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'modified_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the post was last modified, as GMT.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('An alphanumeric identifier for the post unique to its type.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'sanitize_slug' }]) }]) }]) }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A named status for the post.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('get_post_stati', [rt.create_array([rt.ArrayItem{ key: 'internal', val: false }])])) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_status' }]) }]) }]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Type of post.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'password', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A password to protect access to the content and excerpt.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }]) }]) }])
	mut var_post_type_obj := rt.call_function('get_post_type_object', [this.post_type])
	if rt.is_true(rt.call_function('is_post_type_viewable', [var_post_type_obj.clone()])) && rt.is_true(rt.get_property(var_post_type_obj, 'public')) {
		var_schema.array_get_mut('properties').array_set('permalink_template', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Permalink template for the post.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]))
		var_schema.array_get_mut('properties').array_set('generated_slug', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Slug automatically generated from the post title.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]))
		var_schema.array_get_mut('properties').array_set('class_list', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('An array of the class names for the post container element.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]))
	}
	if rt.is_true(rt.get_property(var_post_type_obj, 'hierarchical')) {
		var_schema.array_get_mut('properties').array_set('parent', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID for the parent of the post.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]))
	}
	mut var_post_type_attributes := ['title', 'editor', 'author', 'excerpt', 'thumbnail', 'comments', 'revisions', 'page-attributes', 'post-formats', 'custom-fields']
	mut var_fixed_schemas := rt.create_array([rt.ArrayItem{ key: 'post', val: rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'editor' }, rt.ArrayItem{ key: none, val: 'author' }, rt.ArrayItem{ key: none, val: 'excerpt' }, rt.ArrayItem{ key: none, val: 'thumbnail' }, rt.ArrayItem{ key: none, val: 'comments' }, rt.ArrayItem{ key: none, val: 'revisions' }, rt.ArrayItem{ key: none, val: 'post-formats' }, rt.ArrayItem{ key: none, val: 'custom-fields' }]) }, rt.ArrayItem{ key: 'page', val: rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'editor' }, rt.ArrayItem{ key: none, val: 'author' }, rt.ArrayItem{ key: none, val: 'excerpt' }, rt.ArrayItem{ key: none, val: 'thumbnail' }, rt.ArrayItem{ key: none, val: 'comments' }, rt.ArrayItem{ key: none, val: 'revisions' }, rt.ArrayItem{ key: none, val: 'page-attributes' }, rt.ArrayItem{ key: none, val: 'custom-fields' }]) }, rt.ArrayItem{ key: 'attachment', val: rt.create_array([rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'author' }, rt.ArrayItem{ key: none, val: 'comments' }, rt.ArrayItem{ key: none, val: 'revisions' }, rt.ArrayItem{ key: none, val: 'custom-fields' }, rt.ArrayItem{ key: none, val: 'thumbnail' }]) }])
	for var_attribute in var_post_type_attributes {
		if var_fixed_schemas.array_isset(this.post_type) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(attribute), var_fixed_schemas.array_get(this.post_type), rt.new_bool(true)]))))) {
			continue
		} else if !(var_fixed_schemas.array_isset(this.post_type)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [this.post_type, rt.new_string(attribute)]))))) {
			continue
		}
		mut switch_val_2 := rt.new_string(attribute)
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('title'))) {
			var_schema.array_get_mut('properties').array_set('title', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The title for the post.')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_null() }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'raw', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Title for the post, as it exists in the database.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'rendered', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('HTML title for the post, transformed for display.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('editor'))) {
			var_schema.array_get_mut('properties').array_set('content', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The content for the post.')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_null() }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'raw', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Content for the post, as it exists in the database.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'rendered', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('HTML content for the post, transformed for display.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'block_version', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Version of the content block format used by the post.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'protected', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the content is protected with a password.')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('author'))) {
			var_schema.array_get_mut('properties').array_set('author', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID for the author of the post.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }]))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('excerpt'))) {
			var_schema.array_get_mut('properties').array_set('excerpt', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The excerpt for the post.')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_null() }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_null() }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'raw', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Excerpt for the post, as it exists in the database.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }]) }]) }, rt.ArrayItem{ key: 'rendered', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('HTML excerpt for the post, transformed for display.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'protected', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the excerpt is protected with a password.')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('thumbnail'))) {
			var_schema.array_get_mut('properties').array_set('featured_media', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID of the featured media for the post.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }]))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('comments'))) {
			var_schema.array_get_mut('properties').array_set('comment_status', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether or not comments are open on the post.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'open' }, rt.ArrayItem{ key: none, val: 'closed' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]))
			var_schema.array_get_mut('properties').array_set('ping_status', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether or not the post can be pinged.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'open' }, rt.ArrayItem{ key: none, val: 'closed' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('page-attributes'))) {
			var_schema.array_get_mut('properties').array_set('menu_order', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The order of the post in relation to other posts.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('post-formats'))) {
			mut var_formats := rt.call_function('array_values', [rt.call_function('get_post_format_slugs', []rt.PhpVal{})])
			var_schema.array_get_mut('properties').array_set('format', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The format for the post.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: var_formats }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('custom-fields'))) {
			var_schema.array_get_mut('properties').array_set('meta', rt.call_method(this.meta, 'get_field_schema', []rt.PhpVal{}))
		}
	}
	if rt.is_true(rt.identical(rt.new_string('post'), this.post_type)) {
		var_schema.array_get_mut('properties').array_set('sticky', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether or not the post should be treated as sticky.')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]))
	}
	var_schema.array_get_mut('properties').array_set('template', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The theme file to use to display the post.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_template' }]) }]) }]))
	mut var_taxonomies := rt.call_function('wp_list_filter', [rt.call_function('get_object_taxonomies', [this.post_type, rt.new_string('objects')]), rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }])])
	mut iter_10 := var_taxonomies.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_taxonomy := item_10.val
		mut var_base := if !(!rt.is_true(rt.get_property(var_taxonomy, 'rest_base'))) { rt.get_property(var_taxonomy, 'rest_base') } else { rt.get_property(var_taxonomy, 'name') }
		if rt.is_true(rt.new_bool(var_schema.array_get(rt.new_string('properties')).array_isset(var_base.clone()))) {
			mut var_taxonomy_field_name_with_conflict := rt.new_string((if !(!rt.is_true(rt.get_property(var_taxonomy, 'rest_base'))) { 'rest_base' } else { 'name' }).str())
			rt.call_function('_doing_it_wrong', [rt.new_string('register_taxonomy'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The "%1$s" taxonomy "%2$s" property (%3$s) conflicts with an existing property on the REST API Posts Controller. Specify a custom "rest_base" when registering the taxonomy to avoid this error.')]), rt.get_property(var_taxonomy, 'name'), var_taxonomy_field_name_with_conflict.clone(), var_base.clone()]), rt.new_string('5.4.0')])
		}
		var_schema.array_get_mut('properties').array_set(var_base, rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The terms assigned to the post in the %s taxonomy.')]), rt.get_property(var_taxonomy, 'name')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]))
	}
	mut var_schema_links := this.get_schema_links()
	if rt.is_true(var_schema_links) {
		var_schema.array_set('links', var_schema_links.clone())
	}
	mut var_schema_fields := rt.func_array_keys(var_schema.array_get(rt.new_string('properties')))
	var_schema = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('rest_'), this.post_type), rt.new_string('_item_schema')), var_schema.clone()])
	mut var_new_fields := rt.call_function('array_diff', [rt.func_array_keys(var_schema.array_get(rt.new_string('properties'))), var_schema_fields.clone()])
	if var_new_fields.clone().array_count() > 0 {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Please use %s to add new schema properties.')]), rt.new_string('register_rest_field')]), rt.new_string('5.4.0')])
	}
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'schema'))
}

fn (mut this Class_WP_REST_Posts_Controller) get_schema_links() rt.PhpVal {
	mut var_href := rt.call_function('rest_url', [rt.concat(rt.concat(rt.concat(rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.new_string('/')), rt.get_property(rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this), 'rest_base')), rt.new_string('/{id}'))])
	mut var_links := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attachment'), this.post_type)))) {
		var_links.array_push(rt.create_array([rt.ArrayItem{ key: 'rel', val: 'https://api.w.org/action-publish' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('The current user can publish this post.')]) }, rt.ArrayItem{ key: 'href', val: var_href }, rt.ArrayItem{ key: 'targetSchema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'publish' }, rt.ArrayItem{ key: none, val: 'future' }]) }]) }]) }]) }]))
	}
	var_links.array_push(rt.create_array([rt.ArrayItem{ key: 'rel', val: 'https://api.w.org/action-unfiltered-html' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('The current user can post unfiltered HTML markup and JavaScript.')]) }, rt.ArrayItem{ key: 'href', val: var_href }, rt.ArrayItem{ key: 'targetSchema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'content', val: rt.create_array([rt.ArrayItem{ key: 'raw', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }]))
	if rt.is_true(rt.identical(rt.new_string('post'), this.post_type)) {
		var_links.array_push(rt.create_array([rt.ArrayItem{ key: 'rel', val: 'https://api.w.org/action-sticky' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('The current user can sticky this post.')]) }, rt.ArrayItem{ key: 'href', val: var_href }, rt.ArrayItem{ key: 'targetSchema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'sticky', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }]) }]) }]) }]))
	}
	if rt.is_true(rt.call_function('post_type_supports', [this.post_type, rt.new_string('author')])) {
		var_links.array_push(rt.create_array([rt.ArrayItem{ key: 'rel', val: 'https://api.w.org/action-assign-author' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('The current user can change the author on this post.')]) }, rt.ArrayItem{ key: 'href', val: var_href }, rt.ArrayItem{ key: 'targetSchema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'author', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }]) }]))
	}
	mut var_taxonomies := rt.call_function('wp_list_filter', [rt.call_function('get_object_taxonomies', [this.post_type, rt.new_string('objects')]), rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }])])
	mut iter_11 := var_taxonomies.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_tax := item_11.val
		mut var_tax_base := if !(!rt.is_true(rt.get_property(var_tax, 'rest_base'))) { rt.get_property(var_tax, 'rest_base') } else { rt.get_property(var_tax, 'name') }
		mut var_assign_title := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The current user can assign terms in the %s taxonomy.')]), rt.get_property(var_tax, 'name')])
		mut var_create_title := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The current user can create terms in the %s taxonomy.')]), rt.get_property(var_tax, 'name')])
		var_links.array_push(rt.create_array([rt.ArrayItem{ key: 'rel', val: 'https://api.w.org/action-assign-' + (var_tax_base).str() }, rt.ArrayItem{ key: 'title', val: var_assign_title }, rt.ArrayItem{ key: 'href', val: var_href }, rt.ArrayItem{ key: 'targetSchema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: var_tax_base, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }]) }]) }]))
		var_links.array_push(rt.create_array([rt.ArrayItem{ key: 'rel', val: 'https://api.w.org/action-create-' + (var_tax_base).str() }, rt.ArrayItem{ key: 'title', val: var_create_title }, rt.ArrayItem{ key: 'href', val: var_href }, rt.ArrayItem{ key: 'targetSchema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: var_tax_base, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }]) }]) }]))
	}
	return var_links.clone()
}

fn (mut this Class_WP_REST_Posts_Controller) get_collection_params() rt.PhpVal {
	mut var_query_params := this.Class_WP_REST_Controller.get_collection_params()
	var_query_params.array_get_mut('context').array_set('default', 'view')
	var_query_params.array_set('after', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit response to posts published after a given ISO8601 compliant date.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }]))
	var_query_params.array_set('modified_after', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit response to posts modified after a given ISO8601 compliant date.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }]))
	if rt.is_true(rt.call_function('post_type_supports', [this.post_type, rt.new_string('author')])) {
		var_query_params.array_set('author', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to posts assigned to specific authors.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }]))
		var_query_params.array_set('author_exclude', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Ensure result set excludes posts assigned to specific authors.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }]))
	}
	var_query_params.array_set('before', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit response to posts published before a given ISO8601 compliant date.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }]))
	var_query_params.array_set('modified_before', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit response to posts modified before a given ISO8601 compliant date.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }]))
	var_query_params.array_set('exclude', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Ensure result set excludes specific IDs.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }]))
	var_query_params.array_set('include', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to specific IDs.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }]))
	if rt.is_true(rt.identical(rt.new_string('page'), this.post_type)) || rt.is_true(rt.call_function('post_type_supports', [this.post_type, rt.new_string('page-attributes')])) {
		var_query_params.array_set('menu_order', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to posts with a specific menu_order value.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]))
	}
	var_query_params.array_set('search_semantics', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('How to interpret the search input.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'exact' }]) }]))
	var_query_params.array_set('offset', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Offset the result set by a specific number of items.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]))
	var_query_params.array_set('order', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order sort attribute ascending or descending.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: 'desc' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'desc' }]) }]))
	var_query_params.array_set('orderby', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Sort collection by post attribute.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: 'date' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'author' }, rt.ArrayItem{ key: none, val: 'date' }, rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: 'include' }, rt.ArrayItem{ key: none, val: 'modified' }, rt.ArrayItem{ key: none, val: 'parent' }, rt.ArrayItem{ key: none, val: 'relevance' }, rt.ArrayItem{ key: none, val: 'slug' }, rt.ArrayItem{ key: none, val: 'include_slugs' }, rt.ArrayItem{ key: none, val: 'title' }]) }]))
	if rt.is_true(rt.identical(rt.new_string('page'), this.post_type)) || rt.is_true(rt.call_function('post_type_supports', [this.post_type, rt.new_string('page-attributes')])) {
		var_query_params.array_get_mut('orderby').array_get_mut('enum').array_push('menu_order')
	}
	mut var_post_type := rt.call_function('get_post_type_object', [this.post_type])
	if rt.is_true(rt.get_property(var_post_type, 'hierarchical')) || rt.is_true(rt.identical(rt.new_string('attachment'), this.post_type)) {
		var_query_params.array_set('parent', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items with particular parent IDs.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }]))
		var_query_params.array_set('parent_exclude', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to all items except those of a particular parent ID.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }]))
	}
	var_query_params.array_set('search_columns', rt.create_array([rt.ArrayItem{ key: 'default', val: rt.new_array() }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Array of column names to be searched.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'post_title' }, rt.ArrayItem{ key: none, val: 'post_content' }, rt.ArrayItem{ key: none, val: 'post_excerpt' }]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]))
	var_query_params.array_set('slug', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to posts with one or more specific slugs.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]))
	var_query_params.array_set('status', rt.create_array([rt.ArrayItem{ key: 'default', val: 'publish' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to posts assigned one or more statuses.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [rt.func_array_keys(rt.call_function('get_post_stati', []rt.PhpVal{})), rt.create_array([rt.ArrayItem{ key: none, val: 'any' }])]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Posts_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'sanitize_post_statuses' }]) }]))
	var_query_params = this.prepare_taxonomy_limit_schema(mut rt.cast_object_ptr[Class_array](var_query_params))
	if rt.is_true(rt.identical(rt.new_string('post'), this.post_type)) {
		var_query_params.array_set('sticky', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items that are sticky.')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }]))
		var_query_params.array_set('ignore_sticky', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether to ignore sticky posts or not.')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: true }]))
	}
	if rt.is_true(rt.call_function('post_type_supports', [this.post_type, rt.new_string('post-formats')])) {
		var_query_params.array_set('format', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items assigned one or more given formats.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'uniqueItems', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'enum', val: rt.call_function('array_values', [rt.call_function('get_post_format_slugs', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]))
	}
	return rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('rest_'), this.post_type), rt.new_string('_collection_params')), var_query_params.clone(), var_post_type.clone()])
}

fn (mut this Class_WP_REST_Posts_Controller) sanitize_post_statuses(var_statuses rt.PhpVal, var_request rt.PhpVal, var_parameter rt.PhpVal) rt.PhpVal {
	mut var_statuses_mutated := var_statuses
	var_statuses_mutated = rt.call_function('wp_parse_slug_list', [var_statuses_mutated.clone()])
	mut var_attributes := rt.call_method(var_request, 'get_attributes', []rt.PhpVal{})
	mut var_default_status := var_attributes.array_get(rt.new_string('args')).array_get(rt.new_string('status')).array_get(rt.new_string('default'))
	mut iter_12 := var_statuses_mutated.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_status := item_12.val
		if rt.is_true(rt.identical(var_status, var_default_status)) {
			continue
		}
		mut var_post_type_obj := rt.call_function('get_post_type_object', [this.post_type])
		if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_obj, 'cap'), 'edit_posts')])) || (rt.is_true(rt.identical(rt.new_string('private'), var_status)) && rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_obj, 'cap'), 'read_private_posts')]))) {
			mut var_result := rt.call_function('rest_validate_request_arg', [var_status.clone(), var_request.clone(), var_parameter.clone()])
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				return var_result.clone()
			}
		} else {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_forbidden_status'), rt.call_function('__', [rt.new_string('Status is forbidden.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))
		}
	}
	return var_statuses_mutated.clone()
}

fn (mut this Class_WP_REST_Posts_Controller) prepare_tax_query(mut var_args Class_array, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_relation := var_request.array_get(rt.new_string('tax_relation'))
	if rt.is_true(var_relation) {
		var_args_mutated.array_set('tax_query', rt.create_array([rt.ArrayItem{ key: 'relation', val: var_relation }]))
	}
	mut var_taxonomies := rt.call_function('wp_list_filter', [rt.call_function('get_object_taxonomies', [this.post_type, rt.new_string('objects')]), rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }])])
	mut iter_13 := var_taxonomies.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_taxonomy := item_13.val
		mut var_base := if !(!rt.is_true(rt.get_property(var_taxonomy, 'rest_base'))) { rt.get_property(var_taxonomy, 'rest_base') } else { rt.get_property(var_taxonomy, 'name') }
		mut var_tax_include := var_request.array_get(var_base)
		mut var_tax_exclude := var_request.array_get(rt.new_string((var_base).str() + '_exclude'))
		if rt.is_true(var_tax_include) {
			mut var_terms := rt.new_array()
			mut var_include_children := rt.new_bool(false)
			mut var_operator := rt.new_string('IN')
			if rt.is_true(rt.call_function('rest_is_array', [var_tax_include.clone()])) {
			var_terms = var_tax_include.clone()
			} else if rt.is_true(rt.call_function('rest_is_object', [var_tax_include.clone()])) {
				var_terms = if !rt.is_true(var_tax_include.array_get(rt.new_string('terms'))) { rt.new_array() } else { var_tax_include.array_get(rt.new_string('terms')) }
				var_include_children = rt.new_bool(!(!rt.is_true(var_tax_include.array_get(rt.new_string('include_children')))))
				if var_tax_include.array_isset(rt.new_string('operator')) && rt.is_true(rt.identical(rt.new_string('AND'), var_tax_include.array_get(rt.new_string('operator')))) {
				var_operator = rt.new_string('AND')
				}
			}
			if rt.is_true(var_terms) {
				var_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.get_property(var_taxonomy, 'name') }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'terms', val: var_terms }, rt.ArrayItem{ key: 'include_children', val: var_include_children }, rt.ArrayItem{ key: 'operator', val: var_operator }]))
			}
		}
		if rt.is_true(var_tax_exclude) {
			var_terms = rt.new_array()
			var_include_children = rt.new_bool(false)
			if rt.is_true(rt.call_function('rest_is_array', [var_tax_exclude.clone()])) {
			var_terms = var_tax_exclude.clone()
			} else if rt.is_true(rt.call_function('rest_is_object', [var_tax_exclude.clone()])) {
			var_terms = if !rt.is_true(var_tax_exclude.array_get(rt.new_string('terms'))) { rt.new_array() } else { var_tax_exclude.array_get(rt.new_string('terms')) }
			var_include_children = rt.new_bool(!(!rt.is_true(var_tax_exclude.array_get(rt.new_string('include_children')))))
			}
			if rt.is_true(var_terms) {
				var_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.get_property(var_taxonomy, 'name') }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'terms', val: var_terms }, rt.ArrayItem{ key: 'include_children', val: var_include_children }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }]))
			}
		}
	}
	return rt.new_object('array', []string{}, var_args_mutated)
}

fn (mut this Class_WP_REST_Posts_Controller) prepare_taxonomy_limit_schema(mut var_query_params Class_array) rt.PhpVal {
	mut var_query_params_mutated := var_query_params
	mut var_taxonomies := rt.call_function('wp_list_filter', [rt.call_function('get_object_taxonomies', [this.post_type, rt.new_string('objects')]), rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_taxonomies)))) {
		return rt.new_object('array', []string{}, var_query_params_mutated)
	}
	var_query_params_mutated.array_set('tax_relation', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set based on relationship between multiple taxonomies.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'AND' }, rt.ArrayItem{ key: none, val: 'OR' }]) }]))
	mut var_limit_schema := { 'type': map[string]rt.PhpVal{}, 'oneOf': map[string]rt.PhpVal{} }
	mut var_include_schema := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items with specific terms assigned in the %s taxonomy.')]) }]), rt.create_array_from_native_map(var_limit_schema)])
	var_include_schema.array_get_mut('oneOf').array_get_mut(1).array_get_mut('properties').array_set('operator', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether items must be assigned all or any of the specified terms.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'AND' }, rt.ArrayItem{ key: none, val: 'OR' }]) }, rt.ArrayItem{ key: 'default', val: 'OR' }]))
	mut var_exclude_schema := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to items except those with specific terms assigned in the %s taxonomy.')]) }]), rt.create_array_from_native_map(var_limit_schema)])
	mut iter_14 := var_taxonomies.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_taxonomy := item_14.val
		mut var_base := if !(!rt.is_true(rt.get_property(var_taxonomy, 'rest_base'))) { rt.get_property(var_taxonomy, 'rest_base') } else { rt.get_property(var_taxonomy, 'name') }
		mut var_base_exclude := rt.new_string((var_base).str() + '_exclude')
		var_query_params_mutated.array_set(var_base, var_include_schema.clone())
		var_query_params_mutated.array_get_mut(var_base).array_set('description', rt.call_function('sprintf', [var_query_params_mutated.array_get(var_base).array_get(rt.new_string('description')), var_base.clone()]))
		var_query_params_mutated.array_set(var_base_exclude, var_exclude_schema.clone())
		var_query_params_mutated.array_get_mut(var_base_exclude).array_set('description', rt.call_function('sprintf', [var_query_params_mutated.array_get(var_base_exclude).array_get(rt.new_string('description')), var_base.clone()]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_taxonomy, 'hierarchical'))))) {
			var_query_params_mutated.array_get(var_base).array_get(rt.new_string('oneOf')).array_get(rt.new_int(1)).array_get(rt.new_string('properties')).array_unset(rt.new_string('include_children'))
			var_query_params_mutated.array_get(var_base_exclude).array_get(rt.new_string('oneOf')).array_get(rt.new_int(1)).array_get(rt.new_string('properties')).array_unset(rt.new_string('include_children'))
		}
	}
	return rt.new_object('array', []string{}, var_query_params_mutated)
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

struct Class_stdClass {
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

fn create_wp_rest_controller(_args ...rt.PhpVal) &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
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

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
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


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
