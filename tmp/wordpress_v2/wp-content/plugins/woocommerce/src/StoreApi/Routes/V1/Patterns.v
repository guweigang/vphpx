import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns.identifier() string {
	return 'patterns'
}

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns.schema_type() string {
	return 'patterns'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns.get_path_regex() string {
	return '/patterns'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns) get_args() rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.call_function('is_user_logged_in', []rt.PhpVal{})
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return rt.call_function('is_user_logged_in', []rt.PhpVal{})
	}
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.readable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Patterns', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_response' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_1_fn) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.creatable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Patterns', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_response' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.new_closure(closure_2_fn) },
		]) },
		rt.ArrayItem{ key: 'schema', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Patterns', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute',
			], &this), 'schema') },
			rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns) get_route_response(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_2 := iife_temp_2.container()
	mut var_ptk_client := rt.call_method(iife_result_2, 'get', [
		Class_Automattic_WooCommerce_Blocks_Patterns_PTKClient.class(),
	])
	mut var_response := rt.call_method(var_ptk_client, 'fetch_patterns', [
		rt.create_array([rt.ArrayItem{ key: 'per_page', val: 1 }]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.call_function('wp_kses', [
			rt.call_method(var_response, 'get_error_message', []rt.PhpVal{}),
			rt.new_array(),
		]), rt.call_function('wp_kses', [
			rt.call_method(var_response, 'get_error_code', []rt.PhpVal{}),
			rt.new_array(),
		]))))
	}
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'success', val: true }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns) get_route_post_response(mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_3 := iife_temp_3.container()
	mut var_ptk_patterns_store := rt.call_method(iife_result_3, 'get', [
		Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore.class(),
	])
	mut var_patterns := rt.call_method(var_ptk_patterns_store, 'fetch_patterns', []rt.PhpVal{})
	mut iife_temp_4 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_4 := iife_temp_4.container()
	mut var_block_patterns := rt.call_method(iife_result_4, 'get', [
		Class_Automattic_WooCommerce_Blocks_BlockPatterns.class(),
	])
	rt.call_method(var_block_patterns, 'register_ptk_patterns', [
		var_patterns.clone()])
	return rt.call_function('rest_ensure_response', [
		rt.create_array([rt.ArrayItem{ key: 'success', val: true }]),
	])
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_patterns(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstractroute(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_exceptions_routeexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'get_route_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_route_response(mut dispatch_arg_0)
		}
		'get_route_post_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_route_post_response(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Patterns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
