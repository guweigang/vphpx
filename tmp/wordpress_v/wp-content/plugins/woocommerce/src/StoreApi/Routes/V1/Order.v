import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order.identifier() string {
	return 'order'
}

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order.schema_type() string {
	return 'order'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order {
	rt.PhpObjectBase
pub mut:
	order_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order) construct(mut var_schema_controller Class_Automattic_WooCommerce_StoreApi_SchemaController, mut var_schema Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) {
	this.Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute.construct(rt.new_object('Automattic_WooCommerce_StoreApi_SchemaController',
		[]string{}, var_schema_controller), rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema',
		[]string{}, var_schema))
	this.order_controller = create_automattic_woocommerce_storeapi_utilities_ordercontroller()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order.get_path_regex() string {
	return '/order/(?P<id>[\\d]+)'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order) get_args() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.readable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Order', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_response' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Order', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute',
				], &this) },
				rt.ArrayItem{ key: none, val: 'is_authorized' },
			]) },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
					rt.ArrayItem{ key: 'default', val: 'view' },
				])) },
			]) },
		]) },
		rt.ArrayItem{ key: 'schema', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Order', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute',
			], &this), 'schema') },
			rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order) get_route_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_order_id := rt.call_function('absint', [var_request.array_get('id')])
	return rt.call_function('rest_ensure_response', [
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Order', [
			'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute',
		], &this), 'schema'), 'get_item_response', [
			rt.call_function('wc_get_order', [var_order_id.dup()]),
		]),
	])
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_order(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order{
		PhpObjectBase:    rt.PhpObjectBase{}
		order_controller: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstractroute() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_ordercontroller() &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_SchemaController](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order.get_path_regex())
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

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'order_controller' { return this.order_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'order_controller' {
			this.order_controller = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_OrderController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_order_php() {
}
