import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode.identifier() string {
	return 'cart-coupons-by-code'
}

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode.schema_type() string {
	return 'cart-coupon'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode.get_path_regex() string {
	return '/cart/coupons/(?P<code>[\\w-]+)'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode) get_args() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'args', val: rt.create_array([
			rt.ArrayItem{ key: 'code', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Unique identifier for the coupon within the cart.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.readable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode', [
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
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.deletable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_response' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: '__return_true' },
		]) },
		rt.ArrayItem{ key: 'schema', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
			], &this), 'schema') },
			rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
		]) },
		rt.ArrayItem{ key: 'allow_batch', val: rt.create_array([
			rt.ArrayItem{ key: 'v1', val: true },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode) get_route_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'cart_controller'), 'has_coupon', [var_request.array_get('code')])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_coupon_invalid_code'), rt.call_function('esc_html__', [
			rt.new_string('Coupon does not exist in the cart.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(404))))
	}
	return this.prepare_item_for_response(var_request.array_get('code'), rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request',
		[]string{}, var_request))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode) get_route_delete_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'cart_controller'), 'has_coupon', [var_request.array_get('code')])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_coupon_invalid_code'), rt.call_function('esc_html__', [
			rt.new_string('Coupon does not exist in the cart.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(404))))
	}
	mut var_cart := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'cart_controller'), 'get_cart_instance', []rt.PhpVal{})
	rt.call_method(var_cart, 'remove_coupon', [var_request.array_get('code')])
	return create_automattic_woocommerce_storeapi_routes_v1_wp_rest_response(rt.new_null(),
		rt.new_int(204))
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_cartcouponsbycode() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode{
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

fn create_automattic_woocommerce_storeapi_routes_v1_wp_rest_response() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode.get_path_regex())
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
		'get_route_delete_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_route_delete_response(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartCouponsByCode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_cartcouponsbycode_php() {
}
