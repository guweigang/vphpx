import rt

struct Class_WP_REST_Users_Controller {
	rt.PhpObjectBase
pub mut:
		meta rt.PhpVal = rt.new_null()
		allow_batch rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_REST_Users_Controller) construct()  {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('users'))
	this.meta = create_wp_rest_user_meta_fields()
}

fn (mut this Class_WP_REST_Users_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this), 'rest_base') + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the user.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Required to be true, as users do not support trashing.')]) }]) }, rt.ArrayItem{ key: 'reassign', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Reassign the deleted user\'s posts and links to this user ID.')]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_reassign' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this), 'rest_base') + '/me', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'permission_callback', val: '__return_true' }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_current_item' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_current_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_current_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_current_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_current_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Required to be true, as users do not support trashing.')]) }]) }, rt.ArrayItem{ key: 'reassign', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Reassign the deleted user\'s posts and links to this user ID.')]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'check_reassign' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Users_Controller) check_reassign(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(var_value.dup().is_long() || var_value.dup().is_double())) {
		return (var_value).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_value) || rt.is_true(rt.identical(rt.new_bool(false), var_value)))) || rt.is_true(rt.identical(rt.new_string('false'), var_value)))) {
		return false
	}
	return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [rt.new_string('Invalid user parameter(s).')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
}

fn (mut this Class_WP_REST_Users_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_request_mutated.array_get('roles'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')]))))))) {
		return (create_wp_error(rt.new_string('rest_user_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to filter users by role.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_request_mutated.array_get('capabilities'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')]))))))) {
		return (create_wp_error(rt.new_string('rest_user_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to filter users by capability.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('edit'), var_request_mutated.array_get('context'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')]))))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit users.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_request_mutated.array_get('orderby'), rt.create_array([rt.ArrayItem{ key: none, val: 'email' }, rt.ArrayItem{ key: none, val: 'registered_date' }]), rt.new_bool(true)])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')]))))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_orderby'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to order users by this parameter.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('authors'), var_request_mutated.array_get('who'))) {
		mut var_types := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('objects')])
		{
			mut iter_1 := var_types.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_type := item_1.val
				if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_type, 'name'), rt.new_string('author')])) && rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_type, 'cap'), 'edit_posts')])))) {
					return true
				}
			}
		}
		return (create_wp_error(rt.new_string('rest_forbidden_who'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to query users by this parameter.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Users_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_registered := this.get_collection_params()
	mut var_parameter_mappings := { 'exclude': 'exclude', 'include': 'include', 'order': 'order', 'per_page': 'number', 'search': 'search', 'roles': 'role__in', 'capabilities': 'capability__in', 'slug': 'nicename__in' }
	mut var_prepared_args := rt.new_array()
	for var_api_param, var_wp_param in var_parameter_mappings {
		if var_registered.array_isset(rt.new_string(api_param)) && var_request_mutated.array_isset(rt.new_string(api_param)) {
			var_prepared_args.array_set(wp_param, var_request_mutated.array_get(api_param))
		}
	}
	if var_registered.array_isset(rt.new_string('offset')) && !(!rt.is_true(var_request_mutated.array_get('offset'))) {
		var_prepared_args.array_set('offset', var_request_mutated.array_get('offset'))
	} else {
		var_prepared_args.array_set('offset', rt.mul(rt.sub(var_request_mutated.array_get('page'), rt.new_int(1)), var_prepared_args.array_get('number')))
	}
	if var_registered.array_isset(rt.new_string('orderby')) {
		mut var_orderby_possibles := rt.create_array([rt.ArrayItem{ key: 'id', val: 'ID' }, rt.ArrayItem{ key: 'include', val: 'include' }, rt.ArrayItem{ key: 'name', val: 'display_name' }, rt.ArrayItem{ key: 'registered_date', val: 'registered' }, rt.ArrayItem{ key: 'slug', val: 'user_nicename' }, rt.ArrayItem{ key: 'include_slugs', val: 'nicename__in' }, rt.ArrayItem{ key: 'email', val: 'user_email' }, rt.ArrayItem{ key: 'url', val: 'user_url' }])
		var_prepared_args.array_set('orderby', var_orderby_possibles.array_get(var_request_mutated.array_get('orderby')))
	}
	if rt.is_true(rt.new_bool(var_registered.array_isset(rt.new_string('who')) && !(!rt.is_true(var_request_mutated.array_get('who'))) && rt.is_true(rt.identical(rt.new_string('authors'), var_request_mutated.array_get('who'))))) {
		var_prepared_args.array_set('who', 'authors')
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')]))))) {
		var_prepared_args.array_set('has_published_posts', rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('names')]))
	}
	if !(!rt.is_true(var_request_mutated.array_get('has_published_posts'))) {
		var_prepared_args.array_set('has_published_posts', if rt.is_true(rt.identical(rt.new_bool(true), var_request_mutated.array_get('has_published_posts'))) { rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('names')]) } else { rt.cast_array(var_request_mutated.array_get('has_published_posts')) })
	}
	if !(!rt.is_true(var_prepared_args.array_get('search'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')]))))) {
			var_prepared_args.array_set('search_columns', rt.create_array([rt.ArrayItem{ key: none, val: 'ID' }, rt.ArrayItem{ key: none, val: 'user_login' }, rt.ArrayItem{ key: none, val: 'user_nicename' }, rt.ArrayItem{ key: none, val: 'display_name' }]))
		}
		mut var_search_columns := rt.call_method(var_request_mutated, 'get_param', [rt.new_string('search_columns')])
		mut var_valid_columns := if !(var_prepared_args.array_get('search_columns')).is_null() { var_prepared_args.array_get('search_columns') } else { rt.create_array([rt.ArrayItem{ key: none, val: 'ID' }, rt.ArrayItem{ key: none, val: 'user_login' }, rt.ArrayItem{ key: none, val: 'user_nicename' }, rt.ArrayItem{ key: none, val: 'user_email' }, rt.ArrayItem{ key: none, val: 'display_name' }]) }
		mut var_search_columns_mapping := { 'id': 'ID', 'username': 'user_login', 'slug': 'user_nicename', 'email': 'user_email', 'name': 'display_name' }
		closure_2_fn := fn [var_search_columns_mapping] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_search_columns_mapping] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_column := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string(var_search_columns_mapping[var_column])
	}
	mut var_column := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string(var_search_columns_mapping[var_column])
	}
		var_search_columns = rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_search_columns.dup()])
		var_search_columns = rt.call_function('array_intersect', [var_search_columns.dup(), var_valid_columns.dup()])
		if !(!rt.is_true(var_search_columns)) {
			var_prepared_args.array_set('search_columns', var_search_columns.dup())
		}
		var_prepared_args.array_set('search', '*' + (var_prepared_args.array_get('search')).str() + '*')
	}
	mut var_is_head_request := rt.call_method(var_request_mutated, 'is_method', [rt.new_string('HEAD')])
	if rt.is_true(var_is_head_request) {
		var_prepared_args.array_set('fields', 'id')
	}
	var_prepared_args = rt.call_function('apply_filters', [rt.new_string('rest_user_query'), var_prepared_args.dup(), var_request_mutated.dup()])
	mut var_query := create_wp_user_query(var_prepared_args.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_head_request)))) {
		mut var_users := rt.new_array()
		{
			mut iter_1 := var_query.get_results().iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_user := item_1.val
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('edit'), var_request_mutated.array_get('context'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), rt.get_property(var_user, 'ID')]))))))) {
					continue
				}
				mut var_data := this.prepare_item_for_response(var_user.dup(), var_request_mutated.dup())
				var_users << this.prepare_response_for_collection(var_data.dup())
			}
		}
	}
	mut var_response := if rt.is_true(var_is_head_request) { create_wp_rest_response(rt.new_array()) } else { rt.call_function('rest_ensure_response', [var_users.dup()]) }
	mut var_per_page := // unsupported expression: Expr_Cast_Int
	mut var_page := // unsupported expression: Expr_Cast_Int
	var_prepared_args.array_set('fields', 'ID')
	mut var_total_users := var_query.get_total()
	if rt.is_true(rt.less(var_total_users, rt.new_int(1))) {
		var_prepared_args.array_unset(rt.new_string('number'))
		var_prepared_args.array_unset(rt.new_string('offset'))
		var_prepared_args.array_set('number', 1)
		var_prepared_args.array_set('fields', 'ID')
		mut var_count_query := create_wp_user_query(var_prepared_args.dup())
		var_total_users = var_count_query.get_total()
	}
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), // unsupported expression: Expr_Cast_Int])
	mut var_max_pages := // unsupported expression: Expr_Cast_Int
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), var_max_pages.dup()])
	mut var_base := rt.call_function('add_query_arg', [rt.call_function('urlencode_deep', [rt.call_method(var_request_mutated, 'get_query_params', []rt.PhpVal{})]), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s'), rt.get_property(rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this), 'rest_base')])])])
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

fn (mut this Class_WP_REST_Users_Controller) get_user(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	mut var_error := create_wp_error(rt.new_string('rest_user_invalid_id'), rt.call_function('__', [rt.new_string('Invalid user ID.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	if rt.is_true(rt.less_equal(// unsupported expression: Expr_Cast_Int, rt.new_int(0))) {
		return mut var_error
	}
	mut var_user := rt.call_function('get_userdata', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(!rt.is_true(var_user) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))))) {
		return mut var_error
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [rt.get_property(var_user, 'ID')]))))))) {
		return mut var_error
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_user)
}

fn (mut this Class_WP_REST_Users_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut var_user := this.get_user(var_request_mutated.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return (var_user).to_bool()
	}
	mut var_types := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('names')])
	if rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.get_property(var_user, 'ID'))) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('edit'), var_request_mutated.array_get('context'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), rt.get_property(var_user, 'ID')]))))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this user.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), rt.get_property(var_user, 'ID')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')]))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('count_user_posts', [rt.get_property(var_user, 'ID'), var_types.dup()]))))))) {
		return (create_wp_error(rt.new_string('rest_user_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to list users.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Users_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_user := this.get_user(var_request_mutated.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		return var_user.dup()
	}
	var_user = this.prepare_item_for_response(var_user.dup(), var_request_mutated.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_user.dup()])
	return var_response.dup()
}

fn (mut this Class_WP_REST_Users_Controller) get_current_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if !rt.is_true(var_current_user_id) {
		return create_wp_error(rt.new_string('rest_not_logged_in'), rt.call_function('__', [rt.new_string('You are not currently logged in.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))
	}
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	mut var_response := this.prepare_item_for_response(var_user.dup(), var_request_mutated.dup())
	var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	return var_response.dup()
}

fn (mut this Class_WP_REST_Users_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('create_users')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_create_user'), rt.call_function('__', []), rt.create_array([rt.ArrayItem{ key: , val:  }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Users_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if !(!rt.is_true(.array_get())) {
		return mut rt.cast_object_ptr[Class_WP_Error]()
	}
	
}

fn (mut this Class_WP_REST_Users_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Users_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Users_Controller) update_current_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Users_Controller) update_current_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Users_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Users_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Users_Controller) delete_current_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Users_Controller) delete_current_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Users_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Users_Controller) prepare_links(var_user rt.PhpVal) rt.PhpVal {
	mut var_user_mutated := var_user
}

fn (mut this Class_WP_REST_Users_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Users_Controller) check_role_update(var_user_id rt.PhpVal, var_roles rt.PhpVal) bool {
	mut var_wp_roles := rt.new_null()
	mut var_user_id_mutated := var_user_id
}

fn (mut this Class_WP_REST_Users_Controller) check_username(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Users_Controller) check_user_password(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Users_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WP_REST_Users_Controller) get_collection_params() rt.PhpVal {
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_User_Meta_Fields {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_User_Query {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_users_controller() &Class_WP_REST_Users_Controller {
	mut obj := &Class_WP_REST_Users_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		meta: rt.new_null()
		allow_batch: rt.new_array()
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

fn create_wp_rest_user_meta_fields() &Class_WP_REST_User_Meta_Fields {
	mut obj := &Class_WP_REST_User_Meta_Fields{
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

fn create_wp_user_query() &Class_WP_User_Query {
	mut obj := &Class_WP_User_Query{
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

fn (mut this Class_WP_REST_Users_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'check_reassign' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.check_reassign(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_user' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_user(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_current_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_current_item(dispatch_arg_0)
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
		'update_current_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_current_item_permissions_check(dispatch_arg_0)
		}
		'update_current_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_current_item(dispatch_arg_0)
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_item_permissions_check(dispatch_arg_0))
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'delete_current_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_current_item_permissions_check(dispatch_arg_0)
		}
		'delete_current_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_current_item(dispatch_arg_0)
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
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
		}
		'check_role_update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.check_role_update(dispatch_arg_0, dispatch_arg_1))
		}
		'check_username' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.check_username(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'check_user_password' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.check_user_password(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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

fn (this &Class_WP_REST_Users_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'meta' { return this.meta }
		'allow_batch' { return this.allow_batch }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Users_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'meta' { this.meta = val; return true }
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


fn (mut this Class_WP_REST_User_Meta_Fields) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_User_Meta_Fields) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_User_Meta_Fields) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_User_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_users_controller_php() {
}
