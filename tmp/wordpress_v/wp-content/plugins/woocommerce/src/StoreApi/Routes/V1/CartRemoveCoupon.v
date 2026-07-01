import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon.identifier() string {
	return 'cart-remove-coupon'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon.get_path_regex() string {
	return '/cart/remove-coupon'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon) get_args() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.creatable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_response' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: '__return_true' },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'code', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the coupon within the cart.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'schema', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
			], &this), 'schema') },
			rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
		]) },
		rt.ArrayItem{ key: 'allow_batch', val: rt.create_array([
			rt.ArrayItem{ key: 'v1', val: true },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon) get_route_post_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_coupons_enabled', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_coupon_disabled'), rt.call_function('esc_html__', [
			rt.new_string('Coupons are disabled.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(404))))
	}
	mut var_cart := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'cart_controller'), 'get_cart_instance', []rt.PhpVal{})
	mut var_coupon_code := rt.call_function('wc_format_coupon_code', [
		var_request.array_get('code'),
	])
	mut var_coupon :=
		create_automattic_woocommerce_storeapi_routes_v1_wc_coupon(var_coupon_code.dup())
	mut var_discounts :=
		create_automattic_woocommerce_storeapi_routes_v1_wc_discounts(var_cart.dup())
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_same_coupon', [var_coupon.get_code(), var_coupon_code.dup()])))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_discounts.is_coupon_valid(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WC_Coupon', []string{}, var_coupon))]))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_coupon_error'), rt.call_function('esc_html__', [
			rt.new_string('Invalid coupon code.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(400))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'cart_controller'), 'has_coupon', [var_coupon_code.dup()])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_cart_coupon_invalid_code'), rt.call_function('esc_html__', [
			rt.new_string('Coupon cannot be removed because it is not already applied to the cart.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(409))))
	}
	var_cart = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon', [
		'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
	], &this), 'cart_controller'), 'get_cart_instance', []rt.PhpVal{})
	rt.call_method(var_cart, 'remove_coupon', [var_coupon_code.dup()])
	return rt.call_function('rest_ensure_response', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon', [
			'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute',
		], &this), 'schema'), 'get_item_response', [
			var_cart.dup(),
		]),
	])
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractCartRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Discounts {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_cartremovecoupon() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon{
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

fn create_automattic_woocommerce_storeapi_routes_v1_wc_coupon() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Coupon {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_wc_discounts() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Discounts {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Discounts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon.get_path_regex())
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

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_CartRemoveCoupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Discounts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Discounts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_WC_Discounts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_cartremovecoupon_php() {
}
