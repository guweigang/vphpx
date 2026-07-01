import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug.identifier() string {
	return 'products-by-slug'
}
pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug.schema_type() string {
	return 'product'
}
struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug.get_path_regex() string {
	return '/products/(?P<slug>[\\S]+)'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug) get_args() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Slug of the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute'], &this) }, rt.ArrayItem{ key: none, val: 'get_response' }]) }, rt.ArrayItem{ key: 'permission_callback', val: '__return_true' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }, rt.ArrayItem{ key: 'allow_batch', val: rt.create_array([rt.ArrayItem{ key: 'v1', val: true }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute'], &this), 'schema') }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug) get_route_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_slug := rt.call_function('sanitize_title', [var_request.array_get('slug')])
	mut var_object := this.get_product_by_slug(var_slug.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) {
		var_object = this.get_product_variation_by_slug(var_slug.dup())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_object, 'get_id', []rt.PhpVal{}))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException', []string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_product_invalid_slug'), rt.call_function('__', [rt.new_string('Invalid product slug.'), rt.new_string('woocommerce')]), rt.new_int(404))))
	}
	return this.prepare_item_for_response(var_object.dup(), rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug) get_product_by_slug(var_slug rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
	return rt.call_function('wc_get_product', [rt.call_function('get_page_by_path', [var_slug_mutated.dup(), rt.get_constant('OBJECT'), rt.new_string('product')])])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug) get_product_variation_by_slug(var_slug rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_slug_mutated := var_slug
	// unsupported statement: Stmt_Global
	mut var_result := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID, post_name, post_parent, post_type\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\t\tWHERE post_name = %s\n\t\t\t\tAND post_type = \'product_variation\'')), var_slug_mutated.dup()])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_null()
	}
	return rt.call_function('wc_get_product', [rt.get_property(var_result.array_get(0), 'ID')])
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_productsbyslug() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug{
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'get_route_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_route_response(mut dispatch_arg_0)
		}
		'get_product_by_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_by_slug(dispatch_arg_0)
		}
		'get_product_variation_by_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_variation_by_slug(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductsBySlug) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_productsbyslug_php() {
}
