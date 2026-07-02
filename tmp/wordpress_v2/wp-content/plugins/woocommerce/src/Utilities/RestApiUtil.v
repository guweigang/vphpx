import rt

struct Class_Automattic_WooCommerce_Utilities_RestApiUtil {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Utilities_RestApiUtil) get_endpoint_data(var_endpoint rt.PhpVal, var_params rt.PhpVal) rt.PhpVal {
	mut var_request := create_automattic_woocommerce_utilities_wp_rest_request(rt.new_string('GET'), var_endpoint.clone())
	if rt.is_true(var_params) {
		var_request.set_query_params(var_params.clone())
	}
	mut var_response := rt.call_function('rest_do_request', [var_request])
	mut var_server := rt.call_function('rest_get_server', []rt.PhpVal{})
	mut var_json := rt.call_function('wp_json_encode', [rt.call_method(var_server, 'response_to_data', [var_response.clone(), rt.new_bool(false)])])
	return rt.call_function('json_decode', [var_json.clone(), rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Utilities_RestApiUtil) lazy_load_namespace(route_namespace string, mut var_callback Class_Automattic_WooCommerce_Utilities_callable) {
	mut route_namespace_mutated := route_namespace
	mut var_should_lazy_load_namespace := rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_should_lazy_load_namespace'), rt.new_bool(true), rt.new_string(route_namespace_mutated).clone()])
	if rt.is_true(var_should_lazy_load_namespace) {
		this.attach_lazy_loaded_namespace(route_namespace_mutated, mut var_callback, '', '')
	} else {
		rt.call_function('call_user_func', [var_callback])
	}
}

fn (mut this Class_Automattic_WooCommerce_Utilities_RestApiUtil) attach_lazy_loaded_namespace(route_namespace string, mut var_callback Class_Automattic_WooCommerce_Utilities_callable, rest_route string, callback_filter_id string) {
	mut var_GLOBALS := rt.new_null()
	mut route_namespace_mutated := route_namespace
	mut rest_route_mutated := rest_route
	mut callback_filter_id_mutated := callback_filter_id
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(rest_route_mutated))) && var_GLOBALS.array_isset(rt.new_string('wp')) && var_GLOBALS.array_get(rt.new_string('wp')).is_object() {
	rest_route_mutated = (if !(rt.get_property(var_GLOBALS.array_get(rt.new_string('wp')), 'query_vars').array_get(rt.new_string('rest_route'))).is_null() { rt.get_property(var_GLOBALS.array_get(rt.new_string('wp')), 'query_vars').array_get(rt.new_string('rest_route')) } else { rt.new_string('') }).str()
	}
	if rt.is_true(rt.new_bool('' != rest_route_mutated)) {
		rest_route_mutated = (rt.call_function('trailingslashit', [rt.new_string(rest_route_mutated.trim_left(' \t\n\r'))])).str()
		route_namespace_mutated = (rt.call_function('trailingslashit', [rt.new_string(route_namespace_mutated).clone()])).str()
		if rt.is_true(rt.identical(rt.new_string('/'), rt.new_string(rest_route_mutated))) || rt.is_true(rt.call_function('str_starts_with', [rt.new_string(rest_route_mutated).clone(), rt.new_string(route_namespace_mutated).clone()])) {
			if rt.is_true(rt.new_bool('' != callback_filter_id_mutated)) {
				rt.call_function('remove_filter', [rt.new_string('rest_pre_dispatch'), rt.new_string(callback_filter_id_mutated).clone(), rt.new_int(0)])
			}
			rt.call_function('call_user_func', [var_callback])
			return
		}
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(callback_filter_id_mutated))) {
		closure_1_fn := fn [var_route_namespace, var_callback, mut var_callback_filter_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_filter_result := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_server := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			mut var_request := if args.len > 2 { args[2].clone() } else { rt.new_null() }
			if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_request }, rt.ArrayItem{ key: none, val: 'get_route' }])])) {
				this.attach_lazy_loaded_namespace(route_namespace_mutated, mut rt.new_object('Automattic_WooCommerce_Utilities_callable', []string{}, var_callback), (var_request.get_route()).str(), callback_filter_id_mutated)
			}
			return
			}
		mut var_callback_filter := rt.new_closure(closure_1_fn)
		callback_filter_id_mutated = (rt.call_function('_wp_filter_build_unique_id', [rt.new_string('rest_pre_dispatch'), var_callback_filter.clone(), rt.new_int(0)])).str()
		rt.call_function('add_filter', [rt.new_string('rest_pre_dispatch'), var_callback_filter.clone(), rt.new_int(0), rt.new_int(3)])
	}
}

struct Class_Automattic_WooCommerce_Utilities_WP_REST_Request {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_restapiutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_RestApiUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_RestApiUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_wp_rest_request(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_WP_REST_Request {
	mut obj := &Class_Automattic_WooCommerce_Utilities_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_RestApiUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_endpoint_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_endpoint_data(dispatch_arg_0, dispatch_arg_1)
		}
		'lazy_load_namespace' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_callable](if args.len > 1 { args[1] } else { rt.new_null() })
			this.lazy_load_namespace(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'attach_lazy_loaded_namespace' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_callable](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.attach_lazy_loaded_namespace(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_RestApiUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_RestApiUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
