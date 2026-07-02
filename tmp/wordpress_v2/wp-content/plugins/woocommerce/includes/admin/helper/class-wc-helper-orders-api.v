import rt

struct Class_WC_Helper_Orders_API {
	rt.PhpObjectBase
}

fn Class_WC_Helper_Orders_API.load() {
	rt.call_function('add_filter', [rt.new_string('rest_api_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'register_rest_routes' }])])
}

fn Class_WC_Helper_Orders_API.register_rest_routes() {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_argument := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	rt.call_function('register_rest_route', [rt.new_string('wc/v3'),
		rt.new_string('/marketplace/create-order'),
		rt.create_array([
			rt.ArrayItem{ key: 'methods', val: 'POST' },
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'create_order' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'get_permission' },
			]) },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'product_id', val: rt.create_array([
					rt.ArrayItem{ key: 'required', val: true },
					rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_1_fn) },
				]) },
			]) },
		])])
}

fn Class_WC_Helper_Orders_API.get_permission() rt.PhpVal {
	mut iife_temp_1 := Class_WC_Helper_Subscriptions_API{}
	mut iife_result_1 := iife_temp_1.get_permission()
	return iife_result_1
}

fn Class_WC_Helper_Orders_API.create_order(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_plugins'),
	])))))
	{
		return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.create_array([
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('You do not have permission to install plugins.'),
				rt.new_string('woocommerce'),
			]) },
		]), rt.new_int(403)))
	}
	mut iife_temp_2 := Class_WC_Helper_API{}
	mut iife_result_2 := iife_temp_2.post(rt.new_string('create-order'), rt.create_array([
		rt.ArrayItem{ key: 'authenticated', val: true },
		rt.ArrayItem{ key: 'body', val: rt.call_function('http_build_query', [
			rt.create_array([
				rt.ArrayItem{
					key: 'product_id'
					val: var_request.array_get(rt.new_string('product_id'))
				},
			]),
		]) },
	]))
	mut var_response := iife_result_2
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.call_function('json_decode', [
		rt.call_function('wp_remote_retrieve_body', [var_response.clone()]),
		rt.new_bool(true),
	]), rt.call_function('wp_remote_retrieve_response_code', [
		var_response.clone()])))
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		return rt.new_object('WP_REST_Response', []string{}, create_wp_rest_response(rt.create_array([
			rt.ArrayItem{ key: 'message', val:
				(rt.call_function('__', [rt.new_string('Could not start the installation process. Reason: '), rt.new_string('woocommerce')])).str() +
				(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str() },
			rt.ArrayItem{ key: 'code', val: 'could-not-install' },
		]), rt.new_int(500)))
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

struct Class_WC_Helper_Subscriptions_API {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_WC_Helper_API {
	rt.PhpObjectBase
}

fn create_wc_helper_orders_api(_args ...rt.PhpVal) &Class_WC_Helper_Orders_API {
	mut obj := &Class_WC_Helper_Orders_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_subscriptions_api(_args ...rt.PhpVal) &Class_WC_Helper_Subscriptions_API {
	mut obj := &Class_WC_Helper_Subscriptions_API{
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

fn create_wc_helper_api(_args ...rt.PhpVal) &Class_WC_Helper_API {
	mut obj := &Class_WC_Helper_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Helper_Orders_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'load' {
			Class_WC_Helper_Orders_API.load()
			return rt.new_null()
		}
		'register_rest_routes' {
			Class_WC_Helper_Orders_API.register_rest_routes()
			return rt.new_null()
		}
		'get_permission' {
			return Class_WC_Helper_Orders_API.get_permission()
		}
		'create_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper_Orders_API.create_order(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Helper_Orders_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Orders_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Helper_Subscriptions_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Subscriptions_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Subscriptions_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Helper_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
	Class_WC_Helper_Orders_API.load()
}
