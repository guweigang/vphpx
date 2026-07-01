import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem.identifier() string {
	return 'cart-add-item'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem.get_path_regex() string {
	return '/cart/add-item'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem) get_args() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.creatable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_response' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: '__return_true' },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The cart item product or variation ID.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
				]) },
				rt.ArrayItem{ key: 'quantity', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Quantity of this item to add to the cart.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
						rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_stock_amount' },
					]) },
				]) },
				rt.ArrayItem{ key: 'variation', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Chosen attributes (for variations).'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'attribute', val: rt.create_array([
								rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
									rt.new_string('Variation attribute name.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
							]) },
							rt.ArrayItem{ key: 'value', val: rt.create_array([
								rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
									rt.new_string('Variation attribute value.'),
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
			]) },
		]) },
		rt.ArrayItem{ key: 'schema', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
			], &this), 'schema') },
			rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
		]) },
		rt.ArrayItem{ key: 'allow_batch', val: rt.create_array([
			rt.ArrayItem{ key: 'v1', val: true },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem) get_route_post_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get('key'))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_item_exists'), rt.call_function('esc_html__', [
			rt.new_string('Cannot create an existing cart item.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
	}
	mut var_add_to_cart_data := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_store_api_add_to_cart_data'),
		rt.create_array([rt.ArrayItem{ key: 'id', val: var_request.array_get('id') },
			rt.ArrayItem{ key: 'quantity', val: var_request.array_get('quantity') },
			rt.ArrayItem{ key: 'variation', val: var_request.array_get('variation') },
			rt.ArrayItem{ key: 'cart_item_data', val: rt.new_array() }]),
		var_request,
	])
	mut var_item_id := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'cart_controller'), 'add_to_cart', [var_add_to_cart_data.dup()])
	mut var_cart := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'cart_controller'), 'get_cart_instance', []rt.PhpVal{})
	mut var_cart_item := rt.call_method(var_cart, 'get_cart_item', [
		var_item_id.dup()])
	if !(!rt.is_true(var_cart_item)) {
		mut var_product_id := if rt.is_true(var_cart_item.array_get('variation_id')) {
			var_cart_item.array_get('variation_id')
		} else {
			var_cart_item.array_get('product_id')
		}
		mut var_quantity := if !(var_add_to_cart_data.array_get('quantity')).is_null() {
			var_add_to_cart_data.array_get('quantity')
		} else {
			var_cart_item.array_get('quantity')
		}
		rt.call_function('do_action', [
			rt.new_string('internal_woocommerce_cart_item_added_from_user_request'),
			var_product_id.dup(),
			var_quantity.dup(),
		])
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem', [
			'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
		], &this), 'schema'), 'get_item_response', [
			rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
			], &this), 'cart_controller'), 'get_cart_for_response', []rt.PhpVal{}),
		]),
	])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	return var_response.dup()
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_cartadditem() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem{
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

fn create_automattic_woocommerce_storeapi_exceptions_routeexception() &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem.get_path_regex())
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

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartAddItem) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_cartadditem_php() {
}
