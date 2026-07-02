import rt

struct Class_WC_REST_Customers_V1_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v1')
	rest_base rt.PhpVal = rt.new_string('customers')
}

fn (mut this Class_WC_REST_Customers_V1_Controller) register_routes() {
	rt.call_function('wp_prime_option_caches', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_registration_generate_username' },
			rt.ArrayItem{ key: none, val: 'woocommerce_registration_generate_password' },
		]),
	])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [
					this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()),
					rt.create_array([
						rt.ArrayItem{ key: 'email', val: rt.create_array([
							rt.ArrayItem{ key: 'required', val: true },
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('New user email address.'),
								rt.new_string('woocommerce'),
							]) },
						]) },
						rt.ArrayItem{ key: 'username', val: rt.create_array([
							rt.ArrayItem{ key: 'required', val: rt.identical(rt.new_string('no'), rt.call_function('get_option', [
								rt.new_string('woocommerce_registration_generate_username'),
								rt.new_string('yes'),
							])) },
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('New user username.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
						]) },
						rt.ArrayItem{ key: 'password', val: rt.create_array([
							rt.ArrayItem{ key: 'required', val: rt.identical(rt.new_string('no'), rt.call_function('get_option', [
								rt.new_string('woocommerce_registration_generate_password'),
								rt.new_string('no'),
							])) },
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('New user password.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
						]) },
					]),
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
						'WC_REST_Controller',
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
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
						'WC_REST_Controller',
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
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'force', val: rt.create_array([
						rt.ArrayItem{ key: 'default', val: false },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Required to be true, as resource does not support trashing.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'reassign', val: rt.create_array([
						rt.ArrayItem{ key: 'default', val: 0 },
						rt.ArrayItem{ key: 'type', val: 'integer' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('ID to reassign posts to.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/batch'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'batch_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_batch_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Customers_V1_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_user_permissions', [
		rt.new_string('read'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot list resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Customers_V1_Controller) allowed_roles() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_customer_allowed_roles'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'customer' },
			rt.ArrayItem{ key: none, val: 'subscriber' }]),
	])
}

fn (mut this Class_WC_REST_Customers_V1_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_user_permissions', [
		rt.new_string('create'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to create resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Customers_V1_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.new_bool(this.permissions_check(var_request_mutated.clone(), 'read', mut rt.cast_object_ptr[Class_WP_Error](create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
		rt.new_string('Sorry, you cannot view this resource.'),
		rt.new_string('woocommerce'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	])))))
}

fn (mut this Class_WC_REST_Customers_V1_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut var_permission_result := rt.new_bool(this.permissions_check(var_request_mutated.clone(),
		'edit', mut rt.cast_object_ptr[Class_WP_Error](create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [
		rt.new_string('Sorry, you are not allowed to edit this resource.'),
		rt.new_string('woocommerce'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	])))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permission_result))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_permission_result.clone()])) {
		return var_permission_result.to_bool()
	}
	mut var_allowed_roles := this.allowed_roles()
	mut var_id := rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64())
	mut var_customer := create_wc_customer(var_id.clone())
	if rt.is_true(var_customer)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_method(var_customer, 'get_role', []rt.PhpVal{}), var_allowed_roles.clone(), rt.new_bool(true)]))))) {
		mut var_non_editable_props := ['email', 'password']
		mut var_customer_prop := rt.create_array([
			rt.ArrayItem{ key: 'email', val: rt.call_method(var_customer, 'get_email',
				[]rt.PhpVal{}) },
		])
		for var_prop in var_non_editable_props {
			if var_request_mutated.array_isset(rt.new_string(prop))
				&& rt.is_true(rt.identical(rt.new_string('password'), rt.new_string(prop)))
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_request_mutated.array_get(rt.new_string(prop)), var_customer_prop.array_get(rt.new_string(prop)))))) {
				return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Sorry, %1$s cannot be updated via this endpoint for a user with role %2$s.'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string(prop),
					rt.call_method(var_customer, 'get_role', []rt.PhpVal{}),
				]), rt.create_array([
					rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
						[]rt.PhpVal{}) },
				]))).to_bool()
			}
		}
	}
	return true
}

fn (mut this Class_WC_REST_Customers_V1_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut var_permission_result := rt.new_bool(this.permissions_check(var_request_mutated.clone(),
		'delete', mut rt.cast_object_ptr[Class_WP_Error](create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [
		rt.new_string('Sorry, you are not allowed to delete this resource.'),
		rt.new_string('woocommerce'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
			[]rt.PhpVal{}) },
	])))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permission_result))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_permission_result.clone()])) {
		return var_permission_result.to_bool()
	}
	mut var_id := rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64())
	mut var_allowed_roles := this.allowed_roles()
	mut var_customer := create_wc_customer(var_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.call_method(var_customer, 'get_role', []rt.PhpVal{}),
		var_allowed_roles.clone(),
		rt.new_bool(true),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Sorry, users with %1$s role cannot be deleted via this endpoint. Allowed roles: %2$s'),
				rt.new_string('woocommerce'),
			]),
			rt.call_method(var_customer, 'get_role', []rt.PhpVal{}),
			rt.call_function('implode', [
				rt.new_string(', '),
				var_allowed_roles.clone(),
			]),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Customers_V1_Controller) batch_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_user_permissions', [
		rt.new_string('batch'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_batch'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to batch manipulate this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Customers_V1_Controller) permissions_check(var_request rt.PhpVal, context string, mut var_error_on_failure Class_WP_Error) bool {
	mut var_request_mutated := var_request
	mut context_mutated := context
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_0 :=
		iife_temp_0.get_user_in_current_site(var_request_mutated.array_get(rt.new_string('id')))
	mut var_user := iife_result_0
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		rt.call_method(var_user, 'add_data', [
			rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]),
		])
		return var_user.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_user_permissions', [
		rt.new_string(context_mutated).clone(),
		rt.get_property(var_user, 'ID'),
	])))))
	{
		return var_error_on_failure
	}
	return true
}

fn (mut this Class_WC_REST_Customers_V1_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_prepared_args := rt.new_array()
	var_prepared_args.array_set('exclude', var_request_mutated.array_get(rt.new_string('exclude')))
	var_prepared_args.array_set('include', var_request_mutated.array_get(rt.new_string('include')))
	var_prepared_args.array_set('order', var_request_mutated.array_get(rt.new_string('order')))
	var_prepared_args.array_set('number', var_request_mutated.array_get(rt.new_string('per_page')))
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('offset')))) {
		var_prepared_args.array_set('offset',
			var_request_mutated.array_get(rt.new_string('offset')))
	} else {
		var_prepared_args.array_set('offset', rt.mul(rt.sub(var_request_mutated.array_get(rt.new_string('page')),
			rt.new_int(1)), var_prepared_args.array_get(rt.new_string('number'))))
	}
	mut var_orderby_possibles := rt.create_array([rt.ArrayItem{ key: 'id', val: 'ID' },
		rt.ArrayItem{ key: 'include', val: 'include' }, rt.ArrayItem{
			key: 'name'
			val: 'display_name'
		}, rt.ArrayItem{ key: 'registered_date', val: 'registered' }])
	var_prepared_args.array_set('orderby',
		var_orderby_possibles.array_get(var_request_mutated.array_get(rt.new_string('orderby'))))
	var_prepared_args.array_set('search', var_request_mutated.array_get(rt.new_string('search')))
	if !(!rt.is_true(var_prepared_args.array_get(rt.new_string('search')))) {
		var_prepared_args.array_set('search', '*' +
			(var_prepared_args.array_get(rt.new_string('search'))).str() + '*')
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('email')))) {
		var_prepared_args.array_set('search', var_request_mutated.array_get(rt.new_string('email')))
		var_prepared_args.array_set('search_columns', rt.create_array([
			rt.ArrayItem{ key: none, val: 'user_email' },
		]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'),
		var_request_mutated.array_get(rt.new_string('role'))))))
	{
		var_prepared_args.array_set('role', var_request_mutated.array_get(rt.new_string('role')))
	}
	var_prepared_args = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_customer_query'),
		var_prepared_args.clone(),
		var_request_mutated.clone(),
	])
	mut var_query := create_wp_user_query(var_prepared_args.clone())
	mut var_users := rt.new_array()
	mut iter_1 := rt.get_property(var_query, 'results').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_user := item_1.val
		mut var_data := this.prepare_item_for_response(var_user.clone(),
			var_request_mutated.clone())
		var_users << this.prepare_response_for_collection(var_data.clone())
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		rt.create_array_from_list(var_users),
	])
	mut var_per_page := rt.new_int((var_prepared_args.array_get(rt.new_string('number'))).to_i64())
	mut var_page := rt.call_function('ceil', [
		rt.add(rt.div(rt.new_int((var_prepared_args.array_get(rt.new_string('offset'))).to_i64()),
			var_per_page), rt.new_int(1)),
	])
	var_prepared_args.array_set('fields', 'ID')
	mut var_total_users := var_query.get_total()
	if rt.is_true(rt.less(var_total_users, rt.new_int(1))) {
		var_prepared_args.array_unset(rt.new_string('number'))
		var_prepared_args.array_unset(rt.new_string('offset'))
		mut var_count_query := create_wp_user_query(var_prepared_args.clone())
		var_total_users = var_count_query.get_total()
	}
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int(var_total_users.to_i64())])
	mut var_max_pages := rt.call_function('ceil', [rt.div(var_total_users, var_per_page)])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int(var_max_pages.to_i64())])
	mut var_base := rt.call_function('add_query_arg', [
		rt.call_method(var_request_mutated, 'get_query_params', []rt.PhpVal{}),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base]),
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

fn (mut this Class_WC_REST_Customers_V1_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('id')))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_customer_exists'), rt.call_function('__', [
			rt.new_string('Cannot create existing resource.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_request_mutated.array_set('username', if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('username')))) {
		var_request_mutated.array_get(rt.new_string('username'))
	} else {
		rt.new_string('')
	})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_request_mutated.array_set('password', if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('password')))) {
		var_request_mutated.array_get(rt.new_string('password'))
	} else {
		rt.new_string('')
	})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_customer := create_wc_customer()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_customer, 'set_username', [
		var_request_mutated.array_get(rt.new_string('username')),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_customer, 'set_password', [
		var_request_mutated.array_get(rt.new_string('password')),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_customer, 'set_email',
		[var_request_mutated.array_get(rt.new_string('email'))])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.update_customer_meta_fields(var_customer.clone(), var_request_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_customer, 'save', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_id', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [
			rt.new_string('This resource cannot be created.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_user_data := rt.call_function('get_userdata', [
		rt.call_method(var_customer, 'get_id', []rt.PhpVal{}),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.update_additional_fields_for_object(var_user_data.clone(), var_request_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_insert_customer'),
		var_user_data.clone(), var_request_mutated.clone(), rt.new_bool(true)])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_response := this.prepare_item_for_response(var_user_data.clone(),
		var_request_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base,
				rt.call_method(var_customer, 'get_id', []rt.PhpVal{})]),
		])])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return var_response.clone()
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return rt.new_null()
}

fn (mut this Class_WC_REST_Customers_V1_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_1 :=
		iife_temp_1.get_user_in_current_site(var_request_mutated.array_get(rt.new_string('id')))
	mut var_user := iife_result_1
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		rt.call_method(var_user, 'add_data', [
			rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]),
		])
		return var_user.clone()
	}
	mut var_customer := this.prepare_item_for_response(var_user.clone(),
		var_request_mutated.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_customer.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Customers_V1_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_2 :=
		iife_temp_2.get_user_in_current_site(var_request_mutated.array_get(rt.new_string('id')))
	mut var_user := iife_result_2
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		mut var_id := rt.new_int(0)
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	} else {
		var_id = rt.get_property(var_user, 'ID')
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_customer := create_wc_customer(var_id.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_id', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid resource ID.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('email'))))
		&& rt.is_true(rt.call_function('email_exists', [var_request_mutated.array_get(rt.new_string('email'))]))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_request_mutated.array_get(rt.new_string('email')), rt.call_method(var_customer, 'get_email', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_customer_invalid_email'), rt.call_function('__', [
			rt.new_string('Email address is invalid.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('username'))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_request_mutated.array_get(rt.new_string('username')), rt.call_method(var_customer, 'get_username', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_customer_invalid_argument'), rt.call_function('__', [
			rt.new_string("Username isn't editable."),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if var_request_mutated.array_isset(rt.new_string('email')) {
		rt.call_method(var_customer, 'set_email', [
			rt.call_function('sanitize_email',
				[var_request_mutated.array_get(rt.new_string('email'))]),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if var_request_mutated.array_isset(rt.new_string('password')) {
		rt.call_method(var_customer, 'set_password', [
			var_request_mutated.array_get(rt.new_string('password')),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	this.update_customer_meta_fields(var_customer.clone(), var_request_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	rt.call_method(var_customer, 'save', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_user_data := rt.call_function('get_userdata', [
		rt.call_method(var_customer, 'get_id', []rt.PhpVal{}),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	this.update_additional_fields_for_object(var_user_data.clone(), var_request_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_member_of_blog', [
		rt.get_property(var_user_data, 'ID'),
	])))))
	{
		rt.call_method(var_user_data, 'add_role', [rt.new_string('customer')])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_insert_customer'),
		var_user_data.clone(), var_request_mutated.clone(), rt.new_bool(false)])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_response := this.prepare_item_for_response(var_user_data.clone(),
		var_request_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	return var_response.clone()
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	return rt.new_null()
}

fn (mut this Class_WC_REST_Customers_V1_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_id := rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64())
	mut var_reassign := if var_request_mutated.array_isset(rt.new_string('reassign')) { rt.call_function('absint', [
			var_request_mutated.array_get(rt.new_string('reassign')),
		]) } else { rt.new_null() }
	mut var_force := rt.new_bool(if var_request_mutated.array_isset(rt.new_string('force')) {
		(var_request_mutated.array_get(rt.new_string('force'))).to_bool()
	} else {
		false
	})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_force)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_trash_not_supported'), rt.call_function('__', [
			rt.new_string('Customers do not support trashing.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_3 := iife_temp_3.get_user_in_current_site(var_id.clone())
	mut var_user_data := iife_result_3
	if rt.is_true(rt.call_function('is_wp_error', [var_user_data.clone()])) {
		rt.call_method(var_user_data, 'add_data', [
			rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]),
		])
		return var_user_data.clone()
	}
	if !(!rt.is_true(var_reassign)) {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Utilities_Users{}
		mut iife_result_4 := iife_temp_4.get_user_in_current_site(var_reassign.clone())
		mut var_reassign_user := iife_result_4
		if rt.is_true(rt.identical(var_reassign, var_id))
			|| rt.is_true(rt.call_function('is_wp_error', [var_reassign_user.clone()])) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_customer_invalid_reassign'), rt.call_function('__', [
				rt.new_string('Invalid resource id for reassignment.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
	}
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_user_data.clone(),
		var_request_mutated.clone())
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/user.php', '4')
	mut var_customer := create_wc_customer(var_id.clone())
	if !(var_reassign.clone().is_null()) {
		mut var_result := rt.call_method(var_customer, 'delete_and_reassign', [
			var_reassign.clone(),
		])
	} else {
		var_result = rt.call_method(var_customer, 'delete', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('The resource cannot be deleted.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_delete_customer'),
		var_user_data.clone(), var_response.clone(), var_request_mutated.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Customers_V1_Controller) prepare_item_for_response(var_user_data rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_user_data_mutated := var_user_data
	mut var_request_mutated := var_request
	mut var_customer := create_wc_customer(rt.get_property(var_user_data_mutated, 'ID'))
	mut var__data := rt.call_method(var_customer, 'get_data', []rt.PhpVal{})
	mut var_last_order := rt.call_function('wc_get_customer_last_order', [
		rt.call_method(var_customer, 'get_id', []rt.PhpVal{}),
	])
	mut var_format_date := ['date_created', 'date_modified']
	for var_key in var_format_date {
		var__data.array_set(key, if rt.is_true(var__data.array_get(rt.new_string(key))) { rt.call_function('wc_rest_prepare_date_response', [
				var__data.array_get(rt.new_string(key)),
			]) } else { rt.new_null() })
	}
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'id', val: var__data.array_get(rt.new_string('id')) },
		rt.ArrayItem{ key: 'date_created', val: var__data.array_get(rt.new_string('date_created')) },
		rt.ArrayItem{ key: 'date_modified', val: var__data.array_get(rt.new_string('date_modified')) },
		rt.ArrayItem{ key: 'email', val: var__data.array_get(rt.new_string('email')) },
		rt.ArrayItem{ key: 'first_name', val: var__data.array_get(rt.new_string('first_name')) },
		rt.ArrayItem{ key: 'last_name', val: var__data.array_get(rt.new_string('last_name')) },
		rt.ArrayItem{ key: 'username', val: var__data.array_get(rt.new_string('username')) },
		rt.ArrayItem{ key: 'last_order', val: rt.create_array([
			rt.ArrayItem{
				key: 'id'
				val: if var_last_order.clone().is_object() {
					rt.call_method(var_last_order, 'get_id', []rt.PhpVal{})
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'date'
				val: if var_last_order.clone().is_object() { rt.call_function('wc_rest_prepare_date_response', [
						rt.call_method(var_last_order, 'get_date_created', []rt.PhpVal{}),
					]) } else { rt.new_null() }
			},
		]) },
		rt.ArrayItem{ key: 'orders_count', val: rt.call_method(var_customer, 'get_order_count',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'total_spent', val: rt.call_method(var_customer, 'get_total_spent',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'avatar_url', val: rt.call_method(var_customer, 'get_avatar_url',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'billing', val: var__data.array_get(rt.new_string('billing')) },
		rt.ArrayItem{ key: 'shipping', val: var__data.array_get(rt.new_string('shipping')) },
	])
	mut var_context := if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('context')))) {
		var_request_mutated.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request_mutated.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_links', [
		this.prepare_links(var_user_data_mutated.clone()),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_customer'),
		var_response.clone(),
		var_user_data_mutated.clone(),
		var_request_mutated.clone(),
	])
}

fn (mut this Class_WC_REST_Customers_V1_Controller) update_customer_meta_fields(var_customer rt.PhpVal, var_request rt.PhpVal) {
	mut var_customer_mutated := var_customer
	mut var_request_mutated := var_request
	mut var_schema := this.get_item_schema()
	if var_request_mutated.array_isset(rt.new_string('first_name')) {
		rt.call_method(var_customer_mutated, 'set_first_name', [
			rt.call_function('wc_clean',
				[var_request_mutated.array_get(rt.new_string('first_name'))]),
		])
	}
	if var_request_mutated.array_isset(rt.new_string('last_name')) {
		rt.call_method(var_customer_mutated, 'set_last_name', [
			rt.call_function('wc_clean',
				[var_request_mutated.array_get(rt.new_string('last_name'))]),
		])
	}
	if var_request_mutated.array_isset(rt.new_string('billing')) {
		mut iter_2 :=
			rt.func_array_keys(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('billing')).array_get(rt.new_string('properties'))).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_field := item_2.val
			if var_request_mutated.array_get(rt.new_string('billing')).array_isset(var_field)
				&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
				key: none
				val: var_customer_mutated
			}, rt.ArrayItem{ key: none, val: 'set_billing_${var_field.to_string()}' }])]) {
				rt.call_method(var_customer_mutated, 'set_billing_${var_field.to_string()}', [
					var_request_mutated.array_get(rt.new_string('billing')).array_get(var_field),
				])
			}
		}
	}
	if var_request_mutated.array_isset(rt.new_string('shipping')) {
		mut iter_3 :=
			rt.func_array_keys(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('shipping')).array_get(rt.new_string('properties'))).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_field := item_3.val
			if var_request_mutated.array_get(rt.new_string('shipping')).array_isset(var_field)
				&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
				key: none
				val: var_customer_mutated
			}, rt.ArrayItem{ key: none, val: 'set_shipping_${var_field.to_string()}' }])]) {
				rt.call_method(var_customer_mutated, 'set_shipping_${var_field.to_string()}', [
					var_request_mutated.array_get(rt.new_string('shipping')).array_get(var_field),
				])
			}
		}
	}
}

fn (mut this Class_WC_REST_Customers_V1_Controller) prepare_links(var_customer rt.PhpVal) rt.PhpVal {
	mut var_customer_mutated := var_customer
	mut var_links := {
		'self':       {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base,
					rt.get_property(var_customer_mutated, 'ID')]),
			])
		}
		'collection': {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf',
					[rt.new_string('/%s/%s'), this.namespace, this.rest_base]),
			])
		}
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_Customers_V1_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'customer' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Unique identifier for the resource.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'date_created', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The date the customer was created, as GMT.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'date_modified', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The date the customer was last modified, as GMT.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'email', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The email address for the customer.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'email' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'first_name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Customer first name.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
				]) },
			]) },
			rt.ArrayItem{ key: 'last_name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Customer last name.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
				]) },
			]) },
			rt.ArrayItem{ key: 'username', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Customer login name.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_user' },
				]) },
			]) },
			rt.ArrayItem{ key: 'password', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Customer password.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'last_order', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Last order data.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Last order ID.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'integer' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'date', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The date of the customer last order, as GMT.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'date-time' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'orders_count', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Quantity of orders made by the customer.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'total_spent', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Total amount spent.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'avatar_url', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Avatar URL.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'billing', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('List of billing address data.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'first_name', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('First name.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'last_name', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Last name.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'company', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Company name.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'address_1', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Address line 1.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'address_2', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Address line 2.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'city', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('City name.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('ISO code or name of the state, province or district.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Postal code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'country', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('ISO code of the country.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'email', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Email address.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'format', val: 'email' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'phone', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Phone number.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'shipping', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('List of shipping address data.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'first_name', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('First name.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'last_name', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Last name.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'company', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Company name.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'address_1', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Address line 1.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'address_2', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Address line 2.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'city', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('City name.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'state', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('ISO code or name of the state, province or district.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Postal code.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'country', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('ISO code of the country.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
				]) },
			]) },
		]) },
	])
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Customers_V1_Controller) get_role_names() rt.PhpVal {
	mut var_wp_roles := rt.new_null()
	return rt.func_array_keys(rt.get_property(var_wp_roles, 'role_names'))
}

fn (mut this Class_WC_REST_Customers_V1_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_Controller.get_collection_params()
	var_params.array_get_mut('context').array_set('default', 'view')
	var_params.array_set('exclude', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Ensure result set excludes specific IDs.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
	]))
	var_params.array_set('include', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to specific IDs.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
	]))
	var_params.array_set('offset', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Offset the result set by a specific number of items.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('order', rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'asc' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Order sort attribute ascending or descending.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'asc' },
			rt.ArrayItem{ key: none, val: 'desc' },
		]) },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('orderby', rt.create_array([
		rt.ArrayItem{ key: 'default', val: 'name' },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Sort collection by object attribute.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'include' },
			rt.ArrayItem{ key: none, val: 'name' },
			rt.ArrayItem{ key: none, val: 'registered_date' },
		]) },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('email', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to resources with a specific email.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'email' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('role', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to resources with a specific role.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'customer' },
		rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'all' }]),
			this.get_role_names(),
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

struct Class_WP_User_Query {
	rt.PhpObjectBase
}

struct Class_WC_REST_Exception {
	rt.PhpObjectBase
}

fn create_wc_rest_customers_v1_controller(_args ...rt.PhpVal) &Class_WC_REST_Customers_V1_Controller {
	mut obj := &Class_WC_REST_Customers_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v1')
		rest_base:     rt.new_string('customers')
	}
	return obj
}

fn create_wc_rest_controller(_args ...rt.PhpVal) &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
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

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
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

fn create_wc_rest_exception(_args ...rt.PhpVal) &Class_WC_REST_Exception {
	mut obj := &Class_WC_REST_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Customers_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'allowed_roles' {
			return this.allowed_roles()
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.create_item_permissions_check(dispatch_arg_0))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
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
		'permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WP_Error](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.permissions_check(dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2))
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
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'update_customer_meta_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_customer_meta_fields(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_role_names' {
			return this.get_role_names()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Customers_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Customers_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_REST_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
