import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem.identifier() string {
	return 'cart-update-item'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem.get_path_regex() string {
	return '/cart/update-item'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem) get_args() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.creatable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_response' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: '__return_true' },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'key', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier (key) for the cart item to update.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'quantity', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('New quantity of the item in the cart.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
						rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_stock_amount' },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'schema', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
			], &this), 'schema') },
			rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
		]) },
		rt.ArrayItem{ key: 'allow_batch', val: rt.create_array([
			rt.ArrayItem{ key: 'v1', val: true },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem) get_route_post_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_cart := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'cart_controller'), 'get_cart_instance', []rt.PhpVal{})
	if var_request.array_isset(rt.new_string('quantity')) {
		mut var_cart_item := rt.call_method(var_cart, 'get_cart_item', [
			var_request.array_get(rt.new_string('key')),
		])
		mut var_old_quantity := if !(var_cart_item.array_get(rt.new_string('quantity'))).is_null() {
			var_cart_item.array_get(rt.new_string('quantity'))
		} else {
			rt.new_int(0)
		}
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem', [
			'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
		], &this), 'cart_controller'), 'set_cart_item_quantity', [
			var_request.array_get(rt.new_string('key')),
			var_request.array_get(rt.new_string('quantity')),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_old_quantity,
			rt.new_int((var_request.array_get(rt.new_string('quantity'))).to_i64())))))
		{
			rt.call_function('do_action', [
				rt.new_string('internal_woocommerce_cart_item_updated_from_user_request'),
				var_request.array_get(rt.new_string('key')),
				rt.new_int((var_request.array_get(rt.new_string('quantity'))).to_i64()),
				var_old_quantity.clone(),
				var_cart.clone(),
			])
		}
	}
	return rt.call_function('rest_ensure_response', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem', [
			'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
		], &this), 'schema'), 'get_item_response', [
			var_cart.clone(),
		]),
	])
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_cartupdateitem(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstractcartroute(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'get_route_post_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 {
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

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartUpdateItem) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
