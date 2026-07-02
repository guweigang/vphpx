import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes.identifier() string {
	return 'product-attributes'
}

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes.schema_type() string {
	return 'product-attribute'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes.get_path_regex() string {
	return '/products/attributes'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes) get_args() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.readable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute',
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
			rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute',
			], &this), 'schema') },
			rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes) get_route_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_ids := rt.call_function('wc_get_attribute_taxonomy_ids', []rt.PhpVal{})
	mut var_return := rt.new_array()
	mut iter_1 := var_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_id := item_1.val
		mut var_object := rt.call_function('wc_get_attribute', [
			var_id.clone()])
		mut var_data := this.prepare_item_for_response(var_object.clone(), rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request',
			[]string{}, var_request))
		var_return.array_push(this.prepare_response_for_collection(var_data.clone()))
	}
	return rt.call_function('rest_ensure_response', [var_return.clone()])
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_productattributes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes{
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes.get_path_regex())
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

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductAttributes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
