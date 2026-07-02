import rt

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController {
	rt.PhpObjectBase
pub mut:
		route_namespace rt.PhpVal = rt.new_string('wc-push-notifications')
		rest_base rt.PhpVal = rt.new_string('push-tokens')
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) get_rest_api_namespace() string {
	return (this.route_namespace).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) register_routes() {
	mut var_request := rt.new_null()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('index'))
		}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('create'))
		}
	rt.call_function('register_rest_route', [rt.new_string(this.get_rest_api_namespace()), this.rest_base, rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'authorize_as_from_wpcom' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'page', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Current page of the collection.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 1 }, rt.ArrayItem{ key: 'minimum', val: 1 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }, rt.ArrayItem{ key: 'per_page', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Maximum number of items to be returned in result set.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 10 }, rt.ArrayItem{ key: 'minimum', val: 1 }, rt.ArrayItem{ key: 'maximum', val: 100 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args(mut 'create') }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'authorize_as_authenticated' }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'get_schema' }]) }]) }])])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_request := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.run(var_request.clone(), rt.new_string('delete'))
		}
	rt.call_function('register_rest_route', [rt.new_string(this.get_rest_api_namespace()), rt.new_string((this.rest_base).str() + '/(?P<id>[\\d]+)'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_3_fn) }, rt.ArrayItem{ key: 'args', val: this.get_args(mut 'delete') }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'authorize_as_authenticated' }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'get_schema' }]) }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) index(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_token := rt.new_null()
	mut var_page := rt.new_int((var_request.get_param(rt.new_string('page'))).to_i64())
	mut var_per_page := rt.new_int((var_request.get_param(rt.new_string('per_page'))).to_i64())
	mut var_result := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore.class()]), 'get_tokens_for_roles', [Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.roles_with_push_notifications_enabled(), var_page.clone(), var_per_page.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		return mut rt.cast_object_ptr[Class_WP_REST_Response](this.convert_exception_to_wp_error(mut rt.cast_object_ptr[Class_Exception](var_e)))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_token := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_token, 'to_wpcom_format', []rt.PhpVal{})
		}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_token := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_token, 'to_wpcom_format', []rt.PhpVal{})
		}
	mut var_response := create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'tokens', val: rt.call_function('array_map', [rt.new_closure(closure_4_fn), var_result.array_get(rt.new_string('tokens'))]) }]), Class_WP_Http.ok())
	var_response.header(rt.new_string('X-WP-Total'), rt.new_string((var_result.array_get(rt.new_string('total'))).str()))
	var_response.header(rt.new_string('X-WP-TotalPages'), rt.new_string((var_result.array_get(rt.new_string('total_pages'))).str()))
	return mut var_response
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) create(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'user_id', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'token', val: var_request.get_param(rt.new_string('token')) }, rt.ArrayItem{ key: 'platform', val: var_request.get_param(rt.new_string('platform')) }, rt.ArrayItem{ key: 'device_uuid', val: var_request.get_param(rt.new_string('device_uuid')) }, rt.ArrayItem{ key: 'origin', val: var_request.get_param(rt.new_string('origin')) }, rt.ArrayItem{ key: 'device_locale', val: var_request.get_param(rt.new_string('device_locale')) }, rt.ArrayItem{ key: 'metadata', val: if !(var_request.get_param(rt.new_string('metadata'))).is_null() { var_request.get_param(rt.new_string('metadata')) } else { rt.new_array() } }])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_data_store := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore.class()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_push_token := rt.call_method(var_data_store, 'get_by_token_or_device_id', [var_data.clone()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(var_push_token) {
		rt.call_method(var_push_token, 'set_token', [var_data.array_get(rt.new_string('token'))])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		rt.call_method(var_push_token, 'set_device_uuid', [var_data.array_get(rt.new_string('device_uuid'))])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		rt.call_method(var_push_token, 'set_device_locale', [var_data.array_get(rt.new_string('device_locale'))])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		rt.call_method(var_push_token, 'set_metadata', [var_data.array_get(rt.new_string('metadata'))])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		rt.call_method(var_data_store, 'update', [var_push_token.clone()])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	} else {
		var_push_token = rt.call_method(var_data_store, 'create', [var_data.clone()])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		return this.convert_exception_to_wp_error(mut rt.cast_object_ptr[Class_Exception](var_e))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_push_token, 'get_id', []rt.PhpVal{}) }]), Class_WP_Http.created()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) delete(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_id := rt.new_int((var_request.get_param(rt.new_string('id'))).to_i64())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_data_store := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_PushNotifications_DataStores_PushTokensDataStore.class()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_push_token := rt.call_method(var_data_store, 'read', [var_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_push_token, 'get_user_id', []rt.PhpVal{}), rt.call_function('get_current_user_id', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException', []string{}, create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokennotfoundexception()))
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_deleted := rt.call_method(var_data_store, 'delete', [var_id.clone()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_deleted)))) {
		rt.throw_exception(rt.new_object('WC_Data_Exception', []string{}, create_wc_data_exception(rt.new_string('woocommerce_push_token_not_deleted'), rt.new_string('The push token could not be deleted.'), Class_WP_Http.internal_server_error())))
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.clone()
		return this.convert_exception_to_wp_error(mut rt.cast_object_ptr[Class_Exception](var_e))
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.new_null(), Class_WP_Http.no_content()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) validate_argument(var_value rt.PhpVal, mut var_request Class_WP_REST_Request, param string) rt.PhpVal {
	mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator{}
	mut iife_result_5 := iife_temp_5.validate(var_request.get_params(), rt.create_array([rt.ArrayItem{ key: none, val: param }]))
	return iife_result_5
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) get_schema() rt.PhpVal {
	mut var_item := rt.new_null()
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('array_intersect_key', [var_item.clone(), rt.create_array([rt.ArrayItem{ key: 'description', val: rt.new_null() }, rt.ArrayItem{ key: 'type', val: rt.new_null() }, rt.ArrayItem{ key: 'enum', val: rt.new_null() }, rt.ArrayItem{ key: 'minimum', val: rt.new_null() }, rt.ArrayItem{ key: 'default', val: rt.new_null() }, rt.ArrayItem{ key: 'required', val: rt.new_null() }])])
		}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('array_intersect_key', [var_item.clone(), rt.create_array([rt.ArrayItem{ key: 'description', val: rt.new_null() }, rt.ArrayItem{ key: 'type', val: rt.new_null() }, rt.ArrayItem{ key: 'enum', val: rt.new_null() }, rt.ArrayItem{ key: 'minimum', val: rt.new_null() }, rt.ArrayItem{ key: 'default', val: rt.new_null() }, rt.ArrayItem{ key: 'required', val: rt.new_null() }])])
		}
	return rt.call_function('array_merge', [this.get_base_schema(), rt.create_array([rt.ArrayItem{ key: 'title', val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.post_type() }, rt.ArrayItem{ key: 'properties', val: rt.call_function('array_map', [rt.new_closure(closure_7_fn), this.get_args(rt.new_null())]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) authorize_as_authenticated(mut var_request Class_WP_REST_Request) bool {
	mut var_role := rt.new_null()
	mut var_carry := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_current_user_id', []rt.PhpVal{}))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to do that.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.class()]), 'should_be_enabled', []rt.PhpVal{}))))) {
		return false
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_carry := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_role := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return if rt.is_true(rt.identical(this.check_permission(rt.new_object('WP_REST_Request', []string{}, var_request), var_role.clone()), rt.new_bool(true))) { rt.new_bool(true) } else { var_carry }
		}
	mut var_has_valid_role := rt.call_function('array_reduce', [Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.roles_with_push_notifications_enabled(), rt.new_closure(closure_9_fn), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_valid_role)))) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) authorize_as_from_wpcom(mut var_request Class_WP_REST_Request) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.class()]), 'should_be_enabled', []rt.PhpVal{}))))) {
		return false
	}
	mut iife_temp_9 := Class_Automattic_Jetpack_Connection_Rest_Authentication{}
	mut iife_result_9 := iife_temp_9.is_signed_with_blog_token()
	if rt.is_true(rt.call_function('class_exists', [Class_Automattic_Jetpack_Connection_Rest_Authentication.class()])) && rt.is_true(iife_result_9) {
		return true
	}
	return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to do that.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) convert_exception_to_wp_error(mut var_e Class_Exception) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Exception', []string{}, var_e), 'WC_Data_Exception'))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_e.getcode(), Class_WP_Http.internal_server_error())))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(var_e.geterrorcode(), var_e.getmessage(), var_e.geterrordata()))
	}
	rt.call_method(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()]), 'call_function', [rt.new_string('wc_get_logger')]), 'error', [rt.new_string((var_e.getmessage()).str()), rt.create_array([rt.ArrayItem{ key: 'source', val: Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.feature_name() }])])
	return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_internal_error'), rt.new_string('Internal server error'), rt.create_array([rt.ArrayItem{ key: 'status', val: Class_WP_Http.internal_server_error() }])))
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) get_args(mut var_context Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_?string) rt.PhpVal {
	mut var_arg := rt.new_null()
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Push Token ID'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'delete' }]) }, rt.ArrayItem{ key: 'minimum', val: 1 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'validate_argument' }]) }]) }, rt.ArrayItem{ key: 'origin', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Origin'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'create' }]) }, rt.ArrayItem{ key: 'enum', val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.origins() }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'validate_argument' }]) }]) }, rt.ArrayItem{ key: 'device_uuid', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Device UUID'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'create' }]) }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'validate_argument' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }, rt.ArrayItem{ key: 'device_locale', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Device Locale'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'create' }]) }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'validate_argument' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }, rt.ArrayItem{ key: 'platform', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Platform'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'create' }]) }, rt.ArrayItem{ key: 'enum', val: Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.platforms() }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'validate_argument' }]) }]) }, rt.ArrayItem{ key: 'token', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Push Token'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'create' }]) }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'validate_argument' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_unslash' }]) }, rt.ArrayItem{ key: 'metadata', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Metadata'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'create' }]) }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController', ['Automattic_WooCommerce_Internal_RestApiControllerBase'], &this) }, rt.ArrayItem{ key: none, val: 'validate_argument' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_unslash' }]) }])
	if rt.is_true(var_context) {
	closure_11_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_arg := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('in_array', [var_context, var_arg.array_get(rt.new_string('context')), rt.new_bool(true)])
		}
	var_args = rt.call_function('array_filter', [var_args.clone(), rt.new_closure(closure_11_fn)])
	}
	return var_args.clone()
}

struct Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException {
	rt.PhpObjectBase
}

struct Class_WC_Data_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Connection_Rest_Authentication {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_controllers_pushtokenrestcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController{
		PhpObjectBase: rt.PhpObjectBase{}
		route_namespace: rt.new_string('wc-push-notifications')
		rest_base: rt.new_string('push-tokens')
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapicontrollerbase(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApiControllerBase {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApiControllerBase{
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

fn create_automattic_woocommerce_internal_pushnotifications_exceptions_pushtokennotfoundexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_exception(_args ...rt.PhpVal) &Class_WC_Data_Exception {
	mut obj := &Class_WC_Data_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_validators_pushtokenvalidator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator{
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

fn create_automattic_jetpack_connection_rest_authentication(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Connection_Rest_Authentication {
	mut obj := &Class_Automattic_Jetpack_Connection_Rest_Authentication{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_rest_api_namespace' {
			return rt.new_string(this.get_rest_api_namespace())
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'index' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.index(mut dispatch_arg_0)
		}
		'create' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.create(mut dispatch_arg_0)
		}
		'delete' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.delete(mut dispatch_arg_0)
		}
		'validate_argument' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.validate_argument(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'get_schema' {
			return this.get_schema()
		}
		'authorize_as_authenticated' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.authorize_as_authenticated(mut dispatch_arg_0))
		}
		'authorize_as_from_wpcom' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.authorize_as_from_wpcom(mut dispatch_arg_0))
		}
		'convert_exception_to_wp_error' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Exception](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.convert_exception_to_wp_error(mut dispatch_arg_0)
		}
		'get_args' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_args(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'route_namespace' { return this.route_namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'route_namespace' { this.route_namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApiControllerBase) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Exceptions_PushTokenNotFoundException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Data_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Validators_PushTokenValidator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_Jetpack_Connection_Rest_Authentication) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_Rest_Authentication) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_Rest_Authentication) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
