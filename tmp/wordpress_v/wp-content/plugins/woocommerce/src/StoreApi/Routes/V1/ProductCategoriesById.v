import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById.identifier() string {
	return 'product-categories-by-id'
}
pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById.schema_type() string {
	return 'product-category'
}
struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById.get_path_regex() string {
	return '/products/categories/(?P<id>[\\d]+)'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById) get_args() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute'], &this) }, rt.ArrayItem{ key: none, val: 'get_response' }]) }, rt.ArrayItem{ key: 'permission_callback', val: '__return_true' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }, rt.ArrayItem{ key: 'allow_batch', val: rt.create_array([rt.ArrayItem{ key: 'v1', val: true }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute'], &this), 'schema') }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById) get_route_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_object := rt.call_function('get_term', [// unsupported expression: Expr_Cast_Int, rt.new_string('product_cat')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_object, 'id'))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_category_invalid_id'), rt.call_function('__', [rt.new_string('Invalid category ID.'), rt.new_string('woocommerce')]), rt.new_int(404))))
	}
	mut var_data := this.prepare_item_for_response(var_object.dup(), rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request))
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_productcategoriesbyid() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById{
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'get_route_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_route_response(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategoriesById) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_productcategoriesbyid_php() {
}
