import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch.identifier() string {
	return 'batch'
}
pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch.schema_type() string {
	return 'batch'
}
struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch.get_path_regex() string {
	return '/batch'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch) get_args() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Batch', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute', 'RouteInterface'], &this) }, rt.ArrayItem{ key: none, val: 'get_response' }]) }, rt.ArrayItem{ key: 'methods', val: 'POST' }, rt.ArrayItem{ key: 'permission_callback', val: '__return_true' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'validation', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'require-all-validate' }, rt.ArrayItem{ key: none, val: 'normal' }]) }, rt.ArrayItem{ key: 'default', val: 'normal' }]) }, rt.ArrayItem{ key: 'requests', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'maxItems', val: 25 }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'method', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.call_function('apply_filters', [rt.new_string('__experimental_woocommerce_store_api_batch_request_methods'), rt.create_array([rt.ArrayItem{ key: none, val: 'POST' }, rt.ArrayItem{ key: none, val: 'PUT' }, rt.ArrayItem{ key: none, val: 'PATCH' }, rt.ArrayItem{ key: none, val: 'DELETE' }])]) }, rt.ArrayItem{ key: 'default', val: 'POST' }]) }, rt.ArrayItem{ key: 'path', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'body', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.new_array() }, rt.ArrayItem{ key: 'additionalProperties', val: true }]) }, rt.ArrayItem{ key: 'headers', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.new_array() }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'string' }, rt.ArrayItem{ key: none, val: 'array' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }]) }]) }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch) get_response(mut var_request Class_WP_REST_Request) rt.PhpVal {
	{
		mut iter_1 := var_request.array_get('requests').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_args := item_1.val
			mut var_parsed_path := rt.call_function('wp_parse_url', [var_args.array_get('path'), rt.get_constant('PHP_URL_PATH')])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_path)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_invalid_path'), rt.call_function('__', [rt.new_string('Invalid path provided.'), rt.new_string('woocommerce')]), rt.new_int(400))))
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_response := rt.call_method(rt.call_function('rest_get_server', []rt.PhpVal{}), 'serve_batch_request_v1', [var_request])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Exceptions_RouteException') {
		mut var_error := var_e_1.dup()
		var_response = this.get_route_error_response(rt.call_method(var_error, 'getErrorCode', []rt.PhpVal{}), rt.call_method(var_error, 'getMessage', []rt.PhpVal{}), rt.call_method(var_error, 'getCode', []rt.PhpVal{}), rt.call_method(var_error, 'getAdditionalData', []rt.PhpVal{}))
		unsafe { goto end_label_1 }
	}
	else if rt.instance_of(var_e_1, 'Automattic_WooCommerce_StoreApi_Routes_V1_Exception') {
		mut var_error := var_e_1.dup()
		var_response = this.get_route_error_response(rt.new_string('woocommerce_rest_unknown_server_error'), rt.call_method(var_error, 'getMessage', []rt.PhpVal{}), rt.new_int(500))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		var_response = this.error_to_response(var_response.dup())
	}
	mut var_nonce := rt.call_function('wp_create_nonce', [rt.new_string('wc_store_api')])
	rt.call_method(var_response, 'header', [rt.new_string('Nonce'), var_nonce.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('Nonce-Timestamp'), rt.call_function('time', []rt.PhpVal{})])
	rt.call_method(var_response, 'header', [rt.new_string('User-ID'), rt.call_function('get_current_user_id', []rt.PhpVal{})])
	return var_response.dup()
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_batch() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstractroute() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_routeexception() &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'get_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_response(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Batch) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_batch_php() {
}
