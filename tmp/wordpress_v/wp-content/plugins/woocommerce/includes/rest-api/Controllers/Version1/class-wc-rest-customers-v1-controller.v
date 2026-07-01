import rt

struct Class_WC_REST_Customers_V1_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v1')
		rest_base rt.PhpVal = rt.new_string('customers')
}

fn (mut this Class_WC_REST_Customers_V1_Controller) register_routes()  {
	rt.call_function('wp_prime_option_caches', [rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_registration_generate_username' }, rt.ArrayItem{ key: none, val: 'woocommerce_registration_generate_password' }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()), rt.create_array([rt.ArrayItem{ key: 'email', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('New user email address.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'username', val: rt.create_array([rt.ArrayItem{ key: 'required', val: rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_registration_generate_username'), rt.new_string('yes')])) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('New user username.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'password', val: rt.create_array([rt.ArrayItem{ key: 'required', val: rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_registration_generate_password'), rt.new_string('no')])) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('New user password.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }])]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Required to be true, as resource does not support trashing.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'reassign', val: rt.create_array([rt.ArrayItem{ key: 'default', val: 0 }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('ID to reassign posts to.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/batch', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Customers_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
}

fn (mut this Class_WC_REST_Customers_V1_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_user_permissions', [rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Customers_V1_Controller) allowed_roles() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_customer_allowed_roles'), rt.create_array([rt.ArrayItem{ key: none, val: 'customer' }, rt.ArrayItem{ key: none, val: 'subscriber' }])])
}

fn (mut this Class_WC_REST_Customers_V1_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_user_permissions', [rt.new_string('create')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Customers_V1_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.new_bool(this.permissions_check(var_request_mutated.dup(), 'read', mut rt.cast_object_ptr[Class_WP_Error](create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))))
}

fn (mut this Class_WC_REST_Customers_V1_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut var_permission_result := rt.new_bool(this.permissions_check(var_request_mutated.dup(), 'edit', mut rt.cast_object_ptr[Class_WP_Error](create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_permission_result)))) || rt.is_true(rt.call_function('is_wp_error', [var_permission_result.dup()])))) {
		return (var_permission_result).to_bool()
	}
	mut var_allowed_roles := this.allowed_roles()
	mut var_id := // unsupported expression: Expr_Cast_Int
	mut var_customer := create_wc_customer(var_id.dup())
	if rt.is_true(rt.new_bool(rt.is_true(var_customer) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_method(var_customer, 'get_role', []rt.PhpVal{}), var_allowed_roles.dup(), rt.new_bool(true)]))))))) {
		mut var_non_editable_props := ['email', 'password']
		mut var_customer_prop := rt.create_array([rt.ArrayItem{ key: 'email', val: rt.call_method(var_customer, 'get_email', []rt.PhpVal{}) }])
		for var_prop in var_non_editable_props {
			if rt.is_true(rt.new_bool(var_request_mutated.array_isset(rt.new_string(prop)) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('password'), rt.new_string(prop))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
				return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sorry, %1$s cannot be updated via this endpoint for a user with role %2$s.'), rt.new_string('woocommerce')]), rt.new_string(prop), rt.call_method(var_customer, 'get_role', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
			}
		}
	}
	return true
}

fn (mut this Class_WC_REST_Customers_V1_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut var_permission_result := rt.new_bool(this.permissions_check(var_request_mutated.dup(), 'delete', mut rt.cast_object_ptr[Class_WP_Error](create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }])))))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_permission_result)))) || rt.is_true(rt.call_function('is_wp_error', [var_permission_result.dup()])))) {
		return (var_permission_result).to_bool()
	}
	mut var_id := // unsupported expression: Expr_Cast_Int
	mut var_allowed_roles := this.allowed_roles()
	mut var_customer := create_wc_customer(var_id.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_method(var_customer, 'get_role', []rt.PhpVal{}), var_allowed_roles.dup(), rt.new_bool(true)]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sorry, users with %1$s role cannot be deleted via this endpoint. Allowed roles: %2$s'), rt.new_string('woocommerce')]), rt.call_method(var_customer, 'get_role', []rt.PhpVal{}), rt.call_function('implode', [rt.new_string(', '), var_allowed_roles.dup()])]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Customers_V1_Controller) batch_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_user_permissions', [rt.new_string('batch')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_batch'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to batch manipulate this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Customers_V1_Controller) permissions_check(var_request rt.PhpVal, context string, mut var_error_on_failure Class_WP_Error) bool {
	mut var_request_mutated := var_request
	mut context_mutated := context
	mut var_user := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.get_user_in_current_site(arg_0) }(var_request_mutated.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_user.dup()])) {
		rt.call_method(var_user, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])])
		return (var_user).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_user_permissions', [rt.new_string(context_mutated).dup(), rt.get_property(var_user, 'ID')]))))) {
		return var_error_on_failure
	}
	return true
}

fn (mut this Class_WC_REST_Customers_V1_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_prepared_args := rt.new_array()
	var_prepared_args.array_set('exclude', var_request_mutated.array_get('exclude'))
	var_prepared_args.array_set('include', var_request_mutated.array_get('include'))
	var_prepared_args.array_set('order', var_request_mutated.array_get('order'))
	var_prepared_args.array_set('number', var_request_mutated.array_get('per_page'))
	if !(!rt.is_true(var_request_mutated.array_get('offset'))) {
		var_prepared_args.array_set('offset', var_request_mutated.array_get('offset'))
	} else {
		var_prepared_args.array_set('offset', rt.mul(rt.sub(var_request_mutated.array_get('page'), rt.new_int(1)), var_prepared_args.array_get('number')))
	}
	mut var_orderby_possibles := rt.create_array([rt.ArrayItem{ key: 'id', val: 'ID' }, rt.ArrayItem{ key: 'include', val: 'include' }, rt.ArrayItem{ key: 'name', val: 'display_name' }, rt.ArrayItem{ key: 'registered_date', val: 'registered' }])
	var_prepared_args.array_set('orderby', var_orderby_possibles.array_get(var_request_mutated.array_get('orderby')))
	var_prepared_args.array_set('search', var_request_mutated.array_get('search'))
	if !(!rt.is_true(var_prepared_args.array_get('search'))) {
		var_prepared_args.array_set('search', '*' + (var_prepared_args.array_get('search')).str() + '*')
	}
	if !(!rt.is_true(var_request_mutated.array_get('email'))) {
		var_prepared_args.array_set('search', var_request_mutated.array_get('email'))
		var_prepared_args.array_set('search_columns', rt.create_array([rt.ArrayItem{ key: none, val: 'user_email' }]))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_prepared_args.array_set('role', var_request_mutated.array_get('role'))
	}
	var_prepared_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_customer_query'), var_prepared_args.dup(), var_request_mutated.dup()])
	mut var_query := create_wp_user_query(var_prepared_args.dup())
	mut var_users := rt.new_array()
	{
		mut iter_1 := rt.get_property(var_query, 'results').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_user := item_1.val
			mut var_data := this.prepare_item_for_response(var_user.dup(), var_request_mutated.dup())
			var_users << this.prepare_response_for_collection(var_data.dup())
		}
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_users.dup()])
	mut var_per_page := // unsupported expression: Expr_Cast_Int
	mut var_page := rt.call_function('ceil', [rt.add(rt.div(// unsupported expression: Expr_Cast_Int, var_per_page), rt.new_int(1))])
	var_prepared_args.array_set('fields', 'ID')
	mut var_total_users := var_query.get_total()
	if rt.is_true(rt.less(var_total_users, rt.new_int(1))) {
		var_prepared_args.array_unset(rt.new_string('number'))
		var_prepared_args.array_unset(rt.new_string('offset'))
		mut var_count_query := create_wp_user_query(var_prepared_args.dup())
		var_total_users = var_count_query.get_total()
	}
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), // unsupported expression: Expr_Cast_Int])
	mut var_max_pages := rt.call_function('ceil', [rt.div(var_total_users, var_per_page)])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), // unsupported expression: Expr_Cast_Int])
	mut var_base := rt.call_function('add_query_arg', [rt.call_method(var_request_mutated, 'get_query_params', []rt.PhpVal{}), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base])])])
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

fn (mut this Class_WC_REST_Customers_V1_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if !(!rt.is_true(var_request_mutated.array_get('id'))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_customer_exists'), rt.call_function('__', [rt.new_string('Cannot create existing resource.'), rt.new_string('woocommerce')]), rt.new_int(400))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_request_mutated.array_set('username', if !(!rt.is_true(var_request_mutated.array_get('username'))) { var_request_mutated.array_get('username') } else { rt.new_string('') })
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_request_mutated.array_set('password', if !(!rt.is_true(var_request_mutated.array_get('password'))) { var_request_mutated.array_get('password') } else { rt.new_string('') })
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_customer := create_wc_customer()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_customer, 'set_username', [var_request_mutated.array_get('username')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_customer, 'set_password', [var_request_mutated.array_get('password')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_customer, 'set_email', [var_request_mutated.array_get('email')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.update_customer_meta_fields(var_customer.dup(), var_request_mutated.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_customer, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_id', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('WC_REST_Exception', []string{}, create_wc_rest_exception(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [rt.new_string('This resource cannot be created.'), rt.new_string('woocommerce')]), rt.new_int(400))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_user_data := rt.call_function('get_userdata', [rt.call_method(var_customer, 'get_id', []rt.PhpVal{})])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	this.update_additional_fields_for_object(var_user_data.dup(), var_request_mutated.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_insert_customer'), var_user_data.dup(), var_request_mutated.dup(), rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_response := this.prepare_item_for_response(var_user_data.dup(), var_request_mutated.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [, , , ])])])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return var_response.dup()
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return create_wp_error(, , )
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_WC_REST_Customers_V1_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	
}

fn (mut this Class_WC_REST_Customers_V1_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.new_null()
}

fn (mut this Class_WC_REST_Customers_V1_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Customers_V1_Controller) prepare_item_for_response(var_user_data rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_user_data_mutated := var_user_data
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Customers_V1_Controller) update_customer_meta_fields(var_customer rt.PhpVal, var_request rt.PhpVal)  {
	mut var_customer_mutated := var_customer
	mut var_request_mutated := var_request
}

fn (mut this Class_WC_REST_Customers_V1_Controller) prepare_links(var_customer rt.PhpVal) rt.PhpVal {
	mut var_customer_mutated := var_customer
}

fn (mut this Class_WC_REST_Customers_V1_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WC_REST_Customers_V1_Controller) get_role_names() rt.PhpVal {
	mut var_wp_roles := rt.new_null()
}

fn (mut this Class_WC_REST_Customers_V1_Controller) get_collection_params() rt.PhpVal {
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

fn create_wc_rest_customers_v1_controller() &Class_WC_REST_Customers_V1_Controller {
	mut obj := &Class_WC_REST_Customers_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v1')
		rest_base: rt.new_string('customers')
	}
	return obj
}

fn create_wc_rest_controller() &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
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

fn create_wc_customer() &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_users() &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
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

fn create_wc_rest_exception() &Class_WC_REST_Exception {
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
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WP_Error](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.permissions_check(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
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
		else { return none }
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
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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



pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version1_class_wc_rest_customers_v1_controller_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
