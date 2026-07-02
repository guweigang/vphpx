import rt

struct Class_WP_REST_Users_Controller {
	rt.PhpObjectBase
pub mut:
	meta        rt.PhpVal = rt.new_null()
	allow_batch rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_REST_Users_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('users'))
	this.meta = create_wp_rest_user_meta_fields()
}

fn (mut this Class_WP_REST_Users_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Users_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this), 'rest_base')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable())
				},
			]) },
			rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Users_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the user.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
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
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
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
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'force', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'default', val: false },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Required to be true, as users do not support trashing.'),
						]) },
					]) },
					rt.ArrayItem{ key: 'reassign', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'integer' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string("Reassign the deleted user's posts and links to this user ID."),
						]) },
						rt.ArrayItem{ key: 'required', val: true },
						rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
							rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
								'WP_REST_Controller',
							], &this) },
							rt.ArrayItem{ key: none, val: 'check_reassign' },
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Users_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Users_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/me'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'permission_callback', val: '__return_true' },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_current_item' },
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
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_current_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_current_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_current_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_current_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'force', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'default', val: false },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Required to be true, as users do not support trashing.'),
						]) },
					]) },
					rt.ArrayItem{ key: 'reassign', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'integer' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string("Reassign the deleted user's posts and links to this user ID."),
						]) },
						rt.ArrayItem{ key: 'required', val: true },
						rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
							rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
								'WP_REST_Controller',
							], &this) },
							rt.ArrayItem{ key: none, val: 'check_reassign' },
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Users_Controller) check_reassign(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(var_value.clone().is_long() || var_value.clone().is_double())) {
		return var_value.to_bool()
	}
	if !rt.is_true(var_value) || rt.is_true(rt.identical(rt.new_bool(false), var_value))
		|| rt.is_true(rt.identical(rt.new_string('false'), var_value)) {
		return false
	}
	return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [
		rt.new_string('Invalid user parameter(s).'),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
}

fn (mut this Class_WP_REST_Users_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('roles'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')]))))) {
		return (create_wp_error(rt.new_string('rest_user_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to filter users by role.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('capabilities'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')]))))) {
		return (create_wp_error(rt.new_string('rest_user_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to filter users by capability.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('edit'), var_request_mutated.array_get(rt.new_string('context'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')]))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit users.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	if rt.is_true(rt.call_function('in_array', [var_request_mutated.array_get(rt.new_string('orderby')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'email'
	}, rt.ArrayItem{ key: none, val: 'registered_date' }]), rt.new_bool(true)]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')]))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_orderby'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to order users by this parameter.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('authors'),
		var_request_mutated.array_get(rt.new_string('who'))))
	{
		mut var_types := rt.call_function('get_post_types', [
			rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
			rt.new_string('objects'),
		])
		mut iter_1 := var_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			if rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_type, 'name'), rt.new_string('author')]))
				&& rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_type, 'cap'), 'edit_posts')])) {
				return true
			}
		}
		return (create_wp_error(rt.new_string('rest_forbidden_who'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to query users by this parameter.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Users_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_registered := this.get_collection_params()
	mut var_parameter_mappings := {
		'exclude':      'exclude'
		'include':      'include'
		'order':        'order'
		'per_page':     'number'
		'search':       'search'
		'roles':        'role__in'
		'capabilities': 'capability__in'
		'slug':         'nicename__in'
	}
	mut var_prepared_args := rt.new_array()
	for var_api_param, var_wp_param in var_parameter_mappings {
		if var_registered.array_isset(rt.new_string(api_param))
			&& var_request_mutated.array_isset(rt.new_string(api_param)) {
			var_prepared_args.array_set(wp_param,
				var_request_mutated.array_get(rt.new_string(api_param)))
		}
	}
	if var_registered.array_isset(rt.new_string('offset'))
		&& !(!rt.is_true(var_request_mutated.array_get(rt.new_string('offset')))) {
		var_prepared_args.array_set('offset',
			var_request_mutated.array_get(rt.new_string('offset')))
	} else {
		var_prepared_args.array_set('offset', rt.mul(rt.sub(var_request_mutated.array_get(rt.new_string('page')),
			rt.new_int(1)), var_prepared_args.array_get(rt.new_string('number'))))
	}
	if var_registered.array_isset(rt.new_string('orderby')) {
		mut var_orderby_possibles := rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'ID' },
			rt.ArrayItem{ key: 'include', val: 'include' },
			rt.ArrayItem{ key: 'name', val: 'display_name' },
			rt.ArrayItem{ key: 'registered_date', val: 'registered' },
			rt.ArrayItem{ key: 'slug', val: 'user_nicename' },
			rt.ArrayItem{ key: 'include_slugs', val: 'nicename__in' },
			rt.ArrayItem{ key: 'email', val: 'user_email' },
			rt.ArrayItem{ key: 'url', val: 'user_url' },
		])
		var_prepared_args.array_set('orderby',
			var_orderby_possibles.array_get(var_request_mutated.array_get(rt.new_string('orderby'))))
	}
	if var_registered.array_isset(rt.new_string('who'))
		&& !(!rt.is_true(var_request_mutated.array_get(rt.new_string('who'))))
		&& rt.is_true(rt.identical(rt.new_string('authors'), var_request_mutated.array_get(rt.new_string('who')))) {
		var_prepared_args.array_set('who', 'authors')
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('list_users'),
	])))))
	{
		var_prepared_args.array_set('has_published_posts', rt.call_function('get_post_types', [
			rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
			rt.new_string('names'),
		]))
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('has_published_posts')))) {
		var_prepared_args.array_set('has_published_posts', if rt.is_true(rt.identical(rt.new_bool(true),
			var_request_mutated.array_get(rt.new_string('has_published_posts'))))
		{
			rt.call_function('get_post_types', [
				rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
				rt.new_string('names'),
			])
		} else {
			rt.cast_array(var_request_mutated.array_get(rt.new_string('has_published_posts')))
		})
	}
	if !(!rt.is_true(var_prepared_args.array_get(rt.new_string('search')))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('list_users'),
		])))))
		{
			var_prepared_args.array_set('search_columns', rt.create_array([
				rt.ArrayItem{ key: none, val: 'ID' },
				rt.ArrayItem{ key: none, val: 'user_login' },
				rt.ArrayItem{ key: none, val: 'user_nicename' },
				rt.ArrayItem{ key: none, val: 'display_name' },
			]))
		}
		mut var_search_columns := rt.call_method(var_request_mutated, 'get_param', [
			rt.new_string('search_columns'),
		])
		mut var_valid_columns := if !(var_prepared_args.array_get(rt.new_string('search_columns'))).is_null() { var_prepared_args.array_get(rt.new_string('search_columns')) } else { rt.create_array([
				rt.ArrayItem{ key: none, val: 'ID' },
				rt.ArrayItem{ key: none, val: 'user_login' },
				rt.ArrayItem{ key: none, val: 'user_nicename' },
				rt.ArrayItem{ key: none, val: 'user_email' },
				rt.ArrayItem{ key: none, val: 'display_name' },
			]) }
		mut var_search_columns_mapping := {
			'id':       'ID'
			'username': 'user_login'
			'slug':     'user_nicename'
			'email':    'user_email'
			'name':     'display_name'
		}
		closure_1_fn := fn [var_search_columns_mapping] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_column := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_string((var_search_columns_mapping[var_column]).str())
		}
		closure_2_fn := fn [var_search_columns_mapping] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_column := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_string((var_search_columns_mapping[var_column]).str())
		}
		var_search_columns = rt.call_function('array_map', [rt.new_closure(closure_1_fn),
			var_search_columns.clone()])
		var_search_columns = rt.call_function('array_intersect', [
			var_search_columns.clone(), var_valid_columns.clone()])
		if !(!rt.is_true(var_search_columns)) {
			var_prepared_args.array_set('search_columns', var_search_columns.clone())
		}
		var_prepared_args.array_set('search', '*' +
			(var_prepared_args.array_get(rt.new_string('search'))).str() + '*')
	}
	mut var_is_head_request := rt.call_method(var_request_mutated, 'is_method', [
		rt.new_string('HEAD'),
	])
	if rt.is_true(var_is_head_request) {
		var_prepared_args.array_set('fields', 'id')
	}
	var_prepared_args = rt.call_function('apply_filters', [
		rt.new_string('rest_user_query'),
		var_prepared_args.clone(),
		var_request_mutated.clone(),
	])
	mut var_query := create_wp_user_query(var_prepared_args.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_head_request)))) {
		mut var_users := rt.new_array()
		mut iter_2 := var_query.get_results().iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_user := item_2.val
			if rt.is_true(rt.identical(rt.new_string('edit'), var_request_mutated.array_get(rt.new_string('context'))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), rt.get_property(var_user, 'ID')]))))) {
				continue
			}
			mut var_data := this.prepare_item_for_response(var_user.clone(),
				var_request_mutated.clone())
			var_users << this.prepare_response_for_collection(var_data.clone())
		}
	}
	mut var_response := if rt.is_true(var_is_head_request) { create_wp_rest_response(rt.new_array()) } else { rt.call_function('rest_ensure_response', [
			rt.create_array_from_list(var_users),
		]) }
	mut var_per_page := rt.new_int((var_prepared_args.array_get(rt.new_string('number'))).to_i64())
	mut var_page := rt.new_int((rt.call_function('ceil', [
		rt.add(rt.div(rt.new_int((var_prepared_args.array_get(rt.new_string('offset'))).to_i64()),
			var_per_page), rt.new_int(1)),
	])).to_i64())
	var_prepared_args.array_set('fields', 'ID')
	mut var_total_users := var_query.get_total()
	if rt.is_true(rt.less(var_total_users, rt.new_int(1))) {
		var_prepared_args.array_unset(rt.new_string('number'))
		var_prepared_args.array_unset(rt.new_string('offset'))
		var_prepared_args.array_set('number', 1)
		var_prepared_args.array_set('fields', 'ID')
		mut var_count_query := create_wp_user_query(var_prepared_args.clone())
		var_total_users = var_count_query.get_total()
	}
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int(var_total_users.to_i64())])
	mut var_max_pages := rt.new_int((rt.call_function('ceil', [
		rt.div(var_total_users, var_per_page),
	])).to_i64())
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		var_max_pages.clone()])
	mut var_base := rt.call_function('add_query_arg', [
		rt.call_function('urlencode_deep', [
			rt.call_method(var_request_mutated, 'get_query_params', []rt.PhpVal{}),
		]),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('%s/%s'),
				rt.get_property(rt.new_object('WP_REST_Users_Controller', [
					'WP_REST_Controller',
				], &this), 'namespace'),
				rt.get_property(rt.new_object('WP_REST_Users_Controller', [
					'WP_REST_Controller',
				], &this), 'rest_base')]),
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

fn (mut this Class_WP_REST_Users_Controller) get_user(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	mut var_error := create_wp_error(rt.new_string('rest_user_invalid_id'), rt.call_function('__', [
		rt.new_string('Invalid user ID.'),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	if rt.new_int(var_id_mutated.to_i64()) <= 0 {
		return mut var_error
	}
	mut var_user := rt.call_function('get_userdata', [
		rt.new_int(var_id_mutated.to_i64()),
	])
	if !rt.is_true(var_user)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{}))))) {
		return mut var_error
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [rt.get_property(var_user, 'ID')]))))) {
		return mut var_error
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_user)
}

fn (mut this Class_WP_REST_Users_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut var_user := this.get_user(var_request_mutated.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.to_bool()
	}
	mut var_types := rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
		rt.new_string('names'),
	])
	if rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.get_property(var_user,
		'ID')))
	{
		return true
	}
	if rt.is_true(rt.identical(rt.new_string('edit'), var_request_mutated.array_get(rt.new_string('context'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), rt.get_property(var_user, 'ID')]))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this user.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), rt.get_property(var_user, 'ID')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('count_user_posts', [rt.get_property(var_user, 'ID'), var_types.clone()]))))) {
		return (create_wp_error(rt.new_string('rest_user_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to list users.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Users_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_user := this.get_user(var_request_mutated.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.clone()
	}
	var_user = this.prepare_item_for_response(var_user.clone(), var_request_mutated.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_user.clone()])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Users_Controller) get_current_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if !rt.is_true(var_current_user_id) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_not_logged_in'), rt.call_function('__', [
			rt.new_string('You are not currently logged in.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }])))
	}
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	mut var_response := this.prepare_item_for_response(var_user.clone(),
		var_request_mutated.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Users_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('create_users'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_create_user'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to create new users.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Users_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('id')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_user_exists'), rt.call_function('__', [
			rt.new_string('Cannot create existing user.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('roles'))))
		&& !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('roles')))) {
		mut var_check_permission := rt.new_bool(this.check_role_update(var_request_mutated.array_get(rt.new_string('id')),
			var_request_mutated.array_get(rt.new_string('roles'))))
		if rt.is_true(rt.call_function('is_wp_error', [var_check_permission.clone()])) {
			return mut rt.cast_object_ptr[Class_WP_Error](var_check_permission)
		}
	}
	mut var_user := this.prepare_item_for_database(var_request_mutated.clone())
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut var_ret := rt.call_function('wpmu_validate_user_signup', [
			rt.get_property(var_user, 'user_login'),
			rt.get_property(var_user, 'user_email'),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_ret.array_get(rt.new_string('errors'))]))
			&& rt.is_true(rt.call_method(var_ret.array_get(rt.new_string('errors')), 'has_errors', []rt.PhpVal{})) {
			mut var_error := create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('__', [
				rt.new_string('Invalid user parameter(s).'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
			mut iter_3 :=
				rt.get_property(var_ret.array_get(rt.new_string('errors')), 'errors').iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_messages := item_3.val
				mut var_code := item_3.key
				mut iter_4 := var_messages.iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_message := item_4.val
					var_error.add(var_code.clone(), var_message.clone())
				}
				mut var_error_data := var_error.get_error_data(var_code.clone())
				if rt.is_true(var_error_data) {
					var_error.add_data(var_error_data.clone(), var_code.clone())
				}
			}
			return mut var_error
		}
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut var_user_id := rt.call_function('wpmu_create_user', [
			rt.get_property(var_user, 'user_login'),
			rt.get_property(var_user, 'user_pass'),
			rt.get_property(var_user, 'user_email'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_user_create'), rt.call_function('__', [
				rt.new_string('Error creating new user.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
		}
		rt.set_property(var_user, 'ID', var_user_id.clone())
		var_user_id = rt.call_function('wp_update_user', [
			rt.call_function('wp_slash', [rt.cast_array(var_user)]),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_user_id.clone()])) {
			return mut rt.cast_object_ptr[Class_WP_Error](var_user_id)
		}
		mut var_result := rt.call_function('add_user_to_blog', [
			rt.get_property(rt.call_function('get_site', []rt.PhpVal{}), 'id'),
			var_user_id.clone(),
			rt.new_string(''),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			return mut rt.cast_object_ptr[Class_WP_Error](var_result)
		}
	} else {
		var_user_id = rt.call_function('wp_insert_user', [
			rt.call_function('wp_slash', [rt.cast_array(var_user)]),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_user_id.clone()])) {
			return mut rt.cast_object_ptr[Class_WP_Error](var_user_id)
		}
	}
	var_user = rt.call_function('get_user_by', [rt.new_string('id'),
		var_user_id.clone()])
	rt.call_function('do_action', [rt.new_string('rest_insert_user'),
		var_user.clone(), var_request_mutated.clone(), rt.new_bool(true)])
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('roles'))))
		&& !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('roles')))) {
		rt.call_function('array_map', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_user },
				rt.ArrayItem{ key: none, val: 'add_role' }]),
			var_request_mutated.array_get(rt.new_string('roles')),
		])
	}
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('meta'))))
		&& var_request_mutated.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(this.meta, 'update_value', [
			var_request_mutated.array_get(rt.new_string('meta')),
			var_user_id.clone(),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.clone()])) {
			return mut rt.cast_object_ptr[Class_WP_Error](var_meta_update)
		}
	}
	var_user = rt.call_function('get_user_by', [rt.new_string('id'),
		var_user_id.clone()])
	mut var_fields_update := this.update_additional_fields_for_object(var_user.clone(),
		var_request_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return mut rt.cast_object_ptr[Class_WP_Error](var_fields_update)
	}
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	rt.call_function('do_action', [rt.new_string('rest_after_insert_user'),
		var_user.clone(), var_request_mutated.clone(), rt.new_bool(true)])
	mut var_response := this.prepare_item_for_response(var_user.clone(),
		var_request_mutated.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('%s/%s/%d'),
				rt.get_property(rt.new_object('WP_REST_Users_Controller', [
					'WP_REST_Controller',
				], &this), 'namespace'),
				rt.get_property(rt.new_object('WP_REST_Users_Controller', [
					'WP_REST_Controller',
				], &this), 'rest_base'),
				var_user_id.clone()]),
		])])
	return mut rt.cast_object_ptr[Class_WP_Error](var_response)
}

fn (mut this Class_WP_REST_Users_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut var_user := this.get_user(var_request_mutated.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.to_bool()
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('roles')))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('promote_user'),
			rt.get_property(var_user, 'ID'),
		])))))
		{
			return (create_wp_error(rt.new_string('rest_cannot_edit_roles'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to edit roles of this user.'),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
					[]rt.PhpVal{}) },
			]))).to_bool()
		}
		mut var_request_params := rt.func_array_keys(rt.call_method(var_request_mutated,
			'get_params', []rt.PhpVal{}))
		rt.call_function('sort', [var_request_params.clone()])
		if rt.is_true(rt.identical(rt.create_array([rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'roles' }]), var_request_params))
		{
			return true
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_user'),
		rt.get_property(var_user, 'ID'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_edit'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to edit this user.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Users_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_user := this.get_user(var_request_mutated.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.clone()
	}
	mut var_id := rt.get_property(var_user, 'ID')
	mut var_owner_id := rt.new_bool(false)
	if rt.is_true(rt.new_bool(var_request_mutated.array_get(rt.new_string('email')).is_string())) {
		var_owner_id = rt.call_function('email_exists', [
			var_request_mutated.array_get(rt.new_string('email')),
		])
	}
	if rt.is_true(var_owner_id)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_owner_id, var_id)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_user_invalid_email'), rt.call_function('__', [
			rt.new_string('Invalid email address.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('username'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_request_mutated.array_get(rt.new_string('username')), rt.get_property(var_user, 'user_login'))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_user_invalid_argument'), rt.call_function('__', [
			rt.new_string('Username is not editable.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('slug'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_request_mutated.array_get(rt.new_string('slug')), rt.get_property(var_user, 'user_nicename')))))
		&& rt.is_true(rt.call_function('get_user_by', [rt.new_string('slug'), var_request_mutated.array_get(rt.new_string('slug'))])) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_user_invalid_slug'), rt.call_function('__', [
			rt.new_string('Invalid slug.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('roles')))) {
		mut var_check_permission := rt.new_bool(this.check_role_update(var_id.clone(),
			var_request_mutated.array_get(rt.new_string('roles'))))
		if rt.is_true(rt.call_function('is_wp_error', [var_check_permission.clone()])) {
			return var_check_permission.clone()
		}
	}
	var_user = this.prepare_item_for_database(var_request_mutated.clone())
	rt.set_property(var_user, 'ID', var_id.clone())
	mut var_user_id := rt.call_function('wp_update_user', [
		rt.call_function('wp_slash', [rt.cast_array(var_user)]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_user_id.clone()])) {
		return var_user_id.clone()
	}
	var_user = rt.call_function('get_user_by', [rt.new_string('id'),
		var_user_id.clone()])
	rt.call_function('do_action', [rt.new_string('rest_insert_user'),
		var_user.clone(), var_request_mutated.clone(), rt.new_bool(false)])
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('roles')))) {
		rt.call_function('array_map', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_user },
				rt.ArrayItem{ key: none, val: 'add_role' }]),
			var_request_mutated.array_get(rt.new_string('roles')),
		])
	}
	mut var_schema := this.get_item_schema()
	if !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('meta'))))
		&& var_request_mutated.array_isset(rt.new_string('meta')) {
		mut var_meta_update := rt.call_method(this.meta, 'update_value', [
			var_request_mutated.array_get(rt.new_string('meta')),
			var_id.clone(),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_meta_update.clone()])) {
			return var_meta_update.clone()
		}
	}
	var_user = rt.call_function('get_user_by', [rt.new_string('id'),
		var_user_id.clone()])
	mut var_fields_update := this.update_additional_fields_for_object(var_user.clone(),
		var_request_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_fields_update.clone()])) {
		return var_fields_update.clone()
	}
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	rt.call_function('do_action', [rt.new_string('rest_after_insert_user'),
		var_user.clone(), var_request_mutated.clone(), rt.new_bool(false)])
	mut var_response := this.prepare_item_for_response(var_user.clone(),
		var_request_mutated.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Users_Controller) update_current_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	var_request_mutated.array_set('id', rt.call_function('get_current_user_id', []rt.PhpVal{}))
	return rt.new_bool(this.update_item_permissions_check(var_request_mutated.clone()))
}

fn (mut this Class_WP_REST_Users_Controller) update_current_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	var_request_mutated.array_set('id', rt.call_function('get_current_user_id', []rt.PhpVal{}))
	return this.update_item(var_request_mutated.clone())
}

fn (mut this Class_WP_REST_Users_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut var_user := this.get_user(var_request_mutated.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('delete_user'),
		rt.get_property(var_user, 'ID'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_user_cannot_delete'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete this user.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Users_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('The user cannot be deleted.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
	}
	mut var_user := this.get_user(var_request_mutated.array_get(rt.new_string('id')))
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return var_user.clone()
	}
	mut var_id := rt.get_property(var_user, 'ID')
	mut var_reassign := if rt.is_true(rt.identical(rt.new_bool(false), var_request_mutated.array_get(rt.new_string('reassign')))) { rt.new_null() } else { rt.call_function('absint', [
			var_request_mutated.array_get(rt.new_string('reassign')),
		]) }
	mut var_force := rt.new_bool(if var_request_mutated.array_isset(rt.new_string('force')) {
		(var_request_mutated.array_get(rt.new_string('force'))).to_bool()
	} else {
		false
	})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_force)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_trash_not_supported'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string("Users do not support trashing. Set '%s' to delete."),
			]),
			rt.new_string('force=true'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
	}
	if !(!rt.is_true(var_reassign)) {
		if rt.is_true(rt.identical(var_reassign, var_id))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_userdata', [var_reassign.clone()]))))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_user_invalid_reassign'), rt.call_function('__', [
				rt.new_string('Invalid user ID for reassignment.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
	}
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_previous := this.prepare_item_for_response(var_user.clone(),
		var_request_mutated.clone())
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/user.php', '4')
	mut var_result := rt.call_function('wp_delete_user', [var_id.clone(),
		var_reassign.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('The user cannot be deleted.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	mut var_response := create_wp_rest_response()
	rt.call_method(var_response, 'set_data', [
		rt.create_array([rt.ArrayItem{ key: 'deleted', val: true },
			rt.ArrayItem{ key: 'previous', val: rt.call_method(var_previous, 'get_data',
				[]rt.PhpVal{}) }]),
	])
	rt.call_function('do_action', [rt.new_string('rest_delete_user'),
		var_user.clone(), var_response.clone(), var_request_mutated.clone()])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Users_Controller) delete_current_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	var_request_mutated.array_set('id', rt.call_function('get_current_user_id', []rt.PhpVal{}))
	return rt.new_bool(this.delete_item_permissions_check(var_request_mutated.clone()))
}

fn (mut this Class_WP_REST_Users_Controller) delete_current_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	var_request_mutated.array_set('id', rt.call_function('get_current_user_id', []rt.PhpVal{}))
	return this.delete_item(var_request_mutated.clone())
}

fn (mut this Class_WP_REST_Users_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_user := var_item
	if rt.is_true(rt.call_method(var_request_mutated, 'is_method', [
		rt.new_string('HEAD'),
	]))
	{
		return rt.call_function('apply_filters', [rt.new_string('rest_prepare_user'),
			create_wp_rest_response(rt.new_array()), var_user.clone(),
			var_request_mutated.clone()])
	}
	mut var_fields := this.get_fields_for_response(var_request_mutated.clone())
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('in_array', [rt.new_string('id'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('id', rt.get_property(var_user, 'ID'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('username'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('username', rt.get_property(var_user, 'user_login'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('name'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('name', rt.get_property(var_user, 'display_name'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('first_name'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('first_name', rt.get_property(var_user, 'first_name'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('last_name'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('last_name', rt.get_property(var_user, 'last_name'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('email'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('email', rt.get_property(var_user, 'user_email'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('url'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('url', rt.get_property(var_user, 'user_url'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('description'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('description', rt.get_property(var_user, 'description'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('link'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('link', rt.call_function('get_author_posts_url', [
			rt.get_property(var_user, 'ID'),
			rt.get_property(var_user, 'user_nicename'),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('locale'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('locale', rt.call_function('get_user_locale', [
			var_user.clone()]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('nickname'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('nickname', rt.get_property(var_user, 'nickname'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('slug'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('slug', rt.get_property(var_user, 'user_nicename'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('roles'), var_fields.clone(), rt.new_bool(true)]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('list_users')]))
		|| rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_user'), rt.get_property(var_user, 'ID')])) {
		var_data.array_set('roles', rt.call_function('array_values', [
			rt.get_property(var_user, 'roles'),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('registered_date'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('registered_date', rt.call_function('gmdate', [
			rt.new_string('c'),
			rt.call_function('strtotime', [rt.get_property(var_user, 'user_registered')]),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('capabilities'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('capabilities', rt.array_to_object(rt.get_property(var_user, 'allcaps')))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('extra_capabilities'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('extra_capabilities', rt.array_to_object(rt.get_property(var_user,
			'caps')))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('avatar_urls'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('avatar_urls', rt.call_function('rest_get_avatar_urls', [
			var_user.clone(),
		]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('meta'),
		var_fields.clone(), rt.new_bool(true)]))
	{
		var_data.array_set('meta', rt.call_method(this.meta, 'get_value', [
			rt.get_property(var_user, 'ID'),
			var_request_mutated.clone(),
		]))
	}
	mut var_context := if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('context')))) {
		var_request_mutated.array_get(rt.new_string('context'))
	} else {
		rt.new_string('embed')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request_mutated.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.clone()]))
		|| rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.clone()])) {
		rt.call_method(var_response, 'add_links', [this.prepare_links(var_user.clone())])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_user'),
		var_response.clone(), var_user.clone(), var_request_mutated.clone()])
}

fn (mut this Class_WP_REST_Users_Controller) prepare_links(var_user rt.PhpVal) rt.PhpVal {
	mut var_user_mutated := var_user
	mut var_links := {
		'self':       {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s/%d'),
					rt.get_property(rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base'),
					rt.get_property(var_user_mutated, 'ID')]),
			])
		}
		'collection': {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Users_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base')]),
			])
		}
	}
	return var_links.clone()
}

fn (mut this Class_WP_REST_Users_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_prepared_user := create_stdclass()
	mut var_schema := this.get_item_schema()
	if var_request_mutated.array_isset(rt.new_string('email'))
		&& !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('email')))) {
		rt.set_property(var_prepared_user, 'user_email',
			var_request_mutated.array_get(rt.new_string('email')))
	}
	if var_request_mutated.array_isset(rt.new_string('username'))
		&& !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('username')))) {
		rt.set_property(var_prepared_user, 'user_login',
			var_request_mutated.array_get(rt.new_string('username')))
	}
	if var_request_mutated.array_isset(rt.new_string('password'))
		&& !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('password')))) {
		rt.set_property(var_prepared_user, 'user_pass',
			var_request_mutated.array_get(rt.new_string('password')))
	}
	if var_request_mutated.array_isset(rt.new_string('id')) {
		rt.set_property(var_prepared_user, 'ID', rt.call_function('absint', [
			var_request_mutated.array_get(rt.new_string('id')),
		]))
	}
	if var_request_mutated.array_isset(rt.new_string('name'))
		&& !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('name')))) {
		rt.set_property(var_prepared_user, 'display_name',
			var_request_mutated.array_get(rt.new_string('name')))
	}
	if var_request_mutated.array_isset(rt.new_string('first_name'))
		&& !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('first_name')))) {
		rt.set_property(var_prepared_user, 'first_name',
			var_request_mutated.array_get(rt.new_string('first_name')))
	}
	if var_request_mutated.array_isset(rt.new_string('last_name'))
		&& !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('last_name')))) {
		rt.set_property(var_prepared_user, 'last_name',
			var_request_mutated.array_get(rt.new_string('last_name')))
	}
	if var_request_mutated.array_isset(rt.new_string('nickname'))
		&& !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('nickname')))) {
		rt.set_property(var_prepared_user, 'nickname',
			var_request_mutated.array_get(rt.new_string('nickname')))
	}
	if var_request_mutated.array_isset(rt.new_string('slug'))
		&& !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('slug')))) {
		rt.set_property(var_prepared_user, 'user_nicename',
			var_request_mutated.array_get(rt.new_string('slug')))
	}
	if var_request_mutated.array_isset(rt.new_string('description'))
		&& !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('description')))) {
		rt.set_property(var_prepared_user, 'description',
			var_request_mutated.array_get(rt.new_string('description')))
	}
	if var_request_mutated.array_isset(rt.new_string('url'))
		&& !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('url')))) {
		rt.set_property(var_prepared_user, 'user_url',
			var_request_mutated.array_get(rt.new_string('url')))
	}
	if var_request_mutated.array_isset(rt.new_string('locale'))
		&& !(!rt.is_true(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('locale')))) {
		rt.set_property(var_prepared_user, 'locale',
			var_request_mutated.array_get(rt.new_string('locale')))
	}
	if var_request_mutated.array_isset(rt.new_string('roles')) {
		rt.set_property(var_prepared_user, 'role', rt.new_bool(false))
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_pre_insert_user'),
		var_prepared_user, var_request_mutated.clone()])
}

fn (mut this Class_WP_REST_Users_Controller) check_role_update(var_user_id rt.PhpVal, var_roles rt.PhpVal) bool {
	mut var_wp_roles := rt.new_null()
	mut var_user_id_mutated := var_user_id
	mut iter_5 := var_roles.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_role := item_5.val
		if !(rt.get_property(var_wp_roles, 'role_objects').array_isset(var_role)) {
			return (create_wp_error(rt.new_string('rest_user_invalid_role'), rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('The role %s does not exist.')]),
				var_role.clone(),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
		mut var_potential_role := rt.get_property(var_wp_roles, 'role_objects').array_get(var_role)
		if !(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_sites')])))
			&& rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), var_user_id_mutated))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_potential_role, 'has_cap', [rt.new_string('edit_users')]))))) {
			return (create_wp_error(rt.new_string('rest_user_invalid_role'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to give users that role.'),
			]), rt.create_array([
				rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
					[]rt.PhpVal{}) },
			]))).to_bool()
		}
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/user.php', '4')
		mut var_editable_roles := rt.call_function('get_editable_roles', []rt.PhpVal{})
		if !rt.is_true(var_editable_roles.array_get(var_role)) {
			return (create_wp_error(rt.new_string('rest_user_invalid_role'), rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to give users that role.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]))).to_bool()
		}
	}
	return true
}

fn (mut this Class_WP_REST_Users_Controller) check_username(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_username := rt.new_string(var_value.str())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('validate_username', [
		var_username.clone(),
	])))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_user_invalid_username'), rt.call_function('__', [
			rt.new_string('This username is invalid because it uses illegal characters. Please enter a valid username.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_illegal_logins := rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('illegal_user_logins'),
		rt.new_array(),
	]))
	if rt.is_true(rt.call_function('in_array', [
		rt.new_string(var_username.clone().to_string().to_lower()),
		rt.call_function('array_map', [rt.new_string('strtolower'),
			var_illegal_logins.clone()]),
		rt.new_bool(true),
	]))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_user_invalid_username'), rt.call_function('__', [
			rt.new_string('Sorry, that username is not allowed.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	return var_username.clone()
}

fn (mut this Class_WP_REST_Users_Controller) check_user_password(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_password := rt.new_string(var_value.str())
	if !rt.is_true(var_password) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_user_invalid_password'), rt.call_function('__', [
			rt.new_string('Passwords cannot be empty.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if rt.is_true(rt.call_function('str_contains', [var_password.clone(),
		rt.new_string('\\')]))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_user_invalid_password'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Passwords cannot contain the "%s" character.'),
			]),
			rt.new_string('\\'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	return var_password.clone()
}

fn (mut this Class_WP_REST_Users_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Users_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Users_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'user' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Unique identifier for the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'username', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Login name for the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'required', val: true },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
							'WP_REST_Controller',
						], &this) },
						rt.ArrayItem{ key: none, val: 'check_username' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Display name for the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
				]) },
			]) },
			rt.ArrayItem{ key: 'first_name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('First name for the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
				]) },
			]) },
			rt.ArrayItem{ key: 'last_name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Last name for the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
				]) },
			]) },
			rt.ArrayItem{ key: 'email', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The email address for the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'email' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'required', val: true },
			]) },
			rt.ArrayItem{ key: 'url', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('URL of the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'uri' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Description of the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'link', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Author URL of the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'uri' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'locale', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Locale for the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [
					rt.create_array([
						rt.ArrayItem{ key: none, val: '' },
						rt.ArrayItem{ key: none, val: 'en_US' },
					]),
					rt.call_function('get_available_languages', []rt.PhpVal{}),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'nickname', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The nickname for the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
				]) },
			]) },
			rt.ArrayItem{ key: 'slug', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('An alphanumeric identifier for the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
							'WP_REST_Controller',
						], &this) },
						rt.ArrayItem{ key: none, val: 'sanitize_slug' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'registered_date', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Registration date for the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'roles', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Roles assigned to the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'password', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Password for the user (never included).'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.new_array() },
				rt.ArrayItem{ key: 'required', val: true },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Users_Controller', [
							'WP_REST_Controller',
						], &this) },
						rt.ArrayItem{ key: none, val: 'check_user_password' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'capabilities', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('All capabilities assigned to the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'extra_capabilities', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Any extra capabilities assigned to the user.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	])
	if rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')])) {
		mut var_avatar_properties := rt.new_array()
		mut var_avatar_sizes := rt.call_function('rest_get_avatar_sizes', []rt.PhpVal{})
		mut iter_6 := var_avatar_sizes.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_size := item_6.val
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
		var_schema.array_get_mut('properties').array_set('avatar_urls', rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Avatar URLs for the user.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'embed' },
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'properties', val: var_avatar_properties },
		]))
	}
	var_schema.array_get_mut('properties').array_set('meta', rt.call_method(this.meta,
		'get_field_schema', []rt.PhpVal{}))
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Users_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Users_Controller) get_collection_params() rt.PhpVal {
	mut var_query_params := this.Class_WP_REST_Controller.get_collection_params()
	var_query_params.array_get_mut('context').array_set('default', 'view')
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
		rt.ArrayItem{ key: 'default', val: 'asc' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Order sort attribute ascending or descending.'),
		]) },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'asc' },
			rt.ArrayItem{ key: none, val: 'desc' },
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
	]))
	var_query_params.array_set('orderby', rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'name' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Sort collection by user attribute.'),
		]) },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'include' },
			rt.ArrayItem{ key: none, val: 'name' },
			rt.ArrayItem{ key: none, val: 'registered_date' },
			rt.ArrayItem{ key: none, val: 'slug' },
			rt.ArrayItem{ key: none, val: 'include_slugs' },
			rt.ArrayItem{ key: none, val: 'email' },
			rt.ArrayItem{ key: none, val: 'url' },
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
	]))
	var_query_params.array_set('slug', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to users with one or more specific slugs.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	]))
	var_query_params.array_set('roles', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to users matching at least one specific role provided. Accepts csv list or single role.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	]))
	var_query_params.array_set('capabilities', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to users matching at least one specific capability provided. Accepts csv list or single capability.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	]))
	var_query_params.array_set('who', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to users who are considered authors.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'authors' },
		]) },
	]))
	var_query_params.array_set('has_published_posts', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to users who have published posts.'),
		]) },
		rt.ArrayItem{ key: 'type', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'boolean' },
			rt.ArrayItem{ key: none, val: 'array' },
		]) },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'enum', val: rt.call_function('get_post_types', [
				rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
				rt.new_string('names'),
			]) },
		]) },
	]))
	var_query_params.array_set('search_columns', rt.create_array([
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Array of column names to be searched.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'enum', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'email' },
				rt.ArrayItem{ key: none, val: 'name' },
				rt.ArrayItem{ key: none, val: 'id' },
				rt.ArrayItem{ key: none, val: 'username' },
				rt.ArrayItem{ key: none, val: 'slug' },
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	]))
	return rt.call_function('apply_filters', [
		rt.new_string('rest_user_collection_params'),
		var_query_params.clone(),
	])
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

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_rest_users_controller() &Class_WP_REST_Users_Controller {
	mut obj := &Class_WP_REST_Users_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		meta:          rt.new_null()
		allow_batch:   rt.new_array()
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

fn create_wp_rest_user_meta_fields(_args ...rt.PhpVal) &Class_WP_REST_User_Meta_Fields {
	mut obj := &Class_WP_REST_User_Meta_Fields{
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

fn create_wp_user_query(_args ...rt.PhpVal) &Class_WP_User_Query {
	mut obj := &Class_WP_User_Query{
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
		else {
			return none
		}
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
		'meta' {
			this.meta = val
			return true
		}
		'allow_batch' {
			this.allow_batch = val
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
