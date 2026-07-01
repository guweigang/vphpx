import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart.identifier() string {
	return 'cart'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart.get_path_regex() string {
	return '/cart'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart) get_args() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.readable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Cart', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_response' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: '__return_true' },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
					rt.ArrayItem{ key: 'default', val: 'view' },
				])) },
			]) },
		]) },
		rt.ArrayItem{ key: 'schema', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Cart', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
			], &this), 'schema') },
			rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
		]) },
		rt.ArrayItem{ key: 'allow_batch', val: rt.create_array([
			rt.ArrayItem{ key: 'v1', val: true },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart) get_route_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	return rt.call_function('rest_ensure_response', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Cart', [
			'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
		], &this), 'schema'), 'get_item_response', [
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Cart', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
			], &this), 'cart_controller'), 'get_cart_for_response', []rt.PhpVal{}),
		]),
	])
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_cart() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstractcartroute() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'get_route_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_route_response(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Cart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_cart_php() {
}
