import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms.identifier() string {
	return 'product-attribute-terms'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms.get_path_regex() string {
	return '/products/attributes/(?P<attribute_id>[\\d]+)/terms'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms) get_args() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'args', val: rt.create_array([
			rt.ArrayItem{ key: 'attribute_id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Unique identifier for the attribute.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.readable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_response' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: '__return_true' },
			rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			rt.ArrayItem{ key: 'allow_batch', val: rt.create_array([
				rt.ArrayItem{ key: 'v1', val: true },
			]) },
		]) },
		rt.ArrayItem{ key: 'schema', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute',
			], &this), 'schema') },
			rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms) get_collection_params() rt.PhpVal {
	mut var_params :=
		this.Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute.get_collection_params()
	var_params.array_get_mut('orderby').array_get_mut('enum').array_push('menu_order')
	var_params.array_get_mut('orderby').array_get_mut('enum').array_push('name_num')
	var_params.array_get_mut('orderby').array_get_mut('enum').array_push('id')
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms) get_route_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_attribute := rt.call_function('wc_get_attribute', [
		var_request.array_get(rt.new_string('attribute_id')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [rt.get_property(var_attribute, 'slug')]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_StoreApi_Exceptions_RouteException',
			[]string{}, create_automattic_woocommerce_storeapi_exceptions_routeexception(rt.new_string('woocommerce_rest_taxonomy_invalid'), rt.call_function('__', [
			rt.new_string('Attribute does not exist.'),
			rt.new_string('woocommerce'),
		]), rt.new_int(404))))
	}
	return this.get_terms_response(rt.get_property(var_attribute, 'slug'), rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request',
		[]string{}, var_request))
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Exceptions_RouteException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_productattributeterms(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstracttermsroute(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute{
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'get_collection_params' {
			return this.get_collection_params()
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

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributeTerms) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
