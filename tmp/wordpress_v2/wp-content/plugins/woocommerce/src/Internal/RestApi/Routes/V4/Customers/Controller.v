import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base        rt.PhpVal = rt.new_string('customers')
	item_schema      rt.PhpVal = rt.new_null()
	collection_query rt.PhpVal = rt.new_null()
	update_utils     rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) init(mut var_item_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema, mut var_collection_query Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CollectionQuery, mut var_update_utils Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_UpdateUtils) {
	this.item_schema = var_item_schema
	this.collection_query = var_collection_query
	this.update_utils = var_update_utils
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) get_schema() rt.PhpVal {
	return rt.call_method(this.item_schema, 'get_item_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) get_query_schema() rt.PhpVal {
	return rt.call_method(this.collection_query, 'get_query_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
			'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
					'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
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
							rt.ArrayItem{ key: 'required', val: false },
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('New user username. Generated from email if not provided.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
						]) },
						rt.ArrayItem{ key: 'password', val: rt.create_array([
							rt.ArrayItem{ key: 'required', val: false },
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('New user password. Generated automatically if not provided.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'type', val: 'string' },
						]) },
					]),
				]) },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
			'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
					'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
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
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
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
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
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
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
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
				]) },
			]) },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_0 :=
		iife_temp_0.get_user_in_current_site(var_request_mutated.array_get(rt.new_string('id')))
	mut var_user := iife_result_0
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller.invalid_id())
	}
	mut var_customer := this.prepare_item_for_response(create_wc_customer(rt.get_property(var_user, 'ID')),
		var_request_mutated.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_customer.clone()])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) get_item_response(var_customer rt.PhpVal, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_customer_mutated := var_customer
	mut var_request_mutated := var_request
	return rt.call_method(this.item_schema, 'get_item_response', [
		var_customer_mutated.clone(), var_request_mutated,
		this.get_fields_for_response(rt.new_object('WP_REST_Request',
			[]string{}, var_request_mutated))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_query_args := rt.call_method(this.collection_query, 'get_query_args', [
		var_request_mutated.clone(),
	])
	mut var_results := rt.call_method(this.collection_query, 'get_query_results', [
		var_query_args.clone(),
		var_request_mutated.clone(),
	])
	mut var_items := rt.new_array()
	mut iter_1 := var_results.array_get(rt.new_string('results')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_customer := item_1.val
		var_items.array_push(this.prepare_response_for_collection(this.prepare_item_for_response(var_customer.clone(),
			var_request_mutated.clone())))
	}
	mut var_pagination_util := create_automattic_woocommerce_storeapi_utilities_pagination()
	mut var_response := var_pagination_util.add_headers(rt.call_function('rest_ensure_response', [
		var_items.clone(),
	]), var_request_mutated.clone(), var_results.array_get(rt.new_string('total')),
		var_results.array_get(rt.new_string('pages')))
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('id')))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller.resource_exists())
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
	rt.call_method(this.update_utils, 'update_customer_from_request', [
		var_customer.clone(), var_request_mutated.clone(), rt.new_bool(true)])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_id', []rt.PhpVal{}))))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller.cannot_create())
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
	rt.call_function('do_action', [
		rt.new_string((this.get_hook_prefix()).str() + 'created'),
		var_user_data.clone(),
		var_request_mutated.clone(),
	])
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
	mut var_response := this.prepare_item_for_response(var_customer.clone(),
		var_request_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_response, 'set_status', [Class_WP_Http.created()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'),
				rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller', [
					'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
				], &this), 'namespace'),
				this.rest_base, rt.call_method(var_customer, 'get_id', []rt.PhpVal{})]),
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
	if rt.instance_of(var_e_1,
		'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_WC_REST_Exception')
	{
		mut var_e := var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
		unsafe {
			goto end_label_1
		}
	} else if rt.instance_of(var_e_1,
		'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Exception')
	{
		var_e = var_e_1.clone()
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller.cannot_create())
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_1 :=
		iife_temp_1.get_user_in_current_site(var_request_mutated.array_get(rt.new_string('id')))
	mut var_user := iife_result_1
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller.invalid_id())
	}
	mut var_customer := create_wc_customer(rt.get_property(var_user, 'ID'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_id', []rt.PhpVal{}))))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller.invalid_id())
	}
	rt.call_method(this.update_utils, 'update_customer_from_request', [
		var_customer.clone(), var_request_mutated.clone(), rt.new_bool(false)])
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
	rt.call_function('do_action', [
		rt.new_string((this.get_hook_prefix()).str() + 'updated'),
		var_user_data.clone(),
		var_request_mutated.clone(),
	])
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
	return this.prepare_item_for_response(var_customer.clone(), var_request_mutated.clone())
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2,
		'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_WC_REST_Exception')
	{
		mut var_e := var_e_2.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
		unsafe {
			goto end_label_2
		}
	} else if rt.instance_of(var_e_2,
		'Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Exception')
	{
		var_e = var_e_2.clone()
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller.cannot_update())
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_id := rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64())
	mut var_force := rt.new_bool(if var_request_mutated.array_isset(rt.new_string('force')) {
		(var_request_mutated.array_get(rt.new_string('force'))).to_bool()
	} else {
		false
	})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_force)))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller.trash_not_supported())
	}
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_2 := iife_temp_2.get_user_in_current_site(var_id.clone())
	mut var_user_data := iife_result_2
	if rt.is_true(rt.call_function('is_wp_error', [var_user_data.clone()])) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller.invalid_id())
	}
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(create_wc_customer(var_id.clone()),
		var_request_mutated.clone())
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/user.php', '4')
	mut var_customer := create_wc_customer(var_id.clone())
	mut var_result := rt.call_method(var_customer, 'delete', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller.cannot_delete())
	}
	rt.call_function('do_action', [
		rt.new_string((this.get_hook_prefix()).str() + 'deleted'),
		var_user_data.clone(),
		var_response.clone(),
		var_request_mutated.clone(),
	])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_user_permissions', [
		rt.new_string('read'),
	])))))
	{
		return (this.get_authentication_error_by_method(rt.call_method(var_request_mutated,
			'get_method', []rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut iife_temp_3 :=
		Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_3 :=
		iife_temp_3.get_user_in_current_site(var_request_mutated.array_get(rt.new_string('id')))
	mut var_user := iife_result_3
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return (this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller.invalid_id())).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_user_permissions', [
		rt.new_string('read'),
		rt.get_property(var_user, 'ID'),
	])))))
	{
		return (this.get_authentication_error_by_method(rt.call_method(var_request_mutated,
			'get_method', []rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_user_permissions', [
		rt.new_string('create'),
	])))))
	{
		return (this.get_authentication_error_by_method(rt.call_method(var_request_mutated,
			'get_method', []rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut iife_temp_4 :=
		Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_4 :=
		iife_temp_4.get_user_in_current_site(var_request_mutated.array_get(rt.new_string('id')))
	mut var_user := iife_result_4
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return (this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller.invalid_id())).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_user_permissions', [
		rt.new_string('edit'),
		rt.get_property(var_user, 'ID'),
	])))))
	{
		return (this.get_authentication_error_by_method(rt.call_method(var_request_mutated,
			'get_method', []rt.PhpVal{}))).to_bool()
	}
	mut var_allowed_roles := this.get_allowed_roles()
	mut var_customer := create_wc_customer(rt.get_property(var_user, 'ID'))
	if rt.is_true(var_customer)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_method(var_customer, 'get_role', []rt.PhpVal{}), var_allowed_roles.clone(), rt.new_bool(true)]))))) {
		mut var_non_editable_props := rt.create_array([
			rt.ArrayItem{ key: none, val: 'email' },
			rt.ArrayItem{ key: none, val: 'password' },
		])
		mut var_customer_prop := rt.create_array([
			rt.ArrayItem{ key: 'email', val: rt.call_method(var_customer, 'get_email',
				[]rt.PhpVal{}) },
		])
		mut iter_2 := var_non_editable_props.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_prop := item_2.val
			if var_request_mutated.array_isset(var_prop)
				&& rt.is_true(rt.identical(rt.new_string('password'), var_prop))
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_request_mutated.array_get(var_prop), var_customer_prop.array_get(var_prop))))) {
				return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Sorry, %1$s cannot be updated via this endpoint for a user with role %2$s.'),
						rt.new_string('woocommerce'),
					]),
					var_prop.clone(),
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut iife_temp_5 :=
		Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_Utilities_Users{}
	mut iife_result_5 :=
		iife_temp_5.get_user_in_current_site(var_request_mutated.array_get(rt.new_string('id')))
	mut var_user := iife_result_5
	if rt.is_true(rt.call_function('is_wp_error', [var_user.clone()])) {
		return (this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller.invalid_id())).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_user_permissions', [
		rt.new_string('delete'),
		rt.get_property(var_user, 'ID'),
	])))))
	{
		return (this.get_authentication_error_by_method(rt.call_method(var_request_mutated,
			'get_method', []rt.PhpVal{}))).to_bool()
	}
	mut var_id := rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64())
	mut var_allowed_roles := this.get_allowed_roles()
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) get_allowed_roles() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_customer_allowed_roles'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'customer' },
			rt.ArrayItem{ key: none, val: 'subscriber' }]),
	])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_customers_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller{
		PhpObjectBase:    rt.PhpObjectBase{}
		rest_base:        rt.new_string('customers')
		item_schema:      rt.new_null()
		collection_query: rt.new_null()
		update_utils:     rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_customers_automattic_woocommerce_internal_utilities_users(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_Utilities_Users{
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

fn create_automattic_woocommerce_storeapi_utilities_pagination(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CustomerSchema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_CollectionQuery](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_UpdateUtils](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'get_schema' {
			return this.get_schema()
		}
		'get_query_schema' {
			return this.get_query_schema()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.create_item_permissions_check(dispatch_arg_0))
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_item_permissions_check(dispatch_arg_0))
		}
		'get_allowed_roles' {
			return this.get_allowed_roles()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'item_schema' { return this.item_schema }
		'collection_query' { return this.collection_query }
		'update_utils' { return this.update_utils }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' {
			this.rest_base = val
			return true
		}
		'item_schema' {
			this.item_schema = val
			return true
		}
		'collection_query' {
			this.collection_query = val
			return true
		}
		'update_utils' {
			this.update_utils = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Customers_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
